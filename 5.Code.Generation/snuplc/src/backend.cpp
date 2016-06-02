//------------------------------------------------------------------------------
/// @brief SnuPL backend
/// @author Bernhard Egger <bernhard@csap.snu.ac.kr>
/// @section changelog Change Log
/// 2012/11/28 Bernhard Egger created
/// 2013/06/09 Bernhard Egger adapted to SnuPL/0
/// 2016/04/04 Bernhard Egger adapted to SnuPL/1
///
/// @section license_section License
/// Copyright (c) 2012-2016 Bernhard Egger
/// All rights reserved.
///
/// Redistribution and use in source and binary forms,  with or without modifi-
/// cation, are permitted provided that the following conditions are met:
///
/// - Redistributions of source code must retain the above copyright notice,
///   this list of conditions and the following disclaimer.
/// - Redistributions in binary form must reproduce the above copyright notice,
///   this list of conditions and the following disclaimer in the documentation
///   and/or other materials provided with the distribution.
///
/// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
/// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,  BUT NOT LIMITED TO,  THE
/// IMPLIED WARRANTIES OF MERCHANTABILITY  AND FITNESS FOR A PARTICULAR PURPOSE
/// ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDER  OR CONTRIBUTORS BE
/// LIABLE FOR ANY DIRECT,  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSE-
/// QUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF  SUBSTITUTE
/// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
/// HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT
/// LIABILITY, OR TORT  (INCLUDING NEGLIGENCE OR OTHERWISE)  ARISING IN ANY WAY
/// OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
/// DAMAGE.
//------------------------------------------------------------------------------

#include <fstream>
#include <sstream>
#include <iomanip>
#include <cassert>
#include <algorithm>

#include "backend.h"
using namespace std;

//#define DEBUG
#ifdef DEBUG
#define Dprintf(a) printf a
#else
#define Dprintf(a) ;
#endif

//------------------------------------------------------------------------------
// CBackend
//
CBackend::CBackend(ostream &out)
  : _out(out)
{
}

CBackend::~CBackend(void)
{
}

bool CBackend::Emit(CModule *m)
{
  assert(m != NULL);
  _m = m;

  if (!_out.good()) return false;

  bool res = true;

  try {
    EmitHeader();
    EmitCode();
    EmitData();
    EmitFooter();

    res = _out.good();
  } catch (...) {
    res = false;
  }

  return res;
}

void CBackend::EmitHeader(void)
{
}

void CBackend::EmitCode(void)
{
}

void CBackend::EmitData(void)
{
}

void CBackend::EmitFooter(void)
{
}


//------------------------------------------------------------------------------
// CBackendx86
//
CBackendx86::CBackendx86(ostream &out)
  : CBackend(out), _curr_scope(NULL)
{
  _ind = string(4, ' ');
}

CBackendx86::~CBackendx86(void)
{
}

void CBackendx86::EmitHeader(void)
{
  _out << "##################################################" << endl
       << "# " << _m->GetName() << endl
       << "#" << endl
       << endl;
}

void CBackendx86::EmitCode(void)
{
  _out << _ind << "#-----------------------------------------" << endl
       << _ind << "# text section" << endl
       << _ind << "#" << endl
       << _ind << ".text" << endl
       << _ind << ".align 4" << endl
       << endl
       << _ind << "# entry point and pre-defined functions" << endl
       << _ind << ".global main" << endl
       << _ind << ".extern DIM" << endl
       << _ind << ".extern DOFS" << endl
       << _ind << ".extern ReadInt" << endl
       << _ind << ".extern WriteInt" << endl
       << _ind << ".extern WriteStr" << endl
       << _ind << ".extern WriteChar" << endl
       << _ind << ".extern WriteLn" << endl
       << endl;


  // TODO
  // forall s in subscopes do
  //   EmitScope(s)
  // EmitScope(program)

  const vector<CScope *> &children = _m->GetSubscopes();
  for (int i=0; i<children.size(); ++i) {
	  SetScope(children[i]);
	  EmitScope(children[i]);
  }

  CScope *cur_scope = dynamic_cast<CScope *>(_m);
  SetScope(cur_scope);
  EmitScope(GetScope());
  

  _out << _ind << "# end of text section" << endl
       << _ind << "#-----------------------------------------" << endl
       << endl;
}

void CBackendx86::EmitData(void)
{
  _out << _ind << "#-----------------------------------------" << endl
       << _ind << "# global data section" << endl
       << _ind << "#" << endl
       << _ind << ".data" << endl
       << _ind << ".align 4" << endl
       << endl;

  EmitGlobalData(_m);

  _out << _ind << "# end of global data section" << endl
       << _ind << "#-----------------------------------------" << endl
       << endl;
}

void CBackendx86::EmitFooter(void)
{
  _out << _ind << ".end" << endl
       << "##################################################" << endl;
}

void CBackendx86::SetScope(CScope *scope)
{
  _curr_scope = scope;
}

CScope* CBackendx86::GetScope(void) const
{
  return _curr_scope;
}

void CBackendx86::EmitScope(CScope *scope)
{
  assert(scope != NULL);

  string label;

  if (scope->GetParent() == NULL) label = "main";
  else label = scope->GetName();

  // label
  _out << _ind << "# scope " << scope->GetName() << endl
       << label << ":" << endl;

  // TODO
  // ComputeStackOffsets(scope)
  size_t stack_size = ComputeStackOffsets(scope->GetSymbolTable(), 8, 12);

  //
  // emit function prologue

  _out << _ind << "# prologue" << endl;
  EmitInstruction("pushl", "\%ebp");
  EmitInstruction("movl", "\%esp, \%ebp");
  EmitInstruction("pushl", "\%ebx", "save callee saved registers");
  EmitInstruction("pushl", "\%esi");
  EmitInstruction("pushl", "\%edi");
  EmitInstruction("subl", Imm(stack_size) + ", \%esp", "make room for locals");
  _out << endl;

  // initializelocaldata(scope)
  //
  if (stack_size == 0) {
  	// do nothing
  }
  else if (stack_size/4 <= 4) {
	  EmitInstruction("xorl", "\%eax, \%eax", "memset local stack area to 0");
	  for (int i=stack_size/4 - 1; i>=0; --i)
		  EmitInstruction("movl", "\%eax, " + to_string(i*4) + "(\%esp)");
	  _out << endl;
  }
  else {
	  EmitInstruction("cld", "", "memset local stack area to 0");
	  EmitInstruction("xorl", "\%eax, \%eax");
	  EmitInstruction("movl", Imm(stack_size/4) + ", \%ecx");
	  EmitInstruction("mov", "\%esp, \%edi");
	  EmitInstruction("rep", "stosl");
	  _out << endl;
  }
	  
	  

  // forall i in instructions do
  //   EmitInstruction(i)

  _out << _ind << "# function body" << endl;
  EmitCodeBlock(scope->GetCodeBlock());
  _out << endl;

  //
  // emit function epilogue
  _out << Label(new CTacLabel("exit")) << ":" << endl;
  _out << _ind << "# epilogue" << endl;
  EmitInstruction("addl", Imm(stack_size) + ", \%esp", "remove locals");
  EmitInstruction("popl", "\%edi");
  EmitInstruction("popl", "\%esi");
  EmitInstruction("popl", "\%ebx");
  EmitInstruction("popl", "\%ebp");
  EmitInstruction("ret");

  _out << endl;
}

void CBackendx86::EmitGlobalData(CScope *scope)
{
  assert(scope != NULL);

  // emit the globals for the current scope
  CSymtab *st = scope->GetSymbolTable();
  assert(st != NULL);

  bool header = false;

  vector<CSymbol*> slist = st->GetSymbols();

  _out << dec;

  size_t size = 0;

  for (size_t i=0; i<slist.size(); i++) {
    CSymbol *s = slist[i];
    const CType *t = s->GetDataType();

    if (s->GetSymbolType() == stGlobal) {
      if (!header) {
        _out << _ind << "# scope: " << scope->GetName() << endl;
        header = true;
      }

      // insert alignment only when necessary
      if ((t->GetAlign() > 1) && (size % t->GetAlign() != 0)) {
        size += t->GetAlign() - size % t->GetAlign();
        _out << setw(4) << " " << ".align "
             << right << setw(3) << t->GetAlign() << endl;
      }

      _out << left << setw(36) << s->GetName() + ":" << "# " << t << endl;

      if (t->IsArray()) {
        const CArrayType *a = dynamic_cast<const CArrayType*>(t);
        assert(a != NULL);
        int dim = a->GetNDim();

        _out << setw(4) << " "
          << ".long " << right << setw(4) << dim << endl;

        for (int d=0; d<dim; d++) {
          assert(a != NULL);

          _out << setw(4) << " "
            << ".long " << right << setw(4) << a->GetNElem() << endl;

          a = dynamic_cast<const CArrayType*>(a->GetInnerType());
        }
      }

      const CDataInitializer *di = s->GetData();
      if (di != NULL) {
        const CDataInitString *sdi = dynamic_cast<const CDataInitString*>(di);
        assert(sdi != NULL);  // only support string data initializers for now

        _out << left << setw(4) << " "
          << ".asciz " << '"' << sdi->GetData() << '"' << endl;
      } else {
        _out  << left << setw(4) << " "
          << ".skip " << dec << right << setw(4) << t->GetDataSize()
          << endl;
      }

      size += t->GetSize();
    }
  }

  _out << endl;

  // emit globals in subscopes (necessary if we support static local variables)
  vector<CScope*>::const_iterator sit = scope->GetSubscopes().begin();
  while (sit != scope->GetSubscopes().end()) EmitGlobalData(*sit++);
}

void CBackendx86::EmitLocalData(CScope *scope)
{
  assert(scope != NULL);

  // TODO TODO!
}

void CBackendx86::EmitCodeBlock(CCodeBlock *cb)
{
  assert(cb != NULL);

  const list<CTacInstr*> &instr = cb->GetInstr();
  list<CTacInstr*>::const_iterator it = instr.begin();

  while (it != instr.end()) EmitInstruction(*it++);
}

void CBackendx86::EmitInstruction(CTacInstr *i)
{
  assert(i != NULL);

  ostringstream cmt;
  string mnm;
  cmt << i;

  EOperation op = i->GetOperation();
/*




  */

  switch (op) {
    // binary operators
    // dst = src1 op src2
	  case opAdd :
		  Load(i->GetSrc(1), "\%eax", cmt.str());
		  Load(i->GetSrc(2), "\%ebx");
		  EmitInstruction("addl", "\%ebx, \%eax");
		  Store(i->GetDest(), 'a');
		  break;

	  case opSub :
		  Load(i->GetSrc(1), "\%eax", cmt.str());
		  Load(i->GetSrc(2), "\%ebx");
		  EmitInstruction("subl", "\%ebx, \%eax");
		  Store(i->GetDest(), 'a');
		  break;

	  case opMul :
		  Load(i->GetSrc(1), "\%eax", cmt.str());
		  Load(i->GetSrc(2), "\%ebx");
		  EmitInstruction("imull", "\%ebx");
		  Store(i->GetDest(), 'a');
		  break;

	  case opDiv :
		  Load(i->GetSrc(1), "\%eax", cmt.str());
		  Load(i->GetSrc(2), "\%ebx");
		  EmitInstruction("cdq");
		  EmitInstruction("idivl", "\%ebx");
		  Store(i->GetDest(), 'a');
		  break;

	  case opAnd:
	  case opOr:
		  // Do nothing
		  EmitInstruction("# ???", "not implemented", cmt.str());
		  break;


    // TODO
    // unary operators
    // dst = op src1
	  case opNeg:
	  	Load(i->GetSrc(1), "\%eax", cmt.str());
		EmitInstruction("negl", "\%eax");
		Store(i->GetDest(), 'a');
		break;

	  case opPos:
		// We have this but do we need this?
	  case opNot:
		// Do nothing
		EmitInstruction("# ???", "not implemented", cmt.str());
		break;


    // memory operations
    // dst = src1
    // TODO
	  case opAssign:
		Load(i->GetSrc(1), "\%eax", cmt.str());
		Store(i->GetDest(), 'a');
		break;



    // unconditional branching
    // goto dst
    // TODO

	case opGoto:
	  EmitInstruction("jmp", Label(dynamic_cast<CTacLabel *>(i->GetDest())->GetLabel()), cmt.str());
	  break;

    // conditional branching
    // if src1 relOp src2 then goto dst
    // TODO
	case opEqual:
	case opNotEqual:
	case opLessThan:
	case opLessEqual:
	case opBiggerThan:
  	case opBiggerEqual:
	  Load(i->GetSrc(1), "\%eax", cmt.str());
	  Load(i->GetSrc(2), "\%ebx");
	  EmitInstruction("cmpl", "\%ebx, \%eax");
	  EmitInstruction("j"+Condition(op), Label(dynamic_cast<CTacLabel *>(i->GetDest())->GetLabel()));
	  break;

    // function call-related operations
  	// opCall,                           ///< call:  dst = call src1
  	// opReturn,                         ///< return: return optional src1
  	// opParam,                          ///< parameter: dst = index,src1 = parameter
    // TODO
	case opCall: {
	  CTacName *name = dynamic_cast<CTacName *>(i->GetSrc(1));
	  const CSymbol *sym = name->GetSymbol();
	  const CSymProc *proc = dynamic_cast<const CSymProc *>(sym);

	  EmitInstruction("call", sym->GetName(), cmt.str());
	  if (proc->GetNParams() > 0) {
		  EmitInstruction("addl", Imm(proc->GetNParams()*4) + ", \%esp");
	  }
	  if (i->GetDest()) {
		  Store(i->GetDest(), 'a');
	  }
	  break;
				 }
	case opReturn:
	  if (i->GetSrc(1)) {
		  Load(i->GetSrc(1), "\%eax", cmt.str());
	  }
	  EmitInstruction("jmp", Label("exit"));
	  break;

	case opParam: 
	  Load(i->GetSrc(1), "\%eax", cmt.str());
	  EmitInstruction("pushl", "\%eax");
	  break;
	
	  	  
	 
  // special and pointer operations
  // opAddress,                        ///< reference: dst = &src1
  // opDeref,                          ///< dereference: dst = *src1
  // opCast,                           ///< type cast: dst = (type)src1
	case opAddress:
	  EmitInstruction("leal", Operand(i->GetSrc(1))+ ", \%eax", cmt.str());
	  Store(i->GetDest(), 'a');
	  break;

	case opDeref:
	  EmitInstruction("abc");
	  break;

	case opCast:
      EmitInstruction("# ???", "not implemented", cmt.str());
	  break;

    case opLabel:
      _out << Label(dynamic_cast<CTacLabel*>(i)) << ":" << endl;
      break;

    case opNop:
      EmitInstruction("nop", "", cmt.str());
      break;


    default:
      EmitInstruction("# ???", "not implemented", cmt.str());
  }
}

void CBackendx86::EmitInstruction(string mnemonic, string args, string comment)
{
  _out << left
       << _ind
       << setw(7) << mnemonic << " "
       << setw(23) << args;
  if (comment != "") _out << " # " << comment;
  _out << endl;
}

void CBackendx86::Load(CTacAddr *src, string dst, string comment)
{
  assert(src != NULL);

  string mnm = "mov";
  string mod = "l";

  // set operator modifier based on the operand size
  switch (OperandSize(src)) {
    case 1: mod = "zbl"; break;
    case 2: mod = "zwl"; break;
    case 4: mod = "l"; break;
  }

  // emit the load instruction
  EmitInstruction(mnm + mod, Operand(src) + ", " + dst, comment);
}

void CBackendx86::Store(CTac *dst, char src_base, string comment)
{
  assert(dst != NULL);

  string mnm = "mov";
  string mod = "l";
  string src = "%";

  // compose the source register name based on the operand size
  switch (OperandSize(dst)) {
    case 1: mod = "b"; src += string(1, src_base) + "l"; break;
    case 2: mod = "w"; src += string(1, src_base) + "x"; break;
    case 4: mod = "l"; src += "e" + string(1, src_base) + "x"; break;
  }

  // emit the store instruction
  EmitInstruction(mnm + mod, src + ", " + Operand(dst), comment);
}

string CBackendx86::Operand(const CTac *op)
{
  string operand;
  //cout << "Operand is " << op << endl;
  const CTacReference *ref;
  const CTacConst *con;
  const CTacTemp *temp;
  const CTacName *name;

  // TODO
  // return a string representing op
  // hint: take special care of references (op of type CTacReference)

  if (con = dynamic_cast<const CTacConst *>(op)) {
	  //cout << "const type" << endl << endl;
	  return Imm(con->GetValue());
  }
  else if (ref = dynamic_cast<const CTacReference *>(op)) {	// case @t1, @t2 ...
	  //cout << "ref type" << endl << endl;
	  const CSymbol *sym = ref->GetSymbol();
	  if (sym->GetSymbolType() == stGlobal)
		  EmitInstruction("movl", sym->GetName() + ", \%edi");
	  else 
		  EmitInstruction("movl", to_string(sym->GetOffset()) + "(" + sym->GetBaseRegister() + "), \%edi");

	  return "(\%edi)";
  }
  else if (name = dynamic_cast<const CTacName *>(op)) { // case a, b (global symbols or parameter ...)
	  //cout << "name type" << endl << endl;
	  const CSymbol *sym = name->GetSymbol();
	  if (sym->GetSymbolType() == stGlobal)
		  return sym->GetName();
	  else 
		  return to_string(sym->GetOffset()) + "(" + sym->GetBaseRegister() + ")";

  }


  return operand;
}

string CBackendx86::Imm(int value) const
{
  ostringstream o;
  o << "$" << dec << value;
  return o.str();
}

string CBackendx86::Label(const CTacLabel* label) const
{
  CScope *cs = GetScope();
  assert(cs != NULL);

  ostringstream o;
  o << "l_" << cs->GetName() << "_" << label->GetLabel();
  return o.str();
}

string CBackendx86::Label(string label) const
{
  CScope *cs = GetScope();
  assert(cs != NULL);

  return "l_" + cs->GetName() + "_" + label;
}

string CBackendx86::Condition(EOperation cond) const
{
  switch (cond) {
    case opEqual:       return "e";
    case opNotEqual:    return "ne";
    case opLessThan:    return "l";
    case opLessEqual:   return "le";
    case opBiggerThan:  return "g";
    case opBiggerEqual: return "ge";
    default:            assert(false); break;
  }
}

int CBackendx86::OperandSize(CTac *t) const
{
  int size = 4;
  // TODO
  // compute the size for operand t of type CTacName
  // Hint: you need to take special care of references (incl. references to pointers!)
  //       and arrays. Compare your output to that of the reference implementation
  //       if you are not sure.
  CTacName *name; 
  CTacConst *con;
 
  if (name = dynamic_cast<CTacName *>(t)) {
	  const CSymbol *sym = name->GetSymbol();
	  const CType *type = sym->GetDataType();

	  if (type->IsArray()) {
		  const CArrayType *arr = dynamic_cast<const CArrayType *>(type);
		  size = arr->GetBaseType()->GetSize();
	  }
	  else if (type->IsScalar()) {
		  if (type->IsBoolean() || type->IsChar()) size = 1;
		  else if (type->IsInt()) size = 4;
		  else if (type->IsPointer()) {
			  /*
			  const CPointerType *ptr = dynamic_cast<const CPointerType *>(type);
			  type = ptr->GetBaseType();

			  const CArrayType *arr = dynamic_cast<const CArrayType *>(type);
			  size = arr->GetBaseType()->GetSize();
			  */
			  size = 4;
		  }
		  else if (type->IsNull()) {

		  }
	  }
	  cout << sym->GetName() << " is " << sym->GetDataType() << " <<< " << size << endl << endl;
  }
  else if (con = dynamic_cast<CTacConst *>(t)) {
	  cout << "constant !!!!!!!!!!!!!!!!!!!! " <<endl;

  }
  else {
	  cout << "other !!#@Q#$@#$" <<endl;
  }

  return size;
}

size_t CBackendx86::ComputeStackOffsets(CSymtab *symtab, int param_ofs, int local_ofs)
{
  assert(symtab != NULL);
  vector<CSymbol*> slist = symtab->GetSymbols();

  _out << _ind << "# stack offsets:"  << endl;

  size_t size = 0;
  int l_ofs = local_ofs;

  // TODO
  // foreach local symbol l in slist do
  //   compute aligned offset on stack and store in symbol l
  //   set base register to %ebp
  //
  // foreach parameter p in slist do
  //   compute offset on stack and store in symbol p
  //   set base register to %ebp
  //
  // align size
  //
  // dump stack frame to assembly file
  for (int i=0; i<slist.size(); ++i) {
	  ESymbolType type = slist[i]->GetSymbolType();
	  slist[i]->SetBaseRegister("\%ebp");

	  switch (type) {
		  case stParam : {
			  CSymParam *cur = dynamic_cast<CSymParam *>(slist[i]);
			  slist[i]->SetOffset(param_ofs + cur->GetIndex()*4);
			  break;
						 }

		  case stLocal : {
			  l_ofs += slist[i]->GetDataType()->GetSize();
			  if (slist[i]->GetDataType()->GetSize() == 4 && l_ofs%4) l_ofs += 4 - (l_ofs%4);
			  slist[i]->SetOffset(-l_ofs);
			  break;
						 }
	  }

  }

  for (int i=0; i<slist.size(); ++i) {
	  ESymbolType type = slist[i]->GetSymbolType();
	  if (type == stParam || type == stLocal) 
		  _out << _ind << "# " << right << setw(12) << to_string(slist[i]->GetOffset())
			  + "(" + slist[i]->GetBaseRegister() + ")"
			  << setw(4) << slist[i]->GetDataType()->GetSize()
			  << "  " << slist[i] << endl;
  }
  _out << endl;

  if (l_ofs%4) l_ofs += 4 - (l_ofs%4);
  return l_ofs - local_ofs;
}
