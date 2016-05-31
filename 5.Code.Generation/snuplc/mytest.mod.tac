mytest.mod:
[[ module: mytest
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
    [ @A        <int>     ]
    [ @B        <bool>     ]
    [ *DIM(<ptr(4) to <NULL>>,<int>) --> <int>     ]
    [ *DOFS(<ptr(4) to <NULL>>) --> <int>     ]
    [ *ReadInt() --> <int>     ]
    [ *WriteChar(<char>) --> <NULL>     ]
    [ *WriteInt(<int>) --> <NULL>     ]
    [ *WriteLn() --> <NULL>     ]
    [ *WriteStr(<ptr(4) to <array of <char>>>) --> <NULL>     ]
    [ *foo(<int>) --> <int>     ]
    [ $t0       <int>     ]
  ]]
  [[ mytest
      0:     param  0 <- A
      1:     call   t0 <- foo
      2:     assign A <- 1
  ]]

  [[ procedure: foo
    [[
      [ %a        <int>       ]
      [ $aa       <int>       ]
      [ $bb       <bool>       ]
      [ $t0       <int>       ]
      [ $t1       <bool>       ]
    ]]
    [[ foo
        0:     add    t0 <- A, 1
        1:     assign aa <- t0
        2:     if     a > aa goto 3
        3:     goto   4
        4: 3:
        5:     assign t1 <- 1
        6:     goto   5
        7: 4:
        8:     assign t1 <- 0
        9: 5:
       10:     assign bb <- t1
       11:     return aa
    ]]
  ]]
]]
