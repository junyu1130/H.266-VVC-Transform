//describe  : 用于DCT2生成蝶形运算单元
//input     : 64个原数据
//output    : 64个蝶形运算单元
//delay     : 1 clk
module dct2_butterfly#(
    parameter IN_WIDTH = 16
)
(
//system input
    input                                   clk     ,
    input                                   rst_n   ,
//input parameter
    input               [2 : 0]             i_size  ,//1:4x4, 2:8x8, 3:16x16, 4:32x32, 5:64x64
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
    input       signed  [IN_WIDTH - 1 : 0]  i_32    ,
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
    output reg          [2 : 0]             o_size  ,
//output data
    output reg                              o_valid ,
    output reg  signed  [IN_WIDTH + 4 : 0]  o_0     ,//4 21bit
    output reg  signed  [IN_WIDTH + 4 : 0]  o_1     ,
    output reg  signed  [IN_WIDTH + 4 : 0]  o_2     ,
    output reg  signed  [IN_WIDTH + 4 : 0]  o_3     ,
    output reg  signed  [IN_WIDTH + 3 : 0]  o_4     ,//4 8 20bit
    output reg  signed  [IN_WIDTH + 3 : 0]  o_5     ,
    output reg  signed  [IN_WIDTH + 3 : 0]  o_6     ,
    output reg  signed  [IN_WIDTH + 3 : 0]  o_7     ,
    output reg  signed  [IN_WIDTH + 2 : 0]  o_8     ,//4 8 16 19bit
    output reg  signed  [IN_WIDTH + 2 : 0]  o_9     ,
    output reg  signed  [IN_WIDTH + 2 : 0]  o_10    ,
    output reg  signed  [IN_WIDTH + 2 : 0]  o_11    ,
    output reg  signed  [IN_WIDTH + 2 : 0]  o_12    ,
    output reg  signed  [IN_WIDTH + 2 : 0]  o_13    ,
    output reg  signed  [IN_WIDTH + 2 : 0]  o_14    ,
    output reg  signed  [IN_WIDTH + 2 : 0]  o_15    ,
    output reg  signed  [IN_WIDTH + 1 : 0]  o_16    ,//4 8 16 32 18bit
    output reg  signed  [IN_WIDTH + 1 : 0]  o_17    ,
    output reg  signed  [IN_WIDTH + 1 : 0]  o_18    ,
    output reg  signed  [IN_WIDTH + 1 : 0]  o_19    ,
    output reg  signed  [IN_WIDTH + 1 : 0]  o_20    ,
    output reg  signed  [IN_WIDTH + 1 : 0]  o_21    ,
    output reg  signed  [IN_WIDTH + 1 : 0]  o_22    ,
    output reg  signed  [IN_WIDTH + 1 : 0]  o_23    ,
    output reg  signed  [IN_WIDTH + 1 : 0]  o_24    ,
    output reg  signed  [IN_WIDTH + 1 : 0]  o_25    ,
    output reg  signed  [IN_WIDTH + 1 : 0]  o_26    ,
    output reg  signed  [IN_WIDTH + 1 : 0]  o_27    ,
    output reg  signed  [IN_WIDTH + 1 : 0]  o_28    ,
    output reg  signed  [IN_WIDTH + 1 : 0]  o_29    ,
    output reg  signed  [IN_WIDTH + 1 : 0]  o_30    ,
    output reg  signed  [IN_WIDTH + 1 : 0]  o_31    ,
    output reg  signed  [IN_WIDTH + 1 : 0]  o_32    ,
    output reg  signed  [IN_WIDTH     : 0]  o_33    ,//64 17bit
    output reg  signed  [IN_WIDTH     : 0]  o_34    ,
    output reg  signed  [IN_WIDTH     : 0]  o_35    ,
    output reg  signed  [IN_WIDTH     : 0]  o_36    ,
    output reg  signed  [IN_WIDTH     : 0]  o_37    ,
    output reg  signed  [IN_WIDTH     : 0]  o_38    ,
    output reg  signed  [IN_WIDTH     : 0]  o_39    ,
    output reg  signed  [IN_WIDTH     : 0]  o_40    ,
    output reg  signed  [IN_WIDTH     : 0]  o_41    ,
    output reg  signed  [IN_WIDTH     : 0]  o_42    ,
    output reg  signed  [IN_WIDTH     : 0]  o_43    ,
    output reg  signed  [IN_WIDTH     : 0]  o_44    ,
    output reg  signed  [IN_WIDTH     : 0]  o_45    ,
    output reg  signed  [IN_WIDTH     : 0]  o_46    ,
    output reg  signed  [IN_WIDTH     : 0]  o_47    ,
    output reg  signed  [IN_WIDTH     : 0]  o_48    ,
    output reg  signed  [IN_WIDTH     : 0]  o_49    ,
    output reg  signed  [IN_WIDTH     : 0]  o_50    ,
    output reg  signed  [IN_WIDTH     : 0]  o_51    ,
    output reg  signed  [IN_WIDTH     : 0]  o_52    ,
    output reg  signed  [IN_WIDTH     : 0]  o_53    ,
    output reg  signed  [IN_WIDTH     : 0]  o_54    ,
    output reg  signed  [IN_WIDTH     : 0]  o_55    ,
    output reg  signed  [IN_WIDTH     : 0]  o_56    ,
    output reg  signed  [IN_WIDTH     : 0]  o_57    ,
    output reg  signed  [IN_WIDTH     : 0]  o_58    ,
    output reg  signed  [IN_WIDTH     : 0]  o_59    ,
    output reg  signed  [IN_WIDTH     : 0]  o_60    ,
    output reg  signed  [IN_WIDTH     : 0]  o_61    ,
    output reg  signed  [IN_WIDTH     : 0]  o_62    ,
    output reg  signed  [IN_WIDTH     : 0]  o_63    
);

localparam  SIZE4  = 3'd1,
            SIZE8  = 3'd2,
            SIZE16 = 3'd3,
            SIZE32 = 3'd4,
            SIZE64 = 3'd5;
integer i;

//input
    wire signed [IN_WIDTH - 1 : 0] i_data[0 : 63];
//butterfly 
    reg  signed [IN_WIDTH - 1 : 0] butterfly64_in_u0[0 : 63], butterfly16_in_u1[0 : 15], butterfly8_in_u2[0 : 7], butterfly8_in_u3[0 : 7], butterfly4_in_u4[0 : 3], butterfly4_in_u5[0 : 3], butterfly4_in_u6[0 : 3], butterfly4_in_u7[0 : 3];
    reg  signed [IN_WIDTH     : 0] butterfly32_in_u0[0 : 31], butterfly8_in_u1[0 : 7], butterfly4_in_u2[0 : 3], butterfly4_in_u3[0 : 3];
    reg  signed [IN_WIDTH + 1 : 0] butterfly16_in_u0[0 : 15], butterfly4_in_u1[0 : 3];
    reg  signed [IN_WIDTH + 2 : 0] butterfly8_in_u0[0 : 7];
    reg  signed [IN_WIDTH + 3 : 0] butterfly4_in_u0[0 : 3];
    wire signed [IN_WIDTH     : 0] butterfly64_out_u0[0 : 63], butterfly16_out_u1[0 : 15], butterfly8_out_u2[0 : 7], butterfly8_out_u3[0 : 7], butterfly4_out_u4[0 : 3], butterfly4_out_u5[0 : 3], butterfly4_out_u6[0 : 3], butterfly4_out_u7[0 : 3];
    wire signed [IN_WIDTH + 1 : 0] butterfly32_out_u0[0 : 31], butterfly8_out_u1[0 : 7], butterfly4_out_u2[0 : 3], butterfly4_out_u3[0 : 3];
    wire signed [IN_WIDTH + 2 : 0] butterfly16_out_u0[0 : 15], butterfly4_out_u1[0 : 3];
    wire signed [IN_WIDTH + 3 : 0] butterfly8_out_u0[0 : 7];
    wire signed [IN_WIDTH + 4 : 0] butterfly4_out_u0[0 : 3];

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
    assign i_data[32] = i_32;
    assign i_data[33] = i_33;
    assign i_data[34] = i_34;
    assign i_data[35] = i_35;
    assign i_data[36] = i_36;
    assign i_data[37] = i_37;
    assign i_data[38] = i_38;
    assign i_data[39] = i_39;
    assign i_data[40] = i_40;
    assign i_data[41] = i_41;
    assign i_data[42] = i_42;
    assign i_data[43] = i_43;
    assign i_data[44] = i_44;
    assign i_data[45] = i_45;
    assign i_data[46] = i_46;
    assign i_data[47] = i_47;
    assign i_data[48] = i_48;
    assign i_data[49] = i_49;
    assign i_data[50] = i_50;
    assign i_data[51] = i_51;
    assign i_data[52] = i_52;
    assign i_data[53] = i_53;
    assign i_data[54] = i_54;
    assign i_data[55] = i_55;
    assign i_data[56] = i_56;
    assign i_data[57] = i_57;
    assign i_data[58] = i_58;
    assign i_data[59] = i_59;
    assign i_data[60] = i_60;
    assign i_data[61] = i_61;
    assign i_data[62] = i_62;
    assign i_data[63] = i_63;

//butterfly in
always @(*) begin
    for (i = 0; i < 64; i = i + 1) begin
        butterfly64_in_u0[i] <= 0;
    end
    for (i = 0; i < 32; i = i + 1) begin
        butterfly32_in_u0[i] <= 0;
    end
    for (i = 0; i < 16; i = i + 1) begin
        butterfly16_in_u0[i] <= 0; butterfly16_in_u1[i] <= 0;
    end
    for (i = 0; i < 8; i = i + 1) begin
        butterfly8_in_u0[i] <= 0; butterfly8_in_u1[i] <= 0; butterfly8_in_u2[i] <= 0; butterfly8_in_u3[i] <= 0;
    end
    for (i = 0; i < 4; i = i + 1) begin
        butterfly4_in_u0[i] <= 0; butterfly4_in_u1[i] <= 0; butterfly4_in_u2[i] <= 0; butterfly4_in_u3[i] <= 0;
        butterfly4_in_u4[i] <= 0; butterfly4_in_u5[i] <= 0; butterfly4_in_u6[i] <= 0; butterfly4_in_u7[i] <= 0;
    end
    case (i_size) 
        SIZE64 : begin
            for (i = 0; i < 64; i = i + 1) begin
                butterfly64_in_u0[i] <= i_data[i];
            end
            for (i = 0; i < 32; i = i + 1) begin
                butterfly32_in_u0[i] <= butterfly64_out_u0[i];
            end
            for (i = 0; i < 16; i = i + 1) begin
                butterfly16_in_u0[i] <= butterfly32_out_u0[i];
            end
            for (i = 0; i < 8; i = i + 1) begin
                butterfly8_in_u0[i] <= butterfly16_out_u0[i];
            end
            for (i = 0; i < 4; i = i + 1) begin
                butterfly4_in_u0[i] <= butterfly8_out_u0[i];
            end
        end
        SIZE32 : begin
            for (i = 0; i < 32; i = i + 1) begin
                butterfly32_in_u0[i] <= i_data[i];
            end
            for (i = 0; i < 16; i = i + 1) begin
                butterfly16_in_u0[i] <= butterfly32_out_u0[i];
            end
            for (i = 0; i < 8; i = i + 1) begin
                butterfly8_in_u0[i] <= butterfly16_out_u0[i];
            end
            for (i = 0; i < 4; i = i + 1) begin
                butterfly4_in_u0[i] <= butterfly8_out_u0[i];
            end
        end
        SIZE16 : begin
            for (i = 0; i < 16; i = i + 1) begin
                butterfly16_in_u0[i] <= i_data[i];
                butterfly16_in_u1[i] <= i_data[i + 16];
            end
            for (i = 0; i < 8; i = i + 1) begin
                butterfly8_in_u0[i] <= butterfly16_out_u0[i];
                butterfly8_in_u1[i] <= butterfly16_out_u1[i];
            end
            for (i = 0; i < 4; i = i + 1) begin
                butterfly4_in_u0[i] <= butterfly8_out_u0[i];
                butterfly4_in_u1[i] <= butterfly8_out_u1[i];
            end
        end
        SIZE8 : begin
            for (i = 0; i < 8; i = i + 1) begin
                butterfly8_in_u0[i] <= i_data[i];
                butterfly8_in_u1[i] <= i_data[i + 8];
                butterfly8_in_u2[i] <= i_data[i + 16];
                butterfly8_in_u3[i] <= i_data[i + 24];
            end
            for (i = 0; i < 4; i = i + 1) begin
                butterfly4_in_u0[i] <= butterfly8_out_u0[i];
                butterfly4_in_u1[i] <= butterfly8_out_u1[i];
                butterfly4_in_u2[i] <= butterfly8_out_u2[i];
                butterfly4_in_u3[i] <= butterfly8_out_u3[i];
            end
        end 
        SIZE4 : begin
            for (i = 0; i < 4; i = i + 1) begin
                butterfly4_in_u0[i] <= i_data[i];
                butterfly4_in_u1[i] <= i_data[i + 4];
                butterfly4_in_u2[i] <= i_data[i + 8];
                butterfly4_in_u3[i] <= i_data[i + 12];
                butterfly4_in_u4[i] <= i_data[i + 16];
                butterfly4_in_u5[i] <= i_data[i + 20];
                butterfly4_in_u6[i] <= i_data[i + 24];
                butterfly4_in_u7[i] <= i_data[i + 28];
            end
        end
    endcase
end

dct2_butterfly64#(
    .IN_WIDTH   (IN_WIDTH)
)
u0_dct2_butterfly64(
//input data
    .i_0    (butterfly64_in_u0[0 ]  ),
    .i_1    (butterfly64_in_u0[1 ]  ),
    .i_2    (butterfly64_in_u0[2 ]  ),
    .i_3    (butterfly64_in_u0[3 ]  ),
    .i_4    (butterfly64_in_u0[4 ]  ),
    .i_5    (butterfly64_in_u0[5 ]  ),
    .i_6    (butterfly64_in_u0[6 ]  ),
    .i_7    (butterfly64_in_u0[7 ]  ),
    .i_8    (butterfly64_in_u0[8 ]  ),
    .i_9    (butterfly64_in_u0[9 ]  ),
    .i_10   (butterfly64_in_u0[10]  ),
    .i_11   (butterfly64_in_u0[11]  ),
    .i_12   (butterfly64_in_u0[12]  ),
    .i_13   (butterfly64_in_u0[13]  ),
    .i_14   (butterfly64_in_u0[14]  ),
    .i_15   (butterfly64_in_u0[15]  ),
    .i_16   (butterfly64_in_u0[16]  ),
    .i_17   (butterfly64_in_u0[17]  ),
    .i_18   (butterfly64_in_u0[18]  ),
    .i_19   (butterfly64_in_u0[19]  ),
    .i_20   (butterfly64_in_u0[20]  ),
    .i_21   (butterfly64_in_u0[21]  ),
    .i_22   (butterfly64_in_u0[22]  ),
    .i_23   (butterfly64_in_u0[23]  ),
    .i_24   (butterfly64_in_u0[24]  ),
    .i_25   (butterfly64_in_u0[25]  ),
    .i_26   (butterfly64_in_u0[26]  ),
    .i_27   (butterfly64_in_u0[27]  ),
    .i_28   (butterfly64_in_u0[28]  ),
    .i_29   (butterfly64_in_u0[29]  ),
    .i_30   (butterfly64_in_u0[30]  ),
    .i_31   (butterfly64_in_u0[31]  ),
    .i_32   (butterfly64_in_u0[32]  ),
    .i_33   (butterfly64_in_u0[33]  ),
    .i_34   (butterfly64_in_u0[34]  ),
    .i_35   (butterfly64_in_u0[35]  ),
    .i_36   (butterfly64_in_u0[36]  ),
    .i_37   (butterfly64_in_u0[37]  ),
    .i_38   (butterfly64_in_u0[38]  ),
    .i_39   (butterfly64_in_u0[39]  ),
    .i_40   (butterfly64_in_u0[40]  ),
    .i_41   (butterfly64_in_u0[41]  ),
    .i_42   (butterfly64_in_u0[42]  ),
    .i_43   (butterfly64_in_u0[43]  ),
    .i_44   (butterfly64_in_u0[44]  ),
    .i_45   (butterfly64_in_u0[45]  ),
    .i_46   (butterfly64_in_u0[46]  ),
    .i_47   (butterfly64_in_u0[47]  ),
    .i_48   (butterfly64_in_u0[48]  ),
    .i_49   (butterfly64_in_u0[49]  ),
    .i_50   (butterfly64_in_u0[50]  ),
    .i_51   (butterfly64_in_u0[51]  ),
    .i_52   (butterfly64_in_u0[52]  ),
    .i_53   (butterfly64_in_u0[53]  ),
    .i_54   (butterfly64_in_u0[54]  ),
    .i_55   (butterfly64_in_u0[55]  ),
    .i_56   (butterfly64_in_u0[56]  ),
    .i_57   (butterfly64_in_u0[57]  ),
    .i_58   (butterfly64_in_u0[58]  ),
    .i_59   (butterfly64_in_u0[59]  ),
    .i_60   (butterfly64_in_u0[60]  ),
    .i_61   (butterfly64_in_u0[61]  ),
    .i_62   (butterfly64_in_u0[62]  ),
    .i_63   (butterfly64_in_u0[63]  ),
//output data
    .o_0    (butterfly64_out_u0[0 ] ),//E
    .o_1    (butterfly64_out_u0[1 ] ),
    .o_2    (butterfly64_out_u0[2 ] ),
    .o_3    (butterfly64_out_u0[3 ] ),
    .o_4    (butterfly64_out_u0[4 ] ),
    .o_5    (butterfly64_out_u0[5 ] ),
    .o_6    (butterfly64_out_u0[6 ] ),
    .o_7    (butterfly64_out_u0[7 ] ),
    .o_8    (butterfly64_out_u0[8 ] ),
    .o_9    (butterfly64_out_u0[9 ] ),
    .o_10   (butterfly64_out_u0[10] ),
    .o_11   (butterfly64_out_u0[11] ),
    .o_12   (butterfly64_out_u0[12] ),
    .o_13   (butterfly64_out_u0[13] ),
    .o_14   (butterfly64_out_u0[14] ),
    .o_15   (butterfly64_out_u0[15] ),
    .o_16   (butterfly64_out_u0[16] ),
    .o_17   (butterfly64_out_u0[17] ),
    .o_18   (butterfly64_out_u0[18] ),
    .o_19   (butterfly64_out_u0[19] ),
    .o_20   (butterfly64_out_u0[20] ),
    .o_21   (butterfly64_out_u0[21] ),
    .o_22   (butterfly64_out_u0[22] ),
    .o_23   (butterfly64_out_u0[23] ),
    .o_24   (butterfly64_out_u0[24] ),
    .o_25   (butterfly64_out_u0[25] ),
    .o_26   (butterfly64_out_u0[26] ),
    .o_27   (butterfly64_out_u0[27] ),
    .o_28   (butterfly64_out_u0[28] ),
    .o_29   (butterfly64_out_u0[29] ),
    .o_30   (butterfly64_out_u0[30] ),
    .o_31   (butterfly64_out_u0[31] ),
    .o_32   (butterfly64_out_u0[32] ),//O
    .o_33   (butterfly64_out_u0[33] ),
    .o_34   (butterfly64_out_u0[34] ),
    .o_35   (butterfly64_out_u0[35] ),
    .o_36   (butterfly64_out_u0[36] ),
    .o_37   (butterfly64_out_u0[37] ),
    .o_38   (butterfly64_out_u0[38] ),
    .o_39   (butterfly64_out_u0[39] ),
    .o_40   (butterfly64_out_u0[40] ),
    .o_41   (butterfly64_out_u0[41] ),
    .o_42   (butterfly64_out_u0[42] ),
    .o_43   (butterfly64_out_u0[43] ),
    .o_44   (butterfly64_out_u0[44] ),
    .o_45   (butterfly64_out_u0[45] ),
    .o_46   (butterfly64_out_u0[46] ),
    .o_47   (butterfly64_out_u0[47] ),
    .o_48   (butterfly64_out_u0[48] ),
    .o_49   (butterfly64_out_u0[49] ),
    .o_50   (butterfly64_out_u0[50] ),
    .o_51   (butterfly64_out_u0[51] ),
    .o_52   (butterfly64_out_u0[52] ),
    .o_53   (butterfly64_out_u0[53] ),
    .o_54   (butterfly64_out_u0[54] ),
    .o_55   (butterfly64_out_u0[55] ),
    .o_56   (butterfly64_out_u0[56] ),
    .o_57   (butterfly64_out_u0[57] ),
    .o_58   (butterfly64_out_u0[58] ),
    .o_59   (butterfly64_out_u0[59] ),
    .o_60   (butterfly64_out_u0[60] ),
    .o_61   (butterfly64_out_u0[61] ),
    .o_62   (butterfly64_out_u0[62] ),
    .o_63   (butterfly64_out_u0[63] )
);

dct2_butterfly32#(
    .IN_WIDTH   (IN_WIDTH + 1)
)
u0_dct2_butterfly32(
//input data
    .i_0    (butterfly32_in_u0[0 ]  ),
    .i_1    (butterfly32_in_u0[1 ]  ),
    .i_2    (butterfly32_in_u0[2 ]  ),
    .i_3    (butterfly32_in_u0[3 ]  ),
    .i_4    (butterfly32_in_u0[4 ]  ),
    .i_5    (butterfly32_in_u0[5 ]  ),
    .i_6    (butterfly32_in_u0[6 ]  ),
    .i_7    (butterfly32_in_u0[7 ]  ),
    .i_8    (butterfly32_in_u0[8 ]  ),
    .i_9    (butterfly32_in_u0[9 ]  ),
    .i_10   (butterfly32_in_u0[10]  ),
    .i_11   (butterfly32_in_u0[11]  ),
    .i_12   (butterfly32_in_u0[12]  ),
    .i_13   (butterfly32_in_u0[13]  ),
    .i_14   (butterfly32_in_u0[14]  ),
    .i_15   (butterfly32_in_u0[15]  ),
    .i_16   (butterfly32_in_u0[16]  ),
    .i_17   (butterfly32_in_u0[17]  ),
    .i_18   (butterfly32_in_u0[18]  ),
    .i_19   (butterfly32_in_u0[19]  ),
    .i_20   (butterfly32_in_u0[20]  ),
    .i_21   (butterfly32_in_u0[21]  ),
    .i_22   (butterfly32_in_u0[22]  ),
    .i_23   (butterfly32_in_u0[23]  ),
    .i_24   (butterfly32_in_u0[24]  ),
    .i_25   (butterfly32_in_u0[25]  ),
    .i_26   (butterfly32_in_u0[26]  ),
    .i_27   (butterfly32_in_u0[27]  ),
    .i_28   (butterfly32_in_u0[28]  ),
    .i_29   (butterfly32_in_u0[29]  ),
    .i_30   (butterfly32_in_u0[30]  ),
    .i_31   (butterfly32_in_u0[31]  ),
//output data
    .o_0    (butterfly32_out_u0[0 ] ),//E
    .o_1    (butterfly32_out_u0[1 ] ),
    .o_2    (butterfly32_out_u0[2 ] ),
    .o_3    (butterfly32_out_u0[3 ] ),
    .o_4    (butterfly32_out_u0[4 ] ),
    .o_5    (butterfly32_out_u0[5 ] ),
    .o_6    (butterfly32_out_u0[6 ] ),
    .o_7    (butterfly32_out_u0[7 ] ),
    .o_8    (butterfly32_out_u0[8 ] ),
    .o_9    (butterfly32_out_u0[9 ] ),
    .o_10   (butterfly32_out_u0[10] ),
    .o_11   (butterfly32_out_u0[11] ),
    .o_12   (butterfly32_out_u0[12] ),
    .o_13   (butterfly32_out_u0[13] ),
    .o_14   (butterfly32_out_u0[14] ),
    .o_15   (butterfly32_out_u0[15] ),
    .o_16   (butterfly32_out_u0[16] ),//O
    .o_17   (butterfly32_out_u0[17] ),
    .o_18   (butterfly32_out_u0[18] ),
    .o_19   (butterfly32_out_u0[19] ),
    .o_20   (butterfly32_out_u0[20] ),
    .o_21   (butterfly32_out_u0[21] ),
    .o_22   (butterfly32_out_u0[22] ),
    .o_23   (butterfly32_out_u0[23] ),
    .o_24   (butterfly32_out_u0[24] ),
    .o_25   (butterfly32_out_u0[25] ),
    .o_26   (butterfly32_out_u0[26] ),
    .o_27   (butterfly32_out_u0[27] ),
    .o_28   (butterfly32_out_u0[28] ),
    .o_29   (butterfly32_out_u0[29] ),
    .o_30   (butterfly32_out_u0[30] ),
    .o_31   (butterfly32_out_u0[31] )
);

dct2_butterfly16#(
    .IN_WIDTH   (IN_WIDTH + 2)
)
u0_dct2_butterfly16(
//input data
    .i_0    (butterfly16_in_u0[0 ]  ),
    .i_1    (butterfly16_in_u0[1 ]  ),
    .i_2    (butterfly16_in_u0[2 ]  ),
    .i_3    (butterfly16_in_u0[3 ]  ),
    .i_4    (butterfly16_in_u0[4 ]  ),
    .i_5    (butterfly16_in_u0[5 ]  ),
    .i_6    (butterfly16_in_u0[6 ]  ),
    .i_7    (butterfly16_in_u0[7 ]  ),
    .i_8    (butterfly16_in_u0[8 ]  ),
    .i_9    (butterfly16_in_u0[9 ]  ),
    .i_10   (butterfly16_in_u0[10]  ),
    .i_11   (butterfly16_in_u0[11]  ),
    .i_12   (butterfly16_in_u0[12]  ),
    .i_13   (butterfly16_in_u0[13]  ),
    .i_14   (butterfly16_in_u0[14]  ),
    .i_15   (butterfly16_in_u0[15]  ),
//output data
    .o_0    (butterfly16_out_u0[0 ] ),//E
    .o_1    (butterfly16_out_u0[1 ] ),
    .o_2    (butterfly16_out_u0[2 ] ),
    .o_3    (butterfly16_out_u0[3 ] ),
    .o_4    (butterfly16_out_u0[4 ] ),
    .o_5    (butterfly16_out_u0[5 ] ),
    .o_6    (butterfly16_out_u0[6 ] ),
    .o_7    (butterfly16_out_u0[7 ] ),
    .o_8    (butterfly16_out_u0[8 ] ),//O
    .o_9    (butterfly16_out_u0[9 ] ),
    .o_10   (butterfly16_out_u0[10] ),
    .o_11   (butterfly16_out_u0[11] ),
    .o_12   (butterfly16_out_u0[12] ),
    .o_13   (butterfly16_out_u0[13] ),
    .o_14   (butterfly16_out_u0[14] ),
    .o_15   (butterfly16_out_u0[15] )
);

dct2_butterfly16#(
    .IN_WIDTH   (IN_WIDTH)
)
u1_dct2_butterfly16(
//input data
    .i_0    (butterfly16_in_u1[0 ]  ),
    .i_1    (butterfly16_in_u1[1 ]  ),
    .i_2    (butterfly16_in_u1[2 ]  ),
    .i_3    (butterfly16_in_u1[3 ]  ),
    .i_4    (butterfly16_in_u1[4 ]  ),
    .i_5    (butterfly16_in_u1[5 ]  ),
    .i_6    (butterfly16_in_u1[6 ]  ),
    .i_7    (butterfly16_in_u1[7 ]  ),
    .i_8    (butterfly16_in_u1[8 ]  ),
    .i_9    (butterfly16_in_u1[9 ]  ),
    .i_10   (butterfly16_in_u1[10]  ),
    .i_11   (butterfly16_in_u1[11]  ),
    .i_12   (butterfly16_in_u1[12]  ),
    .i_13   (butterfly16_in_u1[13]  ),
    .i_14   (butterfly16_in_u1[14]  ),
    .i_15   (butterfly16_in_u1[15]  ),
//output data
    .o_0    (butterfly16_out_u1[0 ] ),//E
    .o_1    (butterfly16_out_u1[1 ] ),
    .o_2    (butterfly16_out_u1[2 ] ),
    .o_3    (butterfly16_out_u1[3 ] ),
    .o_4    (butterfly16_out_u1[4 ] ),
    .o_5    (butterfly16_out_u1[5 ] ),
    .o_6    (butterfly16_out_u1[6 ] ),
    .o_7    (butterfly16_out_u1[7 ] ),
    .o_8    (butterfly16_out_u1[8 ] ),//O
    .o_9    (butterfly16_out_u1[9 ] ),
    .o_10   (butterfly16_out_u1[10] ),
    .o_11   (butterfly16_out_u1[11] ),
    .o_12   (butterfly16_out_u1[12] ),
    .o_13   (butterfly16_out_u1[13] ),
    .o_14   (butterfly16_out_u1[14] ),
    .o_15   (butterfly16_out_u1[15] )
);

dct2_butterfly8#(
    .IN_WIDTH   (IN_WIDTH + 3)
)
u0_dct2_butterfly8(
//input data
    .i_0    (butterfly8_in_u0[0 ]   ),
    .i_1    (butterfly8_in_u0[1 ]   ),
    .i_2    (butterfly8_in_u0[2 ]   ),
    .i_3    (butterfly8_in_u0[3 ]   ),
    .i_4    (butterfly8_in_u0[4 ]   ),
    .i_5    (butterfly8_in_u0[5 ]   ),
    .i_6    (butterfly8_in_u0[6 ]   ),
    .i_7    (butterfly8_in_u0[7 ]   ),
//output data
    .o_0    (butterfly8_out_u0[0 ]  ),//E
    .o_1    (butterfly8_out_u0[1 ]  ),
    .o_2    (butterfly8_out_u0[2 ]  ),
    .o_3    (butterfly8_out_u0[3 ]  ),
    .o_4    (butterfly8_out_u0[4 ]  ),//O
    .o_5    (butterfly8_out_u0[5 ]  ),
    .o_6    (butterfly8_out_u0[6 ]  ),
    .o_7    (butterfly8_out_u0[7 ]  )
);

dct2_butterfly8#(
    .IN_WIDTH   (IN_WIDTH + 1)
)
u1_dct2_butterfly8(
//input data
    .i_0    (butterfly8_in_u1[0 ]   ),
    .i_1    (butterfly8_in_u1[1 ]   ),
    .i_2    (butterfly8_in_u1[2 ]   ),
    .i_3    (butterfly8_in_u1[3 ]   ),
    .i_4    (butterfly8_in_u1[4 ]   ),
    .i_5    (butterfly8_in_u1[5 ]   ),
    .i_6    (butterfly8_in_u1[6 ]   ),
    .i_7    (butterfly8_in_u1[7 ]   ),
//output data
    .o_0    (butterfly8_out_u1[0 ]  ),//E
    .o_1    (butterfly8_out_u1[1 ]  ),
    .o_2    (butterfly8_out_u1[2 ]  ),
    .o_3    (butterfly8_out_u1[3 ]  ),
    .o_4    (butterfly8_out_u1[4 ]  ),//O
    .o_5    (butterfly8_out_u1[5 ]  ),
    .o_6    (butterfly8_out_u1[6 ]  ),
    .o_7    (butterfly8_out_u1[7 ]  )
);

dct2_butterfly8#(
    .IN_WIDTH   (IN_WIDTH)
)
u2_dct2_butterfly8(
//input data
    .i_0    (butterfly8_in_u2[0 ]   ),
    .i_1    (butterfly8_in_u2[1 ]   ),
    .i_2    (butterfly8_in_u2[2 ]   ),
    .i_3    (butterfly8_in_u2[3 ]   ),
    .i_4    (butterfly8_in_u2[4 ]   ),
    .i_5    (butterfly8_in_u2[5 ]   ),
    .i_6    (butterfly8_in_u2[6 ]   ),
    .i_7    (butterfly8_in_u2[7 ]   ),
//output data
    .o_0    (butterfly8_out_u2[0 ]  ),//E
    .o_1    (butterfly8_out_u2[1 ]  ),
    .o_2    (butterfly8_out_u2[2 ]  ),
    .o_3    (butterfly8_out_u2[3 ]  ),
    .o_4    (butterfly8_out_u2[4 ]  ),//O
    .o_5    (butterfly8_out_u2[5 ]  ),
    .o_6    (butterfly8_out_u2[6 ]  ),
    .o_7    (butterfly8_out_u2[7 ]  )
);

dct2_butterfly8#(
    .IN_WIDTH   (IN_WIDTH)
)
u3_dct2_butterfly8(
//input data
    .i_0    (butterfly8_in_u3[0 ]   ),
    .i_1    (butterfly8_in_u3[1 ]   ),
    .i_2    (butterfly8_in_u3[2 ]   ),
    .i_3    (butterfly8_in_u3[3 ]   ),
    .i_4    (butterfly8_in_u3[4 ]   ),
    .i_5    (butterfly8_in_u3[5 ]   ),
    .i_6    (butterfly8_in_u3[6 ]   ),
    .i_7    (butterfly8_in_u3[7 ]   ),
//output data
    .o_0    (butterfly8_out_u3[0 ]  ),//E
    .o_1    (butterfly8_out_u3[1 ]  ),
    .o_2    (butterfly8_out_u3[2 ]  ),
    .o_3    (butterfly8_out_u3[3 ]  ),
    .o_4    (butterfly8_out_u3[4 ]  ),//O
    .o_5    (butterfly8_out_u3[5 ]  ),
    .o_6    (butterfly8_out_u3[6 ]  ),
    .o_7    (butterfly8_out_u3[7 ]  )
);

dct2_butterfly4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u0_dct2_butterfly4(
//input data
    .i_0    (butterfly4_in_u0[0 ]   ),
    .i_1    (butterfly4_in_u0[1 ]   ),
    .i_2    (butterfly4_in_u0[2 ]   ),
    .i_3    (butterfly4_in_u0[3 ]   ),
//output data
    .o_0    (butterfly4_out_u0[0 ]  ),//E
    .o_1    (butterfly4_out_u0[1 ]  ),
    .o_2    (butterfly4_out_u0[2 ]  ),//O
    .o_3    (butterfly4_out_u0[3 ]  )
);

dct2_butterfly4#(
    .IN_WIDTH   (IN_WIDTH + 2)
)
u1_dct2_butterfly4(
//input data
    .i_0    (butterfly4_in_u1[0 ]   ),
    .i_1    (butterfly4_in_u1[1 ]   ),
    .i_2    (butterfly4_in_u1[2 ]   ),
    .i_3    (butterfly4_in_u1[3 ]   ),
//output data
    .o_0    (butterfly4_out_u1[0 ]  ),//E
    .o_1    (butterfly4_out_u1[1 ]  ),
    .o_2    (butterfly4_out_u1[2 ]  ),//O
    .o_3    (butterfly4_out_u1[3 ]  )
);

dct2_butterfly4#(
    .IN_WIDTH   (IN_WIDTH + 1)
)
u2_dct2_butterfly4(
//input data
    .i_0    (butterfly4_in_u2[0 ]   ),
    .i_1    (butterfly4_in_u2[1 ]   ),
    .i_2    (butterfly4_in_u2[2 ]   ),
    .i_3    (butterfly4_in_u2[3 ]   ),
//output data
    .o_0    (butterfly4_out_u2[0 ]  ),//E
    .o_1    (butterfly4_out_u2[1 ]  ),
    .o_2    (butterfly4_out_u2[2 ]  ),//O
    .o_3    (butterfly4_out_u2[3 ]  )
);

dct2_butterfly4#(
    .IN_WIDTH   (IN_WIDTH + 1)
)
u3_dct2_butterfly4(
//input data
    .i_0    (butterfly4_in_u3[0 ]   ),
    .i_1    (butterfly4_in_u3[1 ]   ),
    .i_2    (butterfly4_in_u3[2 ]   ),
    .i_3    (butterfly4_in_u3[3 ]   ),
//output data
    .o_0    (butterfly4_out_u3[0 ]  ),//E
    .o_1    (butterfly4_out_u3[1 ]  ),
    .o_2    (butterfly4_out_u3[2 ]  ),//O
    .o_3    (butterfly4_out_u3[3 ]  )
);

dct2_butterfly4#(
    .IN_WIDTH   (IN_WIDTH)
)
u4_dct2_butterfly4(
//input data
    .i_0    (butterfly4_in_u4[0 ]   ),
    .i_1    (butterfly4_in_u4[1 ]   ),
    .i_2    (butterfly4_in_u4[2 ]   ),
    .i_3    (butterfly4_in_u4[3 ]   ),
//output data
    .o_0    (butterfly4_out_u4[0 ]  ),//E
    .o_1    (butterfly4_out_u4[1 ]  ),
    .o_2    (butterfly4_out_u4[2 ]  ),//O
    .o_3    (butterfly4_out_u4[3 ]  )
);

dct2_butterfly4#(
    .IN_WIDTH   (IN_WIDTH)
)
u5_dct2_butterfly4(
//input data
    .i_0    (butterfly4_in_u5[0 ]   ),
    .i_1    (butterfly4_in_u5[1 ]   ),
    .i_2    (butterfly4_in_u5[2 ]   ),
    .i_3    (butterfly4_in_u5[3 ]   ),
//output data
    .o_0    (butterfly4_out_u5[0 ]  ),//E
    .o_1    (butterfly4_out_u5[1 ]  ),
    .o_2    (butterfly4_out_u5[2 ]  ),//O
    .o_3    (butterfly4_out_u5[3 ]  )
);

dct2_butterfly4#(
    .IN_WIDTH   (IN_WIDTH)
)
u6_dct2_butterfly4(
//input data
    .i_0    (butterfly4_in_u6[0 ]   ),
    .i_1    (butterfly4_in_u6[1 ]   ),
    .i_2    (butterfly4_in_u6[2 ]   ),
    .i_3    (butterfly4_in_u6[3 ]   ),
//output data
    .o_0    (butterfly4_out_u6[0 ]  ),//E
    .o_1    (butterfly4_out_u6[1 ]  ),
    .o_2    (butterfly4_out_u6[2 ]  ),//O
    .o_3    (butterfly4_out_u6[3 ]  )
);

dct2_butterfly4#(
    .IN_WIDTH   (IN_WIDTH)
)
u7_dct2_butterfly4(
//input data
    .i_0    (butterfly4_in_u7[0 ]   ),
    .i_1    (butterfly4_in_u7[1 ]   ),
    .i_2    (butterfly4_in_u7[2 ]   ),
    .i_3    (butterfly4_in_u7[3 ]   ),
//output data
    .o_0    (butterfly4_out_u7[0 ]  ),//E
    .o_1    (butterfly4_out_u7[1 ]  ),
    .o_2    (butterfly4_out_u7[2 ]  ),//O
    .o_3    (butterfly4_out_u7[3 ]  )
);

//output
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        o_size  <= 0;
        o_valid <= 0;
        o_0     <= 0;
        o_1     <= 0;
        o_2     <= 0;
        o_3     <= 0;
        o_4     <= 0;
        o_5     <= 0;
        o_6     <= 0;
        o_7     <= 0;
        o_8     <= 0;
        o_9     <= 0;
        o_10    <= 0;
        o_11    <= 0;
        o_12    <= 0;
        o_13    <= 0;
        o_14    <= 0;
        o_15    <= 0;
        o_16    <= 0;
        o_17    <= 0;
        o_18    <= 0;
        o_19    <= 0;
        o_20    <= 0;
        o_21    <= 0;
        o_22    <= 0;
        o_23    <= 0;
        o_24    <= 0;
        o_25    <= 0;
        o_26    <= 0;
        o_27    <= 0;
        o_28    <= 0;
        o_29    <= 0;
        o_30    <= 0;
        o_31    <= 0;
        o_32    <= 0;
        o_33    <= 0;
        o_34    <= 0;
        o_35    <= 0;
        o_36    <= 0;
        o_37    <= 0;
        o_38    <= 0;
        o_39    <= 0;
        o_40    <= 0;
        o_41    <= 0;
        o_42    <= 0;
        o_43    <= 0;
        o_44    <= 0;
        o_45    <= 0;
        o_46    <= 0;
        o_47    <= 0;
        o_48    <= 0;
        o_49    <= 0;
        o_50    <= 0;
        o_51    <= 0;
        o_52    <= 0;
        o_53    <= 0;
        o_54    <= 0;
        o_55    <= 0;
        o_56    <= 0;
        o_57    <= 0;
        o_58    <= 0;
        o_59    <= 0;
        o_60    <= 0;
        o_61    <= 0;
        o_62    <= 0;
        o_63    <= 0;
    end
    else begin
        o_size  <= i_size;
        o_valid <= i_valid;
        //0-3
        o_0  <= butterfly4_out_u0[0];
        o_1  <= butterfly4_out_u0[1];
        o_2  <= butterfly4_out_u0[2];
        o_3  <= butterfly4_out_u0[3];
        //4-7
        case (i_size) 
            SIZE4   : begin
                o_4  <= butterfly4_out_u1[0];
                o_5  <= butterfly4_out_u1[1];
                o_6  <= butterfly4_out_u1[2];
                o_7  <= butterfly4_out_u1[3];
            end
            default : begin
                o_4  <= butterfly8_out_u0[4];
                o_5  <= butterfly8_out_u0[5];
                o_6  <= butterfly8_out_u0[6];
                o_7  <= butterfly8_out_u0[7];
            end
        endcase
        //8-15
        case (i_size) 
            SIZE4   : begin
                o_8  <= butterfly4_out_u2[0];
                o_9  <= butterfly4_out_u2[1];
                o_10 <= butterfly4_out_u2[2];
                o_11 <= butterfly4_out_u2[3];
                o_12 <= butterfly4_out_u3[0];
                o_13 <= butterfly4_out_u3[1];
                o_14 <= butterfly4_out_u3[2];
                o_15 <= butterfly4_out_u3[3];
            end
            SIZE8   : begin
                o_8  <= butterfly4_out_u1[0];
                o_9  <= butterfly4_out_u1[1];
                o_10 <= butterfly4_out_u1[2];
                o_11 <= butterfly4_out_u1[3];
                o_12 <= butterfly8_out_u1[4];
                o_13 <= butterfly8_out_u1[5];
                o_14 <= butterfly8_out_u1[6];
                o_15 <= butterfly8_out_u1[7];
            end
            default : begin
                o_8  <= butterfly16_out_u0[8 ];
                o_9  <= butterfly16_out_u0[9 ];
                o_10 <= butterfly16_out_u0[10];
                o_11 <= butterfly16_out_u0[11];
                o_12 <= butterfly16_out_u0[12];
                o_13 <= butterfly16_out_u0[13];
                o_14 <= butterfly16_out_u0[14];
                o_15 <= butterfly16_out_u0[15];
            end
        endcase
        //16-31
        case (i_size) 
            SIZE4   : begin
                o_16 <= butterfly4_out_u4[0];
                o_17 <= butterfly4_out_u4[1];
                o_18 <= butterfly4_out_u4[2];
                o_19 <= butterfly4_out_u4[3];
                o_20 <= butterfly4_out_u5[0];
                o_21 <= butterfly4_out_u5[1];
                o_22 <= butterfly4_out_u5[2];
                o_23 <= butterfly4_out_u5[3];
                o_24 <= butterfly4_out_u6[0];
                o_25 <= butterfly4_out_u6[1];
                o_26 <= butterfly4_out_u6[2];
                o_27 <= butterfly4_out_u6[3];
                o_28 <= butterfly4_out_u7[0];
                o_29 <= butterfly4_out_u7[1];
                o_30 <= butterfly4_out_u7[2];
                o_31 <= butterfly4_out_u7[3];
            end
            SIZE8   : begin
                o_16 <= butterfly4_out_u2[0];
                o_17 <= butterfly4_out_u2[1];
                o_18 <= butterfly4_out_u2[2];
                o_19 <= butterfly4_out_u2[3];
                o_20 <= butterfly8_out_u2[4];
                o_21 <= butterfly8_out_u2[5];
                o_22 <= butterfly8_out_u2[6];
                o_23 <= butterfly8_out_u2[7];
                o_24 <= butterfly4_out_u3[0];
                o_25 <= butterfly4_out_u3[1];
                o_26 <= butterfly4_out_u3[2];
                o_27 <= butterfly4_out_u3[3];
                o_28 <= butterfly8_out_u3[4];
                o_29 <= butterfly8_out_u3[5];
                o_30 <= butterfly8_out_u3[6];
                o_31 <= butterfly8_out_u3[7];
            end
            SIZE16  : begin
                o_16 <= butterfly4_out_u1[0];
                o_17 <= butterfly4_out_u1[1];
                o_18 <= butterfly4_out_u1[2];
                o_19 <= butterfly4_out_u1[3];
                o_20 <= butterfly8_out_u1[4];
                o_21 <= butterfly8_out_u1[5];
                o_22 <= butterfly8_out_u1[6];
                o_23 <= butterfly8_out_u1[7];
                o_24 <= butterfly16_out_u1[8 ];
                o_25 <= butterfly16_out_u1[9 ];
                o_26 <= butterfly16_out_u1[10];
                o_27 <= butterfly16_out_u1[11];
                o_28 <= butterfly16_out_u1[12];
                o_29 <= butterfly16_out_u1[13];
                o_30 <= butterfly16_out_u1[14];
                o_31 <= butterfly16_out_u1[15];
            end
            default : begin
                o_16 <= butterfly32_out_u0[16];
                o_17 <= butterfly32_out_u0[17];
                o_18 <= butterfly32_out_u0[18];
                o_19 <= butterfly32_out_u0[19];
                o_20 <= butterfly32_out_u0[20];
                o_21 <= butterfly32_out_u0[21];
                o_22 <= butterfly32_out_u0[22];
                o_23 <= butterfly32_out_u0[23];
                o_24 <= butterfly32_out_u0[24];
                o_25 <= butterfly32_out_u0[25];
                o_26 <= butterfly32_out_u0[26];
                o_27 <= butterfly32_out_u0[27];
                o_28 <= butterfly32_out_u0[28];
                o_29 <= butterfly32_out_u0[29];
                o_30 <= butterfly32_out_u0[30];
                o_31 <= butterfly32_out_u0[31];
            end
        endcase
        //32-63
        o_32 <= butterfly64_out_u0[32];
        o_33 <= butterfly64_out_u0[33];
        o_34 <= butterfly64_out_u0[34];
        o_35 <= butterfly64_out_u0[35];
        o_36 <= butterfly64_out_u0[36];
        o_37 <= butterfly64_out_u0[37];
        o_38 <= butterfly64_out_u0[38];
        o_39 <= butterfly64_out_u0[39];
        o_40 <= butterfly64_out_u0[40];
        o_41 <= butterfly64_out_u0[41];
        o_42 <= butterfly64_out_u0[42];
        o_43 <= butterfly64_out_u0[43];
        o_44 <= butterfly64_out_u0[44];
        o_45 <= butterfly64_out_u0[45];
        o_46 <= butterfly64_out_u0[46];
        o_47 <= butterfly64_out_u0[47];
        o_48 <= butterfly64_out_u0[48];
        o_49 <= butterfly64_out_u0[49];
        o_50 <= butterfly64_out_u0[50];
        o_51 <= butterfly64_out_u0[51];
        o_52 <= butterfly64_out_u0[52];
        o_53 <= butterfly64_out_u0[53];
        o_54 <= butterfly64_out_u0[54];
        o_55 <= butterfly64_out_u0[55];
        o_56 <= butterfly64_out_u0[56];
        o_57 <= butterfly64_out_u0[57];
        o_58 <= butterfly64_out_u0[58];
        o_59 <= butterfly64_out_u0[59];
        o_60 <= butterfly64_out_u0[60];
        o_61 <= butterfly64_out_u0[61];
        o_62 <= butterfly64_out_u0[62];
        o_63 <= butterfly64_out_u0[63];
    end
end
    
endmodule
