//describe  : 右移保持系数在16位，右移需要考虑四舍五入
//input     : 32个预处理系数,右移位数
//output    : 32个系数结果
//delay     : 1 clk
module right_shift#(
    parameter IN_WIDTH  = 21,
    parameter OUT_WIDTH = 16
)
(
//system input
    input                                   clk     ,
    input                                   rst_n   ,
//input parameter
    input               [3 : 0]             i_shift ,
//input pre_coeff
    input                                   i_valid ,
    input       signed  [IN_WIDTH - 1 : 0]  i_0     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_1     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_2     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_3     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_4     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_5     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_6     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_7     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_8     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_9     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_10    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_11    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_12    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_13    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_14    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_15    ,
//output coeff
    output reg                              o_valid ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_0     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_1     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_2     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_3     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_4     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_5     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_6     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_7     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_8     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_9     ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_10    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_11    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_12    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_13    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_14    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_15    
);

//右移(shift-1)位
    wire [3 : 0] shift1 = i_shift - 1;
    wire signed [OUT_WIDTH : 0] temp_0  = i_0  >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_1  = i_1  >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_2  = i_2  >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_3  = i_3  >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_4  = i_4  >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_5  = i_5  >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_6  = i_6  >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_7  = i_7  >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_8  = i_8  >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_9  = i_9  >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_10 = i_10 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_11 = i_11 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_12 = i_12 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_13 = i_13 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_14 = i_14 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_15 = i_15 >>> shift1;

//四舍五入后右移1位
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        o_valid <= 0;
        o_0     <= 0;
        o_1     <= 0;
        o_2     <= 0;
        o_3     <= 0;
        o_4     <= 0;
        o_5     <= 0;
        o_6     <= 0;
        o_7     <= 0;
        o_8     <= 0;
        o_9     <= 0;
        o_10    <= 0;
        o_11    <= 0;
        o_12    <= 0;
        o_13    <= 0;
        o_14    <= 0;
        o_15    <= 0;
    end
    else begin
        o_valid <= i_valid;
        o_0     <= (temp_0  + 1) >>> 1;
        o_1     <= (temp_1  + 1) >>> 1;
        o_2     <= (temp_2  + 1) >>> 1;
        o_3     <= (temp_3  + 1) >>> 1;
        o_4     <= (temp_4  + 1) >>> 1;
        o_5     <= (temp_5  + 1) >>> 1;
        o_6     <= (temp_6  + 1) >>> 1;
        o_7     <= (temp_7  + 1) >>> 1;
        o_8     <= (temp_8  + 1) >>> 1;
        o_9     <= (temp_9  + 1) >>> 1;
        o_10    <= (temp_10 + 1) >>> 1;
        o_11    <= (temp_11 + 1) >>> 1;
        o_12    <= (temp_12 + 1) >>> 1;
        o_13    <= (temp_13 + 1) >>> 1;
        o_14    <= (temp_14 + 1) >>> 1;
        o_15    <= (temp_15 + 1) >>> 1;
    end
end

endmodule
