//describe  : 正序输入DST7，倒序输入DCT8(1、3输出反号)，大小为4
//input     : 4个像素残差
//output    : 4个系数
//delay     : 3 clk
module dst7_dct8_1d_4#(
    parameter IN_WIDTH = 16
)
(
//system input
    input                                   clk     ,
    input                                   rst_n   ,
//input data
    input                                   i_valid ,
    input       signed  [IN_WIDTH - 1 : 0]  i_0     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_1     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_2     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_3     ,
//output data
    output reg                              o_valid ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_0     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_1     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_2     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_3     
);

//input
    reg i_valid_d1, i_valid_d2;

//stage 1 butterfly
    wire signed [IN_WIDTH + 10 : 0] i_2_4 = i_2 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_2_5 = i_2 + i_2_4;
    wire signed [IN_WIDTH + 10 : 0] i_2_32 = i_2 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] i_2_37 = i_2_5 + i_2_32;
    wire signed [IN_WIDTH + 10 : 0] i_2_74 = i_2_37 <<< 1;
    reg signed [IN_WIDTH + 10 : 0] c_0;
    reg signed [IN_WIDTH + 10 : 0] c_1;
    reg signed [IN_WIDTH + 10 : 0] c_2;
    reg signed [IN_WIDTH + 10 : 0] c_3;
    reg signed [IN_WIDTH + 10 : 0] c_4;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d1 <= 0;
        c_0 <= 0;
        c_1 <= 0;
        c_2 <= 0;
        c_3 <= 0;
        c_4 <= 0;
    end
    else begin
        i_valid_d1 <= i_valid;
        c_0 <= i_0 + i_3;
        c_1 <= i_1 + i_3;
        c_2 <= i_0 - i_1;
        c_3 <= i_2_74;
        c_4 <= i_0 + i_1 - i_3;
    end
end

//mcm
//4 3 32 29 58 55
    wire signed [IN_WIDTH + 10 : 0] c_0_4 = c_0 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] c_0_3 = c_0_4 - c_0;
    wire signed [IN_WIDTH + 10 : 0] c_0_32 = c_0 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] c_0_29 = c_0_32 - c_0_3;
    wire signed [IN_WIDTH + 10 : 0] c_0_58 = c_0_29 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] c_0_55 = c_0_58 - c_0_3;

    wire signed [IN_WIDTH + 10 : 0] c_1_4 = c_1 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] c_1_3 = c_1_4 - c_1;
    wire signed [IN_WIDTH + 10 : 0] c_1_32 = c_1 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] c_1_29 = c_1_32 - c_1_3;
    wire signed [IN_WIDTH + 10 : 0] c_1_58 = c_1_29 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] c_1_55 = c_1_58 - c_1_3;

    wire signed [IN_WIDTH + 10 : 0] c_2_4 = c_2 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] c_2_3 = c_2_4 - c_2;
    wire signed [IN_WIDTH + 10 : 0] c_2_32 = c_2 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] c_2_29 = c_2_32 - c_2_3;
    wire signed [IN_WIDTH + 10 : 0] c_2_58 = c_2_29 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] c_2_55 = c_2_58 - c_2_3;

    wire signed [IN_WIDTH + 10 : 0] c_4_4 = c_4 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] c_4_5 = c_4 + c_4_4;
    wire signed [IN_WIDTH + 10 : 0] c_4_32 = c_4 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] c_4_37 = c_4_5 + c_4_32;
    wire signed [IN_WIDTH + 10 : 0] c_4_74 = c_4_37 <<< 1;

//stage 2 reg
    reg signed [IN_WIDTH + 10 : 0] c_3_r;
    reg signed [IN_WIDTH + 10 : 0] c_0_29_r;
    reg signed [IN_WIDTH + 10 : 0] c_1_55_r;
    reg signed [IN_WIDTH + 10 : 0] c_4_74_r;
    reg signed [IN_WIDTH + 10 : 0] c_2_29_r;
    reg signed [IN_WIDTH + 10 : 0] c_0_55_r;
    reg signed [IN_WIDTH + 10 : 0] c_2_55_r;
    reg signed [IN_WIDTH + 10 : 0] c_1_29_r;
    
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d2 <= 0;
        c_3_r      <= 0;
        c_0_29_r   <= 0;
        c_1_55_r   <= 0;
        c_4_74_r   <= 0;
        c_2_29_r   <= 0;
        c_0_55_r   <= 0;
        c_2_55_r   <= 0;
        c_1_29_r   <= 0;
    end
    else begin
        i_valid_d2 <= i_valid_d1;
        c_3_r      <= c_3;
        c_0_29_r   <= c_0_29;
        c_1_55_r   <= c_1_55;
        c_4_74_r   <= c_4_74;
        c_2_29_r   <= c_2_29;
        c_0_55_r   <= c_0_55;
        c_2_55_r   <= c_2_55;
        c_1_29_r   <= c_1_29;
    end
end

//stage 3 output
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        o_valid <= 0;
        o_0  <= 0;
        o_1  <= 0;
        o_2  <= 0;
        o_3  <= 0;
    end
    else begin
        o_valid <= i_valid_d2;
        o_0 <= c_0_29_r + c_1_55_r + c_3_r;
        o_1 <= c_4_74_r;
        o_2 <= c_2_29_r + c_0_55_r - c_3_r;
        o_3 <= c_2_55_r - c_1_29_r + c_3_r;
    end
end

endmodule
