//describe  : MCM(RAG-n算法)生成乘法单元，求和得到结果
//input     : 16个蝶形单元
//output    : 16个系数结果(后需右移)
//delay     : 3 clk
module dct2_calculate_32#(
    parameter IN_WIDTH = 18
)
(
//system input
    input                                   clk     ,
    input                                   rst_n   ,
//input parameter
    input               [2 : 0]             i_size  ,//4:DCT_32, 5:DCT_64
//input data                                         //N=64     N=32
    input                                   i_valid ,
    input       signed  [IN_WIDTH - 1 : 0]  i_0     ,//EO0      O0 
    input       signed  [IN_WIDTH - 1 : 0]  i_1     ,//EO1      O1 
    input       signed  [IN_WIDTH - 1 : 0]  i_2     ,//EO2      O2 
    input       signed  [IN_WIDTH - 1 : 0]  i_3     ,//EO3      O3 
    input       signed  [IN_WIDTH - 1 : 0]  i_4     ,//EO4      O4 
    input       signed  [IN_WIDTH - 1 : 0]  i_5     ,//EO5      O5 
    input       signed  [IN_WIDTH - 1 : 0]  i_6     ,//EO6      O6 
    input       signed  [IN_WIDTH - 1 : 0]  i_7     ,//EO7      O7 
    input       signed  [IN_WIDTH - 1 : 0]  i_8     ,//EO8      O8 
    input       signed  [IN_WIDTH - 1 : 0]  i_9     ,//EO9      O9 
    input       signed  [IN_WIDTH - 1 : 0]  i_10    ,//EO10     O10
    input       signed  [IN_WIDTH - 1 : 0]  i_11    ,//EO11     O11
    input       signed  [IN_WIDTH - 1 : 0]  i_12    ,//EO12     O12
    input       signed  [IN_WIDTH - 1 : 0]  i_13    ,//EO13     O13
    input       signed  [IN_WIDTH - 1 : 0]  i_14    ,//EO14     O14
    input       signed  [IN_WIDTH - 1 : 0]  i_15    ,//EO15     O15
//output pre_coeff
    output reg                              o_valid ,
    output reg  signed  [IN_WIDTH + 9 : 0]  o_0     ,//2        1
    output reg  signed  [IN_WIDTH + 9 : 0]  o_1     ,//6        3
    output reg  signed  [IN_WIDTH + 9 : 0]  o_2     ,//10       5
    output reg  signed  [IN_WIDTH + 9 : 0]  o_3     ,//14       7
    output reg  signed  [IN_WIDTH + 9 : 0]  o_4     ,//18       9
    output reg  signed  [IN_WIDTH + 9 : 0]  o_5     ,//22       11
    output reg  signed  [IN_WIDTH + 9 : 0]  o_6     ,//26       13
    output reg  signed  [IN_WIDTH + 9 : 0]  o_7     ,//30       15
    output reg  signed  [IN_WIDTH + 9 : 0]  o_8     ,//34(0)    17
    output reg  signed  [IN_WIDTH + 9 : 0]  o_9     ,//38(0)    19
    output reg  signed  [IN_WIDTH + 9 : 0]  o_10    ,//42(0)    21
    output reg  signed  [IN_WIDTH + 9 : 0]  o_11    ,//46(0)    23
    output reg  signed  [IN_WIDTH + 9 : 0]  o_12    ,//50(0)    25
    output reg  signed  [IN_WIDTH + 9 : 0]  o_13    ,//54(0)    27
    output reg  signed  [IN_WIDTH + 9 : 0]  o_14    ,//58(0)    29
    output reg  signed  [IN_WIDTH + 9 : 0]  o_15     //62(0)    31
);

integer i;
localparam SIZE64 = 3'd5;

//mcm
//90 90 88 85 82 78 73 67 / 61 54 46 38 31 22 13 4
    wire signed [IN_WIDTH + 7 : 0] i_0_32 = i_0 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_0_31 = i_0_32 - i_0;
    wire signed [IN_WIDTH + 7 : 0] i_0_8 = i_0 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_0_23 = i_0_31 - i_0_8;
    wire signed [IN_WIDTH + 7 : 0] i_0_4 = i_0 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_0_27 = i_0_31 - i_0_4;
    wire signed [IN_WIDTH + 7 : 0] i_0_39 = i_0_31 + i_0_8;
    wire signed [IN_WIDTH + 7 : 0] i_0_62 = i_0_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_0_61 = i_0_62 - i_0;
    wire signed [IN_WIDTH + 7 : 0] i_0_22 = i_0_23 - i_0;
    wire signed [IN_WIDTH + 7 : 0] i_0_11 = i_0_22 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_0_26 = i_0_27 - i_0;
    wire signed [IN_WIDTH + 7 : 0] i_0_13 = i_0_26 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_0_19 = i_0_23 - i_0_4;
    wire signed [IN_WIDTH + 7 : 0] i_0_64 = i_0 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_0_41 = i_0_64 - i_0_23;
    wire signed [IN_WIDTH + 7 : 0] i_0_46 = i_0_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_0_45 = i_0_46 - i_0;
    wire signed [IN_WIDTH + 7 : 0] i_0_128 = i_0 <<< 7;
    wire signed [IN_WIDTH + 7 : 0] i_0_67 = i_0_128 - i_0_61;
    wire signed [IN_WIDTH + 7 : 0] i_0_73 = i_0_27 + i_0_46;
    wire signed [IN_WIDTH + 7 : 0] i_0_108 = i_0_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_0_85 = i_0_108 - i_0_23;
    wire signed [IN_WIDTH + 7 : 0] i_0_90 = i_0_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_0_88 = i_0_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_0_82 = i_0_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_0_78 = i_0_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_0_54 = i_0_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_0_38 = i_0_19 <<< 1;
//90 82 67 46 22 -4 -31 -54 / -73 -85 -90 -88 -78 -61 -38 -13
    wire signed [IN_WIDTH + 7 : 0] i_1_32 = i_1 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_1_31 = i_1_32 - i_1;
    wire signed [IN_WIDTH + 7 : 0] i_1_8 = i_1 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_1_23 = i_1_31 - i_1_8;
    wire signed [IN_WIDTH + 7 : 0] i_1_4 = i_1 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_1_27 = i_1_31 - i_1_4;
    wire signed [IN_WIDTH + 7 : 0] i_1_39 = i_1_31 + i_1_8;
    wire signed [IN_WIDTH + 7 : 0] i_1_62 = i_1_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_1_61 = i_1_62 - i_1;
    wire signed [IN_WIDTH + 7 : 0] i_1_22 = i_1_23 - i_1;
    wire signed [IN_WIDTH + 7 : 0] i_1_11 = i_1_22 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_1_26 = i_1_27 - i_1;
    wire signed [IN_WIDTH + 7 : 0] i_1_13 = i_1_26 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_1_19 = i_1_23 - i_1_4;
    wire signed [IN_WIDTH + 7 : 0] i_1_64 = i_1 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_1_41 = i_1_64 - i_1_23;
    wire signed [IN_WIDTH + 7 : 0] i_1_46 = i_1_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_1_45 = i_1_46 - i_1;
    wire signed [IN_WIDTH + 7 : 0] i_1_128 = i_1 <<< 7;
    wire signed [IN_WIDTH + 7 : 0] i_1_67 = i_1_128 - i_1_61;
    wire signed [IN_WIDTH + 7 : 0] i_1_73 = i_1_27 + i_1_46;
    wire signed [IN_WIDTH + 7 : 0] i_1_108 = i_1_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_1_85 = i_1_108 - i_1_23;
    wire signed [IN_WIDTH + 7 : 0] i_1_90 = i_1_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_1_88 = i_1_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_1_82 = i_1_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_1_78 = i_1_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_1_54 = i_1_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_1_38 = i_1_19 <<< 1;
//88 67 31 -13 -54 -82 -90 -78 / -46 -4 38 73 90 85 61 22
    wire signed [IN_WIDTH + 7 : 0] i_2_32 = i_2 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_2_31 = i_2_32 - i_2;
    wire signed [IN_WIDTH + 7 : 0] i_2_8 = i_2 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_2_23 = i_2_31 - i_2_8;
    wire signed [IN_WIDTH + 7 : 0] i_2_4 = i_2 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_2_27 = i_2_31 - i_2_4;
    wire signed [IN_WIDTH + 7 : 0] i_2_39 = i_2_31 + i_2_8;
    wire signed [IN_WIDTH + 7 : 0] i_2_62 = i_2_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_2_61 = i_2_62 - i_2;
    wire signed [IN_WIDTH + 7 : 0] i_2_22 = i_2_23 - i_2;
    wire signed [IN_WIDTH + 7 : 0] i_2_11 = i_2_22 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_2_26 = i_2_27 - i_2;
    wire signed [IN_WIDTH + 7 : 0] i_2_13 = i_2_26 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_2_19 = i_2_23 - i_2_4;
    wire signed [IN_WIDTH + 7 : 0] i_2_64 = i_2 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_2_41 = i_2_64 - i_2_23;
    wire signed [IN_WIDTH + 7 : 0] i_2_46 = i_2_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_2_45 = i_2_46 - i_2;
    wire signed [IN_WIDTH + 7 : 0] i_2_128 = i_2 <<< 7;
    wire signed [IN_WIDTH + 7 : 0] i_2_67 = i_2_128 - i_2_61;
    wire signed [IN_WIDTH + 7 : 0] i_2_73 = i_2_27 + i_2_46;
    wire signed [IN_WIDTH + 7 : 0] i_2_108 = i_2_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_2_85 = i_2_108 - i_2_23;
    wire signed [IN_WIDTH + 7 : 0] i_2_90 = i_2_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_2_88 = i_2_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_2_82 = i_2_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_2_78 = i_2_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_2_54 = i_2_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_2_38 = i_2_19 <<< 1;
//85 46 -13 -67 -90 -73 -22 38 / 82 88 54 -4 -61 -90 -78 -31
    wire signed [IN_WIDTH + 7 : 0] i_3_32 = i_3 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_3_31 = i_3_32 - i_3;
    wire signed [IN_WIDTH + 7 : 0] i_3_8 = i_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_3_23 = i_3_31 - i_3_8;
    wire signed [IN_WIDTH + 7 : 0] i_3_4 = i_3 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_3_27 = i_3_31 - i_3_4;
    wire signed [IN_WIDTH + 7 : 0] i_3_39 = i_3_31 + i_3_8;
    wire signed [IN_WIDTH + 7 : 0] i_3_62 = i_3_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_3_61 = i_3_62 - i_3;
    wire signed [IN_WIDTH + 7 : 0] i_3_22 = i_3_23 - i_3;
    wire signed [IN_WIDTH + 7 : 0] i_3_11 = i_3_22 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_3_26 = i_3_27 - i_3;
    wire signed [IN_WIDTH + 7 : 0] i_3_13 = i_3_26 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_3_19 = i_3_23 - i_3_4;
    wire signed [IN_WIDTH + 7 : 0] i_3_64 = i_3 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_3_41 = i_3_64 - i_3_23;
    wire signed [IN_WIDTH + 7 : 0] i_3_46 = i_3_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_3_45 = i_3_46 - i_3;
    wire signed [IN_WIDTH + 7 : 0] i_3_128 = i_3 <<< 7;
    wire signed [IN_WIDTH + 7 : 0] i_3_67 = i_3_128 - i_3_61;
    wire signed [IN_WIDTH + 7 : 0] i_3_73 = i_3_27 + i_3_46;
    wire signed [IN_WIDTH + 7 : 0] i_3_108 = i_3_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_3_85 = i_3_108 - i_3_23;
    wire signed [IN_WIDTH + 7 : 0] i_3_90 = i_3_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_3_88 = i_3_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_3_82 = i_3_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_3_78 = i_3_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_3_54 = i_3_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_3_38 = i_3_19 <<< 1;
//82 22 -54 -90 -61 13 78 85 / 31 -46 -90 -67 4 73 88 38
    wire signed [IN_WIDTH + 7 : 0] i_4_32 = i_4 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_4_31 = i_4_32 - i_4;
    wire signed [IN_WIDTH + 7 : 0] i_4_8 = i_4 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_4_23 = i_4_31 - i_4_8;
    wire signed [IN_WIDTH + 7 : 0] i_4_4 = i_4 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_4_27 = i_4_31 - i_4_4;
    wire signed [IN_WIDTH + 7 : 0] i_4_39 = i_4_31 + i_4_8;
    wire signed [IN_WIDTH + 7 : 0] i_4_62 = i_4_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_4_61 = i_4_62 - i_4;
    wire signed [IN_WIDTH + 7 : 0] i_4_22 = i_4_23 - i_4;
    wire signed [IN_WIDTH + 7 : 0] i_4_11 = i_4_22 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_4_26 = i_4_27 - i_4;
    wire signed [IN_WIDTH + 7 : 0] i_4_13 = i_4_26 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_4_19 = i_4_23 - i_4_4;
    wire signed [IN_WIDTH + 7 : 0] i_4_64 = i_4 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_4_41 = i_4_64 - i_4_23;
    wire signed [IN_WIDTH + 7 : 0] i_4_46 = i_4_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_4_45 = i_4_46 - i_4;
    wire signed [IN_WIDTH + 7 : 0] i_4_128 = i_4 <<< 7;
    wire signed [IN_WIDTH + 7 : 0] i_4_67 = i_4_128 - i_4_61;
    wire signed [IN_WIDTH + 7 : 0] i_4_73 = i_4_27 + i_4_46;
    wire signed [IN_WIDTH + 7 : 0] i_4_108 = i_4_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_4_85 = i_4_108 - i_4_23;
    wire signed [IN_WIDTH + 7 : 0] i_4_90 = i_4_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_4_88 = i_4_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_4_82 = i_4_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_4_78 = i_4_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_4_54 = i_4_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_4_38 = i_4_19 <<< 1;
//78 -4 -82 -73 13 85 67 -22 / -88 -61 31 90 54 -38 -90 -46
    wire signed [IN_WIDTH + 7 : 0] i_5_32 = i_5 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_5_31 = i_5_32 - i_5;
    wire signed [IN_WIDTH + 7 : 0] i_5_8 = i_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_5_23 = i_5_31 - i_5_8;
    wire signed [IN_WIDTH + 7 : 0] i_5_4 = i_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_5_27 = i_5_31 - i_5_4;
    wire signed [IN_WIDTH + 7 : 0] i_5_39 = i_5_31 + i_5_8;
    wire signed [IN_WIDTH + 7 : 0] i_5_62 = i_5_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_5_61 = i_5_62 - i_5;
    wire signed [IN_WIDTH + 7 : 0] i_5_22 = i_5_23 - i_5;
    wire signed [IN_WIDTH + 7 : 0] i_5_11 = i_5_22 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_5_26 = i_5_27 - i_5;
    wire signed [IN_WIDTH + 7 : 0] i_5_13 = i_5_26 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_5_19 = i_5_23 - i_5_4;
    wire signed [IN_WIDTH + 7 : 0] i_5_64 = i_5 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_5_41 = i_5_64 - i_5_23;
    wire signed [IN_WIDTH + 7 : 0] i_5_46 = i_5_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_5_45 = i_5_46 - i_5;
    wire signed [IN_WIDTH + 7 : 0] i_5_128 = i_5 <<< 7;
    wire signed [IN_WIDTH + 7 : 0] i_5_67 = i_5_128 - i_5_61;
    wire signed [IN_WIDTH + 7 : 0] i_5_73 = i_5_27 + i_5_46;
    wire signed [IN_WIDTH + 7 : 0] i_5_108 = i_5_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_5_85 = i_5_108 - i_5_23;
    wire signed [IN_WIDTH + 7 : 0] i_5_90 = i_5_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_5_88 = i_5_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_5_82 = i_5_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_5_78 = i_5_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_5_54 = i_5_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_5_38 = i_5_19 <<< 1;
//73 -31 -90 -22 78 67 -38 -90 / -13 82 61 -46 -88 -4 85 54
    wire signed [IN_WIDTH + 7 : 0] i_6_32 = i_6 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_6_31 = i_6_32 - i_6;
    wire signed [IN_WIDTH + 7 : 0] i_6_8 = i_6 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_6_23 = i_6_31 - i_6_8;
    wire signed [IN_WIDTH + 7 : 0] i_6_4 = i_6 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_6_27 = i_6_31 - i_6_4;
    wire signed [IN_WIDTH + 7 : 0] i_6_39 = i_6_31 + i_6_8;
    wire signed [IN_WIDTH + 7 : 0] i_6_62 = i_6_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_6_61 = i_6_62 - i_6;
    wire signed [IN_WIDTH + 7 : 0] i_6_22 = i_6_23 - i_6;
    wire signed [IN_WIDTH + 7 : 0] i_6_11 = i_6_22 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_6_26 = i_6_27 - i_6;
    wire signed [IN_WIDTH + 7 : 0] i_6_13 = i_6_26 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_6_19 = i_6_23 - i_6_4;
    wire signed [IN_WIDTH + 7 : 0] i_6_64 = i_6 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_6_41 = i_6_64 - i_6_23;
    wire signed [IN_WIDTH + 7 : 0] i_6_46 = i_6_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_6_45 = i_6_46 - i_6;
    wire signed [IN_WIDTH + 7 : 0] i_6_128 = i_6 <<< 7;
    wire signed [IN_WIDTH + 7 : 0] i_6_67 = i_6_128 - i_6_61;
    wire signed [IN_WIDTH + 7 : 0] i_6_73 = i_6_27 + i_6_46;
    wire signed [IN_WIDTH + 7 : 0] i_6_108 = i_6_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_6_85 = i_6_108 - i_6_23;
    wire signed [IN_WIDTH + 7 : 0] i_6_90 = i_6_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_6_88 = i_6_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_6_82 = i_6_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_6_78 = i_6_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_6_54 = i_6_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_6_38 = i_6_19 <<< 1;
//67 -54 -78 38 85 -22 -90 4 / 90 13 -88 -31 82 46 -73 -61
    wire signed [IN_WIDTH + 7 : 0] i_7_32 = i_7 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_7_31 = i_7_32 - i_7;
    wire signed [IN_WIDTH + 7 : 0] i_7_8 = i_7 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_7_23 = i_7_31 - i_7_8;
    wire signed [IN_WIDTH + 7 : 0] i_7_4 = i_7 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_7_27 = i_7_31 - i_7_4;
    wire signed [IN_WIDTH + 7 : 0] i_7_39 = i_7_31 + i_7_8;
    wire signed [IN_WIDTH + 7 : 0] i_7_62 = i_7_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_7_61 = i_7_62 - i_7;
    wire signed [IN_WIDTH + 7 : 0] i_7_22 = i_7_23 - i_7;
    wire signed [IN_WIDTH + 7 : 0] i_7_11 = i_7_22 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_7_26 = i_7_27 - i_7;
    wire signed [IN_WIDTH + 7 : 0] i_7_13 = i_7_26 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_7_19 = i_7_23 - i_7_4;
    wire signed [IN_WIDTH + 7 : 0] i_7_64 = i_7 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_7_41 = i_7_64 - i_7_23;
    wire signed [IN_WIDTH + 7 : 0] i_7_46 = i_7_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_7_45 = i_7_46 - i_7;
    wire signed [IN_WIDTH + 7 : 0] i_7_128 = i_7 <<< 7;
    wire signed [IN_WIDTH + 7 : 0] i_7_67 = i_7_128 - i_7_61;
    wire signed [IN_WIDTH + 7 : 0] i_7_73 = i_7_27 + i_7_46;
    wire signed [IN_WIDTH + 7 : 0] i_7_108 = i_7_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_7_85 = i_7_108 - i_7_23;
    wire signed [IN_WIDTH + 7 : 0] i_7_90 = i_7_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_7_88 = i_7_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_7_82 = i_7_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_7_78 = i_7_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_7_54 = i_7_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_7_38 = i_7_19 <<< 1;
//61 -73 -46 82 31 -88 -13 90 / -4 -90 22 85 -38 -78 54 67
    wire signed [IN_WIDTH + 7 : 0] i_8_32 = i_8 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_8_31 = i_8_32 - i_8;
    wire signed [IN_WIDTH + 7 : 0] i_8_8 = i_8 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_8_23 = i_8_31 - i_8_8;
    wire signed [IN_WIDTH + 7 : 0] i_8_4 = i_8 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_8_27 = i_8_31 - i_8_4;
    wire signed [IN_WIDTH + 7 : 0] i_8_39 = i_8_31 + i_8_8;
    wire signed [IN_WIDTH + 7 : 0] i_8_62 = i_8_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_8_61 = i_8_62 - i_8;
    wire signed [IN_WIDTH + 7 : 0] i_8_22 = i_8_23 - i_8;
    wire signed [IN_WIDTH + 7 : 0] i_8_11 = i_8_22 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_8_26 = i_8_27 - i_8;
    wire signed [IN_WIDTH + 7 : 0] i_8_13 = i_8_26 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_8_19 = i_8_23 - i_8_4;
    wire signed [IN_WIDTH + 7 : 0] i_8_64 = i_8 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_8_41 = i_8_64 - i_8_23;
    wire signed [IN_WIDTH + 7 : 0] i_8_46 = i_8_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_8_45 = i_8_46 - i_8;
    wire signed [IN_WIDTH + 7 : 0] i_8_128 = i_8 <<< 7;
    wire signed [IN_WIDTH + 7 : 0] i_8_67 = i_8_128 - i_8_61;
    wire signed [IN_WIDTH + 7 : 0] i_8_73 = i_8_27 + i_8_46;
    wire signed [IN_WIDTH + 7 : 0] i_8_108 = i_8_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_8_85 = i_8_108 - i_8_23;
    wire signed [IN_WIDTH + 7 : 0] i_8_90 = i_8_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_8_88 = i_8_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_8_82 = i_8_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_8_78 = i_8_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_8_54 = i_8_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_8_38 = i_8_19 <<< 1;
//54 -85 -4 88 -46 -61 82 13 / -90 38 67 -78 -22 90 -31 -73
    wire signed [IN_WIDTH + 7 : 0] i_9_32 = i_9 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_9_31 = i_9_32 - i_9;
    wire signed [IN_WIDTH + 7 : 0] i_9_8 = i_9 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_9_23 = i_9_31 - i_9_8;
    wire signed [IN_WIDTH + 7 : 0] i_9_4 = i_9 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_9_27 = i_9_31 - i_9_4;
    wire signed [IN_WIDTH + 7 : 0] i_9_39 = i_9_31 + i_9_8;
    wire signed [IN_WIDTH + 7 : 0] i_9_62 = i_9_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_9_61 = i_9_62 - i_9;
    wire signed [IN_WIDTH + 7 : 0] i_9_22 = i_9_23 - i_9;
    wire signed [IN_WIDTH + 7 : 0] i_9_11 = i_9_22 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_9_26 = i_9_27 - i_9;
    wire signed [IN_WIDTH + 7 : 0] i_9_13 = i_9_26 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_9_19 = i_9_23 - i_9_4;
    wire signed [IN_WIDTH + 7 : 0] i_9_64 = i_9 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_9_41 = i_9_64 - i_9_23;
    wire signed [IN_WIDTH + 7 : 0] i_9_46 = i_9_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_9_45 = i_9_46 - i_9;
    wire signed [IN_WIDTH + 7 : 0] i_9_128 = i_9 <<< 7;
    wire signed [IN_WIDTH + 7 : 0] i_9_67 = i_9_128 - i_9_61;
    wire signed [IN_WIDTH + 7 : 0] i_9_73 = i_9_27 + i_9_46;
    wire signed [IN_WIDTH + 7 : 0] i_9_108 = i_9_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_9_85 = i_9_108 - i_9_23;
    wire signed [IN_WIDTH + 7 : 0] i_9_90 = i_9_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_9_88 = i_9_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_9_82 = i_9_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_9_78 = i_9_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_9_54 = i_9_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_9_38 = i_9_19 <<< 1;
//46 -90 38 54 -90 31 61 -88 / 22 67 -85 13 73 -82 4 78
    wire signed [IN_WIDTH + 7 : 0] i_10_32 = i_10 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_10_31 = i_10_32 - i_10;
    wire signed [IN_WIDTH + 7 : 0] i_10_8 = i_10 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_10_23 = i_10_31 - i_10_8;
    wire signed [IN_WIDTH + 7 : 0] i_10_4 = i_10 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_10_27 = i_10_31 - i_10_4;
    wire signed [IN_WIDTH + 7 : 0] i_10_39 = i_10_31 + i_10_8;
    wire signed [IN_WIDTH + 7 : 0] i_10_62 = i_10_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_10_61 = i_10_62 - i_10;
    wire signed [IN_WIDTH + 7 : 0] i_10_22 = i_10_23 - i_10;
    wire signed [IN_WIDTH + 7 : 0] i_10_11 = i_10_22 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_10_26 = i_10_27 - i_10;
    wire signed [IN_WIDTH + 7 : 0] i_10_13 = i_10_26 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_10_19 = i_10_23 - i_10_4;
    wire signed [IN_WIDTH + 7 : 0] i_10_64 = i_10 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_10_41 = i_10_64 - i_10_23;
    wire signed [IN_WIDTH + 7 : 0] i_10_46 = i_10_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_10_45 = i_10_46 - i_10;
    wire signed [IN_WIDTH + 7 : 0] i_10_128 = i_10 <<< 7;
    wire signed [IN_WIDTH + 7 : 0] i_10_67 = i_10_128 - i_10_61;
    wire signed [IN_WIDTH + 7 : 0] i_10_73 = i_10_27 + i_10_46;
    wire signed [IN_WIDTH + 7 : 0] i_10_108 = i_10_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_10_85 = i_10_108 - i_10_23;
    wire signed [IN_WIDTH + 7 : 0] i_10_90 = i_10_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_10_88 = i_10_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_10_82 = i_10_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_10_78 = i_10_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_10_54 = i_10_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_10_38 = i_10_19 <<< 1;
//38 -88 73 -4 -67 90 -46 -31 / 85 -78 13 61 -90 54 22 -82
    wire signed [IN_WIDTH + 7 : 0] i_11_32 = i_11 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_11_31 = i_11_32 - i_11;
    wire signed [IN_WIDTH + 7 : 0] i_11_8 = i_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_11_23 = i_11_31 - i_11_8;
    wire signed [IN_WIDTH + 7 : 0] i_11_4 = i_11 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_11_27 = i_11_31 - i_11_4;
    wire signed [IN_WIDTH + 7 : 0] i_11_39 = i_11_31 + i_11_8;
    wire signed [IN_WIDTH + 7 : 0] i_11_62 = i_11_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_11_61 = i_11_62 - i_11;
    wire signed [IN_WIDTH + 7 : 0] i_11_22 = i_11_23 - i_11;
    wire signed [IN_WIDTH + 7 : 0] i_11_11 = i_11_22 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_11_26 = i_11_27 - i_11;
    wire signed [IN_WIDTH + 7 : 0] i_11_13 = i_11_26 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_11_19 = i_11_23 - i_11_4;
    wire signed [IN_WIDTH + 7 : 0] i_11_64 = i_11 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_11_41 = i_11_64 - i_11_23;
    wire signed [IN_WIDTH + 7 : 0] i_11_46 = i_11_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_11_45 = i_11_46 - i_11;
    wire signed [IN_WIDTH + 7 : 0] i_11_128 = i_11 <<< 7;
    wire signed [IN_WIDTH + 7 : 0] i_11_67 = i_11_128 - i_11_61;
    wire signed [IN_WIDTH + 7 : 0] i_11_73 = i_11_27 + i_11_46;
    wire signed [IN_WIDTH + 7 : 0] i_11_108 = i_11_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_11_85 = i_11_108 - i_11_23;
    wire signed [IN_WIDTH + 7 : 0] i_11_90 = i_11_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_11_88 = i_11_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_11_82 = i_11_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_11_78 = i_11_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_11_54 = i_11_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_11_38 = i_11_19 <<< 1;
//31 -78 90 -61 4 54 -88 82 / -38 -22 73 -90 67 -13 -46 85
    wire signed [IN_WIDTH + 7 : 0] i_12_32 = i_12 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_12_31 = i_12_32 - i_12;
    wire signed [IN_WIDTH + 7 : 0] i_12_8 = i_12 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_12_23 = i_12_31 - i_12_8;
    wire signed [IN_WIDTH + 7 : 0] i_12_4 = i_12 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_12_27 = i_12_31 - i_12_4;
    wire signed [IN_WIDTH + 7 : 0] i_12_39 = i_12_31 + i_12_8;
    wire signed [IN_WIDTH + 7 : 0] i_12_62 = i_12_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_12_61 = i_12_62 - i_12;
    wire signed [IN_WIDTH + 7 : 0] i_12_22 = i_12_23 - i_12;
    wire signed [IN_WIDTH + 7 : 0] i_12_11 = i_12_22 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_12_26 = i_12_27 - i_12;
    wire signed [IN_WIDTH + 7 : 0] i_12_13 = i_12_26 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_12_19 = i_12_23 - i_12_4;
    wire signed [IN_WIDTH + 7 : 0] i_12_64 = i_12 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_12_41 = i_12_64 - i_12_23;
    wire signed [IN_WIDTH + 7 : 0] i_12_46 = i_12_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_12_45 = i_12_46 - i_12;
    wire signed [IN_WIDTH + 7 : 0] i_12_128 = i_12 <<< 7;
    wire signed [IN_WIDTH + 7 : 0] i_12_67 = i_12_128 - i_12_61;
    wire signed [IN_WIDTH + 7 : 0] i_12_73 = i_12_27 + i_12_46;
    wire signed [IN_WIDTH + 7 : 0] i_12_108 = i_12_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_12_85 = i_12_108 - i_12_23;
    wire signed [IN_WIDTH + 7 : 0] i_12_90 = i_12_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_12_88 = i_12_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_12_82 = i_12_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_12_78 = i_12_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_12_54 = i_12_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_12_38 = i_12_19 <<< 1;
//22 -61 85 -90 73 -38 -4 46 / -78 90 -82 54 -13 -31 67 -88
    wire signed [IN_WIDTH + 7 : 0] i_13_32 = i_13 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_13_31 = i_13_32 - i_13;
    wire signed [IN_WIDTH + 7 : 0] i_13_8 = i_13 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_13_23 = i_13_31 - i_13_8;
    wire signed [IN_WIDTH + 7 : 0] i_13_4 = i_13 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_13_27 = i_13_31 - i_13_4;
    wire signed [IN_WIDTH + 7 : 0] i_13_39 = i_13_31 + i_13_8;
    wire signed [IN_WIDTH + 7 : 0] i_13_62 = i_13_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_13_61 = i_13_62 - i_13;
    wire signed [IN_WIDTH + 7 : 0] i_13_22 = i_13_23 - i_13;
    wire signed [IN_WIDTH + 7 : 0] i_13_11 = i_13_22 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_13_26 = i_13_27 - i_13;
    wire signed [IN_WIDTH + 7 : 0] i_13_13 = i_13_26 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_13_19 = i_13_23 - i_13_4;
    wire signed [IN_WIDTH + 7 : 0] i_13_64 = i_13 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_13_41 = i_13_64 - i_13_23;
    wire signed [IN_WIDTH + 7 : 0] i_13_46 = i_13_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_13_45 = i_13_46 - i_13;
    wire signed [IN_WIDTH + 7 : 0] i_13_128 = i_13 <<< 7;
    wire signed [IN_WIDTH + 7 : 0] i_13_67 = i_13_128 - i_13_61;
    wire signed [IN_WIDTH + 7 : 0] i_13_73 = i_13_27 + i_13_46;
    wire signed [IN_WIDTH + 7 : 0] i_13_108 = i_13_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_13_85 = i_13_108 - i_13_23;
    wire signed [IN_WIDTH + 7 : 0] i_13_90 = i_13_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_13_88 = i_13_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_13_82 = i_13_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_13_78 = i_13_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_13_54 = i_13_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_13_38 = i_13_19 <<< 1;
//13 -38 61 -78 88 -90 85 -73 / 54 -31 4 22 -46 67 -82 90
    wire signed [IN_WIDTH + 7 : 0] i_14_32 = i_14 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_14_31 = i_14_32 - i_14;
    wire signed [IN_WIDTH + 7 : 0] i_14_8 = i_14 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_14_23 = i_14_31 - i_14_8;
    wire signed [IN_WIDTH + 7 : 0] i_14_4 = i_14 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_14_27 = i_14_31 - i_14_4;
    wire signed [IN_WIDTH + 7 : 0] i_14_39 = i_14_31 + i_14_8;
    wire signed [IN_WIDTH + 7 : 0] i_14_62 = i_14_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_14_61 = i_14_62 - i_14;
    wire signed [IN_WIDTH + 7 : 0] i_14_22 = i_14_23 - i_14;
    wire signed [IN_WIDTH + 7 : 0] i_14_11 = i_14_22 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_14_26 = i_14_27 - i_14;
    wire signed [IN_WIDTH + 7 : 0] i_14_13 = i_14_26 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_14_19 = i_14_23 - i_14_4;
    wire signed [IN_WIDTH + 7 : 0] i_14_64 = i_14 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_14_41 = i_14_64 - i_14_23;
    wire signed [IN_WIDTH + 7 : 0] i_14_46 = i_14_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_14_45 = i_14_46 - i_14;
    wire signed [IN_WIDTH + 7 : 0] i_14_128 = i_14 <<< 7;
    wire signed [IN_WIDTH + 7 : 0] i_14_67 = i_14_128 - i_14_61;
    wire signed [IN_WIDTH + 7 : 0] i_14_73 = i_14_27 + i_14_46;
    wire signed [IN_WIDTH + 7 : 0] i_14_108 = i_14_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_14_85 = i_14_108 - i_14_23;
    wire signed [IN_WIDTH + 7 : 0] i_14_90 = i_14_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_14_88 = i_14_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_14_82 = i_14_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_14_78 = i_14_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_14_54 = i_14_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_14_38 = i_14_19 <<< 1;
//4 -13 22 -31 38 -46 54 -61 / 67 -73 78 -82 85 -88 90 -90
    wire signed [IN_WIDTH + 7 : 0] i_15_32 = i_15 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_15_31 = i_15_32 - i_15;
    wire signed [IN_WIDTH + 7 : 0] i_15_8 = i_15 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_15_23 = i_15_31 - i_15_8;
    wire signed [IN_WIDTH + 7 : 0] i_15_4 = i_15 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_15_27 = i_15_31 - i_15_4;
    wire signed [IN_WIDTH + 7 : 0] i_15_39 = i_15_31 + i_15_8;
    wire signed [IN_WIDTH + 7 : 0] i_15_62 = i_15_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_15_61 = i_15_62 - i_15;
    wire signed [IN_WIDTH + 7 : 0] i_15_22 = i_15_23 - i_15;
    wire signed [IN_WIDTH + 7 : 0] i_15_11 = i_15_22 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_15_26 = i_15_27 - i_15;
    wire signed [IN_WIDTH + 7 : 0] i_15_13 = i_15_26 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_15_19 = i_15_23 - i_15_4;
    wire signed [IN_WIDTH + 7 : 0] i_15_64 = i_15 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_15_41 = i_15_64 - i_15_23;
    wire signed [IN_WIDTH + 7 : 0] i_15_46 = i_15_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_15_45 = i_15_46 - i_15;
    wire signed [IN_WIDTH + 7 : 0] i_15_128 = i_15 <<< 7;
    wire signed [IN_WIDTH + 7 : 0] i_15_67 = i_15_128 - i_15_61;
    wire signed [IN_WIDTH + 7 : 0] i_15_73 = i_15_27 + i_15_46;
    wire signed [IN_WIDTH + 7 : 0] i_15_108 = i_15_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_15_85 = i_15_108 - i_15_23;
    wire signed [IN_WIDTH + 7 : 0] i_15_90 = i_15_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_15_88 = i_15_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_15_82 = i_15_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_15_78 = i_15_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_15_54 = i_15_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_15_38 = i_15_19 <<< 1;

//sum
reg i_valid_d1, i_valid_d2;
reg signed  [IN_WIDTH + 7 : 0] sum0_0[0 : 15], sum0_1[0 : 15], sum0_2[0 : 15], sum0_3[0 : 15], 
                               sum0_4[0 : 15], sum0_5[0 : 15], sum0_6[0 : 15], sum0_7[0 : 15];
reg signed  [IN_WIDTH + 9 : 0] sum1_0[0 : 15], sum1_1[0 : 15];
//stage 1
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d1 <= 0;
        for (i = 0; i < 16; i = i + 1) begin
            sum0_0[i] <= 0; sum0_1[i] <= 0; sum0_2[i] <= 0; sum0_3[i] <= 0; 
            sum0_4[i] <= 0; sum0_5[i] <= 0; sum0_6[i] <= 0; sum0_7[i] <= 0; 
        end
    end
    else begin
        i_valid_d1 <= i_valid;
        sum0_0[0 ] <= i_0_90 + i_1_90; sum0_1[0 ] <= i_2_88 + i_3_85; sum0_2[0 ] <= i_4_82 + i_5_78; sum0_3[0 ] <= i_6_73 + i_7_67; 
        sum0_0[1 ] <= i_0_90 + i_1_82; sum0_1[1 ] <= i_2_67 + i_3_46; sum0_2[1 ] <= i_4_22 - i_5_4 ; sum0_3[1 ] <= i_6_31 + i_7_54; 
        sum0_0[2 ] <= i_0_88 + i_1_67; sum0_1[2 ] <= i_2_31 - i_3_13; sum0_2[2 ] <= i_4_54 + i_5_82; sum0_3[2 ] <= i_6_90 + i_7_78; 
        sum0_0[3 ] <= i_0_85 + i_1_46; sum0_1[3 ] <= i_2_13 + i_3_67; sum0_2[3 ] <= i_4_90 + i_5_73; sum0_3[3 ] <= i_6_22 - i_7_38; 
        sum0_0[4 ] <= i_0_82 + i_1_22; sum0_1[4 ] <= i_2_54 + i_3_90; sum0_2[4 ] <= i_4_61 - i_5_13; sum0_3[4 ] <= i_6_78 + i_7_85; 
        sum0_0[5 ] <= i_0_78 - i_1_4 ; sum0_1[5 ] <= i_2_82 + i_3_73; sum0_2[5 ] <= i_4_13 + i_5_85; sum0_3[5 ] <= i_6_67 - i_7_22; 
        sum0_0[6 ] <= i_0_73 - i_1_31; sum0_1[6 ] <= i_2_90 + i_3_22; sum0_2[6 ] <= i_4_78 + i_5_67; sum0_3[6 ] <= i_6_38 + i_7_90; 
        sum0_0[7 ] <= i_0_67 - i_1_54; sum0_1[7 ] <= i_2_78 - i_3_38; sum0_2[7 ] <= i_4_85 - i_5_22; sum0_3[7 ] <= i_6_90 - i_7_4 ; 
        sum0_0[8 ] <= i_0_61 - i_1_73; sum0_1[8 ] <= i_2_46 - i_3_82; sum0_2[8 ] <= i_4_31 - i_5_88; sum0_3[8 ] <= i_6_13 - i_7_90; 
        sum0_0[9 ] <= i_0_54 - i_1_85; sum0_1[9 ] <= i_2_4  - i_3_88; sum0_2[9 ] <= i_4_46 + i_5_61; sum0_3[9 ] <= i_6_82 + i_7_13; 
        sum0_0[10] <= i_0_46 - i_1_90; sum0_1[10] <= i_2_38 + i_3_54; sum0_2[10] <= i_4_90 - i_5_31; sum0_3[10] <= i_6_61 - i_7_88; 
        sum0_0[11] <= i_0_38 - i_1_88; sum0_1[11] <= i_2_73 - i_3_4 ; sum0_2[11] <= i_4_67 - i_5_90; sum0_3[11] <= i_6_46 + i_7_31; 
        sum0_0[12] <= i_0_31 - i_1_78; sum0_1[12] <= i_2_90 - i_3_61; sum0_2[12] <= i_4_4 + i_5_54 ; sum0_3[12] <= i_6_88 - i_7_82; 
        sum0_0[13] <= i_0_22 - i_1_61; sum0_1[13] <= i_2_85 - i_3_90; sum0_2[13] <= i_4_73 - i_5_38; sum0_3[13] <= i_6_4  - i_7_46; 
        sum0_0[14] <= i_0_13 - i_1_38; sum0_1[14] <= i_2_61 - i_3_78; sum0_2[14] <= i_4_88 - i_5_90; sum0_3[14] <= i_6_85 - i_7_73; 
        sum0_0[15] <= i_0_4  - i_1_13; sum0_1[15] <= i_2_22 - i_3_31; sum0_2[15] <= i_4_38 - i_5_46; sum0_3[15] <= i_6_54 - i_7_61; 
        
        sum0_4[0 ] <= i_8_61 + i_9_54; sum0_5[0 ] <= i_10_46 + i_11_38; sum0_6[0 ] <= i_12_31 + i_13_22; sum0_7[0 ] <= i_14_13 + i_15_4 ;
        sum0_4[1 ] <= i_8_73 + i_9_85; sum0_5[1 ] <= i_10_90 + i_11_88; sum0_6[1 ] <= i_12_78 + i_13_61; sum0_7[1 ] <= i_14_38 + i_15_13;
        sum0_4[2 ] <= i_8_46 + i_9_4 ; sum0_5[2 ] <= i_10_38 + i_11_73; sum0_6[2 ] <= i_12_90 + i_13_85; sum0_7[2 ] <= i_14_61 + i_15_22;
        sum0_4[3 ] <= i_8_82 + i_9_88; sum0_5[3 ] <= i_10_54 - i_11_4 ; sum0_6[3 ] <= i_12_61 + i_13_90; sum0_7[3 ] <= i_14_78 + i_15_31;
        sum0_4[4 ] <= i_8_31 - i_9_46; sum0_5[4 ] <= i_10_90 + i_11_67; sum0_6[4 ] <= i_12_4  + i_13_73; sum0_7[4 ] <= i_14_88 + i_15_38;
        sum0_4[5 ] <= i_8_88 + i_9_61; sum0_5[5 ] <= i_10_31 + i_11_90; sum0_6[5 ] <= i_12_54 - i_13_38; sum0_7[5 ] <= i_14_90 + i_15_46;
        sum0_4[6 ] <= i_8_13 - i_9_82; sum0_5[6 ] <= i_10_61 - i_11_46; sum0_6[6 ] <= i_12_88 + i_13_4 ; sum0_7[6 ] <= i_14_85 + i_15_54;
        sum0_4[7 ] <= i_8_90 + i_9_13; sum0_5[7 ] <= i_10_88 + i_11_31; sum0_6[7 ] <= i_12_82 + i_13_46; sum0_7[7 ] <= i_14_73 + i_15_61;
        sum0_4[8 ] <= i_8_4 + i_9_90 ; sum0_5[8 ] <= i_10_22 + i_11_85; sum0_6[8 ] <= i_12_38 + i_13_78; sum0_7[8 ] <= i_14_54 + i_15_67;
        sum0_4[9 ] <= i_8_90 - i_9_38; sum0_5[9 ] <= i_10_67 - i_11_78; sum0_6[9 ] <= i_12_22 - i_13_90; sum0_7[9 ] <= i_14_31 + i_15_73;
        sum0_4[10] <= i_8_22 + i_9_67; sum0_5[10] <= i_10_85 - i_11_13; sum0_6[10] <= i_12_73 - i_13_82; sum0_7[10] <= i_14_4  + i_15_78;
        sum0_4[11] <= i_8_85 - i_9_78; sum0_5[11] <= i_10_13 + i_11_61; sum0_6[11] <= i_12_90 - i_13_54; sum0_7[11] <= i_14_22 - i_15_82;
        sum0_4[12] <= i_8_38 + i_9_22; sum0_5[12] <= i_10_73 - i_11_90; sum0_6[12] <= i_12_67 - i_13_13; sum0_7[12] <= i_14_46 - i_15_85;
        sum0_4[13] <= i_8_78 - i_9_90; sum0_5[13] <= i_10_82 - i_11_54; sum0_6[13] <= i_12_13 + i_13_31; sum0_7[13] <= i_14_67 - i_15_88;
        sum0_4[14] <= i_8_54 - i_9_31; sum0_5[14] <= i_10_4  + i_11_22; sum0_6[14] <= i_12_46 - i_13_67; sum0_7[14] <= i_14_82 - i_15_90;
        sum0_4[15] <= i_8_67 - i_9_73; sum0_5[15] <= i_10_78 - i_11_82; sum0_6[15] <= i_12_85 - i_13_88; sum0_7[15] <= i_14_90 - i_15_90;
    end
end
//stage 2
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d2 <= 0;
        for (i = 0; i < 16; i = i + 1) begin
            sum1_0[i] <= 0; sum1_1[i] <= 0;
        end
    end
    else begin
        i_valid_d2 <= i_valid_d1;
        sum1_0[0 ] <= sum0_0[0 ] + sum0_1[0 ] + sum0_2[0 ] + sum0_3[0 ]; sum1_1[0 ] <= sum0_4[0 ] + sum0_5[0 ] + sum0_6[0 ] + sum0_7[0 ];
        sum1_0[1 ] <= sum0_0[1 ] + sum0_1[1 ] + sum0_2[1 ] - sum0_3[1 ]; sum1_1[1 ] <= sum0_4[1 ] + sum0_5[1 ] + sum0_6[1 ] + sum0_7[1 ];
        sum1_0[2 ] <= sum0_0[2 ] + sum0_1[2 ] - sum0_2[2 ] - sum0_3[2 ]; sum1_1[2 ] <= sum0_4[2 ] - sum0_5[2 ] - sum0_6[2 ] - sum0_7[2 ];
        sum1_0[3 ] <= sum0_0[3 ] - sum0_1[3 ] - sum0_2[3 ] - sum0_3[3 ]; sum1_1[3 ] <= sum0_4[3 ] + sum0_5[3 ] - sum0_6[3 ] - sum0_7[3 ];
        sum1_0[4 ] <= sum0_0[4 ] - sum0_1[4 ] - sum0_2[4 ] + sum0_3[4 ]; sum1_1[4 ] <= sum0_4[4 ] - sum0_5[4 ] + sum0_6[4 ] + sum0_7[4 ];
        sum1_0[5 ] <= sum0_0[5 ] - sum0_1[5 ] + sum0_2[5 ] + sum0_3[5 ]; sum1_1[5 ] <= sum0_4[5 ] - sum0_5[5 ] - sum0_6[5 ] + sum0_7[5 ];
        sum1_0[6 ] <= sum0_0[6 ] - sum0_1[6 ] + sum0_2[6 ] - sum0_3[6 ]; sum1_1[6 ] <= sum0_4[6 ] - sum0_5[6 ] + sum0_6[6 ] - sum0_7[6 ];
        sum1_0[7 ] <= sum0_0[7 ] - sum0_1[7 ] + sum0_2[7 ] - sum0_3[7 ]; sum1_1[7 ] <= sum0_4[7 ] - sum0_5[7 ] + sum0_6[7 ] - sum0_7[7 ];
        sum1_0[8 ] <= sum0_0[8 ] - sum0_1[8 ] + sum0_2[8 ] - sum0_3[8 ]; sum1_1[8 ] <= sum0_4[8 ] - sum0_5[8 ] + sum0_6[8 ] - sum0_7[8 ];
        sum1_0[9 ] <= sum0_0[9 ] - sum0_1[9 ] - sum0_2[9 ] + sum0_3[9 ]; sum1_1[9 ] <= sum0_4[9 ] - sum0_5[9 ] + sum0_6[9 ] + sum0_7[9 ];
        sum1_0[10] <= sum0_0[10] + sum0_1[10] - sum0_2[10] + sum0_3[10]; sum1_1[10] <= sum0_4[10] - sum0_5[10] + sum0_6[10] + sum0_7[10];
        sum1_0[11] <= sum0_0[11] + sum0_1[11] - sum0_2[11] - sum0_3[11]; sum1_1[11] <= sum0_4[11] + sum0_5[11] - sum0_6[11] + sum0_7[11];
        sum1_0[12] <= sum0_0[12] + sum0_1[12] + sum0_2[12] - sum0_3[12]; sum1_1[12] <= sum0_4[12] - sum0_5[12] - sum0_6[12] + sum0_7[12];
        sum1_0[13] <= sum0_0[13] + sum0_1[13] + sum0_2[13] - sum0_3[13]; sum1_1[13] <= sum0_4[13] + sum0_5[13] + sum0_6[13] - sum0_7[13];
        sum1_0[14] <= sum0_0[14] + sum0_1[14] + sum0_2[14] + sum0_3[14]; sum1_1[14] <= sum0_4[14] + sum0_5[14] - sum0_6[14] - sum0_7[14];
        sum1_0[15] <= sum0_0[15] + sum0_1[15] + sum0_2[15] + sum0_3[15]; sum1_1[15] <= sum0_4[15] + sum0_5[15] + sum0_6[15] + sum0_7[15];
    end
end
//stage 3
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
    else if (i_size == SIZE64) begin//高频置零
        o_valid <= i_valid_d2;
        o_0  <= sum1_0[0 ] + sum1_1[0 ];
        o_1  <= sum1_0[1 ] - sum1_1[1 ];
        o_2  <= sum1_0[2 ] - sum1_1[2 ];
        o_3  <= sum1_0[3 ] + sum1_1[3 ];
        o_4  <= sum1_0[4 ] + sum1_1[4 ];
        o_5  <= sum1_0[5 ] - sum1_1[5 ];
        o_6  <= sum1_0[6 ] - sum1_1[6 ];
        o_7  <= sum1_0[7 ] + sum1_1[7 ];
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
        o_valid <= i_valid_d2;
        o_0  <= sum1_0[0 ] + sum1_1[0 ];
        o_1  <= sum1_0[1 ] - sum1_1[1 ];
        o_2  <= sum1_0[2 ] - sum1_1[2 ];
        o_3  <= sum1_0[3 ] + sum1_1[3 ];
        o_4  <= sum1_0[4 ] + sum1_1[4 ];
        o_5  <= sum1_0[5 ] - sum1_1[5 ];
        o_6  <= sum1_0[6 ] - sum1_1[6 ];
        o_7  <= sum1_0[7 ] + sum1_1[7 ];
        o_8  <= sum1_0[8 ] - sum1_1[8 ];
        o_9  <= sum1_0[9 ] - sum1_1[9 ];
        o_10 <= sum1_0[10] + sum1_1[10];
        o_11 <= sum1_0[11] + sum1_1[11];
        o_12 <= sum1_0[12] - sum1_1[12];
        o_13 <= sum1_0[13] - sum1_1[13];
        o_14 <= sum1_0[14] + sum1_1[14];
        o_15 <= sum1_0[15] + sum1_1[15];
    end
end

endmodule
