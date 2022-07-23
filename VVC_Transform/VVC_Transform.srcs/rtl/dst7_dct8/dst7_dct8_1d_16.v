//describe  : 正序输入DST7，倒序输入DCT8(1/3/5/7/9/11/13/15输出反号)，大小为16
//input     : 16个像素残差
//output    : 16个系数
//delay     : 4 clk
module dst7_dct8_1d_16#(
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
    wire signed [IN_WIDTH - 1 : 0] i_data[0 : 15];
    reg signed [IN_WIDTH - 1 : 0] i_data_d1[0 : 15];
    reg i_valid_d1, i_valid_d2, i_valid_d3;;
//butterfly
    reg signed [IN_WIDTH + 10 : 0] a[0 : 4];
    reg signed [IN_WIDTH + 10 : 0] b[0 : 4];
    reg signed [IN_WIDTH + 10 : 0] c[0 : 4];
    reg signed [IN_WIDTH + 10 : 0] d[0 : 4];
    reg signed [IN_WIDTH + 10 : 0] t;

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

//butterfly
    wire signed [IN_WIDTH + 10 : 0] i_10_4 = i_10 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_10_3 = i_10_4 - i_10;
    wire signed [IN_WIDTH + 10 : 0] i_10_5 = i_10 + i_10_4;
    wire signed [IN_WIDTH + 10 : 0] i_10_80 = i_10_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] i_10_77 = i_10_80 - i_10_3;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d1 <= 0;
        for (i = 0; i < 5; i = i + 1) begin
            a[i] <= 0;
            b[i] <= 0;
            c[i] <= 0;
            d[i] <= 0;
        end
        t <= 0;
        for (i = 0; i < 16; i = i + 1) begin
            i_data_d1[i] <= 0;
        end
    end
    else begin
        i_valid_d1 <= i_valid;
        for (i = 0; i < 5; i = i + 1) begin
            a[i] <= i_data[    i] + i_data[11 + i];
            b[i] <= i_data[9 - i] + i_data[11 + i];
            c[i] <= i_data[    i] - i_data[ 9 - i];
            d[i] <= i_data[    i] + i_data[ 9 - i] - i_data[11 + i];
        end
        t <= i_10_77;
        for (i = 0; i < 16; i = i + 1) begin
            i_data_d1[i] <= i_data[i];
        end
    end
end

//mcm
//d : 25 48 68 81 88
    wire signed [IN_WIDTH + 10 : 0] d0_4 = d[0] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] d0_3 = d0_4 - d[0];
    wire signed [IN_WIDTH + 10 : 0] d0_16 = d[0] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] d0_17 = d[0] + d0_16;
    wire signed [IN_WIDTH + 10 : 0] d0_8 = d[0] <<< 3;
    wire signed [IN_WIDTH + 10 : 0] d0_11 = d0_3 + d0_8;
    wire signed [IN_WIDTH + 10 : 0] d0_24 = d0_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] d0_25 = d[0] + d0_24;
    wire signed [IN_WIDTH + 10 : 0] d0_64 = d[0] <<< 6;
    wire signed [IN_WIDTH + 10 : 0] d0_81 = d0_17 + d0_64;
    wire signed [IN_WIDTH + 10 : 0] d0_48 = d0_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] d0_68 = d0_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] d0_88 = d0_11 <<< 3;

    wire signed [IN_WIDTH + 10 : 0] d1_4 = d[1] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] d1_3 = d1_4 - d[1];
    wire signed [IN_WIDTH + 10 : 0] d1_16 = d[1] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] d1_17 = d[1] + d1_16;
    wire signed [IN_WIDTH + 10 : 0] d1_8 = d[1] <<< 3;
    wire signed [IN_WIDTH + 10 : 0] d1_11 = d1_3 + d1_8;
    wire signed [IN_WIDTH + 10 : 0] d1_24 = d1_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] d1_25 = d[1] + d1_24;
    wire signed [IN_WIDTH + 10 : 0] d1_64 = d[1] <<< 6;
    wire signed [IN_WIDTH + 10 : 0] d1_81 = d1_17 + d1_64;
    wire signed [IN_WIDTH + 10 : 0] d1_48 = d1_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] d1_68 = d1_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] d1_88 = d1_11 <<< 3;

    wire signed [IN_WIDTH + 10 : 0] d2_4 = d[2] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] d2_3 = d2_4 - d[2];
    wire signed [IN_WIDTH + 10 : 0] d2_16 = d[2] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] d2_17 = d[2] + d2_16;
    wire signed [IN_WIDTH + 10 : 0] d2_8 = d[2] <<< 3;
    wire signed [IN_WIDTH + 10 : 0] d2_11 = d2_3 + d2_8;
    wire signed [IN_WIDTH + 10 : 0] d2_24 = d2_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] d2_25 = d[2] + d2_24;
    wire signed [IN_WIDTH + 10 : 0] d2_64 = d[2] <<< 6;
    wire signed [IN_WIDTH + 10 : 0] d2_81 = d2_17 + d2_64;
    wire signed [IN_WIDTH + 10 : 0] d2_48 = d2_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] d2_68 = d2_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] d2_88 = d2_11 <<< 3;

    wire signed [IN_WIDTH + 10 : 0] d3_4 = d[3] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] d3_3 = d3_4 - d[3];
    wire signed [IN_WIDTH + 10 : 0] d3_16 = d[3] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] d3_17 = d[3] + d3_16;
    wire signed [IN_WIDTH + 10 : 0] d3_8 = d[3] <<< 3;
    wire signed [IN_WIDTH + 10 : 0] d3_11 = d3_3 + d3_8;
    wire signed [IN_WIDTH + 10 : 0] d3_24 = d3_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] d3_25 = d[3] + d3_24;
    wire signed [IN_WIDTH + 10 : 0] d3_64 = d[3] <<< 6;
    wire signed [IN_WIDTH + 10 : 0] d3_81 = d3_17 + d3_64;
    wire signed [IN_WIDTH + 10 : 0] d3_48 = d3_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] d3_68 = d3_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] d3_88 = d3_11 <<< 3;

    wire signed [IN_WIDTH + 10 : 0] d4_4 = d[4] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] d4_3 = d4_4 - d[4];
    wire signed [IN_WIDTH + 10 : 0] d4_16 = d[4] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] d4_17 = d[4] + d4_16;
    wire signed [IN_WIDTH + 10 : 0] d4_8 = d[4] <<< 3;
    wire signed [IN_WIDTH + 10 : 0] d4_11 = d4_3 + d4_8;
    wire signed [IN_WIDTH + 10 : 0] d4_24 = d4_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] d4_25 = d[4] + d4_24;
    wire signed [IN_WIDTH + 10 : 0] d4_64 = d[4] <<< 6;
    wire signed [IN_WIDTH + 10 : 0] d4_81 = d4_17 + d4_64;
    wire signed [IN_WIDTH + 10 : 0] d4_48 = d4_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] d4_68 = d4_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] d4_88 = d4_11 <<< 3;
//a[0] : 8 55 68 73 33 48 25 
    wire signed [IN_WIDTH + 10 : 0] a0_4 = a[0] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a0_3 = a0_4 - a[0];
    wire signed [IN_WIDTH + 10 : 0] a0_16 = a[0] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a0_17 = a[0] + a0_16;
    wire signed [IN_WIDTH + 10 : 0] a0_32 = a[0] <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a0_33 = a[0] + a0_32;
    wire signed [IN_WIDTH + 10 : 0] a0_24 = a0_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a0_25 = a[0] + a0_24;
    wire signed [IN_WIDTH + 10 : 0] a0_48 = a0_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a0_73 = a0_25 + a0_48;
    wire signed [IN_WIDTH + 10 : 0] a0_128 = a[0] <<< 7;
    wire signed [IN_WIDTH + 10 : 0] a0_55 = a0_128 - a0_73;
    wire signed [IN_WIDTH + 10 : 0] a0_8 = a[0] <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a0_68 = a0_17 <<< 2;
//b[0] : 73 48 33 8 25 55 68
    wire signed [IN_WIDTH + 10 : 0] b0_4 = b[0] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b0_3 = b0_4 - b[0];
    wire signed [IN_WIDTH + 10 : 0] b0_16 = b[0] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] b0_17 = b[0] + b0_16;
    wire signed [IN_WIDTH + 10 : 0] b0_32 = b[0] <<< 5;
    wire signed [IN_WIDTH + 10 : 0] b0_33 = b[0] + b0_32;
    wire signed [IN_WIDTH + 10 : 0] b0_24 = b0_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] b0_25 = b[0] + b0_24;
    wire signed [IN_WIDTH + 10 : 0] b0_48 = b0_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] b0_73 = b0_25 + b0_48;
    wire signed [IN_WIDTH + 10 : 0] b0_128 = b[0] <<< 7;
    wire signed [IN_WIDTH + 10 : 0] b0_55 = b0_128 - b0_73;
    wire signed [IN_WIDTH + 10 : 0] b0_8 = b[0] <<< 3;
    wire signed [IN_WIDTH + 10 : 0] b0_68 = b0_17 <<< 2;
//c[0] : 40 62 17 17
    wire signed [IN_WIDTH + 10 : 0] c0_4 = c[0] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] c0_5 = c[0] + c0_4;
    wire signed [IN_WIDTH + 10 : 0] c0_16 = c[0] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] c0_17 = c[0] + c0_16;
    wire signed [IN_WIDTH + 10 : 0] c0_32 = c[0] <<< 5;
    wire signed [IN_WIDTH + 10 : 0] c0_31 = c0_32 - c[0];
    wire signed [IN_WIDTH + 10 : 0] c0_40 = c0_5 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] c0_62 = c0_31 <<< 1;
//a[1] : 17 40 62 40
    wire signed [IN_WIDTH + 10 : 0] a1_4 = a[1] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a1_5 = a[1] + a1_4;
    wire signed [IN_WIDTH + 10 : 0] a1_16 = a[1] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a1_17 = a[1] + a1_16;
    wire signed [IN_WIDTH + 10 : 0] a1_32 = a[1] <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a1_31 = a1_32 - a[1];
    wire signed [IN_WIDTH + 10 : 0] a1_40 = a1_5 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a1_62 = a1_31 <<< 1;
//b[1] : 68 8 33 73 48 25 55
    wire signed [IN_WIDTH + 10 : 0] b1_4 = b[1] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b1_3 = b1_4 - b[1];
    wire signed [IN_WIDTH + 10 : 0] b1_16 = b[1] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] b1_17 = b[1] + b1_16;
    wire signed [IN_WIDTH + 10 : 0] b1_32 = b[1] <<< 5;
    wire signed [IN_WIDTH + 10 : 0] b1_33 = b[1] + b1_32;
    wire signed [IN_WIDTH + 10 : 0] b1_24 = b1_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] b1_25 = b[1] + b1_24;
    wire signed [IN_WIDTH + 10 : 0] b1_48 = b1_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] b1_73 = b1_25 + b1_48;
    wire signed [IN_WIDTH + 10 : 0] b1_128 = b[1] <<< 7;
    wire signed [IN_WIDTH + 10 : 0] b1_55 = b1_128 - b1_73;
    wire signed [IN_WIDTH + 10 : 0] b1_68 = b1_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b1_8 = b[1] <<< 3;
//c[1] : 73 25 55 8 68 48 33 
    wire signed [IN_WIDTH + 10 : 0] c1_4 = c[1] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] c1_3 = c1_4 - c[1];
    wire signed [IN_WIDTH + 10 : 0] c1_16 = c[1] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] c1_17 = c[1] + c1_16;
    wire signed [IN_WIDTH + 10 : 0] c1_32 = c[1] <<< 5;
    wire signed [IN_WIDTH + 10 : 0] c1_33 = c[1] + c1_32;
    wire signed [IN_WIDTH + 10 : 0] c1_24 = c1_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] c1_25 = c[1] + c1_24;
    wire signed [IN_WIDTH + 10 : 0] c1_48 = c1_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] c1_73 = c1_25 + c1_48;
    wire signed [IN_WIDTH + 10 : 0] c1_128 = c[1] <<< 7;
    wire signed [IN_WIDTH + 10 : 0] c1_55 = c1_128 - c1_73;
    wire signed [IN_WIDTH + 10 : 0] c1_8 = c[1] <<< 3;
    wire signed [IN_WIDTH + 10 : 0] c1_68 = c1_17 <<< 2;
//a[2] : 25 48 68 33 8 55 73
    wire signed [IN_WIDTH + 10 : 0] a2_4 = a[2] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a2_3 = a2_4 - a[2];
    wire signed [IN_WIDTH + 10 : 0] a2_16 = a[2] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a2_17 = a[2] + a2_16;
    wire signed [IN_WIDTH + 10 : 0] a2_32 = a[2] <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a2_33 = a[2] + a2_32;
    wire signed [IN_WIDTH + 10 : 0] a2_24 = a2_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a2_25 = a[2] + a2_24;
    wire signed [IN_WIDTH + 10 : 0] a2_48 = a2_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a2_73 = a2_25 + a2_48;
    wire signed [IN_WIDTH + 10 : 0] a2_128 = a[2] <<< 7;
    wire signed [IN_WIDTH + 10 : 0] a2_55 = a2_128 - a2_73;
    wire signed [IN_WIDTH + 10 : 0] a2_68 = a2_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a2_8 = a[2] <<< 3;
//b[2] : 62 40 17 62 40
    wire signed [IN_WIDTH + 10 : 0] b2_4 = b[2] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b2_5 = b[2] + b2_4;
    wire signed [IN_WIDTH + 10 : 0] b2_16 = b[2] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] b2_17 = b[2] + b2_16;
    wire signed [IN_WIDTH + 10 : 0] b2_32 = b[2] <<< 5;
    wire signed [IN_WIDTH + 10 : 0] b2_31 = b2_32 - b[2];
    wire signed [IN_WIDTH + 10 : 0] b2_62 = b2_31 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] b2_40 = b2_5 <<< 3;
//c[2] : 55 73 33 68 25 8 48
    wire signed [IN_WIDTH + 10 : 0] c2_4 = c[2] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] c2_3 = c2_4 - c[2];
    wire signed [IN_WIDTH + 10 : 0] c2_16 = c[2] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] c2_17 = c[2] + c2_16;
    wire signed [IN_WIDTH + 10 : 0] c2_32 = c[2] <<< 5;
    wire signed [IN_WIDTH + 10 : 0] c2_33 = c[2] + c2_32;
    wire signed [IN_WIDTH + 10 : 0] c2_24 = c2_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] c2_25 = c[2] + c2_24;
    wire signed [IN_WIDTH + 10 : 0] c2_48 = c2_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] c2_73 = c2_25 + c2_48;
    wire signed [IN_WIDTH + 10 : 0] c2_128 = c[2] <<< 7;
    wire signed [IN_WIDTH + 10 : 0] c2_55 = c2_128 - c2_73;
    wire signed [IN_WIDTH + 10 : 0] c2_68 = c2_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] c2_8 = c[2] <<< 3;
//a[3] : 33 73 55 8 68 25 48 
    wire signed [IN_WIDTH + 10 : 0] a3_4 = a[3] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a3_3 = a3_4 - a[3];
    wire signed [IN_WIDTH + 10 : 0] a3_16 = a[3] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a3_17 = a[3] + a3_16;
    wire signed [IN_WIDTH + 10 : 0] a3_32 = a[3] <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a3_33 = a[3] + a3_32;
    wire signed [IN_WIDTH + 10 : 0] a3_24 = a3_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a3_25 = a[3] + a3_24;
    wire signed [IN_WIDTH + 10 : 0] a3_48 = a3_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a3_73 = a3_25 + a3_48;
    wire signed [IN_WIDTH + 10 : 0] a3_128 = a[3] <<< 7;
    wire signed [IN_WIDTH + 10 : 0] a3_55 = a3_128 - a3_73;
    wire signed [IN_WIDTH + 10 : 0] a3_8 = a[3] <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a3_68 = a3_17 <<< 2;
//b[3] : 55 48 68 8 33 73 25
    wire signed [IN_WIDTH + 10 : 0] b3_4 = b[3] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b3_3 = b3_4 - b[3];
    wire signed [IN_WIDTH + 10 : 0] b3_16 = b[3] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] b3_17 = b[3] + b3_16;
    wire signed [IN_WIDTH + 10 : 0] b3_32 = b[3] <<< 5;
    wire signed [IN_WIDTH + 10 : 0] b3_33 = b[3] + b3_32;
    wire signed [IN_WIDTH + 10 : 0] b3_24 = b3_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] b3_25 = b[3] + b3_24;
    wire signed [IN_WIDTH + 10 : 0] b3_48 = b3_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] b3_73 = b3_25 + b3_48;
    wire signed [IN_WIDTH + 10 : 0] b3_128 = b[3] <<< 7;
    wire signed [IN_WIDTH + 10 : 0] b3_55 = b3_128 - b3_73;
    wire signed [IN_WIDTH + 10 : 0] b3_68 = b3_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b3_8 = b[3] <<< 3;
//c[3] : 17 40 62
    wire signed [IN_WIDTH + 10 : 0] c3_4 = c[3] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] c3_5 = c[3] + c3_4;
    wire signed [IN_WIDTH + 10 : 0] c3_16 = c[3] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] c3_17 = c[3] + c3_16;
    wire signed [IN_WIDTH + 10 : 0] c3_32 = c[3] <<< 5;
    wire signed [IN_WIDTH + 10 : 0] c3_31 = c3_32 - c[3];
    wire signed [IN_WIDTH + 10 : 0] c3_40 = c3_5 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] c3_62 = c3_31 <<< 1;
//a[4] : 40 62 17
    wire signed [IN_WIDTH + 10 : 0] a4_4 = a[4] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] a4_5 = a[4] + a4_4;
    wire signed [IN_WIDTH + 10 : 0] a4_16 = a[4] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] a4_17 = a[4] + a4_16;
    wire signed [IN_WIDTH + 10 : 0] a4_32 = a[4] <<< 5;
    wire signed [IN_WIDTH + 10 : 0] a4_31 = a4_32 - a[4];
    wire signed [IN_WIDTH + 10 : 0] a4_40 = a4_5 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] a4_62 = a4_31 <<< 1;
//b[4] : 48 25 68 73 55 33 8
    wire signed [IN_WIDTH + 10 : 0] b4_4 = b[4] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b4_3 = b4_4 - b[4];
    wire signed [IN_WIDTH + 10 : 0] b4_16 = b[4] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] b4_17 = b[4] + b4_16;
    wire signed [IN_WIDTH + 10 : 0] b4_32 = b[4] <<< 5;
    wire signed [IN_WIDTH + 10 : 0] b4_33 = b[4] + b4_32;
    wire signed [IN_WIDTH + 10 : 0] b4_24 = b4_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] b4_25 = b[4] + b4_24;
    wire signed [IN_WIDTH + 10 : 0] b4_48 = b4_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] b4_73 = b4_25 + b4_48;
    wire signed [IN_WIDTH + 10 : 0] b4_128 = b[4] <<< 7;
    wire signed [IN_WIDTH + 10 : 0] b4_55 = b4_128 - b4_73;
    wire signed [IN_WIDTH + 10 : 0] b4_68 = b4_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] b4_8 = b[4] <<< 3;
//c[4] : 8 25 33 48 55 68 73
    wire signed [IN_WIDTH + 10 : 0] c4_4 = c[4] <<< 2;
    wire signed [IN_WIDTH + 10 : 0] c4_3 = c4_4 - c[4];
    wire signed [IN_WIDTH + 10 : 0] c4_16 = c[4] <<< 4;
    wire signed [IN_WIDTH + 10 : 0] c4_17 = c[4] + c4_16;
    wire signed [IN_WIDTH + 10 : 0] c4_32 = c[4] <<< 5;
    wire signed [IN_WIDTH + 10 : 0] c4_33 = c[4] + c4_32;
    wire signed [IN_WIDTH + 10 : 0] c4_24 = c4_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] c4_25 = c[4] + c4_24;
    wire signed [IN_WIDTH + 10 : 0] c4_48 = c4_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] c4_73 = c4_25 + c4_48;
    wire signed [IN_WIDTH + 10 : 0] c4_128 = c[4] <<< 7;
    wire signed [IN_WIDTH + 10 : 0] c4_55 = c4_128 - c4_73;
    wire signed [IN_WIDTH + 10 : 0] c4_8 = c[4] <<< 3;
    wire signed [IN_WIDTH + 10 : 0] c4_68 = c4_17 <<< 2;

//sum
    reg signed  [IN_WIDTH + 10 : 0] sum0_0[0 : 15], sum0_1[0 : 15], sum0_2[0 : 15], sum0_3[0 : 15], sum0_4[0 : 15], sum0_5[0 : 15];
    reg signed  [IN_WIDTH + 10 : 0] sum1_0[0 : 15], sum1_1[0 : 15];
//stage 1
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d2 <= 0;
        for (i = 0; i < 16; i = i + 1) begin
            sum0_0[i] <= 0; sum0_1[i] <= 0; sum0_2[i] <= 0; sum0_3[i] <= 0; sum0_4[i] <= 0; sum0_5[i] <= 0; 
        end
    end
    else begin
        i_valid_d2 <= i_valid_d1;
        sum0_0[0 ] <= a0_8  + b0_73; sum0_1[0 ] <= a1_17 + b1_68;  sum0_2[0 ] <= a2_25 + b2_62;  sum0_3[0 ] <= a3_33 + b3_55;  sum0_4[0 ] <= a4_40 + b4_48;      sum0_5[0 ] <= t;
        sum0_0[1 ] <= d0_25;         sum0_1[1 ] <= d1_48;          sum0_2[1 ] <= d2_68;          sum0_3[1 ] <= d3_81;          sum0_4[1 ] <= d4_88;              
        sum0_0[2 ] <= c0_40 - b0_48; sum0_1[2 ] <= c1_73 - b1_8 ;  sum0_2[2 ] <= c2_55 + a2_33;  sum0_3[2 ] <= c3_17 + a3_68;  sum0_4[2 ] <= a4_62 + b4_25;      sum0_5[2 ] <= - t;
        sum0_0[3 ] <= a0_55 + b0_33; sum0_1[3 ] <= c1_25 + a1_62;  sum0_2[3 ] <= c2_73 + a2_8 ;  sum0_3[3 ] <= c3_40 - b3_48;  sum0_4[3 ] <= -a4_17 - b4_68;     sum0_5[3 ] <= t;
        sum0_0[4 ] <= d0_68;         sum0_1[4 ] <= d1_88;          sum0_2[4 ] <= d2_48;          sum0_3[4 ] <= -d3_25;         sum0_4[4 ] <= -d4_81;             
        sum0_0[5 ] <= i_data_d1[0] + i_data_d1[1]; sum0_1[5 ] <= - i_data_d1[3] - i_data_d1[4]; sum0_2[5 ] <= i_data_d1[6] + i_data_d1[7]; sum0_3[5 ] <= - i_data_d1[9] - i_data_d1[10]; sum0_4[5 ] <= i_data_d1[12] + i_data_d1[13] - i_data_d1[15]; 
        sum0_0[6 ] <= a0_68 + c0_17; sum0_1[6 ] <= c1_55 - b1_33;  sum0_2[6 ] <= -a2_48 - b2_40; sum0_3[6 ] <= -c3_62 - a3_25; sum0_4[6 ] <= -c4_8 + b4_73;      sum0_5[6 ] <= t;
        sum0_0[7 ] <= d0_88;         sum0_1[7 ] <= d1_25;          sum0_2[7 ] <= -d2_81;         sum0_3[7 ] <= - d3_48;        sum0_4[7 ] <= d4_68;              
        sum0_0[8 ] <= c0_40 + a0_48; sum0_1[8 ] <= -c1_8 + b1_73;  sum0_2[8 ] <= -c2_33 - a2_55; sum0_3[8 ] <= c3_17 - b3_68;  sum0_4[8 ] <= c4_25 + a4_62;      sum0_5[8 ] <= - t;
        sum0_0[9 ] <= c0_62 + a0_25; sum0_1[9 ] <= -a1_40 - b1_48; sum0_2[9 ] <= -c2_68 + b2_17; sum0_3[9 ] <= a3_73 + b3_8;   sum0_4[9 ] <= c4_33 - b4_55;      sum0_5[9 ] <= t;
        sum0_0[10] <= d0_81;         sum0_1[10] <= - d1_68;        sum0_2[10] <= - d2_25;        sum0_3[10] <= d3_88;          sum0_4[10] <= - d4_48;              
        sum0_0[11] <= a0_73 + b0_8;  sum0_1[11] <= -c1_68 - a1_17; sum0_2[11] <= c2_25 - b2_62;  sum0_3[11] <= a3_55 + b3_33;  sum0_4[11] <= -c4_48 - a4_40;     sum0_5[11] <= - t;
        sum0_0[12] <= c0_62 - b0_25; sum0_1[12] <= -c1_48 - a1_40; sum0_2[12] <= a2_68 + b2_17;  sum0_3[12] <= -a3_8 - b3_73;  sum0_4[12] <= -c4_55 + b4_33;     sum0_5[12] <= t;
        sum0_0[13] <= d0_48;         sum0_1[13] <= - d1_81;        sum0_2[13] <= d2_88;          sum0_3[13] <= - d3_68;        sum0_4[13] <= d4_25;              
        sum0_0[14] <= a0_33 + b0_55; sum0_1[14] <= -a1_62 - b1_25; sum0_2[14] <= c2_8 + a2_73;   sum0_3[14] <= -c3_40 - a3_48; sum0_4[14] <= c4_68 + a4_17;      sum0_5[14] <= - t;
        sum0_0[15] <= c0_17 - b0_68; sum0_1[15] <= -c1_33 + b1_55; sum0_2[15] <= c2_48 - b2_40;  sum0_3[15] <= -c3_62 + b3_25; sum0_4[15] <= c4_73 - b4_8;       sum0_5[15] <= t;
    end
end
//stage 2
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d3 <= 0;
        for (i = 0; i < 16; i = i + 1) begin
            sum1_0[i] <= 0; sum1_1[i] <= 0;
        end
    end
    else begin
        i_valid_d3 <= i_valid_d2;
        sum1_0[0 ] <= sum0_0[0 ] + sum0_1[0 ] + sum0_2[0 ]; sum1_1[0 ] <= sum0_3[0 ] + sum0_4[0 ] + sum0_5[0 ];
        sum1_0[1 ] <= sum0_0[1 ] + sum0_1[1 ] + sum0_2[1 ]; sum1_1[1 ] <= sum0_3[1 ] + sum0_4[1 ];
        sum1_0[2 ] <= sum0_0[2 ] + sum0_1[2 ] + sum0_2[2 ]; sum1_1[2 ] <= sum0_3[2 ] + sum0_4[2 ] + sum0_5[2 ];
        sum1_0[3 ] <= sum0_0[3 ] + sum0_1[3 ] + sum0_2[3 ]; sum1_1[3 ] <= sum0_3[3 ] + sum0_4[3 ] + sum0_5[3 ];
        sum1_0[4 ] <= sum0_0[4 ] + sum0_1[4 ] + sum0_2[4 ]; sum1_1[4 ] <= sum0_3[4 ] + sum0_4[4 ];
        sum1_0[5 ] <= sum0_0[5 ] + sum0_1[5 ] + sum0_2[5 ]; sum1_1[5 ] <= sum0_3[5 ] + sum0_4[5 ];
        sum1_0[6 ] <= sum0_0[6 ] + sum0_1[6 ] + sum0_2[6 ]; sum1_1[6 ] <= sum0_3[6 ] + sum0_4[6 ] + sum0_5[6 ];
        sum1_0[7 ] <= sum0_0[7 ] + sum0_1[7 ] + sum0_2[7 ]; sum1_1[7 ] <= sum0_3[7 ] + sum0_4[7 ];
        sum1_0[8 ] <= sum0_0[8 ] + sum0_1[8 ] + sum0_2[8 ]; sum1_1[8 ] <= sum0_3[8 ] + sum0_4[8 ] + sum0_5[8 ];
        sum1_0[9 ] <= sum0_0[9 ] + sum0_1[9 ] + sum0_2[9 ]; sum1_1[9 ] <= sum0_3[9 ] + sum0_4[9 ] + sum0_5[9 ];
        sum1_0[10] <= sum0_0[10] + sum0_1[10] + sum0_2[10]; sum1_1[10] <= sum0_3[10] + sum0_4[10];
        sum1_0[11] <= sum0_0[11] + sum0_1[11] + sum0_2[11]; sum1_1[11] <= sum0_3[11] + sum0_4[11] + sum0_5[11];
        sum1_0[12] <= sum0_0[12] + sum0_1[12] + sum0_2[12]; sum1_1[12] <= sum0_3[12] + sum0_4[12] + sum0_5[12];
        sum1_0[13] <= sum0_0[13] + sum0_1[13] + sum0_2[13]; sum1_1[13] <= sum0_3[13] + sum0_4[13];
        sum1_0[14] <= sum0_0[14] + sum0_1[14] + sum0_2[14]; sum1_1[14] <= sum0_3[14] + sum0_4[14] + sum0_5[14];
        sum1_0[15] <= sum0_0[15] + sum0_1[15] + sum0_2[15]; sum1_1[15] <= sum0_3[15] + sum0_4[15] + sum0_5[15];
    end
end

    wire signed [IN_WIDTH + 10 : 0] o_data_5 = sum1_0[5 ] + sum1_1[5 ];
    wire signed [IN_WIDTH + 10 : 0] o_data_5_4 = o_data_5 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] o_data_5_3 = o_data_5_4 - o_data_5;
    wire signed [IN_WIDTH + 10 : 0] o_data_5_5 = o_data_5 + o_data_5_4;
    wire signed [IN_WIDTH + 10 : 0] o_data_5_80 = o_data_5_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] o_data_5_77 = o_data_5_80 - o_data_5_3;
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
        o_valid <= i_valid_d3;
        o_0  <= sum1_0[0 ] + sum1_1[0 ];
        o_1  <= sum1_0[1 ] + sum1_1[1 ];
        o_2  <= sum1_0[2 ] + sum1_1[2 ];
        o_3  <= sum1_0[3 ] + sum1_1[3 ];
        o_4  <= sum1_0[4 ] + sum1_1[4 ];
        o_5  <= o_data_5_77;
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
    end
end

endmodule
