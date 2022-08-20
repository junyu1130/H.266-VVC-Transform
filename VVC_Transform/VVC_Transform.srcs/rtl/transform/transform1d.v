//describe  : 第一次一维正变换(DCT2/DCT8/DST7)
//input     : 16个像素残差
//output    : 16个一维变换系数
//delay     : 10 clk
module transform1d#(
    parameter  IN_WIDTH = 9,
    parameter  OUT_WIDTH = 16
)(
//system input
    input                               clk         ,
    input                               rst_n       ,
//input parameter
    input                               tr_sequence ,
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


    wire    [1 : 0] i_type;
    wire    [2 : 0] i_size;

    wire            [2 : 0]                 tr_out_size;
    wire                                    tr_out_valid;
    wire    signed  [IN_WIDTH + 11 : 0]     tr_out_data[0 : 15];
    wire    signed  [OUT_WIDTH - 1 : 0]     coeff_out_data[0 : 15];
    wire                                    coeff_out_valid;
    reg             [3 : 0]                 tr_shift;

//input delay
    reg             [1 : 0]                 i_type_h_d[0 : 9];
    reg             [1 : 0]                 i_type_v_d[0 : 9];
    reg             [2 : 0]                 i_height_d[0 : 9];
    reg             [2 : 0]                 i_width_d[0 : 9];



//delay
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin 
        for (i = 0; i < 10; i = i + 1) begin
            i_width_d[i]  <= 0;
            i_height_d[i] <= 0;
            i_type_h_d[i] <= 0;
            i_type_v_d[i] <= 0;
        end
    end
    else begin
        i_width_d[0]  <= i_width;
        i_height_d[0] <= i_height;
        i_type_h_d[0] <= i_type_h;
        i_type_v_d[0] <= i_type_v;
        for (i = 0; i < 9; i = i + 1) begin
            i_width_d[i + 1]  <= i_width_d[i];
            i_height_d[i + 1] <= i_height_d[i];
            i_type_h_d[i + 1] <= i_type_h_d[i];
            i_type_v_d[i + 1] <= i_type_v_d[i];
        end
    end
end




assign i_type = tr_sequence ? i_type_v : i_type_h;
assign i_size = tr_sequence ? i_height : i_width;

transform#(
    .IN_WIDTH   (IN_WIDTH       ),
    .OUT_WIDTH  (IN_WIDTH + 12  )
)
u_transform(
//system input
    .clk     (clk         ),
    .rst_n   (rst_n       ),
//input parameter
    .i_size  (i_size      ),
    .i_type  (i_type      ), 
//input data
    .i_valid (i_valid     ),
    .i_0     (i_0         ),
    .i_1     (i_1         ),
    .i_2     (i_2         ),
    .i_3     (i_3         ),
    .i_4     (i_4         ),
    .i_5     (i_5         ),
    .i_6     (i_6         ),
    .i_7     (i_7         ),
    .i_8     (i_8         ),
    .i_9     (i_9         ),
    .i_10    (i_10        ),
    .i_11    (i_11        ),
    .i_12    (i_12        ),
    .i_13    (i_13        ),
    .i_14    (i_14        ),
    .i_15    (i_15        ),
//output parameter
    .o_size  (tr_out_size    ),
    .o_valid (tr_out_valid   ),
//output 1st stage's coeff
    .o_0     (tr_out_data[0 ] ),
    .o_1     (tr_out_data[1 ] ),
    .o_2     (tr_out_data[2 ] ),
    .o_3     (tr_out_data[3 ] ),
    .o_4     (tr_out_data[4 ] ),
    .o_5     (tr_out_data[5 ] ),
    .o_6     (tr_out_data[6 ] ),
    .o_7     (tr_out_data[7 ] ),
    .o_8     (tr_out_data[8 ] ),
    .o_9     (tr_out_data[9 ] ),
    .o_10    (tr_out_data[10] ),
    .o_11    (tr_out_data[11] ),
    .o_12    (tr_out_data[12] ),
    .o_13    (tr_out_data[13] ),
    .o_14    (tr_out_data[14] ),
    .o_15    (tr_out_data[15] )
); 


//shift
always @(*) begin
    case (tr_out_size)//first stage : log2(Width) + BitDepth - 9
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
    .o_15       (coeff_out_data[15] )
);  

//output

    assign o_type_h     =   i_type_h_d[9];
    assign o_type_v     =   i_type_v_d[9];
    assign o_width      =   i_width_d[9];
    assign o_height     =   i_height_d[9];


    assign o_valid      =   coeff_out_valid;
    assign o_0          =   coeff_out_data[0 ];
    assign o_1          =   coeff_out_data[1 ];
    assign o_2          =   coeff_out_data[2 ];
    assign o_3          =   coeff_out_data[3 ];
    assign o_4          =   coeff_out_data[4 ];
    assign o_5          =   coeff_out_data[5 ];
    assign o_6          =   coeff_out_data[6 ];
    assign o_7          =   coeff_out_data[7 ];
    assign o_8          =   coeff_out_data[8 ];
    assign o_9          =   coeff_out_data[9 ];
    assign o_10         =   coeff_out_data[10];
    assign o_11         =   coeff_out_data[11];
    assign o_12         =   coeff_out_data[12];
    assign o_13         =   coeff_out_data[13];
    assign o_14         =   coeff_out_data[14];
    assign o_15         =   coeff_out_data[15];


endmodule
