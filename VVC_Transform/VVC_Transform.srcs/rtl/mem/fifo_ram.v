module fifo_ram#(
    parameter DATA_WIDTH = 10,
    parameter DATA_DEPTH = 128
)
(
    input                       clk,
    //write port
    input                       wr_en,
    input [DATA_WIDTH - 1 : 0]  wr_data,
    output                      wr_full,
    //read port
    input                       rd_en,
    output [DATA_WIDTH - 1 : 0] rd_data,
    output                      rd_empty
);

    reg [$clog2(DATA_DEPTH) : 0] fifo_cnt = 0;

    reg [$clog2(DATA_DEPTH) - 1 : 0] wr_pointer = 0;
    reg [$clog2(DATA_DEPTH) - 1 : 0] rd_pointer = 0;

    assign wr_full = (fifo_cnt == DATA_DEPTH)? 1 : 0;
    assign rd_empty = (fifo_cnt == 0) ? 1 : 0;    
    
// keep track of the  fifo counter
always @(posedge clk) begin
    if (wr_en && !rd_en) begin //wr_en is asserted and fifo is not full
        fifo_cnt <= fifo_cnt + 1;
    end
    else if (rd_en && !wr_en) begin // rd_en is asserted and fifo is not empty
        fifo_cnt <= fifo_cnt - 1;
    end
end
    
//keep track of the write  pointer
always @(posedge clk) begin
    if (wr_en && !wr_full) begin
        if (wr_pointer == DATA_DEPTH - 1) begin
            wr_pointer <= 0; 
        end
        else begin
            wr_pointer <= wr_pointer + 1;
        end
    end
end

//keep track of the read pointer 
always @(posedge clk) begin
    if (rd_en && !rd_empty) begin
        if (rd_pointer == DATA_DEPTH - 1) begin
            rd_pointer <= 0;
        end
        else begin
            rd_pointer <= rd_pointer + 1;
        end
    end
end
    
sram_2p_128x10 u_mem 
(
    // Outputs
    .QA                                (rd_data),       //read data           
    // Inputs
    .CLK                               (clk),           //read clock          
    .CENA                              (~rd_en),        //read select.low active         
    .AA                                (rd_pointer),    //read address           
    .CENB                              (~wr_en),        //write select.low active          
    .AB                                (wr_pointer),    //write address           
    .DB                                (wr_data),       //write data              
    .STOV                              (1'b0),            
    .STOVAB                            (1'b0),            

    .EMA                               (3'b011),          
    .EMAW                              (2'b01),           
    .EMAS                              (1'b0),            
    .EMAP                              (1'b0),            
    .RET1N                             (1'b1)
);           
      
endmodule                                
//cut_begin
//Local Variables:
//verilog-library-flags:("-y .")
//verilog-library-files:("./verilog/rf_2p_hce.v")
//verilog-library-extensions:(".v" ".h")
//verilog-auto-inst-param-value:t
//End: 
//cut_end
