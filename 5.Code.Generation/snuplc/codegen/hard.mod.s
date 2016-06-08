##################################################
# hardcore
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

    # scope fint
fint:
    # stack offsets:
    #     12(%ebp)   1  [ %B        <bool> %ebp+12 ]
    #     16(%ebp)   4  [ %C        <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp+16 ]
    #      8(%ebp)   4  [ %a        <int> %ebp+8 ]
    #    -16(%ebp)   4  [ $b        <int> %ebp-16 ]
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
    #   -140(%ebp)   4  [ $t36      <int> %ebp-140 ]
    #   -144(%ebp)   4  [ $t37      <int> %ebp-144 ]
    #   -148(%ebp)   4  [ $t38      <int> %ebp-148 ]
    #   -152(%ebp)   4  [ $t39      <int> %ebp-152 ]
    #   -156(%ebp)   4  [ $t4       <int> %ebp-156 ]
    #   -160(%ebp)   4  [ $t40      <int> %ebp-160 ]
    #   -164(%ebp)   4  [ $t41      <int> %ebp-164 ]
    #   -165(%ebp)   1  [ $t42      <bool> %ebp-165 ]
    #   -172(%ebp)   4  [ $t43      <int> %ebp-172 ]
    #   -176(%ebp)   4  [ $t44      <int> %ebp-176 ]
    #   -180(%ebp)   4  [ $t45      <int> %ebp-180 ]
    #   -184(%ebp)   4  [ $t5       <int> %ebp-184 ]
    #   -188(%ebp)   4  [ $t6       <int> %ebp-188 ]
    #   -192(%ebp)   4  [ $t7       <int> %ebp-192 ]
    #   -196(%ebp)   4  [ $t8       <int> %ebp-196 ]
    #   -200(%ebp)   4  [ $t9       <int> %ebp-200 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $188, %esp              # make room for locals

    cld                             # memset local stack area to 0
    xorl    %eax, %eax             
    movl    $47, %ecx              
    mov     %esp, %edi             
    rep     stosl                  

    # function body
    movl    -16(%ebp), %eax         #   0:     if     b # 0 goto 3
    movl    $0, %ebx               
    cmpl    %ebx, %eax             
    jne     l_fint_3               
    jmp     l_fint_2_if_false       #   1:     goto   2_if_false
l_fint_3:
    movzbl  12(%ebp), %eax          #   3:     if     B = 1 goto 1_if_true
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_fint_1_if_true       
    jmp     l_fint_2_if_false       #   4:     goto   2_if_false
l_fint_1_if_true:
    movl    8(%ebp), %eax           #   6:     neg    t0 <- a
    negl    %eax                   
    movl    %eax, -20(%ebp)        
    movl    $2, %eax                #   7:     param  1 <- 2
    pushl   %eax                   
    movl    16(%ebp), %eax          #   8:     param  0 <- C
    pushl   %eax                   
    call    DIM                     #   9:     call   t1 <- DIM
    addl    $8, %esp               
    movl    %eax, -24(%ebp)        
    movl    $1, %eax                #  10:     mul    t2 <- 1, t1
    movl    -24(%ebp), %ebx        
    imull   %ebx                   
    movl    %eax, -68(%ebp)        
    movl    -68(%ebp), %eax         #  11:     add    t3 <- t2, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -112(%ebp)       
    movl    $3, %eax                #  12:     param  1 <- 3
    pushl   %eax                   
    movl    16(%ebp), %eax          #  13:     param  0 <- C
    pushl   %eax                   
    call    DIM                     #  14:     call   t4 <- DIM
    addl    $8, %esp               
    movl    %eax, -156(%ebp)       
    movl    -112(%ebp), %eax        #  15:     mul    t5 <- t3, t4
    movl    -156(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -184(%ebp)       
    movl    -184(%ebp), %eax        #  16:     add    t6 <- t5, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -188(%ebp)       
    movl    -188(%ebp), %eax        #  17:     mul    t7 <- t6, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -192(%ebp)       
    movl    16(%ebp), %eax          #  18:     param  0 <- C
    pushl   %eax                   
    call    DOFS                    #  19:     call   t8 <- DOFS
    addl    $4, %esp               
    movl    %eax, -196(%ebp)       
    movl    -192(%ebp), %eax        #  20:     add    t9 <- t7, t8
    movl    -196(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -200(%ebp)       
    movl    16(%ebp), %eax          #  21:     add    t10 <- C, t9
    movl    -200(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -28(%ebp)        
    movl    -20(%ebp), %eax         #  22:     add    t11 <- t0, @t10
    movl    -28(%ebp), %edi        
    movl    (%edi), %ebx           
    addl    %ebx, %eax             
    movl    %eax, -32(%ebp)        
    movl    -32(%ebp), %eax         #  23:     return t11
    jmp     l_fint_exit            
    jmp     l_fint_0                #  24:     goto   0
l_fint_2_if_false:
    movl    $2, %eax                #  26:     param  1 <- 2
    pushl   %eax                   
    movl    16(%ebp), %eax          #  27:     param  0 <- C
    pushl   %eax                   
    call    DIM                     #  28:     call   t12 <- DIM
    addl    $8, %esp               
    movl    %eax, -36(%ebp)        
    movl    $0, %eax                #  29:     mul    t13 <- 0, t12
    movl    -36(%ebp), %ebx        
    imull   %ebx                   
    movl    %eax, -40(%ebp)        
    movl    -40(%ebp), %eax         #  30:     add    t14 <- t13, a
    movl    8(%ebp), %ebx          
    addl    %ebx, %eax             
    movl    %eax, -44(%ebp)        
    movl    $3, %eax                #  31:     param  1 <- 3
    pushl   %eax                   
    movl    16(%ebp), %eax          #  32:     param  0 <- C
    pushl   %eax                   
    call    DIM                     #  33:     call   t15 <- DIM
    addl    $8, %esp               
    movl    %eax, -48(%ebp)        
    movl    -44(%ebp), %eax         #  34:     mul    t16 <- t14, t15
    movl    -48(%ebp), %ebx        
    imull   %ebx                   
    movl    %eax, -52(%ebp)        
    movl    -52(%ebp), %eax         #  35:     add    t17 <- t16, 7
    movl    $7, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -56(%ebp)        
    movl    -56(%ebp), %eax         #  36:     mul    t18 <- t17, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -60(%ebp)        
    movl    16(%ebp), %eax          #  37:     param  0 <- C
    pushl   %eax                   
    call    DOFS                    #  38:     call   t19 <- DOFS
    addl    $4, %esp               
    movl    %eax, -64(%ebp)        
    movl    -60(%ebp), %eax         #  39:     add    t20 <- t18, t19
    movl    -64(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -72(%ebp)        
    movl    16(%ebp), %eax          #  40:     add    t21 <- C, t20
    movl    -72(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -76(%ebp)        
    movl    $2, %eax                #  41:     param  1 <- 2
    pushl   %eax                   
    movl    16(%ebp), %eax          #  42:     param  0 <- C
    pushl   %eax                   
    call    DIM                     #  43:     call   t22 <- DIM
    addl    $8, %esp               
    movl    %eax, -80(%ebp)        
    movl    $0, %eax                #  44:     mul    t23 <- 0, t22
    movl    -80(%ebp), %ebx        
    imull   %ebx                   
    movl    %eax, -84(%ebp)        
    movl    -84(%ebp), %eax         #  45:     add    t24 <- t23, 0
    movl    $0, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -88(%ebp)        
    movl    $3, %eax                #  46:     param  1 <- 3
    pushl   %eax                   
    movl    16(%ebp), %eax          #  47:     param  0 <- C
    pushl   %eax                   
    call    DIM                     #  48:     call   t25 <- DIM
    addl    $8, %esp               
    movl    %eax, -92(%ebp)        
    movl    -88(%ebp), %eax         #  49:     mul    t26 <- t24, t25
    movl    -92(%ebp), %ebx        
    imull   %ebx                   
    movl    %eax, -96(%ebp)        
    movl    $2, %eax                #  50:     param  1 <- 2
    pushl   %eax                   
    movl    16(%ebp), %eax          #  51:     param  0 <- C
    pushl   %eax                   
    call    DIM                     #  52:     call   t27 <- DIM
    addl    $8, %esp               
    movl    %eax, -100(%ebp)       
    movl    8(%ebp), %eax           #  53:     mul    t28 <- a, t27
    movl    -100(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -104(%ebp)       
    movl    -104(%ebp), %eax        #  54:     add    t29 <- t28, a
    movl    8(%ebp), %ebx          
    addl    %ebx, %eax             
    movl    %eax, -108(%ebp)       
    movl    $3, %eax                #  55:     param  1 <- 3
    pushl   %eax                   
    movl    16(%ebp), %eax          #  56:     param  0 <- C
    pushl   %eax                   
    call    DIM                     #  57:     call   t30 <- DIM
    addl    $8, %esp               
    movl    %eax, -116(%ebp)       
    movl    -108(%ebp), %eax        #  58:     mul    t31 <- t29, t30
    movl    -116(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -120(%ebp)       
    movl    -120(%ebp), %eax        #  59:     add    t32 <- t31, a
    movl    8(%ebp), %ebx          
    addl    %ebx, %eax             
    movl    %eax, -124(%ebp)       
    movl    -124(%ebp), %eax        #  60:     mul    t33 <- t32, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -128(%ebp)       
    movl    16(%ebp), %eax          #  61:     param  0 <- C
    pushl   %eax                   
    call    DOFS                    #  62:     call   t34 <- DOFS
    addl    $4, %esp               
    movl    %eax, -132(%ebp)       
    movl    -128(%ebp), %eax        #  63:     add    t35 <- t33, t34
    movl    -132(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -136(%ebp)       
    movl    16(%ebp), %eax          #  64:     add    t36 <- C, t35
    movl    -136(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -140(%ebp)       
    movl    -96(%ebp), %eax         #  65:     add    t37 <- t26, @t36
    movl    -140(%ebp), %edi       
    movl    (%edi), %ebx           
    addl    %ebx, %eax             
    movl    %eax, -144(%ebp)       
    movl    -144(%ebp), %eax        #  66:     mul    t38 <- t37, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -148(%ebp)       
    movl    16(%ebp), %eax          #  67:     param  0 <- C
    pushl   %eax                   
    call    DOFS                    #  68:     call   t39 <- DOFS
    addl    $4, %esp               
    movl    %eax, -152(%ebp)       
    movl    -148(%ebp), %eax        #  69:     add    t40 <- t38, t39
    movl    -152(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -160(%ebp)       
    movl    16(%ebp), %eax          #  70:     add    t41 <- C, t40
    movl    -160(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -164(%ebp)       
    movl    -76(%ebp), %edi        
    movl    (%edi), %eax            #  71:     if     @t21 # @t41 goto 7_if_true
    movl    -164(%ebp), %edi       
    movl    (%edi), %ebx           
    cmpl    %ebx, %eax             
    jne     l_fint_7_if_true       
    jmp     l_fint_8_if_false       #  72:     goto   8_if_false
l_fint_7_if_true:
    jmp     l_fint_6                #  74:     goto   6
l_fint_8_if_false:
    movl    16(%ebp), %eax          #  76:     param  2 <- C
    pushl   %eax                   
    movzbl  12(%ebp), %eax          #  77:     if     B = 1 goto 12
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_fint_12              
    movl    $1, %eax                #  78:     assign t42 <- 1
    movb    %al, -165(%ebp)        
    jmp     l_fint_13               #  79:     goto   13
l_fint_12:
    movl    $0, %eax                #  81:     assign t42 <- 0
    movb    %al, -165(%ebp)        
l_fint_13:
    movzbl  -165(%ebp), %eax        #  83:     param  1 <- t42
    pushl   %eax                   
    movl    8(%ebp), %eax           #  84:     sub    t43 <- a, 1
    movl    $1, %ebx               
    subl    %ebx, %eax             
    movl    %eax, -172(%ebp)       
    movl    -172(%ebp), %eax        #  85:     param  0 <- t43
    pushl   %eax                   
    call    fint                    #  86:     call   t44 <- fint
    addl    $12, %esp              
    movl    %eax, -176(%ebp)       
    movl    -176(%ebp), %eax        #  87:     pos    t45 <- t44
    movl    %eax, -180(%ebp)       
    movl    -180(%ebp), %eax        #  88:     return t45
    jmp     l_fint_exit            
l_fint_6:
l_fint_0:

l_fint_exit:
    # epilogue
    addl    $188, %esp              # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # scope fbool
fbool:
    # stack offsets:
    #     12(%ebp)   1  [ %B        <bool> %ebp+12 ]
    #     16(%ebp)   4  [ %C        <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp+16 ]
    #      8(%ebp)   4  [ %a        <int> %ebp+8 ]
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
    #   -109(%ebp)   1  [ $t30      <bool> %ebp-109 ]
    #   -116(%ebp)   4  [ $t4       <int> %ebp-116 ]
    #   -120(%ebp)   4  [ $t5       <int> %ebp-120 ]
    #   -124(%ebp)   4  [ $t6       <int> %ebp-124 ]
    #   -128(%ebp)   4  [ $t7       <int> %ebp-128 ]
    #   -132(%ebp)   4  [ $t8       <int> %ebp-132 ]
    #   -136(%ebp)   4  [ $t9       <int> %ebp-136 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $124, %esp              # make room for locals

    cld                             # memset local stack area to 0
    xorl    %eax, %eax             
    movl    $31, %ecx              
    mov     %esp, %edi             
    rep     stosl                  

    # function body
    movl    $2, %eax                #   0:     param  1 <- 2
    pushl   %eax                   
    movl    16(%ebp), %eax          #   1:     param  0 <- C
    pushl   %eax                   
    call    DIM                     #   2:     call   t0 <- DIM
    addl    $8, %esp               
    movl    %eax, -16(%ebp)        
    movl    8(%ebp), %eax           #   3:     mul    t1 <- a, t0
    movl    -16(%ebp), %ebx        
    imull   %ebx                   
    movl    %eax, -20(%ebp)        
    movl    -20(%ebp), %eax         #   4:     add    t2 <- t1, 7
    movl    $7, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -64(%ebp)        
    movl    $3, %eax                #   5:     param  1 <- 3
    pushl   %eax                   
    movl    16(%ebp), %eax          #   6:     param  0 <- C
    pushl   %eax                   
    call    DIM                     #   7:     call   t3 <- DIM
    addl    $8, %esp               
    movl    %eax, -108(%ebp)       
    movl    -64(%ebp), %eax         #   8:     mul    t4 <- t2, t3
    movl    -108(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -116(%ebp)       
    movl    -116(%ebp), %eax        #   9:     add    t5 <- t4, a
    movl    8(%ebp), %ebx          
    addl    %ebx, %eax             
    movl    %eax, -120(%ebp)       
    movl    -120(%ebp), %eax        #  10:     mul    t6 <- t5, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -124(%ebp)       
    movl    16(%ebp), %eax          #  11:     param  0 <- C
    pushl   %eax                   
    call    DOFS                    #  12:     call   t7 <- DOFS
    addl    $4, %esp               
    movl    %eax, -128(%ebp)       
    movl    -124(%ebp), %eax        #  13:     add    t8 <- t6, t7
    movl    -128(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -132(%ebp)       
    movl    16(%ebp), %eax          #  14:     add    t9 <- C, t8
    movl    -132(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -136(%ebp)       
    movl    $7, %eax                #  15:     assign @t9 <- 7
    movl    -136(%ebp), %edi       
    movl    %eax, (%edi)           
l_fbool_2_while_cond:
    movzbl  12(%ebp), %eax          #  17:     if     B = 1 goto 4
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_fbool_4              
    jmp     l_fbool_1               #  18:     goto   1
l_fbool_4:
    movl    $2, %eax                #  20:     param  1 <- 2
    pushl   %eax                   
    movl    16(%ebp), %eax          #  21:     param  0 <- C
    pushl   %eax                   
    call    DIM                     #  22:     call   t10 <- DIM
    addl    $8, %esp               
    movl    %eax, -24(%ebp)        
    movl    $3, %eax                #  23:     mul    t11 <- 3, t10
    movl    -24(%ebp), %ebx        
    imull   %ebx                   
    movl    %eax, -28(%ebp)        
    movl    -28(%ebp), %eax         #  24:     add    t12 <- t11, a
    movl    8(%ebp), %ebx          
    addl    %ebx, %eax             
    movl    %eax, -32(%ebp)        
    movl    $3, %eax                #  25:     param  1 <- 3
    pushl   %eax                   
    movl    16(%ebp), %eax          #  26:     param  0 <- C
    pushl   %eax                   
    call    DIM                     #  27:     call   t13 <- DIM
    addl    $8, %esp               
    movl    %eax, -36(%ebp)        
    movl    -32(%ebp), %eax         #  28:     mul    t14 <- t12, t13
    movl    -36(%ebp), %ebx        
    imull   %ebx                   
    movl    %eax, -40(%ebp)        
    movl    -40(%ebp), %eax         #  29:     add    t15 <- t14, 0
    movl    $0, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -44(%ebp)        
    movl    -44(%ebp), %eax         #  30:     mul    t16 <- t15, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -48(%ebp)        
    movl    16(%ebp), %eax          #  31:     param  0 <- C
    pushl   %eax                   
    call    DOFS                    #  32:     call   t17 <- DOFS
    addl    $4, %esp               
    movl    %eax, -52(%ebp)        
    movl    -48(%ebp), %eax         #  33:     add    t18 <- t16, t17
    movl    -52(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -56(%ebp)        
    movl    16(%ebp), %eax          #  34:     add    t19 <- C, t18
    movl    -56(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -60(%ebp)        
    movl    8(%ebp), %eax           #  35:     if     a >= @t19 goto 3_while_body
    movl    -60(%ebp), %edi        
    movl    (%edi), %ebx           
    cmpl    %ebx, %eax             
    jge     l_fbool_3_while_body   
    jmp     l_fbool_1               #  36:     goto   1
l_fbool_3_while_body:
l_fbool_7_while_cond:
    movzbl  12(%ebp), %eax          #  39:     if     B = 1 goto 8_while_body
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_fbool_8_while_body   
    movl    $2, %eax                #  40:     param  1 <- 2
    pushl   %eax                   
    movl    16(%ebp), %eax          #  41:     param  0 <- C
    pushl   %eax                   
    call    DIM                     #  42:     call   t20 <- DIM
    addl    $8, %esp               
    movl    %eax, -68(%ebp)        
    movl    $3, %eax                #  43:     mul    t21 <- 3, t20
    movl    -68(%ebp), %ebx        
    imull   %ebx                   
    movl    %eax, -72(%ebp)        
    movl    -72(%ebp), %eax         #  44:     add    t22 <- t21, a
    movl    8(%ebp), %ebx          
    addl    %ebx, %eax             
    movl    %eax, -76(%ebp)        
    movl    $3, %eax                #  45:     param  1 <- 3
    pushl   %eax                   
    movl    16(%ebp), %eax          #  46:     param  0 <- C
    pushl   %eax                   
    call    DIM                     #  47:     call   t23 <- DIM
    addl    $8, %esp               
    movl    %eax, -80(%ebp)        
    movl    -76(%ebp), %eax         #  48:     mul    t24 <- t22, t23
    movl    -80(%ebp), %ebx        
    imull   %ebx                   
    movl    %eax, -84(%ebp)        
    movl    -84(%ebp), %eax         #  49:     add    t25 <- t24, 0
    movl    $0, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -88(%ebp)        
    movl    -88(%ebp), %eax         #  50:     mul    t26 <- t25, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -92(%ebp)        
    movl    16(%ebp), %eax          #  51:     param  0 <- C
    pushl   %eax                   
    call    DOFS                    #  52:     call   t27 <- DOFS
    addl    $4, %esp               
    movl    %eax, -96(%ebp)        
    movl    -92(%ebp), %eax         #  53:     add    t28 <- t26, t27
    movl    -96(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -100(%ebp)       
    movl    16(%ebp), %eax          #  54:     add    t29 <- C, t28
    movl    -100(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -104(%ebp)       
    movl    8(%ebp), %eax           #  55:     if     a < @t29 goto 8_while_body
    movl    -104(%ebp), %edi       
    movl    (%edi), %ebx           
    cmpl    %ebx, %eax             
    jl      l_fbool_8_while_body   
    jmp     l_fbool_6               #  56:     goto   6
l_fbool_8_while_body:
    jmp     l_fbool_7_while_cond    #  58:     goto   7_while_cond
l_fbool_6:
    jmp     l_fbool_2_while_cond    #  60:     goto   2_while_cond
l_fbool_1:
    movzbl  12(%ebp), %eax          #  62:     if     B = 1 goto 15
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_fbool_15             
    jmp     l_fbool_13              #  63:     goto   13
l_fbool_15:
    jmp     l_fbool_13              #  65:     goto   13
    movl    $1, %eax                #  66:     assign t30 <- 1
    movb    %al, -109(%ebp)        
    jmp     l_fbool_14              #  67:     goto   14
l_fbool_13:
    movl    $0, %eax                #  69:     assign t30 <- 0
    movb    %al, -109(%ebp)        
l_fbool_14:
    movzbl  -109(%ebp), %eax        #  71:     return t30
    jmp     l_fbool_exit           

l_fbool_exit:
    # epilogue
    addl    $124, %esp              # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # scope printSomething
printSomething:
    # stack offsets:
    #      8(%ebp)   4  [ %C        <ptr(4) to <array 9 of <char>>> %ebp+8 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $0, %esp                # make room for locals

    # function body
    movl    8(%ebp), %eax           #   0:     param  0 <- C
    pushl   %eax                   
    call    WriteStr                #   1:     call   WriteStr
    addl    $4, %esp               
    jmp     l_printSomething_exit  
    movl    $7, %eax                #   3:     param  0 <- 7
    pushl   %eax                   
    call    WriteInt                #   4:     call   WriteInt
    addl    $4, %esp               
    call    WriteLn                 #   5:     call   WriteLn

l_printSomething_exit:
    # epilogue
    addl    $0, %esp                # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # scope hardcore
main:
    # stack offsets:
    #    -16(%ebp)   4  [ $t0       <ptr(4) to <array 13 of <char>>> %ebp-16 ]
    #    -20(%ebp)   4  [ $t1       <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-20 ]
    #    -24(%ebp)   4  [ $t10      <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-24 ]
    #    -28(%ebp)   4  [ $t100     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-28 ]
    #    -32(%ebp)   4  [ $t101     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-32 ]
    #    -36(%ebp)   4  [ $t102     <int> %ebp-36 ]
    #    -40(%ebp)   4  [ $t103     <int> %ebp-40 ]
    #    -44(%ebp)   4  [ $t104     <int> %ebp-44 ]
    #    -48(%ebp)   4  [ $t105     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-48 ]
    #    -52(%ebp)   4  [ $t106     <int> %ebp-52 ]
    #    -56(%ebp)   4  [ $t107     <int> %ebp-56 ]
    #    -60(%ebp)   4  [ $t108     <int> %ebp-60 ]
    #    -64(%ebp)   4  [ $t109     <int> %ebp-64 ]
    #    -68(%ebp)   4  [ $t11      <int> %ebp-68 ]
    #    -72(%ebp)   4  [ $t110     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-72 ]
    #    -76(%ebp)   4  [ $t111     <int> %ebp-76 ]
    #    -80(%ebp)   4  [ $t112     <int> %ebp-80 ]
    #    -84(%ebp)   4  [ $t113     <int> %ebp-84 ]
    #    -88(%ebp)   4  [ $t114     <int> %ebp-88 ]
    #    -92(%ebp)   4  [ $t115     <int> %ebp-92 ]
    #    -96(%ebp)   4  [ $t116     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-96 ]
    #   -100(%ebp)   4  [ $t117     <int> %ebp-100 ]
    #   -104(%ebp)   4  [ $t118     <int> %ebp-104 ]
    #   -108(%ebp)   4  [ $t119     <int> %ebp-108 ]
    #   -112(%ebp)   4  [ $t12      <int> %ebp-112 ]
    #   -116(%ebp)   4  [ $t120     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-116 ]
    #   -120(%ebp)   4  [ $t121     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-120 ]
    #   -124(%ebp)   4  [ $t122     <int> %ebp-124 ]
    #   -128(%ebp)   4  [ $t123     <int> %ebp-128 ]
    #   -132(%ebp)   4  [ $t124     <int> %ebp-132 ]
    #   -136(%ebp)   4  [ $t125     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-136 ]
    #   -140(%ebp)   4  [ $t126     <int> %ebp-140 ]
    #   -144(%ebp)   4  [ $t127     <int> %ebp-144 ]
    #   -148(%ebp)   4  [ $t128     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-148 ]
    #   -152(%ebp)   4  [ $t129     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-152 ]
    #   -156(%ebp)   4  [ $t13      <int> %ebp-156 ]
    #   -160(%ebp)   4  [ $t130     <int> %ebp-160 ]
    #   -164(%ebp)   4  [ $t131     <int> %ebp-164 ]
    #   -168(%ebp)   4  [ $t132     <int> %ebp-168 ]
    #   -172(%ebp)   4  [ $t133     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-172 ]
    #   -176(%ebp)   4  [ $t134     <int> %ebp-176 ]
    #   -180(%ebp)   4  [ $t135     <int> %ebp-180 ]
    #   -184(%ebp)   4  [ $t136     <int> %ebp-184 ]
    #   -188(%ebp)   4  [ $t137     <int> %ebp-188 ]
    #   -192(%ebp)   4  [ $t138     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-192 ]
    #   -196(%ebp)   4  [ $t139     <int> %ebp-196 ]
    #   -200(%ebp)   4  [ $t14      <int> %ebp-200 ]
    #   -204(%ebp)   4  [ $t140     <int> %ebp-204 ]
    #   -208(%ebp)   4  [ $t141     <int> %ebp-208 ]
    #   -212(%ebp)   4  [ $t142     <int> %ebp-212 ]
    #   -216(%ebp)   4  [ $t143     <int> %ebp-216 ]
    #   -220(%ebp)   4  [ $t144     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-220 ]
    #   -224(%ebp)   4  [ $t145     <int> %ebp-224 ]
    #   -228(%ebp)   4  [ $t146     <int> %ebp-228 ]
    #   -232(%ebp)   4  [ $t147     <int> %ebp-232 ]
    #   -236(%ebp)   4  [ $t148     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-236 ]
    #   -240(%ebp)   4  [ $t149     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-240 ]
    #   -244(%ebp)   4  [ $t15      <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-244 ]
    #   -248(%ebp)   4  [ $t150     <int> %ebp-248 ]
    #   -252(%ebp)   4  [ $t151     <int> %ebp-252 ]
    #   -256(%ebp)   4  [ $t152     <int> %ebp-256 ]
    #   -260(%ebp)   4  [ $t153     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-260 ]
    #   -264(%ebp)   4  [ $t154     <int> %ebp-264 ]
    #   -268(%ebp)   4  [ $t155     <int> %ebp-268 ]
    #   -272(%ebp)   4  [ $t156     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-272 ]
    #   -276(%ebp)   4  [ $t157     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-276 ]
    #   -280(%ebp)   4  [ $t158     <int> %ebp-280 ]
    #   -284(%ebp)   4  [ $t159     <int> %ebp-284 ]
    #   -288(%ebp)   4  [ $t16      <int> %ebp-288 ]
    #   -292(%ebp)   4  [ $t160     <int> %ebp-292 ]
    #   -296(%ebp)   4  [ $t161     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-296 ]
    #   -300(%ebp)   4  [ $t162     <int> %ebp-300 ]
    #   -304(%ebp)   4  [ $t163     <int> %ebp-304 ]
    #   -308(%ebp)   4  [ $t164     <int> %ebp-308 ]
    #   -312(%ebp)   4  [ $t165     <int> %ebp-312 ]
    #   -316(%ebp)   4  [ $t166     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-316 ]
    #   -320(%ebp)   4  [ $t167     <int> %ebp-320 ]
    #   -324(%ebp)   4  [ $t168     <int> %ebp-324 ]
    #   -328(%ebp)   4  [ $t169     <int> %ebp-328 ]
    #   -332(%ebp)   4  [ $t17      <int> %ebp-332 ]
    #   -336(%ebp)   4  [ $t170     <int> %ebp-336 ]
    #   -340(%ebp)   4  [ $t171     <int> %ebp-340 ]
    #   -344(%ebp)   4  [ $t172     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-344 ]
    #   -348(%ebp)   4  [ $t173     <int> %ebp-348 ]
    #   -352(%ebp)   4  [ $t174     <int> %ebp-352 ]
    #   -356(%ebp)   4  [ $t175     <int> %ebp-356 ]
    #   -360(%ebp)   4  [ $t176     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-360 ]
    #   -361(%ebp)   1  [ $t177     <bool> %ebp-361 ]
    #   -368(%ebp)   4  [ $t178     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-368 ]
    #   -369(%ebp)   1  [ $t179     <bool> %ebp-369 ]
    #   -376(%ebp)   4  [ $t18      <int> %ebp-376 ]
    #   -377(%ebp)   1  [ $t180     <bool> %ebp-377 ]
    #   -384(%ebp)   4  [ $t181     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-384 ]
    #   -388(%ebp)   4  [ $t182     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-388 ]
    #   -392(%ebp)   4  [ $t183     <int> %ebp-392 ]
    #   -396(%ebp)   4  [ $t184     <int> %ebp-396 ]
    #   -400(%ebp)   4  [ $t185     <int> %ebp-400 ]
    #   -404(%ebp)   4  [ $t186     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-404 ]
    #   -408(%ebp)   4  [ $t187     <int> %ebp-408 ]
    #   -412(%ebp)   4  [ $t188     <int> %ebp-412 ]
    #   -416(%ebp)   4  [ $t189     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-416 ]
    #   -420(%ebp)   4  [ $t19      <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-420 ]
    #   -424(%ebp)   4  [ $t190     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-424 ]
    #   -428(%ebp)   4  [ $t191     <int> %ebp-428 ]
    #   -432(%ebp)   4  [ $t192     <int> %ebp-432 ]
    #   -436(%ebp)   4  [ $t193     <int> %ebp-436 ]
    #   -440(%ebp)   4  [ $t194     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-440 ]
    #   -444(%ebp)   4  [ $t195     <int> %ebp-444 ]
    #   -448(%ebp)   4  [ $t196     <int> %ebp-448 ]
    #   -452(%ebp)   4  [ $t197     <int> %ebp-452 ]
    #   -456(%ebp)   4  [ $t198     <int> %ebp-456 ]
    #   -460(%ebp)   4  [ $t199     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-460 ]
    #   -464(%ebp)   4  [ $t2       <int> %ebp-464 ]
    #   -468(%ebp)   4  [ $t20      <int> %ebp-468 ]
    #   -472(%ebp)   4  [ $t200     <int> %ebp-472 ]
    #   -476(%ebp)   4  [ $t201     <int> %ebp-476 ]
    #   -480(%ebp)   4  [ $t202     <int> %ebp-480 ]
    #   -484(%ebp)   4  [ $t203     <int> %ebp-484 ]
    #   -488(%ebp)   4  [ $t204     <int> %ebp-488 ]
    #   -492(%ebp)   4  [ $t205     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-492 ]
    #   -496(%ebp)   4  [ $t206     <int> %ebp-496 ]
    #   -500(%ebp)   4  [ $t207     <int> %ebp-500 ]
    #   -504(%ebp)   4  [ $t208     <int> %ebp-504 ]
    #   -505(%ebp)   1  [ $t209     <bool> %ebp-505 ]
    #   -512(%ebp)   4  [ $t21      <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-512 ]
    #   -513(%ebp)   1  [ $t210     <bool> %ebp-513 ]
    #   -514(%ebp)   1  [ $t211     <bool> %ebp-514 ]
    #   -515(%ebp)   1  [ $t212     <bool> %ebp-515 ]
    #   -520(%ebp)   4  [ $t213     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-520 ]
    #   -524(%ebp)   4  [ $t214     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-524 ]
    #   -528(%ebp)   4  [ $t215     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-528 ]
    #   -532(%ebp)   4  [ $t216     <int> %ebp-532 ]
    #   -536(%ebp)   4  [ $t217     <int> %ebp-536 ]
    #   -540(%ebp)   4  [ $t218     <int> %ebp-540 ]
    #   -544(%ebp)   4  [ $t219     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-544 ]
    #   -548(%ebp)   4  [ $t22      <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-548 ]
    #   -552(%ebp)   4  [ $t220     <int> %ebp-552 ]
    #   -556(%ebp)   4  [ $t221     <int> %ebp-556 ]
    #   -560(%ebp)   4  [ $t222     <int> %ebp-560 ]
    #   -564(%ebp)   4  [ $t223     <int> %ebp-564 ]
    #   -568(%ebp)   4  [ $t224     <int> %ebp-568 ]
    #   -572(%ebp)   4  [ $t225     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-572 ]
    #   -576(%ebp)   4  [ $t226     <int> %ebp-576 ]
    #   -580(%ebp)   4  [ $t227     <int> %ebp-580 ]
    #   -584(%ebp)   4  [ $t228     <int> %ebp-584 ]
    #   -588(%ebp)   4  [ $t229     <int> %ebp-588 ]
    #   -592(%ebp)   4  [ $t23      <int> %ebp-592 ]
    #   -596(%ebp)   4  [ $t230     <int> %ebp-596 ]
    #   -600(%ebp)   4  [ $t231     <int> %ebp-600 ]
    #   -601(%ebp)   1  [ $t232     <bool> %ebp-601 ]
    #   -602(%ebp)   1  [ $t233     <bool> %ebp-602 ]
    #   -608(%ebp)   4  [ $t234     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-608 ]
    #   -612(%ebp)   4  [ $t235     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-612 ]
    #   -613(%ebp)   1  [ $t236     <bool> %ebp-613 ]
    #   -614(%ebp)   1  [ $t237     <bool> %ebp-614 ]
    #   -615(%ebp)   1  [ $t238     <bool> %ebp-615 ]
    #   -620(%ebp)   4  [ $t239     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-620 ]
    #   -624(%ebp)   4  [ $t24      <int> %ebp-624 ]
    #   -628(%ebp)   4  [ $t240     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-628 ]
    #   -632(%ebp)   4  [ $t241     <int> %ebp-632 ]
    #   -636(%ebp)   4  [ $t242     <int> %ebp-636 ]
    #   -640(%ebp)   4  [ $t243     <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-640 ]
    #   -644(%ebp)   4  [ $t244     <int> %ebp-644 ]
    #   -648(%ebp)   4  [ $t245     <int> %ebp-648 ]
    #   -652(%ebp)   4  [ $t246     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-652 ]
    #   -656(%ebp)   4  [ $t247     <int> %ebp-656 ]
    #   -660(%ebp)   4  [ $t248     <int> %ebp-660 ]
    #   -664(%ebp)   4  [ $t249     <int> %ebp-664 ]
    #   -668(%ebp)   4  [ $t25      <int> %ebp-668 ]
    #   -672(%ebp)   4  [ $t250     <int> %ebp-672 ]
    #   -676(%ebp)   4  [ $t251     <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-676 ]
    #   -680(%ebp)   4  [ $t252     <int> %ebp-680 ]
    #   -684(%ebp)   4  [ $t253     <int> %ebp-684 ]
    #   -688(%ebp)   4  [ $t254     <int> %ebp-688 ]
    #   -689(%ebp)   1  [ $t255     <bool> %ebp-689 ]
    #   -696(%ebp)   4  [ $t26      <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-696 ]
    #   -700(%ebp)   4  [ $t27      <int> %ebp-700 ]
    #   -704(%ebp)   4  [ $t28      <int> %ebp-704 ]
    #   -708(%ebp)   4  [ $t29      <int> %ebp-708 ]
    #   -712(%ebp)   4  [ $t3       <int> %ebp-712 ]
    #   -716(%ebp)   4  [ $t30      <int> %ebp-716 ]
    #   -720(%ebp)   4  [ $t31      <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-720 ]
    #   -724(%ebp)   4  [ $t32      <int> %ebp-724 ]
    #   -728(%ebp)   4  [ $t33      <int> %ebp-728 ]
    #   -732(%ebp)   4  [ $t34      <int> %ebp-732 ]
    #   -733(%ebp)   1  [ $t35      <bool> %ebp-733 ]
    #   -740(%ebp)   4  [ $t36      <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-740 ]
    #   -744(%ebp)   4  [ $t37      <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-744 ]
    #   -748(%ebp)   4  [ $t38      <int> %ebp-748 ]
    #   -752(%ebp)   4  [ $t39      <int> %ebp-752 ]
    #   -756(%ebp)   4  [ $t4       <int> %ebp-756 ]
    #   -760(%ebp)   4  [ $t40      <int> %ebp-760 ]
    #   -764(%ebp)   4  [ $t41      <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-764 ]
    #   -768(%ebp)   4  [ $t42      <int> %ebp-768 ]
    #   -772(%ebp)   4  [ $t43      <int> %ebp-772 ]
    #   -776(%ebp)   4  [ $t44      <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-776 ]
    #   -780(%ebp)   4  [ $t45      <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-780 ]
    #   -784(%ebp)   4  [ $t46      <int> %ebp-784 ]
    #   -788(%ebp)   4  [ $t47      <int> %ebp-788 ]
    #   -792(%ebp)   4  [ $t48      <int> %ebp-792 ]
    #   -796(%ebp)   4  [ $t49      <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-796 ]
    #   -800(%ebp)   4  [ $t5       <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-800 ]
    #   -804(%ebp)   4  [ $t50      <int> %ebp-804 ]
    #   -808(%ebp)   4  [ $t51      <int> %ebp-808 ]
    #   -812(%ebp)   4  [ $t52      <int> %ebp-812 ]
    #   -816(%ebp)   4  [ $t53      <int> %ebp-816 ]
    #   -820(%ebp)   4  [ $t54      <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-820 ]
    #   -824(%ebp)   4  [ $t55      <int> %ebp-824 ]
    #   -828(%ebp)   4  [ $t56      <int> %ebp-828 ]
    #   -832(%ebp)   4  [ $t57      <int> %ebp-832 ]
    #   -836(%ebp)   4  [ $t58      <int> %ebp-836 ]
    #   -840(%ebp)   4  [ $t59      <int> %ebp-840 ]
    #   -844(%ebp)   4  [ $t6       <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-844 ]
    #   -848(%ebp)   4  [ $t60      <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-848 ]
    #   -852(%ebp)   4  [ $t61      <int> %ebp-852 ]
    #   -856(%ebp)   4  [ $t62      <int> %ebp-856 ]
    #   -860(%ebp)   4  [ $t63      <int> %ebp-860 ]
    #   -864(%ebp)   4  [ $t64      <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-864 ]
    #   -868(%ebp)   4  [ $t65      <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-868 ]
    #   -872(%ebp)   4  [ $t66      <int> %ebp-872 ]
    #   -876(%ebp)   4  [ $t67      <int> %ebp-876 ]
    #   -880(%ebp)   4  [ $t68      <int> %ebp-880 ]
    #   -884(%ebp)   4  [ $t69      <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-884 ]
    #   -888(%ebp)   4  [ $t7       <int> %ebp-888 ]
    #   -892(%ebp)   4  [ $t70      <int> %ebp-892 ]
    #   -896(%ebp)   4  [ $t71      <int> %ebp-896 ]
    #   -900(%ebp)   4  [ $t72      <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-900 ]
    #   -904(%ebp)   4  [ $t73      <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-904 ]
    #   -908(%ebp)   4  [ $t74      <int> %ebp-908 ]
    #   -912(%ebp)   4  [ $t75      <int> %ebp-912 ]
    #   -916(%ebp)   4  [ $t76      <int> %ebp-916 ]
    #   -920(%ebp)   4  [ $t77      <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-920 ]
    #   -924(%ebp)   4  [ $t78      <int> %ebp-924 ]
    #   -928(%ebp)   4  [ $t79      <int> %ebp-928 ]
    #   -932(%ebp)   4  [ $t8       <int> %ebp-932 ]
    #   -936(%ebp)   4  [ $t80      <int> %ebp-936 ]
    #   -940(%ebp)   4  [ $t81      <int> %ebp-940 ]
    #   -944(%ebp)   4  [ $t82      <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-944 ]
    #   -948(%ebp)   4  [ $t83      <int> %ebp-948 ]
    #   -952(%ebp)   4  [ $t84      <int> %ebp-952 ]
    #   -956(%ebp)   4  [ $t85      <int> %ebp-956 ]
    #   -960(%ebp)   4  [ $t86      <int> %ebp-960 ]
    #   -964(%ebp)   4  [ $t87      <int> %ebp-964 ]
    #   -968(%ebp)   4  [ $t88      <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-968 ]
    #   -972(%ebp)   4  [ $t89      <int> %ebp-972 ]
    #   -976(%ebp)   4  [ $t9       <int> %ebp-976 ]
    #   -980(%ebp)   4  [ $t90      <int> %ebp-980 ]
    #   -984(%ebp)   4  [ $t91      <int> %ebp-984 ]
    #   -988(%ebp)   4  [ $t92      <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-988 ]
    #   -992(%ebp)   4  [ $t93      <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-992 ]
    #   -996(%ebp)   4  [ $t94      <int> %ebp-996 ]
    #  -1000(%ebp)   4  [ $t95      <int> %ebp-1000 ]
    #  -1004(%ebp)   4  [ $t96      <int> %ebp-1004 ]
    #  -1008(%ebp)   4  [ $t97      <ptr(4) to <array 5 of <array 6 of <array 5 of <bool>>>>> %ebp-1008 ]
    #  -1012(%ebp)   4  [ $t98      <int> %ebp-1012 ]
    #  -1016(%ebp)   4  [ $t99      <int> %ebp-1016 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $1004, %esp             # make room for locals

    cld                             # memset local stack area to 0
    xorl    %eax, %eax             
    movl    $251, %ecx             
    mov     %esp, %edi             
    rep     stosl                  

    # function body
    leal    _str_41, %eax           #   0:     &()    t0 <- _str_41
    movl    %eax, -16(%ebp)        
    movl    -16(%ebp), %eax         #   1:     param  0 <- t0
    pushl   %eax                   
    call    WriteStr                #   2:     call   WriteStr
    addl    $4, %esp               
    leal    I, %eax                 #   3:     &()    t1 <- I
    movl    %eax, -20(%ebp)        
    movl    -20(%ebp), %eax         #   4:     param  0 <- t1
    pushl   %eax                   
    call    DOFS                    #   5:     call   t2 <- DOFS
    addl    $4, %esp               
    movl    %eax, -464(%ebp)       
    movl    -464(%ebp), %eax        #   6:     assign i <- t2
    movl    %eax, i                
    movl    $1, %eax                #   7:     add    t3 <- 1, 2
    movl    $2, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -712(%ebp)       
    movl    -712(%ebp), %eax        #   8:     mul    t4 <- t3, 3
    movl    $3, %ebx               
    imull   %ebx                   
    movl    %eax, -756(%ebp)       
    movl    -756(%ebp), %eax        #   9:     assign i <- t4
    movl    %eax, i                
    leal    I, %eax                 #  10:     &()    t5 <- I
    movl    %eax, -800(%ebp)       
    movl    $2, %eax                #  11:     param  1 <- 2
    pushl   %eax                   
    leal    I, %eax                 #  12:     &()    t6 <- I
    movl    %eax, -844(%ebp)       
    movl    -844(%ebp), %eax        #  13:     param  0 <- t6
    pushl   %eax                   
    call    DIM                     #  14:     call   t7 <- DIM
    addl    $8, %esp               
    movl    %eax, -888(%ebp)       
    movl    $2, %eax                #  15:     mul    t8 <- 2, t7
    movl    -888(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -932(%ebp)       
    movl    -932(%ebp), %eax        #  16:     add    t9 <- t8, 0
    movl    $0, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -976(%ebp)       
    movl    $3, %eax                #  17:     param  1 <- 3
    pushl   %eax                   
    leal    I, %eax                 #  18:     &()    t10 <- I
    movl    %eax, -24(%ebp)        
    movl    -24(%ebp), %eax         #  19:     param  0 <- t10
    pushl   %eax                   
    call    DIM                     #  20:     call   t11 <- DIM
    addl    $8, %esp               
    movl    %eax, -68(%ebp)        
    movl    -976(%ebp), %eax        #  21:     mul    t12 <- t9, t11
    movl    -68(%ebp), %ebx        
    imull   %ebx                   
    movl    %eax, -112(%ebp)       
    movl    -112(%ebp), %eax        #  22:     add    t13 <- t12, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -156(%ebp)       
    movl    -156(%ebp), %eax        #  23:     mul    t14 <- t13, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -200(%ebp)       
    leal    I, %eax                 #  24:     &()    t15 <- I
    movl    %eax, -244(%ebp)       
    movl    -244(%ebp), %eax        #  25:     param  0 <- t15
    pushl   %eax                   
    call    DOFS                    #  26:     call   t16 <- DOFS
    addl    $4, %esp               
    movl    %eax, -288(%ebp)       
    movl    -200(%ebp), %eax        #  27:     add    t17 <- t14, t16
    movl    -288(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -332(%ebp)       
    movl    -800(%ebp), %eax        #  28:     add    t18 <- t5, t17
    movl    -332(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -376(%ebp)       
    movl    $9, %eax                #  29:     assign @t18 <- 9
    movl    -376(%ebp), %edi       
    movl    %eax, (%edi)           
    leal    I, %eax                 #  30:     &()    t19 <- I
    movl    %eax, -420(%ebp)       
    movl    -420(%ebp), %eax        #  31:     param  2 <- t19
    pushl   %eax                   
    movzbl  b, %eax                 #  32:     param  1 <- b
    pushl   %eax                   
    movl    i, %eax                 #  33:     param  0 <- i
    pushl   %eax                   
    call    fint                    #  34:     call   t20 <- fint
    addl    $12, %esp              
    movl    %eax, -468(%ebp)       
    leal    I, %eax                 #  35:     &()    t21 <- I
    movl    %eax, -512(%ebp)       
    movl    $2, %eax                #  36:     param  1 <- 2
    pushl   %eax                   
    leal    I, %eax                 #  37:     &()    t22 <- I
    movl    %eax, -548(%ebp)       
    movl    -548(%ebp), %eax        #  38:     param  0 <- t22
    pushl   %eax                   
    call    DIM                     #  39:     call   t23 <- DIM
    addl    $8, %esp               
    movl    %eax, -592(%ebp)       
    movl    $2, %eax                #  40:     mul    t24 <- 2, t23
    movl    -592(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -624(%ebp)       
    movl    -624(%ebp), %eax        #  41:     add    t25 <- t24, 0
    movl    $0, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -668(%ebp)       
    movl    $3, %eax                #  42:     param  1 <- 3
    pushl   %eax                   
    leal    I, %eax                 #  43:     &()    t26 <- I
    movl    %eax, -696(%ebp)       
    movl    -696(%ebp), %eax        #  44:     param  0 <- t26
    pushl   %eax                   
    call    DIM                     #  45:     call   t27 <- DIM
    addl    $8, %esp               
    movl    %eax, -700(%ebp)       
    movl    -668(%ebp), %eax        #  46:     mul    t28 <- t25, t27
    movl    -700(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -704(%ebp)       
    movl    -704(%ebp), %eax        #  47:     add    t29 <- t28, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -708(%ebp)       
    movl    -708(%ebp), %eax        #  48:     mul    t30 <- t29, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -716(%ebp)       
    leal    I, %eax                 #  49:     &()    t31 <- I
    movl    %eax, -720(%ebp)       
    movl    -720(%ebp), %eax        #  50:     param  0 <- t31
    pushl   %eax                   
    call    DOFS                    #  51:     call   t32 <- DOFS
    addl    $4, %esp               
    movl    %eax, -724(%ebp)       
    movl    -716(%ebp), %eax        #  52:     add    t33 <- t30, t32
    movl    -724(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -728(%ebp)       
    movl    -512(%ebp), %eax        #  53:     add    t34 <- t21, t33
    movl    -728(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -732(%ebp)       
    movl    -468(%ebp), %eax        #  54:     assign @t34 <- t20
    movl    -732(%ebp), %edi       
    movl    %eax, (%edi)           
    movzbl  b, %eax                 #  55:     if     b = 1 goto 6_if_true
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_hardcore_6_if_true   
    jmp     l_hardcore_7_if_false   #  56:     goto   7_if_false
l_hardcore_6_if_true:
    movl    $1, %eax                #  58:     assign t35 <- 1
    movb    %al, -733(%ebp)        
    jmp     l_hardcore_11           #  59:     goto   11
    movl    $0, %eax                #  60:     assign t35 <- 0
    movb    %al, -733(%ebp)        
l_hardcore_11:
    leal    B, %eax                 #  62:     &()    t36 <- B
    movl    %eax, -740(%ebp)       
    movl    $2, %eax                #  63:     param  1 <- 2
    pushl   %eax                   
    leal    B, %eax                 #  64:     &()    t37 <- B
    movl    %eax, -744(%ebp)       
    movl    -744(%ebp), %eax        #  65:     param  0 <- t37
    pushl   %eax                   
    call    DIM                     #  66:     call   t38 <- DIM
    addl    $8, %esp               
    movl    %eax, -748(%ebp)       
    movl    $7, %eax                #  67:     mul    t39 <- 7, t38
    movl    -748(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -752(%ebp)       
    movl    -752(%ebp), %eax        #  68:     add    t40 <- t39, i
    movl    i, %ebx                
    addl    %ebx, %eax             
    movl    %eax, -760(%ebp)       
    movl    $3, %eax                #  69:     param  1 <- 3
    pushl   %eax                   
    leal    B, %eax                 #  70:     &()    t41 <- B
    movl    %eax, -764(%ebp)       
    movl    -764(%ebp), %eax        #  71:     param  0 <- t41
    pushl   %eax                   
    call    DIM                     #  72:     call   t42 <- DIM
    addl    $8, %esp               
    movl    %eax, -768(%ebp)       
    movl    -760(%ebp), %eax        #  73:     mul    t43 <- t40, t42
    movl    -768(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -772(%ebp)       
    leal    I, %eax                 #  74:     &()    t44 <- I
    movl    %eax, -776(%ebp)       
    movl    $2, %eax                #  75:     param  1 <- 2
    pushl   %eax                   
    leal    I, %eax                 #  76:     &()    t45 <- I
    movl    %eax, -780(%ebp)       
    movl    -780(%ebp), %eax        #  77:     param  0 <- t45
    pushl   %eax                   
    call    DIM                     #  78:     call   t46 <- DIM
    addl    $8, %esp               
    movl    %eax, -784(%ebp)       
    movl    $7, %eax                #  79:     mul    t47 <- 7, t46
    movl    -784(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -788(%ebp)       
    movl    -788(%ebp), %eax        #  80:     add    t48 <- t47, i
    movl    i, %ebx                
    addl    %ebx, %eax             
    movl    %eax, -792(%ebp)       
    movl    $3, %eax                #  81:     param  1 <- 3
    pushl   %eax                   
    leal    I, %eax                 #  82:     &()    t49 <- I
    movl    %eax, -796(%ebp)       
    movl    -796(%ebp), %eax        #  83:     param  0 <- t49
    pushl   %eax                   
    call    DIM                     #  84:     call   t50 <- DIM
    addl    $8, %esp               
    movl    %eax, -804(%ebp)       
    movl    -792(%ebp), %eax        #  85:     mul    t51 <- t48, t50
    movl    -804(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -808(%ebp)       
    movl    -808(%ebp), %eax        #  86:     add    t52 <- t51, i
    movl    i, %ebx                
    addl    %ebx, %eax             
    movl    %eax, -812(%ebp)       
    movl    -812(%ebp), %eax        #  87:     mul    t53 <- t52, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -816(%ebp)       
    leal    I, %eax                 #  88:     &()    t54 <- I
    movl    %eax, -820(%ebp)       
    movl    -820(%ebp), %eax        #  89:     param  0 <- t54
    pushl   %eax                   
    call    DOFS                    #  90:     call   t55 <- DOFS
    addl    $4, %esp               
    movl    %eax, -824(%ebp)       
    movl    -816(%ebp), %eax        #  91:     add    t56 <- t53, t55
    movl    -824(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -828(%ebp)       
    movl    -776(%ebp), %eax        #  92:     add    t57 <- t44, t56
    movl    -828(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -832(%ebp)       
    movl    -772(%ebp), %eax        #  93:     add    t58 <- t43, @t57
    movl    -832(%ebp), %edi       
    movl    (%edi), %ebx           
    addl    %ebx, %eax             
    movl    %eax, -836(%ebp)       
    movl    -836(%ebp), %eax        #  94:     mul    t59 <- t58, 1
    movl    $1, %ebx               
    imull   %ebx                   
    movl    %eax, -840(%ebp)       
    leal    B, %eax                 #  95:     &()    t60 <- B
    movl    %eax, -848(%ebp)       
    movl    -848(%ebp), %eax        #  96:     param  0 <- t60
    pushl   %eax                   
    call    DOFS                    #  97:     call   t61 <- DOFS
    addl    $4, %esp               
    movl    %eax, -852(%ebp)       
    movl    -840(%ebp), %eax        #  98:     add    t62 <- t59, t61
    movl    -852(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -856(%ebp)       
    movl    -740(%ebp), %eax        #  99:     add    t63 <- t36, t62
    movl    -856(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -860(%ebp)       
    movzbl  -733(%ebp), %eax        # 100:     assign @t63 <- t35
    movl    -860(%ebp), %edi       
    movb    %al, (%edi)            
    leal    B, %eax                 # 101:     &()    t64 <- B
    movl    %eax, -864(%ebp)       
    movl    $2, %eax                # 102:     param  1 <- 2
    pushl   %eax                   
    leal    B, %eax                 # 103:     &()    t65 <- B
    movl    %eax, -868(%ebp)       
    movl    -868(%ebp), %eax        # 104:     param  0 <- t65
    pushl   %eax                   
    call    DIM                     # 105:     call   t66 <- DIM
    addl    $8, %esp               
    movl    %eax, -872(%ebp)       
    movl    $7, %eax                # 106:     mul    t67 <- 7, t66
    movl    -872(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -876(%ebp)       
    movl    -876(%ebp), %eax        # 107:     add    t68 <- t67, i
    movl    i, %ebx                
    addl    %ebx, %eax             
    movl    %eax, -880(%ebp)       
    movl    $3, %eax                # 108:     param  1 <- 3
    pushl   %eax                   
    leal    B, %eax                 # 109:     &()    t69 <- B
    movl    %eax, -884(%ebp)       
    movl    -884(%ebp), %eax        # 110:     param  0 <- t69
    pushl   %eax                   
    call    DIM                     # 111:     call   t70 <- DIM
    addl    $8, %esp               
    movl    %eax, -892(%ebp)       
    movl    -880(%ebp), %eax        # 112:     mul    t71 <- t68, t70
    movl    -892(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -896(%ebp)       
    leal    I, %eax                 # 113:     &()    t72 <- I
    movl    %eax, -900(%ebp)       
    movl    $2, %eax                # 114:     param  1 <- 2
    pushl   %eax                   
    leal    I, %eax                 # 115:     &()    t73 <- I
    movl    %eax, -904(%ebp)       
    movl    -904(%ebp), %eax        # 116:     param  0 <- t73
    pushl   %eax                   
    call    DIM                     # 117:     call   t74 <- DIM
    addl    $8, %esp               
    movl    %eax, -908(%ebp)       
    movl    $7, %eax                # 118:     mul    t75 <- 7, t74
    movl    -908(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -912(%ebp)       
    movl    -912(%ebp), %eax        # 119:     add    t76 <- t75, i
    movl    i, %ebx                
    addl    %ebx, %eax             
    movl    %eax, -916(%ebp)       
    movl    $3, %eax                # 120:     param  1 <- 3
    pushl   %eax                   
    leal    I, %eax                 # 121:     &()    t77 <- I
    movl    %eax, -920(%ebp)       
    movl    -920(%ebp), %eax        # 122:     param  0 <- t77
    pushl   %eax                   
    call    DIM                     # 123:     call   t78 <- DIM
    addl    $8, %esp               
    movl    %eax, -924(%ebp)       
    movl    -916(%ebp), %eax        # 124:     mul    t79 <- t76, t78
    movl    -924(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -928(%ebp)       
    movl    -928(%ebp), %eax        # 125:     add    t80 <- t79, i
    movl    i, %ebx                
    addl    %ebx, %eax             
    movl    %eax, -936(%ebp)       
    movl    -936(%ebp), %eax        # 126:     mul    t81 <- t80, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -940(%ebp)       
    leal    I, %eax                 # 127:     &()    t82 <- I
    movl    %eax, -944(%ebp)       
    movl    -944(%ebp), %eax        # 128:     param  0 <- t82
    pushl   %eax                   
    call    DOFS                    # 129:     call   t83 <- DOFS
    addl    $4, %esp               
    movl    %eax, -948(%ebp)       
    movl    -940(%ebp), %eax        # 130:     add    t84 <- t81, t83
    movl    -948(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -952(%ebp)       
    movl    -900(%ebp), %eax        # 131:     add    t85 <- t72, t84
    movl    -952(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -956(%ebp)       
    movl    -896(%ebp), %eax        # 132:     add    t86 <- t71, @t85
    movl    -956(%ebp), %edi       
    movl    (%edi), %ebx           
    addl    %ebx, %eax             
    movl    %eax, -960(%ebp)       
    movl    -960(%ebp), %eax        # 133:     mul    t87 <- t86, 1
    movl    $1, %ebx               
    imull   %ebx                   
    movl    %eax, -964(%ebp)       
    leal    B, %eax                 # 134:     &()    t88 <- B
    movl    %eax, -968(%ebp)       
    movl    -968(%ebp), %eax        # 135:     param  0 <- t88
    pushl   %eax                   
    call    DOFS                    # 136:     call   t89 <- DOFS
    addl    $4, %esp               
    movl    %eax, -972(%ebp)       
    movl    -964(%ebp), %eax        # 137:     add    t90 <- t87, t89
    movl    -972(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -980(%ebp)       
    movl    -864(%ebp), %eax        # 138:     add    t91 <- t64, t90
    movl    -980(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -984(%ebp)       
    movzbl  b, %eax                 # 139:     assign @t91 <- b
    movl    -984(%ebp), %edi       
    movb    %al, (%edi)            
    leal    B, %eax                 # 140:     &()    t92 <- B
    movl    %eax, -988(%ebp)       
    movl    $2, %eax                # 141:     param  1 <- 2
    pushl   %eax                   
    leal    B, %eax                 # 142:     &()    t93 <- B
    movl    %eax, -992(%ebp)       
    movl    -992(%ebp), %eax        # 143:     param  0 <- t93
    pushl   %eax                   
    call    DIM                     # 144:     call   t94 <- DIM
    addl    $8, %esp               
    movl    %eax, -996(%ebp)       
    movl    $7, %eax                # 145:     mul    t95 <- 7, t94
    movl    -996(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -1000(%ebp)      
    movl    -1000(%ebp), %eax       # 146:     add    t96 <- t95, i
    movl    i, %ebx                
    addl    %ebx, %eax             
    movl    %eax, -1004(%ebp)      
    movl    $3, %eax                # 147:     param  1 <- 3
    pushl   %eax                   
    leal    B, %eax                 # 148:     &()    t97 <- B
    movl    %eax, -1008(%ebp)      
    movl    -1008(%ebp), %eax       # 149:     param  0 <- t97
    pushl   %eax                   
    call    DIM                     # 150:     call   t98 <- DIM
    addl    $8, %esp               
    movl    %eax, -1012(%ebp)      
    movl    -1004(%ebp), %eax       # 151:     mul    t99 <- t96, t98
    movl    -1012(%ebp), %ebx      
    imull   %ebx                   
    movl    %eax, -1016(%ebp)      
    leal    I, %eax                 # 152:     &()    t100 <- I
    movl    %eax, -28(%ebp)        
    movl    $2, %eax                # 153:     param  1 <- 2
    pushl   %eax                   
    leal    I, %eax                 # 154:     &()    t101 <- I
    movl    %eax, -32(%ebp)        
    movl    -32(%ebp), %eax         # 155:     param  0 <- t101
    pushl   %eax                   
    call    DIM                     # 156:     call   t102 <- DIM
    addl    $8, %esp               
    movl    %eax, -36(%ebp)        
    movl    $7, %eax                # 157:     mul    t103 <- 7, t102
    movl    -36(%ebp), %ebx        
    imull   %ebx                   
    movl    %eax, -40(%ebp)        
    movl    -40(%ebp), %eax         # 158:     add    t104 <- t103, i
    movl    i, %ebx                
    addl    %ebx, %eax             
    movl    %eax, -44(%ebp)        
    movl    $3, %eax                # 159:     param  1 <- 3
    pushl   %eax                   
    leal    I, %eax                 # 160:     &()    t105 <- I
    movl    %eax, -48(%ebp)        
    movl    -48(%ebp), %eax         # 161:     param  0 <- t105
    pushl   %eax                   
    call    DIM                     # 162:     call   t106 <- DIM
    addl    $8, %esp               
    movl    %eax, -52(%ebp)        
    movl    -44(%ebp), %eax         # 163:     mul    t107 <- t104, t106
    movl    -52(%ebp), %ebx        
    imull   %ebx                   
    movl    %eax, -56(%ebp)        
    movl    -56(%ebp), %eax         # 164:     add    t108 <- t107, i
    movl    i, %ebx                
    addl    %ebx, %eax             
    movl    %eax, -60(%ebp)        
    movl    -60(%ebp), %eax         # 165:     mul    t109 <- t108, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -64(%ebp)        
    leal    I, %eax                 # 166:     &()    t110 <- I
    movl    %eax, -72(%ebp)        
    movl    -72(%ebp), %eax         # 167:     param  0 <- t110
    pushl   %eax                   
    call    DOFS                    # 168:     call   t111 <- DOFS
    addl    $4, %esp               
    movl    %eax, -76(%ebp)        
    movl    -64(%ebp), %eax         # 169:     add    t112 <- t109, t111
    movl    -76(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -80(%ebp)        
    movl    -28(%ebp), %eax         # 170:     add    t113 <- t100, t112
    movl    -80(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -84(%ebp)        
    movl    -1016(%ebp), %eax       # 171:     add    t114 <- t99, @t113
    movl    -84(%ebp), %edi        
    movl    (%edi), %ebx           
    addl    %ebx, %eax             
    movl    %eax, -88(%ebp)        
    movl    -88(%ebp), %eax         # 172:     mul    t115 <- t114, 1
    movl    $1, %ebx               
    imull   %ebx                   
    movl    %eax, -92(%ebp)        
    leal    B, %eax                 # 173:     &()    t116 <- B
    movl    %eax, -96(%ebp)        
    movl    -96(%ebp), %eax         # 174:     param  0 <- t116
    pushl   %eax                   
    call    DOFS                    # 175:     call   t117 <- DOFS
    addl    $4, %esp               
    movl    %eax, -100(%ebp)       
    movl    -92(%ebp), %eax         # 176:     add    t118 <- t115, t117
    movl    -100(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -104(%ebp)       
    movl    -988(%ebp), %eax        # 177:     add    t119 <- t92, t118
    movl    -104(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -108(%ebp)       
    leal    B, %eax                 # 178:     &()    t120 <- B
    movl    %eax, -116(%ebp)       
    movl    $2, %eax                # 179:     param  1 <- 2
    pushl   %eax                   
    leal    B, %eax                 # 180:     &()    t121 <- B
    movl    %eax, -120(%ebp)       
    movl    -120(%ebp), %eax        # 181:     param  0 <- t121
    pushl   %eax                   
    call    DIM                     # 182:     call   t122 <- DIM
    addl    $8, %esp               
    movl    %eax, -124(%ebp)       
    movl    $7, %eax                # 183:     mul    t123 <- 7, t122
    movl    -124(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -128(%ebp)       
    movl    -128(%ebp), %eax        # 184:     add    t124 <- t123, i
    movl    i, %ebx                
    addl    %ebx, %eax             
    movl    %eax, -132(%ebp)       
    movl    $3, %eax                # 185:     param  1 <- 3
    pushl   %eax                   
    leal    B, %eax                 # 186:     &()    t125 <- B
    movl    %eax, -136(%ebp)       
    movl    -136(%ebp), %eax        # 187:     param  0 <- t125
    pushl   %eax                   
    call    DIM                     # 188:     call   t126 <- DIM
    addl    $8, %esp               
    movl    %eax, -140(%ebp)       
    movl    -132(%ebp), %eax        # 189:     mul    t127 <- t124, t126
    movl    -140(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -144(%ebp)       
    leal    I, %eax                 # 190:     &()    t128 <- I
    movl    %eax, -148(%ebp)       
    movl    $2, %eax                # 191:     param  1 <- 2
    pushl   %eax                   
    leal    I, %eax                 # 192:     &()    t129 <- I
    movl    %eax, -152(%ebp)       
    movl    -152(%ebp), %eax        # 193:     param  0 <- t129
    pushl   %eax                   
    call    DIM                     # 194:     call   t130 <- DIM
    addl    $8, %esp               
    movl    %eax, -160(%ebp)       
    movl    $7, %eax                # 195:     mul    t131 <- 7, t130
    movl    -160(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -164(%ebp)       
    movl    -164(%ebp), %eax        # 196:     add    t132 <- t131, i
    movl    i, %ebx                
    addl    %ebx, %eax             
    movl    %eax, -168(%ebp)       
    movl    $3, %eax                # 197:     param  1 <- 3
    pushl   %eax                   
    leal    I, %eax                 # 198:     &()    t133 <- I
    movl    %eax, -172(%ebp)       
    movl    -172(%ebp), %eax        # 199:     param  0 <- t133
    pushl   %eax                   
    call    DIM                     # 200:     call   t134 <- DIM
    addl    $8, %esp               
    movl    %eax, -176(%ebp)       
    movl    -168(%ebp), %eax        # 201:     mul    t135 <- t132, t134
    movl    -176(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -180(%ebp)       
    movl    -180(%ebp), %eax        # 202:     add    t136 <- t135, i
    movl    i, %ebx                
    addl    %ebx, %eax             
    movl    %eax, -184(%ebp)       
    movl    -184(%ebp), %eax        # 203:     mul    t137 <- t136, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -188(%ebp)       
    leal    I, %eax                 # 204:     &()    t138 <- I
    movl    %eax, -192(%ebp)       
    movl    -192(%ebp), %eax        # 205:     param  0 <- t138
    pushl   %eax                   
    call    DOFS                    # 206:     call   t139 <- DOFS
    addl    $4, %esp               
    movl    %eax, -196(%ebp)       
    movl    -188(%ebp), %eax        # 207:     add    t140 <- t137, t139
    movl    -196(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -204(%ebp)       
    movl    -148(%ebp), %eax        # 208:     add    t141 <- t128, t140
    movl    -204(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -208(%ebp)       
    movl    -144(%ebp), %eax        # 209:     add    t142 <- t127, @t141
    movl    -208(%ebp), %edi       
    movl    (%edi), %ebx           
    addl    %ebx, %eax             
    movl    %eax, -212(%ebp)       
    movl    -212(%ebp), %eax        # 210:     mul    t143 <- t142, 1
    movl    $1, %ebx               
    imull   %ebx                   
    movl    %eax, -216(%ebp)       
    leal    B, %eax                 # 211:     &()    t144 <- B
    movl    %eax, -220(%ebp)       
    movl    -220(%ebp), %eax        # 212:     param  0 <- t144
    pushl   %eax                   
    call    DOFS                    # 213:     call   t145 <- DOFS
    addl    $4, %esp               
    movl    %eax, -224(%ebp)       
    movl    -216(%ebp), %eax        # 214:     add    t146 <- t143, t145
    movl    -224(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -228(%ebp)       
    movl    -116(%ebp), %eax        # 215:     add    t147 <- t120, t146
    movl    -228(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -232(%ebp)       
    movl    -108(%ebp), %edi       
    movzbl  (%edi), %eax            # 216:     assign @t147 <- @t119
    movl    -232(%ebp), %edi       
    movb    %al, (%edi)            
    jmp     l_hardcore_exit        
    jmp     l_hardcore_5            # 218:     goto   5
l_hardcore_7_if_false:
l_hardcore_5:
    leal    B, %eax                 # 221:     &()    t148 <- B
    movl    %eax, -236(%ebp)       
    movl    $2, %eax                # 222:     param  1 <- 2
    pushl   %eax                   
    leal    B, %eax                 # 223:     &()    t149 <- B
    movl    %eax, -240(%ebp)       
    movl    -240(%ebp), %eax        # 224:     param  0 <- t149
    pushl   %eax                   
    call    DIM                     # 225:     call   t150 <- DIM
    addl    $8, %esp               
    movl    %eax, -248(%ebp)       
    movl    $7, %eax                # 226:     mul    t151 <- 7, t150
    movl    -248(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -252(%ebp)       
    movl    -252(%ebp), %eax        # 227:     add    t152 <- t151, i
    movl    i, %ebx                
    addl    %ebx, %eax             
    movl    %eax, -256(%ebp)       
    movl    $3, %eax                # 228:     param  1 <- 3
    pushl   %eax                   
    leal    B, %eax                 # 229:     &()    t153 <- B
    movl    %eax, -260(%ebp)       
    movl    -260(%ebp), %eax        # 230:     param  0 <- t153
    pushl   %eax                   
    call    DIM                     # 231:     call   t154 <- DIM
    addl    $8, %esp               
    movl    %eax, -264(%ebp)       
    movl    -256(%ebp), %eax        # 232:     mul    t155 <- t152, t154
    movl    -264(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -268(%ebp)       
    leal    I, %eax                 # 233:     &()    t156 <- I
    movl    %eax, -272(%ebp)       
    movl    $2, %eax                # 234:     param  1 <- 2
    pushl   %eax                   
    leal    I, %eax                 # 235:     &()    t157 <- I
    movl    %eax, -276(%ebp)       
    movl    -276(%ebp), %eax        # 236:     param  0 <- t157
    pushl   %eax                   
    call    DIM                     # 237:     call   t158 <- DIM
    addl    $8, %esp               
    movl    %eax, -280(%ebp)       
    movl    $7, %eax                # 238:     mul    t159 <- 7, t158
    movl    -280(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -284(%ebp)       
    movl    -284(%ebp), %eax        # 239:     add    t160 <- t159, i
    movl    i, %ebx                
    addl    %ebx, %eax             
    movl    %eax, -292(%ebp)       
    movl    $3, %eax                # 240:     param  1 <- 3
    pushl   %eax                   
    leal    I, %eax                 # 241:     &()    t161 <- I
    movl    %eax, -296(%ebp)       
    movl    -296(%ebp), %eax        # 242:     param  0 <- t161
    pushl   %eax                   
    call    DIM                     # 243:     call   t162 <- DIM
    addl    $8, %esp               
    movl    %eax, -300(%ebp)       
    movl    -292(%ebp), %eax        # 244:     mul    t163 <- t160, t162
    movl    -300(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -304(%ebp)       
    movl    -304(%ebp), %eax        # 245:     add    t164 <- t163, i
    movl    i, %ebx                
    addl    %ebx, %eax             
    movl    %eax, -308(%ebp)       
    movl    -308(%ebp), %eax        # 246:     mul    t165 <- t164, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -312(%ebp)       
    leal    I, %eax                 # 247:     &()    t166 <- I
    movl    %eax, -316(%ebp)       
    movl    -316(%ebp), %eax        # 248:     param  0 <- t166
    pushl   %eax                   
    call    DOFS                    # 249:     call   t167 <- DOFS
    addl    $4, %esp               
    movl    %eax, -320(%ebp)       
    movl    -312(%ebp), %eax        # 250:     add    t168 <- t165, t167
    movl    -320(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -324(%ebp)       
    movl    -272(%ebp), %eax        # 251:     add    t169 <- t156, t168
    movl    -324(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -328(%ebp)       
    movl    -268(%ebp), %eax        # 252:     add    t170 <- t155, @t169
    movl    -328(%ebp), %edi       
    movl    (%edi), %ebx           
    addl    %ebx, %eax             
    movl    %eax, -336(%ebp)       
    movl    -336(%ebp), %eax        # 253:     mul    t171 <- t170, 1
    movl    $1, %ebx               
    imull   %ebx                   
    movl    %eax, -340(%ebp)       
    leal    B, %eax                 # 254:     &()    t172 <- B
    movl    %eax, -344(%ebp)       
    movl    -344(%ebp), %eax        # 255:     param  0 <- t172
    pushl   %eax                   
    call    DOFS                    # 256:     call   t173 <- DOFS
    addl    $4, %esp               
    movl    %eax, -348(%ebp)       
    movl    -340(%ebp), %eax        # 257:     add    t174 <- t171, t173
    movl    -348(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -352(%ebp)       
    movl    -236(%ebp), %eax        # 258:     add    t175 <- t148, t174
    movl    -352(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -356(%ebp)       
    movl    -356(%ebp), %edi       
    movzbl  (%edi), %eax            # 259:     if     @t175 = 1 goto 17_if_true
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_hardcore_17_if_true  
    jmp     l_hardcore_18_if_false  # 260:     goto   18_if_false
l_hardcore_17_if_true:
    leal    I, %eax                 # 262:     &()    t176 <- I
    movl    %eax, -360(%ebp)       
    movl    -360(%ebp), %eax        # 263:     param  2 <- t176
    pushl   %eax                   
    movzbl  b, %eax                 # 264:     param  1 <- b
    pushl   %eax                   
    movl    $5, %eax                # 265:     param  0 <- 5
    pushl   %eax                   
    call    fbool                   # 266:     call   t177 <- fbool
    addl    $12, %esp              
    movb    %al, -361(%ebp)        
    leal    I, %eax                 # 267:     &()    t178 <- I
    movl    %eax, -368(%ebp)       
    movl    -368(%ebp), %eax        # 268:     param  2 <- t178
    pushl   %eax                   
    movzbl  b, %eax                 # 269:     param  1 <- b
    pushl   %eax                   
    movl    $5, %eax                # 270:     param  0 <- 5
    pushl   %eax                   
    call    fbool                   # 271:     call   t179 <- fbool
    addl    $12, %esp              
    movb    %al, -369(%ebp)        
    jmp     l_hardcore_16           # 272:     goto   16
l_hardcore_18_if_false:
l_hardcore_16:
    jmp     l_hardcore_22           # 275:     goto   22
l_hardcore_22:
    movl    $1, %eax                # 277:     assign t180 <- 1
    movb    %al, -377(%ebp)        
    jmp     l_hardcore_24           # 278:     goto   24
    movl    $0, %eax                # 279:     assign t180 <- 0
    movb    %al, -377(%ebp)        
l_hardcore_24:
    leal    B, %eax                 # 281:     &()    t181 <- B
    movl    %eax, -384(%ebp)       
    movl    $2, %eax                # 282:     param  1 <- 2
    pushl   %eax                   
    leal    B, %eax                 # 283:     &()    t182 <- B
    movl    %eax, -388(%ebp)       
    movl    -388(%ebp), %eax        # 284:     param  0 <- t182
    pushl   %eax                   
    call    DIM                     # 285:     call   t183 <- DIM
    addl    $8, %esp               
    movl    %eax, -392(%ebp)       
    movl    $7, %eax                # 286:     mul    t184 <- 7, t183
    movl    -392(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -396(%ebp)       
    movl    -396(%ebp), %eax        # 287:     add    t185 <- t184, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -400(%ebp)       
    movl    $3, %eax                # 288:     param  1 <- 3
    pushl   %eax                   
    leal    B, %eax                 # 289:     &()    t186 <- B
    movl    %eax, -404(%ebp)       
    movl    -404(%ebp), %eax        # 290:     param  0 <- t186
    pushl   %eax                   
    call    DIM                     # 291:     call   t187 <- DIM
    addl    $8, %esp               
    movl    %eax, -408(%ebp)       
    movl    -400(%ebp), %eax        # 292:     mul    t188 <- t185, t187
    movl    -408(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -412(%ebp)       
    leal    I, %eax                 # 293:     &()    t189 <- I
    movl    %eax, -416(%ebp)       
    movl    $2, %eax                # 294:     param  1 <- 2
    pushl   %eax                   
    leal    I, %eax                 # 295:     &()    t190 <- I
    movl    %eax, -424(%ebp)       
    movl    -424(%ebp), %eax        # 296:     param  0 <- t190
    pushl   %eax                   
    call    DIM                     # 297:     call   t191 <- DIM
    addl    $8, %esp               
    movl    %eax, -428(%ebp)       
    movl    $7, %eax                # 298:     mul    t192 <- 7, t191
    movl    -428(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -432(%ebp)       
    movl    -432(%ebp), %eax        # 299:     add    t193 <- t192, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -436(%ebp)       
    movl    $3, %eax                # 300:     param  1 <- 3
    pushl   %eax                   
    leal    I, %eax                 # 301:     &()    t194 <- I
    movl    %eax, -440(%ebp)       
    movl    -440(%ebp), %eax        # 302:     param  0 <- t194
    pushl   %eax                   
    call    DIM                     # 303:     call   t195 <- DIM
    addl    $8, %esp               
    movl    %eax, -444(%ebp)       
    movl    -436(%ebp), %eax        # 304:     mul    t196 <- t193, t195
    movl    -444(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -448(%ebp)       
    movl    -448(%ebp), %eax        # 305:     add    t197 <- t196, i
    movl    i, %ebx                
    addl    %ebx, %eax             
    movl    %eax, -452(%ebp)       
    movl    -452(%ebp), %eax        # 306:     mul    t198 <- t197, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -456(%ebp)       
    leal    I, %eax                 # 307:     &()    t199 <- I
    movl    %eax, -460(%ebp)       
    movl    -460(%ebp), %eax        # 308:     param  0 <- t199
    pushl   %eax                   
    call    DOFS                    # 309:     call   t200 <- DOFS
    addl    $4, %esp               
    movl    %eax, -472(%ebp)       
    movl    -456(%ebp), %eax        # 310:     add    t201 <- t198, t200
    movl    -472(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -476(%ebp)       
    movl    -416(%ebp), %eax        # 311:     add    t202 <- t189, t201
    movl    -476(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -480(%ebp)       
    movl    -412(%ebp), %eax        # 312:     add    t203 <- t188, @t202
    movl    -480(%ebp), %edi       
    movl    (%edi), %ebx           
    addl    %ebx, %eax             
    movl    %eax, -484(%ebp)       
    movl    -484(%ebp), %eax        # 313:     mul    t204 <- t203, 1
    movl    $1, %ebx               
    imull   %ebx                   
    movl    %eax, -488(%ebp)       
    leal    B, %eax                 # 314:     &()    t205 <- B
    movl    %eax, -492(%ebp)       
    movl    -492(%ebp), %eax        # 315:     param  0 <- t205
    pushl   %eax                   
    call    DOFS                    # 316:     call   t206 <- DOFS
    addl    $4, %esp               
    movl    %eax, -496(%ebp)       
    movl    -488(%ebp), %eax        # 317:     add    t207 <- t204, t206
    movl    -496(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -500(%ebp)       
    movl    -384(%ebp), %eax        # 318:     add    t208 <- t181, t207
    movl    -500(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -504(%ebp)       
    movzbl  -377(%ebp), %eax        # 319:     assign @t208 <- t180
    movl    -504(%ebp), %edi       
    movb    %al, (%edi)            
    movl    i, %eax                 # 320:     if     i > 9 goto 31
    movl    $9, %ebx               
    cmpl    %ebx, %eax             
    jg      l_hardcore_31          
    jmp     l_hardcore_30           # 321:     goto   30
l_hardcore_31:
    movl    i, %eax                 # 323:     if     i < 3 goto 27
    movl    $3, %ebx               
    cmpl    %ebx, %eax             
    jl      l_hardcore_27          
l_hardcore_30:
l_hardcore_27:
    movl    $1, %eax                # 326:     assign t209 <- 1
    movb    %al, -505(%ebp)        
    jmp     l_hardcore_29           # 327:     goto   29
    movl    $0, %eax                # 328:     assign t209 <- 0
    movb    %al, -505(%ebp)        
l_hardcore_29:
    movzbl  -505(%ebp), %eax        # 330:     assign b <- t209
    movb    %al, b                 
    jmp     l_hardcore_36           # 331:     goto   36
l_hardcore_36:
    movl    $1, %eax                # 333:     assign t210 <- 1
    movb    %al, -513(%ebp)        
    jmp     l_hardcore_38           # 334:     goto   38
    movl    $0, %eax                # 335:     assign t210 <- 0
    movb    %al, -513(%ebp)        
l_hardcore_38:
    movzbl  -513(%ebp), %eax        # 337:     assign b <- t210
    movb    %al, b                 
    jmp     l_hardcore_41           # 338:     goto   41
    jmp     l_hardcore_42           # 339:     goto   42
l_hardcore_41:
    movl    $1, %eax                # 341:     assign t211 <- 1
    movb    %al, -514(%ebp)        
    jmp     l_hardcore_43           # 342:     goto   43
l_hardcore_42:
    movl    $0, %eax                # 344:     assign t211 <- 0
    movb    %al, -514(%ebp)        
l_hardcore_43:
    movzbl  -514(%ebp), %eax        # 346:     assign b <- t211
    movb    %al, b                 
    jmp     l_hardcore_49           # 347:     goto   49
    movl    $0, %eax                # 348:     if     0 = 1 goto 46
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_hardcore_46          
l_hardcore_49:
    movl    $0, %eax                # 350:     if     0 # 1 goto 46
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    jne     l_hardcore_46          
    jmp     l_hardcore_47           # 351:     goto   47
l_hardcore_46:
    movl    $1, %eax                # 353:     assign t212 <- 1
    movb    %al, -515(%ebp)        
    jmp     l_hardcore_48           # 354:     goto   48
l_hardcore_47:
    movl    $0, %eax                # 356:     assign t212 <- 0
    movb    %al, -515(%ebp)        
l_hardcore_48:
    movzbl  -515(%ebp), %eax        # 358:     assign b <- t212
    movb    %al, b                 
    jmp     l_hardcore_57           # 359:     goto   57
    jmp     l_hardcore_57           # 360:     goto   57
    movl    $0, %eax                # 361:     if     0 = 1 goto 55_if_true
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_hardcore_55_if_true  
l_hardcore_57:
    movl    $0, %eax                # 363:     if     0 # 1 goto 55_if_true
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    jne     l_hardcore_55_if_true  
    jmp     l_hardcore_56_if_false  # 364:     goto   56_if_false
l_hardcore_55_if_true:
    jmp     l_hardcore_exit        
    jmp     l_hardcore_54           # 367:     goto   54
l_hardcore_56_if_false:
l_hardcore_54:
    jmp     l_hardcore_65_if_false  # 370:     goto   65_if_false
    jmp     l_hardcore_exit        
    jmp     l_hardcore_63           # 372:     goto   63
l_hardcore_65_if_false:
l_hardcore_63:
    leal    I, %eax                 # 375:     &()    t213 <- I
    movl    %eax, -520(%ebp)       
    movl    -520(%ebp), %eax        # 376:     param  2 <- t213
    pushl   %eax                   
    leal    B, %eax                 # 377:     &()    t214 <- B
    movl    %eax, -524(%ebp)       
    movl    $2, %eax                # 378:     param  1 <- 2
    pushl   %eax                   
    leal    B, %eax                 # 379:     &()    t215 <- B
    movl    %eax, -528(%ebp)       
    movl    -528(%ebp), %eax        # 380:     param  0 <- t215
    pushl   %eax                   
    call    DIM                     # 381:     call   t216 <- DIM
    addl    $8, %esp               
    movl    %eax, -532(%ebp)       
    movl    i, %eax                 # 382:     mul    t217 <- i, t216
    movl    -532(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -536(%ebp)       
    movl    -536(%ebp), %eax        # 383:     add    t218 <- t217, i
    movl    i, %ebx                
    addl    %ebx, %eax             
    movl    %eax, -540(%ebp)       
    movl    $3, %eax                # 384:     param  1 <- 3
    pushl   %eax                   
    leal    B, %eax                 # 385:     &()    t219 <- B
    movl    %eax, -544(%ebp)       
    movl    -544(%ebp), %eax        # 386:     param  0 <- t219
    pushl   %eax                   
    call    DIM                     # 387:     call   t220 <- DIM
    addl    $8, %esp               
    movl    %eax, -552(%ebp)       
    movl    -540(%ebp), %eax        # 388:     mul    t221 <- t218, t220
    movl    -552(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -556(%ebp)       
    movl    i, %eax                 # 389:     add    t222 <- i, i
    movl    i, %ebx                
    addl    %ebx, %eax             
    movl    %eax, -560(%ebp)       
    movl    -556(%ebp), %eax        # 390:     add    t223 <- t221, t222
    movl    -560(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -564(%ebp)       
    movl    -564(%ebp), %eax        # 391:     mul    t224 <- t223, 1
    movl    $1, %ebx               
    imull   %ebx                   
    movl    %eax, -568(%ebp)       
    leal    B, %eax                 # 392:     &()    t225 <- B
    movl    %eax, -572(%ebp)       
    movl    -572(%ebp), %eax        # 393:     param  0 <- t225
    pushl   %eax                   
    call    DOFS                    # 394:     call   t226 <- DOFS
    addl    $4, %esp               
    movl    %eax, -576(%ebp)       
    movl    -568(%ebp), %eax        # 395:     add    t227 <- t224, t226
    movl    -576(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -580(%ebp)       
    movl    -524(%ebp), %eax        # 396:     add    t228 <- t214, t227
    movl    -580(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -584(%ebp)       
    movl    -584(%ebp), %edi       
    movzbl  (%edi), %eax            # 397:     param  1 <- @t228
    pushl   %eax                   
    movl    i, %eax                 # 398:     mul    t229 <- i, i
    movl    i, %ebx                
    imull   %ebx                   
    movl    %eax, -588(%ebp)       
    movl    i, %eax                 # 399:     add    t230 <- i, t229
    movl    -588(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -596(%ebp)       
    movl    -596(%ebp), %eax        # 400:     add    t231 <- t230, i
    movl    i, %ebx                
    addl    %ebx, %eax             
    movl    %eax, -600(%ebp)       
    movl    -600(%ebp), %eax        # 401:     param  0 <- t231
    pushl   %eax                   
    call    fbool                   # 402:     call   t232 <- fbool
    addl    $12, %esp              
    movb    %al, -601(%ebp)        
    movzbl  -601(%ebp), %eax        # 403:     if     t232 = 1 goto 68_if_true
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_hardcore_68_if_true  
    jmp     l_hardcore_69_if_false  # 404:     goto   69_if_false
l_hardcore_68_if_true:
    jmp     l_hardcore_67           # 406:     goto   67
l_hardcore_69_if_false:
l_hardcore_67:
    movl    $0, %eax                # 409:     if     0 # 1 goto 72
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    jne     l_hardcore_72          
    movl    $1, %eax                # 410:     assign t233 <- 1
    movb    %al, -602(%ebp)        
    jmp     l_hardcore_73           # 411:     goto   73
l_hardcore_72:
    movl    $0, %eax                # 413:     assign t233 <- 0
    movb    %al, -602(%ebp)        
l_hardcore_73:
    movzbl  -602(%ebp), %eax        # 415:     assign b <- t233
    movb    %al, b                 
    jmp     l_hardcore_79           # 416:     goto   79
    jmp     l_hardcore_76           # 417:     goto   76
l_hardcore_79:
    leal    I, %eax                 # 419:     &()    t234 <- I
    movl    %eax, -608(%ebp)       
    movl    -608(%ebp), %eax        # 420:     param  2 <- t234
    pushl   %eax                   
    leal    I, %eax                 # 421:     &()    t235 <- I
    movl    %eax, -612(%ebp)       
    movl    -612(%ebp), %eax        # 422:     param  2 <- t235
    pushl   %eax                   
    movl    $1, %eax                # 423:     param  1 <- 1
    pushl   %eax                   
    movl    $1, %eax                # 424:     param  0 <- 1
    pushl   %eax                   
    call    fbool                   # 425:     call   t236 <- fbool
    addl    $12, %esp              
    movb    %al, -613(%ebp)        
    movzbl  -613(%ebp), %eax        # 426:     param  1 <- t236
    pushl   %eax                   
    movl    $5, %eax                # 427:     param  0 <- 5
    pushl   %eax                   
    call    fbool                   # 428:     call   t237 <- fbool
    addl    $12, %esp              
    movb    %al, -614(%ebp)        
    movzbl  -614(%ebp), %eax        # 429:     if     t237 = 1 goto 76
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_hardcore_76          
    jmp     l_hardcore_77           # 430:     goto   77
l_hardcore_76:
    movl    $1, %eax                # 432:     assign t238 <- 1
    movb    %al, -615(%ebp)        
    jmp     l_hardcore_78           # 433:     goto   78
l_hardcore_77:
    movl    $0, %eax                # 435:     assign t238 <- 0
    movb    %al, -615(%ebp)        
l_hardcore_78:
    leal    B, %eax                 # 437:     &()    t239 <- B
    movl    %eax, -620(%ebp)       
    movl    $2, %eax                # 438:     param  1 <- 2
    pushl   %eax                   
    leal    B, %eax                 # 439:     &()    t240 <- B
    movl    %eax, -628(%ebp)       
    movl    -628(%ebp), %eax        # 440:     param  0 <- t240
    pushl   %eax                   
    call    DIM                     # 441:     call   t241 <- DIM
    addl    $8, %esp               
    movl    %eax, -632(%ebp)       
    movl    $3, %eax                # 442:     mul    t242 <- 3, t241
    movl    -632(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -636(%ebp)       
    leal    I, %eax                 # 443:     &()    t243 <- I
    movl    %eax, -640(%ebp)       
    movl    -640(%ebp), %eax        # 444:     param  2 <- t243
    pushl   %eax                   
    movzbl  b, %eax                 # 445:     param  1 <- b
    pushl   %eax                   
    movl    i, %eax                 # 446:     param  0 <- i
    pushl   %eax                   
    call    fint                    # 447:     call   t244 <- fint
    addl    $12, %esp              
    movl    %eax, -644(%ebp)       
    movl    -636(%ebp), %eax        # 448:     add    t245 <- t242, t244
    movl    -644(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -648(%ebp)       
    movl    $3, %eax                # 449:     param  1 <- 3
    pushl   %eax                   
    leal    B, %eax                 # 450:     &()    t246 <- B
    movl    %eax, -652(%ebp)       
    movl    -652(%ebp), %eax        # 451:     param  0 <- t246
    pushl   %eax                   
    call    DIM                     # 452:     call   t247 <- DIM
    addl    $8, %esp               
    movl    %eax, -656(%ebp)       
    movl    -648(%ebp), %eax        # 453:     mul    t248 <- t245, t247
    movl    -656(%ebp), %ebx       
    imull   %ebx                   
    movl    %eax, -660(%ebp)       
    movl    -660(%ebp), %eax        # 454:     add    t249 <- t248, 5
    movl    $5, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -664(%ebp)       
    movl    -664(%ebp), %eax        # 455:     mul    t250 <- t249, 1
    movl    $1, %ebx               
    imull   %ebx                   
    movl    %eax, -672(%ebp)       
    leal    B, %eax                 # 456:     &()    t251 <- B
    movl    %eax, -676(%ebp)       
    movl    -676(%ebp), %eax        # 457:     param  0 <- t251
    pushl   %eax                   
    call    DOFS                    # 458:     call   t252 <- DOFS
    addl    $4, %esp               
    movl    %eax, -680(%ebp)       
    movl    -672(%ebp), %eax        # 459:     add    t253 <- t250, t252
    movl    -680(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -684(%ebp)       
    movl    -620(%ebp), %eax        # 460:     add    t254 <- t239, t253
    movl    -684(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -688(%ebp)       
    movzbl  -615(%ebp), %eax        # 461:     assign @t254 <- t238
    movl    -688(%ebp), %edi       
    movb    %al, (%edi)            
    jmp     l_hardcore_exit        
    jmp     l_hardcore_exit        
    jmp     l_hardcore_exit        
    jmp     l_hardcore_exit        
    jmp     l_hardcore_exit        
    jmp     l_hardcore_81           # 467:     goto   81
l_hardcore_81:
    jmp     l_hardcore_91           # 469:     goto   91
    movl    $1, %eax                # 470:     assign t255 <- 1
    movb    %al, -689(%ebp)        
    jmp     l_hardcore_92           # 471:     goto   92
l_hardcore_91:
    movl    $0, %eax                # 473:     assign t255 <- 0
    movb    %al, -689(%ebp)        
l_hardcore_92:
    movzbl  -689(%ebp), %eax        # 475:     assign b <- t255
    movb    %al, b                 
    jmp     l_hardcore_exit        

l_hardcore_exit:
    # epilogue
    addl    $1004, %esp             # remove locals
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

    # scope: hardcore
B:                                  # <array 5 of <array 6 of <array 5 of <bool>>>>
    .long    3
    .long    5
    .long    6
    .long    5
    .skip  150
    .align   4
C:                                  # <array 7 of <char>>
    .long    1
    .long    7
    .skip    7
    .align   4
I:                                  # <array 3 of <array 4 of <array 1 of <int>>>>
    .long    3
    .long    3
    .long    4
    .long    1
    .skip   48
_str_41:                            # <array 13 of <char>>
    .long    1
    .long   13
    .asciz "Hello World!"
b:                                  # <bool>
    .skip    1
    .align   4
i:                                  # <int>
    .skip    4




    # end of global data section
    #-----------------------------------------

    .end
##################################################
