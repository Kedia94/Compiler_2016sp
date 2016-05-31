test03.mod:
[[ module: test03
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
    array types:
      <array of <char>>
  ]]
  [[
    [ *DIM(<ptr(4) to <NULL>>,<int>) --> <int>     ]
    [ *DOFS(<ptr(4) to <NULL>>) --> <int>     ]
    [ *ReadInt() --> <int>     ]
    [ *WriteChar(<char>) --> <NULL>     ]
    [ *WriteInt(<int>) --> <NULL>     ]
    [ *WriteLn() --> <NULL>     ]
    [ *WriteStr(<ptr(4) to <array of <char>>>) --> <NULL>     ]
    [ @a        <bool>     ]
    [ @b        <bool>     ]
    [ @b1       <int>     ]
    [ @c        <bool>     ]
    [ main     <NULL>     ]
    [ $t0       <bool>     ]
    [ $t1       <bool>     ]
    [ $t2       <bool>     ]
  ]]
  [[ test03
      0:     assign a <- 1
      1:     assign b <- 0
      2:     if     a = 1 goto 6
      3:     goto   4
      4: 6:
      5:     if     b = 1 goto 3
      6:     goto   4
      7: 3:
      8:     assign t0 <- 1
      9:     goto   5
     10: 4:
     11:     assign t0 <- 0
     12: 5:
     13:     assign c <- t0
     14:     if     c = 1 goto 8_if_true
     15:     goto   9_if_false
     16: 8_if_true:
     17:     param  0 <- 1
     18:     call   WriteInt
     19:     goto   7
     20: 9_if_false:
     21:     param  0 <- 0
     22:     call   WriteInt
     23: 7:
     24:     if     a = 1 goto 13
     25:     if     b = 1 goto 13
     26:     goto   14
     27: 13:
     28:     assign t1 <- 1
     29:     goto   15
     30: 14:
     31:     assign t1 <- 0
     32: 15:
     33:     assign c <- t1
     34:     if     c = 1 goto 18_if_true
     35:     goto   19_if_false
     36: 18_if_true:
     37:     param  0 <- 1
     38:     call   WriteInt
     39:     goto   17
     40: 19_if_false:
     41:     param  0 <- 0
     42:     call   WriteInt
     43: 17:
     44:     if     a = 1 goto 24
     45:     if     b = 1 goto 24
     46:     assign t2 <- 1
     47:     goto   25
     48: 24:
     49:     assign t2 <- 0
     50: 25:
     51:     assign c <- t2
     52:     if     c = 1 goto 28_if_true
     53:     goto   29_if_false
     54: 28_if_true:
     55:     param  0 <- 1
     56:     call   WriteInt
     57:     goto   27
     58: 29_if_false:
     59:     param  0 <- 0
     60:     call   WriteInt
     61: 27:
  ]]
]]
