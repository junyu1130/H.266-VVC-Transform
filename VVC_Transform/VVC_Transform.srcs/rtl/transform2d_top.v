//describe  : ��ά���任(DCT2/DCT8/DST7)
//input     : 32�����زв�
//output    : 32���任ϵ��
//delay     : 145(64x64) / 81(other) clk
module transform2d_top#(
    parameter  BIT_DEPTH = 8,
    parameter  OUT_WIDTH = 16
)
(
//system input
    input                               clk         ,
    input                               reset       ,
//input parameter
    input           [1 : 0]             i_type_h    ,//0:DCT2 1:DCT8 2:DST7      
    input           [1 : 0]             i_type_v    ,              
    input           [2 : 0]             i_width     ,//1st 1:4x4, 2:8x8, 3:16x16, 4:32x32, 5:64x64
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

integer i;

//input
    reg [1 : 0] i_type_v_d[0 : 6];
    reg [2 : 0] i_height_d[0 : 6];
//transform1d
    wire [1 : 0] transform1d_out_type_h;
    wire [1 : 0] transform1d_out_type_v = i_type_v_d[5];
    wire [2 : 0] transform1d_out_width;
    wire [2 : 0] transform1d_out_height = i_height_d[5];
    wire transform1d_out_valid;
    wire signed [OUT_WIDTH - 1 : 0] transform1d_out[0 : 31];
//transpose memory
    wire [1 : 0] transpose_out_type_h;
    wire [1 : 0] transpose_out_type_v;
    wire [2 : 0] transpose_out_width, transpose_out_height;
    wire transpose_out_valid;
    wire signed [OUT_WIDTH - 1 : 0] transpose_out[0 : 31];
    reg [1 : 0] transpose_out_type_h_d[0 : 6];
    reg [2 : 0] transpose_out_width_d[0 : 6];

//parameter delay
always @(posedge clk or negedge reset) begin
    if (!reset) begin 
        for (i = 0; i < 7; i = i + 1) begin
            i_height_d[i] <= 0;
            i_type_v_d[i] <= 0;
            transpose_out_width_d[i] <= 0;
            transpose_out_type_h_d[i] <= 0;
        end
    end
    else begin
        i_height_d[0] <= i_height;
        i_type_v_d[0] <= i_type_v;
        transpose_out_width_d[0] <= transpose_out_width;
        transpose_out_type_h_d[0] <= transpose_out_type_h;
        for (i = 0; i < 6; i = i + 1) begin
            i_height_d[i + 1] <= i_height_d[i];
            i_type_v_d[i + 1] <= i_type_v_d[i];
            transpose_out_width_d[i + 1] <= transpose_out_width_d[i];
            transpose_out_type_h_d[i + 1] <= transpose_out_type_h_d[i];
        end
    end
end

//transform1d 1st stage
transform1d#(
    .IN_WIDTH   (BIT_DEPTH + 1          ),
    .OUT_WIDTH  (OUT_WIDTH              )
)
u_transform1d_1st(
//system input
    .clk        (clk                    ),
    .rst_n      (reset                  ),
//input parameter
    .i_type     (i_type_h               ),
    .i_size     (i_width                ),
//input data
    .i_valid    (i_valid                ),
    .i_0        (i_0                    ),
    .i_1        (i_1                    ),
    .i_2        (i_2                    ),
    .i_3        (i_3                    ),
    .i_4        (i_4                    ),
    .i_5        (i_5                    ),
    .i_6        (i_6                    ),
    .i_7        (i_7                    ),
    .i_8        (i_8                    ),
    .i_9        (i_9                    ),
    .i_10       (i_10                   ),
    .i_11       (i_11                   ),
    .i_12       (i_12                   ),
    .i_13       (i_13                   ),
    .i_14       (i_14                   ),
    .i_15       (i_15                   ),
    .i_16       (i_16                   ),
    .i_17       (i_17                   ),
    .i_18       (i_18                   ),
    .i_19       (i_19                   ),
    .i_20       (i_20                   ),
    .i_21       (i_21                   ),
    .i_22       (i_22                   ),
    .i_23       (i_23                   ),
    .i_24       (i_24                   ),
    .i_25       (i_25                   ),
    .i_26       (i_26                   ),
    .i_27       (i_27                   ),
    .i_28       (i_28                   ),
    .i_29       (i_29                   ),
    .i_30       (i_30                   ),
    .i_31       (i_31                   ),
//output parameter
    .o_type     (transform1d_out_type_h ),
    .o_size     (transform1d_out_width  ),
//output 1st stage's coeff
    .o_valid    (transform1d_out_valid  ),
    .o_0        (transform1d_out[0 ]    ),
    .o_1        (transform1d_out[1 ]    ),
    .o_2        (transform1d_out[2 ]    ),
    .o_3        (transform1d_out[3 ]    ),
    .o_4        (transform1d_out[4 ]    ),
    .o_5        (transform1d_out[5 ]    ),
    .o_6        (transform1d_out[6 ]    ),
    .o_7        (transform1d_out[7 ]    ),
    .o_8        (transform1d_out[8 ]    ),
    .o_9        (transform1d_out[9 ]    ),
    .o_10       (transform1d_out[10]    ),
    .o_11       (transform1d_out[11]    ),
    .o_12       (transform1d_out[12]    ),
    .o_13       (transform1d_out[13]    ),
    .o_14       (transform1d_out[14]    ),
    .o_15       (transform1d_out[15]    ),
    .o_16       (transform1d_out[16]    ),
    .o_17       (transform1d_out[17]    ),
    .o_18       (transform1d_out[18]    ),
    .o_19       (transform1d_out[19]    ),
    .o_20       (transform1d_out[20]    ),
    .o_21       (transform1d_out[21]    ),
    .o_22       (transform1d_out[22]    ),
    .o_23       (transform1d_out[23]    ),
    .o_24       (transform1d_out[24]    ),
    .o_25       (transform1d_out[25]    ),
    .o_26       (transform1d_out[26]    ),
    .o_27       (transform1d_out[27]    ),
    .o_28       (transform1d_out[28]    ),
    .o_29       (transform1d_out[29]    ),
    .o_30       (transform1d_out[30]    ),
    .o_31       (transform1d_out[31]    )
); 

//transpose memory
transpose_memory#(
    .WIDTH      (OUT_WIDTH              )
)
u_transpose_memory(
//system input
    .clk        (clk                    ),
    .rst_n      (reset                  ),
//input parameter
    .i_type_h   (transform1d_out_type_h ),
    .i_type_v   (transform1d_out_type_v ),
    .i_width    (transform1d_out_width  ),
    .i_height   (transform1d_out_height ),
//1st stage's coeff
    .i_valid    (transform1d_out_valid  ),
    .i_0        (transform1d_out[0 ]    ),
    .i_1        (transform1d_out[1 ]    ),
    .i_2        (transform1d_out[2 ]    ),
    .i_3        (transform1d_out[3 ]    ),
    .i_4        (transform1d_out[4 ]    ),
    .i_5        (transform1d_out[5 ]    ),
    .i_6        (transform1d_out[6 ]    ),
    .i_7        (transform1d_out[7 ]    ),
    .i_8        (transform1d_out[8 ]    ),
    .i_9        (transform1d_out[9 ]    ),
    .i_10       (transform1d_out[10]    ),
    .i_11       (transform1d_out[11]    ),
    .i_12       (transform1d_out[12]    ),
    .i_13       (transform1d_out[13]    ),
    .i_14       (transform1d_out[14]    ),
    .i_15       (transform1d_out[15]    ),
    .i_16       (transform1d_out[16]    ),
    .i_17       (transform1d_out[17]    ),
    .i_18       (transform1d_out[18]    ),
    .i_19       (transform1d_out[19]    ),
    .i_20       (transform1d_out[20]    ),
    .i_21       (transform1d_out[21]    ),
    .i_22       (transform1d_out[22]    ),
    .i_23       (transform1d_out[23]    ),
    .i_24       (transform1d_out[24]    ),
    .i_25       (transform1d_out[25]    ),
    .i_26       (transform1d_out[26]    ),
    .i_27       (transform1d_out[27]    ),
    .i_28       (transform1d_out[28]    ),
    .i_29       (transform1d_out[29]    ),
    .i_30       (transform1d_out[30]    ),
    .i_31       (transform1d_out[31]    ),
//output parameter
    .o_type_h   (transpose_out_type_h   ),
    .o_type_v   (transpose_out_type_v   ),
    .o_width    (transpose_out_width    ),
    .o_height   (transpose_out_height   ),
//transpose 1st stage's coeff
    .o_valid    (transpose_out_valid    ),
    .o_0        (transpose_out[0 ]      ),
    .o_1        (transpose_out[1 ]      ),
    .o_2        (transpose_out[2 ]      ),
    .o_3        (transpose_out[3 ]      ),
    .o_4        (transpose_out[4 ]      ),
    .o_5        (transpose_out[5 ]      ),
    .o_6        (transpose_out[6 ]      ),
    .o_7        (transpose_out[7 ]      ),
    .o_8        (transpose_out[8 ]      ),
    .o_9        (transpose_out[9 ]      ),
    .o_10       (transpose_out[10]      ),
    .o_11       (transpose_out[11]      ),
    .o_12       (transpose_out[12]      ),
    .o_13       (transpose_out[13]      ),
    .o_14       (transpose_out[14]      ),
    .o_15       (transpose_out[15]      ),
    .o_16       (transpose_out[16]      ),
    .o_17       (transpose_out[17]      ),
    .o_18       (transpose_out[18]      ),
    .o_19       (transpose_out[19]      ),
    .o_20       (transpose_out[20]      ),
    .o_21       (transpose_out[21]      ),
    .o_22       (transpose_out[22]      ),
    .o_23       (transpose_out[23]      ),
    .o_24       (transpose_out[24]      ),
    .o_25       (transpose_out[25]      ),
    .o_26       (transpose_out[26]      ),
    .o_27       (transpose_out[27]      ),
    .o_28       (transpose_out[28]      ),
    .o_29       (transpose_out[29]      ),
    .o_30       (transpose_out[30]      ),
    .o_31       (transpose_out[31]      )
);

//transform1d 2nd stage 
transform1d#(
    .IN_WIDTH   (OUT_WIDTH              ),
    .OUT_WIDTH  (OUT_WIDTH              )
)
u_transform1d_2nd(
//system input
    .clk        (clk                    ),
    .rst_n      (reset                  ),
//input parameter
    .i_type     (transpose_out_type_v   ),
    .i_size     (transpose_out_height   ),
//input transposed 1st stage's coeff
    .i_valid    (transpose_out_valid    ),
    .i_0        (transpose_out[0 ]      ),
    .i_1        (transpose_out[1 ]      ),
    .i_2        (transpose_out[2 ]      ),
    .i_3        (transpose_out[3 ]      ),
    .i_4        (transpose_out[4 ]      ),
    .i_5        (transpose_out[5 ]      ),
    .i_6        (transpose_out[6 ]      ),
    .i_7        (transpose_out[7 ]      ),
    .i_8        (transpose_out[8 ]      ),
    .i_9        (transpose_out[9 ]      ),
    .i_10       (transpose_out[10]      ),
    .i_11       (transpose_out[11]      ),
    .i_12       (transpose_out[12]      ),
    .i_13       (transpose_out[13]      ),
    .i_14       (transpose_out[14]      ),
    .i_15       (transpose_out[15]      ),
    .i_16       (transpose_out[16]      ),
    .i_17       (transpose_out[17]      ),
    .i_18       (transpose_out[18]      ),
    .i_19       (transpose_out[19]      ),
    .i_20       (transpose_out[20]      ),
    .i_21       (transpose_out[21]      ),
    .i_22       (transpose_out[22]      ),
    .i_23       (transpose_out[23]      ),
    .i_24       (transpose_out[24]      ),
    .i_25       (transpose_out[25]      ),
    .i_26       (transpose_out[26]      ),
    .i_27       (transpose_out[27]      ),
    .i_28       (transpose_out[28]      ),
    .i_29       (transpose_out[29]      ),
    .i_30       (transpose_out[30]      ),
    .i_31       (transpose_out[31]      ),
//output parameter
    .o_type     (o_type_v               ),
    .o_size     (o_height               ),
//output 2nd stage's coeff
    .o_valid    (o_valid                ),
    .o_0        (o_0                    ),
    .o_1        (o_1                    ),
    .o_2        (o_2                    ),
    .o_3        (o_3                    ),
    .o_4        (o_4                    ),
    .o_5        (o_5                    ),
    .o_6        (o_6                    ),
    .o_7        (o_7                    ),
    .o_8        (o_8                    ),
    .o_9        (o_9                    ),
    .o_10       (o_10                   ),
    .o_11       (o_11                   ),
    .o_12       (o_12                   ),
    .o_13       (o_13                   ),
    .o_14       (o_14                   ),
    .o_15       (o_15                   ),
    .o_16       (o_16                   ),
    .o_17       (o_17                   ),
    .o_18       (o_18                   ),
    .o_19       (o_19                   ),
    .o_20       (o_20                   ),
    .o_21       (o_21                   ),
    .o_22       (o_22                   ),
    .o_23       (o_23                   ),
    .o_24       (o_24                   ),
    .o_25       (o_25                   ),
    .o_26       (o_26                   ),
    .o_27       (o_27                   ),
    .o_28       (o_28                   ),
    .o_29       (o_29                   ),
    .o_30       (o_30                   ),
    .o_31       (o_31                   )
); 

assign o_type_h = transpose_out_type_h_d[6];
assign o_width = transpose_out_width_d[6];

endmodule
