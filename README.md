# DSD_VectorProcessor
In this project we design to build a simple vector processor in Verilog.
## SubModules
- CPU     
- ArithmeticUnit [capable of addition and multiplication]
- Memory [512Words]
- RegisterFile [Containing 4 512bit_registers]

## Implementation
## IMPORTANT NOTE
It is our goal to design a vector processor whih is a tipe of SIMD processors, which means for every additions it adds two vetors and not two numbers.

### AU

firstly we design the arithmeticUnit (if opcode=00 add elseif opcode=01 mult). we get 2 512bit inputs A and B; we break these two to 16 32bit numbers and then using generation and looping perform the operation
on all the 16 pairs of numbers and store the result in a 16*64bit array.now we put the first 32 bits of this array next to each other as low_result and the other 32bits as high_result.


![The implementation of AU.](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20185618.png)

### RegisterFile
our registerfile has 4 registers (A1,A2,A3,A4),two data outptut and their respective register address,one data input and two write flags(one for writing in any register and the other for output of arithmetic operation [A3,A4] also two arithmetic 512bit inputs ).  


![RegisterFile](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20185711.png)

### Memory
we have a memory with depth 512 and width of 16 and since our processsor is a vector processor we intend to read to/write from 16 consecutive memory cells.we have a write flag a 513bit input and a 512 output also a 9 bit memory address.

![Memory](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20185631.png)
