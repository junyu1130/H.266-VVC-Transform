//describe  : 对大小为8的DCT2变换生成蝶形运算单元
//input     : 8个原数据
//output    : 8个蝶形运算单元 -> cal4, cal8
//delay     : 1 clk
module dct2_butterfly_8#(
    parameter IN_WIDTH = 19
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
    input       signed  [IN_WIDTH - 1 : 0]  i_4     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_5     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_6     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_7     ,
//output data
    output reg                              o_valid ,
    output reg  signed  [IN_WIDTH     : 0]  o_0     ,//E
    output reg  signed  [IN_WIDTH     : 0]  o_1     ,
    output reg  signed  [IN_WIDTH     : 0]  o_2     ,
    output reg  signed  [IN_WIDTH     : 0]  o_3     ,
    output reg  signed  [IN_WIDTH     : 0]  o_4     ,//O
    output reg  signed  [IN_WIDTH     : 0]  o_5     ,
    output reg  signed  [IN_WIDTH     : 0]  o_6     ,
    output reg  signed  [IN_WIDTH     : 0]  o_7     
);

//生成蝶形运算单元
//E/O
    wire signed [IN_WIDTH : 0] E_0 = i_0 + i_7;
    wire signed [IN_WIDTH : 0] E_1 = i_1 + i_6;
    wire signed [IN_WIDTH : 0] E_2 = i_2 + i_5;
    wire signed [IN_WIDTH : 0] E_3 = i_3 + i_4;
    wire signed [IN_WIDTH : 0] O_0 = i_0 - i_7;
    wire signed [IN_WIDTH : 0] O_1 = i_1 - i_6;
    wire signed [IN_WIDTH : 0] O_2 = i_2 - i_5;
    wire signed [IN_WIDTH : 0] O_3 = i_3 - i_4;

//output
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        o_valid <= 0;
        o_0  <= 0;
        o_1  <= 0;
        o_2  <= 0;
        o_3  <= 0;
        o_4  <= 0;
        o_5  <= 0;
        o_6  <= 0;
        o_7  <= 0;
    end
    else begin
        o_valid <= i_valid;
        o_0  = E_0;
        o_1  = E_1;
        o_2  = E_2;
        o_3  = E_3;
        o_4  = O_0;
        o_5  = O_1;
        o_6  = O_2;
        o_7  = O_3;
    end
end

endmodule
