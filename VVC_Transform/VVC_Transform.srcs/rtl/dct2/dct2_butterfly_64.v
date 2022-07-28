//describe  : 对大小为64的DCT2变换生成蝶形运算单元
//input     : 64个原数据
//output    : 64个蝶形运算单元 -> cal4, cal8, cal16, cal32, cal64
//delay     : 1 clk
module dct2_butterfly_64#(
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
    output reg  signed  [IN_WIDTH     : 0]  o_16    ,
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
    output reg  signed  [IN_WIDTH     : 0]  o_31    ,
    output reg  signed  [IN_WIDTH     : 0]  o_32    ,//O
    output reg  signed  [IN_WIDTH     : 0]  o_33    ,
    output reg  signed  [IN_WIDTH     : 0]  o_34    ,
    output reg  signed  [IN_WIDTH     : 0]  o_35    ,
    output reg  signed  [IN_WIDTH     : 0]  o_36    ,
    output reg  signed  [IN_WIDTH     : 0]  o_37    ,
    output reg  signed  [IN_WIDTH     : 0]  o_38    ,
    output reg  signed  [IN_WIDTH     : 0]  o_39    ,
    output reg  signed  [IN_WIDTH     : 0]  o_40    ,
    output reg  signed  [IN_WIDTH     : 0]  o_41    ,
    output reg  signed  [IN_WIDTH     : 0]  o_42    ,
    output reg  signed  [IN_WIDTH     : 0]  o_43    ,
    output reg  signed  [IN_WIDTH     : 0]  o_44    ,
    output reg  signed  [IN_WIDTH     : 0]  o_45    ,
    output reg  signed  [IN_WIDTH     : 0]  o_46    ,
    output reg  signed  [IN_WIDTH     : 0]  o_47    ,
    output reg  signed  [IN_WIDTH     : 0]  o_48    ,
    output reg  signed  [IN_WIDTH     : 0]  o_49    ,
    output reg  signed  [IN_WIDTH     : 0]  o_50    ,
    output reg  signed  [IN_WIDTH     : 0]  o_51    ,
    output reg  signed  [IN_WIDTH     : 0]  o_52    ,
    output reg  signed  [IN_WIDTH     : 0]  o_53    ,
    output reg  signed  [IN_WIDTH     : 0]  o_54    ,
    output reg  signed  [IN_WIDTH     : 0]  o_55    ,
    output reg  signed  [IN_WIDTH     : 0]  o_56    ,
    output reg  signed  [IN_WIDTH     : 0]  o_57    ,
    output reg  signed  [IN_WIDTH     : 0]  o_58    ,
    output reg  signed  [IN_WIDTH     : 0]  o_59    ,
    output reg  signed  [IN_WIDTH     : 0]  o_60    ,
    output reg  signed  [IN_WIDTH     : 0]  o_61    ,
    output reg  signed  [IN_WIDTH     : 0]  o_62    ,
    output reg  signed  [IN_WIDTH     : 0]  o_63    
);

//生成蝶形运算单元
//E/O
    wire signed [IN_WIDTH : 0] E_0  = i_0  + i_63;
    wire signed [IN_WIDTH : 0] E_1  = i_1  + i_62;
    wire signed [IN_WIDTH : 0] E_2  = i_2  + i_61;
    wire signed [IN_WIDTH : 0] E_3  = i_3  + i_60;
    wire signed [IN_WIDTH : 0] E_4  = i_4  + i_59;
    wire signed [IN_WIDTH : 0] E_5  = i_5  + i_58;
    wire signed [IN_WIDTH : 0] E_6  = i_6  + i_57;
    wire signed [IN_WIDTH : 0] E_7  = i_7  + i_56;
    wire signed [IN_WIDTH : 0] E_8  = i_8  + i_55;
    wire signed [IN_WIDTH : 0] E_9  = i_9  + i_54;
    wire signed [IN_WIDTH : 0] E_10 = i_10 + i_53;
    wire signed [IN_WIDTH : 0] E_11 = i_11 + i_52;
    wire signed [IN_WIDTH : 0] E_12 = i_12 + i_51;
    wire signed [IN_WIDTH : 0] E_13 = i_13 + i_50;
    wire signed [IN_WIDTH : 0] E_14 = i_14 + i_49;
    wire signed [IN_WIDTH : 0] E_15 = i_15 + i_48;
    wire signed [IN_WIDTH : 0] E_16 = i_16 + i_47;
    wire signed [IN_WIDTH : 0] E_17 = i_17 + i_46;
    wire signed [IN_WIDTH : 0] E_18 = i_18 + i_45;
    wire signed [IN_WIDTH : 0] E_19 = i_19 + i_44;
    wire signed [IN_WIDTH : 0] E_20 = i_20 + i_43;
    wire signed [IN_WIDTH : 0] E_21 = i_21 + i_42;
    wire signed [IN_WIDTH : 0] E_22 = i_22 + i_41;
    wire signed [IN_WIDTH : 0] E_23 = i_23 + i_40;
    wire signed [IN_WIDTH : 0] E_24 = i_24 + i_39;
    wire signed [IN_WIDTH : 0] E_25 = i_25 + i_38;
    wire signed [IN_WIDTH : 0] E_26 = i_26 + i_37;
    wire signed [IN_WIDTH : 0] E_27 = i_27 + i_36;
    wire signed [IN_WIDTH : 0] E_28 = i_28 + i_35;
    wire signed [IN_WIDTH : 0] E_29 = i_29 + i_34;
    wire signed [IN_WIDTH : 0] E_30 = i_30 + i_33;
    wire signed [IN_WIDTH : 0] E_31 = i_31 + i_32;
    wire signed [IN_WIDTH : 0] O_0  = i_0  - i_63;
    wire signed [IN_WIDTH : 0] O_1  = i_1  - i_62;
    wire signed [IN_WIDTH : 0] O_2  = i_2  - i_61;
    wire signed [IN_WIDTH : 0] O_3  = i_3  - i_60;
    wire signed [IN_WIDTH : 0] O_4  = i_4  - i_59;
    wire signed [IN_WIDTH : 0] O_5  = i_5  - i_58;
    wire signed [IN_WIDTH : 0] O_6  = i_6  - i_57;
    wire signed [IN_WIDTH : 0] O_7  = i_7  - i_56;
    wire signed [IN_WIDTH : 0] O_8  = i_8  - i_55;
    wire signed [IN_WIDTH : 0] O_9  = i_9  - i_54;
    wire signed [IN_WIDTH : 0] O_10 = i_10 - i_53;
    wire signed [IN_WIDTH : 0] O_11 = i_11 - i_52;
    wire signed [IN_WIDTH : 0] O_12 = i_12 - i_51;
    wire signed [IN_WIDTH : 0] O_13 = i_13 - i_50;
    wire signed [IN_WIDTH : 0] O_14 = i_14 - i_49;
    wire signed [IN_WIDTH : 0] O_15 = i_15 - i_48;
    wire signed [IN_WIDTH : 0] O_16 = i_16 - i_47;
    wire signed [IN_WIDTH : 0] O_17 = i_17 - i_46;
    wire signed [IN_WIDTH : 0] O_18 = i_18 - i_45;
    wire signed [IN_WIDTH : 0] O_19 = i_19 - i_44;
    wire signed [IN_WIDTH : 0] O_20 = i_20 - i_43;
    wire signed [IN_WIDTH : 0] O_21 = i_21 - i_42;
    wire signed [IN_WIDTH : 0] O_22 = i_22 - i_41;
    wire signed [IN_WIDTH : 0] O_23 = i_23 - i_40;
    wire signed [IN_WIDTH : 0] O_24 = i_24 - i_39;
    wire signed [IN_WIDTH : 0] O_25 = i_25 - i_38;
    wire signed [IN_WIDTH : 0] O_26 = i_26 - i_37;
    wire signed [IN_WIDTH : 0] O_27 = i_27 - i_36;
    wire signed [IN_WIDTH : 0] O_28 = i_28 - i_35;
    wire signed [IN_WIDTH : 0] O_29 = i_29 - i_34;
    wire signed [IN_WIDTH : 0] O_30 = i_30 - i_33;
    wire signed [IN_WIDTH : 0] O_31 = i_31 - i_32;

//output
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
        o_0     <= E_0 ;
        o_1     <= E_1 ;
        o_2     <= E_2 ;
        o_3     <= E_3 ;
        o_4     <= E_4 ;
        o_5     <= E_5 ;
        o_6     <= E_6 ;
        o_7     <= E_7 ;
        o_8     <= E_8 ;
        o_9     <= E_9 ;
        o_10    <= E_10;
        o_11    <= E_11;
        o_12    <= E_12;
        o_13    <= E_13;
        o_14    <= E_14;
        o_15    <= E_15;
        o_16    <= E_16;
        o_17    <= E_17;
        o_18    <= E_18;
        o_19    <= E_19;
        o_20    <= E_20;
        o_21    <= E_21;
        o_22    <= E_22;
        o_23    <= E_23;
        o_24    <= E_24;
        o_25    <= E_25;
        o_26    <= E_26;
        o_27    <= E_27;
        o_28    <= E_28;
        o_29    <= E_29;
        o_30    <= E_30;
        o_31    <= E_31;
        o_32    <= O_0 ;
        o_33    <= O_1 ;
        o_34    <= O_2 ;
        o_35    <= O_3 ;
        o_36    <= O_4 ;
        o_37    <= O_5 ;
        o_38    <= O_6 ;
        o_39    <= O_7 ;
        o_40    <= O_8 ;
        o_41    <= O_9 ;
        o_42    <= O_10;
        o_43    <= O_11;
        o_44    <= O_12;
        o_45    <= O_13;
        o_46    <= O_14;
        o_47    <= O_15;
        o_48    <= O_16;
        o_49    <= O_17;
        o_50    <= O_18;
        o_51    <= O_19;
        o_52    <= O_20;
        o_53    <= O_21;
        o_54    <= O_22;
        o_55    <= O_23;
        o_56    <= O_24;
        o_57    <= O_25;
        o_58    <= O_26;
        o_59    <= O_27;
        o_60    <= O_28;
        o_61    <= O_29;
        o_62    <= O_30;
        o_63    <= O_31;
    end
end
    
endmodule
