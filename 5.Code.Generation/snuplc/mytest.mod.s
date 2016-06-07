##################################################
# test12
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

    # scope test12
main:
    # stack offsets:
    #    -16(%ebp)   4  [ $t0       <int> %ebp-16 ]

    # prologue
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                    # save callee saved registers
    pushl   %esi                   
    pushl   %edi                   
    subl    $4, %esp                # make room for locals

    xorl    %eax, %eax              # memset local stack area to 0
    movl    %eax, 0(%esp)          

    # function body
    movl    $4, %eax                #   0:     assign i <- 4
    movl    %eax, i                
    movl    i, %eax                 #   1:     param  0 <- i
    pushl   %eax                   
    call    WriteInt                #   2:     call   WriteInt
    addl    $4, %esp               
    movl    i, %eax                 #   3:     pos    t0 <- i
    movl    %eax, -16(%ebp)        
    movl    -16(%ebp), %eax         #   4:     assign i <- t0
    movl    %eax, i                
    movl    i, %eax                 #   5:     param  0 <- i
    pushl   %eax                   
    call    WriteInt                #   6:     call   WriteInt
    addl    $4, %esp               

l_test12_exit:
    # epilogue
    addl    $4, %esp                # remove locals
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

    # scope: test12
i:                                  # <int>
    .skip    4

    # end of global data section
    #-----------------------------------------

    .end
##################################################
