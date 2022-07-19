//describe  : 二维DCT2
//input     : 16个像素残差数据
//output    : 16个系数数据
//delay     :  clk = 1in + 4serial + 7dct + 1parallel + transpose + 4serial + 7dct + 1parallel
module dct2d_top#(
    parameter  BIT_DEPTH = 8,
    parameter  OUT_WIDTH = 16
)
(
//system input
    input                               clk         ,
    input                               rst_n       ,
//input parameter
    input           [2 : 0]             i_width     ,//1st 1:DCT_4, 2:DCT_8, 3:DCT_16, 4:DCT_32, 5:DCT_64
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
//output parameter
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
    output  signed  [OUT_WIDTH - 1 : 0] o_15        
);

integer i;

//input
    wire [BIT_DEPTH : 0] i_data[0 : 15];
    reg [2 : 0] i_width_d1, i_height_d1;
    reg i_valid_d1;
    reg [BIT_DEPTH : 0] i_data_d1[0 : 15];
//1D-DCT first stage
    wire [2 : 0] dct1d_in_width, dct1d_in_height;
    wire dct1d_in_valid;
    wire signed [BIT_DEPTH : 0] dct1d_in[0 : 63];
    wire [2 : 0] dct1d_out_width, dct1d_out_height;
    wire dct1d_out_valid;
    wire signed [OUT_WIDTH - 1 : 0] dct1d_out[0 : 31];
//transpose memory
    wire [2 : 0] transpose_in_width, transpose_in_height;
    wire transpose_in_valid;
    wire signed [OUT_WIDTH - 1 : 0] transpose_in[0 : 15];
    wire [2 : 0] transpose_out_width, transpose_out_height;
    wire transpose_out_valid;
    wire signed [OUT_WIDTH - 1 : 0] transpose_out[0 : 15];
//1D-DCT second stage
    wire [2 : 0] dct2d_in_width, dct2d_in_height;
    wire dct2d_in_valid;
    wire signed [OUT_WIDTH - 1 : 0] dct2d_in[0 : 63];
    wire [2 : 0] dct2d_out_width, dct2d_out_height;
    wire dct2d_out_valid;
    wire signed [OUT_WIDTH - 1 : 0] dct2d_out[0 : 31];
//output 
    wire [2 : 0] o_data_width, o_data_height;
    wire o_data_valid;
    wire signed [OUT_WIDTH - 1 : 0] o_data[0 : 15];

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

//input delay 1 clk
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_width_d1 <= 0; 
        i_height_d1 <= 0;
        i_valid_d1 <= 0;
        for (i = 0; i < 16; i = i + 1) begin
            i_data_d1[i] <= 0;
        end
    end
    else begin
        i_width_d1 <= i_width; 
        i_height_d1 <= i_height;
        i_valid_d1 <= i_valid;
        for (i = 0; i < 16; i = i + 1) begin
            i_data_d1[i] <= i_data[i];
        end
    end
end

//sub module
//serial to parallel
serial_to_parallel#(
    .IN_WIDTH   (BIT_DEPTH + 1  ),
    .OUT_WIDTH  (BIT_DEPTH + 1  )
)
u0_serial_to_parallel(
//system input
    .clk     (clk               ),
    .rst_n   (rst_n             ),
//input parameter
    .i_width (i_width_d1        ),
    .i_height(i_height_d1       ),
//input data
    .i_valid (i_valid_d1        ),
    .i_0     (i_data_d1[0 ]     ),
    .i_1     (i_data_d1[1 ]     ),
    .i_2     (i_data_d1[2 ]     ),
    .i_3     (i_data_d1[3 ]     ),
    .i_4     (i_data_d1[4 ]     ),
    .i_5     (i_data_d1[5 ]     ),
    .i_6     (i_data_d1[6 ]     ),
    .i_7     (i_data_d1[7 ]     ),
    .i_8     (i_data_d1[8 ]     ),
    .i_9     (i_data_d1[9 ]     ),
    .i_10    (i_data_d1[10]     ),
    .i_11    (i_data_d1[11]     ),
    .i_12    (i_data_d1[12]     ),
    .i_13    (i_data_d1[13]     ),
    .i_14    (i_data_d1[14]     ),
    .i_15    (i_data_d1[15]     ),
//output parameter
    .o_width (dct1d_in_width    ),
    .o_height(dct1d_in_height   ),
//output data
    .o_valid (dct1d_in_valid    ),
    .o_0     (dct1d_in[0 ]      ),
    .o_1     (dct1d_in[1 ]      ),
    .o_2     (dct1d_in[2 ]      ),
    .o_3     (dct1d_in[3 ]      ),
    .o_4     (dct1d_in[4 ]      ),
    .o_5     (dct1d_in[5 ]      ),
    .o_6     (dct1d_in[6 ]      ),
    .o_7     (dct1d_in[7 ]      ),
    .o_8     (dct1d_in[8 ]      ),
    .o_9     (dct1d_in[9 ]      ),
    .o_10    (dct1d_in[10]      ),
    .o_11    (dct1d_in[11]      ),
    .o_12    (dct1d_in[12]      ),
    .o_13    (dct1d_in[13]      ),
    .o_14    (dct1d_in[14]      ),
    .o_15    (dct1d_in[15]      ),
    .o_16    (dct1d_in[16]      ),
    .o_17    (dct1d_in[17]      ),
    .o_18    (dct1d_in[18]      ),
    .o_19    (dct1d_in[19]      ),
    .o_20    (dct1d_in[20]      ),
    .o_21    (dct1d_in[21]      ),
    .o_22    (dct1d_in[22]      ),
    .o_23    (dct1d_in[23]      ),
    .o_24    (dct1d_in[24]      ),
    .o_25    (dct1d_in[25]      ),
    .o_26    (dct1d_in[26]      ),
    .o_27    (dct1d_in[27]      ),
    .o_28    (dct1d_in[28]      ),
    .o_29    (dct1d_in[29]      ),
    .o_30    (dct1d_in[30]      ),
    .o_31    (dct1d_in[31]      ),
    .o_32    (dct1d_in[32]      ),
    .o_33    (dct1d_in[33]      ),
    .o_34    (dct1d_in[34]      ),
    .o_35    (dct1d_in[35]      ),
    .o_36    (dct1d_in[36]      ),
    .o_37    (dct1d_in[37]      ),
    .o_38    (dct1d_in[38]      ),
    .o_39    (dct1d_in[39]      ),
    .o_40    (dct1d_in[40]      ),
    .o_41    (dct1d_in[41]      ),
    .o_42    (dct1d_in[42]      ),
    .o_43    (dct1d_in[43]      ),
    .o_44    (dct1d_in[44]      ),
    .o_45    (dct1d_in[45]      ),
    .o_46    (dct1d_in[46]      ),
    .o_47    (dct1d_in[47]      ),
    .o_48    (dct1d_in[48]      ),
    .o_49    (dct1d_in[49]      ),
    .o_50    (dct1d_in[50]      ),
    .o_51    (dct1d_in[51]      ),
    .o_52    (dct1d_in[52]      ),
    .o_53    (dct1d_in[53]      ),
    .o_54    (dct1d_in[54]      ),
    .o_55    (dct1d_in[55]      ),
    .o_56    (dct1d_in[56]      ),
    .o_57    (dct1d_in[57]      ),
    .o_58    (dct1d_in[58]      ),
    .o_59    (dct1d_in[59]      ),
    .o_60    (dct1d_in[60]      ),
    .o_61    (dct1d_in[61]      ),
    .o_62    (dct1d_in[62]      ),
    .o_63    (dct1d_in[63]      )
);   

//first stage 1D-DCT
dct1d_1st#(
    .IN_WIDTH   (BIT_DEPTH + 1  ),
    .OUT_WIDTH  (OUT_WIDTH      )
)
u_dct1d_1st(
//system input
    .clk     (clk               ),
    .rst_n   (rst_n             ),
//input parameter
    .i_width (dct1d_in_width    ),
    .i_height(dct1d_in_height   ),
//input data
    .i_valid (dct1d_in_valid    ),
    .i_0     (dct1d_in[0 ]      ),
    .i_1     (dct1d_in[1 ]      ),
    .i_2     (dct1d_in[2 ]      ),
    .i_3     (dct1d_in[3 ]      ),
    .i_4     (dct1d_in[4 ]      ),
    .i_5     (dct1d_in[5 ]      ),
    .i_6     (dct1d_in[6 ]      ),
    .i_7     (dct1d_in[7 ]      ),
    .i_8     (dct1d_in[8 ]      ),
    .i_9     (dct1d_in[9 ]      ),
    .i_10    (dct1d_in[10]      ),
    .i_11    (dct1d_in[11]      ),
    .i_12    (dct1d_in[12]      ),
    .i_13    (dct1d_in[13]      ),
    .i_14    (dct1d_in[14]      ),
    .i_15    (dct1d_in[15]      ),
    .i_16    (dct1d_in[16]      ),
    .i_17    (dct1d_in[17]      ),
    .i_18    (dct1d_in[18]      ),
    .i_19    (dct1d_in[19]      ),
    .i_20    (dct1d_in[20]      ),
    .i_21    (dct1d_in[21]      ),
    .i_22    (dct1d_in[22]      ),
    .i_23    (dct1d_in[23]      ),
    .i_24    (dct1d_in[24]      ),
    .i_25    (dct1d_in[25]      ),
    .i_26    (dct1d_in[26]      ),
    .i_27    (dct1d_in[27]      ),
    .i_28    (dct1d_in[28]      ),
    .i_29    (dct1d_in[29]      ),
    .i_30    (dct1d_in[30]      ),
    .i_31    (dct1d_in[31]      ),
    .i_32    (dct1d_in[32]      ),
    .i_33    (dct1d_in[33]      ),
    .i_34    (dct1d_in[34]      ),
    .i_35    (dct1d_in[35]      ),
    .i_36    (dct1d_in[36]      ),
    .i_37    (dct1d_in[37]      ),
    .i_38    (dct1d_in[38]      ),
    .i_39    (dct1d_in[39]      ),
    .i_40    (dct1d_in[40]      ),
    .i_41    (dct1d_in[41]      ),
    .i_42    (dct1d_in[42]      ),
    .i_43    (dct1d_in[43]      ),
    .i_44    (dct1d_in[44]      ),
    .i_45    (dct1d_in[45]      ),
    .i_46    (dct1d_in[46]      ),
    .i_47    (dct1d_in[47]      ),
    .i_48    (dct1d_in[48]      ),
    .i_49    (dct1d_in[49]      ),
    .i_50    (dct1d_in[50]      ),
    .i_51    (dct1d_in[51]      ),
    .i_52    (dct1d_in[52]      ),
    .i_53    (dct1d_in[53]      ),
    .i_54    (dct1d_in[54]      ),
    .i_55    (dct1d_in[55]      ),
    .i_56    (dct1d_in[56]      ),
    .i_57    (dct1d_in[57]      ),
    .i_58    (dct1d_in[58]      ),
    .i_59    (dct1d_in[59]      ),
    .i_60    (dct1d_in[60]      ),
    .i_61    (dct1d_in[61]      ),
    .i_62    (dct1d_in[62]      ),
    .i_63    (dct1d_in[63]      ),
//output parameter
    .o_width (dct1d_out_width   ),
    .o_height(dct1d_out_height  ),
//output 1st stage's coeff
    .o_valid (dct1d_out_valid   ),
    .o_0     (dct1d_out[0 ]     ),
    .o_1     (dct1d_out[1 ]     ),
    .o_2     (dct1d_out[2 ]     ),
    .o_3     (dct1d_out[3 ]     ),
    .o_4     (dct1d_out[4 ]     ),
    .o_5     (dct1d_out[5 ]     ),
    .o_6     (dct1d_out[6 ]     ),
    .o_7     (dct1d_out[7 ]     ),
    .o_8     (dct1d_out[8 ]     ),
    .o_9     (dct1d_out[9 ]     ),
    .o_10    (dct1d_out[10]     ),
    .o_11    (dct1d_out[11]     ),
    .o_12    (dct1d_out[12]     ),
    .o_13    (dct1d_out[13]     ),
    .o_14    (dct1d_out[14]     ),
    .o_15    (dct1d_out[15]     ),
    .o_16    (dct1d_out[16]     ),
    .o_17    (dct1d_out[17]     ),
    .o_18    (dct1d_out[18]     ),
    .o_19    (dct1d_out[19]     ),
    .o_20    (dct1d_out[20]     ),
    .o_21    (dct1d_out[21]     ),
    .o_22    (dct1d_out[22]     ),
    .o_23    (dct1d_out[23]     ),
    .o_24    (dct1d_out[24]     ),
    .o_25    (dct1d_out[25]     ),
    .o_26    (dct1d_out[26]     ),
    .o_27    (dct1d_out[27]     ),
    .o_28    (dct1d_out[28]     ),
    .o_29    (dct1d_out[29]     ),
    .o_30    (dct1d_out[30]     ),
    .o_31    (dct1d_out[31]     )
); 

//parallel to serial
parallel_to_serial#(
    .IN_WIDTH   (OUT_WIDTH          ),
    .OUT_WIDTH  (OUT_WIDTH          )
)
u_parallel_to_serial(
//system input
    .clk     (clk                   ),
    .rst_n   (rst_n                 ),
//input parameter
    .i_width (dct1d_out_width       ),
    .i_height(dct1d_out_height      ),
//input data
    .i_valid (dct1d_out_valid       ),
    .i_0     (dct1d_out[0 ]         ),
    .i_1     (dct1d_out[1 ]         ),
    .i_2     (dct1d_out[2 ]         ),
    .i_3     (dct1d_out[3 ]         ),
    .i_4     (dct1d_out[4 ]         ),
    .i_5     (dct1d_out[5 ]         ),
    .i_6     (dct1d_out[6 ]         ),
    .i_7     (dct1d_out[7 ]         ),
    .i_8     (dct1d_out[8 ]         ),
    .i_9     (dct1d_out[9 ]         ),
    .i_10    (dct1d_out[10]         ),
    .i_11    (dct1d_out[11]         ),
    .i_12    (dct1d_out[12]         ),
    .i_13    (dct1d_out[13]         ),
    .i_14    (dct1d_out[14]         ),
    .i_15    (dct1d_out[15]         ),
    .i_16    (dct1d_out[16]         ),
    .i_17    (dct1d_out[17]         ),
    .i_18    (dct1d_out[18]         ),
    .i_19    (dct1d_out[19]         ),
    .i_20    (dct1d_out[20]         ),
    .i_21    (dct1d_out[21]         ),
    .i_22    (dct1d_out[22]         ),
    .i_23    (dct1d_out[23]         ),
    .i_24    (dct1d_out[24]         ),
    .i_25    (dct1d_out[25]         ),
    .i_26    (dct1d_out[26]         ),
    .i_27    (dct1d_out[27]         ),
    .i_28    (dct1d_out[28]         ),
    .i_29    (dct1d_out[29]         ),
    .i_30    (dct1d_out[30]         ),
    .i_31    (dct1d_out[31]         ),
//output parameter
    .o_width (transpose_in_width    ),
    .o_height(transpose_in_height   ),
//output data
    .o_valid (transpose_in_valid    ),
    .o_0     (transpose_in[0 ]      ),
    .o_1     (transpose_in[1 ]      ),
    .o_2     (transpose_in[2 ]      ),
    .o_3     (transpose_in[3 ]      ),
    .o_4     (transpose_in[4 ]      ),
    .o_5     (transpose_in[5 ]      ),
    .o_6     (transpose_in[6 ]      ),
    .o_7     (transpose_in[7 ]      ),
    .o_8     (transpose_in[8 ]      ),
    .o_9     (transpose_in[9 ]      ),
    .o_10    (transpose_in[10]      ),
    .o_11    (transpose_in[11]      ),
    .o_12    (transpose_in[12]      ),
    .o_13    (transpose_in[13]      ),
    .o_14    (transpose_in[14]      ),
    .o_15    (transpose_in[15]      )
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
    .i_width (transpose_in_width    ),
    .i_height(transpose_in_height   ),
//1st stage's coeff
    .i_valid (transpose_in_valid    ),
    .i_0     (transpose_in[0 ]      ),
    .i_1     (transpose_in[1 ]      ),
    .i_2     (transpose_in[2 ]      ),
    .i_3     (transpose_in[3 ]      ),
    .i_4     (transpose_in[4 ]      ),
    .i_5     (transpose_in[5 ]      ),
    .i_6     (transpose_in[6 ]      ),
    .i_7     (transpose_in[7 ]      ),
    .i_8     (transpose_in[8 ]      ),
    .i_9     (transpose_in[9 ]      ),
    .i_10    (transpose_in[10]      ),
    .i_11    (transpose_in[11]      ),
    .i_12    (transpose_in[12]      ),
    .i_13    (transpose_in[13]      ),
    .i_14    (transpose_in[14]      ),
    .i_15    (transpose_in[15]      ),
//output parameter
    .o_width (transpose_out_width   ),
    .o_height(transpose_out_height  ),
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
    .o_15    (transpose_out[15]     )
);

//serial to parallel
serial_to_parallel#(
    .IN_WIDTH   (OUT_WIDTH          ),
    .OUT_WIDTH  (OUT_WIDTH          )
)
u1_serial_to_parallel(
//system input
    .clk     (clk                   ),
    .rst_n   (rst_n                 ),
//input parameter
    .i_width (transpose_out_width   ),
    .i_height(transpose_out_height  ),
//input data
    .i_valid (transpose_out_valid   ),
    .i_0     (transpose_out[0 ]     ),
    .i_1     (transpose_out[1 ]     ),
    .i_2     (transpose_out[2 ]     ),
    .i_3     (transpose_out[3 ]     ),
    .i_4     (transpose_out[4 ]     ),
    .i_5     (transpose_out[5 ]     ),
    .i_6     (transpose_out[6 ]     ),
    .i_7     (transpose_out[7 ]     ),
    .i_8     (transpose_out[8 ]     ),
    .i_9     (transpose_out[9 ]     ),
    .i_10    (transpose_out[10]     ),
    .i_11    (transpose_out[11]     ),
    .i_12    (transpose_out[12]     ),
    .i_13    (transpose_out[13]     ),
    .i_14    (transpose_out[14]     ),
    .i_15    (transpose_out[15]     ),
//output parameter
    .o_width (dct2d_in_width        ),
    .o_height(dct2d_in_height       ),
//output data
    .o_valid (dct2d_in_valid        ),
    .o_0     (dct2d_in[0 ]          ),
    .o_1     (dct2d_in[1 ]          ),
    .o_2     (dct2d_in[2 ]          ),
    .o_3     (dct2d_in[3 ]          ),
    .o_4     (dct2d_in[4 ]          ),
    .o_5     (dct2d_in[5 ]          ),
    .o_6     (dct2d_in[6 ]          ),
    .o_7     (dct2d_in[7 ]          ),
    .o_8     (dct2d_in[8 ]          ),
    .o_9     (dct2d_in[9 ]          ),
    .o_10    (dct2d_in[10]          ),
    .o_11    (dct2d_in[11]          ),
    .o_12    (dct2d_in[12]          ),
    .o_13    (dct2d_in[13]          ),
    .o_14    (dct2d_in[14]          ),
    .o_15    (dct2d_in[15]          ),
    .o_16    (dct2d_in[16]          ),
    .o_17    (dct2d_in[17]          ),
    .o_18    (dct2d_in[18]          ),
    .o_19    (dct2d_in[19]          ),
    .o_20    (dct2d_in[20]          ),
    .o_21    (dct2d_in[21]          ),
    .o_22    (dct2d_in[22]          ),
    .o_23    (dct2d_in[23]          ),
    .o_24    (dct2d_in[24]          ),
    .o_25    (dct2d_in[25]          ),
    .o_26    (dct2d_in[26]          ),
    .o_27    (dct2d_in[27]          ),
    .o_28    (dct2d_in[28]          ),
    .o_29    (dct2d_in[29]          ),
    .o_30    (dct2d_in[30]          ),
    .o_31    (dct2d_in[31]          ),
    .o_32    (dct2d_in[32]          ),
    .o_33    (dct2d_in[33]          ),
    .o_34    (dct2d_in[34]          ),
    .o_35    (dct2d_in[35]          ),
    .o_36    (dct2d_in[36]          ),
    .o_37    (dct2d_in[37]          ),
    .o_38    (dct2d_in[38]          ),
    .o_39    (dct2d_in[39]          ),
    .o_40    (dct2d_in[40]          ),
    .o_41    (dct2d_in[41]          ),
    .o_42    (dct2d_in[42]          ),
    .o_43    (dct2d_in[43]          ),
    .o_44    (dct2d_in[44]          ),
    .o_45    (dct2d_in[45]          ),
    .o_46    (dct2d_in[46]          ),
    .o_47    (dct2d_in[47]          ),
    .o_48    (dct2d_in[48]          ),
    .o_49    (dct2d_in[49]          ),
    .o_50    (dct2d_in[50]          ),
    .o_51    (dct2d_in[51]          ),
    .o_52    (dct2d_in[52]          ),
    .o_53    (dct2d_in[53]          ),
    .o_54    (dct2d_in[54]          ),
    .o_55    (dct2d_in[55]          ),
    .o_56    (dct2d_in[56]          ),
    .o_57    (dct2d_in[57]          ),
    .o_58    (dct2d_in[58]          ),
    .o_59    (dct2d_in[59]          ),
    .o_60    (dct2d_in[60]          ),
    .o_61    (dct2d_in[61]          ),
    .o_62    (dct2d_in[62]          ),
    .o_63    (dct2d_in[63]          )
); 

//second stage 1D-DCT
dct1d_2nd#(
    .IN_WIDTH   (OUT_WIDTH          ),
    .OUT_WIDTH  (OUT_WIDTH          )
)
u_dct1d_2nd(
//system input
    .clk     (clk                   ),
    .rst_n   (rst_n                 ),
//input parameter
    .i_width (dct2d_in_width        ),
    .i_height(dct2d_in_height       ),
//input data
    .i_valid (dct2d_in_valid        ),
    .i_0     (dct2d_in[0 ]          ),
    .i_1     (dct2d_in[1 ]          ),
    .i_2     (dct2d_in[2 ]          ),
    .i_3     (dct2d_in[3 ]          ),
    .i_4     (dct2d_in[4 ]          ),
    .i_5     (dct2d_in[5 ]          ),
    .i_6     (dct2d_in[6 ]          ),
    .i_7     (dct2d_in[7 ]          ),
    .i_8     (dct2d_in[8 ]          ),
    .i_9     (dct2d_in[9 ]          ),
    .i_10    (dct2d_in[10]          ),
    .i_11    (dct2d_in[11]          ),
    .i_12    (dct2d_in[12]          ),
    .i_13    (dct2d_in[13]          ),
    .i_14    (dct2d_in[14]          ),
    .i_15    (dct2d_in[15]          ),
    .i_16    (dct2d_in[16]          ),
    .i_17    (dct2d_in[17]          ),
    .i_18    (dct2d_in[18]          ),
    .i_19    (dct2d_in[19]          ),
    .i_20    (dct2d_in[20]          ),
    .i_21    (dct2d_in[21]          ),
    .i_22    (dct2d_in[22]          ),
    .i_23    (dct2d_in[23]          ),
    .i_24    (dct2d_in[24]          ),
    .i_25    (dct2d_in[25]          ),
    .i_26    (dct2d_in[26]          ),
    .i_27    (dct2d_in[27]          ),
    .i_28    (dct2d_in[28]          ),
    .i_29    (dct2d_in[29]          ),
    .i_30    (dct2d_in[30]          ),
    .i_31    (dct2d_in[31]          ),
    .i_32    (dct2d_in[32]          ),
    .i_33    (dct2d_in[33]          ),
    .i_34    (dct2d_in[34]          ),
    .i_35    (dct2d_in[35]          ),
    .i_36    (dct2d_in[36]          ),
    .i_37    (dct2d_in[37]          ),
    .i_38    (dct2d_in[38]          ),
    .i_39    (dct2d_in[39]          ),
    .i_40    (dct2d_in[40]          ),
    .i_41    (dct2d_in[41]          ),
    .i_42    (dct2d_in[42]          ),
    .i_43    (dct2d_in[43]          ),
    .i_44    (dct2d_in[44]          ),
    .i_45    (dct2d_in[45]          ),
    .i_46    (dct2d_in[46]          ),
    .i_47    (dct2d_in[47]          ),
    .i_48    (dct2d_in[48]          ),
    .i_49    (dct2d_in[49]          ),
    .i_50    (dct2d_in[50]          ),
    .i_51    (dct2d_in[51]          ),
    .i_52    (dct2d_in[52]          ),
    .i_53    (dct2d_in[53]          ),
    .i_54    (dct2d_in[54]          ),
    .i_55    (dct2d_in[55]          ),
    .i_56    (dct2d_in[56]          ),
    .i_57    (dct2d_in[57]          ),
    .i_58    (dct2d_in[58]          ),
    .i_59    (dct2d_in[59]          ),
    .i_60    (dct2d_in[60]          ),
    .i_61    (dct2d_in[61]          ),
    .i_62    (dct2d_in[62]          ),
    .i_63    (dct2d_in[63]          ),
//output parameter
    .o_width (dct2d_out_width       ),
    .o_height(dct2d_out_height      ),
//output coeff
    .o_valid (dct2d_out_valid       ),
    .o_0     (dct2d_out[0 ]         ),
    .o_1     (dct2d_out[1 ]         ),
    .o_2     (dct2d_out[2 ]         ),
    .o_3     (dct2d_out[3 ]         ),
    .o_4     (dct2d_out[4 ]         ),
    .o_5     (dct2d_out[5 ]         ),
    .o_6     (dct2d_out[6 ]         ),
    .o_7     (dct2d_out[7 ]         ),
    .o_8     (dct2d_out[8 ]         ),
    .o_9     (dct2d_out[9 ]         ),
    .o_10    (dct2d_out[10]         ),
    .o_11    (dct2d_out[11]         ),
    .o_12    (dct2d_out[12]         ),
    .o_13    (dct2d_out[13]         ),
    .o_14    (dct2d_out[14]         ),
    .o_15    (dct2d_out[15]         ),
    .o_16    (dct2d_out[16]         ),
    .o_17    (dct2d_out[17]         ),
    .o_18    (dct2d_out[18]         ),
    .o_19    (dct2d_out[19]         ),
    .o_20    (dct2d_out[20]         ),
    .o_21    (dct2d_out[21]         ),
    .o_22    (dct2d_out[22]         ),
    .o_23    (dct2d_out[23]         ),
    .o_24    (dct2d_out[24]         ),
    .o_25    (dct2d_out[25]         ),
    .o_26    (dct2d_out[26]         ),
    .o_27    (dct2d_out[27]         ),
    .o_28    (dct2d_out[28]         ),
    .o_29    (dct2d_out[29]         ),
    .o_30    (dct2d_out[30]         ),
    .o_31    (dct2d_out[31]         )
);

//parallel to serial
parallel_to_serial#(
    .IN_WIDTH   (OUT_WIDTH          ),
    .OUT_WIDTH  (OUT_WIDTH          )
)
u1_parallel_to_serial(
//system input
    .clk     (clk                   ),
    .rst_n   (rst_n                 ),
//input parameter
    .i_width (dct2d_out_width       ),
    .i_height(dct2d_out_height      ),
//input data
    .i_valid (dct2d_out_valid       ),
    .i_0     (dct2d_out[0 ]         ),
    .i_1     (dct2d_out[1 ]         ),
    .i_2     (dct2d_out[2 ]         ),
    .i_3     (dct2d_out[3 ]         ),
    .i_4     (dct2d_out[4 ]         ),
    .i_5     (dct2d_out[5 ]         ),
    .i_6     (dct2d_out[6 ]         ),
    .i_7     (dct2d_out[7 ]         ),
    .i_8     (dct2d_out[8 ]         ),
    .i_9     (dct2d_out[9 ]         ),
    .i_10    (dct2d_out[10]         ),
    .i_11    (dct2d_out[11]         ),
    .i_12    (dct2d_out[12]         ),
    .i_13    (dct2d_out[13]         ),
    .i_14    (dct2d_out[14]         ),
    .i_15    (dct2d_out[15]         ),
    .i_16    (dct2d_out[16]         ),
    .i_17    (dct2d_out[17]         ),
    .i_18    (dct2d_out[18]         ),
    .i_19    (dct2d_out[19]         ),
    .i_20    (dct2d_out[20]         ),
    .i_21    (dct2d_out[21]         ),
    .i_22    (dct2d_out[22]         ),
    .i_23    (dct2d_out[23]         ),
    .i_24    (dct2d_out[24]         ),
    .i_25    (dct2d_out[25]         ),
    .i_26    (dct2d_out[26]         ),
    .i_27    (dct2d_out[27]         ),
    .i_28    (dct2d_out[28]         ),
    .i_29    (dct2d_out[29]         ),
    .i_30    (dct2d_out[30]         ),
    .i_31    (dct2d_out[31]         ),
//output parameter
    .o_width (o_data_width          ),
    .o_height(o_data_height         ),
//output data
    .o_valid (o_data_valid          ),
    .o_0     (o_data[0 ]            ),
    .o_1     (o_data[1 ]            ),
    .o_2     (o_data[2 ]            ),
    .o_3     (o_data[3 ]            ),
    .o_4     (o_data[4 ]            ),
    .o_5     (o_data[5 ]            ),
    .o_6     (o_data[6 ]            ),
    .o_7     (o_data[7 ]            ),
    .o_8     (o_data[8 ]            ),
    .o_9     (o_data[9 ]            ),
    .o_10    (o_data[10]            ),
    .o_11    (o_data[11]            ),
    .o_12    (o_data[12]            ),
    .o_13    (o_data[13]            ),
    .o_14    (o_data[14]            ),
    .o_15    (o_data[15]            )
); 

//output
    assign o_width = o_data_width;
    assign o_height = o_data_height;
    assign o_valid = o_data_valid;
    assign o_0  = o_data[0 ];
    assign o_1  = o_data[1 ];
    assign o_2  = o_data[2 ];
    assign o_3  = o_data[3 ];
    assign o_4  = o_data[4 ];
    assign o_5  = o_data[5 ];
    assign o_6  = o_data[6 ];
    assign o_7  = o_data[7 ];
    assign o_8  = o_data[8 ];
    assign o_9  = o_data[9 ];
    assign o_10 = o_data[10];
    assign o_11 = o_data[11];
    assign o_12 = o_data[12];
    assign o_13 = o_data[13];
    assign o_14 = o_data[14];
    assign o_15 = o_data[15];

endmodule
