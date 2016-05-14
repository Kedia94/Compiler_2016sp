//
// strings
//

module string02;

var age, year: integer;
    a, b: char[20];

begin
  a := "hello";
  b := a;
  WriteStr("Enter your age: "); age := ReadInt();
  WriteStr(a); year := ReadInt();

  WriteStr("You will be 100 years old in the year ");
  WriteInt(year + 100 - age);
  WriteStr(".\n")
end string02.
