module arraylength_notnumber;

var X, Y: integer;
a,b,c,d: integer[3][4];

procedure add(A,B,C: integer[][]);
var i,j: integer;
begin
  i := 0;
  while (i < X) do
    j := 0;
    while (j < Y) do
      C[i][j] := A[i][j] + B[i][j]
    end
  end
end add;

begin
  add(a,b,a)
end arraylength_notnumber.
