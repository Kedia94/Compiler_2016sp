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

    # function body
    # ???   not implemented         #   0:     goto   2
    # ???   not implemented         #   1:     assign t0 <- 1
    # ???   not implemented         #   2:     goto   3
    # ???   not implemented         #   4:     assign t0 <- 0
    # ???   not implemented         #   6:     assign param_bool_a <- t0
    # ???   not implemented         #   7:     goto   6
    # ???   not implemented         #   8:     assign t1 <- 1
    # ???   not implemented         #   9:     goto   7
    # ???   not implemented         #  11:     assign t1 <- 0
    # ???   not implemented         #  13:     assign param_bool_a <- t1
    # ???   not implemented         #  14:     goto   10
    # ???   not implemented         #  15:     assign t2 <- 1
    # ???   not implemented         #  16:     goto   11
    # ???   not implemented         #  18:     assign t2 <- 0
    # ???   not implemented         #  20:     assign param_bool_a <- t2
    # ???   not implemented         #  21:     goto   14
    # ???   not implemented         #  22:     assign t3 <- 1
    # ???   not implemented         #  23:     goto   15
    # ???   not implemented         #  25:     assign t3 <- 0
    # ???   not implemented         #  27:     assign param_bool_a <- t3
    movl    , %eax                  #  28:     add    t4 <- 1, param_integer
    movl    , %ebx                 
    addl    %ebx, %eax             
    movl    %eax,                  
    # ???   not implemented         #  29:     assign param_integer <- t4
    # ???   not implemented         #  30:     goto   19
    # ???   not implemented         #  31:     assign t5 <- 1
    # ???   not implemented         #  32:     goto   20
    # ???   not implemented         #  34:     assign t5 <- 0
    # ???   not implemented         #  36:     assign param_bool_a <- t5
    # ???   not implemented         #  37:     return param_bool_a
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
    # ???   not implemented         #   0:     return 3
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
