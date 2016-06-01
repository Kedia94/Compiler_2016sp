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
    jmp     l_foo_2                 #   0:     goto   2
    movl    $1, %eax                #   1:     assign t0 <- 1
    movb    %al, -13(%ebp)         
    jmp     l_foo_3                 #   2:     goto   3
l_foo_2:
    movl    $0, %eax                #   4:     assign t0 <- 0
    movb    %al, -13(%ebp)         
l_foo_3:
    movzbl  -13(%ebp), %eax         #   6:     assign param_bool_a <- t0
    movb    %al, 8(%ebp)           
    jmp     l_foo_6                 #   7:     goto   6
    movl    $1, %eax                #   8:     assign t1 <- 1
    movb    %al, -14(%ebp)         
    jmp     l_foo_7                 #   9:     goto   7
l_foo_6:
    movl    $0, %eax                #  11:     assign t1 <- 0
    movb    %al, -14(%ebp)         
l_foo_7:
    movzbl  -14(%ebp), %eax         #  13:     assign param_bool_a <- t1
    movb    %al, 8(%ebp)           
    jmp     l_foo_10                #  14:     goto   10
    movl    $1, %eax                #  15:     assign t2 <- 1
    movb    %al, -15(%ebp)         
    jmp     l_foo_11                #  16:     goto   11
l_foo_10:
    movl    $0, %eax                #  18:     assign t2 <- 0
    movb    %al, -15(%ebp)         
l_foo_11:
    movzbl  -15(%ebp), %eax         #  20:     assign param_bool_a <- t2
    movb    %al, 8(%ebp)           
    jmp     l_foo_14                #  21:     goto   14
    movl    $1, %eax                #  22:     assign t3 <- 1
    movb    %al, -16(%ebp)         
    jmp     l_foo_15                #  23:     goto   15
l_foo_14:
    movl    $0, %eax                #  25:     assign t3 <- 0
    movb    %al, -16(%ebp)         
l_foo_15:
    movzbl  -16(%ebp), %eax         #  27:     assign param_bool_a <- t3
    movb    %al, 8(%ebp)           
    movl    $1, %eax                #  28:     add    t4 <- 1, param_integer
    movl    16(%ebp), %ebx         
    addl    %ebx, %eax             
    movl    %eax, -20(%ebp)        
    movl    -20(%ebp), %eax         #  29:     assign param_integer <- t4
    movl    %eax, 16(%ebp)         
    jmp     l_foo_19                #  30:     goto   19
    movl    $1, %eax                #  31:     assign t5 <- 1
    movb    %al, -21(%ebp)         
    jmp     l_foo_20                #  32:     goto   20
l_foo_19:
    movl    $0, %eax                #  34:     assign t5 <- 0
    movb    %al, -21(%ebp)         
l_foo_20:
    movzbl  -21(%ebp), %eax         #  36:     assign param_bool_a <- t5
    movb    %al, 8(%ebp)           
    movzbl  8(%ebp), %eax           #  37:     return param_bool_a
    jmp     l_foo_exit             

l_foo_exit:
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
    movl    12(%ebp), %eax          #   0:     add    t0 <- a2, a3
    movl    16(%ebp), %ebx         
    addl    %ebx, %eax             
    movl    %eax, -16(%ebp)        
    movl    -16(%ebp), %eax         #   1:     assign a1 <- t0
    movl    %eax, 8(%ebp)          
    movl    12(%ebp), %eax          #   2:     add    t1 <- a2, a3
    movl    16(%ebp), %ebx         
    addl    %ebx, %eax             
    movl    %eax, -20(%ebp)        
    movl    -20(%ebp), %eax         #   3:     assign a1 <- t1
    movl    %eax, 8(%ebp)          
    movzbl  24(%ebp), %eax          #   4:     if     b1 = 1 goto 6
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_bar_6                
    jmp     l_bar_4                 #   5:     goto   4
l_bar_6:
    movzbl  28(%ebp), %eax          #   7:     if     b2 = 1 goto 3
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_bar_3                
    jmp     l_bar_4                 #   8:     goto   4
l_bar_3:
    movl    $1, %eax                #  10:     assign t2 <- 1
    movb    %al, -21(%ebp)         
    jmp     l_bar_5                 #  11:     goto   5
l_bar_4:
    movl    $0, %eax                #  13:     assign t2 <- 0
    movb    %al, -21(%ebp)         
l_bar_5:
    movzbl  -21(%ebp), %eax         #  15:     assign b1 <- t2
    movb    %al, 24(%ebp)          
    movzbl  24(%ebp), %eax          #  16:     if     b1 = 1 goto 11
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_bar_11               
    jmp     l_bar_9                 #  17:     goto   9
l_bar_11:
    movzbl  28(%ebp), %eax          #  19:     if     b2 = 1 goto 8
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_bar_8                
    jmp     l_bar_9                 #  20:     goto   9
l_bar_8:
    movl    $1, %eax                #  22:     assign t3 <- 1
    movb    %al, -22(%ebp)         
    jmp     l_bar_10                #  23:     goto   10
l_bar_9:
    movl    $0, %eax                #  25:     assign t3 <- 0
    movb    %al, -22(%ebp)         
l_bar_10:
    movzbl  -22(%ebp), %eax         #  27:     assign b1 <- t3
    movb    %al, 24(%ebp)          
    movzbl  24(%ebp), %eax          #  28:     if     b1 = 1 goto 16
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_bar_16               
    jmp     l_bar_14                #  29:     goto   14
l_bar_16:
    movzbl  28(%ebp), %eax          #  31:     if     b2 = 1 goto 13
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_bar_13               
    jmp     l_bar_14                #  32:     goto   14
l_bar_13:
    movl    $1, %eax                #  34:     assign t4 <- 1
    movb    %al, -23(%ebp)         
    jmp     l_bar_15                #  35:     goto   15
l_bar_14:
    movl    $0, %eax                #  37:     assign t4 <- 0
    movb    %al, -23(%ebp)         
l_bar_15:
    movzbl  -23(%ebp), %eax         #  39:     assign b1 <- t4
    movb    %al, 24(%ebp)          
    movzbl  24(%ebp), %eax          #  40:     if     b1 = 1 goto 21
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_bar_21               
    jmp     l_bar_19                #  41:     goto   19
l_bar_21:
    movzbl  28(%ebp), %eax          #  43:     if     b2 = 1 goto 18
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_bar_18               
    jmp     l_bar_19                #  44:     goto   19
l_bar_18:
    movl    $1, %eax                #  46:     assign t5 <- 1
    movb    %al, -24(%ebp)         
    jmp     l_bar_20                #  47:     goto   20
l_bar_19:
    movl    $0, %eax                #  49:     assign t5 <- 0
    movb    %al, -24(%ebp)         
l_bar_20:
    movzbl  -24(%ebp), %eax         #  51:     assign b1 <- t5
    movb    %al, 24(%ebp)          
    movl    12(%ebp), %eax          #  52:     add    t6 <- a2, a3
    movl    16(%ebp), %ebx         
    addl    %ebx, %eax             
    movl    %eax, -28(%ebp)        
    movl    -28(%ebp), %eax         #  53:     assign a1 <- t6
    movl    %eax, 8(%ebp)          
    movzbl  24(%ebp), %eax          #  54:     if     b1 = 1 goto 27
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_bar_27               
    jmp     l_bar_25                #  55:     goto   25
l_bar_27:
    movzbl  28(%ebp), %eax          #  57:     if     b2 = 1 goto 24
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_bar_24               
    jmp     l_bar_25                #  58:     goto   25
l_bar_24:
    movl    $1, %eax                #  60:     assign t7 <- 1
    movb    %al, -29(%ebp)         
    jmp     l_bar_26                #  61:     goto   26
l_bar_25:
    movl    $0, %eax                #  63:     assign t7 <- 0
    movb    %al, -29(%ebp)         
l_bar_26:
    movzbl  -29(%ebp), %eax         #  65:     assign b1 <- t7
    movb    %al, 24(%ebp)          
    movzbl  24(%ebp), %eax          #  66:     if     b1 = 1 goto 32
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_bar_32               
    jmp     l_bar_30                #  67:     goto   30
l_bar_32:
    movzbl  28(%ebp), %eax          #  69:     if     b2 = 1 goto 29
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_bar_29               
    jmp     l_bar_30                #  70:     goto   30
l_bar_29:
    movl    $1, %eax                #  72:     assign t8 <- 1
    movb    %al, -30(%ebp)         
    jmp     l_bar_31                #  73:     goto   31
l_bar_30:
    movl    $0, %eax                #  75:     assign t8 <- 0
    movb    %al, -30(%ebp)         
l_bar_31:
    movzbl  -30(%ebp), %eax         #  77:     assign b1 <- t8
    movb    %al, 24(%ebp)          
    movzbl  24(%ebp), %eax          #  78:     if     b1 = 1 goto 37
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_bar_37               
    jmp     l_bar_35                #  79:     goto   35
l_bar_37:
    movzbl  28(%ebp), %eax          #  81:     if     b2 = 1 goto 34
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_bar_34               
    jmp     l_bar_35                #  82:     goto   35
l_bar_34:
    movl    $1, %eax                #  84:     assign t9 <- 1
    movb    %al, -31(%ebp)         
    jmp     l_bar_36                #  85:     goto   36
l_bar_35:
    movl    $0, %eax                #  87:     assign t9 <- 0
    movb    %al, -31(%ebp)         
l_bar_36:
    movzbl  -31(%ebp), %eax         #  89:     assign b1 <- t9
    movb    %al, 24(%ebp)          
    movl    $3, %eax                #  90:     return 3
    jmp     l_bar_exit             

l_bar_exit:
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

l_mytest_exit:
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
    .align   4
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
