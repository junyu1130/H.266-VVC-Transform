//describe  : �Դ�СΪ4��DCT2�任���ɵ������㵥Ԫ
//input     : 4��ԭ����
//output    : 4���������㵥Ԫ
//delay     : 0 clk
module dct2_butterfly4#(
    parameter IN_WIDTH = 20
)
(
//input data
    input   signed  [IN_WIDTH - 1 : 0]  i_0     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_1     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_2     ,
    input   signed  [IN_WIDTH - 1 : 0]  i_3     ,
//output data
    output  signed  [IN_WIDTH     : 0]  o_0     ,//E
    output  signed  [IN_WIDTH     : 0]  o_1     ,
    output  signed  [IN_WIDTH     : 0]  o_2     ,//O
    output  signed  [IN_WIDTH     : 0]  o_3     
);

//���ɵ������㵥Ԫ
//E/O
    wire signed [IN_WIDTH : 0] E_0 = i_0 + i_3;
    wire signed [IN_WIDTH : 0] E_1 = i_1 + i_2;
    wire signed [IN_WIDTH : 0] O_0 = i_0 - i_3;
    wire signed [IN_WIDTH : 0] O_1 = i_1 - i_2;

//output
    assign o_0 = E_0;
    assign o_1 = E_1;
    assign o_2 = O_0;
    assign o_3 = O_1;

endmodule
