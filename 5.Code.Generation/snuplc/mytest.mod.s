##################################################
# mytest
#

    #-----------------------------------------
    # text section
    #
    .text
    .align 4

    # entry point and pre-defined functions
    .global main
    .extern DIM
    .extern DOFS
    .extern ReadInt
    .extern WriteInt
    .extern WriteStr
    .extern WriteChar
    .extern WriteLn

    # scope foo
foo:
    # stack offsets:
    #      8(%ebp)   1  [ %param_bool_a <bool> %ebp+8 ]
    #     12(%ebp)   1  [ %param_char <char> %ebp+12 ]
    #     20(%ebp)   4  [ %param_intarray_a <ptr(4) to <array 10 of <int>>> %ebp+20 ]
    #     24(%ebp)   4  [ %param_intarray_b <ptr(4) to <array 10 of <int>>> %ebp+24 ]
    #     16(%ebp)   4  [ %param_integer <int> %ebp+16 ]
    #    -13(%ebp)   1  [ $t0       <bool> %ebp-13 ]
    #    -14(%ebp)   1  [ $t1       <bool> %ebp-14 ]
    #    -15(%ebp)   1  [ $t2       <bool> %ebp-15 ]
    #    -16(%ebp)   1  [ $t3       <bool> %ebp-16 ]
    #    -20(%ebp)   4  [ $t4       <int> %ebp-20 ]
    #    -21(%ebp)   1  [ $t5       <bool> %ebp-21 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $12, %esp               # make room for locals

    xorl    %eax, %eax              # memset local stack area to 0
    movl    %eax, 8(%esp)          
    movl    %eax, 4(%esp)          
    movl    %eax, 0(%esp)          

    # function body
    # ???   not implemented         #   0:     goto   2
    # ???   not implemented         #   1:     assign t0 <- 1
    # ???   not implemented         #   2:     goto   3
    # ???   not implemented         #   4:     assign t0 <- 0
    # ???   not implemented         #   6:     assign param_bool_a <- t0
    # ???   not implemented         #   7:     goto   6
    # ???   not implemented         #   8:     assign t1 <- 1
    # ???   not implemented         #   9:     goto   7
    # ???   not implemented         #  11:     assign t1 <- 0
    # ???   not implemented         #  13:     assign param_bool_a <- t1
    # ???   not implemented         #  14:     goto   10
    # ???   not implemented         #  15:     assign t2 <- 1
    # ???   not implemented         #  16:     goto   11
    # ???   not implemented         #  18:     assign t2 <- 0
    # ???   not implemented         #  20:     assign param_bool_a <- t2
    # ???   not implemented         #  21:     goto   14
    # ???   not implemented         #  22:     assign t3 <- 1
    # ???   not implemented         #  23:     goto   15
    # ???   not implemented         #  25:     assign t3 <- 0
    # ???   not implemented         #  27:     assign param_bool_a <- t3
    movl    , %eax                  #  28:     add    t4 <- 1, param_integer
    movl    , %ebx                 
    addl    %ebx, %eax             
    movl    %eax,                  
    # ???   not implemented         #  29:     assign param_integer <- t4
    # ???   not implemented         #  30:     goto   19
    # ???   not implemented         #  31:     assign t5 <- 1
    # ???   not implemented         #  32:     goto   20
    # ???   not implemented         #  34:     assign t5 <- 0
    # ???   not implemented         #  36:     assign param_bool_a <- t5
    # ???   not implemented         #  37:     return param_bool_a
    # epilogue
    addl    $12, %esp               # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # scope bar
bar:
    # stack offsets:
    #      8(%ebp)   4  [ %a1       <int> %ebp+8 ]
    #     12(%ebp)   4  [ %a2       <int> %ebp+12 ]
    #     16(%ebp)   4  [ %a3       <int> %ebp+16 ]
    #     20(%ebp)   4  [ %a4       <int> %ebp+20 ]
    #     24(%ebp)   1  [ %b1       <bool> %ebp+24 ]
    #     28(%ebp)   1  [ %b2       <bool> %ebp+28 ]
    #    -16(%ebp)   4  [ $t0       <int> %ebp-16 ]
    #    -20(%ebp)   4  [ $t1       <int> %ebp-20 ]
    #    -21(%ebp)   1  [ $t2       <bool> %ebp-21 ]
    #    -22(%ebp)   1  [ $t3       <bool> %ebp-22 ]
    #    -23(%ebp)   1  [ $t4       <bool> %ebp-23 ]
    #    -24(%ebp)   1  [ $t5       <bool> %ebp-24 ]
    #    -28(%ebp)   4  [ $t6       <int> %ebp-28 ]
    #    -29(%ebp)   1  [ $t7       <bool> %ebp-29 ]
    #    -30(%ebp)   1  [ $t8       <bool> %ebp-30 ]
    #    -31(%ebp)   1  [ $t9       <bool> %ebp-31 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $20, %esp               # make room for locals

    cld                             # memset local stack area to 0
    xorl    %eax, %eax             
    movl    $5, %ecx               
    mov     %esp, %edi             
    rep     stosl                  

    # function body
    movl    , %eax                  #   0:     add    t0 <- a2, a3
    movl    , %ebx                 
    addl    %ebx, %eax             
    movl    %eax,                  
    # ???   not implemented         #   1:     assign a1 <- t0
    movl    , %eax                  #   2:     add    t1 <- a2, a3
    movl    , %ebx                 
    addl    %ebx, %eax             
    movl    %eax,                  
    # ???   not implemented         #   3:     assign a1 <- t1
    # ???   not implemented         #   4:     if     b1 = 1 goto 6
    # ???   not implemented         #   5:     goto   4
    # ???   not implemented         #   7:     if     b2 = 1 goto 3
    # ???   not implemented         #   8:     goto   4
    # ???   not implemented         #  10:     assign t2 <- 1
    # ???   not implemented         #  11:     goto   5
    # ???   not implemented         #  13:     assign t2 <- 0
    # ???   not implemented         #  15:     assign b1 <- t2
    # ???   not implemented         #  16:     if     b1 = 1 goto 11
    # ???   not implemented         #  17:     goto   9
    # ???   not implemented         #  19:     if     b2 = 1 goto 8
    # ???   not implemented         #  20:     goto   9
    # ???   not implemented         #  22:     assign t3 <- 1
    # ???   not implemented         #  23:     goto   10
    # ???   not implemented         #  25:     assign t3 <- 0
    # ???   not implemented         #  27:     assign b1 <- t3
    # ???   not implemented         #  28:     if     b1 = 1 goto 16
    # ???   not implemented         #  29:     goto   14
    # ???   not implemented         #  31:     if     b2 = 1 goto 13
    # ???   not implemented         #  32:     goto   14
    # ???   not implemented         #  34:     assign t4 <- 1
    # ???   not implemented         #  35:     goto   15
    # ???   not implemented         #  37:     assign t4 <- 0
    # ???   not implemented         #  39:     assign b1 <- t4
    # ???   not implemented         #  40:     if     b1 = 1 goto 21
    # ???   not implemented         #  41:     goto   19
    # ???   not implemented         #  43:     if     b2 = 1 goto 18
    # ???   not implemented         #  44:     goto   19
    # ???   not implemented         #  46:     assign t5 <- 1
    # ???   not implemented         #  47:     goto   20
    # ???   not implemented         #  49:     assign t5 <- 0
    # ???   not implemented         #  51:     assign b1 <- t5
    movl    , %eax                  #  52:     add    t6 <- a2, a3
    movl    , %ebx                 
    addl    %ebx, %eax             
    movl    %eax,                  
    # ???   not implemented         #  53:     assign a1 <- t6
    # ???   not implemented         #  54:     if     b1 = 1 goto 27
    # ???   not implemented         #  55:     goto   25
    # ???   not implemented         #  57:     if     b2 = 1 goto 24
    # ???   not implemented         #  58:     goto   25
    # ???   not implemented         #  60:     assign t7 <- 1
    # ???   not implemented         #  61:     goto   26
    # ???   not implemented         #  63:     assign t7 <- 0
    # ???   not implemented         #  65:     assign b1 <- t7
    # ???   not implemented         #  66:     if     b1 = 1 goto 32
    # ???   not implemented         #  67:     goto   30
    # ???   not implemented         #  69:     if     b2 = 1 goto 29
    # ???   not implemented         #  70:     goto   30
    # ???   not implemented         #  72:     assign t8 <- 1
    # ???   not implemented         #  73:     goto   31
    # ???   not implemented         #  75:     assign t8 <- 0
    # ???   not implemented         #  77:     assign b1 <- t8
    # ???   not implemented         #  78:     if     b1 = 1 goto 37
    # ???   not implemented         #  79:     goto   35
    # ???   not implemented         #  81:     if     b2 = 1 goto 34
    # ???   not implemented         #  82:     goto   35
    # ???   not implemented         #  84:     assign t9 <- 1
    # ???   not implemented         #  85:     goto   36
    # ???   not implemented         #  87:     assign t9 <- 0
    # ???   not implemented         #  89:     assign b1 <- t9
    # ???   not implemented         #  90:     return 3
    # epilogue
    addl    $20, %esp               # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # scope mytest
main:
    # stack offsets:

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $0, %esp                # make room for locals

    # function body
    # epilogue
    addl    $0, %esp                # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # end of text section
    #-----------------------------------------

    #-----------------------------------------
    # global data section
    #
    .data
    .align 4

    # scope: mytest
global_bool_a:                      # <bool>
    .skip    1
global_bool_b:                      # <bool>
    .skip    1
global_bool_c:                      # <bool>
    .skip    1
global_bool_d:                      # <bool>
    .skip    1
global_boolarray_a:                 # <array 10 of <bool>>
    .long    1
    .long   10
    .skip   10
global_char_a:                      # <char>
    .skip    1
global_chararray_a:                 # <array 10 of <char>>
    .long    1
    .long   10
    .skip   10
    .align   4
global_intarray_a:                  # <array 10 of <int>>
    .long    1
    .long   10
    .skip   40
global_integer_a:                   # <int>
    .skip    4
global_integer_b:                   # <int>
    .skip    4



    # end of global data section
    #-----------------------------------------

    .end
##################################################
