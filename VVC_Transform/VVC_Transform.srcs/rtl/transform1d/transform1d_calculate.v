//describe  : 一维变换计算模块(MCM)
//input     : 64个像素/一维系数
//output    : 32个一维系数/二维系数
//delay     : 3 clk
module tranform1d_calculate#(
    parameter IN_WIDTH  = 17,
    parameter OUT_WIDTH = 28
)
(
//system input
    input                                   clk     ,
    input                                   rst_n   ,
//input parameter
    input               [1 : 0]             i_type  ,//0:DCT2 1:DCT8 2:DST7
    input               [2 : 0]             i_size  ,//1:4x4, 2:8x8, 3:16x16, 4:32x32
//input data                                         
    input                                   i_valid ,
    input       signed  [IN_WIDTH + 3 : 0]  i_0     ,//21bit DCT2-4
    input       signed  [IN_WIDTH + 3 : 0]  i_1     ,
    input       signed  [IN_WIDTH + 3 : 0]  i_2     ,
    input       signed  [IN_WIDTH + 3 : 0]  i_3     ,
    input       signed  [IN_WIDTH + 2 : 0]  i_4     ,//20bit DCT2-4/8
    input       signed  [IN_WIDTH + 2 : 0]  i_5     ,
    input       signed  [IN_WIDTH + 2 : 0]  i_6     ,
    input       signed  [IN_WIDTH + 2 : 0]  i_7     ,
    input       signed  [IN_WIDTH + 1 : 0]  i_8     ,//19bit DCT2-4/8/16
    input       signed  [IN_WIDTH + 1 : 0]  i_9     ,
    input       signed  [IN_WIDTH + 1 : 0]  i_10    ,
    input       signed  [IN_WIDTH + 1 : 0]  i_11    ,
    input       signed  [IN_WIDTH + 1 : 0]  i_12    ,
    input       signed  [IN_WIDTH + 1 : 0]  i_13    ,
    input       signed  [IN_WIDTH + 1 : 0]  i_14    ,
    input       signed  [IN_WIDTH + 1 : 0]  i_15    ,
    input       signed  [IN_WIDTH     : 0]  i_16    ,//18bit DCT2-4/8/16/32
    input       signed  [IN_WIDTH     : 0]  i_17    ,
    input       signed  [IN_WIDTH     : 0]  i_18    ,
    input       signed  [IN_WIDTH     : 0]  i_19    ,
    input       signed  [IN_WIDTH     : 0]  i_20    ,
    input       signed  [IN_WIDTH     : 0]  i_21    ,
    input       signed  [IN_WIDTH     : 0]  i_22    ,
    input       signed  [IN_WIDTH     : 0]  i_23    ,
    input       signed  [IN_WIDTH     : 0]  i_24    ,
    input       signed  [IN_WIDTH     : 0]  i_25    ,
    input       signed  [IN_WIDTH     : 0]  i_26    ,
    input       signed  [IN_WIDTH     : 0]  i_27    ,
    input       signed  [IN_WIDTH     : 0]  i_28    ,
    input       signed  [IN_WIDTH     : 0]  i_29    ,
    input       signed  [IN_WIDTH     : 0]  i_30    ,
    input       signed  [IN_WIDTH     : 0]  i_31    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_32    ,//17bit DCT2-64, DST7/DCT8
    input       signed  [IN_WIDTH - 1 : 0]  i_33    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_34    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_35    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_36    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_37    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_38    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_39    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_40    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_41    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_42    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_43    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_44    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_45    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_46    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_47    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_48    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_49    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_50    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_51    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_52    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_53    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_54    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_55    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_56    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_57    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_58    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_59    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_60    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_61    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_62    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_63    ,
//output parameter
    output reg          [1 : 0]             o_type  ,
    output reg          [2 : 0]             o_size  ,
//output pre_coeff
    output reg                              o_valid ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_0     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_1     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_2     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_3     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_4     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_5     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_6     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_7     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_8     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_9     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_10    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_11    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_12    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_13    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_14    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_15    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_16    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_17    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_18    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_19    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_20    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_21    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_22    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_23    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_24    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_25    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_26    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_27    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_28    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_29    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_30    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_31        
);

localparam  DCT2   = 2'd0,
            DCT8   = 2'd1,
            DST7   = 2'd2;
localparam  SIZE4  = 3'd1,
            SIZE8  = 3'd2,
            SIZE16 = 3'd3,
            SIZE32 = 3'd4,
            SIZE64 = 3'd5;
integer i;

//input
    reg [1 : 0] i_type_d1, i_type_d2, i_type_d3;
    reg [2 : 0] i_size_d1, i_size_d2, i_size_d3;
    reg i_valid_d1, i_valid_d2, i_valid_d3;
//mcm
//DCT2 SIZE4-32
//[i_0  21bit] <cost: [ 0] adds/subtracts [ 1] shifts, Depth: [0]> DCT2 SIZE4: 64  64
    wire signed [IN_WIDTH + 9 : 0] i_0_64 = i_0 <<< 6;
//[i_1  21bit] <cost: [ 0] adds/subtracts [ 1] shifts, Depth: [0]> DCT2 SIZE4: 64 -64
    wire signed [IN_WIDTH + 9 : 0] i_1_64 = i_1 <<< 6;
//[i_2  21bit] <cost: [ 3] adds/subtracts [ 4] shifts, Depth: [2]> DCT2 SIZE4: 83  36
    wire signed [IN_WIDTH + 10 : 0] i_2_8 = i_2 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] i_2_9 = i_2 + i_2_8;
    wire signed [IN_WIDTH + 10 : 0] i_2_64 = i_2 <<< 6;
    wire signed [IN_WIDTH + 10 : 0] i_2_65 = i_2 + i_2_64;
    wire signed [IN_WIDTH + 10 : 0] i_2_18 = i_2_9 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_2_83 = i_2_65 + i_2_18;
    wire signed [IN_WIDTH + 10 : 0] i_2_36 = i_2_9 <<< 2;
//[i_3  21bit] <cost: [ 3] adds/subtracts [ 4] shifts, Depth: [2]> DCT2 SIZE4: 36 -83
    wire signed [IN_WIDTH + 10 : 0] i_3_8 = i_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] i_3_9 = i_3 + i_3_8;
    wire signed [IN_WIDTH + 10 : 0] i_3_64 = i_3 <<< 6;
    wire signed [IN_WIDTH + 10 : 0] i_3_65 = i_3 + i_3_64;
    wire signed [IN_WIDTH + 10 : 0] i_3_18 = i_3_9 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_3_83 = i_3_65 + i_3_18;
    wire signed [IN_WIDTH + 10 : 0] i_3_36 = i_3_9 <<< 2;
//[i_4  20bit] <cost: [ 4] adds/subtracts [ 7] shifts, Depth: [3]> DCT2 SIZE8: 89  75  50  18; SIZE4: 64  64
    wire signed [IN_WIDTH + 9 : 0] i_4_8 = i_4 <<< 3;
    wire signed [IN_WIDTH + 9 : 0] i_4_9 = i_4 + i_4_8;
    wire signed [IN_WIDTH + 9 : 0] i_4_16 = i_4 <<< 4;
    wire signed [IN_WIDTH + 9 : 0] i_4_25 = i_4_9 + i_4_16;
    wire signed [IN_WIDTH + 9 : 0] i_4_100 = i_4_25 <<< 2;
    wire signed [IN_WIDTH + 9 : 0] i_4_75 = i_4_100 - i_4_25;
    wire signed [IN_WIDTH + 9 : 0] i_4_64 = i_4 <<< 6;
    wire signed [IN_WIDTH + 9 : 0] i_4_89 = i_4_25 + i_4_64;
    wire signed [IN_WIDTH + 9 : 0] i_4_50 = i_4_25 <<< 1;
    wire signed [IN_WIDTH + 9 : 0] i_4_18 = i_4_9 <<< 1;
//[i_5  20bit] <cost: [ 4] adds/subtracts [ 7] shifts, Depth: [3]> DCT2 SIZE8: 75 -18 -89 -50; SIZE4: 64 -64
    wire signed [IN_WIDTH + 9 : 0] i_5_8 = i_5 <<< 3;
    wire signed [IN_WIDTH + 9 : 0] i_5_9 = i_5 + i_5_8;
    wire signed [IN_WIDTH + 9 : 0] i_5_16 = i_5 <<< 4;
    wire signed [IN_WIDTH + 9 : 0] i_5_25 = i_5_9 + i_5_16;
    wire signed [IN_WIDTH + 9 : 0] i_5_100 = i_5_25 <<< 2;
    wire signed [IN_WIDTH + 9 : 0] i_5_75 = i_5_100 - i_5_25;
    wire signed [IN_WIDTH + 9 : 0] i_5_64 = i_5 <<< 6;
    wire signed [IN_WIDTH + 9 : 0] i_5_89 = i_5_25 + i_5_64;
    wire signed [IN_WIDTH + 9 : 0] i_5_50 = i_5_25 <<< 1;
    wire signed [IN_WIDTH + 9 : 0] i_5_18 = i_5_9 <<< 1;
//[i_6  20bit] <cost: [ 5] adds/subtracts [ 8] shifts, Depth: [4]> DCT2 SIZE8: 50 -89  18  75; SIZE4: 83  36
    wire signed [IN_WIDTH + 9 : 0] i_6_8 = i_6 <<< 3;
    wire signed [IN_WIDTH + 9 : 0] i_6_9 = i_6 + i_6_8;
    wire signed [IN_WIDTH + 9 : 0] i_6_16 = i_6 <<< 4;
    wire signed [IN_WIDTH + 9 : 0] i_6_25 = i_6_9 + i_6_16;
    wire signed [IN_WIDTH + 9 : 0] i_6_100 = i_6_25 <<< 2;
    wire signed [IN_WIDTH + 9 : 0] i_6_75 = i_6_100 - i_6_25;
    wire signed [IN_WIDTH + 9 : 0] i_6_64 = i_6 <<< 6;
    wire signed [IN_WIDTH + 9 : 0] i_6_89 = i_6_25 + i_6_64;
    wire signed [IN_WIDTH + 9 : 0] i_6_83 = i_6_75 + i_6_8;
    wire signed [IN_WIDTH + 9 : 0] i_6_50 = i_6_25 <<< 1;
    wire signed [IN_WIDTH + 9 : 0] i_6_18 = i_6_9 <<< 1;
    wire signed [IN_WIDTH + 9 : 0] i_6_36 = i_6_9 <<< 2;
//[i_7  20bit] <cost: [ 5] adds/subtracts [ 8] shifts, Depth: [4]> DCT2 SIZE8: 18 -50  75 -89; SIZE4: 36 -83
    wire signed [IN_WIDTH + 9 : 0] i_7_8 = i_7 <<< 3;
    wire signed [IN_WIDTH + 9 : 0] i_7_9 = i_7 + i_7_8;
    wire signed [IN_WIDTH + 9 : 0] i_7_16 = i_7 <<< 4;
    wire signed [IN_WIDTH + 9 : 0] i_7_25 = i_7_9 + i_7_16;
    wire signed [IN_WIDTH + 9 : 0] i_7_100 = i_7_25 <<< 2;
    wire signed [IN_WIDTH + 9 : 0] i_7_75 = i_7_100 - i_7_25;
    wire signed [IN_WIDTH + 9 : 0] i_7_64 = i_7 <<< 6;
    wire signed [IN_WIDTH + 9 : 0] i_7_89 = i_7_25 + i_7_64;
    wire signed [IN_WIDTH + 9 : 0] i_7_83 = i_7_75 + i_7_8;
    wire signed [IN_WIDTH + 9 : 0] i_7_50 = i_7_25 <<< 1;
    wire signed [IN_WIDTH + 9 : 0] i_7_18 = i_7_9 <<< 1;
    wire signed [IN_WIDTH + 9 : 0] i_7_36 = i_7_9 <<< 2;
//[i_8  19bit] <cost: [ 8] adds/subtracts [12] shifts, Depth: [4]> DCT2 SIZE16: 90  87  80  70  57  43  25   9; SIZE4: 64  64
    wire signed [IN_WIDTH + 8 : 0] i_8_4 = i_8 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_8_5 = i_8 + i_8_4;
    wire signed [IN_WIDTH + 8 : 0] i_8_8 = i_8 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_8_9 = i_8 + i_8_8;
    wire signed [IN_WIDTH + 8 : 0] i_8_16 = i_8 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_8_25 = i_8_9 + i_8_16;
    wire signed [IN_WIDTH + 8 : 0] i_8_36 = i_8_9 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_8_35 = i_8_36 - i_8;
    wire signed [IN_WIDTH + 8 : 0] i_8_40 = i_8_5 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_8_45 = i_8_5 + i_8_40;
    wire signed [IN_WIDTH + 8 : 0] i_8_43 = i_8_35 + i_8_8;
    wire signed [IN_WIDTH + 8 : 0] i_8_32 = i_8 <<< 5;
    wire signed [IN_WIDTH + 8 : 0] i_8_57 = i_8_25 + i_8_32;
    wire signed [IN_WIDTH + 8 : 0] i_8_86 = i_8_43 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_8_87 = i_8 + i_8_86;
    wire signed [IN_WIDTH + 8 : 0] i_8_90 = i_8_45 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_8_80 = i_8_5 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_8_70 = i_8_35 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_8_64 = i_8 <<< 6;
//[i_9  19bit] <cost: [ 8] adds/subtracts [12] shifts, Depth: [4]> DCT2 SIZE16: 87  57   9 -43 -80 -90 -70 -25; SIZE4: 64 -64
    wire signed [IN_WIDTH + 8 : 0] i_9_4 = i_9 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_9_5 = i_9 + i_9_4;
    wire signed [IN_WIDTH + 8 : 0] i_9_8 = i_9 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_9_9 = i_9 + i_9_8;
    wire signed [IN_WIDTH + 8 : 0] i_9_16 = i_9 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_9_25 = i_9_9 + i_9_16;
    wire signed [IN_WIDTH + 8 : 0] i_9_36 = i_9_9 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_9_35 = i_9_36 - i_9;
    wire signed [IN_WIDTH + 8 : 0] i_9_40 = i_9_5 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_9_45 = i_9_5 + i_9_40;
    wire signed [IN_WIDTH + 8 : 0] i_9_43 = i_9_35 + i_9_8;
    wire signed [IN_WIDTH + 8 : 0] i_9_32 = i_9 <<< 5;
    wire signed [IN_WIDTH + 8 : 0] i_9_57 = i_9_25 + i_9_32;
    wire signed [IN_WIDTH + 8 : 0] i_9_86 = i_9_43 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_9_87 = i_9 + i_9_86;
    wire signed [IN_WIDTH + 8 : 0] i_9_90 = i_9_45 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_9_80 = i_9_5 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_9_70 = i_9_35 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_9_64 = i_9 <<< 6;
//[i_10 19bit] <cost: [ 9] adds/subtracts [13] shifts, Depth: [4]> DCT2 SIZE16: 80   9 -70 -87 -25  57  90  43; SIZE4: 83  36
    wire signed [IN_WIDTH + 8 : 0] i_10_4 = i_10 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_10_5 = i_10 + i_10_4;
    wire signed [IN_WIDTH + 8 : 0] i_10_8 = i_10 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_10_9 = i_10 + i_10_8;
    wire signed [IN_WIDTH + 8 : 0] i_10_16 = i_10 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_10_25 = i_10_9 + i_10_16;
    wire signed [IN_WIDTH + 8 : 0] i_10_36 = i_10_9 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_10_35 = i_10_36 - i_10;
    wire signed [IN_WIDTH + 8 : 0] i_10_40 = i_10_5 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_10_45 = i_10_5 + i_10_40;
    wire signed [IN_WIDTH + 8 : 0] i_10_43 = i_10_35 + i_10_8;
    wire signed [IN_WIDTH + 8 : 0] i_10_32 = i_10 <<< 5;
    wire signed [IN_WIDTH + 8 : 0] i_10_57 = i_10_25 + i_10_32;
    wire signed [IN_WIDTH + 8 : 0] i_10_128 = i_10 <<< 7;
    wire signed [IN_WIDTH + 8 : 0] i_10_83 = i_10_128 - i_10_45;
    wire signed [IN_WIDTH + 8 : 0] i_10_86 = i_10_43 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_10_87 = i_10 + i_10_86;
    wire signed [IN_WIDTH + 8 : 0] i_10_90 = i_10_45 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_10_80 = i_10_5 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_10_70 = i_10_35 <<< 1;
//[i_11 19bit] <cost: [ 9] adds/subtracts [13] shifts, Depth: [4]> DCT2 SIZE16: 70 -43 -87   9  90  25 -80 -57; SIZE4: 36 -83
    wire signed [IN_WIDTH + 8 : 0] i_11_4 = i_11 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_11_5 = i_11 + i_11_4;
    wire signed [IN_WIDTH + 8 : 0] i_11_8 = i_11 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_11_9 = i_11 + i_11_8;
    wire signed [IN_WIDTH + 8 : 0] i_11_16 = i_11 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_11_25 = i_11_9 + i_11_16;
    wire signed [IN_WIDTH + 8 : 0] i_11_36 = i_11_9 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_11_35 = i_11_36 - i_11;
    wire signed [IN_WIDTH + 8 : 0] i_11_40 = i_11_5 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_11_45 = i_11_5 + i_11_40;
    wire signed [IN_WIDTH + 8 : 0] i_11_43 = i_11_35 + i_11_8;
    wire signed [IN_WIDTH + 8 : 0] i_11_32 = i_11 <<< 5;
    wire signed [IN_WIDTH + 8 : 0] i_11_57 = i_11_25 + i_11_32;
    wire signed [IN_WIDTH + 8 : 0] i_11_128 = i_11 <<< 7;
    wire signed [IN_WIDTH + 8 : 0] i_11_83 = i_11_128 - i_11_45;
    wire signed [IN_WIDTH + 8 : 0] i_11_86 = i_11_43 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_11_87 = i_11 + i_11_86;
    wire signed [IN_WIDTH + 8 : 0] i_11_90 = i_11_45 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_11_80 = i_11_5 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_11_70 = i_11_35 <<< 1;
//[i_12 19bit] <cost: [10] adds/subtracts [16] shifts, Depth: [3]> DCT2 SIZE16: 57 -80 -25  90  -9 -87  43  70; SIZE8: 89  75  50  18; SIZE4: 64  64
    wire signed [IN_WIDTH + 8 : 0] i_12_4 = i_12 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_12_5 = i_12 + i_12_4;
    wire signed [IN_WIDTH + 8 : 0] i_12_8 = i_12 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_12_9 = i_12 + i_12_8;
    wire signed [IN_WIDTH + 8 : 0] i_12_16 = i_12 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_12_25 = i_12_9 + i_12_16;
    wire signed [IN_WIDTH + 8 : 0] i_12_36 = i_12_9 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_12_35 = i_12_36 - i_12;
    wire signed [IN_WIDTH + 8 : 0] i_12_40 = i_12_5 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_12_45 = i_12_5 + i_12_40;
    wire signed [IN_WIDTH + 8 : 0] i_12_80 = i_12_5 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_12_75 = i_12_80 - i_12_5;
    wire signed [IN_WIDTH + 8 : 0] i_12_89 = i_12_9 + i_12_80;
    wire signed [IN_WIDTH + 8 : 0] i_12_43 = i_12_35 + i_12_8;
    wire signed [IN_WIDTH + 8 : 0] i_12_32 = i_12 <<< 5;
    wire signed [IN_WIDTH + 8 : 0] i_12_57 = i_12_25 + i_12_32;
    wire signed [IN_WIDTH + 8 : 0] i_12_2 = i_12 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_12_87 = i_12_89 - i_12_2;
    wire signed [IN_WIDTH + 8 : 0] i_12_90 = i_12_45 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_12_70 = i_12_35 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_12_50 = i_12_25 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_12_18 = i_12_9 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_12_64 = i_12 <<< 6;
//[i_13 19bit] <cost: [10] adds/subtracts [16] shifts, Depth: [3]> DCT2 SIZE16: 43 -90  57  25 -87  70   9 -80; SIZE8: 75 -18 -89 -50; SIZE4: 64 -64
    wire signed [IN_WIDTH + 8 : 0] i_13_4 = i_13 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_13_5 = i_13 + i_13_4;
    wire signed [IN_WIDTH + 8 : 0] i_13_8 = i_13 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_13_9 = i_13 + i_13_8;
    wire signed [IN_WIDTH + 8 : 0] i_13_16 = i_13 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_13_25 = i_13_9 + i_13_16;
    wire signed [IN_WIDTH + 8 : 0] i_13_36 = i_13_9 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_13_35 = i_13_36 - i_13;
    wire signed [IN_WIDTH + 8 : 0] i_13_40 = i_13_5 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_13_45 = i_13_5 + i_13_40;
    wire signed [IN_WIDTH + 8 : 0] i_13_80 = i_13_5 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_13_75 = i_13_80 - i_13_5;
    wire signed [IN_WIDTH + 8 : 0] i_13_89 = i_13_9 + i_13_80;
    wire signed [IN_WIDTH + 8 : 0] i_13_43 = i_13_35 + i_13_8;
    wire signed [IN_WIDTH + 8 : 0] i_13_32 = i_13 <<< 5;
    wire signed [IN_WIDTH + 8 : 0] i_13_57 = i_13_25 + i_13_32;
    wire signed [IN_WIDTH + 8 : 0] i_13_2 = i_13 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_13_87 = i_13_89 - i_13_2;
    wire signed [IN_WIDTH + 8 : 0] i_13_90 = i_13_45 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_13_70 = i_13_35 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_13_50 = i_13_25 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_13_18 = i_13_9 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_13_64 = i_13 <<< 6;
//[i_14 19bit] <cost: [11] adds/subtracts [17] shifts, Depth: [3]> DCT2 SIZE16: 25 -70  90 -80  43   9 -57  87; SIZE8: 50 -89  18  75; SIZE4: 83  36
    wire signed [IN_WIDTH + 8 : 0] i_14_4 = i_14 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_14_5 = i_14 + i_14_4;
    wire signed [IN_WIDTH + 8 : 0] i_14_8 = i_14 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_14_9 = i_14 + i_14_8;
    wire signed [IN_WIDTH + 8 : 0] i_14_16 = i_14 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_14_25 = i_14_9 + i_14_16;
    wire signed [IN_WIDTH + 8 : 0] i_14_36 = i_14_9 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_14_35 = i_14_36 - i_14;
    wire signed [IN_WIDTH + 8 : 0] i_14_40 = i_14_5 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_14_45 = i_14_5 + i_14_40;
    wire signed [IN_WIDTH + 8 : 0] i_14_80 = i_14_5 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_14_75 = i_14_80 - i_14_5;
    wire signed [IN_WIDTH + 8 : 0] i_14_89 = i_14_9 + i_14_80;
    wire signed [IN_WIDTH + 8 : 0] i_14_43 = i_14_35 + i_14_8;
    wire signed [IN_WIDTH + 8 : 0] i_14_32 = i_14 <<< 5;
    wire signed [IN_WIDTH + 8 : 0] i_14_57 = i_14_25 + i_14_32;
    wire signed [IN_WIDTH + 8 : 0] i_14_128 = i_14 <<< 7;
    wire signed [IN_WIDTH + 8 : 0] i_14_83 = i_14_128 - i_14_45;
    wire signed [IN_WIDTH + 8 : 0] i_14_2 = i_14 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_14_87 = i_14_89 - i_14_2;
    wire signed [IN_WIDTH + 8 : 0] i_14_90 = i_14_45 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_14_70 = i_14_35 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_14_50 = i_14_25 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_14_18 = i_14_9 <<< 1;
//[i_15 19bit] <cost: [11] adds/subtracts [17] shifts, Depth: [3]> DCT2 SIZE16:  9 -25  43 -57  70 -80  87 -90; SIZE8: 18 -50  75 -89; SIZE4: 36 -83
    wire signed [IN_WIDTH + 8 : 0] i_15_4 = i_15 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_15_5 = i_15 + i_15_4;
    wire signed [IN_WIDTH + 8 : 0] i_15_8 = i_15 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_15_9 = i_15 + i_15_8;
    wire signed [IN_WIDTH + 8 : 0] i_15_16 = i_15 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_15_25 = i_15_9 + i_15_16;
    wire signed [IN_WIDTH + 8 : 0] i_15_36 = i_15_9 <<< 2;
    wire signed [IN_WIDTH + 8 : 0] i_15_35 = i_15_36 - i_15;
    wire signed [IN_WIDTH + 8 : 0] i_15_40 = i_15_5 <<< 3;
    wire signed [IN_WIDTH + 8 : 0] i_15_45 = i_15_5 + i_15_40;
    wire signed [IN_WIDTH + 8 : 0] i_15_80 = i_15_5 <<< 4;
    wire signed [IN_WIDTH + 8 : 0] i_15_75 = i_15_80 - i_15_5;
    wire signed [IN_WIDTH + 8 : 0] i_15_89 = i_15_9 + i_15_80;
    wire signed [IN_WIDTH + 8 : 0] i_15_43 = i_15_35 + i_15_8;
    wire signed [IN_WIDTH + 8 : 0] i_15_32 = i_15 <<< 5;
    wire signed [IN_WIDTH + 8 : 0] i_15_57 = i_15_25 + i_15_32;
    wire signed [IN_WIDTH + 8 : 0] i_15_128 = i_15 <<< 7;
    wire signed [IN_WIDTH + 8 : 0] i_15_83 = i_15_128 - i_15_45;
    wire signed [IN_WIDTH + 8 : 0] i_15_2 = i_15 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_15_87 = i_15_89 - i_15_2;
    wire signed [IN_WIDTH + 8 : 0] i_15_90 = i_15_45 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_15_70 = i_15_35 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_15_50 = i_15_25 <<< 1;
    wire signed [IN_WIDTH + 8 : 0] i_15_18 = i_15_9 <<< 1;
//[i_16 18bit] <cost: [13] adds/subtracts [24] shifts, Depth: [3]> DCT2 SIZE32: 90  90  88  85  82  78  73  67  61  54  46  38  31  22  13   4; SIZE4: 64  64
    wire signed [IN_WIDTH + 7 : 0] i_16_32 = i_16 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_16_31 = i_16_32 - i_16;
    wire signed [IN_WIDTH + 7 : 0] i_16_8 = i_16 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_16_23 = i_16_31 - i_16_8;
    wire signed [IN_WIDTH + 7 : 0] i_16_4 = i_16 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_16_27 = i_16_31 - i_16_4;
    wire signed [IN_WIDTH + 7 : 0] i_16_39 = i_16_31 + i_16_8;
    wire signed [IN_WIDTH + 7 : 0] i_16_62 = i_16_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_16_61 = i_16_62 - i_16;
    wire signed [IN_WIDTH + 7 : 0] i_16_22 = i_16_23 - i_16;
    wire signed [IN_WIDTH + 7 : 0] i_16_11 = i_16_22 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_16_26 = i_16_27 - i_16;
    wire signed [IN_WIDTH + 7 : 0] i_16_13 = i_16_26 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_16_19 = i_16_23 - i_16_4;
    wire signed [IN_WIDTH + 7 : 0] i_16_64 = i_16 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_16_41 = i_16_64 - i_16_23;
    wire signed [IN_WIDTH + 7 : 0] i_16_46 = i_16_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_16_45 = i_16_46 - i_16;
    wire signed [IN_WIDTH + 7 : 0] i_16_128 = i_16 <<< 7;
    wire signed [IN_WIDTH + 7 : 0] i_16_67 = i_16_128 - i_16_61;
    wire signed [IN_WIDTH + 7 : 0] i_16_73 = i_16_27 + i_16_46;
    wire signed [IN_WIDTH + 7 : 0] i_16_108 = i_16_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_16_85 = i_16_108 - i_16_23;
    wire signed [IN_WIDTH + 7 : 0] i_16_90 = i_16_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_16_88 = i_16_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_16_82 = i_16_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_16_78 = i_16_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_16_54 = i_16_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_16_38 = i_16_19 <<< 1;
//[i_17 18bit] <cost: [13] adds/subtracts [24] shifts, Depth: [3]> DCT2 SIZE32: 90  82  67  46  22  -4 -31 -54 -73 -85 -90 -88 -78 -61 -38 -13; SIZE4: 64 -64
    wire signed [IN_WIDTH + 7 : 0] i_17_32 = i_17 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_17_31 = i_17_32 - i_17;
    wire signed [IN_WIDTH + 7 : 0] i_17_8 = i_17 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_17_23 = i_17_31 - i_17_8;
    wire signed [IN_WIDTH + 7 : 0] i_17_4 = i_17 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_17_27 = i_17_31 - i_17_4;
    wire signed [IN_WIDTH + 7 : 0] i_17_39 = i_17_31 + i_17_8;
    wire signed [IN_WIDTH + 7 : 0] i_17_62 = i_17_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_17_61 = i_17_62 - i_17;
    wire signed [IN_WIDTH + 7 : 0] i_17_22 = i_17_23 - i_17;
    wire signed [IN_WIDTH + 7 : 0] i_17_11 = i_17_22 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_17_26 = i_17_27 - i_17;
    wire signed [IN_WIDTH + 7 : 0] i_17_13 = i_17_26 >>> 1;
    wire signed [IN_WIDTH + 7 : 0] i_17_19 = i_17_23 - i_17_4;
    wire signed [IN_WIDTH + 7 : 0] i_17_64 = i_17 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_17_41 = i_17_64 - i_17_23;
    wire signed [IN_WIDTH + 7 : 0] i_17_46 = i_17_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_17_45 = i_17_46 - i_17;
    wire signed [IN_WIDTH + 7 : 0] i_17_128 = i_17 <<< 7;
    wire signed [IN_WIDTH + 7 : 0] i_17_67 = i_17_128 - i_17_61;
    wire signed [IN_WIDTH + 7 : 0] i_17_73 = i_17_27 + i_17_46;
    wire signed [IN_WIDTH + 7 : 0] i_17_108 = i_17_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_17_85 = i_17_108 - i_17_23;
    wire signed [IN_WIDTH + 7 : 0] i_17_90 = i_17_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_17_88 = i_17_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_17_82 = i_17_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_17_78 = i_17_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_17_54 = i_17_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_17_38 = i_17_19 <<< 1;
//[i_18 18bit] <cost: [15] adds/subtracts [26] shifts, Depth: [3]> DCT2 SIZE32: 88  67  31 -13 -54 -82 -90 -78 -46  -4  38  73  90  85  61  22; SIZE4: 83  36
    wire signed [IN_WIDTH + 7 : 0] i_18_8 = i_18 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_18_9 = i_18 + i_18_8;
    wire signed [IN_WIDTH + 7 : 0] i_18_32 = i_18 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_18_31 = i_18_32 - i_18;
    wire signed [IN_WIDTH + 7 : 0] i_18_2 = i_18 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_18_11 = i_18_9 + i_18_2;
    wire signed [IN_WIDTH + 7 : 0] i_18_4 = i_18 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_18_13 = i_18_9 + i_18_4;
    wire signed [IN_WIDTH + 7 : 0] i_18_18 = i_18_9 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_18_19 = i_18 + i_18_18;
    wire signed [IN_WIDTH + 7 : 0] i_18_23 = i_18_32 - i_18_9;
    wire signed [IN_WIDTH + 7 : 0] i_18_27 = i_18_31 - i_18_4;
    wire signed [IN_WIDTH + 7 : 0] i_18_39 = i_18_31 + i_18_8;
    wire signed [IN_WIDTH + 7 : 0] i_18_41 = i_18_9 + i_18_32;
    wire signed [IN_WIDTH + 7 : 0] i_18_36 = i_18_9 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_18_45 = i_18_9 + i_18_36;
    wire signed [IN_WIDTH + 7 : 0] i_18_62 = i_18_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_18_61 = i_18_62 - i_18;
    wire signed [IN_WIDTH + 7 : 0] i_18_67 = i_18_31 + i_18_36;
    wire signed [IN_WIDTH + 7 : 0] i_18_64 = i_18 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_18_73 = i_18_9 + i_18_64;
    wire signed [IN_WIDTH + 7 : 0] i_18_83 = i_18_19 + i_18_64;
    wire signed [IN_WIDTH + 7 : 0] i_18_72 = i_18_9 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_18_85 = i_18_13 + i_18_72;
    wire signed [IN_WIDTH + 7 : 0] i_18_90 = i_18_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_18_88 = i_18_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_18_82 = i_18_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_18_78 = i_18_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_18_54 = i_18_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_18_46 = i_18_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_18_38 = i_18_19 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_18_22 = i_18_11 <<< 1;
//[i_19 18bit] <cost: [15] adds/subtracts [26] shifts, Depth: [3]> DCT2 SIZE32: 85  46 -13 -67 -90 -73 -22  38  82  88  54  -4 -61 -90 -78 -31; SIZE4: 36 -83
    wire signed [IN_WIDTH + 7 : 0] i_19_8 = i_19 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_19_9 = i_19 + i_19_8;
    wire signed [IN_WIDTH + 7 : 0] i_19_32 = i_19 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_19_31 = i_19_32 - i_19;
    wire signed [IN_WIDTH + 7 : 0] i_19_2 = i_19 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_19_11 = i_19_9 + i_19_2;
    wire signed [IN_WIDTH + 7 : 0] i_19_4 = i_19 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_19_13 = i_19_9 + i_19_4;
    wire signed [IN_WIDTH + 7 : 0] i_19_18 = i_19_9 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_19_19 = i_19 + i_19_18;
    wire signed [IN_WIDTH + 7 : 0] i_19_23 = i_19_32 - i_19_9;
    wire signed [IN_WIDTH + 7 : 0] i_19_27 = i_19_31 - i_19_4;
    wire signed [IN_WIDTH + 7 : 0] i_19_39 = i_19_31 + i_19_8;
    wire signed [IN_WIDTH + 7 : 0] i_19_41 = i_19_9 + i_19_32;
    wire signed [IN_WIDTH + 7 : 0] i_19_36 = i_19_9 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_19_45 = i_19_9 + i_19_36;
    wire signed [IN_WIDTH + 7 : 0] i_19_62 = i_19_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_19_61 = i_19_62 - i_19;
    wire signed [IN_WIDTH + 7 : 0] i_19_67 = i_19_31 + i_19_36;
    wire signed [IN_WIDTH + 7 : 0] i_19_64 = i_19 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_19_73 = i_19_9 + i_19_64;
    wire signed [IN_WIDTH + 7 : 0] i_19_83 = i_19_19 + i_19_64;
    wire signed [IN_WIDTH + 7 : 0] i_19_72 = i_19_9 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_19_85 = i_19_13 + i_19_72;
    wire signed [IN_WIDTH + 7 : 0] i_19_90 = i_19_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_19_88 = i_19_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_19_82 = i_19_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_19_78 = i_19_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_19_54 = i_19_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_19_46 = i_19_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_19_38 = i_19_19 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_19_22 = i_19_11 <<< 1;
//[i_20 18bit] <cost: [17] adds/subtracts [30] shifts, Depth: [3]> DCT2 SIZE32: 82  22 -54 -90 -61  13  78  85  31 -46 -90 -67   4  73  88  38; SIZE8: 89  75  50  18; SIZE4: 64  64
    wire signed [IN_WIDTH + 7 : 0] i_20_8 = i_20 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_20_9 = i_20 + i_20_8;
    wire signed [IN_WIDTH + 7 : 0] i_20_32 = i_20 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_20_31 = i_20_32 - i_20;
    wire signed [IN_WIDTH + 7 : 0] i_20_2 = i_20 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_20_11 = i_20_9 + i_20_2;
    wire signed [IN_WIDTH + 7 : 0] i_20_4 = i_20 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_20_13 = i_20_9 + i_20_4;
    wire signed [IN_WIDTH + 7 : 0] i_20_18 = i_20_9 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_20_19 = i_20 + i_20_18;
    wire signed [IN_WIDTH + 7 : 0] i_20_23 = i_20_32 - i_20_9;
    wire signed [IN_WIDTH + 7 : 0] i_20_16 = i_20 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_20_25 = i_20_9 + i_20_16;
    wire signed [IN_WIDTH + 7 : 0] i_20_27 = i_20_31 - i_20_4;
    wire signed [IN_WIDTH + 7 : 0] i_20_39 = i_20_31 + i_20_8;
    wire signed [IN_WIDTH + 7 : 0] i_20_41 = i_20_9 + i_20_32;
    wire signed [IN_WIDTH + 7 : 0] i_20_36 = i_20_9 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_20_45 = i_20_9 + i_20_36;
    wire signed [IN_WIDTH + 7 : 0] i_20_62 = i_20_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_20_61 = i_20_62 - i_20;
    wire signed [IN_WIDTH + 7 : 0] i_20_67 = i_20_31 + i_20_36;
    wire signed [IN_WIDTH + 7 : 0] i_20_64 = i_20 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_20_73 = i_20_9 + i_20_64;
    wire signed [IN_WIDTH + 7 : 0] i_20_75 = i_20_11 + i_20_64;
    wire signed [IN_WIDTH + 7 : 0] i_20_72 = i_20_9 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_20_85 = i_20_13 + i_20_72;
    wire signed [IN_WIDTH + 7 : 0] i_20_88 = i_20_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_20_89 = i_20 + i_20_88;
    wire signed [IN_WIDTH + 7 : 0] i_20_90 = i_20_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_20_82 = i_20_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_20_78 = i_20_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_20_54 = i_20_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_20_46 = i_20_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_20_38 = i_20_19 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_20_22 = i_20_11 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_20_50 = i_20_25 <<< 1;
//[i_21 18bit] <cost: [17] adds/subtracts [30] shifts, Depth: [3]> DCT2 SIZE32: 78  -4 -82 -73  13  85  67 -22 -88 -61  31  90  54 -38 -90 -46; SIZE8: 75 -18 -89 -50; SIZE4: 64 -64
    wire signed [IN_WIDTH + 7 : 0] i_21_8 = i_21 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_21_9 = i_21 + i_21_8;
    wire signed [IN_WIDTH + 7 : 0] i_21_32 = i_21 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_21_31 = i_21_32 - i_21;
    wire signed [IN_WIDTH + 7 : 0] i_21_2 = i_21 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_21_11 = i_21_9 + i_21_2;
    wire signed [IN_WIDTH + 7 : 0] i_21_4 = i_21 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_21_13 = i_21_9 + i_21_4;
    wire signed [IN_WIDTH + 7 : 0] i_21_18 = i_21_9 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_21_19 = i_21 + i_21_18;
    wire signed [IN_WIDTH + 7 : 0] i_21_23 = i_21_32 - i_21_9;
    wire signed [IN_WIDTH + 7 : 0] i_21_16 = i_21 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_21_25 = i_21_9 + i_21_16;
    wire signed [IN_WIDTH + 7 : 0] i_21_27 = i_21_31 - i_21_4;
    wire signed [IN_WIDTH + 7 : 0] i_21_39 = i_21_31 + i_21_8;
    wire signed [IN_WIDTH + 7 : 0] i_21_41 = i_21_9 + i_21_32;
    wire signed [IN_WIDTH + 7 : 0] i_21_36 = i_21_9 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_21_45 = i_21_9 + i_21_36;
    wire signed [IN_WIDTH + 7 : 0] i_21_62 = i_21_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_21_61 = i_21_62 - i_21;
    wire signed [IN_WIDTH + 7 : 0] i_21_67 = i_21_31 + i_21_36;
    wire signed [IN_WIDTH + 7 : 0] i_21_64 = i_21 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_21_73 = i_21_9 + i_21_64;
    wire signed [IN_WIDTH + 7 : 0] i_21_75 = i_21_11 + i_21_64;
    wire signed [IN_WIDTH + 7 : 0] i_21_72 = i_21_9 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_21_85 = i_21_13 + i_21_72;
    wire signed [IN_WIDTH + 7 : 0] i_21_88 = i_21_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_21_89 = i_21 + i_21_88;
    wire signed [IN_WIDTH + 7 : 0] i_21_90 = i_21_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_21_82 = i_21_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_21_78 = i_21_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_21_54 = i_21_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_21_46 = i_21_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_21_38 = i_21_19 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_21_22 = i_21_11 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_21_50 = i_21_25 <<< 1;
//[i_22 18bit] <cost: [18] adds/subtracts [31] shifts, Depth: [3]> DCT2 SIZE32: 73 -31 -90 -22  78  67 -38 -90 -13  82  61 -46 -88  -4  85  54; SIZE8: 50 -89  18  75; SIZE4: 83  36
    wire signed [IN_WIDTH + 7 : 0] i_22_8 = i_22 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_22_9 = i_22 + i_22_8;
    wire signed [IN_WIDTH + 7 : 0] i_22_32 = i_22 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_22_31 = i_22_32 - i_22;
    wire signed [IN_WIDTH + 7 : 0] i_22_2 = i_22 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_22_11 = i_22_9 + i_22_2;
    wire signed [IN_WIDTH + 7 : 0] i_22_4 = i_22 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_22_13 = i_22_9 + i_22_4;
    wire signed [IN_WIDTH + 7 : 0] i_22_18 = i_22_9 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_22_19 = i_22 + i_22_18;
    wire signed [IN_WIDTH + 7 : 0] i_22_23 = i_22_32 - i_22_9;
    wire signed [IN_WIDTH + 7 : 0] i_22_16 = i_22 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_22_25 = i_22_9 + i_22_16;
    wire signed [IN_WIDTH + 7 : 0] i_22_27 = i_22_31 - i_22_4;
    wire signed [IN_WIDTH + 7 : 0] i_22_39 = i_22_31 + i_22_8;
    wire signed [IN_WIDTH + 7 : 0] i_22_41 = i_22_9 + i_22_32;
    wire signed [IN_WIDTH + 7 : 0] i_22_36 = i_22_9 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_22_45 = i_22_9 + i_22_36;
    wire signed [IN_WIDTH + 7 : 0] i_22_62 = i_22_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_22_61 = i_22_62 - i_22;
    wire signed [IN_WIDTH + 7 : 0] i_22_67 = i_22_31 + i_22_36;
    wire signed [IN_WIDTH + 7 : 0] i_22_64 = i_22 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_22_73 = i_22_9 + i_22_64;
    wire signed [IN_WIDTH + 7 : 0] i_22_75 = i_22_11 + i_22_64;
    wire signed [IN_WIDTH + 7 : 0] i_22_83 = i_22_19 + i_22_64;
    wire signed [IN_WIDTH + 7 : 0] i_22_72 = i_22_9 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_22_85 = i_22_13 + i_22_72;
    wire signed [IN_WIDTH + 7 : 0] i_22_88 = i_22_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_22_89 = i_22 + i_22_88;
    wire signed [IN_WIDTH + 7 : 0] i_22_90 = i_22_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_22_82 = i_22_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_22_78 = i_22_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_22_54 = i_22_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_22_46 = i_22_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_22_38 = i_22_19 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_22_22 = i_22_11 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_22_50 = i_22_25 <<< 1;
//[i_23 18bit] <cost: [18] adds/subtracts [31] shifts, Depth: [3]> DCT2 SIZE32: 67 -54 -78  38  85 -22 -90   4  90  13 -88 -31  82  46 -73 -61; SIZE8: 18 -50  75 -89; SIZE4: 36 -83
    wire signed [IN_WIDTH + 7 : 0] i_23_8 = i_23 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_23_9 = i_23 + i_23_8;
    wire signed [IN_WIDTH + 7 : 0] i_23_32 = i_23 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_23_31 = i_23_32 - i_23;
    wire signed [IN_WIDTH + 7 : 0] i_23_2 = i_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_23_11 = i_23_9 + i_23_2;
    wire signed [IN_WIDTH + 7 : 0] i_23_4 = i_23 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_23_13 = i_23_9 + i_23_4;
    wire signed [IN_WIDTH + 7 : 0] i_23_18 = i_23_9 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_23_19 = i_23 + i_23_18;
    wire signed [IN_WIDTH + 7 : 0] i_23_23 = i_23_32 - i_23_9;
    wire signed [IN_WIDTH + 7 : 0] i_23_16 = i_23 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_23_25 = i_23_9 + i_23_16;
    wire signed [IN_WIDTH + 7 : 0] i_23_27 = i_23_31 - i_23_4;
    wire signed [IN_WIDTH + 7 : 0] i_23_39 = i_23_31 + i_23_8;
    wire signed [IN_WIDTH + 7 : 0] i_23_41 = i_23_9 + i_23_32;
    wire signed [IN_WIDTH + 7 : 0] i_23_36 = i_23_9 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_23_45 = i_23_9 + i_23_36;
    wire signed [IN_WIDTH + 7 : 0] i_23_62 = i_23_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_23_61 = i_23_62 - i_23;
    wire signed [IN_WIDTH + 7 : 0] i_23_67 = i_23_31 + i_23_36;
    wire signed [IN_WIDTH + 7 : 0] i_23_64 = i_23 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_23_73 = i_23_9 + i_23_64;
    wire signed [IN_WIDTH + 7 : 0] i_23_75 = i_23_11 + i_23_64;
    wire signed [IN_WIDTH + 7 : 0] i_23_83 = i_23_19 + i_23_64;
    wire signed [IN_WIDTH + 7 : 0] i_23_72 = i_23_9 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_23_85 = i_23_13 + i_23_72;
    wire signed [IN_WIDTH + 7 : 0] i_23_88 = i_23_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_23_89 = i_23 + i_23_88;
    wire signed [IN_WIDTH + 7 : 0] i_23_90 = i_23_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_23_82 = i_23_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_23_78 = i_23_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_23_54 = i_23_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_23_46 = i_23_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_23_38 = i_23_19 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_23_22 = i_23_11 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_23_50 = i_23_25 <<< 1;
//[i_24 18bit] <cost: [20] adds/subtracts [33] shifts, Depth: [3]> DCT2 SIZE32: 61 -73 -46  82  31 -88 -13  90  -4 -90  22  85 -38 -78  54  67; SIZE16: 90  87  80  70  57  43  25   9; SIZE4: 64  64
    wire signed [IN_WIDTH + 7 : 0] i_24_4 = i_24 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_24_5 = i_24 + i_24_4;
    wire signed [IN_WIDTH + 7 : 0] i_24_8 = i_24 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_24_9 = i_24 + i_24_8;
    wire signed [IN_WIDTH + 7 : 0] i_24_32 = i_24 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_24_31 = i_24_32 - i_24;
    wire signed [IN_WIDTH + 7 : 0] i_24_16 = i_24 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_24_11 = i_24_16 - i_24_5;
    wire signed [IN_WIDTH + 7 : 0] i_24_13 = i_24_5 + i_24_8;
    wire signed [IN_WIDTH + 7 : 0] i_24_20 = i_24_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_24_19 = i_24_20 - i_24;
    wire signed [IN_WIDTH + 7 : 0] i_24_23 = i_24_32 - i_24_9;
    wire signed [IN_WIDTH + 7 : 0] i_24_25 = i_24_9 + i_24_16;
    wire signed [IN_WIDTH + 7 : 0] i_24_27 = i_24_32 - i_24_5;
    wire signed [IN_WIDTH + 7 : 0] i_24_36 = i_24_9 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_24_35 = i_24_36 - i_24;
    wire signed [IN_WIDTH + 7 : 0] i_24_40 = i_24_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_24_39 = i_24_40 - i_24;
    wire signed [IN_WIDTH + 7 : 0] i_24_41 = i_24 + i_24_40;
    wire signed [IN_WIDTH + 7 : 0] i_24_45 = i_24_5 + i_24_40;
    wire signed [IN_WIDTH + 7 : 0] i_24_62 = i_24_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_24_57 = i_24_62 - i_24_5;
    wire signed [IN_WIDTH + 7 : 0] i_24_61 = i_24_62 - i_24;
    wire signed [IN_WIDTH + 7 : 0] i_24_72 = i_24_9 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_24_67 = i_24_72 - i_24_5;
    wire signed [IN_WIDTH + 7 : 0] i_24_64 = i_24 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_24_73 = i_24_9 + i_24_64;
    wire signed [IN_WIDTH + 7 : 0] i_24_80 = i_24_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_24_85 = i_24_5 + i_24_80;
    wire signed [IN_WIDTH + 7 : 0] i_24_43 = i_24_11 + i_24_32;
    wire signed [IN_WIDTH + 7 : 0] i_24_88 = i_24_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_24_87 = i_24_88 - i_24;
    wire signed [IN_WIDTH + 7 : 0] i_24_46 = i_24_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_24_82 = i_24_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_24_90 = i_24_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_24_22 = i_24_11 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_24_38 = i_24_19 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_24_78 = i_24_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_24_54 = i_24_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_24_70 = i_24_35 <<< 1;
//[i_25 18bit] <cost: [20] adds/subtracts [33] shifts, Depth: [3]> DCT2 SIZE32: 54 -85  -4  88 -46 -61  82  13 -90  38  67 -78 -22  90 -31 -73; SIZE16: 87  57   9 -43 -80 -90 -70 -25; SIZE4: 64 -64
    wire signed [IN_WIDTH + 7 : 0] i_25_4 = i_25 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_25_5 = i_25 + i_25_4;
    wire signed [IN_WIDTH + 7 : 0] i_25_8 = i_25 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_25_9 = i_25 + i_25_8;
    wire signed [IN_WIDTH + 7 : 0] i_25_32 = i_25 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_25_31 = i_25_32 - i_25;
    wire signed [IN_WIDTH + 7 : 0] i_25_16 = i_25 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_25_11 = i_25_16 - i_25_5;
    wire signed [IN_WIDTH + 7 : 0] i_25_13 = i_25_5 + i_25_8;
    wire signed [IN_WIDTH + 7 : 0] i_25_20 = i_25_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_25_19 = i_25_20 - i_25;
    wire signed [IN_WIDTH + 7 : 0] i_25_23 = i_25_32 - i_25_9;
    wire signed [IN_WIDTH + 7 : 0] i_25_25 = i_25_9 + i_25_16;
    wire signed [IN_WIDTH + 7 : 0] i_25_27 = i_25_32 - i_25_5;
    wire signed [IN_WIDTH + 7 : 0] i_25_36 = i_25_9 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_25_35 = i_25_36 - i_25;
    wire signed [IN_WIDTH + 7 : 0] i_25_40 = i_25_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_25_39 = i_25_40 - i_25;
    wire signed [IN_WIDTH + 7 : 0] i_25_41 = i_25 + i_25_40;
    wire signed [IN_WIDTH + 7 : 0] i_25_45 = i_25_5 + i_25_40;
    wire signed [IN_WIDTH + 7 : 0] i_25_62 = i_25_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_25_57 = i_25_62 - i_25_5;
    wire signed [IN_WIDTH + 7 : 0] i_25_61 = i_25_62 - i_25;
    wire signed [IN_WIDTH + 7 : 0] i_25_72 = i_25_9 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_25_67 = i_25_72 - i_25_5;
    wire signed [IN_WIDTH + 7 : 0] i_25_64 = i_25 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_25_73 = i_25_9 + i_25_64;
    wire signed [IN_WIDTH + 7 : 0] i_25_80 = i_25_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_25_85 = i_25_5 + i_25_80;
    wire signed [IN_WIDTH + 7 : 0] i_25_43 = i_25_11 + i_25_32;
    wire signed [IN_WIDTH + 7 : 0] i_25_88 = i_25_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_25_87 = i_25_88 - i_25;
    wire signed [IN_WIDTH + 7 : 0] i_25_46 = i_25_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_25_82 = i_25_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_25_90 = i_25_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_25_22 = i_25_11 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_25_38 = i_25_19 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_25_78 = i_25_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_25_54 = i_25_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_25_70 = i_25_35 <<< 1;
//[i_26 18bit] <cost: [21] adds/subtracts [34] shifts, Depth: [3]> DCT2 SIZE32: 46 -90  38  54 -90  31  61 -88  22  67 -85  13  73 -82   4  78; SIZE16: 80   9 -70 -87 -25  57  90  43; SIZE4: 83  36
    wire signed [IN_WIDTH + 7 : 0] i_26_4 = i_26 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_26_5 = i_26 + i_26_4;
    wire signed [IN_WIDTH + 7 : 0] i_26_8 = i_26 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_26_9 = i_26 + i_26_8;
    wire signed [IN_WIDTH + 7 : 0] i_26_32 = i_26 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_26_31 = i_26_32 - i_26;
    wire signed [IN_WIDTH + 7 : 0] i_26_16 = i_26 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_26_11 = i_26_16 - i_26_5;
    wire signed [IN_WIDTH + 7 : 0] i_26_13 = i_26_5 + i_26_8;
    wire signed [IN_WIDTH + 7 : 0] i_26_20 = i_26_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_26_19 = i_26_20 - i_26;
    wire signed [IN_WIDTH + 7 : 0] i_26_23 = i_26_32 - i_26_9;
    wire signed [IN_WIDTH + 7 : 0] i_26_25 = i_26_9 + i_26_16;
    wire signed [IN_WIDTH + 7 : 0] i_26_27 = i_26_32 - i_26_5;
    wire signed [IN_WIDTH + 7 : 0] i_26_36 = i_26_9 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_26_35 = i_26_36 - i_26;
    wire signed [IN_WIDTH + 7 : 0] i_26_40 = i_26_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_26_39 = i_26_40 - i_26;
    wire signed [IN_WIDTH + 7 : 0] i_26_41 = i_26 + i_26_40;
    wire signed [IN_WIDTH + 7 : 0] i_26_45 = i_26_5 + i_26_40;
    wire signed [IN_WIDTH + 7 : 0] i_26_62 = i_26_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_26_57 = i_26_62 - i_26_5;
    wire signed [IN_WIDTH + 7 : 0] i_26_61 = i_26_62 - i_26;
    wire signed [IN_WIDTH + 7 : 0] i_26_72 = i_26_9 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_26_67 = i_26_72 - i_26_5;
    wire signed [IN_WIDTH + 7 : 0] i_26_64 = i_26 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_26_73 = i_26_9 + i_26_64;
    wire signed [IN_WIDTH + 7 : 0] i_26_80 = i_26_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_26_85 = i_26_5 + i_26_80;
    wire signed [IN_WIDTH + 7 : 0] i_26_43 = i_26_11 + i_26_32;
    wire signed [IN_WIDTH + 7 : 0] i_26_83 = i_26_19 + i_26_64;
    wire signed [IN_WIDTH + 7 : 0] i_26_88 = i_26_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_26_87 = i_26_88 - i_26;
    wire signed [IN_WIDTH + 7 : 0] i_26_46 = i_26_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_26_82 = i_26_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_26_90 = i_26_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_26_22 = i_26_11 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_26_38 = i_26_19 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_26_78 = i_26_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_26_54 = i_26_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_26_70 = i_26_35 <<< 1;
//[i_27 18bit] <cost: [21] adds/subtracts [34] shifts, Depth: [3]> DCT2 SIZE32: 38 -88  73  -4 -67  90 -46 -31  85 -78  13  61 -90  54  22 -82; SIZE16: 70 -43 -87   9  90  25 -80 -57; SIZE4: 36 -83
    wire signed [IN_WIDTH + 7 : 0] i_27_4 = i_27 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_27_5 = i_27 + i_27_4;
    wire signed [IN_WIDTH + 7 : 0] i_27_8 = i_27 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_27_9 = i_27 + i_27_8;
    wire signed [IN_WIDTH + 7 : 0] i_27_32 = i_27 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_27_31 = i_27_32 - i_27;
    wire signed [IN_WIDTH + 7 : 0] i_27_16 = i_27 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_27_11 = i_27_16 - i_27_5;
    wire signed [IN_WIDTH + 7 : 0] i_27_13 = i_27_5 + i_27_8;
    wire signed [IN_WIDTH + 7 : 0] i_27_20 = i_27_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_27_19 = i_27_20 - i_27;
    wire signed [IN_WIDTH + 7 : 0] i_27_23 = i_27_32 - i_27_9;
    wire signed [IN_WIDTH + 7 : 0] i_27_25 = i_27_9 + i_27_16;
    wire signed [IN_WIDTH + 7 : 0] i_27_27 = i_27_32 - i_27_5;
    wire signed [IN_WIDTH + 7 : 0] i_27_36 = i_27_9 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_27_35 = i_27_36 - i_27;
    wire signed [IN_WIDTH + 7 : 0] i_27_40 = i_27_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_27_39 = i_27_40 - i_27;
    wire signed [IN_WIDTH + 7 : 0] i_27_41 = i_27 + i_27_40;
    wire signed [IN_WIDTH + 7 : 0] i_27_45 = i_27_5 + i_27_40;
    wire signed [IN_WIDTH + 7 : 0] i_27_62 = i_27_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_27_57 = i_27_62 - i_27_5;
    wire signed [IN_WIDTH + 7 : 0] i_27_61 = i_27_62 - i_27;
    wire signed [IN_WIDTH + 7 : 0] i_27_72 = i_27_9 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_27_67 = i_27_72 - i_27_5;
    wire signed [IN_WIDTH + 7 : 0] i_27_64 = i_27 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_27_73 = i_27_9 + i_27_64;
    wire signed [IN_WIDTH + 7 : 0] i_27_80 = i_27_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_27_85 = i_27_5 + i_27_80;
    wire signed [IN_WIDTH + 7 : 0] i_27_43 = i_27_11 + i_27_32;
    wire signed [IN_WIDTH + 7 : 0] i_27_83 = i_27_19 + i_27_64;
    wire signed [IN_WIDTH + 7 : 0] i_27_88 = i_27_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_27_87 = i_27_88 - i_27;
    wire signed [IN_WIDTH + 7 : 0] i_27_46 = i_27_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_27_82 = i_27_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_27_90 = i_27_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_27_22 = i_27_11 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_27_38 = i_27_19 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_27_78 = i_27_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_27_54 = i_27_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_27_70 = i_27_35 <<< 1;
//[i_28 18bit] <cost: [22] adds/subtracts [37] shifts, Depth: [3]> DCT2 SIZE32: 31 -78  90 -61   4  54 -88  82 -38 -22  73 -90  67 -13 -46  85; SIZE16: 57 -80 -25  90  -9 -87  43  70; SIZE8: 89  75  50  18; SIZE4: 64  64
    wire signed [IN_WIDTH + 7 : 0] i_28_4 = i_28 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_28_5 = i_28 + i_28_4;
    wire signed [IN_WIDTH + 7 : 0] i_28_8 = i_28 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_28_9 = i_28 + i_28_8;
    wire signed [IN_WIDTH + 7 : 0] i_28_32 = i_28 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_28_31 = i_28_32 - i_28;
    wire signed [IN_WIDTH + 7 : 0] i_28_16 = i_28 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_28_11 = i_28_16 - i_28_5;
    wire signed [IN_WIDTH + 7 : 0] i_28_13 = i_28_5 + i_28_8;
    wire signed [IN_WIDTH + 7 : 0] i_28_20 = i_28_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_28_19 = i_28_20 - i_28;
    wire signed [IN_WIDTH + 7 : 0] i_28_23 = i_28_32 - i_28_9;
    wire signed [IN_WIDTH + 7 : 0] i_28_25 = i_28_9 + i_28_16;
    wire signed [IN_WIDTH + 7 : 0] i_28_27 = i_28_32 - i_28_5;
    wire signed [IN_WIDTH + 7 : 0] i_28_36 = i_28_9 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_28_35 = i_28_36 - i_28;
    wire signed [IN_WIDTH + 7 : 0] i_28_40 = i_28_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_28_39 = i_28_40 - i_28;
    wire signed [IN_WIDTH + 7 : 0] i_28_41 = i_28 + i_28_40;
    wire signed [IN_WIDTH + 7 : 0] i_28_45 = i_28_5 + i_28_40;
    wire signed [IN_WIDTH + 7 : 0] i_28_62 = i_28_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_28_57 = i_28_62 - i_28_5;
    wire signed [IN_WIDTH + 7 : 0] i_28_61 = i_28_62 - i_28;
    wire signed [IN_WIDTH + 7 : 0] i_28_72 = i_28_9 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_28_67 = i_28_72 - i_28_5;
    wire signed [IN_WIDTH + 7 : 0] i_28_64 = i_28 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_28_73 = i_28_9 + i_28_64;
    wire signed [IN_WIDTH + 7 : 0] i_28_80 = i_28_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_28_75 = i_28_80 - i_28_5;
    wire signed [IN_WIDTH + 7 : 0] i_28_85 = i_28_5 + i_28_80;
    wire signed [IN_WIDTH + 7 : 0] i_28_89 = i_28_9 + i_28_80;
    wire signed [IN_WIDTH + 7 : 0] i_28_43 = i_28_11 + i_28_32;
    wire signed [IN_WIDTH + 7 : 0] i_28_88 = i_28_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_28_87 = i_28_88 - i_28;
    wire signed [IN_WIDTH + 7 : 0] i_28_78 = i_28_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_28_90 = i_28_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_28_54 = i_28_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_28_82 = i_28_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_28_38 = i_28_19 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_28_22 = i_28_11 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_28_46 = i_28_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_28_70 = i_28_35 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_28_50 = i_28_25 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_28_18 = i_28_9 <<< 1;
//[i_29 18bit] <cost: [22] adds/subtracts [37] shifts, Depth: [3]> DCT2 SIZE32: 22 -61  85 -90  73 -38  -4  46 -78  90 -82  54 -13 -31  67 -88; SIZE16: 43 -90  57  25 -87  70   9 -80; SIZE8: 75 -18 -89 -50; SIZE4: 64 -64
    wire signed [IN_WIDTH + 7 : 0] i_29_4 = i_29 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_29_5 = i_29 + i_29_4;
    wire signed [IN_WIDTH + 7 : 0] i_29_8 = i_29 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_29_9 = i_29 + i_29_8;
    wire signed [IN_WIDTH + 7 : 0] i_29_32 = i_29 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_29_31 = i_29_32 - i_29;
    wire signed [IN_WIDTH + 7 : 0] i_29_16 = i_29 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_29_11 = i_29_16 - i_29_5;
    wire signed [IN_WIDTH + 7 : 0] i_29_13 = i_29_5 + i_29_8;
    wire signed [IN_WIDTH + 7 : 0] i_29_20 = i_29_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_29_19 = i_29_20 - i_29;
    wire signed [IN_WIDTH + 7 : 0] i_29_23 = i_29_32 - i_29_9;
    wire signed [IN_WIDTH + 7 : 0] i_29_25 = i_29_9 + i_29_16;
    wire signed [IN_WIDTH + 7 : 0] i_29_27 = i_29_32 - i_29_5;
    wire signed [IN_WIDTH + 7 : 0] i_29_36 = i_29_9 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_29_35 = i_29_36 - i_29;
    wire signed [IN_WIDTH + 7 : 0] i_29_40 = i_29_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_29_39 = i_29_40 - i_29;
    wire signed [IN_WIDTH + 7 : 0] i_29_41 = i_29 + i_29_40;
    wire signed [IN_WIDTH + 7 : 0] i_29_45 = i_29_5 + i_29_40;
    wire signed [IN_WIDTH + 7 : 0] i_29_62 = i_29_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_29_57 = i_29_62 - i_29_5;
    wire signed [IN_WIDTH + 7 : 0] i_29_61 = i_29_62 - i_29;
    wire signed [IN_WIDTH + 7 : 0] i_29_72 = i_29_9 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_29_67 = i_29_72 - i_29_5;
    wire signed [IN_WIDTH + 7 : 0] i_29_64 = i_29 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_29_73 = i_29_9 + i_29_64;
    wire signed [IN_WIDTH + 7 : 0] i_29_80 = i_29_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_29_75 = i_29_80 - i_29_5;
    wire signed [IN_WIDTH + 7 : 0] i_29_85 = i_29_5 + i_29_80;
    wire signed [IN_WIDTH + 7 : 0] i_29_89 = i_29_9 + i_29_80;
    wire signed [IN_WIDTH + 7 : 0] i_29_43 = i_29_11 + i_29_32;
    wire signed [IN_WIDTH + 7 : 0] i_29_88 = i_29_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_29_87 = i_29_88 - i_29;
    wire signed [IN_WIDTH + 7 : 0] i_29_78 = i_29_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_29_90 = i_29_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_29_54 = i_29_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_29_82 = i_29_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_29_38 = i_29_19 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_29_22 = i_29_11 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_29_46 = i_29_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_29_70 = i_29_35 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_29_50 = i_29_25 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_29_18 = i_29_9 <<< 1;
//[i_30 18bit] <cost: [23] adds/subtracts [38] shifts, Depth: [3]> DCT2 SIZE32: 13 -38  61 -78  88 -90  85 -73  54 -31   4  22 -46  67 -82  90; SIZE16: 25 -70  90 -80  43   9 -57  87; SIZE8: 50 -89  18  75; SIZE4: 83  36
    wire signed [IN_WIDTH + 7 : 0] i_30_4 = i_30 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_30_5 = i_30 + i_30_4;
    wire signed [IN_WIDTH + 7 : 0] i_30_8 = i_30 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_30_9 = i_30 + i_30_8;
    wire signed [IN_WIDTH + 7 : 0] i_30_32 = i_30 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_30_31 = i_30_32 - i_30;
    wire signed [IN_WIDTH + 7 : 0] i_30_16 = i_30 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_30_11 = i_30_16 - i_30_5;
    wire signed [IN_WIDTH + 7 : 0] i_30_13 = i_30_5 + i_30_8;
    wire signed [IN_WIDTH + 7 : 0] i_30_20 = i_30_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_30_19 = i_30_20 - i_30;
    wire signed [IN_WIDTH + 7 : 0] i_30_23 = i_30_32 - i_30_9;
    wire signed [IN_WIDTH + 7 : 0] i_30_25 = i_30_9 + i_30_16;
    wire signed [IN_WIDTH + 7 : 0] i_30_27 = i_30_32 - i_30_5;
    wire signed [IN_WIDTH + 7 : 0] i_30_36 = i_30_9 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_30_35 = i_30_36 - i_30;
    wire signed [IN_WIDTH + 7 : 0] i_30_40 = i_30_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_30_39 = i_30_40 - i_30;
    wire signed [IN_WIDTH + 7 : 0] i_30_41 = i_30 + i_30_40;
    wire signed [IN_WIDTH + 7 : 0] i_30_45 = i_30_5 + i_30_40;
    wire signed [IN_WIDTH + 7 : 0] i_30_62 = i_30_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_30_57 = i_30_62 - i_30_5;
    wire signed [IN_WIDTH + 7 : 0] i_30_61 = i_30_62 - i_30;
    wire signed [IN_WIDTH + 7 : 0] i_30_72 = i_30_9 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_30_67 = i_30_72 - i_30_5;
    wire signed [IN_WIDTH + 7 : 0] i_30_64 = i_30 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_30_73 = i_30_9 + i_30_64;
    wire signed [IN_WIDTH + 7 : 0] i_30_80 = i_30_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_30_75 = i_30_80 - i_30_5;
    wire signed [IN_WIDTH + 7 : 0] i_30_85 = i_30_5 + i_30_80;
    wire signed [IN_WIDTH + 7 : 0] i_30_89 = i_30_9 + i_30_80;
    wire signed [IN_WIDTH + 7 : 0] i_30_43 = i_30_11 + i_30_32;
    wire signed [IN_WIDTH + 7 : 0] i_30_83 = i_30_19 + i_30_64;
    wire signed [IN_WIDTH + 7 : 0] i_30_88 = i_30_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_30_87 = i_30_88 - i_30;
    wire signed [IN_WIDTH + 7 : 0] i_30_78 = i_30_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_30_90 = i_30_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_30_54 = i_30_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_30_82 = i_30_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_30_38 = i_30_19 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_30_22 = i_30_11 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_30_46 = i_30_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_30_70 = i_30_35 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_30_50 = i_30_25 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_30_18 = i_30_9 <<< 1;
//[i_31 18bit] <cost: [23] adds/subtracts [38] shifts, Depth: [3]> DCT2 SIZE32:  4 -13  22 -31  38 -46  54 -61  67 -73  78 -82  85 -88  90 -90; SIZE16:  9 -25  43 -57  70 -80  87 -90; SIZE8: 18 -50  75 -89; SIZE4: 36 -83
    wire signed [IN_WIDTH + 7 : 0] i_31_4 = i_31 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_31_5 = i_31 + i_31_4;
    wire signed [IN_WIDTH + 7 : 0] i_31_8 = i_31 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_31_9 = i_31 + i_31_8;
    wire signed [IN_WIDTH + 7 : 0] i_31_32 = i_31 <<< 5;
    wire signed [IN_WIDTH + 7 : 0] i_31_31 = i_31_32 - i_31;
    wire signed [IN_WIDTH + 7 : 0] i_31_16 = i_31 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_31_11 = i_31_16 - i_31_5;
    wire signed [IN_WIDTH + 7 : 0] i_31_13 = i_31_5 + i_31_8;
    wire signed [IN_WIDTH + 7 : 0] i_31_20 = i_31_5 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_31_19 = i_31_20 - i_31;
    wire signed [IN_WIDTH + 7 : 0] i_31_23 = i_31_32 - i_31_9;
    wire signed [IN_WIDTH + 7 : 0] i_31_25 = i_31_9 + i_31_16;
    wire signed [IN_WIDTH + 7 : 0] i_31_27 = i_31_32 - i_31_5;
    wire signed [IN_WIDTH + 7 : 0] i_31_36 = i_31_9 <<< 2;
    wire signed [IN_WIDTH + 7 : 0] i_31_35 = i_31_36 - i_31;
    wire signed [IN_WIDTH + 7 : 0] i_31_40 = i_31_5 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_31_39 = i_31_40 - i_31;
    wire signed [IN_WIDTH + 7 : 0] i_31_41 = i_31 + i_31_40;
    wire signed [IN_WIDTH + 7 : 0] i_31_45 = i_31_5 + i_31_40;
    wire signed [IN_WIDTH + 7 : 0] i_31_62 = i_31_31 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_31_57 = i_31_62 - i_31_5;
    wire signed [IN_WIDTH + 7 : 0] i_31_61 = i_31_62 - i_31;
    wire signed [IN_WIDTH + 7 : 0] i_31_72 = i_31_9 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_31_67 = i_31_72 - i_31_5;
    wire signed [IN_WIDTH + 7 : 0] i_31_64 = i_31 <<< 6;
    wire signed [IN_WIDTH + 7 : 0] i_31_73 = i_31_9 + i_31_64;
    wire signed [IN_WIDTH + 7 : 0] i_31_80 = i_31_5 <<< 4;
    wire signed [IN_WIDTH + 7 : 0] i_31_75 = i_31_80 - i_31_5;
    wire signed [IN_WIDTH + 7 : 0] i_31_85 = i_31_5 + i_31_80;
    wire signed [IN_WIDTH + 7 : 0] i_31_89 = i_31_9 + i_31_80;
    wire signed [IN_WIDTH + 7 : 0] i_31_43 = i_31_11 + i_31_32;
    wire signed [IN_WIDTH + 7 : 0] i_31_83 = i_31_19 + i_31_64;
    wire signed [IN_WIDTH + 7 : 0] i_31_88 = i_31_11 <<< 3;
    wire signed [IN_WIDTH + 7 : 0] i_31_87 = i_31_88 - i_31;
    wire signed [IN_WIDTH + 7 : 0] i_31_78 = i_31_39 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_31_90 = i_31_45 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_31_54 = i_31_27 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_31_82 = i_31_41 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_31_38 = i_31_19 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_31_22 = i_31_11 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_31_46 = i_31_23 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_31_70 = i_31_35 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_31_50 = i_31_25 <<< 1;
    wire signed [IN_WIDTH + 7 : 0] i_31_18 = i_31_9 <<< 1;
//DCT2 SIZE64, DST7/DCT8
//[i_32 17bit] <cost: [31] adds/subtracts [72] shifts, Depth: [2]> DCT2 SIZE64: 91  90  90  90  88  87  86  84  83  81  79  77  73  71  69  65; DST7/DCT8 SIZE32: 4   13  21  30  38  46  53  60  66  72  77  80  84  86  88  90; SIZE16:  8  25  40  55  68  77  85  88  88  87  81  73  62  48  33  17; SIZE8: 17  46  71  85  86  78  60  32; SIZE4: 29  74  84  55;
    wire signed [IN_WIDTH + 6 : 0] i_32_4 = i_32 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_32_3 = i_32_4 - i_32;
    wire signed [IN_WIDTH + 6 : 0] i_32_5 = i_32 + i_32_4;
    wire signed [IN_WIDTH + 6 : 0] i_32_8 = i_32 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_32_9 = i_32 + i_32_8;
    wire signed [IN_WIDTH + 6 : 0] i_32_16 = i_32 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_32_15 = i_32_16 - i_32;
    wire signed [IN_WIDTH + 6 : 0] i_32_17 = i_32 + i_32_16;
    wire signed [IN_WIDTH + 6 : 0] i_32_32 = i_32 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_32_31 = i_32_32 - i_32;
    wire signed [IN_WIDTH + 6 : 0] i_32_33 = i_32 + i_32_32;
    wire signed [IN_WIDTH + 6 : 0] i_32_64 = i_32 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_32_65 = i_32 + i_32_64;
    wire signed [IN_WIDTH + 6 : 0] i_32_11 = i_32_3 + i_32_8;
    wire signed [IN_WIDTH + 6 : 0] i_32_13 = i_32_16 - i_32_3;
    wire signed [IN_WIDTH + 6 : 0] i_32_19 = i_32_3 + i_32_16;
    wire signed [IN_WIDTH + 6 : 0] i_32_21 = i_32_5 + i_32_16;
    wire signed [IN_WIDTH + 6 : 0] i_32_24 = i_32_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_32_23 = i_32_24 - i_32;
    wire signed [IN_WIDTH + 6 : 0] i_32_25 = i_32 + i_32_24;
    wire signed [IN_WIDTH + 6 : 0] i_32_29 = i_32_32 - i_32_3;
    wire signed [IN_WIDTH + 6 : 0] i_32_37 = i_32_5 + i_32_32;
    wire signed [IN_WIDTH + 6 : 0] i_32_40 = i_32_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_32_39 = i_32_40 - i_32;
    wire signed [IN_WIDTH + 6 : 0] i_32_48 = i_32_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_32_43 = i_32_48 - i_32_5;
    wire signed [IN_WIDTH + 6 : 0] i_32_45 = i_32_48 - i_32_3;
    wire signed [IN_WIDTH + 6 : 0] i_32_53 = i_32_5 + i_32_48;
    wire signed [IN_WIDTH + 6 : 0] i_32_55 = i_32_64 - i_32_9;
    wire signed [IN_WIDTH + 6 : 0] i_32_69 = i_32_5 + i_32_64;
    wire signed [IN_WIDTH + 6 : 0] i_32_72 = i_32_9 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_32_71 = i_32_72 - i_32;
    wire signed [IN_WIDTH + 6 : 0] i_32_73 = i_32_9 + i_32_64;
    wire signed [IN_WIDTH + 6 : 0] i_32_80 = i_32_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_32_77 = i_32_80 - i_32_3;
    wire signed [IN_WIDTH + 6 : 0] i_32_79 = i_32_80 - i_32;
    wire signed [IN_WIDTH + 6 : 0] i_32_81 = i_32 + i_32_80;
    wire signed [IN_WIDTH + 6 : 0] i_32_83 = i_32_3 + i_32_80;
    wire signed [IN_WIDTH + 6 : 0] i_32_85 = i_32_5 + i_32_80;
    wire signed [IN_WIDTH + 6 : 0] i_32_96 = i_32_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_32_87 = i_32_96 - i_32_9;
    wire signed [IN_WIDTH + 6 : 0] i_32_91 = i_32_96 - i_32_5;
    wire signed [IN_WIDTH + 6 : 0] i_32_90 = i_32_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_32_88 = i_32_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_32_86 = i_32_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_32_84 = i_32_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_32_30 = i_32_15 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_32_38 = i_32_19 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_32_46 = i_32_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_32_60 = i_32_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_32_66 = i_32_33 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_32_68 = i_32_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_32_62 = i_32_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_32_78 = i_32_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_32_74 = i_32_37 <<< 1;
//[i_33 17bit] <cost: [29] adds/subtracts [59] shifts, Depth: [2]> DCT2 SIZE64: 90  88  84  79  71  62  52  41  28  15   2 -11 -24 -37 -48 -59; DST7/DCT8 SIZE32: 9   26  42  56  68  78  85  89  90  86  80  72  60  46  30  13; SIZE16: 17  48  73  87  88  77  55  25  -8 -40 -68 -85 -88 -81 -62 -33; SIZE8: 32  78  85  46 -17 -71 -86 -60; SIZE4: 55  74 -29 -84;
    wire signed [IN_WIDTH + 6 : 0] i_33_4 = i_33 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_33_3 = i_33_4 - i_33;
    wire signed [IN_WIDTH + 6 : 0] i_33_5 = i_33 + i_33_4;
    wire signed [IN_WIDTH + 6 : 0] i_33_8 = i_33 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_33_7 = i_33_8 - i_33;
    wire signed [IN_WIDTH + 6 : 0] i_33_9 = i_33 + i_33_8;
    wire signed [IN_WIDTH + 6 : 0] i_33_16 = i_33 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_33_15 = i_33_16 - i_33;
    wire signed [IN_WIDTH + 6 : 0] i_33_17 = i_33 + i_33_16;
    wire signed [IN_WIDTH + 6 : 0] i_33_32 = i_33 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_33_31 = i_33_32 - i_33;
    wire signed [IN_WIDTH + 6 : 0] i_33_33 = i_33 + i_33_32;
    wire signed [IN_WIDTH + 6 : 0] i_33_11 = i_33_3 + i_33_8;
    wire signed [IN_WIDTH + 6 : 0] i_33_13 = i_33_16 - i_33_3;
    wire signed [IN_WIDTH + 6 : 0] i_33_21 = i_33_5 + i_33_16;
    wire signed [IN_WIDTH + 6 : 0] i_33_24 = i_33_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_33_23 = i_33_24 - i_33;
    wire signed [IN_WIDTH + 6 : 0] i_33_25 = i_33 + i_33_24;
    wire signed [IN_WIDTH + 6 : 0] i_33_29 = i_33_32 - i_33_3;
    wire signed [IN_WIDTH + 6 : 0] i_33_37 = i_33_5 + i_33_32;
    wire signed [IN_WIDTH + 6 : 0] i_33_40 = i_33_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_33_39 = i_33_40 - i_33;
    wire signed [IN_WIDTH + 6 : 0] i_33_41 = i_33 + i_33_40;
    wire signed [IN_WIDTH + 6 : 0] i_33_48 = i_33_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_33_43 = i_33_48 - i_33_5;
    wire signed [IN_WIDTH + 6 : 0] i_33_45 = i_33_48 - i_33_3;
    wire signed [IN_WIDTH + 6 : 0] i_33_56 = i_33_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_33_55 = i_33_56 - i_33;
    wire signed [IN_WIDTH + 6 : 0] i_33_64 = i_33 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_33_59 = i_33_64 - i_33_5;
    wire signed [IN_WIDTH + 6 : 0] i_33_71 = i_33_7 + i_33_64;
    wire signed [IN_WIDTH + 6 : 0] i_33_73 = i_33_9 + i_33_64;
    wire signed [IN_WIDTH + 6 : 0] i_33_80 = i_33_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_33_77 = i_33_80 - i_33_3;
    wire signed [IN_WIDTH + 6 : 0] i_33_79 = i_33_80 - i_33;
    wire signed [IN_WIDTH + 6 : 0] i_33_81 = i_33 + i_33_80;
    wire signed [IN_WIDTH + 6 : 0] i_33_85 = i_33_5 + i_33_80;
    wire signed [IN_WIDTH + 6 : 0] i_33_96 = i_33_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_33_87 = i_33_96 - i_33_9;
    wire signed [IN_WIDTH + 6 : 0] i_33_89 = i_33_96 - i_33_7;
    wire signed [IN_WIDTH + 6 : 0] i_33_90 = i_33_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_33_88 = i_33_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_33_84 = i_33_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_33_62 = i_33_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_33_52 = i_33_13 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_33_28 = i_33_7 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_33_2 = i_33 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_33_26 = i_33_13 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_33_42 = i_33_21 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_33_68 = i_33_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_33_78 = i_33_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_33_86 = i_33_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_33_72 = i_33_9 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_33_60 = i_33_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_33_46 = i_33_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_33_30 = i_33_15 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_33_74 = i_33_37 <<< 1;
//[i_34 17bit] <cost: [27] adds/subtracts [58] shifts, Depth: [2]> DCT2 SIZE64: 90  84  73  59  41  20  -2 -24 -44 -62 -77 -86 -90 -90 -83 -71; DST7/DCT8 SIZE32: 13  38  60  77  86  90  85  74  56  34   9 -17 -42 -63 -78 -87; SIZE16: 25  68  88  81  48   0 -48 -81 -88 -68 -25  25  68  88  81  48; SIZE8: 46  86  32 -60 -85 -17  71  78; SIZE4: 74   0 -74  74;
    wire signed [IN_WIDTH + 6 : 0] i_34_4 = i_34 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_34_3 = i_34_4 - i_34;
    wire signed [IN_WIDTH + 6 : 0] i_34_5 = i_34 + i_34_4;
    wire signed [IN_WIDTH + 6 : 0] i_34_8 = i_34 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_34_7 = i_34_8 - i_34;
    wire signed [IN_WIDTH + 6 : 0] i_34_9 = i_34 + i_34_8;
    wire signed [IN_WIDTH + 6 : 0] i_34_16 = i_34 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_34_15 = i_34_16 - i_34;
    wire signed [IN_WIDTH + 6 : 0] i_34_17 = i_34 + i_34_16;
    wire signed [IN_WIDTH + 6 : 0] i_34_32 = i_34 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_34_31 = i_34_32 - i_34;
    wire signed [IN_WIDTH + 6 : 0] i_34_64 = i_34 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_34_63 = i_34_64 - i_34;
    wire signed [IN_WIDTH + 6 : 0] i_34_11 = i_34_3 + i_34_8;
    wire signed [IN_WIDTH + 6 : 0] i_34_13 = i_34_16 - i_34_3;
    wire signed [IN_WIDTH + 6 : 0] i_34_19 = i_34_3 + i_34_16;
    wire signed [IN_WIDTH + 6 : 0] i_34_21 = i_34_5 + i_34_16;
    wire signed [IN_WIDTH + 6 : 0] i_34_24 = i_34_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_34_23 = i_34_24 - i_34;
    wire signed [IN_WIDTH + 6 : 0] i_34_25 = i_34 + i_34_24;
    wire signed [IN_WIDTH + 6 : 0] i_34_37 = i_34_5 + i_34_32;
    wire signed [IN_WIDTH + 6 : 0] i_34_40 = i_34_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_34_39 = i_34_40 - i_34;
    wire signed [IN_WIDTH + 6 : 0] i_34_41 = i_34 + i_34_40;
    wire signed [IN_WIDTH + 6 : 0] i_34_48 = i_34_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_34_43 = i_34_48 - i_34_5;
    wire signed [IN_WIDTH + 6 : 0] i_34_45 = i_34_48 - i_34_3;
    wire signed [IN_WIDTH + 6 : 0] i_34_59 = i_34_64 - i_34_5;
    wire signed [IN_WIDTH + 6 : 0] i_34_71 = i_34_7 + i_34_64;
    wire signed [IN_WIDTH + 6 : 0] i_34_73 = i_34_9 + i_34_64;
    wire signed [IN_WIDTH + 6 : 0] i_34_80 = i_34_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_34_77 = i_34_80 - i_34_3;
    wire signed [IN_WIDTH + 6 : 0] i_34_81 = i_34 + i_34_80;
    wire signed [IN_WIDTH + 6 : 0] i_34_83 = i_34_3 + i_34_80;
    wire signed [IN_WIDTH + 6 : 0] i_34_85 = i_34_5 + i_34_80;
    wire signed [IN_WIDTH + 6 : 0] i_34_96 = i_34_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_34_87 = i_34_96 - i_34_9;
    wire signed [IN_WIDTH + 6 : 0] i_34_90 = i_34_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_34_84 = i_34_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_34_20 = i_34_5 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_34_2 = i_34 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_34_44 = i_34_11 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_34_62 = i_34_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_34_86 = i_34_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_34_38 = i_34_19 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_34_60 = i_34_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_34_74 = i_34_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_34_56 = i_34_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_34_34 = i_34_17 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_34_42 = i_34_21 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_34_78 = i_34_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_34_68 = i_34_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_34_88 = i_34_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_34_46 = i_34_23 <<< 1;
//[i_35 17bit] <cost: [29] adds/subtracts [63] shifts, Depth: [2]> DCT2 SIZE64: 90  79  59  33   2 -28 -56 -77 -88 -90 -81 -62 -37  -7  24  52; DST7/DCT8 SIZE32: 17  50  74  87  88  77  53  21 -13 -46 -72 -86 -89 -78 -56 -26; SIZE16: 33  81  85  40 -25 -77 -87 -48  17  73  88  55  -8 -68 -88 -62; SIZE8: 60  71 -46 -78  32  85 -17 -86; SIZE4: 84 -74  55 -29;
    wire signed [IN_WIDTH + 6 : 0] i_35_4 = i_35 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_35_3 = i_35_4 - i_35;
    wire signed [IN_WIDTH + 6 : 0] i_35_5 = i_35 + i_35_4;
    wire signed [IN_WIDTH + 6 : 0] i_35_8 = i_35 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_35_7 = i_35_8 - i_35;
    wire signed [IN_WIDTH + 6 : 0] i_35_9 = i_35 + i_35_8;
    wire signed [IN_WIDTH + 6 : 0] i_35_16 = i_35 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_35_15 = i_35_16 - i_35;
    wire signed [IN_WIDTH + 6 : 0] i_35_17 = i_35 + i_35_16;
    wire signed [IN_WIDTH + 6 : 0] i_35_32 = i_35 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_35_31 = i_35_32 - i_35;
    wire signed [IN_WIDTH + 6 : 0] i_35_33 = i_35 + i_35_32;
    wire signed [IN_WIDTH + 6 : 0] i_35_11 = i_35_3 + i_35_8;
    wire signed [IN_WIDTH + 6 : 0] i_35_13 = i_35_16 - i_35_3;
    wire signed [IN_WIDTH + 6 : 0] i_35_21 = i_35_5 + i_35_16;
    wire signed [IN_WIDTH + 6 : 0] i_35_24 = i_35_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_35_23 = i_35_24 - i_35;
    wire signed [IN_WIDTH + 6 : 0] i_35_25 = i_35 + i_35_24;
    wire signed [IN_WIDTH + 6 : 0] i_35_29 = i_35_32 - i_35_3;
    wire signed [IN_WIDTH + 6 : 0] i_35_37 = i_35_5 + i_35_32;
    wire signed [IN_WIDTH + 6 : 0] i_35_40 = i_35_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_35_39 = i_35_40 - i_35;
    wire signed [IN_WIDTH + 6 : 0] i_35_48 = i_35_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_35_43 = i_35_48 - i_35_5;
    wire signed [IN_WIDTH + 6 : 0] i_35_45 = i_35_48 - i_35_3;
    wire signed [IN_WIDTH + 6 : 0] i_35_53 = i_35_5 + i_35_48;
    wire signed [IN_WIDTH + 6 : 0] i_35_56 = i_35_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_35_55 = i_35_56 - i_35;
    wire signed [IN_WIDTH + 6 : 0] i_35_64 = i_35 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_35_59 = i_35_64 - i_35_5;
    wire signed [IN_WIDTH + 6 : 0] i_35_71 = i_35_7 + i_35_64;
    wire signed [IN_WIDTH + 6 : 0] i_35_73 = i_35_9 + i_35_64;
    wire signed [IN_WIDTH + 6 : 0] i_35_80 = i_35_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_35_77 = i_35_80 - i_35_3;
    wire signed [IN_WIDTH + 6 : 0] i_35_79 = i_35_80 - i_35;
    wire signed [IN_WIDTH + 6 : 0] i_35_81 = i_35 + i_35_80;
    wire signed [IN_WIDTH + 6 : 0] i_35_85 = i_35_5 + i_35_80;
    wire signed [IN_WIDTH + 6 : 0] i_35_96 = i_35_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_35_87 = i_35_96 - i_35_9;
    wire signed [IN_WIDTH + 6 : 0] i_35_89 = i_35_96 - i_35_7;
    wire signed [IN_WIDTH + 6 : 0] i_35_90 = i_35_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_35_2 = i_35 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_35_28 = i_35_7 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_35_88 = i_35_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_35_62 = i_35_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_35_52 = i_35_13 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_35_50 = i_35_25 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_35_74 = i_35_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_35_46 = i_35_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_35_72 = i_35_9 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_35_86 = i_35_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_35_78 = i_35_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_35_26 = i_35_13 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_35_68 = i_35_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_35_60 = i_35_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_35_84 = i_35_21 <<< 2;
//[i_36 17bit] <cost: [27] adds/subtracts [54] shifts, Depth: [2]> DCT2 SIZE64: 88  71  41   2 -37 -69 -87 -90 -73 -44  -7  33  65  86  90  77; DST7/DCT8 SIZE32: 21  60  84  89  74  42   0 -42 -74 -89 -84 -60 -21  21  60  84; SIZE16: 40  88  62 -17 -81 -77  -8  68  87  33 -48 -88 -55  25  85  73; SIZE8: 71  32 -86  17  78 -60 -46  85; SIZE4: 29  74  84  55;
    wire signed [IN_WIDTH + 6 : 0] i_36_4 = i_36 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_36_3 = i_36_4 - i_36;
    wire signed [IN_WIDTH + 6 : 0] i_36_5 = i_36 + i_36_4;
    wire signed [IN_WIDTH + 6 : 0] i_36_8 = i_36 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_36_7 = i_36_8 - i_36;
    wire signed [IN_WIDTH + 6 : 0] i_36_16 = i_36 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_36_15 = i_36_16 - i_36;
    wire signed [IN_WIDTH + 6 : 0] i_36_17 = i_36 + i_36_16;
    wire signed [IN_WIDTH + 6 : 0] i_36_32 = i_36 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_36_31 = i_36_32 - i_36;
    wire signed [IN_WIDTH + 6 : 0] i_36_33 = i_36 + i_36_32;
    wire signed [IN_WIDTH + 6 : 0] i_36_64 = i_36 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_36_65 = i_36 + i_36_64;
    wire signed [IN_WIDTH + 6 : 0] i_36_11 = i_36_3 + i_36_8;
    wire signed [IN_WIDTH + 6 : 0] i_36_21 = i_36_5 + i_36_16;
    wire signed [IN_WIDTH + 6 : 0] i_36_24 = i_36_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_36_23 = i_36_24 - i_36;
    wire signed [IN_WIDTH + 6 : 0] i_36_25 = i_36 + i_36_24;
    wire signed [IN_WIDTH + 6 : 0] i_36_29 = i_36_32 - i_36_3;
    wire signed [IN_WIDTH + 6 : 0] i_36_37 = i_36_5 + i_36_32;
    wire signed [IN_WIDTH + 6 : 0] i_36_40 = i_36_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_36_39 = i_36_40 - i_36;
    wire signed [IN_WIDTH + 6 : 0] i_36_41 = i_36 + i_36_40;
    wire signed [IN_WIDTH + 6 : 0] i_36_48 = i_36_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_36_43 = i_36_48 - i_36_5;
    wire signed [IN_WIDTH + 6 : 0] i_36_45 = i_36_48 - i_36_3;
    wire signed [IN_WIDTH + 6 : 0] i_36_56 = i_36_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_36_55 = i_36_56 - i_36;
    wire signed [IN_WIDTH + 6 : 0] i_36_69 = i_36_5 + i_36_64;
    wire signed [IN_WIDTH + 6 : 0] i_36_71 = i_36_7 + i_36_64;
    wire signed [IN_WIDTH + 6 : 0] i_36_73 = i_36_65 + i_36_8;
    wire signed [IN_WIDTH + 6 : 0] i_36_80 = i_36_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_36_77 = i_36_80 - i_36_3;
    wire signed [IN_WIDTH + 6 : 0] i_36_81 = i_36 + i_36_80;
    wire signed [IN_WIDTH + 6 : 0] i_36_85 = i_36_5 + i_36_80;
    wire signed [IN_WIDTH + 6 : 0] i_36_87 = i_36_7 + i_36_80;
    wire signed [IN_WIDTH + 6 : 0] i_36_96 = i_36_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_36_89 = i_36_96 - i_36_7;
    wire signed [IN_WIDTH + 6 : 0] i_36_88 = i_36_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_36_2 = i_36 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_36_90 = i_36_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_36_44 = i_36_11 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_36_86 = i_36_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_36_60 = i_36_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_36_84 = i_36_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_36_74 = i_36_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_36_42 = i_36_21 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_36_62 = i_36_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_36_68 = i_36_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_36_78 = i_36_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_36_46 = i_36_23 <<< 1;
//[i_37 17bit] <cost: [28] adds/subtracts [63] shifts, Depth: [2]> DCT2 SIZE64: 87  62  20 -28 -69 -90 -84 -56 -11  37  73  90  81  48   2 -44; DST7/DCT8 SIZE32: 26  68  89  80  46  -4 -53 -84 -87 -63 -17  34  74  90  77  38; SIZE16: 48  88  25 -68 -81   0  81  68 -25 -88 -48  48  88  25 -68 -81; SIZE8: 78 -17 -60  86 -46 -32  85 -71; SIZE4: 55  74 -29 -84;
    wire signed [IN_WIDTH + 6 : 0] i_37_4 = i_37 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_37_3 = i_37_4 - i_37;
    wire signed [IN_WIDTH + 6 : 0] i_37_5 = i_37 + i_37_4;
    wire signed [IN_WIDTH + 6 : 0] i_37_8 = i_37 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_37_7 = i_37_8 - i_37;
    wire signed [IN_WIDTH + 6 : 0] i_37_16 = i_37 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_37_15 = i_37_16 - i_37;
    wire signed [IN_WIDTH + 6 : 0] i_37_17 = i_37 + i_37_16;
    wire signed [IN_WIDTH + 6 : 0] i_37_32 = i_37 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_37_31 = i_37_32 - i_37;
    wire signed [IN_WIDTH + 6 : 0] i_37_64 = i_37 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_37_63 = i_37_64 - i_37;
    wire signed [IN_WIDTH + 6 : 0] i_37_11 = i_37_3 + i_37_8;
    wire signed [IN_WIDTH + 6 : 0] i_37_13 = i_37_16 - i_37_3;
    wire signed [IN_WIDTH + 6 : 0] i_37_19 = i_37_3 + i_37_16;
    wire signed [IN_WIDTH + 6 : 0] i_37_21 = i_37_5 + i_37_16;
    wire signed [IN_WIDTH + 6 : 0] i_37_24 = i_37_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_37_23 = i_37_24 - i_37;
    wire signed [IN_WIDTH + 6 : 0] i_37_25 = i_37 + i_37_24;
    wire signed [IN_WIDTH + 6 : 0] i_37_29 = i_37_32 - i_37_3;
    wire signed [IN_WIDTH + 6 : 0] i_37_37 = i_37_5 + i_37_32;
    wire signed [IN_WIDTH + 6 : 0] i_37_40 = i_37_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_37_39 = i_37_40 - i_37;
    wire signed [IN_WIDTH + 6 : 0] i_37_48 = i_37_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_37_43 = i_37_48 - i_37_5;
    wire signed [IN_WIDTH + 6 : 0] i_37_45 = i_37_48 - i_37_3;
    wire signed [IN_WIDTH + 6 : 0] i_37_53 = i_37_5 + i_37_48;
    wire signed [IN_WIDTH + 6 : 0] i_37_56 = i_37_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_37_55 = i_37_56 - i_37;
    wire signed [IN_WIDTH + 6 : 0] i_37_69 = i_37_5 + i_37_64;
    wire signed [IN_WIDTH + 6 : 0] i_37_71 = i_37_7 + i_37_64;
    wire signed [IN_WIDTH + 6 : 0] i_37_80 = i_37_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_37_73 = i_37_80 - i_37_7;
    wire signed [IN_WIDTH + 6 : 0] i_37_77 = i_37_80 - i_37_3;
    wire signed [IN_WIDTH + 6 : 0] i_37_81 = i_37 + i_37_80;
    wire signed [IN_WIDTH + 6 : 0] i_37_85 = i_37_5 + i_37_80;
    wire signed [IN_WIDTH + 6 : 0] i_37_87 = i_37_63 + i_37_24;
    wire signed [IN_WIDTH + 6 : 0] i_37_96 = i_37_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_37_89 = i_37_96 - i_37_7;
    wire signed [IN_WIDTH + 6 : 0] i_37_62 = i_37_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_37_20 = i_37_5 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_37_28 = i_37_7 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_37_90 = i_37_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_37_84 = i_37_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_37_2 = i_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_37_44 = i_37_11 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_37_26 = i_37_13 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_37_68 = i_37_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_37_46 = i_37_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_37_34 = i_37_17 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_37_74 = i_37_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_37_38 = i_37_19 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_37_88 = i_37_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_37_78 = i_37_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_37_60 = i_37_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_37_86 = i_37_43 <<< 1;
//[i_38 17bit] <cost: [28] adds/subtracts [59] shifts, Depth: [2]> DCT2 SIZE64: 86  52  -2 -56 -87 -84 -48   7  59  88  83  44 -11 -62 -90 -81; DST7/DCT8 SIZE32: 30  77  89  63   9 -50 -85 -84 -46  13  66  90  74  26 -34 -78; SIZE16: 55  81 -17 -88 -25  77  62 -48 -85   8  88  33 -73 -68  40  87; SIZE8: 85 -60  17  32 -71  86 -78  46; SIZE4: 74   0 -74  74;
    wire signed [IN_WIDTH + 6 : 0] i_38_4 = i_38 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_38_3 = i_38_4 - i_38;
    wire signed [IN_WIDTH + 6 : 0] i_38_5 = i_38 + i_38_4;
    wire signed [IN_WIDTH + 6 : 0] i_38_8 = i_38 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_38_7 = i_38_8 - i_38;
    wire signed [IN_WIDTH + 6 : 0] i_38_9 = i_38 + i_38_8;
    wire signed [IN_WIDTH + 6 : 0] i_38_16 = i_38 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_38_15 = i_38_16 - i_38;
    wire signed [IN_WIDTH + 6 : 0] i_38_17 = i_38 + i_38_16;
    wire signed [IN_WIDTH + 6 : 0] i_38_32 = i_38 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_38_31 = i_38_32 - i_38;
    wire signed [IN_WIDTH + 6 : 0] i_38_33 = i_38 + i_38_32;
    wire signed [IN_WIDTH + 6 : 0] i_38_64 = i_38 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_38_63 = i_38_64 - i_38;
    wire signed [IN_WIDTH + 6 : 0] i_38_11 = i_38_3 + i_38_8;
    wire signed [IN_WIDTH + 6 : 0] i_38_13 = i_38_16 - i_38_3;
    wire signed [IN_WIDTH + 6 : 0] i_38_21 = i_38_5 + i_38_16;
    wire signed [IN_WIDTH + 6 : 0] i_38_24 = i_38_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_38_23 = i_38_24 - i_38;
    wire signed [IN_WIDTH + 6 : 0] i_38_25 = i_38 + i_38_24;
    wire signed [IN_WIDTH + 6 : 0] i_38_37 = i_38_5 + i_38_32;
    wire signed [IN_WIDTH + 6 : 0] i_38_40 = i_38_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_38_39 = i_38_40 - i_38;
    wire signed [IN_WIDTH + 6 : 0] i_38_48 = i_38_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_38_43 = i_38_48 - i_38_5;
    wire signed [IN_WIDTH + 6 : 0] i_38_45 = i_38_48 - i_38_3;
    wire signed [IN_WIDTH + 6 : 0] i_38_56 = i_38_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_38_55 = i_38_56 - i_38;
    wire signed [IN_WIDTH + 6 : 0] i_38_59 = i_38_64 - i_38_5;
    wire signed [IN_WIDTH + 6 : 0] i_38_71 = i_38_7 + i_38_64;
    wire signed [IN_WIDTH + 6 : 0] i_38_73 = i_38_9 + i_38_64;
    wire signed [IN_WIDTH + 6 : 0] i_38_80 = i_38_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_38_77 = i_38_80 - i_38_3;
    wire signed [IN_WIDTH + 6 : 0] i_38_81 = i_38 + i_38_80;
    wire signed [IN_WIDTH + 6 : 0] i_38_83 = i_38_3 + i_38_80;
    wire signed [IN_WIDTH + 6 : 0] i_38_85 = i_38_5 + i_38_80;
    wire signed [IN_WIDTH + 6 : 0] i_38_96 = i_38_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_38_87 = i_38_96 - i_38_9;
    wire signed [IN_WIDTH + 6 : 0] i_38_89 = i_38_96 - i_38_7;
    wire signed [IN_WIDTH + 6 : 0] i_38_86 = i_38_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_38_52 = i_38_13 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_38_2 = i_38 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_38_84 = i_38_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_38_88 = i_38_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_38_44 = i_38_11 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_38_62 = i_38_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_38_90 = i_38_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_38_30 = i_38_15 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_38_50 = i_38_25 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_38_46 = i_38_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_38_66 = i_38_33 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_38_74 = i_38_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_38_26 = i_38_13 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_38_34 = i_38_17 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_38_78 = i_38_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_38_68 = i_38_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_38_60 = i_38_15 <<< 2;
//[i_39 17bit] <cost: [30] adds/subtracts [64] shifts, Depth: [2]> DCT2 SIZE64: 84  41 -24 -77 -90 -56   7  65  91  69  11 -52 -88 -79 -28  37; DST7/DCT8 SIZE32: 34  82  84  38 -30 -80 -85 -42  26  78  86  46 -21 -77 -87 -50; SIZE16: 62  68 -55 -73  48  77 -40 -81  33  85 -25 -87  17  88  -8 -88; SIZE8: 86 -85  78 -71  60 -46  32 -17; SIZE4: 84 -74  55 -29;
    wire signed [IN_WIDTH + 6 : 0] i_39_4 = i_39 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_39_3 = i_39_4 - i_39;
    wire signed [IN_WIDTH + 6 : 0] i_39_5 = i_39 + i_39_4;
    wire signed [IN_WIDTH + 6 : 0] i_39_8 = i_39 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_39_7 = i_39_8 - i_39;
    wire signed [IN_WIDTH + 6 : 0] i_39_16 = i_39 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_39_15 = i_39_16 - i_39;
    wire signed [IN_WIDTH + 6 : 0] i_39_17 = i_39 + i_39_16;
    wire signed [IN_WIDTH + 6 : 0] i_39_32 = i_39 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_39_31 = i_39_32 - i_39;
    wire signed [IN_WIDTH + 6 : 0] i_39_33 = i_39 + i_39_32;
    wire signed [IN_WIDTH + 6 : 0] i_39_64 = i_39 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_39_65 = i_39 + i_39_64;
    wire signed [IN_WIDTH + 6 : 0] i_39_11 = i_39_3 + i_39_8;
    wire signed [IN_WIDTH + 6 : 0] i_39_13 = i_39_16 - i_39_3;
    wire signed [IN_WIDTH + 6 : 0] i_39_19 = i_39_3 + i_39_16;
    wire signed [IN_WIDTH + 6 : 0] i_39_21 = i_39_5 + i_39_16;
    wire signed [IN_WIDTH + 6 : 0] i_39_24 = i_39_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_39_23 = i_39_24 - i_39;
    wire signed [IN_WIDTH + 6 : 0] i_39_25 = i_39 + i_39_24;
    wire signed [IN_WIDTH + 6 : 0] i_39_29 = i_39_32 - i_39_3;
    wire signed [IN_WIDTH + 6 : 0] i_39_37 = i_39_5 + i_39_32;
    wire signed [IN_WIDTH + 6 : 0] i_39_40 = i_39_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_39_39 = i_39_40 - i_39;
    wire signed [IN_WIDTH + 6 : 0] i_39_41 = i_39 + i_39_40;
    wire signed [IN_WIDTH + 6 : 0] i_39_48 = i_39_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_39_43 = i_39_48 - i_39_5;
    wire signed [IN_WIDTH + 6 : 0] i_39_45 = i_39_48 - i_39_3;
    wire signed [IN_WIDTH + 6 : 0] i_39_56 = i_39_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_39_55 = i_39_56 - i_39;
    wire signed [IN_WIDTH + 6 : 0] i_39_69 = i_39_5 + i_39_64;
    wire signed [IN_WIDTH + 6 : 0] i_39_71 = i_39_7 + i_39_64;
    wire signed [IN_WIDTH + 6 : 0] i_39_73 = i_39_65 + i_39_8;
    wire signed [IN_WIDTH + 6 : 0] i_39_80 = i_39_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_39_77 = i_39_80 - i_39_3;
    wire signed [IN_WIDTH + 6 : 0] i_39_79 = i_39_80 - i_39;
    wire signed [IN_WIDTH + 6 : 0] i_39_81 = i_39 + i_39_80;
    wire signed [IN_WIDTH + 6 : 0] i_39_85 = i_39_5 + i_39_80;
    wire signed [IN_WIDTH + 6 : 0] i_39_87 = i_39_7 + i_39_80;
    wire signed [IN_WIDTH + 6 : 0] i_39_96 = i_39_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_39_91 = i_39_96 - i_39_5;
    wire signed [IN_WIDTH + 6 : 0] i_39_84 = i_39_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_39_90 = i_39_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_39_52 = i_39_13 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_39_88 = i_39_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_39_28 = i_39_7 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_39_34 = i_39_17 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_39_82 = i_39_41 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_39_38 = i_39_19 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_39_30 = i_39_15 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_39_42 = i_39_21 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_39_26 = i_39_13 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_39_78 = i_39_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_39_86 = i_39_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_39_46 = i_39_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_39_50 = i_39_25 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_39_62 = i_39_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_39_68 = i_39_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_39_60 = i_39_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_39_74 = i_39_37 <<< 1;
//[i_40 17bit] <cost: [31] adds/subtracts [66] shifts, Depth: [2]> DCT2 SIZE64: 83  28 -44 -88 -73 -11  59  91  62  -7 -71 -90 -48  24  81  84; DST7/DCT8 SIZE32: 38  86  74   9 -63 -90 -53  21  80  82  26 -50 -89 -66   4  72; SIZE16: 68  48 -81 -25  88   0 -88  25  81 -48 -68  68  48 -81 -25  88; SIZE8: 17  46  71  85  86  78  60  32; SIZE4: 29  74  84  55;
    wire signed [IN_WIDTH + 6 : 0] i_40_4 = i_40 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_40_3 = i_40_4 - i_40;
    wire signed [IN_WIDTH + 6 : 0] i_40_5 = i_40 + i_40_4;
    wire signed [IN_WIDTH + 6 : 0] i_40_8 = i_40 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_40_7 = i_40_8 - i_40;
    wire signed [IN_WIDTH + 6 : 0] i_40_9 = i_40 + i_40_8;
    wire signed [IN_WIDTH + 6 : 0] i_40_16 = i_40 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_40_15 = i_40_16 - i_40;
    wire signed [IN_WIDTH + 6 : 0] i_40_17 = i_40 + i_40_16;
    wire signed [IN_WIDTH + 6 : 0] i_40_32 = i_40 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_40_31 = i_40_32 - i_40;
    wire signed [IN_WIDTH + 6 : 0] i_40_33 = i_40 + i_40_32;
    wire signed [IN_WIDTH + 6 : 0] i_40_64 = i_40 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_40_63 = i_40_64 - i_40;
    wire signed [IN_WIDTH + 6 : 0] i_40_11 = i_40_3 + i_40_8;
    wire signed [IN_WIDTH + 6 : 0] i_40_13 = i_40_16 - i_40_3;
    wire signed [IN_WIDTH + 6 : 0] i_40_19 = i_40_3 + i_40_16;
    wire signed [IN_WIDTH + 6 : 0] i_40_21 = i_40_5 + i_40_16;
    wire signed [IN_WIDTH + 6 : 0] i_40_24 = i_40_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_40_23 = i_40_24 - i_40;
    wire signed [IN_WIDTH + 6 : 0] i_40_25 = i_40 + i_40_24;
    wire signed [IN_WIDTH + 6 : 0] i_40_29 = i_40_32 - i_40_3;
    wire signed [IN_WIDTH + 6 : 0] i_40_37 = i_40_5 + i_40_32;
    wire signed [IN_WIDTH + 6 : 0] i_40_40 = i_40_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_40_39 = i_40_40 - i_40;
    wire signed [IN_WIDTH + 6 : 0] i_40_41 = i_40 + i_40_40;
    wire signed [IN_WIDTH + 6 : 0] i_40_48 = i_40_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_40_43 = i_40_48 - i_40_5;
    wire signed [IN_WIDTH + 6 : 0] i_40_45 = i_40_48 - i_40_3;
    wire signed [IN_WIDTH + 6 : 0] i_40_53 = i_40_5 + i_40_48;
    wire signed [IN_WIDTH + 6 : 0] i_40_56 = i_40_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_40_55 = i_40_56 - i_40;
    wire signed [IN_WIDTH + 6 : 0] i_40_59 = i_40_64 - i_40_5;
    wire signed [IN_WIDTH + 6 : 0] i_40_71 = i_40_7 + i_40_64;
    wire signed [IN_WIDTH + 6 : 0] i_40_73 = i_40_9 + i_40_64;
    wire signed [IN_WIDTH + 6 : 0] i_40_80 = i_40_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_40_81 = i_40 + i_40_80;
    wire signed [IN_WIDTH + 6 : 0] i_40_83 = i_40_3 + i_40_80;
    wire signed [IN_WIDTH + 6 : 0] i_40_85 = i_40_5 + i_40_80;
    wire signed [IN_WIDTH + 6 : 0] i_40_96 = i_40_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_40_89 = i_40_96 - i_40_7;
    wire signed [IN_WIDTH + 6 : 0] i_40_91 = i_40_96 - i_40_5;
    wire signed [IN_WIDTH + 6 : 0] i_40_28 = i_40_7 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_40_44 = i_40_11 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_40_88 = i_40_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_40_62 = i_40_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_40_90 = i_40_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_40_84 = i_40_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_40_38 = i_40_19 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_40_86 = i_40_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_40_74 = i_40_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_40_82 = i_40_41 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_40_26 = i_40_13 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_40_50 = i_40_25 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_40_66 = i_40_33 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_40_72 = i_40_9 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_40_68 = i_40_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_40_46 = i_40_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_40_78 = i_40_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_40_60 = i_40_15 <<< 2;
//[i_41 17bit] <cost: [27] adds/subtracts [60] shifts, Depth: [2]> DCT2 SIZE64: 81  15 -62 -90 -44  37  88  69  -7 -77 -84 -24  56  91  52 -28; DST7/DCT8 SIZE32: 42  89  60 -21 -84 -74   0  74  84  21 -60 -89 -42  42  89  60; SIZE16: 73  25 -88  33  68 -77 -17  88 -40 -62  81   8 -87  48  55 -85; SIZE8: 32  78  85  46 -17 -71 -86 -60; SIZE4: 55  74 -29 -84;
    wire signed [IN_WIDTH + 6 : 0] i_41_4 = i_41 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_41_3 = i_41_4 - i_41;
    wire signed [IN_WIDTH + 6 : 0] i_41_5 = i_41 + i_41_4;
    wire signed [IN_WIDTH + 6 : 0] i_41_8 = i_41 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_41_7 = i_41_8 - i_41;
    wire signed [IN_WIDTH + 6 : 0] i_41_16 = i_41 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_41_15 = i_41_16 - i_41;
    wire signed [IN_WIDTH + 6 : 0] i_41_17 = i_41 + i_41_16;
    wire signed [IN_WIDTH + 6 : 0] i_41_32 = i_41 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_41_31 = i_41_32 - i_41;
    wire signed [IN_WIDTH + 6 : 0] i_41_33 = i_41 + i_41_32;
    wire signed [IN_WIDTH + 6 : 0] i_41_11 = i_41_3 + i_41_8;
    wire signed [IN_WIDTH + 6 : 0] i_41_13 = i_41_16 - i_41_3;
    wire signed [IN_WIDTH + 6 : 0] i_41_21 = i_41_5 + i_41_16;
    wire signed [IN_WIDTH + 6 : 0] i_41_24 = i_41_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_41_23 = i_41_24 - i_41;
    wire signed [IN_WIDTH + 6 : 0] i_41_25 = i_41 + i_41_24;
    wire signed [IN_WIDTH + 6 : 0] i_41_29 = i_41_32 - i_41_3;
    wire signed [IN_WIDTH + 6 : 0] i_41_37 = i_41_5 + i_41_32;
    wire signed [IN_WIDTH + 6 : 0] i_41_40 = i_41_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_41_39 = i_41_40 - i_41;
    wire signed [IN_WIDTH + 6 : 0] i_41_48 = i_41_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_41_43 = i_41_48 - i_41_5;
    wire signed [IN_WIDTH + 6 : 0] i_41_45 = i_41_48 - i_41_3;
    wire signed [IN_WIDTH + 6 : 0] i_41_56 = i_41_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_41_55 = i_41_56 - i_41;
    wire signed [IN_WIDTH + 6 : 0] i_41_64 = i_41 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_41_69 = i_41_5 + i_41_64;
    wire signed [IN_WIDTH + 6 : 0] i_41_71 = i_41_7 + i_41_64;
    wire signed [IN_WIDTH + 6 : 0] i_41_80 = i_41_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_41_73 = i_41_80 - i_41_7;
    wire signed [IN_WIDTH + 6 : 0] i_41_77 = i_41_80 - i_41_3;
    wire signed [IN_WIDTH + 6 : 0] i_41_81 = i_41 + i_41_80;
    wire signed [IN_WIDTH + 6 : 0] i_41_85 = i_41_5 + i_41_80;
    wire signed [IN_WIDTH + 6 : 0] i_41_87 = i_41_7 + i_41_80;
    wire signed [IN_WIDTH + 6 : 0] i_41_96 = i_41_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_41_89 = i_41_96 - i_41_7;
    wire signed [IN_WIDTH + 6 : 0] i_41_91 = i_41_96 - i_41_5;
    wire signed [IN_WIDTH + 6 : 0] i_41_62 = i_41_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_41_90 = i_41_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_41_44 = i_41_11 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_41_88 = i_41_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_41_84 = i_41_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_41_52 = i_41_13 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_41_28 = i_41_7 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_41_42 = i_41_21 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_41_60 = i_41_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_41_74 = i_41_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_41_68 = i_41_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_41_78 = i_41_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_41_46 = i_41_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_41_86 = i_41_43 <<< 1;
//[i_42 17bit] <cost: [27] adds/subtracts [47] shifts, Depth: [3]> DCT2 SIZE64: 79   2 -77 -81  -7  73  83  11 -71 -84 -15  69  86  20 -65 -87; DST7/DCT8 SIZE32: 46  90  42 -50 -90 -38  53  89  34 -56 -88 -30  60  87  26 -63; SIZE16: 77   0 -77  77   0 -77  77   0 -77  77   0 -77  77   0 -77  77; SIZE8: 46  86  32 -60 -85 -17  71  78; SIZE4: 74   0 -74  74;
    wire signed [IN_WIDTH + 6 : 0] i_42_4 = i_42 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_42_5 = i_42 + i_42_4;
    wire signed [IN_WIDTH + 6 : 0] i_42_8 = i_42 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_42_7 = i_42_8 - i_42;
    wire signed [IN_WIDTH + 6 : 0] i_42_16 = i_42 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_42_15 = i_42_16 - i_42;
    wire signed [IN_WIDTH + 6 : 0] i_42_17 = i_42 + i_42_16;
    wire signed [IN_WIDTH + 6 : 0] i_42_64 = i_42 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_42_63 = i_42_64 - i_42;
    wire signed [IN_WIDTH + 6 : 0] i_42_65 = i_42 + i_42_64;
    wire signed [IN_WIDTH + 6 : 0] i_42_11 = i_42_16 - i_42_5;
    wire signed [IN_WIDTH + 6 : 0] i_42_13 = i_42_5 + i_42_8;
    wire signed [IN_WIDTH + 6 : 0] i_42_20 = i_42_5 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_42_19 = i_42_20 - i_42;
    wire signed [IN_WIDTH + 6 : 0] i_42_21 = i_42_5 + i_42_16;
    wire signed [IN_WIDTH + 6 : 0] i_42_23 = i_42_7 + i_42_16;
    wire signed [IN_WIDTH + 6 : 0] i_42_32 = i_42 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_42_25 = i_42_32 - i_42_7;
    wire signed [IN_WIDTH + 6 : 0] i_42_37 = i_42_5 + i_42_32;
    wire signed [IN_WIDTH + 6 : 0] i_42_40 = i_42_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_42_39 = i_42_40 - i_42;
    wire signed [IN_WIDTH + 6 : 0] i_42_43 = i_42_63 - i_42_20;
    wire signed [IN_WIDTH + 6 : 0] i_42_45 = i_42_5 + i_42_40;
    wire signed [IN_WIDTH + 6 : 0] i_42_10 = i_42_5 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_42_53 = i_42_63 - i_42_10;
    wire signed [IN_WIDTH + 6 : 0] i_42_69 = i_42_5 + i_42_64;
    wire signed [IN_WIDTH + 6 : 0] i_42_71 = i_42_7 + i_42_64;
    wire signed [IN_WIDTH + 6 : 0] i_42_73 = i_42_65 + i_42_8;
    wire signed [IN_WIDTH + 6 : 0] i_42_14 = i_42_7 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_42_77 = i_42_63 + i_42_14;
    wire signed [IN_WIDTH + 6 : 0] i_42_80 = i_42_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_42_79 = i_42_80 - i_42;
    wire signed [IN_WIDTH + 6 : 0] i_42_81 = i_42 + i_42_80;
    wire signed [IN_WIDTH + 6 : 0] i_42_83 = i_42_63 + i_42_20;
    wire signed [IN_WIDTH + 6 : 0] i_42_85 = i_42_5 + i_42_80;
    wire signed [IN_WIDTH + 6 : 0] i_42_87 = i_42_7 + i_42_80;
    wire signed [IN_WIDTH + 6 : 0] i_42_88 = i_42_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_42_89 = i_42 + i_42_88;
    wire signed [IN_WIDTH + 6 : 0] i_42_2 = i_42 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_42_84 = i_42_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_42_86 = i_42_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_42_46 = i_42_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_42_90 = i_42_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_42_42 = i_42_21 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_42_50 = i_42_25 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_42_38 = i_42_19 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_42_34 = i_42_17 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_42_56 = i_42_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_42_30 = i_42_15 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_42_60 = i_42_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_42_26 = i_42_13 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_42_78 = i_42_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_42_74 = i_42_37 <<< 1;
//[i_43 17bit] <cost: [26] adds/subtracts [63] shifts, Depth: [2]> DCT2 SIZE64: 77 -11 -86 -62  33  90  44 -52 -90 -24  69  83   2 -81 -71  20; DST7/DCT8 SIZE32: 50  88  21 -72 -78   9  85  60 -38 -90 -34  63  84   4 -80 -68; SIZE16: 81 -25 -48  88 -68   0  68 -88  48  25 -81  81 -25 -48  88 -68; SIZE8: 60  71 -46 -78  32  85 -17 -86; SIZE4: 84 -74  55 -29;
    wire signed [IN_WIDTH + 6 : 0] i_43_4 = i_43 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_43_3 = i_43_4 - i_43;
    wire signed [IN_WIDTH + 6 : 0] i_43_5 = i_43 + i_43_4;
    wire signed [IN_WIDTH + 6 : 0] i_43_8 = i_43 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_43_9 = i_43 + i_43_8;
    wire signed [IN_WIDTH + 6 : 0] i_43_16 = i_43 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_43_15 = i_43_16 - i_43;
    wire signed [IN_WIDTH + 6 : 0] i_43_17 = i_43 + i_43_16;
    wire signed [IN_WIDTH + 6 : 0] i_43_32 = i_43 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_43_31 = i_43_32 - i_43;
    wire signed [IN_WIDTH + 6 : 0] i_43_33 = i_43 + i_43_32;
    wire signed [IN_WIDTH + 6 : 0] i_43_64 = i_43 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_43_63 = i_43_64 - i_43;
    wire signed [IN_WIDTH + 6 : 0] i_43_11 = i_43_3 + i_43_8;
    wire signed [IN_WIDTH + 6 : 0] i_43_13 = i_43_16 - i_43_3;
    wire signed [IN_WIDTH + 6 : 0] i_43_19 = i_43_3 + i_43_16;
    wire signed [IN_WIDTH + 6 : 0] i_43_21 = i_43_5 + i_43_16;
    wire signed [IN_WIDTH + 6 : 0] i_43_24 = i_43_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_43_23 = i_43_24 - i_43;
    wire signed [IN_WIDTH + 6 : 0] i_43_25 = i_43 + i_43_24;
    wire signed [IN_WIDTH + 6 : 0] i_43_29 = i_43_32 - i_43_3;
    wire signed [IN_WIDTH + 6 : 0] i_43_37 = i_43_5 + i_43_32;
    wire signed [IN_WIDTH + 6 : 0] i_43_40 = i_43_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_43_39 = i_43_40 - i_43;
    wire signed [IN_WIDTH + 6 : 0] i_43_48 = i_43_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_43_43 = i_43_48 - i_43_5;
    wire signed [IN_WIDTH + 6 : 0] i_43_45 = i_43_48 - i_43_3;
    wire signed [IN_WIDTH + 6 : 0] i_43_55 = i_43_64 - i_43_9;
    wire signed [IN_WIDTH + 6 : 0] i_43_69 = i_43_5 + i_43_64;
    wire signed [IN_WIDTH + 6 : 0] i_43_72 = i_43_9 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_43_71 = i_43_72 - i_43;
    wire signed [IN_WIDTH + 6 : 0] i_43_80 = i_43_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_43_77 = i_43_80 - i_43_3;
    wire signed [IN_WIDTH + 6 : 0] i_43_81 = i_43 + i_43_80;
    wire signed [IN_WIDTH + 6 : 0] i_43_83 = i_43_3 + i_43_80;
    wire signed [IN_WIDTH + 6 : 0] i_43_85 = i_43_5 + i_43_80;
    wire signed [IN_WIDTH + 6 : 0] i_43_86 = i_43_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_43_62 = i_43_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_43_90 = i_43_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_43_44 = i_43_11 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_43_52 = i_43_13 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_43_2 = i_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_43_20 = i_43_5 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_43_50 = i_43_25 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_43_88 = i_43_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_43_78 = i_43_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_43_60 = i_43_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_43_38 = i_43_19 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_43_34 = i_43_17 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_43_84 = i_43_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_43_68 = i_43_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_43_46 = i_43_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_43_74 = i_43_37 <<< 1;
//[i_44 17bit] <cost: [26] adds/subtracts [61] shifts, Depth: [2]> DCT2 SIZE64: 73 -24 -90 -37  65  81 -11 -88 -48  56  86   2 -84 -59  44  90; DST7/DCT8 SIZE32: 53  85   0 -85 -53  53  85   0 -85 -53  53  85   0 -85 -53  53; SIZE16: 85 -48  -8  62 -88  77 -33 -25  73 -88  68 -17 -40  81 -87  55; SIZE8: 71  32 -86  17  78 -60 -46  85; SIZE4: 29  74  84  55;
    wire signed [IN_WIDTH + 6 : 0] i_44_4 = i_44 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_44_3 = i_44_4 - i_44;
    wire signed [IN_WIDTH + 6 : 0] i_44_5 = i_44 + i_44_4;
    wire signed [IN_WIDTH + 6 : 0] i_44_8 = i_44 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_44_7 = i_44_8 - i_44;
    wire signed [IN_WIDTH + 6 : 0] i_44_16 = i_44 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_44_15 = i_44_16 - i_44;
    wire signed [IN_WIDTH + 6 : 0] i_44_17 = i_44 + i_44_16;
    wire signed [IN_WIDTH + 6 : 0] i_44_32 = i_44 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_44_31 = i_44_32 - i_44;
    wire signed [IN_WIDTH + 6 : 0] i_44_33 = i_44 + i_44_32;
    wire signed [IN_WIDTH + 6 : 0] i_44_64 = i_44 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_44_65 = i_44 + i_44_64;
    wire signed [IN_WIDTH + 6 : 0] i_44_11 = i_44_3 + i_44_8;
    wire signed [IN_WIDTH + 6 : 0] i_44_21 = i_44_5 + i_44_16;
    wire signed [IN_WIDTH + 6 : 0] i_44_24 = i_44_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_44_23 = i_44_24 - i_44;
    wire signed [IN_WIDTH + 6 : 0] i_44_25 = i_44 + i_44_24;
    wire signed [IN_WIDTH + 6 : 0] i_44_29 = i_44_32 - i_44_3;
    wire signed [IN_WIDTH + 6 : 0] i_44_37 = i_44_5 + i_44_32;
    wire signed [IN_WIDTH + 6 : 0] i_44_40 = i_44_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_44_39 = i_44_40 - i_44;
    wire signed [IN_WIDTH + 6 : 0] i_44_48 = i_44_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_44_43 = i_44_48 - i_44_5;
    wire signed [IN_WIDTH + 6 : 0] i_44_45 = i_44_48 - i_44_3;
    wire signed [IN_WIDTH + 6 : 0] i_44_53 = i_44_5 + i_44_48;
    wire signed [IN_WIDTH + 6 : 0] i_44_56 = i_44_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_44_55 = i_44_56 - i_44;
    wire signed [IN_WIDTH + 6 : 0] i_44_59 = i_44_64 - i_44_5;
    wire signed [IN_WIDTH + 6 : 0] i_44_71 = i_44_7 + i_44_64;
    wire signed [IN_WIDTH + 6 : 0] i_44_73 = i_44_65 + i_44_8;
    wire signed [IN_WIDTH + 6 : 0] i_44_80 = i_44_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_44_77 = i_44_80 - i_44_3;
    wire signed [IN_WIDTH + 6 : 0] i_44_81 = i_44 + i_44_80;
    wire signed [IN_WIDTH + 6 : 0] i_44_85 = i_44_5 + i_44_80;
    wire signed [IN_WIDTH + 6 : 0] i_44_87 = i_44_7 + i_44_80;
    wire signed [IN_WIDTH + 6 : 0] i_44_90 = i_44_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_44_88 = i_44_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_44_86 = i_44_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_44_2 = i_44 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_44_84 = i_44_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_44_44 = i_44_11 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_44_62 = i_44_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_44_68 = i_44_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_44_78 = i_44_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_44_60 = i_44_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_44_46 = i_44_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_44_74 = i_44_37 <<< 1;
//[i_45 17bit] <cost: [30] adds/subtracts [61] shifts, Depth: [2]> DCT2 SIZE64: 71 -37 -90  -7  86  48 -62 -79  24  91  20 -81 -59  52  84 -11; DST7/DCT8 SIZE32: 56  80 -21 -90 -17  82  53 -60 -78  26  90  13 -84 -50  63  77; SIZE16: 87 -68  33   8 -48  77 -88  81 -55  17  25 -62  85 -88  73 -40; SIZE8: 78 -17 -60  86 -46 -32  85 -71; SIZE4: 55  74 -29 -84;
    wire signed [IN_WIDTH + 6 : 0] i_45_4 = i_45 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_45_3 = i_45_4 - i_45;
    wire signed [IN_WIDTH + 6 : 0] i_45_5 = i_45 + i_45_4;
    wire signed [IN_WIDTH + 6 : 0] i_45_8 = i_45 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_45_7 = i_45_8 - i_45;
    wire signed [IN_WIDTH + 6 : 0] i_45_16 = i_45 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_45_15 = i_45_16 - i_45;
    wire signed [IN_WIDTH + 6 : 0] i_45_17 = i_45 + i_45_16;
    wire signed [IN_WIDTH + 6 : 0] i_45_32 = i_45 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_45_31 = i_45_32 - i_45;
    wire signed [IN_WIDTH + 6 : 0] i_45_33 = i_45 + i_45_32;
    wire signed [IN_WIDTH + 6 : 0] i_45_64 = i_45 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_45_63 = i_45_64 - i_45;
    wire signed [IN_WIDTH + 6 : 0] i_45_11 = i_45_3 + i_45_8;
    wire signed [IN_WIDTH + 6 : 0] i_45_13 = i_45_16 - i_45_3;
    wire signed [IN_WIDTH + 6 : 0] i_45_21 = i_45_5 + i_45_16;
    wire signed [IN_WIDTH + 6 : 0] i_45_24 = i_45_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_45_23 = i_45_24 - i_45;
    wire signed [IN_WIDTH + 6 : 0] i_45_25 = i_45 + i_45_24;
    wire signed [IN_WIDTH + 6 : 0] i_45_29 = i_45_32 - i_45_3;
    wire signed [IN_WIDTH + 6 : 0] i_45_37 = i_45_5 + i_45_32;
    wire signed [IN_WIDTH + 6 : 0] i_45_40 = i_45_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_45_39 = i_45_40 - i_45;
    wire signed [IN_WIDTH + 6 : 0] i_45_41 = i_45 + i_45_40;
    wire signed [IN_WIDTH + 6 : 0] i_45_48 = i_45_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_45_43 = i_45_48 - i_45_5;
    wire signed [IN_WIDTH + 6 : 0] i_45_45 = i_45_48 - i_45_3;
    wire signed [IN_WIDTH + 6 : 0] i_45_53 = i_45_5 + i_45_48;
    wire signed [IN_WIDTH + 6 : 0] i_45_56 = i_45_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_45_55 = i_45_56 - i_45;
    wire signed [IN_WIDTH + 6 : 0] i_45_59 = i_45_64 - i_45_5;
    wire signed [IN_WIDTH + 6 : 0] i_45_71 = i_45_7 + i_45_64;
    wire signed [IN_WIDTH + 6 : 0] i_45_80 = i_45_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_45_73 = i_45_80 - i_45_7;
    wire signed [IN_WIDTH + 6 : 0] i_45_77 = i_45_80 - i_45_3;
    wire signed [IN_WIDTH + 6 : 0] i_45_79 = i_45_80 - i_45;
    wire signed [IN_WIDTH + 6 : 0] i_45_81 = i_45 + i_45_80;
    wire signed [IN_WIDTH + 6 : 0] i_45_85 = i_45_5 + i_45_80;
    wire signed [IN_WIDTH + 6 : 0] i_45_87 = i_45_63 + i_45_24;
    wire signed [IN_WIDTH + 6 : 0] i_45_96 = i_45_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_45_91 = i_45_96 - i_45_5;
    wire signed [IN_WIDTH + 6 : 0] i_45_90 = i_45_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_45_86 = i_45_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_45_62 = i_45_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_45_20 = i_45_5 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_45_52 = i_45_13 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_45_84 = i_45_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_45_82 = i_45_41 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_45_60 = i_45_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_45_78 = i_45_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_45_26 = i_45_13 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_45_50 = i_45_25 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_45_68 = i_45_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_45_88 = i_45_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_45_46 = i_45_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_45_74 = i_45_37 <<< 1;
//[i_46 17bit] <cost: [21] adds/subtracts [54] shifts, Depth: [2]> DCT2 SIZE64: 69 -48 -83  24  90   2 -90 -28  81  52 -65 -71  44  84 -20 -90; DST7/DCT8 SIZE32: 60  74 -42 -84  21  89   0 -89 -21  84  42 -74 -60  60  74 -42; SIZE16: 88 -81  68 -48  25   0 -25  48 -68  81 -88  88 -81  68 -48  25; SIZE8: 85 -60  17  32 -71  86 -78  46; SIZE4: 74   0 -74  74;
    wire signed [IN_WIDTH + 6 : 0] i_46_4 = i_46 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_46_3 = i_46_4 - i_46;
    wire signed [IN_WIDTH + 6 : 0] i_46_5 = i_46 + i_46_4;
    wire signed [IN_WIDTH + 6 : 0] i_46_8 = i_46 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_46_7 = i_46_8 - i_46;
    wire signed [IN_WIDTH + 6 : 0] i_46_16 = i_46 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_46_15 = i_46_16 - i_46;
    wire signed [IN_WIDTH + 6 : 0] i_46_17 = i_46 + i_46_16;
    wire signed [IN_WIDTH + 6 : 0] i_46_64 = i_46 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_46_65 = i_46 + i_46_64;
    wire signed [IN_WIDTH + 6 : 0] i_46_11 = i_46_3 + i_46_8;
    wire signed [IN_WIDTH + 6 : 0] i_46_13 = i_46_16 - i_46_3;
    wire signed [IN_WIDTH + 6 : 0] i_46_21 = i_46_5 + i_46_16;
    wire signed [IN_WIDTH + 6 : 0] i_46_24 = i_46_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_46_23 = i_46_24 - i_46;
    wire signed [IN_WIDTH + 6 : 0] i_46_25 = i_46 + i_46_24;
    wire signed [IN_WIDTH + 6 : 0] i_46_32 = i_46 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_46_37 = i_46_5 + i_46_32;
    wire signed [IN_WIDTH + 6 : 0] i_46_40 = i_46_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_46_39 = i_46_40 - i_46;
    wire signed [IN_WIDTH + 6 : 0] i_46_48 = i_46_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_46_43 = i_46_48 - i_46_5;
    wire signed [IN_WIDTH + 6 : 0] i_46_45 = i_46_48 - i_46_3;
    wire signed [IN_WIDTH + 6 : 0] i_46_69 = i_46_5 + i_46_64;
    wire signed [IN_WIDTH + 6 : 0] i_46_71 = i_46_7 + i_46_64;
    wire signed [IN_WIDTH + 6 : 0] i_46_80 = i_46_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_46_81 = i_46 + i_46_80;
    wire signed [IN_WIDTH + 6 : 0] i_46_83 = i_46_3 + i_46_80;
    wire signed [IN_WIDTH + 6 : 0] i_46_85 = i_46_5 + i_46_80;
    wire signed [IN_WIDTH + 6 : 0] i_46_96 = i_46_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_46_89 = i_46_96 - i_46_7;
    wire signed [IN_WIDTH + 6 : 0] i_46_90 = i_46_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_46_2 = i_46 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_46_28 = i_46_7 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_46_52 = i_46_13 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_46_44 = i_46_11 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_46_84 = i_46_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_46_20 = i_46_5 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_46_60 = i_46_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_46_74 = i_46_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_46_42 = i_46_21 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_46_88 = i_46_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_46_68 = i_46_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_46_86 = i_46_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_46_78 = i_46_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_46_46 = i_46_23 <<< 1;
//[i_47 17bit] <cost: [31] adds/subtracts [65] shifts, Depth: [2]> DCT2 SIZE64: 65 -59 -71  52  77 -44 -81  37  84 -28 -87  20  90 -11 -90   2; DST7/DCT8 SIZE32: 63  66 -60 -68  56  72 -53 -74  50  77 -46 -78  42  80 -38 -82; SIZE16: 88 -88  87 -85  81 -77  73 -68  62 -55  48 -40  33 -25  17  -8; SIZE8: 86 -85  78 -71  60 -46  32 -17; SIZE4: 84 -74  55 -29;
    wire signed [IN_WIDTH + 6 : 0] i_47_4 = i_47 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_47_3 = i_47_4 - i_47;
    wire signed [IN_WIDTH + 6 : 0] i_47_5 = i_47 + i_47_4;
    wire signed [IN_WIDTH + 6 : 0] i_47_8 = i_47 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_47_7 = i_47_8 - i_47;
    wire signed [IN_WIDTH + 6 : 0] i_47_9 = i_47 + i_47_8;
    wire signed [IN_WIDTH + 6 : 0] i_47_16 = i_47 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_47_15 = i_47_16 - i_47;
    wire signed [IN_WIDTH + 6 : 0] i_47_17 = i_47 + i_47_16;
    wire signed [IN_WIDTH + 6 : 0] i_47_32 = i_47 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_47_31 = i_47_32 - i_47;
    wire signed [IN_WIDTH + 6 : 0] i_47_33 = i_47 + i_47_32;
    wire signed [IN_WIDTH + 6 : 0] i_47_64 = i_47 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_47_63 = i_47_64 - i_47;
    wire signed [IN_WIDTH + 6 : 0] i_47_65 = i_47 + i_47_64;
    wire signed [IN_WIDTH + 6 : 0] i_47_11 = i_47_3 + i_47_8;
    wire signed [IN_WIDTH + 6 : 0] i_47_13 = i_47_16 - i_47_3;
    wire signed [IN_WIDTH + 6 : 0] i_47_19 = i_47_3 + i_47_16;
    wire signed [IN_WIDTH + 6 : 0] i_47_21 = i_47_5 + i_47_16;
    wire signed [IN_WIDTH + 6 : 0] i_47_24 = i_47_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_47_23 = i_47_24 - i_47;
    wire signed [IN_WIDTH + 6 : 0] i_47_25 = i_47 + i_47_24;
    wire signed [IN_WIDTH + 6 : 0] i_47_29 = i_47_32 - i_47_3;
    wire signed [IN_WIDTH + 6 : 0] i_47_37 = i_47_5 + i_47_32;
    wire signed [IN_WIDTH + 6 : 0] i_47_40 = i_47_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_47_39 = i_47_40 - i_47;
    wire signed [IN_WIDTH + 6 : 0] i_47_41 = i_47 + i_47_40;
    wire signed [IN_WIDTH + 6 : 0] i_47_48 = i_47_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_47_43 = i_47_48 - i_47_5;
    wire signed [IN_WIDTH + 6 : 0] i_47_45 = i_47_48 - i_47_3;
    wire signed [IN_WIDTH + 6 : 0] i_47_53 = i_47_5 + i_47_48;
    wire signed [IN_WIDTH + 6 : 0] i_47_56 = i_47_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_47_55 = i_47_56 - i_47;
    wire signed [IN_WIDTH + 6 : 0] i_47_59 = i_47_64 - i_47_5;
    wire signed [IN_WIDTH + 6 : 0] i_47_71 = i_47_7 + i_47_64;
    wire signed [IN_WIDTH + 6 : 0] i_47_73 = i_47_9 + i_47_64;
    wire signed [IN_WIDTH + 6 : 0] i_47_80 = i_47_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_47_77 = i_47_80 - i_47_3;
    wire signed [IN_WIDTH + 6 : 0] i_47_81 = i_47 + i_47_80;
    wire signed [IN_WIDTH + 6 : 0] i_47_85 = i_47_5 + i_47_80;
    wire signed [IN_WIDTH + 6 : 0] i_47_96 = i_47_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_47_87 = i_47_96 - i_47_9;
    wire signed [IN_WIDTH + 6 : 0] i_47_52 = i_47_13 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_47_44 = i_47_11 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_47_84 = i_47_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_47_28 = i_47_7 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_47_20 = i_47_5 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_47_90 = i_47_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_47_2 = i_47 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_47_66 = i_47_33 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_47_60 = i_47_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_47_68 = i_47_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_47_72 = i_47_9 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_47_74 = i_47_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_47_50 = i_47_25 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_47_46 = i_47_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_47_78 = i_47_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_47_42 = i_47_21 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_47_38 = i_47_19 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_47_82 = i_47_41 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_47_88 = i_47_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_47_62 = i_47_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_47_86 = i_47_43 <<< 1;
//[i_48 17bit] <cost: [30] adds/subtracts [63] shifts, Depth: [2]> DCT2 SIZE64: 62 -69 -56  73  48 -79 -41  83  33 -86 -24  88  15 -90  -7  91; DST7/DCT8 SIZE32: 66  56 -74 -46  80  34 -85 -21  88   9 -90   4  89 -17 -86  30; SIZE16:  8  25  40  55  68  77  85  88  88  87  81  73  62  48  33  17; SIZE8: 17  46  71  85  86  78  60  32; SIZE4: 29  74  84  55;
    wire signed [IN_WIDTH + 6 : 0] i_48_4 = i_48 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_48_3 = i_48_4 - i_48;
    wire signed [IN_WIDTH + 6 : 0] i_48_5 = i_48 + i_48_4;
    wire signed [IN_WIDTH + 6 : 0] i_48_8 = i_48 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_48_7 = i_48_8 - i_48;
    wire signed [IN_WIDTH + 6 : 0] i_48_9 = i_48 + i_48_8;
    wire signed [IN_WIDTH + 6 : 0] i_48_16 = i_48 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_48_15 = i_48_16 - i_48;
    wire signed [IN_WIDTH + 6 : 0] i_48_17 = i_48 + i_48_16;
    wire signed [IN_WIDTH + 6 : 0] i_48_32 = i_48 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_48_31 = i_48_32 - i_48;
    wire signed [IN_WIDTH + 6 : 0] i_48_33 = i_48 + i_48_32;
    wire signed [IN_WIDTH + 6 : 0] i_48_11 = i_48_3 + i_48_8;
    wire signed [IN_WIDTH + 6 : 0] i_48_21 = i_48_5 + i_48_16;
    wire signed [IN_WIDTH + 6 : 0] i_48_24 = i_48_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_48_23 = i_48_24 - i_48;
    wire signed [IN_WIDTH + 6 : 0] i_48_25 = i_48 + i_48_24;
    wire signed [IN_WIDTH + 6 : 0] i_48_29 = i_48_32 - i_48_3;
    wire signed [IN_WIDTH + 6 : 0] i_48_37 = i_48_5 + i_48_32;
    wire signed [IN_WIDTH + 6 : 0] i_48_40 = i_48_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_48_39 = i_48_40 - i_48;
    wire signed [IN_WIDTH + 6 : 0] i_48_41 = i_48 + i_48_40;
    wire signed [IN_WIDTH + 6 : 0] i_48_48 = i_48_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_48_43 = i_48_48 - i_48_5;
    wire signed [IN_WIDTH + 6 : 0] i_48_45 = i_48_48 - i_48_3;
    wire signed [IN_WIDTH + 6 : 0] i_48_56 = i_48_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_48_55 = i_48_56 - i_48;
    wire signed [IN_WIDTH + 6 : 0] i_48_64 = i_48 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_48_69 = i_48_5 + i_48_64;
    wire signed [IN_WIDTH + 6 : 0] i_48_71 = i_48_7 + i_48_64;
    wire signed [IN_WIDTH + 6 : 0] i_48_73 = i_48_9 + i_48_64;
    wire signed [IN_WIDTH + 6 : 0] i_48_80 = i_48_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_48_77 = i_48_80 - i_48_3;
    wire signed [IN_WIDTH + 6 : 0] i_48_79 = i_48_80 - i_48;
    wire signed [IN_WIDTH + 6 : 0] i_48_81 = i_48 + i_48_80;
    wire signed [IN_WIDTH + 6 : 0] i_48_83 = i_48_3 + i_48_80;
    wire signed [IN_WIDTH + 6 : 0] i_48_85 = i_48_5 + i_48_80;
    wire signed [IN_WIDTH + 6 : 0] i_48_96 = i_48_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_48_87 = i_48_96 - i_48_9;
    wire signed [IN_WIDTH + 6 : 0] i_48_89 = i_48_96 - i_48_7;
    wire signed [IN_WIDTH + 6 : 0] i_48_91 = i_48_96 - i_48_5;
    wire signed [IN_WIDTH + 6 : 0] i_48_62 = i_48_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_48_86 = i_48_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_48_88 = i_48_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_48_90 = i_48_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_48_66 = i_48_33 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_48_74 = i_48_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_48_46 = i_48_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_48_34 = i_48_17 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_48_30 = i_48_15 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_48_68 = i_48_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_48_78 = i_48_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_48_60 = i_48_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_48_84 = i_48_21 <<< 2;
//[i_49 17bit] <cost: [29] adds/subtracts [58] shifts, Depth: [2]> DCT2 SIZE64: 59 -77 -37  87  11 -91  15  86 -41 -73  62  56 -79 -33  88   7; DST7/DCT8 SIZE32: 68  46 -84 -17  90 -13 -85  42  72 -66 -50  82  21 -90   9  86; SIZE16: 17  48  73  87  88  77  55  25  -8 -40 -68 -85 -88 -81 -62 -33; SIZE8: 32  78  85  46 -17 -71 -86 -60; SIZE4: 55  74 -29 -84;
    wire signed [IN_WIDTH + 6 : 0] i_49_4 = i_49 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_49_3 = i_49_4 - i_49;
    wire signed [IN_WIDTH + 6 : 0] i_49_5 = i_49 + i_49_4;
    wire signed [IN_WIDTH + 6 : 0] i_49_8 = i_49 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_49_7 = i_49_8 - i_49;
    wire signed [IN_WIDTH + 6 : 0] i_49_9 = i_49 + i_49_8;
    wire signed [IN_WIDTH + 6 : 0] i_49_16 = i_49 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_49_15 = i_49_16 - i_49;
    wire signed [IN_WIDTH + 6 : 0] i_49_17 = i_49 + i_49_16;
    wire signed [IN_WIDTH + 6 : 0] i_49_32 = i_49 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_49_31 = i_49_32 - i_49;
    wire signed [IN_WIDTH + 6 : 0] i_49_33 = i_49 + i_49_32;
    wire signed [IN_WIDTH + 6 : 0] i_49_11 = i_49_3 + i_49_8;
    wire signed [IN_WIDTH + 6 : 0] i_49_13 = i_49_16 - i_49_3;
    wire signed [IN_WIDTH + 6 : 0] i_49_21 = i_49_5 + i_49_16;
    wire signed [IN_WIDTH + 6 : 0] i_49_24 = i_49_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_49_23 = i_49_24 - i_49;
    wire signed [IN_WIDTH + 6 : 0] i_49_25 = i_49 + i_49_24;
    wire signed [IN_WIDTH + 6 : 0] i_49_29 = i_49_32 - i_49_3;
    wire signed [IN_WIDTH + 6 : 0] i_49_37 = i_49_5 + i_49_32;
    wire signed [IN_WIDTH + 6 : 0] i_49_40 = i_49_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_49_39 = i_49_40 - i_49;
    wire signed [IN_WIDTH + 6 : 0] i_49_41 = i_49 + i_49_40;
    wire signed [IN_WIDTH + 6 : 0] i_49_48 = i_49_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_49_43 = i_49_48 - i_49_5;
    wire signed [IN_WIDTH + 6 : 0] i_49_45 = i_49_48 - i_49_3;
    wire signed [IN_WIDTH + 6 : 0] i_49_56 = i_49_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_49_55 = i_49_56 - i_49;
    wire signed [IN_WIDTH + 6 : 0] i_49_64 = i_49 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_49_59 = i_49_64 - i_49_5;
    wire signed [IN_WIDTH + 6 : 0] i_49_71 = i_49_7 + i_49_64;
    wire signed [IN_WIDTH + 6 : 0] i_49_73 = i_49_9 + i_49_64;
    wire signed [IN_WIDTH + 6 : 0] i_49_80 = i_49_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_49_77 = i_49_80 - i_49_3;
    wire signed [IN_WIDTH + 6 : 0] i_49_79 = i_49_80 - i_49;
    wire signed [IN_WIDTH + 6 : 0] i_49_81 = i_49 + i_49_80;
    wire signed [IN_WIDTH + 6 : 0] i_49_85 = i_49_5 + i_49_80;
    wire signed [IN_WIDTH + 6 : 0] i_49_96 = i_49_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_49_87 = i_49_96 - i_49_9;
    wire signed [IN_WIDTH + 6 : 0] i_49_91 = i_49_96 - i_49_5;
    wire signed [IN_WIDTH + 6 : 0] i_49_86 = i_49_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_49_62 = i_49_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_49_88 = i_49_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_49_68 = i_49_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_49_46 = i_49_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_49_84 = i_49_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_49_90 = i_49_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_49_42 = i_49_21 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_49_72 = i_49_9 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_49_66 = i_49_33 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_49_50 = i_49_25 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_49_82 = i_49_41 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_49_78 = i_49_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_49_60 = i_49_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_49_74 = i_49_37 <<< 1;
//[i_50 17bit] <cost: [28] adds/subtracts [58] shifts, Depth: [2]> DCT2 SIZE64: 56 -83 -15  90 -28 -77  65  44 -87  -2  88 -41 -69  73  33 -90; DST7/DCT8 SIZE32: 72  34 -89  13  82 -56 -53  84   9 -88  38  68 -74 -30  90 -17; SIZE16: 25  68  88  81  48   0 -48 -81 -88 -68 -25  25  68  88  81  48; SIZE8: 46  86  32 -60 -85 -17  71  78; SIZE4: 74   0 -74  74;
    wire signed [IN_WIDTH + 6 : 0] i_50_4 = i_50 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_50_3 = i_50_4 - i_50;
    wire signed [IN_WIDTH + 6 : 0] i_50_8 = i_50 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_50_7 = i_50_8 - i_50;
    wire signed [IN_WIDTH + 6 : 0] i_50_9 = i_50 + i_50_8;
    wire signed [IN_WIDTH + 6 : 0] i_50_16 = i_50 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_50_15 = i_50_16 - i_50;
    wire signed [IN_WIDTH + 6 : 0] i_50_17 = i_50 + i_50_16;
    wire signed [IN_WIDTH + 6 : 0] i_50_32 = i_50 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_50_33 = i_50 + i_50_32;
    wire signed [IN_WIDTH + 6 : 0] i_50_64 = i_50 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_50_65 = i_50 + i_50_64;
    wire signed [IN_WIDTH + 6 : 0] i_50_11 = i_50_3 + i_50_8;
    wire signed [IN_WIDTH + 6 : 0] i_50_13 = i_50_16 - i_50_3;
    wire signed [IN_WIDTH + 6 : 0] i_50_19 = i_50_3 + i_50_16;
    wire signed [IN_WIDTH + 6 : 0] i_50_21 = i_50_17 + i_50_4;
    wire signed [IN_WIDTH + 6 : 0] i_50_24 = i_50_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_50_23 = i_50_24 - i_50;
    wire signed [IN_WIDTH + 6 : 0] i_50_25 = i_50 + i_50_24;
    wire signed [IN_WIDTH + 6 : 0] i_50_36 = i_50_9 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_50_37 = i_50 + i_50_36;
    wire signed [IN_WIDTH + 6 : 0] i_50_39 = i_50_7 + i_50_32;
    wire signed [IN_WIDTH + 6 : 0] i_50_41 = i_50_9 + i_50_32;
    wire signed [IN_WIDTH + 6 : 0] i_50_43 = i_50_7 + i_50_36;
    wire signed [IN_WIDTH + 6 : 0] i_50_48 = i_50_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_50_45 = i_50_48 - i_50_3;
    wire signed [IN_WIDTH + 6 : 0] i_50_56 = i_50_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_50_53 = i_50_56 - i_50_3;
    wire signed [IN_WIDTH + 6 : 0] i_50_68 = i_50_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_50_69 = i_50 + i_50_68;
    wire signed [IN_WIDTH + 6 : 0] i_50_71 = i_50_7 + i_50_64;
    wire signed [IN_WIDTH + 6 : 0] i_50_73 = i_50_9 + i_50_64;
    wire signed [IN_WIDTH + 6 : 0] i_50_12 = i_50_3 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_50_77 = i_50_65 + i_50_12;
    wire signed [IN_WIDTH + 6 : 0] i_50_81 = i_50_17 + i_50_64;
    wire signed [IN_WIDTH + 6 : 0] i_50_18 = i_50_9 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_50_83 = i_50_65 + i_50_18;
    wire signed [IN_WIDTH + 6 : 0] i_50_85 = i_50_17 + i_50_68;
    wire signed [IN_WIDTH + 6 : 0] i_50_96 = i_50_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_50_87 = i_50_96 - i_50_9;
    wire signed [IN_WIDTH + 6 : 0] i_50_89 = i_50_96 - i_50_7;
    wire signed [IN_WIDTH + 6 : 0] i_50_90 = i_50_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_50_28 = i_50_7 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_50_44 = i_50_11 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_50_2 = i_50 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_50_88 = i_50_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_50_72 = i_50_9 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_50_34 = i_50_17 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_50_82 = i_50_41 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_50_84 = i_50_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_50_38 = i_50_19 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_50_74 = i_50_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_50_30 = i_50_15 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_50_46 = i_50_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_50_86 = i_50_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_50_60 = i_50_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_50_78 = i_50_39 <<< 1;
//[i_51 17bit] <cost: [30] adds/subtracts [61] shifts, Depth: [2]> DCT2 SIZE64: 52 -87   7  83 -62 -41  90 -20 -77  71  28 -91  33  69 -79 -15; DST7/DCT8 SIZE32: 74  21 -89  42  60 -84   0  84 -60 -42  89 -21 -74  74  21 -89; SIZE16: 33  81  85  40 -25 -77 -87 -48  17  73  88  55  -8 -68 -88 -62; SIZE8: 60  71 -46 -78  32  85 -17 -86; SIZE4: 84 -74  55 -29;
    wire signed [IN_WIDTH + 6 : 0] i_51_4 = i_51 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_51_3 = i_51_4 - i_51;
    wire signed [IN_WIDTH + 6 : 0] i_51_5 = i_51 + i_51_4;
    wire signed [IN_WIDTH + 6 : 0] i_51_8 = i_51 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_51_7 = i_51_8 - i_51;
    wire signed [IN_WIDTH + 6 : 0] i_51_16 = i_51 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_51_15 = i_51_16 - i_51;
    wire signed [IN_WIDTH + 6 : 0] i_51_17 = i_51 + i_51_16;
    wire signed [IN_WIDTH + 6 : 0] i_51_32 = i_51 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_51_31 = i_51_32 - i_51;
    wire signed [IN_WIDTH + 6 : 0] i_51_33 = i_51 + i_51_32;
    wire signed [IN_WIDTH + 6 : 0] i_51_11 = i_51_3 + i_51_8;
    wire signed [IN_WIDTH + 6 : 0] i_51_13 = i_51_16 - i_51_3;
    wire signed [IN_WIDTH + 6 : 0] i_51_21 = i_51_5 + i_51_16;
    wire signed [IN_WIDTH + 6 : 0] i_51_24 = i_51_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_51_23 = i_51_24 - i_51;
    wire signed [IN_WIDTH + 6 : 0] i_51_25 = i_51 + i_51_24;
    wire signed [IN_WIDTH + 6 : 0] i_51_29 = i_51_32 - i_51_3;
    wire signed [IN_WIDTH + 6 : 0] i_51_37 = i_51_5 + i_51_32;
    wire signed [IN_WIDTH + 6 : 0] i_51_40 = i_51_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_51_39 = i_51_40 - i_51;
    wire signed [IN_WIDTH + 6 : 0] i_51_41 = i_51 + i_51_40;
    wire signed [IN_WIDTH + 6 : 0] i_51_48 = i_51_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_51_43 = i_51_48 - i_51_5;
    wire signed [IN_WIDTH + 6 : 0] i_51_45 = i_51_48 - i_51_3;
    wire signed [IN_WIDTH + 6 : 0] i_51_56 = i_51_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_51_55 = i_51_56 - i_51;
    wire signed [IN_WIDTH + 6 : 0] i_51_64 = i_51 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_51_69 = i_51_5 + i_51_64;
    wire signed [IN_WIDTH + 6 : 0] i_51_71 = i_51_7 + i_51_64;
    wire signed [IN_WIDTH + 6 : 0] i_51_80 = i_51_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_51_73 = i_51_80 - i_51_7;
    wire signed [IN_WIDTH + 6 : 0] i_51_77 = i_51_80 - i_51_3;
    wire signed [IN_WIDTH + 6 : 0] i_51_79 = i_51_80 - i_51;
    wire signed [IN_WIDTH + 6 : 0] i_51_81 = i_51 + i_51_80;
    wire signed [IN_WIDTH + 6 : 0] i_51_83 = i_51_3 + i_51_80;
    wire signed [IN_WIDTH + 6 : 0] i_51_85 = i_51_5 + i_51_80;
    wire signed [IN_WIDTH + 6 : 0] i_51_87 = i_51_7 + i_51_80;
    wire signed [IN_WIDTH + 6 : 0] i_51_96 = i_51_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_51_89 = i_51_96 - i_51_7;
    wire signed [IN_WIDTH + 6 : 0] i_51_91 = i_51_96 - i_51_5;
    wire signed [IN_WIDTH + 6 : 0] i_51_52 = i_51_13 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_51_62 = i_51_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_51_90 = i_51_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_51_20 = i_51_5 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_51_28 = i_51_7 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_51_74 = i_51_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_51_42 = i_51_21 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_51_60 = i_51_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_51_84 = i_51_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_51_88 = i_51_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_51_68 = i_51_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_51_46 = i_51_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_51_78 = i_51_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_51_86 = i_51_43 <<< 1;
//[i_52 17bit] <cost: [32] adds/subtracts [61] shifts, Depth: [2]> DCT2 SIZE64: 48 -90  28  65 -84   7  79 -73 -15  87 -59 -37  91 -41 -56  88; DST7/DCT8 SIZE32: 77   9 -84  66  26 -88  53  42 -90  38  56 -87  21  68 -82   4; SIZE16: 40  88  62 -17 -81 -77  -8  68  87  33 -48 -88 -55  25  85  73; SIZE8: 71  32 -86  17  78 -60 -46  85; SIZE4: 29  74  84  55;
    wire signed [IN_WIDTH + 6 : 0] i_52_4 = i_52 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_52_3 = i_52_4 - i_52;
    wire signed [IN_WIDTH + 6 : 0] i_52_5 = i_52 + i_52_4;
    wire signed [IN_WIDTH + 6 : 0] i_52_8 = i_52 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_52_7 = i_52_8 - i_52;
    wire signed [IN_WIDTH + 6 : 0] i_52_9 = i_52 + i_52_8;
    wire signed [IN_WIDTH + 6 : 0] i_52_16 = i_52 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_52_15 = i_52_16 - i_52;
    wire signed [IN_WIDTH + 6 : 0] i_52_17 = i_52 + i_52_16;
    wire signed [IN_WIDTH + 6 : 0] i_52_32 = i_52 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_52_31 = i_52_32 - i_52;
    wire signed [IN_WIDTH + 6 : 0] i_52_33 = i_52 + i_52_32;
    wire signed [IN_WIDTH + 6 : 0] i_52_64 = i_52 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_52_65 = i_52 + i_52_64;
    wire signed [IN_WIDTH + 6 : 0] i_52_11 = i_52_3 + i_52_8;
    wire signed [IN_WIDTH + 6 : 0] i_52_13 = i_52_16 - i_52_3;
    wire signed [IN_WIDTH + 6 : 0] i_52_19 = i_52_3 + i_52_16;
    wire signed [IN_WIDTH + 6 : 0] i_52_21 = i_52_5 + i_52_16;
    wire signed [IN_WIDTH + 6 : 0] i_52_24 = i_52_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_52_23 = i_52_24 - i_52;
    wire signed [IN_WIDTH + 6 : 0] i_52_25 = i_52 + i_52_24;
    wire signed [IN_WIDTH + 6 : 0] i_52_29 = i_52_32 - i_52_3;
    wire signed [IN_WIDTH + 6 : 0] i_52_37 = i_52_5 + i_52_32;
    wire signed [IN_WIDTH + 6 : 0] i_52_40 = i_52_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_52_39 = i_52_40 - i_52;
    wire signed [IN_WIDTH + 6 : 0] i_52_41 = i_52 + i_52_40;
    wire signed [IN_WIDTH + 6 : 0] i_52_48 = i_52_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_52_43 = i_52_48 - i_52_5;
    wire signed [IN_WIDTH + 6 : 0] i_52_45 = i_52_48 - i_52_3;
    wire signed [IN_WIDTH + 6 : 0] i_52_53 = i_52_5 + i_52_48;
    wire signed [IN_WIDTH + 6 : 0] i_52_56 = i_52_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_52_55 = i_52_56 - i_52;
    wire signed [IN_WIDTH + 6 : 0] i_52_59 = i_52_64 - i_52_5;
    wire signed [IN_WIDTH + 6 : 0] i_52_71 = i_52_7 + i_52_64;
    wire signed [IN_WIDTH + 6 : 0] i_52_73 = i_52_9 + i_52_64;
    wire signed [IN_WIDTH + 6 : 0] i_52_80 = i_52_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_52_77 = i_52_80 - i_52_3;
    wire signed [IN_WIDTH + 6 : 0] i_52_79 = i_52_80 - i_52;
    wire signed [IN_WIDTH + 6 : 0] i_52_81 = i_52 + i_52_80;
    wire signed [IN_WIDTH + 6 : 0] i_52_85 = i_52_5 + i_52_80;
    wire signed [IN_WIDTH + 6 : 0] i_52_96 = i_52_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_52_87 = i_52_96 - i_52_9;
    wire signed [IN_WIDTH + 6 : 0] i_52_91 = i_52_96 - i_52_5;
    wire signed [IN_WIDTH + 6 : 0] i_52_90 = i_52_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_52_28 = i_52_7 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_52_84 = i_52_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_52_88 = i_52_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_52_66 = i_52_33 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_52_26 = i_52_13 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_52_42 = i_52_21 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_52_38 = i_52_19 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_52_68 = i_52_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_52_82 = i_52_41 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_52_62 = i_52_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_52_86 = i_52_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_52_78 = i_52_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_52_60 = i_52_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_52_46 = i_52_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_52_74 = i_52_37 <<< 1;
//[i_53 17bit] <cost: [27] adds/subtracts [61] shifts, Depth: [2]> DCT2 SIZE64: 44 -91  48  41 -90  52  37 -90  56  33 -90  59  28 -88  62  24; DST7/DCT8 SIZE32: 78  -4 -74  82 -13 -68  85 -21 -63  87 -30 -56  89 -38 -50  90; SIZE16: 48  88  25 -68 -81   0  81  68 -25 -88 -48  48  88  25 -68 -81; SIZE8: 78 -17 -60  86 -46 -32  85 -71; SIZE4: 55  74 -29 -84;
    wire signed [IN_WIDTH + 6 : 0] i_53_4 = i_53 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_53_3 = i_53_4 - i_53;
    wire signed [IN_WIDTH + 6 : 0] i_53_8 = i_53 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_53_7 = i_53_8 - i_53;
    wire signed [IN_WIDTH + 6 : 0] i_53_16 = i_53 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_53_15 = i_53_16 - i_53;
    wire signed [IN_WIDTH + 6 : 0] i_53_17 = i_53 + i_53_16;
    wire signed [IN_WIDTH + 6 : 0] i_53_32 = i_53 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_53_31 = i_53_32 - i_53;
    wire signed [IN_WIDTH + 6 : 0] i_53_33 = i_53 + i_53_32;
    wire signed [IN_WIDTH + 6 : 0] i_53_64 = i_53 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_53_63 = i_53_64 - i_53;
    wire signed [IN_WIDTH + 6 : 0] i_53_11 = i_53_3 + i_53_8;
    wire signed [IN_WIDTH + 6 : 0] i_53_13 = i_53_16 - i_53_3;
    wire signed [IN_WIDTH + 6 : 0] i_53_19 = i_53_3 + i_53_16;
    wire signed [IN_WIDTH + 6 : 0] i_53_21 = i_53_17 + i_53_4;
    wire signed [IN_WIDTH + 6 : 0] i_53_24 = i_53_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_53_23 = i_53_24 - i_53;
    wire signed [IN_WIDTH + 6 : 0] i_53_25 = i_53 + i_53_24;
    wire signed [IN_WIDTH + 6 : 0] i_53_29 = i_53_32 - i_53_3;
    wire signed [IN_WIDTH + 6 : 0] i_53_37 = i_53_33 + i_53_4;
    wire signed [IN_WIDTH + 6 : 0] i_53_39 = i_53_7 + i_53_32;
    wire signed [IN_WIDTH + 6 : 0] i_53_41 = i_53_33 + i_53_8;
    wire signed [IN_WIDTH + 6 : 0] i_53_12 = i_53_3 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_53_43 = i_53_31 + i_53_12;
    wire signed [IN_WIDTH + 6 : 0] i_53_48 = i_53_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_53_45 = i_53_48 - i_53_3;
    wire signed [IN_WIDTH + 6 : 0] i_53_56 = i_53_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_53_55 = i_53_56 - i_53;
    wire signed [IN_WIDTH + 6 : 0] i_53_60 = i_53_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_53_59 = i_53_60 - i_53;
    wire signed [IN_WIDTH + 6 : 0] i_53_71 = i_53_7 + i_53_64;
    wire signed [IN_WIDTH + 6 : 0] i_53_81 = i_53_17 + i_53_64;
    wire signed [IN_WIDTH + 6 : 0] i_53_68 = i_53_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_53_85 = i_53_17 + i_53_68;
    wire signed [IN_WIDTH + 6 : 0] i_53_87 = i_53_63 + i_53_24;
    wire signed [IN_WIDTH + 6 : 0] i_53_96 = i_53_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_53_89 = i_53_96 - i_53_7;
    wire signed [IN_WIDTH + 6 : 0] i_53_28 = i_53_7 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_53_91 = i_53_63 + i_53_28;
    wire signed [IN_WIDTH + 6 : 0] i_53_44 = i_53_11 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_53_90 = i_53_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_53_52 = i_53_13 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_53_88 = i_53_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_53_62 = i_53_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_53_78 = i_53_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_53_74 = i_53_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_53_82 = i_53_41 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_53_30 = i_53_15 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_53_38 = i_53_19 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_53_50 = i_53_25 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_53_86 = i_53_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_53_46 = i_53_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_53_84 = i_53_21 <<< 2;
//[i_54 17bit] <cost: [28] adds/subtracts [58] shifts, Depth: [2]> DCT2 SIZE64: 41 -90  65  11 -79  83 -20 -59  90 -48 -33  87 -71  -2  73 -86; DST7/DCT8 SIZE32: 80 -17 -60  90 -50 -30  85 -74   4  68 -87  38  42 -88  66   9; SIZE16: 55  81 -17 -88 -25  77  62 -48 -85   8  88  33 -73 -68  40  87; SIZE8: 85 -60  17  32 -71  86 -78  46; SIZE4: 74   0 -74  74;
    wire signed [IN_WIDTH + 6 : 0] i_54_4 = i_54 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_54_3 = i_54_4 - i_54;
    wire signed [IN_WIDTH + 6 : 0] i_54_5 = i_54 + i_54_4;
    wire signed [IN_WIDTH + 6 : 0] i_54_8 = i_54 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_54_9 = i_54 + i_54_8;
    wire signed [IN_WIDTH + 6 : 0] i_54_16 = i_54 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_54_15 = i_54_16 - i_54;
    wire signed [IN_WIDTH + 6 : 0] i_54_17 = i_54 + i_54_16;
    wire signed [IN_WIDTH + 6 : 0] i_54_32 = i_54 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_54_31 = i_54_32 - i_54;
    wire signed [IN_WIDTH + 6 : 0] i_54_33 = i_54 + i_54_32;
    wire signed [IN_WIDTH + 6 : 0] i_54_64 = i_54 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_54_65 = i_54 + i_54_64;
    wire signed [IN_WIDTH + 6 : 0] i_54_11 = i_54_3 + i_54_8;
    wire signed [IN_WIDTH + 6 : 0] i_54_19 = i_54_3 + i_54_16;
    wire signed [IN_WIDTH + 6 : 0] i_54_21 = i_54_5 + i_54_16;
    wire signed [IN_WIDTH + 6 : 0] i_54_24 = i_54_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_54_23 = i_54_24 - i_54;
    wire signed [IN_WIDTH + 6 : 0] i_54_25 = i_54 + i_54_24;
    wire signed [IN_WIDTH + 6 : 0] i_54_37 = i_54_5 + i_54_32;
    wire signed [IN_WIDTH + 6 : 0] i_54_40 = i_54_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_54_39 = i_54_40 - i_54;
    wire signed [IN_WIDTH + 6 : 0] i_54_41 = i_54 + i_54_40;
    wire signed [IN_WIDTH + 6 : 0] i_54_48 = i_54_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_54_43 = i_54_48 - i_54_5;
    wire signed [IN_WIDTH + 6 : 0] i_54_45 = i_54_48 - i_54_3;
    wire signed [IN_WIDTH + 6 : 0] i_54_55 = i_54_64 - i_54_9;
    wire signed [IN_WIDTH + 6 : 0] i_54_59 = i_54_64 - i_54_5;
    wire signed [IN_WIDTH + 6 : 0] i_54_72 = i_54_9 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_54_71 = i_54_72 - i_54;
    wire signed [IN_WIDTH + 6 : 0] i_54_73 = i_54_9 + i_54_64;
    wire signed [IN_WIDTH + 6 : 0] i_54_80 = i_54_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_54_77 = i_54_80 - i_54_3;
    wire signed [IN_WIDTH + 6 : 0] i_54_79 = i_54_80 - i_54;
    wire signed [IN_WIDTH + 6 : 0] i_54_81 = i_54 + i_54_80;
    wire signed [IN_WIDTH + 6 : 0] i_54_83 = i_54_3 + i_54_80;
    wire signed [IN_WIDTH + 6 : 0] i_54_85 = i_54_5 + i_54_80;
    wire signed [IN_WIDTH + 6 : 0] i_54_96 = i_54_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_54_87 = i_54_96 - i_54_9;
    wire signed [IN_WIDTH + 6 : 0] i_54_90 = i_54_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_54_20 = i_54_5 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_54_2 = i_54 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_54_86 = i_54_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_54_60 = i_54_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_54_50 = i_54_25 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_54_30 = i_54_15 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_54_74 = i_54_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_54_68 = i_54_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_54_38 = i_54_19 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_54_42 = i_54_21 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_54_88 = i_54_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_54_66 = i_54_33 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_54_62 = i_54_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_54_78 = i_54_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_54_46 = i_54_23 <<< 1;
//[i_55 17bit] <cost: [32] adds/subtracts [61] shifts, Depth: [2]> DCT2 SIZE64: 37 -86  79 -20 -52  90 -69   2  65 -90  56  15 -77  87 -41 -33; DST7/DCT8 SIZE32: 82 -30 -42  86 -77  17  53 -89  68  -4 -63  90 -60  -9  72 -88; SIZE16: 62  68 -55 -73  48  77 -40 -81  33  85 -25 -87  17  88  -8 -88; SIZE8: 86 -85  78 -71  60 -46  32 -17; SIZE4: 84 -74  55 -29;
    wire signed [IN_WIDTH + 6 : 0] i_55_4 = i_55 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_55_3 = i_55_4 - i_55;
    wire signed [IN_WIDTH + 6 : 0] i_55_5 = i_55 + i_55_4;
    wire signed [IN_WIDTH + 6 : 0] i_55_8 = i_55 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_55_7 = i_55_8 - i_55;
    wire signed [IN_WIDTH + 6 : 0] i_55_9 = i_55 + i_55_8;
    wire signed [IN_WIDTH + 6 : 0] i_55_16 = i_55 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_55_15 = i_55_16 - i_55;
    wire signed [IN_WIDTH + 6 : 0] i_55_17 = i_55 + i_55_16;
    wire signed [IN_WIDTH + 6 : 0] i_55_32 = i_55 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_55_31 = i_55_32 - i_55;
    wire signed [IN_WIDTH + 6 : 0] i_55_33 = i_55 + i_55_32;
    wire signed [IN_WIDTH + 6 : 0] i_55_64 = i_55 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_55_63 = i_55_64 - i_55;
    wire signed [IN_WIDTH + 6 : 0] i_55_65 = i_55 + i_55_64;
    wire signed [IN_WIDTH + 6 : 0] i_55_11 = i_55_3 + i_55_8;
    wire signed [IN_WIDTH + 6 : 0] i_55_13 = i_55_16 - i_55_3;
    wire signed [IN_WIDTH + 6 : 0] i_55_21 = i_55_5 + i_55_16;
    wire signed [IN_WIDTH + 6 : 0] i_55_24 = i_55_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_55_23 = i_55_24 - i_55;
    wire signed [IN_WIDTH + 6 : 0] i_55_25 = i_55 + i_55_24;
    wire signed [IN_WIDTH + 6 : 0] i_55_29 = i_55_32 - i_55_3;
    wire signed [IN_WIDTH + 6 : 0] i_55_37 = i_55_5 + i_55_32;
    wire signed [IN_WIDTH + 6 : 0] i_55_40 = i_55_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_55_39 = i_55_40 - i_55;
    wire signed [IN_WIDTH + 6 : 0] i_55_41 = i_55 + i_55_40;
    wire signed [IN_WIDTH + 6 : 0] i_55_48 = i_55_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_55_43 = i_55_48 - i_55_5;
    wire signed [IN_WIDTH + 6 : 0] i_55_45 = i_55_48 - i_55_3;
    wire signed [IN_WIDTH + 6 : 0] i_55_53 = i_55_5 + i_55_48;
    wire signed [IN_WIDTH + 6 : 0] i_55_56 = i_55_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_55_55 = i_55_56 - i_55;
    wire signed [IN_WIDTH + 6 : 0] i_55_69 = i_55_5 + i_55_64;
    wire signed [IN_WIDTH + 6 : 0] i_55_71 = i_55_7 + i_55_64;
    wire signed [IN_WIDTH + 6 : 0] i_55_73 = i_55_9 + i_55_64;
    wire signed [IN_WIDTH + 6 : 0] i_55_80 = i_55_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_55_77 = i_55_80 - i_55_3;
    wire signed [IN_WIDTH + 6 : 0] i_55_79 = i_55_80 - i_55;
    wire signed [IN_WIDTH + 6 : 0] i_55_81 = i_55 + i_55_80;
    wire signed [IN_WIDTH + 6 : 0] i_55_85 = i_55_5 + i_55_80;
    wire signed [IN_WIDTH + 6 : 0] i_55_96 = i_55_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_55_87 = i_55_96 - i_55_9;
    wire signed [IN_WIDTH + 6 : 0] i_55_89 = i_55_96 - i_55_7;
    wire signed [IN_WIDTH + 6 : 0] i_55_86 = i_55_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_55_20 = i_55_5 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_55_52 = i_55_13 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_55_90 = i_55_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_55_2 = i_55 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_55_82 = i_55_41 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_55_30 = i_55_15 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_55_42 = i_55_21 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_55_68 = i_55_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_55_60 = i_55_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_55_72 = i_55_9 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_55_88 = i_55_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_55_62 = i_55_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_55_78 = i_55_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_55_46 = i_55_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_55_84 = i_55_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_55_74 = i_55_37 <<< 1;
//[i_56 17bit] <cost: [24] adds/subtracts [54] shifts, Depth: [2]> DCT2 SIZE64: 33 -81  87 -48 -15  71 -90  62  -2 -59  90 -73  20  44 -86  83; DST7/DCT8 SIZE32: 84 -42 -21  74 -89  60   0 -60  89 -74  21  42 -84  84 -42 -21; SIZE16: 68  48 -81 -25  88   0 -88  25  81 -48 -68  68  48 -81 -25  88; SIZE8: 17  46  71  85  86  78  60  32; SIZE4: 29  74  84  55;
    wire signed [IN_WIDTH + 6 : 0] i_56_4 = i_56 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_56_3 = i_56_4 - i_56;
    wire signed [IN_WIDTH + 6 : 0] i_56_5 = i_56 + i_56_4;
    wire signed [IN_WIDTH + 6 : 0] i_56_16 = i_56 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_56_15 = i_56_16 - i_56;
    wire signed [IN_WIDTH + 6 : 0] i_56_17 = i_56 + i_56_16;
    wire signed [IN_WIDTH + 6 : 0] i_56_32 = i_56 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_56_31 = i_56_32 - i_56;
    wire signed [IN_WIDTH + 6 : 0] i_56_33 = i_56 + i_56_32;
    wire signed [IN_WIDTH + 6 : 0] i_56_8 = i_56 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_56_11 = i_56_3 + i_56_8;
    wire signed [IN_WIDTH + 6 : 0] i_56_21 = i_56_5 + i_56_16;
    wire signed [IN_WIDTH + 6 : 0] i_56_24 = i_56_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_56_23 = i_56_24 - i_56;
    wire signed [IN_WIDTH + 6 : 0] i_56_25 = i_56 + i_56_24;
    wire signed [IN_WIDTH + 6 : 0] i_56_29 = i_56_32 - i_56_3;
    wire signed [IN_WIDTH + 6 : 0] i_56_37 = i_56_5 + i_56_32;
    wire signed [IN_WIDTH + 6 : 0] i_56_40 = i_56_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_56_39 = i_56_40 - i_56;
    wire signed [IN_WIDTH + 6 : 0] i_56_48 = i_56_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_56_43 = i_56_48 - i_56_5;
    wire signed [IN_WIDTH + 6 : 0] i_56_45 = i_56_48 - i_56_3;
    wire signed [IN_WIDTH + 6 : 0] i_56_55 = i_56_31 + i_56_24;
    wire signed [IN_WIDTH + 6 : 0] i_56_64 = i_56 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_56_59 = i_56_64 - i_56_5;
    wire signed [IN_WIDTH + 6 : 0] i_56_68 = i_56_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_56_71 = i_56_3 + i_56_68;
    wire signed [IN_WIDTH + 6 : 0] i_56_73 = i_56_5 + i_56_68;
    wire signed [IN_WIDTH + 6 : 0] i_56_80 = i_56_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_56_81 = i_56 + i_56_80;
    wire signed [IN_WIDTH + 6 : 0] i_56_83 = i_56_3 + i_56_80;
    wire signed [IN_WIDTH + 6 : 0] i_56_85 = i_56_5 + i_56_80;
    wire signed [IN_WIDTH + 6 : 0] i_56_120 = i_56_15 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_56_87 = i_56_120 - i_56_33;
    wire signed [IN_WIDTH + 6 : 0] i_56_89 = i_56_120 - i_56_31;
    wire signed [IN_WIDTH + 6 : 0] i_56_90 = i_56_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_56_62 = i_56_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_56_2 = i_56 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_56_20 = i_56_5 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_56_44 = i_56_11 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_56_86 = i_56_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_56_84 = i_56_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_56_42 = i_56_21 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_56_74 = i_56_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_56_60 = i_56_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_56_88 = i_56_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_56_46 = i_56_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_56_78 = i_56_39 <<< 1;
//[i_57 17bit] <cost: [29] adds/subtracts [63] shifts, Depth: [2]> DCT2 SIZE64: 28 -73  91 -71  24  33 -77  90 -69  20  37 -79  90 -65  15  41; DST7/DCT8 SIZE32: 85 -53   0  53 -85  85 -53   0  53 -85  85 -53   0  53 -85  85; SIZE16: 73  25 -88  33  68 -77 -17  88 -40 -62  81   8 -87  48  55 -85; SIZE8: 32  78  85  46 -17 -71 -86 -60; SIZE4: 55  74 -29 -84;
    wire signed [IN_WIDTH + 6 : 0] i_57_4 = i_57 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_57_3 = i_57_4 - i_57;
    wire signed [IN_WIDTH + 6 : 0] i_57_5 = i_57 + i_57_4;
    wire signed [IN_WIDTH + 6 : 0] i_57_8 = i_57 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_57_7 = i_57_8 - i_57;
    wire signed [IN_WIDTH + 6 : 0] i_57_16 = i_57 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_57_15 = i_57_16 - i_57;
    wire signed [IN_WIDTH + 6 : 0] i_57_17 = i_57 + i_57_16;
    wire signed [IN_WIDTH + 6 : 0] i_57_32 = i_57 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_57_31 = i_57_32 - i_57;
    wire signed [IN_WIDTH + 6 : 0] i_57_33 = i_57 + i_57_32;
    wire signed [IN_WIDTH + 6 : 0] i_57_64 = i_57 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_57_65 = i_57 + i_57_64;
    wire signed [IN_WIDTH + 6 : 0] i_57_11 = i_57_3 + i_57_8;
    wire signed [IN_WIDTH + 6 : 0] i_57_21 = i_57_5 + i_57_16;
    wire signed [IN_WIDTH + 6 : 0] i_57_24 = i_57_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_57_23 = i_57_24 - i_57;
    wire signed [IN_WIDTH + 6 : 0] i_57_25 = i_57 + i_57_24;
    wire signed [IN_WIDTH + 6 : 0] i_57_29 = i_57_32 - i_57_3;
    wire signed [IN_WIDTH + 6 : 0] i_57_37 = i_57_5 + i_57_32;
    wire signed [IN_WIDTH + 6 : 0] i_57_40 = i_57_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_57_39 = i_57_40 - i_57;
    wire signed [IN_WIDTH + 6 : 0] i_57_41 = i_57 + i_57_40;
    wire signed [IN_WIDTH + 6 : 0] i_57_48 = i_57_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_57_43 = i_57_48 - i_57_5;
    wire signed [IN_WIDTH + 6 : 0] i_57_45 = i_57_48 - i_57_3;
    wire signed [IN_WIDTH + 6 : 0] i_57_53 = i_57_5 + i_57_48;
    wire signed [IN_WIDTH + 6 : 0] i_57_56 = i_57_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_57_55 = i_57_56 - i_57;
    wire signed [IN_WIDTH + 6 : 0] i_57_69 = i_57_5 + i_57_64;
    wire signed [IN_WIDTH + 6 : 0] i_57_71 = i_57_7 + i_57_64;
    wire signed [IN_WIDTH + 6 : 0] i_57_73 = i_57_65 + i_57_8;
    wire signed [IN_WIDTH + 6 : 0] i_57_80 = i_57_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_57_77 = i_57_80 - i_57_3;
    wire signed [IN_WIDTH + 6 : 0] i_57_79 = i_57_80 - i_57;
    wire signed [IN_WIDTH + 6 : 0] i_57_81 = i_57 + i_57_80;
    wire signed [IN_WIDTH + 6 : 0] i_57_85 = i_57_5 + i_57_80;
    wire signed [IN_WIDTH + 6 : 0] i_57_87 = i_57_7 + i_57_80;
    wire signed [IN_WIDTH + 6 : 0] i_57_96 = i_57_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_57_91 = i_57_96 - i_57_5;
    wire signed [IN_WIDTH + 6 : 0] i_57_28 = i_57_7 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_57_90 = i_57_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_57_20 = i_57_5 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_57_88 = i_57_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_57_68 = i_57_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_57_62 = i_57_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_57_78 = i_57_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_57_46 = i_57_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_57_86 = i_57_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_57_60 = i_57_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_57_74 = i_57_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_57_84 = i_57_21 <<< 2;
//[i_58 17bit] <cost: [24] adds/subtracts [45] shifts, Depth: [2]> DCT2 SIZE64: 24 -65  88 -86  59 -15 -33  71 -90  83 -52   7  41 -77  91 -79; DST7/DCT8 SIZE32: 86 -63  21  26 -66  87 -85  60 -17 -30  68 -88  84 -56  13  34; SIZE16: 77   0 -77  77   0 -77  77   0 -77  77   0 -77  77   0 -77  77; SIZE8: 46  86  32 -60 -85 -17  71  78; SIZE4: 74   0 -74  74;
    wire signed [IN_WIDTH + 6 : 0] i_58_4 = i_58 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_58_3 = i_58_4 - i_58;
    wire signed [IN_WIDTH + 6 : 0] i_58_8 = i_58 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_58_7 = i_58_8 - i_58;
    wire signed [IN_WIDTH + 6 : 0] i_58_16 = i_58 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_58_15 = i_58_16 - i_58;
    wire signed [IN_WIDTH + 6 : 0] i_58_17 = i_58 + i_58_16;
    wire signed [IN_WIDTH + 6 : 0] i_58_32 = i_58 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_58_33 = i_58 + i_58_32;
    wire signed [IN_WIDTH + 6 : 0] i_58_64 = i_58 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_58_63 = i_58_64 - i_58;
    wire signed [IN_WIDTH + 6 : 0] i_58_65 = i_58 + i_58_64;
    wire signed [IN_WIDTH + 6 : 0] i_58_11 = i_58_3 + i_58_8;
    wire signed [IN_WIDTH + 6 : 0] i_58_13 = i_58_16 - i_58_3;
    wire signed [IN_WIDTH + 6 : 0] i_58_21 = i_58_17 + i_58_4;
    wire signed [IN_WIDTH + 6 : 0] i_58_24 = i_58_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_58_23 = i_58_24 - i_58;
    wire signed [IN_WIDTH + 6 : 0] i_58_37 = i_58_33 + i_58_4;
    wire signed [IN_WIDTH + 6 : 0] i_58_39 = i_58_7 + i_58_32;
    wire signed [IN_WIDTH + 6 : 0] i_58_41 = i_58_33 + i_58_8;
    wire signed [IN_WIDTH + 6 : 0] i_58_28 = i_58_7 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_58_43 = i_58_15 + i_58_28;
    wire signed [IN_WIDTH + 6 : 0] i_58_48 = i_58_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_58_45 = i_58_48 - i_58_3;
    wire signed [IN_WIDTH + 6 : 0] i_58_60 = i_58_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_58_59 = i_58_60 - i_58;
    wire signed [IN_WIDTH + 6 : 0] i_58_71 = i_58_7 + i_58_64;
    wire signed [IN_WIDTH + 6 : 0] i_58_12 = i_58_3 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_58_77 = i_58_65 + i_58_12;
    wire signed [IN_WIDTH + 6 : 0] i_58_79 = i_58_15 + i_58_64;
    wire signed [IN_WIDTH + 6 : 0] i_58_68 = i_58_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_58_83 = i_58_15 + i_58_68;
    wire signed [IN_WIDTH + 6 : 0] i_58_85 = i_58_17 + i_58_68;
    wire signed [IN_WIDTH + 6 : 0] i_58_87 = i_58_63 + i_58_24;
    wire signed [IN_WIDTH + 6 : 0] i_58_91 = i_58_63 + i_58_28;
    wire signed [IN_WIDTH + 6 : 0] i_58_88 = i_58_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_58_86 = i_58_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_58_90 = i_58_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_58_52 = i_58_13 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_58_26 = i_58_13 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_58_66 = i_58_33 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_58_30 = i_58_15 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_58_84 = i_58_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_58_56 = i_58_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_58_34 = i_58_17 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_58_46 = i_58_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_58_78 = i_58_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_58_74 = i_58_37 <<< 1;
//[i_59 17bit] <cost: [30] adds/subtracts [65] shifts, Depth: [2]> DCT2 SIZE64: 20 -56  81 -91  83 -59  24  15 -52  79 -90  84 -62  28  11 -48; DST7/DCT8 SIZE32: 87 -72  42  -4 -34  66 -85  89 -77  50 -13 -26  60 -82  90 -80; SIZE16: 81 -25 -48  88 -68   0  68 -88  48  25 -81  81 -25 -48  88 -68; SIZE8: 60  71 -46 -78  32  85 -17 -86; SIZE4: 84 -74  55 -29;
    wire signed [IN_WIDTH + 6 : 0] i_59_4 = i_59 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_59_3 = i_59_4 - i_59;
    wire signed [IN_WIDTH + 6 : 0] i_59_5 = i_59 + i_59_4;
    wire signed [IN_WIDTH + 6 : 0] i_59_8 = i_59 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_59_7 = i_59_8 - i_59;
    wire signed [IN_WIDTH + 6 : 0] i_59_9 = i_59 + i_59_8;
    wire signed [IN_WIDTH + 6 : 0] i_59_16 = i_59 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_59_15 = i_59_16 - i_59;
    wire signed [IN_WIDTH + 6 : 0] i_59_17 = i_59 + i_59_16;
    wire signed [IN_WIDTH + 6 : 0] i_59_32 = i_59 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_59_31 = i_59_32 - i_59;
    wire signed [IN_WIDTH + 6 : 0] i_59_33 = i_59 + i_59_32;
    wire signed [IN_WIDTH + 6 : 0] i_59_11 = i_59_3 + i_59_8;
    wire signed [IN_WIDTH + 6 : 0] i_59_13 = i_59_16 - i_59_3;
    wire signed [IN_WIDTH + 6 : 0] i_59_21 = i_59_5 + i_59_16;
    wire signed [IN_WIDTH + 6 : 0] i_59_24 = i_59_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_59_23 = i_59_24 - i_59;
    wire signed [IN_WIDTH + 6 : 0] i_59_25 = i_59 + i_59_24;
    wire signed [IN_WIDTH + 6 : 0] i_59_29 = i_59_32 - i_59_3;
    wire signed [IN_WIDTH + 6 : 0] i_59_37 = i_59_5 + i_59_32;
    wire signed [IN_WIDTH + 6 : 0] i_59_40 = i_59_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_59_39 = i_59_40 - i_59;
    wire signed [IN_WIDTH + 6 : 0] i_59_41 = i_59 + i_59_40;
    wire signed [IN_WIDTH + 6 : 0] i_59_48 = i_59_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_59_43 = i_59_48 - i_59_5;
    wire signed [IN_WIDTH + 6 : 0] i_59_45 = i_59_48 - i_59_3;
    wire signed [IN_WIDTH + 6 : 0] i_59_56 = i_59_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_59_55 = i_59_56 - i_59;
    wire signed [IN_WIDTH + 6 : 0] i_59_64 = i_59 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_59_59 = i_59_64 - i_59_5;
    wire signed [IN_WIDTH + 6 : 0] i_59_71 = i_59_7 + i_59_64;
    wire signed [IN_WIDTH + 6 : 0] i_59_80 = i_59_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_59_77 = i_59_80 - i_59_3;
    wire signed [IN_WIDTH + 6 : 0] i_59_79 = i_59_80 - i_59;
    wire signed [IN_WIDTH + 6 : 0] i_59_81 = i_59 + i_59_80;
    wire signed [IN_WIDTH + 6 : 0] i_59_83 = i_59_3 + i_59_80;
    wire signed [IN_WIDTH + 6 : 0] i_59_85 = i_59_5 + i_59_80;
    wire signed [IN_WIDTH + 6 : 0] i_59_96 = i_59_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_59_87 = i_59_96 - i_59_9;
    wire signed [IN_WIDTH + 6 : 0] i_59_89 = i_59_96 - i_59_7;
    wire signed [IN_WIDTH + 6 : 0] i_59_91 = i_59_96 - i_59_5;
    wire signed [IN_WIDTH + 6 : 0] i_59_20 = i_59_5 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_59_52 = i_59_13 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_59_90 = i_59_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_59_84 = i_59_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_59_62 = i_59_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_59_28 = i_59_7 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_59_72 = i_59_9 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_59_42 = i_59_21 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_59_34 = i_59_17 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_59_66 = i_59_33 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_59_50 = i_59_25 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_59_26 = i_59_13 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_59_60 = i_59_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_59_82 = i_59_41 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_59_88 = i_59_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_59_68 = i_59_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_59_46 = i_59_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_59_78 = i_59_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_59_86 = i_59_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_59_74 = i_59_37 <<< 1;
//[i_60 17bit] <cost: [29] adds/subtracts [64] shifts, Depth: [2]> DCT2 SIZE64: 15 -44  69 -84  91 -86  71 -48  20  11 -41  65 -83  90 -87  73; DST7/DCT8 SIZE32: 88 -78  60 -34   4  26 -53  74 -86  90 -82  66 -42  13  17 -46; SIZE16: 85 -48  -8  62 -88  77 -33 -25  73 -88  68 -17 -40  81 -87  55; SIZE8: 71  32 -86  17  78 -60 -46  85; SIZE4: 29  74  84  55;
    wire signed [IN_WIDTH + 6 : 0] i_60_4 = i_60 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_60_3 = i_60_4 - i_60;
    wire signed [IN_WIDTH + 6 : 0] i_60_5 = i_60 + i_60_4;
    wire signed [IN_WIDTH + 6 : 0] i_60_16 = i_60 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_60_15 = i_60_16 - i_60;
    wire signed [IN_WIDTH + 6 : 0] i_60_17 = i_60 + i_60_16;
    wire signed [IN_WIDTH + 6 : 0] i_60_32 = i_60 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_60_31 = i_60_32 - i_60;
    wire signed [IN_WIDTH + 6 : 0] i_60_33 = i_60 + i_60_32;
    wire signed [IN_WIDTH + 6 : 0] i_60_64 = i_60 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_60_65 = i_60 + i_60_64;
    wire signed [IN_WIDTH + 6 : 0] i_60_8 = i_60 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_60_11 = i_60_3 + i_60_8;
    wire signed [IN_WIDTH + 6 : 0] i_60_13 = i_60_16 - i_60_3;
    wire signed [IN_WIDTH + 6 : 0] i_60_21 = i_60_5 + i_60_16;
    wire signed [IN_WIDTH + 6 : 0] i_60_24 = i_60_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_60_23 = i_60_24 - i_60;
    wire signed [IN_WIDTH + 6 : 0] i_60_25 = i_60 + i_60_24;
    wire signed [IN_WIDTH + 6 : 0] i_60_29 = i_60_32 - i_60_3;
    wire signed [IN_WIDTH + 6 : 0] i_60_37 = i_60_5 + i_60_32;
    wire signed [IN_WIDTH + 6 : 0] i_60_40 = i_60_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_60_39 = i_60_40 - i_60;
    wire signed [IN_WIDTH + 6 : 0] i_60_41 = i_60 + i_60_40;
    wire signed [IN_WIDTH + 6 : 0] i_60_48 = i_60_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_60_43 = i_60_48 - i_60_5;
    wire signed [IN_WIDTH + 6 : 0] i_60_45 = i_60_48 - i_60_3;
    wire signed [IN_WIDTH + 6 : 0] i_60_53 = i_60_5 + i_60_48;
    wire signed [IN_WIDTH + 6 : 0] i_60_55 = i_60_31 + i_60_24;
    wire signed [IN_WIDTH + 6 : 0] i_60_69 = i_60_5 + i_60_64;
    wire signed [IN_WIDTH + 6 : 0] i_60_68 = i_60_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_60_71 = i_60_3 + i_60_68;
    wire signed [IN_WIDTH + 6 : 0] i_60_73 = i_60_65 + i_60_8;
    wire signed [IN_WIDTH + 6 : 0] i_60_80 = i_60_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_60_77 = i_60_80 - i_60_3;
    wire signed [IN_WIDTH + 6 : 0] i_60_81 = i_60 + i_60_80;
    wire signed [IN_WIDTH + 6 : 0] i_60_83 = i_60_3 + i_60_80;
    wire signed [IN_WIDTH + 6 : 0] i_60_85 = i_60_5 + i_60_80;
    wire signed [IN_WIDTH + 6 : 0] i_60_120 = i_60_15 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_60_87 = i_60_120 - i_60_33;
    wire signed [IN_WIDTH + 6 : 0] i_60_96 = i_60_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_60_91 = i_60_96 - i_60_5;
    wire signed [IN_WIDTH + 6 : 0] i_60_44 = i_60_11 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_60_84 = i_60_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_60_86 = i_60_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_60_20 = i_60_5 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_60_90 = i_60_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_60_88 = i_60_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_60_78 = i_60_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_60_60 = i_60_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_60_34 = i_60_17 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_60_26 = i_60_13 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_60_74 = i_60_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_60_82 = i_60_41 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_60_66 = i_60_33 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_60_42 = i_60_21 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_60_46 = i_60_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_60_62 = i_60_31 <<< 1;
//[i_61 17bit] <cost: [28] adds/subtracts [55] shifts, Depth: [2]> DCT2 SIZE64: 11 -33  52 -69  81 -88  91 -87  79 -65  48 -28   7  15 -37  56; DST7/DCT8 SIZE32: 89 -84  74 -60  42 -21   0  21 -42  60 -74  84 -89  89 -84  74; SIZE16: 87 -68  33   8 -48  77 -88  81 -55  17  25 -62  85 -88  73 -40; SIZE8: 78 -17 -60  86 -46 -32  85 -71; SIZE4: 55  74 -29 -84;
    wire signed [IN_WIDTH + 6 : 0] i_61_4 = i_61 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_61_3 = i_61_4 - i_61;
    wire signed [IN_WIDTH + 6 : 0] i_61_5 = i_61 + i_61_4;
    wire signed [IN_WIDTH + 6 : 0] i_61_8 = i_61 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_61_7 = i_61_8 - i_61;
    wire signed [IN_WIDTH + 6 : 0] i_61_16 = i_61 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_61_15 = i_61_16 - i_61;
    wire signed [IN_WIDTH + 6 : 0] i_61_17 = i_61 + i_61_16;
    wire signed [IN_WIDTH + 6 : 0] i_61_32 = i_61 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_61_31 = i_61_32 - i_61;
    wire signed [IN_WIDTH + 6 : 0] i_61_33 = i_61 + i_61_32;
    wire signed [IN_WIDTH + 6 : 0] i_61_64 = i_61 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_61_65 = i_61 + i_61_64;
    wire signed [IN_WIDTH + 6 : 0] i_61_11 = i_61_3 + i_61_8;
    wire signed [IN_WIDTH + 6 : 0] i_61_13 = i_61_16 - i_61_3;
    wire signed [IN_WIDTH + 6 : 0] i_61_21 = i_61_5 + i_61_16;
    wire signed [IN_WIDTH + 6 : 0] i_61_24 = i_61_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_61_23 = i_61_24 - i_61;
    wire signed [IN_WIDTH + 6 : 0] i_61_25 = i_61 + i_61_24;
    wire signed [IN_WIDTH + 6 : 0] i_61_29 = i_61_32 - i_61_3;
    wire signed [IN_WIDTH + 6 : 0] i_61_37 = i_61_5 + i_61_32;
    wire signed [IN_WIDTH + 6 : 0] i_61_40 = i_61_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_61_39 = i_61_40 - i_61;
    wire signed [IN_WIDTH + 6 : 0] i_61_48 = i_61_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_61_43 = i_61_48 - i_61_5;
    wire signed [IN_WIDTH + 6 : 0] i_61_56 = i_61_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_61_55 = i_61_56 - i_61;
    wire signed [IN_WIDTH + 6 : 0] i_61_69 = i_61_5 + i_61_64;
    wire signed [IN_WIDTH + 6 : 0] i_61_71 = i_61_7 + i_61_64;
    wire signed [IN_WIDTH + 6 : 0] i_61_73 = i_61_65 + i_61_8;
    wire signed [IN_WIDTH + 6 : 0] i_61_80 = i_61_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_61_77 = i_61_80 - i_61_3;
    wire signed [IN_WIDTH + 6 : 0] i_61_79 = i_61_80 - i_61;
    wire signed [IN_WIDTH + 6 : 0] i_61_81 = i_61 + i_61_80;
    wire signed [IN_WIDTH + 6 : 0] i_61_85 = i_61_5 + i_61_80;
    wire signed [IN_WIDTH + 6 : 0] i_61_87 = i_61_7 + i_61_80;
    wire signed [IN_WIDTH + 6 : 0] i_61_96 = i_61_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_61_89 = i_61_96 - i_61_7;
    wire signed [IN_WIDTH + 6 : 0] i_61_91 = i_61_96 - i_61_5;
    wire signed [IN_WIDTH + 6 : 0] i_61_52 = i_61_13 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_61_88 = i_61_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_61_28 = i_61_7 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_61_84 = i_61_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_61_74 = i_61_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_61_60 = i_61_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_61_42 = i_61_21 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_61_68 = i_61_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_61_62 = i_61_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_61_78 = i_61_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_61_86 = i_61_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_61_46 = i_61_23 <<< 1;
//[i_62 17bit] <cost: [27] adds/subtracts [56] shifts, Depth: [2]> DCT2 SIZE64:  7 -20  33 -44  56 -65  73 -81  86 -90  91 -90  87 -83  77 -69; DST7/DCT8 SIZE32: 90 -87  84 -78  72 -63  53 -42  30 -17   4   9 -21  34 -46  56; SIZE16: 88 -81  68 -48  25   0 -25  48 -68  81 -88  88 -81  68 -48  25; SIZE8: 85 -60  17  32 -71  86 -78  46; SIZE4: 74   0 -74  74;
    wire signed [IN_WIDTH + 6 : 0] i_62_4 = i_62 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_62_3 = i_62_4 - i_62;
    wire signed [IN_WIDTH + 6 : 0] i_62_5 = i_62 + i_62_4;
    wire signed [IN_WIDTH + 6 : 0] i_62_8 = i_62 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_62_7 = i_62_8 - i_62;
    wire signed [IN_WIDTH + 6 : 0] i_62_9 = i_62 + i_62_8;
    wire signed [IN_WIDTH + 6 : 0] i_62_16 = i_62 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_62_15 = i_62_16 - i_62;
    wire signed [IN_WIDTH + 6 : 0] i_62_17 = i_62 + i_62_16;
    wire signed [IN_WIDTH + 6 : 0] i_62_32 = i_62 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_62_33 = i_62 + i_62_32;
    wire signed [IN_WIDTH + 6 : 0] i_62_64 = i_62 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_62_63 = i_62_64 - i_62;
    wire signed [IN_WIDTH + 6 : 0] i_62_65 = i_62 + i_62_64;
    wire signed [IN_WIDTH + 6 : 0] i_62_11 = i_62_3 + i_62_8;
    wire signed [IN_WIDTH + 6 : 0] i_62_21 = i_62_5 + i_62_16;
    wire signed [IN_WIDTH + 6 : 0] i_62_24 = i_62_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_62_23 = i_62_24 - i_62;
    wire signed [IN_WIDTH + 6 : 0] i_62_25 = i_62 + i_62_24;
    wire signed [IN_WIDTH + 6 : 0] i_62_37 = i_62_5 + i_62_32;
    wire signed [IN_WIDTH + 6 : 0] i_62_40 = i_62_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_62_39 = i_62_40 - i_62;
    wire signed [IN_WIDTH + 6 : 0] i_62_48 = i_62_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_62_43 = i_62_48 - i_62_5;
    wire signed [IN_WIDTH + 6 : 0] i_62_45 = i_62_48 - i_62_3;
    wire signed [IN_WIDTH + 6 : 0] i_62_53 = i_62_5 + i_62_48;
    wire signed [IN_WIDTH + 6 : 0] i_62_69 = i_62_5 + i_62_64;
    wire signed [IN_WIDTH + 6 : 0] i_62_71 = i_62_7 + i_62_64;
    wire signed [IN_WIDTH + 6 : 0] i_62_73 = i_62_9 + i_62_64;
    wire signed [IN_WIDTH + 6 : 0] i_62_80 = i_62_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_62_77 = i_62_80 - i_62_3;
    wire signed [IN_WIDTH + 6 : 0] i_62_81 = i_62 + i_62_80;
    wire signed [IN_WIDTH + 6 : 0] i_62_83 = i_62_3 + i_62_80;
    wire signed [IN_WIDTH + 6 : 0] i_62_85 = i_62_5 + i_62_80;
    wire signed [IN_WIDTH + 6 : 0] i_62_96 = i_62_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_62_87 = i_62_96 - i_62_9;
    wire signed [IN_WIDTH + 6 : 0] i_62_91 = i_62_96 - i_62_5;
    wire signed [IN_WIDTH + 6 : 0] i_62_20 = i_62_5 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_62_44 = i_62_11 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_62_56 = i_62_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_62_86 = i_62_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_62_90 = i_62_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_62_84 = i_62_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_62_78 = i_62_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_62_72 = i_62_9 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_62_42 = i_62_21 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_62_30 = i_62_15 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_62_34 = i_62_17 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_62_46 = i_62_23 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_62_88 = i_62_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_62_68 = i_62_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_62_60 = i_62_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_62_74 = i_62_37 <<< 1;
//[i_63 17bit] <cost: [28] adds/subtracts [58] shifts, Depth: [2]> DCT2 SIZE64:  2  -7  11 -15  20 -24  28 -33  37 -41  44 -48  52 -56  59 -62; DST7/DCT8 SIZE32: 90 -90  89 -88  87 -86  85 -84  82 -80  78 -77  74 -72  68 -66; SIZE16: 88 -88  87 -85  81 -77  73 -68  62 -55  48 -40  33 -25  17  -8; SIZE8: 86 -85  78 -71  60 -46  32 -17; SIZE4: 84 -74  55 -29;
    wire signed [IN_WIDTH + 6 : 0] i_63_4 = i_63 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_63_3 = i_63_4 - i_63;
    wire signed [IN_WIDTH + 6 : 0] i_63_5 = i_63 + i_63_4;
    wire signed [IN_WIDTH + 6 : 0] i_63_8 = i_63 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_63_7 = i_63_8 - i_63;
    wire signed [IN_WIDTH + 6 : 0] i_63_9 = i_63 + i_63_8;
    wire signed [IN_WIDTH + 6 : 0] i_63_16 = i_63 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_63_15 = i_63_16 - i_63;
    wire signed [IN_WIDTH + 6 : 0] i_63_17 = i_63 + i_63_16;
    wire signed [IN_WIDTH + 6 : 0] i_63_32 = i_63 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_63_31 = i_63_32 - i_63;
    wire signed [IN_WIDTH + 6 : 0] i_63_33 = i_63 + i_63_32;
    wire signed [IN_WIDTH + 6 : 0] i_63_11 = i_63_3 + i_63_8;
    wire signed [IN_WIDTH + 6 : 0] i_63_13 = i_63_16 - i_63_3;
    wire signed [IN_WIDTH + 6 : 0] i_63_21 = i_63_5 + i_63_16;
    wire signed [IN_WIDTH + 6 : 0] i_63_24 = i_63_3 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_63_23 = i_63_24 - i_63;
    wire signed [IN_WIDTH + 6 : 0] i_63_25 = i_63 + i_63_24;
    wire signed [IN_WIDTH + 6 : 0] i_63_29 = i_63_32 - i_63_3;
    wire signed [IN_WIDTH + 6 : 0] i_63_37 = i_63_5 + i_63_32;
    wire signed [IN_WIDTH + 6 : 0] i_63_40 = i_63_5 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_63_39 = i_63_40 - i_63;
    wire signed [IN_WIDTH + 6 : 0] i_63_41 = i_63 + i_63_40;
    wire signed [IN_WIDTH + 6 : 0] i_63_48 = i_63_3 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_63_43 = i_63_48 - i_63_5;
    wire signed [IN_WIDTH + 6 : 0] i_63_45 = i_63_48 - i_63_3;
    wire signed [IN_WIDTH + 6 : 0] i_63_56 = i_63_7 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_63_55 = i_63_56 - i_63;
    wire signed [IN_WIDTH + 6 : 0] i_63_64 = i_63 <<< 6;
    wire signed [IN_WIDTH + 6 : 0] i_63_59 = i_63_64 - i_63_5;
    wire signed [IN_WIDTH + 6 : 0] i_63_71 = i_63_7 + i_63_64;
    wire signed [IN_WIDTH + 6 : 0] i_63_73 = i_63_9 + i_63_64;
    wire signed [IN_WIDTH + 6 : 0] i_63_80 = i_63_5 <<< 4;
    wire signed [IN_WIDTH + 6 : 0] i_63_77 = i_63_80 - i_63_3;
    wire signed [IN_WIDTH + 6 : 0] i_63_81 = i_63 + i_63_80;
    wire signed [IN_WIDTH + 6 : 0] i_63_85 = i_63_5 + i_63_80;
    wire signed [IN_WIDTH + 6 : 0] i_63_96 = i_63_3 <<< 5;
    wire signed [IN_WIDTH + 6 : 0] i_63_87 = i_63_96 - i_63_9;
    wire signed [IN_WIDTH + 6 : 0] i_63_89 = i_63_96 - i_63_7;
    wire signed [IN_WIDTH + 6 : 0] i_63_2 = i_63 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_63_20 = i_63_5 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_63_28 = i_63_7 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_63_44 = i_63_11 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_63_52 = i_63_13 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_63_62 = i_63_31 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_63_90 = i_63_45 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_63_88 = i_63_11 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_63_86 = i_63_43 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_63_84 = i_63_21 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_63_82 = i_63_41 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_63_78 = i_63_39 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_63_74 = i_63_37 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_63_72 = i_63_9 <<< 3;
    wire signed [IN_WIDTH + 6 : 0] i_63_68 = i_63_17 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_63_66 = i_63_33 <<< 1;
    wire signed [IN_WIDTH + 6 : 0] i_63_60 = i_63_15 <<< 2;
    wire signed [IN_WIDTH + 6 : 0] i_63_46 = i_63_23 <<< 1;

//sum
    reg signed  [IN_WIDTH + 10 : 0] sum0_0[0 : 31], sum0_1[0 : 31];
    reg signed  [IN_WIDTH +  9 : 0] sum0_2[0 : 31], sum0_3[0 : 31];
    reg signed  [IN_WIDTH +  8 : 0] sum0_4[0 : 31], sum0_5[0 : 31], sum0_6[0 : 31], sum0_7[0 : 31];
    reg signed  [IN_WIDTH +  7 : 0] sum0_8[0 : 15], sum0_9[0 : 15], sum0_10[0 : 15], sum0_11[0 : 15], sum0_12[0 : 15], sum0_13[0 : 15], sum0_14[0 : 15], sum0_15[0 : 15];
    reg signed  [IN_WIDTH + 10 : 0] sum1_0[0 : 31], sum1_1[0 : 31];

//stage 1
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_type_d1 <= 0;
        i_size_d1 <= 0;
        i_valid_d1 <= 0;
        for (i = 0; i < 32; i = i + 1) begin
            sum0_0[i] <= 0; sum0_1[i] <= 0; sum0_2[i] <= 0; sum0_3[i] <= 0; sum0_4[i] <= 0; sum0_5[i] <= 0; sum0_6[i] <= 0; sum0_7[i] <= 0; 
        end
        for (i = 0; i < 16; i = i + 1) begin
            sum0_8[i] <= 0; sum0_9[i] <= 0; sum0_10[i] <= 0; sum0_11[i] <= 0; sum0_12[i] <= 0; sum0_13[i] <= 0; sum0_14[i] <= 0; sum0_15[i] <= 0;
        end
    end
    else begin
        i_type_d1 <= i_type;
        i_size_d1 <= i_size;
        i_valid_d1 <= i_valid;
        if (i_type == DCT2) begin
            //0-1
            sum0_0[0 ] <= i_0_64 +  i_1_64;
            sum0_0[1 ] <= i_2_83 +  i_3_36;
            //2-3
            case (i_size)
                SIZE64  : begin
                    sum0_0[2 ] <= i_4_89 +  i_5_75; sum0_1[2 ] <=  i_6_50 +  i_7_18;
                    sum0_0[3 ] <= i_4_75 + -i_5_18; sum0_1[3 ] <= -i_6_89 + -i_7_50;
                end
                default : begin
                    sum0_0[2 ] <= i_0_64 + -i_1_64;
                    sum0_0[3 ] <= i_2_36 + -i_3_83;
                end
            endcase
            //4-7
            case (i_size)
                SIZE64  : begin
                    sum0_0[4 ] <= i_8_90 +  i_9_87; sum0_1[4 ] <=  i_10_80 +  i_11_70; sum0_2[4 ] <=  i_12_57 +  i_13_43; sum0_3[4 ] <=  i_14_25 +  i_15_9 ;
                    sum0_0[5 ] <= i_8_87 +  i_9_57; sum0_1[5 ] <=  i_10_9  + -i_11_43; sum0_2[5 ] <= -i_12_80 + -i_13_90; sum0_3[5 ] <= -i_14_70 + -i_15_25;
                    sum0_0[6 ] <= i_8_80 +  i_9_9 ; sum0_1[6 ] <= -i_10_70 + -i_11_87; sum0_2[6 ] <= -i_12_25 +  i_13_57; sum0_3[6 ] <=  i_14_90 +  i_15_43;
                    sum0_0[7 ] <= i_8_70 + -i_9_43; sum0_1[7 ] <= -i_10_87 +  i_11_9 ; sum0_2[7 ] <=  i_12_90 +  i_13_25; sum0_3[7 ] <= -i_14_80 + -i_15_57;
                end
                SIZE4   : begin
                    sum0_0[4 ] <= i_4_64 +  i_5_64;
                    sum0_0[5 ] <= i_6_83 +  i_7_36;
                    sum0_0[6 ] <= i_4_64 + -i_5_64;
                    sum0_0[7 ] <= i_6_36 + -i_7_83;
                end
                default : begin
                    sum0_0[4 ] <= i_4_89 +  i_5_75; sum0_1[4 ] <=  i_6_50 +  i_7_18;
                    sum0_0[5 ] <= i_4_75 + -i_5_18; sum0_1[5 ] <= -i_6_89 + -i_7_50;
                    sum0_0[6 ] <= i_4_50 + -i_5_89; sum0_1[6 ] <=  i_6_18 +  i_7_75;
                    sum0_0[7 ] <= i_4_18 + -i_5_50; sum0_1[7 ] <=  i_6_75 + -i_7_89;
                end
            endcase
            //8-11
            case (i_size)
                SIZE64          : begin
                    sum0_0[8 ] <= i_16_90 +  i_17_90; sum0_1[8 ] <=  i_18_88 +  i_19_85; sum0_2[8 ] <=  i_20_82 +  i_21_78; sum0_3[8 ] <=  i_22_73 +  i_23_67; sum0_4[8 ] <=  i_24_61 +  i_25_54; sum0_5[8 ] <=  i_26_46 +  i_27_38; sum0_6[8 ] <=  i_28_31 +  i_29_22; sum0_7[8 ] <=  i_30_13 +  i_31_4 ;
                    sum0_0[9 ] <= i_16_90 +  i_17_82; sum0_1[9 ] <=  i_18_67 +  i_19_46; sum0_2[9 ] <=  i_20_22 + -i_21_4 ; sum0_3[9 ] <= -i_22_31 + -i_23_54; sum0_4[9 ] <= -i_24_73 + -i_25_85; sum0_5[9 ] <= -i_26_90 + -i_27_88; sum0_6[9 ] <= -i_28_78 + -i_29_61; sum0_7[9 ] <= -i_30_38 + -i_31_13;
                    sum0_0[10] <= i_16_88 +  i_17_67; sum0_1[10] <=  i_18_31 + -i_19_13; sum0_2[10] <= -i_20_54 + -i_21_82; sum0_3[10] <= -i_22_90 + -i_23_78; sum0_4[10] <= -i_24_46 + -i_25_4 ; sum0_5[10] <=  i_26_38 +  i_27_73; sum0_6[10] <=  i_28_90 +  i_29_85; sum0_7[10] <=  i_30_61 +  i_31_22;
                    sum0_0[11] <= i_16_85 +  i_17_46; sum0_1[11] <= -i_18_13 + -i_19_67; sum0_2[11] <= -i_20_90 + -i_21_73; sum0_3[11] <= -i_22_22 +  i_23_38; sum0_4[11] <=  i_24_82 +  i_25_88; sum0_5[11] <=  i_26_54 + -i_27_4 ; sum0_6[11] <= -i_28_61 + -i_29_90; sum0_7[11] <= -i_30_78 + -i_31_31;
                end
                SIZE4, SIZE8    : begin
                    sum0_0[8 ] <= i_8_64 +  i_9_64;
                    sum0_0[9 ] <= i_10_83 +  i_11_36;
                    sum0_0[10] <= i_8_64 + -i_9_64;
                    sum0_0[11] <= i_10_36 + -i_11_83;
                end
                default         : begin
                    sum0_0[8 ] <= i_8_90 +  i_9_87; sum0_1[8 ] <=  i_10_80 +  i_11_70; sum0_2[8 ] <=  i_12_57 +  i_13_43; sum0_3[8 ] <=  i_14_25 +  i_15_9 ;
                    sum0_0[9 ] <= i_8_87 +  i_9_57; sum0_1[9 ] <=  i_10_9  + -i_11_43; sum0_2[9 ] <= -i_12_80 + -i_13_90; sum0_3[9 ] <= -i_14_70 + -i_15_25;
                    sum0_0[10] <= i_8_80 +  i_9_9 ; sum0_1[10] <= -i_10_70 + -i_11_87; sum0_2[10] <= -i_12_25 +  i_13_57; sum0_3[10] <=  i_14_90 +  i_15_43;
                    sum0_0[11] <= i_8_70 + -i_9_43; sum0_1[11] <= -i_10_87 +  i_11_9 ; sum0_2[11] <=  i_12_90 +  i_13_25; sum0_3[11] <= -i_14_80 + -i_15_57;
                end
            endcase
            //12-15
            case (i_size)
                SIZE64  : begin
                    sum0_0[12] <= i_16_82 +  i_17_22; sum0_1[12] <= -i_18_54 + -i_19_90; sum0_2[12] <= -i_20_61 +  i_21_13; sum0_3[12] <=  i_22_78 +  i_23_85; sum0_4[12] <=  i_24_31 + -i_25_46; sum0_5[12] <= -i_26_90 + -i_27_67; sum0_6[12] <=  i_28_4  +  i_29_73; sum0_7[12] <=  i_30_88 +  i_31_38;
                    sum0_0[13] <= i_16_78 + -i_17_4 ; sum0_1[13] <= -i_18_82 + -i_19_73; sum0_2[13] <=  i_20_13 +  i_21_85; sum0_3[13] <=  i_22_67 + -i_23_22; sum0_4[13] <= -i_24_88 + -i_25_61; sum0_5[13] <=  i_26_31 +  i_27_90; sum0_6[13] <=  i_28_54 + -i_29_38; sum0_7[13] <= -i_30_90 + -i_31_46;
                    sum0_0[14] <= i_16_73 + -i_17_31; sum0_1[14] <= -i_18_90 + -i_19_22; sum0_2[14] <=  i_20_78 +  i_21_67; sum0_3[14] <= -i_22_38 + -i_23_90; sum0_4[14] <= -i_24_13 +  i_25_82; sum0_5[14] <=  i_26_61 + -i_27_46; sum0_6[14] <= -i_28_88 + -i_29_4 ; sum0_7[14] <=  i_30_85 +  i_31_54;
                    sum0_0[15] <= i_16_67 + -i_17_54; sum0_1[15] <= -i_18_78 +  i_19_38; sum0_2[15] <=  i_20_85 + -i_21_22; sum0_3[15] <= -i_22_90 +  i_23_4 ; sum0_4[15] <=  i_24_90 +  i_25_13; sum0_5[15] <= -i_26_88 + -i_27_31; sum0_6[15] <=  i_28_82 +  i_29_46; sum0_7[15] <= -i_30_73 + -i_31_61;
                end
                SIZE8   : begin
                    sum0_0[12] <= i_12_89 +  i_13_75; sum0_1[12] <=  i_14_50 +  i_15_18;
                    sum0_0[13] <= i_12_75 + -i_13_18; sum0_1[13] <= -i_14_89 + -i_15_50;
                    sum0_0[14] <= i_12_50 + -i_13_89; sum0_1[14] <=  i_14_18 +  i_15_75;
                    sum0_0[15] <= i_12_18 + -i_13_50; sum0_1[15] <=  i_14_75 + -i_15_89;
                end
                SIZE4   : begin
                    sum0_0[12] <= i_12_64 +  i_13_64;
                    sum0_0[13] <= i_14_83 +  i_15_36;
                    sum0_0[14] <= i_12_64 + -i_13_64;
                    sum0_0[15] <= i_14_36 + -i_15_83;
                end
                default : begin
                    sum0_0[12] <= i_8_57 + -i_9_80; sum0_1[12] <= -i_10_25 +  i_11_90; sum0_2[12] <= -i_12_9  + -i_13_87; sum0_3[12] <=  i_14_43 +  i_15_70;
                    sum0_0[13] <= i_8_43 + -i_9_90; sum0_1[13] <=  i_10_57 +  i_11_25; sum0_2[13] <= -i_12_87 +  i_13_70; sum0_3[13] <=  i_14_9  + -i_15_80;
                    sum0_0[14] <= i_8_25 + -i_9_70; sum0_1[14] <=  i_10_90 + -i_11_80; sum0_2[14] <=  i_12_43 +  i_13_9 ; sum0_3[14] <= -i_14_57 +  i_15_87;
                    sum0_0[15] <= i_8_9  + -i_9_25; sum0_1[15] <=  i_10_43 + -i_11_57; sum0_2[15] <=  i_12_70 + -i_13_80; sum0_3[15] <=  i_14_87 + -i_15_90;
                end
            endcase
            //16-19
            case (i_size)
                SIZE64  : begin
                    sum0_0[16] <= i_32_91 +  i_33_90; sum0_1[16] <=  i_34_90 +  i_35_90; sum0_2[16] <=  i_36_88 +  i_37_87; sum0_3[16] <=  i_38_86 +  i_39_84; sum0_4[16] <=  i_40_83 +  i_41_81; sum0_5[16] <=  i_42_79 +  i_43_77; sum0_6[16] <=  i_44_73 +  i_45_71; sum0_7[16] <=  i_46_69 +  i_47_65; sum0_8[0 ] <=  i_48_62 +  i_49_59; sum0_9[0 ] <=  i_50_56 +  i_51_52; sum0_10[0 ] <=  i_52_48 +  i_53_44; sum0_11[0 ] <=  i_54_41 +  i_55_37; sum0_12[0 ] <=  i_56_33 +  i_57_28; sum0_13[0 ] <=  i_58_24 +  i_59_20; sum0_14[0 ] <=  i_60_15 +  i_61_11; sum0_15[0 ] <=  i_62_7  +  i_63_2 ;
                    sum0_0[17] <= i_32_90 +  i_33_88; sum0_1[17] <=  i_34_84 +  i_35_79; sum0_2[17] <=  i_36_71 +  i_37_62; sum0_3[17] <=  i_38_52 +  i_39_41; sum0_4[17] <=  i_40_28 +  i_41_15; sum0_5[17] <=  i_42_2  + -i_43_11; sum0_6[17] <= -i_44_24 + -i_45_37; sum0_7[17] <= -i_46_48 + -i_47_59; sum0_8[1 ] <= -i_48_69 + -i_49_77; sum0_9[1 ] <= -i_50_83 + -i_51_87; sum0_10[1 ] <= -i_52_90 + -i_53_91; sum0_11[1 ] <= -i_54_90 + -i_55_86; sum0_12[1 ] <= -i_56_81 + -i_57_73; sum0_13[1 ] <= -i_58_65 + -i_59_56; sum0_14[1 ] <= -i_60_44 + -i_61_33; sum0_15[1 ] <= -i_62_20 + -i_63_7 ;
                    sum0_0[18] <= i_32_90 +  i_33_84; sum0_1[18] <=  i_34_73 +  i_35_59; sum0_2[18] <=  i_36_41 +  i_37_20; sum0_3[18] <= -i_38_2  + -i_39_24; sum0_4[18] <= -i_40_44 + -i_41_62; sum0_5[18] <= -i_42_77 + -i_43_86; sum0_6[18] <= -i_44_90 + -i_45_90; sum0_7[18] <= -i_46_83 + -i_47_71; sum0_8[2 ] <= -i_48_56 + -i_49_37; sum0_9[2 ] <= -i_50_15 +  i_51_7 ; sum0_10[2 ] <=  i_52_28 +  i_53_48; sum0_11[2 ] <=  i_54_65 +  i_55_79; sum0_12[2 ] <=  i_56_87 +  i_57_91; sum0_13[2 ] <=  i_58_88 +  i_59_81; sum0_14[2 ] <=  i_60_69 +  i_61_52; sum0_15[2 ] <=  i_62_33 +  i_63_11;
                    sum0_0[19] <= i_32_90 +  i_33_79; sum0_1[19] <=  i_34_59 +  i_35_33; sum0_2[19] <=  i_36_2  + -i_37_28; sum0_3[19] <= -i_38_56 + -i_39_77; sum0_4[19] <= -i_40_88 + -i_41_90; sum0_5[19] <= -i_42_81 + -i_43_62; sum0_6[19] <= -i_44_37 + -i_45_7 ; sum0_7[19] <=  i_46_24 +  i_47_52; sum0_8[3 ] <=  i_48_73 +  i_49_87; sum0_9[3 ] <=  i_50_90 +  i_51_83; sum0_10[3 ] <=  i_52_65 +  i_53_41; sum0_11[3 ] <=  i_54_11 + -i_55_20; sum0_12[3 ] <= -i_56_48 + -i_57_71; sum0_13[3 ] <= -i_58_86 + -i_59_91; sum0_14[3 ] <= -i_60_84 + -i_61_69; sum0_15[3 ] <= -i_62_44 + -i_63_15;
                end
                SIZE32  : begin
                    sum0_0[16] <= i_16_90 +  i_17_90; sum0_1[16] <=  i_18_88 +  i_19_85; sum0_2[16] <=  i_20_82 +  i_21_78; sum0_3[16] <=  i_22_73 +  i_23_67; sum0_4[16] <=  i_24_61 +  i_25_54; sum0_5[16] <=  i_26_46 +  i_27_38; sum0_6[16] <=  i_28_31 +  i_29_22; sum0_7[16] <=  i_30_13 +  i_31_4 ;
                    sum0_0[17] <= i_16_90 +  i_17_82; sum0_1[17] <=  i_18_67 +  i_19_46; sum0_2[17] <=  i_20_22 + -i_21_4 ; sum0_3[17] <= -i_22_31 + -i_23_54; sum0_4[17] <= -i_24_73 + -i_25_85; sum0_5[17] <= -i_26_90 + -i_27_88; sum0_6[17] <= -i_28_78 + -i_29_61; sum0_7[17] <= -i_30_38 + -i_31_13;
                    sum0_0[18] <= i_16_88 +  i_17_67; sum0_1[18] <=  i_18_31 + -i_19_13; sum0_2[18] <= -i_20_54 + -i_21_82; sum0_3[18] <= -i_22_90 + -i_23_78; sum0_4[18] <= -i_24_46 + -i_25_4 ; sum0_5[18] <=  i_26_38 +  i_27_73; sum0_6[18] <=  i_28_90 +  i_29_85; sum0_7[18] <=  i_30_61 +  i_31_22;
                    sum0_0[19] <= i_16_85 +  i_17_46; sum0_1[19] <= -i_18_13 + -i_19_67; sum0_2[19] <= -i_20_90 + -i_21_73; sum0_3[19] <= -i_22_22 +  i_23_38; sum0_4[19] <=  i_24_82 +  i_25_88; sum0_5[19] <=  i_26_54 + -i_27_4 ; sum0_6[19] <= -i_28_61 + -i_29_90; sum0_7[19] <= -i_30_78 + -i_31_31;
                end
                default : begin
                    sum0_0[16] <= i_16_64 +  i_17_64;
                    sum0_0[17] <= i_18_83 +  i_19_36;
                    sum0_0[18] <= i_16_64 + -i_17_64;
                    sum0_0[19] <= i_18_36 + -i_19_83;
                end
            endcase
            //20-23
            case (i_size)
                SIZE64  : begin
                    sum0_0[20] <= i_32_88 +  i_33_71; sum0_1[20] <=  i_34_41 +  i_35_2 ; sum0_2[20] <= -i_36_37 + -i_37_69; sum0_3[20] <= -i_38_87 + -i_39_90; sum0_4[20] <= -i_40_73 + -i_41_44; sum0_5[20] <= -i_42_7  +  i_43_33; sum0_6[20] <=  i_44_65 +  i_45_86; sum0_7[20] <=  i_46_90 +  i_47_77; sum0_8[4 ] <=  i_48_48 +  i_49_11; sum0_9[4 ] <= -i_50_28 + -i_51_62; sum0_10[4 ] <= -i_52_84 + -i_53_90; sum0_11[4 ] <= -i_54_79 + -i_55_52; sum0_12[4 ] <= -i_56_15 +  i_57_24; sum0_13[4 ] <=  i_58_59 +  i_59_83; sum0_14[4 ] <=  i_60_91 +  i_61_81; sum0_15[4 ] <=  i_62_56 +  i_63_20;
                    sum0_0[21] <= i_32_87 +  i_33_62; sum0_1[21] <=  i_34_20 + -i_35_28; sum0_2[21] <= -i_36_69 + -i_37_90; sum0_3[21] <= -i_38_84 + -i_39_56; sum0_4[21] <= -i_40_11 +  i_41_37; sum0_5[21] <=  i_42_73 +  i_43_90; sum0_6[21] <=  i_44_81 +  i_45_48; sum0_7[21] <=  i_46_2  + -i_47_44; sum0_8[5 ] <= -i_48_79 + -i_49_91; sum0_9[5 ] <= -i_50_77 + -i_51_41; sum0_10[5 ] <=  i_52_7  +  i_53_52; sum0_11[5 ] <=  i_54_83 +  i_55_90; sum0_12[5 ] <=  i_56_71 +  i_57_33; sum0_13[5 ] <= -i_58_15 + -i_59_59; sum0_14[5 ] <= -i_60_86 + -i_61_88; sum0_15[5 ] <= -i_62_65 + -i_63_24;
                    sum0_0[22] <= i_32_86 +  i_33_52; sum0_1[22] <= -i_34_2  + -i_35_56; sum0_2[22] <= -i_36_87 + -i_37_84; sum0_3[22] <= -i_38_48 +  i_39_7 ; sum0_4[22] <=  i_40_59 +  i_41_88; sum0_5[22] <=  i_42_83 +  i_43_44; sum0_6[22] <= -i_44_11 + -i_45_62; sum0_7[22] <= -i_46_90 + -i_47_81; sum0_8[6 ] <= -i_48_41 +  i_49_15; sum0_9[6 ] <=  i_50_65 +  i_51_90; sum0_10[6 ] <=  i_52_79 +  i_53_37; sum0_11[6 ] <= -i_54_20 + -i_55_69; sum0_12[6 ] <= -i_56_90 + -i_57_77; sum0_13[6 ] <= -i_58_33 +  i_59_24; sum0_14[6 ] <=  i_60_71 +  i_61_91; sum0_15[6 ] <=  i_62_73 +  i_63_28;
                    sum0_0[23] <= i_32_84 +  i_33_41; sum0_1[23] <= -i_34_24 + -i_35_77; sum0_2[23] <= -i_36_90 + -i_37_56; sum0_3[23] <=  i_38_7  +  i_39_65; sum0_4[23] <=  i_40_91 +  i_41_69; sum0_5[23] <=  i_42_11 + -i_43_52; sum0_6[23] <= -i_44_88 + -i_45_79; sum0_7[23] <= -i_46_28 +  i_47_37; sum0_8[7 ] <=  i_48_83 +  i_49_86; sum0_9[7 ] <=  i_50_44 + -i_51_20; sum0_10[7 ] <= -i_52_73 + -i_53_90; sum0_11[7 ] <= -i_54_59 +  i_55_2 ; sum0_12[7 ] <=  i_56_62 +  i_57_90; sum0_13[7 ] <=  i_58_71 +  i_59_15; sum0_14[7 ] <= -i_60_48 + -i_61_87; sum0_15[7 ] <= -i_62_81 + -i_63_33;
                end
                SIZE32  : begin
                    sum0_0[20] <= i_16_82 +  i_17_22; sum0_1[20] <= -i_18_54 + -i_19_90; sum0_2[20] <= -i_20_61 +  i_21_13; sum0_3[20] <=  i_22_78 +  i_23_85; sum0_4[20] <=  i_24_31 + -i_25_46; sum0_5[20] <= -i_26_90 + -i_27_67; sum0_6[20] <=  i_28_4  +  i_29_73; sum0_7[20] <=  i_30_88 +  i_31_38;
                    sum0_0[21] <= i_16_78 + -i_17_4 ; sum0_1[21] <= -i_18_82 + -i_19_73; sum0_2[21] <=  i_20_13 +  i_21_85; sum0_3[21] <=  i_22_67 + -i_23_22; sum0_4[21] <= -i_24_88 + -i_25_61; sum0_5[21] <=  i_26_31 +  i_27_90; sum0_6[21] <=  i_28_54 + -i_29_38; sum0_7[21] <= -i_30_90 + -i_31_46;
                    sum0_0[22] <= i_16_73 + -i_17_31; sum0_1[22] <= -i_18_90 + -i_19_22; sum0_2[22] <=  i_20_78 +  i_21_67; sum0_3[22] <= -i_22_38 + -i_23_90; sum0_4[22] <= -i_24_13 +  i_25_82; sum0_5[22] <=  i_26_61 + -i_27_46; sum0_6[22] <= -i_28_88 + -i_29_4 ; sum0_7[22] <=  i_30_85 +  i_31_54;
                    sum0_0[23] <= i_16_67 + -i_17_54; sum0_1[23] <= -i_18_78 +  i_19_38; sum0_2[23] <=  i_20_85 + -i_21_22; sum0_3[23] <= -i_22_90 +  i_23_4 ; sum0_4[23] <=  i_24_90 +  i_25_13; sum0_5[23] <= -i_26_88 + -i_27_31; sum0_6[23] <=  i_28_82 +  i_29_46; sum0_7[23] <= -i_30_73 + -i_31_61;
                end
                SIZE4   : begin
                    sum0_0[20] <= i_20_64 +  i_21_64;
                    sum0_0[21] <= i_22_83 +  i_23_36;
                    sum0_0[22] <= i_20_64 + -i_21_64;
                    sum0_0[23] <= i_22_36 + -i_23_83;
                end
                default : begin
                    sum0_0[20] <= i_20_89 +  i_21_75; sum0_1[20] <=  i_22_50 +  i_23_18;
                    sum0_0[21] <= i_20_75 + -i_21_18; sum0_1[21] <= -i_22_89 + -i_23_50;
                    sum0_0[22] <= i_20_50 + -i_21_89; sum0_1[22] <=  i_22_18 +  i_23_75;
                    sum0_0[23] <= i_20_18 + -i_21_50; sum0_1[23] <=  i_22_75 + -i_23_89;
                end
            endcase
            //24-27
            case (i_size)
                SIZE64  : begin
                    sum0_0[24] <= i_32_83 +  i_33_28; sum0_1[24] <= -i_34_44 + -i_35_88; sum0_2[24] <= -i_36_73 + -i_37_11; sum0_3[24] <=  i_38_59 +  i_39_91; sum0_4[24] <=  i_40_62 + -i_41_7 ; sum0_5[24] <= -i_42_71 + -i_43_90; sum0_6[24] <= -i_44_48 +  i_45_24; sum0_7[24] <=  i_46_81 +  i_47_84; sum0_8[8 ] <=  i_48_33 + -i_49_41; sum0_9[8 ] <= -i_50_87 + -i_51_77; sum0_10[8 ] <= -i_52_15 +  i_53_56; sum0_11[8 ] <=  i_54_90 +  i_55_65; sum0_12[8 ] <= -i_56_2  + -i_57_69; sum0_13[8 ] <= -i_58_90 + -i_59_52; sum0_14[8 ] <=  i_60_20 +  i_61_79; sum0_15[8 ] <=  i_62_86 +  i_63_37;
                    sum0_0[25] <= i_32_81 +  i_33_15; sum0_1[25] <= -i_34_62 + -i_35_90; sum0_2[25] <= -i_36_44 +  i_37_37; sum0_3[25] <=  i_38_88 +  i_39_69; sum0_4[25] <= -i_40_7  + -i_41_77; sum0_5[25] <= -i_42_84 + -i_43_24; sum0_6[25] <=  i_44_56 +  i_45_91; sum0_7[25] <=  i_46_52 + -i_47_28; sum0_8[9 ] <= -i_48_86 + -i_49_73; sum0_9[9 ] <= -i_50_2  +  i_51_71; sum0_10[9 ] <=  i_52_87 +  i_53_33; sum0_11[9 ] <= -i_54_48 + -i_55_90; sum0_12[9 ] <= -i_56_59 +  i_57_20; sum0_13[9 ] <=  i_58_83 +  i_59_79; sum0_14[9 ] <=  i_60_11 + -i_61_65; sum0_15[9 ] <= -i_62_90 + -i_63_41;
                    sum0_0[26] <= i_32_79 +  i_33_2 ; sum0_1[26] <= -i_34_77 + -i_35_81; sum0_2[26] <= -i_36_7  +  i_37_73; sum0_3[26] <=  i_38_83 +  i_39_11; sum0_4[26] <= -i_40_71 + -i_41_84; sum0_5[26] <= -i_42_15 +  i_43_69; sum0_6[26] <=  i_44_86 +  i_45_20; sum0_7[26] <= -i_46_65 + -i_47_87; sum0_8[10] <= -i_48_24 +  i_49_62; sum0_9[10] <=  i_50_88 +  i_51_28; sum0_10[10] <= -i_52_59 + -i_53_90; sum0_11[10] <= -i_54_33 +  i_55_56; sum0_12[10] <=  i_56_90 +  i_57_37; sum0_13[10] <= -i_58_52 + -i_59_90; sum0_14[10] <= -i_60_41 +  i_61_48; sum0_15[10] <=  i_62_91 +  i_63_44;
                    sum0_0[27] <= i_32_77 + -i_33_11; sum0_1[27] <= -i_34_86 + -i_35_62; sum0_2[27] <=  i_36_33 +  i_37_90; sum0_3[27] <=  i_38_44 + -i_39_52; sum0_4[27] <= -i_40_90 + -i_41_24; sum0_5[27] <=  i_42_69 +  i_43_83; sum0_6[27] <=  i_44_2  + -i_45_81; sum0_7[27] <= -i_46_71 +  i_47_20; sum0_8[11] <=  i_48_88 +  i_49_56; sum0_9[11] <= -i_50_41 + -i_51_91; sum0_10[11] <= -i_52_37 +  i_53_59; sum0_11[11] <=  i_54_87 +  i_55_15; sum0_12[11] <= -i_56_73 + -i_57_79; sum0_13[11] <=  i_58_7  +  i_59_84; sum0_14[11] <=  i_60_65 + -i_61_28; sum0_15[11] <= -i_62_90 + -i_63_48;
                end
                SIZE32  : begin
                    sum0_0[24] <= i_16_61 + -i_17_73; sum0_1[24] <= -i_18_46 +  i_19_82; sum0_2[24] <=  i_20_31 + -i_21_88; sum0_3[24] <= -i_22_13 +  i_23_90; sum0_4[24] <= -i_24_4  + -i_25_90; sum0_5[24] <=  i_26_22 +  i_27_85; sum0_6[24] <= -i_28_38 + -i_29_78; sum0_7[24] <=  i_30_54 +  i_31_67;
                    sum0_0[25] <= i_16_54 + -i_17_85; sum0_1[25] <= -i_18_4  +  i_19_88; sum0_2[25] <= -i_20_46 + -i_21_61; sum0_3[25] <=  i_22_82 +  i_23_13; sum0_4[25] <= -i_24_90 +  i_25_38; sum0_5[25] <=  i_26_67 + -i_27_78; sum0_6[25] <= -i_28_22 +  i_29_90; sum0_7[25] <= -i_30_31 + -i_31_73;
                    sum0_0[26] <= i_16_46 + -i_17_90; sum0_1[26] <=  i_18_38 +  i_19_54; sum0_2[26] <= -i_20_90 +  i_21_31; sum0_3[26] <=  i_22_61 + -i_23_88; sum0_4[26] <=  i_24_22 +  i_25_67; sum0_5[26] <= -i_26_85 +  i_27_13; sum0_6[26] <=  i_28_73 + -i_29_82; sum0_7[26] <=  i_30_4  +  i_31_78;
                    sum0_0[27] <= i_16_38 + -i_17_88; sum0_1[27] <=  i_18_73 + -i_19_4 ; sum0_2[27] <= -i_20_67 +  i_21_90; sum0_3[27] <= -i_22_46 + -i_23_31; sum0_4[27] <=  i_24_85 + -i_25_78; sum0_5[27] <=  i_26_13 +  i_27_61; sum0_6[27] <= -i_28_90 +  i_29_54; sum0_7[27] <=  i_30_22 + -i_31_82;
                end
                SIZE16  : begin
                    sum0_0[24] <= i_24_90 +  i_25_87; sum0_1[24] <=  i_26_80 +  i_27_70; sum0_2[24] <=  i_28_57 +  i_29_43; sum0_3[24] <=  i_30_25 +  i_31_9 ;
                    sum0_0[25] <= i_24_87 +  i_25_57; sum0_1[25] <=  i_26_9  + -i_27_43; sum0_2[25] <= -i_28_80 + -i_29_90; sum0_3[25] <= -i_30_70 + -i_31_25;
                    sum0_0[26] <= i_24_80 +  i_25_9 ; sum0_1[26] <= -i_26_70 + -i_27_87; sum0_2[26] <= -i_28_25 +  i_29_57; sum0_3[26] <=  i_30_90 +  i_31_43;
                    sum0_0[27] <= i_24_70 + -i_25_43; sum0_1[27] <= -i_26_87 +  i_27_9 ; sum0_2[27] <=  i_28_90 +  i_29_25; sum0_3[27] <= -i_30_80 + -i_31_57;
                end
                default : begin
                    sum0_0[24] <= i_24_64 +  i_25_64;
                    sum0_0[25] <= i_26_83 +  i_27_36;
                    sum0_0[26] <= i_24_64 + -i_25_64;
                    sum0_0[27] <= i_26_36 + -i_27_83;
                end
            endcase
            //28-31
            case (i_size)
                SIZE64  : begin
                    sum0_0[28] <= i_32_73 + -i_33_24; sum0_1[28] <= -i_34_90 + -i_35_37; sum0_2[28] <=  i_36_65 +  i_37_81; sum0_3[28] <= -i_38_11 + -i_39_88; sum0_4[28] <= -i_40_48 +  i_41_56; sum0_5[28] <=  i_42_86 +  i_43_2 ; sum0_6[28] <= -i_44_84 + -i_45_59; sum0_7[28] <=  i_46_44 +  i_47_90; sum0_8[12] <=  i_48_15 + -i_49_79; sum0_9[12] <= -i_50_69 +  i_51_33; sum0_10[12] <=  i_52_91 +  i_53_28; sum0_11[12] <= -i_54_71 + -i_55_77; sum0_12[12] <=  i_56_20 +  i_57_90; sum0_13[12] <=  i_58_41 + -i_59_62; sum0_14[12] <= -i_60_83 +  i_61_7 ; sum0_15[12] <=  i_62_87 +  i_63_52;
                    sum0_0[29] <= i_32_71 + -i_33_37; sum0_1[29] <= -i_34_90 + -i_35_7 ; sum0_2[29] <=  i_36_86 +  i_37_48; sum0_3[29] <= -i_38_62 + -i_39_79; sum0_4[29] <=  i_40_24 +  i_41_91; sum0_5[29] <=  i_42_20 + -i_43_81; sum0_6[29] <= -i_44_59 +  i_45_52; sum0_7[29] <=  i_46_84 + -i_47_11; sum0_8[13] <= -i_48_90 + -i_49_33; sum0_9[13] <=  i_50_73 +  i_51_69; sum0_10[13] <= -i_52_41 + -i_53_88; sum0_11[13] <= -i_54_2  +  i_55_87; sum0_12[13] <=  i_56_44 + -i_57_65; sum0_13[13] <= -i_58_77 +  i_59_28; sum0_14[13] <=  i_60_90 +  i_61_15; sum0_15[13] <= -i_62_83 + -i_63_56;
                    sum0_0[30] <= i_32_69 + -i_33_48; sum0_1[30] <= -i_34_83 +  i_35_24; sum0_2[30] <=  i_36_90 +  i_37_2 ; sum0_3[30] <= -i_38_90 + -i_39_28; sum0_4[30] <=  i_40_81 +  i_41_52; sum0_5[30] <= -i_42_65 + -i_43_71; sum0_6[30] <=  i_44_44 +  i_45_84; sum0_7[30] <= -i_46_20 + -i_47_90; sum0_8[14] <= -i_48_7  +  i_49_88; sum0_9[14] <=  i_50_33 + -i_51_79; sum0_10[14] <= -i_52_56 +  i_53_62; sum0_11[14] <=  i_54_73 + -i_55_41; sum0_12[14] <= -i_56_86 +  i_57_15; sum0_13[14] <=  i_58_91 +  i_59_11; sum0_14[14] <= -i_60_87 + -i_61_37; sum0_15[14] <=  i_62_77 +  i_63_59;
                    sum0_0[31] <= i_32_65 + -i_33_59; sum0_1[31] <= -i_34_71 +  i_35_52; sum0_2[31] <=  i_36_77 + -i_37_44; sum0_3[31] <= -i_38_81 +  i_39_37; sum0_4[31] <=  i_40_84 + -i_41_28; sum0_5[31] <= -i_42_87 +  i_43_20; sum0_6[31] <=  i_44_90 + -i_45_11; sum0_7[31] <= -i_46_90 +  i_47_2 ; sum0_8[15] <=  i_48_91 +  i_49_7 ; sum0_9[15] <= -i_50_90 + -i_51_15; sum0_10[15] <=  i_52_88 +  i_53_24; sum0_11[15] <= -i_54_86 + -i_55_33; sum0_12[15] <=  i_56_83 +  i_57_41; sum0_13[15] <= -i_58_79 + -i_59_48; sum0_14[15] <=  i_60_73 +  i_61_56; sum0_15[15] <= -i_62_69 + -i_63_62;
                end
                SIZE32  : begin
                    sum0_0[28] <= i_16_31 + -i_17_78; sum0_1[28] <=  i_18_90 + -i_19_61; sum0_2[28] <=  i_20_4  +  i_21_54; sum0_3[28] <= -i_22_88 +  i_23_82; sum0_4[28] <= -i_24_38 + -i_25_22; sum0_5[28] <=  i_26_73 + -i_27_90; sum0_6[28] <=  i_28_67 + -i_29_13; sum0_7[28] <= -i_30_46 +  i_31_85;
                    sum0_0[29] <= i_16_22 + -i_17_61; sum0_1[29] <=  i_18_85 + -i_19_90; sum0_2[29] <=  i_20_73 + -i_21_38; sum0_3[29] <= -i_22_4  +  i_23_46; sum0_4[29] <= -i_24_78 +  i_25_90; sum0_5[29] <= -i_26_82 +  i_27_54; sum0_6[29] <= -i_28_13 + -i_29_31; sum0_7[29] <=  i_30_67 + -i_31_88;
                    sum0_0[30] <= i_16_13 + -i_17_38; sum0_1[30] <=  i_18_61 + -i_19_78; sum0_2[30] <=  i_20_88 + -i_21_90; sum0_3[30] <=  i_22_85 + -i_23_73; sum0_4[30] <=  i_24_54 + -i_25_31; sum0_5[30] <=  i_26_4  +  i_27_22; sum0_6[30] <= -i_28_46 +  i_29_67; sum0_7[30] <= -i_30_82 +  i_31_90;
                    sum0_0[31] <= i_16_4  + -i_17_13; sum0_1[31] <=  i_18_22 + -i_19_31; sum0_2[31] <=  i_20_38 + -i_21_46; sum0_3[31] <=  i_22_54 + -i_23_61; sum0_4[31] <=  i_24_67 + -i_25_73; sum0_5[31] <=  i_26_78 + -i_27_82; sum0_6[31] <=  i_28_85 + -i_29_88; sum0_7[31] <=  i_30_90 + -i_31_90;
                end
                SIZE16  : begin
                    sum0_0[28] <= i_24_57 + -i_25_80; sum0_1[28] <= -i_26_25 +  i_27_90; sum0_2[28] <= -i_28_9  + -i_29_87; sum0_3[28] <=  i_30_43 +  i_31_70;
                    sum0_0[29] <= i_24_43 + -i_25_90; sum0_1[29] <=  i_26_57 +  i_27_25; sum0_2[29] <= -i_28_87 +  i_29_70; sum0_3[29] <=  i_30_9  + -i_31_80;
                    sum0_0[30] <= i_24_25 + -i_25_70; sum0_1[30] <=  i_26_90 + -i_27_80; sum0_2[30] <=  i_28_43 +  i_29_9 ; sum0_3[30] <= -i_30_57 +  i_31_87;
                    sum0_0[31] <= i_24_9  + -i_25_25; sum0_1[31] <=  i_26_43 + -i_27_57; sum0_2[31] <=  i_28_70 + -i_29_80; sum0_3[31] <=  i_30_87 + -i_31_90;
                end
                SIZE8   : begin
                    sum0_0[28] <= i_28_89 +  i_29_75; sum0_1[28] <=  i_30_50 +  i_31_18;
                    sum0_0[29] <= i_28_75 + -i_29_18; sum0_1[29] <= -i_30_89 + -i_31_50;
                    sum0_0[30] <= i_28_50 + -i_29_89; sum0_1[30] <=  i_30_18 +  i_31_75;
                    sum0_0[31] <= i_28_18 + -i_29_50; sum0_1[31] <=  i_30_75 + -i_31_89;
                end
                SIZE4   : begin
                    sum0_0[28] <= i_28_64 +  i_29_64;
                    sum0_0[29] <= i_30_83 +  i_31_36;
                    sum0_0[30] <= i_28_64 + -i_29_64;
                    sum0_0[31] <= i_30_36 + -i_31_83;
                end
            endcase
        end
        else begin
            case (i_size)
                SIZE32 : begin
                    sum0_0[0 ] <= i_32_4  +  i_33_9 ; sum0_1[0 ] <=  i_34_13 +  i_35_17; sum0_2[0 ] <=  i_36_21 +  i_37_26; sum0_3[0 ] <=  i_38_30 +  i_39_34; sum0_4[0 ] <=  i_40_38 +  i_41_42; sum0_5[0 ] <=  i_42_46 +  i_43_50; sum0_6[0 ] <=  i_44_53 +  i_45_56; sum0_7[0 ] <=  i_46_60 +  i_47_63; sum0_8[0 ] <=  i_48_66 +  i_49_68; sum0_9[0 ] <=  i_50_72 +  i_51_74; sum0_10[0 ] <=  i_52_77 +  i_53_78; sum0_11[0 ] <=  i_54_80 +  i_55_82; sum0_12[0 ] <=  i_56_84 +  i_57_85; sum0_13[0 ] <=  i_58_86 +  i_59_87; sum0_14[0 ] <=  i_60_88 +  i_61_89; sum0_15[0 ] <=  i_62_90 +  i_63_90;
                    sum0_0[1 ] <= i_32_13 +  i_33_26; sum0_1[1 ] <=  i_34_38 +  i_35_50; sum0_2[1 ] <=  i_36_60 +  i_37_68; sum0_3[1 ] <=  i_38_77 +  i_39_82; sum0_4[1 ] <=  i_40_86 +  i_41_89; sum0_5[1 ] <=  i_42_90 +  i_43_88; sum0_6[1 ] <=  i_44_85 +  i_45_80; sum0_7[1 ] <=  i_46_74 +  i_47_66; sum0_8[1 ] <=  i_48_56 +  i_49_46; sum0_9[1 ] <=  i_50_34 +  i_51_21; sum0_10[1 ] <=  i_52_9  + -i_53_4 ; sum0_11[1 ] <= -i_54_17 + -i_55_30; sum0_12[1 ] <= -i_56_42 + -i_57_53; sum0_13[1 ] <= -i_58_63 + -i_59_72; sum0_14[1 ] <= -i_60_78 + -i_61_84; sum0_15[1 ] <= -i_62_87 + -i_63_90;
                    sum0_0[2 ] <= i_32_21 +  i_33_42; sum0_1[2 ] <=  i_34_60 +  i_35_74; sum0_2[2 ] <=  i_36_84 +  i_37_89; sum0_3[2 ] <=  i_38_89 +  i_39_84; sum0_4[2 ] <=  i_40_74 +  i_41_60; sum0_5[2 ] <=  i_42_42 +  i_43_21; sum0_6[2 ] <=            -i_45_21; sum0_7[2 ] <= -i_46_42 + -i_47_60; sum0_8[2 ] <= -i_48_74 + -i_49_84; sum0_9[2 ] <= -i_50_89 + -i_51_89; sum0_10[2 ] <= -i_52_84 + -i_53_74; sum0_11[2 ] <= -i_54_60 + -i_55_42; sum0_12[2 ] <= -i_56_21           ; sum0_13[2 ] <=  i_58_21 +  i_59_42; sum0_14[2 ] <=  i_60_60 +  i_61_74; sum0_15[2 ] <=  i_62_84 +  i_63_89;
                    sum0_0[3 ] <= i_32_30 +  i_33_56; sum0_1[3 ] <=  i_34_77 +  i_35_87; sum0_2[3 ] <=  i_36_89 +  i_37_80; sum0_3[3 ] <=  i_38_63 +  i_39_38; sum0_4[3 ] <=  i_40_9  + -i_41_21; sum0_5[3 ] <= -i_42_50 + -i_43_72; sum0_6[3 ] <= -i_44_85 + -i_45_90; sum0_7[3 ] <= -i_46_84 + -i_47_68; sum0_8[3 ] <= -i_48_46 + -i_49_17; sum0_9[3 ] <=  i_50_13 +  i_51_42; sum0_10[3 ] <=  i_52_66 +  i_53_82; sum0_11[3 ] <=  i_54_90 +  i_55_86; sum0_12[3 ] <=  i_56_74 +  i_57_53; sum0_13[3 ] <=  i_58_26 + -i_59_4 ; sum0_14[3 ] <= -i_60_34 + -i_61_60; sum0_15[3 ] <= -i_62_78 + -i_63_88;
                    sum0_0[4 ] <= i_32_38 +  i_33_68; sum0_1[4 ] <=  i_34_86 +  i_35_88; sum0_2[4 ] <=  i_36_74 +  i_37_46; sum0_3[4 ] <=  i_38_9  + -i_39_30; sum0_4[4 ] <= -i_40_63 + -i_41_84; sum0_5[4 ] <= -i_42_90 + -i_43_78; sum0_6[4 ] <= -i_44_53 + -i_45_17; sum0_7[4 ] <=  i_46_21 +  i_47_56; sum0_8[4 ] <=  i_48_80 +  i_49_90; sum0_9[4 ] <=  i_50_82 +  i_51_60; sum0_10[4 ] <=  i_52_26 + -i_53_13; sum0_11[4 ] <= -i_54_50 + -i_55_77; sum0_12[4 ] <= -i_56_89 + -i_57_85; sum0_13[4 ] <= -i_58_66 + -i_59_34; sum0_14[4 ] <=  i_60_4  +  i_61_42; sum0_15[4 ] <=  i_62_72 +  i_63_87;
                    sum0_0[5 ] <= i_32_46 +  i_33_78; sum0_1[5 ] <=  i_34_90 +  i_35_77; sum0_2[5 ] <=  i_36_42 + -i_37_4 ; sum0_3[5 ] <= -i_38_50 + -i_39_80; sum0_4[5 ] <= -i_40_90 + -i_41_74; sum0_5[5 ] <= -i_42_38 +  i_43_9 ; sum0_6[5 ] <=  i_44_53 +  i_45_82; sum0_7[5 ] <=  i_46_89 +  i_47_72; sum0_8[5 ] <=  i_48_34 + -i_49_13; sum0_9[5 ] <= -i_50_56 + -i_51_84; sum0_10[5 ] <= -i_52_88 + -i_53_68; sum0_11[5 ] <= -i_54_30 +  i_55_17; sum0_12[5 ] <=  i_56_60 +  i_57_85; sum0_13[5 ] <=  i_58_87 +  i_59_66; sum0_14[5 ] <=  i_60_26 + -i_61_21; sum0_15[5 ] <= -i_62_63 + -i_63_86;
                    sum0_0[6 ] <= i_32_53 +  i_33_85; sum0_1[6 ] <=  i_34_85 +  i_35_53; sum0_2[6 ] <=            -i_37_53; sum0_3[6 ] <= -i_38_85 + -i_39_85; sum0_4[6 ] <= -i_40_53           ; sum0_5[6 ] <=  i_42_53 +  i_43_85; sum0_6[6 ] <=  i_44_85 +  i_45_53; sum0_7[6 ] <=            -i_47_53; sum0_8[6 ] <= -i_48_85 + -i_49_85; sum0_9[6 ] <= -i_50_53           ; sum0_10[6 ] <=  i_52_53 +  i_53_85; sum0_11[6 ] <=  i_54_85 +  i_55_53; sum0_12[6 ] <=            -i_57_53; sum0_13[6 ] <= -i_58_85 + -i_59_85; sum0_14[6 ] <= -i_60_53           ; sum0_15[6 ] <=  i_62_53 +  i_63_85;
                    sum0_0[7 ] <= i_32_60 +  i_33_89; sum0_1[7 ] <=  i_34_74 +  i_35_21; sum0_2[7 ] <= -i_36_42 + -i_37_84; sum0_3[7 ] <= -i_38_84 + -i_39_42; sum0_4[7 ] <=  i_40_21 +  i_41_74; sum0_5[7 ] <=  i_42_89 +  i_43_60; sum0_6[7 ] <=            -i_45_60; sum0_7[7 ] <= -i_46_89 + -i_47_74; sum0_8[7 ] <= -i_48_21 +  i_49_42; sum0_9[7 ] <=  i_50_84 +  i_51_84; sum0_10[7 ] <=  i_52_42 + -i_53_21; sum0_11[7 ] <= -i_54_74 + -i_55_89; sum0_12[7 ] <= -i_56_60           ; sum0_13[7 ] <=  i_58_60 +  i_59_89; sum0_14[7 ] <=  i_60_74 +  i_61_21; sum0_15[7 ] <= -i_62_42 + -i_63_84;
                    sum0_0[8 ] <= i_32_66 +  i_33_90; sum0_1[8 ] <=  i_34_56 + -i_35_13; sum0_2[8 ] <= -i_36_74 + -i_37_87; sum0_3[8 ] <= -i_38_46 +  i_39_26; sum0_4[8 ] <=  i_40_80 +  i_41_84; sum0_5[8 ] <=  i_42_34 + -i_43_38; sum0_6[8 ] <= -i_44_85 + -i_45_78; sum0_7[8 ] <= -i_46_21 +  i_47_50; sum0_8[8 ] <=  i_48_88 +  i_49_72; sum0_9[8 ] <=  i_50_9  + -i_51_60; sum0_10[8 ] <= -i_52_90 + -i_53_63; sum0_11[8 ] <=  i_54_4  +  i_55_68; sum0_12[8 ] <=  i_56_89 +  i_57_53; sum0_13[8 ] <= -i_58_17 + -i_59_77; sum0_14[8 ] <= -i_60_86 + -i_61_42; sum0_15[8 ] <=  i_62_30 +  i_63_82;
                    sum0_0[9 ] <= i_32_72 +  i_33_86; sum0_1[9 ] <=  i_34_34 + -i_35_46; sum0_2[9 ] <= -i_36_89 + -i_37_63; sum0_3[9 ] <=  i_38_13 +  i_39_78; sum0_4[9 ] <=  i_40_82 +  i_41_21; sum0_5[9 ] <= -i_42_56 + -i_43_90; sum0_6[9 ] <= -i_44_53 +  i_45_26; sum0_7[9 ] <=  i_46_84 +  i_47_77; sum0_8[9 ] <=  i_48_9  + -i_49_66; sum0_9[9 ] <= -i_50_88 + -i_51_42; sum0_10[9 ] <=  i_52_38 +  i_53_87; sum0_11[9 ] <=  i_54_68 + -i_55_4 ; sum0_12[9 ] <= -i_56_74 + -i_57_85; sum0_13[9 ] <= -i_58_30 +  i_59_50; sum0_14[9 ] <=  i_60_90 +  i_61_60; sum0_15[9 ] <= -i_62_17 + -i_63_80;
                    sum0_0[10] <= i_32_77 +  i_33_80; sum0_1[10] <=  i_34_9  + -i_35_72; sum0_2[10] <= -i_36_84 + -i_37_17; sum0_3[10] <=  i_38_66 +  i_39_86; sum0_4[10] <=  i_40_26 + -i_41_60; sum0_5[10] <= -i_42_88 + -i_43_34; sum0_6[10] <=  i_44_53 +  i_45_90; sum0_7[10] <=  i_46_42 + -i_47_46; sum0_8[10] <= -i_48_90 + -i_49_50; sum0_9[10] <=  i_50_38 +  i_51_89; sum0_10[10] <=  i_52_56 + -i_53_30; sum0_11[10] <= -i_54_87 + -i_55_63; sum0_12[10] <=  i_56_21 +  i_57_85; sum0_13[10] <=  i_58_68 + -i_59_13; sum0_14[10] <= -i_60_82 + -i_61_74; sum0_15[10] <=  i_62_4  +  i_63_78;
                    sum0_0[11] <= i_32_80 +  i_33_72; sum0_1[11] <= -i_34_17 + -i_35_86; sum0_2[11] <= -i_36_60 +  i_37_34; sum0_3[11] <=  i_38_90 +  i_39_46; sum0_4[11] <= -i_40_50 + -i_41_89; sum0_5[11] <= -i_42_30 +  i_43_63; sum0_6[11] <=  i_44_85 +  i_45_13; sum0_7[11] <= -i_46_74 + -i_47_78; sum0_8[11] <=  i_48_4  +  i_49_82; sum0_9[11] <=  i_50_68 + -i_51_21; sum0_10[11] <= -i_52_87 + -i_53_56; sum0_11[11] <=  i_54_38 +  i_55_90; sum0_12[11] <=  i_56_42 + -i_57_53; sum0_13[11] <= -i_58_88 + -i_59_26; sum0_14[11] <=  i_60_66 +  i_61_84; sum0_15[11] <=  i_62_9  + -i_63_77;
                    sum0_0[12] <= i_32_84 +  i_33_60; sum0_1[12] <= -i_34_42 + -i_35_89; sum0_2[12] <= -i_36_21 +  i_37_74; sum0_3[12] <=  i_38_74 + -i_39_21; sum0_4[12] <= -i_40_89 + -i_41_42; sum0_5[12] <=  i_42_60 +  i_43_84; sum0_6[12] <=            -i_45_84; sum0_7[12] <= -i_46_60 +  i_47_42; sum0_8[12] <=  i_48_89 +  i_49_21; sum0_9[12] <= -i_50_74 + -i_51_74; sum0_10[12] <=  i_52_21 +  i_53_89; sum0_11[12] <=  i_54_42 + -i_55_60; sum0_12[12] <= -i_56_84           ; sum0_13[12] <=  i_58_84 +  i_59_60; sum0_14[12] <= -i_60_42 + -i_61_89; sum0_15[12] <= -i_62_21 +  i_63_74;
                    sum0_0[13] <= i_32_86 +  i_33_46; sum0_1[13] <= -i_34_63 + -i_35_78; sum0_2[13] <=  i_36_21 +  i_37_90; sum0_3[13] <=  i_38_26 + -i_39_77; sum0_4[13] <= -i_40_66 +  i_41_42; sum0_5[13] <=  i_42_87 +  i_43_4 ; sum0_6[13] <= -i_44_85 + -i_45_50; sum0_7[13] <=  i_46_60 +  i_47_80; sum0_8[13] <= -i_48_17 + -i_49_90; sum0_9[13] <= -i_50_30 +  i_51_74; sum0_10[13] <=  i_52_68 + -i_53_38; sum0_11[13] <= -i_54_88 + -i_55_9 ; sum0_12[13] <=  i_56_84 +  i_57_53; sum0_13[13] <= -i_58_56 + -i_59_82; sum0_14[13] <=  i_60_13 +  i_61_89; sum0_15[13] <=  i_62_34 + -i_63_72;
                    sum0_0[14] <= i_32_88 +  i_33_30; sum0_1[14] <= -i_34_78 + -i_35_56; sum0_2[14] <=  i_36_60 +  i_37_77; sum0_3[14] <= -i_38_34 + -i_39_87; sum0_4[14] <=  i_40_4  +  i_41_89; sum0_5[14] <=  i_42_26 + -i_43_80; sum0_6[14] <= -i_44_53 +  i_45_63; sum0_7[14] <=  i_46_74 + -i_47_38; sum0_8[14] <= -i_48_86 +  i_49_9 ; sum0_9[14] <=  i_50_90 +  i_51_21; sum0_10[14] <= -i_52_82 + -i_53_50; sum0_11[14] <=  i_54_66 +  i_55_72; sum0_12[14] <= -i_56_42 + -i_57_85; sum0_13[14] <=  i_58_13 +  i_59_90; sum0_14[14] <=  i_60_17 + -i_61_84; sum0_15[14] <= -i_62_46 +  i_63_68;
                    sum0_0[15] <= i_32_90 +  i_33_13; sum0_1[15] <= -i_34_87 + -i_35_26; sum0_2[15] <=  i_36_84 +  i_37_38; sum0_3[15] <= -i_38_78 + -i_39_50; sum0_4[15] <=  i_40_72 +  i_41_60; sum0_5[15] <= -i_42_63 + -i_43_68; sum0_6[15] <=  i_44_53 +  i_45_77; sum0_7[15] <= -i_46_42 + -i_47_82; sum0_8[15] <=  i_48_30 +  i_49_86; sum0_9[15] <= -i_50_17 + -i_51_89; sum0_10[15] <=  i_52_4  +  i_53_90; sum0_11[15] <=  i_54_9  + -i_55_88; sum0_12[15] <= -i_56_21 +  i_57_85; sum0_13[15] <=  i_58_34 + -i_59_80; sum0_14[15] <= -i_60_46 +  i_61_74; sum0_15[15] <=  i_62_56 + -i_63_66;
                end
                SIZE16 : begin
                    sum0_0[0 ] <= i_32_8  +  i_33_17; sum0_1[0 ] <=  i_34_25 +  i_35_33; sum0_2[0 ] <=  i_36_40 +  i_37_48; sum0_3[0 ] <=  i_38_55 +  i_39_62; sum0_4[0 ] <=  i_40_68 +  i_41_73; sum0_5[0 ] <=  i_42_77 +  i_43_81; sum0_6[0 ] <=  i_44_85 +  i_45_87; sum0_7[0 ] <=  i_46_88 +  i_47_88; 
                    sum0_0[1 ] <= i_32_25 +  i_33_48; sum0_1[1 ] <=  i_34_68 +  i_35_81; sum0_2[1 ] <=  i_36_88 +  i_37_88; sum0_3[1 ] <=  i_38_81 +  i_39_68; sum0_4[1 ] <=  i_40_48 +  i_41_25; sum0_5[1 ] <=            -i_43_25; sum0_6[1 ] <= -i_44_48 + -i_45_68; sum0_7[1 ] <= -i_46_81 + -i_47_88; 
                    sum0_0[2 ] <= i_32_40 +  i_33_73; sum0_1[2 ] <=  i_34_88 +  i_35_85; sum0_2[2 ] <=  i_36_62 +  i_37_25; sum0_3[2 ] <= -i_38_17 + -i_39_55; sum0_4[2 ] <= -i_40_81 + -i_41_88; sum0_5[2 ] <= -i_42_77 + -i_43_48; sum0_6[2 ] <= -i_44_8  +  i_45_33; sum0_7[2 ] <=  i_46_68 +  i_47_87; 
                    sum0_0[3 ] <= i_32_55 +  i_33_87; sum0_1[3 ] <=  i_34_81 +  i_35_40; sum0_2[3 ] <= -i_36_17 + -i_37_68; sum0_3[3 ] <= -i_38_88 + -i_39_73; sum0_4[3 ] <= -i_40_25 +  i_41_33; sum0_5[3 ] <=  i_42_77 +  i_43_88; sum0_6[3 ] <=  i_44_62 +  i_45_8 ; sum0_7[3 ] <= -i_46_48 + -i_47_85; 
                    sum0_0[4 ] <= i_32_68 +  i_33_88; sum0_1[4 ] <=  i_34_48 + -i_35_25; sum0_2[4 ] <= -i_36_81 + -i_37_81; sum0_3[4 ] <= -i_38_25 +  i_39_48; sum0_4[4 ] <=  i_40_88 +  i_41_68; sum0_5[4 ] <=            -i_43_68; sum0_6[4 ] <= -i_44_88 + -i_45_48; sum0_7[4 ] <=  i_46_25 +  i_47_81; 
                    sum0_0[5 ] <= i_32_77 +  i_33_77; sum0_1[5 ] <=            -i_35_77; sum0_2[5 ] <= -i_36_77           ; sum0_3[5 ] <=  i_38_77 +  i_39_77; sum0_4[5 ] <=            -i_41_77; sum0_5[5 ] <= -i_42_77           ; sum0_6[5 ] <=  i_44_77 +  i_45_77; sum0_7[5 ] <=            -i_47_77; 
                    sum0_0[6 ] <= i_32_85 +  i_33_55; sum0_1[6 ] <= -i_34_48 + -i_35_87; sum0_2[6 ] <= -i_36_8  +  i_37_81; sum0_3[6 ] <=  i_38_62 + -i_39_40; sum0_4[6 ] <= -i_40_88 + -i_41_17; sum0_5[6 ] <=  i_42_77 +  i_43_68; sum0_6[6 ] <= -i_44_33 + -i_45_88; sum0_7[6 ] <= -i_46_25 +  i_47_73; 
                    sum0_0[7 ] <= i_32_88 +  i_33_25; sum0_1[7 ] <= -i_34_81 + -i_35_48; sum0_2[7 ] <=  i_36_68 +  i_37_68; sum0_3[7 ] <= -i_38_48 + -i_39_81; sum0_4[7 ] <=  i_40_25 +  i_41_88; sum0_5[7 ] <=            -i_43_88; sum0_6[7 ] <= -i_44_25 +  i_45_81; sum0_7[7 ] <=  i_46_48 + -i_47_68; 
                    sum0_0[8 ] <= i_32_88 + -i_33_8 ; sum0_1[8 ] <= -i_34_88 +  i_35_17; sum0_2[8 ] <=  i_36_87 + -i_37_25; sum0_3[8 ] <= -i_38_85 +  i_39_33; sum0_4[8 ] <=  i_40_81 + -i_41_40; sum0_5[8 ] <= -i_42_77 +  i_43_48; sum0_6[8 ] <=  i_44_73 + -i_45_55; sum0_7[8 ] <= -i_46_68 +  i_47_62; 
                    sum0_0[9 ] <= i_32_87 + -i_33_40; sum0_1[9 ] <= -i_34_68 +  i_35_73; sum0_2[9 ] <=  i_36_33 + -i_37_88; sum0_3[9 ] <=  i_38_8  +  i_39_85; sum0_4[9 ] <= -i_40_48 + -i_41_62; sum0_5[9 ] <=  i_42_77 +  i_43_25; sum0_6[9 ] <= -i_44_88 +  i_45_17; sum0_7[9 ] <=  i_46_81 + -i_47_55; 
                    sum0_0[10] <= i_32_81 + -i_33_68; sum0_1[10] <= -i_34_25 +  i_35_88; sum0_2[10] <= -i_36_48 + -i_37_48; sum0_3[10] <=  i_38_88 + -i_39_25; sum0_4[10] <= -i_40_68 +  i_41_81; sum0_5[10] <=            -i_43_81; sum0_6[10] <=  i_44_68 +  i_45_25; sum0_7[10] <= -i_46_88 +  i_47_48; 
                    sum0_0[11] <= i_32_73 + -i_33_85; sum0_1[11] <=  i_34_25 +  i_35_55; sum0_2[11] <= -i_36_88 +  i_37_48; sum0_3[11] <=  i_38_33 + -i_39_87; sum0_4[11] <=  i_40_68 +  i_41_8 ; sum0_5[11] <= -i_42_77 +  i_43_81; sum0_6[11] <= -i_44_17 + -i_45_62; sum0_7[11] <=  i_46_88 + -i_47_40; 
                    sum0_0[12] <= i_32_62 + -i_33_88; sum0_1[12] <=  i_34_68 + -i_35_8 ; sum0_2[12] <= -i_36_55 +  i_37_88; sum0_3[12] <= -i_38_73 +  i_39_17; sum0_4[12] <=  i_40_48 + -i_41_87; sum0_5[12] <=  i_42_77 + -i_43_25; sum0_6[12] <= -i_44_40 +  i_45_85; sum0_7[12] <= -i_46_81 +  i_47_33; 
                    sum0_0[13] <= i_32_48 + -i_33_81; sum0_1[13] <=  i_34_88 + -i_35_68; sum0_2[13] <=  i_36_25 +  i_37_25; sum0_3[13] <= -i_38_68 +  i_39_88; sum0_4[13] <= -i_40_81 +  i_41_48; sum0_5[13] <=            -i_43_48; sum0_6[13] <=  i_44_81 + -i_45_88; sum0_7[13] <=  i_46_68 + -i_47_25; 
                    sum0_0[14] <= i_32_33 + -i_33_62; sum0_1[14] <=  i_34_81 + -i_35_88; sum0_2[14] <=  i_36_85 + -i_37_68; sum0_3[14] <=  i_38_40 + -i_39_8 ; sum0_4[14] <= -i_40_25 +  i_41_55; sum0_5[14] <= -i_42_77 +  i_43_88; sum0_6[14] <= -i_44_87 +  i_45_73; sum0_7[14] <= -i_46_48 +  i_47_17; 
                    sum0_0[15] <= i_32_17 + -i_33_33; sum0_1[15] <=  i_34_48 + -i_35_62; sum0_2[15] <=  i_36_73 + -i_37_81; sum0_3[15] <=  i_38_87 + -i_39_88; sum0_4[15] <=  i_40_88 + -i_41_85; sum0_5[15] <=  i_42_77 + -i_43_68; sum0_6[15] <=  i_44_55 + -i_45_40; sum0_7[15] <=  i_46_25 + -i_47_8 ;

                    sum0_0[16] <= i_48_8  +  i_49_17; sum0_1[16] <=  i_50_25 +  i_51_33; sum0_2[16] <=  i_52_40 +  i_53_48; sum0_3[16] <=  i_54_55 +  i_55_62; sum0_4[16] <=  i_56_68 +  i_57_73; sum0_5[16] <=  i_58_77 +  i_59_81; sum0_6[16] <=  i_60_85 +  i_61_87; sum0_7[16] <=  i_62_88 +  i_63_88; 
                    sum0_0[17] <= i_48_25 +  i_49_48; sum0_1[17] <=  i_50_68 +  i_51_81; sum0_2[17] <=  i_52_88 +  i_53_88; sum0_3[17] <=  i_54_81 +  i_55_68; sum0_4[17] <=  i_56_48 +  i_57_25; sum0_5[17] <=            -i_59_25; sum0_6[17] <= -i_60_48 + -i_61_68; sum0_7[17] <= -i_62_81 + -i_63_88; 
                    sum0_0[18] <= i_48_40 +  i_49_73; sum0_1[18] <=  i_50_88 +  i_51_85; sum0_2[18] <=  i_52_62 +  i_53_25; sum0_3[18] <= -i_54_17 + -i_55_55; sum0_4[18] <= -i_56_81 + -i_57_88; sum0_5[18] <= -i_58_77 + -i_59_48; sum0_6[18] <= -i_60_8  +  i_61_33; sum0_7[18] <=  i_62_68 +  i_63_87; 
                    sum0_0[19] <= i_48_55 +  i_49_87; sum0_1[19] <=  i_50_81 +  i_51_40; sum0_2[19] <= -i_52_17 + -i_53_68; sum0_3[19] <= -i_54_88 + -i_55_73; sum0_4[19] <= -i_56_25 +  i_57_33; sum0_5[19] <=  i_58_77 +  i_59_88; sum0_6[19] <=  i_60_62 +  i_61_8 ; sum0_7[19] <= -i_62_48 + -i_63_85; 
                    sum0_0[20] <= i_48_68 +  i_49_88; sum0_1[20] <=  i_50_48 + -i_51_25; sum0_2[20] <= -i_52_81 + -i_53_81; sum0_3[20] <= -i_54_25 +  i_55_48; sum0_4[20] <=  i_56_88 +  i_57_68; sum0_5[20] <=            -i_59_68; sum0_6[20] <= -i_60_88 + -i_61_48; sum0_7[20] <=  i_62_25 +  i_63_81; 
                    sum0_0[21] <= i_48_77 +  i_49_77; sum0_1[21] <=            -i_51_77; sum0_2[21] <= -i_52_77           ; sum0_3[21] <=  i_54_77 +  i_55_77; sum0_4[21] <=            -i_57_77; sum0_5[21] <= -i_58_77           ; sum0_6[21] <=  i_60_77 +  i_61_77; sum0_7[21] <=            -i_63_77; 
                    sum0_0[22] <= i_48_85 +  i_49_55; sum0_1[22] <= -i_50_48 + -i_51_87; sum0_2[22] <= -i_52_8  +  i_53_81; sum0_3[22] <=  i_54_62 + -i_55_40; sum0_4[22] <= -i_56_88 + -i_57_17; sum0_5[22] <=  i_58_77 +  i_59_68; sum0_6[22] <= -i_60_33 + -i_61_88; sum0_7[22] <= -i_62_25 +  i_63_73; 
                    sum0_0[23] <= i_48_88 +  i_49_25; sum0_1[23] <= -i_50_81 + -i_51_48; sum0_2[23] <=  i_52_68 +  i_53_68; sum0_3[23] <= -i_54_48 + -i_55_81; sum0_4[23] <=  i_56_25 +  i_57_88; sum0_5[23] <=            -i_59_88; sum0_6[23] <= -i_60_25 +  i_61_81; sum0_7[23] <=  i_62_48 + -i_63_68; 
                    sum0_0[24] <= i_48_88 + -i_49_8 ; sum0_1[24] <= -i_50_88 +  i_51_17; sum0_2[24] <=  i_52_87 + -i_53_25; sum0_3[24] <= -i_54_85 +  i_55_33; sum0_4[24] <=  i_56_81 + -i_57_40; sum0_5[24] <= -i_58_77 +  i_59_48; sum0_6[24] <=  i_60_73 + -i_61_55; sum0_7[24] <= -i_62_68 +  i_63_62; 
                    sum0_0[25] <= i_48_87 + -i_49_40; sum0_1[25] <= -i_50_68 +  i_51_73; sum0_2[25] <=  i_52_33 + -i_53_88; sum0_3[25] <=  i_54_8  +  i_55_85; sum0_4[25] <= -i_56_48 + -i_57_62; sum0_5[25] <=  i_58_77 +  i_59_25; sum0_6[25] <= -i_60_88 +  i_61_17; sum0_7[25] <=  i_62_81 + -i_63_55; 
                    sum0_0[26] <= i_48_81 + -i_49_68; sum0_1[26] <= -i_50_25 +  i_51_88; sum0_2[26] <= -i_52_48 + -i_53_48; sum0_3[26] <=  i_54_88 + -i_55_25; sum0_4[26] <= -i_56_68 +  i_57_81; sum0_5[26] <=            -i_59_81; sum0_6[26] <=  i_60_68 +  i_61_25; sum0_7[26] <= -i_62_88 +  i_63_48; 
                    sum0_0[27] <= i_48_73 + -i_49_85; sum0_1[27] <=  i_50_25 +  i_51_55; sum0_2[27] <= -i_52_88 +  i_53_48; sum0_3[27] <=  i_54_33 + -i_55_87; sum0_4[27] <=  i_56_68 +  i_57_8 ; sum0_5[27] <= -i_58_77 +  i_59_81; sum0_6[27] <= -i_60_17 + -i_61_62; sum0_7[27] <=  i_62_88 + -i_63_40; 
                    sum0_0[28] <= i_48_62 + -i_49_88; sum0_1[28] <=  i_50_68 + -i_51_8 ; sum0_2[28] <= -i_52_55 +  i_53_88; sum0_3[28] <= -i_54_73 +  i_55_17; sum0_4[28] <=  i_56_48 + -i_57_87; sum0_5[28] <=  i_58_77 + -i_59_25; sum0_6[28] <= -i_60_40 +  i_61_85; sum0_7[28] <= -i_62_81 +  i_63_33; 
                    sum0_0[29] <= i_48_48 + -i_49_81; sum0_1[29] <=  i_50_88 + -i_51_68; sum0_2[29] <=  i_52_25 +  i_53_25; sum0_3[29] <= -i_54_68 +  i_55_88; sum0_4[29] <= -i_56_81 +  i_57_48; sum0_5[29] <=            -i_59_48; sum0_6[29] <=  i_60_81 + -i_61_88; sum0_7[29] <=  i_62_68 + -i_63_25; 
                    sum0_0[30] <= i_48_33 + -i_49_62; sum0_1[30] <=  i_50_81 + -i_51_88; sum0_2[30] <=  i_52_85 + -i_53_68; sum0_3[30] <=  i_54_40 + -i_55_8 ; sum0_4[30] <= -i_56_25 +  i_57_55; sum0_5[30] <= -i_58_77 +  i_59_88; sum0_6[30] <= -i_60_87 +  i_61_73; sum0_7[30] <= -i_62_48 +  i_63_17; 
                    sum0_0[31] <= i_48_17 + -i_49_33; sum0_1[31] <=  i_50_48 + -i_51_62; sum0_2[31] <=  i_52_73 + -i_53_81; sum0_3[31] <=  i_54_87 + -i_55_88; sum0_4[31] <=  i_56_88 + -i_57_85; sum0_5[31] <=  i_58_77 + -i_59_68; sum0_6[31] <=  i_60_55 + -i_61_40; sum0_7[31] <=  i_62_25 + -i_63_8 ; 
                end
                SIZE8  : begin
                    sum0_0[0 ] <= i_32_17 +  i_33_32; sum0_1[0 ] <=  i_34_46 +  i_35_60; sum0_2[0 ] <=  i_36_71 +  i_37_78; sum0_3[0 ] <=  i_38_85 +  i_39_86; 
                    sum0_0[1 ] <= i_32_46 +  i_33_78; sum0_1[1 ] <=  i_34_86 +  i_35_71; sum0_2[1 ] <=  i_36_32 + -i_37_17; sum0_3[1 ] <= -i_38_60 + -i_39_85; 
                    sum0_0[2 ] <= i_32_71 +  i_33_85; sum0_1[2 ] <=  i_34_32 + -i_35_46; sum0_2[2 ] <= -i_36_86 + -i_37_60; sum0_3[2 ] <=  i_38_17 +  i_39_78; 
                    sum0_0[3 ] <= i_32_85 +  i_33_46; sum0_1[3 ] <= -i_34_60 + -i_35_78; sum0_2[3 ] <=  i_36_17 +  i_37_86; sum0_3[3 ] <=  i_38_32 + -i_39_71; 
                    sum0_0[4 ] <= i_32_86 + -i_33_17; sum0_1[4 ] <= -i_34_85 +  i_35_32; sum0_2[4 ] <=  i_36_78 + -i_37_46; sum0_3[4 ] <= -i_38_71 +  i_39_60; 
                    sum0_0[5 ] <= i_32_78 + -i_33_71; sum0_1[5 ] <= -i_34_17 +  i_35_85; sum0_2[5 ] <= -i_36_60 + -i_37_32; sum0_3[5 ] <=  i_38_86 + -i_39_46; 
                    sum0_0[6 ] <= i_32_60 + -i_33_86; sum0_1[6 ] <=  i_34_71 + -i_35_17; sum0_2[6 ] <= -i_36_46 +  i_37_85; sum0_3[6 ] <= -i_38_78 +  i_39_32; 
                    sum0_0[7 ] <= i_32_32 + -i_33_60; sum0_1[7 ] <=  i_34_78 + -i_35_86; sum0_2[7 ] <=  i_36_85 + -i_37_71; sum0_3[7 ] <=  i_38_46 + -i_39_17; 

                    sum0_0[8 ] <= i_40_17 +  i_41_32; sum0_1[8 ] <=  i_42_46 +  i_43_60; sum0_2[8 ] <=  i_44_71 +  i_45_78; sum0_3[8 ] <=  i_46_85 +  i_47_86;
                    sum0_0[9 ] <= i_40_46 +  i_41_78; sum0_1[9 ] <=  i_42_86 +  i_43_71; sum0_2[9 ] <=  i_44_32 + -i_45_17; sum0_3[9 ] <= -i_46_60 + -i_47_85;
                    sum0_0[10] <= i_40_71 +  i_41_85; sum0_1[10] <=  i_42_32 + -i_43_46; sum0_2[10] <= -i_44_86 + -i_45_60; sum0_3[10] <=  i_46_17 +  i_47_78;
                    sum0_0[11] <= i_40_85 +  i_41_46; sum0_1[11] <= -i_42_60 + -i_43_78; sum0_2[11] <=  i_44_17 +  i_45_86; sum0_3[11] <=  i_46_32 + -i_47_71;
                    sum0_0[12] <= i_40_86 + -i_41_17; sum0_1[12] <= -i_42_85 +  i_43_32; sum0_2[12] <=  i_44_78 + -i_45_46; sum0_3[12] <= -i_46_71 +  i_47_60;
                    sum0_0[13] <= i_40_78 + -i_41_71; sum0_1[13] <= -i_42_17 +  i_43_85; sum0_2[13] <= -i_44_60 + -i_45_32; sum0_3[13] <=  i_46_86 + -i_47_46;
                    sum0_0[14] <= i_40_60 + -i_41_86; sum0_1[14] <=  i_42_71 + -i_43_17; sum0_2[14] <= -i_44_46 +  i_45_85; sum0_3[14] <= -i_46_78 +  i_47_32;
                    sum0_0[15] <= i_40_32 + -i_41_60; sum0_1[15] <=  i_42_78 + -i_43_86; sum0_2[15] <=  i_44_85 + -i_45_71; sum0_3[15] <=  i_46_46 + -i_47_17;

                    sum0_0[16] <= i_48_17 +  i_49_32; sum0_1[16] <=  i_50_46 +  i_51_60; sum0_2[16] <=  i_52_71 +  i_53_78; sum0_3[16] <=  i_54_85 +  i_55_86;
                    sum0_0[17] <= i_48_46 +  i_49_78; sum0_1[17] <=  i_50_86 +  i_51_71; sum0_2[17] <=  i_52_32 + -i_53_17; sum0_3[17] <= -i_54_60 + -i_55_85;
                    sum0_0[18] <= i_48_71 +  i_49_85; sum0_1[18] <=  i_50_32 + -i_51_46; sum0_2[18] <= -i_52_86 + -i_53_60; sum0_3[18] <=  i_54_17 +  i_55_78;
                    sum0_0[19] <= i_48_85 +  i_49_46; sum0_1[19] <= -i_50_60 + -i_51_78; sum0_2[19] <=  i_52_17 +  i_53_86; sum0_3[19] <=  i_54_32 + -i_55_71;
                    sum0_0[20] <= i_48_86 + -i_49_17; sum0_1[20] <= -i_50_85 +  i_51_32; sum0_2[20] <=  i_52_78 + -i_53_46; sum0_3[20] <= -i_54_71 +  i_55_60;
                    sum0_0[21] <= i_48_78 + -i_49_71; sum0_1[21] <= -i_50_17 +  i_51_85; sum0_2[21] <= -i_52_60 + -i_53_32; sum0_3[21] <=  i_54_86 + -i_55_46;
                    sum0_0[22] <= i_48_60 + -i_49_86; sum0_1[22] <=  i_50_71 + -i_51_17; sum0_2[22] <= -i_52_46 +  i_53_85; sum0_3[22] <= -i_54_78 +  i_55_32;
                    sum0_0[23] <= i_48_32 + -i_49_60; sum0_1[23] <=  i_50_78 + -i_51_86; sum0_2[23] <=  i_52_85 + -i_53_71; sum0_3[23] <=  i_54_46 + -i_55_17;

                    sum0_0[24] <= i_56_17 +  i_57_32; sum0_1[24] <=  i_58_46 +  i_59_60; sum0_2[24] <=  i_60_71 +  i_61_78; sum0_3[24] <=  i_62_85 +  i_63_86;
                    sum0_0[25] <= i_56_46 +  i_57_78; sum0_1[25] <=  i_58_86 +  i_59_71; sum0_2[25] <=  i_60_32 + -i_61_17; sum0_3[25] <= -i_62_60 + -i_63_85;
                    sum0_0[26] <= i_56_71 +  i_57_85; sum0_1[26] <=  i_58_32 + -i_59_46; sum0_2[26] <= -i_60_86 + -i_61_60; sum0_3[26] <=  i_62_17 +  i_63_78;
                    sum0_0[27] <= i_56_85 +  i_57_46; sum0_1[27] <= -i_58_60 + -i_59_78; sum0_2[27] <=  i_60_17 +  i_61_86; sum0_3[27] <=  i_62_32 + -i_63_71;
                    sum0_0[28] <= i_56_86 + -i_57_17; sum0_1[28] <= -i_58_85 +  i_59_32; sum0_2[28] <=  i_60_78 + -i_61_46; sum0_3[28] <= -i_62_71 +  i_63_60;
                    sum0_0[29] <= i_56_78 + -i_57_71; sum0_1[29] <= -i_58_17 +  i_59_85; sum0_2[29] <= -i_60_60 + -i_61_32; sum0_3[29] <=  i_62_86 + -i_63_46;
                    sum0_0[30] <= i_56_60 + -i_57_86; sum0_1[30] <=  i_58_71 + -i_59_17; sum0_2[30] <= -i_60_46 +  i_61_85; sum0_3[30] <= -i_62_78 +  i_63_32;
                    sum0_0[31] <= i_56_32 + -i_57_60; sum0_1[31] <=  i_58_78 + -i_59_86; sum0_2[31] <=  i_60_85 + -i_61_71; sum0_3[31] <=  i_62_46 + -i_63_17;
                end
                SIZE4  : begin
                    sum0_0[0 ] <= i_32_29 +  i_33_55; sum0_1[0 ] <=  i_34_74 +  i_35_84;
                    sum0_0[1 ] <= i_32_74 +  i_33_74; sum0_1[1 ] <=            -i_35_74;
                    sum0_0[2 ] <= i_32_84 + -i_33_29; sum0_1[2 ] <= -i_34_74 +  i_35_55;
                    sum0_0[3 ] <= i_32_55 + -i_33_84; sum0_1[3 ] <=  i_34_74 + -i_35_29;

                    sum0_0[4 ] <= i_36_29 +  i_37_55; sum0_1[4 ] <=  i_38_74 +  i_39_84;
                    sum0_0[5 ] <= i_36_74 +  i_37_74; sum0_1[5 ] <=            -i_39_74;
                    sum0_0[6 ] <= i_36_84 + -i_37_29; sum0_1[6 ] <= -i_38_74 +  i_39_55;
                    sum0_0[7 ] <= i_36_55 + -i_37_84; sum0_1[7 ] <=  i_38_74 + -i_39_29;

                    sum0_0[8 ] <= i_40_29 +  i_41_55; sum0_1[8 ] <=  i_42_74 +  i_43_84;
                    sum0_0[9 ] <= i_40_74 +  i_41_74; sum0_1[9 ] <=            -i_43_74;
                    sum0_0[10] <= i_40_84 + -i_41_29; sum0_1[10] <= -i_42_74 +  i_43_55;
                    sum0_0[11] <= i_40_55 + -i_41_84; sum0_1[11] <=  i_42_74 + -i_43_29;

                    sum0_0[12] <= i_44_29 +  i_45_55; sum0_1[12] <=  i_46_74 +  i_47_84;
                    sum0_0[13] <= i_44_74 +  i_45_74; sum0_1[13] <=            -i_47_74;
                    sum0_0[14] <= i_44_84 + -i_45_29; sum0_1[14] <= -i_46_74 +  i_47_55;
                    sum0_0[15] <= i_44_55 + -i_45_84; sum0_1[15] <=  i_46_74 + -i_47_29;

                    sum0_0[16] <= i_48_29 +  i_49_55; sum0_1[16] <=  i_50_74 +  i_51_84;
                    sum0_0[17] <= i_48_74 +  i_49_74; sum0_1[17] <=            -i_51_74;
                    sum0_0[18] <= i_48_84 + -i_49_29; sum0_1[18] <= -i_50_74 +  i_51_55;
                    sum0_0[19] <= i_48_55 + -i_49_84; sum0_1[19] <=  i_50_74 + -i_51_29;

                    sum0_0[20] <= i_52_29 +  i_53_55; sum0_1[20] <=  i_54_74 +  i_55_84;
                    sum0_0[21] <= i_52_74 +  i_53_74; sum0_1[21] <=            -i_55_74;
                    sum0_0[22] <= i_52_84 + -i_53_29; sum0_1[22] <= -i_54_74 +  i_55_55;
                    sum0_0[23] <= i_52_55 + -i_53_84; sum0_1[23] <=  i_54_74 + -i_55_29;

                    sum0_0[24] <= i_56_29 +  i_57_55; sum0_1[24] <=  i_58_74 +  i_59_84;
                    sum0_0[25] <= i_56_74 +  i_57_74; sum0_1[25] <=            -i_59_74;
                    sum0_0[26] <= i_56_84 + -i_57_29; sum0_1[26] <= -i_58_74 +  i_59_55;
                    sum0_0[27] <= i_56_55 + -i_57_84; sum0_1[27] <=  i_58_74 + -i_59_29;

                    sum0_0[28] <= i_60_29 +  i_61_55; sum0_1[28] <=  i_62_74 +  i_63_84;
                    sum0_0[29] <= i_60_74 +  i_61_74; sum0_1[29] <=            -i_63_74;
                    sum0_0[30] <= i_60_84 + -i_61_29; sum0_1[30] <= -i_62_74 +  i_63_55;
                    sum0_0[31] <= i_60_55 + -i_61_84; sum0_1[31] <=  i_62_74 + -i_63_29;
                end
            endcase
        end
    end
end

//stage 2
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_type_d2 <= 0;
        i_size_d2 <= 0;
        i_valid_d2 <= 0;
        for (i = 0; i < 32; i = i + 1) begin
            sum1_0[i] <= 0;
            sum1_1[i] <= 0;
        end
    end
    else begin
        i_type_d2 <= i_type_d1;
        i_size_d2 <= i_size_d1;
        i_valid_d2 <= i_valid_d1;
        if (i_type_d1 == DCT2) begin
            case (i_size_d1)
                SIZE64  : begin
                    for (i = 0; i < 2; i = i + 1) begin
                        sum1_0[16 * i] <= sum0_0[i];
                    end
                    for (i = 2; i < 4; i = i + 1) begin
                        sum1_0[16 * i - 24] <= sum0_0[i] + sum0_1[i];
                    end
                    for (i = 4; i < 8; i = i + 1) begin
                        sum1_0[8 * i - 28] <= (sum0_0[i] + sum0_1[i]) + (sum0_2[i] + sum0_3[i]);
                    end
                    for (i = 8; i < 16; i = i + 1) begin
                        sum1_0[4 * i - 30] <= ((sum0_0[i] + sum0_1[i]) + (sum0_2[i] + sum0_3[i])); 
                        sum1_1[4 * i - 30] <= ((sum0_4[i] + sum0_5[i]) + (sum0_6[i] + sum0_7[i]));
                    end
                    for (i = 16; i < 32; i = i + 1) begin
                        sum1_0[2 * i - 31] <= ((sum0_0[i] + sum0_1[i]) + (sum0_2[i] + sum0_3[i])) + ((sum0_4[i] + sum0_5[i]) + (sum0_6[i] + sum0_7[i]));
                        sum1_1[2 * i - 31] <= ((sum0_8[i - 16] + sum0_9[i - 16]) + (sum0_10[i - 16] + sum0_11[i - 16])) + ((sum0_12[i - 16] + sum0_13[i - 16]) + (sum0_14[i - 16] + sum0_15[i - 16]));
                    end
                end
                SIZE32  : begin
                    for (i = 0; i < 4; i = i + 1) begin
                        sum1_0[8 * i] <= sum0_0[i];
                    end
                    for (i = 4; i < 8; i = i + 1) begin
                        sum1_0[8 * i - 28] <= sum0_0[i] + sum0_1[i];
                    end
                    for (i = 8; i < 16; i = i + 1) begin
                        sum1_0[4 * i - 30] <= (sum0_0[i] + sum0_1[i]) + (sum0_2[i] + sum0_3[i]);
                    end
                    for (i = 16; i < 32; i = i + 1) begin
                        sum1_0[2 * i - 31] <= ((sum0_0[i] + sum0_1[i]) + (sum0_2[i] + sum0_3[i]));
                        sum1_1[2 * i - 31] <= ((sum0_4[i] + sum0_5[i]) + (sum0_6[i] + sum0_7[i]));
                    end
                end
                SIZE16 : begin
                    for (i = 0; i < 4; i = i + 1) begin
                        sum1_0[4 * i] <= sum0_0[i];
                        sum1_0[4 * i + 16] <= sum0_0[i + 16];
                    end
                    for (i = 4; i < 8; i = i + 1) begin
                        sum1_0[4 * i - 14] <= sum0_0[i] + sum0_1[i];
                        sum1_0[4 * i + 2] <= sum0_0[i + 16] + sum0_1[i + 16];
                    end
                    for (i = 8; i < 16; i = i + 1) begin
                        sum1_0[2 * i - 15] <= (sum0_0[i] + sum0_1[i]) + (sum0_2[i] + sum0_3[i]);
                        sum1_0[2 * i + 1] <= (sum0_0[i + 16] + sum0_1[i + 16]) + (sum0_2[i + 16] + sum0_3[i + 16]);
                    end
                end  
                SIZE8 : begin
                    for (i = 0; i < 4; i = i + 1) begin
                        sum1_0[2 * i] <= sum0_0[i];
                        sum1_0[2 * i + 8] <= sum0_0[i + 8];
                        sum1_0[2 * i + 16] <= sum0_0[i + 16];
                        sum1_0[2 * i + 24] <= sum0_0[i + 24];
                    end
                    for (i = 4; i < 8; i = i + 1) begin
                        sum1_0[2 * i - 7] <= sum0_0[i] + sum0_1[i];
                        sum1_0[2 * i + 1] <= sum0_0[i + 8] + sum0_1[i + 8];
                        sum1_0[2 * i + 9] <= sum0_0[i + 16] + sum0_1[i + 16];
                        sum1_0[2 * i + 17] <= sum0_0[i + 24] + sum0_1[i + 24];
                    end
                end  
                SIZE4 : begin
                    for (i = 0; i < 4; i = i + 1) begin
                        sum1_0[i] <= sum0_0[i];
                        sum1_0[i + 4] <= sum0_0[i + 4];
                        sum1_0[i + 8] <= sum0_0[i + 8];
                        sum1_0[i + 12] <= sum0_0[i + 12];
                        sum1_0[i + 16] <= sum0_0[i + 16];
                        sum1_0[i + 20] <= sum0_0[i + 20];
                        sum1_0[i + 24] <= sum0_0[i + 24];
                        sum1_0[i + 28] <= sum0_0[i + 28];
                    end
                end
            endcase
        end
        else begin
            case (i_size_d1)
                SIZE32  : begin
                    for (i = 0; i < 16; i = i + 1) begin
                        sum1_0[i] <= ((sum0_0[i] + sum0_1[i]) + (sum0_2[i] + sum0_3[i])) + ((sum0_4[i] + sum0_5[i]) + (sum0_6[i] + sum0_7[i]));
                        sum1_1[i] <= ((sum0_8[i] + sum0_9[i]) + (sum0_10[i] + sum0_11[i])) + ((sum0_12[i] + sum0_13[i]) + (sum0_14[i] + sum0_15[i]));
                    end
                end
                SIZE16 : begin
                    for (i = 0; i < 32; i = i + 1) begin
                        sum1_0[i] <= ((sum0_0[i] + sum0_1[i]) + (sum0_2[i] + sum0_3[i]));
                        sum1_1[i] <= ((sum0_4[i] + sum0_5[i]) + (sum0_6[i] + sum0_7[i]));
                    end
                end  
                SIZE8 : begin
                    for (i = 0; i < 32; i = i + 1) begin
                        sum1_0[i] <= (sum0_0[i] + sum0_1[i]) + (sum0_2[i] + sum0_3[i]);
                    end
                end  
                SIZE4 : begin
                    for (i = 0; i < 32; i = i + 1) begin
                        sum1_0[i] <= sum0_0[i] + sum0_1[i];
                    end
                end
            endcase
        end
    end
end

//stage 3
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        o_type <= 0;
        o_size <= 0;
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
        o_16 <= 0;
        o_17 <= 0;
        o_18 <= 0;
        o_19 <= 0;
        o_20 <= 0;
        o_21 <= 0;
        o_22 <= 0;
        o_23 <= 0;
        o_24 <= 0;
        o_25 <= 0;
        o_26 <= 0;
        o_27 <= 0;
        o_28 <= 0;
        o_29 <= 0;
        o_30 <= 0;
        o_31 <= 0;
    end
    else begin
        o_type <= i_type_d2;
        o_size <= i_size_d2;
        o_valid <= i_valid_d2;
        if (i_type_d2 == DCT2 && i_size_d2 == SIZE64) begin
            o_0  <= sum1_0[0 ];
            o_1  <= sum1_0[1 ] + sum1_1[1 ];
            o_2  <= sum1_0[2 ] + sum1_1[2 ];
            o_3  <= sum1_0[3 ] + sum1_1[3 ];
            o_4  <= sum1_0[4 ];
            o_5  <= sum1_0[5 ] + sum1_1[5 ];
            o_6  <= sum1_0[6 ] + sum1_1[6 ];
            o_7  <= sum1_0[7 ] + sum1_1[7 ];
            o_8  <= sum1_0[8 ];
            o_9  <= sum1_0[9 ] + sum1_1[9 ];
            o_10 <= sum1_0[10] + sum1_1[10];
            o_11 <= sum1_0[11] + sum1_1[11];
            o_12 <= sum1_0[12];
            o_13 <= sum1_0[13] + sum1_1[13];
            o_14 <= sum1_0[14] + sum1_1[14];
            o_15 <= sum1_0[15] + sum1_1[15];
            o_16 <= sum1_0[16];
            o_17 <= sum1_0[17] + sum1_1[17];
            o_18 <= sum1_0[18] + sum1_1[18];
            o_19 <= sum1_0[19] + sum1_1[19];
            o_20 <= sum1_0[20];
            o_21 <= sum1_0[21] + sum1_1[21];
            o_22 <= sum1_0[22] + sum1_1[22];
            o_23 <= sum1_0[23] + sum1_1[23];
            o_24 <= sum1_0[24];
            o_25 <= sum1_0[25] + sum1_1[25];
            o_26 <= sum1_0[26] + sum1_1[26];
            o_27 <= sum1_0[27] + sum1_1[27];
            o_28 <= sum1_0[28];
            o_29 <= sum1_0[29] + sum1_1[29];
            o_30 <= sum1_0[30] + sum1_1[30];
            o_31 <= sum1_0[31] + sum1_1[31];
        end
        else if (i_type_d2 == DCT2 && i_size_d2 == SIZE32) begin
            o_0  <= sum1_0[0 ];
            o_1  <= sum1_0[1 ] + sum1_1[1 ];
            o_2  <= sum1_0[2 ];
            o_3  <= sum1_0[3 ] + sum1_1[3 ];
            o_4  <= sum1_0[4 ];
            o_5  <= sum1_0[5 ] + sum1_1[5 ];
            o_6  <= sum1_0[6 ];
            o_7  <= sum1_0[7 ] + sum1_1[7 ];
            o_8  <= sum1_0[8 ];
            o_9  <= sum1_0[9 ] + sum1_1[9 ];
            o_10 <= sum1_0[10];
            o_11 <= sum1_0[11] + sum1_1[11];
            o_12 <= sum1_0[12];
            o_13 <= sum1_0[13] + sum1_1[13];
            o_14 <= sum1_0[14];
            o_15 <= sum1_0[15] + sum1_1[15];
            o_16 <= sum1_0[16];
            o_17 <= sum1_0[17] + sum1_1[17];
            o_18 <= sum1_0[18];
            o_19 <= sum1_0[19] + sum1_1[19];
            o_20 <= sum1_0[20];
            o_21 <= sum1_0[21] + sum1_1[21];
            o_22 <= sum1_0[22];
            o_23 <= sum1_0[23] + sum1_1[23];
            o_24 <= sum1_0[24];
            o_25 <= sum1_0[25] + sum1_1[25];
            o_26 <= sum1_0[26];
            o_27 <= sum1_0[27] + sum1_1[27];
            o_28 <= sum1_0[28];
            o_29 <= sum1_0[29] + sum1_1[29];
            o_30 <= sum1_0[30];
            o_31 <= sum1_0[31] + sum1_1[31];
        end
        else if ((i_type_d2 == DST7 || i_type_d2 == DCT8) && i_size_d2 == SIZE32) begin
            o_0  <= sum1_0[0 ] + sum1_1[0 ];
            o_1  <= sum1_0[1 ] + sum1_1[1 ];
            o_2  <= sum1_0[2 ] + sum1_1[2 ];
            o_3  <= sum1_0[3 ] + sum1_1[3 ];
            o_4  <= sum1_0[4 ] + sum1_1[4 ];
            o_5  <= sum1_0[5 ] + sum1_1[5 ];
            o_6  <= sum1_0[6 ] + sum1_1[6 ];
            o_7  <= sum1_0[7 ] + sum1_1[7 ];
            o_8  <= sum1_0[8 ] + sum1_1[8 ];
            o_9  <= sum1_0[9 ] + sum1_1[9 ];
            o_10 <= sum1_0[10] + sum1_1[10];
            o_11 <= sum1_0[11] + sum1_1[11];
            o_12 <= sum1_0[12] + sum1_1[12];
            o_13 <= sum1_0[13] + sum1_1[13];
            o_14 <= sum1_0[14] + sum1_1[14];
            o_15 <= sum1_0[15] + sum1_1[15];
            o_16 <= 0;
            o_17 <= 0;
            o_18 <= 0;
            o_19 <= 0;
            o_20 <= 0;
            o_21 <= 0;
            o_22 <= 0;
            o_23 <= 0;
            o_24 <= 0;
            o_25 <= 0;
            o_26 <= 0;
            o_27 <= 0;
            o_28 <= 0;
            o_29 <= 0;
            o_30 <= 0;
            o_31 <= 0;
        end
        else if ((i_type_d2 == DST7 || i_type_d2 == DCT8) && i_size_d2 == SIZE16) begin
            o_0  <= sum1_0[0 ] + sum1_1[0 ];
            o_1  <= sum1_0[1 ] + sum1_1[1 ];
            o_2  <= sum1_0[2 ] + sum1_1[2 ];
            o_3  <= sum1_0[3 ] + sum1_1[3 ];
            o_4  <= sum1_0[4 ] + sum1_1[4 ];
            o_5  <= sum1_0[5 ] + sum1_1[5 ];
            o_6  <= sum1_0[6 ] + sum1_1[6 ];
            o_7  <= sum1_0[7 ] + sum1_1[7 ];
            o_8  <= sum1_0[8 ] + sum1_1[8 ];
            o_9  <= sum1_0[9 ] + sum1_1[9 ];
            o_10 <= sum1_0[10] + sum1_1[10];
            o_11 <= sum1_0[11] + sum1_1[11];
            o_12 <= sum1_0[12] + sum1_1[12];
            o_13 <= sum1_0[13] + sum1_1[13];
            o_14 <= sum1_0[14] + sum1_1[14];
            o_15 <= sum1_0[15] + sum1_1[15];
            o_16 <= sum1_0[16] + sum1_1[16];
            o_17 <= sum1_0[17] + sum1_1[17];
            o_18 <= sum1_0[18] + sum1_1[18];
            o_19 <= sum1_0[19] + sum1_1[19];
            o_20 <= sum1_0[20] + sum1_1[20];
            o_21 <= sum1_0[21] + sum1_1[21];
            o_22 <= sum1_0[22] + sum1_1[22];
            o_23 <= sum1_0[23] + sum1_1[23];
            o_24 <= sum1_0[24] + sum1_1[24];
            o_25 <= sum1_0[25] + sum1_1[25];
            o_26 <= sum1_0[26] + sum1_1[26];
            o_27 <= sum1_0[27] + sum1_1[27];
            o_28 <= sum1_0[28] + sum1_1[28];
            o_29 <= sum1_0[29] + sum1_1[29];
            o_30 <= sum1_0[30] + sum1_1[30];
            o_31 <= sum1_0[31] + sum1_1[31];
        end
        else begin
            o_0  <= sum1_0[0 ];
            o_1  <= sum1_0[1 ];
            o_2  <= sum1_0[2 ];
            o_3  <= sum1_0[3 ];
            o_4  <= sum1_0[4 ];
            o_5  <= sum1_0[5 ];
            o_6  <= sum1_0[6 ];
            o_7  <= sum1_0[7 ];
            o_8  <= sum1_0[8 ];
            o_9  <= sum1_0[9 ];
            o_10 <= sum1_0[10];
            o_11 <= sum1_0[11];
            o_12 <= sum1_0[12];
            o_13 <= sum1_0[13];
            o_14 <= sum1_0[14];
            o_15 <= sum1_0[15];
            o_16 <= sum1_0[16];
            o_17 <= sum1_0[17];
            o_18 <= sum1_0[18];
            o_19 <= sum1_0[19];
            o_20 <= sum1_0[20];
            o_21 <= sum1_0[21];
            o_22 <= sum1_0[22];
            o_23 <= sum1_0[23];
            o_24 <= sum1_0[24];
            o_25 <= sum1_0[25];
            o_26 <= sum1_0[26];
            o_27 <= sum1_0[27];
            o_28 <= sum1_0[28];
            o_29 <= sum1_0[29];
            o_30 <= sum1_0[30];
            o_31 <= sum1_0[31];
        end
    end
end

endmodule
