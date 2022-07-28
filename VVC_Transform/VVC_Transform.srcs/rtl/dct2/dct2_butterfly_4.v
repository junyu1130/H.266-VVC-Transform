//describe  : �Դ�СΪ4��DCT2�任���ɵ������㵥Ԫ
//input     : 4��ԭ����
//output    : 4���������㵥Ԫ -> cal4
//delay     : 1 clk
module dct2_butterfly_4#(
    parameter IN_WIDTH = 20
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
    output reg  signed  [IN_WIDTH     : 0]  o_0     ,//E
    output reg  signed  [IN_WIDTH     : 0]  o_1     ,
    output reg  signed  [IN_WIDTH     : 0]  o_2     ,//O
    output reg  signed  [IN_WIDTH     : 0]  o_3     
);

//���ɵ������㵥Ԫ
//E/O
    wire signed [IN_WIDTH : 0] E_0 = i_0 + i_3;
    wire signed [IN_WIDTH : 0] E_1 = i_1 + i_2;
    wire signed [IN_WIDTH : 0] O_0 = i_0 - i_3;
    wire signed [IN_WIDTH : 0] O_1 = i_1 - i_2;

//output
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        o_valid <= 0;
        o_0     <= 0;
        o_1     <= 0;
        o_2     <= 0;
        o_3     <= 0;
    end
    else begin
        o_valid <= i_valid;
        o_0     <= E_0;
        o_1     <= E_1;
        o_2     <= O_0;
        o_3     <= O_1;
    end
end

endmodule
