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

firstly we design the arithmeticUnit (if opcode = 000 add elseif opcode = 001 mult). we get 2 512bit inputs A and B; we break these two to 16 32bit numbers and then using generation and looping perform the operation
on all the 16 pairs of numbers and store the result in a 16*64bit array.now we put the first 32 bits of this array next to each other as low_result and the other 32bits as high_result.


![The implementation of AU.](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20185618.png)

### RegisterFile
our registerfile has 4 registers (A1,A2,A3,A4),two data outptut and their respective register address,one data input and two write flags(one for writing in any register and the other for output of arithmetic operation [A3,A4] also two arithmetic 512bit inputs ).  


![RegisterFile](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20185711.png)

### Memory
we have a memory with depth 512 and width of 16 and since our processsor is a vector processor we intend to read to/write from 16 consecutive memory cells.we have a write flag a 513bit input and a 512 output also a 9 bit memory address.

![Memory](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20185631.png)

### CPU
Now its time to essemble what we have built.Centeral Processing Unit is where we create an instance of the module above and using a 3bit opcode we model the behavior of the cpu.(op = 000 addition, opcode = 001 multiplication, opcode = 010 writing from registerfile to memory ,and finally opcode = 011 writing from memory to registerfile, other opcodes are used as reset to reset write flags.)

![CPU instantiation](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20185836.png)

![CPU behavioral Modeling](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20185849.png)


## TESTBENCH
we need to test our CPU in four diffrent areas. opcode = 000,001,010,011
- first we instantiate cpu in cpu_tb module.
  ![CPU instansiation](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20205625.png)
   ![CPU instansiation](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20205650.png)
    
- we then proceed to give values to A1 and A2
  ![](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20205741.png)
   ![](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20210357.png)
-  now its time to test addition notice each 8 digit from A3 with their respective 8 digits from A4 are the result of addition of the respecctive 8 digits from A1 and A2
  ![](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20205911.png)
    ![](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20210405.png)
- multiplication is the same as addition
  ![](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20205923.png)
   ![](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20210417.png)
    - for example take the biggest 8digits of A1 = AAAAAAAA and A2 = 11111111 and the result given by the Au is low(A3) = 49f49f4a   high(A4) = 0b60b60
     now we check this with a calculator:
              ![](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20210405.png)

- we write the value of A3 in the first 16 cells of memory and then display the memory

  ![](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20210528.png)
   ![](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20210612.png)
- we write the first 16 cells  of memory  in A1 and then display the memory
  ![](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20221512.png)
   ![](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20220851.png)
  ![](https://github.com/Hemenam/DSD_VectorProcessor/blob/main/Pictures/Screenshot%202024-06-25%20220856.png)




