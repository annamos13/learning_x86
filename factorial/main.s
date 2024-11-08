# PURPOSE: - Given a number, this program computes the factorial.
#            For example, the factorial of 3 is 3*2*1.

# This program shows how to call a function recursively.

.section .data
format_string:
  .ascii "Result is: %d\n"

# This program has no global data
.section .text 

.globl _start
_start:
  push $5         # the factorial takes one argument - so it gets pushed on the top of the stack 
  call factorial  # run the factorial function 
  addl $4, %esp   # scrubs the parameter that was pushed on the stack. Move the stack pointer back to where it was, 
                  # before we pushed $5 on it.

  pushl %eax 
  pushl $format_string
  call printf 

  call exit