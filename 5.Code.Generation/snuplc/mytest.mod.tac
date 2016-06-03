mytest.mod:
[[ module: test06
  [[ type manager
    base types:
      <NULL>
      <int>
      <char>
      <bool>
      <ptr(4) to <NULL>>
    pointer types:
      <ptr(4) to <NULL>>
      <ptr(4) to <array of <char>>>
      <ptr(4) to <array of <bool>>>
      <ptr(4) to <array 10 of <bool>>>
    array types:
      <array of <char>>
      <array 10 of <bool>>
      <array of <bool>>
  ]]
  [[
    [ *DIM(<ptr(4) to <NULL>>,<int>) --> <int>     ]
    [ *DOFS(<ptr(4) to <NULL>>) --> <int>     ]
    [ *ReadInt() --> <int>     ]
    [ *WriteChar(<char>) --> <NULL>     ]
    [ *WriteInt(<int>) --> <NULL>     ]
    [ *WriteLn() --> <NULL>     ]
    [ *WriteStr(<ptr(4) to <array of <char>>>) --> <NULL>     ]
    [ @a        <array 10 of <bool>>     ]
    [ $t0       <ptr(4) to <array 10 of <bool>>>     ]
    [ *test(<ptr(4) to <array of <bool>>>) --> <NULL>     ]
  ]]
  [[ test06
      0:     &()    t0 <- a
      1:     param  0 <- t0
      2:     call   test
  ]]

  [[ procedure: test
    [[
      [ %a        <ptr(4) to <array of <bool>>>       ]
      [ $i        <int>       ]
      [ $t0       <bool>       ]
      [ $t1       <int>       ]
      [ $t10      <int>       ]
      [ $t2       <int>       ]
      [ $t3       <int>       ]
      [ $t4       <int>       ]
      [ $t5       <int>       ]
      [ $t6       <int>       ]
      [ $t7       <int>       ]
      [ $t8       <int>       ]
      [ $t9       <int>       ]
    ]]
    [[ test
        0:     assign i <- 0
        1: 2_while_cond:
        2:     if     i < 10 goto 3_while_body
        3:     goto   1
        4: 3_while_body:
        5:     if     i > 2 goto 7
        6:     goto   8
        7: 7:
        8:     assign t0 <- 1
        9:     goto   9
       10: 8:
       11:     assign t0 <- 0
       12: 9:
       13:     mul    t1 <- i, 1
       14:     param  0 <- a
       15:     call   t2 <- DOFS
       16:     add    t3 <- t1, t2
       17:     add    t4 <- a, t3
       18:     assign @t4 <- t0
       19:     add    t5 <- i, 1
       20:     assign i <- t5
       21:     goto   2_while_cond
       22: 1:
       23:     assign i <- 0
       24: 14_while_cond:
       25:     if     i < 10 goto 15_while_body
       26:     goto   13
       27: 15_while_body:
       28:     mul    t6 <- i, 1
       29:     param  0 <- a
       30:     call   t7 <- DOFS
       31:     add    t8 <- t6, t7
       32:     add    t9 <- a, t8
       33:     if     @t9 = 1 goto 18_if_true
       34:     goto   19_if_false
       35: 18_if_true:
       36:     param  0 <- 1
       37:     call   WriteInt
       38:     goto   17
       39: 19_if_false:
       40:     param  0 <- 0
       41:     call   WriteInt
       42: 17:
       43:     add    t10 <- i, 1
       44:     assign i <- t10
       45:     goto   14_while_cond
       46: 13:
    ]]
  ]]
]]
