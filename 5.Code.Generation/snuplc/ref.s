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
    #      8(%ebp)   4  [ %a        <int> %ebp+8 ]
    #    -16(%ebp)   4  [ $aa       <int> %ebp-16 ]
    #    -17(%ebp)   1  [ $bb       <bool> %ebp-17 ]
    #    -24(%ebp)   4  [ $t3       <int> %ebp-24 ]
    #    -25(%ebp)   1  [ $t4       <bool> %ebp-25 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $16, %esp               # make room for locals

    xorl    %eax, %eax              # memset local stack area to 0
    movl    %eax, 12(%esp)         
    movl    %eax, 8(%esp)          
    movl    %eax, 4(%esp)          
    movl    %eax, 0(%esp)          

    # function body
    movl    A, %eax                 #   0:     add    t3 <- A, 1
    movl    $1, %ebx               
    addl    %ebx, %eax             
    movl    %eax, -24(%ebp)        
    movl    -24(%ebp), %eax         #   1:     assign aa <- t3
    movl    %eax, -16(%ebp)        
    movl    8(%ebp), %eax           #   2:     if     a > aa goto 2
    movl    -16(%ebp), %ebx        
    cmpl    %ebx, %eax             
    jg      l_foo_2                
    jmp     l_foo_3                 #   3:     goto   3
l_foo_2:
    movl    $1, %eax                #   5:     assign t4 <- 1
    movb    %al, -25(%ebp)         
    jmp     l_foo_4                 #   6:     goto   4
l_foo_3:
    movl    $0, %eax                #   8:     assign t4 <- 0
    movb    %al, -25(%ebp)         
l_foo_4:
    movzbl  -25(%ebp), %eax         #  10:     assign bb <- t4
    movb    %al, -17(%ebp)         
    movl    -16(%ebp), %eax         #  11:     return aa
    jmp     l_foo_exit             

l_foo_exit:
    # epilogue
    addl    $16, %esp               # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # scope mytest
main:
    # stack offsets:
    #    -13(%ebp)   1  [ $t0       <bool> %ebp-13 ]
    #    -14(%ebp)   1  [ $t1       <bool> %ebp-14 ]
    #    -20(%ebp)   4  [ $t2       <int> %ebp-20 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $8, %esp                # make room for locals

    xorl    %eax, %eax              # memset local stack area to 0
    movl    %eax, 4(%esp)          
    movl    %eax, 0(%esp)          

    # function body
    movzbl  B, %eax                 #   0:     if     B = 1 goto 1
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_mytest_1             
    movzbl  B, %eax                 #   1:     if     B = 1 goto 1
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_mytest_1             
    jmp     l_mytest_2              #   2:     goto   2
l_mytest_1:
    movl    $1, %eax                #   4:     assign t0 <- 1
    movb    %al, -13(%ebp)         
    jmp     l_mytest_3              #   5:     goto   3
l_mytest_2:
    movl    $0, %eax                #   7:     assign t0 <- 0
    movb    %al, -13(%ebp)         
l_mytest_3:
    movzbl  -13(%ebp), %eax         #   9:     assign B <- t0
    movb    %al, B                 
    movzbl  B, %eax                 #  10:     if     B = 1 goto 9
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_mytest_9             
    jmp     l_mytest_7              #  11:     goto   7
l_mytest_9:
    movzbl  B, %eax                 #  13:     if     B = 1 goto 6
    movl    $1, %ebx               
    cmpl    %ebx, %eax             
    je      l_mytest_6             
    jmp     l_mytest_7              #  14:     goto   7
l_mytest_6:
    movl    $1, %eax                #  16:     assign t1 <- 1
    movb    %al, -14(%ebp)         
    jmp     l_mytest_8              #  17:     goto   8
l_mytest_7:
    movl    $0, %eax                #  19:     assign t1 <- 0
    movb    %al, -14(%ebp)         
l_mytest_8:
    movzbl  -14(%ebp), %eax         #  21:     assign B <- t1
    movb    %al, B                 
    movl    A, %eax                 #  22:     param  0 <- A
    pushl   %eax                   
    call    foo                     #  23:     call   t2 <- foo
    addl    $4, %esp               
    movl    %eax, -20(%ebp)        

l_mytest_exit:
    # epilogue
    addl    $8, %esp                # remove locals
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
A:                                  # <int>
    .skip    4
B:                                  # <bool>
    .skip    1


    # end of global data section
    #-----------------------------------------

    .end
##################################################
