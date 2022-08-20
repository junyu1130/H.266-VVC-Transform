module regular_multiplication#(   
    parameter   IN_WIDTH = 9,
    parameter   COEF_WIDTH = 8,
    parameter   OUT_WIDTH = 28 
    )(
    input                                       clk,
    input                                       rst_n,
    input   signed      [IN_WIDTH - 1 : 0]      i_0,
    input   signed      [IN_WIDTH - 1 : 0]      i_1,
    input   signed      [IN_WIDTH - 1 : 0]      i_2,
    input   signed      [IN_WIDTH - 1 : 0]      i_3,
    input   signed      [IN_WIDTH - 1 : 0]      i_4,
    input   signed      [IN_WIDTH - 1 : 0]      i_5,
    input   signed      [IN_WIDTH - 1 : 0]      i_6,
    input   signed      [IN_WIDTH - 1 : 0]      i_7,
    input   signed      [IN_WIDTH - 1 : 0]      i_8,
    input   signed      [IN_WIDTH - 1 : 0]      i_9,
    input   signed      [IN_WIDTH - 1 : 0]      i_10,
    input   signed      [IN_WIDTH - 1 : 0]      i_11,
    input   signed      [IN_WIDTH - 1 : 0]      i_12,
    input   signed      [IN_WIDTH - 1 : 0]      i_13,
    input   signed      [IN_WIDTH - 1 : 0]      i_14,
    input   signed      [IN_WIDTH - 1 : 0]      i_15,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_0,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_1,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_2,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_3,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_4,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_5,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_6,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_7,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_8,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_9,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_10,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_11,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_12,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_13,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_14,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_15,

    output  signed      [OUT_WIDTH - 1 : 0]     data_sum_quarter_0,
    output  signed      [OUT_WIDTH - 1 : 0]     data_sum_quarter_1,
    output  signed      [OUT_WIDTH - 1 : 0]     data_sum_quarter_2,
    output  signed      [OUT_WIDTH - 1 : 0]     data_sum_quarter_3

);
    
    integer i;
    wire     signed     [IN_WIDTH - 1    : 0]    i_data[15 : 0];
    wire     signed     [COEF_WIDTH - 1  : 0]    coef_data[15 : 0];
    reg      signed     [OUT_WIDTH - 1   : 0]    sum_quarter_0;
    reg      signed     [OUT_WIDTH - 1   : 0]    sum_quarter_1;
    reg      signed     [OUT_WIDTH - 1   : 0]    sum_quarter_2;
    reg      signed     [OUT_WIDTH - 1   : 0]    sum_quarter_3;
    //input
    assign i_data[0]  = i_0 ;
    assign i_data[1]  = i_1 ;
    assign i_data[2]  = i_2 ;
    assign i_data[3]  = i_3 ;
    assign i_data[4]  = i_4 ;
    assign i_data[5]  = i_5 ;
    assign i_data[6]  = i_6 ;
    assign i_data[7]  = i_7 ;
    assign i_data[8]  = i_8 ;
    assign i_data[9]  = i_9 ;
    assign i_data[10] = i_10;
    assign i_data[11] = i_11;
    assign i_data[12] = i_12;
    assign i_data[13] = i_13;
    assign i_data[14] = i_14;
    assign i_data[15] = i_15;
    
    
    assign coef_data[0]  = coef_0 ;
    assign coef_data[1]  = coef_1 ;
    assign coef_data[2]  = coef_2 ;
    assign coef_data[3]  = coef_3 ;
    assign coef_data[4]  = coef_4 ;
    assign coef_data[5]  = coef_5 ;
    assign coef_data[6]  = coef_6 ;
    assign coef_data[7]  = coef_7 ;
    assign coef_data[8]  = coef_8 ;
    assign coef_data[9]  = coef_9 ;
    assign coef_data[10] = coef_10;
    assign coef_data[11] = coef_11;
    assign coef_data[12] = coef_12;
    assign coef_data[13] = coef_13;
    assign coef_data[14] = coef_14;
    assign coef_data[15] = coef_15;
    
    always@(posedge clk or negedge rst_n)
        if (!rst_n) begin
            sum_quarter_0 <= 0;
            sum_quarter_1 <= 0;
            sum_quarter_2 <= 0;
            sum_quarter_3 <= 0;
        end 
        else begin
            sum_quarter_0 <= i_data[0] * coef_data[0]   + i_data[1] * coef_data[1]   + i_data[2] * coef_data[2]   + i_data[3] * coef_data[3];
            sum_quarter_1 <= i_data[4] * coef_data[4]   + i_data[5] * coef_data[5]   + i_data[6] * coef_data[6]   + i_data[7] * coef_data[7];
            sum_quarter_2 <= i_data[8] * coef_data[8]   + i_data[9] * coef_data[9]   + i_data[10] * coef_data[10] + i_data[11] * coef_data[11];
            sum_quarter_3 <= i_data[12] * coef_data[12] + i_data[13] * coef_data[13] + i_data[14] * coef_data[14] + i_data[15] * coef_data[15];
        end

assign      data_sum_quarter_0      =   sum_quarter_0;  
assign      data_sum_quarter_1      =   sum_quarter_1;  
assign      data_sum_quarter_2      =   sum_quarter_2;  
assign      data_sum_quarter_3      =   sum_quarter_3;
endmodule
