//describe  : 第二次一维DCT2
//input     : 16-64个一维变换系数
//output    : 16-32个二维变换系数
//delay     : 6 clk
module dct2_1d_2nd#(
    parameter  IN_WIDTH  = 16
)
(
//system input
    input                               clk     ,
    input                               rst_n   ,
//input parameter
    input           [2 : 0]             i_width ,//1:4x4, 2:8x8, 3:16x16, 4:32x32, 5:64x64
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
    output  signed  [IN_WIDTH + 11 : 0] o_0     ,
    output  signed  [IN_WIDTH + 11 : 0] o_1     ,
    output  signed  [IN_WIDTH + 11 : 0] o_2     ,
    output  signed  [IN_WIDTH + 11 : 0] o_3     ,
    output  signed  [IN_WIDTH + 11 : 0] o_4     ,
    output  signed  [IN_WIDTH + 11 : 0] o_5     ,
    output  signed  [IN_WIDTH + 11 : 0] o_6     ,
    output  signed  [IN_WIDTH + 11 : 0] o_7     ,
    output  signed  [IN_WIDTH + 11 : 0] o_8     ,
    output  signed  [IN_WIDTH + 11 : 0] o_9     ,
    output  signed  [IN_WIDTH + 11 : 0] o_10    ,
    output  signed  [IN_WIDTH + 11 : 0] o_11    ,
    output  signed  [IN_WIDTH + 11 : 0] o_12    ,
    output  signed  [IN_WIDTH + 11 : 0] o_13    ,
    output  signed  [IN_WIDTH + 11 : 0] o_14    ,
    output  signed  [IN_WIDTH + 11 : 0] o_15    ,
    output  signed  [IN_WIDTH + 11 : 0] o_16    ,
    output  signed  [IN_WIDTH + 11 : 0] o_17    ,
    output  signed  [IN_WIDTH + 11 : 0] o_18    ,
    output  signed  [IN_WIDTH + 11 : 0] o_19    ,
    output  signed  [IN_WIDTH + 11 : 0] o_20    ,
    output  signed  [IN_WIDTH + 11 : 0] o_21    ,
    output  signed  [IN_WIDTH + 11 : 0] o_22    ,
    output  signed  [IN_WIDTH + 11 : 0] o_23    ,
    output  signed  [IN_WIDTH + 11 : 0] o_24    ,
    output  signed  [IN_WIDTH + 11 : 0] o_25    ,
    output  signed  [IN_WIDTH + 11 : 0] o_26    ,
    output  signed  [IN_WIDTH + 11 : 0] o_27    ,
    output  signed  [IN_WIDTH + 11 : 0] o_28    ,
    output  signed  [IN_WIDTH + 11 : 0] o_29    ,
    output  signed  [IN_WIDTH + 11 : 0] o_30    ,
    output  signed  [IN_WIDTH + 11 : 0] o_31    
);

localparam  SIZE4  = 3'd1,
            SIZE8  = 3'd2,
            SIZE16 = 3'd3,
            SIZE32 = 3'd4,
            SIZE64 = 3'd5;
integer i;

//input
    reg i_valid_d1, i_valid_d2, i_valid_d3, i_valid_d4;
    wire signed [IN_WIDTH - 1 : 0] i_data[0 : 63];
    reg signed [IN_WIDTH - 1 : 0] i_data_d1[0 : 63], i_data_d2[0 : 63], i_data_d3[0 : 63], i_data_d4[0 : 63];
    reg [2 : 0] i_width_d[0 : 5];
    reg [2 : 0] i_height_d[0 : 5];
//size mux in
    reg tr_in_64_valid, tr_in_32_valid, tr_in_16_valid, tr_in_8_valid, tr_in_4_valid;  
    reg  signed [IN_WIDTH - 1 : 0] tr_in_64_u0[0 : 63];
    reg  signed [IN_WIDTH     : 0] tr_in_32_u0[0 : 31];
    reg  signed [IN_WIDTH + 1 : 0] tr_in_16_u0[0 : 15];
    reg  signed [IN_WIDTH + 2 : 0] tr_in_8_u0[0 : 7], tr_in_8_u1[0 : 7];
    reg  signed [IN_WIDTH + 3 : 0] tr_in_4_u0[0 : 3], tr_in_4_u1[0 : 3], tr_in_4_u2[0 : 3], tr_in_4_u3[0 : 3];
//calculate
    wire signed [IN_WIDTH     : 0] butterfly_64_u0[0 : 31];
    wire signed [IN_WIDTH + 1 : 0] butterfly_32_u0[0 : 15];
    wire signed [IN_WIDTH + 2 : 0] butterfly_16_u0[0 : 7];
    wire signed [IN_WIDTH + 3 : 0] butterfly_8_u0[0 : 3], butterfly_8_u1[0 : 3];
    wire pre_coeff_64_valid, pre_coeff_32_valid, pre_coeff_16_valid, pre_coeff_8_valid, pre_coeff_4_valid;
    wire signed [IN_WIDTH + 11 : 0] pre_coeff_64_u0[0 : 15];
    wire signed [IN_WIDTH + 11 : 0] pre_coeff_32_u0[0 : 15];
    wire signed [IN_WIDTH + 11 : 0] pre_coeff_16_u0[0 : 7];
    wire signed [IN_WIDTH + 11 : 0] pre_coeff_8_u0[0 : 3], pre_coeff_8_u1[0 : 3];
    wire signed [IN_WIDTH + 11 : 0] pre_coeff_4_u0[0 : 3], pre_coeff_4_u1[0 : 3], pre_coeff_4_u2[0 : 3], pre_coeff_4_u3[0 : 3];
//size mux out
    reg pre_coeff_valid;
    reg signed [IN_WIDTH + 11 : 0] pre_coeff[0 : 31];

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

//input delay
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

//size mux in
always @(negedge clk or negedge rst_n) begin
    if (!rst_n) begin
        tr_in_64_valid <= 0;
        tr_in_32_valid <= 0;
        tr_in_16_valid <= 0;
        tr_in_8_valid  <= 0;
        tr_in_4_valid  <= 0;
        for (i = 0; i < 64; i = i + 1) begin
            tr_in_64_u0[i] <= 0;
        end
        for (i = 0; i < 32; i = i + 1) begin
            tr_in_32_u0[i] <= 0;
        end
        for (i = 0; i < 16; i = i + 1) begin
            tr_in_16_u0[i] <= 0;
        end
        for (i = 0; i < 8; i = i + 1) begin
            tr_in_8_u0[i] <= 0; tr_in_8_u1[i] <= 0;
        end
        for (i = 0; i < 4; i = i + 1) begin
            tr_in_4_u0[i] <= 0; tr_in_4_u1[i] <= 0; tr_in_4_u2[i] <= 0; tr_in_4_u3[i] <= 0;
        end
    end
    else begin
        //delay 0 clk
        case (i_height) 
            SIZE64 : begin
                tr_in_64_valid <= i_valid;
                for (i = 0; i < 64; i = i + 1) begin
                    tr_in_64_u0[i] <= i_data[i];
                end
            end
        endcase
        //delay 1 clk
        case (i_height_d[0]) 
            SIZE64 : begin
                for (i = 0; i < 32; i = i + 1) begin
                    tr_in_32_u0[i] <= butterfly_64_u0[i];
                end
            end
            SIZE32 : begin
                tr_in_32_valid <= i_valid_d1;
                for (i = 0; i < 32; i = i + 1) begin
                    tr_in_32_u0[i] <= i_data_d1[i];
                end
            end
        endcase
        //delay 2 clk
        case (i_height_d[1]) 
            SIZE64 : begin
                for (i = 0; i < 16; i = i + 1) begin
                    tr_in_16_u0[i] <= butterfly_32_u0[i];
                end
            end
            SIZE32 : begin
                for (i = 0; i < 16; i = i + 1) begin
                    tr_in_16_u0[i] <= butterfly_32_u0[i];
                end
            end
            SIZE16 : begin
                tr_in_16_valid <= i_valid_d2;
                for (i = 0; i < 16; i = i + 1) begin
                    tr_in_16_u0[i] <= i_data_d2[i];
                end
            end
        endcase
        //delay 3 clk
        case (i_height_d[2]) 
            SIZE64 : begin
                for (i = 0; i < 8; i = i + 1) begin
                    tr_in_8_u0[i] <= butterfly_16_u0[i];
                end
            end
            SIZE32 : begin
                for (i = 0; i < 8; i = i + 1) begin
                    tr_in_8_u0[i] <= butterfly_16_u0[i];
                end
            end
            SIZE16 : begin
                for (i = 0; i < 8; i = i + 1) begin
                    tr_in_8_u0[i] <= butterfly_16_u0[i];
                end
            end
            SIZE8 : begin
                tr_in_8_valid <= i_valid_d3;
                for (i = 0; i < 8; i = i + 1) begin
                    tr_in_8_u0[i] <= i_data_d3[i];
                    tr_in_8_u1[i] <= i_data_d3[i + 8];
                end
            end
        endcase
        //delay 4 clk
        case (i_height_d[3]) 
            SIZE64 : begin
                for (i = 0; i < 4; i = i + 1) begin
                    tr_in_4_u0[i] <= butterfly_8_u0[i];
                end
            end
            SIZE32 : begin
                for (i = 0; i < 4; i = i + 1) begin
                    tr_in_4_u0[i] <= butterfly_8_u0[i];
                end
            end
            SIZE16 : begin
                for (i = 0; i < 4; i = i + 1) begin
                    tr_in_4_u0[i] <= butterfly_8_u0[i];
                end
            end
            SIZE8 : begin
                for (i = 0; i < 4; i = i + 1) begin
                    tr_in_4_u0[i] <= butterfly_8_u0[i];
                    tr_in_4_u1[i] <= butterfly_8_u1[i];
                end
            end
            SIZE4 : begin
                tr_in_4_valid <= i_valid_d4;
                for (i = 0; i < 4; i = i + 1) begin
                    tr_in_4_u0[i] <= i_data_d4[i];
                    tr_in_4_u1[i] <= i_data_d4[i + 4];
                    tr_in_4_u2[i] <= i_data_d4[i + 8];
                    tr_in_4_u3[i] <= i_data_d4[i + 12];
                end
            end
        endcase
    end
end

//size mux out
always @(*) begin
    pre_coeff_valid <= 0;
    for (i = 0; i < 32; i = i + 1) begin
        pre_coeff[i] <= 0;
    end
    case (i_height_d[5])
        SIZE64  : begin //high frequency coefficients are set to zero
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
        SIZE32  : begin
            pre_coeff_valid <= pre_coeff_32_valid;
            for (i = 0; i < 16; i = i + 1) begin
                pre_coeff[1 + 2 * i] <= pre_coeff_32_u0[i];
            end
            for (i = 0; i < 8; i = i + 1) begin
                pre_coeff[2 + 4 * i] <= pre_coeff_16_u0[i];
            end
            for (i = 0; i < 4; i = i + 1) begin
                pre_coeff[4 + 8 * i] <= pre_coeff_8_u0[i];
            end
            for (i = 0; i < 4; i = i + 1) begin
                pre_coeff[0 + 8 * i] <= pre_coeff_4_u0[i];
            end
        end
        SIZE16  : begin
            pre_coeff_valid <= pre_coeff_16_valid;
            for (i = 0; i < 8; i = i + 1) begin
                pre_coeff[1 + 2 * i] <= pre_coeff_16_u0[i];
            end
            for (i = 0; i < 4; i = i + 1) begin
                pre_coeff[2 + 4 * i] <= pre_coeff_8_u0[i];
            end
            for (i = 0; i < 4; i = i + 1) begin
                pre_coeff[0 + 4 * i] <= pre_coeff_4_u0[i];
            end
        end
        SIZE8   : begin
            pre_coeff_valid <= pre_coeff_8_valid;
            for (i = 0; i < 4; i = i + 1) begin
                pre_coeff[1 + 2 * i] <= pre_coeff_8_u0[i];
                pre_coeff[9 + 2 * i] <= pre_coeff_8_u1[i];
            end
            for (i = 0; i < 4; i = i + 1) begin
                pre_coeff[0 + 2 * i] <= pre_coeff_4_u0[i];
                pre_coeff[8 + 2 * i] <= pre_coeff_4_u1[i];
            end
        end
        SIZE4   : begin
            pre_coeff_valid <= pre_coeff_4_valid;
            for (i = 0; i < 4; i = i + 1) begin
                pre_coeff[0 + i] <= pre_coeff_4_u0[i];
                pre_coeff[4 + i] <= pre_coeff_4_u1[i];
                pre_coeff[8 + i] <= pre_coeff_4_u2[i];
                pre_coeff[12 + i] <= pre_coeff_4_u3[i];
            end
        end
    endcase
end

//sub module
//64 x 64
dct2_1d_64#(
    .IN_WIDTH   (IN_WIDTH)
)
u0_dct2_1d_64(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input data
    .i_valid(tr_in_64_valid     ),
    .i_0    (tr_in_64_u0[0 ]    ),
    .i_1    (tr_in_64_u0[1 ]    ),
    .i_2    (tr_in_64_u0[2 ]    ),
    .i_3    (tr_in_64_u0[3 ]    ),
    .i_4    (tr_in_64_u0[4 ]    ),
    .i_5    (tr_in_64_u0[5 ]    ),
    .i_6    (tr_in_64_u0[6 ]    ),
    .i_7    (tr_in_64_u0[7 ]    ),
    .i_8    (tr_in_64_u0[8 ]    ),
    .i_9    (tr_in_64_u0[9 ]    ),
    .i_10   (tr_in_64_u0[10]    ),
    .i_11   (tr_in_64_u0[11]    ),
    .i_12   (tr_in_64_u0[12]    ),
    .i_13   (tr_in_64_u0[13]    ),
    .i_14   (tr_in_64_u0[14]    ),
    .i_15   (tr_in_64_u0[15]    ),
    .i_16   (tr_in_64_u0[16]    ),
    .i_17   (tr_in_64_u0[17]    ),
    .i_18   (tr_in_64_u0[18]    ),
    .i_19   (tr_in_64_u0[19]    ),
    .i_20   (tr_in_64_u0[20]    ),
    .i_21   (tr_in_64_u0[21]    ),
    .i_22   (tr_in_64_u0[22]    ),
    .i_23   (tr_in_64_u0[23]    ),
    .i_24   (tr_in_64_u0[24]    ),
    .i_25   (tr_in_64_u0[25]    ),
    .i_26   (tr_in_64_u0[26]    ),
    .i_27   (tr_in_64_u0[27]    ),
    .i_28   (tr_in_64_u0[28]    ),
    .i_29   (tr_in_64_u0[29]    ),
    .i_30   (tr_in_64_u0[30]    ),
    .i_31   (tr_in_64_u0[31]    ),
    .i_32   (tr_in_64_u0[32]    ),
    .i_33   (tr_in_64_u0[33]    ),
    .i_34   (tr_in_64_u0[34]    ),
    .i_35   (tr_in_64_u0[35]    ),
    .i_36   (tr_in_64_u0[36]    ),
    .i_37   (tr_in_64_u0[37]    ),
    .i_38   (tr_in_64_u0[38]    ),
    .i_39   (tr_in_64_u0[39]    ),
    .i_40   (tr_in_64_u0[40]    ),
    .i_41   (tr_in_64_u0[41]    ),
    .i_42   (tr_in_64_u0[42]    ),
    .i_43   (tr_in_64_u0[43]    ),
    .i_44   (tr_in_64_u0[44]    ),
    .i_45   (tr_in_64_u0[45]    ),
    .i_46   (tr_in_64_u0[46]    ),
    .i_47   (tr_in_64_u0[47]    ),
    .i_48   (tr_in_64_u0[48]    ),
    .i_49   (tr_in_64_u0[49]    ),
    .i_50   (tr_in_64_u0[50]    ),
    .i_51   (tr_in_64_u0[51]    ),
    .i_52   (tr_in_64_u0[52]    ),
    .i_53   (tr_in_64_u0[53]    ),
    .i_54   (tr_in_64_u0[54]    ),
    .i_55   (tr_in_64_u0[55]    ),
    .i_56   (tr_in_64_u0[56]    ),
    .i_57   (tr_in_64_u0[57]    ),
    .i_58   (tr_in_64_u0[58]    ),
    .i_59   (tr_in_64_u0[59]    ),
    .i_60   (tr_in_64_u0[60]    ),
    .i_61   (tr_in_64_u0[61]    ),
    .i_62   (tr_in_64_u0[62]    ),
    .i_63   (tr_in_64_u0[63]    ),
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
    .o_47   (pre_coeff_64_u0[15])
);

//32x32
dct2_1d_32#(
    .IN_WIDTH   (IN_WIDTH + 1)
)
u0_dct2_1d_32(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_height_d[4]      ),
//input data
    .i_valid(tr_in_32_valid     ),
    .i_0    (tr_in_32_u0[0 ]    ),
    .i_1    (tr_in_32_u0[1 ]    ),
    .i_2    (tr_in_32_u0[2 ]    ),
    .i_3    (tr_in_32_u0[3 ]    ),
    .i_4    (tr_in_32_u0[4 ]    ),
    .i_5    (tr_in_32_u0[5 ]    ),
    .i_6    (tr_in_32_u0[6 ]    ),
    .i_7    (tr_in_32_u0[7 ]    ),
    .i_8    (tr_in_32_u0[8 ]    ),
    .i_9    (tr_in_32_u0[9 ]    ),
    .i_10   (tr_in_32_u0[10]    ),
    .i_11   (tr_in_32_u0[11]    ),
    .i_12   (tr_in_32_u0[12]    ),
    .i_13   (tr_in_32_u0[13]    ),
    .i_14   (tr_in_32_u0[14]    ),
    .i_15   (tr_in_32_u0[15]    ),
    .i_16   (tr_in_32_u0[16]    ),
    .i_17   (tr_in_32_u0[17]    ),
    .i_18   (tr_in_32_u0[18]    ),
    .i_19   (tr_in_32_u0[19]    ),
    .i_20   (tr_in_32_u0[20]    ),
    .i_21   (tr_in_32_u0[21]    ),
    .i_22   (tr_in_32_u0[22]    ),
    .i_23   (tr_in_32_u0[23]    ),
    .i_24   (tr_in_32_u0[24]    ),
    .i_25   (tr_in_32_u0[25]    ),
    .i_26   (tr_in_32_u0[26]    ),
    .i_27   (tr_in_32_u0[27]    ),
    .i_28   (tr_in_32_u0[28]    ),
    .i_29   (tr_in_32_u0[29]    ),
    .i_30   (tr_in_32_u0[30]    ),
    .i_31   (tr_in_32_u0[31]    ),
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

//16x16
dct2_1d_16#(
    .IN_WIDTH   (IN_WIDTH + 2)
)
u0_dct2_1d_16(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_height_d[4]      ),
//input data
    .i_valid(tr_in_16_valid     ),
    .i_0    (tr_in_16_u0[0 ]    ),
    .i_1    (tr_in_16_u0[1 ]    ),
    .i_2    (tr_in_16_u0[2 ]    ),
    .i_3    (tr_in_16_u0[3 ]    ),
    .i_4    (tr_in_16_u0[4 ]    ),
    .i_5    (tr_in_16_u0[5 ]    ),
    .i_6    (tr_in_16_u0[6 ]    ),
    .i_7    (tr_in_16_u0[7 ]    ),
    .i_8    (tr_in_16_u0[8 ]    ),
    .i_9    (tr_in_16_u0[9 ]    ),
    .i_10   (tr_in_16_u0[10]    ),
    .i_11   (tr_in_16_u0[11]    ),
    .i_12   (tr_in_16_u0[12]    ),
    .i_13   (tr_in_16_u0[13]    ),
    .i_14   (tr_in_16_u0[14]    ),
    .i_15   (tr_in_16_u0[15]    ),
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

//8x8
dct2_1d_8#(
    .IN_WIDTH   (IN_WIDTH + 3)
)
u0_dct2_1d_8(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_height_d[4]      ),
//input data
    .i_valid(tr_in_8_valid      ),
    .i_0    (tr_in_8_u0[0 ]     ),
    .i_1    (tr_in_8_u0[1 ]     ),
    .i_2    (tr_in_8_u0[2 ]     ),
    .i_3    (tr_in_8_u0[3 ]     ),
    .i_4    (tr_in_8_u0[4 ]     ),
    .i_5    (tr_in_8_u0[5 ]     ),
    .i_6    (tr_in_8_u0[6 ]     ),
    .i_7    (tr_in_8_u0[7 ]     ),
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
dct2_1d_8#(
    .IN_WIDTH   (IN_WIDTH + 3)
)
u1_dct2_1d_8(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_height_d[4]      ),
//input data
    .i_valid(tr_in_8_valid      ),
    .i_0    (tr_in_8_u1[0 ]     ),
    .i_1    (tr_in_8_u1[1 ]     ),
    .i_2    (tr_in_8_u1[2 ]     ),
    .i_3    (tr_in_8_u1[3 ]     ),
    .i_4    (tr_in_8_u1[4 ]     ),
    .i_5    (tr_in_8_u1[5 ]     ),
    .i_6    (tr_in_8_u1[6 ]     ),
    .i_7    (tr_in_8_u1[7 ]     ),
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

//4x4
dct2_1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u0_dct2_1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_height_d[4]      ),
//input data
    .i_valid(tr_in_4_valid      ),
    .i_0    (tr_in_4_u0[0 ]     ),
    .i_1    (tr_in_4_u0[1 ]     ),
    .i_2    (tr_in_4_u0[2 ]     ),
    .i_3    (tr_in_4_u0[3 ]     ),
//output data
    .o_valid(pre_coeff_4_valid  ),
    .o_0    (pre_coeff_4_u0[0 ] ),
    .o_1    (pre_coeff_4_u0[1 ] ),
    .o_2    (pre_coeff_4_u0[2 ] ),
    .o_3    (pre_coeff_4_u0[3 ] )
);
dct2_1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u1_dct2_1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_height_d[4]      ),
//input data
    .i_valid(tr_in_4_valid      ),
    .i_0    (tr_in_4_u1[0 ]     ),
    .i_1    (tr_in_4_u1[1 ]     ),
    .i_2    (tr_in_4_u1[2 ]     ),
    .i_3    (tr_in_4_u1[3 ]     ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u1[0 ] ),
    .o_1    (pre_coeff_4_u1[1 ] ),
    .o_2    (pre_coeff_4_u1[2 ] ),
    .o_3    (pre_coeff_4_u1[3 ] )
);
dct2_1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u2_dct2_1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_height_d[4]      ),
//input data
    .i_valid(tr_in_4_valid      ),
    .i_0    (tr_in_4_u2[0 ]     ),
    .i_1    (tr_in_4_u2[1 ]     ),
    .i_2    (tr_in_4_u2[2 ]     ),
    .i_3    (tr_in_4_u2[3 ]     ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u2[0 ] ),
    .o_1    (pre_coeff_4_u2[1 ] ),
    .o_2    (pre_coeff_4_u2[2 ] ),
    .o_3    (pre_coeff_4_u2[3 ] )
);
dct2_1d_4#(
    .IN_WIDTH   (IN_WIDTH + 4)
)
u3_dct2_1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input parameter
    .i_size (i_height_d[4]      ),
//input data
    .i_valid(tr_in_4_valid      ),
    .i_0    (tr_in_4_u3[0 ]     ),
    .i_1    (tr_in_4_u3[1 ]     ),
    .i_2    (tr_in_4_u3[2 ]     ),
    .i_3    (tr_in_4_u3[3 ]     ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u3[0 ] ),
    .o_1    (pre_coeff_4_u3[1 ] ),
    .o_2    (pre_coeff_4_u3[2 ] ),
    .o_3    (pre_coeff_4_u3[3 ] )
);

//output
    assign o_width  = i_width_d[5]  ;
    assign o_height = i_height_d[5] ;
    assign o_valid  = pre_coeff_valid;
    assign o_0      = pre_coeff[0 ]  ;
    assign o_1      = pre_coeff[1 ]  ;
    assign o_2      = pre_coeff[2 ]  ;
    assign o_3      = pre_coeff[3 ]  ;
    assign o_4      = pre_coeff[4 ]  ;
    assign o_5      = pre_coeff[5 ]  ;
    assign o_6      = pre_coeff[6 ]  ;
    assign o_7      = pre_coeff[7 ]  ;
    assign o_8      = pre_coeff[8 ]  ;
    assign o_9      = pre_coeff[9 ]  ;
    assign o_10     = pre_coeff[10]  ;
    assign o_11     = pre_coeff[11]  ;
    assign o_12     = pre_coeff[12]  ;
    assign o_13     = pre_coeff[13]  ;
    assign o_14     = pre_coeff[14]  ;
    assign o_15     = pre_coeff[15]  ;
    assign o_16     = pre_coeff[16]  ;
    assign o_17     = pre_coeff[17]  ;
    assign o_18     = pre_coeff[18]  ;
    assign o_19     = pre_coeff[19]  ;
    assign o_20     = pre_coeff[20]  ;
    assign o_21     = pre_coeff[21]  ;
    assign o_22     = pre_coeff[22]  ;
    assign o_23     = pre_coeff[23]  ;
    assign o_24     = pre_coeff[24]  ;
    assign o_25     = pre_coeff[25]  ;
    assign o_26     = pre_coeff[26]  ;
    assign o_27     = pre_coeff[27]  ;
    assign o_28     = pre_coeff[28]  ;
    assign o_29     = pre_coeff[29]  ;
    assign o_30     = pre_coeff[30]  ;
    assign o_31     = pre_coeff[31]  ;

endmodule
