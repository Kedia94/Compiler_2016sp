subarray.mod:
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
      <ptr(4) to <array 10 of <bool>>>
      <ptr(4) to <array 10 of <int>>>
      <ptr(4) to <array 2 of <array 10 of <bool>>>>
      <ptr(4) to <bool>>
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
    [ *foo(<ptr(4) to <array 10 of <bool>>>,<int>) --> <NULL>     ]
    [ @i        <int>     ]
    [ $t0       <ptr(4) to <array 10 of <int>>>     ]
    [ $t1       <int>     ]
    [ $t10      <int>     ]
    [ $t11      <int>     ]
    [ $t12      <ptr(4) to <array 2 of <array 10 of <bool>>>>     ]
    [ $t13      <ptr(4) to <array 2 of <array 10 of <bool>>>>     ]
    [ $t14      <int>     ]
    [ $t15      <int>     ]
    [ $t16      <int>     ]
    [ $t17      <int>     ]
    [ $t18      <ptr(4) to <array 2 of <array 10 of <bool>>>>     ]
    [ $t19      <int>     ]
    [ $t2       <ptr(4) to <array 10 of <int>>>     ]
    [ $t20      <int>     ]
    [ $t21      <int>     ]
    [ $t22      <ptr(4) to <bool>>     ]
    [ $t23      <int>     ]
    [ $t24      <ptr(4) to <array 10 of <int>>>     ]
    [ $t25      <int>     ]
    [ $t26      <ptr(4) to <array 10 of <int>>>     ]
    [ $t27      <int>     ]
    [ $t28      <int>     ]
    [ $t29      <int>     ]
    [ $t3       <int>     ]
    [ $t30      <int>     ]
    [ $t31      <ptr(4) to <array 10 of <int>>>     ]
    [ $t32      <int>     ]
    [ $t33      <ptr(4) to <array 10 of <int>>>     ]
    [ $t34      <int>     ]
    [ $t35      <int>     ]
    [ $t36      <int>     ]
    [ $t37      <int>     ]
    [ $t4       <int>     ]
    [ $t5       <int>     ]
    [ $t6       <ptr(4) to <array 10 of <int>>>     ]
    [ $t7       <int>     ]
    [ $t8       <ptr(4) to <array 10 of <int>>>     ]
    [ $t9       <int>     ]
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
     17:     param  1 <- 2
     18:     &()    t13 <- d
     19:     param  0 <- t13
     20:     call   t14 <- DIM
     21:     mul    t15 <- 1, t14
     22:     add    t16 <- t15, 0
     23:     mul    t17 <- t16, 1
     24:     &()    t18 <- d
     25:     param  0 <- t18
     26:     call   t19 <- DOFS
     27:     add    t20 <- t17, t19
     28:     add    t21 <- t12, t20
     29:     &()    t22 <- @t21
     30:     param  0 <- t22
     31:     call   foo
     32:     assign i <- 1
     33: 4_while_cond:
     34:     if     i < 10 goto 5_while_body
     35:     goto   3
     36: 5_while_body:
     37:     sub    t23 <- 10, i
     38:     &()    t24 <- a
     39:     mul    t25 <- i, 4
     40:     &()    t26 <- a
     41:     param  0 <- t26
     42:     call   t27 <- DOFS
     43:     add    t28 <- t25, t27
     44:     add    t29 <- t24, t28
     45:     assign @t29 <- t23
     46:     add    t30 <- i, 1
     47:     assign i <- t30
     48:     goto   4_while_cond
     49: 3:
     50:     assign i <- 0
     51: 11_while_cond:
     52:     if     i < 10 goto 12_while_body
     53:     goto   10
     54: 12_while_body:
     55:     &()    t31 <- a
     56:     mul    t32 <- i, 4
     57:     &()    t33 <- a
     58:     param  0 <- t33
     59:     call   t34 <- DOFS
     60:     add    t35 <- t32, t34
     61:     add    t36 <- t31, t35
     62:     param  0 <- @t36
     63:     call   WriteInt
     64:     add    t37 <- i, 1
     65:     assign i <- t37
     66:     goto   11_while_cond
     67: 10:
  ]]

  [[ procedure: foo
    [[
      [ %aaa      <ptr(4) to <array 10 of <bool>>>       ]
      [ $t0       <int>       ]
      [ $t1       <int>       ]
      [ $t2       <int>       ]
      [ $t3       <int>       ]
      [ $t4       <int>       ]
      [ $t5       <int>       ]
      [ $t6       <int>       ]
      [ $t7       <int>       ]
      [ %x        <int>       ]
    ]]
    [[ foo
        0:     mul    t0 <- 0, 1
        1:     param  0 <- aaa
        2:     call   t1 <- DOFS
        3:     add    t2 <- t0, t1
        4:     add    t3 <- aaa, t2
        5:     assign @t3 <- 1
        6:     mul    t4 <- 0, 1
        7:     param  0 <- aaa
        8:     call   t5 <- DOFS
        9:     add    t6 <- t4, t5
       10:     add    t7 <- aaa, t6
       11:     assign @t7 <- b
    ]]
  ]]
]]
