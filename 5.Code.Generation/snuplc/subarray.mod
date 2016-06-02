//
// test02
//
// computations with integers arrays
// also test alignment of global data
//
// expected output: 1987654321 (no newline)
//

module test02;

var a : integer[10];
    b : boolean;
    c : boolean[2];
	d : boolean[2][10];
    i : integer;

procedure foo(aaa : boolean[10]; x : integer);
begin
	aaa[0] := true;
	aaa[0] := b
end foo;

begin
  a[0] := 1;

  foo(d[1], a[0]);
  i := 1;
  while (i < 10) do
    a[i] := 10-i;
    i := i+1
  end;

  i := 0;
  while (i < 10) do
    WriteInt(a[i]);
    i := i+1
  end
end test02.
