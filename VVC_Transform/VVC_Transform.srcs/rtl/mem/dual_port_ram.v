module dual_port_ram#(
    parameter RAM_WIDTH = 16,
    parameter ADDR_LINE = 8
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
    input   		            rd_en;        // data output enable, high active
    input   		            wr_en;        // write enable, high active
    input   [ADDR_LINE-1:0]     wr_addr;      // wr address input
    input   [ADDR_LINE-1:0]     rd_addr;      // rd address input
    input   [RAM_WIDTH-1:0]     wr_data;      // data input
    output  [RAM_WIDTH-1:0]     rd_data;      // data output
// ********************************************
    wire     [RAM_WIDTH-1:0]    data_r;	
    reg                         rd_en_d1;

always @(posedge clk) begin
    rd_en_d1 <= rd_en;
end
	
assign rd_data = rd_en_d1 ? data_r : 1'b0;
                    
sram_2p_256x16 u_mem 
(/*AUTOINST*/
    // Outputs
    .QA                                (data_r),           	//read data

    .CLK                               (clk),             	//read clock
    .CENA                              (~rd_en),          	//read select.low active
    .AA                                (rd_addr),           //read address
    .CENB                              (~wr_en),           	//write select.low active
    .AB                                (wr_addr),           //write address
    .DB                                (wr_data),           //write data 
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
