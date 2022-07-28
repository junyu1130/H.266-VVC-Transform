//describe  : 正序输入DST7，倒序输入DCT8(1/3/5/7/9/11/13/15输出反号)，大小为32，高频置零
//input     : 32个像素残差
//output    : 16个系数
//delay     : 6 clk
module dst7_dct8_1d_32#(
    parameter IN_WIDTH = 16
)
(
//system input
    input                                   clk     ,
    input                                   rst_n   ,
//input data                                         
    input                                   i_valid ,
    input       signed  [IN_WIDTH - 1 : 0]  i_0     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_1     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_2     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_3     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_4     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_5     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_6     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_7     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_8     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_9     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_10    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_11    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_12    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_13    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_14    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_15    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_16    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_17    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_18    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_19    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_20    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_21    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_22    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_23    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_24    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_25    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_26    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_27    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_28    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_29    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_30    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_31    ,
//output pre_coeff
    output reg                              o_valid ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_0     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_1     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_2     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_3     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_4     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_5     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_6     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_7     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_8     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_9     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_10    ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_11    ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_12    ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_13    ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_14    ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_15     
);

integer i;

//input
    wire signed [IN_WIDTH - 1 : 0] i_data[0 : 31];
    reg i_valid_d1, i_valid_d2, i_valid_d3, i_valid_d4, i_valid_d5;

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

//stage 1 butterfly
    reg signed [IN_WIDTH + 10 : 0] a0[0 : 5];
    reg signed [IN_WIDTH + 10 : 0] a1[0 : 5];
    reg signed [IN_WIDTH + 10 : 0] a2[0 : 5];
    reg signed [IN_WIDTH + 10 : 0] a3[0 : 5];
    reg signed [IN_WIDTH + 10 : 0] a4[0 : 5];
    reg signed [IN_WIDTH + 10 : 0] a5[0 : 5];
    reg signed [IN_WIDTH + 10 : 0] a6[0 : 5];
    reg signed [IN_WIDTH + 10 : 0] a7[0 : 5];
    reg signed [IN_WIDTH + 10 : 0] a8[0 : 5];
    reg signed [IN_WIDTH + 10 : 0] a9[0 : 5];
    reg signed [IN_WIDTH + 10 : 0] b[0 : 5];
    reg signed [IN_WIDTH + 10 : 0] c0[0 : 1], c1[0 : 1], c2[0 : 1];
    reg signed [IN_WIDTH + 10 : 0] i_12_d1, i_25_d1;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d1 <= 0;
        for (i = 0; i < 6; i = i + 1) begin
            a0[i] <= 0;
            a1[i] <= 0;
            a2[i] <= 0;
            a3[i] <= 0;
            a4[i] <= 0;
            a5[i] <= 0;
            a6[i] <= 0;
            a7[i] <= 0;
            a8[i] <= 0;
            a9[i] <= 0;
            b[i]  <= 0;
        end
        for (i = 0; i < 2; i = i + 1) begin
            c0[i] <= 0;
            c1[i] <= 0;
            c2[i] <= 0;
        end
        i_12_d1 <= 0; i_25_d1 <= 0;
    end
    else begin
        i_valid_d1 <= i_valid;
        for (i = 0; i < 6; i = i + 1) begin
            a0[i] <= i_data[i]      - i_data[11 - i];
            a1[i] <= i_data[i]      + i_data[13 + i];
            a2[i] <= i_data[i]      + i_data[24 - i];
            a3[i] <= i_data[i]      - i_data[26 + i];
            a4[i] <= i_data[6 + i]  + i_data[18 - i];
            a5[i] <= i_data[6 + i]  + i_data[19 + i];
            a6[i] <= i_data[6 + i]  - i_data[31 - i];
            a7[i] <= i_data[13 + i] - i_data[24 - i];
            a8[i] <= i_data[13 + i] + i_data[26 + i];
            a9[i] <= i_data[19 + i] + i_data[31 - i];
            b[i]  <= i_data[i] + i_data[11 - i] - i_data[13 + i] - i_data[24 - i] + i_data[26 + i];
        end
        for (i = 0; i < 2; i = i + 1) begin
            c0[i] <= i_data[i] + i_data[3 - i] - i_data[5 + i] - i_data[8 - i] + i_data[10 + i];
            c1[i] <= i_data[13 - i] - i_data[15 + i] - i_data[18 - i] + i_data[20 + i] + i_data[23 - i];
            c2[i] <= - i_data[25 + i] - i_data[28 - i] + i_data[30 + i];
        end
        i_12_d1 <= i_data[12]; i_25_d1 <= i_data[25];
    end
end

//mcm
//a0[0] : 4 13 80 68 72
    wire signed [IN_WIDTH + 10 : 0] a0_0 = a0[0];
    wire signed [IN_WIDTH + 10 : 0] a0_0_4 = a0_0 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a0_0_5 = a0_0 + a0_0_4;
    wire signed [IN_WIDTH + 10 : 0] a0_0_8 = a0_0 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a0_0_9 = a0_0 + a0_0_8;
    wire signed [IN_WIDTH + 10 : 0] a0_0_16 = a0_0 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a0_0_17 = a0_0 + a0_0_16;
    wire signed [IN_WIDTH + 10 : 0] a0_0_13 = a0_0_5 + a0_0_8;
    wire signed [IN_WIDTH + 10 : 0] a0_0_80 = a0_0_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a0_0_68 = a0_0_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a0_0_72 = a0_0_9 <<< 3;
//a0[1] : 56 46 80 34 68 26
    wire signed [IN_WIDTH + 10 : 0] a0_1 = a0[1];
    wire signed [IN_WIDTH + 10 : 0] a0_1_4 = a0_1 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a0_1_5 = a0_1 + a0_1_4;
    wire signed [IN_WIDTH + 10 : 0] a0_1_8 = a0_1 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a0_1_7 = a0_1_8 - a0_1;
    wire signed [IN_WIDTH + 10 : 0] a0_1_16 = a0_1 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a0_1_17 = a0_1 + a0_1_16;
    wire signed [IN_WIDTH + 10 : 0] a0_1_13 = a0_1_5 + a0_1_8;
    wire signed [IN_WIDTH + 10 : 0] a0_1_23 = a0_1_7 + a0_1_16;
    wire signed [IN_WIDTH + 10 : 0] a0_1_56 = a0_1_7 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a0_1_46 = a0_1_23 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a0_1_80 = a0_1_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a0_1_34 = a0_1_17 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a0_1_68 = a0_1_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a0_1_26 = a0_1_13 <<< 1;
//a0[2] : 84 60 17 38 78 74
    wire signed [IN_WIDTH + 10 : 0] a0_2 = a0[2];
    wire signed [IN_WIDTH + 10 : 0] a0_2_16 = a0_2 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a0_2_15 = a0_2_16 - a0_2;
    wire signed [IN_WIDTH + 10 : 0] a0_2_17 = a0_2 + a0_2_16;
    wire signed [IN_WIDTH + 10 : 0] a0_2_4 = a0_2 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a0_2_19 = a0_2_15 + a0_2_4;
    wire signed [IN_WIDTH + 10 : 0] a0_2_21 = a0_2_17 + a0_2_4;
    wire signed [IN_WIDTH + 10 : 0] a0_2_38 = a0_2_19 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a0_2_37 = a0_2_38 - a0_2;
    wire signed [IN_WIDTH + 10 : 0] a0_2_39 = a0_2 + a0_2_38;
    wire signed [IN_WIDTH + 10 : 0] a0_2_84 = a0_2_21 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a0_2_60 = a0_2_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a0_2_78 = a0_2_39 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a0_2_74 = a0_2_37 <<< 1;
//a0[3] : 50 9 63 77
    wire signed [IN_WIDTH + 10 : 0] a0_3 = a0[3];
    wire signed [IN_WIDTH + 10 : 0] a0_3_8 = a0_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a0_3_9 = a0_3 + a0_3_8;
    wire signed [IN_WIDTH + 10 : 0] a0_3_64 = a0_3 <<< 6;
    wire signed [IN_WIDTH + 10 : 0] a0_3_63 = a0_3_64 - a0_3;
    wire signed [IN_WIDTH + 10 : 0] a0_3_16 = a0_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a0_3_25 = a0_3_9 + a0_3_16;
    wire signed [IN_WIDTH + 10 : 0] a0_3_4 = a0_3 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a0_3_5 = a0_3 + a0_3_4;
    wire signed [IN_WIDTH + 10 : 0] a0_3_72 = a0_3_9 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a0_3_77 = a0_3_5 + a0_3_72;
    wire signed [IN_WIDTH + 10 : 0] a0_3_50 = a0_3_25 <<< 1;
//a0[4] : 84 60 38 78
    wire signed [IN_WIDTH + 10 : 0] a0_4 = a0[4];
    wire signed [IN_WIDTH + 10 : 0] a0_4_16 = a0_4 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a0_4_15 = a0_4_16 - a0_4;
    wire signed [IN_WIDTH + 10 : 0] a0_4_4 = a0_4 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a0_4_19 = a0_4_15 + a0_4_4;
    wire signed [IN_WIDTH + 10 : 0] a0_4_2 = a0_4 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a0_4_21 = a0_4_19 + a0_4_2;
    wire signed [IN_WIDTH + 10 : 0] a0_4_38 = a0_4_19 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a0_4_39 = a0_4 + a0_4_38;
    wire signed [IN_WIDTH + 10 : 0] a0_4_84 = a0_4_21 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a0_4_60 = a0_4_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a0_4_78 = a0_4_39 <<< 1;
//a0[5] : 46 34 26
    wire signed [IN_WIDTH + 10 : 0] a0_5 = a0[5];
    wire signed [IN_WIDTH + 10 : 0] a0_5_16 = a0_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a0_5_17 = a0_5 + a0_5_16;
    wire signed [IN_WIDTH + 10 : 0] a0_5_4 = a0_5 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a0_5_13 = a0_5_17 - a0_5_4;
    wire signed [IN_WIDTH + 10 : 0] a0_5_3 = a0_5_4 - a0_5;
    wire signed [IN_WIDTH + 10 : 0] a0_5_24 = a0_5_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a0_5_23 = a0_5_24 - a0_5;
    wire signed [IN_WIDTH + 10 : 0] a0_5_46 = a0_5_23 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a0_5_34 = a0_5_17 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a0_5_26 = a0_5_13 <<< 1;
//a1[0] : 50 63 77 30
    wire signed [IN_WIDTH + 10 : 0] a1_0 = a1[0];
    wire signed [IN_WIDTH + 10 : 0] a1_0_16 = a1_0 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a1_0_15 = a1_0_16 - a1_0;
    wire signed [IN_WIDTH + 10 : 0] a1_0_64 = a1_0 <<< 6;
    wire signed [IN_WIDTH + 10 : 0] a1_0_63 = a1_0_64 - a1_0;
    wire signed [IN_WIDTH + 10 : 0] a1_0_4 = a1_0 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a1_0_3 = a1_0_4 - a1_0;
    wire signed [IN_WIDTH + 10 : 0] a1_0_24 = a1_0_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a1_0_25 = a1_0 + a1_0_24;
    wire signed [IN_WIDTH + 10 : 0] a1_0_5 = a1_0 + a1_0_4;
    wire signed [IN_WIDTH + 10 : 0] a1_0_80 = a1_0_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a1_0_77 = a1_0_80 - a1_0_3;
    wire signed [IN_WIDTH + 10 : 0] a1_0_50 = a1_0_25 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a1_0_30 = a1_0_15 <<< 1;
//a1[1] : 84 78 21
    wire signed [IN_WIDTH + 10 : 0] a1_1 = a1[1];
    wire signed [IN_WIDTH + 10 : 0] a1_1_4 = a1_1 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a1_1_3 = a1_1_4 - a1_1;
    wire signed [IN_WIDTH + 10 : 0] a1_1_24 = a1_1_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a1_1_21 = a1_1_24 - a1_1_3;
    wire signed [IN_WIDTH + 10 : 0] a1_1_42 = a1_1_21 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a1_1_39 = a1_1_42 - a1_1_3;
    wire signed [IN_WIDTH + 10 : 0] a1_1_84 = a1_1_21 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a1_1_78 = a1_1_39 <<< 1;
//a1[2] : 56 82 72
    wire signed [IN_WIDTH + 10 : 0] a1_2 = a1[2];
    wire signed [IN_WIDTH + 10 : 0] a1_2_8 = a1_2 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a1_2_7 = a1_2_8 - a1_2;
    wire signed [IN_WIDTH + 10 : 0] a1_2_9 = a1_2 + a1_2_8;
    wire signed [IN_WIDTH + 10 : 0] a1_2_32 = a1_2 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a1_2_41 = a1_2_9 + a1_2_32;
    wire signed [IN_WIDTH + 10 : 0] a1_2_56 = a1_2_7 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a1_2_82 = a1_2_41 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a1_2_72 = a1_2_9 <<< 3;
//a1[3] : 4 56 46 13 80 72
    wire signed [IN_WIDTH + 10 : 0] a1_3 = a1[3];
    wire signed [IN_WIDTH + 10 : 0] a1_3_4 = a1_3 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a1_3_5 = a1_3 + a1_3_4;
    wire signed [IN_WIDTH + 10 : 0] a1_3_8 = a1_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a1_3_7 = a1_3_8 - a1_3;
    wire signed [IN_WIDTH + 10 : 0] a1_3_9 = a1_3 + a1_3_8;
    wire signed [IN_WIDTH + 10 : 0] a1_3_13 = a1_3_5 + a1_3_8;
    wire signed [IN_WIDTH + 10 : 0] a1_3_16 = a1_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a1_3_23 = a1_3_7 + a1_3_16;
    wire signed [IN_WIDTH + 10 : 0] a1_3_56 = a1_3_7 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a1_3_46 = a1_3_23 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a1_3_80 = a1_3_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a1_3_72 = a1_3_9 <<< 3;
//a1[4] : 84 17 66 21 74
    wire signed [IN_WIDTH + 10 : 0] a1_4 = a1[4];
    wire signed [IN_WIDTH + 10 : 0] a1_4_16 = a1_4 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a1_4_17 = a1_4 + a1_4_16;
    wire signed [IN_WIDTH + 10 : 0] a1_4_32 = a1_4 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a1_4_33 = a1_4 + a1_4_32;
    wire signed [IN_WIDTH + 10 : 0] a1_4_4 = a1_4 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a1_4_21 = a1_4_17 + a1_4_4;
    wire signed [IN_WIDTH + 10 : 0] a1_4_37 = a1_4_33 + a1_4_4;
    wire signed [IN_WIDTH + 10 : 0] a1_4_84 = a1_4_21 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a1_4_66 = a1_4_33 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a1_4_74 = a1_4_37 <<< 1;
//a1[5] : 9 63 77 30
    wire signed [IN_WIDTH + 10 : 0] a1_5 = a1[5];
    wire signed [IN_WIDTH + 10 : 0] a1_5_8 = a1_5 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a1_5_9 = a1_5 + a1_5_8;
    wire signed [IN_WIDTH + 10 : 0] a1_5_16 = a1_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a1_5_15 = a1_5_16 - a1_5;
    wire signed [IN_WIDTH + 10 : 0] a1_5_64 = a1_5 <<< 6;
    wire signed [IN_WIDTH + 10 : 0] a1_5_63 = a1_5_64 - a1_5;
    wire signed [IN_WIDTH + 10 : 0] a1_5_4 = a1_5 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a1_5_5 = a1_5 + a1_5_4;
    wire signed [IN_WIDTH + 10 : 0] a1_5_72 = a1_5_9 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a1_5_77 = a1_5_5 + a1_5_72;
    wire signed [IN_WIDTH + 10 : 0] a1_5_30 = a1_5_15 <<< 1;
//a2[0] : 84 42 38 66 21
    wire signed [IN_WIDTH + 10 : 0] a2_0 = a2[0];
    wire signed [IN_WIDTH + 10 : 0] a2_0_32 = a2_0 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a2_0_33 = a2_0 + a2_0_32;
    wire signed [IN_WIDTH + 10 : 0] a2_0_4 = a2_0 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a2_0_3 = a2_0_4 - a2_0;
    wire signed [IN_WIDTH + 10 : 0] a2_0_16 = a2_0 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a2_0_19 = a2_0_3 + a2_0_16;
    wire signed [IN_WIDTH + 10 : 0] a2_0_24 = a2_0_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a2_0_21 = a2_0_24 - a2_0_3;
    wire signed [IN_WIDTH + 10 : 0] a2_0_84 = a2_0_21 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a2_0_42 = a2_0_21 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a2_0_38 = a2_0_19 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a2_0_66 = a2_0_33 <<< 1;
//a2[1] : 4 56 13 68 72
    wire signed [IN_WIDTH + 10 : 0] a2_1 = a2[1];
    wire signed [IN_WIDTH + 10 : 0] a2_1_8 = a2_1 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a2_1_7 = a2_1_8 - a2_1;
    wire signed [IN_WIDTH + 10 : 0] a2_1_9 = a2_1 + a2_1_8;
    wire signed [IN_WIDTH + 10 : 0] a2_1_16 = a2_1 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a2_1_17 = a2_1 + a2_1_16;
    wire signed [IN_WIDTH + 10 : 0] a2_1_14 = a2_1_7 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a2_1_13 = a2_1_14 - a2_1;
    wire signed [IN_WIDTH + 10 : 0] a2_1_4 = a2_1 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a2_1_56 = a2_1_7 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a2_1_68 = a2_1_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a2_1_72 = a2_1_9 <<< 3;
//a2[2] : 50 9 63 77 30
    wire signed [IN_WIDTH + 10 : 0] a2_2 = a2[2];
    wire signed [IN_WIDTH + 10 : 0] a2_2_8 = a2_2 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a2_2_9 = a2_2 + a2_2_8;
    wire signed [IN_WIDTH + 10 : 0] a2_2_16 = a2_2 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a2_2_15 = a2_2_16 - a2_2;
    wire signed [IN_WIDTH + 10 : 0] a2_2_64 = a2_2 <<< 6;
    wire signed [IN_WIDTH + 10 : 0] a2_2_63 = a2_2_64 - a2_2;
    wire signed [IN_WIDTH + 10 : 0] a2_2_25 = a2_2_9 + a2_2_16;
    wire signed [IN_WIDTH + 10 : 0] a2_2_4 = a2_2 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a2_2_5 = a2_2 + a2_2_4;
    wire signed [IN_WIDTH + 10 : 0] a2_2_72 = a2_2_9 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a2_2_77 = a2_2_5 + a2_2_72;
    wire signed [IN_WIDTH + 10 : 0] a2_2_50 = a2_2_25 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a2_2_30 = a2_2_15 <<< 1;
//a2[3] : 56 46 82 13 26
    wire signed [IN_WIDTH + 10 : 0] a2_3 = a2[3];
    wire signed [IN_WIDTH + 10 : 0] a2_3_8 = a2_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a2_3_7 = a2_3_8 - a2_3;
    wire signed [IN_WIDTH + 10 : 0] a2_3_14 = a2_3_7 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a2_3_13 = a2_3_14 - a2_3;
    wire signed [IN_WIDTH + 10 : 0] a2_3_16 = a2_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a2_3_23 = a2_3_7 + a2_3_16;
    wire signed [IN_WIDTH + 10 : 0] a2_3_64 = a2_3 <<< 6;
    wire signed [IN_WIDTH + 10 : 0] a2_3_41 = a2_3_64 - a2_3_23;
    wire signed [IN_WIDTH + 10 : 0] a2_3_56 = a2_3_7 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a2_3_46 = a2_3_23 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a2_3_82 = a2_3_41 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a2_3_26 = a2_3_13 <<< 1;
//a2[4] : 60 42 38 66 74
    wire signed [IN_WIDTH + 10 : 0] a2_4 = a2[4];
    wire signed [IN_WIDTH + 10 : 0] a2_4_16 = a2_4 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a2_4_15 = a2_4_16 - a2_4;
    wire signed [IN_WIDTH + 10 : 0] a2_4_32 = a2_4 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a2_4_33 = a2_4 + a2_4_32;
    wire signed [IN_WIDTH + 10 : 0] a2_4_4 = a2_4 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a2_4_19 = a2_4_15 + a2_4_4;
    wire signed [IN_WIDTH + 10 : 0] a2_4_37 = a2_4_33 + a2_4_4;
    wire signed [IN_WIDTH + 10 : 0] a2_4_2 = a2_4 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a2_4_21 = a2_4_19 + a2_4_2;
    wire signed [IN_WIDTH + 10 : 0] a2_4_60 = a2_4_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a2_4_42 = a2_4_21 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a2_4_38 = a2_4_19 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a2_4_66 = a2_4_33 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a2_4_74 = a2_4_37 <<< 1;
//a2[5] : 60 17 38 74
    wire signed [IN_WIDTH + 10 : 0] a2_5 = a2[5];
    wire signed [IN_WIDTH + 10 : 0] a2_5_16 = a2_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a2_5_15 = a2_5_16 - a2_5;
    wire signed [IN_WIDTH + 10 : 0] a2_5_17 = a2_5 + a2_5_16;
    wire signed [IN_WIDTH + 10 : 0] a2_5_4 = a2_5 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a2_5_19 = a2_5_15 + a2_5_4;
    wire signed [IN_WIDTH + 10 : 0] a2_5_38 = a2_5_19 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a2_5_37 = a2_5_38 - a2_5;
    wire signed [IN_WIDTH + 10 : 0] a2_5_60 = a2_5_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a2_5_74 = a2_5_37 <<< 1;
//a3[0] : 4 56 46 13 80 34
    wire signed [IN_WIDTH + 10 : 0] a3_0 = a3[0];
    wire signed [IN_WIDTH + 10 : 0] a3_0_4 = a3_0 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a3_0_5 = a3_0 + a3_0_4;
    wire signed [IN_WIDTH + 10 : 0] a3_0_8 = a3_0 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a3_0_7 = a3_0_8 - a3_0;
    wire signed [IN_WIDTH + 10 : 0] a3_0_16 = a3_0 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a3_0_17 = a3_0 + a3_0_16;
    wire signed [IN_WIDTH + 10 : 0] a3_0_13 = a3_0_5 + a3_0_8;
    wire signed [IN_WIDTH + 10 : 0] a3_0_23 = a3_0_7 + a3_0_16;
    wire signed [IN_WIDTH + 10 : 0] a3_0_56 = a3_0_7 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a3_0_46 = a3_0_23 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a3_0_80 = a3_0_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a3_0_34 = a3_0_17 <<< 1;
//a3[1] : 50 9 77 30
    wire signed [IN_WIDTH + 10 : 0] a3_1 = a3[1];
    wire signed [IN_WIDTH + 10 : 0] a3_1_8 = a3_1 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a3_1_9 = a3_1 + a3_1_8;
    wire signed [IN_WIDTH + 10 : 0] a3_1_16 = a3_1 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a3_1_15 = a3_1_16 - a3_1;
    wire signed [IN_WIDTH + 10 : 0] a3_1_25 = a3_1_9 + a3_1_16;
    wire signed [IN_WIDTH + 10 : 0] a3_1_4 = a3_1 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a3_1_5 = a3_1 + a3_1_4;
    wire signed [IN_WIDTH + 10 : 0] a3_1_72 = a3_1_9 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a3_1_77 = a3_1_5 + a3_1_72;
    wire signed [IN_WIDTH + 10 : 0] a3_1_50 = a3_1_25 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a3_1_30 = a3_1_15 <<< 1;
//a3[2] : 4 56 46 13 34 26
    wire signed [IN_WIDTH + 10 : 0] a3_2 = a3[2];
    wire signed [IN_WIDTH + 10 : 0] a3_2_8 = a3_2 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a3_2_7 = a3_2_8 - a3_2;
    wire signed [IN_WIDTH + 10 : 0] a3_2_16 = a3_2 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a3_2_17 = a3_2 + a3_2_16;
    wire signed [IN_WIDTH + 10 : 0] a3_2_14 = a3_2_7 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a3_2_13 = a3_2_14 - a3_2;
    wire signed [IN_WIDTH + 10 : 0] a3_2_23 = a3_2_7 + a3_2_16;
    wire signed [IN_WIDTH + 10 : 0] a3_2_4 = a3_2 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a3_2_56 = a3_2_7 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a3_2_46 = a3_2_23 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a3_2_34 = a3_2_17 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a3_2_26 = a3_2_13 <<< 1;
//a3[3] : 84 60 42 17 78
    wire signed [IN_WIDTH + 10 : 0] a3_3 = a3[3];
    wire signed [IN_WIDTH + 10 : 0] a3_3_16 = a3_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a3_3_15 = a3_3_16 - a3_3;
    wire signed [IN_WIDTH + 10 : 0] a3_3_17 = a3_3 + a3_3_16;
    wire signed [IN_WIDTH + 10 : 0] a3_3_4 = a3_3 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a3_3_21 = a3_3_17 + a3_3_4;
    wire signed [IN_WIDTH + 10 : 0] a3_3_60 = a3_3_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a3_3_39 = a3_3_60 - a3_3_21;
    wire signed [IN_WIDTH + 10 : 0] a3_3_84 = a3_3_21 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a3_3_42 = a3_3_21 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a3_3_78 = a3_3_39 <<< 1;
//a3[4] : 60 17 78 21
    wire signed [IN_WIDTH + 10 : 0] a3_4 = a3[4];
    wire signed [IN_WIDTH + 10 : 0] a3_4_16 = a3_4 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a3_4_15 = a3_4_16 - a3_4;
    wire signed [IN_WIDTH + 10 : 0] a3_4_17 = a3_4 + a3_4_16;
    wire signed [IN_WIDTH + 10 : 0] a3_4_4 = a3_4 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a3_4_21 = a3_4_17 + a3_4_4;
    wire signed [IN_WIDTH + 10 : 0] a3_4_60 = a3_4_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a3_4_39 = a3_4_60 - a3_4_21;
    wire signed [IN_WIDTH + 10 : 0] a3_4_78 = a3_4_39 <<< 1;
//a3[5] : 4 46 82 80 68 26 72
    wire signed [IN_WIDTH + 10 : 0] a3_5 = a3[5];
    wire signed [IN_WIDTH + 10 : 0] a3_5_4 = a3_5 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a3_5_5 = a3_5 + a3_5_4;
    wire signed [IN_WIDTH + 10 : 0] a3_5_8 = a3_5 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a3_5_9 = a3_5 + a3_5_8;
    wire signed [IN_WIDTH + 10 : 0] a3_5_16 = a3_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a3_5_17 = a3_5 + a3_5_16;
    wire signed [IN_WIDTH + 10 : 0] a3_5_13 = a3_5_5 + a3_5_8;
    wire signed [IN_WIDTH + 10 : 0] a3_5_32 = a3_5 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a3_5_23 = a3_5_32 - a3_5_9;
    wire signed [IN_WIDTH + 10 : 0] a3_5_40 = a3_5_5 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a3_5_41 = a3_5 + a3_5_40;
    wire signed [IN_WIDTH + 10 : 0] a3_5_46 = a3_5_23 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a3_5_82 = a3_5_41 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a3_5_80 = a3_5_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a3_5_68 = a3_5_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a3_5_26 = a3_5_13 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a3_5_72 = a3_5_9 <<< 3;
//a4[0] : 13 34 68
    wire signed [IN_WIDTH + 10 : 0] a4_0 = a4[0];
    wire signed [IN_WIDTH + 10 : 0] a4_0_16 = a4_0 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a4_0_17 = a4_0 + a4_0_16;
    wire signed [IN_WIDTH + 10 : 0] a4_0_4 = a4_0 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a4_0_13 = a4_0_17 - a4_0_4;
    wire signed [IN_WIDTH + 10 : 0] a4_0_34 = a4_0_17 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a4_0_68 = a4_0_17 <<< 2;
//a4[1] : 50 9 77 30
    wire signed [IN_WIDTH + 10 : 0] a4_1 = a4[1];
    wire signed [IN_WIDTH + 10 : 0] a4_1_8 = a4_1 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a4_1_9 = a4_1 + a4_1_8;
    wire signed [IN_WIDTH + 10 : 0] a4_1_16 = a4_1 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a4_1_15 = a4_1_16 - a4_1;
    wire signed [IN_WIDTH + 10 : 0] a4_1_25 = a4_1_9 + a4_1_16;
    wire signed [IN_WIDTH + 10 : 0] a4_1_4 = a4_1 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a4_1_5 = a4_1 + a4_1_4;
    wire signed [IN_WIDTH + 10 : 0] a4_1_72 = a4_1_9 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a4_1_77 = a4_1_5 + a4_1_72;
    wire signed [IN_WIDTH + 10 : 0] a4_1_50 = a4_1_25 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a4_1_30 = a4_1_15 <<< 1;
//a4[2] : 4 56 80 34 26
    wire signed [IN_WIDTH + 10 : 0] a4_2 = a4[2];
    wire signed [IN_WIDTH + 10 : 0] a4_2_4 = a4_2 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a4_2_5 = a4_2 + a4_2_4;
    wire signed [IN_WIDTH + 10 : 0] a4_2_8 = a4_2 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a4_2_7 = a4_2_8 - a4_2;
    wire signed [IN_WIDTH + 10 : 0] a4_2_16 = a4_2 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a4_2_17 = a4_2 + a4_2_16;
    wire signed [IN_WIDTH + 10 : 0] a4_2_13 = a4_2_5 + a4_2_8;
    wire signed [IN_WIDTH + 10 : 0] a4_2_56 = a4_2_7 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a4_2_80 = a4_2_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a4_2_34 = a4_2_17 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a4_2_26 = a4_2_13 <<< 1;
//a4[3] : 38 66 78
    wire signed [IN_WIDTH + 10 : 0] a4_3 = a4[3];
    wire signed [IN_WIDTH + 10 : 0] a4_3_32 = a4_3 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a4_3_33 = a4_3 + a4_3_32;
    wire signed [IN_WIDTH + 10 : 0] a4_3_4 = a4_3 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a4_3_3 = a4_3_4 - a4_3;
    wire signed [IN_WIDTH + 10 : 0] a4_3_16 = a4_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a4_3_19 = a4_3_3 + a4_3_16;
    wire signed [IN_WIDTH + 10 : 0] a4_3_6 = a4_3_3 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a4_3_39 = a4_3_33 + a4_3_6;
    wire signed [IN_WIDTH + 10 : 0] a4_3_38 = a4_3_19 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a4_3_66 = a4_3_33 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a4_3_78 = a4_3_39 <<< 1;
//a4[4] : 60 42 38 21 74
    wire signed [IN_WIDTH + 10 : 0] a4_4 = a4[4];
    wire signed [IN_WIDTH + 10 : 0] a4_4_16 = a4_4 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a4_4_15 = a4_4_16 - a4_4;
    wire signed [IN_WIDTH + 10 : 0] a4_4_4 = a4_4 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a4_4_19 = a4_4_15 + a4_4_4;
    wire signed [IN_WIDTH + 10 : 0] a4_4_2 = a4_4 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a4_4_21 = a4_4_19 + a4_4_2;
    wire signed [IN_WIDTH + 10 : 0] a4_4_38 = a4_4_19 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a4_4_37 = a4_4_38 - a4_4;
    wire signed [IN_WIDTH + 10 : 0] a4_4_60 = a4_4_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a4_4_42 = a4_4_21 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a4_4_74 = a4_4_37 <<< 1;
//a4[5] : 80 34 26 72
    wire signed [IN_WIDTH + 10 : 0] a4_5 = a4[5];
    wire signed [IN_WIDTH + 10 : 0] a4_5_4 = a4_5 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a4_5_5 = a4_5 + a4_5_4;
    wire signed [IN_WIDTH + 10 : 0] a4_5_8 = a4_5 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a4_5_9 = a4_5 + a4_5_8;
    wire signed [IN_WIDTH + 10 : 0] a4_5_16 = a4_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a4_5_17 = a4_5 + a4_5_16;
    wire signed [IN_WIDTH + 10 : 0] a4_5_13 = a4_5_5 + a4_5_8;
    wire signed [IN_WIDTH + 10 : 0] a4_5_80 = a4_5_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a4_5_34 = a4_5_17 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a4_5_26 = a4_5_13 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a4_5_72 = a4_5_9 <<< 3;
//a5[0] : 66 78 21
    wire signed [IN_WIDTH + 10 : 0] a5_0 = a5[0];
    wire signed [IN_WIDTH + 10 : 0] a5_0_32 = a5_0 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a5_0_33 = a5_0 + a5_0_32;
    wire signed [IN_WIDTH + 10 : 0] a5_0_4 = a5_0 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a5_0_3 = a5_0_4 - a5_0;
    wire signed [IN_WIDTH + 10 : 0] a5_0_24 = a5_0_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a5_0_21 = a5_0_24 - a5_0_3;
    wire signed [IN_WIDTH + 10 : 0] a5_0_6 = a5_0_3 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a5_0_39 = a5_0_33 + a5_0_6;
    wire signed [IN_WIDTH + 10 : 0] a5_0_66 = a5_0_33 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a5_0_78 = a5_0_39 <<< 1;
//a5[1] : 56 46 82 80 26
    wire signed [IN_WIDTH + 10 : 0] a5_1 = a5[1];
    wire signed [IN_WIDTH + 10 : 0] a5_1_4 = a5_1 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a5_1_5 = a5_1 + a5_1_4;
    wire signed [IN_WIDTH + 10 : 0] a5_1_8 = a5_1 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a5_1_7 = a5_1_8 - a5_1;
    wire signed [IN_WIDTH + 10 : 0] a5_1_13 = a5_1_5 + a5_1_8;
    wire signed [IN_WIDTH + 10 : 0] a5_1_16 = a5_1 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a5_1_23 = a5_1_7 + a5_1_16;
    wire signed [IN_WIDTH + 10 : 0] a5_1_40 = a5_1_5 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a5_1_41 = a5_1 + a5_1_40;
    wire signed [IN_WIDTH + 10 : 0] a5_1_56 = a5_1_7 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a5_1_46 = a5_1_23 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a5_1_82 = a5_1_41 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a5_1_80 = a5_1_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a5_1_26 = a5_1_13 <<< 1;
//a5[2] : 4 82 68 72
    wire signed [IN_WIDTH + 10 : 0] a5_2 = a5[2];
    wire signed [IN_WIDTH + 10 : 0] a5_2_8 = a5_2 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a5_2_9 = a5_2 + a5_2_8;
    wire signed [IN_WIDTH + 10 : 0] a5_2_16 = a5_2 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a5_2_17 = a5_2 + a5_2_16;
    wire signed [IN_WIDTH + 10 : 0] a5_2_32 = a5_2 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a5_2_41 = a5_2_9 + a5_2_32;
    wire signed [IN_WIDTH + 10 : 0] a5_2_4 = a5_2 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a5_2_82 = a5_2_41 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a5_2_68 = a5_2_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a5_2_72 = a5_2_9 <<< 3;
//a5[3] : 60 42 17 38 66 21
    wire signed [IN_WIDTH + 10 : 0] a5_3 = a5[3];
    wire signed [IN_WIDTH + 10 : 0] a5_3_16 = a5_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a5_3_15 = a5_3_16 - a5_3;
    wire signed [IN_WIDTH + 10 : 0] a5_3_17 = a5_3 + a5_3_16;
    wire signed [IN_WIDTH + 10 : 0] a5_3_32 = a5_3 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a5_3_33 = a5_3 + a5_3_32;
    wire signed [IN_WIDTH + 10 : 0] a5_3_4 = a5_3 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a5_3_19 = a5_3_15 + a5_3_4;
    wire signed [IN_WIDTH + 10 : 0] a5_3_21 = a5_3_17 + a5_3_4;
    wire signed [IN_WIDTH + 10 : 0] a5_3_60 = a5_3_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a5_3_42 = a5_3_21 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a5_3_38 = a5_3_19 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a5_3_66 = a5_3_33 <<< 1;
//a5[4] : 50 9 63 77 30
    wire signed [IN_WIDTH + 10 : 0] a5_4 = a5[4];
    wire signed [IN_WIDTH + 10 : 0] a5_4_8 = a5_4 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a5_4_9 = a5_4 + a5_4_8;
    wire signed [IN_WIDTH + 10 : 0] a5_4_16 = a5_4 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a5_4_15 = a5_4_16 - a5_4;
    wire signed [IN_WIDTH + 10 : 0] a5_4_64 = a5_4 <<< 6;
    wire signed [IN_WIDTH + 10 : 0] a5_4_63 = a5_4_64 - a5_4;
    wire signed [IN_WIDTH + 10 : 0] a5_4_25 = a5_4_9 + a5_4_16;
    wire signed [IN_WIDTH + 10 : 0] a5_4_4 = a5_4 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a5_4_5 = a5_4 + a5_4_4;
    wire signed [IN_WIDTH + 10 : 0] a5_4_72 = a5_4_9 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a5_4_77 = a5_4_5 + a5_4_72;
    wire signed [IN_WIDTH + 10 : 0] a5_4_50 = a5_4_25 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a5_4_30 = a5_4_15 <<< 1;
//a5[5] : 42 38 78 74
    wire signed [IN_WIDTH + 10 : 0] a5_5 = a5[5];
    wire signed [IN_WIDTH + 10 : 0] a5_5_4 = a5_5 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a5_5_3 = a5_5_4 - a5_5;
    wire signed [IN_WIDTH + 10 : 0] a5_5_16 = a5_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a5_5_19 = a5_5_3 + a5_5_16;
    wire signed [IN_WIDTH + 10 : 0] a5_5_24 = a5_5_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a5_5_21 = a5_5_24 - a5_5_3;
    wire signed [IN_WIDTH + 10 : 0] a5_5_38 = a5_5_19 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a5_5_37 = a5_5_38 - a5_5;
    wire signed [IN_WIDTH + 10 : 0] a5_5_39 = a5_5 + a5_5_38;
    wire signed [IN_WIDTH + 10 : 0] a5_5_42 = a5_5_21 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a5_5_78 = a5_5_39 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a5_5_74 = a5_5_37 <<< 1;
//a6[0] : 50 9 63 77 30
    wire signed [IN_WIDTH + 10 : 0] a6_0 = a6[0];
    wire signed [IN_WIDTH + 10 : 0] a6_0_8 = a6_0 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a6_0_9 = a6_0 + a6_0_8;
    wire signed [IN_WIDTH + 10 : 0] a6_0_16 = a6_0 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a6_0_15 = a6_0_16 - a6_0;
    wire signed [IN_WIDTH + 10 : 0] a6_0_64 = a6_0 <<< 6;
    wire signed [IN_WIDTH + 10 : 0] a6_0_63 = a6_0_64 - a6_0;
    wire signed [IN_WIDTH + 10 : 0] a6_0_25 = a6_0_9 + a6_0_16;
    wire signed [IN_WIDTH + 10 : 0] a6_0_4 = a6_0 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a6_0_5 = a6_0 + a6_0_4;
    wire signed [IN_WIDTH + 10 : 0] a6_0_72 = a6_0_9 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a6_0_77 = a6_0_5 + a6_0_72;
    wire signed [IN_WIDTH + 10 : 0] a6_0_50 = a6_0_25 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a6_0_30 = a6_0_15 <<< 1;
//a6[1] : 4 46 82 34
    wire signed [IN_WIDTH + 10 : 0] a6_1 = a6[1];
    wire signed [IN_WIDTH + 10 : 0] a6_1_16 = a6_1 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a6_1_17 = a6_1 + a6_1_16;
    wire signed [IN_WIDTH + 10 : 0] a6_1_4 = a6_1 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a6_1_3 = a6_1_4 - a6_1;
    wire signed [IN_WIDTH + 10 : 0] a6_1_24 = a6_1_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a6_1_23 = a6_1_24 - a6_1;
    wire signed [IN_WIDTH + 10 : 0] a6_1_41 = a6_1_17 + a6_1_24;
    wire signed [IN_WIDTH + 10 : 0] a6_1_46 = a6_1_23 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a6_1_82 = a6_1_41 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a6_1_34 = a6_1_17 <<< 1;
//a6[2] : 84 38 66 21
    wire signed [IN_WIDTH + 10 : 0] a6_2 = a6[2];
    wire signed [IN_WIDTH + 10 : 0] a6_2_32 = a6_2 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a6_2_33 = a6_2 + a6_2_32;
    wire signed [IN_WIDTH + 10 : 0] a6_2_4 = a6_2 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a6_2_3 = a6_2_4 - a6_2;
    wire signed [IN_WIDTH + 10 : 0] a6_2_16 = a6_2 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a6_2_19 = a6_2_3 + a6_2_16;
    wire signed [IN_WIDTH + 10 : 0] a6_2_24 = a6_2_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a6_2_21 = a6_2_24 - a6_2_3;
    wire signed [IN_WIDTH + 10 : 0] a6_2_84 = a6_2_21 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a6_2_38 = a6_2_19 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a6_2_66 = a6_2_33 <<< 1;
//a6[3] : 84 42 17 66 78 21
    wire signed [IN_WIDTH + 10 : 0] a6_3 = a6[3];
    wire signed [IN_WIDTH + 10 : 0] a6_3_16 = a6_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a6_3_17 = a6_3 + a6_3_16;
    wire signed [IN_WIDTH + 10 : 0] a6_3_32 = a6_3 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a6_3_33 = a6_3 + a6_3_32;
    wire signed [IN_WIDTH + 10 : 0] a6_3_4 = a6_3 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a6_3_21 = a6_3_17 + a6_3_4;
    wire signed [IN_WIDTH + 10 : 0] a6_3_3 = a6_3_4 - a6_3;
    wire signed [IN_WIDTH + 10 : 0] a6_3_6 = a6_3_3 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a6_3_39 = a6_3_33 + a6_3_6;
    wire signed [IN_WIDTH + 10 : 0] a6_3_84 = a6_3_21 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a6_3_42 = a6_3_21 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a6_3_66 = a6_3_33 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a6_3_78 = a6_3_39 <<< 1;
//a6[4] : 46 82 13 34 26 72
    wire signed [IN_WIDTH + 10 : 0] a6_4 = a6[4];
    wire signed [IN_WIDTH + 10 : 0] a6_4_8 = a6_4 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a6_4_9 = a6_4 + a6_4_8;
    wire signed [IN_WIDTH + 10 : 0] a6_4_16 = a6_4 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a6_4_17 = a6_4 + a6_4_16;
    wire signed [IN_WIDTH + 10 : 0] a6_4_4 = a6_4 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a6_4_13 = a6_4_9 + a6_4_4;
    wire signed [IN_WIDTH + 10 : 0] a6_4_32 = a6_4 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a6_4_23 = a6_4_32 - a6_4_9;
    wire signed [IN_WIDTH + 10 : 0] a6_4_41 = a6_4_9 + a6_4_32;
    wire signed [IN_WIDTH + 10 : 0] a6_4_46 = a6_4_23 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a6_4_82 = a6_4_41 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a6_4_34 = a6_4_17 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a6_4_26 = a6_4_13 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a6_4_72 = a6_4_9 <<< 3;
//a6[5] : 50 9 63 30
    wire signed [IN_WIDTH + 10 : 0] a6_5 = a6[5];
    wire signed [IN_WIDTH + 10 : 0] a6_5_8 = a6_5 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a6_5_9 = a6_5 + a6_5_8;
    wire signed [IN_WIDTH + 10 : 0] a6_5_16 = a6_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a6_5_15 = a6_5_16 - a6_5;
    wire signed [IN_WIDTH + 10 : 0] a6_5_64 = a6_5 <<< 6;
    wire signed [IN_WIDTH + 10 : 0] a6_5_63 = a6_5_64 - a6_5;
    wire signed [IN_WIDTH + 10 : 0] a6_5_25 = a6_5_9 + a6_5_16;
    wire signed [IN_WIDTH + 10 : 0] a6_5_50 = a6_5_25 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a6_5_30 = a6_5_15 <<< 1;
//a7[0] : 17 78 21 74
    wire signed [IN_WIDTH + 10 : 0] a7_0 = a7[0];
    wire signed [IN_WIDTH + 10 : 0] a7_0_16 = a7_0 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a7_0_17 = a7_0 + a7_0_16;
    wire signed [IN_WIDTH + 10 : 0] a7_0_4 = a7_0 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a7_0_21 = a7_0_17 + a7_0_4;
    wire signed [IN_WIDTH + 10 : 0] a7_0_37 = a7_0_21 + a7_0_16;
    wire signed [IN_WIDTH + 10 : 0] a7_0_2 = a7_0 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a7_0_39 = a7_0_37 + a7_0_2;
    wire signed [IN_WIDTH + 10 : 0] a7_0_78 = a7_0_39 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a7_0_74 = a7_0_37 <<< 1;
//a7[1] : 84 42 17 74
    wire signed [IN_WIDTH + 10 : 0] a7_1 = a7[1];
    wire signed [IN_WIDTH + 10 : 0] a7_1_16 = a7_1 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a7_1_17 = a7_1 + a7_1_16;
    wire signed [IN_WIDTH + 10 : 0] a7_1_4 = a7_1 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a7_1_21 = a7_1_17 + a7_1_4;
    wire signed [IN_WIDTH + 10 : 0] a7_1_37 = a7_1_21 + a7_1_16;
    wire signed [IN_WIDTH + 10 : 0] a7_1_84 = a7_1_21 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a7_1_42 = a7_1_21 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a7_1_74 = a7_1_37 <<< 1;
//a7[2] : 46 80 68
    wire signed [IN_WIDTH + 10 : 0] a7_2 = a7[2];
    wire signed [IN_WIDTH + 10 : 0] a7_2_4 = a7_2 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a7_2_5 = a7_2 + a7_2_4;
    wire signed [IN_WIDTH + 10 : 0] a7_2_16 = a7_2 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a7_2_17 = a7_2 + a7_2_16;
    wire signed [IN_WIDTH + 10 : 0] a7_2_40 = a7_2_5 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a7_2_23 = a7_2_40 - a7_2_17;
    wire signed [IN_WIDTH + 10 : 0] a7_2_46 = a7_2_23 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a7_2_80 = a7_2_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a7_2_68 = a7_2_17 <<< 2;
//a7[3] : 50 9 63 30
    wire signed [IN_WIDTH + 10 : 0] a7_3 = a7[3];
    wire signed [IN_WIDTH + 10 : 0] a7_3_8 = a7_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a7_3_9 = a7_3 + a7_3_8;
    wire signed [IN_WIDTH + 10 : 0] a7_3_16 = a7_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a7_3_15 = a7_3_16 - a7_3;
    wire signed [IN_WIDTH + 10 : 0] a7_3_64 = a7_3 <<< 6;
    wire signed [IN_WIDTH + 10 : 0] a7_3_63 = a7_3_64 - a7_3;
    wire signed [IN_WIDTH + 10 : 0] a7_3_25 = a7_3_9 + a7_3_16;
    wire signed [IN_WIDTH + 10 : 0] a7_3_50 = a7_3_25 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a7_3_30 = a7_3_15 <<< 1;
//a7[4] : 4 82 13 68 26 72
    wire signed [IN_WIDTH + 10 : 0] a7_4 = a7[4];
    wire signed [IN_WIDTH + 10 : 0] a7_4_8 = a7_4 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a7_4_9 = a7_4 + a7_4_8;
    wire signed [IN_WIDTH + 10 : 0] a7_4_16 = a7_4 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a7_4_17 = a7_4 + a7_4_16;
    wire signed [IN_WIDTH + 10 : 0] a7_4_4 = a7_4 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a7_4_13 = a7_4_9 + a7_4_4;
    wire signed [IN_WIDTH + 10 : 0] a7_4_32 = a7_4 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a7_4_41 = a7_4_9 + a7_4_32;
    wire signed [IN_WIDTH + 10 : 0] a7_4_82 = a7_4_41 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a7_4_68 = a7_4_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a7_4_26 = a7_4_13 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a7_4_72 = a7_4_9 <<< 3;
//a7[5] : 42 17 38 21
    wire signed [IN_WIDTH + 10 : 0] a7_5 = a7[5];
    wire signed [IN_WIDTH + 10 : 0] a7_5_16 = a7_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a7_5_17 = a7_5 + a7_5_16;
    wire signed [IN_WIDTH + 10 : 0] a7_5_2 = a7_5 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a7_5_19 = a7_5_17 + a7_5_2;
    wire signed [IN_WIDTH + 10 : 0] a7_5_4 = a7_5 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a7_5_21 = a7_5_17 + a7_5_4;
    wire signed [IN_WIDTH + 10 : 0] a7_5_42 = a7_5_21 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a7_5_38 = a7_5_19 <<< 1;
//a8[0] : 56 82 13 68 26
    wire signed [IN_WIDTH + 10 : 0] a8_0 = a8[0];
    wire signed [IN_WIDTH + 10 : 0] a8_0_8 = a8_0 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a8_0_7 = a8_0_8 - a8_0;
    wire signed [IN_WIDTH + 10 : 0] a8_0_16 = a8_0 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a8_0_17 = a8_0 + a8_0_16;
    wire signed [IN_WIDTH + 10 : 0] a8_0_14 = a8_0_7 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a8_0_13 = a8_0_14 - a8_0;
    wire signed [IN_WIDTH + 10 : 0] a8_0_34 = a8_0_17 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a8_0_41 = a8_0_7 + a8_0_34;
    wire signed [IN_WIDTH + 10 : 0] a8_0_56 = a8_0_7 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a8_0_82 = a8_0_41 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a8_0_68 = a8_0_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a8_0_26 = a8_0_13 <<< 1;
//a8[1] : 60 66 74
    wire signed [IN_WIDTH + 10 : 0] a8_1 = a8[1];
    wire signed [IN_WIDTH + 10 : 0] a8_1_16 = a8_1 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a8_1_15 = a8_1_16 - a8_1;
    wire signed [IN_WIDTH + 10 : 0] a8_1_32 = a8_1 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a8_1_33 = a8_1 + a8_1_32;
    wire signed [IN_WIDTH + 10 : 0] a8_1_4 = a8_1 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a8_1_37 = a8_1_33 + a8_1_4;
    wire signed [IN_WIDTH + 10 : 0] a8_1_60 = a8_1_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a8_1_66 = a8_1_33 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a8_1_74 = a8_1_37 <<< 1;
//a8[2] : 50 63 77
    wire signed [IN_WIDTH + 10 : 0] a8_2 = a8[2];
    wire signed [IN_WIDTH + 10 : 0] a8_2_64 = a8_2 <<< 6;
    wire signed [IN_WIDTH + 10 : 0] a8_2_63 = a8_2_64 - a8_2;
    wire signed [IN_WIDTH + 10 : 0] a8_2_4 = a8_2 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a8_2_3 = a8_2_4 - a8_2;
    wire signed [IN_WIDTH + 10 : 0] a8_2_24 = a8_2_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a8_2_25 = a8_2 + a8_2_24;
    wire signed [IN_WIDTH + 10 : 0] a8_2_5 = a8_2 + a8_2_4;
    wire signed [IN_WIDTH + 10 : 0] a8_2_80 = a8_2_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a8_2_77 = a8_2_80 - a8_2_3;
    wire signed [IN_WIDTH + 10 : 0] a8_2_50 = a8_2_25 <<< 1;
//a8[3] : 84 42 17 66 74
    wire signed [IN_WIDTH + 10 : 0] a8_3 = a8[3];
    wire signed [IN_WIDTH + 10 : 0] a8_3_16 = a8_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a8_3_17 = a8_3 + a8_3_16;
    wire signed [IN_WIDTH + 10 : 0] a8_3_32 = a8_3 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a8_3_33 = a8_3 + a8_3_32;
    wire signed [IN_WIDTH + 10 : 0] a8_3_4 = a8_3 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a8_3_21 = a8_3_17 + a8_3_4;
    wire signed [IN_WIDTH + 10 : 0] a8_3_37 = a8_3_33 + a8_3_4;
    wire signed [IN_WIDTH + 10 : 0] a8_3_84 = a8_3_21 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a8_3_42 = a8_3_21 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a8_3_66 = a8_3_33 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a8_3_74 = a8_3_37 <<< 1;
//a8[4] : 56 46 34 68 72
    wire signed [IN_WIDTH + 10 : 0] a8_4 = a8[4];
    wire signed [IN_WIDTH + 10 : 0] a8_4_8 = a8_4 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a8_4_7 = a8_4_8 - a8_4;
    wire signed [IN_WIDTH + 10 : 0] a8_4_9 = a8_4 + a8_4_8;
    wire signed [IN_WIDTH + 10 : 0] a8_4_16 = a8_4 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a8_4_17 = a8_4 + a8_4_16;
    wire signed [IN_WIDTH + 10 : 0] a8_4_23 = a8_4_7 + a8_4_16;
    wire signed [IN_WIDTH + 10 : 0] a8_4_56 = a8_4_7 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a8_4_46 = a8_4_23 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a8_4_34 = a8_4_17 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a8_4_68 = a8_4_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a8_4_72 = a8_4_9 <<< 3;
//a8[5] : 56 82 13 80 34 68 72
    wire signed [IN_WIDTH + 10 : 0] a8_5 = a8[5];
    wire signed [IN_WIDTH + 10 : 0] a8_5_4 = a8_5 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a8_5_5 = a8_5 + a8_5_4;
    wire signed [IN_WIDTH + 10 : 0] a8_5_8 = a8_5 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a8_5_7 = a8_5_8 - a8_5;
    wire signed [IN_WIDTH + 10 : 0] a8_5_9 = a8_5 + a8_5_8;
    wire signed [IN_WIDTH + 10 : 0] a8_5_16 = a8_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a8_5_17 = a8_5 + a8_5_16;
    wire signed [IN_WIDTH + 10 : 0] a8_5_13 = a8_5_5 + a8_5_8;
    wire signed [IN_WIDTH + 10 : 0] a8_5_40 = a8_5_5 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a8_5_41 = a8_5 + a8_5_40;
    wire signed [IN_WIDTH + 10 : 0] a8_5_56 = a8_5_7 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a8_5_82 = a8_5_41 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a8_5_80 = a8_5_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a8_5_34 = a8_5_17 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a8_5_68 = a8_5_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a8_5_72 = a8_5_9 <<< 3;
//a9[0] : 84 60 42 66 78 21 74
    wire signed [IN_WIDTH + 10 : 0] a9_0 = a9[0];
    wire signed [IN_WIDTH + 10 : 0] a9_0_16 = a9_0 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a9_0_15 = a9_0_16 - a9_0;
    wire signed [IN_WIDTH + 10 : 0] a9_0_32 = a9_0 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a9_0_33 = a9_0 + a9_0_32;
    wire signed [IN_WIDTH + 10 : 0] a9_0_4 = a9_0 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a9_0_37 = a9_0_33 + a9_0_4;
    wire signed [IN_WIDTH + 10 : 0] a9_0_21 = a9_0_37 - a9_0_16;
    wire signed [IN_WIDTH + 10 : 0] a9_0_2 = a9_0 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a9_0_39 = a9_0_37 + a9_0_2;
    wire signed [IN_WIDTH + 10 : 0] a9_0_84 = a9_0_21 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a9_0_60 = a9_0_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a9_0_42 = a9_0_21 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a9_0_66 = a9_0_33 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a9_0_78 = a9_0_39 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a9_0_74 = a9_0_37 <<< 1;
//a9[1] : 9 63 77 30
    wire signed [IN_WIDTH + 10 : 0] a9_1 = a9[1];
    wire signed [IN_WIDTH + 10 : 0] a9_1_8 = a9_1 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a9_1_9 = a9_1 + a9_1_8;
    wire signed [IN_WIDTH + 10 : 0] a9_1_16 = a9_1 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a9_1_15 = a9_1_16 - a9_1;
    wire signed [IN_WIDTH + 10 : 0] a9_1_64 = a9_1 <<< 6;
    wire signed [IN_WIDTH + 10 : 0] a9_1_63 = a9_1_64 - a9_1;
    wire signed [IN_WIDTH + 10 : 0] a9_1_4 = a9_1 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a9_1_5 = a9_1 + a9_1_4;
    wire signed [IN_WIDTH + 10 : 0] a9_1_72 = a9_1_9 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a9_1_77 = a9_1_5 + a9_1_72;
    wire signed [IN_WIDTH + 10 : 0] a9_1_30 = a9_1_15 <<< 1;
//a9[2] : 60 38 78 74
    wire signed [IN_WIDTH + 10 : 0] a9_2 = a9[2];
    wire signed [IN_WIDTH + 10 : 0] a9_2_16 = a9_2 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a9_2_15 = a9_2_16 - a9_2;
    wire signed [IN_WIDTH + 10 : 0] a9_2_4 = a9_2 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a9_2_19 = a9_2_15 + a9_2_4;
    wire signed [IN_WIDTH + 10 : 0] a9_2_38 = a9_2_19 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a9_2_37 = a9_2_38 - a9_2;
    wire signed [IN_WIDTH + 10 : 0] a9_2_39 = a9_2 + a9_2_38;
    wire signed [IN_WIDTH + 10 : 0] a9_2_60 = a9_2_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a9_2_78 = a9_2_39 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a9_2_74 = a9_2_37 <<< 1;
//a9[3] : 4 82 13 80 34 68
    wire signed [IN_WIDTH + 10 : 0] a9_3 = a9[3];
    wire signed [IN_WIDTH + 10 : 0] a9_3_4 = a9_3 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a9_3_5 = a9_3 + a9_3_4;
    wire signed [IN_WIDTH + 10 : 0] a9_3_16 = a9_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a9_3_17 = a9_3 + a9_3_16;
    wire signed [IN_WIDTH + 10 : 0] a9_3_8 = a9_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a9_3_13 = a9_3_5 + a9_3_8;
    wire signed [IN_WIDTH + 10 : 0] a9_3_40 = a9_3_5 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a9_3_41 = a9_3 + a9_3_40;
    wire signed [IN_WIDTH + 10 : 0] a9_3_82 = a9_3_41 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a9_3_80 = a9_3_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a9_3_34 = a9_3_17 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a9_3_68 = a9_3_17 <<< 2;
//a9[4] : 4 82 80 26 72
    wire signed [IN_WIDTH + 10 : 0] a9_4 = a9[4];
    wire signed [IN_WIDTH + 10 : 0] a9_4_4 = a9_4 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a9_4_5 = a9_4 + a9_4_4;
    wire signed [IN_WIDTH + 10 : 0] a9_4_8 = a9_4 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a9_4_9 = a9_4 + a9_4_8;
    wire signed [IN_WIDTH + 10 : 0] a9_4_13 = a9_4_5 + a9_4_8;
    wire signed [IN_WIDTH + 10 : 0] a9_4_40 = a9_4_5 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a9_4_41 = a9_4 + a9_4_40;
    wire signed [IN_WIDTH + 10 : 0] a9_4_82 = a9_4_41 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a9_4_80 = a9_4_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a9_4_26 = a9_4_13 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a9_4_72 = a9_4_9 <<< 3;
//a9[5] : 84 60 42 17 66
    wire signed [IN_WIDTH + 10 : 0] a9_5 = a9[5];
    wire signed [IN_WIDTH + 10 : 0] a9_5_16 = a9_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a9_5_15 = a9_5_16 - a9_5;
    wire signed [IN_WIDTH + 10 : 0] a9_5_17 = a9_5 + a9_5_16;
    wire signed [IN_WIDTH + 10 : 0] a9_5_32 = a9_5 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a9_5_33 = a9_5 + a9_5_32;
    wire signed [IN_WIDTH + 10 : 0] a9_5_4 = a9_5 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a9_5_21 = a9_5_17 + a9_5_4;
    wire signed [IN_WIDTH + 10 : 0] a9_5_84 = a9_5_21 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a9_5_60 = a9_5_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a9_5_42 = a9_5_21 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] a9_5_66 = a9_5_33 <<< 1;
//b[0]  : 21 60 84
    wire signed [IN_WIDTH + 10 : 0] b0 = b[0];
    wire signed [IN_WIDTH + 10 : 0] b0_16 = b0 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] b0_15 = b0_16 - b0;
    wire signed [IN_WIDTH + 10 : 0] b0_4 = b0 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b0_3 = b0_4 - b0;
    wire signed [IN_WIDTH + 10 : 0] b0_24 = b0_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] b0_21 = b0_24 - b0_3;
    wire signed [IN_WIDTH + 10 : 0] b0_60 = b0_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b0_84 = b0_21 <<< 2;
//b[1]  : 42 89 60
    wire signed [IN_WIDTH + 10 : 0] b1 = b[1];
    wire signed [IN_WIDTH + 10 : 0] b1_16 = b1 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] b1_15 = b1_16 - b1;
    wire signed [IN_WIDTH + 10 : 0] b1_4 = b1 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b1_3 = b1_4 - b1;
    wire signed [IN_WIDTH + 10 : 0] b1_24 = b1_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] b1_21 = b1_24 - b1_3;
    wire signed [IN_WIDTH + 10 : 0] b1_5 = b1 + b1_4;
    wire signed [IN_WIDTH + 10 : 0] b1_84 = b1_21 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b1_89 = b1_5 + b1_84;
    wire signed [IN_WIDTH + 10 : 0] b1_42 = b1_21 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] b1_60 = b1_15 <<< 2;
//b[2]  : 60 74 42
    wire signed [IN_WIDTH + 10 : 0] b2 = b[2];
    wire signed [IN_WIDTH + 10 : 0] b2_16 = b2 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] b2_15 = b2_16 - b2;
    wire signed [IN_WIDTH + 10 : 0] b2_4 = b2 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b2_3 = b2_4 - b2;
    wire signed [IN_WIDTH + 10 : 0] b2_24 = b2_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] b2_21 = b2_24 - b2_3;
    wire signed [IN_WIDTH + 10 : 0] b2_37 = b2_21 + b2_16;
    wire signed [IN_WIDTH + 10 : 0] b2_60 = b2_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b2_74 = b2_37 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] b2_42 = b2_21 <<< 1;
//b[3]  : 74 21 89
    wire signed [IN_WIDTH + 10 : 0] b3 = b[3];
    wire signed [IN_WIDTH + 10 : 0] b3_4 = b3 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b3_3 = b3_4 - b3;
    wire signed [IN_WIDTH + 10 : 0] b3_24 = b3_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] b3_21 = b3_24 - b3_3;
    wire signed [IN_WIDTH + 10 : 0] b3_16 = b3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] b3_37 = b3_21 + b3_16;
    wire signed [IN_WIDTH + 10 : 0] b3_5 = b3 + b3_4;
    wire signed [IN_WIDTH + 10 : 0] b3_84 = b3_21 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b3_89 = b3_5 + b3_84;
    wire signed [IN_WIDTH + 10 : 0] b3_74 = b3_37 <<< 1;
//b[4]  : 84 42 21
    wire signed [IN_WIDTH + 10 : 0] b4 = b[4];
    wire signed [IN_WIDTH + 10 : 0] b4_4 = b4 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b4_3 = b4_4 - b4;
    wire signed [IN_WIDTH + 10 : 0] b4_24 = b4_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] b4_21 = b4_24 - b4_3;
    wire signed [IN_WIDTH + 10 : 0] b4_84 = b4_21 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b4_42 = b4_21 <<< 1;
//b[5]  : 89 84 74
    wire signed [IN_WIDTH + 10 : 0] b5 = b[5];
    wire signed [IN_WIDTH + 10 : 0] b5_4 = b5 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b5_3 = b5_4 - b5;
    wire signed [IN_WIDTH + 10 : 0] b5_24 = b5_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] b5_21 = b5_24 - b5_3;
    wire signed [IN_WIDTH + 10 : 0] b5_16 = b5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] b5_37 = b5_21 + b5_16;
    wire signed [IN_WIDTH + 10 : 0] b5_5 = b5 + b5_4;
    wire signed [IN_WIDTH + 10 : 0] b5_84 = b5_21 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b5_89 = b5_5 + b5_84;
    wire signed [IN_WIDTH + 10 : 0] b5_74 = b5_37 <<< 1;

//stage 2 reg
    reg signed [IN_WIDTH + 10 : 0] c[0 : 1];
    reg signed [IN_WIDTH + 10 : 0] a0_0_4_r, a0_0_13_r, a0_0_80_r, a0_0_68_r, a0_0_72_r;
    reg signed [IN_WIDTH + 10 : 0] a0_1_56_r, a0_1_46_r, a0_1_80_r, a0_1_34_r, a0_1_68_r, a0_1_26_r;
    reg signed [IN_WIDTH + 10 : 0] a0_2_84_r, a0_2_60_r, a0_2_17_r, a0_2_38_r, a0_2_78_r, a0_2_74_r;
    reg signed [IN_WIDTH + 10 : 0] a0_3_50_r, a0_3_9_r, a0_3_63_r, a0_3_77_r;
    reg signed [IN_WIDTH + 10 : 0] a0_4_84_r, a0_4_60_r, a0_4_38_r, a0_4_78_r;
    reg signed [IN_WIDTH + 10 : 0] a0_5_46_r, a0_5_34_r, a0_5_26_r;
    reg signed [IN_WIDTH + 10 : 0] a1_0_50_r, a1_0_63_r, a1_0_77_r, a1_0_30_r;
    reg signed [IN_WIDTH + 10 : 0] a1_1_84_r, a1_1_78_r, a1_1_21_r;
    reg signed [IN_WIDTH + 10 : 0] a1_2_56_r, a1_2_82_r, a1_2_72_r;
    reg signed [IN_WIDTH + 10 : 0] a1_3_4_r, a1_3_56_r, a1_3_46_r, a1_3_13_r, a1_3_80_r, a1_3_72_r;
    reg signed [IN_WIDTH + 10 : 0] a1_4_84_r, a1_4_17_r, a1_4_66_r, a1_4_21_r, a1_4_74_r;
    reg signed [IN_WIDTH + 10 : 0] a1_5_9_r, a1_5_63_r, a1_5_77_r, a1_5_30_r;
    reg signed [IN_WIDTH + 10 : 0] a2_0_84_r, a2_0_42_r, a2_0_38_r, a2_0_66_r, a2_0_21_r;
    reg signed [IN_WIDTH + 10 : 0] a2_1_4_r, a2_1_56_r, a2_1_13_r, a2_1_68_r, a2_1_72_r;
    reg signed [IN_WIDTH + 10 : 0] a2_2_50_r, a2_2_9_r, a2_2_63_r, a2_2_77_r, a2_2_30_r;
    reg signed [IN_WIDTH + 10 : 0] a2_3_56_r, a2_3_46_r, a2_3_82_r, a2_3_13_r, a2_3_26_r;
    reg signed [IN_WIDTH + 10 : 0] a2_4_60_r, a2_4_42_r, a2_4_38_r, a2_4_66_r, a2_4_74_r;
    reg signed [IN_WIDTH + 10 : 0] a2_5_60_r, a2_5_17_r, a2_5_38_r, a2_5_74_r;
    reg signed [IN_WIDTH + 10 : 0] a3_0_4_r, a3_0_56_r, a3_0_46_r, a3_0_13_r, a3_0_80_r, a3_0_34_r;
    reg signed [IN_WIDTH + 10 : 0] a3_1_50_r, a3_1_9_r, a3_1_77_r, a3_1_30_r;
    reg signed [IN_WIDTH + 10 : 0] a3_2_4_r, a3_2_56_r, a3_2_46_r, a3_2_13_r, a3_2_34_r, a3_2_26_r;
    reg signed [IN_WIDTH + 10 : 0] a3_3_84_r, a3_3_60_r, a3_3_42_r, a3_3_17_r, a3_3_78_r;
    reg signed [IN_WIDTH + 10 : 0] a3_4_60_r, a3_4_17_r, a3_4_78_r, a3_4_21_r;
    reg signed [IN_WIDTH + 10 : 0] a3_5_4_r, a3_5_46_r, a3_5_82_r, a3_5_80_r, a3_5_68_r, a3_5_26_r, a3_5_72_r;
    reg signed [IN_WIDTH + 10 : 0] a4_0_13_r, a4_0_34_r, a4_0_68_r;
    reg signed [IN_WIDTH + 10 : 0] a4_1_50_r, a4_1_9_r, a4_1_77_r, a4_1_30_r;
    reg signed [IN_WIDTH + 10 : 0] a4_2_4_r, a4_2_56_r, a4_2_80_r, a4_2_34_r, a4_2_26_r;
    reg signed [IN_WIDTH + 10 : 0] a4_3_38_r, a4_3_66_r, a4_3_78_r;
    reg signed [IN_WIDTH + 10 : 0] a4_4_60_r, a4_4_42_r, a4_4_38_r, a4_4_21_r, a4_4_74_r;
    reg signed [IN_WIDTH + 10 : 0] a4_5_80_r, a4_5_34_r, a4_5_26_r, a4_5_72_r;
    reg signed [IN_WIDTH + 10 : 0] a5_0_66_r, a5_0_78_r, a5_0_21_r;
    reg signed [IN_WIDTH + 10 : 0] a5_1_56_r, a5_1_46_r, a5_1_82_r, a5_1_80_r, a5_1_26_r;
    reg signed [IN_WIDTH + 10 : 0] a5_2_4_r, a5_2_82_r, a5_2_68_r, a5_2_72_r;
    reg signed [IN_WIDTH + 10 : 0] a5_3_60_r, a5_3_42_r, a5_3_17_r, a5_3_38_r, a5_3_66_r, a5_3_21_r;
    reg signed [IN_WIDTH + 10 : 0] a5_4_50_r, a5_4_9_r, a5_4_63_r, a5_4_77_r, a5_4_30_r;
    reg signed [IN_WIDTH + 10 : 0] a5_5_42_r, a5_5_38_r, a5_5_78_r, a5_5_74_r;
    reg signed [IN_WIDTH + 10 : 0] a6_0_50_r, a6_0_9_r, a6_0_63_r, a6_0_77_r, a6_0_30_r;
    reg signed [IN_WIDTH + 10 : 0] a6_1_4_r, a6_1_46_r, a6_1_82_r, a6_1_34_r;
    reg signed [IN_WIDTH + 10 : 0] a6_2_84_r, a6_2_38_r, a6_2_66_r, a6_2_21_r;
    reg signed [IN_WIDTH + 10 : 0] a6_3_84_r, a6_3_42_r, a6_3_17_r, a6_3_66_r, a6_3_78_r, a6_3_21_r;
    reg signed [IN_WIDTH + 10 : 0] a6_4_46_r, a6_4_82_r, a6_4_13_r, a6_4_34_r, a6_4_26_r, a6_4_72_r;
    reg signed [IN_WIDTH + 10 : 0] a6_5_50_r, a6_5_9_r, a6_5_63_r, a6_5_30_r;
    reg signed [IN_WIDTH + 10 : 0] a7_0_17_r, a7_0_78_r, a7_0_21_r, a7_0_74_r;
    reg signed [IN_WIDTH + 10 : 0] a7_1_84_r, a7_1_42_r, a7_1_17_r, a7_1_74_r;
    reg signed [IN_WIDTH + 10 : 0] a7_2_46_r, a7_2_80_r, a7_2_68_r;
    reg signed [IN_WIDTH + 10 : 0] a7_3_50_r, a7_3_9_r, a7_3_63_r, a7_3_30_r;
    reg signed [IN_WIDTH + 10 : 0] a7_4_4_r, a7_4_82_r, a7_4_13_r, a7_4_68_r, a7_4_26_r, a7_4_72_r;
    reg signed [IN_WIDTH + 10 : 0] a7_5_42_r, a7_5_17_r, a7_5_38_r, a7_5_21_r;
    reg signed [IN_WIDTH + 10 : 0] a8_0_56_r, a8_0_82_r, a8_0_13_r, a8_0_68_r, a8_0_26_r;
    reg signed [IN_WIDTH + 10 : 0] a8_1_60_r, a8_1_66_r, a8_1_74_r;
    reg signed [IN_WIDTH + 10 : 0] a8_2_50_r, a8_2_63_r, a8_2_77_r;
    reg signed [IN_WIDTH + 10 : 0] a8_3_84_r, a8_3_42_r, a8_3_17_r, a8_3_66_r, a8_3_74_r;
    reg signed [IN_WIDTH + 10 : 0] a8_4_56_r, a8_4_46_r, a8_4_34_r, a8_4_68_r, a8_4_72_r;
    reg signed [IN_WIDTH + 10 : 0] a8_5_56_r, a8_5_82_r, a8_5_13_r, a8_5_80_r, a8_5_34_r, a8_5_68_r, a8_5_72_r;
    reg signed [IN_WIDTH + 10 : 0] a9_0_84_r, a9_0_60_r, a9_0_42_r, a9_0_66_r, a9_0_78_r, a9_0_21_r, a9_0_74_r;
    reg signed [IN_WIDTH + 10 : 0] a9_1_9_r, a9_1_63_r, a9_1_77_r, a9_1_30_r;
    reg signed [IN_WIDTH + 10 : 0] a9_2_60_r, a9_2_38_r, a9_2_78_r, a9_2_74_r;
    reg signed [IN_WIDTH + 10 : 0] a9_3_4_r, a9_3_82_r, a9_3_13_r, a9_3_80_r, a9_3_34_r, a9_3_68_r;
    reg signed [IN_WIDTH + 10 : 0] a9_4_4_r, a9_4_82_r, a9_4_80_r, a9_4_26_r, a9_4_72_r;
    reg signed [IN_WIDTH + 10 : 0] a9_5_84_r, a9_5_60_r, a9_5_42_r, a9_5_17_r, a9_5_66_r;
    reg signed [IN_WIDTH + 10 : 0] b0_21_r, b0_60_r, b0_84_r;
    reg signed [IN_WIDTH + 10 : 0] b1_42_r, b1_89_r, b1_60_r;
    reg signed [IN_WIDTH + 10 : 0] b2_60_r, b2_74_r, b2_42_r;
    reg signed [IN_WIDTH + 10 : 0] b3_74_r, b3_21_r, b3_89_r;
    reg signed [IN_WIDTH + 10 : 0] b4_84_r, b4_42_r, b4_21_r;
    reg signed [IN_WIDTH + 10 : 0] b5_89_r, b5_84_r, b5_74_r;
    reg signed [IN_WIDTH + 10 : 0] t[0 : 1];
    //53 85
    wire signed [IN_WIDTH + 10 : 0] i_12_4 = i_12_d1 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_12_5 = i_12_d1 + i_12_4;
    wire signed [IN_WIDTH + 10 : 0] i_12_80 = i_12_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] i_12_85 = i_12_5 + i_12_80;
    wire signed [IN_WIDTH + 10 : 0] i_12_32 = i_12_d1 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] i_12_53 = i_12_85 - i_12_32;

    wire signed [IN_WIDTH + 10 : 0] i_25_4 = i_25_d1 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_25_5 = i_25_d1 + i_25_4;
    wire signed [IN_WIDTH + 10 : 0] i_25_80 = i_25_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] i_25_85 = i_25_5 + i_25_80;
    wire signed [IN_WIDTH + 10 : 0] i_25_32 = i_25_d1 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] i_25_53 = i_25_85 - i_25_32;


always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d2 <= 0;
        for (i = 0; i < 2; i = i + 1) begin
            c[i] <= 0;
        end
        t[0] <= 0;
        t[1] <= 0;
        a3_0_4_r <= 0; a6_5_50_r <= 0;  a8_0_56_r <= 0; a9_5_84_r <= 0; a3_1_9_r <= 0; a6_4_46_r <= 0; a8_1_60_r <= 0; a9_4_82_r <= 0; a3_2_13_r <= 0; a6_3_42_r <= 0; a8_2_63_r <= 0; a9_3_80_r <= 0; a3_3_17_r <= 0; a6_2_38_r <= 0; a8_3_66_r <= 0; a9_2_78_r <= 0; a3_4_21_r <= 0; a6_1_34_r <= 0; a8_4_68_r <= 0; a9_1_77_r <= 0; a3_5_26_r <= 0; a6_0_30_r <= 0; a8_5_72_r <= 0; a9_0_74_r <= 0;
        a5_2_4_r <= 0; a0_3_50_r <= 0;  a4_2_56_r <= 0; a6_2_84_r <= 0; a9_1_9_r <= 0; a8_4_46_r <= 0; a3_4_60_r <= 0; a6_1_82_r <= 0; a0_0_13_r <= 0; a5_5_42_r <= 0; a6_5_63_r <= 0; a4_5_80_r <= 0; a5_3_17_r <= 0; a0_2_38_r <= 0; a4_3_66_r <= 0; a6_3_78_r <= 0; a9_0_21_r <= 0; a8_5_34_r <= 0; a3_5_68_r <= 0; a6_0_77_r <= 0; a0_1_26_r <= 0; a5_4_30_r <= 0; a6_4_72_r <= 0; a4_4_74_r <= 0;
        b0_21_r  <= 0; b1_42_r   <= 0;  b2_60_r   <= 0; b3_74_r   <= 0; b4_84_r  <= 0; b5_89_r   <= 0;
        a9_4_4_r <= 0; a5_4_50_r <= 0;  a2_1_56_r <= 0; a7_1_84_r <= 0; a0_3_9_r <= 0; a1_3_46_r <= 0; a3_3_60_r <= 0; a2_3_82_r <= 0; a8_5_13_r <= 0; a9_0_42_r <= 0; a6_0_63_r <= 0; a3_5_80_r <= 0; a1_4_17_r <= 0; a0_4_38_r <= 0; a2_4_66_r <= 0; a3_4_78_r <= 0; a5_3_21_r <= 0; a9_3_34_r <= 0; a7_2_68_r <= 0; a2_2_77_r <= 0; a8_0_26_r <= 0; a1_0_30_r <= 0; a4_5_72_r <= 0; a7_0_74_r <= 0;
        a3_2_4_r <= 0; a2_2_50_r <= 0;  a1_2_56_r <= 0; a0_2_84_r <= 0; a6_0_9_r <= 0; a3_5_46_r <= 0; a9_0_60_r <= 0; a8_5_82_r <= 0; a2_3_13_r <= 0; a3_3_42_r <= 0; a0_3_63_r <= 0; a1_3_80_r <= 0; a7_0_17_r <= 0; a2_0_38_r <= 0; a9_5_66_r <= 0; a5_5_78_r <= 0; a4_4_21_r <= 0; a6_4_34_r <= 0; a0_1_68_r <= 0; a5_4_77_r <= 0; a7_4_26_r <= 0; a4_1_30_r <= 0; a8_4_72_r <= 0; a1_4_74_r <= 0;
        a3_5_4_r <= 0; a6_0_50_r <= 0;  a8_5_56_r <= 0; a9_0_84_r <= 0; a6_5_9_r <= 0; a3_0_46_r <= 0; a9_5_60_r <= 0; a8_0_82_r <= 0; a7_4_13_r <= 0; a2_4_42_r <= 0; a9_1_63_r <= 0; a5_1_80_r <= 0; a7_1_17_r <= 0; a4_4_38_r <= 0; a8_1_66_r <= 0; a1_1_78_r <= 0; a6_2_21_r <= 0; a4_2_34_r <= 0; a5_2_68_r <= 0; a0_3_77_r <= 0; a3_2_26_r <= 0; a2_2_30_r <= 0; a1_2_72_r <= 0; a0_2_74_r <= 0;
        b0_60_r  <= 0; b1_89_r   <= 0;  b2_74_r   <= 0; b3_21_r   <= 0; b4_42_r  <= 0; b5_84_r   <= 0;
        a9_3_4_r <= 0; a8_2_50_r <= 0;  a3_2_56_r <= 0; a6_3_84_r <= 0; a1_5_9_r <= 0; a0_5_46_r <= 0; a2_5_60_r <= 0; a3_5_82_r <= 0; a1_3_13_r <= 0; a8_3_42_r <= 0; a7_3_63_r <= 0; a4_2_80_r <= 0; a9_5_17_r <= 0; a5_5_38_r <= 0; a2_0_66_r <= 0; a7_0_78_r <= 0; a1_1_21_r <= 0; a0_1_34_r <= 0; a2_1_68_r <= 0; a3_1_77_r <= 0; a5_1_26_r <= 0; a9_1_30_r <= 0; a7_4_72_r <= 0; a2_4_74_r <= 0;
        a2_1_4_r <= 0; a3_1_50_r <= 0;  a0_1_56_r <= 0; a1_1_84_r <= 0; a7_3_9_r <= 0; a2_3_46_r <= 0; a9_2_60_r <= 0; a5_2_82_r <= 0; a4_0_13_r <= 0; a7_5_42_r <= 0; a1_5_63_r <= 0; a8_5_80_r <= 0; a3_4_17_r <= 0; a2_4_38_r <= 0; a1_4_66_r <= 0; a0_4_78_r <= 0; a6_3_21_r <= 0; a3_2_34_r <= 0; a9_3_68_r <= 0; a8_2_77_r <= 0; a4_5_26_r <= 0; a6_5_30_r <= 0; a0_0_72_r <= 0; a5_5_74_r <= 0;
        a6_1_4_r <= 0; a4_1_50_r <= 0;  a5_1_56_r <= 0; a0_4_84_r <= 0; a2_2_9_r <= 0; a7_2_46_r <= 0; a5_3_60_r <= 0; a9_3_82_r <= 0; a6_4_13_r <= 0; a4_4_42_r <= 0; a5_4_63_r <= 0; a0_1_80_r <= 0; a2_5_17_r <= 0; a7_5_38_r <= 0; a5_0_66_r <= 0; a9_0_78_r <= 0; a7_0_21_r <= 0; a4_5_34_r <= 0; a8_0_68_r <= 0; a1_0_77_r <= 0; a4_2_26_r <= 0; a7_3_30_r <= 0; a1_3_72_r <= 0; a8_3_74_r <= 0;
        a1_3_4_r <= 0; a0_3_50_r <= 0;  a2_3_56_r <= 0; a3_3_84_r <= 0; a9_1_9_r <= 0; a5_1_46_r <= 0; a2_4_60_r <= 0; a7_4_82_r <= 0; a8_0_13_r <= 0; a9_5_42_r <= 0; a6_5_63_r <= 0; a3_0_80_r <= 0; a0_2_17_r <= 0; a5_3_38_r <= 0; a6_3_66_r <= 0; a4_3_78_r <= 0; a5_0_21_r <= 0; a0_5_34_r <= 0; a4_0_68_r <= 0; a6_0_77_r <= 0; a9_4_26_r <= 0; a5_4_30_r <= 0; a2_1_72_r <= 0; a7_1_74_r <= 0;
        b0_84_r  <= 0; b1_60_r   <= 0;  b2_42_r   <= 0; b3_89_r   <= 0; b4_21_r  <= 0; b5_74_r   <= 0;
        a0_0_4_r <= 0; a1_0_50_r <= 0;  a3_0_56_r <= 0; a2_0_84_r <= 0; a5_4_9_r <= 0; a0_1_46_r <= 0; a4_4_60_r <= 0; a6_4_82_r <= 0; a9_3_13_r <= 0; a5_3_42_r <= 0; a2_2_63_r <= 0; a7_2_80_r <= 0; a8_3_17_r <= 0; a9_2_38_r <= 0; a6_2_66_r <= 0; a3_3_78_r <= 0; a1_4_21_r <= 0; a8_4_34_r <= 0; a7_4_68_r <= 0; a4_1_77_r <= 0; a0_5_26_r <= 0; a1_5_30_r <= 0; a3_5_72_r <= 0; a2_5_74_r <= 0;
        a4_2_4_r <= 0; a7_3_50_r <= 0;  a1_3_56_r <= 0; a8_3_84_r <= 0; a4_1_9_r <= 0; a6_1_46_r <= 0; a0_4_60_r <= 0; a5_1_82_r <= 0; a3_0_13_r <= 0; a2_0_42_r <= 0; a1_0_63_r <= 0; a0_0_80_r <= 0; a6_3_17_r <= 0; a4_3_38_r <= 0; a5_3_66_r <= 0; a0_2_78_r <= 0; a7_5_21_r <= 0; a4_0_34_r <= 0; a8_5_68_r <= 0; a1_5_77_r <= 0; a6_4_26_r <= 0; a3_1_30_r <= 0; a9_4_72_r <= 0; a8_1_74_r <= 0;
        a7_4_4_r <= 0; a4_1_50_r <= 0;  a8_4_56_r <= 0; a1_4_84_r <= 0; a2_2_9_r <= 0; a3_2_46_r <= 0; a0_2_60_r <= 0; a1_2_82_r <= 0; a2_1_13_r <= 0; a7_1_42_r <= 0; a5_4_63_r <= 0; a9_4_80_r <= 0; a7_5_17_r <= 0; a2_5_38_r <= 0; a9_0_66_r <= 0; a5_0_78_r <= 0; a2_0_21_r <= 0; a3_0_34_r <= 0; a0_0_68_r <= 0; a1_0_77_r <= 0; a2_3_26_r <= 0; a7_3_30_r <= 0; a5_2_72_r <= 0; a9_2_74_r <= 0;
    end
    else begin
        i_valid_d2 <= i_valid_d1;
        for (i = 0; i < 2; i = i + 1) begin
            c[i] <= c0[i] + c1[i] + c2[i];
        end
        t[0] <= i_12_53 + i_25_85;
        t[1] <= i_25_53 - i_12_85;
        a3_0_4_r <= a3_0_4; a6_5_50_r <= a6_5_50;  a8_0_56_r <= a8_0_56; a9_5_84_r <= a9_5_84; a3_1_9_r <= a3_1_9; a6_4_46_r <= a6_4_46; a8_1_60_r <= a8_1_60; a9_4_82_r <= a9_4_82; a3_2_13_r <= a3_2_13; a6_3_42_r <= a6_3_42; a8_2_63_r <= a8_2_63; a9_3_80_r <= a9_3_80; a3_3_17_r <= a3_3_17; a6_2_38_r <= a6_2_38; a8_3_66_r <= a8_3_66; a9_2_78_r <= a9_2_78; a3_4_21_r <= a3_4_21; a6_1_34_r <= a6_1_34; a8_4_68_r <= a8_4_68; a9_1_77_r <= a9_1_77; a3_5_26_r <= a3_5_26; a6_0_30_r <= a6_0_30; a8_5_72_r <= a8_5_72; a9_0_74_r <= a9_0_74;
        a5_2_4_r <= a5_2_4; a0_3_50_r <= a0_3_50;  a4_2_56_r <= a4_2_56; a6_2_84_r <= a6_2_84; a9_1_9_r <= a9_1_9; a8_4_46_r <= a8_4_46; a3_4_60_r <= a3_4_60; a6_1_82_r <= a6_1_82; a0_0_13_r <= a0_0_13; a5_5_42_r <= a5_5_42; a6_5_63_r <= a6_5_63; a4_5_80_r <= a4_5_80; a5_3_17_r <= a5_3_17; a0_2_38_r <= a0_2_38; a4_3_66_r <= a4_3_66; a6_3_78_r <= a6_3_78; a9_0_21_r <= a9_0_21; a8_5_34_r <= a8_5_34; a3_5_68_r <= a3_5_68; a6_0_77_r <= a6_0_77; a0_1_26_r <= a0_1_26; a5_4_30_r <= a5_4_30; a6_4_72_r <= a6_4_72; a4_4_74_r <= a4_4_74;
        b0_21_r  <= b0_21 ; b1_42_r   <= b1_42  ;  b2_60_r   <= b2_60  ; b3_74_r   <= b3_74  ; b4_84_r  <= b4_84 ; b5_89_r   <= b5_89  ;
        a9_4_4_r <= a9_4_4; a5_4_50_r <= a5_4_50;  a2_1_56_r <= a2_1_56; a7_1_84_r <= a7_1_84; a0_3_9_r <= a0_3_9; a1_3_46_r <= a1_3_46; a3_3_60_r <= a3_3_60; a2_3_82_r <= a2_3_82; a8_5_13_r <= a8_5_13; a9_0_42_r <= a9_0_42; a6_0_63_r <= a6_0_63; a3_5_80_r <= a3_5_80; a1_4_17_r <= a1_4_17; a0_4_38_r <= a0_4_38; a2_4_66_r <= a2_4_66; a3_4_78_r <= a3_4_78; a5_3_21_r <= a5_3_21; a9_3_34_r <= a9_3_34; a7_2_68_r <= a7_2_68; a2_2_77_r <= a2_2_77; a8_0_26_r <= a8_0_26; a1_0_30_r <= a1_0_30; a4_5_72_r <= a4_5_72; a7_0_74_r <= a7_0_74;
        a3_2_4_r <= a3_2_4; a2_2_50_r <= a2_2_50;  a1_2_56_r <= a1_2_56; a0_2_84_r <= a0_2_84; a6_0_9_r <= a6_0_9; a3_5_46_r <= a3_5_46; a9_0_60_r <= a9_0_60; a8_5_82_r <= a8_5_82; a2_3_13_r <= a2_3_13; a3_3_42_r <= a3_3_42; a0_3_63_r <= a0_3_63; a1_3_80_r <= a1_3_80; a7_0_17_r <= a7_0_17; a2_0_38_r <= a2_0_38; a9_5_66_r <= a9_5_66; a5_5_78_r <= a5_5_78; a4_4_21_r <= a4_4_21; a6_4_34_r <= a6_4_34; a0_1_68_r <= a0_1_68; a5_4_77_r <= a5_4_77; a7_4_26_r <= a7_4_26; a4_1_30_r <= a4_1_30; a8_4_72_r <= a8_4_72; a1_4_74_r <= a1_4_74;
        a3_5_4_r <= a3_5_4; a6_0_50_r <= a6_0_50;  a8_5_56_r <= a8_5_56; a9_0_84_r <= a9_0_84; a6_5_9_r <= a6_5_9; a3_0_46_r <= a3_0_46; a9_5_60_r <= a9_5_60; a8_0_82_r <= a8_0_82; a7_4_13_r <= a7_4_13; a2_4_42_r <= a2_4_42; a9_1_63_r <= a9_1_63; a5_1_80_r <= a5_1_80; a7_1_17_r <= a7_1_17; a4_4_38_r <= a4_4_38; a8_1_66_r <= a8_1_66; a1_1_78_r <= a1_1_78; a6_2_21_r <= a6_2_21; a4_2_34_r <= a4_2_34; a5_2_68_r <= a5_2_68; a0_3_77_r <= a0_3_77; a3_2_26_r <= a3_2_26; a2_2_30_r <= a2_2_30; a1_2_72_r <= a1_2_72; a0_2_74_r <= a0_2_74;
        b0_60_r  <= b0_60 ; b1_89_r   <= b1_89  ;  b2_74_r   <= b2_74  ; b3_21_r   <= b3_21  ; b4_42_r  <= b4_42 ; b5_84_r   <= b5_84  ;
        a9_3_4_r <= a9_3_4; a8_2_50_r <= a8_2_50;  a3_2_56_r <= a3_2_56; a6_3_84_r <= a6_3_84; a1_5_9_r <= a1_5_9; a0_5_46_r <= a0_5_46; a2_5_60_r <= a2_5_60; a3_5_82_r <= a3_5_82; a1_3_13_r <= a1_3_13; a8_3_42_r <= a8_3_42; a7_3_63_r <= a7_3_63; a4_2_80_r <= a4_2_80; a9_5_17_r <= a9_5_17; a5_5_38_r <= a5_5_38; a2_0_66_r <= a2_0_66; a7_0_78_r <= a7_0_78; a1_1_21_r <= a1_1_21; a0_1_34_r <= a0_1_34; a2_1_68_r <= a2_1_68; a3_1_77_r <= a3_1_77; a5_1_26_r <= a5_1_26; a9_1_30_r <= a9_1_30; a7_4_72_r <= a7_4_72; a2_4_74_r <= a2_4_74;
        a2_1_4_r <= a2_1_4; a3_1_50_r <= a3_1_50;  a0_1_56_r <= a0_1_56; a1_1_84_r <= a1_1_84; a7_3_9_r <= a7_3_9; a2_3_46_r <= a2_3_46; a9_2_60_r <= a9_2_60; a5_2_82_r <= a5_2_82; a4_0_13_r <= a4_0_13; a7_5_42_r <= a7_5_42; a1_5_63_r <= a1_5_63; a8_5_80_r <= a8_5_80; a3_4_17_r <= a3_4_17; a2_4_38_r <= a2_4_38; a1_4_66_r <= a1_4_66; a0_4_78_r <= a0_4_78; a6_3_21_r <= a6_3_21; a3_2_34_r <= a3_2_34; a9_3_68_r <= a9_3_68; a8_2_77_r <= a8_2_77; a4_5_26_r <= a4_5_26; a6_5_30_r <= a6_5_30; a0_0_72_r <= a0_0_72; a5_5_74_r <= a5_5_74;
        a6_1_4_r <= a6_1_4; a4_1_50_r <= a4_1_50;  a5_1_56_r <= a5_1_56; a0_4_84_r <= a0_4_84; a2_2_9_r <= a2_2_9; a7_2_46_r <= a7_2_46; a5_3_60_r <= a5_3_60; a9_3_82_r <= a9_3_82; a6_4_13_r <= a6_4_13; a4_4_42_r <= a4_4_42; a5_4_63_r <= a5_4_63; a0_1_80_r <= a0_1_80; a2_5_17_r <= a2_5_17; a7_5_38_r <= a7_5_38; a5_0_66_r <= a5_0_66; a9_0_78_r <= a9_0_78; a7_0_21_r <= a7_0_21; a4_5_34_r <= a4_5_34; a8_0_68_r <= a8_0_68; a1_0_77_r <= a1_0_77; a4_2_26_r <= a4_2_26; a7_3_30_r <= a7_3_30; a1_3_72_r <= a1_3_72; a8_3_74_r <= a8_3_74;
        a1_3_4_r <= a1_3_4; a0_3_50_r <= a0_3_50;  a2_3_56_r <= a2_3_56; a3_3_84_r <= a3_3_84; a9_1_9_r <= a9_1_9; a5_1_46_r <= a5_1_46; a2_4_60_r <= a2_4_60; a7_4_82_r <= a7_4_82; a8_0_13_r <= a8_0_13; a9_5_42_r <= a9_5_42; a6_5_63_r <= a6_5_63; a3_0_80_r <= a3_0_80; a0_2_17_r <= a0_2_17; a5_3_38_r <= a5_3_38; a6_3_66_r <= a6_3_66; a4_3_78_r <= a4_3_78; a5_0_21_r <= a5_0_21; a0_5_34_r <= a0_5_34; a4_0_68_r <= a4_0_68; a6_0_77_r <= a6_0_77; a9_4_26_r <= a9_4_26; a5_4_30_r <= a5_4_30; a2_1_72_r <= a2_1_72; a7_1_74_r <= a7_1_74;
        b0_84_r  <= b0_84 ; b1_60_r   <= b1_60  ;  b2_42_r   <= b2_42  ; b3_89_r   <= b3_89  ; b4_21_r  <= b4_21 ; b5_74_r   <= b5_74  ;
        a0_0_4_r <= a0_0_4; a1_0_50_r <= a1_0_50;  a3_0_56_r <= a3_0_56; a2_0_84_r <= a2_0_84; a5_4_9_r <= a5_4_9; a0_1_46_r <= a0_1_46; a4_4_60_r <= a4_4_60; a6_4_82_r <= a6_4_82; a9_3_13_r <= a9_3_13; a5_3_42_r <= a5_3_42; a2_2_63_r <= a2_2_63; a7_2_80_r <= a7_2_80; a8_3_17_r <= a8_3_17; a9_2_38_r <= a9_2_38; a6_2_66_r <= a6_2_66; a3_3_78_r <= a3_3_78; a1_4_21_r <= a1_4_21; a8_4_34_r <= a8_4_34; a7_4_68_r <= a7_4_68; a4_1_77_r <= a4_1_77; a0_5_26_r <= a0_5_26; a1_5_30_r <= a1_5_30; a3_5_72_r <= a3_5_72; a2_5_74_r <= a2_5_74;
        a4_2_4_r <= a4_2_4; a7_3_50_r <= a7_3_50;  a1_3_56_r <= a1_3_56; a8_3_84_r <= a8_3_84; a4_1_9_r <= a4_1_9; a6_1_46_r <= a6_1_46; a0_4_60_r <= a0_4_60; a5_1_82_r <= a5_1_82; a3_0_13_r <= a3_0_13; a2_0_42_r <= a2_0_42; a1_0_63_r <= a1_0_63; a0_0_80_r <= a0_0_80; a6_3_17_r <= a6_3_17; a4_3_38_r <= a4_3_38; a5_3_66_r <= a5_3_66; a0_2_78_r <= a0_2_78; a7_5_21_r <= a7_5_21; a4_0_34_r <= a4_0_34; a8_5_68_r <= a8_5_68; a1_5_77_r <= a1_5_77; a6_4_26_r <= a6_4_26; a3_1_30_r <= a3_1_30; a9_4_72_r <= a9_4_72; a8_1_74_r <= a8_1_74;
        a7_4_4_r <= a7_4_4; a4_1_50_r <= a4_1_50;  a8_4_56_r <= a8_4_56; a1_4_84_r <= a1_4_84; a2_2_9_r <= a2_2_9; a3_2_46_r <= a3_2_46; a0_2_60_r <= a0_2_60; a1_2_82_r <= a1_2_82; a2_1_13_r <= a2_1_13; a7_1_42_r <= a7_1_42; a5_4_63_r <= a5_4_63; a9_4_80_r <= a9_4_80; a7_5_17_r <= a7_5_17; a2_5_38_r <= a2_5_38; a9_0_66_r <= a9_0_66; a5_0_78_r <= a5_0_78; a2_0_21_r <= a2_0_21; a3_0_34_r <= a3_0_34; a0_0_68_r <= a0_0_68; a1_0_77_r <= a1_0_77; a2_3_26_r <= a2_3_26; a7_3_30_r <= a7_3_30; a5_2_72_r <= a5_2_72; a9_2_74_r <= a9_2_74;
    end
end

//sum
    reg signed  [IN_WIDTH + 10 : 0] sum0_0[0 : 15], sum0_1[0 : 15], sum0_2[0 : 15], sum0_3[0 : 15], sum0_4[0 : 15], sum0_5[0 : 15], sum0_6[0 : 15], sum0_7[0 : 15], sum0_8[0 : 15], sum0_9[0 : 15], sum0_10[0 : 15], sum0_11[0 : 15], sum0_12[0 : 15];
    reg signed  [IN_WIDTH + 10 : 0] sum1_0[0 : 15], sum1_1[0 : 15], sum1_2[0 : 15], sum1_3[0 : 15];
    reg signed  [IN_WIDTH + 10 : 0] sum2_0[0 : 15], sum2_1[0 : 15];
    //c[0]  : 53
    wire signed [IN_WIDTH + 10 : 0] c0_4 = c[0] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] c0_3 = c0_4 - c[0];
    wire signed [IN_WIDTH + 10 : 0] c0_5 = c[0] + c0_4;
    wire signed [IN_WIDTH + 10 : 0] c0_48 = c0_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] c0_53 = c0_5 + c0_48;
    //c[1]  : 85
    wire signed [IN_WIDTH + 10 : 0] c1_4 = c[1] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] c1_5 = c[1] + c1_4;
    wire signed [IN_WIDTH + 10 : 0] c1_80 = c1_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] c1_85 = c1_5 + c1_80;

//stage 3
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d3 <= 0;
        for (i = 0; i < 16; i = i + 1) begin
            sum0_0[i] <= 0; sum0_1[i] <= 0; sum0_2[i] <= 0; sum0_3[i] <= 0; sum0_4[i] <= 0; sum0_5[i] <= 0; sum0_6[i] <= 0; sum0_7[i] <= 0; sum0_8[i] <= 0; sum0_9[i] <= 0; sum0_10[i] <= 0; sum0_11[i] <= 0;
        end
    end
    else begin
        i_valid_d3 <= i_valid_d2;
        sum0_0[0 ] <=   a3_0_4_r + a6_5_50_r; sum0_1[0 ] <=   a8_0_56_r + a9_5_84_r; sum0_2[0 ] <=   a3_1_9_r + a6_4_46_r; sum0_3[0 ] <=   a8_1_60_r + a9_4_82_r; sum0_4[0 ] <=   a3_2_13_r + a6_3_42_r; sum0_5[0 ] <=   a8_2_63_r + a9_3_80_r; sum0_6[0 ] <=   a3_3_17_r + a6_2_38_r; sum0_7[0 ] <=   a8_3_66_r + a9_2_78_r; sum0_8[0 ] <=   a3_4_21_r + a6_1_34_r; sum0_9[0 ] <=   a8_4_68_r + a9_1_77_r; sum0_10[0 ] <=   a3_5_26_r + a6_0_30_r; sum0_11[0 ] <=   a8_5_72_r + a9_0_74_r; sum0_12[0 ] <= + t[0];
        sum0_0[1 ] <= - a5_2_4_r + a0_3_50_r; sum0_1[1 ] <=   a4_2_56_r + a6_2_84_r; sum0_2[1 ] <=   a9_1_9_r + a8_4_46_r; sum0_3[1 ] <=   a3_4_60_r + a6_1_82_r; sum0_4[1 ] <=   a0_0_13_r - a5_5_42_r; sum0_5[1 ] <=   a6_5_63_r + a4_5_80_r; sum0_6[1 ] <= - a5_3_17_r + a0_2_38_r; sum0_7[1 ] <=   a4_3_66_r + a6_3_78_r; sum0_8[1 ] <=   a9_0_21_r + a8_5_34_r; sum0_9[1 ] <=   a3_5_68_r + a6_0_77_r; sum0_10[1 ] <=   a0_1_26_r - a5_4_30_r; sum0_11[1 ] <=   a6_4_72_r + a4_4_74_r; sum0_12[1 ] <= - t[1];
        sum0_0[2 ] <=   b0_21_r  + b1_42_r + b2_60_r; sum0_1[2 ] <= b3_74_r + b4_84_r + b5_89_r;
        sum0_0[3 ] <= - a9_4_4_r - a5_4_50_r; sum0_1[3 ] <=   a2_1_56_r - a7_1_84_r; sum0_2[3 ] <= - a0_3_9_r - a1_3_46_r; sum0_3[3 ] <=   a3_3_60_r + a2_3_82_r; sum0_4[3 ] <=   a8_5_13_r + a9_0_42_r; sum0_5[3 ] <=   a6_0_63_r + a3_5_80_r; sum0_6[3 ] <= - a1_4_17_r - a0_4_38_r; sum0_7[3 ] <=   a2_4_66_r + a3_4_78_r; sum0_8[3 ] <= - a5_3_21_r - a9_3_34_r; sum0_9[3 ] <= - a7_2_68_r + a2_2_77_r; sum0_10[3 ] <=   a8_0_26_r + a1_0_30_r; sum0_11[3 ] <= - a4_5_72_r - a7_0_74_r; sum0_12[3 ] <= + t[1];
        sum0_0[4 ] <= - a3_2_4_r - a2_2_50_r; sum0_1[4 ] <=   a1_2_56_r + a0_2_84_r; sum0_2[4 ] <=   a6_0_9_r + a3_5_46_r; sum0_3[4 ] <=   a9_0_60_r + a8_5_82_r; sum0_4[4 ] <= - a2_3_13_r - a3_3_42_r; sum0_5[4 ] <=   a0_3_63_r + a1_3_80_r; sum0_6[4 ] <= - a7_0_17_r + a2_0_38_r; sum0_7[4 ] <= - a9_5_66_r - a5_5_78_r; sum0_8[4 ] <=   a4_4_21_r + a6_4_34_r; sum0_9[4 ] <=   a0_1_68_r - a5_4_77_r; sum0_10[4 ] <= - a7_4_26_r - a4_1_30_r; sum0_11[4 ] <=   a8_4_72_r + a1_4_74_r; sum0_12[4 ] <= - t[0];
        sum0_0[5 ] <= - a3_5_4_r - a6_0_50_r; sum0_1[5 ] <= - a8_5_56_r - a9_0_84_r; sum0_2[5 ] <=   a6_5_9_r + a3_0_46_r; sum0_3[5 ] <=   a9_5_60_r + a8_0_82_r; sum0_4[5 ] <= - a7_4_13_r + a2_4_42_r; sum0_5[5 ] <= - a9_1_63_r - a5_1_80_r; sum0_6[5 ] <= - a7_1_17_r - a4_4_38_r; sum0_7[5 ] <=   a8_1_66_r + a1_1_78_r; sum0_8[5 ] <=   a6_2_21_r + a4_2_34_r; sum0_9[5 ] <= - a5_2_68_r + a0_3_77_r; sum0_10[5 ] <= - a3_2_26_r - a2_2_30_r; sum0_11[5 ] <=   a1_2_72_r + a0_2_74_r; sum0_12[5 ] <= + t[0];
        sum0_0[6 ] <=   c0_53  + c1_85;
        sum0_0[7 ] <=   b0_60_r + b1_89_r + b2_74_r; sum0_1[7 ] <= b3_21_r - b4_42_r - b5_84_r;
        sum0_0[8 ] <=   a9_3_4_r + a8_2_50_r; sum0_1[8 ] <=   a3_2_56_r + a6_3_84_r; sum0_2[8 ] <=   a1_5_9_r + a0_5_46_r; sum0_3[8 ] <= - a2_5_60_r - a3_5_82_r; sum0_4[8 ] <= - a1_3_13_r - a8_3_42_r; sum0_5[8 ] <=   a7_3_63_r + a4_2_80_r; sum0_6[8 ] <= - a9_5_17_r - a5_5_38_r; sum0_7[8 ] <=   a2_0_66_r - a7_0_78_r; sum0_8[8 ] <= - a1_1_21_r - a0_1_34_r; sum0_9[8 ] <=   a2_1_68_r + a3_1_77_r; sum0_10[8 ] <=   a5_1_26_r + a9_1_30_r; sum0_11[8 ] <=   a7_4_72_r - a2_4_74_r; sum0_12[8 ] <= + t[1];
        sum0_0[9 ] <= - a2_1_4_r - a3_1_50_r; sum0_1[9 ] <=   a0_1_56_r + a1_1_84_r; sum0_2[9 ] <=   a7_3_9_r - a2_3_46_r; sum0_3[9 ] <=   a9_2_60_r + a5_2_82_r; sum0_4[9 ] <=   a4_0_13_r + a7_5_42_r; sum0_5[9 ] <= - a1_5_63_r - a8_5_80_r; sum0_6[9 ] <=   a3_4_17_r + a2_4_38_r; sum0_7[9 ] <= - a1_4_66_r - a0_4_78_r; sum0_8[9 ] <=   a6_3_21_r + a3_2_34_r; sum0_9[9 ] <=   a9_3_68_r + a8_2_77_r; sum0_10[9 ] <=   a4_5_26_r + a6_5_30_r; sum0_11[9 ] <=   a0_0_72_r - a5_5_74_r; sum0_12[9 ] <= - t[0];
        sum0_0[10] <= - a6_1_4_r - a4_1_50_r; sum0_1[10] <=   a5_1_56_r - a0_4_84_r; sum0_2[10] <=   a2_2_9_r - a7_2_46_r; sum0_3[10] <= - a5_3_60_r - a9_3_82_r; sum0_4[10] <=   a6_4_13_r + a4_4_42_r; sum0_5[10] <= - a5_4_63_r + a0_1_80_r; sum0_6[10] <= - a2_5_17_r + a7_5_38_r; sum0_7[10] <=   a5_0_66_r + a9_0_78_r; sum0_8[10] <= - a7_0_21_r - a4_5_34_r; sum0_9[10] <=   a8_0_68_r + a1_0_77_r; sum0_10[10] <=   a4_2_26_r + a7_3_30_r; sum0_11[10] <= - a1_3_72_r - a8_3_74_r; sum0_12[10] <= + t[0];
        sum0_0[11] <=   a1_3_4_r + a0_3_50_r; sum0_1[11] <= - a2_3_56_r - a3_3_84_r; sum0_2[11] <=   a9_1_9_r + a5_1_46_r; sum0_3[11] <= - a2_4_60_r + a7_4_82_r; sum0_4[11] <=   a8_0_13_r + a9_5_42_r; sum0_5[11] <=   a6_5_63_r + a3_0_80_r; sum0_6[11] <= - a0_2_17_r + a5_3_38_r; sum0_7[11] <= - a6_3_66_r - a4_3_78_r; sum0_8[11] <= - a5_0_21_r + a0_5_34_r; sum0_9[11] <=   a4_0_68_r + a6_0_77_r; sum0_10[11] <= - a9_4_26_r - a5_4_30_r; sum0_11[11] <=   a2_1_72_r - a7_1_74_r; sum0_12[11] <= - t[1];
        sum0_0[12] <=   b0_84_r + b1_60_r - b2_42_r; sum0_1[12] <= - b3_89_r - b4_21_r + b5_74_r;
        sum0_0[13] <= - a0_0_4_r - a1_0_50_r; sum0_1[13] <=   a3_0_56_r + a2_0_84_r; sum0_2[13] <= - a5_4_9_r + a0_1_46_r; sum0_3[13] <=   a4_4_60_r + a6_4_82_r; sum0_4[13] <=   a9_3_13_r + a5_3_42_r; sum0_5[13] <= - a2_2_63_r + a7_2_80_r; sum0_6[13] <= - a8_3_17_r - a9_2_38_r; sum0_7[13] <= - a6_2_66_r - a3_3_78_r; sum0_8[13] <=   a1_4_21_r + a8_4_34_r; sum0_9[13] <= - a7_4_68_r - a4_1_77_r; sum0_10[13] <= - a0_5_26_r - a1_5_30_r; sum0_11[13] <=   a3_5_72_r + a2_5_74_r; sum0_12[13] <= + t[1];
        sum0_0[14] <=   a4_2_4_r + a7_3_50_r; sum0_1[14] <= - a1_3_56_r - a8_3_84_r; sum0_2[14] <=   a4_1_9_r + a6_1_46_r; sum0_3[14] <=   a0_4_60_r - a5_1_82_r; sum0_4[14] <= - a3_0_13_r - a2_0_42_r; sum0_5[14] <=   a1_0_63_r + a0_0_80_r; sum0_6[14] <= - a6_3_17_r - a4_3_38_r; sum0_7[14] <=   a5_3_66_r - a0_2_78_r; sum0_8[14] <= - a7_5_21_r - a4_0_34_r; sum0_9[14] <=   a8_5_68_r + a1_5_77_r; sum0_10[14] <=   a6_4_26_r + a3_1_30_r; sum0_11[14] <=   a9_4_72_r + a8_1_74_r; sum0_12[14] <= - t[0];
        sum0_0[15] <= - a7_4_4_r - a4_1_50_r; sum0_1[15] <=   a8_4_56_r + a1_4_84_r; sum0_2[15] <=   a2_2_9_r + a3_2_46_r; sum0_3[15] <= - a0_2_60_r - a1_2_82_r; sum0_4[15] <=   a2_1_13_r - a7_1_42_r; sum0_5[15] <= - a5_4_63_r - a9_4_80_r; sum0_6[15] <= - a7_5_17_r + a2_5_38_r; sum0_7[15] <= - a9_0_66_r - a5_0_78_r; sum0_8[15] <= - a2_0_21_r - a3_0_34_r; sum0_9[15] <=   a0_0_68_r + a1_0_77_r; sum0_10[15] <= - a2_3_26_r + a7_3_30_r; sum0_11[15] <=   a5_2_72_r + a9_2_74_r; sum0_12[15] <= + t[0];
    end
end
//stage 4
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d4 <= 0;
        for (i = 0; i < 16; i = i + 1) begin
            sum1_0[i] <= 0; sum1_1[i] <= 0; sum1_2[i] <= 0; sum1_3[i] <= 0;
        end
    end
    else begin
        i_valid_d4 <= i_valid_d3;
        sum1_0[0 ] <= sum0_0[0 ] + sum0_1[0 ] + sum0_2[0 ]; sum1_1[0 ] <= sum0_3[0 ] + sum0_4[0 ] + sum0_5[0 ]; sum1_2[0 ] <= sum0_6[0 ] + sum0_7[0 ] + sum0_8[0 ]; sum1_3[0 ] <= sum0_9[0 ] + sum0_10[0 ] + sum0_11[0 ] + sum0_12[0 ];
        sum1_0[1 ] <= sum0_0[1 ] + sum0_1[1 ] + sum0_2[1 ]; sum1_1[1 ] <= sum0_3[1 ] + sum0_4[1 ] + sum0_5[1 ]; sum1_2[1 ] <= sum0_6[1 ] + sum0_7[1 ] + sum0_8[1 ]; sum1_3[1 ] <= sum0_9[1 ] + sum0_10[1 ] + sum0_11[1 ] + sum0_12[1 ];
        sum1_0[2 ] <= sum0_0[2 ] + sum0_1[2 ];
        sum1_0[3 ] <= sum0_0[3 ] + sum0_1[3 ] + sum0_2[3 ]; sum1_1[3 ] <= sum0_3[3 ] + sum0_4[3 ] + sum0_5[3 ]; sum1_2[3 ] <= sum0_6[3 ] + sum0_7[3 ] + sum0_8[3 ]; sum1_3[3 ] <= sum0_9[3 ] + sum0_10[3 ] + sum0_11[3 ] + sum0_12[3 ];
        sum1_0[4 ] <= sum0_0[4 ] + sum0_1[4 ] + sum0_2[4 ]; sum1_1[4 ] <= sum0_3[4 ] + sum0_4[4 ] + sum0_5[4 ]; sum1_2[4 ] <= sum0_6[4 ] + sum0_7[4 ] + sum0_8[4 ]; sum1_3[4 ] <= sum0_9[4 ] + sum0_10[4 ] + sum0_11[4 ] + sum0_12[4 ];
        sum1_0[5 ] <= sum0_0[5 ] + sum0_1[5 ] + sum0_2[5 ]; sum1_1[5 ] <= sum0_3[5 ] + sum0_4[5 ] + sum0_5[5 ]; sum1_2[5 ] <= sum0_6[5 ] + sum0_7[5 ] + sum0_8[5 ]; sum1_3[5 ] <= sum0_9[5 ] + sum0_10[5 ] + sum0_11[5 ] + sum0_12[5 ];
        sum1_0[6 ] <= sum0_0[6 ];
        sum1_0[7 ] <= sum0_0[7 ] + sum0_1[7 ];
        sum1_0[8 ] <= sum0_0[8 ] + sum0_1[8 ] + sum0_2[8 ]; sum1_1[8 ] <= sum0_3[8 ] + sum0_4[8 ] + sum0_5[8 ]; sum1_2[8 ] <= sum0_6[8 ] + sum0_7[8 ] + sum0_8[8 ]; sum1_3[8 ] <= sum0_9[8 ] + sum0_10[8 ] + sum0_11[8 ] + sum0_12[8 ];
        sum1_0[9 ] <= sum0_0[9 ] + sum0_1[9 ] + sum0_2[9 ]; sum1_1[9 ] <= sum0_3[9 ] + sum0_4[9 ] + sum0_5[9 ]; sum1_2[9 ] <= sum0_6[9 ] + sum0_7[9 ] + sum0_8[9 ]; sum1_3[9 ] <= sum0_9[9 ] + sum0_10[9 ] + sum0_11[9 ] + sum0_12[9 ];
        sum1_0[10] <= sum0_0[10] + sum0_1[10] + sum0_2[10]; sum1_1[10] <= sum0_3[10] + sum0_4[10] + sum0_5[10]; sum1_2[10] <= sum0_6[10] + sum0_7[10] + sum0_8[10]; sum1_3[10] <= sum0_9[10] + sum0_10[10] + sum0_11[10] + sum0_12[10];
        sum1_0[11] <= sum0_0[11] + sum0_1[11] + sum0_2[11]; sum1_1[11] <= sum0_3[11] + sum0_4[11] + sum0_5[11]; sum1_2[11] <= sum0_6[11] + sum0_7[11] + sum0_8[11]; sum1_3[11] <= sum0_9[11] + sum0_10[11] + sum0_11[11] + sum0_12[11];
        sum1_0[12] <= sum0_0[12] + sum0_1[12];
        sum1_0[13] <= sum0_0[13] + sum0_1[13] + sum0_2[13]; sum1_1[13] <= sum0_3[13] + sum0_4[13] + sum0_5[13]; sum1_2[13] <= sum0_6[13] + sum0_7[13] + sum0_8[13]; sum1_3[13] <= sum0_9[13] + sum0_10[13] + sum0_11[13] + sum0_12[13];
        sum1_0[14] <= sum0_0[14] + sum0_1[14] + sum0_2[14]; sum1_1[14] <= sum0_3[14] + sum0_4[14] + sum0_5[14]; sum1_2[14] <= sum0_6[14] + sum0_7[14] + sum0_8[14]; sum1_3[14] <= sum0_9[14] + sum0_10[14] + sum0_11[14] + sum0_12[14];
        sum1_0[15] <= sum0_0[15] + sum0_1[15] + sum0_2[15]; sum1_1[15] <= sum0_3[15] + sum0_4[15] + sum0_5[15]; sum1_2[15] <= sum0_6[15] + sum0_7[15] + sum0_8[15]; sum1_3[15] <= sum0_9[15] + sum0_10[15] + sum0_11[15] + sum0_12[15];
    end
end
//stage 5
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d5 <= 0;
        for (i = 0; i < 16; i = i + 1) begin
            sum2_0[i] <= 0; sum2_1[i] <= 0;
        end
    end
    else begin
        i_valid_d5 <= i_valid_d4;
        sum2_0[0 ] <= sum1_0[0 ] + sum1_1[0 ]; sum2_1[0 ] <= sum1_2[0 ] + sum1_3[0 ];
        sum2_0[1 ] <= sum1_0[1 ] + sum1_1[1 ]; sum2_1[1 ] <= sum1_2[1 ] + sum1_3[1 ];
        sum2_0[2 ] <= sum1_0[2 ] + sum1_1[2 ];
        sum2_0[3 ] <= sum1_0[3 ] + sum1_1[3 ]; sum2_1[3 ] <= sum1_2[3 ] + sum1_3[3 ];
        sum2_0[4 ] <= sum1_0[4 ] + sum1_1[4 ]; sum2_1[4 ] <= sum1_2[4 ] + sum1_3[4 ];
        sum2_0[5 ] <= sum1_0[5 ] + sum1_1[5 ]; sum2_1[5 ] <= sum1_2[5 ] + sum1_3[5 ];
        sum2_0[6 ] <= sum1_0[6 ];
        sum2_0[7 ] <= sum1_0[7 ] + sum1_1[7 ];
        sum2_0[8 ] <= sum1_0[8 ] + sum1_1[8 ]; sum2_1[8 ] <= sum1_2[8 ] + sum1_3[8 ];
        sum2_0[9 ] <= sum1_0[9 ] + sum1_1[9 ]; sum2_1[9 ] <= sum1_2[9 ] + sum1_3[9 ];
        sum2_0[10] <= sum1_0[10] + sum1_1[10]; sum2_1[10] <= sum1_2[10] + sum1_3[10];
        sum2_0[11] <= sum1_0[11] + sum1_1[11]; sum2_1[11] <= sum1_2[11] + sum1_3[11];
        sum2_0[12] <= sum1_0[12] + sum1_1[12];
        sum2_0[13] <= sum1_0[13] + sum1_1[13]; sum2_1[13] <= sum1_2[13] + sum1_3[13];
        sum2_0[14] <= sum1_0[14] + sum1_1[14]; sum2_1[14] <= sum1_2[14] + sum1_3[14];
        sum2_0[15] <= sum1_0[15] + sum1_1[15]; sum2_1[15] <= sum1_2[15] + sum1_3[15];
    end
end
//stage 6
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        o_valid <= 0;
        o_0  <= 0;
        o_1  <= 0;
        o_2  <= 0;
        o_3  <= 0;
        o_4  <= 0;
        o_5  <= 0;
        o_6  <= 0;
        o_7  <= 0;
        o_8  <= 0;
        o_9  <= 0;
        o_10 <= 0;
        o_11 <= 0;
        o_12 <= 0;
        o_13 <= 0;
        o_14 <= 0;
        o_15 <= 0;
    end
    else begin
        o_valid <= i_valid_d5;
        o_0  <= sum2_0[0 ] + sum2_1[0 ];
        o_1  <= sum2_0[1 ] + sum2_1[1 ];
        o_2  <= sum2_0[2 ];
        o_3  <= sum2_0[3 ] + sum2_1[3 ];
        o_4  <= sum2_0[4 ] + sum2_1[4 ];
        o_5  <= sum2_0[5 ] + sum2_1[5 ];
        o_6  <= sum2_0[6 ];
        o_7  <= sum2_0[7 ];
        o_8  <= sum2_0[8 ] + sum2_1[8 ];
        o_9  <= sum2_0[9 ] + sum2_1[9 ];
        o_10 <= sum2_0[10] + sum2_1[10];
        o_11 <= sum2_0[11] + sum2_1[11];
        o_12 <= sum2_0[12];
        o_13 <= sum2_0[13] + sum2_1[13];
        o_14 <= sum2_0[14] + sum2_1[14];
        o_15 <= sum2_0[15] + sum2_1[15];
    end
end

endmodule
