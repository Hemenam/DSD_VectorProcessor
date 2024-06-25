module Memory (
    input clk,
    input [8:0] addr, 
    input [511:0] wr_data,
    input wr_en,
    output reg [511:0] rd_data
);

    reg [31:0] mem [0:511]; 

    always @(posedge clk) begin
        if (wr_en) begin

            mem[addr]     <= wr_data[511:480];
            mem[addr+1]   <= wr_data[479:448];
            mem[addr+2]   <= wr_data[447:416];
            mem[addr+3]   <= wr_data[415:384];
            mem[addr+4]   <= wr_data[383:352];
            mem[addr+5]   <= wr_data[351:320];
            mem[addr+6]   <= wr_data[319:288];
            mem[addr+7]   <= wr_data[287:256];
            mem[addr+8]   <= wr_data[255:224];
            mem[addr+9]   <= wr_data[223:192];
            mem[addr+10]  <= wr_data[191:160];
            mem[addr+11]  <= wr_data[159:128];
            mem[addr+12]  <= wr_data[127:96];
            mem[addr+13]  <= wr_data[95:64];
            mem[addr+14]  <= wr_data[63:32];
            mem[addr+15]  <= wr_data[31:0];
        end else begin
            rd_data[511:480] <= mem[addr];
            rd_data[479:448] <= mem[addr+1];
            rd_data[447:416] <= mem[addr+2];
            rd_data[415:384] <= mem[addr+3];
            rd_data[383:352] <= mem[addr+4];
            rd_data[351:320] <= mem[addr+5];
            rd_data[319:288] <= mem[addr+6];
            rd_data[287:256] <= mem[addr+7];
            rd_data[255:224] <= mem[addr+8];
            rd_data[223:192] <= mem[addr+9];
            rd_data[191:160] <= mem[addr+10];
            rd_data[159:128] <= mem[addr+11];
            rd_data[127:96]  <= mem[addr+12];
            rd_data[95:64]   <= mem[addr+13];
            rd_data[63:32]   <= mem[addr+14];
            rd_data[31:0]    <= mem[addr+15];
        end
    end
endmodule

