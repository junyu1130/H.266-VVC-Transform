//describe  : MCM(RAG-n算法)生成乘法单元，求和得到结果
//input     : 4个蝶形单元
//output    : 4个系数结果(后需右移)
//delay     : 2 clk
module calculate_8#(
    parameter IN_WIDTH = 20
)
(
//system input
    input                                   clk     ,
    input                                   rst_n   ,
//input parameter
    input               [2 : 0]             i_size  ,//2:DCT_8, 3:DCT_16, 4:DCT_32, 5:DCT_64
//input data                                         //N=64     N=32    N=16    N=8
    input                                   i_valid ,
    input       signed  [IN_WIDTH - 1 : 0]  i_0     ,//EEEO0    EEO0    EO0     O0
    input       signed  [IN_WIDTH - 1 : 0]  i_1     ,//EEEO1    EEO1    EO1     O1
    input       signed  [IN_WIDTH - 1 : 0]  i_2     ,//EEEO2    EEO2    EO2     O2
    input       signed  [IN_WIDTH - 1 : 0]  i_3     ,//EEEO3    EEO3    EO3     O3
//output pre_coeff
    output reg                              o_valid ,
    output reg  signed  [IN_WIDTH + 7 : 0]  o_0     ,//8        4       2       1
    output reg  signed  [IN_WIDTH + 7 : 0]  o_1     ,//24       12      6       3
    output reg  signed  [IN_WIDTH + 7 : 0]  o_2     ,//40(0)    20      10      5
    output reg  signed  [IN_WIDTH + 7 : 0]  o_3      //56(0)    28      14      7
);

integer i;
localparam DCT_64 = 5;

//mcm
//89 75 / 50 18
    wire signed [IN_WIDTH + 7 : 0] i_0_8 = i_0 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_0_9 = i_0 + i_0_8;
    wire signed [IN_WIDTH + 7 : 0] i_0_16 = i_0 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_0_25 = i_0_9 + i_0_16;
    wire signed [IN_WIDTH + 7 : 0] i_0_100 = i_0_25 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_0_75 = i_0_100 - i_0_25;
    wire signed [IN_WIDTH + 7 : 0] i_0_64 = i_0 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_0_89 = i_0_25 + i_0_64;
    wire signed [IN_WIDTH + 7 : 0] i_0_50 = i_0_25 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_0_18 = i_0_9 <<< 1;
//75 -18 / -89 -50
    wire signed [IN_WIDTH + 7 : 0] i_1_8 = i_1 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_1_9 = i_1 + i_1_8;
    wire signed [IN_WIDTH + 7 : 0] i_1_16 = i_1 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_1_25 = i_1_9 + i_1_16;
    wire signed [IN_WIDTH + 7 : 0] i_1_100 = i_1_25 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_1_75 = i_1_100 - i_1_25;
    wire signed [IN_WIDTH + 7 : 0] i_1_64 = i_1 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_1_89 = i_1_25 + i_1_64;
    wire signed [IN_WIDTH + 7 : 0] i_1_50 = i_1_25 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_1_18 = i_1_9 <<< 1;
//50 -89 / 18 75
    wire signed [IN_WIDTH + 7 : 0] i_2_8 = i_2 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_2_9 = i_2 + i_2_8;
    wire signed [IN_WIDTH + 7 : 0] i_2_16 = i_2 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_2_25 = i_2_9 + i_2_16;
    wire signed [IN_WIDTH + 7 : 0] i_2_100 = i_2_25 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_2_75 = i_2_100 - i_2_25;
    wire signed [IN_WIDTH + 7 : 0] i_2_64 = i_2 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_2_89 = i_2_25 + i_2_64;
    wire signed [IN_WIDTH + 7 : 0] i_2_50 = i_2_25 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_2_18 = i_2_9 <<< 1;
//18 -50 / 75 -89
    wire signed [IN_WIDTH + 7 : 0] i_3_8 = i_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_3_9 = i_3 + i_3_8;
    wire signed [IN_WIDTH + 7 : 0] i_3_16 = i_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_3_25 = i_3_9 + i_3_16;
    wire signed [IN_WIDTH + 7 : 0] i_3_100 = i_3_25 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_3_75 = i_3_100 - i_3_25;
    wire signed [IN_WIDTH + 7 : 0] i_3_64 = i_3 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_3_89 = i_3_25 + i_3_64;
    wire signed [IN_WIDTH + 7 : 0] i_3_50 = i_3_25 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_3_18 = i_3_9 <<< 1;

//sum
reg i_valid_d1;
reg signed  [IN_WIDTH + 7 : 0] sum0_0[0 : 3], sum0_1[0 : 3];
//stage 1
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d1 <= 0;
        for (i = 0; i < 4; i = i + 1) begin
            sum0_0[i] <= 0; sum0_1[i] <= 0;
        end
    end
    else begin
        i_valid_d1 <= i_valid;
        sum0_0[0] <= i_0_89 + i_1_75; sum0_1[0] <= i_2_50 + i_3_18;
        sum0_0[1] <= i_0_75 - i_1_18; sum0_1[1] <= i_2_89 + i_3_50;
        sum0_0[2] <= i_0_50 - i_1_89; sum0_1[2] <= i_2_18 + i_3_75;
        sum0_0[3] <= i_0_18 - i_1_50; sum0_1[3] <= i_2_75 - i_3_89;
    end
end
//stage 2
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        o_valid <= 0;
        o_0 <= 0;
        o_1 <= 0;
        o_2 <= 0;
        o_3 <= 0;
    end
    else if (i_size == DCT_64) begin//高频置零
        o_valid <= i_valid_d1;
        o_0 <= sum0_0[0] + sum0_1[0];
        o_1 <= sum0_0[1] - sum0_1[1];
        o_2 <= 0;
        o_3 <= 0;
    end
    else begin
        o_valid <= i_valid_d1;
        o_0 <= sum0_0[0] + sum0_1[0];
        o_1 <= sum0_0[1] - sum0_1[1];
        o_2 <= sum0_0[2] + sum0_1[2];
        o_3 <= sum0_0[3] + sum0_1[3];
    end
end

endmodule
