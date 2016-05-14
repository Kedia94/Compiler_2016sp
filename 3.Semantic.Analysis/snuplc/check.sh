#!/bin/bash

#test for reference
./3_test_parser mod.mod > ref

#test for our own implementation
./test_parser mod.mod > our

#diff them
diff ref our > diff

#open diff
vim diff
