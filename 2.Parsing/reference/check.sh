#!/bin/bash

#test for reference
./test_parser ../test/parser/char01.mod > ../compare/cc1
./test_parser ../test/parser/char02.mod > ../compare/cc2
./test_parser ../test/parser/char03.mod > ../compare/cc3
./test_parser ../test/parser/char04.mod > ../compare/cc4


./test_parser ../test/parser/array.mod > ../compare/aa
./test_parser ../test/parser/array01.mod > ../compare/aa1
./test_parser ../test/parser/array02.mod > ../compare/aa2
./test_parser ../test/parser/array03.mod > ../compare/aa3
./test_parser ../test/parser/array04.mod > ../compare/aa4
./test_parser ../test/parser/array05.mod > ../compare/aa5
./test_parser ../test/parser/array06.mod > ../compare/aa6
./test_parser ../test/parser/array07.mod > ../compare/aa7


./test_parser ../test/parser/string01.mod > ../compare/ss1
./test_parser ../test/parser/string02.mod > ../compare/ss2

./test_parser ../test/parser/test03.mod > ../compare/tt3
./test_parser ../test/parser/test04.mod > ../compare/tt4
./test_parser ../test/parser/test05.mod > ../compare/tt5
./test_parser ../test/parser/test06.mod > ../compare/tt6

#test for our own implementation
./../snuplc/test_parser ../test/parser/char01.mod > ../compare/c1
./../snuplc/test_parser ../test/parser/char02.mod > ../compare/c2
./../snuplc/test_parser ../test/parser/char03.mod > ../compare/c3
./../snuplc/test_parser ../test/parser/char04.mod > ../compare/c4


./../snuplc/test_parser ../test/parser/array.mod > ../compare/a
./../snuplc/test_parser ../test/parser/array01.mod > ../compare/a1
./../snuplc/test_parser ../test/parser/array02.mod > ../compare/a2
./../snuplc/test_parser ../test/parser/array03.mod > ../compare/a3
./../snuplc/test_parser ../test/parser/array04.mod > ../compare/a4
./../snuplc/test_parser ../test/parser/array05.mod > ../compare/a5
./../snuplc/test_parser ../test/parser/array06.mod > ../compare/a6
./../snuplc/test_parser ../test/parser/array07.mod > ../compare/a7


./../snuplc/test_parser ../test/parser/string01.mod > ../compare/s1
./../snuplc/test_parser ../test/parser/string02.mod > ../compare/s2

./../snuplc/test_parser ../test/parser/test03.mod > ../compare/t3
./../snuplc/test_parser ../test/parser/test04.mod > ../compare/t4
./../snuplc/test_parser ../test/parser/test05.mod > ../compare/t5
./../snuplc/test_parser ../test/parser/test06.mod > ../compare/t6

#diff them
diff ../compare/c1 ../compare/cc1 > ../compare/diff_cc1
diff ../compare/c2 ../compare/cc2 > ../compare/diff_cc2
diff ../compare/c3 ../compare/cc3 > ../compare/diff_cc3
diff ../compare/c4 ../compare/cc4 > ../compare/diff_cc4


diff ../compare/a  ../compare/aa  > ../compare/diff_aa
diff ../compare/a1 ../compare/aa1 > ../compare/diff_aa1
diff ../compare/a2 ../compare/aa2 > ../compare/diff_aa2
diff ../compare/a3 ../compare/aa3 > ../compare/diff_aa3
diff ../compare/a4 ../compare/aa4 > ../compare/diff_aa4
diff ../compare/a5 ../compare/aa5 > ../compare/diff_aa5
diff ../compare/a6 ../compare/aa6 > ../compare/diff_aa6
diff ../compare/a7 ../compare/aa7 > ../compare/diff_aa7


diff ../compare/s1 ../compare/ss1 > ../compare/diff_ss1
diff ../compare/s2 ../compare/ss2 > ../compare/diff_ss2

diff ../compare/t3 ../compare/tt3 > ../compare/diff_tt3
diff ../compare/t4 ../compare/tt4 > ../compare/diff_tt4
diff ../compare/t5 ../compare/tt5 > ../compare/diff_tt5
diff ../compare/t6 ../compare/tt6 > ../compare/diff_tt6
