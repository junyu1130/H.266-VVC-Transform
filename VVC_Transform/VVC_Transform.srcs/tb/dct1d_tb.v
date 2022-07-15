`timescale 1ns / 100ps

module dct1d_tb();

parameter   IN_WIDTH = 9,
            OUT_WIDTH = 16;

integer fp_r, fp_w, cnt;

//system input
    reg                               clk     ;
    reg                               rst_n   ;
//input parameter
    reg           [2 : 0]             i_size  ;
    reg           [3 : 0]             i_shift ;
//input data
    reg                               i_valid ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_0     ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_1     ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_2     ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_3     ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_4     ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_5     ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_6     ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_7     ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_8     ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_9     ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_10    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_11    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_12    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_13    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_14    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_15    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_16    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_17    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_18    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_19    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_20    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_21    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_22    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_23    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_24    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_25    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_26    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_27    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_28    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_29    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_30    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_31    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_32    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_33    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_34    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_35    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_36    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_37    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_38    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_39    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_40    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_41    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_42    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_43    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_44    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_45    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_46    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_47    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_48    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_49    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_50    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_51    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_52    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_53    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_54    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_55    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_56    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_57    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_58    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_59    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_60    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_61    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_62    ;
    reg   signed  [IN_WIDTH - 1 : 0]  i_63    ;
//output coeff
    wire                              o_valid ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_0     ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_1     ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_2     ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_3     ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_4     ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_5     ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_6     ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_7     ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_8     ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_9     ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_10    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_11    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_12    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_13    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_14    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_15    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_16    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_17    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_18    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_19    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_20    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_21    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_22    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_23    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_24    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_25    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_26    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_27    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_28    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_29    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_30    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_31    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_32    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_33    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_34    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_35    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_36    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_37    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_38    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_39    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_40    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_41    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_42    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_43    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_44    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_45    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_46    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_47    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_48    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_49    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_50    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_51    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_52    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_53    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_54    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_55    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_56    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_57    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_58    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_59    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_60    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_61    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_62    ;
    wire  signed  [OUT_WIDTH - 1 : 0] o_63    ;

dct1d#(
    .IN_WIDTH   (IN_WIDTH),
    .OUT_WIDTH  (OUT_WIDTH)
)
u_dct1d(
//system input
    .clk     (clk     ),
    .rst_n   (rst_n   ),
//input parameter
    .i_size  (i_size  ),
    .i_shift (i_shift ),
//input data
    .i_valid (i_valid ),
    .i_0     (i_0     ),
    .i_1     (i_1     ),
    .i_2     (i_2     ),
    .i_3     (i_3     ),
    .i_4     (i_4     ),
    .i_5     (i_5     ),
    .i_6     (i_6     ),
    .i_7     (i_7     ),
    .i_8     (i_8     ),
    .i_9     (i_9     ),
    .i_10    (i_10    ),
    .i_11    (i_11    ),
    .i_12    (i_12    ),
    .i_13    (i_13    ),
    .i_14    (i_14    ),
    .i_15    (i_15    ),
    .i_16    (i_16    ),
    .i_17    (i_17    ),
    .i_18    (i_18    ),
    .i_19    (i_19    ),
    .i_20    (i_20    ),
    .i_21    (i_21    ),
    .i_22    (i_22    ),
    .i_23    (i_23    ),
    .i_24    (i_24    ),
    .i_25    (i_25    ),
    .i_26    (i_26    ),
    .i_27    (i_27    ),
    .i_28    (i_28    ),
    .i_29    (i_29    ),
    .i_30    (i_30    ),
    .i_31    (i_31    ),
    .i_32    (i_32    ),
    .i_33    (i_33    ),
    .i_34    (i_34    ),
    .i_35    (i_35    ),
    .i_36    (i_36    ),
    .i_37    (i_37    ),
    .i_38    (i_38    ),
    .i_39    (i_39    ),
    .i_40    (i_40    ),
    .i_41    (i_41    ),
    .i_42    (i_42    ),
    .i_43    (i_43    ),
    .i_44    (i_44    ),
    .i_45    (i_45    ),
    .i_46    (i_46    ),
    .i_47    (i_47    ),
    .i_48    (i_48    ),
    .i_49    (i_49    ),
    .i_50    (i_50    ),
    .i_51    (i_51    ),
    .i_52    (i_52    ),
    .i_53    (i_53    ),
    .i_54    (i_54    ),
    .i_55    (i_55    ),
    .i_56    (i_56    ),
    .i_57    (i_57    ),
    .i_58    (i_58    ),
    .i_59    (i_59    ),
    .i_60    (i_60    ),
    .i_61    (i_61    ),
    .i_62    (i_62    ),
    .i_63    (i_63    ),
//output coeff
    .o_valid (o_valid ),
    .o_0     (o_0     ),
    .o_1     (o_1     ),
    .o_2     (o_2     ),
    .o_3     (o_3     ),
    .o_4     (o_4     ),
    .o_5     (o_5     ),
    .o_6     (o_6     ),
    .o_7     (o_7     ),
    .o_8     (o_8     ),
    .o_9     (o_9     ),
    .o_10    (o_10    ),
    .o_11    (o_11    ),
    .o_12    (o_12    ),
    .o_13    (o_13    ),
    .o_14    (o_14    ),
    .o_15    (o_15    ),
    .o_16    (o_16    ),
    .o_17    (o_17    ),
    .o_18    (o_18    ),
    .o_19    (o_19    ),
    .o_20    (o_20    ),
    .o_21    (o_21    ),
    .o_22    (o_22    ),
    .o_23    (o_23    ),
    .o_24    (o_24    ),
    .o_25    (o_25    ),
    .o_26    (o_26    ),
    .o_27    (o_27    ),
    .o_28    (o_28    ),
    .o_29    (o_29    ),
    .o_30    (o_30    ),
    .o_31    (o_31    ),
    .o_32    (o_32    ),
    .o_33    (o_33    ),
    .o_34    (o_34    ),
    .o_35    (o_35    ),
    .o_36    (o_36    ),
    .o_37    (o_37    ),
    .o_38    (o_38    ),
    .o_39    (o_39    ),
    .o_40    (o_40    ),
    .o_41    (o_41    ),
    .o_42    (o_42    ),
    .o_43    (o_43    ),
    .o_44    (o_44    ),
    .o_45    (o_45    ),
    .o_46    (o_46    ),
    .o_47    (o_47    ),
    .o_48    (o_48    ),
    .o_49    (o_49    ),
    .o_50    (o_50    ),
    .o_51    (o_51    ),
    .o_52    (o_52    ),
    .o_53    (o_53    ),
    .o_54    (o_54    ),
    .o_55    (o_55    ),
    .o_56    (o_56    ),
    .o_57    (o_57    ),
    .o_58    (o_58    ),
    .o_59    (o_59    ),
    .o_60    (o_60    ),
    .o_61    (o_61    ),
    .o_62    (o_62    ),
    .o_63    (o_63    )
);

always #5 begin
    clk <= ~clk;
end

initial begin
    clk = 0;
    rst_n = 0;
    cnt = 0;
    i_size = 0; i_shift = 0;
    i_0 = 0; i_1 = 0; i_2 = 0; i_3 = 0; i_4 = 0; i_5 = 0; i_6 = 0; i_7 = 0; i_8 = 0; i_9 = 0; i_10 = 0; i_11 = 0; i_12 = 0; i_13 = 0; i_14 = 0; i_15 = 0; i_16 = 0; i_17 = 0; i_18 = 0; i_19 = 0; i_20 = 0; i_21 = 0; i_22 = 0; i_23 = 0; i_24 = 0; i_25 = 0; i_26 = 0; i_27 = 0; i_28 = 0; i_29 = 0; i_30 = 0; i_31 = 0; 
    i_32 = 0; i_33 = 0; i_34 = 0; i_35 = 0; i_36 = 0; i_37 = 0; i_38 = 0; i_39 = 0; i_40 = 0; i_41 = 0; i_42 = 0; i_43 = 0; i_44 = 0; i_45 = 0; i_46 = 0; i_47 = 0; i_48 = 0; i_49 = 0; i_50 = 0; i_51 = 0; i_52 = 0; i_53 = 0; i_54 = 0; i_55 = 0; i_56 = 0; i_57 = 0; i_58 = 0; i_59 = 0; i_60 = 0; i_61 = 0; i_62 = 0; i_63 = 0; 
    #10;
    rst_n = 1;

    i_size = 4; 
    i_shift = 5;
    i_valid = 1'b1;
    i_0 = 0; i_1 = 0; i_2 = 0; i_3 = 0; i_4 = 0; i_5 = 0; i_6 = 0; i_7 = 0; i_8 = 0; i_9 = 0; i_10 = 0; i_11 = 0; i_12 = 0; i_13 = 0; i_14 = 0; i_15 = 0; i_16 = 0; i_17 = 0; i_18 = 0; i_19 = 0; i_20 = 0; i_21 = 0; i_22 = 0; i_23 = 0; i_24 = 0; i_25 = 0; i_26 = 0; i_27 = 0; i_28 = 0; i_29 = 0; i_30 = 0; i_31 = 0; 
    i_32 = 0; i_33 = 0; i_34 = 0; i_35 = 0; i_36 = 0; i_37 = 0; i_38 = 0; i_39 = 0; i_40 = 0; i_41 = 0; i_42 = 0; i_43 = 0; i_44 = 0; i_45 = 0; i_46 = 0; i_47 = 0; i_48 = 0; i_49 = 0; i_50 = 0; i_51 = 0; i_52 = 0; i_53 = 0; i_54 = 0; i_55 = 0; i_56 = 0; i_57 = 0; i_58 = 0; i_59 = 0; i_60 = 0; i_61 = 0; i_62 = 0; i_63 = 0; 
    fp_r = $fopen("E:/Projects/VideoCoding/result/origin_data.txt", "r");
    fp_w = $fopen("E:/Projects/VideoCoding/result/fpga_coeff.txt", "w");
    while (!$feof(fp_r)) begin//Ö±µ½¶Áµ½Ä©Î²
        $fscanf(fp_r, "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d", 
                    i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7,i_8,i_9,i_10,i_11,i_12,i_13,i_14,i_15,i_16,i_17,i_18,i_19,i_20,i_21,i_22,i_23,i_24,i_25,i_26,i_27,i_28,i_29,i_30,i_31,i_32,i_33,i_34,i_35,i_36,i_37,i_38,i_39,i_40,i_41,i_42,i_43,i_44,i_45,i_46,i_47,i_48,i_49,i_50,i_51,i_52,i_53,i_54,i_55,i_56,i_57,i_58,i_59,i_60,i_61,i_62,i_63);
        cnt = cnt + 1;
        if (cnt == 65) begin
            i_valid = 1'b0;  
        end
        $fwrite(fp_w, "%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d\n", o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31,o_32,o_33,o_34,o_35,o_36,o_37,o_38,o_39,o_40,o_41,o_42,o_43,o_44,o_45,o_46,o_47,o_48,o_49,o_50,o_51,o_52,o_53,o_54,o_55,o_56,o_57,o_58,o_59,o_60,o_61,o_62,o_63);
        #10;
    end 
    $fwrite(fp_w, "%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d\n", o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31,o_32,o_33,o_34,o_35,o_36,o_37,o_38,o_39,o_40,o_41,o_42,o_43,o_44,o_45,o_46,o_47,o_48,o_49,o_50,o_51,o_52,o_53,o_54,o_55,o_56,o_57,o_58,o_59,o_60,o_61,o_62,o_63);
    #10;
    $fwrite(fp_w, "%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d\n", o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31,o_32,o_33,o_34,o_35,o_36,o_37,o_38,o_39,o_40,o_41,o_42,o_43,o_44,o_45,o_46,o_47,o_48,o_49,o_50,o_51,o_52,o_53,o_54,o_55,o_56,o_57,o_58,o_59,o_60,o_61,o_62,o_63);
    
    $fclose(fp_r);
    $fclose(fp_w);

    #1000;
    $stop;
end             

endmodule

