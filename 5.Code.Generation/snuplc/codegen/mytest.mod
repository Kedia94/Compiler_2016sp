module hardcore;

var
i: integer;
I: integer[3][4][1];
b: boolean;
B: boolean[5][6][5];
C: char[7];

function fint(a: integer; B: boolean; C,D,E,F: integer[3][4][1]): integer;
var b: integer;
begin
C[5][D[5][6][7]][4]:=1
//    if ((b # 0) && B)
//    then
//        return -a + C[1][1][1]
//    else
//        if (C[0][a][7] # C[D[a][a][a]][F[C[1][2][3]][5][6]][E[a][a][a]]) // 여기서 멸망!
//        then
//        else
//            return +fint(a - 1, !!!B, C,D,E,F)
//        end
//    end
end fint;


begin
	i := -fint(1, !true, I, I, I, I);
    WriteStr("Hello World!")
end hardcore.
