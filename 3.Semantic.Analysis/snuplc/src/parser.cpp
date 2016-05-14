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
			printf("(Debug) Start check\n");
//			if (!_module->TypeCheck(&t, &msg)) SetError(t, msg);
			printf("(Debug) End check\n");
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

	// Pointers for assignmest;
	CToken dummy, t1, t2;
	CAstModule *m;
	CAstStatement *stat = NULL;
	CAstProcedure *routine = NULL;

	// Consumes keywords
	Consume(tModule);
	Consume(tIdent, &t1);
	Consume(tSemicolon);

	// make new module by its name and init symbol table
	m = new CAstModule(t1, t1.GetValue());
	InitSymbolTable(m->GetSymbolTable());

	// get value declarations
	vardeclaration(m);

	// if next token is not a tBegin, it means we have subroutineDecl
	while (_scanner->Peek().GetType() != tBegin) {
		routine = subroutinedecl(m);
	}

	// Consumes keywords
	Consume(tBegin);

	// get statSequence 
	stat = statSequence(m);
	m->SetStatementSequence(stat);

	// Consuems keywords
	Consume(tEnd);
	Consume(tIdent, &t2);
	Consume(tDot);

	// If modules name doesn't match, report error
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

	CAstStatement *head = NULL;
	CSymtab *table = s->GetSymbolTable();		// get symbol table

	EToken tt = _scanner->Peek().GetType();		// peek next token
	if (!(tt == tEnd || tt == tElse)) {			// while current token isn't included in FOLLOW	
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

				case tIdent:	
					// if tIdent's value type is procedure it is subroutinecall
					if (table->FindSymbol(_scanner->Peek().GetValue()) == NULL) 
						SetError(_scanner->Peek(), "No such symbol");
					else if (table->FindSymbol(_scanner->Peek().GetValue())->GetSymbolType() == stProcedure) {
						st = subroutinecall(s);
					}
					// else it is assignment
					else {
						st = assignment(s);
					}

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

			if (head == NULL)			// if it is first time
				head = st;				// make new statment
			else 
				tail->SetNext(st);		// else append to next

			tail = st;					

			tt = _scanner->Peek().GetType();
			if (tt == tEnd || tt == tElse) break;

			Consume(tSemicolon);		
		} while (!_abort);
	}

	return head;						
}

CAstStatAssign* CParser::assignment(CAstScope *s)
{
	/* 
	 *  assignment = qualident ":=" expression.
	 *  FIRST = {tIdnet}
	 */
	CToken t;

	CAstDesignator *lhs = qualident(s);		// qualident
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
	if (_scanner->Peek().GetType() == tRelOp) {				// if it has [ relOp simpleexpression ]
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
	else {													// it has no [ relOp simpleexpression ] part
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
	  bool pos = true;
		Consume(tTermOp, &topt);							// consume operator
		if (topt.GetValue() == "-") pos = false;
                else if (topt.GetValue() == "||") SetError(topt, "Invalid unary operator");
                
                if (_scanner->Peek().GetType() == tNumber)
                  n = number(pos);
                else {
                  n = term(s);
                  if (pos) n = new CAstUnaryOp(topt, opPos, n);
                  else n = new CAstUnaryOp(topt, opNeg, n);
                }

        }


        else {
          n = term(s);
        }



	while (_scanner->Peek().GetType() == tTermOp) {			// { termOp term } parts
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

		// Consumes keywords
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

CAstConstant* CParser::character()
{
	CToken t;
	long long v;

	// Consumes keywords
	Consume (tCharacter, &t);

	// Exception handling when '\0' entered
	if (t.GetValue().size() == 0)
		return new CAstConstant (t, CTypeManager::Get()->GetChar(), '\0');

	// Else escape
	if (t.GetValue().at(0) == '\\') {
		switch (t.GetValue().at(1)) {
			case 'n':
				v = '\n';
				break;

			case 't':
				v = '\t';
				break;

			case '\"':
				v = '\"';
				break;

			case '\'':
				v = '\'';
				break;

			case '\\':
				v = '\\';
				break;

			default:
				SetError(t, "Undefined character token");
		}
	}
	// If not an escape character, just append
	else
		v = t.GetValue().at(0);

	return new CAstConstant (t, CTypeManager::Get()->GetChar(), v);
}

CAstExpression* CParser::factor(CAstScope *s)
{
	/* 
	 * factor = qualident | number | boolean | char | string | "(" expression ")" | subroutineCall | "!" factor.
	 */


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
			if (symbol == NULL) {								// Error handling
				SetError(t, "No symbol \'" + _scanner->Peek().GetValue() + "\'");
			}
			else {
				if (symbol->GetSymbolType() == stProcedure) {	// if it's subroutinecall
					call = subroutinecall(s);		
					n = call->GetCall();
				}
				else {											// else it's qualident
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
			n = character(); 
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

CAstConstant* CParser::number(bool pos)
{
	//
	// number ::= digit { digit }.
	// "digit { digit }" is scanned as one token (tNumber)
	//

	CToken t;

	// Consumes a keyword
	Consume(tNumber, &t);

	// Convert string number to long long type
	errno = 0;
	long long v = strtoll(t.GetValue().c_str(), NULL, 10);
	if (!pos) v = -v;
	if (v < INT_MIN) SetError(t, "smaller than min int");
        else if (v > INT_MAX) SetError(t, "bigger than max int");
	if (errno != 0) SetError(t, "invalid number.");

	return new CAstConstant(t, CTypeManager::Get()->GetInt(), v);
}

CAstConstant* CParser::boolean(void)
{
	//
	// boolean = "true" | "false"
	//

	CToken t;

	// We devided Boolean value into two tokens, so cover both cases
	if (_scanner->Peek().GetType() == tTrue){
		Consume(tTrue, &t);
		return new CAstConstant(t, CTypeManager::Get()->GetBool(), true);
	}
	else {
		Consume(tFalse, &t);
		return new CAstConstant(t, CTypeManager::Get()->GetBool(), false);
	}
}

CAstArrayDesignator* CParser::qualident(CAstScope *s)
{
	//
	// qualident ::= ident { "[" expression "]" }.
	//
	// 

	CAstArrayDesignator *n = NULL;
	CAstExpression *ex = NULL;
	const CSymbol *symbol = NULL;
	CToken t;
	int i = 0;

	Consume(tIdent, &t);									// Consume ident part

	symbol = s->GetSymbolTable()->FindSymbol(t.GetValue());	// find symbol for ident
	if (symbol == NULL) 
		SetError(t, "no such variable");

	if (_scanner->Peek().GetType() != tLLBrak) {
		return (CAstArrayDesignator *) new CAstDesignator(t, symbol);	// if just ident return 
	}

	n = new CAstArrayDesignator(t, symbol);				// else make new ArrayDesignator
	while (_scanner->Peek().GetType() == tLLBrak) {		// repeatedly consume "["
		Consume(tLLBrak);								// consume "["
		ex = expression(s);								// expresssion part
		Consume(tRRBrak);								// consume "]"
		n->AddIndex(ex);								// set index
	}

	n->IndicesComplete();								// Complete indicies

	return n; 

}

CAstType* CParser::type(CAstScope *s, bool declare, bool pointer)
{
	//
	// type = basetype | type "[" [ number ] "]".
	//
	// basetype = "boolean" | "char" | "integer"
	// token: tBoolean, tChar, tInteger
	//

	CTypeManager *tm = CTypeManager::Get();
	CAstType *n = NULL;
	const CType *type;
	CToken t;

	EToken tt = _scanner->Peek().GetType();	// peek one token


	// Get the first part of type, it should be included in these three cases
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

	if (_scanner->Peek().GetType() != tLLBrak) {		// check if it has additionarl array parts
		return new CAstType(t, type);
	}

	vector<CAstConstant*> vec;
	// type ::= type "[" [ number ] "]" -> array
	while (_scanner->Peek().GetType() == tLLBrak) {		// repeatedly consumes "["
		Consume(tLLBrak);

		CAstConstant *k;
		if (_scanner->Peek().GetType() == tNumber) {
			vec.push_back(number());					// get number
		}
		else {
		  if (declare){
		    Consume(tRRBrak, &t);
		    SetError(t, "expected \'tNumber\', got \'tRRBrak\'");
                  }
			vec.push_back(NULL);						// mark
		}

		Consume(tRRBrak);

	}

	for (int i=vec.size()-1; i>=0; --i) {
		if (vec[i] == NULL || pointer)
			type = tm->GetArray(-1, type);						
		else
			type = tm->GetArray(vec[i]->GetValue(), type);	
	}

	if (pointer) {									// if it requested for pointer type
		type = tm->GetPointer(type);					// get the pointer typed
	}

	n = new CAstType(t, type);
	return n;
}

CAstStatCall* CParser::subroutinecall(CAstScope *s)
{
	//
	// subroutinecall = ident "(" [ expression { "," expression } ] ")".
	//

	CAstFunctionCall *funccall = NULL;
	CAstDesignator *identifier = NULL;
	CAstExpression *l, *r = NULL;
	CAstStatement *n = NULL;
	CToken t;

	identifier = qualident(s);							// consumes ident

	// make new functionCall ast by ident
	funccall = new CAstFunctionCall(identifier->GetToken(), (CSymProc *)identifier->GetSymbol());

	Consume(tLBrak);									// consumes "("
	if (_scanner->Peek().GetType() != tRBrak) {			// while it is not a void type
		l = expression(s);								// expression part
		if (l->GetType()->IsArray()){
		l = new CAstSpecialOp(l->GetToken(), opAddress, l);
                }
		funccall->AddArg(l);							// add expression as argument
		while (_scanner->Peek().GetType() == tComma) {	// repeatedly scans for arguments
			Consume(tComma);
			l = expression(s);

			if (l->GetType()->IsArray()){
			  l = new CAstSpecialOp(l->GetToken(), opAddress, l);
                        }
			funccall->AddArg(l);
		}
	}

	Consume(tRBrak);									// consumes ")"
	return new CAstStatCall(t, funccall);
}

CAstStatement* CParser::ifstatement(CAstScope *s)
{
	//
	// ifstatement = "if" "(" expression ")" "then" statsquence [ "else" statsequence ] "end".
	//
	CAstStatement *m, *r = NULL;
	CAstStatement *n = NULL;
	CAstExpression *l;
	CToken t;

	Consume(tIf, &t);			// consumes if

	Consume(tLBrak);			// consumes "("
	l = expression(s);			// expression part
	Consume(tRBrak);			// consumes ")"

	Consume(tThen);				// consumes "then"
	m = statSequence(s);		// statsequence part

	if (_scanner->Peek().GetType() == tElse) {	
		Consume(tElse);			// consumes "else"
		r = statSequence(s);	// statsequence part
	}
	Consume(tEnd);				// consumes "end"

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

	Consume(tWhile, &t);		// consuems while

	Consume(tLBrak);			// consuems "("
	l = expression(s);			// expression part
	Consume(tRBrak);			// consuems ")"

	Consume(tDo);				// consumes "do"
	r = statSequence(s);		// statsequence part
	Consume(tEnd);				// consuems "end"

	n = new CAstStatWhile(t, l, r);
	return n;
}

CAstStatement* CParser::returnstatement(CAstScope *s)
{
	//
	// returnstatement = "return" [ expression ].
	//

	CAstExpression *child = NULL;
	CAstStatement *n = NULL;
	CToken t;

	Consume(tReturn, &t);								// consuems return

	switch (_scanner->Peek().GetType()) {
		// FOLLOW(returnstatement) = "end" | ";" | "else"
		// returnstatement ::= "return"
		case tSemicolon:								// if it has FOLLOW
		case tElse:
		case tEnd:
			n = new CAstStatReturn(t, s, child);		// then it doesn't have return value
			break;

			// returnstatement ::= "return" expression 
		default:
			child = expression(s);						// else it has return value
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
	// 
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

	Consume(tIdent, &t);		// consumes ident
	vec.push_back(t);			// append it

	// repeatedly gets for ident
	while (_scanner->Peek().GetType() == tComma) { 
		Consume(tComma);		// consumes comma
		Consume(tIdent, &t);	// conusmes ident
		vec.push_back(t);		// append it
	}

	Consume(tColon);			// consuems colon
	typ = type(s, true);				// type part

	int size = vec.size();
	for (int i=0;i<size; i++) {
		symbol = s->CreateVar(vec[i].GetValue(), typ->GetType());
		// if trying to re-defining existing variable
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
	while(_scanner->Peek().GetType() == tSemicolon) {	// repeatedly consume Semicolons
		Consume(tSemicolon);							// consumes semicolon
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

	// Pointers for assignments
	CToken t, tname, tendname, tval;
	CSymtab *table = s->GetSymbolTable();
	CAstProcedure *n = NULL;
	CAstType *typ = NULL;
	CSymProc *sym = NULL;
	vector<CSymParam *> v;
	vector<CToken> vec;
	int index=0, size;

	if (_scanner->Peek().GetType() == tProcedure) {		// if it is proceduredecl
		Consume(tProcedure, &t);
	}
	else if (_scanner->Peek().GetType() == tFunction) {	// if it is functiondecl
		Consume(tFunction, &t);
	}
	else {												// else raise error
		SetError(_scanner->Peek(), "\"procedure\" or \"function\" expected.");
	}

	Consume(tIdent, &tname);	// consumes ident

	// formalparam
	if (_scanner->Peek().GetType() == tLBrak) {
		// Consumes keywords
		Consume(tLBrak);

		// Untill we find right bracket
		if (_scanner->Peek().GetType() != tRBrak) {
			Consume(tIdent, &tval);							// Consumes keywords
			vec.push_back(tval);							// Put in vector 
			while (_scanner->Peek().GetType() == tComma) {	// if it has other ident, consumes it
				Consume(tComma);
				Consume(tIdent, &tval);
				vec.push_back(tval);
			}
			Consume(tColon);								// Consuems colon 
			typ = type(s, false, true);
			size = vec.size();

			for (int i=0; i<size; i++) {					// Iterate vector and append its elements to another vector
				v.push_back(new CSymParam(index, vec[i].GetValue(), typ->GetType()));
				index++;
			}

			while (_scanner->Peek().GetType() == tSemicolon) {
				vec.clear();								// Repeatedly do the same job while nextType is ";"
				Consume(tSemicolon);						// Consumes keywords
				Consume(tIdent, &tval);
				vec.push_back(tval);
				while (_scanner->Peek().GetType() == tComma) {
					Consume(tComma);						// Consuems keywords
					Consume(tIdent, &tval);
					vec.push_back(tval);
				}
				Consume(tColon);							// Consumes keywords
				typ = type(s, false);
				size = vec.size();

				for (int i=0; i<size; i++) {				// Iterate vector and append its elements to another vector
					v.push_back(new CSymParam(index, vec[i].GetValue(), typ->GetType()));
					index++;
				}
			}
		}
		Consume(tRBrak);									// Finally consumes right bracket
	}

	if (t.GetType() == tFunction) {		// if it is functiondecl
		Consume(tColon);				// consuems colon
		typ = type(s, false);
		sym = new CSymProc(tname.GetValue(), typ->GetType());
	}
	else {								// if it is proceduredecl
		sym = new CSymProc(tname.GetValue(), CTypeManager::Get()->GetNull());
	}		
	Consume(tSemicolon);				// consuems semicolon

	size = v.size();
	for (int i=0;i<size;i++) {			// add all parameters to the symbol tree
		sym->AddParam(v[i]);
	}

	n = new CAstProcedure(t, tname.GetValue(), s, sym);
	table->AddSymbol(sym);
	table = n->GetSymbolTable();		// add all parameters to the symbol tree
	for (int i=0;i<size;i++) {
		table->AddSymbol(v[i]);
	}

	// subroutinebody

	subroutinebody(n);
	Consume(tIdent, &tendname);
	Consume(tSemicolon);

	// different ident error handling
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

	vardeclaration(s);			// varDeclaration part
	Consume(tBegin);			// consumes begin
	if (_scanner->Peek().GetType() != tEnd)
		stat = statSequence(s);	// statSequence exists

	Consume(tEnd);				// consuems end

	s->SetStatementSequence(stat);
	return n;
}

