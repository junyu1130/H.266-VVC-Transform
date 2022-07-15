//describe  : 右移保持系数在16位，右移需要考虑四舍五入
//input     : 64个预处理系数,右移位数
//output    : 64个系数结果
//delay     : 1 clk
module right_shift#(
    parameter IN_WIDTH  = 28,
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
    input       signed  [IN_WIDTH - 1 : 0]  i_32    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_33    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_34    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_35    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_36    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_37    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_38    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_39    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_40    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_41    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_42    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_43    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_44    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_45    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_46    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_47    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_48    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_49    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_50    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_51    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_52    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_53    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_54    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_55    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_56    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_57    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_58    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_59    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_60    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_61    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_62    ,
    input       signed  [IN_WIDTH - 1 : 0]  i_63    ,
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
    output reg  signed  [OUT_WIDTH - 1 : 0] o_15    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_16    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_17    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_18    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_19    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_20    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_21    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_22    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_23    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_24    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_25    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_26    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_27    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_28    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_29    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_30    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_31    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_32    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_33    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_34    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_35    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_36    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_37    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_38    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_39    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_40    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_41    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_42    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_43    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_44    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_45    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_46    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_47    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_48    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_49    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_50    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_51    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_52    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_53    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_54    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_55    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_56    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_57    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_58    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_59    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_60    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_61    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_62    ,
    output reg  signed  [OUT_WIDTH - 1 : 0] o_63
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
    wire signed [OUT_WIDTH : 0] temp_16 = i_16 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_17 = i_17 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_18 = i_18 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_19 = i_19 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_20 = i_20 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_21 = i_21 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_22 = i_22 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_23 = i_23 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_24 = i_24 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_25 = i_25 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_26 = i_26 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_27 = i_27 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_28 = i_28 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_29 = i_29 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_30 = i_30 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_31 = i_31 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_32 = i_32 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_33 = i_33 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_34 = i_34 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_35 = i_35 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_36 = i_36 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_37 = i_37 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_38 = i_38 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_39 = i_39 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_40 = i_40 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_41 = i_41 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_42 = i_42 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_43 = i_43 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_44 = i_44 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_45 = i_45 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_46 = i_46 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_47 = i_47 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_48 = i_48 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_49 = i_49 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_50 = i_50 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_51 = i_51 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_52 = i_52 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_53 = i_53 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_54 = i_54 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_55 = i_55 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_56 = i_56 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_57 = i_57 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_58 = i_58 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_59 = i_59 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_60 = i_60 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_61 = i_61 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_62 = i_62 >>> shift1;
    wire signed [OUT_WIDTH : 0] temp_63 = i_63 >>> shift1;

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
        o_16    <= 0;
        o_17    <= 0;
        o_18    <= 0;
        o_19    <= 0;
        o_20    <= 0;
        o_21    <= 0;
        o_22    <= 0;
        o_23    <= 0;
        o_24    <= 0;
        o_25    <= 0;
        o_26    <= 0;
        o_27    <= 0;
        o_28    <= 0;
        o_29    <= 0;
        o_30    <= 0;
        o_31    <= 0;
        o_32    <= 0;
        o_33    <= 0;
        o_34    <= 0;
        o_35    <= 0;
        o_36    <= 0;
        o_37    <= 0;
        o_38    <= 0;
        o_39    <= 0;
        o_40    <= 0;
        o_41    <= 0;
        o_42    <= 0;
        o_43    <= 0;
        o_44    <= 0;
        o_45    <= 0;
        o_46    <= 0;
        o_47    <= 0;
        o_48    <= 0;
        o_49    <= 0;
        o_50    <= 0;
        o_51    <= 0;
        o_52    <= 0;
        o_53    <= 0;
        o_54    <= 0;
        o_55    <= 0;
        o_56    <= 0;
        o_57    <= 0;
        o_58    <= 0;
        o_59    <= 0;
        o_60    <= 0;
        o_61    <= 0;
        o_62    <= 0;
        o_63    <= 0;
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
        o_16    <= (temp_16 + 1) >>> 1;
        o_17    <= (temp_17 + 1) >>> 1;
        o_18    <= (temp_18 + 1) >>> 1;
        o_19    <= (temp_19 + 1) >>> 1;
        o_20    <= (temp_20 + 1) >>> 1;
        o_21    <= (temp_21 + 1) >>> 1;
        o_22    <= (temp_22 + 1) >>> 1;
        o_23    <= (temp_23 + 1) >>> 1;
        o_24    <= (temp_24 + 1) >>> 1;
        o_25    <= (temp_25 + 1) >>> 1;
        o_26    <= (temp_26 + 1) >>> 1;
        o_27    <= (temp_27 + 1) >>> 1;
        o_28    <= (temp_28 + 1) >>> 1;
        o_29    <= (temp_29 + 1) >>> 1;
        o_30    <= (temp_30 + 1) >>> 1;
        o_31    <= (temp_31 + 1) >>> 1;
        o_32    <= (temp_32 + 1) >>> 1;
        o_33    <= (temp_33 + 1) >>> 1;
        o_34    <= (temp_34 + 1) >>> 1;
        o_35    <= (temp_35 + 1) >>> 1;
        o_36    <= (temp_36 + 1) >>> 1;
        o_37    <= (temp_37 + 1) >>> 1;
        o_38    <= (temp_38 + 1) >>> 1;
        o_39    <= (temp_39 + 1) >>> 1;
        o_40    <= (temp_40 + 1) >>> 1;
        o_41    <= (temp_41 + 1) >>> 1;
        o_42    <= (temp_42 + 1) >>> 1;
        o_43    <= (temp_43 + 1) >>> 1;
        o_44    <= (temp_44 + 1) >>> 1;
        o_45    <= (temp_45 + 1) >>> 1;
        o_46    <= (temp_46 + 1) >>> 1;
        o_47    <= (temp_47 + 1) >>> 1;
        o_48    <= (temp_48 + 1) >>> 1;
        o_49    <= (temp_49 + 1) >>> 1;
        o_50    <= (temp_50 + 1) >>> 1;
        o_51    <= (temp_51 + 1) >>> 1;
        o_52    <= (temp_52 + 1) >>> 1;
        o_53    <= (temp_53 + 1) >>> 1;
        o_54    <= (temp_54 + 1) >>> 1;
        o_55    <= (temp_55 + 1) >>> 1;
        o_56    <= (temp_56 + 1) >>> 1;
        o_57    <= (temp_57 + 1) >>> 1;
        o_58    <= (temp_58 + 1) >>> 1;
        o_59    <= (temp_59 + 1) >>> 1;
        o_60    <= (temp_60 + 1) >>> 1;
        o_61    <= (temp_61 + 1) >>> 1;
        o_62    <= (temp_62 + 1) >>> 1;
        o_63    <= (temp_63 + 1) >>> 1;
    end
end

endmodule
