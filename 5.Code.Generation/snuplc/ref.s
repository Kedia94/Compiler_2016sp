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
    #      8(%ebp)   1  [ %param_bool_a <bool> %ebp+8 ]
    #     12(%ebp)   1  [ %param_char <char> %ebp+12 ]
    #     20(%ebp)   4  [ %param_intarray_a <ptr(4) to <array 10 of <int>>> %ebp+20 ]
    #     24(%ebp)   4  [ %param_intarray_b <ptr(4) to <array 10 of <int>>> %ebp+24 ]
    #     16(%ebp)   4  [ %param_integer <int> %ebp+16 ]
    #    -13(%ebp)   1  [ $t0       <bool> %ebp-13 ]
    #    -14(%ebp)   1  [ $t1       <bool> %ebp-14 ]
    #    -15(%ebp)   1  [ $t2       <bool> %ebp-15 ]
    #    -16(%ebp)   1  [ $t3       <bool> %ebp-16 ]
    #    -20(%ebp)   4  [ $t4       <int> %ebp-20 ]
    #    -21(%ebp)   1  [ $t5       <bool> %ebp-21 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $12, %esp               # make room for locals

    xorl    %eax, %eax              # memset local stack area to 0
    movl    %eax, 8(%esp)          
    movl    %eax, 4(%esp)          
    movl    %eax, 0(%esp)          

    # function body
    jmp     l_foo_2                 #   0:     goto   2
    movl    $1, %eax                #   1:     assign t0 <- 1
    movb    %al, -13(%ebp)         
    jmp     l_foo_3                 #   2:     goto   3
l_foo_2:
    movl    $0, %eax                #   4:     assign t0 <- 0
    movb    %al, -13(%ebp)         
l_foo_3:
    movzbl  -13(%ebp), %eax         #   6:     assign param_bool_a <- t0
    movb    %al, 8(%ebp)           
    jmp     l_foo_6                 #   7:     goto   6
    movl    $1, %eax                #   8:     assign t1 <- 1
    movb    %al, -14(%ebp)         
    jmp     l_foo_7                 #   9:     goto   7
l_foo_6:
    movl    $0, %eax                #  11:     assign t1 <- 0
    movb    %al, -14(%ebp)         
l_foo_7:
    movzbl  -14(%ebp), %eax         #  13:     assign param_bool_a <- t1
    movb    %al, 8(%ebp)           
    jmp     l_foo_10                #  14:     goto   10
    movl    $1, %eax                #  15:     assign t2 <- 1
    movb    %al, -15(%ebp)         
    jmp     l_foo_11                #  16:     goto   11
l_foo_10:
    movl    $0, %eax                #  18:     assign t2 <- 0
    movb    %al, -15(%ebp)         
l_foo_11:
    movzbl  -15(%ebp), %eax         #  20:     assign param_bool_a <- t2
    movb    %al, 8(%ebp)           
    jmp     l_foo_14                #  21:     goto   14
    movl    $1, %eax                #  22:     assign t3 <- 1
    movb    %al, -16(%ebp)         
    jmp     l_foo_15                #  23:     goto   15
l_foo_14:
    movl    $0, %eax                #  25:     assign t3 <- 0
    movb    %al, -16(%ebp)         
l_foo_15:
    movzbl  -16(%ebp), %eax         #  27:     assign param_bool_a <- t3
    movb    %al, 8(%ebp)           
    movl    $1, %eax                #  28:     add    t4 <- 1, param_integer
    movl    16(%ebp), %ebx         
    addl    %ebx, %eax             
    movl    %eax, -20(%ebp)        
    movl    -20(%ebp), %eax         #  29:     assign param_integer <- t4
    movl    %eax, 16(%ebp)         
    jmp     l_foo_19                #  30:     goto   19
    movl    $1, %eax                #  31:     assign t5 <- 1
    movb    %al, -21(%ebp)         
    jmp     l_foo_20                #  32:     goto   20
l_foo_19:
    movl    $0, %eax                #  34:     assign t5 <- 0
    movb    %al, -21(%ebp)         
l_foo_20:
    movzbl  -21(%ebp), %eax         #  36:     assign param_bool_a <- t5
    movb    %al, 8(%ebp)           
    movzbl  8(%ebp), %eax           #  37:     return param_bool_a
    jmp     l_foo_exit             

l_foo_exit:
    # epilogue
    addl    $12, %esp               # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # scope bar
bar:
    # stack offsets:
    #     20(%ebp)   4  [ %aab      <int> %ebp+20 ]
    #     24(%ebp)   4  [ %aba      <int> %ebp+24 ]
    #     16(%ebp)   4  [ %abb      <int> %ebp+16 ]
    #     12(%ebp)   4  [ %baa      <int> %ebp+12 ]
    #      8(%ebp)   4  [ %bbb      <int> %ebp+8 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $0, %esp                # make room for locals

    # function body
    movl    $3, %eax                #   0:     return 3
    jmp     l_bar_exit             

l_bar_exit:
    # epilogue
    addl    $0, %esp                # remove locals
    popl    %edi                   
    popl    %esi                   
    popl    %ebx                   
    popl    %ebp                   
    ret                            

    # scope mytest
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

l_mytest_exit:
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

    # scope: mytest
global_bool_a:                      # <bool>
    .skip    1
global_bool_b:                      # <bool>
    .skip    1
global_bool_c:                      # <bool>
    .skip    1
global_bool_d:                      # <bool>
    .skip    1
global_boolarray_a:                 # <array 10 of <bool>>
    .long    1
    .long   10
    .skip   10
global_char_a:                      # <char>
    .skip    1
    .align   4
global_chararray_a:                 # <array 10 of <char>>
    .long    1
    .long   10
    .skip   10
    .align   4
global_intarray_a:                  # <array 10 of <int>>
    .long    1
    .long   10
    .skip   40
global_integer_a:                   # <int>
    .skip    4
global_integer_b:                   # <int>
    .skip    4



    # end of global data section
    #-----------------------------------------

    .end
##################################################
