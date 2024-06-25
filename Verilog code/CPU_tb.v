module CPU_tb;

    reg clk;
    reg [1:0] reg_wr_addr;
    reg [511:0] reg_wr_data;
   
    reg [1:0] reg_rd_addr1;
    reg [1:0] reg_rd_addr2;
    reg [8:0] mem_addr;
    reg [511:0] mem_wr_data;
   
    reg [2:0] op;
    wire [511:0] reg_rd_data1;
    wire [511:0] reg_rd_data2;
    wire [511:0] mem_rd_data;
    wire [511:0] low_result;
    wire [511:0] high_result;

    CPU cpu (
        .clk(clk),
        .reg_wr_addr(reg_wr_addr),
        .reg_wr_data(reg_wr_data),
        
        .reg_rd_addr1(reg_rd_addr1),
        .reg_rd_addr2(reg_rd_addr2),
        .mem_addr(mem_addr),
        .mem_wr_data(mem_wr_data),
      
        .op(op),
        .reg_rd_data1(reg_rd_data1),
        .reg_rd_data2(reg_rd_data2),
        .mem_rd_data(mem_rd_data),
        .low_result(low_result),
        .high_result(high_result)
    );

    initial begin
        clk = 0;
        reg_wr_addr = 0;
        reg_wr_data = 0;
        
        reg_rd_addr1 = 0;
        reg_rd_addr2 = 1;
        mem_addr = 0;
        mem_wr_data = 0;
        
        op = 3'b000;

     
        #10;
        reg_wr_addr = 3'b000;
        reg_wr_data = {16{32'hAAAAAAAA}};
        
	cpu.rf.registers[00]={16{32'hAAAAAAAA}};
        #10;
        
 
    
        #10;
        reg_wr_addr = 3'b001;
        reg_wr_data = {32'h11111111, 32'h22222222, 32'h33333333, 32'h44444444,
                       32'h55555555, 32'h66666666, 32'h77777777, 32'h88888888,
                       32'h99999999, 32'hAAAAAAAA, 32'hBBBBBBBB, 32'hCCCCCCCC,
                       32'hDDDDDDDD, 32'hEEEEEEEE, 32'hFFFFFFFF, 32'h00000000}; 
        
	cpu.rf.registers[01]=reg_wr_data;
        #10;
        
 $display("a1 %h", cpu.rf.registers[00]);
 $display("a2 %h", cpu.rf.registers[01]);
        
        #10;
        reg_rd_addr1 = 2'b00;
        reg_rd_addr2 = 2'b01;
        op = 3'b000; // Addition 
        #10;

        $display("Addition Result (Low): %h", cpu.rf.registers[10]);
        $display("Addition Result (High): %h", cpu.rf.registers[11]);
#10

        // multiplication
        #10;
        op = 3'b001; // Mult
        #10;


        $display("Multiplication Low Result: %h", cpu.rf.registers[10]);
        $display("Multiplication High Result: %h", cpu.rf.registers[11]);

        // Write  to memory
        #10;
        mem_addr = 9'd0;

        mem_wr_data = cpu.rf.registers[10];
        op=3'b010;
        #1000;
$display("\n\n\n\n we have given A3 to be written at address 0 of the memory:"  );      
 $display("Memory [15:0]: %h", {cpu.mem.mem[0], cpu.mem.mem[1], cpu.mem.mem[2], cpu.mem.mem[3], cpu.mem.mem[4], cpu.mem.mem[5], cpu.mem.mem[6], cpu.mem.mem[7], 
                                       cpu.mem.mem[8], cpu.mem.mem[9], cpu.mem.mem[10], cpu.mem.mem[11], cpu.mem.mem[12], cpu.mem.mem[13], cpu.mem.mem[14], cpu.mem.mem[15]});
	#100;
	op=3'b111;
	#100
        // Write  to register file
	reg_wr_addr = 0 ;
	reg_wr_data <= mem_rd_data;
	op=3'b011;
         #100;
      
$display("\n\n\n\n we have given the first 16 cells of memory to be written at  A1 of the registerfile:"  );      
 $display("A1: %h", cpu.rf.registers[00]);

        #10;
        $finish;
    end

    always #5 clk = ~clk;

endmodule

