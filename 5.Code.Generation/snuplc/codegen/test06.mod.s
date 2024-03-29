##################################################
# test06
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
    #      8(%ebp)   4  [ %a        <ptr(4) to <array of <bool>>> %ebp+8 ]
    #    -16(%ebp)   4  [ $i        <int> %ebp-16 ]
    #    -17(%ebp)   1  [ $t0       <bool> %ebp-17 ]
    #    -24(%ebp)   4  [ $t1       <int> %ebp-24 ]
    #    -28(%ebp)   4  [ $t10      <int> %ebp-28 ]
    #    -32(%ebp)   4  [ $t2       <int> %ebp-32 ]
    #    -36(%ebp)   4  [ $t3       <int> %ebp-36 ]
    #    -40(%ebp)   4  [ $t4       <int> %ebp-40 ]
    #    -44(%ebp)   4  [ $t5       <int> %ebp-44 ]
    #    -48(%ebp)   4  [ $t6       <int> %ebp-48 ]
    #    -52(%ebp)   4  [ $t7       <int> %ebp-52 ]
    #    -56(%ebp)   4  [ $t8       <int> %ebp-56 ]
    #    -60(%ebp)   4  [ $t9       <int> %ebp-60 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $48, %esp               # make room for locals

    cld                             # memset local stack area to 0
    xorl    %eax, %eax             
    movl    $12, %ecx              
    mov     %esp, %edi             
    rep     stosl                  

    # function body
    movl    $0, %eax                #   0:     assign i <- 0
    movl    %eax, -16(%ebp)        
l_test_2_while_cond:
    movl    -16(%ebp), %eax         #   2:     if     i < 10 goto 3_while_body
    movl    $10, %ebx              
    cmpl    %ebx, %eax             
    jl      l_test_3_while_body    
    jmp     l_test_1                #   3:     goto   1
l_test_3_while_body:
    movl    -16(%ebp), %eax         #   5:     if     i > 2 goto 7
    movl    $2, %ebx               
    cmpl    %ebx, %eax             
    jg      l_test_7               
    jmp     l_test_8                #   6:     goto   8
l_test_7:
    movl    $1, %eax                #   8:     assign t0 <- 1
    movb    %al, -17(%ebp)         
    jmp     l_test_9                #   9:     goto   9
l_test_8:
    movl    $0, %eax                #  11:     assign t0 <- 0
    movb    %al, -17(%ebp)         
l_test_9:
    movl    -16(%ebp), %eax         #  13:     mul    t1 <- i, 1
    movl    $1, %ebx               
    imull   %ebx                   
    movl    %eax, -24(%ebp)        
    movl    8(%ebp), %eax           #  14:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  15:     call   t2 <- DOFS
    addl    $4, %esp               
    movl    %eax, -32(%ebp)        
    movl    -24(%ebp), %eax         #  16:     add    t3 <- t1, t2
    movl    -32(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -36(%ebp)        
    movl    8(%ebp), %eax           #  17:     add    t4 <- a, t3
    movl    -36(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -40(%ebp)        
    movzbl  -17(%ebp), %eax         #  18:     assign @t4 <- t0
    movl    -40(%ebp), %edi        
    movb    %al, (%edi)            
    movl    -16(%ebp), %eax         #  19:     add    t5 <- i, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -44(%ebp)        
    movl    -44(%ebp), %eax         #  20:     assign i <- t5
    movl    %eax, -16(%ebp)        
    jmp     l_test_2_while_cond     #  21:     goto   2_while_cond
l_test_1:
    movl    $0, %eax                #  23:     assign i <- 0
    movl    %eax, -16(%ebp)        
l_test_14_while_cond:
    movl    -16(%ebp), %eax         #  25:     if     i < 10 goto 15_while_body
    movl    $10, %ebx              
    cmpl    %ebx, %eax             
    jl      l_test_15_while_body   
    jmp     l_test_13               #  26:     goto   13
l_test_15_while_body:
    movl    -16(%ebp), %eax         #  28:     mul    t6 <- i, 1
    movl    $1, %ebx               
    imull   %ebx                   
    movl    %eax, -48(%ebp)        
    movl    8(%ebp), %eax           #  29:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  30:     call   t7 <- DOFS
    addl    $4, %esp               
    movl    %eax, -52(%ebp)        
    movl    -48(%ebp), %eax         #  31:     add    t8 <- t6, t7
    movl    -52(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -56(%ebp)        
    movl    8(%ebp), %eax           #  32:     add    t9 <- a, t8
    movl    -56(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -60(%ebp)        
    movl    -60(%ebp), %edi        
    movzbl  (%edi), %eax            #  33:     if     @t9 = 1 goto 18_if_true
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_test_18_if_true      
    jmp     l_test_19_if_false      #  34:     goto   19_if_false
l_test_18_if_true:
    movl    $1, %eax                #  36:     param  0 <- 1
    pushl   %eax                   
    call    WriteInt                #  37:     call   WriteInt
    addl    $4, %esp               
    jmp     l_test_17               #  38:     goto   17
l_test_19_if_false:
    movl    $0, %eax                #  40:     param  0 <- 0
    pushl   %eax                   
    call    WriteInt                #  41:     call   WriteInt
    addl    $4, %esp               
l_test_17:
    movl    -16(%ebp), %eax         #  43:     add    t10 <- i, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -28(%ebp)        
    movl    -28(%ebp), %eax         #  44:     assign i <- t10
    movl    %eax, -16(%ebp)        
    jmp     l_test_14_while_cond    #  45:     goto   14_while_cond
l_test_13:

l_test_exit:
    # epilogue
    addl    $48, %esp               # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # scope test06
main:
    # stack offsets:
    #    -16(%ebp)   4  [ $t0       <ptr(4) to <array 10 of <bool>>> %ebp-16 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $4, %esp                # make room for locals

    xorl    %eax, %eax              # memset local stack area to 0
    movl    %eax, 0(%esp)          

    # function body
    leal    a, %eax                 #   0:     &()    t0 <- a
    movl    %eax, -16(%ebp)        
    movl    -16(%ebp), %eax         #   1:     param  0 <- t0
    pushl   %eax                   
    call    test                    #   2:     call   test
    addl    $4, %esp               

l_test06_exit:
    # epilogue
    addl    $4, %esp                # remove locals
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

    # scope: test06
a:                                  # <array 10 of <bool>>
    .long    1
    .long   10
    .skip   10


    # end of global data section
    #-----------------------------------------

    .end
##################################################
