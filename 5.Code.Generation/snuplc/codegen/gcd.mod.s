##################################################
# gcd
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

    # scope gcd_iter
gcd_iter:
    # stack offsets:
    #      8(%ebp)   4  [ %a        <ptr(4) to <array 2 of <int>>> %ebp+8 ]
    #    -16(%ebp)   4  [ $t0       <int> %ebp-16 ]
    #    -20(%ebp)   4  [ $t1       <int> %ebp-20 ]
    #    -24(%ebp)   4  [ $t10      <int> %ebp-24 ]
    #    -28(%ebp)   4  [ $t11      <int> %ebp-28 ]
    #    -32(%ebp)   4  [ $t12      <int> %ebp-32 ]
    #    -36(%ebp)   4  [ $t13      <int> %ebp-36 ]
    #    -40(%ebp)   4  [ $t14      <int> %ebp-40 ]
    #    -44(%ebp)   4  [ $t15      <int> %ebp-44 ]
    #    -48(%ebp)   4  [ $t16      <int> %ebp-48 ]
    #    -52(%ebp)   4  [ $t17      <int> %ebp-52 ]
    #    -56(%ebp)   4  [ $t18      <int> %ebp-56 ]
    #    -60(%ebp)   4  [ $t19      <int> %ebp-60 ]
    #    -64(%ebp)   4  [ $t2       <int> %ebp-64 ]
    #    -68(%ebp)   4  [ $t20      <int> %ebp-68 ]
    #    -72(%ebp)   4  [ $t21      <int> %ebp-72 ]
    #    -76(%ebp)   4  [ $t22      <int> %ebp-76 ]
    #    -80(%ebp)   4  [ $t23      <int> %ebp-80 ]
    #    -84(%ebp)   4  [ $t24      <int> %ebp-84 ]
    #    -88(%ebp)   4  [ $t25      <int> %ebp-88 ]
    #    -92(%ebp)   4  [ $t26      <int> %ebp-92 ]
    #    -96(%ebp)   4  [ $t27      <int> %ebp-96 ]
    #   -100(%ebp)   4  [ $t28      <int> %ebp-100 ]
    #   -104(%ebp)   4  [ $t29      <int> %ebp-104 ]
    #   -108(%ebp)   4  [ $t3       <int> %ebp-108 ]
    #   -112(%ebp)   4  [ $t30      <int> %ebp-112 ]
    #   -116(%ebp)   4  [ $t31      <int> %ebp-116 ]
    #   -120(%ebp)   4  [ $t32      <int> %ebp-120 ]
    #   -124(%ebp)   4  [ $t33      <int> %ebp-124 ]
    #   -128(%ebp)   4  [ $t34      <int> %ebp-128 ]
    #   -132(%ebp)   4  [ $t35      <int> %ebp-132 ]
    #   -136(%ebp)   4  [ $t36      <int> %ebp-136 ]
    #   -140(%ebp)   4  [ $t37      <int> %ebp-140 ]
    #   -144(%ebp)   4  [ $t38      <int> %ebp-144 ]
    #   -148(%ebp)   4  [ $t39      <int> %ebp-148 ]
    #   -152(%ebp)   4  [ $t4       <int> %ebp-152 ]
    #   -156(%ebp)   4  [ $t40      <int> %ebp-156 ]
    #   -160(%ebp)   4  [ $t41      <int> %ebp-160 ]
    #   -164(%ebp)   4  [ $t42      <int> %ebp-164 ]
    #   -168(%ebp)   4  [ $t43      <int> %ebp-168 ]
    #   -172(%ebp)   4  [ $t44      <int> %ebp-172 ]
    #   -176(%ebp)   4  [ $t45      <int> %ebp-176 ]
    #   -180(%ebp)   4  [ $t5       <int> %ebp-180 ]
    #   -184(%ebp)   4  [ $t6       <int> %ebp-184 ]
    #   -188(%ebp)   4  [ $t7       <int> %ebp-188 ]
    #   -192(%ebp)   4  [ $t8       <int> %ebp-192 ]
    #   -196(%ebp)   4  [ $t9       <int> %ebp-196 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $184, %esp              # make room for locals

    cld                             # memset local stack area to 0
    xorl    %eax, %eax             
    movl    $46, %ecx              
    mov     %esp, %edi             
    rep     stosl                  

    # function body
l_gcd_iter_1_while_cond:
    movl    $0, %eax                #   1:     mul    t0 <- 0, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -16(%ebp)        
    movl    8(%ebp), %eax           #   2:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #   3:     call   t1 <- DOFS
    addl    $4, %esp               
    movl    %eax, -20(%ebp)        
    movl    -16(%ebp), %eax         #   4:     add    t2 <- t0, t1
    movl    -20(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -64(%ebp)        
    movl    8(%ebp), %eax           #   5:     add    t3 <- a, t2
    movl    -64(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -108(%ebp)       
    movl    $1, %eax                #   6:     mul    t4 <- 1, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -152(%ebp)       
    movl    8(%ebp), %eax           #   7:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #   8:     call   t5 <- DOFS
    addl    $4, %esp               
    movl    %eax, -180(%ebp)       
    movl    -152(%ebp), %eax        #   9:     add    t6 <- t4, t5
    movl    -180(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -184(%ebp)       
    movl    8(%ebp), %eax           #  10:     add    t7 <- a, t6
    movl    -184(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -188(%ebp)       
    movl    -108(%ebp), %edi       
    movl    (%edi), %eax            #  11:     if     @t3 # @t7 goto 2_while_body
    movl    -188(%ebp), %edi       
    movl    (%edi), %ebx           
    cmpl    %ebx, %eax             
    jne     l_gcd_iter_2_while_body
    jmp     l_gcd_iter_0            #  12:     goto   0
l_gcd_iter_2_while_body:
    movl    $0, %eax                #  14:     mul    t8 <- 0, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -192(%ebp)       
    movl    8(%ebp), %eax           #  15:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  16:     call   t9 <- DOFS
    addl    $4, %esp               
    movl    %eax, -196(%ebp)       
    movl    -192(%ebp), %eax        #  17:     add    t10 <- t8, t9
    movl    -196(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -24(%ebp)        
    movl    8(%ebp), %eax           #  18:     add    t11 <- a, t10
    movl    -24(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -28(%ebp)        
    movl    $1, %eax                #  19:     mul    t12 <- 1, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -32(%ebp)        
    movl    8(%ebp), %eax           #  20:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  21:     call   t13 <- DOFS
    addl    $4, %esp               
    movl    %eax, -36(%ebp)        
    movl    -32(%ebp), %eax         #  22:     add    t14 <- t12, t13
    movl    -36(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -40(%ebp)        
    movl    8(%ebp), %eax           #  23:     add    t15 <- a, t14
    movl    -40(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -44(%ebp)        
    movl    -28(%ebp), %edi        
    movl    (%edi), %eax            #  24:     if     @t11 > @t15 goto 5_if_true
    movl    -44(%ebp), %edi        
    movl    (%edi), %ebx           
    cmpl    %ebx, %eax             
    jg      l_gcd_iter_5_if_true   
    jmp     l_gcd_iter_6_if_false   #  25:     goto   6_if_false
l_gcd_iter_5_if_true:
    movl    $0, %eax                #  27:     mul    t16 <- 0, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -48(%ebp)        
    movl    8(%ebp), %eax           #  28:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  29:     call   t17 <- DOFS
    addl    $4, %esp               
    movl    %eax, -52(%ebp)        
    movl    -48(%ebp), %eax         #  30:     add    t18 <- t16, t17
    movl    -52(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -56(%ebp)        
    movl    8(%ebp), %eax           #  31:     add    t19 <- a, t18
    movl    -56(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -60(%ebp)        
    movl    $1, %eax                #  32:     mul    t20 <- 1, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -68(%ebp)        
    movl    8(%ebp), %eax           #  33:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  34:     call   t21 <- DOFS
    addl    $4, %esp               
    movl    %eax, -72(%ebp)        
    movl    -68(%ebp), %eax         #  35:     add    t22 <- t20, t21
    movl    -72(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -76(%ebp)        
    movl    8(%ebp), %eax           #  36:     add    t23 <- a, t22
    movl    -76(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -80(%ebp)        
    movl    -60(%ebp), %edi        
    movl    (%edi), %eax            #  37:     sub    t24 <- @t19, @t23
    movl    -80(%ebp), %edi        
    movl    (%edi), %ebx           
    subl    %ebx, %eax             
    movl    %eax, -84(%ebp)        
    movl    $0, %eax                #  38:     mul    t25 <- 0, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -88(%ebp)        
    movl    8(%ebp), %eax           #  39:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  40:     call   t26 <- DOFS
    addl    $4, %esp               
    movl    %eax, -92(%ebp)        
    movl    -88(%ebp), %eax         #  41:     add    t27 <- t25, t26
    movl    -92(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -96(%ebp)        
    movl    8(%ebp), %eax           #  42:     add    t28 <- a, t27
    movl    -96(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -100(%ebp)       
    movl    -84(%ebp), %eax         #  43:     assign @t28 <- t24
    movl    -100(%ebp), %edi       
    movl    %eax, (%edi)           
    jmp     l_gcd_iter_4            #  44:     goto   4
l_gcd_iter_6_if_false:
    movl    $1, %eax                #  46:     mul    t29 <- 1, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -104(%ebp)       
    movl    8(%ebp), %eax           #  47:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  48:     call   t30 <- DOFS
    addl    $4, %esp               
    movl    %eax, -112(%ebp)       
    movl    -104(%ebp), %eax        #  49:     add    t31 <- t29, t30
    movl    -112(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -116(%ebp)       
    movl    8(%ebp), %eax           #  50:     add    t32 <- a, t31
    movl    -116(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -120(%ebp)       
    movl    $0, %eax                #  51:     mul    t33 <- 0, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -124(%ebp)       
    movl    8(%ebp), %eax           #  52:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  53:     call   t34 <- DOFS
    addl    $4, %esp               
    movl    %eax, -128(%ebp)       
    movl    -124(%ebp), %eax        #  54:     add    t35 <- t33, t34
    movl    -128(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -132(%ebp)       
    movl    8(%ebp), %eax           #  55:     add    t36 <- a, t35
    movl    -132(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -136(%ebp)       
    movl    -120(%ebp), %edi       
    movl    (%edi), %eax            #  56:     sub    t37 <- @t32, @t36
    movl    -136(%ebp), %edi       
    movl    (%edi), %ebx           
    subl    %ebx, %eax             
    movl    %eax, -140(%ebp)       
    movl    $1, %eax                #  57:     mul    t38 <- 1, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -144(%ebp)       
    movl    8(%ebp), %eax           #  58:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  59:     call   t39 <- DOFS
    addl    $4, %esp               
    movl    %eax, -148(%ebp)       
    movl    -144(%ebp), %eax        #  60:     add    t40 <- t38, t39
    movl    -148(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -156(%ebp)       
    movl    8(%ebp), %eax           #  61:     add    t41 <- a, t40
    movl    -156(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -160(%ebp)       
    movl    -140(%ebp), %eax        #  62:     assign @t41 <- t37
    movl    -160(%ebp), %edi       
    movl    %eax, (%edi)           
l_gcd_iter_4:
    jmp     l_gcd_iter_1_while_cond #  64:     goto   1_while_cond
l_gcd_iter_0:
    movl    $0, %eax                #  66:     mul    t42 <- 0, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -164(%ebp)       
    movl    8(%ebp), %eax           #  67:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  68:     call   t43 <- DOFS
    addl    $4, %esp               
    movl    %eax, -168(%ebp)       
    movl    -164(%ebp), %eax        #  69:     add    t44 <- t42, t43
    movl    -168(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -172(%ebp)       
    movl    8(%ebp), %eax           #  70:     add    t45 <- a, t44
    movl    -172(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -176(%ebp)       
    movl    -176(%ebp), %edi       
    movl    (%edi), %eax            #  71:     return @t45
    jmp     l_gcd_iter_exit        

l_gcd_iter_exit:
    # epilogue
    addl    $184, %esp              # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # scope gcd_mod
gcd_mod:
    # stack offsets:
    #      8(%ebp)   4  [ %a        <ptr(4) to <array 2 of <int>>> %ebp+8 ]
    #    -16(%ebp)   4  [ $t        <int> %ebp-16 ]
    #    -20(%ebp)   4  [ $t0       <int> %ebp-20 ]
    #    -24(%ebp)   4  [ $t1       <int> %ebp-24 ]
    #    -28(%ebp)   4  [ $t10      <int> %ebp-28 ]
    #    -32(%ebp)   4  [ $t11      <int> %ebp-32 ]
    #    -36(%ebp)   4  [ $t12      <int> %ebp-36 ]
    #    -40(%ebp)   4  [ $t13      <int> %ebp-40 ]
    #    -44(%ebp)   4  [ $t14      <int> %ebp-44 ]
    #    -48(%ebp)   4  [ $t15      <int> %ebp-48 ]
    #    -52(%ebp)   4  [ $t16      <int> %ebp-52 ]
    #    -56(%ebp)   4  [ $t17      <int> %ebp-56 ]
    #    -60(%ebp)   4  [ $t18      <int> %ebp-60 ]
    #    -64(%ebp)   4  [ $t19      <int> %ebp-64 ]
    #    -68(%ebp)   4  [ $t2       <int> %ebp-68 ]
    #    -72(%ebp)   4  [ $t20      <int> %ebp-72 ]
    #    -76(%ebp)   4  [ $t21      <int> %ebp-76 ]
    #    -80(%ebp)   4  [ $t22      <int> %ebp-80 ]
    #    -84(%ebp)   4  [ $t23      <int> %ebp-84 ]
    #    -88(%ebp)   4  [ $t24      <int> %ebp-88 ]
    #    -92(%ebp)   4  [ $t25      <int> %ebp-92 ]
    #    -96(%ebp)   4  [ $t26      <int> %ebp-96 ]
    #   -100(%ebp)   4  [ $t27      <int> %ebp-100 ]
    #   -104(%ebp)   4  [ $t28      <int> %ebp-104 ]
    #   -108(%ebp)   4  [ $t29      <int> %ebp-108 ]
    #   -112(%ebp)   4  [ $t3       <int> %ebp-112 ]
    #   -116(%ebp)   4  [ $t30      <int> %ebp-116 ]
    #   -120(%ebp)   4  [ $t4       <int> %ebp-120 ]
    #   -124(%ebp)   4  [ $t5       <int> %ebp-124 ]
    #   -128(%ebp)   4  [ $t6       <int> %ebp-128 ]
    #   -132(%ebp)   4  [ $t7       <int> %ebp-132 ]
    #   -136(%ebp)   4  [ $t8       <int> %ebp-136 ]
    #   -140(%ebp)   4  [ $t9       <int> %ebp-140 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $128, %esp              # make room for locals

    cld                             # memset local stack area to 0
    xorl    %eax, %eax             
    movl    $32, %ecx              
    mov     %esp, %edi             
    rep     stosl                  

    # function body
l_gcd_mod_1_while_cond:
    movl    $1, %eax                #   1:     mul    t0 <- 1, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -20(%ebp)        
    movl    8(%ebp), %eax           #   2:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #   3:     call   t1 <- DOFS
    addl    $4, %esp               
    movl    %eax, -24(%ebp)        
    movl    -20(%ebp), %eax         #   4:     add    t2 <- t0, t1
    movl    -24(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -68(%ebp)        
    movl    8(%ebp), %eax           #   5:     add    t3 <- a, t2
    movl    -68(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -112(%ebp)       
    movl    -112(%ebp), %edi       
    movl    (%edi), %eax            #   6:     if     @t3 # 0 goto 2_while_body
    movl    $0, %ebx               
    cmpl    %ebx, %eax             
    jne     l_gcd_mod_2_while_body 
    jmp     l_gcd_mod_0             #   7:     goto   0
l_gcd_mod_2_while_body:
    movl    $1, %eax                #   9:     mul    t4 <- 1, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -120(%ebp)       
    movl    8(%ebp), %eax           #  10:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  11:     call   t5 <- DOFS
    addl    $4, %esp               
    movl    %eax, -124(%ebp)       
    movl    -120(%ebp), %eax        #  12:     add    t6 <- t4, t5
    movl    -124(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -128(%ebp)       
    movl    8(%ebp), %eax           #  13:     add    t7 <- a, t6
    movl    -128(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -132(%ebp)       
    movl    -132(%ebp), %edi       
    movl    (%edi), %eax            #  14:     assign t <- @t7
    movl    %eax, -16(%ebp)        
    movl    $0, %eax                #  15:     mul    t8 <- 0, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -136(%ebp)       
    movl    8(%ebp), %eax           #  16:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  17:     call   t9 <- DOFS
    addl    $4, %esp               
    movl    %eax, -140(%ebp)       
    movl    -136(%ebp), %eax        #  18:     add    t10 <- t8, t9
    movl    -140(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -28(%ebp)        
    movl    8(%ebp), %eax           #  19:     add    t11 <- a, t10
    movl    -28(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -32(%ebp)        
    movl    $0, %eax                #  20:     mul    t12 <- 0, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -36(%ebp)        
    movl    8(%ebp), %eax           #  21:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  22:     call   t13 <- DOFS
    addl    $4, %esp               
    movl    %eax, -40(%ebp)        
    movl    -36(%ebp), %eax         #  23:     add    t14 <- t12, t13
    movl    -40(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -44(%ebp)        
    movl    8(%ebp), %eax           #  24:     add    t15 <- a, t14
    movl    -44(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -48(%ebp)        
    movl    -48(%ebp), %edi        
    movl    (%edi), %eax            #  25:     div    t16 <- @t15, t
    movl    -16(%ebp), %ebx        
    cdq                            
    idivl   %ebx                   
    movl    %eax, -52(%ebp)        
    movl    -52(%ebp), %eax         #  26:     mul    t17 <- t16, t
    movl    -16(%ebp), %ebx        
    imull   %ebx                   
    movl    %eax, -56(%ebp)        
    movl    -32(%ebp), %edi        
    movl    (%edi), %eax            #  27:     sub    t18 <- @t11, t17
    movl    -56(%ebp), %ebx        
    subl    %ebx, %eax             
    movl    %eax, -60(%ebp)        
    movl    $1, %eax                #  28:     mul    t19 <- 1, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -64(%ebp)        
    movl    8(%ebp), %eax           #  29:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  30:     call   t20 <- DOFS
    addl    $4, %esp               
    movl    %eax, -72(%ebp)        
    movl    -64(%ebp), %eax         #  31:     add    t21 <- t19, t20
    movl    -72(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -76(%ebp)        
    movl    8(%ebp), %eax           #  32:     add    t22 <- a, t21
    movl    -76(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -80(%ebp)        
    movl    -60(%ebp), %eax         #  33:     assign @t22 <- t18
    movl    -80(%ebp), %edi        
    movl    %eax, (%edi)           
    movl    $0, %eax                #  34:     mul    t23 <- 0, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -84(%ebp)        
    movl    8(%ebp), %eax           #  35:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  36:     call   t24 <- DOFS
    addl    $4, %esp               
    movl    %eax, -88(%ebp)        
    movl    -84(%ebp), %eax         #  37:     add    t25 <- t23, t24
    movl    -88(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -92(%ebp)        
    movl    8(%ebp), %eax           #  38:     add    t26 <- a, t25
    movl    -92(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -96(%ebp)        
    movl    -16(%ebp), %eax         #  39:     assign @t26 <- t
    movl    -96(%ebp), %edi        
    movl    %eax, (%edi)           
    jmp     l_gcd_mod_1_while_cond  #  40:     goto   1_while_cond
l_gcd_mod_0:
    movl    $0, %eax                #  42:     mul    t27 <- 0, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -100(%ebp)       
    movl    8(%ebp), %eax           #  43:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  44:     call   t28 <- DOFS
    addl    $4, %esp               
    movl    %eax, -104(%ebp)       
    movl    -100(%ebp), %eax        #  45:     add    t29 <- t27, t28
    movl    -104(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -108(%ebp)       
    movl    8(%ebp), %eax           #  46:     add    t30 <- a, t29
    movl    -108(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -116(%ebp)       
    movl    -116(%ebp), %edi       
    movl    (%edi), %eax            #  47:     return @t30
    jmp     l_gcd_mod_exit         

l_gcd_mod_exit:
    # epilogue
    addl    $128, %esp              # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # scope gcd_rec
gcd_rec:
    # stack offsets:
    #      8(%ebp)   4  [ %a        <ptr(4) to <array 2 of <int>>> %ebp+8 ]
    #    -16(%ebp)   4  [ $t        <int> %ebp-16 ]
    #    -20(%ebp)   4  [ $t0       <int> %ebp-20 ]
    #    -24(%ebp)   4  [ $t1       <int> %ebp-24 ]
    #    -28(%ebp)   4  [ $t10      <int> %ebp-28 ]
    #    -32(%ebp)   4  [ $t11      <int> %ebp-32 ]
    #    -36(%ebp)   4  [ $t12      <int> %ebp-36 ]
    #    -40(%ebp)   4  [ $t13      <int> %ebp-40 ]
    #    -44(%ebp)   4  [ $t14      <int> %ebp-44 ]
    #    -48(%ebp)   4  [ $t15      <int> %ebp-48 ]
    #    -52(%ebp)   4  [ $t16      <int> %ebp-52 ]
    #    -56(%ebp)   4  [ $t17      <int> %ebp-56 ]
    #    -60(%ebp)   4  [ $t18      <int> %ebp-60 ]
    #    -64(%ebp)   4  [ $t19      <int> %ebp-64 ]
    #    -68(%ebp)   4  [ $t2       <int> %ebp-68 ]
    #    -72(%ebp)   4  [ $t20      <int> %ebp-72 ]
    #    -76(%ebp)   4  [ $t21      <int> %ebp-76 ]
    #    -80(%ebp)   4  [ $t22      <int> %ebp-80 ]
    #    -84(%ebp)   4  [ $t23      <int> %ebp-84 ]
    #    -88(%ebp)   4  [ $t24      <int> %ebp-88 ]
    #    -92(%ebp)   4  [ $t25      <int> %ebp-92 ]
    #    -96(%ebp)   4  [ $t26      <int> %ebp-96 ]
    #   -100(%ebp)   4  [ $t27      <int> %ebp-100 ]
    #   -104(%ebp)   4  [ $t28      <int> %ebp-104 ]
    #   -108(%ebp)   4  [ $t29      <int> %ebp-108 ]
    #   -112(%ebp)   4  [ $t3       <int> %ebp-112 ]
    #   -116(%ebp)   4  [ $t30      <int> %ebp-116 ]
    #   -120(%ebp)   4  [ $t31      <int> %ebp-120 ]
    #   -124(%ebp)   4  [ $t32      <int> %ebp-124 ]
    #   -128(%ebp)   4  [ $t33      <int> %ebp-128 ]
    #   -132(%ebp)   4  [ $t34      <int> %ebp-132 ]
    #   -136(%ebp)   4  [ $t35      <int> %ebp-136 ]
    #   -140(%ebp)   4  [ $t4       <int> %ebp-140 ]
    #   -144(%ebp)   4  [ $t5       <int> %ebp-144 ]
    #   -148(%ebp)   4  [ $t6       <int> %ebp-148 ]
    #   -152(%ebp)   4  [ $t7       <int> %ebp-152 ]
    #   -156(%ebp)   4  [ $t8       <int> %ebp-156 ]
    #   -160(%ebp)   4  [ $t9       <int> %ebp-160 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $148, %esp              # make room for locals

    cld                             # memset local stack area to 0
    xorl    %eax, %eax             
    movl    $37, %ecx              
    mov     %esp, %edi             
    rep     stosl                  

    # function body
    movl    $1, %eax                #   0:     mul    t0 <- 1, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -20(%ebp)        
    movl    8(%ebp), %eax           #   1:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #   2:     call   t1 <- DOFS
    addl    $4, %esp               
    movl    %eax, -24(%ebp)        
    movl    -20(%ebp), %eax         #   3:     add    t2 <- t0, t1
    movl    -24(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -68(%ebp)        
    movl    8(%ebp), %eax           #   4:     add    t3 <- a, t2
    movl    -68(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -112(%ebp)       
    movl    -112(%ebp), %edi       
    movl    (%edi), %eax            #   5:     if     @t3 = 0 goto 1_if_true
    movl    $0, %ebx               
    cmpl    %ebx, %eax             
    je      l_gcd_rec_1_if_true    
    jmp     l_gcd_rec_2_if_false    #   6:     goto   2_if_false
l_gcd_rec_1_if_true:
    movl    $0, %eax                #   8:     mul    t4 <- 0, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -140(%ebp)       
    movl    8(%ebp), %eax           #   9:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  10:     call   t5 <- DOFS
    addl    $4, %esp               
    movl    %eax, -144(%ebp)       
    movl    -140(%ebp), %eax        #  11:     add    t6 <- t4, t5
    movl    -144(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -148(%ebp)       
    movl    8(%ebp), %eax           #  12:     add    t7 <- a, t6
    movl    -148(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -152(%ebp)       
    movl    -152(%ebp), %edi       
    movl    (%edi), %eax            #  13:     return @t7
    jmp     l_gcd_rec_exit         
    jmp     l_gcd_rec_0             #  14:     goto   0
l_gcd_rec_2_if_false:
    movl    $0, %eax                #  16:     mul    t8 <- 0, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -156(%ebp)       
    movl    8(%ebp), %eax           #  17:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  18:     call   t9 <- DOFS
    addl    $4, %esp               
    movl    %eax, -160(%ebp)       
    movl    -156(%ebp), %eax        #  19:     add    t10 <- t8, t9
    movl    -160(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -28(%ebp)        
    movl    8(%ebp), %eax           #  20:     add    t11 <- a, t10
    movl    -28(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -32(%ebp)        
    movl    -32(%ebp), %edi        
    movl    (%edi), %eax            #  21:     assign t <- @t11
    movl    %eax, -16(%ebp)        
    movl    $1, %eax                #  22:     mul    t12 <- 1, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -36(%ebp)        
    movl    8(%ebp), %eax           #  23:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  24:     call   t13 <- DOFS
    addl    $4, %esp               
    movl    %eax, -40(%ebp)        
    movl    -36(%ebp), %eax         #  25:     add    t14 <- t12, t13
    movl    -40(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -44(%ebp)        
    movl    8(%ebp), %eax           #  26:     add    t15 <- a, t14
    movl    -44(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -48(%ebp)        
    movl    $0, %eax                #  27:     mul    t16 <- 0, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -52(%ebp)        
    movl    8(%ebp), %eax           #  28:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  29:     call   t17 <- DOFS
    addl    $4, %esp               
    movl    %eax, -56(%ebp)        
    movl    -52(%ebp), %eax         #  30:     add    t18 <- t16, t17
    movl    -56(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -60(%ebp)        
    movl    8(%ebp), %eax           #  31:     add    t19 <- a, t18
    movl    -60(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -64(%ebp)        
    movl    -48(%ebp), %edi        
    movl    (%edi), %eax            #  32:     assign @t19 <- @t15
    movl    -64(%ebp), %edi        
    movl    %eax, (%edi)           
    movl    $1, %eax                #  33:     mul    t20 <- 1, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -72(%ebp)        
    movl    8(%ebp), %eax           #  34:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  35:     call   t21 <- DOFS
    addl    $4, %esp               
    movl    %eax, -76(%ebp)        
    movl    -72(%ebp), %eax         #  36:     add    t22 <- t20, t21
    movl    -76(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -80(%ebp)        
    movl    8(%ebp), %eax           #  37:     add    t23 <- a, t22
    movl    -80(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -84(%ebp)        
    movl    -16(%ebp), %eax         #  38:     div    t24 <- t, @t23
    movl    -84(%ebp), %edi        
    movl    (%edi), %ebx           
    cdq                            
    idivl   %ebx                   
    movl    %eax, -88(%ebp)        
    movl    $1, %eax                #  39:     mul    t25 <- 1, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -92(%ebp)        
    movl    8(%ebp), %eax           #  40:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  41:     call   t26 <- DOFS
    addl    $4, %esp               
    movl    %eax, -96(%ebp)        
    movl    -92(%ebp), %eax         #  42:     add    t27 <- t25, t26
    movl    -96(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -100(%ebp)       
    movl    8(%ebp), %eax           #  43:     add    t28 <- a, t27
    movl    -100(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -104(%ebp)       
    movl    -88(%ebp), %eax         #  44:     mul    t29 <- t24, @t28
    movl    -104(%ebp), %edi       
    movl    (%edi), %ebx           
    imull   %ebx                   
    movl    %eax, -108(%ebp)       
    movl    -16(%ebp), %eax         #  45:     sub    t30 <- t, t29
    movl    -108(%ebp), %ebx       
    subl    %ebx, %eax             
    movl    %eax, -116(%ebp)       
    movl    $1, %eax                #  46:     mul    t31 <- 1, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -120(%ebp)       
    movl    8(%ebp), %eax           #  47:     param  0 <- a
    pushl   %eax                   
    call    DOFS                    #  48:     call   t32 <- DOFS
    addl    $4, %esp               
    movl    %eax, -124(%ebp)       
    movl    -120(%ebp), %eax        #  49:     add    t33 <- t31, t32
    movl    -124(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -128(%ebp)       
    movl    8(%ebp), %eax           #  50:     add    t34 <- a, t33
    movl    -128(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -132(%ebp)       
    movl    -116(%ebp), %eax        #  51:     assign @t34 <- t30
    movl    -132(%ebp), %edi       
    movl    %eax, (%edi)           
    movl    8(%ebp), %eax           #  52:     param  0 <- a
    pushl   %eax                   
    call    gcd_rec                 #  53:     call   t35 <- gcd_rec
    addl    $4, %esp               
    movl    %eax, -136(%ebp)       
    movl    -136(%ebp), %eax        #  54:     return t35
    jmp     l_gcd_rec_exit         
l_gcd_rec_0:

l_gcd_rec_exit:
    # epilogue
    addl    $148, %esp              # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # scope ReadNumbers
ReadNumbers:
    # stack offsets:
    #    -16(%ebp)   4  [ $i        <int> %ebp-16 ]
    #      8(%ebp)   4  [ %n        <ptr(4) to <array 2 of <int>>> %ebp+8 ]
    #    -20(%ebp)   4  [ $t0       <ptr(4) to <array 22 of <char>>> %ebp-20 ]
    #    -24(%ebp)   4  [ $t1       <int> %ebp-24 ]
    #    -28(%ebp)   4  [ $t10      <int> %ebp-28 ]
    #    -32(%ebp)   4  [ $t11      <int> %ebp-32 ]
    #    -36(%ebp)   4  [ $t2       <int> %ebp-36 ]
    #    -40(%ebp)   4  [ $t3       <int> %ebp-40 ]
    #    -44(%ebp)   4  [ $t4       <int> %ebp-44 ]
    #    -48(%ebp)   4  [ $t5       <int> %ebp-48 ]
    #    -52(%ebp)   4  [ $t6       <ptr(4) to <array 22 of <char>>> %ebp-52 ]
    #    -56(%ebp)   4  [ $t7       <int> %ebp-56 ]
    #    -60(%ebp)   4  [ $t8       <int> %ebp-60 ]
    #    -64(%ebp)   4  [ $t9       <int> %ebp-64 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $52, %esp               # make room for locals

    cld                             # memset local stack area to 0
    xorl    %eax, %eax             
    movl    $13, %ecx              
    mov     %esp, %edi             
    rep     stosl                  

    # function body
    leal    _str_24, %eax           #   0:     &()    t0 <- _str_24
    movl    %eax, -20(%ebp)        
    movl    -20(%ebp), %eax         #   1:     param  0 <- t0
    pushl   %eax                   
    call    WriteStr                #   2:     call   WriteStr
    addl    $4, %esp               
    call    ReadInt                 #   3:     call   t1 <- ReadInt
    movl    %eax, -24(%ebp)        
    movl    $0, %eax                #   4:     mul    t2 <- 0, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -36(%ebp)        
    movl    8(%ebp), %eax           #   5:     param  0 <- n
    pushl   %eax                   
    call    DOFS                    #   6:     call   t3 <- DOFS
    addl    $4, %esp               
    movl    %eax, -40(%ebp)        
    movl    -36(%ebp), %eax         #   7:     add    t4 <- t2, t3
    movl    -40(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -44(%ebp)        
    movl    8(%ebp), %eax           #   8:     add    t5 <- n, t4
    movl    -44(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -48(%ebp)        
    movl    -24(%ebp), %eax         #   9:     assign @t5 <- t1
    movl    -48(%ebp), %edi        
    movl    %eax, (%edi)           
    leal    _str_25, %eax           #  10:     &()    t6 <- _str_25
    movl    %eax, -52(%ebp)        
    movl    -52(%ebp), %eax         #  11:     param  0 <- t6
    pushl   %eax                   
    call    WriteStr                #  12:     call   WriteStr
    addl    $4, %esp               
    call    ReadInt                 #  13:     call   t7 <- ReadInt
    movl    %eax, -56(%ebp)        
    movl    $1, %eax                #  14:     mul    t8 <- 1, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -60(%ebp)        
    movl    8(%ebp), %eax           #  15:     param  0 <- n
    pushl   %eax                   
    call    DOFS                    #  16:     call   t9 <- DOFS
    addl    $4, %esp               
    movl    %eax, -64(%ebp)        
    movl    -60(%ebp), %eax         #  17:     add    t10 <- t8, t9
    movl    -64(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -28(%ebp)        
    movl    8(%ebp), %eax           #  18:     add    t11 <- n, t10
    movl    -28(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -32(%ebp)        
    movl    -56(%ebp), %eax         #  19:     assign @t11 <- t7
    movl    -32(%ebp), %edi        
    movl    %eax, (%edi)           

l_ReadNumbers_exit:
    # epilogue
    addl    $52, %esp               # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # scope gcd
main:
    # stack offsets:
    #    -16(%ebp)   4  [ $t0       <ptr(4) to <array 25 of <char>>> %ebp-16 ]
    #    -20(%ebp)   4  [ $t1       <ptr(4) to <array 2 of <int>>> %ebp-20 ]
    #    -24(%ebp)   4  [ $t10      <int> %ebp-24 ]
    #    -28(%ebp)   4  [ $t2       <ptr(4) to <array 14 of <char>>> %ebp-28 ]
    #    -32(%ebp)   4  [ $t3       <ptr(4) to <array 2 of <int>>> %ebp-32 ]
    #    -36(%ebp)   4  [ $t4       <int> %ebp-36 ]
    #    -40(%ebp)   4  [ $t5       <ptr(4) to <array 14 of <char>>> %ebp-40 ]
    #    -44(%ebp)   4  [ $t6       <ptr(4) to <array 2 of <int>>> %ebp-44 ]
    #    -48(%ebp)   4  [ $t7       <int> %ebp-48 ]
    #    -52(%ebp)   4  [ $t8       <ptr(4) to <array 14 of <char>>> %ebp-52 ]
    #    -56(%ebp)   4  [ $t9       <ptr(4) to <array 2 of <int>>> %ebp-56 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $44, %esp               # make room for locals

    cld                             # memset local stack area to 0
    xorl    %eax, %eax             
    movl    $11, %ecx              
    mov     %esp, %edi             
    rep     stosl                  

    # function body
    leal    _str_26, %eax           #   0:     &()    t0 <- _str_26
    movl    %eax, -16(%ebp)        
    movl    -16(%ebp), %eax         #   1:     param  0 <- t0
    pushl   %eax                   
    call    WriteStr                #   2:     call   WriteStr
    addl    $4, %esp               
    call    WriteLn                 #   3:     call   WriteLn
    call    WriteLn                 #   4:     call   WriteLn
    leal    n, %eax                 #   5:     &()    t1 <- n
    movl    %eax, -20(%ebp)        
    movl    -20(%ebp), %eax         #   6:     param  0 <- t1
    pushl   %eax                   
    call    ReadNumbers             #   7:     call   ReadNumbers
    addl    $4, %esp               
    leal    _str_27, %eax           #   8:     &()    t2 <- _str_27
    movl    %eax, -28(%ebp)        
    movl    -28(%ebp), %eax         #   9:     param  0 <- t2
    pushl   %eax                   
    call    WriteStr                #  10:     call   WriteStr
    addl    $4, %esp               
    leal    n, %eax                 #  11:     &()    t3 <- n
    movl    %eax, -32(%ebp)        
    movl    -32(%ebp), %eax         #  12:     param  0 <- t3
    pushl   %eax                   
    call    gcd_iter                #  13:     call   t4 <- gcd_iter
    addl    $4, %esp               
    movl    %eax, -36(%ebp)        
    movl    -36(%ebp), %eax         #  14:     param  0 <- t4
    pushl   %eax                   
    call    WriteInt                #  15:     call   WriteInt
    addl    $4, %esp               
    call    WriteLn                 #  16:     call   WriteLn
    leal    _str_28, %eax           #  17:     &()    t5 <- _str_28
    movl    %eax, -40(%ebp)        
    movl    -40(%ebp), %eax         #  18:     param  0 <- t5
    pushl   %eax                   
    call    WriteStr                #  19:     call   WriteStr
    addl    $4, %esp               
    leal    n, %eax                 #  20:     &()    t6 <- n
    movl    %eax, -44(%ebp)        
    movl    -44(%ebp), %eax         #  21:     param  0 <- t6
    pushl   %eax                   
    call    gcd_mod                 #  22:     call   t7 <- gcd_mod
    addl    $4, %esp               
    movl    %eax, -48(%ebp)        
    movl    -48(%ebp), %eax         #  23:     param  0 <- t7
    pushl   %eax                   
    call    WriteInt                #  24:     call   WriteInt
    addl    $4, %esp               
    call    WriteLn                 #  25:     call   WriteLn
    leal    _str_29, %eax           #  26:     &()    t8 <- _str_29
    movl    %eax, -52(%ebp)        
    movl    -52(%ebp), %eax         #  27:     param  0 <- t8
    pushl   %eax                   
    call    WriteStr                #  28:     call   WriteStr
    addl    $4, %esp               
    leal    n, %eax                 #  29:     &()    t9 <- n
    movl    %eax, -56(%ebp)        
    movl    -56(%ebp), %eax         #  30:     param  0 <- t9
    pushl   %eax                   
    call    gcd_rec                 #  31:     call   t10 <- gcd_rec
    addl    $4, %esp               
    movl    %eax, -24(%ebp)        
    movl    -24(%ebp), %eax         #  32:     param  0 <- t10
    pushl   %eax                   
    call    WriteInt                #  33:     call   WriteInt
    addl    $4, %esp               
    call    WriteLn                 #  34:     call   WriteLn

l_gcd_exit:
    # epilogue
    addl    $44, %esp               # remove locals
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

    # scope: gcd
_str_24:                            # <array 22 of <char>>
    .long    1
    .long   22
    .asciz "Enter first number : "
    .align   4
_str_25:                            # <array 22 of <char>>
    .long    1
    .long   22
    .asciz "Enter second number: "
    .align   4
_str_26:                            # <array 25 of <char>>
    .long    1
    .long   25
    .asciz "Greatest commond divisor"
    .align   4
_str_27:                            # <array 14 of <char>>
    .long    1
    .long   14
    .asciz " subtract  : "
    .align   4
_str_28:                            # <array 14 of <char>>
    .long    1
    .long   14
    .asciz " divide    : "
    .align   4
_str_29:                            # <array 14 of <char>>
    .long    1
    .long   14
    .asciz " recursive : "
    .align   4
n:                                  # <array 2 of <int>>
    .long    1
    .long    2
    .skip    8





    # end of global data section
    #-----------------------------------------

    .end
##################################################
