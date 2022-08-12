module dual_port_ram#(
    parameter RAM_WIDTH = 16,
    parameter ADDR_LINE = 7
)
(
    clk,
    wr_en,
    rd_en,
    wr_data,
    rd_data,
    wr_addr,
    rd_addr
);
// ********************************************
//                                             
//    Input/Output DECLARATION                    
//                                             
// ********************************************
    input                       clk;          // clock in
    input                       rd_en;        // data output enable, high active
    input                       wr_en;        // write enable, high active
    input   [ADDR_LINE-1:0]     wr_addr;      // wr address input
    input   [ADDR_LINE-1:0]     rd_addr;      // rd address input
    input   [RAM_WIDTH-1:0]     wr_data;      // data input
    output  [RAM_WIDTH-1:0]     rd_data;      // data output
// ********************************************
    reg     [RAM_WIDTH-1:0]     memory[(1<<ADDR_LINE)-1:0];
    reg     [RAM_WIDTH-1:0]     data_r;	
    reg                         rd_en_d1;

//Ð´
always @(posedge clk)begin
    if (wr_en)
        memory[wr_addr] <= wr_data;
    else
        memory[wr_addr] <= memory[wr_addr];
end

always @(posedge clk) begin
    rd_en_d1 <= rd_en;
end

//¶Á
always @(posedge clk)begin
    if (rd_en)
        data_r <= memory[rd_addr];
    else
        data_r <= data_r;
end
    
assign rd_data = rd_en_d1 ? data_r : 1'b0;

endmodule
