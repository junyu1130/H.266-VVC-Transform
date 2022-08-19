//describe  : 对大小为8的DCT2变换生成蝶形运算单元
//input     : 8个原数据
//output    : 8个蝶形运算单元
//delay     : 0 clk
module dct2_butterfly8#(
    parameter IN_WIDTH = 19
)
(
//input data
    input   signed  [IN_WIDTH - 1 : 0]  i_0     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_1     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_2     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_3     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_4     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_5     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_6     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_7     ,
//output data
    output  signed  [IN_WIDTH     : 0]  o_0     ,//E
    output  signed  [IN_WIDTH     : 0]  o_1     ,
    output  signed  [IN_WIDTH     : 0]  o_2     ,
    output  signed  [IN_WIDTH     : 0]  o_3     ,
    output  signed  [IN_WIDTH     : 0]  o_4     ,//O
    output  signed  [IN_WIDTH     : 0]  o_5     ,
    output  signed  [IN_WIDTH     : 0]  o_6     ,
    output  signed  [IN_WIDTH     : 0]  o_7     
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
    assign o_0 = E_0;
    assign o_1 = E_1;
    assign o_2 = E_2;
    assign o_3 = E_3;
    assign o_4 = O_0;
    assign o_5 = O_1;
    assign o_6 = O_2;
    assign o_7 = O_3;
    
endmodule
