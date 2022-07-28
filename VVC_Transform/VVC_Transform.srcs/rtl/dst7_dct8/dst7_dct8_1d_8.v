//describe  : 正序输入DST7，倒序输入DCT8(1/3/5/7输出反号)，大小为8
//input     : 8个像素残差
//output    : 8个系数
//delay     : 4 clk
module dst7_dct8_1d_8#(
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
    input       signed  [IN_WIDTH - 1 : 0]  i_4     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_5     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_6     ,
    input       signed  [IN_WIDTH - 1 : 0]  i_7     ,
//output data
    output reg                              o_valid ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_0     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_1     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_2     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_3     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_4     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_5     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_6     ,
    output reg  signed  [IN_WIDTH + 10 : 0] o_7     
);

integer i;

//input
    reg i_valid_d1, i_valid_d2, i_valid_d3;
//mcm
//17 46 71 85 86 78 60 32 
    wire signed [IN_WIDTH + 10 : 0] i_0_16 = i_0 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] i_0_15 = i_0_16 - i_0;
    wire signed [IN_WIDTH + 10 : 0] i_0_17 = i_0 + i_0_16;
    wire signed [IN_WIDTH + 10 : 0] i_0_8  = i_0 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] i_0_23 = i_0_15 + i_0_8;
    wire signed [IN_WIDTH + 10 : 0] i_0_60 = i_0_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_0_43 = i_0_60 - i_0_17;
    wire signed [IN_WIDTH + 10 : 0] i_0_68 = i_0_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_0_85 = i_0_17 + i_0_68;
    wire signed [IN_WIDTH + 10 : 0] i_0_39 = i_0_23 + i_0_16;
    wire signed [IN_WIDTH + 10 : 0] i_0_86 = i_0_43 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_0_71 = i_0_86 - i_0_15;
    wire signed [IN_WIDTH + 10 : 0] i_0_46 = i_0_23 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_0_78 = i_0_39 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_0_32 = i_0 <<< 5;
//32 78 85 46 -17 -71 -86 -60 
    wire signed [IN_WIDTH + 10 : 0] i_1_16 = i_1 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] i_1_15 = i_1_16 - i_1;
    wire signed [IN_WIDTH + 10 : 0] i_1_17 = i_1 + i_1_16;
    wire signed [IN_WIDTH + 10 : 0] i_1_8  = i_1 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] i_1_23 = i_1_15 + i_1_8;
    wire signed [IN_WIDTH + 10 : 0] i_1_60 = i_1_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_1_43 = i_1_60 - i_1_17;
    wire signed [IN_WIDTH + 10 : 0] i_1_68 = i_1_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_1_85 = i_1_17 + i_1_68;
    wire signed [IN_WIDTH + 10 : 0] i_1_39 = i_1_23 + i_1_16;
    wire signed [IN_WIDTH + 10 : 0] i_1_86 = i_1_43 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_1_71 = i_1_86 - i_1_15;
    wire signed [IN_WIDTH + 10 : 0] i_1_32 = i_1 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] i_1_78 = i_1_39 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_1_46 = i_1_23 <<< 1;
//46 86 32 -60 -85 -17 71 78 
    wire signed [IN_WIDTH + 10 : 0] i_2_16 = i_2 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] i_2_15 = i_2_16 - i_2;
    wire signed [IN_WIDTH + 10 : 0] i_2_17 = i_2 + i_2_16;
    wire signed [IN_WIDTH + 10 : 0] i_2_8  = i_2 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] i_2_23 = i_2_15 + i_2_8;
    wire signed [IN_WIDTH + 10 : 0] i_2_60 = i_2_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_2_43 = i_2_60 - i_2_17;
    wire signed [IN_WIDTH + 10 : 0] i_2_68 = i_2_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_2_85 = i_2_17 + i_2_68;
    wire signed [IN_WIDTH + 10 : 0] i_2_39 = i_2_23 + i_2_16;
    wire signed [IN_WIDTH + 10 : 0] i_2_86 = i_2_43 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_2_71 = i_2_86 - i_2_15;
    wire signed [IN_WIDTH + 10 : 0] i_2_46 = i_2_23 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_2_32 = i_2 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] i_2_78 = i_2_39 <<< 1;
//60 71 -46 -78 32 85 -17 -86
    wire signed [IN_WIDTH + 10 : 0] i_3_16 = i_3 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] i_3_15 = i_3_16 - i_3;
    wire signed [IN_WIDTH + 10 : 0] i_3_17 = i_3 + i_3_16;
    wire signed [IN_WIDTH + 10 : 0] i_3_8  = i_3 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] i_3_23 = i_3_15 + i_3_8;
    wire signed [IN_WIDTH + 10 : 0] i_3_60 = i_3_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_3_43 = i_3_60 - i_3_17;
    wire signed [IN_WIDTH + 10 : 0] i_3_68 = i_3_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_3_85 = i_3_17 + i_3_68;
    wire signed [IN_WIDTH + 10 : 0] i_3_39 = i_3_23 + i_3_16;
    wire signed [IN_WIDTH + 10 : 0] i_3_86 = i_3_43 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_3_71 = i_3_86 - i_3_15;
    wire signed [IN_WIDTH + 10 : 0] i_3_46 = i_3_23 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_3_78 = i_3_39 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_3_32 = i_3 <<< 5;
//71 32 -86 17 78 -60 -46 85 
    wire signed [IN_WIDTH + 10 : 0] i_4_16 = i_4 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] i_4_15 = i_4_16 - i_4;
    wire signed [IN_WIDTH + 10 : 0] i_4_17 = i_4 + i_4_16;
    wire signed [IN_WIDTH + 10 : 0] i_4_8  = i_4 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] i_4_23 = i_4_15 + i_4_8;
    wire signed [IN_WIDTH + 10 : 0] i_4_60 = i_4_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_4_43 = i_4_60 - i_4_17;
    wire signed [IN_WIDTH + 10 : 0] i_4_68 = i_4_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_4_85 = i_4_17 + i_4_68;
    wire signed [IN_WIDTH + 10 : 0] i_4_39 = i_4_23 + i_4_16;
    wire signed [IN_WIDTH + 10 : 0] i_4_86 = i_4_43 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_4_71 = i_4_86 - i_4_15;
    wire signed [IN_WIDTH + 10 : 0] i_4_32 = i_4 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] i_4_78 = i_4_39 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_4_46 = i_4_23 <<< 1;
//78 -17 -60  86 -46 -32  85 -71
    wire signed [IN_WIDTH + 10 : 0] i_5_16 = i_5 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] i_5_15 = i_5_16 - i_5;
    wire signed [IN_WIDTH + 10 : 0] i_5_17 = i_5 + i_5_16;
    wire signed [IN_WIDTH + 10 : 0] i_5_8  = i_5 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] i_5_23 = i_5_15 + i_5_8;
    wire signed [IN_WIDTH + 10 : 0] i_5_60 = i_5_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_5_43 = i_5_60 - i_5_17;
    wire signed [IN_WIDTH + 10 : 0] i_5_68 = i_5_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_5_85 = i_5_17 + i_5_68;
    wire signed [IN_WIDTH + 10 : 0] i_5_39 = i_5_23 + i_5_16;
    wire signed [IN_WIDTH + 10 : 0] i_5_86 = i_5_43 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_5_71 = i_5_86 - i_5_15;
    wire signed [IN_WIDTH + 10 : 0] i_5_78 = i_5_39 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_5_46 = i_5_23 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_5_32 = i_5 <<< 5;
//85 -60  17  32 -71  86 -78  46
    wire signed [IN_WIDTH + 10 : 0] i_6_16 = i_6 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] i_6_15 = i_6_16 - i_6;
    wire signed [IN_WIDTH + 10 : 0] i_6_17 = i_6 + i_6_16;
    wire signed [IN_WIDTH + 10 : 0] i_6_8  = i_6 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] i_6_23 = i_6_15 + i_6_8;
    wire signed [IN_WIDTH + 10 : 0] i_6_60 = i_6_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_6_43 = i_6_60 - i_6_17;
    wire signed [IN_WIDTH + 10 : 0] i_6_68 = i_6_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_6_85 = i_6_17 + i_6_68;
    wire signed [IN_WIDTH + 10 : 0] i_6_39 = i_6_23 + i_6_16;
    wire signed [IN_WIDTH + 10 : 0] i_6_86 = i_6_43 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_6_71 = i_6_86 - i_6_15;
    wire signed [IN_WIDTH + 10 : 0] i_6_32 = i_6 <<< 5;
    wire signed [IN_WIDTH + 10 : 0] i_6_78 = i_6_39 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_6_46 = i_6_23 <<< 1;
//86 -85  78 -71  60 -46  32 -17 
    wire signed [IN_WIDTH + 10 : 0] i_7_16 = i_7 <<< 4;
    wire signed [IN_WIDTH + 10 : 0] i_7_15 = i_7_16 - i_7;
    wire signed [IN_WIDTH + 10 : 0] i_7_17 = i_7 + i_7_16;
    wire signed [IN_WIDTH + 10 : 0] i_7_8  = i_7 <<< 3;
    wire signed [IN_WIDTH + 10 : 0] i_7_23 = i_7_15 + i_7_8;
    wire signed [IN_WIDTH + 10 : 0] i_7_60 = i_7_15 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_7_43 = i_7_60 - i_7_17;
    wire signed [IN_WIDTH + 10 : 0] i_7_68 = i_7_17 <<< 2;
    wire signed [IN_WIDTH + 10 : 0] i_7_85 = i_7_17 + i_7_68;
    wire signed [IN_WIDTH + 10 : 0] i_7_39 = i_7_23 + i_7_16;
    wire signed [IN_WIDTH + 10 : 0] i_7_86 = i_7_43 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_7_71 = i_7_86 - i_7_15;
    wire signed [IN_WIDTH + 10 : 0] i_7_78 = i_7_39 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_7_46 = i_7_23 <<< 1;
    wire signed [IN_WIDTH + 10 : 0] i_7_32 = i_7 <<< 5;

//stage1 reg
    reg signed [IN_WIDTH + 10 : 0] i_0_17_r, i_0_46_r, i_0_71_r, i_0_85_r, i_0_86_r, i_0_78_r, i_0_60_r, i_0_32_r; 
    reg signed [IN_WIDTH + 10 : 0] i_1_32_r, i_1_78_r, i_1_85_r, i_1_46_r, i_1_17_r, i_1_71_r, i_1_86_r, i_1_60_r;
    reg signed [IN_WIDTH + 10 : 0] i_2_46_r, i_2_86_r, i_2_32_r, i_2_60_r, i_2_85_r, i_2_17_r, i_2_71_r, i_2_78_r; 
    reg signed [IN_WIDTH + 10 : 0] i_3_60_r, i_3_71_r, i_3_46_r, i_3_78_r, i_3_32_r, i_3_85_r, i_3_17_r, i_3_86_r;
    reg signed [IN_WIDTH + 10 : 0] i_4_71_r, i_4_32_r, i_4_86_r, i_4_17_r, i_4_78_r, i_4_60_r, i_4_46_r, i_4_85_r;
    reg signed [IN_WIDTH + 10 : 0] i_5_78_r, i_5_17_r, i_5_60_r, i_5_86_r, i_5_46_r, i_5_32_r, i_5_85_r, i_5_71_r;
    reg signed [IN_WIDTH + 10 : 0] i_6_85_r, i_6_60_r, i_6_17_r, i_6_32_r, i_6_71_r, i_6_86_r, i_6_78_r, i_6_46_r;
    reg signed [IN_WIDTH + 10 : 0] i_7_86_r, i_7_85_r, i_7_78_r, i_7_71_r, i_7_60_r, i_7_46_r, i_7_32_r, i_7_17_r;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d1 <= 0;
        i_0_17_r <= 0; i_1_32_r <= 0; i_2_46_r <= 0; i_3_60_r <= 0; i_4_71_r <= 0; i_5_78_r <= 0; i_6_85_r <= 0; i_7_86_r <= 0;
        i_0_46_r <= 0; i_1_78_r <= 0; i_2_86_r <= 0; i_3_71_r <= 0; i_4_32_r <= 0; i_5_17_r <= 0; i_6_60_r <= 0; i_7_85_r <= 0;
        i_0_71_r <= 0; i_1_85_r <= 0; i_2_32_r <= 0; i_3_46_r <= 0; i_4_86_r <= 0; i_5_60_r <= 0; i_6_17_r <= 0; i_7_78_r <= 0;
        i_0_85_r <= 0; i_1_46_r <= 0; i_2_60_r <= 0; i_3_78_r <= 0; i_4_17_r <= 0; i_5_86_r <= 0; i_6_32_r <= 0; i_7_71_r <= 0;
        i_0_86_r <= 0; i_1_17_r <= 0; i_2_85_r <= 0; i_3_32_r <= 0; i_4_78_r <= 0; i_5_46_r <= 0; i_6_71_r <= 0; i_7_60_r <= 0;
        i_0_78_r <= 0; i_1_71_r <= 0; i_2_17_r <= 0; i_3_85_r <= 0; i_4_60_r <= 0; i_5_32_r <= 0; i_6_86_r <= 0; i_7_46_r <= 0;
        i_0_60_r <= 0; i_1_86_r <= 0; i_2_71_r <= 0; i_3_17_r <= 0; i_4_46_r <= 0; i_5_85_r <= 0; i_6_78_r <= 0; i_7_32_r <= 0;
        i_0_32_r <= 0; i_1_60_r <= 0; i_2_78_r <= 0; i_3_86_r <= 0; i_4_85_r <= 0; i_5_71_r <= 0; i_6_46_r <= 0; i_7_17_r <= 0;
    end
    else begin
        i_valid_d1 <= i_valid;
        i_0_17_r <= i_0_17; i_1_32_r <= i_1_32; i_2_46_r <= i_2_46; i_3_60_r <= i_3_60; i_4_71_r <= i_4_71; i_5_78_r <= i_5_78; i_6_85_r <= i_6_85; i_7_86_r <= i_7_86;
        i_0_46_r <= i_0_46; i_1_78_r <= i_1_78; i_2_86_r <= i_2_86; i_3_71_r <= i_3_71; i_4_32_r <= i_4_32; i_5_17_r <= i_5_17; i_6_60_r <= i_6_60; i_7_85_r <= i_7_85;
        i_0_71_r <= i_0_71; i_1_85_r <= i_1_85; i_2_32_r <= i_2_32; i_3_46_r <= i_3_46; i_4_86_r <= i_4_86; i_5_60_r <= i_5_60; i_6_17_r <= i_6_17; i_7_78_r <= i_7_78;
        i_0_85_r <= i_0_85; i_1_46_r <= i_1_46; i_2_60_r <= i_2_60; i_3_78_r <= i_3_78; i_4_17_r <= i_4_17; i_5_86_r <= i_5_86; i_6_32_r <= i_6_32; i_7_71_r <= i_7_71;
        i_0_86_r <= i_0_86; i_1_17_r <= i_1_17; i_2_85_r <= i_2_85; i_3_32_r <= i_3_32; i_4_78_r <= i_4_78; i_5_46_r <= i_5_46; i_6_71_r <= i_6_71; i_7_60_r <= i_7_60;
        i_0_78_r <= i_0_78; i_1_71_r <= i_1_71; i_2_17_r <= i_2_17; i_3_85_r <= i_3_85; i_4_60_r <= i_4_60; i_5_32_r <= i_5_32; i_6_86_r <= i_6_86; i_7_46_r <= i_7_46;
        i_0_60_r <= i_0_60; i_1_86_r <= i_1_86; i_2_71_r <= i_2_71; i_3_17_r <= i_3_17; i_4_46_r <= i_4_46; i_5_85_r <= i_5_85; i_6_78_r <= i_6_78; i_7_32_r <= i_7_32;
        i_0_32_r <= i_0_32; i_1_60_r <= i_1_60; i_2_78_r <= i_2_78; i_3_86_r <= i_3_86; i_4_85_r <= i_4_85; i_5_71_r <= i_5_71; i_6_46_r <= i_6_46; i_7_17_r <= i_7_17;
    end
end

//stage 2 sum
reg signed  [IN_WIDTH + 10 : 0] sum0_0[0 : 7], sum0_1[0 : 7], sum0_2[0 : 7], sum0_3[0 : 7];
reg signed  [IN_WIDTH + 10 : 0] sum1_0[0 : 7], sum1_1[0 : 7];

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d2 <= 0;
        for (i = 0; i < 8; i = i + 1) begin
            sum0_0[i] <= 0; sum0_1[i] <= 0; sum0_2[i] <= 0; sum0_3[i] <= 0; 
        end
    end
    else begin
        i_valid_d2 <= i_valid_d1;
        sum0_0[0] <= i_0_17_r + i_1_32_r; sum0_1[0] <= i_2_46_r + i_3_60_r; sum0_2[0] <= i_4_71_r + i_5_78_r; sum0_3[0] <= i_6_85_r + i_7_86_r;
        sum0_0[1] <= i_0_46_r + i_1_78_r; sum0_1[1] <= i_2_86_r + i_3_71_r; sum0_2[1] <= i_4_32_r - i_5_17_r; sum0_3[1] <= i_6_60_r + i_7_85_r;
        sum0_0[2] <= i_0_71_r + i_1_85_r; sum0_1[2] <= i_2_32_r - i_3_46_r; sum0_2[2] <= i_4_86_r + i_5_60_r; sum0_3[2] <= i_6_17_r + i_7_78_r;
        sum0_0[3] <= i_0_85_r + i_1_46_r; sum0_1[3] <= i_2_60_r + i_3_78_r; sum0_2[3] <= i_4_17_r + i_5_86_r; sum0_3[3] <= i_6_32_r - i_7_71_r;
        sum0_0[4] <= i_0_86_r - i_1_17_r; sum0_1[4] <= i_2_85_r - i_3_32_r; sum0_2[4] <= i_4_78_r - i_5_46_r; sum0_3[4] <= i_6_71_r - i_7_60_r;
        sum0_0[5] <= i_0_78_r - i_1_71_r; sum0_1[5] <= i_2_17_r - i_3_85_r; sum0_2[5] <= i_4_60_r + i_5_32_r; sum0_3[5] <= i_6_86_r - i_7_46_r;
        sum0_0[6] <= i_0_60_r - i_1_86_r; sum0_1[6] <= i_2_71_r - i_3_17_r; sum0_2[6] <= i_4_46_r - i_5_85_r; sum0_3[6] <= i_6_78_r - i_7_32_r;
        sum0_0[7] <= i_0_32_r - i_1_60_r; sum0_1[7] <= i_2_78_r - i_3_86_r; sum0_2[7] <= i_4_85_r - i_5_71_r; sum0_3[7] <= i_6_46_r - i_7_17_r;
    end
end

//stage 3
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        i_valid_d3 <= 0;
        for (i = 0; i < 8; i = i + 1) begin
            sum1_0[i] <= 0; sum1_1[i] <= 0;
        end
    end
    else begin
        i_valid_d3 <= i_valid_d2;
        sum1_0[0] <= sum0_0[0] + sum0_1[0]; sum1_1[0] <= sum0_2[0] + sum0_3[0];
        sum1_0[1] <= sum0_0[1] + sum0_1[1]; sum1_1[1] <= sum0_2[1] - sum0_3[1];
        sum1_0[2] <= sum0_0[2] + sum0_1[2]; sum1_1[2] <= sum0_2[2] - sum0_3[2];
        sum1_0[3] <= sum0_0[3] - sum0_1[3]; sum1_1[3] <= sum0_2[3] + sum0_3[3];
        sum1_0[4] <= sum0_0[4] - sum0_1[4]; sum1_1[4] <= sum0_2[4] - sum0_3[4];
        sum1_0[5] <= sum0_0[5] - sum0_1[5]; sum1_1[5] <= sum0_2[5] - sum0_3[5];
        sum1_0[6] <= sum0_0[6] + sum0_1[6]; sum1_1[6] <= sum0_2[6] + sum0_3[6];
        sum1_0[7] <= sum0_0[7] + sum0_1[7]; sum1_1[7] <= sum0_2[7] + sum0_3[7];
    end
end

//stage 4
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        o_valid <= 0;
        o_0 <= 0;
        o_1 <= 0;
        o_2 <= 0;
        o_3 <= 0;
        o_4 <= 0;
        o_5 <= 0;
        o_6 <= 0;
        o_7 <= 0;
    end
    else begin
        o_valid <= i_valid_d3;
        o_0 <= sum1_0[0] + sum1_1[0];
        o_1 <= sum1_0[1] + sum1_1[1];
        o_2 <= sum1_0[2] - sum1_1[2];
        o_3 <= sum1_0[3] + sum1_1[3];
        o_4 <= sum1_0[4] + sum1_1[4];
        o_5 <= sum1_0[5] - sum1_1[5];
        o_6 <= sum1_0[6] - sum1_1[6];
        o_7 <= sum1_0[7] + sum1_1[7];
    end
end

endmodule
