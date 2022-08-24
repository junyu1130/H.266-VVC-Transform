//describe  : 一维正变换(DCT2/DCT8/DST7)
//input     : 16个像素残差/一维变换系数
//output    : 16个一维变换系数/二维变换系数
//delay     : 10 clk
module transform1d#(
    parameter  IN_WIDTH = 16,
    parameter  OUT_WIDTH = 16
)
(
//system input
    input                               clk         ,
    input                               rst_n       ,
//input parameter
    input           [1 : 0]             i_type      ,//0:DCT2 1:DCT8 2:DST7               
    input           [2 : 0]             i_size      ,//1:4x4, 2:8x8, 3:16x16, 4:32x32, 5:64x64
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
//output parameter
    output          [1 : 0]             o_type      ,
    output          [2 : 0]             o_size      ,
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
    output  signed  [OUT_WIDTH - 1 : 0] o_15          
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
    reg [1 : 0] i_type_d[0 : 4];
//serial to parallel
    wire [2 : 0] tr_in_size;
    wire tr_in_valid;
    wire signed [IN_WIDTH - 1 : 0] tr_in_data[0 : 63];
//butterfly
    wire [2 : 0] butterfly_out_size;
    wire butterfly_out_valid;
    wire signed [IN_WIDTH + 4 : 0] butterfly_out_data1[0 : 3];
    wire signed [IN_WIDTH + 3 : 0] butterfly_out_data2[4 : 7];
    wire signed [IN_WIDTH + 2 : 0] butterfly_out_data3[8 : 15];
    wire signed [IN_WIDTH + 1 : 0] butterfly_out_data4[16 : 31];
    wire signed [IN_WIDTH     : 0] butterfly_out_data5[32 : 63];
    reg signed [IN_WIDTH - 1 : 0] tr_in_data_d1[0 : 31];
//type mux in
    reg signed [IN_WIDTH + 4 : 0] calculate_in_data1[0 : 3];
    reg signed [IN_WIDTH + 3 : 0] calculate_in_data2[4 : 7];
    reg signed [IN_WIDTH + 2 : 0] calculate_in_data3[8 : 15];
    reg signed [IN_WIDTH + 1 : 0] calculate_in_data4[16 : 31];
    reg signed [IN_WIDTH     : 0] calculate_in_data5[32 : 63];
//calculate
    wire [1 : 0] calculate_out_type;
    reg [1 : 0] calculate_out_type_d1, calculate_out_type_d2;
    wire [2 : 0] calculate_out_size;
    wire calculate_out_valid;
    wire signed [IN_WIDTH + 11 : 0] calculate_out_data[0 : 31];
//type mux out
    reg signed [IN_WIDTH + 11 : 0] tr_out_data[0 : 31];
//shift
    reg [3 : 0] tr_shift;
    wire [2 : 0] coeff_out_size;
    wire coeff_out_valid;
    wire signed [OUT_WIDTH - 1 : 0] coeff_out_data[0 : 31];
//parallel to serial
    wire [2 : 0] serial_out_size;
    wire serial_out_valid;
    wire signed [OUT_WIDTH - 1 : 0] serial_out_data[0 : 15];

//delay
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin 
        for (i = 0; i < 5; i = i + 1) begin
            i_type_d[i] <= 0;
        end
    end
    else begin
        i_type_d[0] <= i_type;
        for (i = 0; i < 4; i = i + 1) begin
            i_type_d[i + 1] <= i_type_d[i];
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
    .i_size     (i_size         ),
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
//output parameter
    .o_size     (tr_in_size     ),
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

dct2_butterfly#(
    .IN_WIDTH   (IN_WIDTH)
)
u_dct2_butterfly(
//system input
    .clk        (clk                    ),
    .rst_n      (rst_n                  ),
//input parameter
    .i_size     (tr_in_size             ),
//input data
    .i_valid    (tr_in_valid            ),
    .i_0        (tr_in_data[0 ]         ),
    .i_1        (tr_in_data[1 ]         ),
    .i_2        (tr_in_data[2 ]         ),
    .i_3        (tr_in_data[3 ]         ),
    .i_4        (tr_in_data[4 ]         ),
    .i_5        (tr_in_data[5 ]         ),
    .i_6        (tr_in_data[6 ]         ),
    .i_7        (tr_in_data[7 ]         ),
    .i_8        (tr_in_data[8 ]         ),
    .i_9        (tr_in_data[9 ]         ),
    .i_10       (tr_in_data[10]         ),
    .i_11       (tr_in_data[11]         ),
    .i_12       (tr_in_data[12]         ),
    .i_13       (tr_in_data[13]         ),
    .i_14       (tr_in_data[14]         ),
    .i_15       (tr_in_data[15]         ),
    .i_16       (tr_in_data[16]         ),
    .i_17       (tr_in_data[17]         ),
    .i_18       (tr_in_data[18]         ),
    .i_19       (tr_in_data[19]         ),
    .i_20       (tr_in_data[20]         ),
    .i_21       (tr_in_data[21]         ),
    .i_22       (tr_in_data[22]         ),
    .i_23       (tr_in_data[23]         ),
    .i_24       (tr_in_data[24]         ),
    .i_25       (tr_in_data[25]         ),
    .i_26       (tr_in_data[26]         ),
    .i_27       (tr_in_data[27]         ),
    .i_28       (tr_in_data[28]         ),
    .i_29       (tr_in_data[29]         ),
    .i_30       (tr_in_data[30]         ),
    .i_31       (tr_in_data[31]         ),
    .i_32       (tr_in_data[32]         ),
    .i_33       (tr_in_data[33]         ),
    .i_34       (tr_in_data[34]         ),
    .i_35       (tr_in_data[35]         ),
    .i_36       (tr_in_data[36]         ),
    .i_37       (tr_in_data[37]         ),
    .i_38       (tr_in_data[38]         ),
    .i_39       (tr_in_data[39]         ),
    .i_40       (tr_in_data[40]         ),
    .i_41       (tr_in_data[41]         ),
    .i_42       (tr_in_data[42]         ),
    .i_43       (tr_in_data[43]         ),
    .i_44       (tr_in_data[44]         ),
    .i_45       (tr_in_data[45]         ),
    .i_46       (tr_in_data[46]         ),
    .i_47       (tr_in_data[47]         ),
    .i_48       (tr_in_data[48]         ),
    .i_49       (tr_in_data[49]         ),
    .i_50       (tr_in_data[50]         ),
    .i_51       (tr_in_data[51]         ),
    .i_52       (tr_in_data[52]         ),
    .i_53       (tr_in_data[53]         ),
    .i_54       (tr_in_data[54]         ),
    .i_55       (tr_in_data[55]         ),
    .i_56       (tr_in_data[56]         ),
    .i_57       (tr_in_data[57]         ),
    .i_58       (tr_in_data[58]         ),
    .i_59       (tr_in_data[59]         ),
    .i_60       (tr_in_data[60]         ),
    .i_61       (tr_in_data[61]         ),
    .i_62       (tr_in_data[62]         ),
    .i_63       (tr_in_data[63]         ),
//output parameter
    .o_size     (butterfly_out_size     ),
//output data
    .o_valid    (butterfly_out_valid    ),
    .o_0        (butterfly_out_data1[0 ]),
    .o_1        (butterfly_out_data1[1 ]),
    .o_2        (butterfly_out_data1[2 ]),
    .o_3        (butterfly_out_data1[3 ]),
    .o_4        (butterfly_out_data2[4 ]),
    .o_5        (butterfly_out_data2[5 ]),
    .o_6        (butterfly_out_data2[6 ]),
    .o_7        (butterfly_out_data2[7 ]),
    .o_8        (butterfly_out_data3[8 ]),
    .o_9        (butterfly_out_data3[9 ]),
    .o_10       (butterfly_out_data3[10]),
    .o_11       (butterfly_out_data3[11]),
    .o_12       (butterfly_out_data3[12]),
    .o_13       (butterfly_out_data3[13]),
    .o_14       (butterfly_out_data3[14]),
    .o_15       (butterfly_out_data3[15]),
    .o_16       (butterfly_out_data4[16]),
    .o_17       (butterfly_out_data4[17]),
    .o_18       (butterfly_out_data4[18]),
    .o_19       (butterfly_out_data4[19]),
    .o_20       (butterfly_out_data4[20]),
    .o_21       (butterfly_out_data4[21]),
    .o_22       (butterfly_out_data4[22]),
    .o_23       (butterfly_out_data4[23]),
    .o_24       (butterfly_out_data4[24]),
    .o_25       (butterfly_out_data4[25]),
    .o_26       (butterfly_out_data4[26]),
    .o_27       (butterfly_out_data4[27]),
    .o_28       (butterfly_out_data4[28]),
    .o_29       (butterfly_out_data4[29]),
    .o_30       (butterfly_out_data4[30]),
    .o_31       (butterfly_out_data4[31]),
    .o_32       (butterfly_out_data5[32]),
    .o_33       (butterfly_out_data5[33]),
    .o_34       (butterfly_out_data5[34]),
    .o_35       (butterfly_out_data5[35]),
    .o_36       (butterfly_out_data5[36]),
    .o_37       (butterfly_out_data5[37]),
    .o_38       (butterfly_out_data5[38]),
    .o_39       (butterfly_out_data5[39]),
    .o_40       (butterfly_out_data5[40]),
    .o_41       (butterfly_out_data5[41]),
    .o_42       (butterfly_out_data5[42]),
    .o_43       (butterfly_out_data5[43]),
    .o_44       (butterfly_out_data5[44]),
    .o_45       (butterfly_out_data5[45]),
    .o_46       (butterfly_out_data5[46]),
    .o_47       (butterfly_out_data5[47]),
    .o_48       (butterfly_out_data5[48]),
    .o_49       (butterfly_out_data5[49]),
    .o_50       (butterfly_out_data5[50]),
    .o_51       (butterfly_out_data5[51]),
    .o_52       (butterfly_out_data5[52]),
    .o_53       (butterfly_out_data5[53]),
    .o_54       (butterfly_out_data5[54]),
    .o_55       (butterfly_out_data5[55]),
    .o_56       (butterfly_out_data5[56]),
    .o_57       (butterfly_out_data5[57]),
    .o_58       (butterfly_out_data5[58]),
    .o_59       (butterfly_out_data5[59]),
    .o_60       (butterfly_out_data5[60]),
    .o_61       (butterfly_out_data5[61]),
    .o_62       (butterfly_out_data5[62]),
    .o_63       (butterfly_out_data5[63])
);

//no butterfly delay 1 clk
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i = 0; i < 32; i = i + 1) begin
            tr_in_data_d1[i] <= 0; 
        end
    end
    else begin
        for (i = 0; i < 32; i = i + 1) begin
            tr_in_data_d1[i] <= tr_in_data[i]; 
        end
    end
end

//type mux in
always @(*) begin
    for (i = 0; i < 4; i = i + 1) begin
        calculate_in_data1[i] <= 0;
    end
    for (i = 4; i < 8; i = i + 1) begin
        calculate_in_data2[i] <= 0;
    end
    for (i = 8; i < 16; i = i + 1) begin
        calculate_in_data3[i] <= 0;
    end
    for (i = 16; i < 32; i = i + 1) begin
        calculate_in_data4[i] <= 0;
    end
    for (i = 32; i < 64; i = i + 1) begin
        calculate_in_data5[i] <= 0;
    end
    case (i_type_d[4]) 
        DCT2    : begin
            for (i = 0; i < 4; i = i + 1) begin
                calculate_in_data1[i] <= butterfly_out_data1[i];
            end
            for (i = 4; i < 8; i = i + 1) begin
                calculate_in_data2[i] <= butterfly_out_data2[i];
            end
            for (i = 8; i < 16; i = i + 1) begin
                calculate_in_data3[i] <= butterfly_out_data3[i];
            end
            for (i = 16; i < 32; i = i + 1) begin
                calculate_in_data4[i] <= butterfly_out_data4[i];
            end
            for (i = 32; i < 64; i = i + 1) begin
                calculate_in_data5[i] <= butterfly_out_data5[i];
            end
        end
        DST7    : begin
            for (i = 0; i < 32; i = i + 1) begin
                calculate_in_data5[i + 32] <= tr_in_data_d1[i];
            end
        end
        DCT8    : begin //reverse input
            case (butterfly_out_size)
                SIZE32 : begin
                    for (i = 0; i < 32; i = i + 1) begin
                        calculate_in_data5[32 + i] <= tr_in_data_d1[31 - i];
                    end
                end
                SIZE16 : begin
                    for (i = 0; i < 16; i = i + 1) begin
                        calculate_in_data5[32 + i] <= tr_in_data_d1[15 - i];
                    end
                end
                SIZE8 : begin
                    for (i = 0; i < 8; i = i + 1) begin
                        calculate_in_data5[32 + i] <= tr_in_data_d1[7 - i];
                        calculate_in_data5[40 + i] <= tr_in_data_d1[15 - i];
                    end
                end
                SIZE4 : begin
                    for (i = 0; i < 4; i = i + 1) begin
                        calculate_in_data5[32 + i] <= tr_in_data_d1[3 - i];
                        calculate_in_data5[36 + i] <= tr_in_data_d1[7 - i];
                        calculate_in_data5[40 + i] <= tr_in_data_d1[11 - i];
                        calculate_in_data5[44 + i] <= tr_in_data_d1[15 - i];
                    end
                end
            endcase
        end
    endcase
end

tranform1d_calculate#(
    .IN_WIDTH   (IN_WIDTH + 1),
    .OUT_WIDTH  (IN_WIDTH + 12)
)
u_tranform1d_calculate(
//system input
    .clk        (clk                    ),
    .rst_n      (rst_n                  ),
//input parameter
    .i_type     (i_type_d[4]            ),
    .i_size     (butterfly_out_size     ),
//input data
    .i_valid    (butterfly_out_valid    ),
    .i_0        (calculate_in_data1[0 ] ),
    .i_1        (calculate_in_data1[1 ] ),
    .i_2        (calculate_in_data1[2 ] ),
    .i_3        (calculate_in_data1[3 ] ),
    .i_4        (calculate_in_data2[4 ] ),
    .i_5        (calculate_in_data2[5 ] ),
    .i_6        (calculate_in_data2[6 ] ),
    .i_7        (calculate_in_data2[7 ] ),
    .i_8        (calculate_in_data3[8 ] ),
    .i_9        (calculate_in_data3[9 ] ),
    .i_10       (calculate_in_data3[10] ),
    .i_11       (calculate_in_data3[11] ),
    .i_12       (calculate_in_data3[12] ),
    .i_13       (calculate_in_data3[13] ),
    .i_14       (calculate_in_data3[14] ),
    .i_15       (calculate_in_data3[15] ),
    .i_16       (calculate_in_data4[16] ),
    .i_17       (calculate_in_data4[17] ),
    .i_18       (calculate_in_data4[18] ),
    .i_19       (calculate_in_data4[19] ),
    .i_20       (calculate_in_data4[20] ),
    .i_21       (calculate_in_data4[21] ),
    .i_22       (calculate_in_data4[22] ),
    .i_23       (calculate_in_data4[23] ),
    .i_24       (calculate_in_data4[24] ),
    .i_25       (calculate_in_data4[25] ),
    .i_26       (calculate_in_data4[26] ),
    .i_27       (calculate_in_data4[27] ),
    .i_28       (calculate_in_data4[28] ),
    .i_29       (calculate_in_data4[29] ),
    .i_30       (calculate_in_data4[30] ),
    .i_31       (calculate_in_data4[31] ),
    .i_32       (calculate_in_data5[32] ),
    .i_33       (calculate_in_data5[33] ),
    .i_34       (calculate_in_data5[34] ),
    .i_35       (calculate_in_data5[35] ),
    .i_36       (calculate_in_data5[36] ),
    .i_37       (calculate_in_data5[37] ),
    .i_38       (calculate_in_data5[38] ),
    .i_39       (calculate_in_data5[39] ),
    .i_40       (calculate_in_data5[40] ),
    .i_41       (calculate_in_data5[41] ),
    .i_42       (calculate_in_data5[42] ),
    .i_43       (calculate_in_data5[43] ),
    .i_44       (calculate_in_data5[44] ),
    .i_45       (calculate_in_data5[45] ),
    .i_46       (calculate_in_data5[46] ),
    .i_47       (calculate_in_data5[47] ),
    .i_48       (calculate_in_data5[48] ),
    .i_49       (calculate_in_data5[49] ),
    .i_50       (calculate_in_data5[50] ),
    .i_51       (calculate_in_data5[51] ),
    .i_52       (calculate_in_data5[52] ),
    .i_53       (calculate_in_data5[53] ),
    .i_54       (calculate_in_data5[54] ),
    .i_55       (calculate_in_data5[55] ),
    .i_56       (calculate_in_data5[56] ),
    .i_57       (calculate_in_data5[57] ),
    .i_58       (calculate_in_data5[58] ),
    .i_59       (calculate_in_data5[59] ),
    .i_60       (calculate_in_data5[60] ),
    .i_61       (calculate_in_data5[61] ),
    .i_62       (calculate_in_data5[62] ),
    .i_63       (calculate_in_data5[63] ),
//output parameter
    .o_type     (calculate_out_type     ),
    .o_size     (calculate_out_size     ),
//output data
    .o_valid    (calculate_out_valid    ),
    .o_0        (calculate_out_data[0 ] ),
    .o_1        (calculate_out_data[1 ] ),
    .o_2        (calculate_out_data[2 ] ),
    .o_3        (calculate_out_data[3 ] ),
    .o_4        (calculate_out_data[4 ] ),
    .o_5        (calculate_out_data[5 ] ),
    .o_6        (calculate_out_data[6 ] ),
    .o_7        (calculate_out_data[7 ] ),
    .o_8        (calculate_out_data[8 ] ),
    .o_9        (calculate_out_data[9 ] ),
    .o_10       (calculate_out_data[10] ),
    .o_11       (calculate_out_data[11] ),
    .o_12       (calculate_out_data[12] ),
    .o_13       (calculate_out_data[13] ),
    .o_14       (calculate_out_data[14] ),
    .o_15       (calculate_out_data[15] ),
    .o_16       (calculate_out_data[16] ),
    .o_17       (calculate_out_data[17] ),
    .o_18       (calculate_out_data[18] ),
    .o_19       (calculate_out_data[19] ),
    .o_20       (calculate_out_data[20] ),
    .o_21       (calculate_out_data[21] ),
    .o_22       (calculate_out_data[22] ),
    .o_23       (calculate_out_data[23] ),
    .o_24       (calculate_out_data[24] ),
    .o_25       (calculate_out_data[25] ),
    .o_26       (calculate_out_data[26] ),
    .o_27       (calculate_out_data[27] ),
    .o_28       (calculate_out_data[28] ),
    .o_29       (calculate_out_data[29] ),
    .o_30       (calculate_out_data[30] ),
    .o_31       (calculate_out_data[31] )
);

//type mux out
always @(*) begin
    case (calculate_out_type) 
        DCT2    : begin
            for (i = 0; i < 32; i = i + 1) begin
                tr_out_data[i] <= calculate_out_data[i];
            end
        end
        DST7    : begin
            for (i = 0; i < 32; i = i + 1) begin
                tr_out_data[i] <= calculate_out_data[i];
            end
        end
        DCT8    : begin //odd line reverse sign
            for (i = 0; i < 32; i = i + 2) begin
                tr_out_data[i] <= calculate_out_data[i];
            end
            for (i = 1; i < 32; i = i + 2) begin
                tr_out_data[i] <= -calculate_out_data[i];
            end
        end
        default : begin
            for (i = 0; i < 32; i = i + 1) begin
                tr_out_data[i] <= 0;
            end
        end
    endcase
end

//shift
always @(*) begin
    case (calculate_out_size)
        SIZE4   : tr_shift <= IN_WIDTH - 8;
        SIZE8   : tr_shift <= IN_WIDTH - 7;
        SIZE16  : tr_shift <= IN_WIDTH - 6;
        SIZE32  : tr_shift <= IN_WIDTH - 5;
        SIZE64  : tr_shift <= IN_WIDTH - 4;
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
    .i_size     (calculate_out_size ),
//input pre_coeff
    .i_valid    (calculate_out_valid),
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
    .o_size     (coeff_out_size     ),
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

//parallel to serial
parallel_to_serial#(
    .IN_WIDTH   (OUT_WIDTH          ),
    .OUT_WIDTH  (OUT_WIDTH          )
)
u_parallel_to_serial(
//system input
    .clk        (clk                ),
    .rst_n      (rst_n              ),
//input parameter
    .i_size     (coeff_out_size     ),
//input data
    .i_valid    (coeff_out_valid    ),
    .i_0        (coeff_out_data[0 ] ),
    .i_1        (coeff_out_data[1 ] ),
    .i_2        (coeff_out_data[2 ] ),
    .i_3        (coeff_out_data[3 ] ),
    .i_4        (coeff_out_data[4 ] ),
    .i_5        (coeff_out_data[5 ] ),
    .i_6        (coeff_out_data[6 ] ),
    .i_7        (coeff_out_data[7 ] ),
    .i_8        (coeff_out_data[8 ] ),
    .i_9        (coeff_out_data[9 ] ),
    .i_10       (coeff_out_data[10] ),
    .i_11       (coeff_out_data[11] ),
    .i_12       (coeff_out_data[12] ),
    .i_13       (coeff_out_data[13] ),
    .i_14       (coeff_out_data[14] ),
    .i_15       (coeff_out_data[15] ),
    .i_16       (coeff_out_data[16] ),
    .i_17       (coeff_out_data[17] ),
    .i_18       (coeff_out_data[18] ),
    .i_19       (coeff_out_data[19] ),
    .i_20       (coeff_out_data[20] ),
    .i_21       (coeff_out_data[21] ),
    .i_22       (coeff_out_data[22] ),
    .i_23       (coeff_out_data[23] ),
    .i_24       (coeff_out_data[24] ),
    .i_25       (coeff_out_data[25] ),
    .i_26       (coeff_out_data[26] ),
    .i_27       (coeff_out_data[27] ),
    .i_28       (coeff_out_data[28] ),
    .i_29       (coeff_out_data[29] ),
    .i_30       (coeff_out_data[30] ),
    .i_31       (coeff_out_data[31] ),
//output parameter
    .o_size     (serial_out_size    ),
//output data
    .o_valid    (serial_out_valid   ),
    .o_0        (serial_out_data[0 ]),
    .o_1        (serial_out_data[1 ]),
    .o_2        (serial_out_data[2 ]),
    .o_3        (serial_out_data[3 ]),
    .o_4        (serial_out_data[4 ]),
    .o_5        (serial_out_data[5 ]),
    .o_6        (serial_out_data[6 ]),
    .o_7        (serial_out_data[7 ]),
    .o_8        (serial_out_data[8 ]),
    .o_9        (serial_out_data[9 ]),
    .o_10       (serial_out_data[10]),
    .o_11       (serial_out_data[11]),
    .o_12       (serial_out_data[12]),
    .o_13       (serial_out_data[13]),
    .o_14       (serial_out_data[14]),
    .o_15       (serial_out_data[15])
);  

//delay
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin 
        calculate_out_type_d1 <= 0;
        calculate_out_type_d2 <= 0;
    end
    else begin
        calculate_out_type_d1 <= calculate_out_type;
        calculate_out_type_d2 <= calculate_out_type_d1;
    end
end

//output
    assign o_type = calculate_out_type_d2;
    assign o_size = serial_out_size;
    assign o_valid  = serial_out_valid;
    assign o_0      = serial_out_data[0 ];
    assign o_1      = serial_out_data[1 ];
    assign o_2      = serial_out_data[2 ];
    assign o_3      = serial_out_data[3 ];
    assign o_4      = serial_out_data[4 ];
    assign o_5      = serial_out_data[5 ];
    assign o_6      = serial_out_data[6 ];
    assign o_7      = serial_out_data[7 ];
    assign o_8      = serial_out_data[8 ];
    assign o_9      = serial_out_data[9 ];
    assign o_10     = serial_out_data[10];
    assign o_11     = serial_out_data[11];
    assign o_12     = serial_out_data[12];
    assign o_13     = serial_out_data[13];
    assign o_14     = serial_out_data[14];
    assign o_15     = serial_out_data[15];

endmodule
