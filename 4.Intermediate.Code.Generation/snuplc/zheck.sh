#!/usr/bin/env bash
rm -f my ta
find $1 -maxdepth 1 -name "*.mod" -print0 | xargs -L1 -0 -I{} -- sh -c "./test_ir {} >> my"
find $1 -maxdepth 1 -name "*.mod" -print0 | xargs -L1 -0 -I{} -- sh -c "../reference/4_test_ir {} >> ta"
vimdiff my ta
