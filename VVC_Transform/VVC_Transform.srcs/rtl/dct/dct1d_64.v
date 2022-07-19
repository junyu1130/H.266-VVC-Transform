//describe  : 64x64点DCT计算，高频系数置零
//input     : 64个像素残差/第一次变换系数
//output    : 16个预变换系数(后需右移)+32个64_E
//delay     : 64_E : 1 clk , 64_precoeff : 6 clk
module dct1d_64#(
    parameter  IN_WIDTH  = 16
)
(
//system input
    input                               clk     ,
    input                               rst_n   ,
//input data
    input                               i_valid ,
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
    input   signed  [IN_WIDTH - 1 : 0]  i_32    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_33    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_34    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_35    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_36    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_37    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_38    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_39    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_40    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_41    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_42    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_43    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_44    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_45    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_46    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_47    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_48    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_49    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_50    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_51    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_52    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_53    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_54    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_55    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_56    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_57    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_58    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_59    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_60    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_61    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_62    ,
    input   signed  [IN_WIDTH - 1 : 0]  i_63    ,
//output 64's pre_coeff and E
    output                              o_valid ,
    output  signed  [IN_WIDTH      : 0] o_0     ,
    output  signed  [IN_WIDTH      : 0] o_1     ,
    output  signed  [IN_WIDTH      : 0] o_2     ,
    output  signed  [IN_WIDTH      : 0] o_3     ,
    output  signed  [IN_WIDTH      : 0] o_4     ,
    output  signed  [IN_WIDTH      : 0] o_5     ,
    output  signed  [IN_WIDTH      : 0] o_6     ,
    output  signed  [IN_WIDTH      : 0] o_7     ,
    output  signed  [IN_WIDTH      : 0] o_8     ,
    output  signed  [IN_WIDTH      : 0] o_9     ,
    output  signed  [IN_WIDTH      : 0] o_10    ,
    output  signed  [IN_WIDTH      : 0] o_11    ,
    output  signed  [IN_WIDTH      : 0] o_12    ,
    output  signed  [IN_WIDTH      : 0] o_13    ,
    output  signed  [IN_WIDTH      : 0] o_14    ,
    output  signed  [IN_WIDTH      : 0] o_15    ,
    output  signed  [IN_WIDTH      : 0] o_16    ,
    output  signed  [IN_WIDTH      : 0] o_17    ,
    output  signed  [IN_WIDTH      : 0] o_18    ,
    output  signed  [IN_WIDTH      : 0] o_19    ,
    output  signed  [IN_WIDTH      : 0] o_20    ,
    output  signed  [IN_WIDTH      : 0] o_21    ,
    output  signed  [IN_WIDTH      : 0] o_22    ,
    output  signed  [IN_WIDTH      : 0] o_23    ,
    output  signed  [IN_WIDTH      : 0] o_24    ,
    output  signed  [IN_WIDTH      : 0] o_25    ,
    output  signed  [IN_WIDTH      : 0] o_26    ,
    output  signed  [IN_WIDTH      : 0] o_27    ,
    output  signed  [IN_WIDTH      : 0] o_28    ,
    output  signed  [IN_WIDTH      : 0] o_29    ,
    output  signed  [IN_WIDTH      : 0] o_30    ,
    output  signed  [IN_WIDTH      : 0] o_31    ,
    output  signed  [IN_WIDTH + 11 : 0] o_32    ,
    output  signed  [IN_WIDTH + 11 : 0] o_33    ,
    output  signed  [IN_WIDTH + 11 : 0] o_34    ,
    output  signed  [IN_WIDTH + 11 : 0] o_35    ,
    output  signed  [IN_WIDTH + 11 : 0] o_36    ,
    output  signed  [IN_WIDTH + 11 : 0] o_37    ,
    output  signed  [IN_WIDTH + 11 : 0] o_38    ,
    output  signed  [IN_WIDTH + 11 : 0] o_39    ,
    output  signed  [IN_WIDTH + 11 : 0] o_40    ,
    output  signed  [IN_WIDTH + 11 : 0] o_41    ,
    output  signed  [IN_WIDTH + 11 : 0] o_42    ,
    output  signed  [IN_WIDTH + 11 : 0] o_43    ,
    output  signed  [IN_WIDTH + 11 : 0] o_44    ,
    output  signed  [IN_WIDTH + 11 : 0] o_45    ,
    output  signed  [IN_WIDTH + 11 : 0] o_46    ,
    output  signed  [IN_WIDTH + 11 : 0] o_47    
);

//butterfly
    wire butterfly_64_valid;
    wire signed [IN_WIDTH : 0]  butterfly_64[0 : 63];
//calculate : mcm + sum
    wire pre_coeff_valid;
    wire signed [IN_WIDTH + 11 : 0] pre_coeff[0 : 15];

//sub module
butterfly_64#(
    .IN_WIDTH   (IN_WIDTH)
)
u_butterfly_64(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input data
    .i_valid(i_valid            ),
    .i_0    (i_0                ),
    .i_1    (i_1                ),
    .i_2    (i_2                ),
    .i_3    (i_3                ),
    .i_4    (i_4                ),
    .i_5    (i_5                ),
    .i_6    (i_6                ),
    .i_7    (i_7                ),
    .i_8    (i_8                ),
    .i_9    (i_9                ),
    .i_10   (i_10               ),
    .i_11   (i_11               ),
    .i_12   (i_12               ),
    .i_13   (i_13               ),
    .i_14   (i_14               ),
    .i_15   (i_15               ),
    .i_16   (i_16               ),
    .i_17   (i_17               ),
    .i_18   (i_18               ),
    .i_19   (i_19               ),
    .i_20   (i_20               ),
    .i_21   (i_21               ),
    .i_22   (i_22               ),
    .i_23   (i_23               ),
    .i_24   (i_24               ),
    .i_25   (i_25               ),
    .i_26   (i_26               ),
    .i_27   (i_27               ),
    .i_28   (i_28               ),
    .i_29   (i_29               ),
    .i_30   (i_30               ),
    .i_31   (i_31               ),
    .i_32   (i_32               ),
    .i_33   (i_33               ),
    .i_34   (i_34               ),
    .i_35   (i_35               ),
    .i_36   (i_36               ),
    .i_37   (i_37               ),
    .i_38   (i_38               ),
    .i_39   (i_39               ),
    .i_40   (i_40               ),
    .i_41   (i_41               ),
    .i_42   (i_42               ),
    .i_43   (i_43               ),
    .i_44   (i_44               ),
    .i_45   (i_45               ),
    .i_46   (i_46               ),
    .i_47   (i_47               ),
    .i_48   (i_48               ),
    .i_49   (i_49               ),
    .i_50   (i_50               ),
    .i_51   (i_51               ),
    .i_52   (i_52               ),
    .i_53   (i_53               ),
    .i_54   (i_54               ),
    .i_55   (i_55               ),
    .i_56   (i_56               ),
    .i_57   (i_57               ),
    .i_58   (i_58               ),
    .i_59   (i_59               ),
    .i_60   (i_60               ),
    .i_61   (i_61               ),
    .i_62   (i_62               ),
    .i_63   (i_63               ),
//output data
    .o_valid(butterfly_64_valid ),
    .o_0    (butterfly_64[0 ]   ),//E
    .o_1    (butterfly_64[1 ]   ),
    .o_2    (butterfly_64[2 ]   ),
    .o_3    (butterfly_64[3 ]   ),
    .o_4    (butterfly_64[4 ]   ),
    .o_5    (butterfly_64[5 ]   ),
    .o_6    (butterfly_64[6 ]   ),
    .o_7    (butterfly_64[7 ]   ),
    .o_8    (butterfly_64[8 ]   ),
    .o_9    (butterfly_64[9 ]   ),
    .o_10   (butterfly_64[10]   ),
    .o_11   (butterfly_64[11]   ),
    .o_12   (butterfly_64[12]   ),
    .o_13   (butterfly_64[13]   ),
    .o_14   (butterfly_64[14]   ),
    .o_15   (butterfly_64[15]   ),
    .o_16   (butterfly_64[16]   ),
    .o_17   (butterfly_64[17]   ),
    .o_18   (butterfly_64[18]   ),
    .o_19   (butterfly_64[19]   ),
    .o_20   (butterfly_64[20]   ),
    .o_21   (butterfly_64[21]   ),
    .o_22   (butterfly_64[22]   ),
    .o_23   (butterfly_64[23]   ),
    .o_24   (butterfly_64[24]   ),
    .o_25   (butterfly_64[25]   ),
    .o_26   (butterfly_64[26]   ),
    .o_27   (butterfly_64[27]   ),
    .o_28   (butterfly_64[28]   ),
    .o_29   (butterfly_64[29]   ),
    .o_30   (butterfly_64[30]   ),
    .o_31   (butterfly_64[31]   ),
    .o_32   (butterfly_64[32]   ),//O
    .o_33   (butterfly_64[33]   ),
    .o_34   (butterfly_64[34]   ),
    .o_35   (butterfly_64[35]   ),
    .o_36   (butterfly_64[36]   ),
    .o_37   (butterfly_64[37]   ),
    .o_38   (butterfly_64[38]   ),
    .o_39   (butterfly_64[39]   ),
    .o_40   (butterfly_64[40]   ),
    .o_41   (butterfly_64[41]   ),
    .o_42   (butterfly_64[42]   ),
    .o_43   (butterfly_64[43]   ),
    .o_44   (butterfly_64[44]   ),
    .o_45   (butterfly_64[45]   ),
    .o_46   (butterfly_64[46]   ),
    .o_47   (butterfly_64[47]   ),
    .o_48   (butterfly_64[48]   ),
    .o_49   (butterfly_64[49]   ),
    .o_50   (butterfly_64[50]   ),
    .o_51   (butterfly_64[51]   ),
    .o_52   (butterfly_64[52]   ),
    .o_53   (butterfly_64[53]   ),
    .o_54   (butterfly_64[54]   ),
    .o_55   (butterfly_64[55]   ),
    .o_56   (butterfly_64[56]   ),
    .o_57   (butterfly_64[57]   ),
    .o_58   (butterfly_64[58]   ),
    .o_59   (butterfly_64[59]   ),
    .o_60   (butterfly_64[60]   ),
    .o_61   (butterfly_64[61]   ),
    .o_62   (butterfly_64[62]   ),
    .o_63   (butterfly_64[63]   )
);

calculate_64#(
    .IN_WIDTH   (IN_WIDTH + 1)
) 
u_calculate_64(
//system input
    .clk    (clk                ),
    .rst_n  (rst_n              ),
//input data
    .i_valid(butterfly_64_valid ),
    .i_0    (butterfly_64[32]   ),
    .i_1    (butterfly_64[33]   ),
    .i_2    (butterfly_64[34]   ),
    .i_3    (butterfly_64[35]   ),
    .i_4    (butterfly_64[36]   ),
    .i_5    (butterfly_64[37]   ),
    .i_6    (butterfly_64[38]   ),
    .i_7    (butterfly_64[39]   ),
    .i_8    (butterfly_64[40]   ),
    .i_9    (butterfly_64[41]   ),
    .i_10   (butterfly_64[42]   ),
    .i_11   (butterfly_64[43]   ),
    .i_12   (butterfly_64[44]   ),
    .i_13   (butterfly_64[45]   ),
    .i_14   (butterfly_64[46]   ),
    .i_15   (butterfly_64[47]   ),
    .i_16   (butterfly_64[48]   ),
    .i_17   (butterfly_64[49]   ),
    .i_18   (butterfly_64[50]   ),
    .i_19   (butterfly_64[51]   ),
    .i_20   (butterfly_64[52]   ),
    .i_21   (butterfly_64[53]   ),
    .i_22   (butterfly_64[54]   ),
    .i_23   (butterfly_64[55]   ),
    .i_24   (butterfly_64[56]   ),
    .i_25   (butterfly_64[57]   ),
    .i_26   (butterfly_64[58]   ),
    .i_27   (butterfly_64[59]   ),
    .i_28   (butterfly_64[60]   ),
    .i_29   (butterfly_64[61]   ),
    .i_30   (butterfly_64[62]   ),
    .i_31   (butterfly_64[63]   ),
//output pre_coeff
    .o_valid(pre_coeff_valid    ),
    .o_0    (pre_coeff[0 ]      ),
    .o_1    (pre_coeff[1 ]      ),
    .o_2    (pre_coeff[2 ]      ),
    .o_3    (pre_coeff[3 ]      ),
    .o_4    (pre_coeff[4 ]      ),
    .o_5    (pre_coeff[5 ]      ),
    .o_6    (pre_coeff[6 ]      ),
    .o_7    (pre_coeff[7 ]      ),
    .o_8    (pre_coeff[8 ]      ),
    .o_9    (pre_coeff[9 ]      ),
    .o_10   (pre_coeff[10]      ),
    .o_11   (pre_coeff[11]      ),
    .o_12   (pre_coeff[12]      ),
    .o_13   (pre_coeff[13]      ),
    .o_14   (pre_coeff[14]      ),
    .o_15   (pre_coeff[15]      )
);

//output
    assign o_valid = pre_coeff_valid;
    assign o_0     = butterfly_64[0 ];//64_E
    assign o_1     = butterfly_64[1 ];
    assign o_2     = butterfly_64[2 ];
    assign o_3     = butterfly_64[3 ];
    assign o_4     = butterfly_64[4 ];
    assign o_5     = butterfly_64[5 ];
    assign o_6     = butterfly_64[6 ];
    assign o_7     = butterfly_64[7 ];
    assign o_8     = butterfly_64[8 ];
    assign o_9     = butterfly_64[9 ];
    assign o_10    = butterfly_64[10];
    assign o_11    = butterfly_64[11];
    assign o_12    = butterfly_64[12];
    assign o_13    = butterfly_64[13];
    assign o_14    = butterfly_64[14];
    assign o_15    = butterfly_64[15];
    assign o_16    = butterfly_64[16];
    assign o_17    = butterfly_64[17];
    assign o_18    = butterfly_64[18];
    assign o_19    = butterfly_64[19];
    assign o_20    = butterfly_64[20];
    assign o_21    = butterfly_64[21];
    assign o_22    = butterfly_64[22];
    assign o_23    = butterfly_64[23];
    assign o_24    = butterfly_64[24];
    assign o_25    = butterfly_64[25];
    assign o_26    = butterfly_64[26];
    assign o_27    = butterfly_64[27];
    assign o_28    = butterfly_64[28];
    assign o_29    = butterfly_64[29];
    assign o_30    = butterfly_64[30];
    assign o_31    = butterfly_64[31];
    assign o_32    = pre_coeff[0 ];//1 
    assign o_33    = pre_coeff[1 ];//3 
    assign o_34    = pre_coeff[2 ];//5 
    assign o_35    = pre_coeff[3 ];//7 
    assign o_36    = pre_coeff[4 ];//9 
    assign o_37    = pre_coeff[5 ];//11
    assign o_38    = pre_coeff[6 ];//13
    assign o_39    = pre_coeff[7 ];//15
    assign o_40    = pre_coeff[8 ];//17
    assign o_41    = pre_coeff[9 ];//19
    assign o_42    = pre_coeff[10];//21
    assign o_43    = pre_coeff[11];//23
    assign o_44    = pre_coeff[12];//25
    assign o_45    = pre_coeff[13];//27
    assign o_46    = pre_coeff[14];//29
    assign o_47    = pre_coeff[15];//31

endmodule
