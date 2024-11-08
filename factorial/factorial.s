.section .text 
.globl factorial
.type factorial, @function 
factorial:
  pushl %ebp            # standard function stuff - we have to restore %ebp to its prior state before returning, so we have to push it 
  movl %esp, %ebp       # This is because we don't want to modify the stack pointer so we use %ebp. This creates the stack frame for this function.
                        # The two lines above will be the way you always create a function.
  movl 8(%ebp), %eax    # This moves the first argument to %eax.
                        # %ebp holds old %ebp, 4(%ebp) holds the return address, 8(%ebp) holds the first param.
  cmpl $1, %eax         # If the number is 1, this is our base case, we simply return (1 is already in %eax as the return value)
  je end_factorial 

  decl %eax             # otherwise, decrease the value 
  pushl %eax            # push it to our call to factorial 
  call factorial 

  movl 8(%ebp), %ebx    # %eax has the return value, so we reload our param to %ebx 
                        # After a function call, we can never know what the registers are (except %ebp, %esp).
                        # So even though we had the value we were called with (%eax), it is not there anymore.
                        # Therefore, we need to pull it off the stack from the same place we got it the first time 8(%ebp).
  imull %ebx, %eax      # multiply that by the result of the last call to factorial (in %eax)
                        # The answer is stored in %eax, which is good since that's where the return value goes.

end_factorial:
  movl %ebp, %esp 
  popl %ebp 
  ret                   # return to the function (this pops the return value too)