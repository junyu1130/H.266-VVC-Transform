//describe  : 32点DCT计算
//input     : 32个像素残差/一维变换系数
//output    : 16个预变换系数(后需右移)+16个32_E
//delay     : 32_E : 1 clk , 32_precoeff : 3 clk
module dct2_1d_32#(
    parameter  IN_WIDTH  = 17
)
(
//system input
    input                               clk     ,
    input                               rst_n   ,
//input parameter
    input           [2 : 0]             i_size  ,
//input data
    input                               i_valid ,
    input   signed  [IN_WIDTH - 1 : 0]  i_0     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_1     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_2     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_3     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_4     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_5     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_6     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_7     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_8     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_9     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_10    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_11    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_12    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_13    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_14    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_15    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_16    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_17    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_18    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_19    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_20    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_21    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_22    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_23    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_24    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_25    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_26    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_27    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_28    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_29    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_30    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_31    ,
//output pre_coeff
    output                              o_valid ,
    output  signed  [IN_WIDTH      : 0] o_0     ,
    output  signed  [IN_WIDTH      : 0] o_1     ,
    output  signed  [IN_WIDTH      : 0] o_2     ,
    output  signed  [IN_WIDTH      : 0] o_3     ,
    output  signed  [IN_WIDTH      : 0] o_4     ,
    output  signed  [IN_WIDTH      : 0] o_5     ,
    output  signed  [IN_WIDTH      : 0] o_6     ,
    output  signed  [IN_WIDTH      : 0] o_7     ,
    output  signed  [IN_WIDTH      : 0] o_8     ,
    output  signed  [IN_WIDTH      : 0] o_9     ,
    output  signed  [IN_WIDTH      : 0] o_10    ,
    output  signed  [IN_WIDTH      : 0] o_11    ,
    output  signed  [IN_WIDTH      : 0] o_12    ,
    output  signed  [IN_WIDTH      : 0] o_13    ,
    output  signed  [IN_WIDTH      : 0] o_14    ,
    output  signed  [IN_WIDTH      : 0] o_15    ,
    output  signed  [IN_WIDTH + 10 : 0] o_16    ,
    output  signed  [IN_WIDTH + 10 : 0] o_17    ,
    output  signed  [IN_WIDTH + 10 : 0] o_18    ,
    output  signed  [IN_WIDTH + 10 : 0] o_19    ,
    output  signed  [IN_WIDTH + 10 : 0] o_20    ,
    output  signed  [IN_WIDTH + 10 : 0] o_21    ,
    output  signed  [IN_WIDTH + 10 : 0] o_22    ,
    output  signed  [IN_WIDTH + 10 : 0] o_23    ,
    output  signed  [IN_WIDTH + 10 : 0] o_24    ,
    output  signed  [IN_WIDTH + 10 : 0] o_25    ,
    output  signed  [IN_WIDTH + 10 : 0] o_26    ,
    output  signed  [IN_WIDTH + 10 : 0] o_27    ,
    output  signed  [IN_WIDTH + 10 : 0] o_28    ,
    output  signed  [IN_WIDTH + 10 : 0] o_29    ,
    output  signed  [IN_WIDTH + 10 : 0] o_30    ,
    output  signed  [IN_WIDTH + 10 : 0] o_31    
);

//butterfly
    wire butterfly_32_valid;
    wire signed [IN_WIDTH : 0]  butterfly_32[0 : 31];
//calculate : mcm + sum
    wire pre_coeff_valid;
    wire signed [IN_WIDTH + 10 : 0] pre_coeff[0 : 15];

//sub module
dct2_butterfly_32#(
    .IN_WIDTH   (IN_WIDTH)
)
u_dct2_butterfly_32(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input data
    .i_valid(i_valid            ),
    .i_0    (i_0                ),
    .i_1    (i_1                ),
    .i_2    (i_2                ),
    .i_3    (i_3                ),
    .i_4    (i_4                ),
    .i_5    (i_5                ),
    .i_6    (i_6                ),
    .i_7    (i_7                ),
    .i_8    (i_8                ),
    .i_9    (i_9                ),
    .i_10   (i_10               ),
    .i_11   (i_11               ),
    .i_12   (i_12               ),
    .i_13   (i_13               ),
    .i_14   (i_14               ),
    .i_15   (i_15               ),
    .i_16   (i_16               ),
    .i_17   (i_17               ),
    .i_18   (i_18               ),
    .i_19   (i_19               ),
    .i_20   (i_20               ),
    .i_21   (i_21               ),
    .i_22   (i_22               ),
    .i_23   (i_23               ),
    .i_24   (i_24               ),
    .i_25   (i_25               ),
    .i_26   (i_26               ),
    .i_27   (i_27               ),
    .i_28   (i_28               ),
    .i_29   (i_29               ),
    .i_30   (i_30               ),
    .i_31   (i_31               ),
//output data
    .o_valid(butterfly_32_valid ),
    .o_0    (butterfly_32[0 ]   ),//E
    .o_1    (butterfly_32[1 ]   ),
    .o_2    (butterfly_32[2 ]   ),
    .o_3    (butterfly_32[3 ]   ),
    .o_4    (butterfly_32[4 ]   ),
    .o_5    (butterfly_32[5 ]   ),
    .o_6    (butterfly_32[6 ]   ),
    .o_7    (butterfly_32[7 ]   ),
    .o_8    (butterfly_32[8 ]   ),
    .o_9    (butterfly_32[9 ]   ),
    .o_10   (butterfly_32[10]   ),
    .o_11   (butterfly_32[11]   ),
    .o_12   (butterfly_32[12]   ),
    .o_13   (butterfly_32[13]   ),
    .o_14   (butterfly_32[14]   ),
    .o_15   (butterfly_32[15]   ),
    .o_16   (butterfly_32[16]   ),//O
    .o_17   (butterfly_32[17]   ),
    .o_18   (butterfly_32[18]   ),
    .o_19   (butterfly_32[19]   ),
    .o_20   (butterfly_32[20]   ),
    .o_21   (butterfly_32[21]   ),
    .o_22   (butterfly_32[22]   ),
    .o_23   (butterfly_32[23]   ),
    .o_24   (butterfly_32[24]   ),
    .o_25   (butterfly_32[25]   ),
    .o_26   (butterfly_32[26]   ),
    .o_27   (butterfly_32[27]   ),
    .o_28   (butterfly_32[28]   ),
    .o_29   (butterfly_32[29]   ),
    .o_30   (butterfly_32[30]   ),
    .o_31   (butterfly_32[31]   )
);

dct2_calculate_32#(
    .IN_WIDTH   (IN_WIDTH + 1)
) 
u_dct2_calculate_32(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_size             ),
//input data
    .i_valid(butterfly_32_valid ),
    .i_0    (butterfly_32[16]   ),
    .i_1    (butterfly_32[17]   ),
    .i_2    (butterfly_32[18]   ),
    .i_3    (butterfly_32[19]   ),
    .i_4    (butterfly_32[20]   ),
    .i_5    (butterfly_32[21]   ),
    .i_6    (butterfly_32[22]   ),
    .i_7    (butterfly_32[23]   ),
    .i_8    (butterfly_32[24]   ),
    .i_9    (butterfly_32[25]   ),
    .i_10   (butterfly_32[26]   ),
    .i_11   (butterfly_32[27]   ),
    .i_12   (butterfly_32[28]   ),
    .i_13   (butterfly_32[29]   ),
    .i_14   (butterfly_32[30]   ),
    .i_15   (butterfly_32[31]   ),
//output pre_coeff
    .o_valid(pre_coeff_valid    ),
    .o_0    (pre_coeff[0 ]      ),
    .o_1    (pre_coeff[1 ]      ),
    .o_2    (pre_coeff[2 ]      ),
    .o_3    (pre_coeff[3 ]      ),
    .o_4    (pre_coeff[4 ]      ),
    .o_5    (pre_coeff[5 ]      ),
    .o_6    (pre_coeff[6 ]      ),
    .o_7    (pre_coeff[7 ]      ),
    .o_8    (pre_coeff[8 ]      ),
    .o_9    (pre_coeff[9 ]      ),
    .o_10   (pre_coeff[10]      ),
    .o_11   (pre_coeff[11]      ),
    .o_12   (pre_coeff[12]      ),
    .o_13   (pre_coeff[13]      ),
    .o_14   (pre_coeff[14]      ),
    .o_15   (pre_coeff[15]      )
);

//output
    assign o_valid = pre_coeff_valid;
    assign o_0     = butterfly_32[0 ];//32_E
    assign o_1     = butterfly_32[1 ];
    assign o_2     = butterfly_32[2 ];
    assign o_3     = butterfly_32[3 ];
    assign o_4     = butterfly_32[4 ];
    assign o_5     = butterfly_32[5 ];
    assign o_6     = butterfly_32[6 ];
    assign o_7     = butterfly_32[7 ];
    assign o_8     = butterfly_32[8 ];
    assign o_9     = butterfly_32[9 ];
    assign o_10    = butterfly_32[10];
    assign o_11    = butterfly_32[11];
    assign o_12    = butterfly_32[12];
    assign o_13    = butterfly_32[13];
    assign o_14    = butterfly_32[14];
    assign o_15    = butterfly_32[15];
    assign o_16    = pre_coeff[0 ];//1 
    assign o_17    = pre_coeff[1 ];//3 
    assign o_18    = pre_coeff[2 ];//5 
    assign o_19    = pre_coeff[3 ];//7 
    assign o_20    = pre_coeff[4 ];//9 
    assign o_21    = pre_coeff[5 ];//11
    assign o_22    = pre_coeff[6 ];//13
    assign o_23    = pre_coeff[7 ];//15
    assign o_24    = pre_coeff[8 ];//17
    assign o_25    = pre_coeff[9 ];//19
    assign o_26    = pre_coeff[10];//21
    assign o_27    = pre_coeff[11];//23
    assign o_28    = pre_coeff[12];//25
    assign o_29    = pre_coeff[13];//27
    assign o_30    = pre_coeff[14];//29
    assign o_31    = pre_coeff[15];//31

endmodule
