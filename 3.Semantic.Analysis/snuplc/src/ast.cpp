//------------------------------------------------------------------------------
/// @brief SnuPL abstract syntax tree
/// @author Bernhard Egger <bernhard@csap.snu.ac.kr>
/// @section changelog Change Log
/// 2012/09/14 Bernhard Egger created
/// 2013/05/22 Bernhard Egger reimplemented TAC generation
/// 2013/11/04 Bernhard Egger added typechecks for unary '+' operators
/// 2016/03/12 Bernhard Egger adapted to SnuPL/1
/// 2014/04/08 Bernhard Egger assignment 2: AST for SnuPL/-1
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

#include <iostream>
#include <cassert>
#include <cstring>

#include <typeinfo>

#include "ast.h"
using namespace std;

//#define DEBUG 
#ifdef DEBUG
#define Dprintf(a) printf a
#else
#define Dprintf(a) ;
#endif

//------------------------------------------------------------------------------
// CAstNode
//
int CAstNode::_global_id = 0;

	CAstNode::CAstNode(CToken token)
: _token(token), _addr(NULL)
{
	_id = _global_id++;
}

CAstNode::~CAstNode(void)
{
	if (_addr != NULL) delete _addr;
}

int CAstNode::GetID(void) const
{
	return _id;
}

CToken CAstNode::GetToken(void) const
{
	return _token;
}

const CType* CAstNode::GetType(void) const
{
	return CTypeManager::Get()->GetNull();
}

string CAstNode::dotID(void) const
{
	ostringstream out;
	out << "node" << dec << _id;
	return out.str();
}

string CAstNode::dotAttr(void) const
{
	return " [label=\"" + dotID() + "\"]";
}

void CAstNode::toDot(ostream &out, int indent) const
{
	string ind(indent, ' ');

	out << ind << dotID() << dotAttr() << ";" << endl;
}

CTacAddr* CAstNode::GetTacAddr(void) const
{
	return _addr;
}

ostream& operator<<(ostream &out, const CAstNode &t)
{
	return t.print(out);
}

ostream& operator<<(ostream &out, const CAstNode *t)
{
	return t->print(out);
}

//------------------------------------------------------------------------------
// CAstScope
//
	CAstScope::CAstScope(CToken t, const string name, CAstScope *parent)
: CAstNode(t), _name(name), _symtab(NULL), _parent(parent), _statseq(NULL),
	_cb(NULL)
{
	if (_parent != NULL) _parent->AddChild(this);
}

CAstScope::~CAstScope(void)
{
	delete _symtab;
	delete _statseq;
	delete _cb;
}

const string CAstScope::GetName(void) const
{
	return _name;
}

CAstScope* CAstScope::GetParent(void) const
{
	return _parent;
}

size_t CAstScope::GetNumChildren(void) const
{
	return _children.size();
}

CAstScope* CAstScope::GetChild(size_t i) const
{
	assert(i < _children.size());
	return _children[i];
}

CSymtab* CAstScope::GetSymbolTable(void) const
{
	assert(_symtab != NULL);
	return _symtab;
}

void CAstScope::SetStatementSequence(CAstStatement *statseq)
{
	_statseq = statseq;
}

CAstStatement* CAstScope::GetStatementSequence(void) const
{
	return _statseq;
}

bool CAstScope::TypeCheck(CToken *t, string *msg) const
{
	Dprintf(("[Scope::TypeCheck] Start: %s \n", _name.c_str()));
	bool result = true;
	int i;
	for (i=0; i<_children.size(); i++){												// Iterate through all children scope
		Dprintf(("\n[Scope::TypeCheck] %d over %d\n", i ,(int)_children.size()));
		if (_children[i] != NULL && !_children[i]->TypeCheck(t, msg)) return false;	// If one of them is invalid, return false
	}

	if (_statseq != NULL && !_statseq->TypeCheck(t, msg)) return false;				// Move on to the next sequence
	Dprintf(("[Scope::TypeCheck] End: %s\n", _name.c_str()));
	return result;
}

ostream& CAstScope::print(ostream &out, int indent) const
{
	string ind(indent, ' ');

	out << ind << "CAstScope: '" << _name << "'" << endl;
	out << ind << "  symbol table:" << endl;
	_symtab->print(out, indent+4);
	out << ind << "  statement list:" << endl;
	CAstStatement *s = GetStatementSequence();
	if (s != NULL) {
		do {
			s->print(out, indent+4);
			s = s->GetNext();
		} while (s != NULL);
	} else {
		out << ind << "    empty." << endl;
	}

	out << ind << "  nested scopes:" << endl;
	if (_children.size() > 0) {
		for (size_t i=0; i<_children.size(); i++) {
			_children[i]->print(out, indent+4);
		}
	} else {
		out << ind << "    empty." << endl;
	}
	out << ind << endl;

	return out;
}

void CAstScope::toDot(ostream &out, int indent) const
{
	string ind(indent, ' ');

	CAstNode::toDot(out, indent);

	CAstStatement *s = GetStatementSequence();
	if (s != NULL) {
		string prev = dotID();
		do {
			s->toDot(out, indent);
			out << ind << prev << " -> " << s->dotID() << " [style=dotted];" << endl;
			prev = s->dotID();
			s = s->GetNext();
		} while (s != NULL);
	}

	vector<CAstScope*>::const_iterator it = _children.begin();
	while (it != _children.end()) {
		CAstScope *s = *it++;
		s->toDot(out, indent);
		out << ind << dotID() << " -> " << s->dotID() << ";" << endl;
	}

}

CTacAddr* CAstScope::ToTac(CCodeBlock *cb)
{
	return NULL;
}

CCodeBlock* CAstScope::GetCodeBlock(void) const
{
	return _cb;
}

void CAstScope::SetSymbolTable(CSymtab *st)
{
	if (_symtab != NULL) delete _symtab;
	_symtab = st;
}

void CAstScope::AddChild(CAstScope *child)
{
	_children.push_back(child);
}


//------------------------------------------------------------------------------
// CAstModule
//
	CAstModule::CAstModule(CToken t, const string name)
: CAstScope(t, name, NULL)
{
	SetSymbolTable(new CSymtab());
}

CSymbol* CAstModule::CreateVar(const string ident, const CType *type)
{
	return new CSymGlobal(ident, type);
}

string CAstModule::dotAttr(void) const
{
	return " [label=\"m " + GetName() + "\",shape=box]";
}



//------------------------------------------------------------------------------
// CAstProcedure
//
CAstProcedure::CAstProcedure(CToken t, const string name,
		CAstScope *parent, CSymProc *symbol)
: CAstScope(t, name, parent), _symbol(symbol)
{
	assert(GetParent() != NULL);
	SetSymbolTable(new CSymtab(GetParent()->GetSymbolTable()));
	assert(_symbol != NULL);
}

CSymProc* CAstProcedure::GetSymbol(void) const
{
	return _symbol;
}

CSymbol* CAstProcedure::CreateVar(const string ident, const CType *type)
{
	return new CSymLocal(ident, type);
}

const CType* CAstProcedure::GetType(void) const
{
	return GetSymbol()->GetDataType();
}

string CAstProcedure::dotAttr(void) const
{
	return " [label=\"p/f " + GetName() + "\",shape=box]";
}


//------------------------------------------------------------------------------
// CAstType
//
	CAstType::CAstType(CToken t, const CType *type)
: CAstNode(t), _type(type)
{
	assert(type != NULL);
}

const CType* CAstType::GetType(void) const
{
	return _type;
}

ostream& CAstType::print(ostream &out, int indent) const
{
	string ind(indent, ' ');

	out << ind << "CAstType (" << _type << ")" << endl;
	return out;
}


//------------------------------------------------------------------------------
// CAstStatement
//
	CAstStatement::CAstStatement(CToken token)
: CAstNode(token), _next(NULL)
{
}

CAstStatement::~CAstStatement(void)
{
	delete _next;
}

void CAstStatement::SetNext(CAstStatement *next)
{
	_next = next;
}

CAstStatement* CAstStatement::GetNext(void) const
{
	return _next;
}

CTacAddr* CAstStatement::ToTac(CCodeBlock *cb, CTacLabel *next)
{
	return NULL;
}


//------------------------------------------------------------------------------
// CAstStatAssign
//
CAstStatAssign::CAstStatAssign(CToken t,
		CAstDesignator *lhs, CAstExpression *rhs)
: CAstStatement(t), _lhs(lhs), _rhs(rhs)
{
	assert(lhs != NULL);
	assert(rhs != NULL);
}

CAstDesignator* CAstStatAssign::GetLHS(void) const
{
	return _lhs;
}

CAstExpression* CAstStatAssign::GetRHS(void) const
{
	return _rhs;
}

bool CAstStatAssign::TypeCheck(CToken *t, string *msg) const
{
	Dprintf(("[Assign::TypeCheck] Start\n"));
	if (!_lhs->TypeCheck(t, msg)) return false;							// Type check lhs statement
	if (!_rhs->TypeCheck(t, msg)) return false;							// Type check rhs statement

	const CType *lt = _lhs->GetType();									// Get type of lhs
	const CType *rt = _rhs->GetType();									// Get type of rhs
	if (!rt->IsScalar() || !lt->IsScalar()) {							// If it's compound type
		if (msg != NULL) *msg = "(Assign) assigning compound type";
		if (t != NULL) *t = GetToken();
		return false;
	}

	if (!lt->Compare(rt)) {												// If two types are different, error
		if (msg != NULL) *msg = "(Assign) left and right have different type";
		if (t != NULL) *t = GetToken();
		return false;
	}


	Dprintf(("[Assign::TypeCheck] End\n"));
	if (GetNext() != NULL && !GetNext()->TypeCheck(t, msg)) return false;// Move on to the next statement

	return true;
}

const CType* CAstStatAssign::GetType(void) const
{
	return _lhs->GetType();
}

ostream& CAstStatAssign::print(ostream &out, int indent) const
{
	string ind(indent, ' ');

	out << ind << ":=" << " ";

	const CType *t = GetType();
	if (t != NULL) out << t; else out << "<INVALID>";

	out << endl;

	_lhs->print(out, indent+2);
	_rhs->print(out, indent+2);

	return out;
}

string CAstStatAssign::dotAttr(void) const
{
	return " [label=\":=\",shape=box]";
}

void CAstStatAssign::toDot(ostream &out, int indent) const
{
	string ind(indent, ' ');

	CAstNode::toDot(out, indent);

	_lhs->toDot(out, indent);
	out << ind << dotID() << "->" << _lhs->dotID() << ";" << endl;
	_rhs->toDot(out, indent);
	out << ind << dotID() << "->" << _rhs->dotID() << ";" << endl;
}

CTacAddr* CAstStatAssign::ToTac(CCodeBlock *cb, CTacLabel *next)
{
	return NULL;
}


//------------------------------------------------------------------------------
// CAstStatCall
//
	CAstStatCall::CAstStatCall(CToken t, CAstFunctionCall *call)
: CAstStatement(t), _call(call)
{
	assert(call != NULL);
}

CAstFunctionCall* CAstStatCall::GetCall(void) const
{
	return _call;
}

bool CAstStatCall::TypeCheck(CToken *t, string *msg) const
{
	Dprintf(("[Call::TypeCheck] Start\n"));
	if (!GetCall()->TypeCheck(t, msg)) return false;						// If Calling sequence has invalid type, error


	Dprintf(("[Call::TypeCheck] End\n"));

	if (GetNext() != NULL && !GetNext()->TypeCheck(t, msg)) return false;	// Move on to the next statement
	return true;
}

ostream& CAstStatCall::print(ostream &out, int indent) const
{
	_call->print(out, indent);

	return out;
}

string CAstStatCall::dotID(void) const
{
	return _call->dotID();
}

string CAstStatCall::dotAttr(void) const
{
	return _call->dotAttr();
}

void CAstStatCall::toDot(ostream &out, int indent) const
{
	_call->toDot(out, indent);
}

CTacAddr* CAstStatCall::ToTac(CCodeBlock *cb, CTacLabel *next)
{
	return NULL;
}


//------------------------------------------------------------------------------
// CAstStatReturn
//
	CAstStatReturn::CAstStatReturn(CToken t, CAstScope *scope, CAstExpression *expr)
: CAstStatement(t), _scope(scope), _expr(expr)
{
	assert(scope != NULL);
}

CAstScope* CAstStatReturn::GetScope(void) const
{
	return _scope;
}

CAstExpression* CAstStatReturn::GetExpression(void) const
{
	return _expr;
}

bool CAstStatReturn::TypeCheck(CToken *t, string *msg) const
{
	Dprintf(("[Return::TypeCheck] Start\n"));
	const CType *st = GetScope() -> GetType();			// Get type of enclosing procedure
	CAstExpression *e = GetExpression();				// Get return expression

	if (st->Match(CTypeManager::Get()->GetNull())) {	// If return value should be void
		if (e != NULL) { 								// If return value is not void, error
			if (t != NULL) *t = _expr->GetToken();
			if (msg != NULL) *msg = "superflous expression after return.";
			return false;
		}
	}
	else {												// If return value should be something else
		if (e == NULL) {								// If return value is null, error
			if (t != NULL) *t = GetToken();
			if (msg != NULL) *msg = "expression expected after return.";
			return false;
		}

		if (!e->TypeCheck(t, msg)) return false;		// If type of return expression fails

		if (!st->Match(e->GetType())) {					// If return type has wrong type
			if (t != NULL) *t = GetToken();
			if (msg != NULL) *msg = "return type mismatch.";
			return false;
		}
	}

	Dprintf(("[Return::TypeCheck] End\n"));
	if (GetNext() != NULL && !GetNext()->TypeCheck(t, msg)) return false;

	return true;
}

const CType* CAstStatReturn::GetType(void) const
{
	const CType *t = NULL;

	if (GetExpression() != NULL) {
		t = GetExpression()->GetType();
	} else {
		t = CTypeManager::Get()->GetNull();
	}

	return t;
}

ostream& CAstStatReturn::print(ostream &out, int indent) const
{
	string ind(indent, ' ');

	out << ind << "return" << " ";

	const CType *t = GetType();
	if (t != NULL) out << t; else out << "<INVALID>";

	out << endl;

	if (_expr != NULL) _expr->print(out, indent+2);

	return out;
}

string CAstStatReturn::dotAttr(void) const
{
	return " [label=\"return\",shape=box]";
}

void CAstStatReturn::toDot(ostream &out, int indent) const
{
	string ind(indent, ' ');

	CAstNode::toDot(out, indent);

	if (_expr != NULL) {
		_expr->toDot(out, indent);
		out << ind << dotID() << "->" << _expr->dotID() << ";" << endl;
	}
}

CTacAddr* CAstStatReturn::ToTac(CCodeBlock *cb, CTacLabel *next)
{
	return NULL;
}


//------------------------------------------------------------------------------
// CAstStatIf
//
CAstStatIf::CAstStatIf(CToken t, CAstExpression *cond,
		CAstStatement *ifBody, CAstStatement *elseBody)
: CAstStatement(t), _cond(cond), _ifBody(ifBody), _elseBody(elseBody)
{
	assert(cond != NULL);
}

CAstExpression* CAstStatIf::GetCondition(void) const
{
	return _cond;
}

CAstStatement* CAstStatIf::GetIfBody(void) const
{
	return _ifBody;
}

CAstStatement* CAstStatIf::GetElseBody(void) const
{
	return _elseBody;
}

bool CAstStatIf::TypeCheck(CToken *t, string *msg) const
{
	Dprintf(("[If::TypeCheck] Start\n"));
	if (!_cond->TypeCheck(t, msg)) return false;							// Type check condition statement
	if (!_ifBody->TypeCheck(t, msg)) return false;							// Type check body statement
	if (_elseBody != NULL && !_elseBody->TypeCheck(t, msg)) return false;	// Type check else body statement, if has any

	if (!_cond->GetType()->Compare(CTypeManager::Get()->GetBool())) {		// If condition statement is not a bool type, error
		if (t != NULL) *t = _cond->GetToken();
		if (msg != NULL) *msg = "boolean type expected";
		return false;
	}

	Dprintf(("[If::TypeCheck] End\n"));
	if (GetNext() != NULL && !GetNext()->TypeCheck(t, msg)) return false;	// Move on to the next statement

	return true;
}

ostream& CAstStatIf::print(ostream &out, int indent) const
{
	string ind(indent, ' ');

	out << ind << "if cond" << endl;
	_cond->print(out, indent+2);
	out << ind << "if-body" << endl;
	if (_ifBody != NULL) {
		CAstStatement *s = _ifBody;
		do {
			s->print(out, indent+2);
			s = s->GetNext();
		} while (s != NULL);
	} else out << ind << "  empty." << endl;
	out << ind << "else-body" << endl;
	if (_elseBody != NULL) {
		CAstStatement *s = _elseBody;
		do {
			s->print(out, indent+2);
			s = s->GetNext();
		} while (s != NULL);
	} else out << ind << "  empty." << endl;

	return out;
}

string CAstStatIf::dotAttr(void) const
{
	return " [label=\"if\",shape=box]";
}

void CAstStatIf::toDot(ostream &out, int indent) const
{
	string ind(indent, ' ');

	CAstNode::toDot(out, indent);

	_cond->toDot(out, indent);
	out << ind << dotID() << "->" << _cond->dotID() << ";" << endl;

	if (_ifBody != NULL) {
		CAstStatement *s = _ifBody;
		if (s != NULL) {
			string prev = dotID();
			do {
				s->toDot(out, indent);
				out << ind << prev << " -> " << s->dotID() << " [style=dotted];"
					<< endl;
				prev = s->dotID();
				s = s->GetNext();
			} while (s != NULL);
		}
	}

	if (_elseBody != NULL) {
		CAstStatement *s = _elseBody;
		if (s != NULL) {
			string prev = dotID();
			do {
				s->toDot(out, indent);
				out << ind << prev << " -> " << s->dotID() << " [style=dotted];" 
					<< endl;
				prev = s->dotID();
				s = s->GetNext();
			} while (s != NULL);
		}
	}
}

CTacAddr* CAstStatIf::ToTac(CCodeBlock *cb, CTacLabel *next)
{
	return NULL;
}


//------------------------------------------------------------------------------
// CAstStatWhile
//
CAstStatWhile::CAstStatWhile(CToken t,
		CAstExpression *cond, CAstStatement *body)
: CAstStatement(t), _cond(cond), _body(body)
{
	assert(cond != NULL);
}

CAstExpression* CAstStatWhile::GetCondition(void) const
{
	return _cond;
}

CAstStatement* CAstStatWhile::GetBody(void) const
{
	return _body;
}

bool CAstStatWhile::TypeCheck(CToken *t, string *msg) const
{
	Dprintf(("[While::TypeCheck] Start\n"));
	if (!_cond->TypeCheck(t, msg)) return false;							// Type check condition statement
	if (!_body->TypeCheck(t, msg)) return false;							// Type check body statement

	if (!_cond->GetType()->Match(CTypeManager::Get()->GetBool())) 			// If condition statement is not a bool type, error
		return false;		

	Dprintf(("[While::TypeCheck] End\n"));
	if (GetNext() != NULL && !GetNext()->TypeCheck(t, msg)) return false;	// Move on to the next statement

	return true;
}

ostream& CAstStatWhile::print(ostream &out, int indent) const
{
	string ind(indent, ' ');

	out << ind << "while cond" << endl;
	_cond->print(out, indent+2);
	out << ind << "while-body" << endl;
	if (_body != NULL) {
		CAstStatement *s = _body;
		do {
			s->print(out, indent+2);
			s = s->GetNext();
		} while (s != NULL);
	}
	else out << ind << "  empty." << endl;

	return out;
}

string CAstStatWhile::dotAttr(void) const
{
	return " [label=\"while\",shape=box]";
}

void CAstStatWhile::toDot(ostream &out, int indent) const
{
	string ind(indent, ' ');

	CAstNode::toDot(out, indent);

	_cond->toDot(out, indent);
	out << ind << dotID() << "->" << _cond->dotID() << ";" << endl;

	if (_body != NULL) {
		CAstStatement *s = _body;
		if (s != NULL) {
			string prev = dotID();
			do {
				s->toDot(out, indent);
				out << ind << prev << " -> " << s->dotID() << " [style=dotted];"
					<< endl;
				prev = s->dotID();
				s = s->GetNext();
			} while (s != NULL);
		}
	}
}

CTacAddr* CAstStatWhile::ToTac(CCodeBlock *cb, CTacLabel *next)
{
	return NULL;
}


//------------------------------------------------------------------------------
// CAstExpression
//
	CAstExpression::CAstExpression(CToken t)
: CAstNode(t)
{
}

CTacAddr* CAstExpression::ToTac(CCodeBlock *cb)
{
	return NULL;
}

CTacAddr* CAstExpression::ToTac(CCodeBlock *cb,
		CTacLabel *ltrue, CTacLabel *lfalse)
{
	return NULL;
}


//------------------------------------------------------------------------------
// CAstOperation
//
	CAstOperation::CAstOperation(CToken t, EOperation oper)
: CAstExpression(t), _oper(oper)
{
}

EOperation CAstOperation::GetOperation(void) const
{
	return _oper;
}


//------------------------------------------------------------------------------
// CAstBinaryOp
//
CAstBinaryOp::CAstBinaryOp(CToken t, EOperation oper,
		CAstExpression *l,CAstExpression *r)
: CAstOperation(t, oper), _left(l), _right(r)
{
	// these are the only binary operation we support for now
	assert((oper == opAdd)        || (oper == opSub)         ||
			(oper == opMul)        || (oper == opDiv)         ||
			(oper == opAnd)        || (oper == opOr)          ||
			(oper == opEqual)      || (oper == opNotEqual)    ||
			(oper == opLessThan)   || (oper == opLessEqual)   ||
			(oper == opBiggerThan) || (oper == opBiggerEqual)
		  );
	assert(l != NULL);
	assert(r != NULL);
}

CAstExpression* CAstBinaryOp::GetLeft(void) const
{
	return _left;
}

CAstExpression* CAstBinaryOp::GetRight(void) const
{
	return _right;
}

bool IsRelOp(EOperation t) {	// return true for RelOp
	return (t == opEqual) || (t == opNotEqual) || (t == opLessThan)
		|| (t == opLessEqual) || (t == opBiggerThan) || (t == opBiggerEqual);
}

bool IsArith(EOperation t) {	// return true for ArithOp
	return (t == opAdd) || (t == opSub) || (t == opMul) || (t == opDiv);
}

bool IsLogic(EOperation t) {	// return true for LogicOp
	return (t == opAnd) || (t == opOr) || (t == opNot);
}

bool CAstBinaryOp::TypeCheck(CToken *t, string *msg) const
{
	Dprintf(("[Binary::TypeCheck] Start\n"));
	EOperation op = GetOperation();

	if (!_left->TypeCheck(t, msg)) return false;		// Type check left statement
	if (!_right->TypeCheck(t, msg)) return false;		// Type check right statement

	const CType *lt = _left->GetType();					// Get lhs type
	const CType *rt = _right->GetType();				// Get rhs type

	if (!lt->Match(rt)) {									// If two types are different, error
		if (t != NULL) *t = GetToken();
		if (msg != NULL) *msg = "(BinaryOp) different type to operate";
		return false;
	}

	if (IsArith(op)) {										// If it uses arithmatic operator
		if (!lt->Match(CTypeManager::Get()->GetInt())) {	// If type is not integer, error
			if (t != NULL) *t = GetToken();
			if (msg != NULL) *msg = "(BinaryOp) arith operation: type mismatch";
			return false;
		}
	}
	else if (IsLogic(op) && op != opNot) {					// If it uses logical operator
		if (!lt->Match(CTypeManager::Get()->GetBool())) {	// If type is not boolean, error
			if (t != NULL) *t = GetToken();
			if (msg != NULL) *msg = "(BinaryOp) logical operation: type mismatch";
			return false;
		}
	}
	else if (IsRelOp(op) && op != opEqual && op != opNotEqual) {	// If it uses relational operator
		if (!(lt->Match(CTypeManager::Get()->GetChar()) ||
					lt->Match(CTypeManager::Get()->GetInt()))) {	// If type is not char or integer, error
			if (t != NULL) *t = GetToken();
			if (msg != NULL) *msg = "(BinaryOp) relational operation: type mismatch";
			return false;
		}
	}
	else if (op == opEqual || op == opNotEqual) {
		if (!(lt->Match(CTypeManager::Get()->GetChar()) ||
					lt->Match(CTypeManager::Get()->GetInt()) ||
					lt->Match(CTypeManager::Get()->GetBool()))) {	// If type is not char or integer or bool, error
			if (t != NULL) *t = GetToken();
			if (msg != NULL) *msg = "(BinaryOp) equal/unequal operation: type mismatch";
			return false;
		}
	}
	

	Dprintf(("[Binary::TypeCheck] End\n"));
	return true;
}



const CType* CAstBinaryOp::GetType(void) const
{
	EOperation op = GetOperation(); 					// Get operation
	if (IsRelOp(op) || IsLogic(op)) 					// If it's RelOp or LogicalOp
		return CTypeManager::Get()->GetBool();			// It's boolean type
	else  
		return CTypeManager::Get()->GetInt();			// Else it's Integer type
}

ostream& CAstBinaryOp::print(ostream &out, int indent) const
{
	string ind(indent, ' ');

	out << ind << GetOperation() << " ";

	const CType *t = GetType();
	if (t != NULL) out << t; else out << "<INVALID>";

	out << endl;

	_left->print(out, indent+2);
	_right->print(out, indent+2);

	return out;
}

string CAstBinaryOp::dotAttr(void) const
{
	ostringstream out;
	out << " [label=\"" << GetOperation() << "\",shape=box]";
	return out.str();
}

void CAstBinaryOp::toDot(ostream &out, int indent) const
{
	string ind(indent, ' ');

	CAstNode::toDot(out, indent);

	_left->toDot(out, indent);
	out << ind << dotID() << "->" << _left->dotID() << ";" << endl;
	_right->toDot(out, indent);
	out << ind << dotID() << "->" << _right->dotID() << ";" << endl;
}

CTacAddr* CAstBinaryOp::ToTac(CCodeBlock *cb)
{
	return NULL;
}

CTacAddr* CAstBinaryOp::ToTac(CCodeBlock *cb,
		CTacLabel *ltrue, CTacLabel *lfalse)
{
	return NULL;
}


//------------------------------------------------------------------------------
// CAstUnaryOp
//
	CAstUnaryOp::CAstUnaryOp(CToken t, EOperation oper, CAstExpression *e)
: CAstOperation(t, oper), _operand(e)
{
	assert((oper == opNeg) || (oper == opPos) || (oper == opNot));
	assert(e != NULL);
}

CAstExpression* CAstUnaryOp::GetOperand(void) const
{
	return _operand;
}

bool CAstUnaryOp::TypeCheck(CToken *t, string *msg) const
{
	Dprintf(("[Unary::TypeCheck] Start\n"));

	if (!_operand->TypeCheck(t, msg)) return false;		// Typecheck operand
	const CType* type = _operand->GetType();			// Get type of operand
	EOperation op = GetOperation();						// Get operator

	if (op == opNeg || op == opPos){						// If operator is unary + or -
		if (!type->Match(CTypeManager::Get()->GetInt())) {	// If type is not an integer, error
			if (msg != NULL) *msg = "(UnaryOp) pos/neg: type mismatch";
			if (t != NULL) *t = GetToken(); 
			return false;
		}
	}
	else {												// else if operator is unary !
		if (type != CTypeManager::Get()->GetBool()){	// If type is not a bool, error
			*msg = "(UnaryOp) not: type mismatch";
			*t = GetToken();
			return false;
		}
	}

	Dprintf(("[Unary::TypeCheck] End\n"));

	return true;
}

const CType* CAstUnaryOp::GetType(void) const
{
	EOperation op = GetOperation();							// Get operator
	if (op == opNot) return CTypeManager::Get()->GetBool();	// If it's unary ! operator, it's boolean
	else return CTypeManager::Get()->GetInt();				// else it's unary + or -, so integer
}

ostream& CAstUnaryOp::print(ostream &out, int indent) const
{
	string ind(indent, ' ');

	out << ind << GetOperation() << " ";

	const CType *t = GetType();
	if (t != NULL) out << t; else out << "<INVALID>";
	out << endl;

	_operand->print(out, indent+2);

	return out;
}

string CAstUnaryOp::dotAttr(void) const
{
	ostringstream out;
	out << " [label=\"" << GetOperation() << "\",shape=box]";
	return out.str();
}

void CAstUnaryOp::toDot(ostream &out, int indent) const
{
	string ind(indent, ' ');

	CAstNode::toDot(out, indent);

	_operand->toDot(out, indent);
	out << ind << dotID() << "->" << _operand->dotID() << ";" << endl;
}

CTacAddr* CAstUnaryOp::ToTac(CCodeBlock *cb)
{
	return NULL;
}

CTacAddr* CAstUnaryOp::ToTac(CCodeBlock *cb,
		CTacLabel *ltrue, CTacLabel *lfalse)
{
	return NULL;
}


//------------------------------------------------------------------------------
// CAstSpecialOp
//
CAstSpecialOp::CAstSpecialOp(CToken t, EOperation oper, CAstExpression *e,
		const CType *type)
: CAstOperation(t, oper), _operand(e), _type(type)
{
	assert((oper == opAddress) || (oper == opDeref) || (oper = opCast));
	assert(e != NULL);
	assert(((oper != opCast) && (type == NULL)) ||
			((oper == opCast) && (type != NULL)));
}

CAstExpression* CAstSpecialOp::GetOperand(void) const
{
	return _operand;
}

bool CAstSpecialOp::TypeCheck(CToken *t, string *msg) const
{

	if (!_operand->TypeCheck(t, msg)) return false;

	EOperation op = GetOperation();

	if (op == opAddress){
	}
	else if (op == opDeref){
	}
	else {
	}
	return true;
}

const CType* CAstSpecialOp::GetType(void) const
{
	EOperation op = GetOperation();

	if (op == opAddress) {
		const CType* type = _operand->GetType();
		return CTypeManager::Get()->GetPointer(type);	// return valid pointer type
	}
	return _operand->GetType();
}

ostream& CAstSpecialOp::print(ostream &out, int indent) const
{
	string ind(indent, ' ');

	out << ind << GetOperation() << " ";

	const CType *t = GetType();
	if (t != NULL) out << t; else out << "<INVALID>";
	out << endl;

	_operand->print(out, indent+2);

	return out;
}

string CAstSpecialOp::dotAttr(void) const
{
	ostringstream out;
	out << " [label=\"" << GetOperation() << "\",shape=box]";
	return out.str();
}

void CAstSpecialOp::toDot(ostream &out, int indent) const
{
	string ind(indent, ' ');

	CAstNode::toDot(out, indent);

	_operand->toDot(out, indent);
	out << ind << dotID() << "->" << _operand->dotID() << ";" << endl;
}

CTacAddr* CAstSpecialOp::ToTac(CCodeBlock *cb)
{
	return NULL;
}


//------------------------------------------------------------------------------
// CAstFunctionCall
//
	CAstFunctionCall::CAstFunctionCall(CToken t, const CSymProc *symbol)
: CAstExpression(t), _symbol(symbol)
{
	assert(symbol != NULL);
}

const CSymProc* CAstFunctionCall::GetSymbol(void) const
{
	return _symbol;
}

void CAstFunctionCall::AddArg(CAstExpression *arg)
{
	_arg.push_back(arg);
}

int CAstFunctionCall::GetNArgs(void) const
{
	return (int)_arg.size();
}

CAstExpression* CAstFunctionCall::GetArg(int index) const
{
	assert((index >= 0) && (index < _arg.size()));
	return _arg[index];
}

bool CAstFunctionCall::TypeCheck(CToken *t, string *msg) const
{

	// Get original declaration of function
	const CSymProc* decl = GetSymbol();

	// if number of arguments are different, error
	if (decl->GetNParams() != GetNArgs()) {
		if (t != NULL) *t = GetToken();
		if (msg != NULL) *msg = decl->GetNParams() < GetNArgs() ? "too many arguments." : "not enough arguments.";
		return false;
	}

	for (int i=0; i<decl->GetNParams(); ++i) {
		const CAstExpression* arg = GetArg(i);

		if (arg != NULL && !arg->TypeCheck(t, msg)) return false;			// Type check argument
		if (!decl->GetParam(i)->GetDataType()->Match(arg->GetType())) {		// Arguement type mismatch
			if (t != NULL) *t = arg->GetToken();
			if (msg != NULL) *msg = "(Function Call) type of arguments mismatched.";
			return false;
		}
	}

	return true;
}

const CType* CAstFunctionCall::GetType(void) const
{
	return GetSymbol()->GetDataType();
}

ostream& CAstFunctionCall::print(ostream &out, int indent) const
{
	string ind(indent, ' ');

	out << ind << "call " << _symbol << " ";
	const CType *t = GetType();
	if (t != NULL) out << t; else out << "<INVALID>";
	out << endl;

	for (size_t i=0; i<_arg.size(); i++) {
		_arg[i]->print(out, indent+2);
	}

	return out;
}

string CAstFunctionCall::dotAttr(void) const
{
	ostringstream out;
	out << " [label=\"call " << _symbol->GetName() << "\",shape=box]";
	return out.str();
}

void CAstFunctionCall::toDot(ostream &out, int indent) const
{
	string ind(indent, ' ');

	CAstNode::toDot(out, indent);

	for (size_t i=0; i<_arg.size(); i++) {
		_arg[i]->toDot(out, indent);
		out << ind << dotID() << "->" << _arg[i]->dotID() << ";" << endl;
	}
}

CTacAddr* CAstFunctionCall::ToTac(CCodeBlock *cb)
{
	return NULL;
}

CTacAddr* CAstFunctionCall::ToTac(CCodeBlock *cb,
		CTacLabel *ltrue, CTacLabel *lfalse)
{
	return NULL;
}



//------------------------------------------------------------------------------
// CAstOperand
//
	CAstOperand::CAstOperand(CToken t)
: CAstExpression(t)
{
}


//------------------------------------------------------------------------------
// CAstDesignator
//
	CAstDesignator::CAstDesignator(CToken t, const CSymbol *symbol)
: CAstOperand(t), _symbol(symbol)
{
	assert(symbol != NULL);
}

const CSymbol* CAstDesignator::GetSymbol(void) const
{
	return _symbol;
}

bool CAstDesignator::TypeCheck(CToken *t, string *msg) const
{


	return true;
}

const CType* CAstDesignator::GetType(void) const
{
	return GetSymbol()->GetDataType();
}

ostream& CAstDesignator::print(ostream &out, int indent) const
{
	string ind(indent, ' ');

	out << ind << _symbol << " ";

	const CType *t = GetType();
	if (t != NULL) out << t; else out << "<INVALID>";

	out << endl;

	return out;
}

string CAstDesignator::dotAttr(void) const
{
	ostringstream out;
	out << " [label=\"" << _symbol->GetName();
	out << "\",shape=ellipse]";
	return out.str();
}

void CAstDesignator::toDot(ostream &out, int indent) const
{
	string ind(indent, ' ');

	CAstNode::toDot(out, indent);
}

CTacAddr* CAstDesignator::ToTac(CCodeBlock *cb)
{
	return NULL;
}

CTacAddr* CAstDesignator::ToTac(CCodeBlock *cb,
		CTacLabel *ltrue, CTacLabel *lfalse)
{
	return NULL;
}


//------------------------------------------------------------------------------
// CAstArrayDesignator
//
	CAstArrayDesignator::CAstArrayDesignator(CToken t, const CSymbol *symbol)
: CAstDesignator(t, symbol), _done(false), _offset(NULL)
{
}

void CAstArrayDesignator::AddIndex(CAstExpression *idx)
{
	assert(!_done);
	_idx.push_back(idx);
}

void CAstArrayDesignator::IndicesComplete(void)
{
	assert(!_done);
	_done = true;
}

int CAstArrayDesignator::GetNIndices(void) const
{
	return (int)_idx.size();
}

CAstExpression* CAstArrayDesignator::GetIndex(int index) const
{
	assert((index >= 0) && (index < _idx.size()));
	return _idx[index];
}

bool CAstArrayDesignator::TypeCheck(CToken *t, string *msg) const
{
	const CType* sm = GetSymbol() -> GetDataType();				// Get Datatype of array from symboltable

	bool result = true;
	Dprintf(("\n[Array::TypeCheck] Start\n"));

	assert(_done);

	const CArrayType* at = NULL;				// Pointer for ArrayType

	if (sm->IsArray())							// If array type
		at = dynamic_cast<const CArrayType*>(sm);
	else if (sm->IsPointer()) {					// If pointer to array type
		at = dynamic_cast<const CArrayType*>(dynamic_cast<const CPointerType*>(sm)->GetBaseType());
	}
	else {										// else error
		if (t != NULL) *t = GetToken();
		if (msg != NULL) *msg = "Not an array type.";
		return false;
	}

	// Check if dimension is overflowed (ex A: intger[2][2], A[1][1][1] := 3 (error))
	if (at->GetNDim() < GetNIndices()) {
		if (t != NULL) *t = GetToken();
		if (msg != NULL) *msg = "dimension is superfluous";
		return false;
	}

	for (int i=0; i<_idx.size(); ++i) {								// Iterate through index expressions
		CAstExpression* e = _idx[i];
		if (!e->TypeCheck(t, msg)) {								// Typecheck index expression
			if (t != NULL) *t = e->GetToken();
			if (msg != NULL) *msg = "invalid expression.";
			return false;
		}
		if (!e->GetType()->Match(CTypeManager::Get()->GetInt())) {	// If index is not integer type, error
			if (t != NULL) *t = e->GetToken();
			if (msg != NULL) *msg = "expected integer expression.";
			return false;
		}
	}

	return result;
}

const CType* CAstArrayDesignator::GetType(void) const
{
	Dprintf(("[Array::GetType] started\n"));

	const CType* t = GetSymbol() -> GetDataType();	// Get Datatype of array from symboltable

	const CArrayType* at;
	if (t->IsArray())							// If array type
		at = dynamic_cast<const CArrayType*>(t);
	else if (t->IsPointer()) {					// If pointer to array type
		at = dynamic_cast<const CArrayType*>(dynamic_cast<const CPointerType*>(t)->GetBaseType());
	}
	else 
		return NULL;

	if (GetNIndices() == at->GetNDim())			// If have exactly same number of indices
		return at->GetBaseType();				// return base type 

	for (int i=0; i<GetNIndices(); ++i) 		// else dereferencing each time
		at = dynamic_cast<const CArrayType*>(at->GetInnerType());

	return at;
}

ostream& CAstArrayDesignator::print(ostream &out, int indent) const
{
	string ind(indent, ' ');

	out << ind << _symbol << " ";

	const CType *t = GetType();
	if (t != NULL) out << t; else out << "<INVALID>";

	out << endl;

	for (size_t i=0; i<_idx.size(); i++) {
		_idx[i]->print(out, indent+2);
	}

	return out;
}

string CAstArrayDesignator::dotAttr(void) const
{
	ostringstream out;
	out << " [label=\"" << _symbol->GetName() << "[]\",shape=ellipse]";
	return out.str();
}

void CAstArrayDesignator::toDot(ostream &out, int indent) const
{
	string ind(indent, ' ');

	CAstNode::toDot(out, indent);

	for (size_t i=0; i<_idx.size(); i++) {
		_idx[i]->toDot(out, indent);
		out << ind << dotID() << "-> " << _idx[i]->dotID() << ";" << endl;
	}
}

CTacAddr* CAstArrayDesignator::ToTac(CCodeBlock *cb)
{
	return NULL;
}

CTacAddr* CAstArrayDesignator::ToTac(CCodeBlock *cb,
		CTacLabel *ltrue, CTacLabel *lfalse)
{
	return NULL;
}


//------------------------------------------------------------------------------
// CAstConstant
//
	CAstConstant::CAstConstant(CToken t, const CType *type, long long value)
: CAstOperand(t), _type(type), _value(value)
{
}

void CAstConstant::SetValue(long long value)
{
	_value = value;
}

long long CAstConstant::GetValue(void) const
{
	return _value;
}

string CAstConstant::GetValueStr(void) const
{
	ostringstream out;

	if (GetType() == CTypeManager::Get()->GetBool()) {
		out << (_value == 0 ? "false" : "true");
	} else {
		out << dec << _value;
	}

	return out.str();
}

bool CAstConstant::TypeCheck(CToken *t, string *msg) const
{

	return true;
}

const CType* CAstConstant::GetType(void) const
{
	return _type;
}

ostream& CAstConstant::print(ostream &out, int indent) const
{
	string ind(indent, ' ');

	out << ind << GetValueStr() << " ";

	const CType *t = GetType();
	if (t != NULL) out << t; else out << "<INVALID>";

	out << endl;

	return out;
}

string CAstConstant::dotAttr(void) const
{
	ostringstream out;
	out << " [label=\"" << GetValueStr() << "\",shape=ellipse]";
	return out.str();
}

CTacAddr* CAstConstant::ToTac(CCodeBlock *cb)
{
	return NULL;
}

CTacAddr* CAstConstant::ToTac(CCodeBlock *cb,
		CTacLabel *ltrue, CTacLabel *lfalse)
{
	return NULL;
}


//------------------------------------------------------------------------------
// CAstStringConstant
//
int CAstStringConstant::_idx = 0;

CAstStringConstant::CAstStringConstant(CToken t, const string value,
		CAstScope *s)
: CAstOperand(t)
{
	CTypeManager *tm = CTypeManager::Get();

	_type = tm->GetArray(strlen(CToken::unescape(value).c_str())+1,
			tm->GetChar());
	_value = new CDataInitString(value);

	ostringstream o;
	o << "_str_" << ++_idx;

	_sym = new CSymGlobal(o.str(), _type);
	_sym->SetData(_value);
	s->GetSymbolTable()->AddSymbol(_sym);
}

const string CAstStringConstant::GetValue(void) const
{
	return _value->GetData();
}

const string CAstStringConstant::GetValueStr(void) const
{
	return GetValue();
}

bool CAstStringConstant::TypeCheck(CToken *t, string *msg) const
{

	return true;
}

const CType* CAstStringConstant::GetType(void) const
{
	return _type;
}

ostream& CAstStringConstant::print(ostream &out, int indent) const
{
	string ind(indent, ' ');

	out << ind << '"' << GetValueStr() << '"' << " ";

	const CType *t = GetType();
	if (t != NULL) out << t; else out << "<INVALID>";

	out << endl;

	return out;
}

string CAstStringConstant::dotAttr(void) const
{
	ostringstream out;
	// the string is already escaped, but dot requires double escaping
	out << " [label=\"\\\"" << CToken::escape(GetValueStr())
		<< "\\\"\",shape=ellipse]";
	return out.str();
}

CTacAddr* CAstStringConstant::ToTac(CCodeBlock *cb)
{
	return NULL;
}

CTacAddr* CAstStringConstant::ToTac(CCodeBlock *cb,
		CTacLabel *ltrue, CTacLabel *lfalse)
{
	return NULL;
}


