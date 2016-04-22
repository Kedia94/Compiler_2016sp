//------------------------------------------------------------------------------
/// @brief SnuPL/0 parser
/// @author Bernhard Egger <bernhard@csap.snu.ac.kr>
/// @section changelog Change Log
/// 2012/09/14 Bernhard Egger created
/// 2013/03/07 Bernhard Egger adapted to SnuPL/0
/// 2014/11/04 Bernhard Egger maintain unary '+' signs in the AST
/// 2016/04/01 Bernhard Egger adapted to SnuPL/1 (this is not a joke)
/// 2016/09/28 Bernhard Egger assignment 2: parser for SnuPL/-1
///
/// @section license_section License
/// Copyright (c) 2012-2016, Bernhard Egger
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

#include <limits.h>
#include <cassert>
#include <errno.h>
#include <cstdlib>
#include <vector>
#include <iostream>
#include <exception>

#include "parser.h"
using namespace std;


//------------------------------------------------------------------------------
// CParser
//
CParser::CParser(CScanner *scanner)
{
  _scanner = scanner;
  _module = NULL;
}

CAstNode* CParser::Parse(void)
{
  _abort = false;

  if (_module != NULL) { delete _module; _module = NULL; }

  try {
    if (_scanner != NULL) _module = module();

    if (_module != NULL) {
      CToken t;
      string msg;
      //if (!_module->TypeCheck(&t, &msg)) SetError(t, msg);
    }
  } catch (...) {
    _module = NULL;
  }

  return _module;
}

const CToken* CParser::GetErrorToken(void) const
{
  if (_abort) return &_error_token;
  else return NULL;
}

string CParser::GetErrorMessage(void) const
{
  if (_abort) return _message;
  else return "";
}

void CParser::SetError(CToken t, const string message)
{
  _error_token = t;
  _message = message;
  _abort = true;
  throw message;
}

bool CParser::Consume(EToken type, CToken *token)
{
  if (_abort) return false;

  CToken t = _scanner->Get();

  if (t.GetType() != type) {
    SetError(t, "expected '" + CToken::Name(type) + "', got '" +
        t.GetName() + "'");
  }

  if (token != NULL) *token = t;

  return t.GetType() == type;
}

void CParser::InitSymbolTable(CSymtab *s)
{
  CTypeManager *tm = CTypeManager::Get();

  CSymProc *sym = NULL;

  sym = new CSymProc("DIM", tm->GetInt());
  sym->AddParam(new CSymParam(0, "a", tm->GetVoidPtr()));
  sym->AddParam(new CSymParam(1, "dim", tm->GetInt()));
  s->AddSymbol(sym);

  sym = new CSymProc("DOFS", tm->GetInt());
  sym->AddParam(new CSymParam(0, "a", tm->GetVoidPtr()));
  s->AddSymbol(sym);

  sym = new CSymProc("ReadInt", tm->GetInt());
  s->AddSymbol(sym);

  sym = new CSymProc("WriteInt", tm->GetNull());
  sym->AddParam(new CSymParam(0, "i", tm->GetInt()));
  s->AddSymbol(sym);

  sym = new CSymProc("WriteChar", tm->GetNull());
  sym->AddParam(new CSymParam(0, "c", tm->GetChar()));
  s->AddSymbol(sym);

  sym = new CSymProc("WriteStr", tm->GetNull());
  sym->AddParam(new CSymParam(0, "str", tm->GetPointer(tm->GetArray(-1, tm->GetChar())))); ///< -1: open array (dimensions unspecified)
  s->AddSymbol(sym);

  sym = new CSymProc("WriteLn", tm->GetNull());
  s->AddSymbol(sym);
}

CAstModule* CParser::module(void)
{
  /*
   * module = "module" ident ";" varDeclaration { subroutineDecl }
   *          "begin" statSequence "end" ident ".".
   */

  CToken dummy, t1, t2;
  CAstModule *m;
  CAstStatement *stat = NULL;
  CAstProcedure *routine = NULL;

  Consume(tModule);
  Consume(tIdent, &t1);
  Consume(tSemicolon);

  m = new CAstModule(t1, t1.GetValue());
  InitSymbolTable(m->GetSymbolTable());

  vardeclaration(m);

  // TODO overwrite ?
  while (_scanner->Peek().GetType() != tBegin) {
    routine = subroutinedecl(m);
  }

  Consume(tBegin);
  stat = statSequence(m);
  m->SetStatementSequence(stat);

  Consume(tEnd);
  Consume(tIdent, &t2);
  Consume(tDot);

  if (t1.GetValue().compare(t2.GetValue()) != 0)
    SetError(t2, "expected \'" + t1.GetValue() + "\', but \'" + t2.GetValue() + "\'");

  return m;
}

CAstStatement* CParser::statSequence(CAstScope *s)
{
  //
  // statSequence ::= [ statement { ";" statement } ].
  // statement ::= assignment | subroutineCall | ifStatement | whileStatement | returnStatement
  // FIRST = FIRST(<statement>) U {e}
  // FOLLOW = {tEnd, tElse}
  //
  // TODO : modify this with non-do-while version, just check tEnd & tElse first time and do statement()
  // 	   and loop conusme(;), statment()

  CAstStatement *head = NULL;
  CSymtab *table = s->GetSymbolTable();		// get symbol table

  EToken tt = _scanner->Peek().GetType();	// peek next token
  if (!(tt == tEnd || tt == tElse)) {		// while current token isn't included in FOLLOW	
    CAstStatement *tail = NULL;

    do {
      CToken t;
      EToken tt = _scanner->Peek().GetType();
      CAstStatement *st = NULL;

      switch (tt) {
        /*
         * statement = assignment | subroutineCall | ifStatement | whileStatement | returnStatement
		 * FIRST(<statement>) = {tIdent, tIdent, tIf, tWhile, tReturn}
         */

        case tIdent:	// TODO becareful with assignment & subroutinecall
		  // if tIdent's value type is procedure it is subroutinecall
          if (table->FindSymbol(_scanner->Peek().GetValue())->GetSymbolType() == stProcedure) {
            st = subroutinecall(s);
          }
		  // else it is assignment
          else {
            st = assignment(s);
          }
		  // TODO else not declared symbol used => should be checked like factor
          break;

          // statement ::= ifStatement
        case tIf:
          st = ifstatement(s);
          break;

          // statement ::= whileStatement
        case tWhile:
          st = whilestatement(s);
          break;

          // statement ::= returnStatement
        case tReturn:
          st = returnstatement(s);
          break;

        default:
          SetError(_scanner->Peek(), "statement expected.");
          break;
      }

      assert(st != NULL);			// for error handling
      
	  if (head == NULL)				// if it is first time
		  head = st;				// make new statment
      else 
		  tail->SetNext(st);		// else append to next

      tail = st;					// TODO : what's this?

      tt = _scanner->Peek().GetType();
      if (tt == tEnd || tt == tElse) break;

      Consume(tSemicolon);		
    } while (!_abort);
  }

  return head;						// where tail goes?
}

CAstStatAssign* CParser::assignment(CAstScope *s)
{
  /* TODO ?? 
   *  assignment = qualident ":=" expression.
   *  FIRST = {tIdnet}
   */
  CToken t;

  CAstDesignator *lhs = qualident(s);	// qualident
  Consume(tAssign, &t);					// ":="
  CAstExpression *rhs = expression(s);	// expression

  return new CAstStatAssign(t, lhs, rhs);
}

CAstExpression* CParser::expression(CAstScope* s)
{
  /*
   * expression ::= simpleexpr [ relOp simpleexpression ].
   */

  CToken t;
  EOperation relop;
  CAstExpression *left = NULL, *right = NULL;

  left = simpleexpr(s);
  if (_scanner->Peek().GetType() == tRelOp) {			// if it has [ relOp simpleexpression ]
    Consume(tRelOp, &t);								// Consume relOp
    right = simpleexpr(s);								// get right simpleexpression

	// find out what operator t is
    if (t.GetValue() == "=")       relop = opEqual;
    else if (t.GetValue() == "#")  relop = opNotEqual;
    else if (t.GetValue() == "<")  relop = opLessThan;
    else if (t.GetValue() == "<=") relop = opLessEqual;
    else if (t.GetValue() == ">")  relop = opBiggerThan;
    else if (t.GetValue() == ">=") relop = opBiggerEqual;
    else SetError(t, "invalid relation.");				// if no operator matches

    return new CAstBinaryOp(t, relop, left, right);
  } 
  else {												// it has no [ relOp simpleexpression ] part
    return left;
  }
}

CAstExpression* CParser::simpleexpr(CAstScope *s)
{
  /*
   * simpleexpr ::= ["+"|"-"] term { termOp term }.
   */

  CToken topt;
  EOperation factop;
  CAstExpression *n = NULL;

  if (_scanner->Peek().GetType() == tTermOp) {			// if it has ["+"|"-"] parts
    Consume(tTermOp, &topt);							// consume operator
  }

  n = term(s);											// term parts

  // designate appropriate operations
  if (topt.GetValue() == "+") n = new CAstUnaryOp(topt, opPos, n);
  else if (topt.GetValue() == "-") n = new CAstUnaryOp(topt, opNeg, n);
  else SetError(topt, "invalid unary operation.");		// set error 
  // FIXME : it should be "||" ?

  while (_scanner->Peek().GetType() == tTermOp) {		// { termOp term } parts
    CToken t;
    CAstExpression *l = n, *r;

    Consume(tTermOp, &t);								// consume termOp
    r = term(s);										// consume term

	// designate appropriate operations
    if (t.GetValue() == "+")       n = new CAstBinaryOp(t, opAdd, l, r);
    else if (t.GetValue() == "-")  n = new CAstBinaryOp(t, opSub, l, r);
    else if (t.GetValue() == "||") n = new CAstBinaryOp(t, opOr,  l, r);
  }

  return n;
}

CAstExpression* CParser::term(CAstScope *s)
{
  /* 
   * term = factor { factOp factor }.
   */
  CAstExpression *n = NULL;

  n = factor(s); // factor part							

  EToken tt = _scanner->Peek().GetType();
  while ((tt == tFactOp)) {	// check for { factOp factor } part
    CToken t;
    CAstExpression *l = n, *r;

    Consume(tFactOp, &t);
    r = factor(s);

	// designate appropriate operations
    if (t.GetValue() == "*")        n = new CAstBinaryOp(t, opMul, l, r);
    else if (t.GetValue() == "/")   n = new CAstBinaryOp(t, opDiv, l, r);
    else if (t.GetValue() == "&&")  n = new CAstBinaryOp(t, opAnd, l, r);

    tt = _scanner->Peek().GetType();
  }

  return n;
}

CAstExpression* CParser::factor(CAstScope *s)
{
  /* 
   * factor = qualident | number | boolean | char | string | "(" expression ")" | subroutineCall | "!" factor.
   */
  // XXX ident should be distinguished

  CToken t;
  EToken tt = _scanner->Peek().GetType();
  CAstExpression *unary = NULL, *n = NULL;
  const CSymbol *symbol = NULL;
  CAstStatCall* call = NULL;

  switch (tt) {
    // factor ::= qualident
    // factor ::= subroutinecall
    case tIdent:
      symbol = s->GetSymbolTable()->FindSymbol(_scanner->Peek().GetValue());
	  // if peeked value is not found in symboltable
      if (symbol == NULL) {	// Error handling
        SetError(t, "No symbol \'" + _scanner->Peek().GetValue() + "\'");
      }
      else {
        if (symbol->GetSymbolType() == stProcedure) {	// if it's subroutinecall
          call = subroutinecall(s);						// XXX what's this statement means?
          n = call->GetCall();
        }
        else {
          n = qualident(s);
        }
      }
      break;

      // factor ::= number
    case tNumber:
      n = number();
      break;

      // factor ::= boolean
      // boolean = "True" | "False".
    case tTrue:
    case tFalse:
      n = boolean();
      break;

      // factor ::= char
      // char = "'" character "'".
      // "'" character "'" is scanned as one token {tCharacter}
    case tCharacter:
      Consume(tCharacter, &t);
      n = new CAstStringConstant(t, t.GetValue(), s);
      break;

      // factor ::= string
      // string = '"' { character } '"'.
      // '"' { character } '"' is scanned as one token {tString}

    case tString:
      Consume(tString, &t);
      n = new CAstStringConstant(t, t.GetValue(), s);
      break;


      // factor ::= "(" expression ")"
    case tLBrak:
      Consume(tLBrak);
      n = expression(s);
      Consume(tRBrak);
      break;

      // factor ::= "!" factor
    case tNot:
      Consume(tNot, &t);
      unary = factor(s);
      n = new CAstUnaryOp(t, opNot, unary);
      break;

    default:
      SetError(_scanner->Peek(), "factor expected.");
      break;
  }

  return n;
}

CAstConstant* CParser::number(void)
{
  //
  // number ::= digit { digit }.
  // "digit { digit }" is scanned as one token (tNumber)
  //

  CToken t;

  Consume(tNumber, &t);

  errno = 0;
  long long v = strtoll(t.GetValue().c_str(), NULL, 10);
  if (errno != 0) SetError(t, "invalid number.");

  return new CAstConstant(t, CTypeManager::Get()->GetInt(), v);
}

CAstConstant* CParser::boolean(void)
{
  //
  // boolean = "true" | "false"
  //

  CToken t;

  if (_scanner->Peek().GetType() == tTrue){
    Consume(tTrue, &t);
    return new CAstConstant(t, CTypeManager::Get()->GetBool(), true);
  }
  else {
    Consume(tFalse, &t);
    return new CAstConstant(t, CTypeManager::Get()->GetBool(), false);
  }
}

CAstDesignator* CParser::ident(CAstScope *s)
{
  //
  // ident ::= letter { letter | digit }.
  //
  // "letter { letter | digit }" is scanned as one token (tIdent)
  //

  // XXX don't we hae to check wheter ident is insdie a scope s?

  CToken t;
  Consume(tIdent, &t);
  return new CAstDesignator(t, s->GetSymbolTable()->FindSymbol(t.GetValue()));
}

CAstArrayDesignator* CParser::qualident(CAstScope *s)
{
  //
  // qualident ::= ident { "[" expression "]" }.
  //
  // TODO: 무조건 CAstArrayDesignator로 리턴하게 했는데, 배열 아닌경우 CAstDesignator로 해야하는지..

  CAstArrayDesignator *n = NULL;
  int i = 0;
  CToken t;
  const CSymbol *symbol = NULL;
  CAstExpression *ex = NULL;

  Consume(tIdent, &t);

  symbol = s->GetSymbolTable()->FindSymbol(t.GetValue());
  if (_scanner->Peek().GetType() != tLLBrak) {
    return (CAstArrayDesignator *) new CAstDesignator(t, symbol);
  }
  n = new CAstArrayDesignator(t, symbol);

  while (_scanner->Peek().GetType() == tLLBrak) {
    Consume(tLLBrak);
    ex = expression(s);
    Consume(tRRBrak);

    n->AddIndex(ex);
  }

  return n; 

}

CAstType* CParser::type(CAstScope *s, bool pointer)
{
  //
  // type = basetype | type "[" [ number ] "]".
  //
  // basetype = "boolean" | "char" | "integer"
  // token: tBoolean, tChar, tInteger
  //

  CAstType *n = NULL;
  CToken t;
  const CType *type;
  CTypeManager *tm = CTypeManager::Get();

  EToken tt = _scanner->Peek().GetType();

  switch (tt) {

    // type ::= basetype

    case tBoolean:
      Consume(tBoolean, &t);
      type = tm->GetBool();
      break;

    case tChar:
      Consume(tChar, &t);
      type =  tm->GetChar();
      break;

    case tInteger:
      Consume(tInteger, &t);
      type = tm->GetInt();
      break;
  }
  if (_scanner->Peek().GetType() != tLLBrak) {
    return new CAstType(t, type);
  }
  // type ::= type "[" [ number ] "]" -> array
  while (_scanner->Peek().GetType() == tLLBrak) {
    Consume(tLLBrak);

    CAstConstant *k;
    if (_scanner->Peek().GetType() == tNumber) {
      k = number();
      type = tm->GetArray(k->GetValue(), type);
    }
    else {
      type = tm->GetArray(-1, type);
    }

    Consume(tRRBrak);

  }
  if (pointer) {
    type = tm->GetPointer(type);
  }

  n = new CAstType(t, type);
  return n;
}

CAstStatCall* CParser::subroutinecall(CAstScope *s)
{
  //
  // subroutinecall = ident "(" [ expression { "," expression } ] ")".
  //

  CAstStatement *n = NULL;
  CToken t;
  CAstExpression *l, *r = NULL;
  CAstFunctionCall *funccall = NULL;
  CAstDesignator *identifier = NULL;

  identifier = ident(s);

  funccall = new CAstFunctionCall(identifier->GetToken(), (CSymProc *)identifier->GetSymbol());

  Consume(tLBrak);

  if (_scanner->Peek().GetType() != tRBrak) {
    l = expression(s);
    funccall->AddArg(l);
    while (_scanner->Peek().GetType() == tComma) {
      Consume(tComma);
      l = expression(s);
      funccall->AddArg(l);
    }
  }

  Consume(tRBrak);

  return new CAstStatCall(t, funccall);
}

CAstStatement* CParser::ifstatement(CAstScope *s)
{
  //
  // ifstatement = "if" "(" expression ")" "then" statsquence [ "else" statsequence ] "end".
  //
  CAstStatement *n = NULL;
  CAstExpression *l;
  CAstStatement *m, *r = NULL;
  CToken t;

  Consume(tIf, &t);

  Consume(tLBrak);
  l = expression(s);
  Consume(tRBrak);

  Consume(tThen);
  m = statSequence(s);

  if (_scanner->Peek().GetType() == tElse) {
    Consume(tElse);
    r = statSequence(s);
  }
  Consume(tEnd);

  n = new CAstStatIf(t, l, m, r);

  return n;
}

CAstStatement* CParser::whilestatement(CAstScope *s)
{
  //
  // whilestatement = "while" "(" expression ")" "do" statsequence "end".
  //

  CAstStatement *n = NULL;
  CAstExpression *l;
  CAstStatement *r;
  CToken t;

  Consume(tWhile, &t);

  Consume(tLBrak);
  l = expression(s);
  Consume(tRBrak);

  Consume(tDo);
  r = statSequence(s);
  Consume(tEnd);

  n = new CAstStatWhile(t, l, r);

  return n;
}

CAstStatement* CParser::returnstatement(CAstScope *s)
{
  //
  // returnstatement = "return" [ expression ].
  //

  CAstStatement *n = NULL;
  CToken t;
  CAstExpression *child = NULL;

  Consume(tReturn, &t);

  switch (_scanner->Peek().GetType()) {
    // TODO: Check FOLLOW
    // FOLLOW(returnstatement) = "end" | ";" | "else"
    // returnstatement ::= "return"
    case tEnd:
    case tSemicolon:
    case tElse:
      n = new CAstStatReturn(t, s, child);
      break;

      // returnstatement ::= "return" expression 
    default:
      child = expression(s);
      n = new CAstStatReturn(t, s, child);
      break;
  }
  return n;
}

void CParser::vardeclaration(CAstScope *s)
{
  //
  // vardeclaration = [ "var" varDeclSequence ";" ].
  //
  // only Consume(tVar) is not enough
  // ";" will be consumed in function vardeclsequence

  if (_scanner->Peek().GetType() == tVar) {
    Consume(tVar);
    vardeclsequence(s);
  }
}

void CParser::vardecl(CAstScope *s)
{
  //
  // vardecl = ident { "," ident } ":" type
  //

  CToken t;
  vector<CToken> vec;
  CAstType *typ = NULL;
  CSymbol *symbol = NULL;
  CSymtab *symTab = s->GetSymbolTable();

  Consume(tIdent, &t);
  // cout << t.GetValue() << endl;
  vec.push_back(t);

  while (_scanner->Peek().GetType() == tComma) {
    Consume(tComma);
    Consume(tIdent, &t);
    //cout << t.GetValue() << endl;
    vec.push_back(t);
  }

  Consume(tColon);
  typ = type(s);

  int size = vec.size();
  for (int i=0;i<size; i++) {
    symbol = s->CreateVar(vec[i].GetValue(), typ->GetType());
    if (!symTab->AddSymbol(symbol))
      SetError(vec[i], "already existing variable");
  }
}

void CParser::vardeclsequence(CAstScope *s)
{
  //
  // vardeclsequence = vardecl { ";" vardecl }.
  //

  vardecl(s);
  while(_scanner->Peek().GetType() == tSemicolon) {
    Consume(tSemicolon);
    if (_scanner->Peek().GetType() != tIdent)
      break;
    vardecl(s);
  }
}

CAstProcedure* CParser::subroutinedecl(CAstScope *s)
{
  //
  // subroutinedecl = (proceduredecl | functiondecl)
  //                  subroutinebody ident ";".
  // proceduredecl = "procedure" ident [ formalparam ] ";"
  // functiondecl = "function" ident [ formalparam ] ":" type ";"
  // formalparam = "(" [ vardeclsequence ] ")".
  // vardeclsequence = vardecl { ";" vardecl }.
  // vardecl = ident { "," ident } ":" type
  //

  CAstProcedure *n = NULL;
  CToken t, tname, tendname, tval;
  CAstType *typ = NULL;
  vector<CToken> vec;
  vector<CSymParam *> v;
  int index=0, size;
  CSymProc *sym = NULL;
  CSymtab *table = s->GetSymbolTable();

  if (_scanner->Peek().GetType() == tProcedure) {
    Consume(tProcedure, &t);
  }
  else if (_scanner->Peek().GetType() == tFunction) {
    Consume(tFunction, &t);
  }
  else {
    SetError(_scanner->Peek(), "\"procedure\" or \"function\" expected.");
  }

  Consume(tIdent, &tname);
  
  // formalparam
  if (_scanner->Peek().GetType() == tLBrak) {
    Consume(tLBrak);
    if (_scanner->Peek().GetType() != tRBrak) {
      Consume(tIdent, &tval);
      vec.push_back(tval);
      while (_scanner->Peek().GetType() == tComma) {
        Consume(tComma);
        Consume(tIdent, &tval);
        vec.push_back(tval);
      }
      Consume(tColon);
      typ = type(s,true);
      size = vec.size();

      for (int i=0; i<size; i++) {
        v.push_back(new CSymParam(index, vec[i].GetValue(), typ->GetType()));
        index++;
      }

      while (_scanner->Peek().GetType() == tSemicolon) {
        vec.clear();
        Consume(tSemicolon);
        Consume(tIdent, &tval);
        vec.push_back(tval);
        while (_scanner->Peek().GetType() == tComma) {
          Consume(tComma);
          Consume(tIdent, &tval);
          vec.push_back(tval);
        }
        Consume(tColon);
        typ = type(s);
        size = vec.size();

        for (int i=0; i<size; i++) {
          v.push_back(new CSymParam(index, vec[i].GetValue(), typ->GetType()));
          index++;
        }
      }
    }
    Consume(tRBrak);
  }

  if (t.GetType() == tFunction) {
    Consume(tColon);
    typ = type(s);
    sym = new CSymProc(tname.GetValue(), typ->GetType());
  }
  else {
    sym = new CSymProc(tname.GetValue(), CTypeManager::Get()->GetNull());
  }
  Consume(tSemicolon);

  size = v.size();
  for (int i=0;i<size;i++) {
    sym->AddParam(v[i]);
  }

  n = new CAstProcedure(t, tname.GetValue(), s, sym);
  table->AddSymbol(sym);
  table = n->GetSymbolTable();
  for (int i=0;i<size;i++) {
    table->AddSymbol(v[i]);
  }

  // subroutinebody

  subroutinebody(n);
  Consume(tIdent, &tendname);
  Consume(tSemicolon);

  // different ident
  if (tendname.GetValue().compare(tname.GetValue()) != 0) {
    SetError(tendname, "expected \'" + tname.GetValue() + "\', end with \'" + tendname.GetValue() + "\'");
  }

  return n;
}

CAstExpression* CParser::subroutinebody(CAstScope *s)
{
  //
  // subroutinebody = vardeclaration "begin" statsequence "end".
  //

  CAstExpression *n = NULL;
  CAstStatement *stat = NULL; 
  vardeclaration(s);
  Consume(tBegin);
  if (_scanner->Peek().GetType() != tEnd)
    stat = statSequence(s);
  Consume(tEnd);

  s->SetStatementSequence(stat);
  return n;
}

