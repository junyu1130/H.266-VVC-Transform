//describe  : 对大小为32的DCT2变换生成蝶形运算单元
//input     : 32个原数据
//output    : 32个不同的蝶形运算单元 -> cal4, cal8, cal16, cal32
//delay     : 1 clk
module butterfly_32#(
    parameter IN_WIDTH = 17
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
    input       signed  [IN_WIDTH - 1 : 0]  i_16    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_17    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_18    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_19    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_20    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_21    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_22    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_23    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_24    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_25    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_26    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_27    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_28    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_29    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_30    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_31    ,
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
    output reg  signed  [IN_WIDTH     : 0]  o_8     ,
    output reg  signed  [IN_WIDTH     : 0]  o_9     ,
    output reg  signed  [IN_WIDTH     : 0]  o_10    ,
    output reg  signed  [IN_WIDTH     : 0]  o_11    ,
    output reg  signed  [IN_WIDTH     : 0]  o_12    ,
    output reg  signed  [IN_WIDTH     : 0]  o_13    ,
    output reg  signed  [IN_WIDTH     : 0]  o_14    ,
    output reg  signed  [IN_WIDTH     : 0]  o_15    ,
    output reg  signed  [IN_WIDTH     : 0]  o_16    ,//O
    output reg  signed  [IN_WIDTH     : 0]  o_17    ,
    output reg  signed  [IN_WIDTH     : 0]  o_18    ,
    output reg  signed  [IN_WIDTH     : 0]  o_19    ,
    output reg  signed  [IN_WIDTH     : 0]  o_20    ,
    output reg  signed  [IN_WIDTH     : 0]  o_21    ,
    output reg  signed  [IN_WIDTH     : 0]  o_22    ,
    output reg  signed  [IN_WIDTH     : 0]  o_23    ,
    output reg  signed  [IN_WIDTH     : 0]  o_24    ,
    output reg  signed  [IN_WIDTH     : 0]  o_25    ,
    output reg  signed  [IN_WIDTH     : 0]  o_26    ,
    output reg  signed  [IN_WIDTH     : 0]  o_27    ,
    output reg  signed  [IN_WIDTH     : 0]  o_28    ,
    output reg  signed  [IN_WIDTH     : 0]  o_29    ,
    output reg  signed  [IN_WIDTH     : 0]  o_30    ,
    output reg  signed  [IN_WIDTH     : 0]  o_31    
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
        o_16 <= 0;
        o_17 <= 0;
        o_18 <= 0;
        o_19 <= 0;
        o_20 <= 0;
        o_21 <= 0;
        o_22 <= 0;
        o_23 <= 0;
        o_24 <= 0;
        o_25 <= 0;
        o_26 <= 0;
        o_27 <= 0;
        o_28 <= 0;
        o_29 <= 0;
        o_30 <= 0;
        o_31 <= 0;
    end
    else begin
        o_valid <= i_valid;
        o_0  = E_0 ;
        o_1  = E_1 ;
        o_2  = E_2 ;
        o_3  = E_3 ;
        o_4  = E_4 ;
        o_5  = E_5 ;
        o_6  = E_6 ;
        o_7  = E_7 ;
        o_8  = E_8 ;
        o_9  = E_9 ;
        o_10 = E_10;
        o_11 = E_11;
        o_12 = E_12;
        o_13 = E_13;
        o_14 = E_14;
        o_15 = E_15;
        o_16 = O_0 ;
        o_17 = O_1 ;
        o_18 = O_2 ;
        o_19 = O_3 ;
        o_20 = O_4 ;
        o_21 = O_5 ;
        o_22 = O_6 ;
        o_23 = O_7 ;
        o_24 = O_8 ;
        o_25 = O_9 ;
        o_26 = O_10;
        o_27 = O_11;
        o_28 = O_12;
        o_29 = O_13;
        o_30 = O_14;
        o_31 = O_15;
    end
end

endmodule
