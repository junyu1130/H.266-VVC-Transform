//describe  : MCM(RAG-n算法)生成乘法单元，求和得到结果
//input     : 4个蝶形单元
//output    : 4个系数结果(后需右移)
//delay     : 1 clk
module calculate_4#(
    parameter IN_WIDTH = 21
)
(
//system input
    input                                   clk     ,
    input                                   rst_n   ,
//input parameter
    input               [2 : 0]             i_size  ,//1:DCT_4, 2:DCT_8, 3:DCT_16, 4:DCT_32, 5:DCT_64
//input data                                         //N=64     N=32    N=16    N=8     N=4
    input                                   i_valid ,
    input       signed  [IN_WIDTH - 1 : 0]  i_0     ,//EEEEE0   EEEE0   EEE0    EE0     E0
    input       signed  [IN_WIDTH - 1 : 0]  i_1     ,//EEEEE1   EEEE1   EEE1    EE1     E1
    input       signed  [IN_WIDTH - 1 : 0]  i_2     ,//EEEEO0   EEEO0   EEO0    EO0     O0
    input       signed  [IN_WIDTH - 1 : 0]  i_3     ,//EEEEO1   EEEO1   EEO1    EO1     O1
//output pre_coeff
    output reg                              o_valid ,
    output reg  signed  [IN_WIDTH + 6 : 0]  o_0     ,//0        0       0       0       0
    output reg  signed  [IN_WIDTH + 6 : 0]  o_1     ,//16       8       4       2       1
    output reg  signed  [IN_WIDTH + 6 : 0]  o_2     ,//32(0)    16      8       4       2
    output reg  signed  [IN_WIDTH + 6 : 0]  o_3      //48(0)    24      12      6       3
);

localparam DCT_64 = 5;

//mcm
//64 / 64
    wire signed [IN_WIDTH + 6 : 0] i_0_64 = i_0 <<< 6;
//64 / -64
    wire signed [IN_WIDTH + 6 : 0] i_1_64 = i_1 <<< 6;
//83 / 36
    wire signed [IN_WIDTH + 6 : 0] i_2_8 = i_2 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_2_9 = i_2 + i_2_8;
    wire signed [IN_WIDTH + 6 : 0] i_2_2 = i_2 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_2_11 = i_2_9 + i_2_2;
    wire signed [IN_WIDTH + 6 : 0] i_2_72 = i_2_9 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_2_83 = i_2_11 + i_2_72;
    wire signed [IN_WIDTH + 6 : 0] i_2_36 = i_2_9 <<< 2;
//36 / -83
    wire signed [IN_WIDTH + 6 : 0] i_3_8 = i_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_3_9 = i_3 + i_3_8;
    wire signed [IN_WIDTH + 6 : 0] i_3_2 = i_3 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_3_11 = i_3_9 + i_3_2;
    wire signed [IN_WIDTH + 6 : 0] i_3_72 = i_3_9 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_3_83 = i_3_11 + i_3_72;
    wire signed [IN_WIDTH + 6 : 0] i_3_36 = i_3_9 <<< 2;

//sum
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        o_valid <= 0;
        o_0     <= 0;
        o_1     <= 0;
        o_2     <= 0;
        o_3     <= 0;
    end
    else if (i_size == DCT_64) begin//高频置零
        o_valid <= i_valid;
        o_0     <= i_0_64 + i_1_64;
        o_1     <= i_2_83 + i_3_36;
        o_2     <= 0;
        o_3     <= 0;
    end
    else begin
        o_valid <= i_valid;
        o_0     <= i_0_64 + i_1_64;
        o_1     <= i_2_83 + i_3_36;
        o_2     <= i_0_64 - i_1_64;
        o_3     <= i_2_36 - i_3_83;
    end
end

endmodule
