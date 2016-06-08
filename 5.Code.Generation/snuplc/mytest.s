##################################################
# test09
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

    # scope test
test:
    # stack offsets:
    #   -124(%ebp)  112  [ $a        <array 10 of <array 10 of <bool>>> %ebp-124 ]
    #   -128(%ebp)   4  [ $i        <int> %ebp-128 ]
    #   -129(%ebp)   1  [ $t0       <bool> %ebp-129 ]
    #   -136(%ebp)   4  [ $t1       <ptr(4) to <array 10 of <array 10 of <bool>>>> %ebp-136 ]
    #   -140(%ebp)   4  [ $t10      <int> %ebp-140 ]
    #   -144(%ebp)   4  [ $t11      <int> %ebp-144 ]
    #   -148(%ebp)   4  [ $t12      <ptr(4) to <array 10 of <array 10 of <bool>>>> %ebp-148 ]
    #   -152(%ebp)   4  [ $t13      <ptr(4) to <array 10 of <array 10 of <bool>>>> %ebp-152 ]
    #   -156(%ebp)   4  [ $t14      <int> %ebp-156 ]
    #   -160(%ebp)   4  [ $t15      <int> %ebp-160 ]
    #   -164(%ebp)   4  [ $t16      <int> %ebp-164 ]
    #   -168(%ebp)   4  [ $t17      <int> %ebp-168 ]
    #   -172(%ebp)   4  [ $t18      <ptr(4) to <array 10 of <array 10 of <bool>>>> %ebp-172 ]
    #   -176(%ebp)   4  [ $t19      <int> %ebp-176 ]
    #   -180(%ebp)   4  [ $t2       <ptr(4) to <array 10 of <array 10 of <bool>>>> %ebp-180 ]
    #   -184(%ebp)   4  [ $t20      <int> %ebp-184 ]
    #   -188(%ebp)   4  [ $t21      <int> %ebp-188 ]
    #   -192(%ebp)   4  [ $t22      <int> %ebp-192 ]
    #   -196(%ebp)   4  [ $t3       <int> %ebp-196 ]
    #   -200(%ebp)   4  [ $t4       <int> %ebp-200 ]
    #   -204(%ebp)   4  [ $t5       <int> %ebp-204 ]
    #   -208(%ebp)   4  [ $t6       <int> %ebp-208 ]
    #   -212(%ebp)   4  [ $t7       <ptr(4) to <array 10 of <array 10 of <bool>>>> %ebp-212 ]
    #   -216(%ebp)   4  [ $t8       <int> %ebp-216 ]
    #   -220(%ebp)   4  [ $t9       <int> %ebp-220 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $208, %esp              # make room for locals

    cld                             # memset local stack area to 0
    xorl    %eax, %eax             
    movl    $52, %ecx              
    mov     %esp, %edi             
    rep     stosl                  
    movl    $2,-124(%ebp)           # local array 'a': 2 dimensions
    movl    $10,-120(%ebp)          #   dimension 1: 10 elements
    movl    $10,-116(%ebp)          #   dimension 2: 10 elements

    # function body
    movl    $0, %eax                #   0:     assign i <- 0
    movl    %eax, -128(%ebp)       
l_test_2_while_cond:
    movl    -128(%ebp), %eax        #   2:     if     i < 10 goto 3_while_body
    movl    $10, %ebx              
    cmpl    %ebx, %eax             
    jl      l_test_3_while_body    
    jmp     l_test_1                #   3:     goto   1
l_test_3_while_body:
    movl    -128(%ebp), %eax        #   5:     if     i > 2 goto 6
    movl    $2, %ebx               
    cmpl    %ebx, %eax             
    jg      l_test_6               
    jmp     l_test_7                #   6:     goto   7
l_test_6:
    movl    $1, %eax                #   8:     assign t0 <- 1
    movb    %al, -129(%ebp)        
    jmp     l_test_8                #   9:     goto   8
l_test_7:
    movl    $0, %eax                #  11:     assign t0 <- 0
    movb    %al, -129(%ebp)        
l_test_8:
    leal    -124(%ebp), %eax        #  13:     &()    t1 <- a
    movl    %eax, -136(%ebp)       
    movl    $2, %eax                #  14:     param  1 <- 2
    pushl   %eax                   
    leal    -124(%ebp), %eax        #  15:     &()    t2 <- a
    movl    %eax, -180(%ebp)       
    movl    -180(%ebp), %eax        #  16:     param  0 <- t2
    pushl   %eax                   
    call    DIM                     #  17:     call   t3 <- DIM
    addl    $8, %esp               
    movl    %eax, -196(%ebp)       
    movl    -128(%ebp), %eax        #  18:     mul    t4 <- i, t3
    movl    -196(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -200(%ebp)       
    movl    -200(%ebp), %eax        #  19:     add    t5 <- t4, i
    movl    -128(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -204(%ebp)       
    movl    -204(%ebp), %eax        #  20:     mul    t6 <- t5, 1
    movl    $1, %ebx               
    imull   %ebx                   
    movl    %eax, -208(%ebp)       
    leal    -124(%ebp), %eax        #  21:     &()    t7 <- a
    movl    %eax, -212(%ebp)       
    movl    -212(%ebp), %eax        #  22:     param  0 <- t7
    pushl   %eax                   
    call    DOFS                    #  23:     call   t8 <- DOFS
    addl    $4, %esp               
    movl    %eax, -216(%ebp)       
    movl    -208(%ebp), %eax        #  24:     add    t9 <- t6, t8
    movl    -216(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -220(%ebp)       
    movl    -136(%ebp), %eax        #  25:     add    t10 <- t1, t9
    movl    -220(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -140(%ebp)       
    movzbl  -129(%ebp), %eax        #  26:     assign @t10 <- t0
    movl    -140(%ebp), %edi       
    movb    %al, (%edi)            
    movl    -128(%ebp), %eax        #  27:     add    t11 <- i, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -144(%ebp)       
    movl    -144(%ebp), %eax        #  28:     assign i <- t11
    movl    %eax, -128(%ebp)       
    jmp     l_test_2_while_cond     #  29:     goto   2_while_cond
l_test_1:
    movl    $0, %eax                #  31:     assign i <- 0
    movl    %eax, -128(%ebp)       
l_test_13_while_cond:
    movl    -128(%ebp), %eax        #  33:     if     i < 10 goto 14_while_body
    movl    $10, %ebx              
    cmpl    %ebx, %eax             
    jl      l_test_14_while_body   
    jmp     l_test_12               #  34:     goto   12
l_test_14_while_body:
    leal    -124(%ebp), %eax        #  36:     &()    t12 <- a
    movl    %eax, -148(%ebp)       
    movl    $2, %eax                #  37:     param  1 <- 2
    pushl   %eax                   
    leal    -124(%ebp), %eax        #  38:     &()    t13 <- a
    movl    %eax, -152(%ebp)       
    movl    -152(%ebp), %eax        #  39:     param  0 <- t13
    pushl   %eax                   
    call    DIM                     #  40:     call   t14 <- DIM
    addl    $8, %esp               
    movl    %eax, -156(%ebp)       
    movl    -128(%ebp), %eax        #  41:     mul    t15 <- i, t14
    movl    -156(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -160(%ebp)       
    movl    -160(%ebp), %eax        #  42:     add    t16 <- t15, i
    movl    -128(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -164(%ebp)       
    movl    -164(%ebp), %eax        #  43:     mul    t17 <- t16, 1
    movl    $1, %ebx               
    imull   %ebx                   
    movl    %eax, -168(%ebp)       
    leal    -124(%ebp), %eax        #  44:     &()    t18 <- a
    movl    %eax, -172(%ebp)       
    movl    -172(%ebp), %eax        #  45:     param  0 <- t18
    pushl   %eax                   
    call    DOFS                    #  46:     call   t19 <- DOFS
    addl    $4, %esp               
    movl    %eax, -176(%ebp)       
    movl    -168(%ebp), %eax        #  47:     add    t20 <- t17, t19
    movl    -176(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -184(%ebp)       
    movl    -148(%ebp), %eax        #  48:     add    t21 <- t12, t20
    movl    -184(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -188(%ebp)       
    movl    -188(%ebp), %edi       
    movzbl  (%edi), %eax            #  49:     if     @t21 = 1 goto 17_if_true
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_test_17_if_true      
    jmp     l_test_18_if_false      #  50:     goto   18_if_false
l_test_17_if_true:
    movl    $1, %eax                #  52:     param  0 <- 1
    pushl   %eax                   
    call    WriteInt                #  53:     call   WriteInt
    addl    $4, %esp               
    jmp     l_test_16               #  54:     goto   16
l_test_18_if_false:
    movl    $0, %eax                #  56:     param  0 <- 0
    pushl   %eax                   
    call    WriteInt                #  57:     call   WriteInt
    addl    $4, %esp               
l_test_16:
    movl    -128(%ebp), %eax        #  59:     add    t22 <- i, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -192(%ebp)       
    movl    -192(%ebp), %eax        #  60:     assign i <- t22
    movl    %eax, -128(%ebp)       
    jmp     l_test_13_while_cond    #  61:     goto   13_while_cond
l_test_12:

l_test_exit:
    # epilogue
    addl    $208, %esp              # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # scope test09
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
    call    test                    #   0:     call   test

l_test09_exit:
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



    # end of global data section
    #-----------------------------------------

    .end
##################################################
