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
    #     20(%ebp)   4  [ %D        <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp+20 ]
    #     24(%ebp)   4  [ %E        <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp+24 ]
    #     28(%ebp)   4  [ %F        <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp+28 ]
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
    #    -72(%ebp)   4  [ $t3       <int> %ebp-72 ]
    #    -76(%ebp)   4  [ $t4       <int> %ebp-76 ]
    #    -80(%ebp)   4  [ $t5       <int> %ebp-80 ]
    #    -84(%ebp)   4  [ $t6       <int> %ebp-84 ]
    #    -88(%ebp)   4  [ $t7       <int> %ebp-88 ]
    #    -92(%ebp)   4  [ $t8       <int> %ebp-92 ]
    #    -96(%ebp)   4  [ $t9       <int> %ebp-96 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $84, %esp               # make room for locals

    cld                             # memset local stack area to 0
    xorl    %eax, %eax             
    movl    $21, %ecx              
    mov     %esp, %edi             
    rep     stosl                  

    # function body
    movl    $2, %eax                #   0:     param  1 <- 2
    pushl   %eax                   
    movl    16(%ebp), %eax          #   1:     param  0 <- C
    pushl   %eax                   
    call    DIM                     #   2:     call   t0 <- DIM
    addl    $8, %esp               
    movl    %eax, -20(%ebp)        
    movl    $5, %eax                #   3:     mul    t1 <- 5, t0
    movl    -20(%ebp), %ebx        
    imull   %ebx                   
    movl    %eax, -24(%ebp)        
    movl    $2, %eax                #   4:     param  1 <- 2
    pushl   %eax                   
    movl    20(%ebp), %eax          #   5:     param  0 <- D
    pushl   %eax                   
    call    DIM                     #   6:     call   t2 <- DIM
    addl    $8, %esp               
    movl    %eax, -68(%ebp)        
    movl    $5, %eax                #   7:     mul    t3 <- 5, t2
    movl    -68(%ebp), %ebx        
    imull   %ebx                   
    movl    %eax, -72(%ebp)        
    movl    -72(%ebp), %eax         #   8:     add    t4 <- t3, 6
    movl    $6, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -76(%ebp)        
    movl    $3, %eax                #   9:     param  1 <- 3
    pushl   %eax                   
    movl    20(%ebp), %eax          #  10:     param  0 <- D
    pushl   %eax                   
    call    DIM                     #  11:     call   t5 <- DIM
    addl    $8, %esp               
    movl    %eax, -80(%ebp)        
    movl    -76(%ebp), %eax         #  12:     mul    t6 <- t4, t5
    movl    -80(%ebp), %ebx        
    imull   %ebx                   
    movl    %eax, -84(%ebp)        
    movl    -84(%ebp), %eax         #  13:     add    t7 <- t6, 7
    movl    $7, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -88(%ebp)        
    movl    -88(%ebp), %eax         #  14:     mul    t8 <- t7, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -92(%ebp)        
    movl    20(%ebp), %eax          #  15:     param  0 <- D
    pushl   %eax                   
    call    DOFS                    #  16:     call   t9 <- DOFS
    addl    $4, %esp               
    movl    %eax, -96(%ebp)        
    movl    -92(%ebp), %eax         #  17:     add    t10 <- t8, t9
    movl    -96(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -28(%ebp)        
    movl    20(%ebp), %eax          #  18:     add    t11 <- D, t10
    movl    -28(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -32(%ebp)        
    movl    -24(%ebp), %eax         #  19:     add    t12 <- t1, @t11
    movl    -32(%ebp), %edi        
    movl    (%edi), %ebx           
    addl    %ebx, %eax             
    movl    %eax, -36(%ebp)        
    movl    $3, %eax                #  20:     param  1 <- 3
    pushl   %eax                   
    movl    16(%ebp), %eax          #  21:     param  0 <- C
    pushl   %eax                   
    call    DIM                     #  22:     call   t13 <- DIM
    addl    $8, %esp               
    movl    %eax, -40(%ebp)        
    movl    -36(%ebp), %eax         #  23:     mul    t14 <- t12, t13
    movl    -40(%ebp), %ebx        
    imull   %ebx                   
    movl    %eax, -44(%ebp)        
    movl    -44(%ebp), %eax         #  24:     add    t15 <- t14, 4
    movl    $4, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -48(%ebp)        
    movl    -48(%ebp), %eax         #  25:     mul    t16 <- t15, 4
    movl    $4, %ebx               
    imull   %ebx                   
    movl    %eax, -52(%ebp)        
    movl    16(%ebp), %eax          #  26:     param  0 <- C
    pushl   %eax                   
    call    DOFS                    #  27:     call   t17 <- DOFS
    addl    $4, %esp               
    movl    %eax, -56(%ebp)        
    movl    -52(%ebp), %eax         #  28:     add    t18 <- t16, t17
    movl    -56(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -60(%ebp)        
    movl    16(%ebp), %eax          #  29:     add    t19 <- C, t18
    movl    -60(%ebp), %ebx        
    addl    %ebx, %eax             
    movl    %eax, -64(%ebp)        
    movl    $1, %eax                #  30:     assign @t19 <- 1
    movl    -64(%ebp), %edi        
    movl    %eax, (%edi)           

l_fint_exit:
    # epilogue
    addl    $84, %esp               # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # scope hardcore
main:
    # stack offsets:
    #    -16(%ebp)   4  [ $t0       <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-16 ]
    #    -20(%ebp)   4  [ $t1       <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-20 ]
    #    -24(%ebp)   4  [ $t2       <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-24 ]
    #    -28(%ebp)   4  [ $t3       <ptr(4) to <array 3 of <array 4 of <array 1 of <int>>>>> %ebp-28 ]
    #    -29(%ebp)   1  [ $t4       <bool> %ebp-29 ]
    #    -36(%ebp)   4  [ $t5       <int> %ebp-36 ]
    #    -40(%ebp)   4  [ $t6       <int> %ebp-40 ]
    #    -44(%ebp)   4  [ $t7       <ptr(4) to <array 13 of <char>>> %ebp-44 ]

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
    leal    I, %eax                 #   0:     &()    t0 <- I
    movl    %eax, -16(%ebp)        
    movl    -16(%ebp), %eax         #   1:     param  5 <- t0
    pushl   %eax                   
    leal    I, %eax                 #   2:     &()    t1 <- I
    movl    %eax, -20(%ebp)        
    movl    -20(%ebp), %eax         #   3:     param  4 <- t1
    pushl   %eax                   
    leal    I, %eax                 #   4:     &()    t2 <- I
    movl    %eax, -24(%ebp)        
    movl    -24(%ebp), %eax         #   5:     param  3 <- t2
    pushl   %eax                   
    leal    I, %eax                 #   6:     &()    t3 <- I
    movl    %eax, -28(%ebp)        
    movl    -28(%ebp), %eax         #   7:     param  2 <- t3
    pushl   %eax                   
    jmp     l_hardcore_2            #   8:     goto   2
    movl    $1, %eax                #   9:     assign t4 <- 1
    movb    %al, -29(%ebp)         
    jmp     l_hardcore_3            #  10:     goto   3
l_hardcore_2:
    movl    $0, %eax                #  12:     assign t4 <- 0
    movb    %al, -29(%ebp)         
l_hardcore_3:
    movzbl  -29(%ebp), %eax         #  14:     param  1 <- t4
    pushl   %eax                   
    movl    $1, %eax                #  15:     param  0 <- 1
    pushl   %eax                   
    call    fint                    #  16:     call   t5 <- fint
    addl    $24, %esp              
    movl    %eax, -36(%ebp)        
    movl    -36(%ebp), %eax         #  17:     neg    t6 <- t5
    negl    %eax                   
    movl    %eax, -40(%ebp)        
    movl    -40(%ebp), %eax         #  18:     assign i <- t6
    movl    %eax, i                
    leal    _str_22, %eax           #  19:     &()    t7 <- _str_22
    movl    %eax, -44(%ebp)        
    movl    -44(%ebp), %eax         #  20:     param  0 <- t7
    pushl   %eax                   
    call    WriteStr                #  21:     call   WriteStr
    addl    $4, %esp               

l_hardcore_exit:
    # epilogue
    addl    $32, %esp               # remove locals
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
_str_22:                            # <array 13 of <char>>
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
