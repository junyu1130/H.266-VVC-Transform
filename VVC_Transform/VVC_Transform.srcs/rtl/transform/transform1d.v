//describe  : һά���任(DCT2/DCT8/DST7)
//input     : 16�����زв�/һά�任ϵ��
//output    : 16��һά�任ϵ��/��ά�任ϵ��
//delay     : 10 clk
module transform1d#(
    parameter  IN_WIDTH = 9,
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

//input
    wire signed [IN_WIDTH - 1 : 0] i_data[0 : 31];
    reg [1 : 0] i_type_d[0 : 9];
    reg [2 : 0] i_size_d[0 : 9];
    reg signed [IN_WIDTH - 1 : 0] tr_in_data[0 : 31];
//calculate
    wire [2 : 0] calculate_out_size;
    wire calculate_out_valid;
    wire signed [IN_WIDTH + 11 : 0] calculate_out_data[0 : 31];
    reg signed  [IN_WIDTH + 11 : 0] tr_out_data[0 : 31];
//shift
    wire signed [OUT_WIDTH - 1 : 0] coeff_out_data[0 : 31];
    wire coeff_out_valid;
    reg [3 : 0] tr_shift;

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

//delay
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin 
        for (i = 0; i < 10; i = i + 1) begin
            i_size_d[i]  <= 0;
            i_type_d[i] <= 0;
        end
    end
    else begin
        i_size_d[0]  <= i_size;
        i_type_d[0] <= i_type;
        for (i = 0; i < 9; i = i + 1) begin
            i_size_d[i + 1]  <= i_size_d[i];
            i_type_d[i + 1] <= i_type_d[i];
        end
    end
end

//type mux in
always @(*) begin
    case (i_type) 
        DCT2    : begin
            for (i = 0; i < 32; i = i + 1) begin
                tr_in_data[i] <= i_data[i];
            end
        end
        DST7    : begin
            for (i = 0; i < 32; i = i + 1) begin
                tr_in_data[i] <= i_data[i];
            end
        end
        DCT8    : begin //reverse input
            case (i_size)
                SIZE32 : begin
                    for (i = 0; i < 32; i = i + 1) begin
                        tr_in_data[i] <= i_data[31 - i];
                    end
                end
                SIZE16 : begin
                    for (i = 0; i < 16; i = i + 1) begin
                        tr_in_data[i     ] <= i_data[15 - i];
                        tr_in_data[16 + i] <= i_data[31 - i];
                    end
                end
                SIZE8 : begin
                    for (i = 0; i < 8; i = i + 1) begin
                        tr_in_data[i     ] <= i_data[7  - i];
                        tr_in_data[8  + i] <= i_data[15 - i];
                        tr_in_data[16 + i] <= i_data[23 - i];
                        tr_in_data[24 + i] <= i_data[31 - i];
                    end
                end
                SIZE4 : begin
                    for (i = 0; i < 4; i = i + 1) begin
                        tr_in_data[i     ] <= i_data[3  - i];
                        tr_in_data[4  + i] <= i_data[7  - i];
                        tr_in_data[8  + i] <= i_data[11 - i];
                        tr_in_data[12 + i] <= i_data[15 - i];
                        tr_in_data[16 + i] <= i_data[19 - i];
                        tr_in_data[20 + i] <= i_data[23 - i];
                        tr_in_data[24 + i] <= i_data[27 - i];
                        tr_in_data[28 + i] <= i_data[31 - i];
                    end
                end
                default : begin
                    for (i = 0; i < 32; i = i + 1) begin
                        tr_in_data[i] <= 0;
                    end
                end
            endcase
        end
        default : begin
            for (i = 0; i < 32; i = i + 1) begin
                tr_in_data[i] <= 0;
            end
        end
    endcase
end

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
    .i_0     (tr_in_data[0 ] ),
    .i_1     (tr_in_data[1 ] ),
    .i_2     (tr_in_data[2 ] ),
    .i_3     (tr_in_data[3 ] ),
    .i_4     (tr_in_data[4 ] ),
    .i_5     (tr_in_data[5 ] ),
    .i_6     (tr_in_data[6 ] ),
    .i_7     (tr_in_data[7 ] ),
    .i_8     (tr_in_data[8 ] ),
    .i_9     (tr_in_data[9 ] ),
    .i_10    (tr_in_data[10] ),
    .i_11    (tr_in_data[11] ),
    .i_12    (tr_in_data[12] ),
    .i_13    (tr_in_data[13] ),
    .i_14    (tr_in_data[14] ),
    .i_15    (tr_in_data[15] ),
    .i_16    (tr_in_data[16] ),
    .i_17    (tr_in_data[17] ),
    .i_18    (tr_in_data[18] ),
    .i_19    (tr_in_data[19] ),
    .i_20    (tr_in_data[20] ),
    .i_21    (tr_in_data[21] ),
    .i_22    (tr_in_data[22] ),
    .i_23    (tr_in_data[23] ),
    .i_24    (tr_in_data[24] ),
    .i_25    (tr_in_data[25] ),
    .i_26    (tr_in_data[26] ),
    .i_27    (tr_in_data[27] ),
    .i_28    (tr_in_data[28] ),
    .i_29    (tr_in_data[29] ),
    .i_30    (tr_in_data[30] ),
    .i_31    (tr_in_data[31] ),
//output parameter
    .o_size  (calculate_out_size    ),
    .o_valid (calculate_out_valid   ),
//output 1st stage's coeff
    .o_0     (calculate_out_data[0 ] ),
    .o_1     (calculate_out_data[1 ] ),
    .o_2     (calculate_out_data[2 ] ),
    .o_3     (calculate_out_data[3 ] ),
    .o_4     (calculate_out_data[4 ] ),
    .o_5     (calculate_out_data[5 ] ),
    .o_6     (calculate_out_data[6 ] ),
    .o_7     (calculate_out_data[7 ] ),
    .o_8     (calculate_out_data[8 ] ),
    .o_9     (calculate_out_data[9 ] ),
    .o_10    (calculate_out_data[10] ),
    .o_11    (calculate_out_data[11] ),
    .o_12    (calculate_out_data[12] ),
    .o_13    (calculate_out_data[13] ),
    .o_14    (calculate_out_data[14] ),
    .o_15    (calculate_out_data[15] ),
    .o_16    (calculate_out_data[16] ),
    .o_17    (calculate_out_data[17] ),
    .o_18    (calculate_out_data[18] ),
    .o_19    (calculate_out_data[19] ),
    .o_20    (calculate_out_data[20] ),
    .o_21    (calculate_out_data[21] ),
    .o_22    (calculate_out_data[22] ),
    .o_23    (calculate_out_data[23] ),
    .o_24    (calculate_out_data[24] ),
    .o_25    (calculate_out_data[25] ),
    .o_26    (calculate_out_data[26] ),
    .o_27    (calculate_out_data[27] ),
    .o_28    (calculate_out_data[28] ),
    .o_29    (calculate_out_data[29] ),
    .o_30    (calculate_out_data[30] ),
    .o_31    (calculate_out_data[31] )
); 

//type mux out
always @(*) begin
    case (i_type_d[4]) 
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
    assign o_type   = i_type_d[5];
    assign o_size   = i_size_d[5];
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
