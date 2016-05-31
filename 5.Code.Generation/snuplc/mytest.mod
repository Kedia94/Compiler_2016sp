module mytest;
var A : integer;
	B : boolean;

function foo (a : integer) : integer;
var aa : integer;
	bb : boolean;
begin
	aa := A + 1;
	bb := a > aa;
	return aa
end foo;

begin
	B := B || B;	
B := B && B;
	foo(A)
end mytest.
