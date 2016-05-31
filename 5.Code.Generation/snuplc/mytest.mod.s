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
    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $0, %esp                # make room for locals

    # function body
    movl    , %eax                  #   0:     add    t0 <- A, 1
    movl    , %ebx                 
    addl    %ebx, %eax             
    movl    %eax,                  
    # ???   not implemented         #   1:     assign aa <- t0
    # ???   not implemented         #   2:     if     a > aa goto 3
    # ???   not implemented         #   3:     goto   4
    # ???   not implemented         #   5:     assign t1 <- 1
    # ???   not implemented         #   6:     goto   5
    # ???   not implemented         #   8:     assign t1 <- 0
    # ???   not implemented         #  10:     assign bb <- t1
    # ???   not implemented         #  11:     return aa
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
    # ???   not implemented         #   0:     if     B = 1 goto 1
    # ???   not implemented         #   1:     if     B = 1 goto 1
    # ???   not implemented         #   2:     goto   2
    # ???   not implemented         #   4:     assign t0 <- 1
    # ???   not implemented         #   5:     goto   3
    # ???   not implemented         #   7:     assign t0 <- 0
    # ???   not implemented         #   9:     assign B <- t0
    # ???   not implemented         #  10:     if     B = 1 goto 9
    # ???   not implemented         #  11:     goto   7
    # ???   not implemented         #  13:     if     B = 1 goto 6
    # ???   not implemented         #  14:     goto   7
    # ???   not implemented         #  16:     assign t1 <- 1
    # ???   not implemented         #  17:     goto   8
    # ???   not implemented         #  19:     assign t1 <- 0
    # ???   not implemented         #  21:     assign B <- t1
    # ???   not implemented         #  22:     param  0 <- A
    # ???   not implemented         #  23:     call   t2 <- foo
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
A:                                  # <int>
    .skip    4
B:                                  # <bool>
    .skip    1


    # end of global data section
    #-----------------------------------------

    .end
##################################################
