//describe  : 16x16点DCT计算
//input     : 16个像素残差/一维变换系数
//output    : 8个预变换系数(后需右移)+8个16_E
//delay     : 16_E : 1 clk , 16_precoeff : 4 clk
module dct2_1d_16#(
    parameter  IN_WIDTH  = 18
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
    output  signed  [IN_WIDTH + 9  : 0] o_8     ,
    output  signed  [IN_WIDTH + 9  : 0] o_9     ,
    output  signed  [IN_WIDTH + 9  : 0] o_10    ,
    output  signed  [IN_WIDTH + 9  : 0] o_11    ,
    output  signed  [IN_WIDTH + 9  : 0] o_12    ,
    output  signed  [IN_WIDTH + 9  : 0] o_13    ,
    output  signed  [IN_WIDTH + 9  : 0] o_14    ,
    output  signed  [IN_WIDTH + 9  : 0] o_15    
);

//butterfly
    wire butterfly_16_valid;
    wire signed [IN_WIDTH : 0]  butterfly_16[0 : 15];
//calculate : mcm + sum
    wire pre_coeff_valid;
    wire signed [IN_WIDTH + 9 : 0] pre_coeff[0 : 7];

//sub module
dct2_butterfly_16#(
    .IN_WIDTH   (IN_WIDTH)
)
u_dct2_butterfly_16(
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
//output data
    .o_valid(butterfly_16_valid ),
    .o_0    (butterfly_16[0 ]   ),//E
    .o_1    (butterfly_16[1 ]   ),
    .o_2    (butterfly_16[2 ]   ),
    .o_3    (butterfly_16[3 ]   ),
    .o_4    (butterfly_16[4 ]   ),
    .o_5    (butterfly_16[5 ]   ),
    .o_6    (butterfly_16[6 ]   ),
    .o_7    (butterfly_16[7 ]   ),
    .o_8    (butterfly_16[8 ]   ),//O
    .o_9    (butterfly_16[9 ]   ),
    .o_10   (butterfly_16[10]   ),
    .o_11   (butterfly_16[11]   ),
    .o_12   (butterfly_16[12]   ),
    .o_13   (butterfly_16[13]   ),
    .o_14   (butterfly_16[14]   ),
    .o_15   (butterfly_16[15]   )
);

dct2_calculate_16#(
    .IN_WIDTH   (IN_WIDTH + 1)
) 
u_dct2_calculate_16(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_size             ),
//input data
    .i_valid(butterfly_16_valid ),
    .i_0    (butterfly_16[8 ]   ),
    .i_1    (butterfly_16[9 ]   ),
    .i_2    (butterfly_16[10]   ),
    .i_3    (butterfly_16[11]   ),
    .i_4    (butterfly_16[12]   ),
    .i_5    (butterfly_16[13]   ),
    .i_6    (butterfly_16[14]   ),
    .i_7    (butterfly_16[15]   ),
//output pre_coeff
    .o_valid(pre_coeff_valid    ),
    .o_0    (pre_coeff[0 ]      ),
    .o_1    (pre_coeff[1 ]      ),
    .o_2    (pre_coeff[2 ]      ),
    .o_3    (pre_coeff[3 ]      ),
    .o_4    (pre_coeff[4 ]      ),
    .o_5    (pre_coeff[5 ]      ),
    .o_6    (pre_coeff[6 ]      ),
    .o_7    (pre_coeff[7 ]      ) 
);

//output
    assign o_valid = pre_coeff_valid;
    assign o_0     = butterfly_16[0];
    assign o_1     = butterfly_16[1];
    assign o_2     = butterfly_16[2];
    assign o_3     = butterfly_16[3];
    assign o_4     = butterfly_16[4];
    assign o_5     = butterfly_16[5];
    assign o_6     = butterfly_16[6];
    assign o_7     = butterfly_16[7];
    assign o_8     = pre_coeff[0];//1 
    assign o_9     = pre_coeff[1];//3 
    assign o_10    = pre_coeff[2];//5 
    assign o_11    = pre_coeff[3];//7 
    assign o_12    = pre_coeff[4];//9 
    assign o_13    = pre_coeff[5];//11
    assign o_14    = pre_coeff[6];//13
    assign o_15    = pre_coeff[7];//15

endmodule
