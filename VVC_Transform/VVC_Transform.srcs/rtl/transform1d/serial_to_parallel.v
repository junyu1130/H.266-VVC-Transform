//describe  : ��ת��
//input     : 32 data
//output    : 64 data
//delay     : 2 clk
module serial_to_parallel#(
    parameter  IN_WIDTH  = 16,
    parameter  OUT_WIDTH = 16
)
(
//system input
    input                               clk     ,
    input                               rst_n   ,
//input parameter
    input           [2 : 0]             i_size  ,//1:4x4, 2:8x8, 3:16x16, 4:32x32, 5:64x64
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
    output  signed  [OUT_WIDTH - 1 : 0] o_31    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_32    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_33    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_34    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_35    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_36    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_37    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_38    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_39    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_40    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_41    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_42    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_43    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_44    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_45    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_46    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_47    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_48    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_49    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_50    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_51    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_52    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_53    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_54    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_55    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_56    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_57    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_58    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_59    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_60    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_61    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_62    ,
    output  signed  [OUT_WIDTH - 1 : 0] o_63
);

localparam  SIZE4  = 3'd1,
            SIZE8  = 3'd2,
            SIZE16 = 3'd3,
            SIZE32 = 3'd4,
            SIZE64 = 3'd5;
integer i;

//input delay
    wire signed [IN_WIDTH - 1 : 0] i_data[0 : 31];
    reg [2 : 0] i_size_d[0 : 1];
    reg i_valid_d1, i_valid_d2;
    reg signed [IN_WIDTH - 1 : 0] i_data_d1[0 : 31];
//serial to parallel
    reg count;
    reg count_max;
    reg signed [OUT_WIDTH - 1 : 0] o_data[0 : 63];

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
        i_size_d[0] <= 0;
        i_size_d[1] <= 0;
        i_valid_d1 <= 0;
        i_valid_d2 <= 0;
        for (i = 0; i < 32; i = i + 1) begin
            i_data_d1[i] <= 0; 
        end
    end
    else begin
        i_size_d[0] <= i_size;
        i_size_d[1] <= i_size_d[0];
        i_valid_d1 <= i_valid;
        i_valid_d2 <= i_valid_d1;
        for (i = 0; i < 32; i = i + 1) begin
            i_data_d1[i] <= i_data[i]; 
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count_max <= 0;
    end
    else begin
        case (i_size_d[0]) 
            SIZE64  : count_max <= 1;
            default : count_max <= 0;
        endcase
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count <= 0;
        for (i = 0; i < 64; i = i + 1) begin
            o_data[i] <= 0;
        end
    end
    else begin
        if (count == count_max) begin
            count <= 0;
            case (i_size_d[0])
                SIZE64  : begin // 2 beat -> 1 beat
                    if (i_size == SIZE64) begin
                        for (i = 0; i < 32; i = i + 1) begin
                            o_data[i]      <= i_data_d1[i];
                            o_data[i + 32] <= i_data[i];
                        end
                    end
                end
                default : begin //delay 2 clk
                    for (i = 0; i < 32; i = i + 1) begin
                        o_data[i]      <= i_data_d1[i];
                        o_data[i + 32] <= 0;
                    end
                end
            endcase
        end
        else begin
            count <= count + 1;
        end
    end
end

//output
    assign o_size   = i_size_d[1];
    assign o_valid  = i_valid_d2;
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
    assign o_16     = o_data[16];
    assign o_17     = o_data[17];
    assign o_18     = o_data[18];
    assign o_19     = o_data[19];
    assign o_20     = o_data[20];
    assign o_21     = o_data[21];
    assign o_22     = o_data[22];
    assign o_23     = o_data[23];
    assign o_24     = o_data[24];
    assign o_25     = o_data[25];
    assign o_26     = o_data[26];
    assign o_27     = o_data[27];
    assign o_28     = o_data[28];
    assign o_29     = o_data[29];
    assign o_30     = o_data[30];
    assign o_31     = o_data[31];
    assign o_32     = o_data[32];
    assign o_33     = o_data[33];
    assign o_34     = o_data[34];
    assign o_35     = o_data[35];
    assign o_36     = o_data[36];
    assign o_37     = o_data[37];
    assign o_38     = o_data[38];
    assign o_39     = o_data[39];
    assign o_40     = o_data[40];
    assign o_41     = o_data[41];
    assign o_42     = o_data[42];
    assign o_43     = o_data[43];
    assign o_44     = o_data[44];
    assign o_45     = o_data[45];
    assign o_46     = o_data[46];
    assign o_47     = o_data[47];
    assign o_48     = o_data[48];
    assign o_49     = o_data[49];
    assign o_50     = o_data[50];
    assign o_51     = o_data[51];
    assign o_52     = o_data[52];
    assign o_53     = o_data[53];
    assign o_54     = o_data[54];
    assign o_55     = o_data[55];
    assign o_56     = o_data[56];
    assign o_57     = o_data[57];
    assign o_58     = o_data[58];
    assign o_59     = o_data[59];
    assign o_60     = o_data[60];
    assign o_61     = o_data[61];
    assign o_62     = o_data[62];
    assign o_63     = o_data[63];

endmodule