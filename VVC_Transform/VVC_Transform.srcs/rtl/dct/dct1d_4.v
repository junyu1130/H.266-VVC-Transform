//describe  : 4x4点DCT计算
//input     : 4个像素残差/第一次变换系数
//output    : 4个预变换系数(后需右移)
//delay     : 1 clk
module dct1d_4#(
    parameter  IN_WIDTH  = 20
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
//output pre_coeff
    output                              o_valid ,
    output  signed  [IN_WIDTH + 7 : 0]  o_0     ,
    output  signed  [IN_WIDTH + 7 : 0]  o_1     ,
    output  signed  [IN_WIDTH + 7 : 0]  o_2     ,
    output  signed  [IN_WIDTH + 7 : 0]  o_3     
);

//butterfly
    wire signed [IN_WIDTH : 0]  butterfly_4[3 : 0];
//calculate : mcm + sum
    wire pre_coeff_valid;
    wire signed [IN_WIDTH + 7 : 0] pre_coeff[3 : 0];

//sub module
butterfly_4#(
    .IN_WIDTH   (IN_WIDTH)
)
u_butterfly_4(
//input data
    .i_0    (i_0                ),
    .i_1    (i_1                ),
    .i_2    (i_2                ),
    .i_3    (i_3                ),
//output data
    .o_0    (butterfly_4[0 ]    ),//E
    .o_1    (butterfly_4[1 ]    ),
    .o_2    (butterfly_4[2 ]    ),//O
    .o_3    (butterfly_4[3 ]    )
);

calculate_4#(
    .IN_WIDTH   (IN_WIDTH + 1)
) 
u_calculate_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_size             ),
//input data
    .i_valid(i_valid            ),
    .i_0    (butterfly_4[0 ]    ),
    .i_1    (butterfly_4[1 ]    ),
    .i_2    (butterfly_4[2 ]    ),
    .i_3    (butterfly_4[3 ]    ),
//output pre_coeff
    .o_valid(pre_coeff_valid    ),
    .o_0    (pre_coeff[0 ]      ),
    .o_1    (pre_coeff[1 ]      ),
    .o_2    (pre_coeff[2 ]      ),
    .o_3    (pre_coeff[3 ]      ) 
);

//output
    assign o_valid = pre_coeff_valid;
    assign o_0     = pre_coeff[0 ];
    assign o_1     = pre_coeff[1 ];
    assign o_2     = pre_coeff[2 ];
    assign o_3     = pre_coeff[3 ];

endmodule
