##################################################
# primes
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

    # scope CalcPrimes
CalcPrimes:
    # stack offsets:
    #    -16(%ebp)   4  [ $N        <int> %ebp-16 ]
    #    -20(%ebp)   4  [ $i        <int> %ebp-20 ]
    #    -21(%ebp)   1  [ $isprime  <bool> %ebp-21 ]
    #     12(%ebp)   4  [ %n        <int> %ebp+12 ]
    #      8(%ebp)   4  [ %p        <ptr(4) to <array of <int>>> %ebp+8 ]
    #    -28(%ebp)   4  [ $pidx     <int> %ebp-28 ]
    #    -32(%ebp)   4  [ $psqrt    <int> %ebp-32 ]
    #    -36(%ebp)   4  [ $t0       <ptr(4) to <array 30 of <char>>> %ebp-36 ]
    #    -40(%ebp)   4  [ $t1       <ptr(4) to <array 4 of <char>>> %ebp-40 ]
    #    -44(%ebp)   4  [ $t10      <int> %ebp-44 ]
    #    -48(%ebp)   4  [ $t11      <int> %ebp-48 ]
    #    -52(%ebp)   4  [ $t12      <int> %ebp-52 ]
    #    -56(%ebp)   4  [ $t13      <int> %ebp-56 ]
    #    -60(%ebp)   4  [ $t14      <int> %ebp-60 ]
    #    -64(%ebp)   4  [ $t15      <int> %ebp-64 ]
    #    -68(%ebp)   4  [ $t16      <int> %ebp-68 ]
    #    -72(%ebp)   4  [ $t17      <int> %ebp-72 ]
    #    -76(%ebp)   4  [ $t18      <int> %ebp-76 ]
    #    -80(%ebp)   4  [ $t19      <int> %ebp-80 ]
    #    -84(%ebp)   4  [ $t2       <int> %ebp-84 ]
    #    -88(%ebp)   4  [ $t20      <int> %ebp-88 ]
    #    -92(%ebp)   4  [ $t21      <int> %ebp-92 ]
    #    -96(%ebp)   4  [ $t22      <int> %ebp-96 ]
    #   -100(%ebp)   4  [ $t23      <int> %ebp-100 ]
    #   -104(%ebp)   4  [ $t24      <int> %ebp-104 ]
    #   -108(%ebp)   4  [ $t25      <int> %ebp-108 ]
    #   -112(%ebp)   4  [ $t26      <int> %ebp-112 ]
    #   -116(%ebp)   4  [ $t27      <ptr(4) to <array 45 of <char>>> %ebp-116 ]
    #   -120(%ebp)   4  [ $t28      <int> %ebp-120 ]
    #   -124(%ebp)   4  [ $t29      <int> %ebp-124 ]
    #   -128(%ebp)   4  [ $t3       <int> %ebp-128 ]
    #   -132(%ebp)   4  [ $t30      <int> %ebp-132 ]
    #   -136(%ebp)   4  [ $t31      <int> %ebp-136 ]
    #   -140(%ebp)   4  [ $t32      <int> %ebp-140 ]
    #   -144(%ebp)   4  [ $t33      <int> %ebp-144 ]
    #   -148(%ebp)   4  [ $t34      <int> %ebp-148 ]
    #   -152(%ebp)   4  [ $t35      <int> %ebp-152 ]
    #   -156(%ebp)   4  [ $t36      <int> %ebp-156 ]
    #   -160(%ebp)   4  [ $t37      <int> %ebp-160 ]
    #   -164(%ebp)   4  [ $t38      <int> %ebp-164 ]
    #   -168(%ebp)   4  [ $t39      <ptr(4) to <array 7 of <char>>> %ebp-168 ]
    #   -172(%ebp)   4  [ $t4       <int> %ebp-172 ]
    #   -176(%ebp)   4  [ $t40      <ptr(4) to <array 7 of <char>>> %ebp-176 ]
    #   -180(%ebp)   4  [ $t41      <ptr(4) to <array 15 of <char>>> %ebp-180 ]
    #   -184(%ebp)   4  [ $t5       <int> %ebp-184 ]
    #   -188(%ebp)   4  [ $t6       <int> %ebp-188 ]
    #   -192(%ebp)   4  [ $t7       <int> %ebp-192 ]
    #   -196(%ebp)   4  [ $t8       <int> %ebp-196 ]
    #   -200(%ebp)   4  [ $t9       <int> %ebp-200 ]
    #   -204(%ebp)   4  [ $v        <int> %ebp-204 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $192, %esp              # make room for locals

    cld                             # memset local stack area to 0
    xorl    %eax, %eax             
    movl    $48, %ecx              
    mov     %esp, %edi             
    rep     stosl                  

    # function body
    leal    _str_6, %eax            #   0:     &()    t0 <- _str_6
    movl    %eax, -36(%ebp)        
    movl    -36(%ebp), %eax         #   1:     param  0 <- t0
    pushl   %eax                   
    call    WriteStr                #   2:     call   WriteStr
    addl    $4, %esp               
    movl    12(%ebp), %eax          #   3:     param  0 <- n
    pushl   %eax                   
    call    WriteInt                #   4:     call   WriteInt
    addl    $4, %esp               
    leal    _str_7, %eax            #   5:     &()    t1 <- _str_7
    movl    %eax, -40(%ebp)        
    movl    -40(%ebp), %eax         #   6:     param  0 <- t1
    pushl   %eax                   
    call    WriteStr                #   7:     call   WriteStr
    addl    $4, %esp               
    movl    $1, %eax                #   8:     param  1 <- 1
    pushl   %eax                   
    movl    8(%ebp), %eax           #   9:     param  0 <- p
    pushl   %eax                   
    call    DIM                     #  10:     call   t2 <- DIM
    addl    $8, %esp               
    movl    %eax, -84(%ebp)        
    movl    -84(%ebp), %eax         #  11:     assign N <- t2
    movl    %eax, -16(%ebp)        
    movl    -16(%ebp), %eax         #  12:     if     N < 1 goto 5_if_true
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    jl      l_CalcPrimes_5_if_true 
    jmp     l_CalcPrimes_6_if_false #  13:     goto   6_if_false
l_CalcPrimes_5_if_true:
    movl    $0, %eax                #  15:     return 0
    jmp     l_CalcPrimes_exit      
    jmp     l_CalcPrimes_4          #  16:     goto   4
l_CalcPrimes_6_if_false:
l_CalcPrimes_4:
    movl    $0, %eax                #  19:     mul    t3 <- 0, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -128(%ebp)       
    movl    8(%ebp), %eax           #  20:     param  0 <- p
    pushl   %eax                   
    call    DOFS                    #  21:     call   t4 <- DOFS
    addl    $4, %esp               
    movl    %eax, -172(%ebp)       
    movl    -128(%ebp), %eax        #  22:     add    t5 <- t3, t4
    movl    -172(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -184(%ebp)       
    movl    8(%ebp), %eax           #  23:     add    t6 <- p, t5
    movl    -184(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -188(%ebp)       
    movl    $1, %eax                #  24:     assign @t6 <- 1
    movl    -188(%ebp), %edi       
    movl    %eax, (%edi)           
    movl    $1, %eax                #  25:     mul    t7 <- 1, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -192(%ebp)       
    movl    8(%ebp), %eax           #  26:     param  0 <- p
    pushl   %eax                   
    call    DOFS                    #  27:     call   t8 <- DOFS
    addl    $4, %esp               
    movl    %eax, -196(%ebp)       
    movl    -192(%ebp), %eax        #  28:     add    t9 <- t7, t8
    movl    -196(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -200(%ebp)       
    movl    8(%ebp), %eax           #  29:     add    t10 <- p, t9
    movl    -200(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -44(%ebp)        
    movl    $2, %eax                #  30:     assign @t10 <- 2
    movl    -44(%ebp), %edi        
    movl    %eax, (%edi)           
    movl    $2, %eax                #  31:     assign pidx <- 2
    movl    %eax, -28(%ebp)        
    movl    $1, %eax                #  32:     assign psqrt <- 1
    movl    %eax, -32(%ebp)        
    movl    $3, %eax                #  33:     assign v <- 3
    movl    %eax, -204(%ebp)       
l_CalcPrimes_15_while_cond:
    movl    -204(%ebp), %eax        #  35:     if     v <= n goto 16_while_body
    movl    12(%ebp), %ebx         
    cmpl    %ebx, %eax             
    jle     l_CalcPrimes_16_while_body
    jmp     l_CalcPrimes_14         #  36:     goto   14
l_CalcPrimes_16_while_body:
    movl    $1, %eax                #  38:     assign isprime <- 1
    movb    %al, -21(%ebp)         
    movl    $1, %eax                #  39:     assign i <- 1
    movl    %eax, -20(%ebp)        
l_CalcPrimes_21_while_cond:
    movzbl  -21(%ebp), %eax         #  41:     if     isprime = 1 goto 23
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_CalcPrimes_23        
    jmp     l_CalcPrimes_20         #  42:     goto   20
l_CalcPrimes_23:
    movl    -20(%ebp), %eax         #  44:     if     i <= psqrt goto 22_while_body
    movl    -32(%ebp), %ebx        
    cmpl    %ebx, %eax             
    jle     l_CalcPrimes_22_while_body
    jmp     l_CalcPrimes_20         #  45:     goto   20
l_CalcPrimes_22_while_body:
    movl    -20(%ebp), %eax         #  47:     mul    t11 <- i, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -48(%ebp)        
    movl    8(%ebp), %eax           #  48:     param  0 <- p
    pushl   %eax                   
    call    DOFS                    #  49:     call   t12 <- DOFS
    addl    $4, %esp               
    movl    %eax, -52(%ebp)        
    movl    -48(%ebp), %eax         #  50:     add    t13 <- t11, t12
    movl    -52(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -56(%ebp)        
    movl    8(%ebp), %eax           #  51:     add    t14 <- p, t13
    movl    -56(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -60(%ebp)        
    movl    -204(%ebp), %eax        #  52:     div    t15 <- v, @t14
    movl    -60(%ebp), %edi        
    movl    (%edi), %ebx           
    cdq                            
    idivl   %ebx                   
    movl    %eax, -64(%ebp)        
    movl    -20(%ebp), %eax         #  53:     mul    t16 <- i, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -68(%ebp)        
    movl    8(%ebp), %eax           #  54:     param  0 <- p
    pushl   %eax                   
    call    DOFS                    #  55:     call   t17 <- DOFS
    addl    $4, %esp               
    movl    %eax, -72(%ebp)        
    movl    -68(%ebp), %eax         #  56:     add    t18 <- t16, t17
    movl    -72(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -76(%ebp)        
    movl    8(%ebp), %eax           #  57:     add    t19 <- p, t18
    movl    -76(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -80(%ebp)        
    movl    -64(%ebp), %eax         #  58:     mul    t20 <- t15, @t19
    movl    -80(%ebp), %edi        
    movl    (%edi), %ebx           
    imull   %ebx                   
    movl    %eax, -88(%ebp)        
    movl    -88(%ebp), %eax         #  59:     if     t20 = v goto 26_if_true
    movl    -204(%ebp), %ebx       
    cmpl    %ebx, %eax             
    je      l_CalcPrimes_26_if_true
    jmp     l_CalcPrimes_27_if_false #  60:     goto   27_if_false
l_CalcPrimes_26_if_true:
    movl    $0, %eax                #  62:     assign isprime <- 0
    movb    %al, -21(%ebp)         
    jmp     l_CalcPrimes_25         #  63:     goto   25
l_CalcPrimes_27_if_false:
l_CalcPrimes_25:
    movl    -20(%ebp), %eax         #  66:     add    t21 <- i, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -92(%ebp)        
    movl    -92(%ebp), %eax         #  67:     assign i <- t21
    movl    %eax, -20(%ebp)        
    jmp     l_CalcPrimes_21_while_cond #  68:     goto   21_while_cond
l_CalcPrimes_20:
    movzbl  -21(%ebp), %eax         #  70:     if     isprime = 1 goto 32_if_true
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_CalcPrimes_32_if_true
    jmp     l_CalcPrimes_33_if_false #  71:     goto   33_if_false
l_CalcPrimes_32_if_true:
    movl    -28(%ebp), %eax         #  73:     mul    t22 <- pidx, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -96(%ebp)        
    movl    8(%ebp), %eax           #  74:     param  0 <- p
    pushl   %eax                   
    call    DOFS                    #  75:     call   t23 <- DOFS
    addl    $4, %esp               
    movl    %eax, -100(%ebp)       
    movl    -96(%ebp), %eax         #  76:     add    t24 <- t22, t23
    movl    -100(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -104(%ebp)       
    movl    8(%ebp), %eax           #  77:     add    t25 <- p, t24
    movl    -104(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -108(%ebp)       
    movl    -204(%ebp), %eax        #  78:     assign @t25 <- v
    movl    -108(%ebp), %edi       
    movl    %eax, (%edi)           
    movl    -28(%ebp), %eax         #  79:     add    t26 <- pidx, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -112(%ebp)       
    movl    -112(%ebp), %eax        #  80:     assign pidx <- t26
    movl    %eax, -28(%ebp)        
    movl    -28(%ebp), %eax         #  81:     if     pidx = N goto 38_if_true
    movl    -16(%ebp), %ebx        
    cmpl    %ebx, %eax             
    je      l_CalcPrimes_38_if_true
    jmp     l_CalcPrimes_39_if_false #  82:     goto   39_if_false
l_CalcPrimes_38_if_true:
    leal    _str_8, %eax            #  84:     &()    t27 <- _str_8
    movl    %eax, -116(%ebp)       
    movl    -116(%ebp), %eax        #  85:     param  0 <- t27
    pushl   %eax                   
    call    WriteStr                #  86:     call   WriteStr
    addl    $4, %esp               
    movl    $0, %eax                #  87:     assign n <- 0
    movl    %eax, 12(%ebp)         
    jmp     l_CalcPrimes_37         #  88:     goto   37
l_CalcPrimes_39_if_false:
l_CalcPrimes_37:
    jmp     l_CalcPrimes_31         #  91:     goto   31
l_CalcPrimes_33_if_false:
l_CalcPrimes_31:
    movl    -204(%ebp), %eax        #  94:     add    t28 <- v, 2
    movl    $2, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -120(%ebp)       
    movl    -120(%ebp), %eax        #  95:     assign v <- t28
    movl    %eax, -204(%ebp)       
    movl    -32(%ebp), %eax         #  96:     mul    t29 <- psqrt, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -124(%ebp)       
    movl    8(%ebp), %eax           #  97:     param  0 <- p
    pushl   %eax                   
    call    DOFS                    #  98:     call   t30 <- DOFS
    addl    $4, %esp               
    movl    %eax, -132(%ebp)       
    movl    -124(%ebp), %eax        #  99:     add    t31 <- t29, t30
    movl    -132(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -136(%ebp)       
    movl    8(%ebp), %eax           # 100:     add    t32 <- p, t31
    movl    -136(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -140(%ebp)       
    movl    -32(%ebp), %eax         # 101:     mul    t33 <- psqrt, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -144(%ebp)       
    movl    8(%ebp), %eax           # 102:     param  0 <- p
    pushl   %eax                   
    call    DOFS                    # 103:     call   t34 <- DOFS
    addl    $4, %esp               
    movl    %eax, -148(%ebp)       
    movl    -144(%ebp), %eax        # 104:     add    t35 <- t33, t34
    movl    -148(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -152(%ebp)       
    movl    8(%ebp), %eax           # 105:     add    t36 <- p, t35
    movl    -152(%ebp), %ebx       
    addl    %ebx, %eax             
    movl    %eax, -156(%ebp)       
    movl    -140(%ebp), %edi       
    movl    (%edi), %eax            # 106:     mul    t37 <- @t32, @t36
    movl    -156(%ebp), %edi       
    movl    (%edi), %ebx           
    imull   %ebx                   
    movl    %eax, -160(%ebp)       
    movl    -204(%ebp), %eax        # 107:     if     v > t37 goto 45_if_true
    movl    -160(%ebp), %ebx       
    cmpl    %ebx, %eax             
    jg      l_CalcPrimes_45_if_true
    jmp     l_CalcPrimes_46_if_false # 108:     goto   46_if_false
l_CalcPrimes_45_if_true:
    movl    -32(%ebp), %eax         # 110:     add    t38 <- psqrt, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -164(%ebp)       
    movl    -164(%ebp), %eax        # 111:     assign psqrt <- t38
    movl    %eax, -32(%ebp)        
    movl    -32(%ebp), %eax         # 112:     if     psqrt >= pidx goto 50_if_true
    movl    -28(%ebp), %ebx        
    cmpl    %ebx, %eax             
    jge     l_CalcPrimes_50_if_true
    jmp     l_CalcPrimes_51_if_false # 113:     goto   51_if_false
l_CalcPrimes_50_if_true:
    leal    _str_9, %eax            # 115:     &()    t39 <- _str_9
    movl    %eax, -168(%ebp)       
    movl    -168(%ebp), %eax        # 116:     param  0 <- t39
    pushl   %eax                   
    call    WriteStr                # 117:     call   WriteStr
    addl    $4, %esp               
    movl    $0, %eax                # 118:     assign n <- 0
    movl    %eax, 12(%ebp)         
    jmp     l_CalcPrimes_49         # 119:     goto   49
l_CalcPrimes_51_if_false:
l_CalcPrimes_49:
    jmp     l_CalcPrimes_44         # 122:     goto   44
l_CalcPrimes_46_if_false:
l_CalcPrimes_44:
    jmp     l_CalcPrimes_15_while_cond # 125:     goto   15_while_cond
l_CalcPrimes_14:
    leal    _str_10, %eax           # 127:     &()    t40 <- _str_10
    movl    %eax, -176(%ebp)       
    movl    -176(%ebp), %eax        # 128:     param  0 <- t40
    pushl   %eax                   
    call    WriteStr                # 129:     call   WriteStr
    addl    $4, %esp               
    movl    -28(%ebp), %eax         # 130:     param  0 <- pidx
    pushl   %eax                   
    call    WriteInt                # 131:     call   WriteInt
    addl    $4, %esp               
    leal    _str_11, %eax           # 132:     &()    t41 <- _str_11
    movl    %eax, -180(%ebp)       
    movl    -180(%ebp), %eax        # 133:     param  0 <- t41
    pushl   %eax                   
    call    WriteStr                # 134:     call   WriteStr
    addl    $4, %esp               
    call    WriteLn                 # 135:     call   WriteLn
    movl    -28(%ebp), %eax         # 136:     return pidx
    jmp     l_CalcPrimes_exit      

l_CalcPrimes_exit:
    # epilogue
    addl    $192, %esp              # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # scope PrintPrimes
PrintPrimes:
    # stack offsets:
    #    -16(%ebp)   4  [ $i        <int> %ebp-16 ]
    #     12(%ebp)   4  [ %n        <int> %ebp+12 ]
    #      8(%ebp)   4  [ %p        <ptr(4) to <array of <int>>> %ebp+8 ]
    #     16(%ebp)   4  [ %pn       <int> %ebp+16 ]
    #    -20(%ebp)   4  [ $t0       <ptr(4) to <array 20 of <char>>> %ebp-20 ]
    #    -24(%ebp)   4  [ $t1       <ptr(4) to <array 3 of <char>>> %ebp-24 ]
    #    -28(%ebp)   4  [ $t2       <int> %ebp-28 ]
    #    -32(%ebp)   4  [ $t3       <int> %ebp-32 ]
    #    -36(%ebp)   4  [ $t4       <int> %ebp-36 ]
    #    -40(%ebp)   4  [ $t5       <int> %ebp-40 ]
    #    -44(%ebp)   4  [ $t6       <int> %ebp-44 ]
    #    -48(%ebp)   4  [ $t7       <int> %ebp-48 ]
    #    -52(%ebp)   4  [ $t8       <int> %ebp-52 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $40, %esp               # make room for locals

    cld                             # memset local stack area to 0
    xorl    %eax, %eax             
    movl    $10, %ecx              
    mov     %esp, %edi             
    rep     stosl                  

    # function body
    leal    _str_12, %eax           #   0:     &()    t0 <- _str_12
    movl    %eax, -20(%ebp)        
    movl    -20(%ebp), %eax         #   1:     param  0 <- t0
    pushl   %eax                   
    call    WriteStr                #   2:     call   WriteStr
    addl    $4, %esp               
    movl    12(%ebp), %eax          #   3:     param  0 <- n
    pushl   %eax                   
    call    WriteInt                #   4:     call   WriteInt
    addl    $4, %esp               
    call    WriteLn                 #   5:     call   WriteLn
    movl    $0, %eax                #   6:     assign i <- 0
    movl    %eax, -16(%ebp)        
l_PrintPrimes_5_while_cond:
    movl    -16(%ebp), %eax         #   8:     if     i < pn goto 6_while_body
    movl    16(%ebp), %ebx         
    cmpl    %ebx, %eax             
    jl      l_PrintPrimes_6_while_body
    jmp     l_PrintPrimes_4         #   9:     goto   4
l_PrintPrimes_6_while_body:
    leal    _str_13, %eax           #  11:     &()    t1 <- _str_13
    movl    %eax, -24(%ebp)        
    movl    -24(%ebp), %eax         #  12:     param  0 <- t1
    pushl   %eax                   
    call    WriteStr                #  13:     call   WriteStr
    addl    $4, %esp               
    movl    -16(%ebp), %eax         #  14:     mul    t2 <- i, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -28(%ebp)        
    movl    8(%ebp), %eax           #  15:     param  0 <- p
    pushl   %eax                   
    call    DOFS                    #  16:     call   t3 <- DOFS
    addl    $4, %esp               
    movl    %eax, -32(%ebp)        
    movl    -28(%ebp), %eax         #  17:     add    t4 <- t2, t3
    movl    -32(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -36(%ebp)        
    movl    8(%ebp), %eax           #  18:     add    t5 <- p, t4
    movl    -36(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -40(%ebp)        
    movl    -40(%ebp), %edi        
    movl    (%edi), %eax            #  19:     param  0 <- @t5
    pushl   %eax                   
    call    WriteInt                #  20:     call   WriteInt
    addl    $4, %esp               
    movl    -16(%ebp), %eax         #  21:     add    t6 <- i, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -44(%ebp)        
    movl    -44(%ebp), %eax         #  22:     assign i <- t6
    movl    %eax, -16(%ebp)        
    movl    -16(%ebp), %eax         #  23:     div    t7 <- i, 8
    movl    $8, %ebx               
    cdq                            
    idivl   %ebx                   
    movl    %eax, -48(%ebp)        
    movl    -48(%ebp), %eax         #  24:     mul    t8 <- t7, 8
    movl    $8, %ebx               
    imull   %ebx                   
    movl    %eax, -52(%ebp)        
    movl    -52(%ebp), %eax         #  25:     if     t8 = i goto 12_if_true
    movl    -16(%ebp), %ebx        
    cmpl    %ebx, %eax             
    je      l_PrintPrimes_12_if_true
    jmp     l_PrintPrimes_13_if_false #  26:     goto   13_if_false
l_PrintPrimes_12_if_true:
    call    WriteLn                 #  28:     call   WriteLn
    jmp     l_PrintPrimes_11        #  29:     goto   11
l_PrintPrimes_13_if_false:
l_PrintPrimes_11:
    jmp     l_PrintPrimes_5_while_cond #  32:     goto   5_while_cond
l_PrintPrimes_4:
    call    WriteLn                 #  34:     call   WriteLn

l_PrintPrimes_exit:
    # epilogue
    addl    $40, %esp               # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # scope primes
main:
    # stack offsets:
    #    -16(%ebp)   4  [ $t0       <ptr(4) to <array 14 of <char>>> %ebp-16 ]
    #    -20(%ebp)   4  [ $t1       <ptr(4) to <array 24 of <char>>> %ebp-20 ]
    #    -24(%ebp)   4  [ $t2       <int> %ebp-24 ]
    #    -28(%ebp)   4  [ $t3       <ptr(4) to <array 1000000 of <int>>> %ebp-28 ]
    #    -32(%ebp)   4  [ $t4       <int> %ebp-32 ]
    #    -36(%ebp)   4  [ $t5       <ptr(4) to <array 1000000 of <int>>> %ebp-36 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $24, %esp               # make room for locals

    cld                             # memset local stack area to 0
    xorl    %eax, %eax             
    movl    $6, %ecx               
    mov     %esp, %edi             
    rep     stosl                  

    # function body
    leal    _str_14, %eax           #   0:     &()    t0 <- _str_14
    movl    %eax, -16(%ebp)        
    movl    -16(%ebp), %eax         #   1:     param  0 <- t0
    pushl   %eax                   
    call    WriteStr                #   2:     call   WriteStr
    addl    $4, %esp               
    call    WriteLn                 #   3:     call   WriteLn
    leal    _str_15, %eax           #   4:     &()    t1 <- _str_15
    movl    %eax, -20(%ebp)        
    movl    -20(%ebp), %eax         #   5:     param  0 <- t1
    pushl   %eax                   
    call    WriteStr                #   6:     call   WriteStr
    addl    $4, %esp               
    call    ReadInt                 #   7:     call   t2 <- ReadInt
    movl    %eax, -24(%ebp)        
    movl    -24(%ebp), %eax         #   8:     assign n <- t2
    movl    %eax, n                
    movl    n, %eax                 #   9:     param  1 <- n
    pushl   %eax                   
    leal    p, %eax                 #  10:     &()    t3 <- p
    movl    %eax, -28(%ebp)        
    movl    -28(%ebp), %eax         #  11:     param  0 <- t3
    pushl   %eax                   
    call    CalcPrimes              #  12:     call   t4 <- CalcPrimes
    addl    $8, %esp               
    movl    %eax, -32(%ebp)        
    movl    -32(%ebp), %eax         #  13:     assign pn <- t4
    movl    %eax, pn               
    movl    pn, %eax                #  14:     param  2 <- pn
    pushl   %eax                   
    movl    n, %eax                 #  15:     param  1 <- n
    pushl   %eax                   
    leal    p, %eax                 #  16:     &()    t5 <- p
    movl    %eax, -36(%ebp)        
    movl    -36(%ebp), %eax         #  17:     param  0 <- t5
    pushl   %eax                   
    call    PrintPrimes             #  18:     call   PrintPrimes
    addl    $12, %esp              

l_primes_exit:
    # epilogue
    addl    $24, %esp               # remove locals
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

    # scope: primes
_str_10:                            # <array 7 of <char>>
    .long    1
    .long    7
    .asciz "done. "
    .align   4
_str_11:                            # <array 15 of <char>>
    .long    1
    .long   15
    .asciz " primes found."
    .align   4
_str_12:                            # <array 20 of <char>>
    .long    1
    .long   20
    .asciz "Prime numbers 1 to "
_str_13:                            # <array 3 of <char>>
    .long    1
    .long    3
    .asciz "  "
    .align   4
_str_14:                            # <array 14 of <char>>
    .long    1
    .long   14
    .asciz "Prime numbers"
    .align   4
_str_15:                            # <array 24 of <char>>
    .long    1
    .long   24
    .asciz "Compute primes up to : "
_str_6:                             # <array 30 of <char>>
    .long    1
    .long   30
    .asciz "  computing primes from 1 to "
    .align   4
_str_7:                             # <array 4 of <char>>
    .long    1
    .long    4
    .asciz "..."
_str_8:                             # <array 45 of <char>>
    .long    1
    .long   45
    .asciz "WARNING: array too small to hold all primes."
    .align   4
_str_9:                             # <array 7 of <char>>
    .long    1
    .long    7
    .asciz "ERROR."
    .align   4
n:                                  # <int>
    .skip    4
p:                                  # <array 1000000 of <int>>
    .long    1
    .long 1000000
    .skip 4000000
pn:                                 # <int>
    .skip    4



    # end of global data section
    #-----------------------------------------

    .end
##################################################
