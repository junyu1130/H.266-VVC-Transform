//describe  : 第一次一维DCT2
//input     : 16-64个残差像素
//output    : 16-64个第一次变换系数
//delay     : 6 clk
module dct1d_1st#(
    parameter  IN_WIDTH  = 9,
    parameter  OUT_WIDTH = 16
)
(
//system input
    input                               clk     ,
    input                               rst_n   ,
//input parameter
    input           [2 : 0]             i_width ,//1:DCT_4, 2:DCT_8, 3:DCT_16, 4:DCT_32, 5:DCT_64
    input           [2 : 0]             i_height,
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
    input   signed  [IN_WIDTH - 1 : 0]  i_32    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_33    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_34    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_35    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_36    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_37    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_38    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_39    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_40    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_41    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_42    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_43    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_44    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_45    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_46    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_47    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_48    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_49    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_50    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_51    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_52    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_53    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_54    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_55    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_56    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_57    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_58    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_59    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_60    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_61    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_62    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_63    ,
//output parameter
    output          [2 : 0]             o_width ,
    output          [2 : 0]             o_height,
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
    output  signed  [OUT_WIDTH - 1 : 0] o_31    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_32    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_33    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_34    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_35    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_36    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_37    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_38    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_39    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_40    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_41    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_42    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_43    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_44    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_45    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_46    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_47    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_48    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_49    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_50    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_51    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_52    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_53    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_54    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_55    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_56    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_57    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_58    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_59    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_60    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_61    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_62    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_63
);

localparam  DCT_4  = 1,
            DCT_8  = 2,
            DCT_16 = 3,
            DCT_32 = 4,
            DCT_64 = 5;
integer i;

//input
    reg i_valid_d1, i_valid_d2, i_valid_d3, i_valid_d4;
    wire signed [IN_WIDTH - 1 : 0] i_data[0 : 63];
    reg signed [IN_WIDTH - 1 : 0] i_data_d1[0 : 63], i_data_d2[0 : 63], i_data_d3[0 : 63], i_data_d4[0 : 63];
//dct select
    reg dct_64_valid, dct_32_valid, dct_16_valid, dct_8_valid, dct_4_valid;  
    reg  signed [IN_WIDTH - 1 : 0] i_dct_64_u0[0 : 63];
    reg  signed [IN_WIDTH     : 0] i_dct_32_u0[0 : 31], i_dct_32_u1[0 : 31];
    reg  signed [IN_WIDTH + 1 : 0] i_dct_16_u0[0 : 15], i_dct_16_u1[0 : 15], i_dct_16_u2[0 : 15], i_dct_16_u3[0 : 15];
    reg  signed [IN_WIDTH + 2 : 0] i_dct_8_u0[0 : 7], i_dct_8_u1[0 : 7], i_dct_8_u2[0 : 7], i_dct_8_u3[0 : 7], 
                                   i_dct_8_u4[0 : 7], i_dct_8_u5[0 : 7], i_dct_8_u6[0 : 7], i_dct_8_u7[0 : 7];
    reg  signed [IN_WIDTH + 3 : 0] i_dct_4_u0[0 : 3], i_dct_4_u1[0 : 3], i_dct_4_u2[0 : 3], i_dct_4_u3[0 : 3],
                                   i_dct_4_u4[0 : 3], i_dct_4_u5[0 : 3], i_dct_4_u6[0 : 3], i_dct_4_u7[0 : 3],
                                   i_dct_4_u8[0 : 3], i_dct_4_u9[0 : 3], i_dct_4_u10[0 : 3], i_dct_4_u11[0 : 3],
                                   i_dct_4_u12[0 : 3], i_dct_4_u13[0 : 3], i_dct_4_u14[0 : 3], i_dct_4_u15[0 : 3];
//calculate : mcm + sum
    wire signed [IN_WIDTH     : 0] butterfly_64_u0[0 : 31];
    wire signed [IN_WIDTH + 1 : 0] butterfly_32_u0[0 : 15], butterfly_32_u1[0 : 15];
    wire signed [IN_WIDTH + 2 : 0] butterfly_16_u0[0 : 7], butterfly_16_u1[0 : 7], butterfly_16_u2[0 : 7], butterfly_16_u3[0 : 7];
    wire signed [IN_WIDTH + 3 : 0] butterfly_8_u0[0 : 3], butterfly_8_u1[0 : 3], butterfly_8_u2[0 : 3], butterfly_8_u3[0 : 3],
                                   butterfly_8_u4[0 : 3], butterfly_8_u5[0 : 3], butterfly_8_u6[0 : 3], butterfly_8_u7[0 : 3];
    wire pre_coeff_64_valid, pre_coeff_32_valid, pre_coeff_16_valid, pre_coeff_8_valid, pre_coeff_4_valid;
    wire signed [IN_WIDTH + 11 : 0] pre_coeff_64_u0[0 : 31];
    wire signed [IN_WIDTH + 11 : 0] pre_coeff_32_u0[0 : 15], pre_coeff_32_u1[0 : 15];
    wire signed [IN_WIDTH + 11 : 0] pre_coeff_16_u0[0 : 7], pre_coeff_16_u1[0 : 7], pre_coeff_16_u2[0 : 7], pre_coeff_16_u3[0 : 7];
    wire signed [IN_WIDTH + 11 : 0] pre_coeff_8_u0[0 : 3], pre_coeff_8_u1[0 : 3], pre_coeff_8_u2[0 : 3], pre_coeff_8_u3[0 : 3],
                                    pre_coeff_8_u4[0 : 3], pre_coeff_8_u5[0 : 3], pre_coeff_8_u6[0 : 3], pre_coeff_8_u7[0 : 3];
    wire signed [IN_WIDTH + 11 : 0] pre_coeff_4_u0[0 : 3], pre_coeff_4_u1[0 : 3], pre_coeff_4_u2[0 : 3], pre_coeff_4_u3[0 : 3],
                                    pre_coeff_4_u4[0 : 3], pre_coeff_4_u5[0 : 3], pre_coeff_4_u6[0 : 3], pre_coeff_4_u7[0 : 3],
                                    pre_coeff_4_u8[0 : 3], pre_coeff_4_u9[0 : 3], pre_coeff_4_u10[0 : 3], pre_coeff_4_u11[0 : 3],
                                    pre_coeff_4_u12[0 : 3], pre_coeff_4_u13[0 : 3], pre_coeff_4_u14[0 : 3], pre_coeff_4_u15[0 : 3];
    reg pre_coeff_valid;
    reg signed [IN_WIDTH + 11 : 0] pre_coeff[0 : 63];
//limited to 16bit : offset + shift
    reg [2 : 0] i_width_d[0 : 5];
    reg [2 : 0] i_height_d[0 : 5];
    reg [3 : 0] dct_shift;
    wire coeff_valid;
    wire signed [OUT_WIDTH - 1 : 0] coeff[0 : 63];

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

//parameter delay
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin 
        for (i = 0; i < 6; i = i + 1) begin
            i_width_d[i] <= 0;
            i_height_d[i] <= 0;
        end
    end
    else begin
        i_width_d[0] <= i_width;
        i_height_d[0] <= i_height;
        for (i = 0; i < 5; i = i + 1) begin
            i_width_d[i + 1] <= i_width_d[i];
            i_height_d[i + 1] <= i_height_d[i];
        end
    end
end

//shift
always @(*) begin
    case (i_width_d[4])//first stage : log2(Width) + BitDepth - 9
        DCT_4   : dct_shift <= IN_WIDTH - 8;
        DCT_8   : dct_shift <= IN_WIDTH - 7;
        DCT_16  : dct_shift <= IN_WIDTH - 6;
        DCT_32  : dct_shift <= IN_WIDTH - 5;
        DCT_64  : dct_shift <= IN_WIDTH - 4;
        default : dct_shift <= 0;
    endcase
end

//dct in delay
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d1 <= 0; 
        i_valid_d2 <= 0; 
        i_valid_d3 <= 0; 
        i_valid_d4 <= 0;
        for (i = 0; i < 64; i = i + 1) begin
            i_data_d1[i] <= 0; 
            i_data_d2[i] <= 0; 
            i_data_d3[i] <= 0; 
            i_data_d4[i] <= 0; 
        end
    end
    else begin
        i_valid_d1 <= i_valid; 
        i_valid_d2 <= i_valid_d1; 
        i_valid_d3 <= i_valid_d2; 
        i_valid_d4 <= i_valid_d3;
        for (i = 0; i < 64; i = i + 1) begin
            i_data_d1[i] <= i_data[i]; 
            i_data_d2[i] <= i_data_d1[i]; 
            i_data_d3[i] <= i_data_d2[i]; 
            i_data_d4[i] <= i_data_d3[i]; 
        end
    end
end

//dct in select
always @(negedge clk or negedge rst_n) begin
    if (!rst_n) begin
        dct_64_valid <= 0;
        dct_32_valid <= 0;
        dct_16_valid <= 0;
        dct_8_valid  <= 0;
        dct_4_valid  <= 0;
        for (i = 0; i < 64; i = i + 1) begin
            i_dct_64_u0[i] <= 0;
        end
        for (i = 0; i < 32; i = i + 1) begin
            i_dct_32_u0[i] <= 0; i_dct_32_u1[i] <= 0;
        end
        for (i = 0; i < 16; i = i + 1) begin
            i_dct_16_u0[i] <= 0; i_dct_16_u1[i] <= 0; i_dct_16_u2[i] <= 0; i_dct_16_u3[i] <= 0;
        end
        for (i = 0; i < 8; i = i + 1) begin
            i_dct_8_u0[i] <= 0; i_dct_8_u1[i] <= 0; i_dct_8_u2[i] <= 0; i_dct_8_u3[i] <= 0; 
            i_dct_8_u4[i] <= 0; i_dct_8_u5[i] <= 0; i_dct_8_u6[i] <= 0; i_dct_8_u7[i] <= 0;
        end
        for (i = 0; i < 4; i = i + 1) begin
            i_dct_4_u0[i] <= 0; i_dct_4_u1[i] <= 0; i_dct_4_u2[i] <= 0; i_dct_4_u3[i] <= 0;
            i_dct_4_u4[i] <= 0; i_dct_4_u5[i] <= 0; i_dct_4_u6[i] <= 0; i_dct_4_u7[i] <= 0;
            i_dct_4_u8[i] <= 0; i_dct_4_u9[i] <= 0; i_dct_4_u10[i] <= 0; i_dct_4_u11[i] <= 0;
            i_dct_4_u12[i] <= 0; i_dct_4_u13[i] <= 0; i_dct_4_u14[i] <= 0; i_dct_4_u15[i] <= 0;
        end
    end
    else begin
        //delay 0 clk
        case (i_width) 
            DCT_64 : begin
                dct_64_valid <= i_valid;
                for (i = 0; i < 64; i = i + 1) begin
                    i_dct_64_u0[i] <= i_data[i];
                end
            end
        endcase
        //delay 1 clk
        case (i_width_d[0]) 
            DCT_64 : begin
                for (i = 0; i < 32; i = i + 1) begin
                    i_dct_32_u0[i] <= butterfly_64_u0[i];
                end
            end
            DCT_32 : begin
                dct_32_valid <= i_valid_d1;
                for (i = 0; i < 32; i = i + 1) begin
                    i_dct_32_u0[i] <= i_data_d1[i];
                    i_dct_32_u1[i] <= i_data_d1[i + 32];
                end
            end
        endcase
        //delay 2 clk
        case (i_width_d[1]) 
            DCT_64 : begin
                for (i = 0; i < 16; i = i + 1) begin
                    i_dct_16_u0[i] <= butterfly_32_u0[i];
                end
            end
            DCT_32 : begin
                for (i = 0; i < 16; i = i + 1) begin
                    i_dct_16_u0[i] <= butterfly_32_u0[i];
                    i_dct_16_u1[i] <= butterfly_32_u1[i];
                end
            end
            DCT_16 : begin
                dct_16_valid <= i_valid_d2;
                for (i = 0; i < 16; i = i + 1) begin
                    i_dct_16_u0[i] <= i_data_d2[i];
                    i_dct_16_u1[i] <= i_data_d2[i + 16];
                    i_dct_16_u2[i] <= i_data_d2[i + 32];
                    i_dct_16_u3[i] <= i_data_d2[i + 48];
                end
            end
        endcase
        //delay 3 clk
        case (i_width_d[2]) 
            DCT_64 : begin
                for (i = 0; i < 8; i = i + 1) begin
                    i_dct_8_u0[i] <= butterfly_16_u0[i];
                end
            end
            DCT_32 : begin
                for (i = 0; i < 8; i = i + 1) begin
                    i_dct_8_u0[i] <= butterfly_16_u0[i];
                    i_dct_8_u1[i] <= butterfly_16_u1[i];
                end
            end
            DCT_16 : begin
                for (i = 0; i < 8; i = i + 1) begin
                    i_dct_8_u0[i] <= butterfly_16_u0[i];
                    i_dct_8_u1[i] <= butterfly_16_u1[i];
                    i_dct_8_u2[i] <= butterfly_16_u2[i];
                    i_dct_8_u3[i] <= butterfly_16_u3[i];
                end
            end
            DCT_8 : begin
                dct_8_valid <= i_valid_d3;
                for (i = 0; i < 8; i = i + 1) begin
                    i_dct_8_u0[i] <= i_data_d3[i];
                    i_dct_8_u1[i] <= i_data_d3[i + 8];
                    i_dct_8_u2[i] <= i_data_d3[i + 16];
                    i_dct_8_u3[i] <= i_data_d3[i + 24];
                    i_dct_8_u4[i] <= i_data_d3[i + 32];
                    i_dct_8_u5[i] <= i_data_d3[i + 40];
                    i_dct_8_u6[i] <= i_data_d3[i + 48];
                    i_dct_8_u7[i] <= i_data_d3[i + 56];
                end
            end
        endcase
        //delay 4 clk
        case (i_width_d[3]) 
            DCT_64 : begin
                for (i = 0; i < 4; i = i + 1) begin
                    i_dct_4_u0[i] <= butterfly_8_u0[i];
                end
            end
            DCT_32 : begin
                for (i = 0; i < 4; i = i + 1) begin
                    i_dct_4_u0[i] <= butterfly_8_u0[i];
                    i_dct_4_u1[i] <= butterfly_8_u1[i];
                end
            end
            DCT_16 : begin
                for (i = 0; i < 4; i = i + 1) begin
                    i_dct_4_u0[i] <= butterfly_8_u0[i];
                    i_dct_4_u1[i] <= butterfly_8_u1[i];
                    i_dct_4_u2[i] <= butterfly_8_u2[i];
                    i_dct_4_u3[i] <= butterfly_8_u3[i];
                end
            end
            DCT_8 : begin
                for (i = 0; i < 4; i = i + 1) begin
                    i_dct_4_u0[i] <= butterfly_8_u0[i];
                    i_dct_4_u1[i] <= butterfly_8_u1[i];
                    i_dct_4_u2[i] <= butterfly_8_u2[i];
                    i_dct_4_u3[i] <= butterfly_8_u3[i];
                    i_dct_4_u4[i] <= butterfly_8_u4[i];
                    i_dct_4_u5[i] <= butterfly_8_u5[i];
                    i_dct_4_u6[i] <= butterfly_8_u6[i];
                    i_dct_4_u7[i] <= butterfly_8_u7[i];
                end
            end
            DCT_4 : begin
                dct_4_valid <= i_valid_d4;
                for (i = 0; i < 4; i = i + 1) begin
                    i_dct_4_u0[i] <= i_data_d4[i];
                    i_dct_4_u1[i] <= i_data_d4[i + 4];
                    i_dct_4_u2[i] <= i_data_d4[i + 8];
                    i_dct_4_u3[i] <= i_data_d4[i + 12];
                    i_dct_4_u4[i] <= i_data_d4[i + 16];
                    i_dct_4_u5[i] <= i_data_d4[i + 20];
                    i_dct_4_u6[i] <= i_data_d4[i + 24];
                    i_dct_4_u7[i] <= i_data_d4[i + 28];
                    i_dct_4_u8[i] <= i_data_d4[i + 32];
                    i_dct_4_u9[i] <= i_data_d4[i + 36];
                    i_dct_4_u10[i] <= i_data_d4[i + 40];
                    i_dct_4_u11[i] <= i_data_d4[i + 44];
                    i_dct_4_u12[i] <= i_data_d4[i + 48];
                    i_dct_4_u13[i] <= i_data_d4[i + 52];
                    i_dct_4_u14[i] <= i_data_d4[i + 56];
                    i_dct_4_u15[i] <= i_data_d4[i + 60];
                end
            end
        endcase
    end
end

//dct out select
always @(*) begin
    pre_coeff_valid <= 0;
    for (i = 0; i < 64; i = i + 1) begin
        pre_coeff[i] <= 0;
    end
    case (i_width_d[4])
        DCT_64  : begin //high frequency coefficients are set to zero
            pre_coeff_valid <= pre_coeff_64_valid;
            for (i = 0; i < 16; i = i + 1) begin
                pre_coeff[1 + 2 * i] <= pre_coeff_64_u0[i];
            end
            for (i = 0; i < 8; i = i + 1) begin
                pre_coeff[2 + 4 * i] <= pre_coeff_32_u0[i];
            end
            for (i = 0; i < 4; i = i + 1) begin
                pre_coeff[4 + 8 * i] <= pre_coeff_16_u0[i];
            end
            for (i = 0; i < 2; i = i + 1) begin
                pre_coeff[8 + 16 * i] <= pre_coeff_8_u0[i];
            end
            for (i = 0; i < 2; i = i + 1) begin
                pre_coeff[0 + 16 * i] <= pre_coeff_4_u0[i];
            end
        end
        DCT_32  : begin
            pre_coeff_valid <= pre_coeff_32_valid;
            for (i = 0; i < 16; i = i + 1) begin
                pre_coeff[1 + 2 * i] <= pre_coeff_32_u0[i];
                pre_coeff[33 + 2 * i] <= pre_coeff_32_u1[i];
            end
            for (i = 0; i < 8; i = i + 1) begin
                pre_coeff[2 + 4 * i] <= pre_coeff_16_u0[i];
                pre_coeff[34 + 4 * i] <= pre_coeff_16_u1[i];
            end
            for (i = 0; i < 4; i = i + 1) begin
                pre_coeff[4 + 8 * i] <= pre_coeff_8_u0[i];
                pre_coeff[36 + 8 * i] <= pre_coeff_8_u1[i];
            end
            for (i = 0; i < 4; i = i + 1) begin
                pre_coeff[0 + 8 * i] <= pre_coeff_4_u0[i];
                pre_coeff[32 + 8 * i] <= pre_coeff_4_u1[i];
            end
        end
        DCT_16  : begin
            pre_coeff_valid <= pre_coeff_16_valid;
            for (i = 0; i < 8; i = i + 1) begin
                pre_coeff[1 + 2 * i] <= pre_coeff_16_u0[i];
                pre_coeff[17 + 2 * i] <= pre_coeff_16_u1[i];
                pre_coeff[33 + 2 * i] <= pre_coeff_16_u2[i];
                pre_coeff[49 + 2 * i] <= pre_coeff_16_u3[i];
            end
            for (i = 0; i < 4; i = i + 1) begin
                pre_coeff[2 + 4 * i] <= pre_coeff_8_u0[i];
                pre_coeff[18 + 4 * i] <= pre_coeff_8_u1[i];
                pre_coeff[34 + 4 * i] <= pre_coeff_8_u2[i];
                pre_coeff[50 + 4 * i] <= pre_coeff_8_u3[i];
            end
            for (i = 0; i < 4; i = i + 1) begin
                pre_coeff[0 + 4 * i] <= pre_coeff_4_u0[i];
                pre_coeff[16 + 4 * i] <= pre_coeff_4_u1[i];
                pre_coeff[32 + 4 * i] <= pre_coeff_4_u2[i];
                pre_coeff[48 + 4 * i] <= pre_coeff_4_u3[i];
            end
        end
        DCT_8   : begin
            pre_coeff_valid <= pre_coeff_8_valid;
            for (i = 0; i < 4; i = i + 1) begin
                pre_coeff[1 + 2 * i] <= pre_coeff_8_u0[i];
                pre_coeff[9 + 2 * i] <= pre_coeff_8_u1[i];
                pre_coeff[17 + 2 * i] <= pre_coeff_8_u2[i];
                pre_coeff[25 + 2 * i] <= pre_coeff_8_u3[i];
                pre_coeff[33 + 2 * i] <= pre_coeff_8_u4[i];
                pre_coeff[41 + 2 * i] <= pre_coeff_8_u5[i];
                pre_coeff[49 + 2 * i] <= pre_coeff_8_u6[i];
                pre_coeff[57 + 2 * i] <= pre_coeff_8_u7[i];
            end
            for (i = 0; i < 4; i = i + 1) begin
                pre_coeff[0 + 2 * i] <= pre_coeff_4_u0[i];
                pre_coeff[8 + 2 * i] <= pre_coeff_4_u1[i];
                pre_coeff[16 + 2 * i] <= pre_coeff_4_u2[i];
                pre_coeff[24 + 2 * i] <= pre_coeff_4_u3[i];
                pre_coeff[32 + 2 * i] <= pre_coeff_4_u4[i];
                pre_coeff[40 + 2 * i] <= pre_coeff_4_u5[i];
                pre_coeff[48 + 2 * i] <= pre_coeff_4_u6[i];
                pre_coeff[56 + 2 * i] <= pre_coeff_4_u7[i];
            end
        end
        DCT_4   : begin
            pre_coeff_valid <= pre_coeff_4_valid;
            for (i = 0; i < 4; i = i + 1) begin
                pre_coeff[0 + i] <= pre_coeff_4_u0[i];
                pre_coeff[4 + i] <= pre_coeff_4_u1[i];
                pre_coeff[8 + i] <= pre_coeff_4_u2[i];
                pre_coeff[12 + i] <= pre_coeff_4_u3[i];
                pre_coeff[16 + i] <= pre_coeff_4_u4[i];
                pre_coeff[20 + i] <= pre_coeff_4_u5[i];
                pre_coeff[24 + i] <= pre_coeff_4_u6[i];
                pre_coeff[28 + i] <= pre_coeff_4_u7[i];
                pre_coeff[32 + i] <= pre_coeff_4_u8[i];
                pre_coeff[36 + i] <= pre_coeff_4_u9[i];
                pre_coeff[40 + i] <= pre_coeff_4_u10[i];
                pre_coeff[44 + i] <= pre_coeff_4_u11[i];
                pre_coeff[48 + i] <= pre_coeff_4_u12[i];
                pre_coeff[52 + i] <= pre_coeff_4_u13[i];
                pre_coeff[56 + i] <= pre_coeff_4_u14[i];
                pre_coeff[60 + i] <= pre_coeff_4_u15[i];
            end
        end
    endcase
end

//sub module
//64 x 64
dct1d_64#(
    .IN_WIDTH   (IN_WIDTH)
)
u0_dct1d_64(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input data
    .i_valid(dct_64_valid       ),
    .i_0    (i_dct_64_u0[0 ]    ),
    .i_1    (i_dct_64_u0[1 ]    ),
    .i_2    (i_dct_64_u0[2 ]    ),
    .i_3    (i_dct_64_u0[3 ]    ),
    .i_4    (i_dct_64_u0[4 ]    ),
    .i_5    (i_dct_64_u0[5 ]    ),
    .i_6    (i_dct_64_u0[6 ]    ),
    .i_7    (i_dct_64_u0[7 ]    ),
    .i_8    (i_dct_64_u0[8 ]    ),
    .i_9    (i_dct_64_u0[9 ]    ),
    .i_10   (i_dct_64_u0[10]    ),
    .i_11   (i_dct_64_u0[11]    ),
    .i_12   (i_dct_64_u0[12]    ),
    .i_13   (i_dct_64_u0[13]    ),
    .i_14   (i_dct_64_u0[14]    ),
    .i_15   (i_dct_64_u0[15]    ),
    .i_16   (i_dct_64_u0[16]    ),
    .i_17   (i_dct_64_u0[17]    ),
    .i_18   (i_dct_64_u0[18]    ),
    .i_19   (i_dct_64_u0[19]    ),
    .i_20   (i_dct_64_u0[20]    ),
    .i_21   (i_dct_64_u0[21]    ),
    .i_22   (i_dct_64_u0[22]    ),
    .i_23   (i_dct_64_u0[23]    ),
    .i_24   (i_dct_64_u0[24]    ),
    .i_25   (i_dct_64_u0[25]    ),
    .i_26   (i_dct_64_u0[26]    ),
    .i_27   (i_dct_64_u0[27]    ),
    .i_28   (i_dct_64_u0[28]    ),
    .i_29   (i_dct_64_u0[29]    ),
    .i_30   (i_dct_64_u0[30]    ),
    .i_31   (i_dct_64_u0[31]    ),
    .i_32   (i_dct_64_u0[32]    ),
    .i_33   (i_dct_64_u0[33]    ),
    .i_34   (i_dct_64_u0[34]    ),
    .i_35   (i_dct_64_u0[35]    ),
    .i_36   (i_dct_64_u0[36]    ),
    .i_37   (i_dct_64_u0[37]    ),
    .i_38   (i_dct_64_u0[38]    ),
    .i_39   (i_dct_64_u0[39]    ),
    .i_40   (i_dct_64_u0[40]    ),
    .i_41   (i_dct_64_u0[41]    ),
    .i_42   (i_dct_64_u0[42]    ),
    .i_43   (i_dct_64_u0[43]    ),
    .i_44   (i_dct_64_u0[44]    ),
    .i_45   (i_dct_64_u0[45]    ),
    .i_46   (i_dct_64_u0[46]    ),
    .i_47   (i_dct_64_u0[47]    ),
    .i_48   (i_dct_64_u0[48]    ),
    .i_49   (i_dct_64_u0[49]    ),
    .i_50   (i_dct_64_u0[50]    ),
    .i_51   (i_dct_64_u0[51]    ),
    .i_52   (i_dct_64_u0[52]    ),
    .i_53   (i_dct_64_u0[53]    ),
    .i_54   (i_dct_64_u0[54]    ),
    .i_55   (i_dct_64_u0[55]    ),
    .i_56   (i_dct_64_u0[56]    ),
    .i_57   (i_dct_64_u0[57]    ),
    .i_58   (i_dct_64_u0[58]    ),
    .i_59   (i_dct_64_u0[59]    ),
    .i_60   (i_dct_64_u0[60]    ),
    .i_61   (i_dct_64_u0[61]    ),
    .i_62   (i_dct_64_u0[62]    ),
    .i_63   (i_dct_64_u0[63]    ),
//output data
    .o_valid(pre_coeff_64_valid ),
    .o_0    (butterfly_64_u0[0 ]),
    .o_1    (butterfly_64_u0[1 ]),
    .o_2    (butterfly_64_u0[2 ]),
    .o_3    (butterfly_64_u0[3 ]),
    .o_4    (butterfly_64_u0[4 ]),
    .o_5    (butterfly_64_u0[5 ]),
    .o_6    (butterfly_64_u0[6 ]),
    .o_7    (butterfly_64_u0[7 ]),
    .o_8    (butterfly_64_u0[8 ]),
    .o_9    (butterfly_64_u0[9 ]),
    .o_10   (butterfly_64_u0[10]),
    .o_11   (butterfly_64_u0[11]),
    .o_12   (butterfly_64_u0[12]),
    .o_13   (butterfly_64_u0[13]),
    .o_14   (butterfly_64_u0[14]),
    .o_15   (butterfly_64_u0[15]),
    .o_16   (butterfly_64_u0[16]),
    .o_17   (butterfly_64_u0[17]),
    .o_18   (butterfly_64_u0[18]),
    .o_19   (butterfly_64_u0[19]),
    .o_20   (butterfly_64_u0[20]),
    .o_21   (butterfly_64_u0[21]),
    .o_22   (butterfly_64_u0[22]),
    .o_23   (butterfly_64_u0[23]),
    .o_24   (butterfly_64_u0[24]),
    .o_25   (butterfly_64_u0[25]),
    .o_26   (butterfly_64_u0[26]),
    .o_27   (butterfly_64_u0[27]),
    .o_28   (butterfly_64_u0[28]),
    .o_29   (butterfly_64_u0[29]),
    .o_30   (butterfly_64_u0[30]),
    .o_31   (butterfly_64_u0[31]),
    .o_32   (pre_coeff_64_u0[0 ]),
    .o_33   (pre_coeff_64_u0[1 ]),
    .o_34   (pre_coeff_64_u0[2 ]),
    .o_35   (pre_coeff_64_u0[3 ]),
    .o_36   (pre_coeff_64_u0[4 ]),
    .o_37   (pre_coeff_64_u0[5 ]),
    .o_38   (pre_coeff_64_u0[6 ]),
    .o_39   (pre_coeff_64_u0[7 ]),
    .o_40   (pre_coeff_64_u0[8 ]),
    .o_41   (pre_coeff_64_u0[9 ]),
    .o_42   (pre_coeff_64_u0[10]),
    .o_43   (pre_coeff_64_u0[11]),
    .o_44   (pre_coeff_64_u0[12]),
    .o_45   (pre_coeff_64_u0[13]),
    .o_46   (pre_coeff_64_u0[14]),
    .o_47   (pre_coeff_64_u0[15]),
    .o_48   (pre_coeff_64_u0[16]),
    .o_49   (pre_coeff_64_u0[17]),
    .o_50   (pre_coeff_64_u0[18]),
    .o_51   (pre_coeff_64_u0[19]),
    .o_52   (pre_coeff_64_u0[20]),
    .o_53   (pre_coeff_64_u0[21]),
    .o_54   (pre_coeff_64_u0[22]),
    .o_55   (pre_coeff_64_u0[23]),
    .o_56   (pre_coeff_64_u0[24]),
    .o_57   (pre_coeff_64_u0[25]),
    .o_58   (pre_coeff_64_u0[26]),
    .o_59   (pre_coeff_64_u0[27]),
    .o_60   (pre_coeff_64_u0[28]),
    .o_61   (pre_coeff_64_u0[29]),
    .o_62   (pre_coeff_64_u0[30]),
    .o_63   (pre_coeff_64_u0[31])
);

//32x32
dct1d_32#(
    .IN_WIDTH   (IN_WIDTH + 1)
)
u0_dct1d_32(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_32_valid       ),
    .i_0    (i_dct_32_u0[0 ]    ),
    .i_1    (i_dct_32_u0[1 ]    ),
    .i_2    (i_dct_32_u0[2 ]    ),
    .i_3    (i_dct_32_u0[3 ]    ),
    .i_4    (i_dct_32_u0[4 ]    ),
    .i_5    (i_dct_32_u0[5 ]    ),
    .i_6    (i_dct_32_u0[6 ]    ),
    .i_7    (i_dct_32_u0[7 ]    ),
    .i_8    (i_dct_32_u0[8 ]    ),
    .i_9    (i_dct_32_u0[9 ]    ),
    .i_10   (i_dct_32_u0[10]    ),
    .i_11   (i_dct_32_u0[11]    ),
    .i_12   (i_dct_32_u0[12]    ),
    .i_13   (i_dct_32_u0[13]    ),
    .i_14   (i_dct_32_u0[14]    ),
    .i_15   (i_dct_32_u0[15]    ),
    .i_16   (i_dct_32_u0[16]    ),
    .i_17   (i_dct_32_u0[17]    ),
    .i_18   (i_dct_32_u0[18]    ),
    .i_19   (i_dct_32_u0[19]    ),
    .i_20   (i_dct_32_u0[20]    ),
    .i_21   (i_dct_32_u0[21]    ),
    .i_22   (i_dct_32_u0[22]    ),
    .i_23   (i_dct_32_u0[23]    ),
    .i_24   (i_dct_32_u0[24]    ),
    .i_25   (i_dct_32_u0[25]    ),
    .i_26   (i_dct_32_u0[26]    ),
    .i_27   (i_dct_32_u0[27]    ),
    .i_28   (i_dct_32_u0[28]    ),
    .i_29   (i_dct_32_u0[29]    ),
    .i_30   (i_dct_32_u0[30]    ),
    .i_31   (i_dct_32_u0[31]    ),
//output data
    .o_valid(pre_coeff_32_valid ),
    .o_0    (butterfly_32_u0[0 ]),
    .o_1    (butterfly_32_u0[1 ]),
    .o_2    (butterfly_32_u0[2 ]),
    .o_3    (butterfly_32_u0[3 ]),
    .o_4    (butterfly_32_u0[4 ]),
    .o_5    (butterfly_32_u0[5 ]),
    .o_6    (butterfly_32_u0[6 ]),
    .o_7    (butterfly_32_u0[7 ]),
    .o_8    (butterfly_32_u0[8 ]),
    .o_9    (butterfly_32_u0[9 ]),
    .o_10   (butterfly_32_u0[10]),
    .o_11   (butterfly_32_u0[11]),
    .o_12   (butterfly_32_u0[12]),
    .o_13   (butterfly_32_u0[13]),
    .o_14   (butterfly_32_u0[14]),
    .o_15   (butterfly_32_u0[15]),
    .o_16   (pre_coeff_32_u0[0 ]),
    .o_17   (pre_coeff_32_u0[1 ]),
    .o_18   (pre_coeff_32_u0[2 ]),
    .o_19   (pre_coeff_32_u0[3 ]),
    .o_20   (pre_coeff_32_u0[4 ]),
    .o_21   (pre_coeff_32_u0[5 ]),
    .o_22   (pre_coeff_32_u0[6 ]),
    .o_23   (pre_coeff_32_u0[7 ]),
    .o_24   (pre_coeff_32_u0[8 ]),
    .o_25   (pre_coeff_32_u0[9 ]),
    .o_26   (pre_coeff_32_u0[10]),
    .o_27   (pre_coeff_32_u0[11]),
    .o_28   (pre_coeff_32_u0[12]),
    .o_29   (pre_coeff_32_u0[13]),
    .o_30   (pre_coeff_32_u0[14]),
    .o_31   (pre_coeff_32_u0[15])
);
dct1d_32#(
    .IN_WIDTH   (IN_WIDTH + 1)
)
u1_dct1d_32(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_32_valid       ),
    .i_0    (i_dct_32_u1[0 ]    ),
    .i_1    (i_dct_32_u1[1 ]    ),
    .i_2    (i_dct_32_u1[2 ]    ),
    .i_3    (i_dct_32_u1[3 ]    ),
    .i_4    (i_dct_32_u1[4 ]    ),
    .i_5    (i_dct_32_u1[5 ]    ),
    .i_6    (i_dct_32_u1[6 ]    ),
    .i_7    (i_dct_32_u1[7 ]    ),
    .i_8    (i_dct_32_u1[8 ]    ),
    .i_9    (i_dct_32_u1[9 ]    ),
    .i_10   (i_dct_32_u1[10]    ),
    .i_11   (i_dct_32_u1[11]    ),
    .i_12   (i_dct_32_u1[12]    ),
    .i_13   (i_dct_32_u1[13]    ),
    .i_14   (i_dct_32_u1[14]    ),
    .i_15   (i_dct_32_u1[15]    ),
    .i_16   (i_dct_32_u1[16]    ),
    .i_17   (i_dct_32_u1[17]    ),
    .i_18   (i_dct_32_u1[18]    ),
    .i_19   (i_dct_32_u1[19]    ),
    .i_20   (i_dct_32_u1[20]    ),
    .i_21   (i_dct_32_u1[21]    ),
    .i_22   (i_dct_32_u1[22]    ),
    .i_23   (i_dct_32_u1[23]    ),
    .i_24   (i_dct_32_u1[24]    ),
    .i_25   (i_dct_32_u1[25]    ),
    .i_26   (i_dct_32_u1[26]    ),
    .i_27   (i_dct_32_u1[27]    ),
    .i_28   (i_dct_32_u1[28]    ),
    .i_29   (i_dct_32_u1[29]    ),
    .i_30   (i_dct_32_u1[30]    ),
    .i_31   (i_dct_32_u1[31]    ),
//output data
    .o_valid(),
    .o_0    (butterfly_32_u1[0 ]),
    .o_1    (butterfly_32_u1[1 ]),
    .o_2    (butterfly_32_u1[2 ]),
    .o_3    (butterfly_32_u1[3 ]),
    .o_4    (butterfly_32_u1[4 ]),
    .o_5    (butterfly_32_u1[5 ]),
    .o_6    (butterfly_32_u1[6 ]),
    .o_7    (butterfly_32_u1[7 ]),
    .o_8    (butterfly_32_u1[8 ]),
    .o_9    (butterfly_32_u1[9 ]),
    .o_10   (butterfly_32_u1[10]),
    .o_11   (butterfly_32_u1[11]),
    .o_12   (butterfly_32_u1[12]),
    .o_13   (butterfly_32_u1[13]),
    .o_14   (butterfly_32_u1[14]),
    .o_15   (butterfly_32_u1[15]),
    .o_16   (pre_coeff_32_u1[0 ]),
    .o_17   (pre_coeff_32_u1[1 ]),
    .o_18   (pre_coeff_32_u1[2 ]),
    .o_19   (pre_coeff_32_u1[3 ]),
    .o_20   (pre_coeff_32_u1[4 ]),
    .o_21   (pre_coeff_32_u1[5 ]),
    .o_22   (pre_coeff_32_u1[6 ]),
    .o_23   (pre_coeff_32_u1[7 ]),
    .o_24   (pre_coeff_32_u1[8 ]),
    .o_25   (pre_coeff_32_u1[9 ]),
    .o_26   (pre_coeff_32_u1[10]),
    .o_27   (pre_coeff_32_u1[11]),
    .o_28   (pre_coeff_32_u1[12]),
    .o_29   (pre_coeff_32_u1[13]),
    .o_30   (pre_coeff_32_u1[14]),
    .o_31   (pre_coeff_32_u1[15])
);

//16x16
dct1d_16#(
    .IN_WIDTH   (IN_WIDTH + 2)
)
u0_dct1d_16(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_16_valid       ),
    .i_0    (i_dct_16_u0[0 ]    ),
    .i_1    (i_dct_16_u0[1 ]    ),
    .i_2    (i_dct_16_u0[2 ]    ),
    .i_3    (i_dct_16_u0[3 ]    ),
    .i_4    (i_dct_16_u0[4 ]    ),
    .i_5    (i_dct_16_u0[5 ]    ),
    .i_6    (i_dct_16_u0[6 ]    ),
    .i_7    (i_dct_16_u0[7 ]    ),
    .i_8    (i_dct_16_u0[8 ]    ),
    .i_9    (i_dct_16_u0[9 ]    ),
    .i_10   (i_dct_16_u0[10]    ),
    .i_11   (i_dct_16_u0[11]    ),
    .i_12   (i_dct_16_u0[12]    ),
    .i_13   (i_dct_16_u0[13]    ),
    .i_14   (i_dct_16_u0[14]    ),
    .i_15   (i_dct_16_u0[15]    ),
//output data
    .o_valid(pre_coeff_16_valid ),
    .o_0    (butterfly_16_u0[0 ]),
    .o_1    (butterfly_16_u0[1 ]),
    .o_2    (butterfly_16_u0[2 ]),
    .o_3    (butterfly_16_u0[3 ]),
    .o_4    (butterfly_16_u0[4 ]),
    .o_5    (butterfly_16_u0[5 ]),
    .o_6    (butterfly_16_u0[6 ]),
    .o_7    (butterfly_16_u0[7 ]),
    .o_8    (pre_coeff_16_u0[0 ]),
    .o_9    (pre_coeff_16_u0[1 ]),
    .o_10   (pre_coeff_16_u0[2 ]),
    .o_11   (pre_coeff_16_u0[3 ]),
    .o_12   (pre_coeff_16_u0[4 ]),
    .o_13   (pre_coeff_16_u0[5 ]),
    .o_14   (pre_coeff_16_u0[6 ]),
    .o_15   (pre_coeff_16_u0[7 ])
);
dct1d_16#(
    .IN_WIDTH   (IN_WIDTH + 2)
)
u1_dct1d_16(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_16_valid       ),
    .i_0    (i_dct_16_u1[0 ]    ),
    .i_1    (i_dct_16_u1[1 ]    ),
    .i_2    (i_dct_16_u1[2 ]    ),
    .i_3    (i_dct_16_u1[3 ]    ),
    .i_4    (i_dct_16_u1[4 ]    ),
    .i_5    (i_dct_16_u1[5 ]    ),
    .i_6    (i_dct_16_u1[6 ]    ),
    .i_7    (i_dct_16_u1[7 ]    ),
    .i_8    (i_dct_16_u1[8 ]    ),
    .i_9    (i_dct_16_u1[9 ]    ),
    .i_10   (i_dct_16_u1[10]    ),
    .i_11   (i_dct_16_u1[11]    ),
    .i_12   (i_dct_16_u1[12]    ),
    .i_13   (i_dct_16_u1[13]    ),
    .i_14   (i_dct_16_u1[14]    ),
    .i_15   (i_dct_16_u1[15]    ),
//output data
    .o_valid(),
    .o_0    (butterfly_16_u1[0 ]),
    .o_1    (butterfly_16_u1[1 ]),
    .o_2    (butterfly_16_u1[2 ]),
    .o_3    (butterfly_16_u1[3 ]),
    .o_4    (butterfly_16_u1[4 ]),
    .o_5    (butterfly_16_u1[5 ]),
    .o_6    (butterfly_16_u1[6 ]),
    .o_7    (butterfly_16_u1[7 ]),
    .o_8    (pre_coeff_16_u1[0 ]),
    .o_9    (pre_coeff_16_u1[1 ]),
    .o_10   (pre_coeff_16_u1[2 ]),
    .o_11   (pre_coeff_16_u1[3 ]),
    .o_12   (pre_coeff_16_u1[4 ]),
    .o_13   (pre_coeff_16_u1[5 ]),
    .o_14   (pre_coeff_16_u1[6 ]),
    .o_15   (pre_coeff_16_u1[7 ])
);
dct1d_16#(
    .IN_WIDTH   (IN_WIDTH + 2)
)
u2_dct1d_16(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_16_valid       ),
    .i_0    (i_dct_16_u2[0 ]    ),
    .i_1    (i_dct_16_u2[1 ]    ),
    .i_2    (i_dct_16_u2[2 ]    ),
    .i_3    (i_dct_16_u2[3 ]    ),
    .i_4    (i_dct_16_u2[4 ]    ),
    .i_5    (i_dct_16_u2[5 ]    ),
    .i_6    (i_dct_16_u2[6 ]    ),
    .i_7    (i_dct_16_u2[7 ]    ),
    .i_8    (i_dct_16_u2[8 ]    ),
    .i_9    (i_dct_16_u2[9 ]    ),
    .i_10   (i_dct_16_u2[10]    ),
    .i_11   (i_dct_16_u2[11]    ),
    .i_12   (i_dct_16_u2[12]    ),
    .i_13   (i_dct_16_u2[13]    ),
    .i_14   (i_dct_16_u2[14]    ),
    .i_15   (i_dct_16_u2[15]    ),
//output data
    .o_valid(),
    .o_0    (butterfly_16_u2[0 ]),
    .o_1    (butterfly_16_u2[1 ]),
    .o_2    (butterfly_16_u2[2 ]),
    .o_3    (butterfly_16_u2[3 ]),
    .o_4    (butterfly_16_u2[4 ]),
    .o_5    (butterfly_16_u2[5 ]),
    .o_6    (butterfly_16_u2[6 ]),
    .o_7    (butterfly_16_u2[7 ]),
    .o_8    (pre_coeff_16_u2[0 ]),
    .o_9    (pre_coeff_16_u2[1 ]),
    .o_10   (pre_coeff_16_u2[2 ]),
    .o_11   (pre_coeff_16_u2[3 ]),
    .o_12   (pre_coeff_16_u2[4 ]),
    .o_13   (pre_coeff_16_u2[5 ]),
    .o_14   (pre_coeff_16_u2[6 ]),
    .o_15   (pre_coeff_16_u2[7 ])
);
dct1d_16#(
    .IN_WIDTH   (IN_WIDTH + 2)
)
u3_dct1d_16(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_16_valid       ),
    .i_0    (i_dct_16_u3[0 ]    ),
    .i_1    (i_dct_16_u3[1 ]    ),
    .i_2    (i_dct_16_u3[2 ]    ),
    .i_3    (i_dct_16_u3[3 ]    ),
    .i_4    (i_dct_16_u3[4 ]    ),
    .i_5    (i_dct_16_u3[5 ]    ),
    .i_6    (i_dct_16_u3[6 ]    ),
    .i_7    (i_dct_16_u3[7 ]    ),
    .i_8    (i_dct_16_u3[8 ]    ),
    .i_9    (i_dct_16_u3[9 ]    ),
    .i_10   (i_dct_16_u3[10]    ),
    .i_11   (i_dct_16_u3[11]    ),
    .i_12   (i_dct_16_u3[12]    ),
    .i_13   (i_dct_16_u3[13]    ),
    .i_14   (i_dct_16_u3[14]    ),
    .i_15   (i_dct_16_u3[15]    ),
//output data
    .o_valid(),
    .o_0    (butterfly_16_u3[0 ]),
    .o_1    (butterfly_16_u3[1 ]),
    .o_2    (butterfly_16_u3[2 ]),
    .o_3    (butterfly_16_u3[3 ]),
    .o_4    (butterfly_16_u3[4 ]),
    .o_5    (butterfly_16_u3[5 ]),
    .o_6    (butterfly_16_u3[6 ]),
    .o_7    (butterfly_16_u3[7 ]),
    .o_8    (pre_coeff_16_u3[0 ]),
    .o_9    (pre_coeff_16_u3[1 ]),
    .o_10   (pre_coeff_16_u3[2 ]),
    .o_11   (pre_coeff_16_u3[3 ]),
    .o_12   (pre_coeff_16_u3[4 ]),
    .o_13   (pre_coeff_16_u3[5 ]),
    .o_14   (pre_coeff_16_u3[6 ]),
    .o_15   (pre_coeff_16_u3[7 ])
);

//8x8
dct1d_8#(
    .IN_WIDTH   (IN_WIDTH + 3)
)
u0_dct1d_8(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_8_valid        ),
    .i_0    (i_dct_8_u0[0 ]     ),
    .i_1    (i_dct_8_u0[1 ]     ),
    .i_2    (i_dct_8_u0[2 ]     ),
    .i_3    (i_dct_8_u0[3 ]     ),
    .i_4    (i_dct_8_u0[4 ]     ),
    .i_5    (i_dct_8_u0[5 ]     ),
    .i_6    (i_dct_8_u0[6 ]     ),
    .i_7    (i_dct_8_u0[7 ]     ),
//output data
    .o_valid(pre_coeff_8_valid  ),
    .o_0    (butterfly_8_u0[0 ] ),
    .o_1    (butterfly_8_u0[1 ] ),
    .o_2    (butterfly_8_u0[2 ] ),
    .o_3    (butterfly_8_u0[3 ] ),
    .o_4    (pre_coeff_8_u0[0 ] ),
    .o_5    (pre_coeff_8_u0[1 ] ),
    .o_6    (pre_coeff_8_u0[2 ] ),
    .o_7    (pre_coeff_8_u0[3 ] )
);
dct1d_8#(
    .IN_WIDTH   (IN_WIDTH + 3)
)
u1_dct1d_8(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_8_valid        ),
    .i_0    (i_dct_8_u1[0 ]     ),
    .i_1    (i_dct_8_u1[1 ]     ),
    .i_2    (i_dct_8_u1[2 ]     ),
    .i_3    (i_dct_8_u1[3 ]     ),
    .i_4    (i_dct_8_u1[4 ]     ),
    .i_5    (i_dct_8_u1[5 ]     ),
    .i_6    (i_dct_8_u1[6 ]     ),
    .i_7    (i_dct_8_u1[7 ]     ),
//output data
    .o_valid(),
    .o_0    (butterfly_8_u1[0 ] ),
    .o_1    (butterfly_8_u1[1 ] ),
    .o_2    (butterfly_8_u1[2 ] ),
    .o_3    (butterfly_8_u1[3 ] ),
    .o_4    (pre_coeff_8_u1[0 ] ),
    .o_5    (pre_coeff_8_u1[1 ] ),
    .o_6    (pre_coeff_8_u1[2 ] ),
    .o_7    (pre_coeff_8_u1[3 ] )
);
dct1d_8#(
    .IN_WIDTH   (IN_WIDTH + 3)
)
u2_dct1d_8(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_8_valid        ),
    .i_0    (i_dct_8_u2[0 ]     ),
    .i_1    (i_dct_8_u2[1 ]     ),
    .i_2    (i_dct_8_u2[2 ]     ),
    .i_3    (i_dct_8_u2[3 ]     ),
    .i_4    (i_dct_8_u2[4 ]     ),
    .i_5    (i_dct_8_u2[5 ]     ),
    .i_6    (i_dct_8_u2[6 ]     ),
    .i_7    (i_dct_8_u2[7 ]     ),
//output data
    .o_valid(),
    .o_0    (butterfly_8_u2[0 ] ),
    .o_1    (butterfly_8_u2[1 ] ),
    .o_2    (butterfly_8_u2[2 ] ),
    .o_3    (butterfly_8_u2[3 ] ),
    .o_4    (pre_coeff_8_u2[0 ] ),
    .o_5    (pre_coeff_8_u2[1 ] ),
    .o_6    (pre_coeff_8_u2[2 ] ),
    .o_7    (pre_coeff_8_u2[3 ] )
);
dct1d_8#(
    .IN_WIDTH   (IN_WIDTH + 3)
)
u3_dct1d_8(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_8_valid        ),
    .i_0    (i_dct_8_u3[0 ]     ),
    .i_1    (i_dct_8_u3[1 ]     ),
    .i_2    (i_dct_8_u3[2 ]     ),
    .i_3    (i_dct_8_u3[3 ]     ),
    .i_4    (i_dct_8_u3[4 ]     ),
    .i_5    (i_dct_8_u3[5 ]     ),
    .i_6    (i_dct_8_u3[6 ]     ),
    .i_7    (i_dct_8_u3[7 ]     ),
//output data
    .o_valid(),
    .o_0    (butterfly_8_u3[0 ] ),
    .o_1    (butterfly_8_u3[1 ] ),
    .o_2    (butterfly_8_u3[2 ] ),
    .o_3    (butterfly_8_u3[3 ] ),
    .o_4    (pre_coeff_8_u3[0 ] ),
    .o_5    (pre_coeff_8_u3[1 ] ),
    .o_6    (pre_coeff_8_u3[2 ] ),
    .o_7    (pre_coeff_8_u3[3 ] )
);
dct1d_8#(
    .IN_WIDTH   (IN_WIDTH + 3)
)
u4_dct1d_8(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_8_valid        ),
    .i_0    (i_dct_8_u4[0 ]     ),
    .i_1    (i_dct_8_u4[1 ]     ),
    .i_2    (i_dct_8_u4[2 ]     ),
    .i_3    (i_dct_8_u4[3 ]     ),
    .i_4    (i_dct_8_u4[4 ]     ),
    .i_5    (i_dct_8_u4[5 ]     ),
    .i_6    (i_dct_8_u4[6 ]     ),
    .i_7    (i_dct_8_u4[7 ]     ),
//output data
    .o_valid(),
    .o_0    (butterfly_8_u4[0 ] ),
    .o_1    (butterfly_8_u4[1 ] ),
    .o_2    (butterfly_8_u4[2 ] ),
    .o_3    (butterfly_8_u4[3 ] ),
    .o_4    (pre_coeff_8_u4[0 ] ),
    .o_5    (pre_coeff_8_u4[1 ] ),
    .o_6    (pre_coeff_8_u4[2 ] ),
    .o_7    (pre_coeff_8_u4[3 ] )
);
dct1d_8#(
    .IN_WIDTH   (IN_WIDTH + 3)
)
u5_dct1d_8(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_8_valid        ),
    .i_0    (i_dct_8_u5[0 ]     ),
    .i_1    (i_dct_8_u5[1 ]     ),
    .i_2    (i_dct_8_u5[2 ]     ),
    .i_3    (i_dct_8_u5[3 ]     ),
    .i_4    (i_dct_8_u5[4 ]     ),
    .i_5    (i_dct_8_u5[5 ]     ),
    .i_6    (i_dct_8_u5[6 ]     ),
    .i_7    (i_dct_8_u5[7 ]     ),
//output data
    .o_valid(),
    .o_0    (butterfly_8_u5[0 ] ),
    .o_1    (butterfly_8_u5[1 ] ),
    .o_2    (butterfly_8_u5[2 ] ),
    .o_3    (butterfly_8_u5[3 ] ),
    .o_4    (pre_coeff_8_u5[0 ] ),
    .o_5    (pre_coeff_8_u5[1 ] ),
    .o_6    (pre_coeff_8_u5[2 ] ),
    .o_7    (pre_coeff_8_u5[3 ] )
);
dct1d_8#(
    .IN_WIDTH   (IN_WIDTH + 3)
)
u6_dct1d_8(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_8_valid        ),
    .i_0    (i_dct_8_u6[0 ]     ),
    .i_1    (i_dct_8_u6[1 ]     ),
    .i_2    (i_dct_8_u6[2 ]     ),
    .i_3    (i_dct_8_u6[3 ]     ),
    .i_4    (i_dct_8_u6[4 ]     ),
    .i_5    (i_dct_8_u6[5 ]     ),
    .i_6    (i_dct_8_u6[6 ]     ),
    .i_7    (i_dct_8_u6[7 ]     ),
//output data
    .o_valid(),
    .o_0    (butterfly_8_u6[0 ] ),
    .o_1    (butterfly_8_u6[1 ] ),
    .o_2    (butterfly_8_u6[2 ] ),
    .o_3    (butterfly_8_u6[3 ] ),
    .o_4    (pre_coeff_8_u6[0 ] ),
    .o_5    (pre_coeff_8_u6[1 ] ),
    .o_6    (pre_coeff_8_u6[2 ] ),
    .o_7    (pre_coeff_8_u6[3 ] )
);
dct1d_8#(
    .IN_WIDTH   (IN_WIDTH + 3)
)
u7_dct1d_8(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_8_valid        ),
    .i_0    (i_dct_8_u7[0 ]     ),
    .i_1    (i_dct_8_u7[1 ]     ),
    .i_2    (i_dct_8_u7[2 ]     ),
    .i_3    (i_dct_8_u7[3 ]     ),
    .i_4    (i_dct_8_u7[4 ]     ),
    .i_5    (i_dct_8_u7[5 ]     ),
    .i_6    (i_dct_8_u7[6 ]     ),
    .i_7    (i_dct_8_u7[7 ]     ),
//output data
    .o_valid(),
    .o_0    (butterfly_8_u7[0 ] ),
    .o_1    (butterfly_8_u7[1 ] ),
    .o_2    (butterfly_8_u7[2 ] ),
    .o_3    (butterfly_8_u7[3 ] ),
    .o_4    (pre_coeff_8_u7[0 ] ),
    .o_5    (pre_coeff_8_u7[1 ] ),
    .o_6    (pre_coeff_8_u7[2 ] ),
    .o_7    (pre_coeff_8_u7[3 ] )
);

//4x4
dct1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u0_dct1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_4_valid        ),
    .i_0    (i_dct_4_u0[0 ]     ),
    .i_1    (i_dct_4_u0[1 ]     ),
    .i_2    (i_dct_4_u0[2 ]     ),
    .i_3    (i_dct_4_u0[3 ]     ),
//output data
    .o_valid(pre_coeff_4_valid  ),
    .o_0    (pre_coeff_4_u0[0 ] ),
    .o_1    (pre_coeff_4_u0[1 ] ),
    .o_2    (pre_coeff_4_u0[2 ] ),
    .o_3    (pre_coeff_4_u0[3 ] )
);
dct1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u1_dct1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_4_valid        ),
    .i_0    (i_dct_4_u1[0 ]     ),
    .i_1    (i_dct_4_u1[1 ]     ),
    .i_2    (i_dct_4_u1[2 ]     ),
    .i_3    (i_dct_4_u1[3 ]     ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u1[0 ] ),
    .o_1    (pre_coeff_4_u1[1 ] ),
    .o_2    (pre_coeff_4_u1[2 ] ),
    .o_3    (pre_coeff_4_u1[3 ] )
);
dct1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u2_dct1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_4_valid        ),
    .i_0    (i_dct_4_u2[0 ]     ),
    .i_1    (i_dct_4_u2[1 ]     ),
    .i_2    (i_dct_4_u2[2 ]     ),
    .i_3    (i_dct_4_u2[3 ]     ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u2[0 ] ),
    .o_1    (pre_coeff_4_u2[1 ] ),
    .o_2    (pre_coeff_4_u2[2 ] ),
    .o_3    (pre_coeff_4_u2[3 ] )
);
dct1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u3_dct1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_4_valid        ),
    .i_0    (i_dct_4_u3[0 ]     ),
    .i_1    (i_dct_4_u3[1 ]     ),
    .i_2    (i_dct_4_u3[2 ]     ),
    .i_3    (i_dct_4_u3[3 ]     ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u3[0 ] ),
    .o_1    (pre_coeff_4_u3[1 ] ),
    .o_2    (pre_coeff_4_u3[2 ] ),
    .o_3    (pre_coeff_4_u3[3 ] )
);
dct1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u4_dct1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_4_valid        ),
    .i_0    (i_dct_4_u4[0 ]     ),
    .i_1    (i_dct_4_u4[1 ]     ),
    .i_2    (i_dct_4_u4[2 ]     ),
    .i_3    (i_dct_4_u4[3 ]     ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u4[0 ] ),
    .o_1    (pre_coeff_4_u4[1 ] ),
    .o_2    (pre_coeff_4_u4[2 ] ),
    .o_3    (pre_coeff_4_u4[3 ] )
);
dct1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u5_dct1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_4_valid        ),
    .i_0    (i_dct_4_u5[0 ]     ),
    .i_1    (i_dct_4_u5[1 ]     ),
    .i_2    (i_dct_4_u5[2 ]     ),
    .i_3    (i_dct_4_u5[3 ]     ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u5[0 ] ),
    .o_1    (pre_coeff_4_u5[1 ] ),
    .o_2    (pre_coeff_4_u5[2 ] ),
    .o_3    (pre_coeff_4_u5[3 ] )
);
dct1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u6_dct1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_4_valid        ),
    .i_0    (i_dct_4_u6[0 ]     ),
    .i_1    (i_dct_4_u6[1 ]     ),
    .i_2    (i_dct_4_u6[2 ]     ),
    .i_3    (i_dct_4_u6[3 ]     ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u6[0 ] ),
    .o_1    (pre_coeff_4_u6[1 ] ),
    .o_2    (pre_coeff_4_u6[2 ] ),
    .o_3    (pre_coeff_4_u6[3 ] )
);
dct1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u7_dct1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_4_valid        ),
    .i_0    (i_dct_4_u7[0 ]     ),
    .i_1    (i_dct_4_u7[1 ]     ),
    .i_2    (i_dct_4_u7[2 ]     ),
    .i_3    (i_dct_4_u7[3 ]     ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u7[0 ] ),
    .o_1    (pre_coeff_4_u7[1 ] ),
    .o_2    (pre_coeff_4_u7[2 ] ),
    .o_3    (pre_coeff_4_u7[3 ] )
);
dct1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u8_dct1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_4_valid        ),
    .i_0    (i_dct_4_u8[0 ]     ),
    .i_1    (i_dct_4_u8[1 ]     ),
    .i_2    (i_dct_4_u8[2 ]     ),
    .i_3    (i_dct_4_u8[3 ]     ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u8[0 ] ),
    .o_1    (pre_coeff_4_u8[1 ] ),
    .o_2    (pre_coeff_4_u8[2 ] ),
    .o_3    (pre_coeff_4_u8[3 ] )
);
dct1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u9_dct1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_4_valid        ),
    .i_0    (i_dct_4_u9[0 ]     ),
    .i_1    (i_dct_4_u9[1 ]     ),
    .i_2    (i_dct_4_u9[2 ]     ),
    .i_3    (i_dct_4_u9[3 ]     ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u9[0 ] ),
    .o_1    (pre_coeff_4_u9[1 ] ),
    .o_2    (pre_coeff_4_u9[2 ] ),
    .o_3    (pre_coeff_4_u9[3 ] )
);
dct1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u10_dct1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_4_valid        ),
    .i_0    (i_dct_4_u10[0 ]    ),
    .i_1    (i_dct_4_u10[1 ]    ),
    .i_2    (i_dct_4_u10[2 ]    ),
    .i_3    (i_dct_4_u10[3 ]    ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u10[0 ]),
    .o_1    (pre_coeff_4_u10[1 ]),
    .o_2    (pre_coeff_4_u10[2 ]),
    .o_3    (pre_coeff_4_u10[3 ])
);
dct1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u11_dct1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_4_valid        ),
    .i_0    (i_dct_4_u11[0 ]    ),
    .i_1    (i_dct_4_u11[1 ]    ),
    .i_2    (i_dct_4_u11[2 ]    ),
    .i_3    (i_dct_4_u11[3 ]    ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u11[0 ]),
    .o_1    (pre_coeff_4_u11[1 ]),
    .o_2    (pre_coeff_4_u11[2 ]),
    .o_3    (pre_coeff_4_u11[3 ])
);
dct1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u12_dct1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_4_valid        ),
    .i_0    (i_dct_4_u12[0 ]    ),
    .i_1    (i_dct_4_u12[1 ]    ),
    .i_2    (i_dct_4_u12[2 ]    ),
    .i_3    (i_dct_4_u12[3 ]    ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u12[0 ]),
    .o_1    (pre_coeff_4_u12[1 ]),
    .o_2    (pre_coeff_4_u12[2 ]),
    .o_3    (pre_coeff_4_u12[3 ])
);
dct1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u13_dct1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_4_valid        ),
    .i_0    (i_dct_4_u13[0 ]    ),
    .i_1    (i_dct_4_u13[1 ]    ),
    .i_2    (i_dct_4_u13[2 ]    ),
    .i_3    (i_dct_4_u13[3 ]    ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u13[0 ]),
    .o_1    (pre_coeff_4_u13[1 ]),
    .o_2    (pre_coeff_4_u13[2 ]),
    .o_3    (pre_coeff_4_u13[3 ])
);
dct1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u14_dct1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_4_valid        ),
    .i_0    (i_dct_4_u14[0 ]    ),
    .i_1    (i_dct_4_u14[1 ]    ),
    .i_2    (i_dct_4_u14[2 ]    ),
    .i_3    (i_dct_4_u14[3 ]    ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u14[0 ]),
    .o_1    (pre_coeff_4_u14[1 ]),
    .o_2    (pre_coeff_4_u14[2 ]),
    .o_3    (pre_coeff_4_u14[3 ])
);
dct1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u15_dct1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_width_d[3]       ),
//input data
    .i_valid(dct_4_valid        ),
    .i_0    (i_dct_4_u15[0 ]    ),
    .i_1    (i_dct_4_u15[1 ]    ),
    .i_2    (i_dct_4_u15[2 ]    ),
    .i_3    (i_dct_4_u15[3 ]    ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u15[0 ]),
    .o_1    (pre_coeff_4_u15[1 ]),
    .o_2    (pre_coeff_4_u15[2 ]),
    .o_3    (pre_coeff_4_u15[3 ])
);

right_shift#(
    .IN_WIDTH  (IN_WIDTH + 12   ),
    .OUT_WIDTH (OUT_WIDTH       )
)
u_right_shift(
//system input
    .clk     (clk               ),
    .rst_n   (rst_n             ),
//input parameter
    .i_shift (dct_shift         ),
//input pre_coeff
    .i_valid (pre_coeff_valid   ),
    .i_0     (pre_coeff[0 ]     ),
    .i_1     (pre_coeff[1 ]     ),
    .i_2     (pre_coeff[2 ]     ),
    .i_3     (pre_coeff[3 ]     ),
    .i_4     (pre_coeff[4 ]     ),
    .i_5     (pre_coeff[5 ]     ),
    .i_6     (pre_coeff[6 ]     ),
    .i_7     (pre_coeff[7 ]     ),
    .i_8     (pre_coeff[8 ]     ),
    .i_9     (pre_coeff[9 ]     ),
    .i_10    (pre_coeff[10]     ),
    .i_11    (pre_coeff[11]     ),
    .i_12    (pre_coeff[12]     ),
    .i_13    (pre_coeff[13]     ),
    .i_14    (pre_coeff[14]     ),
    .i_15    (pre_coeff[15]     ),
    .i_16    (pre_coeff[16]     ),
    .i_17    (pre_coeff[17]     ),
    .i_18    (pre_coeff[18]     ),
    .i_19    (pre_coeff[19]     ),
    .i_20    (pre_coeff[20]     ),
    .i_21    (pre_coeff[21]     ),
    .i_22    (pre_coeff[22]     ),
    .i_23    (pre_coeff[23]     ),
    .i_24    (pre_coeff[24]     ),
    .i_25    (pre_coeff[25]     ),
    .i_26    (pre_coeff[26]     ),
    .i_27    (pre_coeff[27]     ),
    .i_28    (pre_coeff[28]     ),
    .i_29    (pre_coeff[29]     ),
    .i_30    (pre_coeff[30]     ),
    .i_31    (pre_coeff[31]     ),
    .i_32    (pre_coeff[32]     ),
    .i_33    (pre_coeff[33]     ),
    .i_34    (pre_coeff[34]     ),
    .i_35    (pre_coeff[35]     ),
    .i_36    (pre_coeff[36]     ),
    .i_37    (pre_coeff[37]     ),
    .i_38    (pre_coeff[38]     ),
    .i_39    (pre_coeff[39]     ),
    .i_40    (pre_coeff[40]     ),
    .i_41    (pre_coeff[41]     ),
    .i_42    (pre_coeff[42]     ),
    .i_43    (pre_coeff[43]     ),
    .i_44    (pre_coeff[44]     ),
    .i_45    (pre_coeff[45]     ),
    .i_46    (pre_coeff[46]     ),
    .i_47    (pre_coeff[47]     ),
    .i_48    (pre_coeff[48]     ),
    .i_49    (pre_coeff[49]     ),
    .i_50    (pre_coeff[50]     ),
    .i_51    (pre_coeff[51]     ),
    .i_52    (pre_coeff[52]     ),
    .i_53    (pre_coeff[53]     ),
    .i_54    (pre_coeff[54]     ),
    .i_55    (pre_coeff[55]     ),
    .i_56    (pre_coeff[56]     ),
    .i_57    (pre_coeff[57]     ),
    .i_58    (pre_coeff[58]     ),
    .i_59    (pre_coeff[59]     ),
    .i_60    (pre_coeff[60]     ),
    .i_61    (pre_coeff[61]     ),
    .i_62    (pre_coeff[62]     ),
    .i_63    (pre_coeff[63]     ),
//output coeff
    .o_valid (coeff_valid       ),
    .o_0     (coeff[0 ]         ),
    .o_1     (coeff[1 ]         ),
    .o_2     (coeff[2 ]         ),
    .o_3     (coeff[3 ]         ),
    .o_4     (coeff[4 ]         ),
    .o_5     (coeff[5 ]         ),
    .o_6     (coeff[6 ]         ),
    .o_7     (coeff[7 ]         ),
    .o_8     (coeff[8 ]         ),
    .o_9     (coeff[9 ]         ),
    .o_10    (coeff[10]         ),
    .o_11    (coeff[11]         ),
    .o_12    (coeff[12]         ),
    .o_13    (coeff[13]         ),
    .o_14    (coeff[14]         ),
    .o_15    (coeff[15]         ),
    .o_16    (coeff[16]         ),
    .o_17    (coeff[17]         ),
    .o_18    (coeff[18]         ),
    .o_19    (coeff[19]         ),
    .o_20    (coeff[20]         ),
    .o_21    (coeff[21]         ),
    .o_22    (coeff[22]         ),
    .o_23    (coeff[23]         ),
    .o_24    (coeff[24]         ),
    .o_25    (coeff[25]         ),
    .o_26    (coeff[26]         ),
    .o_27    (coeff[27]         ),
    .o_28    (coeff[28]         ),
    .o_29    (coeff[29]         ),
    .o_30    (coeff[30]         ),
    .o_31    (coeff[31]         ),
    .o_32    (coeff[32]         ),
    .o_33    (coeff[33]         ),
    .o_34    (coeff[34]         ),
    .o_35    (coeff[35]         ),
    .o_36    (coeff[36]         ),
    .o_37    (coeff[37]         ),
    .o_38    (coeff[38]         ),
    .o_39    (coeff[39]         ),
    .o_40    (coeff[40]         ),
    .o_41    (coeff[41]         ),
    .o_42    (coeff[42]         ),
    .o_43    (coeff[43]         ),
    .o_44    (coeff[44]         ),
    .o_45    (coeff[45]         ),
    .o_46    (coeff[46]         ),
    .o_47    (coeff[47]         ),
    .o_48    (coeff[48]         ),
    .o_49    (coeff[49]         ),
    .o_50    (coeff[50]         ),
    .o_51    (coeff[51]         ),
    .o_52    (coeff[52]         ),
    .o_53    (coeff[53]         ),
    .o_54    (coeff[54]         ),
    .o_55    (coeff[55]         ),
    .o_56    (coeff[56]         ),
    .o_57    (coeff[57]         ),
    .o_58    (coeff[58]         ),
    .o_59    (coeff[59]         ),
    .o_60    (coeff[60]         ),
    .o_61    (coeff[61]         ),
    .o_62    (coeff[62]         ),
    .o_63    (coeff[63]         )
);

//output
    assign o_width  = i_width_d[5]  ;
    assign o_height = i_height_d[5] ;
    assign o_valid  = coeff_valid   ;
    assign o_0      = coeff[0 ]     ;
    assign o_1      = coeff[1 ]     ;
    assign o_2      = coeff[2 ]     ;
    assign o_3      = coeff[3 ]     ;
    assign o_4      = coeff[4 ]     ;
    assign o_5      = coeff[5 ]     ;
    assign o_6      = coeff[6 ]     ;
    assign o_7      = coeff[7 ]     ;
    assign o_8      = coeff[8 ]     ;
    assign o_9      = coeff[9 ]     ;
    assign o_10     = coeff[10]     ;
    assign o_11     = coeff[11]     ;
    assign o_12     = coeff[12]     ;
    assign o_13     = coeff[13]     ;
    assign o_14     = coeff[14]     ;
    assign o_15     = coeff[15]     ;
    assign o_16     = coeff[16]     ;
    assign o_17     = coeff[17]     ;
    assign o_18     = coeff[18]     ;
    assign o_19     = coeff[19]     ;
    assign o_20     = coeff[20]     ;
    assign o_21     = coeff[21]     ;
    assign o_22     = coeff[22]     ;
    assign o_23     = coeff[23]     ;
    assign o_24     = coeff[24]     ;
    assign o_25     = coeff[25]     ;
    assign o_26     = coeff[26]     ;
    assign o_27     = coeff[27]     ;
    assign o_28     = coeff[28]     ;
    assign o_29     = coeff[29]     ;
    assign o_30     = coeff[30]     ;
    assign o_31     = coeff[31]     ;
    assign o_32     = coeff[32]     ;
    assign o_33     = coeff[33]     ;
    assign o_34     = coeff[34]     ;
    assign o_35     = coeff[35]     ;
    assign o_36     = coeff[36]     ;
    assign o_37     = coeff[37]     ;
    assign o_38     = coeff[38]     ;
    assign o_39     = coeff[39]     ;
    assign o_40     = coeff[40]     ;
    assign o_41     = coeff[41]     ;
    assign o_42     = coeff[42]     ;
    assign o_43     = coeff[43]     ;
    assign o_44     = coeff[44]     ;
    assign o_45     = coeff[45]     ;
    assign o_46     = coeff[46]     ;
    assign o_47     = coeff[47]     ;
    assign o_48     = coeff[48]     ;
    assign o_49     = coeff[49]     ;
    assign o_50     = coeff[50]     ;
    assign o_51     = coeff[51]     ;
    assign o_52     = coeff[52]     ;
    assign o_53     = coeff[53]     ;
    assign o_54     = coeff[54]     ;
    assign o_55     = coeff[55]     ;
    assign o_56     = coeff[56]     ;
    assign o_57     = coeff[57]     ;
    assign o_58     = coeff[58]     ;
    assign o_59     = coeff[59]     ;
    assign o_60     = coeff[60]     ;
    assign o_61     = coeff[61]     ;
    assign o_62     = coeff[62]     ;
    assign o_63     = coeff[63]     ;

endmodule
