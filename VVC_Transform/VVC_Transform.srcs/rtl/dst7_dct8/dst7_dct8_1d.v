//describe  : 一维DST7/SCT8，正序输入DST7，倒序输入DCT8(奇数行输出反号)
//input     : 32个像素残差/一维变换系数
//output    : 32个一维变换系数/二维变换系数
//delay     : 4 clk
module dst7_dct8_1d#(
    parameter  IN_WIDTH  = 16,
    parameter  OUT_WIDTH = 27
)
(
//system input
    input                               clk     ,
    input                               rst_n   ,
//input parameter
    input           [2 : 0]             i_size ,//1:4x4, 2:8x8, 3:16x16, 4:32x32
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
//output parameter
    output          [2 : 0]             o_size  ,
//output coeff
    output                              o_valid ,
    output  signed  [OUT_WIDTH - 1 : 0] o_0     ,
    output  signed  [OUT_WIDTH - 1 : 0] o_1     ,
    output  signed  [OUT_WIDTH - 1 : 0] o_2     ,
    output  signed  [OUT_WIDTH - 1 : 0] o_3     ,
    output  signed  [OUT_WIDTH - 1 : 0] o_4     ,
    output  signed  [OUT_WIDTH - 1 : 0] o_5     ,
    output  signed  [OUT_WIDTH - 1 : 0] o_6     ,
    output  signed  [OUT_WIDTH - 1 : 0] o_7     ,
    output  signed  [OUT_WIDTH - 1 : 0] o_8     ,
    output  signed  [OUT_WIDTH - 1 : 0] o_9     ,
    output  signed  [OUT_WIDTH - 1 : 0] o_10    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_11    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_12    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_13    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_14    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_15    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_16    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_17    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_18    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_19    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_20    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_21    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_22    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_23    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_24    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_25    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_26    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_27    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_28    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_29    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_30    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_31    
);

integer i;

//input
    reg [2 : 0] i_size_d1;
    reg i_valid_d1;
    wire signed [IN_WIDTH - 1 : 0] i_data[0 : 31];
    reg signed [IN_WIDTH - 1 : 0] i_data_d1[0 : 31];

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

//input delay
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_size_d1 <= 0;
        i_valid_d1 <= 0; 
        for (i = 0; i < 32; i = i + 1) begin
            i_data_d1[i] <= 0; 
        end
    end
    else begin
        i_size_d1 <= i_size;
        i_valid_d1 <= i_valid;  
        for (i = 0; i < 32; i = i + 1) begin
            i_data_d1[i] <= i_data[i]; 
        end
    end
end

//32x32
dst7_dct8_1d_calculate#(
    .IN_WIDTH   (IN_WIDTH)
)
u0_dst7_dct8_1d_calculate(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_size_d1          ),
//input data
    .i_valid(i_valid_d1         ),
    .i_0    (i_data_d1[0 ]      ),
    .i_1    (i_data_d1[1 ]      ),
    .i_2    (i_data_d1[2 ]      ),
    .i_3    (i_data_d1[3 ]      ),
    .i_4    (i_data_d1[4 ]      ),
    .i_5    (i_data_d1[5 ]      ),
    .i_6    (i_data_d1[6 ]      ),
    .i_7    (i_data_d1[7 ]      ),
    .i_8    (i_data_d1[8 ]      ),
    .i_9    (i_data_d1[9 ]      ),
    .i_10   (i_data_d1[10]      ),
    .i_11   (i_data_d1[11]      ),
    .i_12   (i_data_d1[12]      ),
    .i_13   (i_data_d1[13]      ),
    .i_14   (i_data_d1[14]      ),
    .i_15   (i_data_d1[15]      ),
    .i_16   (i_data_d1[16]      ),
    .i_17   (i_data_d1[17]      ),
    .i_18   (i_data_d1[18]      ),
    .i_19   (i_data_d1[19]      ),
    .i_20   (i_data_d1[20]      ),
    .i_21   (i_data_d1[21]      ),
    .i_22   (i_data_d1[22]      ),
    .i_23   (i_data_d1[23]      ),
    .i_24   (i_data_d1[24]      ),
    .i_25   (i_data_d1[25]      ),
    .i_26   (i_data_d1[26]      ),
    .i_27   (i_data_d1[27]      ),
    .i_28   (i_data_d1[28]      ),
    .i_29   (i_data_d1[29]      ),
    .i_30   (i_data_d1[30]      ),
    .i_31   (i_data_d1[31]      ),
//output parameter
    .o_size (o_size             ),
//output data
    .o_valid(o_valid            ),
    .o_0    (o_0                ),
    .o_1    (o_1                ),
    .o_2    (o_2                ),
    .o_3    (o_3                ),
    .o_4    (o_4                ),
    .o_5    (o_5                ),
    .o_6    (o_6                ),
    .o_7    (o_7                ),
    .o_8    (o_8                ),
    .o_9    (o_9                ),
    .o_10   (o_10               ),
    .o_11   (o_11               ),
    .o_12   (o_12               ),
    .o_13   (o_13               ),
    .o_14   (o_14               ),
    .o_15   (o_15               ),
    .o_16   (o_16               ),
    .o_17   (o_17               ),
    .o_18   (o_18               ),
    .o_19   (o_19               ),
    .o_20   (o_20               ),
    .o_21   (o_21               ),
    .o_22   (o_22               ),
    .o_23   (o_23               ),
    .o_24   (o_24               ),
    .o_25   (o_25               ),
    .o_26   (o_26               ),
    .o_27   (o_27               ),
    .o_28   (o_28               ),
    .o_29   (o_29               ),
    .o_30   (o_30               ),
    .o_31   (o_31               )
);

endmodule
