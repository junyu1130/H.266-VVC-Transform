//describe  : 对大小为16的DCT2变换生成蝶形运算单元
//input     : 16个原数据
//output    : 16个蝶形运算单元 -> cal4, cal8, cal16
//delay     : 1 clk
module dct2_butterfly_16#(
    parameter IN_WIDTH = 18
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
    input       signed  [IN_WIDTH - 1 : 0]  i_8     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_9     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_10    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_11    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_12    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_13    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_14    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_15    ,
//output data
    output reg                              o_valid ,
    output reg  signed  [IN_WIDTH     : 0]  o_0     ,//E
    output reg  signed  [IN_WIDTH     : 0]  o_1     ,
    output reg  signed  [IN_WIDTH     : 0]  o_2     ,
    output reg  signed  [IN_WIDTH     : 0]  o_3     ,
    output reg  signed  [IN_WIDTH     : 0]  o_4     ,
    output reg  signed  [IN_WIDTH     : 0]  o_5     ,
    output reg  signed  [IN_WIDTH     : 0]  o_6     ,
    output reg  signed  [IN_WIDTH     : 0]  o_7     ,
    output reg  signed  [IN_WIDTH     : 0]  o_8     ,//O
    output reg  signed  [IN_WIDTH     : 0]  o_9     ,
    output reg  signed  [IN_WIDTH     : 0]  o_10    ,
    output reg  signed  [IN_WIDTH     : 0]  o_11    ,
    output reg  signed  [IN_WIDTH     : 0]  o_12    ,
    output reg  signed  [IN_WIDTH     : 0]  o_13    ,
    output reg  signed  [IN_WIDTH     : 0]  o_14    ,
    output reg  signed  [IN_WIDTH     : 0]  o_15    
);

//生成蝶形运算单元
//E/O
    wire signed [IN_WIDTH : 0] E_0 = i_0 + i_15;
    wire signed [IN_WIDTH : 0] E_1 = i_1 + i_14;
    wire signed [IN_WIDTH : 0] E_2 = i_2 + i_13;
    wire signed [IN_WIDTH : 0] E_3 = i_3 + i_12;
    wire signed [IN_WIDTH : 0] E_4 = i_4 + i_11;
    wire signed [IN_WIDTH : 0] E_5 = i_5 + i_10;
    wire signed [IN_WIDTH : 0] E_6 = i_6 + i_9 ;
    wire signed [IN_WIDTH : 0] E_7 = i_7 + i_8 ;
    wire signed [IN_WIDTH : 0] O_0 = i_0 - i_15;
    wire signed [IN_WIDTH : 0] O_1 = i_1 - i_14;
    wire signed [IN_WIDTH : 0] O_2 = i_2 - i_13;
    wire signed [IN_WIDTH : 0] O_3 = i_3 - i_12;
    wire signed [IN_WIDTH : 0] O_4 = i_4 - i_11;
    wire signed [IN_WIDTH : 0] O_5 = i_5 - i_10;
    wire signed [IN_WIDTH : 0] O_6 = i_6 - i_9 ;
    wire signed [IN_WIDTH : 0] O_7 = i_7 - i_8 ;

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
        o_8  <= 0;
        o_9  <= 0;
        o_10 <= 0;
        o_11 <= 0;
        o_12 <= 0;
        o_13 <= 0;
        o_14 <= 0;
        o_15 <= 0;
    end
    else begin
        o_valid <= i_valid;
        o_0  = E_0;
        o_1  = E_1;
        o_2  = E_2;
        o_3  = E_3;
        o_4  = E_4;
        o_5  = E_5;
        o_6  = E_6;
        o_7  = E_7;
        o_8  = O_0;
        o_9  = O_1;
        o_10 = O_2;
        o_11 = O_3;
        o_12 = O_4;
        o_13 = O_5;
        o_14 = O_6;
        o_15 = O_7;
    end
end

endmodule
