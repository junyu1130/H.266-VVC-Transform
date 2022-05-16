module transform_top#(
    parameter  BIT_DEPTH = 9,
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
    input   signed  [BIT_DEPTH - 1 : 0] i_data      ,
//output coeff
    output                              o_valid     ,
    output  signed  [OUT_WIDTH - 1 : 0] o_coeff         
);

integer i;

localparam  DCT_4  = 0,
            DCT_8  = 1,
            DCT_16 = 2,
            DCT_32 = 3,
            DCT_64 = 4;

reg dct2_data_vaild;
reg signed [OUT_WIDTH - 1 : 0] dct2_data[63 : 0];
wire dct2_coeff_vaild;
wire signed [OUT_WIDTH - 1 : 0] dct2_coeff[63 : 0];
reg [5 : 0] count, count_max;

always @(*) begin
    case (i_width)
        DCT_4   : count_max <= 3 ;
        DCT_8   : count_max <= 7 ;
        DCT_16  : count_max <= 15;
        DCT_32  : count_max <= 31;
        DCT_64  : count_max <= 63;
        default : count_max <= 0 ;
    endcase
end

//data in
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        dct2_data_vaild <= 0;
        count <= 0;
    end
    else if (count == count_max) begin
        dct2_data_vaild <= 1;
        count <= 0;
    end
    else if (i_valid) begin
        dct2_data_vaild <= 0;
        count <= count + 1;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i = 0; i < 64; i = i + 1) begin
            dct2_data[i] <= 0;
        end
    end
    else if (i_valid) begin
        dct2_data[count] <= i_data;
    end
    else begin
        for (i = 0; i < 64; i = i + 1) begin
            dct2_data[i] <= 0;
        end
    end
end

dct2d_top#(
    .IN_WIDTH  (OUT_WIDTH ),
    .OUT_WIDTH (OUT_WIDTH )
)
u_dct2d_top(
//system input
    .clk      (clk              ),
    .rst_n    (rst_n            ),
//input parameter
    .i_width  (i_width          ),
    .i_height (i_height         ),
//input data
    .i_valid  (dct2_data_vaild  ),
    .i_0      (dct2_data[0 ]    ),
    .i_1      (dct2_data[1 ]    ),
    .i_2      (dct2_data[2 ]    ),
    .i_3      (dct2_data[3 ]    ),
    .i_4      (dct2_data[4 ]    ),
    .i_5      (dct2_data[5 ]    ),
    .i_6      (dct2_data[6 ]    ),
    .i_7      (dct2_data[7 ]    ),
    .i_8      (dct2_data[8 ]    ),
    .i_9      (dct2_data[9 ]    ),
    .i_10     (dct2_data[10]    ),
    .i_11     (dct2_data[11]    ),
    .i_12     (dct2_data[12]    ),
    .i_13     (dct2_data[13]    ),
    .i_14     (dct2_data[14]    ),
    .i_15     (dct2_data[15]    ),
    .i_16     (dct2_data[16]    ),
    .i_17     (dct2_data[17]    ),
    .i_18     (dct2_data[18]    ),
    .i_19     (dct2_data[19]    ),
    .i_20     (dct2_data[20]    ),
    .i_21     (dct2_data[21]    ),
    .i_22     (dct2_data[22]    ),
    .i_23     (dct2_data[23]    ),
    .i_24     (dct2_data[24]    ),
    .i_25     (dct2_data[25]    ),
    .i_26     (dct2_data[26]    ),
    .i_27     (dct2_data[27]    ),
    .i_28     (dct2_data[28]    ),
    .i_29     (dct2_data[29]    ),
    .i_30     (dct2_data[30]    ),
    .i_31     (dct2_data[31]    ),
    .i_32     (dct2_data[32]    ),
    .i_33     (dct2_data[33]    ),
    .i_34     (dct2_data[34]    ),
    .i_35     (dct2_data[35]    ),
    .i_36     (dct2_data[36]    ),
    .i_37     (dct2_data[37]    ),
    .i_38     (dct2_data[38]    ),
    .i_39     (dct2_data[39]    ),
    .i_40     (dct2_data[40]    ),
    .i_41     (dct2_data[41]    ),
    .i_42     (dct2_data[42]    ),
    .i_43     (dct2_data[43]    ),
    .i_44     (dct2_data[44]    ),
    .i_45     (dct2_data[45]    ),
    .i_46     (dct2_data[46]    ),
    .i_47     (dct2_data[47]    ),
    .i_48     (dct2_data[48]    ),
    .i_49     (dct2_data[49]    ),
    .i_50     (dct2_data[50]    ),
    .i_51     (dct2_data[51]    ),
    .i_52     (dct2_data[52]    ),
    .i_53     (dct2_data[53]    ),
    .i_54     (dct2_data[54]    ),
    .i_55     (dct2_data[55]    ),
    .i_56     (dct2_data[56]    ),
    .i_57     (dct2_data[57]    ),
    .i_58     (dct2_data[58]    ),
    .i_59     (dct2_data[59]    ),
    .i_60     (dct2_data[60]    ),
    .i_61     (dct2_data[61]    ),
    .i_62     (dct2_data[62]    ),
    .i_63     (dct2_data[63]    ),
//output coeff
    .o_valid  (dct2_coeff_vaild ),
    .o_0      (dct2_coeff[0 ]   ),
    .o_1      (dct2_coeff[1 ]   ),
    .o_2      (dct2_coeff[2 ]   ),
    .o_3      (dct2_coeff[3 ]   ),
    .o_4      (dct2_coeff[4 ]   ),
    .o_5      (dct2_coeff[5 ]   ),
    .o_6      (dct2_coeff[6 ]   ),
    .o_7      (dct2_coeff[7 ]   ),
    .o_8      (dct2_coeff[8 ]   ),
    .o_9      (dct2_coeff[9 ]   ),
    .o_10     (dct2_coeff[10]   ),
    .o_11     (dct2_coeff[11]   ),
    .o_12     (dct2_coeff[12]   ),
    .o_13     (dct2_coeff[13]   ),
    .o_14     (dct2_coeff[14]   ),
    .o_15     (dct2_coeff[15]   ),
    .o_16     (dct2_coeff[16]   ),
    .o_17     (dct2_coeff[17]   ),
    .o_18     (dct2_coeff[18]   ),
    .o_19     (dct2_coeff[19]   ),
    .o_20     (dct2_coeff[20]   ),
    .o_21     (dct2_coeff[21]   ),
    .o_22     (dct2_coeff[22]   ),
    .o_23     (dct2_coeff[23]   ),
    .o_24     (dct2_coeff[24]   ),
    .o_25     (dct2_coeff[25]   ),
    .o_26     (dct2_coeff[26]   ),
    .o_27     (dct2_coeff[27]   ),
    .o_28     (dct2_coeff[28]   ),
    .o_29     (dct2_coeff[29]   ),
    .o_30     (dct2_coeff[30]   ),
    .o_31     (dct2_coeff[31]   ),
    .o_32     (dct2_coeff[32]   ),
    .o_33     (dct2_coeff[33]   ),
    .o_34     (dct2_coeff[34]   ),
    .o_35     (dct2_coeff[35]   ),
    .o_36     (dct2_coeff[36]   ),
    .o_37     (dct2_coeff[37]   ),
    .o_38     (dct2_coeff[38]   ),
    .o_39     (dct2_coeff[39]   ),
    .o_40     (dct2_coeff[40]   ),
    .o_41     (dct2_coeff[41]   ),
    .o_42     (dct2_coeff[42]   ),
    .o_43     (dct2_coeff[43]   ),
    .o_44     (dct2_coeff[44]   ),
    .o_45     (dct2_coeff[45]   ),
    .o_46     (dct2_coeff[46]   ),
    .o_47     (dct2_coeff[47]   ),
    .o_48     (dct2_coeff[48]   ),
    .o_49     (dct2_coeff[49]   ),
    .o_50     (dct2_coeff[50]   ),
    .o_51     (dct2_coeff[51]   ),
    .o_52     (dct2_coeff[52]   ),
    .o_53     (dct2_coeff[53]   ),
    .o_54     (dct2_coeff[54]   ),
    .o_55     (dct2_coeff[55]   ),
    .o_56     (dct2_coeff[56]   ),
    .o_57     (dct2_coeff[57]   ),
    .o_58     (dct2_coeff[58]   ),
    .o_59     (dct2_coeff[59]   ),
    .o_60     (dct2_coeff[60]   ),
    .o_61     (dct2_coeff[61]   ),
    .o_62     (dct2_coeff[62]   ),
    .o_63     (dct2_coeff[63]   )
);

//output
assign o_valid = dct2_coeff_vaild;
assign o_coeff = dct2_coeff[0];

endmodule
