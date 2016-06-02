##################################################
# test02
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
    #      8(%ebp)   4  [ %aaa      <ptr(4) to <array 10 of <bool>>> %ebp+8 ]
    #    -16(%ebp)   4  [ $t0       <int> %ebp-16 ]
    #    -20(%ebp)   4  [ $t1       <int> %ebp-20 ]
    #    -24(%ebp)   4  [ $t2       <int> %ebp-24 ]
    #    -28(%ebp)   4  [ $t3       <int> %ebp-28 ]
    #    -32(%ebp)   4  [ $t4       <int> %ebp-32 ]
    #    -36(%ebp)   4  [ $t5       <int> %ebp-36 ]
    #    -40(%ebp)   4  [ $t6       <int> %ebp-40 ]
    #    -44(%ebp)   4  [ $t7       <int> %ebp-44 ]
    #     12(%ebp)   4  [ %x        <int> %ebp+12 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $32, %esp               # make room for locals

    cld                             # memset local stack area to 0
    xorl    %eax, %eax             
    movl    $8, %ecx               
    mov     %esp, %edi             
    rep     stosl                  

    # function body
    movl    $0, %eax                #   0:     mul    t0 <- 0, 1
    movl    $1, %ebx               
    imull   %ebx                   
    movl    %, -16(%ebp)           
    movl    8(%ebp), %eax           #   1:     param  0 <- aaa
    pushl   %eax                   
    call    DOFS                    #   2:     call   t1 <- DOFS
    addl    $4, %esp               
    movl    %, -20(%ebp)           
    movl    -16(%ebp), %eax         #   3:     add    t2 <- t0, t1
    movl    -20(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %, -24(%ebp)           
    movl    8(%ebp), %eax           #   4:     add    t3 <- aaa, t2
    movl    -24(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %, -28(%ebp)           
    movl    $1, %eax                #   5:     assign @t3 <- 1
    movl    -28(%ebp), %edi        
    movl    %, (%edi)              
    movl    $0, %eax                #   6:     mul    t4 <- 0, 1
    movl    $1, %ebx               
    imull   %ebx                   
    movl    %, -32(%ebp)           
    movl    8(%ebp), %eax           #   7:     param  0 <- aaa
    pushl   %eax                   
    call    DOFS                    #   8:     call   t5 <- DOFS
    addl    $4, %esp               
    movl    %, -36(%ebp)           
    movl    -32(%ebp), %eax         #   9:     add    t6 <- t4, t5
    movl    -36(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %, -40(%ebp)           
    movl    8(%ebp), %eax           #  10:     add    t7 <- aaa, t6
    movl    -40(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %, -44(%ebp)           
    movl    b, %eax                 #  11:     assign @t7 <- b
    movl    -44(%ebp), %edi        
    movl    %, (%edi)              

l_foo_exit:
    # epilogue
    addl    $32, %esp               # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # scope test02
main:
    # stack offsets:
    #    -16(%ebp)   4  [ $t0       <ptr(4) to <array 10 of <int>>> %ebp-16 ]
    #    -20(%ebp)   4  [ $t1       <int> %ebp-20 ]
    #    -24(%ebp)   4  [ $t10      <int> %ebp-24 ]
    #    -28(%ebp)   4  [ $t11      <int> %ebp-28 ]
    #    -32(%ebp)   4  [ $t12      <ptr(4) to <array 2 of <array 10 of <bool>>>> %ebp-32 ]
    #    -36(%ebp)   4  [ $t13      <ptr(4) to <array 2 of <array 10 of <bool>>>> %ebp-36 ]
    #    -40(%ebp)   4  [ $t14      <int> %ebp-40 ]
    #    -44(%ebp)   4  [ $t15      <int> %ebp-44 ]
    #    -48(%ebp)   4  [ $t16      <int> %ebp-48 ]
    #    -52(%ebp)   4  [ $t17      <int> %ebp-52 ]
    #    -56(%ebp)   4  [ $t18      <ptr(4) to <array 2 of <array 10 of <bool>>>> %ebp-56 ]
    #    -60(%ebp)   4  [ $t19      <int> %ebp-60 ]
    #    -64(%ebp)   4  [ $t2       <ptr(4) to <array 10 of <int>>> %ebp-64 ]
    #    -68(%ebp)   4  [ $t20      <int> %ebp-68 ]
    #    -72(%ebp)   4  [ $t21      <int> %ebp-72 ]
    #    -76(%ebp)   4  [ $t22      <ptr(4) to <bool>> %ebp-76 ]
    #    -80(%ebp)   4  [ $t23      <int> %ebp-80 ]
    #    -84(%ebp)   4  [ $t24      <ptr(4) to <array 10 of <int>>> %ebp-84 ]
    #    -88(%ebp)   4  [ $t25      <int> %ebp-88 ]
    #    -92(%ebp)   4  [ $t26      <ptr(4) to <array 10 of <int>>> %ebp-92 ]
    #    -96(%ebp)   4  [ $t27      <int> %ebp-96 ]
    #   -100(%ebp)   4  [ $t28      <int> %ebp-100 ]
    #   -104(%ebp)   4  [ $t29      <int> %ebp-104 ]
    #   -108(%ebp)   4  [ $t3       <int> %ebp-108 ]
    #   -112(%ebp)   4  [ $t30      <int> %ebp-112 ]
    #   -116(%ebp)   4  [ $t31      <ptr(4) to <array 10 of <int>>> %ebp-116 ]
    #   -120(%ebp)   4  [ $t32      <int> %ebp-120 ]
    #   -124(%ebp)   4  [ $t33      <ptr(4) to <array 10 of <int>>> %ebp-124 ]
    #   -128(%ebp)   4  [ $t34      <int> %ebp-128 ]
    #   -132(%ebp)   4  [ $t35      <int> %ebp-132 ]
    #   -136(%ebp)   4  [ $t36      <int> %ebp-136 ]
    #   -140(%ebp)   4  [ $t37      <int> %ebp-140 ]
    #   -144(%ebp)   4  [ $t4       <int> %ebp-144 ]
    #   -148(%ebp)   4  [ $t5       <int> %ebp-148 ]
    #   -152(%ebp)   4  [ $t6       <ptr(4) to <array 10 of <int>>> %ebp-152 ]
    #   -156(%ebp)   4  [ $t7       <int> %ebp-156 ]
    #   -160(%ebp)   4  [ $t8       <ptr(4) to <array 10 of <int>>> %ebp-160 ]
    #   -164(%ebp)   4  [ $t9       <int> %ebp-164 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $152, %esp              # make room for locals

    cld                             # memset local stack area to 0
    xorl    %eax, %eax             
    movl    $38, %ecx              
    mov     %esp, %edi             
    rep     stosl                  

    # function body
    leal    a, %eax                 #   0:     &()    t0 <- a
    movl    %, -16(%ebp)           
    movl    $0, %eax                #   1:     mul    t1 <- 0, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %, -20(%ebp)           
    leal    a, %eax                 #   2:     &()    t2 <- a
    movl    %, -64(%ebp)           
    movl    -64(%ebp), %eax         #   3:     param  0 <- t2
    pushl   %eax                   
    call    DOFS                    #   4:     call   t3 <- DOFS
    addl    $4, %esp               
    movl    %, -108(%ebp)          
    movl    -20(%ebp), %eax         #   5:     add    t4 <- t1, t3
    movl    -108(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %, -144(%ebp)          
    movl    -16(%ebp), %eax         #   6:     add    t5 <- t0, t4
    movl    -144(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %, -148(%ebp)          
    movl    $1, %eax                #   7:     assign @t5 <- 1
    movl    -148(%ebp), %edi       
    movl    %, (%edi)              
    leal    a, %eax                 #   8:     &()    t6 <- a
    movl    %, -152(%ebp)          
    movl    $0, %eax                #   9:     mul    t7 <- 0, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %, -156(%ebp)          
    leal    a, %eax                 #  10:     &()    t8 <- a
    movl    %, -160(%ebp)          
    movl    -160(%ebp), %eax        #  11:     param  0 <- t8
    pushl   %eax                   
    call    DOFS                    #  12:     call   t9 <- DOFS
    addl    $4, %esp               
    movl    %, -164(%ebp)          
    movl    -156(%ebp), %eax        #  13:     add    t10 <- t7, t9
    movl    -164(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %, -24(%ebp)           
    movl    -152(%ebp), %eax        #  14:     add    t11 <- t6, t10
    movl    -24(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %, -28(%ebp)           
    movl    -28(%ebp), %edi        
    movl    (%edi), %eax            #  15:     param  1 <- @t11
    pushl   %eax                   
    leal    d, %eax                 #  16:     &()    t12 <- d
    movl    %, -32(%ebp)           
    movl    $2, %eax                #  17:     param  1 <- 2
    pushl   %eax                   
    leal    d, %eax                 #  18:     &()    t13 <- d
    movl    %, -36(%ebp)           
    movl    -36(%ebp), %eax         #  19:     param  0 <- t13
    pushl   %eax                   
    call    DIM                     #  20:     call   t14 <- DIM
    addl    $8, %esp               
    movl    %, -40(%ebp)           
    movl    $1, %eax                #  21:     mul    t15 <- 1, t14
    movl    -40(%ebp), %ebx        
    imull   %ebx                   
    movl    %, -44(%ebp)           
    movl    -44(%ebp), %eax         #  22:     add    t16 <- t15, 0
    movl    $0, %ebx               
    addl    %ebx, %eax             
    movl    %, -48(%ebp)           
    movl    -48(%ebp), %eax         #  23:     mul    t17 <- t16, 1
    movl    $1, %ebx               
    imull   %ebx                   
    movl    %, -52(%ebp)           
    leal    d, %eax                 #  24:     &()    t18 <- d
    movl    %, -56(%ebp)           
    movl    -56(%ebp), %eax         #  25:     param  0 <- t18
    pushl   %eax                   
    call    DOFS                    #  26:     call   t19 <- DOFS
    addl    $4, %esp               
    movl    %, -60(%ebp)           
    movl    -52(%ebp), %eax         #  27:     add    t20 <- t17, t19
    movl    -60(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %, -68(%ebp)           
    movl    -32(%ebp), %eax         #  28:     add    t21 <- t12, t20
    movl    -68(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %, -72(%ebp)           
    movl    -72(%ebp), %edi        
    leal    (%edi), %eax            #  29:     &()    t22 <- @t21
    movl    %, -76(%ebp)           
    movl    -76(%ebp), %eax         #  30:     param  0 <- t22
    pushl   %eax                   
    call    foo                     #  31:     call   foo
    addl    $8, %esp               
    movl    $1, %eax                #  32:     assign i <- 1
    movl    %, i                   
l_test02_4_while_cond:
    # ???   not implemented         #  34:     if     i < 10 goto 5_while_body
    jmp     l_test02_3              #  35:     goto   3
l_test02_5_while_body:
    movl    $10, %eax               #  37:     sub    t23 <- 10, i
    movl    i, %ebx                
    subl    %ebx, %eax             
    movl    %, -80(%ebp)           
    leal    a, %eax                 #  38:     &()    t24 <- a
    movl    %, -84(%ebp)           
    movl    i, %eax                 #  39:     mul    t25 <- i, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %, -88(%ebp)           
    leal    a, %eax                 #  40:     &()    t26 <- a
    movl    %, -92(%ebp)           
    movl    -92(%ebp), %eax         #  41:     param  0 <- t26
    pushl   %eax                   
    call    DOFS                    #  42:     call   t27 <- DOFS
    addl    $4, %esp               
    movl    %, -96(%ebp)           
    movl    -88(%ebp), %eax         #  43:     add    t28 <- t25, t27
    movl    -96(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %, -100(%ebp)          
    movl    -84(%ebp), %eax         #  44:     add    t29 <- t24, t28
    movl    -100(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %, -104(%ebp)          
    movl    -80(%ebp), %eax         #  45:     assign @t29 <- t23
    movl    -104(%ebp), %edi       
    movl    %, (%edi)              
    movl    i, %eax                 #  46:     add    t30 <- i, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %, -112(%ebp)          
    movl    -112(%ebp), %eax        #  47:     assign i <- t30
    movl    %, i                   
    jmp     l_test02_4_while_cond   #  48:     goto   4_while_cond
l_test02_3:
    movl    $0, %eax                #  50:     assign i <- 0
    movl    %, i                   
l_test02_11_while_cond:
    # ???   not implemented         #  52:     if     i < 10 goto 12_while_body
    jmp     l_test02_10             #  53:     goto   10
l_test02_12_while_body:
    leal    a, %eax                 #  55:     &()    t31 <- a
    movl    %, -116(%ebp)          
    movl    i, %eax                 #  56:     mul    t32 <- i, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %, -120(%ebp)          
    leal    a, %eax                 #  57:     &()    t33 <- a
    movl    %, -124(%ebp)          
    movl    -124(%ebp), %eax        #  58:     param  0 <- t33
    pushl   %eax                   
    call    DOFS                    #  59:     call   t34 <- DOFS
    addl    $4, %esp               
    movl    %, -128(%ebp)          
    movl    -120(%ebp), %eax        #  60:     add    t35 <- t32, t34
    movl    -128(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %, -132(%ebp)          
    movl    -116(%ebp), %eax        #  61:     add    t36 <- t31, t35
    movl    -132(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %, -136(%ebp)          
    movl    -136(%ebp), %edi       
    movl    (%edi), %eax            #  62:     param  0 <- @t36
    pushl   %eax                   
    call    WriteInt                #  63:     call   WriteInt
    addl    $4, %esp               
    movl    i, %eax                 #  64:     add    t37 <- i, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %, -140(%ebp)          
    movl    -140(%ebp), %eax        #  65:     assign i <- t37
    movl    %, i                   
    jmp     l_test02_11_while_cond  #  66:     goto   11_while_cond
l_test02_10:

l_test02_exit:
    # epilogue
    addl    $152, %esp              # remove locals
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

    # scope: test02
a:                                  # <array 10 of <int>>
.size48
    .long    1
    .long   10
    .skip   40
b:                                  # <bool>
.size1
    .skip    1
c:                                  # <array 2 of <bool>>
.size10
    .long    1
    .long    2
    .skip    2
d:                                  # <array 2 of <array 10 of <bool>>>
.size32
    .long    2
    .long    2
    .long   10
    .skip   20
    .align   4
i:                                  # <int>
.size4
    .skip    4


    # end of global data section
    #-----------------------------------------

    .end
##################################################
