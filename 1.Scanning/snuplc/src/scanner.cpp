//------------------------------------------------------------------------------
/// @brief SnuPL/0 scanner
/// @author Bernhard Egger <bernhard@csap.snu.ac.kr>
/// @section changelog Change Log
/// 2012/09/14 Bernhard Egger created
/// 2013/03/07 Bernhard Egger adapted to SnuPL/0
/// 2014/09/10 Bernhard Egger assignment 1: scans SnuPL/-1
/// 2016/03/13 Bernhard Egger assignment 1: adapted to modified SnuPL/-1 syntax
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

#include <iostream>
#include <sstream>
#include <cctype>
#include <cstdlib>
#include <cstring>
#include <cassert>
#include <cstdio>

#include "scanner.h"
using namespace std;

//------------------------------------------------------------------------------
// tken names
//
#define TOKEN_STRLEN 16

char ETokenName[][TOKEN_STRLEN] = {
	"tNumber",                         ///< a digit -> changed to number
	"tIdent",                          ///< a letter -> changed to ident

	"tEOF",                             ///< end of file
	"tIOError",                         ///< I/O error
	"tUndefined",                       ///< undefined

	"tModule",                          ///< keywords
	"tProcedure",
	"tFunction",
	"tVar",
	"tInteger",
	"tBoolean",
	"tChar",
	"tBegin",
	"tEnd",
	"tIf",
	"tThen",
	"tElse",
	"tWhile",
	"tDo",
	"tReturn",
	"tTrue",
	"tFalse",

	"tAssign",                          ///< assignment operator
	"tTermOp",                          ///< '+' or '-' or '||'
	"tFactOp",                          ///< '*' or '/' or '&&'
	"tNot",                             ///< '!'
	"tRelOp",                           ///< relational operator

	"tCharacter",                       ///< a char such as 'a'
	"tString",                          ///< a string such as "Hello"

	"tSemicolon",                       ///< a semicolon
	"tColon",                           ///< a colon
	"tDot",                             ///< a dot
	"tComma",                           ///< a comma
	"tLBrak",                           ///< a left bracket '('
	"tRBrak",                           ///< a right bracket ')'
	"tLLBrak",                          ///< a left square bracket '['
	"tRRBrak",                          ///< a right square bracket ']' 
	/* previous tokens
	 *
	 "tNumber",                         ///< a digit
	 "tIdent",                        ///< a letter
	 "tTermOp",                     ///< '+' or '-'
	 "tFactOp",                        ///< '*' or '/'
	 "tRelOp",                         ///< relational operator
	 "tAssign",                        ///< assignment operator
	 "tSemicolon",                     ///< a semicolon
	 "tDot",                           ///< a dot
	 "tLBrak",                         ///< a left bracket
	 "tRBrak",                         ///< a right bracket

	 "tEOF",                           ///< end of file
	 "tIOError",                       ///< I/O error
	 "tUndefined",                     ///< undefined
	 */
};


//------------------------------------------------------------------------------
// format strings used for printing tokens
//

char ETokenStr[][TOKEN_STRLEN] = {
	"tNumber (%s)",                         ///< a digit -> changed to number
	"tIdent (%s)",                          ///< a letter -> changed to ident

	"tEOF",                             ///< end of file
	"tIOError",                         ///< I/O error
	"tUndefined",                       ///< undefined

	"tModule",                          ///< keywords
	"tProcedure",
	"tFunction",
	"tVar",
	"tInteger",
	"tBoolean",
	"tChar",
	"tBegin",
	"tEnd",
	"tIf",
	"tThen",
	"tElse",
	"tWhile",
	"tDo",
	"tReturn",
	"tTrue",
	"tFalse",

	"tAssign",                          ///< assignment operator
	"tTermOp (%s)",                          ///< '+' or '-' or '||'
	"tFactOp (%s)",                          ///< '*' or '/' or '&&'
	"tNot",                             ///< '!'
	"tRelOp (%s)",                           ///< relational operator

	"tCharacter (%s)",                       ///< a char such as 'a'
	"tString (%s)",                          ///< a string such as "Hello"

	"tSemicolon",                       ///< a semicolon
	"tColon",                           ///< a colon
	"tDot",                             ///< a dot
	"tComma",                           ///< a comma
	"tLBrak",                           ///< a left bracket '('
	"tRBrak",                           ///< a right bracket ')'
	"tLLBrak",                          ///< a left square bracket '['
	"tRRBrak",                          ///< a right square bracket ']' 
	/* previous tokens
	 *
	 "tNumber (%s)",                    ///< a digit
	 "tIdent (%s)",                   ///< a letter
	 "tTermOp (%s)",                ///< '+' or '-'
	 "tFactOp (%s)",                   ///< '*' or '/'
	 "tRelOp (%s)",                    ///< relational operator
	 "tAssign",                        ///< assignment operator
	 "tSemicolon",                     ///< a semicolon
	 "tDot",                           ///< a dot
	 "tLBrak",                         ///< a left bracket
	 "tRBrak",                         ///< a right bracket

	 "tEOF",                           ///< end of file
	 "tIOError",                       ///< I/O error
	 "tUndefined (%s)",                ///< undefined
	 */
};


//------------------------------------------------------------------------------
// reserved keywords
//
/*
 * added reserved keywords
 */
pair<const char*, EToken> Keywords[] =
{
	{"module", tModule}, {"procedure", tProcedure}, {"function", tFunction},
	{"var", tVar}, {"integer", tInteger}, {"boolean", tBoolean}, {"char", tChar},
	{"begin", tBegin}, {"end", tEnd}, {"if", tIf}, {"then", tThen}, {"else", tElse},
	{"while", tWhile}, {"do", tDo}, {"return", tReturn}, {"true", tTrue}, {"false", tFalse}
};



//------------------------------------------------------------------------------
// CToken
//
CToken::CToken()
{
	_type = tUndefined;
	_value = "";
	_line = _char = 0;
}

CToken::CToken(int line, int charpos, EToken type, const string value)
{
	_type = type;
	_value = escape(value);
	_line = line;
	_char = charpos;
}

CToken::CToken(const CToken &token)
{
	_type = token.GetType();
	_value = token.GetValue();
	_line = token.GetLineNumber();
	_char = token.GetCharPosition();
}

CToken::CToken(const CToken *token)
{
	_type = token->GetType();
	_value = token->GetValue();
	_line = token->GetLineNumber();
	_char = token->GetCharPosition();
}

const string CToken::Name(EToken type)
{
	return string(ETokenName[type]);
}

const string CToken::GetName(void) const
{
	return string(ETokenName[GetType()]);
}

ostream& CToken::print(ostream &out) const
{
	int str_len = _value.length();
	str_len = TOKEN_STRLEN + (str_len < 64 ? str_len : 64);
	char *str = (char*)malloc(str_len);
	snprintf(str, str_len, ETokenStr[GetType()], _value.c_str());
	out << dec << _line << ":" << _char << ": " << str;
	free(str);
	return out;
}

string CToken::escape(const string text)
{
	const char *t = text.c_str();
	string s;

	while (*t != '\0') {
		switch (*t) {
			case '\n': s += "\\n";  break;
			case '\t': s += "\\t";  break;
			case '\0': s += "\\0";  break;
			case '\'': s += "\\'";  break;
			case '\"': s += "\\\""; break;
			case '\\': s += "\\\\"; break;
			default :  s += *t;
		}
		t++;
	}

	return s;
}

ostream& operator<<(ostream &out, const CToken &t)
{
	return t.print(out);
}

ostream& operator<<(ostream &out, const CToken *t)
{
	return t->print(out);
}


//------------------------------------------------------------------------------
// CScanner
//
map<string, EToken> CScanner::keywords;

CScanner::CScanner(istream *in)
{
	InitKeywords();
	_in = in;
	_delete_in = false;
	_line = _char = 1;
	_token = NULL;
	_good = in->good();
	NextToken();
}

CScanner::CScanner(string in)
{
	InitKeywords();
	_in = new istringstream(in);
	_delete_in = true;
	_line = _char = 1;
	_token = NULL;
	_good = true;
	NextToken();
}

CScanner::~CScanner()
{
	if (_token != NULL) delete _token;
	if (_delete_in) delete _in;
}

void CScanner::InitKeywords(void)
{
	if (keywords.size() == 0) {
		int size = sizeof(Keywords) / sizeof(Keywords[0]);
		for (int i=0; i<size; i++) {
			keywords[Keywords[i].first] = Keywords[i].second;
		}
	}
}

CToken CScanner::Get()
{
	CToken result(_token);

	EToken type = _token->GetType();
	_good = !(type == tIOError);

	NextToken();
	return result;
}

CToken CScanner::Peek() const
{
	return CToken(_token);
}

void CScanner::NextToken()
{
	if (_token != NULL) delete _token;

	_token = Scan();
}

void CScanner::RecordStreamPosition()
{
	_saved_line = _line;
	_saved_char = _char;
}

void CScanner::GetRecordedStreamPosition(int *lineno, int *charpos)
{
	*lineno = _saved_line;
	*charpos = _saved_char;
}

CToken* CScanner::NewToken(EToken type, const string token)
{
	return new CToken(_saved_line, _saved_char, type, token);
}

CToken* CScanner::Scan()
{
	EToken token;
	string tokval;
	char c;

	while (_in->good() && IsWhite(_in->peek())) GetChar();

	RecordStreamPosition();

	if (_in->eof()) return NewToken(tEOF);
	if (!_in->good()) return NewToken(tIOError);

	c = GetChar();
	tokval = c;
	token = tUndefined;
	/*  if (c == '/') {
		if (_in->peek() == '/') {
		while ((c = GetChar()) != '\n')
		;
		c = GetChar();
		}
		}
	 */  switch (c) {

		 /*
		  * case for Assign, Colon
		  */
		 case ':':
			 if (_in->peek() == '=') {
				 tokval += GetChar();
				 token = tAssign;
			 }
			 else {
				 token = tColon;
			 }
			 break;

			 /*
			  * case for TermOp
			  */
		 case '+':
		 case '-':
			 token = tTermOp;
			 break;

		 case '|':
			 if (_in->peek() == '|') {
				 token = tTermOp;
				 tokval += GetChar();
			 }
			 break;

			 /*
			  * case for FactOp
			  */
		 case '*':
		 case '/':
			 token = tFactOp;
			 break;

		 case '&':
			 if (_in->peek() == '&') {
				 token = tFactOp;
				 tokval += GetChar();
			 }
			 break;

			 /*
			  * case for !
			  */
		 case '!':
			 token = tNot;
			 break;

			 /*
			  * case for RelOp
			  */
		 case '=':
		 case '#':
			 token = tRelOp;
			 break;

		 case '<':
		 case '>':
			 token = tRelOp;
			 if (_in->peek() == '=') {
				 tokval += GetChar();
			 }
			 break;

			 /* 
			  * case for special characters
			  */
		 case ';':
			 token = tSemicolon;
			 break;

		 case ',':
			 token = tComma;
			 break;

		 case '.':
			 token = tDot;
			 break;

		 case '(':
			 token = tLBrak;
			 break;

		 case ')':
			 token = tRBrak;
			 break;

		 case '[':
			 token = tLLBrak;
			 break;

		 case ']':
			 token = tRRBrak;
			 break;

			 /*
			  * case for character
			  */
		 case '\'':
			 if (IsASCII(_in->peek())) {
				 tokval += GetChar();
				 if (_in->peek() == '\'') {
					 tokval += GetChar();
					 token = tCharacter;
				 }
				 break;
			 }
			 if (_in->peek() == '\\') {
				 tokval += GetChar();
				 if (_in->peek() == 'n' || _in->peek() == 't' || _in->peek() == '\"' || _in->peek() == '\'' || _in->peek() == '\\' || _in->peek() == '0' ) {
					 tokval += GetChar();
					 if (_in->peek() == '\'') {
						 tokval += GetChar();
						 token = tCharacter;
					 }
				 }
			 }
			 break;

			 /*
			  * case for string
			  */
		 case '\"':
			 while (_in->good() && _in->peek() != '\"') {
				 tokval += GetChar();
			 }
			 if (_in->peek() == '\"') {
				 tokval += GetChar();
				 token = tString;
			 }
			 break;

		 default:
			 /* 
			  * case for number
			  */
			 if (IsDigit(c)) {
				 token = tNumber;
				 while (IsDigit(_in->peek())) {
					 tokval += GetChar();
				 }
			 }
			 /*
			  * case for ident
			  */
			 else if (IsLetter(c)) {
				 while (IsLetter(_in->peek()) || IsDigit(_in->peek())) { 
					 tokval += GetChar();
				 }
				 map<string, EToken>::iterator it = keywords.find(tokval);
				 if (it != keywords.end()) token = (*it).second;
				 else token = tIdent;

			 } 
			 break;

			 if (token == tUndefined) {
				 tokval = "invalid string '" + tokval + "'";
			 }
	 }

	 return NewToken(token, tokval);
}

char CScanner::GetChar()
{
	char c = _in->get();
	if (c == '\n') { _line++; _char = 1; } else _char++;
	return c;
}

string CScanner::GetChar(int n)
{
	string str;
	for (int i=0; i<n; i++) str += GetChar();
	return str;
}

bool CScanner::IsWhite(char c) const
{
	return ((c == ' ') || (c == '\n'));
}

bool CScanner::IsLetter(char c) const
{
	return ((('A' <= c) && (c <= 'Z')) || (('a' <= c) && (c <= 'z')) || (c == '_'));
}

bool CScanner::IsDigit(char c) const
{
	return (('0' <= c) && (c <= '9'));
}

bool CScanner::IsASCII(char c) const
{
	return IsLetter(c) || IsDigit(c);
}
