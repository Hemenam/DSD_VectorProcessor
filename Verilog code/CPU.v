module CPU (
    input clk,
    input [1:0] reg_wr_addr,
    input [511:0] reg_wr_data,
    
    input [1:0] reg_rd_addr1,
    input [1:0] reg_rd_addr2,
    input [8:0] mem_addr,
    input [511:0] mem_wr_data,
    
    input [2:0] op,
    output [511:0] reg_rd_data1,
    output [511:0] reg_rd_data2,
    output [511:0] mem_rd_data,
    output [511:0] low_result,
    output [511:0] high_result
);

    wire [511:0] arith_low_result;
    wire [511:0] arith_high_result;
    reg arith_wr_en,reg_wr_en,mem_wr_en;


    // RegisterFile
    RegisterFile rf (
        .clk(clk),
        .wr_addr(reg_wr_addr),
        .wr_data(reg_wr_data),
        .wr_en(reg_wr_en),
        .rd_addr1(reg_rd_addr1),
        .rd_addr2(reg_rd_addr2),
        .rd_data1(reg_rd_data1),
        .rd_data2(reg_rd_data2),
        .arith_low_result(arith_low_result), 
        .arith_high_result(arith_high_result), 
        .arith_wr_en(arith_wr_en) 
    );

    // ArithmeticUnit
    ArithmeticUnit au (
        .A(reg_rd_data1),
        .B(reg_rd_data2),
        .op(op), 
        .low_result(arith_low_result),
        .high_result(arith_high_result)
    );

    // Memory
    Memory mem (
        .clk(clk),
        .addr(mem_addr),
        .wr_data(mem_wr_data),
        .wr_en(mem_wr_en),
        .rd_data(mem_rd_data)
    );

 
    assign low_result = arith_low_result;
    assign high_result = arith_high_result;

    always @(posedge clk) begin
        arith_wr_en <= 1'b0;
	mem_wr_en <=1'b0;
	reg_wr_en <=1'b0;
        if (op == 3'b000 || op == 3'b001) begin
            //  Write results to registers[10] and registers[11]
            arith_wr_en <= 1'b1;
        end else if (op == 3'b010) begin
            // Write data from register file to memory

 		mem_wr_en<=1'b1;

        end else if (op == 3'b011) begin
            // Write data from memory to register file
		
          reg_wr_en <=1'b1;
            
        end else begin
        arith_wr_en <= 1'b0;
	mem_wr_en <=1'b0;
	reg_wr_en <=1'b0;
end
    end

endmodule

