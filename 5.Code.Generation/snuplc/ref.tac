mytest.mod:
[[ module: test02
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
      <ptr(4) to <array 2 of <array 10 of <bool>>>>
      <ptr(4) to <array 10 of <int>>>
    array types:
      <array of <char>>
      <array 10 of <int>>
      <array 2 of <bool>>
      <array 10 of <bool>>
      <array 2 of <array 10 of <bool>>>
  ]]
  [[
    [ *DIM(<ptr(4) to <NULL>>,<int>) --> <int>     ]
    [ *DOFS(<ptr(4) to <NULL>>) --> <int>     ]
    [ *ReadInt() --> <int>     ]
    [ *WriteChar(<char>) --> <NULL>     ]
    [ *WriteInt(<int>) --> <NULL>     ]
    [ *WriteLn() --> <NULL>     ]
    [ *WriteStr(<ptr(4) to <array of <char>>>) --> <NULL>     ]
    [ @a        <array 10 of <int>>     ]
    [ @b        <bool>     ]
    [ @c        <array 2 of <bool>>     ]
    [ @d        <array 2 of <array 10 of <bool>>>     ]
    [ *foo(<ptr(4) to <array 2 of <array 10 of <bool>>>>,<int>) --> <NULL>     ]
    [ @i        <int>     ]
    [ $t0       <ptr(4) to <array 10 of <int>>>     ]
    [ $t1       <int>     ]
    [ $t10      <int>     ]
    [ $t11      <int>     ]
    [ $t12      <ptr(4) to <array 2 of <array 10 of <bool>>>>     ]
    [ $t13      <int>     ]
    [ $t14      <ptr(4) to <array 10 of <int>>>     ]
    [ $t15      <int>     ]
    [ $t16      <ptr(4) to <array 10 of <int>>>     ]
    [ $t17      <int>     ]
    [ $t18      <int>     ]
    [ $t19      <int>     ]
    [ $t2       <ptr(4) to <array 10 of <int>>>     ]
    [ $t20      <int>     ]
    [ $t21      <ptr(4) to <array 10 of <int>>>     ]
    [ $t22      <int>     ]
    [ $t23      <ptr(4) to <array 10 of <int>>>     ]
    [ $t24      <int>     ]
    [ $t25      <int>     ]
    [ $t26      <int>     ]
    [ $t27      <int>     ]
    [ $t3       <int>     ]
    [ $t4       <int>     ]
    [ $t5       <int>     ]
    [ $t6       <ptr(4) to <array 10 of <int>>>     ]
    [ $t7       <int>     ]
    [ $t8       <ptr(4) to <array 10 of <int>>>     ]
    [ $t9       <int>     ]
    [ @x        <char>     ]
  ]]
  [[ test02
      0:     &()    t0 <- a
      1:     mul    t1 <- 0, 4
      2:     &()    t2 <- a
      3:     param  0 <- t2
      4:     call   t3 <- DOFS
      5:     add    t4 <- t1, t3
      6:     add    t5 <- t0, t4
      7:     assign @t5 <- 1
      8:     &()    t6 <- a
      9:     mul    t7 <- 0, 4
     10:     &()    t8 <- a
     11:     param  0 <- t8
     12:     call   t9 <- DOFS
     13:     add    t10 <- t7, t9
     14:     add    t11 <- t6, t10
     15:     param  1 <- @t11
     16:     &()    t12 <- d
     17:     param  0 <- t12
     18:     call   foo
     19:     assign i <- 1
     20: 4_while_cond:
     21:     if     i < 10 goto 5_while_body
     22:     goto   3
     23: 5_while_body:
     24:     sub    t13 <- 10, i
     25:     &()    t14 <- a
     26:     mul    t15 <- i, 4
     27:     &()    t16 <- a
     28:     param  0 <- t16
     29:     call   t17 <- DOFS
     30:     add    t18 <- t15, t17
     31:     add    t19 <- t14, t18
     32:     assign @t19 <- t13
     33:     add    t20 <- i, 1
     34:     assign i <- t20
     35:     goto   4_while_cond
     36: 3:
     37:     assign x <- 97
     38:     assign i <- 0
     39: 12_while_cond:
     40:     if     i < 10 goto 13_while_body
     41:     goto   11
     42: 13_while_body:
     43:     &()    t21 <- a
     44:     mul    t22 <- i, 4
     45:     &()    t23 <- a
     46:     param  0 <- t23
     47:     call   t24 <- DOFS
     48:     add    t25 <- t22, t24
     49:     add    t26 <- t21, t25
     50:     param  0 <- @t26
     51:     call   WriteInt
     52:     add    t27 <- i, 1
     53:     assign i <- t27
     54:     goto   12_while_cond
     55: 11:
  ]]

  [[ procedure: foo
    [[
      [ %aaa      <ptr(4) to <array 2 of <array 10 of <bool>>>>       ]
      [ $t0       <int>       ]
      [ $t1       <int>       ]
      [ $t10      <int>       ]
      [ $t11      <int>       ]
      [ $t12      <int>       ]
      [ $t13      <int>       ]
      [ $t2       <int>       ]
      [ $t3       <int>       ]
      [ $t4       <int>       ]
      [ $t5       <int>       ]
      [ $t6       <int>       ]
      [ $t7       <int>       ]
      [ $t8       <int>       ]
      [ $t9       <int>       ]
      [ %x        <int>       ]
    ]]
    [[ foo
        0:     param  1 <- 2
        1:     param  0 <- aaa
        2:     call   t0 <- DIM
        3:     mul    t1 <- 0, t0
        4:     add    t2 <- t1, 0
        5:     mul    t3 <- t2, 1
        6:     param  0 <- aaa
        7:     call   t4 <- DOFS
        8:     add    t5 <- t3, t4
        9:     add    t6 <- aaa, t5
       10:     assign @t6 <- 1
       11:     param  1 <- 2
       12:     param  0 <- aaa
       13:     call   t7 <- DIM
       14:     mul    t8 <- 0, t7
       15:     add    t9 <- t8, 0
       16:     mul    t10 <- t9, 1
       17:     param  0 <- aaa
       18:     call   t11 <- DOFS
       19:     add    t12 <- t10, t11
       20:     add    t13 <- aaa, t12
       21:     assign @t13 <- b
    ]]
  ]]
]]
