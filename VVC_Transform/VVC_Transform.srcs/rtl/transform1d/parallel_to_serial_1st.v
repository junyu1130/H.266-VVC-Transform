//describe  : ²¢×ª´®
//input     : 32 data
//output    : 16 data
//delay     : 1 clk
module parallel_to_serial_1st#(
    parameter  IN_WIDTH  = 16,
    parameter  OUT_WIDTH = 16
)
(
//system input
    input                               clk     ,
    input                               rst_n   ,
//input parameter
    input           [1 : 0]             i_type  ,//0:DCT2 1:DCT8 2:DST7  
    input           [2 : 0]             i_width ,//1:4x4, 2:8x8, 3:16x16, 4:32x32, 5:64x64
    input           [2 : 0]             i_height,
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
    output          [1 : 0]             o_type  , 
    output          [2 : 0]             o_width ,
    output          [2 : 0]             o_height,
//output data
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
    output  signed  [OUT_WIDTH - 1 : 0] o_15    
);

localparam  SIZE4  = 3'd1,
            SIZE8  = 3'd2,
            SIZE16 = 3'd3,
            SIZE32 = 3'd4,
            SIZE64 = 3'd5;
integer i;

//input delay
    wire signed [IN_WIDTH - 1 : 0] i_data0[0 : 15], i_data1[0 : 15];
    reg [1 : 0] i_type_d1;
    reg [2 : 0] i_width_d1;
    reg [2 : 0] i_height_d1;
    reg i_valid_d1;
    reg signed [IN_WIDTH - 1 : 0] i_data1_d1[0 : 15];
//serial to parallel
    reg [1 : 0] count;
    reg [1 : 0] count_max;
    reg signed [OUT_WIDTH - 1 : 0] o_data[0 : 15];

//input
    assign i_data0[0 ] = i_0 ;
    assign i_data0[1 ] = i_1 ;
    assign i_data0[2 ] = i_2 ;
    assign i_data0[3 ] = i_3 ;
    assign i_data0[4 ] = i_4 ;
    assign i_data0[5 ] = i_5 ;
    assign i_data0[6 ] = i_6 ;
    assign i_data0[7 ] = i_7 ;
    assign i_data0[8 ] = i_8 ;
    assign i_data0[9 ] = i_9 ;
    assign i_data0[10] = i_10;
    assign i_data0[11] = i_11;
    assign i_data0[12] = i_12;
    assign i_data0[13] = i_13;
    assign i_data0[14] = i_14;
    assign i_data0[15] = i_15;
    assign i_data1[0 ] = i_16;
    assign i_data1[1 ] = i_17;
    assign i_data1[2 ] = i_18;
    assign i_data1[3 ] = i_19;
    assign i_data1[4 ] = i_20;
    assign i_data1[5 ] = i_21;
    assign i_data1[6 ] = i_22;
    assign i_data1[7 ] = i_23;
    assign i_data1[8 ] = i_24;
    assign i_data1[9 ] = i_25;
    assign i_data1[10] = i_26;
    assign i_data1[11] = i_27;
    assign i_data1[12] = i_28;
    assign i_data1[13] = i_29;
    assign i_data1[14] = i_30;
    assign i_data1[15] = i_31;

//delay
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin 
        i_type_d1 <= 0;
        i_width_d1 <= 0;
        i_height_d1 <= 0;
        i_valid_d1 <= 0; 
        for (i = 0; i < 16; i = i + 1) begin
            i_data1_d1[i] <= 0;
        end
    end
    else begin
        i_type_d1 <= i_type;
        i_width_d1 <= i_width;
        i_height_d1 <= i_height;
        i_valid_d1 <= i_valid;
        for (i = 0; i < 16; i = i + 1) begin
            i_data1_d1[i] <= i_data1[i]; 
        end
    end
end

always @(negedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count_max <= 0;
    end
    else if (i_valid) begin
        case (i_width) 
            SIZE64  : count_max <= 3;
            SIZE32  : count_max <= 1;
            default : count_max <= 0;
        endcase
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count <= 0;
        for (i = 0; i < 16; i = i + 1) begin
            o_data[i] <= 0;
        end
    end
    else begin
        if (count == count_max) begin
            count <= 0;
            case (count) 
                0 : begin
                    for (i = 0; i < 16; i = i + 1) begin
                        o_data[i] <= i_data0[i];
                    end
                end
                1 : begin
                    for (i = 0; i < 16; i = i + 1) begin
                        o_data[i] <= i_data1_d1[i];
                    end
                end
                2 : begin
                    for (i = 0; i < 16; i = i + 1) begin
                        o_data[i] <= 0;
                    end
                end
                3 : begin
                    for (i = 0; i < 16; i = i + 1) begin
                        o_data[i] <= 0;
                    end
                end
            endcase
        end
        else begin
            count <= count + 1;
            case (count) 
                0 : begin
                    for (i = 0; i < 16; i = i + 1) begin
                        o_data[i] <= i_data0[i];
                    end
                end
                1 : begin
                    for (i = 0; i < 16; i = i + 1) begin
                        o_data[i] <= i_data1_d1[i];
                    end
                end
                2 : begin
                    for (i = 0; i < 16; i = i + 1) begin
                        o_data[i] <= 0;
                    end
                end
                3 : begin
                    for (i = 0; i < 16; i = i + 1) begin
                        o_data[i] <= 0;
                    end
                end
            endcase
        end
    end
end

//output
    assign o_type   = i_type_d1;
    assign o_width  = i_width_d1;
    assign o_height = i_height_d1;
    assign o_valid  = i_valid_d1;
    assign o_0      = o_data[0 ];
    assign o_1      = o_data[1 ];
    assign o_2      = o_data[2 ];
    assign o_3      = o_data[3 ];
    assign o_4      = o_data[4 ];
    assign o_5      = o_data[5 ];
    assign o_6      = o_data[6 ];
    assign o_7      = o_data[7 ];
    assign o_8      = o_data[8 ];
    assign o_9      = o_data[9 ];
    assign o_10     = o_data[10];
    assign o_11     = o_data[11];
    assign o_12     = o_data[12];
    assign o_13     = o_data[13];
    assign o_14     = o_data[14];
    assign o_15     = o_data[15];

endmodule