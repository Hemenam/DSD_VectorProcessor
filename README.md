# DSD_VectorProcessor
In this project we design to build a simple vector processor in Verilog.
## SubModules
- CPU     
- ArithmeticUnit [capable of addition and multiplication]
- Memory [512Words]
- RegisterFile [Containing 4 512bit_registers]

## Implementation
## IMPORTANT Note
It is our goal to design a vector processor whih is a tipe of SIMD processors, which means for every additions it adds two vetors and not two numbers.

### AU

firstly we design the arithmeticUnit (if opcode=00 add elseif opcode=01 mult). we get 2 512bit inputs A and B; we break these two to 16 32bit numbers and then using generation and looping perform the operation
on all the 16 pairs of numbers and store the result in a 16*64bit array.now we put the first 32 bits of this array next to each other as low_result and the other 32bits as high_result.

