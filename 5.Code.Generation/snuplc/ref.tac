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
    [ main     <NULL>     ]
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
      [ $t1       <bool>       ]
      [ $t10      <int>       ]
      [ $t11      <int>       ]
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
        5:     if     i > 2 goto 6
        6:     goto   7
        7: 6:
        8:     assign t1 <- 1
        9:     goto   8
       10: 7:
       11:     assign t1 <- 0
       12: 8:
       13:     mul    t2 <- i, 1
       14:     param  0 <- a
       15:     call   t3 <- DOFS
       16:     add    t4 <- t2, t3
       17:     add    t5 <- a, t4
       18:     assign @t5 <- t1
       19:     add    t6 <- i, 1
       20:     assign i <- t6
       21:     goto   2_while_cond
       22: 1:
       23:     assign i <- 0
       24: 13_while_cond:
       25:     if     i < 10 goto 14_while_body
       26:     goto   12
       27: 14_while_body:
       28:     mul    t7 <- i, 1
       29:     param  0 <- a
       30:     call   t8 <- DOFS
       31:     add    t9 <- t7, t8
       32:     add    t10 <- a, t9
       33:     if     @t10 = 1 goto 17_if_true
       34:     goto   18_if_false
       35: 17_if_true:
       36:     param  0 <- 1
       37:     call   WriteInt
       38:     goto   16
       39: 18_if_false:
       40:     param  0 <- 0
       41:     call   WriteInt
       42: 16:
       43:     add    t11 <- i, 1
       44:     assign i <- t11
       45:     goto   13_while_cond
       46: 12:
    ]]
  ]]
]]
