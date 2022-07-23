//describe  : MCM(RAG-n算法)生成乘法单元，求和得到结果
//input     : 8个蝶形单元
//output    : 8个系数结果(后需右移)
//delay     : 3 clk
module dct2_calculate_16#(
    parameter IN_WIDTH = 19
)
(
//system input
    input                                   clk     ,
    input                                   rst_n   ,
//input parameter
    input               [2 : 0]             i_size  ,//3:DCT_16, 4:DCT_32, 5:DCT_64
//input data                                         //N=64     N=32    N=16
    input                                   i_valid ,
    input       signed  [IN_WIDTH - 1 : 0]  i_0     ,//EEO0     EO0     O0
    input       signed  [IN_WIDTH - 1 : 0]  i_1     ,//EEO1     EO1     O1
    input       signed  [IN_WIDTH - 1 : 0]  i_2     ,//EEO2     EO2     O2
    input       signed  [IN_WIDTH - 1 : 0]  i_3     ,//EEO3     EO3     O3
    input       signed  [IN_WIDTH - 1 : 0]  i_4     ,//EEO4     EO4     O4
    input       signed  [IN_WIDTH - 1 : 0]  i_5     ,//EEO5     EO5     O5
    input       signed  [IN_WIDTH - 1 : 0]  i_6     ,//EEO6     EO6     O6
    input       signed  [IN_WIDTH - 1 : 0]  i_7     ,//EEO7     EO7     O7
//output pre_coeff
    output reg                              o_valid ,
    output reg  signed  [IN_WIDTH + 8 : 0]  o_0     ,//4        2       1
    output reg  signed  [IN_WIDTH + 8 : 0]  o_1     ,//12       6       3
    output reg  signed  [IN_WIDTH + 8 : 0]  o_2     ,//20       10      5
    output reg  signed  [IN_WIDTH + 8 : 0]  o_3     ,//28       14      7
    output reg  signed  [IN_WIDTH + 8 : 0]  o_4     ,//36(0)    18      9
    output reg  signed  [IN_WIDTH + 8 : 0]  o_5     ,//44(0)    22      11
    output reg  signed  [IN_WIDTH + 8 : 0]  o_6     ,//52(0)    26      13
    output reg  signed  [IN_WIDTH + 8 : 0]  o_7      //60(0)    30      15
);

integer i;
localparam SIZE64 = 3'd5;

//mcm
//90 87 80 70 / 57 43 25 9
    wire signed [IN_WIDTH + 8 : 0] i_0_4 = i_0 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_0_5 = i_0 + i_0_4;
    wire signed [IN_WIDTH + 8 : 0] i_0_8 = i_0 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_0_9 = i_0 + i_0_8;
    wire signed [IN_WIDTH + 8 : 0] i_0_16 = i_0 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_0_25 = i_0_9 + i_0_16;
    wire signed [IN_WIDTH + 8 : 0] i_0_36 = i_0_9 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_0_35 = i_0_36 - i_0;
    wire signed [IN_WIDTH + 8 : 0] i_0_40 = i_0_5 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_0_45 = i_0_5 + i_0_40;
    wire signed [IN_WIDTH + 8 : 0] i_0_43 = i_0_35 + i_0_8;
    wire signed [IN_WIDTH + 8 : 0] i_0_32 = i_0 <<< 5;
    wire signed [IN_WIDTH + 8 : 0] i_0_57 = i_0_25 + i_0_32;
    wire signed [IN_WIDTH + 8 : 0] i_0_86 = i_0_43 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_0_87 = i_0 + i_0_86;
    wire signed [IN_WIDTH + 8 : 0] i_0_90 = i_0_45 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_0_80 = i_0_5 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_0_70 = i_0_35 <<< 1;
//87 57 9 -43 / -80 -90 -70 -25
    wire signed [IN_WIDTH + 8 : 0] i_1_4 = i_1 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_1_5 = i_1 + i_1_4;
    wire signed [IN_WIDTH + 8 : 0] i_1_8 = i_1 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_1_9 = i_1 + i_1_8;
    wire signed [IN_WIDTH + 8 : 0] i_1_16 = i_1 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_1_25 = i_1_9 + i_1_16;
    wire signed [IN_WIDTH + 8 : 0] i_1_36 = i_1_9 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_1_35 = i_1_36 - i_1;
    wire signed [IN_WIDTH + 8 : 0] i_1_40 = i_1_5 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_1_45 = i_1_5 + i_1_40;
    wire signed [IN_WIDTH + 8 : 0] i_1_43 = i_1_35 + i_1_8;
    wire signed [IN_WIDTH + 8 : 0] i_1_32 = i_1 <<< 5;
    wire signed [IN_WIDTH + 8 : 0] i_1_57 = i_1_25 + i_1_32;
    wire signed [IN_WIDTH + 8 : 0] i_1_86 = i_1_43 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_1_87 = i_1 + i_1_86;
    wire signed [IN_WIDTH + 8 : 0] i_1_90 = i_1_45 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_1_80 = i_1_5 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_1_70 = i_1_35 <<< 1;
//80 9 -70 -87 / -25 57 90 43
    wire signed [IN_WIDTH + 8 : 0] i_2_4 = i_2 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_2_5 = i_2 + i_2_4;
    wire signed [IN_WIDTH + 8 : 0] i_2_8 = i_2 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_2_9 = i_2 + i_2_8;
    wire signed [IN_WIDTH + 8 : 0] i_2_16 = i_2 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_2_25 = i_2_9 + i_2_16;
    wire signed [IN_WIDTH + 8 : 0] i_2_36 = i_2_9 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_2_35 = i_2_36 - i_2;
    wire signed [IN_WIDTH + 8 : 0] i_2_40 = i_2_5 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_2_45 = i_2_5 + i_2_40;
    wire signed [IN_WIDTH + 8 : 0] i_2_43 = i_2_35 + i_2_8;
    wire signed [IN_WIDTH + 8 : 0] i_2_32 = i_2 <<< 5;
    wire signed [IN_WIDTH + 8 : 0] i_2_57 = i_2_25 + i_2_32;
    wire signed [IN_WIDTH + 8 : 0] i_2_86 = i_2_43 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_2_87 = i_2 + i_2_86;
    wire signed [IN_WIDTH + 8 : 0] i_2_90 = i_2_45 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_2_80 = i_2_5 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_2_70 = i_2_35 <<< 1;
//70 -43 -87 9 / 90 25 -80 -57
    wire signed [IN_WIDTH + 8 : 0] i_3_4 = i_3 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_3_5 = i_3 + i_3_4;
    wire signed [IN_WIDTH + 8 : 0] i_3_8 = i_3 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_3_9 = i_3 + i_3_8;
    wire signed [IN_WIDTH + 8 : 0] i_3_16 = i_3 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_3_25 = i_3_9 + i_3_16;
    wire signed [IN_WIDTH + 8 : 0] i_3_36 = i_3_9 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_3_35 = i_3_36 - i_3;
    wire signed [IN_WIDTH + 8 : 0] i_3_40 = i_3_5 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_3_45 = i_3_5 + i_3_40;
    wire signed [IN_WIDTH + 8 : 0] i_3_43 = i_3_35 + i_3_8;
    wire signed [IN_WIDTH + 8 : 0] i_3_32 = i_3 <<< 5;
    wire signed [IN_WIDTH + 8 : 0] i_3_57 = i_3_25 + i_3_32;
    wire signed [IN_WIDTH + 8 : 0] i_3_86 = i_3_43 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_3_87 = i_3 + i_3_86;
    wire signed [IN_WIDTH + 8 : 0] i_3_90 = i_3_45 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_3_80 = i_3_5 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_3_70 = i_3_35 <<< 1;
//57 -80 -25 90 / -9 -87 43 70
    wire signed [IN_WIDTH + 8 : 0] i_4_4 = i_4 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_4_5 = i_4 + i_4_4;
    wire signed [IN_WIDTH + 8 : 0] i_4_8 = i_4 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_4_9 = i_4 + i_4_8;
    wire signed [IN_WIDTH + 8 : 0] i_4_16 = i_4 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_4_25 = i_4_9 + i_4_16;
    wire signed [IN_WIDTH + 8 : 0] i_4_36 = i_4_9 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_4_35 = i_4_36 - i_4;
    wire signed [IN_WIDTH + 8 : 0] i_4_40 = i_4_5 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_4_45 = i_4_5 + i_4_40;
    wire signed [IN_WIDTH + 8 : 0] i_4_43 = i_4_35 + i_4_8;
    wire signed [IN_WIDTH + 8 : 0] i_4_32 = i_4 <<< 5;
    wire signed [IN_WIDTH + 8 : 0] i_4_57 = i_4_25 + i_4_32;
    wire signed [IN_WIDTH + 8 : 0] i_4_86 = i_4_43 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_4_87 = i_4 + i_4_86;
    wire signed [IN_WIDTH + 8 : 0] i_4_90 = i_4_45 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_4_80 = i_4_5 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_4_70 = i_4_35 <<< 1;
//43 -90 57 25 / -87 70 9 -80
    wire signed [IN_WIDTH + 8 : 0] i_5_4 = i_5 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_5_5 = i_5 + i_5_4;
    wire signed [IN_WIDTH + 8 : 0] i_5_8 = i_5 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_5_9 = i_5 + i_5_8;
    wire signed [IN_WIDTH + 8 : 0] i_5_16 = i_5 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_5_25 = i_5_9 + i_5_16;
    wire signed [IN_WIDTH + 8 : 0] i_5_36 = i_5_9 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_5_35 = i_5_36 - i_5;
    wire signed [IN_WIDTH + 8 : 0] i_5_40 = i_5_5 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_5_45 = i_5_5 + i_5_40;
    wire signed [IN_WIDTH + 8 : 0] i_5_43 = i_5_35 + i_5_8;
    wire signed [IN_WIDTH + 8 : 0] i_5_32 = i_5 <<< 5;
    wire signed [IN_WIDTH + 8 : 0] i_5_57 = i_5_25 + i_5_32;
    wire signed [IN_WIDTH + 8 : 0] i_5_86 = i_5_43 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_5_87 = i_5 + i_5_86;
    wire signed [IN_WIDTH + 8 : 0] i_5_90 = i_5_45 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_5_80 = i_5_5 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_5_70 = i_5_35 <<< 1;
//25 -70 90 -80 / 43 9 -57 87
    wire signed [IN_WIDTH + 8 : 0] i_6_4 = i_6 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_6_5 = i_6 + i_6_4;
    wire signed [IN_WIDTH + 8 : 0] i_6_8 = i_6 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_6_9 = i_6 + i_6_8;
    wire signed [IN_WIDTH + 8 : 0] i_6_16 = i_6 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_6_25 = i_6_9 + i_6_16;
    wire signed [IN_WIDTH + 8 : 0] i_6_36 = i_6_9 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_6_35 = i_6_36 - i_6;
    wire signed [IN_WIDTH + 8 : 0] i_6_40 = i_6_5 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_6_45 = i_6_5 + i_6_40;
    wire signed [IN_WIDTH + 8 : 0] i_6_43 = i_6_35 + i_6_8;
    wire signed [IN_WIDTH + 8 : 0] i_6_32 = i_6 <<< 5;
    wire signed [IN_WIDTH + 8 : 0] i_6_57 = i_6_25 + i_6_32;
    wire signed [IN_WIDTH + 8 : 0] i_6_86 = i_6_43 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_6_87 = i_6 + i_6_86;
    wire signed [IN_WIDTH + 8 : 0] i_6_90 = i_6_45 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_6_80 = i_6_5 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_6_70 = i_6_35 <<< 1;
//9 -25 43 -57 / 70 -80 87 -90
    wire signed [IN_WIDTH + 8 : 0] i_7_4 = i_7 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_7_5 = i_7 + i_7_4;
    wire signed [IN_WIDTH + 8 : 0] i_7_8 = i_7 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_7_9 = i_7 + i_7_8;
    wire signed [IN_WIDTH + 8 : 0] i_7_16 = i_7 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_7_25 = i_7_9 + i_7_16;
    wire signed [IN_WIDTH + 8 : 0] i_7_36 = i_7_9 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_7_35 = i_7_36 - i_7;
    wire signed [IN_WIDTH + 8 : 0] i_7_40 = i_7_5 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_7_45 = i_7_5 + i_7_40;
    wire signed [IN_WIDTH + 8 : 0] i_7_43 = i_7_35 + i_7_8;
    wire signed [IN_WIDTH + 8 : 0] i_7_32 = i_7 <<< 5;
    wire signed [IN_WIDTH + 8 : 0] i_7_57 = i_7_25 + i_7_32;
    wire signed [IN_WIDTH + 8 : 0] i_7_86 = i_7_43 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_7_87 = i_7 + i_7_86;
    wire signed [IN_WIDTH + 8 : 0] i_7_90 = i_7_45 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_7_80 = i_7_5 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_7_70 = i_7_35 <<< 1;

//sum
reg i_valid_d1, i_valid_d2;
reg signed  [IN_WIDTH + 8 : 0] sum0_0[0 : 7], sum0_1[0 : 7], sum0_2[0 : 7], sum0_3[0 : 7];
reg signed  [IN_WIDTH + 8 : 0] sum1_0[0 : 7], sum1_1[0 : 7];
//stage 1
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d1 <= 0;
        for (i = 0; i < 8; i = i + 1) begin
            sum0_0[i] <= 0; sum0_1[i] <= 0; sum0_2[i] <= 0; sum0_3[i] <= 0; 
        end
    end
    else begin
        i_valid_d1 <= i_valid;
        sum0_0[0] <= i_0_90 + i_1_87; sum0_1[0] <= i_2_80 + i_3_70; sum0_2[0] <= i_4_57 + i_5_43; sum0_3[0] <= i_6_25 + i_7_9 ;
        sum0_0[1] <= i_0_87 + i_1_57; sum0_1[1] <= i_2_9  - i_3_43; sum0_2[1] <= i_4_80 + i_5_90; sum0_3[1] <= i_6_70 + i_7_25;
        sum0_0[2] <= i_0_80 + i_1_9 ; sum0_1[2] <= i_2_70 + i_3_87; sum0_2[2] <= i_4_25 - i_5_57; sum0_3[2] <= i_6_90 + i_7_43;
        sum0_0[3] <= i_0_70 - i_1_43; sum0_1[3] <= i_2_87 - i_3_9 ; sum0_2[3] <= i_4_90 + i_5_25; sum0_3[3] <= i_6_80 + i_7_57;
        sum0_0[4] <= i_0_57 - i_1_80; sum0_1[4] <= i_2_25 - i_3_90; sum0_2[4] <= i_4_9  + i_5_87; sum0_3[4] <= i_6_43 + i_7_70;
        sum0_0[5] <= i_0_43 - i_1_90; sum0_1[5] <= i_2_57 + i_3_25; sum0_2[5] <= i_4_87 - i_5_70; sum0_3[5] <= i_6_9  - i_7_80;
        sum0_0[6] <= i_0_25 - i_1_70; sum0_1[6] <= i_2_90 - i_3_80; sum0_2[6] <= i_4_43 + i_5_9 ; sum0_3[6] <= i_6_57 - i_7_87;
        sum0_0[7] <= i_0_9  - i_1_25; sum0_1[7] <= i_2_43 - i_3_57; sum0_2[7] <= i_4_70 - i_5_80; sum0_3[7] <= i_6_87 - i_7_90;
    end
end
//stage 2
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d2 <= 0;
        for (i = 0; i < 8; i = i + 1) begin
            sum1_0[i] <= 0; sum1_1[i] <= 0;
        end
    end
    else begin
        i_valid_d2 <= i_valid_d1;
        sum1_0[0] <= sum0_0[0] + sum0_1[0]; sum1_1[0] <= sum0_2[0] + sum0_3[0];
        sum1_0[1] <= sum0_0[1] + sum0_1[1]; sum1_1[1] <= sum0_2[1] + sum0_3[1];
        sum1_0[2] <= sum0_0[2] - sum0_1[2]; sum1_1[2] <= sum0_2[2] - sum0_3[2];
        sum1_0[3] <= sum0_0[3] - sum0_1[3]; sum1_1[3] <= sum0_2[3] - sum0_3[3];
        sum1_0[4] <= sum0_0[4] - sum0_1[4]; sum1_1[4] <= sum0_2[4] - sum0_3[4];
        sum1_0[5] <= sum0_0[5] + sum0_1[5]; sum1_1[5] <= sum0_2[5] - sum0_3[5];
        sum1_0[6] <= sum0_0[6] + sum0_1[6]; sum1_1[6] <= sum0_2[6] - sum0_3[6];
        sum1_0[7] <= sum0_0[7] + sum0_1[7]; sum1_1[7] <= sum0_2[7] + sum0_3[7];
    end
end
//stage 3
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        o_valid <= 0;
        o_0 <= 0;
        o_1 <= 0;
        o_2 <= 0;
        o_3 <= 0;
        o_4 <= 0;
        o_5 <= 0;
        o_6 <= 0;
        o_7 <= 0;
    end
    else if (i_size == SIZE64) begin//高频置零
        o_valid <= i_valid_d2;
        o_0 <= sum1_0[0] + sum1_1[0];
        o_1 <= sum1_0[1] - sum1_1[1];
        o_2 <= sum1_0[2] - sum1_1[2];
        o_3 <= sum1_0[3] + sum1_1[3];
        o_4 <= 0;
        o_5 <= 0;
        o_6 <= 0;
        o_7 <= 0;
    end
    else begin
        o_valid <= i_valid_d2;
        o_0 <= sum1_0[0] + sum1_1[0];
        o_1 <= sum1_0[1] - sum1_1[1];
        o_2 <= sum1_0[2] - sum1_1[2];
        o_3 <= sum1_0[3] + sum1_1[3];
        o_4 <= sum1_0[4] - sum1_1[4];
        o_5 <= sum1_0[5] - sum1_1[5];
        o_6 <= sum1_0[6] + sum1_1[6];
        o_7 <= sum1_0[7] + sum1_1[7];
    end
end

endmodule
