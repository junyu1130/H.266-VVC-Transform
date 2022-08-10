//describe  : MCM生成乘法单元，求和得到结果
//input     : 32个蝶形单元
//output    : 16个系数结果(后需右移), 剩余16个被高频置零
//delay     : 3 clk
module dct2_calculate_64#(
    parameter IN_WIDTH = 17
)
(
//system input
    input                                   clk     ,
    input                                   rst_n   ,
//input data
    input                                   i_valid ,
    input       signed  [IN_WIDTH - 1 : 0]  i_0     ,//O0 
    input       signed  [IN_WIDTH - 1 : 0]  i_1     ,//O1 
    input       signed  [IN_WIDTH - 1 : 0]  i_2     ,//O2 
    input       signed  [IN_WIDTH - 1 : 0]  i_3     ,//O3 
    input       signed  [IN_WIDTH - 1 : 0]  i_4     ,//O4 
    input       signed  [IN_WIDTH - 1 : 0]  i_5     ,//O5 
    input       signed  [IN_WIDTH - 1 : 0]  i_6     ,//O6 
    input       signed  [IN_WIDTH - 1 : 0]  i_7     ,//O7 
    input       signed  [IN_WIDTH - 1 : 0]  i_8     ,//O8 
    input       signed  [IN_WIDTH - 1 : 0]  i_9     ,//O9 
    input       signed  [IN_WIDTH - 1 : 0]  i_10    ,//O10
    input       signed  [IN_WIDTH - 1 : 0]  i_11    ,//O11
    input       signed  [IN_WIDTH - 1 : 0]  i_12    ,//O12
    input       signed  [IN_WIDTH - 1 : 0]  i_13    ,//O13
    input       signed  [IN_WIDTH - 1 : 0]  i_14    ,//O14
    input       signed  [IN_WIDTH - 1 : 0]  i_15    ,//O15
    input       signed  [IN_WIDTH - 1 : 0]  i_16    ,//O16
    input       signed  [IN_WIDTH - 1 : 0]  i_17    ,//O17
    input       signed  [IN_WIDTH - 1 : 0]  i_18    ,//O18
    input       signed  [IN_WIDTH - 1 : 0]  i_19    ,//O19
    input       signed  [IN_WIDTH - 1 : 0]  i_20    ,//O20
    input       signed  [IN_WIDTH - 1 : 0]  i_21    ,//O21
    input       signed  [IN_WIDTH - 1 : 0]  i_22    ,//O22
    input       signed  [IN_WIDTH - 1 : 0]  i_23    ,//O23
    input       signed  [IN_WIDTH - 1 : 0]  i_24    ,//O24
    input       signed  [IN_WIDTH - 1 : 0]  i_25    ,//O25
    input       signed  [IN_WIDTH - 1 : 0]  i_26    ,//O26
    input       signed  [IN_WIDTH - 1 : 0]  i_27    ,//O27
    input       signed  [IN_WIDTH - 1 : 0]  i_28    ,//O28
    input       signed  [IN_WIDTH - 1 : 0]  i_29    ,//O29
    input       signed  [IN_WIDTH - 1 : 0]  i_30    ,//O30
    input       signed  [IN_WIDTH - 1 : 0]  i_31    ,//O31
//output pre_coeff
    output reg                              o_valid ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_0     ,//1 
    output reg  signed  [IN_WIDTH + 10 : 0] o_1     ,//3 
    output reg  signed  [IN_WIDTH + 10 : 0] o_2     ,//5 
    output reg  signed  [IN_WIDTH + 10 : 0] o_3     ,//7 
    output reg  signed  [IN_WIDTH + 10 : 0] o_4     ,//9 
    output reg  signed  [IN_WIDTH + 10 : 0] o_5     ,//11
    output reg  signed  [IN_WIDTH + 10 : 0] o_6     ,//13
    output reg  signed  [IN_WIDTH + 10 : 0] o_7     ,//15
    output reg  signed  [IN_WIDTH + 10 : 0] o_8     ,//17
    output reg  signed  [IN_WIDTH + 10 : 0] o_9     ,//19
    output reg  signed  [IN_WIDTH + 10 : 0] o_10    ,//21
    output reg  signed  [IN_WIDTH + 10 : 0] o_11    ,//23
    output reg  signed  [IN_WIDTH + 10 : 0] o_12    ,//25
    output reg  signed  [IN_WIDTH + 10 : 0] o_13    ,//27
    output reg  signed  [IN_WIDTH + 10 : 0] o_14    ,//29
    output reg  signed  [IN_WIDTH + 10 : 0] o_15     //31
);

integer i;

//mcm
//91 90 90 90 88 87 86 84 83 81 79 77 73 71 69 65 / 62 59 56 52 48 44 41 37 33 28 24 20 15 11 7 2
    wire signed [IN_WIDTH + 7 : 0] i_0_64 = i_0 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_0_65 = i_0 + i_0_64;
    wire signed [IN_WIDTH + 7 : 0] i_0_4  = i_0 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_0_69 = i_0_65 + i_0_4;
    wire signed [IN_WIDTH + 7 : 0] i_0_8  = i_0 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_0_73 = i_0_65 + i_0_8;
    wire signed [IN_WIDTH + 7 : 0] i_0_16 = i_0 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_0_81 = i_0_65 + i_0_16;
    wire signed [IN_WIDTH + 7 : 0] i_0_2  = i_0 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_0_71 = i_0_69 + i_0_2;
    wire signed [IN_WIDTH + 7 : 0] i_0_77 = i_0_69 + i_0_8;
    wire signed [IN_WIDTH + 7 : 0] i_0_79 = i_0_81 - i_0_2;
    wire signed [IN_WIDTH + 7 : 0] i_0_83 = i_0_81 + i_0_2;
    wire signed [IN_WIDTH + 7 : 0] i_0_84 = i_0 + i_0_83;
    wire signed [IN_WIDTH + 7 : 0] i_0_21 = i_0_84 >>> 2;
    wire signed [IN_WIDTH + 7 : 0] i_0_32 = i_0 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_0_45 = i_0_77 - i_0_32;
    wire signed [IN_WIDTH + 7 : 0] i_0_87 = i_0_71 + i_0_16;
    wire signed [IN_WIDTH + 7 : 0] i_0_91 = i_0_83 + i_0_8;
    wire signed [IN_WIDTH + 7 : 0] i_0_11 = i_0_32 - i_0_21;
    wire signed [IN_WIDTH + 7 : 0] i_0_43 = i_0_64 - i_0_21;
    wire signed [IN_WIDTH + 7 : 0] i_0_90 = i_0_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_0_88 = i_0_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_0_86 = i_0_43 <<< 1;
//90 88 84 79 71 62 52 41 28 15 2 -11 -24 -37 -48 -59 / -69 -77 -83 -87 -90 -91 -90 -86 -81 -73 -65 -56 -44 -33 -20 -7
    wire signed [IN_WIDTH + 7 : 0] i_1_4  = i_1 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_1_3  = i_1_4 - i_1;
    wire signed [IN_WIDTH + 7 : 0] i_1_8  = i_1 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_1_7  = i_1_8 - i_1;
    wire signed [IN_WIDTH + 7 : 0] i_1_16 = i_1 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_1_15 = i_1_16 - i_1;
    wire signed [IN_WIDTH + 7 : 0] i_1_32 = i_1 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_1_31 = i_1_32 - i_1;
    wire signed [IN_WIDTH + 7 : 0] i_1_11 = i_1_3 + i_1_8;
    wire signed [IN_WIDTH + 7 : 0] i_1_13 = i_1_16 - i_1_3;
    wire signed [IN_WIDTH + 7 : 0] i_1_24 = i_1_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_1_21 = i_1_24 - i_1_3;
    wire signed [IN_WIDTH + 7 : 0] i_1_6  = i_1_3 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_1_37 = i_1_31 + i_1_6;
    wire signed [IN_WIDTH + 7 : 0] i_1_48 = i_1_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_1_41 = i_1_48 - i_1_7;
    wire signed [IN_WIDTH + 7 : 0] i_1_45 = i_1_48 - i_1_3;
    wire signed [IN_WIDTH + 7 : 0] i_1_60 = i_1_15 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_1_59 = i_1_60 - i_1;
    wire signed [IN_WIDTH + 7 : 0] i_1_64 = i_1 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_1_71 = i_1_7 + i_1_64;
    wire signed [IN_WIDTH + 7 : 0] i_1_79 = i_1_15 + i_1_64;
    wire signed [IN_WIDTH + 7 : 0] i_1_90 = i_1_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_1_88 = i_1_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_1_84 = i_1_21 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_1_62 = i_1_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_1_52 = i_1_13 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_1_28 = i_1_7 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_1_2  = i_1 <<< 1;
//90 84 73 59 41 20 -2 -24 -44 -62 -77 -86 -90 -90 -83 -71 / -56 -37 -15 7 28 48 65 79 87 91 88 81 69 52 33 11
    wire signed [IN_WIDTH + 7 : 0] i_2_4  = i_2 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_2_3  = i_2_4 - i_2;
    wire signed [IN_WIDTH + 7 : 0] i_2_5  = i_2 + i_2_4;
    wire signed [IN_WIDTH + 7 : 0] i_2_32 = i_2 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_2_31 = i_2_32 - i_2;
    wire signed [IN_WIDTH + 7 : 0] i_2_8  = i_2 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_2_11 = i_2_3 + i_2_8;
    wire signed [IN_WIDTH + 7 : 0] i_2_16 = i_2 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_2_21 = i_2_5 + i_2_16;
    wire signed [IN_WIDTH + 7 : 0] i_2_40 = i_2_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_2_41 = i_2 + i_2_40;
    wire signed [IN_WIDTH + 7 : 0] i_2_48 = i_2_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_2_43 = i_2_48 - i_2_5;
    wire signed [IN_WIDTH + 7 : 0] i_2_45 = i_2_48 - i_2_3;
    wire signed [IN_WIDTH + 7 : 0] i_2_64 = i_2 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_2_59 = i_2_64 - i_2_5;
    wire signed [IN_WIDTH + 7 : 0] i_2_71 = i_2_31 + i_2_40;
    wire signed [IN_WIDTH + 7 : 0] i_2_80 = i_2_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_2_77 = i_2_80 - i_2_3;
    wire signed [IN_WIDTH + 7 : 0] i_2_83 = i_2_3 + i_2_80;
    wire signed [IN_WIDTH + 7 : 0] i_2_73 = i_2_41 + i_2_32;
    wire signed [IN_WIDTH + 7 : 0] i_2_90 = i_2_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_2_84 = i_2_21 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_2_20 = i_2_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_2_2  = i_2 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_2_24 = i_2_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_2_44 = i_2_11 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_2_62 = i_2_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_2_86 = i_2_43 <<< 1;
//90 79 59 33 2 -28 -56 -77 -88 -90 -81 -62 -37 -7 24 52 / 73 87 90 83 65 41 11 -20 -48 -71 -86 -91 -84 -69 -44 -15 
    wire signed [IN_WIDTH + 7 : 0] i_3_4  = i_3 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_3_3  = i_3_4 - i_3;
    wire signed [IN_WIDTH + 7 : 0] i_3_8  = i_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_3_7  = i_3_8 - i_3;
    wire signed [IN_WIDTH + 7 : 0] i_3_32 = i_3 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_3_31 = i_3_32 - i_3;
    wire signed [IN_WIDTH + 7 : 0] i_3_33 = i_3 + i_3_32;
    wire signed [IN_WIDTH + 7 : 0] i_3_11 = i_3_3 + i_3_8;
    wire signed [IN_WIDTH + 7 : 0] i_3_16 = i_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_3_13 = i_3_16 - i_3_3;
    wire signed [IN_WIDTH + 7 : 0] i_3_37 = i_3_33 + i_3_4;
    wire signed [IN_WIDTH + 7 : 0] i_3_48 = i_3_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_3_45 = i_3_48 - i_3_3;
    wire signed [IN_WIDTH + 7 : 0] i_3_56 = i_3_7 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_3_59 = i_3_3 + i_3_56;
    wire signed [IN_WIDTH + 7 : 0] i_3_79 = i_3_31 + i_3_48;
    wire signed [IN_WIDTH + 7 : 0] i_3_81 = i_3_33 + i_3_48;
    wire signed [IN_WIDTH + 7 : 0] i_3_64 = i_3 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_3_77 = i_3_13 + i_3_64;
    wire signed [IN_WIDTH + 7 : 0] i_3_90 = i_3_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_3_2  = i_3 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_3_28 = i_3_7 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_3_88 = i_3_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_3_62 = i_3_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_3_24 = i_3_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_3_52 = i_3_13 <<< 2;
//88 71 41 2 -37 -69 -87 -90 -73 -44 -7 33 65 86 90 77 / 48 11 -28 -62 -84 -90 -79 -52 -15 24 59 83 91 81 56 20
    wire signed [IN_WIDTH + 7 : 0] i_4_8  = i_4 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_4_7  = i_4_8 - i_4;
    wire signed [IN_WIDTH + 7 : 0] i_4_32 = i_4 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_4_33 = i_4 + i_4_32;
    wire signed [IN_WIDTH + 7 : 0] i_4_64 = i_4 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_4_65 = i_4 + i_4_64;
    wire signed [IN_WIDTH + 7 : 0] i_4_4  = i_4 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_4_11 = i_4_7 + i_4_4;
    wire signed [IN_WIDTH + 7 : 0] i_4_37 = i_4_33 + i_4_4;
    wire signed [IN_WIDTH + 7 : 0] i_4_41 = i_4_33 + i_4_8;
    wire signed [IN_WIDTH + 7 : 0] i_4_69 = i_4_65 + i_4_4;
    wire signed [IN_WIDTH + 7 : 0] i_4_71 = i_4_7 + i_4_64;
    wire signed [IN_WIDTH + 7 : 0] i_4_73 = i_4_65 + i_4_8;
    wire signed [IN_WIDTH + 7 : 0] i_4_43 = i_4_11 + i_4_32;
    wire signed [IN_WIDTH + 7 : 0] i_4_44 = i_4_11 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_4_45 = i_4 + i_4_44;
    wire signed [IN_WIDTH + 7 : 0] i_4_77 = i_4_69 + i_4_8;
    wire signed [IN_WIDTH + 7 : 0] i_4_88 = i_4_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_4_87 = i_4_88 - i_4;
    wire signed [IN_WIDTH + 7 : 0] i_4_2  = i_4 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_4_90 = i_4_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_4_86 = i_4_43 <<< 1;
//87 62 20 -28 -69 -90 -84 -56 -11 37 73 90 81 48 2 -44 / -79 -91 -77 -41 7 52 83 90 71 33 -15 -59 -86 -88 -65 -24
    wire signed [IN_WIDTH + 7 : 0] i_5_4  = i_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_5_3  = i_5_4 - i_5;
    wire signed [IN_WIDTH + 7 : 0] i_5_5  = i_5 + i_5_4;
    wire signed [IN_WIDTH + 7 : 0] i_5_8  = i_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_5_7  = i_5_8 - i_5;
    wire signed [IN_WIDTH + 7 : 0] i_5_32 = i_5 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_5_31 = i_5_32 - i_5;
    wire signed [IN_WIDTH + 7 : 0] i_5_11 = i_5_3 + i_5_8;
    wire signed [IN_WIDTH + 7 : 0] i_5_16 = i_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_5_21 = i_5_5 + i_5_16;
    wire signed [IN_WIDTH + 7 : 0] i_5_37 = i_5_5 + i_5_32;
    wire signed [IN_WIDTH + 7 : 0] i_5_48 = i_5_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_5_45 = i_5_48 - i_5_3;
    wire signed [IN_WIDTH + 7 : 0] i_5_64 = i_5 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_5_69 = i_5_5 + i_5_64;
    wire signed [IN_WIDTH + 7 : 0] i_5_80 = i_5_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_5_73 = i_5_80 - i_5_7;
    wire signed [IN_WIDTH + 7 : 0] i_5_81 = i_5 + i_5_80;
    wire signed [IN_WIDTH + 7 : 0] i_5_87 = i_5_7 + i_5_80;
    wire signed [IN_WIDTH + 7 : 0] i_5_62 = i_5_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_5_20 = i_5_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_5_28 = i_5_7 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_5_90 = i_5_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_5_84 = i_5_21 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_5_56 = i_5_7 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_5_2  = i_5 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_5_44 = i_5_11 <<< 2;
//86 52 -2 -56 -87 -84 -48 7 59 88 83 44 -11 -62 -90 -81 / -41 15 65 90 79 37 -20 -69 -90 -77 -33 24 71 91 73 28
    wire signed [IN_WIDTH + 7 : 0] i_6_4  = i_6 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_6_3  = i_6_4 - i_6;
    wire signed [IN_WIDTH + 7 : 0] i_6_8  = i_6 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_6_7  = i_6_8 - i_6;
    wire signed [IN_WIDTH + 7 : 0] i_6_32 = i_6 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_6_31 = i_6_32 - i_6;
    wire signed [IN_WIDTH + 7 : 0] i_6_11 = i_6_3 + i_6_8;
    wire signed [IN_WIDTH + 7 : 0] i_6_16 = i_6 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_6_13 = i_6_16 - i_6_3;
    wire signed [IN_WIDTH + 7 : 0] i_6_24 = i_6_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_6_21 = i_6_24 - i_6_3;
    wire signed [IN_WIDTH + 7 : 0] i_6_12 = i_6_3 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_6_43 = i_6_31 + i_6_12;
    wire signed [IN_WIDTH + 7 : 0] i_6_48 = i_6_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_6_45 = i_6_48 - i_6_3;
    wire signed [IN_WIDTH + 7 : 0] i_6_56 = i_6_7 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_6_59 = i_6_3 + i_6_56;
    wire signed [IN_WIDTH + 7 : 0] i_6_84 = i_6_21 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_6_81 = i_6_84 - i_6_3;
    wire signed [IN_WIDTH + 7 : 0] i_6_87 = i_6_31 + i_6_56;
    wire signed [IN_WIDTH + 7 : 0] i_6_83 = i_6_84 - i_6;
    wire signed [IN_WIDTH + 7 : 0] i_6_86 = i_6_43 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_6_52 = i_6_13 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_6_2  = i_6 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_6_88 = i_6_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_6_44 = i_6_11 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_6_62 = i_6_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_6_90 = i_6_45 <<< 1;
//84 41 -24 -77 -90 -56 7 65 91 69 11 -52 -88 -79 -28 37 / 83 86 44 -20 -73 -90 -59 2 62 90 71 15 -48 -87 -81 -33
    wire signed [IN_WIDTH + 7 : 0] i_7_4  = i_7 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_7_3  = i_7_4 - i_7;
    wire signed [IN_WIDTH + 7 : 0] i_7_8  = i_7 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_7_7  = i_7_8 - i_7;
    wire signed [IN_WIDTH + 7 : 0] i_7_64 = i_7 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_7_65 = i_7 + i_7_64;
    wire signed [IN_WIDTH + 7 : 0] i_7_11 = i_7_3 + i_7_8;
    wire signed [IN_WIDTH + 7 : 0] i_7_16 = i_7 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_7_13 = i_7_16 - i_7_3;
    wire signed [IN_WIDTH + 7 : 0] i_7_24 = i_7_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_7_21 = i_7_24 - i_7_3;
    wire signed [IN_WIDTH + 7 : 0] i_7_28 = i_7_7 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_7_37 = i_7_65 - i_7_28;
    wire signed [IN_WIDTH + 7 : 0] i_7_48 = i_7_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_7_41 = i_7_48 - i_7_7;
    wire signed [IN_WIDTH + 7 : 0] i_7_45 = i_7_48 - i_7_3;
    wire signed [IN_WIDTH + 7 : 0] i_7_69 = i_7_65 + i_7_4;
    wire signed [IN_WIDTH + 7 : 0] i_7_12 = i_7_3 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_7_77 = i_7_65 + i_7_12;
    wire signed [IN_WIDTH + 7 : 0] i_7_14 = i_7_7 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_7_79 = i_7_65 + i_7_14;
    wire signed [IN_WIDTH + 7 : 0] i_7_84 = i_7_21 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_7_90 = i_7_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_7_91 = i_7_90 + i_7;
    wire signed [IN_WIDTH + 7 : 0] i_7_56 = i_7_7 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_7_52 = i_7_13 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_7_88 = i_7_11 <<< 3;
//83 28 -44 -88 -73 -11 59 91 62 -7 -71 -90 -48 24 81 84 / 33 -41 -87 -77 -15 56 90 65 -2 -69 -90 -52 20 79 86 37
    wire signed [IN_WIDTH + 7 : 0] i_8_4  = i_8 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_8_3  = i_8_4 - i_8;
    wire signed [IN_WIDTH + 7 : 0] i_8_8  = i_8 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_8_7  = i_8_8 - i_8;
    wire signed [IN_WIDTH + 7 : 0] i_8_32 = i_8 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_8_31 = i_8_32 - i_8;
    wire signed [IN_WIDTH + 7 : 0] i_8_11 = i_8_3 + i_8_8;
    wire signed [IN_WIDTH + 7 : 0] i_8_24 = i_8_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_8_21 = i_8_24 - i_8_3;
    wire signed [IN_WIDTH + 7 : 0] i_8_48 = i_8_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_8_45 = i_8_48 - i_8_3;
    wire signed [IN_WIDTH + 7 : 0] i_8_56 = i_8_7 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_8_59 = i_8_3 + i_8_56;
    wire signed [IN_WIDTH + 7 : 0] i_8_64 = i_8 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_8_71 = i_8_7 + i_8_64;
    wire signed [IN_WIDTH + 7 : 0] i_8_84 = i_8_21 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_8_81 = i_8_84 - i_8_3;
    wire signed [IN_WIDTH + 7 : 0] i_8_2  = i_8 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_8_73 = i_8_71 + i_8_2;
    wire signed [IN_WIDTH + 7 : 0] i_8_83 = i_8_84 - i_8;
    wire signed [IN_WIDTH + 7 : 0] i_8_90 = i_8_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_8_91 = i_8 + i_8_90;
    wire signed [IN_WIDTH + 7 : 0] i_8_28 = i_8_7 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_8_44 = i_8_11 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_8_88 = i_8_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_8_62 = i_8_31 <<< 1;
//81 15 -62 -90 -44 37 88 69 -7 -77 -84 -24 56 91 52 -28 / -86 -73 -2 71 87 33 -48 -90 -59 20 83 79 11 -65 -90 -41
    wire signed [IN_WIDTH + 7 : 0] i_9_4  = i_9 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_9_3  = i_9_4 - i_9;
    wire signed [IN_WIDTH + 7 : 0] i_9_8  = i_9 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_9_7  = i_9_8 - i_9;
    wire signed [IN_WIDTH + 7 : 0] i_9_16 = i_9 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_9_15 = i_9_16 - i_9;
    wire signed [IN_WIDTH + 7 : 0] i_9_32 = i_9 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_9_31 = i_9_32 - i_9;
    wire signed [IN_WIDTH + 7 : 0] i_9_11 = i_9_3 + i_9_8;
    wire signed [IN_WIDTH + 7 : 0] i_9_13 = i_9_16 - i_9_3;
    wire signed [IN_WIDTH + 7 : 0] i_9_24 = i_9_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_9_21 = i_9_24 - i_9_3;
    wire signed [IN_WIDTH + 7 : 0] i_9_6  = i_9_3 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_9_37 = i_9_31 + i_9_6;
    wire signed [IN_WIDTH + 7 : 0] i_9_48 = i_9_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_9_45 = i_9_48 - i_9_3;
    wire signed [IN_WIDTH + 7 : 0] i_9_62 = i_9_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_9_69 = i_9_7 + i_9_62;
    wire signed [IN_WIDTH + 7 : 0] i_9_77 = i_9_15 + i_9_62;
    wire signed [IN_WIDTH + 7 : 0] i_9_96 = i_9_3 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_9_81 = i_9_96 - i_9_15;
    wire signed [IN_WIDTH + 7 : 0] i_9_60 = i_9_15 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_9_91 = i_9_31 + i_9_60;
    wire signed [IN_WIDTH + 7 : 0] i_9_90 = i_9_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_9_44 = i_9_11 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_9_88 = i_9_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_9_84 = i_9_21 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_9_56 = i_9_7 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_9_52 = i_9_13 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_9_28 = i_9_7 <<< 2;
//79 2 -77 -81 -7 73 83 11 -71 -84 -15 69 86 20 -65 -87 / -24 62 88 28 -59 -90 -33 56 90 37 -52 -90 -41 48 91 44 
    wire signed [IN_WIDTH + 7 : 0] i_10_4  = i_10 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_10_5  = i_10 + i_10_4;
    wire signed [IN_WIDTH + 7 : 0] i_10_8  = i_10 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_10_7  = i_10_8 - i_10;
    wire signed [IN_WIDTH + 7 : 0] i_10_16 = i_10 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_10_15 = i_10_16 - i_10;
    wire signed [IN_WIDTH + 7 : 0] i_10_64 = i_10 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_10_65 = i_10 + i_10_64;
    wire signed [IN_WIDTH + 7 : 0] i_10_11 = i_10_16 - i_10_5;
    wire signed [IN_WIDTH + 7 : 0] i_10_21 = i_10_5 + i_10_16;
    wire signed [IN_WIDTH + 7 : 0] i_10_28 = i_10_7 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_10_43 = i_10_15 + i_10_28;
    wire signed [IN_WIDTH + 7 : 0] i_10_69 = i_10_5 + i_10_64;
    wire signed [IN_WIDTH + 7 : 0] i_10_71 = i_10_7 + i_10_64;
    wire signed [IN_WIDTH + 7 : 0] i_10_73 = i_10_65 + i_10_8;
    wire signed [IN_WIDTH + 7 : 0] i_10_80 = i_10_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_10_79 = i_10_80 - i_10;
    wire signed [IN_WIDTH + 7 : 0] i_10_81 = i_10 + i_10_80;
    wire signed [IN_WIDTH + 7 : 0] i_10_87 = i_10_7 + i_10_80;
    wire signed [IN_WIDTH + 7 : 0] i_10_77 = i_10_69 + i_10_8;
    wire signed [IN_WIDTH + 7 : 0] i_10_84 = i_10_21 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_10_83 = i_10_84 - i_10;
    wire signed [IN_WIDTH + 7 : 0] i_10_2 = i_10 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_10_86 = i_10_43 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_10_20 = i_10_5 <<< 2;
//77 -11 -86 -62 33 90 44 -52 -90 -24 69 83 2 -81 -71 20 / 88 56 -41 -91 -37 59 87 15 -73 -79 7 84 65 -28 -90 -48
    wire signed [IN_WIDTH + 7 : 0] i_11_4  = i_11 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_11_3  = i_11_4 - i_11;
    wire signed [IN_WIDTH + 7 : 0] i_11_5  = i_11 + i_11_4;
    wire signed [IN_WIDTH + 7 : 0] i_11_32 = i_11 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_11_31 = i_11_32 - i_11;
    wire signed [IN_WIDTH + 7 : 0] i_11_33 = i_11 + i_11_32;
    wire signed [IN_WIDTH + 7 : 0] i_11_8  = i_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_11_11 = i_11_3 + i_11_8;
    wire signed [IN_WIDTH + 7 : 0] i_11_16 = i_11 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_11_13 = i_11_16 - i_11_3;
    wire signed [IN_WIDTH + 7 : 0] i_11_48 = i_11_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_11_43 = i_11_48 - i_11_5;
    wire signed [IN_WIDTH + 7 : 0] i_11_45 = i_11_48 - i_11_3;
    wire signed [IN_WIDTH + 7 : 0] i_11_64 = i_11 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_11_69 = i_11_5 + i_11_64;
    wire signed [IN_WIDTH + 7 : 0] i_11_40 = i_11_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_11_71 = i_11_31 + i_11_40;
    wire signed [IN_WIDTH + 7 : 0] i_11_80 = i_11_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_11_77 = i_11_80 - i_11_3;
    wire signed [IN_WIDTH + 7 : 0] i_11_81 = i_11 + i_11_80;
    wire signed [IN_WIDTH + 7 : 0] i_11_83 = i_11_3 + i_11_80;
    wire signed [IN_WIDTH + 7 : 0] i_11_86 = i_11_43 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_11_62 = i_11_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_11_90 = i_11_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_11_44 = i_11_11 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_11_52 = i_11_13 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_11_24 = i_11_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_11_2  = i_11 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_11_20 = i_11_5 <<< 2;
//73 -24 -90 -37 65 81 -11 -88 -48 56 86 2 -84 -59 44 90 / 15 -79 -69 33 91 28 -71 -77 20 90 41 -62 -83 7 87 52
    wire signed [IN_WIDTH + 7 : 0] i_12_4  = i_12 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_12_3  = i_12_4 - i_12;
    wire signed [IN_WIDTH + 7 : 0] i_12_8  = i_12 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_12_7  = i_12_8 - i_12;
    wire signed [IN_WIDTH + 7 : 0] i_12_64 = i_12 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_12_65 = i_12 + i_12_64;
    wire signed [IN_WIDTH + 7 : 0] i_12_11 = i_12_3 + i_12_8;
    wire signed [IN_WIDTH + 7 : 0] i_12_24 = i_12_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_12_21 = i_12_24 - i_12_3;
    wire signed [IN_WIDTH + 7 : 0] i_12_28 = i_12_7 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_12_37 = i_12_65 - i_12_28;
    wire signed [IN_WIDTH + 7 : 0] i_12_48 = i_12_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_12_45 = i_12_48 - i_12_3;
    wire signed [IN_WIDTH + 7 : 0] i_12_56 = i_12_7 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_12_59 = i_12_3 + i_12_56;
    wire signed [IN_WIDTH + 7 : 0] i_12_73 = i_12_65 + i_12_8;
    wire signed [IN_WIDTH + 7 : 0] i_12_16 = i_12 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_12_81 = i_12_65 + i_12_16;
    wire signed [IN_WIDTH + 7 : 0] i_12_32 = i_12 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_12_43 = i_12_11 + i_12_32;
    wire signed [IN_WIDTH + 7 : 0] i_12_90 = i_12_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_12_88 = i_12_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_12_86 = i_12_43 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_12_2  = i_12 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_12_84 = i_12_21 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_12_44 = i_12_11 <<< 2;
//71 -37 -90 -7 86 48 -62 -79 24 91 20 -81 -59 52 84 -11 / -90 -33 73 69 -41 -88 -2 87 44 -65 -77 28 90 15 -83 -56
    wire signed [IN_WIDTH + 7 : 0] i_13_4  = i_13 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_13_3  = i_13_4 - i_13;
    wire signed [IN_WIDTH + 7 : 0] i_13_5  = i_13 + i_13_4;
    wire signed [IN_WIDTH + 7 : 0] i_13_8  = i_13 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_13_7  = i_13_8 - i_13;
    wire signed [IN_WIDTH + 7 : 0] i_13_32 = i_13 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_13_31 = i_13_32 - i_13;
    wire signed [IN_WIDTH + 7 : 0] i_13_11 = i_13_3 + i_13_8;
    wire signed [IN_WIDTH + 7 : 0] i_13_16 = i_13 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_13_13 = i_13_16 - i_13_3;
    wire signed [IN_WIDTH + 7 : 0] i_13_21 = i_13_5 + i_13_16;
    wire signed [IN_WIDTH + 7 : 0] i_13_37 = i_13_5 + i_13_32;
    wire signed [IN_WIDTH + 7 : 0] i_13_48 = i_13_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_13_43 = i_13_48 - i_13_5;
    wire signed [IN_WIDTH + 7 : 0] i_13_45 = i_13_48 - i_13_3;
    wire signed [IN_WIDTH + 7 : 0] i_13_64 = i_13 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_13_59 = i_13_64 - i_13_5;
    wire signed [IN_WIDTH + 7 : 0] i_13_71 = i_13_7 + i_13_64;
    wire signed [IN_WIDTH + 7 : 0] i_13_80 = i_13_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_13_79 = i_13_80 - i_13;
    wire signed [IN_WIDTH + 7 : 0] i_13_81 = i_13 + i_13_80;
    wire signed [IN_WIDTH + 7 : 0] i_13_96 = i_13_3 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_13_91 = i_13_96 - i_13_5;
    wire signed [IN_WIDTH + 7 : 0] i_13_90 = i_13_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_13_86 = i_13_43 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_13_62 = i_13_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_13_24 = i_13_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_13_20 = i_13_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_13_52 = i_13_13 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_13_84 = i_13_21 <<< 2;
//69 -48 -83 24 90 2 -90 -28 81 52 -65 -71 44 84 -20 -90 / -7 88 33 -79 -56 62 73 -41 -86 15 91 11 -87 -37 77 59
    wire signed [IN_WIDTH + 7 : 0] i_14_4  = i_14 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_14_3  = i_14_4 - i_14;
    wire signed [IN_WIDTH + 7 : 0] i_14_5  = i_14 + i_14_4;
    wire signed [IN_WIDTH + 7 : 0] i_14_8  = i_14 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_14_7  = i_14_8 - i_14;
    wire signed [IN_WIDTH + 7 : 0] i_14_64 = i_14 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_14_65 = i_14 + i_14_64;
    wire signed [IN_WIDTH + 7 : 0] i_14_11 = i_14_3 + i_14_8;
    wire signed [IN_WIDTH + 7 : 0] i_14_16 = i_14 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_14_13 = i_14_16 - i_14_3;
    wire signed [IN_WIDTH + 7 : 0] i_14_21 = i_14_5 + i_14_16;
    wire signed [IN_WIDTH + 7 : 0] i_14_48 = i_14_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_14_45 = i_14_48 - i_14_3;
    wire signed [IN_WIDTH + 7 : 0] i_14_69 = i_14_5 + i_14_64;
    wire signed [IN_WIDTH + 7 : 0] i_14_71 = i_14_7 + i_14_64;
    wire signed [IN_WIDTH + 7 : 0] i_14_80 = i_14_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_14_81 = i_14 + i_14_80;
    wire signed [IN_WIDTH + 7 : 0] i_14_83 = i_14_3 + i_14_80;
    wire signed [IN_WIDTH + 7 : 0] i_14_24 = i_14_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_14_90 = i_14_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_14_2  = i_14 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_14_28 = i_14_7 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_14_52 = i_14_13 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_14_44 = i_14_11 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_14_84 = i_14_21 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_14_20 = i_14_5 <<< 2;
//65 -59 -71 52 77 -44 -81 37 84 -28 -87 20 90 -11 -90 2 / 91 7 -90 -15 88 24 -86 -33 83 41 -79 -48 73 56 -69 -62
    wire signed [IN_WIDTH + 7 : 0] i_15_4  = i_15 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_15_5  = i_15 + i_15_4;
    wire signed [IN_WIDTH + 7 : 0] i_15_8  = i_15 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_15_7  = i_15_8 - i_15;
    wire signed [IN_WIDTH + 7 : 0] i_15_64 = i_15 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_15_65 = i_15 + i_15_64;
    wire signed [IN_WIDTH + 7 : 0] i_15_16 = i_15 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_15_11 = i_15_16 - i_15_5;
    wire signed [IN_WIDTH + 7 : 0] i_15_13 = i_15_5 + i_15_8;
    wire signed [IN_WIDTH + 7 : 0] i_15_21 = i_15_5 + i_15_16;
    wire signed [IN_WIDTH + 7 : 0] i_15_32 = i_15 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_15_37 = i_15_5 + i_15_32;
    wire signed [IN_WIDTH + 7 : 0] i_15_40 = i_15_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_15_45 = i_15_5 + i_15_40;
    wire signed [IN_WIDTH + 7 : 0] i_15_59 = i_15_64 - i_15_5;
    wire signed [IN_WIDTH + 7 : 0] i_15_71 = i_15_7 + i_15_64;
    wire signed [IN_WIDTH + 7 : 0] i_15_80 = i_15_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_15_81 = i_15 + i_15_80;
    wire signed [IN_WIDTH + 7 : 0] i_15_87 = i_15_7 + i_15_80;
    wire signed [IN_WIDTH + 7 : 0] i_15_77 = i_15_13 + i_15_64;
    wire signed [IN_WIDTH + 7 : 0] i_15_52 = i_15_13 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_15_44 = i_15_11 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_15_84 = i_15_21 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_15_28 = i_15_7 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_15_20 = i_15_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_15_90 = i_15_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_15_2  = i_15 <<< 1;
//62 -69 -56 73 48 -79 -41 83 33 -86 -24 88 15 -90 -7 91 / -2 -90 11 90 -20 -87 28 84 -37 -81 44 77 -52 -71 59 65
    wire signed [IN_WIDTH + 7 : 0] i_16_4  = i_16 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_16_3  = i_16_4 - i_16;
    wire signed [IN_WIDTH + 7 : 0] i_16_8  = i_16 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_16_7  = i_16_8 - i_16;
    wire signed [IN_WIDTH + 7 : 0] i_16_16 = i_16 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_16_15 = i_16_16 - i_16;
    wire signed [IN_WIDTH + 7 : 0] i_16_32 = i_16 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_16_31 = i_16_32 - i_16;
    wire signed [IN_WIDTH + 7 : 0] i_16_33 = i_16 + i_16_32;
    wire signed [IN_WIDTH + 7 : 0] i_16_11 = i_16_3 + i_16_8;
    wire signed [IN_WIDTH + 7 : 0] i_16_41 = i_16_33 + i_16_8;
    wire signed [IN_WIDTH + 7 : 0] i_16_12 = i_16_3 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_16_43 = i_16_31 + i_16_12;
    wire signed [IN_WIDTH + 7 : 0] i_16_48 = i_16_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_16_45 = i_16_48 - i_16_3;
    wire signed [IN_WIDTH + 7 : 0] i_16_66 = i_16_33 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_16_69 = i_16_3 + i_16_66;
    wire signed [IN_WIDTH + 7 : 0] i_16_73 = i_16_7 + i_16_66;
    wire signed [IN_WIDTH + 7 : 0] i_16_64 = i_16 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_16_79 = i_16_15 + i_16_64;
    wire signed [IN_WIDTH + 7 : 0] i_16_60 = i_16_15 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_16_91 = i_16_31 + i_16_60;
    wire signed [IN_WIDTH + 7 : 0] i_16_82 = i_16_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_16_83 = i_16 + i_16_82;
    wire signed [IN_WIDTH + 7 : 0] i_16_62 = i_16_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_16_56 = i_16_7 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_16_86 = i_16_43 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_16_24 = i_16_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_16_88 = i_16_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_16_90 = i_16_45 <<< 1;
//59 -77 -37 87 11 -91 15 86 -41 -73 62 56 -79 -33 88 7 / -90 20 84 -44 -71 65 52 -81 -28 90 2 -90 24 83 -48 -69
    wire signed [IN_WIDTH + 7 : 0] i_17_8  = i_17 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_17_7  = i_17_8 - i_17;
    wire signed [IN_WIDTH + 7 : 0] i_17_16 = i_17 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_17_15 = i_17_16 - i_17;
    wire signed [IN_WIDTH + 7 : 0] i_17_32 = i_17 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_17_31 = i_17_32 - i_17;
    wire signed [IN_WIDTH + 7 : 0] i_17_33 = i_17 + i_17_32;
    wire signed [IN_WIDTH + 7 : 0] i_17_4  = i_17 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_17_11 = i_17_7 + i_17_4;
    wire signed [IN_WIDTH + 7 : 0] i_17_37 = i_17_33 + i_17_4;
    wire signed [IN_WIDTH + 7 : 0] i_17_41 = i_17_33 + i_17_8;
    wire signed [IN_WIDTH + 7 : 0] i_17_28 = i_17_7 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_17_43 = i_17_15 + i_17_28;
    wire signed [IN_WIDTH + 7 : 0] i_17_60 = i_17_15 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_17_59 = i_17_60 - i_17;
    wire signed [IN_WIDTH + 7 : 0] i_17_66 = i_17_33 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_17_73 = i_17_7 + i_17_66;
    wire signed [IN_WIDTH + 7 : 0] i_17_62 = i_17_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_17_77 = i_17_15 + i_17_62;
    wire signed [IN_WIDTH + 7 : 0] i_17_64 = i_17 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_17_79 = i_17_15 + i_17_64;
    wire signed [IN_WIDTH + 7 : 0] i_17_56 = i_17_7 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_17_87 = i_17_31 + i_17_56;
    wire signed [IN_WIDTH + 7 : 0] i_17_91 = i_17_31 + i_17_60;
    wire signed [IN_WIDTH + 7 : 0] i_17_86 = i_17_43 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_17_88 = i_17_11 <<< 3;
//56 -83 -15 90 -28 -77 65 44 -87 -2 88 -41 -69 73 33 -90 / 11 84 -52 -59 81 20 -91 24 79 -62 -48 86 7 -90 37 71
    wire signed [IN_WIDTH + 7 : 0] i_18_8  = i_18 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_18_7  = i_18_8 - i_18;
    wire signed [IN_WIDTH + 7 : 0] i_18_16 = i_18 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_18_15 = i_18_16 - i_18;
    wire signed [IN_WIDTH + 7 : 0] i_18_32 = i_18 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_18_33 = i_18 + i_18_32;
    wire signed [IN_WIDTH + 7 : 0] i_18_64 = i_18 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_18_65 = i_18 + i_18_64;
    wire signed [IN_WIDTH + 7 : 0] i_18_4  = i_18 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_18_11 = i_18_7 + i_18_4;
    wire signed [IN_WIDTH + 7 : 0] i_18_41 = i_18_33 + i_18_8;
    wire signed [IN_WIDTH + 7 : 0] i_18_60 = i_18_15 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_18_45 = i_18_60 - i_18_15;
    wire signed [IN_WIDTH + 7 : 0] i_18_69 = i_18_65 + i_18_4;
    wire signed [IN_WIDTH + 7 : 0] i_18_73 = i_18_65 + i_18_8;
    wire signed [IN_WIDTH + 7 : 0] i_18_77 = i_18_45 + i_18_32;
    wire signed [IN_WIDTH + 7 : 0] i_18_82 = i_18_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_18_83 = i_18 + i_18_82;
    wire signed [IN_WIDTH + 7 : 0] i_18_87 = i_18_83 + i_18_4;
    wire signed [IN_WIDTH + 7 : 0] i_18_56 = i_18_7 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_18_90 = i_18_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_18_28 = i_18_7 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_18_44 = i_18_11 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_18_2  = i_18 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_18_88 = i_18_11 <<< 3;
//52 -87 7 83 -62 -41 90 -20 -77 71 28 -91 33 69 -79 -15 / 90 -44 -59 84 2 -86 56 48 -88 11 81 -65 -37 90 -24 -73 
    wire signed [IN_WIDTH + 7 : 0] i_19_4  = i_19 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_19_5  = i_19 + i_19_4;
    wire signed [IN_WIDTH + 7 : 0] i_19_8  = i_19 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_19_7  = i_19_8 - i_19;
    wire signed [IN_WIDTH + 7 : 0] i_19_16 = i_19 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_19_15 = i_19_16 - i_19;
    wire signed [IN_WIDTH + 7 : 0] i_19_32 = i_19 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_19_31 = i_19_32 - i_19;
    wire signed [IN_WIDTH + 7 : 0] i_19_33 = i_19 + i_19_32;
    wire signed [IN_WIDTH + 7 : 0] i_19_13 = i_19_5 + i_19_8;
    wire signed [IN_WIDTH + 7 : 0] i_19_40 = i_19_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_19_41 = i_19 + i_19_40;
    wire signed [IN_WIDTH + 7 : 0] i_19_45 = i_19_5 + i_19_40;
    wire signed [IN_WIDTH + 7 : 0] i_19_64 = i_19 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_19_69 = i_19_5 + i_19_64;
    wire signed [IN_WIDTH + 7 : 0] i_19_71 = i_19_7 + i_19_64;
    wire signed [IN_WIDTH + 7 : 0] i_19_62 = i_19_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_19_77 = i_19_15 + i_19_62;
    wire signed [IN_WIDTH + 7 : 0] i_19_80 = i_19_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_19_79 = i_19_80 - i_19;
    wire signed [IN_WIDTH + 7 : 0] i_19_87 = i_19_7 + i_19_80;
    wire signed [IN_WIDTH + 7 : 0] i_19_60 = i_19_15 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_19_91 = i_19_31 + i_19_60;
    wire signed [IN_WIDTH + 7 : 0] i_19_82 = i_19_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_19_83 = i_19 + i_19_82;
    wire signed [IN_WIDTH + 7 : 0] i_19_52 = i_19_13 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_19_90 = i_19_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_19_20 = i_19_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_19_28 = i_19_7 <<< 2;
//48 -90 28 65 -84 7 79 -73 -15 87 -59 -37 91 -41 -56 88 / -20 -71 81 2 -83 69 24 -90 52 44 -90 33 62 -86 11 77
    wire signed [IN_WIDTH + 7 : 0] i_20_4  = i_20 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_20_3  = i_20_4 - i_20;
    wire signed [IN_WIDTH + 7 : 0] i_20_8  = i_20 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_20_7  = i_20_8 - i_20;
    wire signed [IN_WIDTH + 7 : 0] i_20_16 = i_20 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_20_15 = i_20_16 - i_20;
    wire signed [IN_WIDTH + 7 : 0] i_20_64 = i_20 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_20_65 = i_20 + i_20_64;
    wire signed [IN_WIDTH + 7 : 0] i_20_11 = i_20_3 + i_20_8;
    wire signed [IN_WIDTH + 7 : 0] i_20_24 = i_20_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_20_21 = i_20_24 - i_20_3;
    wire signed [IN_WIDTH + 7 : 0] i_20_30 = i_20_15 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_20_37 = i_20_7 + i_20_30;
    wire signed [IN_WIDTH + 7 : 0] i_20_48 = i_20_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_20_41 = i_20_48 - i_20_7;
    wire signed [IN_WIDTH + 7 : 0] i_20_45 = i_20_48 - i_20_3;
    wire signed [IN_WIDTH + 7 : 0] i_20_60 = i_20_15 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_20_59 = i_20_60 - i_20;
    wire signed [IN_WIDTH + 7 : 0] i_20_73 = i_20_65 + i_20_8;
    wire signed [IN_WIDTH + 7 : 0] i_20_79 = i_20_15 + i_20_64;
    wire signed [IN_WIDTH + 7 : 0] i_20_88 = i_20_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_20_87 = i_20_88 - i_20;
    wire signed [IN_WIDTH + 7 : 0] i_20_90 = i_20_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_20_91 = i_20_90 + i_20;
    wire signed [IN_WIDTH + 7 : 0] i_20_28 = i_20_7 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_20_84 = i_20_21 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_20_56 = i_20_7 <<< 3;
//44 -91 48 41 -90 52 37 -90 56 33 -90 59 28 -88 62 24 / -87 65 20 -86 69 15 -84 71 11 -83 73 7 -81 77 2 -79
    wire signed [IN_WIDTH + 7 : 0] i_21_4  = i_21 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_21_3  = i_21_4 - i_21;
    wire signed [IN_WIDTH + 7 : 0] i_21_8  = i_21 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_21_7  = i_21_8 - i_21;
    wire signed [IN_WIDTH + 7 : 0] i_21_32 = i_21 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_21_31 = i_21_32 - i_21;
    wire signed [IN_WIDTH + 7 : 0] i_21_33 = i_21 + i_21_32;
    wire signed [IN_WIDTH + 7 : 0] i_21_11 = i_21_3 + i_21_8;
    wire signed [IN_WIDTH + 7 : 0] i_21_16 = i_21 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_21_13 = i_21_16 - i_21_3;
    wire signed [IN_WIDTH + 7 : 0] i_21_37 = i_21_33 + i_21_4;
    wire signed [IN_WIDTH + 7 : 0] i_21_41 = i_21_33 + i_21_8;
    wire signed [IN_WIDTH + 7 : 0] i_21_48 = i_21_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_21_45 = i_21_48 - i_21_3;
    wire signed [IN_WIDTH + 7 : 0] i_21_56 = i_21_7 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_21_59 = i_21_3 + i_21_56;
    wire signed [IN_WIDTH + 7 : 0] i_21_44 = i_21_11 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_21_90 = i_21_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_21_91 = i_21_90 + i_21;
    wire signed [IN_WIDTH + 7 : 0] i_21_52 = i_21_13 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_21_28 = i_21_7 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_21_88 = i_21_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_21_62 = i_21_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_21_24 = i_21_3 <<< 3;
//41 -90 65 11 -79 83 -20 -59 90 -48 -33 87 -71 -2 73 -86 / 28 52 -91 56 24 -84 77 -7 -69 88 -37 -44 90 -62 -15 81
    wire signed [IN_WIDTH + 7 : 0] i_22_4  = i_22 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_22_3  = i_22_4 - i_22;
    wire signed [IN_WIDTH + 7 : 0] i_22_5  = i_22 + i_22_4;
    wire signed [IN_WIDTH + 7 : 0] i_22_32 = i_22 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_22_33 = i_22 + i_22_32;
    wire signed [IN_WIDTH + 7 : 0] i_22_64 = i_22 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_22_65 = i_22 + i_22_64;
    wire signed [IN_WIDTH + 7 : 0] i_22_8  = i_22 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_22_11 = i_22_3 + i_22_8;
    wire signed [IN_WIDTH + 7 : 0] i_22_40 = i_22_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_22_41 = i_22 + i_22_40;
    wire signed [IN_WIDTH + 7 : 0] i_22_48 = i_22_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_22_43 = i_22_48 - i_22_5;
    wire signed [IN_WIDTH + 7 : 0] i_22_45 = i_22_48 - i_22_3;
    wire signed [IN_WIDTH + 7 : 0] i_22_59 = i_22_64 - i_22_5;
    wire signed [IN_WIDTH + 7 : 0] i_22_6  = i_22_3 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_22_71 = i_22_65 + i_22_6;
    wire signed [IN_WIDTH + 7 : 0] i_22_73 = i_22_65 + i_22_8;
    wire signed [IN_WIDTH + 7 : 0] i_22_80 = i_22_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_22_79 = i_22_80 - i_22;
    wire signed [IN_WIDTH + 7 : 0] i_22_83 = i_22_3 + i_22_80;
    wire signed [IN_WIDTH + 7 : 0] i_22_88 = i_22_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_22_87 = i_22_88 - i_22;
    wire signed [IN_WIDTH + 7 : 0] i_22_90 = i_22_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_22_20 = i_22_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_22_2  = i_22 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_22_86 = i_22_43 <<< 1;
//37 -86 79 -20 -52 90 -69 2 65 -90 56 15 -77 87 -41 -33 / 84 -81 24 48 -90 71 -7 -62 91 -59 -11 73 -88 44 28 -83
    wire signed [IN_WIDTH + 7 : 0] i_23_4  = i_23 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_23_5  = i_23 + i_23_4;
    wire signed [IN_WIDTH + 7 : 0] i_23_8  = i_23 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_23_7  = i_23_8 - i_23;
    wire signed [IN_WIDTH + 7 : 0] i_23_16 = i_23 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_23_15 = i_23_16 - i_23;
    wire signed [IN_WIDTH + 7 : 0] i_23_32 = i_23 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_23_33 = i_23 + i_23_32;
    wire signed [IN_WIDTH + 7 : 0] i_23_64 = i_23 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_23_65 = i_23 + i_23_64;
    wire signed [IN_WIDTH + 7 : 0] i_23_13 = i_23_5 + i_23_8;
    wire signed [IN_WIDTH + 7 : 0] i_23_37 = i_23_5 + i_23_32;
    wire signed [IN_WIDTH + 7 : 0] i_23_40 = i_23_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_23_41 = i_23 + i_23_40;
    wire signed [IN_WIDTH + 7 : 0] i_23_10 = i_23_5 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_23_43 = i_23_33 + i_23_10;
    wire signed [IN_WIDTH + 7 : 0] i_23_45 = i_23_5 + i_23_40;
    wire signed [IN_WIDTH + 7 : 0] i_23_69 = i_23_5 + i_23_64;
    wire signed [IN_WIDTH + 7 : 0] i_23_80 = i_23_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_23_79 = i_23_80 - i_23;
    wire signed [IN_WIDTH + 7 : 0] i_23_87 = i_23_7 + i_23_80;
    wire signed [IN_WIDTH + 7 : 0] i_23_77 = i_23_13 + i_23_64;
    wire signed [IN_WIDTH + 7 : 0] i_23_86 = i_23_43 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_23_20 = i_23_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_23_52 = i_23_13 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_23_90 = i_23_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_23_2  = i_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_23_56 = i_23_7 <<< 3;
//33 -81 87 -48 -15 71 -90 62 -2 -59 90 -73 20 44 -86 83 / -37 -28 79 -88 52 11 -69 91 -65 7 56 -90 77 -24 -41 84
    wire signed [IN_WIDTH + 7 : 0] i_24_4  = i_24 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_24_3  = i_24_4 - i_24;
    wire signed [IN_WIDTH + 7 : 0] i_24_5  = i_24 + i_24_4;
    wire signed [IN_WIDTH + 7 : 0] i_24_16 = i_24 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_24_15 = i_24_16 - i_24;
    wire signed [IN_WIDTH + 7 : 0] i_24_32 = i_24 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_24_31 = i_24_32 - i_24;
    wire signed [IN_WIDTH + 7 : 0] i_24_33 = i_24 + i_24_32;
    wire signed [IN_WIDTH + 7 : 0] i_24_8  = i_24 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_24_11 = i_24_3 + i_24_8;
    wire signed [IN_WIDTH + 7 : 0] i_24_48 = i_24_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_24_43 = i_24_48 - i_24_5;
    wire signed [IN_WIDTH + 7 : 0] i_24_45 = i_24_48 - i_24_3;
    wire signed [IN_WIDTH + 7 : 0] i_24_64 = i_24 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_24_59 = i_24_64 - i_24_5;
    wire signed [IN_WIDTH + 7 : 0] i_24_40 = i_24_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_24_71 = i_24_31 + i_24_40;
    wire signed [IN_WIDTH + 7 : 0] i_24_73 = i_24_33 + i_24_40;
    wire signed [IN_WIDTH + 7 : 0] i_24_80 = i_24_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_24_81 = i_24 + i_24_80;
    wire signed [IN_WIDTH + 7 : 0] i_24_83 = i_24_3 + i_24_80;
    wire signed [IN_WIDTH + 7 : 0] i_24_87 = i_24_83 + i_24_4;
    wire signed [IN_WIDTH + 7 : 0] i_24_90 = i_24_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_24_62 = i_24_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_24_2  = i_24 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_24_20 = i_24_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_24_44 = i_24_11 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_24_86 = i_24_43 <<< 1;
//28 -73 91 -71 24 33 -77 90 -69 20 37 -79 90 -65 15 41 / -81 90 -62 11 44 -83 88 -59 7 48 -84 87 -56 2 52 -86
    wire signed [IN_WIDTH + 7 : 0] i_25_4  = i_25 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_25_3  = i_25_4 - i_25;
    wire signed [IN_WIDTH + 7 : 0] i_25_5  = i_25 + i_25_4;
    wire signed [IN_WIDTH + 7 : 0] i_25_8  = i_25 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_25_7  = i_25_8 - i_25;
    wire signed [IN_WIDTH + 7 : 0] i_25_16 = i_25 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_25_15 = i_25_16 - i_25;
    wire signed [IN_WIDTH + 7 : 0] i_25_32 = i_25 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_25_33 = i_25 + i_25_32;
    wire signed [IN_WIDTH + 7 : 0] i_25_64 = i_25 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_25_65 = i_25 + i_25_64;
    wire signed [IN_WIDTH + 7 : 0] i_25_37 = i_25_5 + i_25_32;
    wire signed [IN_WIDTH + 7 : 0] i_25_40 = i_25_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_25_41 = i_25 + i_25_40;
    wire signed [IN_WIDTH + 7 : 0] i_25_48 = i_25_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_25_45 = i_25_48 - i_25_3;
    wire signed [IN_WIDTH + 7 : 0] i_25_69 = i_25_5 + i_25_64;
    wire signed [IN_WIDTH + 7 : 0] i_25_71 = i_25_7 + i_25_64;
    wire signed [IN_WIDTH + 7 : 0] i_25_73 = i_25_65 + i_25_8;
    wire signed [IN_WIDTH + 7 : 0] i_25_80 = i_25_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_25_77 = i_25_80 - i_25_3;
    wire signed [IN_WIDTH + 7 : 0] i_25_79 = i_25_80 - i_25;
    wire signed [IN_WIDTH + 7 : 0] i_25_96 = i_25_3 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_25_91 = i_25_96 - i_25_5;
    wire signed [IN_WIDTH + 7 : 0] i_25_28 = i_25_7 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_25_24 = i_25_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_25_90 = i_25_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_25_20 = i_25_5 <<< 2;
//24 -65 88 -86 59 -15 -33 71 -90 83 -52 7 41 -77 91 -79 / 44 2 -48 81 -90 73 -37 -11 56 -84 90 -69 28 20 -62 87
    wire signed [IN_WIDTH + 7 : 0] i_26_4  = i_26 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_26_3  = i_26_4 - i_26;
    wire signed [IN_WIDTH + 7 : 0] i_26_8  = i_26 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_26_7  = i_26_8 - i_26;
    wire signed [IN_WIDTH + 7 : 0] i_26_16 = i_26 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_26_15 = i_26_16 - i_26;
    wire signed [IN_WIDTH + 7 : 0] i_26_32 = i_26 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_26_33 = i_26 + i_26_32;
    wire signed [IN_WIDTH + 7 : 0] i_26_64 = i_26 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_26_65 = i_26 + i_26_64;
    wire signed [IN_WIDTH + 7 : 0] i_26_11 = i_26_3 + i_26_8;
    wire signed [IN_WIDTH + 7 : 0] i_26_13 = i_26_16 - i_26_3;
    wire signed [IN_WIDTH + 7 : 0] i_26_41 = i_26_33 + i_26_8;
    wire signed [IN_WIDTH + 7 : 0] i_26_28 = i_26_7 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_26_43 = i_26_15 + i_26_28;
    wire signed [IN_WIDTH + 7 : 0] i_26_48 = i_26_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_26_45 = i_26_48 - i_26_3;
    wire signed [IN_WIDTH + 7 : 0] i_26_60 = i_26_15 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_26_59 = i_26_60 - i_26;
    wire signed [IN_WIDTH + 7 : 0] i_26_71 = i_26_7 + i_26_64;
    wire signed [IN_WIDTH + 7 : 0] i_26_12 = i_26_3 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_26_77 = i_26_65 + i_26_12;
    wire signed [IN_WIDTH + 7 : 0] i_26_79 = i_26_15 + i_26_64;
    wire signed [IN_WIDTH + 7 : 0] i_26_82 = i_26_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_26_83 = i_26 + i_26_82;
    wire signed [IN_WIDTH + 7 : 0] i_26_90 = i_26_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_26_91 = i_26 + i_26_90;
    wire signed [IN_WIDTH + 7 : 0] i_26_24 = i_26_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_26_88 = i_26_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_26_86 = i_26_43 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_26_52 = i_26_13 <<< 2;
//20 -56 81 -91 83 -59 24 15 -52 79 -90 84 -62 28 11 -48 / 77 -90 86 -65 33 7 -44 73 -90 87 -69 37 2 -41 71 -88 
    wire signed [IN_WIDTH + 7 : 0] i_27_4  = i_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_27_3  = i_27_4 - i_27;
    wire signed [IN_WIDTH + 7 : 0] i_27_5  = i_27 + i_27_4;
    wire signed [IN_WIDTH + 7 : 0] i_27_8  = i_27 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_27_7  = i_27_8 - i_27;
    wire signed [IN_WIDTH + 7 : 0] i_27_16 = i_27 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_27_15 = i_27_16 - i_27;
    wire signed [IN_WIDTH + 7 : 0] i_27_32 = i_27 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_27_31 = i_27_32 - i_27;
    wire signed [IN_WIDTH + 7 : 0] i_27_11 = i_27_3 + i_27_8;
    wire signed [IN_WIDTH + 7 : 0] i_27_13 = i_27_16 - i_27_3;
    wire signed [IN_WIDTH + 7 : 0] i_27_21 = i_27_5 + i_27_16;
    wire signed [IN_WIDTH + 7 : 0] i_27_48 = i_27_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_27_45 = i_27_48 - i_27_3;
    wire signed [IN_WIDTH + 7 : 0] i_27_64 = i_27 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_27_59 = i_27_64 - i_27_5;
    wire signed [IN_WIDTH + 7 : 0] i_27_80 = i_27_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_27_79 = i_27_80 - i_27;
    wire signed [IN_WIDTH + 7 : 0] i_27_81 = i_27 + i_27_80;
    wire signed [IN_WIDTH + 7 : 0] i_27_83 = i_27_3 + i_27_80;
    wire signed [IN_WIDTH + 7 : 0] i_27_96 = i_27_3 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_27_91 = i_27_96 - i_27_5;
    wire signed [IN_WIDTH + 7 : 0] i_27_20 = i_27_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_27_56 = i_27_7 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_27_24 = i_27_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_27_52 = i_27_13 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_27_90 = i_27_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_27_84 = i_27_21 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_27_62 = i_27_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_27_28 = i_27_7 <<< 2;
//15 -44 69 -84 91 -86 71 -48 20 11 -41 65 -83 90 -87 73 / -52 24 7 -37 62 -81 90 -88 77 -56 28 2 -33 59 -79 90
    wire signed [IN_WIDTH + 7 : 0] i_28_4  = i_28 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_28_3  = i_28_4 - i_28;
    wire signed [IN_WIDTH + 7 : 0] i_28_5  = i_28 + i_28_4;
    wire signed [IN_WIDTH + 7 : 0] i_28_16 = i_28 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_28_15 = i_28_16 - i_28;
    wire signed [IN_WIDTH + 7 : 0] i_28_64 = i_28 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_28_65 = i_28 + i_28_64;
    wire signed [IN_WIDTH + 7 : 0] i_28_8  = i_28 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_28_11 = i_28_3 + i_28_8;
    wire signed [IN_WIDTH + 7 : 0] i_28_21 = i_28_5 + i_28_16;
    wire signed [IN_WIDTH + 7 : 0] i_28_40 = i_28_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_28_41 = i_28 + i_28_40;
    wire signed [IN_WIDTH + 7 : 0] i_28_48 = i_28_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_28_43 = i_28_48 - i_28_5;
    wire signed [IN_WIDTH + 7 : 0] i_28_45 = i_28_48 - i_28_3;
    wire signed [IN_WIDTH + 7 : 0] i_28_69 = i_28_5 + i_28_64;
    wire signed [IN_WIDTH + 7 : 0] i_28_6  = i_28_3 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_28_71 = i_28_65 + i_28_6;
    wire signed [IN_WIDTH + 7 : 0] i_28_73 = i_28_65 + i_28_8;
    wire signed [IN_WIDTH + 7 : 0] i_28_80 = i_28_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_28_83 = i_28_3 + i_28_80;
    wire signed [IN_WIDTH + 7 : 0] i_28_96 = i_28_3 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_28_91 = i_28_96 - i_28_5;
    wire signed [IN_WIDTH + 7 : 0] i_28_88 = i_28_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_28_87 = i_28_88 - i_28;
    wire signed [IN_WIDTH + 7 : 0] i_28_44 = i_28_11 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_28_84 = i_28_21 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_28_86 = i_28_43 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_28_20 = i_28_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_28_90 = i_28_45 <<< 1;
//11 -33 52 -69 81 -88 91 -87 79 -65 48 -28 7 15 -37 56 / -71 83 -90 90 -86 77 -62 44 -24 2 20 -41 59 -73 84 -90
    wire signed [IN_WIDTH + 7 : 0] i_29_4  = i_29 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_29_3  = i_29_4 - i_29;
    wire signed [IN_WIDTH + 7 : 0] i_29_8  = i_29 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_29_7  = i_29_8 - i_29;
    wire signed [IN_WIDTH + 7 : 0] i_29_16 = i_29 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_29_15 = i_29_16 - i_29;
    wire signed [IN_WIDTH + 7 : 0] i_29_32 = i_29 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_29_33 = i_29 + i_29_32;
    wire signed [IN_WIDTH + 7 : 0] i_29_64 = i_29 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_29_65 = i_29 + i_29_64;
    wire signed [IN_WIDTH + 7 : 0] i_29_11 = i_29_3 + i_29_8;
    wire signed [IN_WIDTH + 7 : 0] i_29_13 = i_29_16 - i_29_3;
    wire signed [IN_WIDTH + 7 : 0] i_29_37 = i_29_33 + i_29_4;
    wire signed [IN_WIDTH + 7 : 0] i_29_69 = i_29_65 + i_29_4;
    wire signed [IN_WIDTH + 7 : 0] i_29_79 = i_29_15 + i_29_64;
    wire signed [IN_WIDTH + 7 : 0] i_29_81 = i_29_65 + i_29_16;
    wire signed [IN_WIDTH + 7 : 0] i_29_87 = i_29_79 + i_29_8;
    wire signed [IN_WIDTH + 7 : 0] i_29_91 = i_29_87 + i_29_4;
    wire signed [IN_WIDTH + 7 : 0] i_29_52 = i_29_13 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_29_88 = i_29_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_29_48 = i_29_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_29_28 = i_29_7 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_29_56 = i_29_7 <<< 3;
//7 -20 33 -44 56 -65 73 -81 86 -90 91 -90 87 -83 77 -69 / 59 -48 37 -24 11 2 -15 28 -41 52 -62 71 -79 84 -88 90
    wire signed [IN_WIDTH + 7 : 0] i_30_4  = i_30 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_30_5  = i_30 + i_30_4;
    wire signed [IN_WIDTH + 7 : 0] i_30_8  = i_30 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_30_7  = i_30_8 - i_30;
    wire signed [IN_WIDTH + 7 : 0] i_30_32 = i_30 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_30_33 = i_30 + i_30_32;
    wire signed [IN_WIDTH + 7 : 0] i_30_64 = i_30 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_30_65 = i_30 + i_30_64;
    wire signed [IN_WIDTH + 7 : 0] i_30_16 = i_30 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_30_11 = i_30_16 - i_30_5;
    wire signed [IN_WIDTH + 7 : 0] i_30_10 = i_30_5 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_30_43 = i_30_33 + i_30_10;
    wire signed [IN_WIDTH + 7 : 0] i_30_40 = i_30_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_30_45 = i_30_5 + i_30_40;
    wire signed [IN_WIDTH + 7 : 0] i_30_69 = i_30_5 + i_30_64;
    wire signed [IN_WIDTH + 7 : 0] i_30_73 = i_30_65 + i_30_8;
    wire signed [IN_WIDTH + 7 : 0] i_30_80 = i_30_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_30_81 = i_30 + i_30_80;
    wire signed [IN_WIDTH + 7 : 0] i_30_87 = i_30_7 + i_30_80;
    wire signed [IN_WIDTH + 7 : 0] i_30_77 = i_30_45 + i_30_32;
    wire signed [IN_WIDTH + 7 : 0] i_30_83 = i_30_87 - i_30_4;
    wire signed [IN_WIDTH + 7 : 0] i_30_90 = i_30_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_30_91 = i_30 + i_30_90;
    wire signed [IN_WIDTH + 7 : 0] i_30_20 = i_30_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_30_44 = i_30_11 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_30_56 = i_30_7 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_30_86 = i_30_43 <<< 1;
//2 -7 11 -15 20 -24 28 -33 37 -41 44 -48 52 -56 59 -62 / 65 -69 71 -73 77 -79 81 -83 84 -86 87 -88 90 -90 90 -91
    wire signed [IN_WIDTH + 7 : 0] i_31_4  = i_31 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_31_3  = i_31_4 - i_31;
    wire signed [IN_WIDTH + 7 : 0] i_31_5  = i_31 + i_31_4;
    wire signed [IN_WIDTH + 7 : 0] i_31_8  = i_31 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_31_7  = i_31_8 - i_31;
    wire signed [IN_WIDTH + 7 : 0] i_31_16 = i_31 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_31_15 = i_31_16 - i_31;
    wire signed [IN_WIDTH + 7 : 0] i_31_32 = i_31 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_31_31 = i_31_32 - i_31;
    wire signed [IN_WIDTH + 7 : 0] i_31_33 = i_31 + i_31_32;
    wire signed [IN_WIDTH + 7 : 0] i_31_11 = i_31_3 + i_31_8;
    wire signed [IN_WIDTH + 7 : 0] i_31_13 = i_31_16 - i_31_3;
    wire signed [IN_WIDTH + 7 : 0] i_31_37 = i_31_5 + i_31_32;
    wire signed [IN_WIDTH + 7 : 0] i_31_40 = i_31_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_31_41 = i_31 + i_31_40;
    wire signed [IN_WIDTH + 7 : 0] i_31_64 = i_31 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_31_59 = i_31_64 - i_31_5;
    wire signed [IN_WIDTH + 7 : 0] i_31_2  = i_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_31_20 = i_31_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_31_24 = i_31_3 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_31_28 = i_31_7 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_31_44 = i_31_11 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_31_48 = i_31_3 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_31_52 = i_31_13 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_31_56 = i_31_7 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_31_62 = i_31_31 <<< 1;

//sum
reg i_valid_d1, i_valid_d2;
reg signed  [IN_WIDTH +  7 : 0] sum0_0 [0 : 15], sum0_1 [0 : 15], sum0_2 [0 : 15], sum0_3 [0 : 15], 
                                sum0_4 [0 : 15], sum0_5 [0 : 15], sum0_6 [0 : 15], sum0_7 [0 : 15],
                                sum0_8 [0 : 15], sum0_9 [0 : 15], sum0_10[0 : 15], sum0_11[0 : 15],
                                sum0_12[0 : 15], sum0_13[0 : 15], sum0_14[0 : 15], sum0_15[0 : 15];
reg signed  [IN_WIDTH +  9 : 0] sum1_0 [0 : 15], sum1_1 [0 : 15], sum1_2 [0 : 15], sum1_3 [0 : 15]; 
//stage 1
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d1 <= 0;
        for (i = 0; i < 16; i = i + 1) begin
            sum0_0 [i] <= 0; sum0_1 [i] <= 0; sum0_2 [i] <= 0; sum0_3 [i] <= 0;
            sum0_4 [i] <= 0; sum0_5 [i] <= 0; sum0_6 [i] <= 0; sum0_7 [i] <= 0;
            sum0_8 [i] <= 0; sum0_9 [i] <= 0; sum0_10[i] <= 0; sum0_11[i] <= 0;
            sum0_12[i] <= 0; sum0_13[i] <= 0; sum0_14[i] <= 0; sum0_15[i] <= 0;            
        end
    end
    else begin
        i_valid_d1 <= i_valid;
        sum0_0[0 ] <= i_0_91 + i_1_90; sum0_1[0 ] <= i_2_90 + i_3_90; sum0_2[0 ] <= i_4_88 + i_5_87; sum0_3[0 ] <= i_6_86 + i_7_84; 
        sum0_0[1 ] <= i_0_90 + i_1_88; sum0_1[1 ] <= i_2_84 + i_3_79; sum0_2[1 ] <= i_4_71 + i_5_62; sum0_3[1 ] <= i_6_52 + i_7_41; 
        sum0_0[2 ] <= i_0_90 + i_1_84; sum0_1[2 ] <= i_2_73 + i_3_59; sum0_2[2 ] <= i_4_41 + i_5_20; sum0_3[2 ] <= i_6_2  + i_7_24; 
        sum0_0[3 ] <= i_0_90 + i_1_79; sum0_1[3 ] <= i_2_59 + i_3_33; sum0_2[3 ] <= i_4_2  - i_5_28; sum0_3[3 ] <= i_6_56 + i_7_77; 
        sum0_0[4 ] <= i_0_88 + i_1_71; sum0_1[4 ] <= i_2_41 + i_3_2 ; sum0_2[4 ] <= i_4_37 + i_5_69; sum0_3[4 ] <= i_6_87 + i_7_90; 
        sum0_0[5 ] <= i_0_87 + i_1_62; sum0_1[5 ] <= i_2_20 - i_3_28; sum0_2[5 ] <= i_4_69 + i_5_90; sum0_3[5 ] <= i_6_84 + i_7_56; 
        sum0_0[6 ] <= i_0_86 + i_1_52; sum0_1[6 ] <= i_2_2  + i_3_56; sum0_2[6 ] <= i_4_87 + i_5_84; sum0_3[6 ] <= i_6_48 - i_7_7 ; 
        sum0_0[7 ] <= i_0_84 + i_1_41; sum0_1[7 ] <= i_2_24 + i_3_77; sum0_2[7 ] <= i_4_90 + i_5_56; sum0_3[7 ] <= i_6_7  + i_7_65; 
        sum0_0[8 ] <= i_0_83 + i_1_28; sum0_1[8 ] <= i_2_44 + i_3_88; sum0_2[8 ] <= i_4_73 + i_5_11; sum0_3[8 ] <= i_6_59 + i_7_91; 
        sum0_0[9 ] <= i_0_81 + i_1_15; sum0_1[9 ] <= i_2_62 + i_3_90; sum0_2[9 ] <= i_4_44 - i_5_37; sum0_3[9 ] <= i_6_88 + i_7_69; 
        sum0_0[10] <= i_0_79 + i_1_2 ; sum0_1[10] <= i_2_77 + i_3_81; sum0_2[10] <= i_4_7  - i_5_73; sum0_3[10] <= i_6_83 + i_7_11; 
        sum0_0[11] <= i_0_77 - i_1_11; sum0_1[11] <= i_2_86 + i_3_62; sum0_2[11] <= i_4_33 + i_5_90; sum0_3[11] <= i_6_44 - i_7_52; 
        sum0_0[12] <= i_0_73 - i_1_24; sum0_1[12] <= i_2_90 + i_3_37; sum0_2[12] <= i_4_65 + i_5_81; sum0_3[12] <= i_6_11 + i_7_88; 
        sum0_0[13] <= i_0_71 - i_1_37; sum0_1[13] <= i_2_90 + i_3_7 ; sum0_2[13] <= i_4_86 + i_5_48; sum0_3[13] <= i_6_62 + i_7_79; 
        sum0_0[14] <= i_0_69 - i_1_48; sum0_1[14] <= i_2_83 - i_3_24; sum0_2[14] <= i_4_90 + i_5_2 ; sum0_3[14] <= i_6_90 + i_7_28; 
        sum0_0[15] <= i_0_65 - i_1_59; sum0_1[15] <= i_2_71 - i_3_52; sum0_2[15] <= i_4_77 - i_5_44; sum0_3[15] <= i_6_81 - i_7_37; 

        sum0_4[0 ] <= i_8_83 + i_9_81; sum0_5[0 ] <= i_10_79 + i_11_77; sum0_6[0 ] <= i_12_73 + i_13_71; sum0_7[0 ] <= i_14_69 + i_15_65; 
        sum0_4[1 ] <= i_8_28 + i_9_15; sum0_5[1 ] <= i_10_2 - i_11_11 ; sum0_6[1 ] <= i_12_24 + i_13_37; sum0_7[1 ] <= i_14_48 + i_15_59; 
        sum0_4[2 ] <= i_8_44 + i_9_62; sum0_5[2 ] <= i_10_77 + i_11_86; sum0_6[2 ] <= i_12_90 + i_13_90; sum0_7[2 ] <= i_14_83 + i_15_71; 
        sum0_4[3 ] <= i_8_88 + i_9_90; sum0_5[3 ] <= i_10_81 + i_11_62; sum0_6[3 ] <= i_12_37 + i_13_7 ; sum0_7[3 ] <= i_14_24 + i_15_52; 
        sum0_4[4 ] <= i_8_73 + i_9_44; sum0_5[4 ] <= i_10_7 - i_11_33 ; sum0_6[4 ] <= i_12_65 + i_13_86; sum0_7[4 ] <= i_14_90 + i_15_77; 
        sum0_4[5 ] <= i_8_11 - i_9_37; sum0_5[5 ] <= i_10_73 + i_11_90; sum0_6[5 ] <= i_12_81 + i_13_48; sum0_7[5 ] <= i_14_2  - i_15_44; 
        sum0_4[6 ] <= i_8_59 + i_9_88; sum0_5[6 ] <= i_10_83 + i_11_44; sum0_6[6 ] <= i_12_11 + i_13_62; sum0_7[6 ] <= i_14_90 + i_15_81; 
        sum0_4[7 ] <= i_8_91 + i_9_69; sum0_5[7 ] <= i_10_11 - i_11_52; sum0_6[7 ] <= i_12_88 + i_13_79; sum0_7[7 ] <= i_14_28 - i_15_37; 
        sum0_4[8 ] <= i_8_62 - i_9_7 ; sum0_5[8 ] <= i_10_71 + i_11_90; sum0_6[8 ] <= i_12_48 - i_13_24; sum0_7[8 ] <= i_14_81 + i_15_84; 
        sum0_4[9 ] <= i_8_7 + i_9_77 ; sum0_5[9 ] <= i_10_84 + i_11_24; sum0_6[9 ] <= i_12_56 + i_13_91; sum0_7[9 ] <= i_14_52 - i_15_28; 
        sum0_4[10] <= i_8_71 + i_9_84; sum0_5[10] <= i_10_15 - i_11_69; sum0_6[10] <= i_12_86 + i_13_20; sum0_7[10] <= i_14_65 + i_15_87; 
        sum0_4[11] <= i_8_90 + i_9_24; sum0_5[11] <= i_10_69 + i_11_83; sum0_6[11] <= i_12_2  - i_13_81; sum0_7[11] <= i_14_71 - i_15_20; 
        sum0_4[12] <= i_8_48 - i_9_56; sum0_5[12] <= i_10_86 + i_11_2 ; sum0_6[12] <= i_12_84 + i_13_59; sum0_7[12] <= i_14_44 + i_15_90; 
        sum0_4[13] <= i_8_24 + i_9_91; sum0_5[13] <= i_10_20 - i_11_81; sum0_6[13] <= i_12_59 - i_13_52; sum0_7[13] <= i_14_84 - i_15_11; 
        sum0_4[14] <= i_8_81 + i_9_52; sum0_5[14] <= i_10_65 + i_11_71; sum0_6[14] <= i_12_44 + i_13_84; sum0_7[14] <= i_14_20 + i_15_90; 
        sum0_4[15] <= i_8_84 - i_9_28; sum0_5[15] <= i_10_87 - i_11_20; sum0_6[15] <= i_12_90 - i_13_11; sum0_7[15] <= i_14_90 - i_15_2 ; 

        sum0_8[0 ] <= i_16_62 + i_17_59; sum0_9[0 ] <= i_18_56 + i_19_52; sum0_10[0 ] <= i_20_48 + i_21_44; sum0_11[0 ] <= i_22_41 + i_23_37; 
        sum0_8[1 ] <= i_16_69 + i_17_77; sum0_9[1 ] <= i_18_83 + i_19_87; sum0_10[1 ] <= i_20_90 + i_21_91; sum0_11[1 ] <= i_22_90 + i_23_86; 
        sum0_8[2 ] <= i_16_56 + i_17_37; sum0_9[2 ] <= i_18_15 - i_19_7 ; sum0_10[2 ] <= i_20_28 + i_21_48; sum0_11[2 ] <= i_22_65 + i_23_79; 
        sum0_8[3 ] <= i_16_73 + i_17_87; sum0_9[3 ] <= i_18_90 + i_19_83; sum0_10[3 ] <= i_20_65 + i_21_41; sum0_11[3 ] <= i_22_11 - i_23_20; 
        sum0_8[4 ] <= i_16_48 + i_17_11; sum0_9[4 ] <= i_18_28 + i_19_62; sum0_10[4 ] <= i_20_84 + i_21_90; sum0_11[4 ] <= i_22_79 + i_23_52; 
        sum0_8[5 ] <= i_16_79 + i_17_91; sum0_9[5 ] <= i_18_77 + i_19_41; sum0_10[5 ] <= i_20_7 + i_21_52 ; sum0_11[5 ] <= i_22_83 + i_23_90; 
        sum0_8[6 ] <= i_16_41 - i_17_15; sum0_9[6 ] <= i_18_65 + i_19_90; sum0_10[6 ] <= i_20_79 + i_21_37; sum0_11[6 ] <= i_22_20 + i_23_69; 
        sum0_8[7 ] <= i_16_83 + i_17_86; sum0_9[7 ] <= i_18_44 - i_19_20; sum0_10[7 ] <= i_20_73 + i_21_90; sum0_11[7 ] <= i_22_59 - i_23_2 ; 
        sum0_8[8 ] <= i_16_33 - i_17_41; sum0_9[8 ] <= i_18_87 + i_19_77; sum0_10[8 ] <= i_20_15 - i_21_56; sum0_11[8 ] <= i_22_90 + i_23_65; 
        sum0_8[9 ] <= i_16_86 + i_17_73; sum0_9[9 ] <= i_18_2 - i_19_71 ; sum0_10[9 ] <= i_20_87 + i_21_33; sum0_11[9 ] <= i_22_48 + i_23_90; 
        sum0_8[10] <= i_16_24 - i_17_62; sum0_9[10] <= i_18_88 + i_19_28; sum0_10[10] <= i_20_59 + i_21_90; sum0_11[10] <= i_22_33 - i_23_56; 
        sum0_8[11] <= i_16_88 + i_17_56; sum0_9[11] <= i_18_41 + i_19_91; sum0_10[11] <= i_20_37 - i_21_59; sum0_11[11] <= i_22_87 + i_23_15; 
        sum0_8[12] <= i_16_15 - i_17_79; sum0_9[12] <= i_18_69 - i_19_33; sum0_10[12] <= i_20_91 + i_21_28; sum0_11[12] <= i_22_71 + i_23_77; 
        sum0_8[13] <= i_16_90 + i_17_33; sum0_9[13] <= i_18_73 + i_19_69; sum0_10[13] <= i_20_41 + i_21_88; sum0_11[13] <= i_22_2 - i_23_87 ; 
        sum0_8[14] <= i_16_7 - i_17_88 ; sum0_9[14] <= i_18_33 - i_19_79; sum0_10[14] <= i_20_56 - i_21_62; sum0_11[14] <= i_22_73 - i_23_41; 
        sum0_8[15] <= i_16_91 + i_17_7 ; sum0_9[15] <= i_18_90 + i_19_15; sum0_10[15] <= i_20_88 + i_21_24; sum0_11[15] <= i_22_86 + i_23_33; 

        sum0_12[0 ] <= i_24_33 + i_25_28; sum0_13[0 ] <= i_26_24 + i_27_20; sum0_14[0 ] <= i_28_15 + i_29_11; sum0_15[0 ] <= i_30_7  + i_31_2 ;
        sum0_12[1 ] <= i_24_81 + i_25_73; sum0_13[1 ] <= i_26_65 + i_27_56; sum0_14[1 ] <= i_28_44 + i_29_33; sum0_15[1 ] <= i_30_20 + i_31_7 ;
        sum0_12[2 ] <= i_24_87 + i_25_91; sum0_13[2 ] <= i_26_88 + i_27_81; sum0_14[2 ] <= i_28_69 + i_29_52; sum0_15[2 ] <= i_30_33 + i_31_11;
        sum0_12[3 ] <= i_24_48 + i_25_71; sum0_13[3 ] <= i_26_86 + i_27_91; sum0_14[3 ] <= i_28_84 + i_29_69; sum0_15[3 ] <= i_30_44 + i_31_15;
        sum0_12[4 ] <= i_24_15 - i_25_24; sum0_13[4 ] <= i_26_59 + i_27_83; sum0_14[4 ] <= i_28_91 + i_29_81; sum0_15[4 ] <= i_30_56 + i_31_20;
        sum0_12[5 ] <= i_24_71 + i_25_33; sum0_13[5 ] <= i_26_15 + i_27_59; sum0_14[5 ] <= i_28_86 + i_29_88; sum0_15[5 ] <= i_30_65 + i_31_24;
        sum0_12[6 ] <= i_24_90 + i_25_77; sum0_13[6 ] <= i_26_33 - i_27_24; sum0_14[6 ] <= i_28_71 + i_29_91; sum0_15[6 ] <= i_30_73 + i_31_28;
        sum0_12[7 ] <= i_24_62 + i_25_90; sum0_13[7 ] <= i_26_71 + i_27_15; sum0_14[7 ] <= i_28_48 + i_29_87; sum0_15[7 ] <= i_30_81 + i_31_33;
        sum0_12[8 ] <= i_24_2 + i_25_69 ; sum0_13[8 ] <= i_26_90 + i_27_52; sum0_14[8 ] <= i_28_20 + i_29_79; sum0_15[8 ] <= i_30_86 + i_31_37;
        sum0_12[9 ] <= i_24_59 - i_25_20; sum0_13[9 ] <= i_26_83 + i_27_79; sum0_14[9 ] <= i_28_11 - i_29_65; sum0_15[9 ] <= i_30_90 + i_31_41;
        sum0_12[10] <= i_24_90 + i_25_37; sum0_13[10] <= i_26_52 + i_27_90; sum0_14[10] <= i_28_41 - i_29_48; sum0_15[10] <= i_30_91 + i_31_44;
        sum0_12[11] <= i_24_73 + i_25_79; sum0_13[11] <= i_26_7 + i_27_84 ; sum0_14[11] <= i_28_65 - i_29_28; sum0_15[11] <= i_30_90 + i_31_48;
        sum0_12[12] <= i_24_20 + i_25_90; sum0_13[12] <= i_26_41 - i_27_62; sum0_14[12] <= i_28_83 - i_29_7 ; sum0_15[12] <= i_30_87 + i_31_52;
        sum0_12[13] <= i_24_44 - i_25_65; sum0_13[13] <= i_26_77 - i_27_28; sum0_14[13] <= i_28_90 + i_29_15; sum0_15[13] <= i_30_83 + i_31_56;
        sum0_12[14] <= i_24_86 - i_25_15; sum0_13[14] <= i_26_91 + i_27_11; sum0_14[14] <= i_28_87 + i_29_37; sum0_15[14] <= i_30_77 + i_31_59;
        sum0_12[15] <= i_24_83 + i_25_41; sum0_13[15] <= i_26_79 + i_27_48; sum0_14[15] <= i_28_73 + i_29_56; sum0_15[15] <= i_30_69 + i_31_62;
    end
end
//stage 2
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d2 <= 0;
        for (i = 0; i < 16; i = i + 1) begin
            sum1_0[i] <= 0; sum1_1[i] <= 0; sum1_2[i] <= 0; sum1_3[i] <= 0;         
        end
    end
    else begin
        i_valid_d2 <= i_valid_d1;
        sum1_0[0 ] <= (sum0_0[0 ] + sum0_1[0 ]) + (+ sum0_2[0 ] + sum0_3[0 ]); sum1_1[0 ] <= (sum0_4[0 ] + sum0_5[0 ]) + (+ sum0_6[0 ] + sum0_7[0 ]); 
        sum1_0[1 ] <= (sum0_0[1 ] + sum0_1[1 ]) + (+ sum0_2[1 ] + sum0_3[1 ]); sum1_1[1 ] <= (sum0_4[1 ] + sum0_5[1 ]) + (- sum0_6[1 ] - sum0_7[1 ]); 
        sum1_0[2 ] <= (sum0_0[2 ] + sum0_1[2 ]) + (+ sum0_2[2 ] - sum0_3[2 ]); sum1_1[2 ] <= (sum0_4[2 ] + sum0_5[2 ]) + (+ sum0_6[2 ] + sum0_7[2 ]); 
        sum1_0[3 ] <= (sum0_0[3 ] + sum0_1[3 ]) + (+ sum0_2[3 ] - sum0_3[3 ]); sum1_1[3 ] <= (sum0_4[3 ] + sum0_5[3 ]) + (+ sum0_6[3 ] - sum0_7[3 ]); 
        sum1_0[4 ] <= (sum0_0[4 ] + sum0_1[4 ]) + (- sum0_2[4 ] - sum0_3[4 ]); sum1_1[4 ] <= (sum0_4[4 ] + sum0_5[4 ]) + (- sum0_6[4 ] - sum0_7[4 ]); 
        sum1_0[5 ] <= (sum0_0[5 ] + sum0_1[5 ]) + (- sum0_2[5 ] - sum0_3[5 ]); sum1_1[5 ] <= (sum0_4[5 ] - sum0_5[5 ]) + (- sum0_6[5 ] - sum0_7[5 ]); 
        sum1_0[6 ] <= (sum0_0[6 ] - sum0_1[6 ]) + (- sum0_2[6 ] - sum0_3[6 ]); sum1_1[6 ] <= (sum0_4[6 ] + sum0_5[6 ]) + (- sum0_6[6 ] - sum0_7[6 ]); 
        sum1_0[7 ] <= (sum0_0[7 ] - sum0_1[7 ]) + (- sum0_2[7 ] + sum0_3[7 ]); sum1_1[7 ] <= (sum0_4[7 ] + sum0_5[7 ]) + (- sum0_6[7 ] - sum0_7[7 ]); 
        sum1_0[8 ] <= (sum0_0[8 ] - sum0_1[8 ]) + (- sum0_2[8 ] + sum0_3[8 ]); sum1_1[8 ] <= (sum0_4[8 ] - sum0_5[8 ]) + (- sum0_6[8 ] + sum0_7[8 ]); 
        sum1_0[9 ] <= (sum0_0[9 ] - sum0_1[9 ]) + (- sum0_2[9 ] + sum0_3[9 ]); sum1_1[9 ] <= (sum0_4[9 ] + sum0_5[9 ]) + (- sum0_6[9 ] - sum0_7[9 ]); 
        sum1_0[10] <= (sum0_0[10] - sum0_1[10]) + (- sum0_2[10] + sum0_3[10]); sum1_1[10] <= (sum0_4[10] + sum0_5[10]) + (- sum0_6[10] + sum0_7[10]); 
        sum1_0[11] <= (sum0_0[11] - sum0_1[11]) + (+ sum0_2[11] + sum0_3[11]); sum1_1[11] <= (sum0_4[11] - sum0_5[11]) + (- sum0_6[11] + sum0_7[11]); 
        sum1_0[12] <= (sum0_0[12] - sum0_1[12]) + (+ sum0_2[12] - sum0_3[12]); sum1_1[12] <= (sum0_4[12] - sum0_5[12]) + (+ sum0_6[12] - sum0_7[12]); 
        sum1_0[13] <= (sum0_0[13] - sum0_1[13]) + (+ sum0_2[13] - sum0_3[13]); sum1_1[13] <= (sum0_4[13] + sum0_5[13]) + (- sum0_6[13] + sum0_7[13]); 
        sum1_0[14] <= (sum0_0[14] - sum0_1[14]) + (+ sum0_2[14] - sum0_3[14]); sum1_1[14] <= (sum0_4[14] - sum0_5[14]) + (+ sum0_6[14] - sum0_7[14]); 
        sum1_0[15] <= (sum0_0[15] - sum0_1[15]) + (+ sum0_2[15] - sum0_3[15]); sum1_1[15] <= (sum0_4[15] - sum0_5[15]) + (+ sum0_6[15] - sum0_7[15]); 

        sum1_2[0 ] <= (sum0_8[0 ] + sum0_9[0 ]) + (+ sum0_10[0 ] + sum0_11[0 ]); sum1_3[0 ] <= (sum0_12[0 ] + sum0_13[0 ]) + (+ sum0_14[0 ] + sum0_15[0 ]);
        sum1_2[1 ] <= (sum0_8[1 ] + sum0_9[1 ]) + (+ sum0_10[1 ] + sum0_11[1 ]); sum1_3[1 ] <= (sum0_12[1 ] + sum0_13[1 ]) + (+ sum0_14[1 ] + sum0_15[1 ]);
        sum1_2[2 ] <= (sum0_8[2 ] + sum0_9[2 ]) + (- sum0_10[2 ] - sum0_11[2 ]); sum1_3[2 ] <= (sum0_12[2 ] + sum0_13[2 ]) + (+ sum0_14[2 ] + sum0_15[2 ]);
        sum1_2[3 ] <= (sum0_8[3 ] + sum0_9[3 ]) + (+ sum0_10[3 ] + sum0_11[3 ]); sum1_3[3 ] <= (sum0_12[3 ] + sum0_13[3 ]) + (+ sum0_14[3 ] + sum0_15[3 ]);
        sum1_2[4 ] <= (sum0_8[4 ] - sum0_9[4 ]) + (- sum0_10[4 ] - sum0_11[4 ]); sum1_3[4 ] <= (sum0_12[4 ] - sum0_13[4 ]) + (- sum0_14[4 ] - sum0_15[4 ]);
        sum1_2[5 ] <= (sum0_8[5 ] + sum0_9[5 ]) + (- sum0_10[5 ] - sum0_11[5 ]); sum1_3[5 ] <= (sum0_12[5 ] - sum0_13[5 ]) + (- sum0_14[5 ] - sum0_15[5 ]);
        sum1_2[6 ] <= (sum0_8[6 ] - sum0_9[6 ]) + (- sum0_10[6 ] + sum0_11[6 ]); sum1_3[6 ] <= (sum0_12[6 ] + sum0_13[6 ]) + (- sum0_14[6 ] - sum0_15[6 ]);
        sum1_2[7 ] <= (sum0_8[7 ] + sum0_9[7 ]) + (- sum0_10[7 ] - sum0_11[7 ]); sum1_3[7 ] <= (sum0_12[7 ] + sum0_13[7 ]) + (- sum0_14[7 ] - sum0_15[7 ]);
        sum1_2[8 ] <= (sum0_8[8 ] - sum0_9[8 ]) + (- sum0_10[8 ] + sum0_11[8 ]); sum1_3[8 ] <= (sum0_12[8 ] + sum0_13[8 ]) + (- sum0_14[8 ] - sum0_15[8 ]);
        sum1_2[9 ] <= (sum0_8[9 ] + sum0_9[9 ]) + (- sum0_10[9 ] + sum0_11[9 ]); sum1_3[9 ] <= (sum0_12[9 ] - sum0_13[9 ]) + (- sum0_14[9 ] + sum0_15[9 ]);
        sum1_2[10] <= (sum0_8[10] - sum0_9[10]) + (+ sum0_10[10] + sum0_11[10]); sum1_3[10] <= (sum0_12[10] - sum0_13[10]) + (- sum0_14[10] + sum0_15[10]);
        sum1_2[11] <= (sum0_8[11] - sum0_9[11]) + (- sum0_10[11] + sum0_11[11]); sum1_3[11] <= (sum0_12[11] - sum0_13[11]) + (- sum0_14[11] + sum0_15[11]);
        sum1_2[12] <= (sum0_8[12] - sum0_9[12]) + (+ sum0_10[12] - sum0_11[12]); sum1_3[12] <= (sum0_12[12] + sum0_13[12]) + (- sum0_14[12] + sum0_15[12]);
        sum1_2[13] <= (sum0_8[13] - sum0_9[13]) + (+ sum0_10[13] + sum0_11[13]); sum1_3[13] <= (sum0_12[13] - sum0_13[13]) + (+ sum0_14[13] - sum0_15[13]);
        sum1_2[14] <= (sum0_8[14] - sum0_9[14]) + (+ sum0_10[14] - sum0_11[14]); sum1_3[14] <= (sum0_12[14] - sum0_13[14]) + (+ sum0_14[14] - sum0_15[14]);
        sum1_2[15] <= (sum0_8[15] - sum0_9[15]) + (+ sum0_10[15] - sum0_11[15]); sum1_3[15] <= (sum0_12[15] - sum0_13[15]) + (+ sum0_14[15] - sum0_15[15]);
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
    else begin
        o_valid <= i_valid_d2;
        o_0     <= (sum1_0[0 ] + sum1_1[0 ]) + (+ sum1_2[0 ] + sum1_3[0 ]);
        o_1     <= (sum1_0[1 ] + sum1_1[1 ]) + (- sum1_2[1 ] - sum1_3[1 ]);
        o_2     <= (sum1_0[2 ] - sum1_1[2 ]) + (- sum1_2[2 ] + sum1_3[2 ]);
        o_3     <= (sum1_0[3 ] - sum1_1[3 ]) + (+ sum1_2[3 ] - sum1_3[3 ]);
        o_4     <= (sum1_0[4 ] - sum1_1[4 ]) + (+ sum1_2[4 ] - sum1_3[4 ]);
        o_5     <= (sum1_0[5 ] - sum1_1[5 ]) + (- sum1_2[5 ] + sum1_3[5 ]);
        o_6     <= (sum1_0[6 ] + sum1_1[6 ]) + (- sum1_2[6 ] - sum1_3[6 ]);
        o_7     <= (sum1_0[7 ] + sum1_1[7 ]) + (+ sum1_2[7 ] + sum1_3[7 ]);
        o_8     <= (sum1_0[8 ] + sum1_1[8 ]) + (+ sum1_2[8 ] - sum1_3[8 ]);
        o_9     <= (sum1_0[9 ] - sum1_1[9 ]) + (- sum1_2[9 ] - sum1_3[9 ]);
        o_10    <= (sum1_0[10] - sum1_1[10]) + (- sum1_2[10] + sum1_3[10]);
        o_11    <= (sum1_0[11] - sum1_1[11]) + (+ sum1_2[11] - sum1_3[11]);
        o_12    <= (sum1_0[12] - sum1_1[12]) + (+ sum1_2[12] + sum1_3[12]);
        o_13    <= (sum1_0[13] + sum1_1[13]) + (- sum1_2[13] + sum1_3[13]);
        o_14    <= (sum1_0[14] + sum1_1[14]) + (- sum1_2[14] - sum1_3[14]);
        o_15    <= (sum1_0[15] + sum1_1[15]) + (+ sum1_2[15] + sum1_3[15]);
    end
end

endmodule
