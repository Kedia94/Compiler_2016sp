##################################################
# test08
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
    #    -96(%ebp)  48  [ $a        <array 10 of <int>> %ebp-96 ]
    #   -100(%ebp)   4  [ $i        <int> %ebp-100 ]
    #   -104(%ebp)   4  [ $t0       <ptr(4) to <array 10 of <int>>> %ebp-104 ]
    #   -108(%ebp)   4  [ $t1       <int> %ebp-108 ]
    #   -112(%ebp)   4  [ $t10      <int> %ebp-112 ]
    #   -116(%ebp)   4  [ $t11      <int> %ebp-116 ]
    #   -120(%ebp)   4  [ $t12      <int> %ebp-120 ]
    #   -124(%ebp)   4  [ $t13      <int> %ebp-124 ]
    #   -128(%ebp)   4  [ $t14      <ptr(4) to <array 10 of <int>>> %ebp-128 ]
    #   -132(%ebp)   4  [ $t15      <int> %ebp-132 ]
    #   -136(%ebp)   4  [ $t16      <ptr(4) to <array 10 of <int>>> %ebp-136 ]
    #   -140(%ebp)   4  [ $t17      <int> %ebp-140 ]
    #   -144(%ebp)   4  [ $t18      <int> %ebp-144 ]
    #   -148(%ebp)   4  [ $t19      <int> %ebp-148 ]
    #   -152(%ebp)   4  [ $t2       <ptr(4) to <array 10 of <int>>> %ebp-152 ]
    #   -156(%ebp)   4  [ $t20      <int> %ebp-156 ]
    #   -160(%ebp)   4  [ $t3       <int> %ebp-160 ]
    #   -164(%ebp)   4  [ $t4       <int> %ebp-164 ]
    #   -168(%ebp)   4  [ $t5       <int> %ebp-168 ]
    #   -172(%ebp)   4  [ $t6       <int> %ebp-172 ]
    #   -176(%ebp)   4  [ $t7       <ptr(4) to <array 10 of <int>>> %ebp-176 ]
    #   -180(%ebp)   4  [ $t8       <int> %ebp-180 ]
    #   -184(%ebp)   4  [ $t9       <ptr(4) to <array 10 of <int>>> %ebp-184 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $172, %esp              # make room for locals

    cld                             # memset local stack area to 0
    xorl    %eax, %eax             
    movl    $43, %ecx              
    mov     %esp, %edi             
    rep     stosl                  
    movl    $1,-96(%ebp)            # local array 'a': 1 dimensions
    movl    $10,-92(%ebp)           #   dimension 1: 10 elements

    # function body
    leal    -96(%ebp), %eax         #   0:     &()    t0 <- a
    movl    %eax, -104(%ebp)       
    movl    $0, %eax                #   1:     mul    t1 <- 0, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -108(%ebp)       
    leal    -96(%ebp), %eax         #   2:     &()    t2 <- a
    movl    %eax, -152(%ebp)       
    movl    -152(%ebp), %eax        #   3:     param  0 <- t2
    pushl   %eax                   
    call    DOFS                    #   4:     call   t3 <- DOFS
    addl    $4, %esp               
    movl    %eax, -160(%ebp)       
    movl    -108(%ebp), %eax        #   5:     add    t4 <- t1, t3
    movl    -160(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -164(%ebp)       
    movl    -104(%ebp), %eax        #   6:     add    t5 <- t0, t4
    movl    -164(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -168(%ebp)       
    movl    $1, %eax                #   7:     assign @t5 <- 1
    movl    -168(%ebp), %edi       
    movl    %eax, (%edi)           
    movl    $1, %eax                #   8:     assign i <- 1
    movl    %eax, -100(%ebp)       
l_test_3_while_cond:
    movl    -100(%ebp), %eax        #  10:     if     i < 10 goto 4_while_body
    movl    $10, %ebx              
    cmpl    %ebx, %eax             
    jl      l_test_4_while_body    
    jmp     l_test_2                #  11:     goto   2
l_test_4_while_body:
    movl    $10, %eax               #  13:     sub    t6 <- 10, i
    movl    -100(%ebp), %ebx       
    subl    %ebx, %eax             
    movl    %eax, -172(%ebp)       
    leal    -96(%ebp), %eax         #  14:     &()    t7 <- a
    movl    %eax, -176(%ebp)       
    movl    -100(%ebp), %eax        #  15:     mul    t8 <- i, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -180(%ebp)       
    leal    -96(%ebp), %eax         #  16:     &()    t9 <- a
    movl    %eax, -184(%ebp)       
    movl    -184(%ebp), %eax        #  17:     param  0 <- t9
    pushl   %eax                   
    call    DOFS                    #  18:     call   t10 <- DOFS
    addl    $4, %esp               
    movl    %eax, -112(%ebp)       
    movl    -180(%ebp), %eax        #  19:     add    t11 <- t8, t10
    movl    -112(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -116(%ebp)       
    movl    -176(%ebp), %eax        #  20:     add    t12 <- t7, t11
    movl    -116(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -120(%ebp)       
    movl    -172(%ebp), %eax        #  21:     assign @t12 <- t6
    movl    -120(%ebp), %edi       
    movl    %eax, (%edi)           
    movl    -100(%ebp), %eax        #  22:     add    t13 <- i, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -124(%ebp)       
    movl    -124(%ebp), %eax        #  23:     assign i <- t13
    movl    %eax, -100(%ebp)       
    jmp     l_test_3_while_cond     #  24:     goto   3_while_cond
l_test_2:
    movl    $0, %eax                #  26:     assign i <- 0
    movl    %eax, -100(%ebp)       
l_test_10_while_cond:
    movl    -100(%ebp), %eax        #  28:     if     i < 10 goto 11_while_body
    movl    $10, %ebx              
    cmpl    %ebx, %eax             
    jl      l_test_11_while_body   
    jmp     l_test_9                #  29:     goto   9
l_test_11_while_body:
    leal    -96(%ebp), %eax         #  31:     &()    t14 <- a
    movl    %eax, -128(%ebp)       
    movl    -100(%ebp), %eax        #  32:     mul    t15 <- i, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -132(%ebp)       
    leal    -96(%ebp), %eax         #  33:     &()    t16 <- a
    movl    %eax, -136(%ebp)       
    movl    -136(%ebp), %eax        #  34:     param  0 <- t16
    pushl   %eax                   
    call    DOFS                    #  35:     call   t17 <- DOFS
    addl    $4, %esp               
    movl    %eax, -140(%ebp)       
    movl    -132(%ebp), %eax        #  36:     add    t18 <- t15, t17
    movl    -140(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -144(%ebp)       
    movl    -128(%ebp), %eax        #  37:     add    t19 <- t14, t18
    movl    -144(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -148(%ebp)       
    movl    -148(%ebp), %edi       
    movl    (%edi), %eax            #  38:     param  0 <- @t19
    pushl   %eax                   
    call    WriteInt                #  39:     call   WriteInt
    addl    $4, %esp               
    movl    -100(%ebp), %eax        #  40:     add    t20 <- i, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -156(%ebp)       
    movl    -156(%ebp), %eax        #  41:     assign i <- t20
    movl    %eax, -100(%ebp)       
    jmp     l_test_10_while_cond    #  42:     goto   10_while_cond
l_test_9:

l_test_exit:
    # epilogue
    addl    $172, %esp              # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # scope test08
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

l_test08_exit:
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
