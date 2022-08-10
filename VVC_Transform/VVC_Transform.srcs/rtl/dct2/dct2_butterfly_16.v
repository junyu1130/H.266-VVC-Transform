//describe  : 对大小为16的DCT2变换生成蝶形运算单元
//input     : 16个原数据
//output    : 16个蝶形运算单元 -> cal4, cal8, cal16
//delay     : 0 clk
module dct2_butterfly_16#(
    parameter IN_WIDTH = 18
)
(
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
    output                                  o_valid ,
    output      signed  [IN_WIDTH     : 0]  o_0     ,//E
    output      signed  [IN_WIDTH     : 0]  o_1     ,
    output      signed  [IN_WIDTH     : 0]  o_2     ,
    output      signed  [IN_WIDTH     : 0]  o_3     ,
    output      signed  [IN_WIDTH     : 0]  o_4     ,
    output      signed  [IN_WIDTH     : 0]  o_5     ,
    output      signed  [IN_WIDTH     : 0]  o_6     ,
    output      signed  [IN_WIDTH     : 0]  o_7     ,
    output      signed  [IN_WIDTH     : 0]  o_8     ,//O
    output      signed  [IN_WIDTH     : 0]  o_9     ,
    output      signed  [IN_WIDTH     : 0]  o_10    ,
    output      signed  [IN_WIDTH     : 0]  o_11    ,
    output      signed  [IN_WIDTH     : 0]  o_12    ,
    output      signed  [IN_WIDTH     : 0]  o_13    ,
    output      signed  [IN_WIDTH     : 0]  o_14    ,
    output      signed  [IN_WIDTH     : 0]  o_15    
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
    assign o_valid = i_valid;
    assign o_0     = E_0;
    assign o_1     = E_1;
    assign o_2     = E_2;
    assign o_3     = E_3;
    assign o_4     = E_4;
    assign o_5     = E_5;
    assign o_6     = E_6;
    assign o_7     = E_7;
    assign o_8     = O_0;
    assign o_9     = O_1;
    assign o_10    = O_2;
    assign o_11    = O_3;
    assign o_12    = O_4;
    assign o_13    = O_5;
    assign o_14    = O_6;
    assign o_15    = O_7;

endmodule
