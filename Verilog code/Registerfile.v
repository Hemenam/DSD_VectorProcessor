module RegisterFile (
    input clk,
    input [1:0] wr_addr,
    input [511:0] wr_data, 
    input wr_en,
    input [1:0] rd_addr1, 
    input [1:0] rd_addr2, 
    output [511:0] rd_data1,
    output [511:0] rd_data2,
    input [511:0] arith_low_result,
    input [511:0] arith_high_result,
    input arith_wr_en 
);

    reg [511:0] registers [0:15]; 

    always @(posedge clk) begin
        if (wr_en) begin
            registers[wr_addr] <= wr_data;
        end
        if (arith_wr_en) begin
            registers[10] <= arith_low_result;
            registers[11] <= arith_high_result;
        end
    end

    assign rd_data1 = registers[rd_addr1];
    assign rd_data2 = registers[rd_addr2];

endmodule

