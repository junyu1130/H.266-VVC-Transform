//describe  : 二维正变换(DCT2/DCT8/DST7)
//input     : 16个像素残差
//output    : 16个变换系数
//delay     : 281(64x64) / 153(other) clk
module transform2d_top#(
    parameter  BIT_DEPTH = 8,
    parameter  OUT_WIDTH = 16
)
(
//system input
    input                               clk         ,
    input                               reset       ,
//input parameter
    input           [1 : 0]             i_type      ,//0:DCT2 1:DCT8 2:DST7                    
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
//output parameter
    output          [1 : 0]             o_type      ,
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
    reg [1 : 0] i_type_d1;
    reg [2 : 0] i_width_d1, i_height_d1;
    reg i_valid_d1;
    reg [BIT_DEPTH : 0] i_data_d1[0 : 15];
//transform1d first stage
    wire [1 : 0] transform1d_1st_out_type;
    wire [2 : 0] transform1d_1st_out_width, transform1d_1st_out_height;
    wire transform1d_1st_out_valid;
    wire signed [OUT_WIDTH - 1 : 0] transform1d_1st_out[0 : 15];
//transpose memory
    wire [1 : 0] transpose_out_type;
    wire [2 : 0] transpose_out_width, transpose_out_height;
    wire transpose_out_valid;
    wire signed [OUT_WIDTH - 1 : 0] transpose_out[0 : 15];
//transform1d second stage
    wire [1 : 0] transform1d_2nd_out_type;
    wire [2 : 0] transform1d_2nd_out_width, transform1d_2nd_out_height;
    wire transform1d_2nd_out_valid;
    wire signed [OUT_WIDTH - 1 : 0] transform1d_2nd_out[0 : 15];

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
always @(posedge clk or negedge reset) begin
    if (!reset) begin
        i_type_d1 <= 0;
        i_width_d1 <= 0; 
        i_height_d1 <= 0;
        i_valid_d1 <= 0;
        for (i = 0; i < 16; i = i + 1) begin
            i_data_d1[i] <= 0;
        end
    end
    else begin
        i_type_d1 <= i_type;
        i_width_d1 <= i_width; 
        i_height_d1 <= i_height;
        i_valid_d1 <= i_valid;
        for (i = 0; i < 16; i = i + 1) begin
            i_data_d1[i] <= i_data[i];
        end
    end
end

//sub module
//first stage transform1d
transform1d_1st#(
    .IN_WIDTH   (BIT_DEPTH + 1              ),
    .OUT_WIDTH  (OUT_WIDTH                  )
)
u_transform1d_1st(
//system input
    .clk        (clk                        ),
    .rst_n      (reset                      ),
//input parameter
    .i_type     (i_type_d1                  ),
    .i_width    (i_width_d1                 ),
    .i_height   (i_height_d1                ),
//input data
    .i_valid    (i_valid_d1                 ),
    .i_0        (i_data_d1[0 ]              ),
    .i_1        (i_data_d1[1 ]              ),
    .i_2        (i_data_d1[2 ]              ),
    .i_3        (i_data_d1[3 ]              ),
    .i_4        (i_data_d1[4 ]              ),
    .i_5        (i_data_d1[5 ]              ),
    .i_6        (i_data_d1[6 ]              ),
    .i_7        (i_data_d1[7 ]              ),
    .i_8        (i_data_d1[8 ]              ),
    .i_9        (i_data_d1[9 ]              ),
    .i_10       (i_data_d1[10]              ),
    .i_11       (i_data_d1[11]              ),
    .i_12       (i_data_d1[12]              ),
    .i_13       (i_data_d1[13]              ),
    .i_14       (i_data_d1[14]              ),
    .i_15       (i_data_d1[15]              ),
//output parameter
    .o_type     (transform1d_1st_out_type   ),
    .o_width    (transform1d_1st_out_width  ),
    .o_height   (transform1d_1st_out_height ),
//output 1st stage's coeff
    .o_valid    (transform1d_1st_out_valid  ),
    .o_0        (transform1d_1st_out[0 ]    ),
    .o_1        (transform1d_1st_out[1 ]    ),
    .o_2        (transform1d_1st_out[2 ]    ),
    .o_3        (transform1d_1st_out[3 ]    ),
    .o_4        (transform1d_1st_out[4 ]    ),
    .o_5        (transform1d_1st_out[5 ]    ),
    .o_6        (transform1d_1st_out[6 ]    ),
    .o_7        (transform1d_1st_out[7 ]    ),
    .o_8        (transform1d_1st_out[8 ]    ),
    .o_9        (transform1d_1st_out[9 ]    ),
    .o_10       (transform1d_1st_out[10]    ),
    .o_11       (transform1d_1st_out[11]    ),
    .o_12       (transform1d_1st_out[12]    ),
    .o_13       (transform1d_1st_out[13]    ),
    .o_14       (transform1d_1st_out[14]    ),
    .o_15       (transform1d_1st_out[15]    )
); 

//transpose memory
transpose_memory#(
    .WIDTH      (OUT_WIDTH                  )
)
u_transpose_memory(
//system input
    .clk        (clk                        ),
    .rst_n      (reset                      ),
//input parameter
    .i_type     (transform1d_1st_out_type   ),
    .i_width    (transform1d_1st_out_width  ),
    .i_height   (transform1d_1st_out_height ),
//1st stage's coeff
    .i_valid    (transform1d_1st_out_valid  ),
    .i_0        (transform1d_1st_out[0 ]    ),
    .i_1        (transform1d_1st_out[1 ]    ),
    .i_2        (transform1d_1st_out[2 ]    ),
    .i_3        (transform1d_1st_out[3 ]    ),
    .i_4        (transform1d_1st_out[4 ]    ),
    .i_5        (transform1d_1st_out[5 ]    ),
    .i_6        (transform1d_1st_out[6 ]    ),
    .i_7        (transform1d_1st_out[7 ]    ),
    .i_8        (transform1d_1st_out[8 ]    ),
    .i_9        (transform1d_1st_out[9 ]    ),
    .i_10       (transform1d_1st_out[10]    ),
    .i_11       (transform1d_1st_out[11]    ),
    .i_12       (transform1d_1st_out[12]    ),
    .i_13       (transform1d_1st_out[13]    ),
    .i_14       (transform1d_1st_out[14]    ),
    .i_15       (transform1d_1st_out[15]    ),
//output parameter
    .o_type     (transpose_out_type         ),
    .o_width    (transpose_out_width        ),
    .o_height   (transpose_out_height       ),
//transpose 1st stage's coeff
    .o_valid    (transpose_out_valid        ),
    .o_0        (transpose_out[0 ]          ),
    .o_1        (transpose_out[1 ]          ),
    .o_2        (transpose_out[2 ]          ),
    .o_3        (transpose_out[3 ]          ),
    .o_4        (transpose_out[4 ]          ),
    .o_5        (transpose_out[5 ]          ),
    .o_6        (transpose_out[6 ]          ),
    .o_7        (transpose_out[7 ]          ),
    .o_8        (transpose_out[8 ]          ),
    .o_9        (transpose_out[9 ]          ),
    .o_10       (transpose_out[10]          ),
    .o_11       (transpose_out[11]          ),
    .o_12       (transpose_out[12]          ),
    .o_13       (transpose_out[13]          ),
    .o_14       (transpose_out[14]          ),
    .o_15       (transpose_out[15]          )
);

//second stage 1D-DCT
transform1d_2nd#(
    .IN_WIDTH   (OUT_WIDTH                  ),
    .OUT_WIDTH  (OUT_WIDTH                  )
)
u_transform1d_2nd(
//system input
    .clk        (clk                        ),
    .rst_n      (reset                      ),
//input parameter
    .i_type     (transpose_out_type         ),
    .i_width    (transpose_out_width        ),
    .i_height   (transpose_out_height       ),
//input 1st stage's coeff
    .i_valid    (transpose_out_valid        ),
    .i_0        (transpose_out[0 ]          ),
    .i_1        (transpose_out[1 ]          ),
    .i_2        (transpose_out[2 ]          ),
    .i_3        (transpose_out[3 ]          ),
    .i_4        (transpose_out[4 ]          ),
    .i_5        (transpose_out[5 ]          ),
    .i_6        (transpose_out[6 ]          ),
    .i_7        (transpose_out[7 ]          ),
    .i_8        (transpose_out[8 ]          ),
    .i_9        (transpose_out[9 ]          ),
    .i_10       (transpose_out[10]          ),
    .i_11       (transpose_out[11]          ),
    .i_12       (transpose_out[12]          ),
    .i_13       (transpose_out[13]          ),
    .i_14       (transpose_out[14]          ),
    .i_15       (transpose_out[15]          ),
//output parameter
    .o_type     (transform1d_2nd_out_type   ),
    .o_width    (transform1d_2nd_out_width  ),
    .o_height   (transform1d_2nd_out_height ),
//output 2nd stage's coeff
    .o_valid    (transform1d_2nd_out_valid  ),
    .o_0        (transform1d_2nd_out[0 ]    ),
    .o_1        (transform1d_2nd_out[1 ]    ),
    .o_2        (transform1d_2nd_out[2 ]    ),
    .o_3        (transform1d_2nd_out[3 ]    ),
    .o_4        (transform1d_2nd_out[4 ]    ),
    .o_5        (transform1d_2nd_out[5 ]    ),
    .o_6        (transform1d_2nd_out[6 ]    ),
    .o_7        (transform1d_2nd_out[7 ]    ),
    .o_8        (transform1d_2nd_out[8 ]    ),
    .o_9        (transform1d_2nd_out[9 ]    ),
    .o_10       (transform1d_2nd_out[10]    ),
    .o_11       (transform1d_2nd_out[11]    ),
    .o_12       (transform1d_2nd_out[12]    ),
    .o_13       (transform1d_2nd_out[13]    ),
    .o_14       (transform1d_2nd_out[14]    ),
    .o_15       (transform1d_2nd_out[15]    )
); 

//output
    assign o_type   = transform1d_2nd_out_type;
    assign o_width  = transform1d_2nd_out_width;
    assign o_height = transform1d_2nd_out_height;
    assign o_valid  = transform1d_2nd_out_valid;
    assign o_0      = transform1d_2nd_out[0 ];
    assign o_1      = transform1d_2nd_out[1 ];
    assign o_2      = transform1d_2nd_out[2 ];
    assign o_3      = transform1d_2nd_out[3 ];
    assign o_4      = transform1d_2nd_out[4 ];
    assign o_5      = transform1d_2nd_out[5 ];
    assign o_6      = transform1d_2nd_out[6 ];
    assign o_7      = transform1d_2nd_out[7 ];
    assign o_8      = transform1d_2nd_out[8 ];
    assign o_9      = transform1d_2nd_out[9 ];
    assign o_10     = transform1d_2nd_out[10];
    assign o_11     = transform1d_2nd_out[11];
    assign o_12     = transform1d_2nd_out[12];
    assign o_13     = transform1d_2nd_out[13];
    assign o_14     = transform1d_2nd_out[14];
    assign o_15     = transform1d_2nd_out[15];

endmodule
