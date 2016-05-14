##################################################
# test05
#

    #-----------------------------------------
    # text section
    #
    .text
    .align 4

    # entry point and pre-defined functions
    .global main
    .extern Input
    .extern Output

    # scope test05
main:
    pushl   %ebp                   
    movl    %esp, %ebp             
    pushl   %ebx                   
    pushl   %esi                   
    pushl   %edi                   
    subl    $4, %esp                # make room for locals

    movl    $-2147483648, %eax      #   0:     neg    t0 <- -2147483648
    negl    %eax                   
    movl    %eax, -16(%ebp)        
    movl    -16(%ebp), %eax         #   1:     assign min <- t0
    movl    %eax, min              
    movl    $2147483647, %eax       #   2:     assign max <- 2147483647
    movl    %eax, max              

l_test05_exit:
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

    # scope: test05
max:    .skip    4                  # <int>
min:    .skip    4                  # <int>

    # end of global data section
    #-----------------------------------------

    .end
##################################################
