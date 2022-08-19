//describe  : 对大小为32的DCT2变换生成蝶形运算单元
//input     : 32个原数据
//output    : 32个蝶形运算单元
//delay     : 0 clk
module dct2_butterfly32#(
    parameter IN_WIDTH = 17
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
//output data
    output  signed  [IN_WIDTH     : 0]  o_0     ,//E
    output  signed  [IN_WIDTH     : 0]  o_1     ,
    output  signed  [IN_WIDTH     : 0]  o_2     ,
    output  signed  [IN_WIDTH     : 0]  o_3     ,
    output  signed  [IN_WIDTH     : 0]  o_4     ,
    output  signed  [IN_WIDTH     : 0]  o_5     ,
    output  signed  [IN_WIDTH     : 0]  o_6     ,
    output  signed  [IN_WIDTH     : 0]  o_7     ,
    output  signed  [IN_WIDTH     : 0]  o_8     ,
    output  signed  [IN_WIDTH     : 0]  o_9     ,
    output  signed  [IN_WIDTH     : 0]  o_10    ,
    output  signed  [IN_WIDTH     : 0]  o_11    ,
    output  signed  [IN_WIDTH     : 0]  o_12    ,
    output  signed  [IN_WIDTH     : 0]  o_13    ,
    output  signed  [IN_WIDTH     : 0]  o_14    ,
    output  signed  [IN_WIDTH     : 0]  o_15    ,
    output  signed  [IN_WIDTH     : 0]  o_16    ,//O
    output  signed  [IN_WIDTH     : 0]  o_17    ,
    output  signed  [IN_WIDTH     : 0]  o_18    ,
    output  signed  [IN_WIDTH     : 0]  o_19    ,
    output  signed  [IN_WIDTH     : 0]  o_20    ,
    output  signed  [IN_WIDTH     : 0]  o_21    ,
    output  signed  [IN_WIDTH     : 0]  o_22    ,
    output  signed  [IN_WIDTH     : 0]  o_23    ,
    output  signed  [IN_WIDTH     : 0]  o_24    ,
    output  signed  [IN_WIDTH     : 0]  o_25    ,
    output  signed  [IN_WIDTH     : 0]  o_26    ,
    output  signed  [IN_WIDTH     : 0]  o_27    ,
    output  signed  [IN_WIDTH     : 0]  o_28    ,
    output  signed  [IN_WIDTH     : 0]  o_29    ,
    output  signed  [IN_WIDTH     : 0]  o_30    ,
    output  signed  [IN_WIDTH     : 0]  o_31    
);

//生成蝶形运算单元
//E/O
    wire signed [IN_WIDTH : 0] E_0  = i_0  + i_31;
    wire signed [IN_WIDTH : 0] E_1  = i_1  + i_30;
    wire signed [IN_WIDTH : 0] E_2  = i_2  + i_29;
    wire signed [IN_WIDTH : 0] E_3  = i_3  + i_28;
    wire signed [IN_WIDTH : 0] E_4  = i_4  + i_27;
    wire signed [IN_WIDTH : 0] E_5  = i_5  + i_26;
    wire signed [IN_WIDTH : 0] E_6  = i_6  + i_25;
    wire signed [IN_WIDTH : 0] E_7  = i_7  + i_24;
    wire signed [IN_WIDTH : 0] E_8  = i_8  + i_23;
    wire signed [IN_WIDTH : 0] E_9  = i_9  + i_22;
    wire signed [IN_WIDTH : 0] E_10 = i_10 + i_21;
    wire signed [IN_WIDTH : 0] E_11 = i_11 + i_20;
    wire signed [IN_WIDTH : 0] E_12 = i_12 + i_19;
    wire signed [IN_WIDTH : 0] E_13 = i_13 + i_18;
    wire signed [IN_WIDTH : 0] E_14 = i_14 + i_17;
    wire signed [IN_WIDTH : 0] E_15 = i_15 + i_16;
    wire signed [IN_WIDTH : 0] O_0  = i_0  - i_31;
    wire signed [IN_WIDTH : 0] O_1  = i_1  - i_30;
    wire signed [IN_WIDTH : 0] O_2  = i_2  - i_29;
    wire signed [IN_WIDTH : 0] O_3  = i_3  - i_28;
    wire signed [IN_WIDTH : 0] O_4  = i_4  - i_27;
    wire signed [IN_WIDTH : 0] O_5  = i_5  - i_26;
    wire signed [IN_WIDTH : 0] O_6  = i_6  - i_25;
    wire signed [IN_WIDTH : 0] O_7  = i_7  - i_24;
    wire signed [IN_WIDTH : 0] O_8  = i_8  - i_23;
    wire signed [IN_WIDTH : 0] O_9  = i_9  - i_22;
    wire signed [IN_WIDTH : 0] O_10 = i_10 - i_21;
    wire signed [IN_WIDTH : 0] O_11 = i_11 - i_20;
    wire signed [IN_WIDTH : 0] O_12 = i_12 - i_19;
    wire signed [IN_WIDTH : 0] O_13 = i_13 - i_18;
    wire signed [IN_WIDTH : 0] O_14 = i_14 - i_17;
    wire signed [IN_WIDTH : 0] O_15 = i_15 - i_16;

//output
    assign o_0  = E_0 ;
    assign o_1  = E_1 ;
    assign o_2  = E_2 ;
    assign o_3  = E_3 ;
    assign o_4  = E_4 ;
    assign o_5  = E_5 ;
    assign o_6  = E_6 ;
    assign o_7  = E_7 ;
    assign o_8  = E_8 ;
    assign o_9  = E_9 ;
    assign o_10 = E_10;
    assign o_11 = E_11;
    assign o_12 = E_12;
    assign o_13 = E_13;
    assign o_14 = E_14;
    assign o_15 = E_15;
    assign o_16 = O_0 ;
    assign o_17 = O_1 ;
    assign o_18 = O_2 ;
    assign o_19 = O_3 ;
    assign o_20 = O_4 ;
    assign o_21 = O_5 ;
    assign o_22 = O_6 ;
    assign o_23 = O_7 ;
    assign o_24 = O_8 ;
    assign o_25 = O_9 ;
    assign o_26 = O_10;
    assign o_27 = O_11;
    assign o_28 = O_12;
    assign o_29 = O_13;
    assign o_30 = O_14;
    assign o_31 = O_15;

endmodule
