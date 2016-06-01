module mytest;
var global_bool_a, global_bool_b : boolean;
	global_integer_a, global_integer_b : integer;
	global_bool_c, global_bool_d : boolean;
	global_char_a : char;
	global_intarray_a : integer[10];
	global_chararray_a : char[10];
	global_boolarray_a : boolean[10];

function foo (param_bool_a : boolean;param_char : char ; 
				param_integer : integer; param_intarray_a, param_intarray_b : integer[10]) : boolean;
begin
	param_bool_a := !true;
	param_bool_a := !true;
	param_bool_a := !true;
	param_bool_a := !true;
	param_integer := 1 + param_integer;
	param_bool_a := !true;
	return param_bool_a
end foo;

begin


end mytest.
