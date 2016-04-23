//
// char declaration and definitions
//
// does not require array or string support
//

module char01;

var c: char;

begin
  c := '1';
  c := '\0';
  WriteChar(c);
  WriteChar('!');
  WriteLn()
end char01.
