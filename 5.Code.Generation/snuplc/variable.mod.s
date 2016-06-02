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
    # ???   not implemented         #   0:     goto   2
    movl    $1, %eax                #   1:     assign t0 <- 1
    movl    %eax, -13(%ebp)        
    # ???   not implemented         #   2:     goto   3
