//describe  : 一维DST7/SCT8，正序输入DST7，倒序输入DCT8(奇数行输出反号)
//input     : 32个像素残差/一维变换系数
//output    : 32个一维变换系数/二维变换系数
//delay     : 4 clk
module dst7_dct8_1d#(
    parameter  IN_WIDTH  = 16,
    parameter  OUT_WIDTH = 27
)
(
//system input
    input                               clk     ,
    input                               rst_n   ,
//input parameter
    input           [2 : 0]             i_size ,//1:4x4, 2:8x8, 3:16x16, 4:32x32
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
//output parameter
    output          [2 : 0]             o_size  ,
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
    output  signed  [OUT_WIDTH - 1 : 0] o_31    
);

localparam  SIZE4  = 3'd1,
            SIZE8  = 3'd2,
            SIZE16 = 3'd3,
            SIZE32 = 3'd4;
integer i;

//input
    reg i_valid_d1, i_valid_d2;
    wire signed [IN_WIDTH - 1 : 0] i_data[0 : 31];
    reg signed [IN_WIDTH - 1 : 0] i_data_d1[0 : 31], i_data_d2[0 : 31];
    reg [2 : 0] i_size_d[0 : 3];
//size mux in
    reg tr_in_32_valid, tr_in_16_valid, tr_in_8_valid, tr_in_4_valid;  
    reg  signed [IN_WIDTH - 1 : 0] tr_in_32_u0[0 : 31];
    reg  signed [IN_WIDTH - 1 : 0] tr_in_16_u0[0 : 15], tr_in_16_u1[0 : 15];
    reg  signed [IN_WIDTH - 1 : 0] tr_in_8_u0[0 : 7], tr_in_8_u1[0 : 7], tr_in_8_u2[0 : 7], tr_in_8_u3[0 : 7];
    reg  signed [IN_WIDTH - 1 : 0] tr_in_4_u0[0 : 3], tr_in_4_u1[0 : 3], tr_in_4_u2[0 : 3], tr_in_4_u3[0 : 3],
                                   tr_in_4_u4[0 : 3], tr_in_4_u5[0 : 3], tr_in_4_u6[0 : 3], tr_in_4_u7[0 : 3];
//calculate
    wire pre_coeff_32_valid, pre_coeff_16_valid, pre_coeff_8_valid, pre_coeff_4_valid;
    wire signed [IN_WIDTH + 10 : 0] pre_coeff_32_u0[0 : 15];
    wire signed [IN_WIDTH +  9 : 0] pre_coeff_16_u0[0 : 15], pre_coeff_16_u1[0 : 15];
    wire signed [IN_WIDTH +  8 : 0] pre_coeff_8_u0[0 : 7], pre_coeff_8_u1[0 : 7], pre_coeff_8_u2[0 : 7], pre_coeff_8_u3[0 : 7];
    wire signed [IN_WIDTH +  7 : 0] pre_coeff_4_u0[0 : 3], pre_coeff_4_u1[0 : 3], pre_coeff_4_u2[0 : 3], pre_coeff_4_u3[0 : 3],
                                    pre_coeff_4_u4[0 : 3], pre_coeff_4_u5[0 : 3], pre_coeff_4_u6[0 : 3], pre_coeff_4_u7[0 : 3];
//size mux out
    reg pre_coeff_valid;
    reg signed [OUT_WIDTH - 1 : 0] pre_coeff[0 : 31];

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

//parameter delay
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin 
        for (i = 0; i < 4; i = i + 1) begin
            i_size_d[i] <= 0;
        end
    end
    else begin
        i_size_d[0] <= i_size;
        for (i = 0; i < 3; i = i + 1) begin
            i_size_d[i + 1] <= i_size_d[i];
        end
    end
end

//input delay
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d1 <= 0; 
        i_valid_d2 <= 0;  
        for (i = 0; i < 32; i = i + 1) begin
            i_data_d1[i] <= 0; 
            i_data_d2[i] <= 0; 
        end
    end
    else begin
        i_valid_d1 <= i_valid; 
        i_valid_d2 <= i_valid_d1; 
        for (i = 0; i < 32; i = i + 1) begin
            i_data_d1[i] <= i_data[i]; 
            i_data_d2[i] <= i_data_d1[i];
        end
    end
end

//size mux in
always @(*) begin
    tr_in_32_valid <= 0;
    tr_in_16_valid <= 0;
    tr_in_8_valid  <= 0;
    tr_in_4_valid  <= 0;
    for (i = 0; i < 32; i = i + 1) begin
        tr_in_32_u0[i] <= 0;
    end
    for (i = 0; i < 16; i = i + 1) begin
        tr_in_16_u0[i] <= 0; tr_in_16_u1[i] <= 0;
    end
    for (i = 0; i < 8; i = i + 1) begin
        tr_in_8_u0[i] <= 0; tr_in_8_u1[i] <= 0; tr_in_8_u2[i] <= 0; tr_in_8_u3[i] <= 0;
    end
    for (i = 0; i < 4; i = i + 1) begin
        tr_in_4_u0[i] <= 0; tr_in_4_u1[i] <= 0; tr_in_4_u2[i] <= 0; tr_in_4_u3[i] <= 0;
        tr_in_4_u4[i] <= 0; tr_in_4_u5[i] <= 0; tr_in_4_u6[i] <= 0; tr_in_4_u7[i] <= 0;
    end
    //delay 1 clk
    case (i_size_d[0]) 
        SIZE32 : begin
            tr_in_32_valid <= i_valid_d1;
            for (i = 0; i < 32; i = i + 1) begin
                tr_in_32_u0[i] <= i_data_d1[i];
            end
        end
    endcase
    //delay 1 clk
    case (i_size_d[0]) 
        SIZE16 : begin
            tr_in_16_valid <= i_valid_d1;
            for (i = 0; i < 16; i = i + 1) begin
                tr_in_16_u0[i] <= i_data_d1[i];
                tr_in_16_u1[i] <= i_data_d1[i + 16];
            end
        end
    endcase
    //delay 2 clk
    case (i_size_d[1]) 
        SIZE8 : begin
            tr_in_8_valid <= i_valid_d2;
            for (i = 0; i < 8; i = i + 1) begin
                tr_in_8_u0[i] <= i_data_d2[i];
                tr_in_8_u1[i] <= i_data_d2[i + 8];
                tr_in_8_u2[i] <= i_data_d2[i + 16];
                tr_in_8_u3[i] <= i_data_d2[i + 24];
            end
        end
    endcase
    //delay 2 clk
    case (i_size_d[1]) 
        SIZE4 : begin
            tr_in_4_valid <= i_valid_d2;
            for (i = 0; i < 4; i = i + 1) begin
                tr_in_4_u0[i] <= i_data_d2[i];
                tr_in_4_u1[i] <= i_data_d2[i + 4];
                tr_in_4_u2[i] <= i_data_d2[i + 8];
                tr_in_4_u3[i] <= i_data_d2[i + 12];
                tr_in_4_u4[i] <= i_data_d2[i + 16];
                tr_in_4_u5[i] <= i_data_d2[i + 20];
                tr_in_4_u6[i] <= i_data_d2[i + 24];
                tr_in_4_u7[i] <= i_data_d2[i + 28];
            end
        end
    endcase
end

//32x32
dst7_dct8_1d_32#(
    .IN_WIDTH   (IN_WIDTH)
)
u0_dst7_dct8_1d_32(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
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
    .o_0    (pre_coeff_32_u0[0 ]),
    .o_1    (pre_coeff_32_u0[1 ]),
    .o_2    (pre_coeff_32_u0[2 ]),
    .o_3    (pre_coeff_32_u0[3 ]),
    .o_4    (pre_coeff_32_u0[4 ]),
    .o_5    (pre_coeff_32_u0[5 ]),
    .o_6    (pre_coeff_32_u0[6 ]),
    .o_7    (pre_coeff_32_u0[7 ]),
    .o_8    (pre_coeff_32_u0[8 ]),
    .o_9    (pre_coeff_32_u0[9 ]),
    .o_10   (pre_coeff_32_u0[10]),
    .o_11   (pre_coeff_32_u0[11]),
    .o_12   (pre_coeff_32_u0[12]),
    .o_13   (pre_coeff_32_u0[13]),
    .o_14   (pre_coeff_32_u0[14]),
    .o_15   (pre_coeff_32_u0[15])
);

//16x16
dst7_dct8_1d_16#(
    .IN_WIDTH   (IN_WIDTH)
)
u0_dst7_dct8_1d_16(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
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
    .o_0    (pre_coeff_16_u0[0 ]),
    .o_1    (pre_coeff_16_u0[1 ]),
    .o_2    (pre_coeff_16_u0[2 ]),
    .o_3    (pre_coeff_16_u0[3 ]),
    .o_4    (pre_coeff_16_u0[4 ]),
    .o_5    (pre_coeff_16_u0[5 ]),
    .o_6    (pre_coeff_16_u0[6 ]),
    .o_7    (pre_coeff_16_u0[7 ]),
    .o_8    (pre_coeff_16_u0[8 ]),
    .o_9    (pre_coeff_16_u0[9 ]),
    .o_10   (pre_coeff_16_u0[10]),
    .o_11   (pre_coeff_16_u0[11]),
    .o_12   (pre_coeff_16_u0[12]),
    .o_13   (pre_coeff_16_u0[13]),
    .o_14   (pre_coeff_16_u0[14]),
    .o_15   (pre_coeff_16_u0[15])
);
dst7_dct8_1d_16#(
    .IN_WIDTH   (IN_WIDTH)
)
u1_dst7_dct8_1d_16(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input data
    .i_valid(tr_in_16_valid     ),
    .i_0    (tr_in_16_u1[0 ]    ),
    .i_1    (tr_in_16_u1[1 ]    ),
    .i_2    (tr_in_16_u1[2 ]    ),
    .i_3    (tr_in_16_u1[3 ]    ),
    .i_4    (tr_in_16_u1[4 ]    ),
    .i_5    (tr_in_16_u1[5 ]    ),
    .i_6    (tr_in_16_u1[6 ]    ),
    .i_7    (tr_in_16_u1[7 ]    ),
    .i_8    (tr_in_16_u1[8 ]    ),
    .i_9    (tr_in_16_u1[9 ]    ),
    .i_10   (tr_in_16_u1[10]    ),
    .i_11   (tr_in_16_u1[11]    ),
    .i_12   (tr_in_16_u1[12]    ),
    .i_13   (tr_in_16_u1[13]    ),
    .i_14   (tr_in_16_u1[14]    ),
    .i_15   (tr_in_16_u1[15]    ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_16_u1[0 ]),
    .o_1    (pre_coeff_16_u1[1 ]),
    .o_2    (pre_coeff_16_u1[2 ]),
    .o_3    (pre_coeff_16_u1[3 ]),
    .o_4    (pre_coeff_16_u1[4 ]),
    .o_5    (pre_coeff_16_u1[5 ]),
    .o_6    (pre_coeff_16_u1[6 ]),
    .o_7    (pre_coeff_16_u1[7 ]),
    .o_8    (pre_coeff_16_u1[8 ]),
    .o_9    (pre_coeff_16_u1[9 ]),
    .o_10   (pre_coeff_16_u1[10]),
    .o_11   (pre_coeff_16_u1[11]),
    .o_12   (pre_coeff_16_u1[12]),
    .o_13   (pre_coeff_16_u1[13]),
    .o_14   (pre_coeff_16_u1[14]),
    .o_15   (pre_coeff_16_u1[15])
);

//8x8
dst7_dct8_1d_8#(
    .IN_WIDTH   (IN_WIDTH)
)
u0_dst7_dct8_1d_8(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
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
    .o_0    (pre_coeff_8_u0[0 ] ),
    .o_1    (pre_coeff_8_u0[1 ] ),
    .o_2    (pre_coeff_8_u0[2 ] ),
    .o_3    (pre_coeff_8_u0[3 ] ),
    .o_4    (pre_coeff_8_u0[4 ] ),
    .o_5    (pre_coeff_8_u0[5 ] ),
    .o_6    (pre_coeff_8_u0[6 ] ),
    .o_7    (pre_coeff_8_u0[7 ] )
);
dst7_dct8_1d_8#(
    .IN_WIDTH   (IN_WIDTH)
)
u1_dst7_dct8_1d_8(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
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
    .o_0    (pre_coeff_8_u1[0 ] ),
    .o_1    (pre_coeff_8_u1[1 ] ),
    .o_2    (pre_coeff_8_u1[2 ] ),
    .o_3    (pre_coeff_8_u1[3 ] ),
    .o_4    (pre_coeff_8_u1[4 ] ),
    .o_5    (pre_coeff_8_u1[5 ] ),
    .o_6    (pre_coeff_8_u1[6 ] ),
    .o_7    (pre_coeff_8_u1[7 ] )
);
dst7_dct8_1d_8#(
    .IN_WIDTH   (IN_WIDTH)
)
u2_dst7_dct8_1d_8(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input data
    .i_valid(tr_in_8_valid      ),
    .i_0    (tr_in_8_u2[0 ]     ),
    .i_1    (tr_in_8_u2[1 ]     ),
    .i_2    (tr_in_8_u2[2 ]     ),
    .i_3    (tr_in_8_u2[3 ]     ),
    .i_4    (tr_in_8_u2[4 ]     ),
    .i_5    (tr_in_8_u2[5 ]     ),
    .i_6    (tr_in_8_u2[6 ]     ),
    .i_7    (tr_in_8_u2[7 ]     ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_8_u2[0 ] ),
    .o_1    (pre_coeff_8_u2[1 ] ),
    .o_2    (pre_coeff_8_u2[2 ] ),
    .o_3    (pre_coeff_8_u2[3 ] ),
    .o_4    (pre_coeff_8_u2[4 ] ),
    .o_5    (pre_coeff_8_u2[5 ] ),
    .o_6    (pre_coeff_8_u2[6 ] ),
    .o_7    (pre_coeff_8_u2[7 ] )
);
dst7_dct8_1d_8#(
    .IN_WIDTH   (IN_WIDTH)
)
u3_dst7_dct8_1d_8(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input data
    .i_valid(tr_in_8_valid      ),
    .i_0    (tr_in_8_u3[0 ]     ),
    .i_1    (tr_in_8_u3[1 ]     ),
    .i_2    (tr_in_8_u3[2 ]     ),
    .i_3    (tr_in_8_u3[3 ]     ),
    .i_4    (tr_in_8_u3[4 ]     ),
    .i_5    (tr_in_8_u3[5 ]     ),
    .i_6    (tr_in_8_u3[6 ]     ),
    .i_7    (tr_in_8_u3[7 ]     ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_8_u3[0 ] ),
    .o_1    (pre_coeff_8_u3[1 ] ),
    .o_2    (pre_coeff_8_u3[2 ] ),
    .o_3    (pre_coeff_8_u3[3 ] ),
    .o_4    (pre_coeff_8_u3[4 ] ),
    .o_5    (pre_coeff_8_u3[5 ] ),
    .o_6    (pre_coeff_8_u3[6 ] ),
    .o_7    (pre_coeff_8_u3[7 ] )
);

//4x4
dst7_dct8_1d_4#(
    .IN_WIDTH   (IN_WIDTH)
)
u0_dst7_dct8_1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
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
dst7_dct8_1d_4#(
    .IN_WIDTH   (IN_WIDTH)
)
u1_dst7_dct8_1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
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
dst7_dct8_1d_4#(
    .IN_WIDTH   (IN_WIDTH)
)
u2_dst7_dct8_1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
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
dst7_dct8_1d_4#(
    .IN_WIDTH   (IN_WIDTH)
)
u3_dst7_dct8_1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
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
dst7_dct8_1d_4#(
    .IN_WIDTH   (IN_WIDTH)
)
u4_dst7_dct8_1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input data
    .i_valid(tr_in_4_valid      ),
    .i_0    (tr_in_4_u4[0 ]     ),
    .i_1    (tr_in_4_u4[1 ]     ),
    .i_2    (tr_in_4_u4[2 ]     ),
    .i_3    (tr_in_4_u4[3 ]     ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u4[0 ] ),
    .o_1    (pre_coeff_4_u4[1 ] ),
    .o_2    (pre_coeff_4_u4[2 ] ),
    .o_3    (pre_coeff_4_u4[3 ] )
);
dst7_dct8_1d_4#(
    .IN_WIDTH   (IN_WIDTH)
)
u5_dst7_dct8_1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input data
    .i_valid(tr_in_4_valid      ),
    .i_0    (tr_in_4_u5[0 ]     ),
    .i_1    (tr_in_4_u5[1 ]     ),
    .i_2    (tr_in_4_u5[2 ]     ),
    .i_3    (tr_in_4_u5[3 ]     ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u5[0 ] ),
    .o_1    (pre_coeff_4_u5[1 ] ),
    .o_2    (pre_coeff_4_u5[2 ] ),
    .o_3    (pre_coeff_4_u5[3 ] )
);
dst7_dct8_1d_4#(
    .IN_WIDTH   (IN_WIDTH)
)
u6_dst7_dct8_1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input data
    .i_valid(tr_in_4_valid      ),
    .i_0    (tr_in_4_u6[0 ]     ),
    .i_1    (tr_in_4_u6[1 ]     ),
    .i_2    (tr_in_4_u6[2 ]     ),
    .i_3    (tr_in_4_u6[3 ]     ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u6[0 ] ),
    .o_1    (pre_coeff_4_u6[1 ] ),
    .o_2    (pre_coeff_4_u6[2 ] ),
    .o_3    (pre_coeff_4_u6[3 ] )
);
dst7_dct8_1d_4#(
    .IN_WIDTH   (IN_WIDTH)
)
u7_dst7_dct8_1d_4(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input data
    .i_valid(tr_in_4_valid      ),
    .i_0    (tr_in_4_u7[0 ]     ),
    .i_1    (tr_in_4_u7[1 ]     ),
    .i_2    (tr_in_4_u7[2 ]     ),
    .i_3    (tr_in_4_u7[3 ]     ),
//output data
    .o_valid(),
    .o_0    (pre_coeff_4_u7[0 ] ),
    .o_1    (pre_coeff_4_u7[1 ] ),
    .o_2    (pre_coeff_4_u7[2 ] ),
    .o_3    (pre_coeff_4_u7[3 ] )
);

//size mux out
always @(*) begin
    pre_coeff_valid <= 0;
    for (i = 0; i < 32; i = i + 1) begin
        pre_coeff[i] <= 0;
    end
    case (i_size_d[3])
        SIZE32  : begin //high frequency coefficients are set to zero
            pre_coeff_valid <= pre_coeff_32_valid;
            for (i = 0; i < 16; i = i + 1) begin
                pre_coeff[i] <= pre_coeff_32_u0[i];
                pre_coeff[i + 16] <= 0;
            end
        end
        SIZE16  : begin
            pre_coeff_valid <= pre_coeff_16_valid;
            for (i = 0; i < 16; i = i + 1) begin
                pre_coeff[i] <= pre_coeff_16_u0[i];
                pre_coeff[i + 16] <= pre_coeff_16_u1[i];
            end
        end
        SIZE8   : begin
            pre_coeff_valid <= pre_coeff_8_valid;
            for (i = 0; i < 8; i = i + 1) begin
                pre_coeff[i] <= pre_coeff_8_u0[i];
                pre_coeff[8 + i] <= pre_coeff_8_u1[i];
                pre_coeff[16 + i] <= pre_coeff_8_u2[i];
                pre_coeff[24 + i] <= pre_coeff_8_u3[i];
            end
        end
        SIZE4   : begin
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
            end
        end
    endcase
end

//output
    assign o_size   = i_size_d[3]    ;
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
