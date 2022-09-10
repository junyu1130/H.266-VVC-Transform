module regular_multiplication#(   
    parameter   IN_WIDTH = 9,
    parameter   COEF_WIDTH = 8,
    parameter   OUT_WIDTH = 28 
    )(
    input                                       clk,
    input                                       rst_n,
    input   signed      [IN_WIDTH - 1 : 0]      i_0 ,
    input   signed      [IN_WIDTH - 1 : 0]      i_1 ,
    input   signed      [IN_WIDTH - 1 : 0]      i_2 ,
    input   signed      [IN_WIDTH - 1 : 0]      i_3 ,
    input   signed      [IN_WIDTH - 1 : 0]      i_4 ,
    input   signed      [IN_WIDTH - 1 : 0]      i_5 ,
    input   signed      [IN_WIDTH - 1 : 0]      i_6 ,
    input   signed      [IN_WIDTH - 1 : 0]      i_7 ,
    input   signed      [IN_WIDTH - 1 : 0]      i_8 ,
    input   signed      [IN_WIDTH - 1 : 0]      i_9 ,
    input   signed      [IN_WIDTH - 1 : 0]      i_10,
    input   signed      [IN_WIDTH - 1 : 0]      i_11,
    input   signed      [IN_WIDTH - 1 : 0]      i_12,
    input   signed      [IN_WIDTH - 1 : 0]      i_13,
    input   signed      [IN_WIDTH - 1 : 0]      i_14,
    input   signed      [IN_WIDTH - 1 : 0]      i_15,
    input   signed      [IN_WIDTH - 1 : 0]      i_16,
    input   signed      [IN_WIDTH - 1 : 0]      i_17,
    input   signed      [IN_WIDTH - 1 : 0]      i_18,
    input   signed      [IN_WIDTH - 1 : 0]      i_19,
    input   signed      [IN_WIDTH - 1 : 0]      i_20,
    input   signed      [IN_WIDTH - 1 : 0]      i_21,
    input   signed      [IN_WIDTH - 1 : 0]      i_22,
    input   signed      [IN_WIDTH - 1 : 0]      i_23,
    input   signed      [IN_WIDTH - 1 : 0]      i_24,
    input   signed      [IN_WIDTH - 1 : 0]      i_25,
    input   signed      [IN_WIDTH - 1 : 0]      i_26,
    input   signed      [IN_WIDTH - 1 : 0]      i_27,
    input   signed      [IN_WIDTH - 1 : 0]      i_28,
    input   signed      [IN_WIDTH - 1 : 0]      i_29,
    input   signed      [IN_WIDTH - 1 : 0]      i_30,
    input   signed      [IN_WIDTH - 1 : 0]      i_31,

    input   signed      [COEF_WIDTH - 1 : 0]    coef_0 ,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_1 ,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_2 ,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_3 ,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_4 ,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_5 ,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_6 ,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_7 ,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_8 ,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_9 ,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_10,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_11,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_12,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_13,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_14,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_15,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_16,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_17,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_18,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_19,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_20,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_21,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_22,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_23,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_24,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_25,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_26,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_27,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_28,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_29,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_30,
    input   signed      [COEF_WIDTH - 1 : 0]    coef_31,

    output  signed      [OUT_WIDTH - 1 : 0]     data_sum_eighth_0,
    output  signed      [OUT_WIDTH - 1 : 0]     data_sum_eighth_1,
    output  signed      [OUT_WIDTH - 1 : 0]     data_sum_eighth_2,
    output  signed      [OUT_WIDTH - 1 : 0]     data_sum_eighth_3,
    output  signed      [OUT_WIDTH - 1 : 0]     data_sum_eighth_4,
    output  signed      [OUT_WIDTH - 1 : 0]     data_sum_eighth_5,
    output  signed      [OUT_WIDTH - 1 : 0]     data_sum_eighth_6,
    output  signed      [OUT_WIDTH - 1 : 0]     data_sum_eighth_7

);
    
    integer i;
    wire     signed     [IN_WIDTH - 1    : 0]    i_data[31 : 0];
    wire     signed     [COEF_WIDTH - 1  : 0]    coef_data[31 : 0];
    reg      signed     [OUT_WIDTH - 1   : 0]    sum_eighth_0;
    reg      signed     [OUT_WIDTH - 1   : 0]    sum_eighth_1;
    reg      signed     [OUT_WIDTH - 1   : 0]    sum_eighth_2;
    reg      signed     [OUT_WIDTH - 1   : 0]    sum_eighth_3;
    reg      signed     [OUT_WIDTH - 1   : 0]    sum_eighth_4;
    reg      signed     [OUT_WIDTH - 1   : 0]    sum_eighth_5;
    reg      signed     [OUT_WIDTH - 1   : 0]    sum_eighth_6;
    reg      signed     [OUT_WIDTH - 1   : 0]    sum_eighth_7;
    //input
    assign i_data[0 ] = i_0 ;
    assign i_data[1 ] = i_1 ;
    assign i_data[2 ] = i_2 ;
    assign i_data[3 ] = i_3 ;
    assign i_data[4 ] = i_4 ;
    assign i_data[5 ] = i_5 ;
    assign i_data[6 ] = i_6 ;
    assign i_data[7 ] = i_7 ;
    assign i_data[8 ] = i_8 ;
    assign i_data[9 ] = i_9 ;
    assign i_data[10] = i_10;
    assign i_data[11] = i_11;
    assign i_data[12] = i_12;
    assign i_data[13] = i_13;
    assign i_data[14] = i_14;
    assign i_data[15] = i_15;
    assign i_data[16] = i_16;
    assign i_data[17] = i_17;
    assign i_data[18] = i_18;
    assign i_data[19] = i_19;
    assign i_data[20] = i_20;
    assign i_data[21] = i_21;
    assign i_data[22] = i_22;
    assign i_data[23] = i_23;
    assign i_data[24] = i_24;
    assign i_data[25] = i_25;
    assign i_data[26] = i_26;
    assign i_data[27] = i_27;
    assign i_data[28] = i_28;
    assign i_data[29] = i_29;
    assign i_data[30] = i_30;
    assign i_data[31] = i_31;
    
    assign coef_data[0 ] = coef_0 ;
    assign coef_data[1 ] = coef_1 ;
    assign coef_data[2 ] = coef_2 ;
    assign coef_data[3 ] = coef_3 ;
    assign coef_data[4 ] = coef_4 ;
    assign coef_data[5 ] = coef_5 ;
    assign coef_data[6 ] = coef_6 ;
    assign coef_data[7 ] = coef_7 ;
    assign coef_data[8 ] = coef_8 ;
    assign coef_data[9 ] = coef_9 ;
    assign coef_data[10] = coef_10;
    assign coef_data[11] = coef_11;
    assign coef_data[12] = coef_12;
    assign coef_data[13] = coef_13;
    assign coef_data[14] = coef_14;
    assign coef_data[15] = coef_15;
    assign coef_data[16] = coef_16;
    assign coef_data[17] = coef_17;
    assign coef_data[18] = coef_18;
    assign coef_data[19] = coef_19;
    assign coef_data[20] = coef_20;
    assign coef_data[21] = coef_21;
    assign coef_data[22] = coef_22;
    assign coef_data[23] = coef_23;
    assign coef_data[24] = coef_24;
    assign coef_data[25] = coef_25;
    assign coef_data[26] = coef_26;
    assign coef_data[27] = coef_27;
    assign coef_data[28] = coef_28;
    assign coef_data[29] = coef_29;
    assign coef_data[30] = coef_30;
    assign coef_data[31] = coef_31;
    
    always@(posedge clk or negedge rst_n)
        if (!rst_n) begin
            sum_eighth_0 <= 0;
            sum_eighth_1 <= 0;
            sum_eighth_2 <= 0;
            sum_eighth_3 <= 0;
            sum_eighth_4 <= 0;
            sum_eighth_5 <= 0;
            sum_eighth_6 <= 0;
            sum_eighth_7 <= 0;
        end 
        else begin
            sum_eighth_0 <= i_data[0] * coef_data[0]    + i_data[1] * coef_data[1]      + i_data[2] * coef_data[2]      + i_data[3] * coef_data[3];
            sum_eighth_1 <= i_data[4] * coef_data[4]    + i_data[5] * coef_data[5]      + i_data[6] * coef_data[6]      + i_data[7] * coef_data[7];
            sum_eighth_2 <= i_data[8] * coef_data[8]    + i_data[9] * coef_data[9]      + i_data[10] * coef_data[10]    + i_data[11] * coef_data[11];
            sum_eighth_3 <= i_data[12] * coef_data[12]  + i_data[13] * coef_data[13]    + i_data[14] * coef_data[14]    + i_data[15] * coef_data[15];
            sum_eighth_4 <= i_data[16] * coef_data[16]  + i_data[17] * coef_data[17]    + i_data[18] * coef_data[18]    + i_data[19] * coef_data[19];
            sum_eighth_5 <= i_data[20] * coef_data[20]  + i_data[21] * coef_data[21]    + i_data[22] * coef_data[22]    + i_data[23] * coef_data[23];
            sum_eighth_6 <= i_data[24] * coef_data[24]  + i_data[25] * coef_data[25]    + i_data[26] * coef_data[26]    + i_data[27] * coef_data[27];
            sum_eighth_7 <= i_data[28] * coef_data[28]  + i_data[29] * coef_data[29]    + i_data[30] * coef_data[30]    + i_data[31] * coef_data[31];
        end

assign      data_sum_eighth_0      =   sum_eighth_0;  
assign      data_sum_eighth_1      =   sum_eighth_1;  
assign      data_sum_eighth_2      =   sum_eighth_2;  
assign      data_sum_eighth_3      =   sum_eighth_3;
assign      data_sum_eighth_4      =   sum_eighth_4;  
assign      data_sum_eighth_5      =   sum_eighth_5;  
assign      data_sum_eighth_6      =   sum_eighth_6;  
assign      data_sum_eighth_7      =   sum_eighth_7;
endmodule
