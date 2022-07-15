//describe  : 8x8点DCT计算
//input     : 8个像素残差/第一次变换系数
//output    : 4个预变换系数(后需右移)+4个8_E
//delay     : 8_E : 1 clk , 8_precoeff : 2 clk
module dct1d_8#(
    parameter  IN_WIDTH  = 19
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
//output pre_coeff
    output                              o_valid ,
    output  signed  [IN_WIDTH      : 0] o_0     ,
    output  signed  [IN_WIDTH      : 0] o_1     ,
    output  signed  [IN_WIDTH      : 0] o_2     ,
    output  signed  [IN_WIDTH      : 0] o_3     ,
    output  signed  [IN_WIDTH + 8  : 0] o_4     ,
    output  signed  [IN_WIDTH + 8  : 0] o_5     ,
    output  signed  [IN_WIDTH + 8  : 0] o_6     ,
    output  signed  [IN_WIDTH + 8  : 0] o_7     
);

//butterfly
    wire butterfly_8_valid;
    wire signed [IN_WIDTH : 0]  butterfly_8[7 : 0];
//calculate : mcm + sum
    wire pre_coeff_valid;
    wire signed [IN_WIDTH + 8 : 0] pre_coeff[3 : 0];

//sub module
butterfly_8#(
    .IN_WIDTH   (IN_WIDTH)
)
u_butterfly_8(
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
//output data
    .o_valid(butterfly_8_valid  ),
    .o_0    (butterfly_8[0 ]    ),//E
    .o_1    (butterfly_8[1 ]    ),
    .o_2    (butterfly_8[2 ]    ),
    .o_3    (butterfly_8[3 ]    ),
    .o_4    (butterfly_8[4 ]    ),//O
    .o_5    (butterfly_8[5 ]    ),
    .o_6    (butterfly_8[6 ]    ),
    .o_7    (butterfly_8[7 ]    )
);

calculate_8#(
    .IN_WIDTH   (IN_WIDTH + 1)
) 
u_calculate_8(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_size             ),
//input data
    .i_valid(butterfly_8_valid  ),
    .i_0    (butterfly_8[4 ]    ),
    .i_1    (butterfly_8[5 ]    ),
    .i_2    (butterfly_8[6 ]    ),
    .i_3    (butterfly_8[7 ]    ),
//output pre_coeff
    .o_valid(pre_coeff_valid    ),
    .o_0    (pre_coeff[0 ]      ),
    .o_1    (pre_coeff[1 ]      ),
    .o_2    (pre_coeff[2 ]      ),
    .o_3    (pre_coeff[3 ]      ) 
);

//output
    assign o_valid = pre_coeff_valid;
    assign o_0     = butterfly_8[0 ];
    assign o_1     = butterfly_8[1 ];
    assign o_2     = butterfly_8[2 ];
    assign o_3     = butterfly_8[3 ];
    assign o_4     = pre_coeff[0 ];//1
    assign o_5     = pre_coeff[1 ];//3
    assign o_6     = pre_coeff[2 ];//5
    assign o_7     = pre_coeff[3 ];//7

endmodule
