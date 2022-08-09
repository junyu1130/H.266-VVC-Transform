//describe  : 第二次一维正变换/行变换(DCT2/DCT8/DST7)
//input     : 32个一维变换系数
//output    : 32个二维变换系数
//delay     : 8 clk
module transform1d_2nd#(
    parameter  IN_WIDTH = 16,
    parameter  OUT_WIDTH = 16
)
(
//system input
    input                               clk         ,
    input                               rst_n       ,
//input parameter
    input           [1 : 0]             i_type_h    ,//0:DCT2 1:DCT8 2:DST7   
    input           [1 : 0]             i_type_v    ,                 
    input           [2 : 0]             i_width     ,//1:4x4, 2:8x8, 3:16x16, 4:32x32, 5:64x64
    input           [2 : 0]             i_height    ,
//input data
    input                               i_valid     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_0         ,
    input   signed  [IN_WIDTH - 1 : 0]  i_1         ,
    input   signed  [IN_WIDTH - 1 : 0]  i_2         ,
    input   signed  [IN_WIDTH - 1 : 0]  i_3         ,
    input   signed  [IN_WIDTH - 1 : 0]  i_4         ,
    input   signed  [IN_WIDTH - 1 : 0]  i_5         ,
    input   signed  [IN_WIDTH - 1 : 0]  i_6         ,
    input   signed  [IN_WIDTH - 1 : 0]  i_7         ,
    input   signed  [IN_WIDTH - 1 : 0]  i_8         ,
    input   signed  [IN_WIDTH - 1 : 0]  i_9         ,
    input   signed  [IN_WIDTH - 1 : 0]  i_10        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_11        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_12        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_13        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_14        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_15        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_16        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_17        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_18        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_19        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_20        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_21        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_22        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_23        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_24        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_25        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_26        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_27        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_28        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_29        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_30        ,
    input   signed  [IN_WIDTH - 1 : 0]  i_31        ,
//output parameter
    output          [1 : 0]             o_type_h    ,
    output          [1 : 0]             o_type_v    ,
    output          [2 : 0]             o_width     ,
    output          [2 : 0]             o_height    ,
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
    output  signed  [OUT_WIDTH - 1 : 0] o_31        
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

//input delay
    reg [1 : 0] i_type_h_d[0 : 7];
    reg [1 : 0] i_type_v_d[0 : 7];
    reg [2 : 0] i_width_d[0 : 7];
//serial to parallel
    wire [2 : 0] tr_in_height;
    wire tr_in_valid;
    wire signed [IN_WIDTH - 1 : 0] tr_in_data[0 : 63];
//type mux in
    reg [2 : 0] dct2_in_height;
    reg dct2_in_valid;
    reg signed [IN_WIDTH - 1 : 0] dct2_in_data[0 : 63];
    reg [2 : 0] dst7_dct8_in_height;
    reg dst7_dct8_in_valid;
    reg signed [IN_WIDTH - 1 : 0] dst7_dct8_in_data[0 : 31];
//type mux out
    wire [2 : 0] dct2_out_height;
    wire dct2_out_valid;
    wire signed [IN_WIDTH + 11 : 0] dct2_out_data[0 : 31];
    wire [2 : 0] dst7_dct8_out_height;
    wire dst7_dct8_out_valid;
    wire signed [IN_WIDTH + 10 : 0] dst7_dct8_out_data[0 : 31];
    reg [2 : 0] tr_out_height;
    reg tr_out_valid;
    reg signed [IN_WIDTH + 11 : 0] tr_out_data[0 : 31];
//shift
    reg [3 : 0] tr_shift;
    wire [2 : 0] coeff_out_height;
    wire coeff_out_valid;
    wire signed [OUT_WIDTH - 1 : 0] coeff_out_data[0 : 31];

//delay
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin 
        for (i = 0; i < 8; i = i + 1) begin
            i_width_d[i] <= 0;
            i_type_h_d[i] <= 0;
            i_type_v_d[i] <= 0;
        end
    end
    else begin
        i_width_d[0] <= i_width;
        i_type_h_d[0] <= i_type_h;
        i_type_v_d[0] <= i_type_v;
        for (i = 0; i < 7; i = i + 1) begin
            i_width_d[i + 1] <= i_width_d[i];
            i_type_h_d[i + 1] <= i_type_h_d[i];
            i_type_v_d[i + 1] <= i_type_v_d[i];
        end
    end
end

//serial to parallel
serial_to_parallel#(
    .IN_WIDTH   (IN_WIDTH       ),
    .OUT_WIDTH  (IN_WIDTH       )
)
u_serial_to_parallel(
//system input
    .clk        (clk            ),
    .rst_n      (rst_n          ),
//input parameter
    .i_size     (i_height       ),
//input data
    .i_valid    (i_valid        ),
    .i_0        (i_0            ),
    .i_1        (i_1            ),
    .i_2        (i_2            ),
    .i_3        (i_3            ),
    .i_4        (i_4            ),
    .i_5        (i_5            ),
    .i_6        (i_6            ),
    .i_7        (i_7            ),
    .i_8        (i_8            ),
    .i_9        (i_9            ),
    .i_10       (i_10           ),
    .i_11       (i_11           ),
    .i_12       (i_12           ),
    .i_13       (i_13           ),
    .i_14       (i_14           ),
    .i_15       (i_15           ),
    .i_16       (i_16           ),
    .i_17       (i_17           ),
    .i_18       (i_18           ),
    .i_19       (i_19           ),
    .i_20       (i_20           ),
    .i_21       (i_21           ),
    .i_22       (i_22           ),
    .i_23       (i_23           ),
    .i_24       (i_24           ),
    .i_25       (i_25           ),
    .i_26       (i_26           ),
    .i_27       (i_27           ),
    .i_28       (i_28           ),
    .i_29       (i_29           ),
    .i_30       (i_30           ),
    .i_31       (i_31           ),
//output parameter
    .o_size     (tr_in_height   ),
//output data
    .o_valid    (tr_in_valid    ),
    .o_0        (tr_in_data[0 ] ),
    .o_1        (tr_in_data[1 ] ),
    .o_2        (tr_in_data[2 ] ),
    .o_3        (tr_in_data[3 ] ),
    .o_4        (tr_in_data[4 ] ),
    .o_5        (tr_in_data[5 ] ),
    .o_6        (tr_in_data[6 ] ),
    .o_7        (tr_in_data[7 ] ),
    .o_8        (tr_in_data[8 ] ),
    .o_9        (tr_in_data[9 ] ),
    .o_10       (tr_in_data[10] ),
    .o_11       (tr_in_data[11] ),
    .o_12       (tr_in_data[12] ),
    .o_13       (tr_in_data[13] ),
    .o_14       (tr_in_data[14] ),
    .o_15       (tr_in_data[15] ),
    .o_16       (tr_in_data[16] ),
    .o_17       (tr_in_data[17] ),
    .o_18       (tr_in_data[18] ),
    .o_19       (tr_in_data[19] ),
    .o_20       (tr_in_data[20] ),
    .o_21       (tr_in_data[21] ),
    .o_22       (tr_in_data[22] ),
    .o_23       (tr_in_data[23] ),
    .o_24       (tr_in_data[24] ),
    .o_25       (tr_in_data[25] ),
    .o_26       (tr_in_data[26] ),
    .o_27       (tr_in_data[27] ),
    .o_28       (tr_in_data[28] ),
    .o_29       (tr_in_data[29] ),
    .o_30       (tr_in_data[30] ),
    .o_31       (tr_in_data[31] ),
    .o_32       (tr_in_data[32] ),
    .o_33       (tr_in_data[33] ),
    .o_34       (tr_in_data[34] ),
    .o_35       (tr_in_data[35] ),
    .o_36       (tr_in_data[36] ),
    .o_37       (tr_in_data[37] ),
    .o_38       (tr_in_data[38] ),
    .o_39       (tr_in_data[39] ),
    .o_40       (tr_in_data[40] ),
    .o_41       (tr_in_data[41] ),
    .o_42       (tr_in_data[42] ),
    .o_43       (tr_in_data[43] ),
    .o_44       (tr_in_data[44] ),
    .o_45       (tr_in_data[45] ),
    .o_46       (tr_in_data[46] ),
    .o_47       (tr_in_data[47] ),
    .o_48       (tr_in_data[48] ),
    .o_49       (tr_in_data[49] ),
    .o_50       (tr_in_data[50] ),
    .o_51       (tr_in_data[51] ),
    .o_52       (tr_in_data[52] ),
    .o_53       (tr_in_data[53] ),
    .o_54       (tr_in_data[54] ),
    .o_55       (tr_in_data[55] ),
    .o_56       (tr_in_data[56] ),
    .o_57       (tr_in_data[57] ),
    .o_58       (tr_in_data[58] ),
    .o_59       (tr_in_data[59] ),
    .o_60       (tr_in_data[60] ),
    .o_61       (tr_in_data[61] ),
    .o_62       (tr_in_data[62] ),
    .o_63       (tr_in_data[63] )
);

//type mux in
always @(*) begin
    dct2_in_height <= 0;
    dct2_in_valid <= 0;
    for (i = 0; i < 64; i = i + 1) begin
        dct2_in_data[i] <= 0;
    end
    dst7_dct8_in_height <= 0;
    dst7_dct8_in_valid <= 0;
    for (i = 0; i < 32; i = i + 1) begin
        dst7_dct8_in_data[i] <= 0;
    end
    case (i_type_v_d[1]) 
        DCT2    : begin
            dct2_in_height <= tr_in_height;
            dct2_in_valid <= tr_in_valid;
            for (i = 0; i < 64; i = i + 1) begin
                dct2_in_data[i] <= tr_in_data[i];
            end
        end
        DST7    : begin
            dst7_dct8_in_height <= tr_in_height;
            dst7_dct8_in_valid <= tr_in_valid;
            for (i = 0; i < 32; i = i + 1) begin
                dst7_dct8_in_data[i] <= tr_in_data[i];
            end
        end
        DCT8    : begin //reverse input
            dst7_dct8_in_height <= tr_in_height;
            dst7_dct8_in_valid <= tr_in_valid;
            case (tr_in_height)
                SIZE32 : begin
                    for (i = 0; i < 32; i = i + 1) begin
                        dst7_dct8_in_data[i] <= tr_in_data[31 - i];
                    end
                end
                SIZE16 : begin
                    for (i = 0; i < 16; i = i + 1) begin
                        dst7_dct8_in_data[i] <= tr_in_data[15 - i];
                    end
                end
                SIZE8 : begin
                    for (i = 0; i < 8; i = i + 1) begin
                        dst7_dct8_in_data[i] <= tr_in_data[7 - i];
                        dst7_dct8_in_data[8 + i] <= tr_in_data[15 - i];
                    end
                end
                SIZE4 : begin
                    for (i = 0; i < 4; i = i + 1) begin
                        dst7_dct8_in_data[i] <= tr_in_data[3 - i];
                        dst7_dct8_in_data[4 + i] <= tr_in_data[7 - i];
                        dst7_dct8_in_data[8 + i] <= tr_in_data[11 - i];
                        dst7_dct8_in_data[12 + i] <= tr_in_data[15 - i];
                    end
                end
            endcase
        end
    endcase
end

//dct2
dct2_1d#(
    .IN_WIDTH   (IN_WIDTH       ),
    .OUT_WIDTH  (IN_WIDTH + 12  )
)
u_dct2_1d(
//system input
    .clk     (clk               ),
    .rst_n   (rst_n             ),
//input parameter
    .i_size  (dct2_in_height    ),
//input data
    .i_valid (dct2_in_valid     ),
    .i_0     (dct2_in_data[0 ]  ),
    .i_1     (dct2_in_data[1 ]  ),
    .i_2     (dct2_in_data[2 ]  ),
    .i_3     (dct2_in_data[3 ]  ),
    .i_4     (dct2_in_data[4 ]  ),
    .i_5     (dct2_in_data[5 ]  ),
    .i_6     (dct2_in_data[6 ]  ),
    .i_7     (dct2_in_data[7 ]  ),
    .i_8     (dct2_in_data[8 ]  ),
    .i_9     (dct2_in_data[9 ]  ),
    .i_10    (dct2_in_data[10]  ),
    .i_11    (dct2_in_data[11]  ),
    .i_12    (dct2_in_data[12]  ),
    .i_13    (dct2_in_data[13]  ),
    .i_14    (dct2_in_data[14]  ),
    .i_15    (dct2_in_data[15]  ),
    .i_16    (dct2_in_data[16]  ),
    .i_17    (dct2_in_data[17]  ),
    .i_18    (dct2_in_data[18]  ),
    .i_19    (dct2_in_data[19]  ),
    .i_20    (dct2_in_data[20]  ),
    .i_21    (dct2_in_data[21]  ),
    .i_22    (dct2_in_data[22]  ),
    .i_23    (dct2_in_data[23]  ),
    .i_24    (dct2_in_data[24]  ),
    .i_25    (dct2_in_data[25]  ),
    .i_26    (dct2_in_data[26]  ),
    .i_27    (dct2_in_data[27]  ),
    .i_28    (dct2_in_data[28]  ),
    .i_29    (dct2_in_data[29]  ),
    .i_30    (dct2_in_data[30]  ),
    .i_31    (dct2_in_data[31]  ),
    .i_32    (dct2_in_data[32]  ),
    .i_33    (dct2_in_data[33]  ),
    .i_34    (dct2_in_data[34]  ),
    .i_35    (dct2_in_data[35]  ),
    .i_36    (dct2_in_data[36]  ),
    .i_37    (dct2_in_data[37]  ),
    .i_38    (dct2_in_data[38]  ),
    .i_39    (dct2_in_data[39]  ),
    .i_40    (dct2_in_data[40]  ),
    .i_41    (dct2_in_data[41]  ),
    .i_42    (dct2_in_data[42]  ),
    .i_43    (dct2_in_data[43]  ),
    .i_44    (dct2_in_data[44]  ),
    .i_45    (dct2_in_data[45]  ),
    .i_46    (dct2_in_data[46]  ),
    .i_47    (dct2_in_data[47]  ),
    .i_48    (dct2_in_data[48]  ),
    .i_49    (dct2_in_data[49]  ),
    .i_50    (dct2_in_data[50]  ),
    .i_51    (dct2_in_data[51]  ),
    .i_52    (dct2_in_data[52]  ),
    .i_53    (dct2_in_data[53]  ),
    .i_54    (dct2_in_data[54]  ),
    .i_55    (dct2_in_data[55]  ),
    .i_56    (dct2_in_data[56]  ),
    .i_57    (dct2_in_data[57]  ),
    .i_58    (dct2_in_data[58]  ),
    .i_59    (dct2_in_data[59]  ),
    .i_60    (dct2_in_data[60]  ),
    .i_61    (dct2_in_data[61]  ),
    .i_62    (dct2_in_data[62]  ),
    .i_63    (dct2_in_data[63]  ),
//output parameter
    .o_size  (dct2_out_height   ),
//output 1st stage's coeff
    .o_valid (dct2_out_valid    ),
    .o_0     (dct2_out_data[0 ] ),
    .o_1     (dct2_out_data[1 ] ),
    .o_2     (dct2_out_data[2 ] ),
    .o_3     (dct2_out_data[3 ] ),
    .o_4     (dct2_out_data[4 ] ),
    .o_5     (dct2_out_data[5 ] ),
    .o_6     (dct2_out_data[6 ] ),
    .o_7     (dct2_out_data[7 ] ),
    .o_8     (dct2_out_data[8 ] ),
    .o_9     (dct2_out_data[9 ] ),
    .o_10    (dct2_out_data[10] ),
    .o_11    (dct2_out_data[11] ),
    .o_12    (dct2_out_data[12] ),
    .o_13    (dct2_out_data[13] ),
    .o_14    (dct2_out_data[14] ),
    .o_15    (dct2_out_data[15] ),
    .o_16    (dct2_out_data[16] ),
    .o_17    (dct2_out_data[17] ),
    .o_18    (dct2_out_data[18] ),
    .o_19    (dct2_out_data[19] ),
    .o_20    (dct2_out_data[20] ),
    .o_21    (dct2_out_data[21] ),
    .o_22    (dct2_out_data[22] ),
    .o_23    (dct2_out_data[23] ),
    .o_24    (dct2_out_data[24] ),
    .o_25    (dct2_out_data[25] ),
    .o_26    (dct2_out_data[26] ),
    .o_27    (dct2_out_data[27] ),
    .o_28    (dct2_out_data[28] ),
    .o_29    (dct2_out_data[29] ),
    .o_30    (dct2_out_data[30] ),
    .o_31    (dct2_out_data[31] )
); 

//dst7/dct8
dst7_dct8_1d#(
    .IN_WIDTH   (IN_WIDTH           ),
    .OUT_WIDTH  (IN_WIDTH + 11      )
)
u_dst7_dct8_1d(
//system input
    .clk     (clk                   ),
    .rst_n   (rst_n                 ),
//input parameter
    .i_size  (dst7_dct8_in_height   ),
//input data
    .i_valid (dst7_dct8_in_valid    ),
    .i_0     (dst7_dct8_in_data[0 ] ),
    .i_1     (dst7_dct8_in_data[1 ] ),
    .i_2     (dst7_dct8_in_data[2 ] ),
    .i_3     (dst7_dct8_in_data[3 ] ),
    .i_4     (dst7_dct8_in_data[4 ] ),
    .i_5     (dst7_dct8_in_data[5 ] ),
    .i_6     (dst7_dct8_in_data[6 ] ),
    .i_7     (dst7_dct8_in_data[7 ] ),
    .i_8     (dst7_dct8_in_data[8 ] ),
    .i_9     (dst7_dct8_in_data[9 ] ),
    .i_10    (dst7_dct8_in_data[10] ),
    .i_11    (dst7_dct8_in_data[11] ),
    .i_12    (dst7_dct8_in_data[12] ),
    .i_13    (dst7_dct8_in_data[13] ),
    .i_14    (dst7_dct8_in_data[14] ),
    .i_15    (dst7_dct8_in_data[15] ),
    .i_16    (dst7_dct8_in_data[16] ),
    .i_17    (dst7_dct8_in_data[17] ),
    .i_18    (dst7_dct8_in_data[18] ),
    .i_19    (dst7_dct8_in_data[19] ),
    .i_20    (dst7_dct8_in_data[20] ),
    .i_21    (dst7_dct8_in_data[21] ),
    .i_22    (dst7_dct8_in_data[22] ),
    .i_23    (dst7_dct8_in_data[23] ),
    .i_24    (dst7_dct8_in_data[24] ),
    .i_25    (dst7_dct8_in_data[25] ),
    .i_26    (dst7_dct8_in_data[26] ),
    .i_27    (dst7_dct8_in_data[27] ),
    .i_28    (dst7_dct8_in_data[28] ),
    .i_29    (dst7_dct8_in_data[29] ),
    .i_30    (dst7_dct8_in_data[30] ),
    .i_31    (dst7_dct8_in_data[31] ),
//output parameter
    .o_size  (dst7_dct8_out_height  ),
//output 1st stage's coeff
    .o_valid (dst7_dct8_out_valid   ),
    .o_0     (dst7_dct8_out_data[0 ]),
    .o_1     (dst7_dct8_out_data[1 ]),
    .o_2     (dst7_dct8_out_data[2 ]),
    .o_3     (dst7_dct8_out_data[3 ]),
    .o_4     (dst7_dct8_out_data[4 ]),
    .o_5     (dst7_dct8_out_data[5 ]),
    .o_6     (dst7_dct8_out_data[6 ]),
    .o_7     (dst7_dct8_out_data[7 ]),
    .o_8     (dst7_dct8_out_data[8 ]),
    .o_9     (dst7_dct8_out_data[9 ]),
    .o_10    (dst7_dct8_out_data[10]),
    .o_11    (dst7_dct8_out_data[11]),
    .o_12    (dst7_dct8_out_data[12]),
    .o_13    (dst7_dct8_out_data[13]),
    .o_14    (dst7_dct8_out_data[14]),
    .o_15    (dst7_dct8_out_data[15]),
    .o_16    (dst7_dct8_out_data[16]),
    .o_17    (dst7_dct8_out_data[17]),
    .o_18    (dst7_dct8_out_data[18]),
    .o_19    (dst7_dct8_out_data[19]),
    .o_20    (dst7_dct8_out_data[20]),
    .o_21    (dst7_dct8_out_data[21]),
    .o_22    (dst7_dct8_out_data[22]),
    .o_23    (dst7_dct8_out_data[23]),
    .o_24    (dst7_dct8_out_data[24]),
    .o_25    (dst7_dct8_out_data[25]),
    .o_26    (dst7_dct8_out_data[26]),
    .o_27    (dst7_dct8_out_data[27]),
    .o_28    (dst7_dct8_out_data[28]),
    .o_29    (dst7_dct8_out_data[29]),
    .o_30    (dst7_dct8_out_data[30]),
    .o_31    (dst7_dct8_out_data[31])
); 

//type mux out
always @(*) begin
    tr_out_height <= 0;
    tr_out_valid <= 0;
    for (i = 0; i < 32; i = i + 1) begin
        tr_out_data[i] <= 0;
    end
    case (i_type_v_d[6]) 
        DCT2    : begin
            tr_out_height <= dct2_out_height;
            tr_out_valid <= dct2_out_valid;
            for (i = 0; i < 32; i = i + 1) begin
                tr_out_data[i] <= dct2_out_data[i];
            end
        end
        DST7    : begin
            tr_out_height <= dst7_dct8_out_height;
            tr_out_valid <= dst7_dct8_out_valid;
            for (i = 0; i < 32; i = i + 1) begin
                tr_out_data[i] <= dst7_dct8_out_data[i];
            end
        end
        DCT8    : begin //odd line reverse sign
            tr_out_height <= dst7_dct8_out_height;
            tr_out_valid <= dst7_dct8_out_valid;
            for (i = 0; i < 32; i = i + 2) begin
                tr_out_data[i] <= dst7_dct8_out_data[i];
            end
            for (i = 1; i < 32; i = i + 2) begin
                tr_out_data[i] <= -dst7_dct8_out_data[i];
            end
        end
    endcase
end

//shift
always @(*) begin
    case (tr_out_height)//second stage : log2(Height) + 6
        SIZE4   : tr_shift <= 8;
        SIZE8   : tr_shift <= 9;
        SIZE16  : tr_shift <= 10;
        SIZE32  : tr_shift <= 11;
        SIZE64  : tr_shift <= 12;
        default : tr_shift <= 0;
    endcase
end

right_shift#(
    .IN_WIDTH   (IN_WIDTH + 12      ),
    .OUT_WIDTH  (OUT_WIDTH          )
)
u_right_shift(
//system input
    .clk        (clk                ),
    .rst_n      (rst_n              ),
//input parameter
    .i_shift    (tr_shift           ),
    .i_size     (tr_out_height      ),
//input pre_coeff
    .i_valid    (tr_out_valid       ),
    .i_0        (tr_out_data[0 ]    ),
    .i_1        (tr_out_data[1 ]    ),
    .i_2        (tr_out_data[2 ]    ),
    .i_3        (tr_out_data[3 ]    ),
    .i_4        (tr_out_data[4 ]    ),
    .i_5        (tr_out_data[5 ]    ),
    .i_6        (tr_out_data[6 ]    ),
    .i_7        (tr_out_data[7 ]    ),
    .i_8        (tr_out_data[8 ]    ),
    .i_9        (tr_out_data[9 ]    ),
    .i_10       (tr_out_data[10]    ),
    .i_11       (tr_out_data[11]    ),
    .i_12       (tr_out_data[12]    ),
    .i_13       (tr_out_data[13]    ),
    .i_14       (tr_out_data[14]    ),
    .i_15       (tr_out_data[15]    ),
    .i_16       (tr_out_data[16]    ),
    .i_17       (tr_out_data[17]    ),
    .i_18       (tr_out_data[18]    ),
    .i_19       (tr_out_data[19]    ),
    .i_20       (tr_out_data[20]    ),
    .i_21       (tr_out_data[21]    ),
    .i_22       (tr_out_data[22]    ),
    .i_23       (tr_out_data[23]    ),
    .i_24       (tr_out_data[24]    ),
    .i_25       (tr_out_data[25]    ),
    .i_26       (tr_out_data[26]    ),
    .i_27       (tr_out_data[27]    ),
    .i_28       (tr_out_data[28]    ),
    .i_29       (tr_out_data[29]    ),
    .i_30       (tr_out_data[30]    ),
    .i_31       (tr_out_data[31]    ),
//output parameter
    .o_size     (coeff_out_height   ),
//output coeff
    .o_valid    (coeff_out_valid    ),
    .o_0        (coeff_out_data[0 ] ),
    .o_1        (coeff_out_data[1 ] ),
    .o_2        (coeff_out_data[2 ] ),
    .o_3        (coeff_out_data[3 ] ),
    .o_4        (coeff_out_data[4 ] ),
    .o_5        (coeff_out_data[5 ] ),
    .o_6        (coeff_out_data[6 ] ),
    .o_7        (coeff_out_data[7 ] ),
    .o_8        (coeff_out_data[8 ] ),
    .o_9        (coeff_out_data[9 ] ),
    .o_10       (coeff_out_data[10] ),
    .o_11       (coeff_out_data[11] ),
    .o_12       (coeff_out_data[12] ),
    .o_13       (coeff_out_data[13] ),
    .o_14       (coeff_out_data[14] ),
    .o_15       (coeff_out_data[15] ),
    .o_16       (coeff_out_data[16] ),
    .o_17       (coeff_out_data[17] ),
    .o_18       (coeff_out_data[18] ),
    .o_19       (coeff_out_data[19] ),
    .o_20       (coeff_out_data[20] ),
    .o_21       (coeff_out_data[21] ),
    .o_22       (coeff_out_data[22] ),
    .o_23       (coeff_out_data[23] ),
    .o_24       (coeff_out_data[24] ),
    .o_25       (coeff_out_data[25] ),
    .o_26       (coeff_out_data[26] ),
    .o_27       (coeff_out_data[27] ),
    .o_28       (coeff_out_data[28] ),
    .o_29       (coeff_out_data[29] ),
    .o_30       (coeff_out_data[30] ),
    .o_31       (coeff_out_data[31] )
);  

//output
    assign o_type_h = i_type_h_d[7];
    assign o_type_v = i_type_v_d[7];
    assign o_width  = i_width_d[7];
    assign o_height = coeff_out_height;
    assign o_valid  = coeff_out_valid;
    assign o_0      = coeff_out_data[0 ];
    assign o_1      = coeff_out_data[1 ];
    assign o_2      = coeff_out_data[2 ];
    assign o_3      = coeff_out_data[3 ];
    assign o_4      = coeff_out_data[4 ];
    assign o_5      = coeff_out_data[5 ];
    assign o_6      = coeff_out_data[6 ];
    assign o_7      = coeff_out_data[7 ];
    assign o_8      = coeff_out_data[8 ];
    assign o_9      = coeff_out_data[9 ];
    assign o_10     = coeff_out_data[10];
    assign o_11     = coeff_out_data[11];
    assign o_12     = coeff_out_data[12];
    assign o_13     = coeff_out_data[13];
    assign o_14     = coeff_out_data[14];
    assign o_15     = coeff_out_data[15];
    assign o_16     = coeff_out_data[16];
    assign o_17     = coeff_out_data[17];
    assign o_18     = coeff_out_data[18];
    assign o_19     = coeff_out_data[19];
    assign o_20     = coeff_out_data[20];
    assign o_21     = coeff_out_data[21];
    assign o_22     = coeff_out_data[22];
    assign o_23     = coeff_out_data[23];
    assign o_24     = coeff_out_data[24];
    assign o_25     = coeff_out_data[25];
    assign o_26     = coeff_out_data[26];
    assign o_27     = coeff_out_data[27];
    assign o_28     = coeff_out_data[28];
    assign o_29     = coeff_out_data[29];
    assign o_30     = coeff_out_data[30];
    assign o_31     = coeff_out_data[31];

endmodule
