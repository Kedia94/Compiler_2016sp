module hardcore;

var
i: integer;
I: integer[3][4][1];
b: boolean;
B: boolean[5][6][5];
C: char[7];

function fint(a: integer; B: boolean; C: integer[3][4][1]): integer;
var b: integer;
begin
    if ((b # 0) && B)
    then
        return -a + C[1][1][1]
    else
        if (C[0][a][7] # C[C[a][a][a]][0][C[a][a][a]]) // 여기서 멸망!
        then
        else
            return +fint(a - 1, !!!B, C)
        end
    end
end fint;


begin
    WriteStr("Hello World!")
end hardcore.
