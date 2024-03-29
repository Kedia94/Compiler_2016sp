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
    #    -36(%ebp)  18  [ $a        <array 10 of <bool>> %ebp-36 ]
    #    -40(%ebp)   4  [ $i        <int> %ebp-40 ]
    #    -41(%ebp)   1  [ $t0       <bool> %ebp-41 ]
    #    -48(%ebp)   4  [ $t1       <ptr(4) to <array 10 of <bool>>> %ebp-48 ]
    #    -52(%ebp)   4  [ $t10      <ptr(4) to <array 10 of <bool>>> %ebp-52 ]
    #    -56(%ebp)   4  [ $t11      <int> %ebp-56 ]
    #    -60(%ebp)   4  [ $t12      <int> %ebp-60 ]
    #    -64(%ebp)   4  [ $t13      <int> %ebp-64 ]
    #    -68(%ebp)   4  [ $t14      <int> %ebp-68 ]
    #    -72(%ebp)   4  [ $t2       <int> %ebp-72 ]
    #    -76(%ebp)   4  [ $t3       <ptr(4) to <array 10 of <bool>>> %ebp-76 ]
    #    -80(%ebp)   4  [ $t4       <int> %ebp-80 ]
    #    -84(%ebp)   4  [ $t5       <int> %ebp-84 ]
    #    -88(%ebp)   4  [ $t6       <int> %ebp-88 ]
    #    -92(%ebp)   4  [ $t7       <int> %ebp-92 ]
    #    -96(%ebp)   4  [ $t8       <ptr(4) to <array 10 of <bool>>> %ebp-96 ]
    #   -100(%ebp)   4  [ $t9       <int> %ebp-100 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $88, %esp               # make room for locals

    cld                             # memset local stack area to 0
    xorl    %eax, %eax             
    movl    $22, %ecx              
    mov     %esp, %edi             
    rep     stosl                  
    movl    $1,-36(%ebp)            # local array 'a': 1 dimensions
    movl    $10,-32(%ebp)           #   dimension 1: 10 elements

    # function body
    movl    $0, %eax                #   0:     assign i <- 0
    movl    %eax, -40(%ebp)        
l_test_2_while_cond:
    movl    -40(%ebp), %eax         #   2:     if     i < 10 goto 3_while_body
    movl    $10, %ebx              
    cmpl    %ebx, %eax             
    jl      l_test_3_while_body    
    jmp     l_test_1                #   3:     goto   1
l_test_3_while_body:
    movl    -40(%ebp), %eax         #   5:     if     i > 2 goto 6
    movl    $2, %ebx               
    cmpl    %ebx, %eax             
    jg      l_test_6               
    jmp     l_test_7                #   6:     goto   7
l_test_6:
    movl    $1, %eax                #   8:     assign t0 <- 1
    movb    %al, -41(%ebp)         
    jmp     l_test_8                #   9:     goto   8
l_test_7:
    movl    $0, %eax                #  11:     assign t0 <- 0
    movb    %al, -41(%ebp)         
l_test_8:
    leal    -36(%ebp), %eax         #  13:     &()    t1 <- a
    movl    %eax, -48(%ebp)        
    movl    -40(%ebp), %eax         #  14:     mul    t2 <- i, 1
    movl    $1, %ebx               
    imull   %ebx                   
    movl    %eax, -72(%ebp)        
    leal    -36(%ebp), %eax         #  15:     &()    t3 <- a
    movl    %eax, -76(%ebp)        
    movl    -76(%ebp), %eax         #  16:     param  0 <- t3
    pushl   %eax                   
    call    DOFS                    #  17:     call   t4 <- DOFS
    addl    $4, %esp               
    movl    %eax, -80(%ebp)        
    movl    -72(%ebp), %eax         #  18:     add    t5 <- t2, t4
    movl    -80(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -84(%ebp)        
    movl    -48(%ebp), %eax         #  19:     add    t6 <- t1, t5
    movl    -84(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -88(%ebp)        
    movzbl  -41(%ebp), %eax         #  20:     assign @t6 <- t0
    movl    -88(%ebp), %edi        
    movb    %al, (%edi)            
    movl    -40(%ebp), %eax         #  21:     add    t7 <- i, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -92(%ebp)        
    movl    -92(%ebp), %eax         #  22:     assign i <- t7
    movl    %eax, -40(%ebp)        
    jmp     l_test_2_while_cond     #  23:     goto   2_while_cond
l_test_1:
    movl    $0, %eax                #  25:     assign i <- 0
    movl    %eax, -40(%ebp)        
l_test_13_while_cond:
    movl    -40(%ebp), %eax         #  27:     if     i < 10 goto 14_while_body
    movl    $10, %ebx              
    cmpl    %ebx, %eax             
    jl      l_test_14_while_body   
    jmp     l_test_12               #  28:     goto   12
l_test_14_while_body:
    leal    -36(%ebp), %eax         #  30:     &()    t8 <- a
    movl    %eax, -96(%ebp)        
    movl    -40(%ebp), %eax         #  31:     mul    t9 <- i, 1
    movl    $1, %ebx               
    imull   %ebx                   
    movl    %eax, -100(%ebp)       
    leal    -36(%ebp), %eax         #  32:     &()    t10 <- a
    movl    %eax, -52(%ebp)        
    movl    -52(%ebp), %eax         #  33:     param  0 <- t10
    pushl   %eax                   
    call    DOFS                    #  34:     call   t11 <- DOFS
    addl    $4, %esp               
    movl    %eax, -56(%ebp)        
    movl    -100(%ebp), %eax        #  35:     add    t12 <- t9, t11
    movl    -56(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -60(%ebp)        
    movl    -96(%ebp), %eax         #  36:     add    t13 <- t8, t12
    movl    -60(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -64(%ebp)        
    movl    -64(%ebp), %edi        
    movzbl  (%edi), %eax            #  37:     if     @t13 = 1 goto 17_if_true
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_test_17_if_true      
    jmp     l_test_18_if_false      #  38:     goto   18_if_false
l_test_17_if_true:
    movl    $1, %eax                #  40:     param  0 <- 1
    pushl   %eax                   
    call    WriteInt                #  41:     call   WriteInt
    addl    $4, %esp               
    jmp     l_test_16               #  42:     goto   16
l_test_18_if_false:
    movl    $0, %eax                #  44:     param  0 <- 0
    pushl   %eax                   
    call    WriteInt                #  45:     call   WriteInt
    addl    $4, %esp               
l_test_16:
    movl    -40(%ebp), %eax         #  47:     add    t14 <- i, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -68(%ebp)        
    movl    -68(%ebp), %eax         #  48:     assign i <- t14
    movl    %eax, -40(%ebp)        
    jmp     l_test_13_while_cond    #  49:     goto   13_while_cond
l_test_12:

l_test_exit:
    # epilogue
    addl    $88, %esp               # remove locals
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
