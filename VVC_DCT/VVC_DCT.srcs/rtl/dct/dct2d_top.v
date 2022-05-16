//describe  : 二维DCT2，高频系数置零
//input     : 64个像素残差数据
//output    : 64个系数数据
//delay     : Max : [height+15] clk = 1in + 6dct + 1wr + [height-1]other + 1rd + 1in + 6dct
//            Min : [height+7] clk = 1in + 2dct + 1wr + [height-1]other + 1rd + 1in + 2dct
//            1D-DCT : 64x64:6clk, 32x32:5clk, 16x16:4clk, 8x8:3clk 4x4:2clk
//            64x64 : 79 clk后流水输出
//a matrix process time : Max : [height+width+14] clk = 1in + 5dct + 1wr + (height-1)other + 1rd + 1in + 5dct + (width-1)other
//                        Min : [height+width+6] clk = 1in + 2dct + 1wr + (height-1)other + 1rd + 1in + 2dct + (width-1)other
//                        64x64 : 142-32=110 clk (Nx64 =>reduce 32 clk)
module dct2d_top#(
    parameter  BIT_DEPTH = 8,
    parameter  OUT_WIDTH = 16
)
(
//system input
    input                               clk         ,
    input                               rst_n       ,
//input parameter
    input           [2 : 0]             i_width     ,//1st 0:DCT_4, 1:DCT_8, 2:DCT_16, 3:DCT_32, 4:DCT_64
    input           [2 : 0]             i_height    ,//2nd
//input data
    input                               i_valid     ,
    input   signed  [BIT_DEPTH : 0]     i_0         ,
    input   signed  [BIT_DEPTH : 0]     i_1         ,
    input   signed  [BIT_DEPTH : 0]     i_2         ,
    input   signed  [BIT_DEPTH : 0]     i_3         ,
    input   signed  [BIT_DEPTH : 0]     i_4         ,
    input   signed  [BIT_DEPTH : 0]     i_5         ,
    input   signed  [BIT_DEPTH : 0]     i_6         ,
    input   signed  [BIT_DEPTH : 0]     i_7         ,
    input   signed  [BIT_DEPTH : 0]     i_8         ,
    input   signed  [BIT_DEPTH : 0]     i_9         ,
    input   signed  [BIT_DEPTH : 0]     i_10        ,
    input   signed  [BIT_DEPTH : 0]     i_11        ,
    input   signed  [BIT_DEPTH : 0]     i_12        ,
    input   signed  [BIT_DEPTH : 0]     i_13        ,
    input   signed  [BIT_DEPTH : 0]     i_14        ,
    input   signed  [BIT_DEPTH : 0]     i_15        ,
    input   signed  [BIT_DEPTH : 0]     i_16        ,
    input   signed  [BIT_DEPTH : 0]     i_17        ,
    input   signed  [BIT_DEPTH : 0]     i_18        ,
    input   signed  [BIT_DEPTH : 0]     i_19        ,
    input   signed  [BIT_DEPTH : 0]     i_20        ,
    input   signed  [BIT_DEPTH : 0]     i_21        ,
    input   signed  [BIT_DEPTH : 0]     i_22        ,
    input   signed  [BIT_DEPTH : 0]     i_23        ,
    input   signed  [BIT_DEPTH : 0]     i_24        ,
    input   signed  [BIT_DEPTH : 0]     i_25        ,
    input   signed  [BIT_DEPTH : 0]     i_26        ,
    input   signed  [BIT_DEPTH : 0]     i_27        ,
    input   signed  [BIT_DEPTH : 0]     i_28        ,
    input   signed  [BIT_DEPTH : 0]     i_29        ,
    input   signed  [BIT_DEPTH : 0]     i_30        ,
    input   signed  [BIT_DEPTH : 0]     i_31        ,
    input   signed  [BIT_DEPTH : 0]     i_32        ,
    input   signed  [BIT_DEPTH : 0]     i_33        ,
    input   signed  [BIT_DEPTH : 0]     i_34        ,
    input   signed  [BIT_DEPTH : 0]     i_35        ,
    input   signed  [BIT_DEPTH : 0]     i_36        ,
    input   signed  [BIT_DEPTH : 0]     i_37        ,
    input   signed  [BIT_DEPTH : 0]     i_38        ,
    input   signed  [BIT_DEPTH : 0]     i_39        ,
    input   signed  [BIT_DEPTH : 0]     i_40        ,
    input   signed  [BIT_DEPTH : 0]     i_41        ,
    input   signed  [BIT_DEPTH : 0]     i_42        ,
    input   signed  [BIT_DEPTH : 0]     i_43        ,
    input   signed  [BIT_DEPTH : 0]     i_44        ,
    input   signed  [BIT_DEPTH : 0]     i_45        ,
    input   signed  [BIT_DEPTH : 0]     i_46        ,
    input   signed  [BIT_DEPTH : 0]     i_47        ,
    input   signed  [BIT_DEPTH : 0]     i_48        ,
    input   signed  [BIT_DEPTH : 0]     i_49        ,
    input   signed  [BIT_DEPTH : 0]     i_50        ,
    input   signed  [BIT_DEPTH : 0]     i_51        ,
    input   signed  [BIT_DEPTH : 0]     i_52        ,
    input   signed  [BIT_DEPTH : 0]     i_53        ,
    input   signed  [BIT_DEPTH : 0]     i_54        ,
    input   signed  [BIT_DEPTH : 0]     i_55        ,
    input   signed  [BIT_DEPTH : 0]     i_56        ,
    input   signed  [BIT_DEPTH : 0]     i_57        ,
    input   signed  [BIT_DEPTH : 0]     i_58        ,
    input   signed  [BIT_DEPTH : 0]     i_59        ,
    input   signed  [BIT_DEPTH : 0]     i_60        ,
    input   signed  [BIT_DEPTH : 0]     i_61        ,
    input   signed  [BIT_DEPTH : 0]     i_62        ,
    input   signed  [BIT_DEPTH : 0]     i_63        ,
//output coeff
    output                              o_valid     ,
    output  signed  [OUT_WIDTH - 1 : 0] o_0         ,
    output  signed  [OUT_WIDTH - 1 : 0] o_1         ,
    output  signed  [OUT_WIDTH - 1 : 0] o_2         ,
    output  signed  [OUT_WIDTH - 1 : 0] o_3         ,
    output  signed  [OUT_WIDTH - 1 : 0] o_4         ,
    output  signed  [OUT_WIDTH - 1 : 0] o_5         ,
    output  signed  [OUT_WIDTH - 1 : 0] o_6         ,
    output  signed  [OUT_WIDTH - 1 : 0] o_7         ,
    output  signed  [OUT_WIDTH - 1 : 0] o_8         ,
    output  signed  [OUT_WIDTH - 1 : 0] o_9         ,
    output  signed  [OUT_WIDTH - 1 : 0] o_10        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_11        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_12        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_13        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_14        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_15        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_16        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_17        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_18        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_19        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_20        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_21        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_22        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_23        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_24        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_25        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_26        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_27        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_28        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_29        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_30        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_31        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_32        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_33        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_34        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_35        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_36        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_37        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_38        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_39        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_40        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_41        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_42        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_43        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_44        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_45        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_46        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_47        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_48        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_49        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_50        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_51        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_52        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_53        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_54        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_55        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_56        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_57        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_58        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_59        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_60        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_61        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_62        ,
    output  signed  [OUT_WIDTH - 1 : 0] o_63    
);

localparam  DCT_1st = 0,
            DCT_2nd = 1;

localparam  DCT_4  = 0,
            DCT_8  = 1,
            DCT_16 = 2,
            DCT_32 = 3,
            DCT_64 = 4;
integer i;

//DCT
    reg dct_stage;
    reg [2 : 0] dct_size;
    reg dct_in_valid;
    reg signed [OUT_WIDTH - 1 : 0] dct_in[63 : 0];
    wire dct_out_valid;
    wire signed [OUT_WIDTH - 1 : 0] dct_out[63 : 0];
    wire dct2d_out_valid;
    reg signed [OUT_WIDTH - 1 : 0] dct2d_out[63 : 0];
//shift
    reg [3 : 0] shift_1st, shift_2nd, dct_shift;
//transpose memory
    wire transpose_in_valid, transpose_out_valid;
    reg signed [OUT_WIDTH - 1 : 0] transpose_in[63 : 0];
    wire signed [OUT_WIDTH - 1 : 0] transpose_out[63 : 0];

assign transpose_in_valid = dct_stage ? 0 : dct_out_valid;
assign dct2d_out_valid = dct_stage ? dct_out_valid : 0;

//shift
always @(*) begin
    case (i_width)//first stage : log2(Width) + BitDepth - 9
        DCT_4   : shift_1st <= BIT_DEPTH - 7;
        DCT_8   : shift_1st <= BIT_DEPTH - 6;
        DCT_16  : shift_1st <= BIT_DEPTH - 5;
        DCT_32  : shift_1st <= BIT_DEPTH - 4;
        DCT_64  : shift_1st <= BIT_DEPTH - 3;
        default : shift_1st <= 0;
    endcase
    case (i_height)//second stage : log2(Height) + 6
        DCT_4   : shift_2nd <= 8;
        DCT_8   : shift_2nd <= 9;
        DCT_16  : shift_2nd <= 10;
        DCT_32  : shift_2nd <= 11;
        DCT_64  : shift_2nd <= 12;
        default : shift_2nd <= 0;
    endcase
end

//dct data in(1 clk)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        dct_stage <= 0;
        dct_size <= 0;
        dct_shift <= 0;
        dct_in_valid <= 0;
        for (i = 0; i < 64; i = i + 1) begin
            dct_in[i] <= 0;
        end
    end
    else if (i_valid) begin//1st stage
        dct_stage <= 0;
        dct_size <= i_width;
        dct_shift <= shift_1st;
        dct_in_valid <= i_valid;
        dct_in[0 ] <= i_0 ;
        dct_in[1 ] <= i_1 ;
        dct_in[2 ] <= i_2 ;
        dct_in[3 ] <= i_3 ;
        dct_in[4 ] <= i_4 ;
        dct_in[5 ] <= i_5 ;
        dct_in[6 ] <= i_6 ;
        dct_in[7 ] <= i_7 ;
        dct_in[8 ] <= i_8 ;
        dct_in[9 ] <= i_9 ;
        dct_in[10] <= i_10;
        dct_in[11] <= i_11;
        dct_in[12] <= i_12;
        dct_in[13] <= i_13;
        dct_in[14] <= i_14;
        dct_in[15] <= i_15;
        dct_in[16] <= i_16;
        dct_in[17] <= i_17;
        dct_in[18] <= i_18;
        dct_in[19] <= i_19;
        dct_in[20] <= i_20;
        dct_in[21] <= i_21;
        dct_in[22] <= i_22;
        dct_in[23] <= i_23;
        dct_in[24] <= i_24;
        dct_in[25] <= i_25;
        dct_in[26] <= i_26;
        dct_in[27] <= i_27;
        dct_in[28] <= i_28;
        dct_in[29] <= i_29;
        dct_in[30] <= i_30;
        dct_in[31] <= i_31;
        dct_in[32] <= i_32;
        dct_in[33] <= i_33;
        dct_in[34] <= i_34;
        dct_in[35] <= i_35;
        dct_in[36] <= i_36;
        dct_in[37] <= i_37;
        dct_in[38] <= i_38;
        dct_in[39] <= i_39;
        dct_in[40] <= i_40;
        dct_in[41] <= i_41;
        dct_in[42] <= i_42;
        dct_in[43] <= i_43;
        dct_in[44] <= i_44;
        dct_in[45] <= i_45;
        dct_in[46] <= i_46;
        dct_in[47] <= i_47;
        dct_in[48] <= i_48;
        dct_in[49] <= i_49;
        dct_in[50] <= i_50;
        dct_in[51] <= i_51;
        dct_in[52] <= i_52;
        dct_in[53] <= i_53;
        dct_in[54] <= i_54;
        dct_in[55] <= i_55;
        dct_in[56] <= i_56;
        dct_in[57] <= i_57;
        dct_in[58] <= i_58;
        dct_in[59] <= i_59;
        dct_in[60] <= i_60;
        dct_in[61] <= i_61;
        dct_in[62] <= i_62;
        dct_in[63] <= i_63;
    end
    else if (transpose_out_valid) begin//2nd stage
        dct_stage <= 1;
        dct_size <= i_height;
        dct_shift <= shift_2nd;
        dct_in_valid <= transpose_out_valid;
        for (i = 0; i < 64; i = i + 1) begin
            dct_in[i] <= transpose_out[i];
        end
    end
    else begin
        dct_stage <= dct_stage;
        dct_size <= dct_size;
        dct_shift <= dct_shift;
        dct_in_valid <= 0;
        for (i = 0; i < 64; i = i + 1) begin
            dct_in[i] <= 0;
        end
    end
end

//transpose data in
always @(*) begin
    if (transpose_in_valid) begin
        for (i = 0; i < 64; i = i + 1) begin
            transpose_in[i] <= dct_out[i];
        end
    end
    else begin
        for (i = 0; i < 64; i = i + 1) begin
            transpose_in[i] <= 0;
        end
    end
end

//dct data out
always @(*) begin
    if (dct_stage) begin
        for (i = 0; i < 64; i = i + 1) begin
            dct2d_out[i] <= dct_out[i];
        end
    end
    else begin
        for (i = 0; i < 64; i = i + 1) begin
            dct2d_out[i] <= 0;
        end
    end
end

//sub module
//1D-DCT
dct1d#(
    .IN_WIDTH   (OUT_WIDTH),
    .OUT_WIDTH  (OUT_WIDTH)
)
u_dct1d(
//system input
    .clk     (clk           ),
    .rst_n   (rst_n         ),
//input parameter
    .i_size  (dct_size      ),
    .i_shift (dct_shift     ),
//input data
    .i_valid (dct_in_valid  ),
    .i_0     (dct_in[0 ]    ),
    .i_1     (dct_in[1 ]    ),
    .i_2     (dct_in[2 ]    ),
    .i_3     (dct_in[3 ]    ),
    .i_4     (dct_in[4 ]    ),
    .i_5     (dct_in[5 ]    ),
    .i_6     (dct_in[6 ]    ),
    .i_7     (dct_in[7 ]    ),
    .i_8     (dct_in[8 ]    ),
    .i_9     (dct_in[9 ]    ),
    .i_10    (dct_in[10]    ),
    .i_11    (dct_in[11]    ),
    .i_12    (dct_in[12]    ),
    .i_13    (dct_in[13]    ),
    .i_14    (dct_in[14]    ),
    .i_15    (dct_in[15]    ),
    .i_16    (dct_in[16]    ),
    .i_17    (dct_in[17]    ),
    .i_18    (dct_in[18]    ),
    .i_19    (dct_in[19]    ),
    .i_20    (dct_in[20]    ),
    .i_21    (dct_in[21]    ),
    .i_22    (dct_in[22]    ),
    .i_23    (dct_in[23]    ),
    .i_24    (dct_in[24]    ),
    .i_25    (dct_in[25]    ),
    .i_26    (dct_in[26]    ),
    .i_27    (dct_in[27]    ),
    .i_28    (dct_in[28]    ),
    .i_29    (dct_in[29]    ),
    .i_30    (dct_in[30]    ),
    .i_31    (dct_in[31]    ),
    .i_32    (dct_in[32]    ),
    .i_33    (dct_in[33]    ),
    .i_34    (dct_in[34]    ),
    .i_35    (dct_in[35]    ),
    .i_36    (dct_in[36]    ),
    .i_37    (dct_in[37]    ),
    .i_38    (dct_in[38]    ),
    .i_39    (dct_in[39]    ),
    .i_40    (dct_in[40]    ),
    .i_41    (dct_in[41]    ),
    .i_42    (dct_in[42]    ),
    .i_43    (dct_in[43]    ),
    .i_44    (dct_in[44]    ),
    .i_45    (dct_in[45]    ),
    .i_46    (dct_in[46]    ),
    .i_47    (dct_in[47]    ),
    .i_48    (dct_in[48]    ),
    .i_49    (dct_in[49]    ),
    .i_50    (dct_in[50]    ),
    .i_51    (dct_in[51]    ),
    .i_52    (dct_in[52]    ),
    .i_53    (dct_in[53]    ),
    .i_54    (dct_in[54]    ),
    .i_55    (dct_in[55]    ),
    .i_56    (dct_in[56]    ),
    .i_57    (dct_in[57]    ),
    .i_58    (dct_in[58]    ),
    .i_59    (dct_in[59]    ),
    .i_60    (dct_in[60]    ),
    .i_61    (dct_in[61]    ),
    .i_62    (dct_in[62]    ),
    .i_63    (dct_in[63]    ),
//output coeff
    .o_valid (dct_out_valid ),
    .o_0     (dct_out[0 ]   ),
    .o_1     (dct_out[1 ]   ),
    .o_2     (dct_out[2 ]   ),
    .o_3     (dct_out[3 ]   ),
    .o_4     (dct_out[4 ]   ),
    .o_5     (dct_out[5 ]   ),
    .o_6     (dct_out[6 ]   ),
    .o_7     (dct_out[7 ]   ),
    .o_8     (dct_out[8 ]   ),
    .o_9     (dct_out[9 ]   ),
    .o_10    (dct_out[10]   ),
    .o_11    (dct_out[11]   ),
    .o_12    (dct_out[12]   ),
    .o_13    (dct_out[13]   ),
    .o_14    (dct_out[14]   ),
    .o_15    (dct_out[15]   ),
    .o_16    (dct_out[16]   ),
    .o_17    (dct_out[17]   ),
    .o_18    (dct_out[18]   ),
    .o_19    (dct_out[19]   ),
    .o_20    (dct_out[20]   ),
    .o_21    (dct_out[21]   ),
    .o_22    (dct_out[22]   ),
    .o_23    (dct_out[23]   ),
    .o_24    (dct_out[24]   ),
    .o_25    (dct_out[25]   ),
    .o_26    (dct_out[26]   ),
    .o_27    (dct_out[27]   ),
    .o_28    (dct_out[28]   ),
    .o_29    (dct_out[29]   ),
    .o_30    (dct_out[30]   ),
    .o_31    (dct_out[31]   ),
    .o_32    (dct_out[32]   ),
    .o_33    (dct_out[33]   ),
    .o_34    (dct_out[34]   ),
    .o_35    (dct_out[35]   ),
    .o_36    (dct_out[36]   ),
    .o_37    (dct_out[37]   ),
    .o_38    (dct_out[38]   ),
    .o_39    (dct_out[39]   ),
    .o_40    (dct_out[40]   ),
    .o_41    (dct_out[41]   ),
    .o_42    (dct_out[42]   ),
    .o_43    (dct_out[43]   ),
    .o_44    (dct_out[44]   ),
    .o_45    (dct_out[45]   ),
    .o_46    (dct_out[46]   ),
    .o_47    (dct_out[47]   ),
    .o_48    (dct_out[48]   ),
    .o_49    (dct_out[49]   ),
    .o_50    (dct_out[50]   ),
    .o_51    (dct_out[51]   ),
    .o_52    (dct_out[52]   ),
    .o_53    (dct_out[53]   ),
    .o_54    (dct_out[54]   ),
    .o_55    (dct_out[55]   ),
    .o_56    (dct_out[56]   ),
    .o_57    (dct_out[57]   ),
    .o_58    (dct_out[58]   ),
    .o_59    (dct_out[59]   ),
    .o_60    (dct_out[60]   ),
    .o_61    (dct_out[61]   ),
    .o_62    (dct_out[62]   ),
    .o_63    (dct_out[63]   )
);

//transpose memory
transpose_memory#(
    .WIDTH   (OUT_WIDTH )
)
u_transpose_memory(
//system input
    .clk     (clk                   ),
    .rst_n   (rst_n                 ),
//input parameter
    .i_width (i_width               ),
    .i_height(i_height              ),
//1st stage's coeff
    .i_valid (transpose_in_valid    ),
    .i_0     (dct_out[0 ]           ),
    .i_1     (dct_out[1 ]           ),
    .i_2     (dct_out[2 ]           ),
    .i_3     (dct_out[3 ]           ),
    .i_4     (dct_out[4 ]           ),
    .i_5     (dct_out[5 ]           ),
    .i_6     (dct_out[6 ]           ),
    .i_7     (dct_out[7 ]           ),
    .i_8     (dct_out[8 ]           ),
    .i_9     (dct_out[9 ]           ),
    .i_10    (dct_out[10]           ),
    .i_11    (dct_out[11]           ),
    .i_12    (dct_out[12]           ),
    .i_13    (dct_out[13]           ),
    .i_14    (dct_out[14]           ),
    .i_15    (dct_out[15]           ),
    .i_16    (dct_out[16]           ),
    .i_17    (dct_out[17]           ),
    .i_18    (dct_out[18]           ),
    .i_19    (dct_out[19]           ),
    .i_20    (dct_out[20]           ),
    .i_21    (dct_out[21]           ),
    .i_22    (dct_out[22]           ),
    .i_23    (dct_out[23]           ),
    .i_24    (dct_out[24]           ),
    .i_25    (dct_out[25]           ),
    .i_26    (dct_out[26]           ),
    .i_27    (dct_out[27]           ),
    .i_28    (dct_out[28]           ),
    .i_29    (dct_out[29]           ),
    .i_30    (dct_out[30]           ),
    .i_31    (dct_out[31]           ),
    .i_32    (dct_out[32]           ),
    .i_33    (dct_out[33]           ),
    .i_34    (dct_out[34]           ),
    .i_35    (dct_out[35]           ),
    .i_36    (dct_out[36]           ),
    .i_37    (dct_out[37]           ),
    .i_38    (dct_out[38]           ),
    .i_39    (dct_out[39]           ),
    .i_40    (dct_out[40]           ),
    .i_41    (dct_out[41]           ),
    .i_42    (dct_out[42]           ),
    .i_43    (dct_out[43]           ),
    .i_44    (dct_out[44]           ),
    .i_45    (dct_out[45]           ),
    .i_46    (dct_out[46]           ),
    .i_47    (dct_out[47]           ),
    .i_48    (dct_out[48]           ),
    .i_49    (dct_out[49]           ),
    .i_50    (dct_out[50]           ),
    .i_51    (dct_out[51]           ),
    .i_52    (dct_out[52]           ),
    .i_53    (dct_out[53]           ),
    .i_54    (dct_out[54]           ),
    .i_55    (dct_out[55]           ),
    .i_56    (dct_out[56]           ),
    .i_57    (dct_out[57]           ),
    .i_58    (dct_out[58]           ),
    .i_59    (dct_out[59]           ),
    .i_60    (dct_out[60]           ),
    .i_61    (dct_out[61]           ),
    .i_62    (dct_out[62]           ),
    .i_63    (dct_out[63]           ),
//transpose 1st stage's coeff
    .o_valid (transpose_out_valid   ),
    .o_0     (transpose_out[0 ]     ),
    .o_1     (transpose_out[1 ]     ),
    .o_2     (transpose_out[2 ]     ),
    .o_3     (transpose_out[3 ]     ),
    .o_4     (transpose_out[4 ]     ),
    .o_5     (transpose_out[5 ]     ),
    .o_6     (transpose_out[6 ]     ),
    .o_7     (transpose_out[7 ]     ),
    .o_8     (transpose_out[8 ]     ),
    .o_9     (transpose_out[9 ]     ),
    .o_10    (transpose_out[10]     ),
    .o_11    (transpose_out[11]     ),
    .o_12    (transpose_out[12]     ),
    .o_13    (transpose_out[13]     ),
    .o_14    (transpose_out[14]     ),
    .o_15    (transpose_out[15]     ),
    .o_16    (transpose_out[16]     ),
    .o_17    (transpose_out[17]     ),
    .o_18    (transpose_out[18]     ),
    .o_19    (transpose_out[19]     ),
    .o_20    (transpose_out[20]     ),
    .o_21    (transpose_out[21]     ),
    .o_22    (transpose_out[22]     ),
    .o_23    (transpose_out[23]     ),
    .o_24    (transpose_out[24]     ),
    .o_25    (transpose_out[25]     ),
    .o_26    (transpose_out[26]     ),
    .o_27    (transpose_out[27]     ),
    .o_28    (transpose_out[28]     ),
    .o_29    (transpose_out[29]     ),
    .o_30    (transpose_out[30]     ),
    .o_31    (transpose_out[31]     ),
    .o_32    (transpose_out[32]     ),
    .o_33    (transpose_out[33]     ),
    .o_34    (transpose_out[34]     ),
    .o_35    (transpose_out[35]     ),
    .o_36    (transpose_out[36]     ),
    .o_37    (transpose_out[37]     ),
    .o_38    (transpose_out[38]     ),
    .o_39    (transpose_out[39]     ),
    .o_40    (transpose_out[40]     ),
    .o_41    (transpose_out[41]     ),
    .o_42    (transpose_out[42]     ),
    .o_43    (transpose_out[43]     ),
    .o_44    (transpose_out[44]     ),
    .o_45    (transpose_out[45]     ),
    .o_46    (transpose_out[46]     ),
    .o_47    (transpose_out[47]     ),
    .o_48    (transpose_out[48]     ),
    .o_49    (transpose_out[49]     ),
    .o_50    (transpose_out[50]     ),
    .o_51    (transpose_out[51]     ),
    .o_52    (transpose_out[52]     ),
    .o_53    (transpose_out[53]     ),
    .o_54    (transpose_out[54]     ),
    .o_55    (transpose_out[55]     ),
    .o_56    (transpose_out[56]     ),
    .o_57    (transpose_out[57]     ),
    .o_58    (transpose_out[58]     ),
    .o_59    (transpose_out[59]     ),
    .o_60    (transpose_out[60]     ),
    .o_61    (transpose_out[61]     ),
    .o_62    (transpose_out[62]     ),
    .o_63    (transpose_out[63]     )
);

//output
    assign o_valid = dct2d_out_valid;
    assign o_0  = dct2d_out[0 ];
    assign o_1  = dct2d_out[1 ];
    assign o_2  = dct2d_out[2 ];
    assign o_3  = dct2d_out[3 ];
    assign o_4  = dct2d_out[4 ];
    assign o_5  = dct2d_out[5 ];
    assign o_6  = dct2d_out[6 ];
    assign o_7  = dct2d_out[7 ];
    assign o_8  = dct2d_out[8 ];
    assign o_9  = dct2d_out[9 ];
    assign o_10 = dct2d_out[10];
    assign o_11 = dct2d_out[11];
    assign o_12 = dct2d_out[12];
    assign o_13 = dct2d_out[13];
    assign o_14 = dct2d_out[14];
    assign o_15 = dct2d_out[15];
    assign o_16 = dct2d_out[16];
    assign o_17 = dct2d_out[17];
    assign o_18 = dct2d_out[18];
    assign o_19 = dct2d_out[19];
    assign o_20 = dct2d_out[20];
    assign o_21 = dct2d_out[21];
    assign o_22 = dct2d_out[22];
    assign o_23 = dct2d_out[23];
    assign o_24 = dct2d_out[24];
    assign o_25 = dct2d_out[25];
    assign o_26 = dct2d_out[26];
    assign o_27 = dct2d_out[27];
    assign o_28 = dct2d_out[28];
    assign o_29 = dct2d_out[29];
    assign o_30 = dct2d_out[30];
    assign o_31 = dct2d_out[31];
    assign o_32 = dct2d_out[32];
    assign o_33 = dct2d_out[33];
    assign o_34 = dct2d_out[34];
    assign o_35 = dct2d_out[35];
    assign o_36 = dct2d_out[36];
    assign o_37 = dct2d_out[37];
    assign o_38 = dct2d_out[38];
    assign o_39 = dct2d_out[39];
    assign o_40 = dct2d_out[40];
    assign o_41 = dct2d_out[41];
    assign o_42 = dct2d_out[42];
    assign o_43 = dct2d_out[43];
    assign o_44 = dct2d_out[44];
    assign o_45 = dct2d_out[45];
    assign o_46 = dct2d_out[46];
    assign o_47 = dct2d_out[47];
    assign o_48 = dct2d_out[48];
    assign o_49 = dct2d_out[49];
    assign o_50 = dct2d_out[50];
    assign o_51 = dct2d_out[51];
    assign o_52 = dct2d_out[52];
    assign o_53 = dct2d_out[53];
    assign o_54 = dct2d_out[54];
    assign o_55 = dct2d_out[55];
    assign o_56 = dct2d_out[56];
    assign o_57 = dct2d_out[57];
    assign o_58 = dct2d_out[58];
    assign o_59 = dct2d_out[59];
    assign o_60 = dct2d_out[60];
    assign o_61 = dct2d_out[61];
    assign o_62 = dct2d_out[62];
    assign o_63 = dct2d_out[63];

endmodule
