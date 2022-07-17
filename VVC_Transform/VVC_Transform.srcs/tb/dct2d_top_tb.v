`timescale 1ns / 1ns

module dct2d_top_tb();

parameter   BIT_DEPTH = 8,
            OUT_WIDTH = 16;

parameter   DCT_4 = 4,
            DCT_8 = 8,
            DCT_16 = 16,
            DCT_32 = 32,
            DCT_64 = 64;

integer fp_r, fp_w, cnt, i;

//system input
    reg                                 clk     ;
    reg                                 rst_n   ;
//input parameter 
    reg             [2 : 0]             i_width     ;
    reg             [2 : 0]             i_height    ;
//input data
    reg                                 i_valid     ;
    reg     signed  [BIT_DEPTH : 0]     i_0         ;
    reg     signed  [BIT_DEPTH : 0]     i_1         ;
    reg     signed  [BIT_DEPTH : 0]     i_2         ;
    reg     signed  [BIT_DEPTH : 0]     i_3         ;
    reg     signed  [BIT_DEPTH : 0]     i_4         ;
    reg     signed  [BIT_DEPTH : 0]     i_5         ;
    reg     signed  [BIT_DEPTH : 0]     i_6         ;
    reg     signed  [BIT_DEPTH : 0]     i_7         ;
    reg     signed  [BIT_DEPTH : 0]     i_8         ;
    reg     signed  [BIT_DEPTH : 0]     i_9         ;
    reg     signed  [BIT_DEPTH : 0]     i_10        ;
    reg     signed  [BIT_DEPTH : 0]     i_11        ;
    reg     signed  [BIT_DEPTH : 0]     i_12        ;
    reg     signed  [BIT_DEPTH : 0]     i_13        ;
    reg     signed  [BIT_DEPTH : 0]     i_14        ;
    reg     signed  [BIT_DEPTH : 0]     i_15        ;
    reg     signed  [BIT_DEPTH : 0]     i_16        ;
    reg     signed  [BIT_DEPTH : 0]     i_17        ;
    reg     signed  [BIT_DEPTH : 0]     i_18        ;
    reg     signed  [BIT_DEPTH : 0]     i_19        ;
    reg     signed  [BIT_DEPTH : 0]     i_20        ;
    reg     signed  [BIT_DEPTH : 0]     i_21        ;
    reg     signed  [BIT_DEPTH : 0]     i_22        ;
    reg     signed  [BIT_DEPTH : 0]     i_23        ;
    reg     signed  [BIT_DEPTH : 0]     i_24        ;
    reg     signed  [BIT_DEPTH : 0]     i_25        ;
    reg     signed  [BIT_DEPTH : 0]     i_26        ;
    reg     signed  [BIT_DEPTH : 0]     i_27        ;
    reg     signed  [BIT_DEPTH : 0]     i_28        ;
    reg     signed  [BIT_DEPTH : 0]     i_29        ;
    reg     signed  [BIT_DEPTH : 0]     i_30        ;
    reg     signed  [BIT_DEPTH : 0]     i_31        ;
    reg     signed  [BIT_DEPTH : 0]     i_32        ;
    reg     signed  [BIT_DEPTH : 0]     i_33        ;
    reg     signed  [BIT_DEPTH : 0]     i_34        ;
    reg     signed  [BIT_DEPTH : 0]     i_35        ;
    reg     signed  [BIT_DEPTH : 0]     i_36        ;
    reg     signed  [BIT_DEPTH : 0]     i_37        ;
    reg     signed  [BIT_DEPTH : 0]     i_38        ;
    reg     signed  [BIT_DEPTH : 0]     i_39        ;
    reg     signed  [BIT_DEPTH : 0]     i_40        ;
    reg     signed  [BIT_DEPTH : 0]     i_41        ;
    reg     signed  [BIT_DEPTH : 0]     i_42        ;
    reg     signed  [BIT_DEPTH : 0]     i_43        ;
    reg     signed  [BIT_DEPTH : 0]     i_44        ;
    reg     signed  [BIT_DEPTH : 0]     i_45        ;
    reg     signed  [BIT_DEPTH : 0]     i_46        ;
    reg     signed  [BIT_DEPTH : 0]     i_47        ;
    reg     signed  [BIT_DEPTH : 0]     i_48        ;
    reg     signed  [BIT_DEPTH : 0]     i_49        ;
    reg     signed  [BIT_DEPTH : 0]     i_50        ;
    reg     signed  [BIT_DEPTH : 0]     i_51        ;
    reg     signed  [BIT_DEPTH : 0]     i_52        ;
    reg     signed  [BIT_DEPTH : 0]     i_53        ;
    reg     signed  [BIT_DEPTH : 0]     i_54        ;
    reg     signed  [BIT_DEPTH : 0]     i_55        ;
    reg     signed  [BIT_DEPTH : 0]     i_56        ;
    reg     signed  [BIT_DEPTH : 0]     i_57        ;
    reg     signed  [BIT_DEPTH : 0]     i_58        ;
    reg     signed  [BIT_DEPTH : 0]     i_59        ;
    reg     signed  [BIT_DEPTH : 0]     i_60        ;
    reg     signed  [BIT_DEPTH : 0]     i_61        ;
    reg     signed  [BIT_DEPTH : 0]     i_62        ;
    reg     signed  [BIT_DEPTH : 0]     i_63        ;
//output parameter 
    wire            [2 : 0]             o_width     ;
    wire            [2 : 0]             o_height    ;
//output coeff
    wire                                o_valid     ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_0         ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_1         ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_2         ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_3         ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_4         ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_5         ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_6         ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_7         ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_8         ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_9         ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_10        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_11        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_12        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_13        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_14        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_15        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_16        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_17        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_18        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_19        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_20        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_21        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_22        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_23        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_24        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_25        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_26        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_27        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_28        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_29        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_30        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_31        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_32        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_33        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_34        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_35        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_36        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_37        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_38        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_39        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_40        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_41        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_42        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_43        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_44        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_45        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_46        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_47        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_48        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_49        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_50        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_51        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_52        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_53        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_54        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_55        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_56        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_57        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_58        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_59        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_60        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_61        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_62        ;
    wire    signed  [OUT_WIDTH - 1 : 0] o_63        ;

dct2d_top#(
    .BIT_DEPTH (BIT_DEPTH ),
    .OUT_WIDTH (OUT_WIDTH )
)
u_dct2d_top(
//system input
    .clk         (clk         ),
    .rst_n       (rst_n       ),
//input parameter
    .i_width     (i_width     ),
    .i_height    (i_height    ),
//input data
    .i_valid     (i_valid     ),
    .i_0         (i_0         ),
    .i_1         (i_1         ),
    .i_2         (i_2         ),
    .i_3         (i_3         ),
    .i_4         (i_4         ),
    .i_5         (i_5         ),
    .i_6         (i_6         ),
    .i_7         (i_7         ),
    .i_8         (i_8         ),
    .i_9         (i_9         ),
    .i_10        (i_10        ),
    .i_11        (i_11        ),
    .i_12        (i_12        ),
    .i_13        (i_13        ),
    .i_14        (i_14        ),
    .i_15        (i_15        ),
    .i_16        (i_16        ),
    .i_17        (i_17        ),
    .i_18        (i_18        ),
    .i_19        (i_19        ),
    .i_20        (i_20        ),
    .i_21        (i_21        ),
    .i_22        (i_22        ),
    .i_23        (i_23        ),
    .i_24        (i_24        ),
    .i_25        (i_25        ),
    .i_26        (i_26        ),
    .i_27        (i_27        ),
    .i_28        (i_28        ),
    .i_29        (i_29        ),
    .i_30        (i_30        ),
    .i_31        (i_31        ),
    .i_32        (i_32        ),
    .i_33        (i_33        ),
    .i_34        (i_34        ),
    .i_35        (i_35        ),
    .i_36        (i_36        ),
    .i_37        (i_37        ),
    .i_38        (i_38        ),
    .i_39        (i_39        ),
    .i_40        (i_40        ),
    .i_41        (i_41        ),
    .i_42        (i_42        ),
    .i_43        (i_43        ),
    .i_44        (i_44        ),
    .i_45        (i_45        ),
    .i_46        (i_46        ),
    .i_47        (i_47        ),
    .i_48        (i_48        ),
    .i_49        (i_49        ),
    .i_50        (i_50        ),
    .i_51        (i_51        ),
    .i_52        (i_52        ),
    .i_53        (i_53        ),
    .i_54        (i_54        ),
    .i_55        (i_55        ),
    .i_56        (i_56        ),
    .i_57        (i_57        ),
    .i_58        (i_58        ),
    .i_59        (i_59        ),
    .i_60        (i_60        ),
    .i_61        (i_61        ),
    .i_62        (i_62        ),
    .i_63        (i_63        ),
//output parameter
    .o_width     (o_width     ),
    .o_height    (o_height    ),
//output coeff
    .o_valid     (o_valid     ),
    .o_0         (o_0         ),
    .o_1         (o_1         ),
    .o_2         (o_2         ),
    .o_3         (o_3         ),
    .o_4         (o_4         ),
    .o_5         (o_5         ),
    .o_6         (o_6         ),
    .o_7         (o_7         ),
    .o_8         (o_8         ),
    .o_9         (o_9         ),
    .o_10        (o_10        ),
    .o_11        (o_11        ),
    .o_12        (o_12        ),
    .o_13        (o_13        ),
    .o_14        (o_14        ),
    .o_15        (o_15        ),
    .o_16        (o_16        ),
    .o_17        (o_17        ),
    .o_18        (o_18        ),
    .o_19        (o_19        ),
    .o_20        (o_20        ),
    .o_21        (o_21        ),
    .o_22        (o_22        ),
    .o_23        (o_23        ),
    .o_24        (o_24        ),
    .o_25        (o_25        ),
    .o_26        (o_26        ),
    .o_27        (o_27        ),
    .o_28        (o_28        ),
    .o_29        (o_29        ),
    .o_30        (o_30        ),
    .o_31        (o_31        ),
    .o_32        (o_32        ),
    .o_33        (o_33        ),
    .o_34        (o_34        ),
    .o_35        (o_35        ),
    .o_36        (o_36        ),
    .o_37        (o_37        ),
    .o_38        (o_38        ),
    .o_39        (o_39        ),
    .o_40        (o_40        ),
    .o_41        (o_41        ),
    .o_42        (o_42        ),
    .o_43        (o_43        ),
    .o_44        (o_44        ),
    .o_45        (o_45        ),
    .o_46        (o_46        ),
    .o_47        (o_47        ),
    .o_48        (o_48        ),
    .o_49        (o_49        ),
    .o_50        (o_50        ),
    .o_51        (o_51        ),
    .o_52        (o_52        ),
    .o_53        (o_53        ),
    .o_54        (o_54        ),
    .o_55        (o_55        ),
    .o_56        (o_56        ),
    .o_57        (o_57        ),
    .o_58        (o_58        ),
    .o_59        (o_59        ),
    .o_60        (o_60        ),
    .o_61        (o_61        ),
    .o_62        (o_62        ),
    .o_63        (o_63        )
);

always #1 begin
    clk <= ~clk;
end

`define use_pipeline 1
// `define use_pipeline0 1

`ifdef use_pipeline
    //read
    initial begin
        clk = 0;
        rst_n = 0;
        cnt = 0;
        i_width = 0; i_height = 0;
        i_valid = 0;
        i_0 = 0; i_1 = 0; i_2 = 0; i_3 = 0; i_4 = 0; i_5 = 0; i_6 = 0; i_7 = 0; i_8 = 0; i_9 = 0; i_10 = 0; i_11 = 0; i_12 = 0; i_13 = 0; i_14 = 0; i_15 = 0; 
        i_16 = 0; i_17 = 0; i_18 = 0; i_19 = 0; i_20 = 0; i_21 = 0; i_22 = 0; i_23 = 0; i_24 = 0; i_25 = 0; i_26 = 0; i_27 = 0; i_28 = 0; i_29 = 0; i_30 = 0; i_31 = 0; 
        i_32 = 0; i_33 = 0; i_34 = 0; i_35 = 0; i_36 = 0; i_37 = 0; i_38 = 0; i_39 = 0; i_40 = 0; i_41 = 0; i_42 = 0; i_43 = 0; i_44 = 0; i_45 = 0; i_46 = 0; i_47 = 0; 
        i_48 = 0; i_49 = 0; i_50 = 0; i_51 = 0; i_52 = 0; i_53 = 0; i_54 = 0; i_55 = 0; i_56 = 0; i_57 = 0; i_58 = 0; i_59 = 0; i_60 = 0; i_61 = 0; i_62 = 0; i_63 = 0; 
        #2;
        rst_n = 1;

        //64x64
        i_valid = 1;
        i_width = 5; i_height = 5;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_64x64.txt", "r");
        cnt = 0;
        while (cnt < 64) begin
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
                        i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7,i_8,i_9,i_10,i_11,i_12,i_13,i_14,i_15,i_16,i_17,i_18,i_19,i_20,i_21,i_22,i_23,i_24,i_25,i_26,i_27,i_28,i_29,i_30,i_31,
                        i_32,i_33,i_34,i_35,i_36,i_37,i_38,i_39,i_40,i_41,i_42,i_43,i_44,i_45,i_46,i_47,i_48,i_49,i_50,i_51,i_52,i_53,i_54,i_55,i_56,i_57,i_58,i_59,i_60,i_61,i_62,i_63);
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end
        $fclose(fp_r);
        //32x32
        i_valid = 1;
        i_width = 4; i_height = 4;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_32x32.txt", "r");
        cnt = 0;
        while (cnt < 16) begin
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
                        i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7,i_8,i_9,i_10,i_11,i_12,i_13,i_14,i_15,i_16,i_17,i_18,i_19,i_20,i_21,i_22,i_23,i_24,i_25,i_26,i_27,i_28,i_29,i_30,i_31);
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
                        i_32,i_33,i_34,i_35,i_36,i_37,i_38,i_39,i_40,i_41,i_42,i_43,i_44,i_45,i_46,i_47,i_48,i_49,i_50,i_51,i_52,i_53,i_54,i_55,i_56,i_57,i_58,i_59,i_60,i_61,i_62,i_63);
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end 
        $fclose(fp_r);
        //16x16
        i_valid = 1;
        i_width = 3; i_height = 3;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_16x16.txt", "r");
        cnt = 0;
        while (cnt < 4) begin
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7,i_8,i_9,i_10,i_11,i_12,i_13,i_14,i_15);
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", i_16,i_17,i_18,i_19,i_20,i_21,i_22,i_23,i_24,i_25,i_26,i_27,i_28,i_29,i_30,i_31);
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", i_32,i_33,i_34,i_35,i_36,i_37,i_38,i_39,i_40,i_41,i_42,i_43,i_44,i_45,i_46,i_47);
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", i_48,i_49,i_50,i_51,i_52,i_53,i_54,i_55,i_56,i_57,i_58,i_59,i_60,i_61,i_62,i_63);
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end 
        $fclose(fp_r);
        //8x8
        i_valid = 1;
        i_width = 2; i_height = 2;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_8x8.txt", "r");
        cnt = 0;
        while (cnt < 1) begin
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d", i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7);
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d", i_8,i_9,i_10,i_11,i_12,i_13,i_14,i_15);
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d", i_16,i_17,i_18,i_19,i_20,i_21,i_22,i_23);
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d", i_24,i_25,i_26,i_27,i_28,i_29,i_30,i_31);
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d", i_32,i_33,i_34,i_35,i_36,i_37,i_38,i_39);
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d", i_40,i_41,i_42,i_43,i_44,i_45,i_46,i_47);
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d", i_48,i_49,i_50,i_51,i_52,i_53,i_54,i_55);
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d", i_56,i_57,i_58,i_59,i_60,i_61,i_62,i_63);
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end 
        $fclose(fp_r);
        //4x4
        i_valid = 1;
        i_width = 1; i_height = 1;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_4x4.txt", "r");
        cnt = 0;
        while (cnt < 1) begin
            $fscanf(fp_r, "%d %d %d %d", i_0,i_1,i_2,i_3);
            $fscanf(fp_r, "%d %d %d %d", i_4,i_5,i_6,i_7);
            $fscanf(fp_r, "%d %d %d %d", i_8,i_9,i_10,i_11);
            $fscanf(fp_r, "%d %d %d %d", i_12,i_13,i_14,i_15); 
            i_16 = 0; i_17 = 0; i_18 = 0; i_19 = 0; i_20 = 0; i_21 = 0; i_22 = 0; i_23 = 0; i_24 = 0; i_25 = 0; i_26 = 0; i_27 = 0; i_28 = 0; i_29 = 0; i_30 = 0; i_31 = 0; 
            i_32 = 0; i_33 = 0; i_34 = 0; i_35 = 0; i_36 = 0; i_37 = 0; i_38 = 0; i_39 = 0; i_40 = 0; i_41 = 0; i_42 = 0; i_43 = 0; i_44 = 0; i_45 = 0; i_46 = 0; i_47 = 0; 
            i_48 = 0; i_49 = 0; i_50 = 0; i_51 = 0; i_52 = 0; i_53 = 0; i_54 = 0; i_55 = 0; i_56 = 0; i_57 = 0; i_58 = 0; i_59 = 0; i_60 = 0; i_61 = 0; i_62 = 0; i_63 = 0; 
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end   
        $fclose(fp_r);
        //32x64
        i_valid = 1;
        i_width = 5; i_height = 4;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_32x64.txt", "r");
        cnt = 0;
        while (cnt < 32) begin
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
                        i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7,i_8,i_9,i_10,i_11,i_12,i_13,i_14,i_15,i_16,i_17,i_18,i_19,i_20,i_21,i_22,i_23,i_24,i_25,i_26,i_27,i_28,i_29,i_30,i_31,
                        i_32,i_33,i_34,i_35,i_36,i_37,i_38,i_39,i_40,i_41,i_42,i_43,i_44,i_45,i_46,i_47,i_48,i_49,i_50,i_51,i_52,i_53,i_54,i_55,i_56,i_57,i_58,i_59,i_60,i_61,i_62,i_63);
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end 
        $fclose(fp_r);
        //64x32
        i_valid = 1;
        i_width = 4; i_height = 5;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_64x32.txt", "r");
        cnt = 0;
        while (cnt < 32) begin
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
                        i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7,i_8,i_9,i_10,i_11,i_12,i_13,i_14,i_15,i_16,i_17,i_18,i_19,i_20,i_21,i_22,i_23,i_24,i_25,i_26,i_27,i_28,i_29,i_30,i_31);
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
                        i_32,i_33,i_34,i_35,i_36,i_37,i_38,i_39,i_40,i_41,i_42,i_43,i_44,i_45,i_46,i_47,i_48,i_49,i_50,i_51,i_52,i_53,i_54,i_55,i_56,i_57,i_58,i_59,i_60,i_61,i_62,i_63);
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end 
        $fclose(fp_r);

        #200;
        $stop;
    end

    // //write
    // initial begin 
    //     #2;
    //     #16; //delay 8 clk
    //     //64x64
    //     fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_64x64.txt", "w");
    //     for (i = 0; i < 64; i = i + 1) begin
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
    //                 o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31,
    //                 o_32,o_33,o_34,o_35,o_36,o_37,o_38,o_39,o_40,o_41,o_42,o_43,o_44,o_45,o_46,o_47,o_48,o_49,o_50,o_51,o_52,o_53,o_54,o_55,o_56,o_57,o_58,o_59,o_60,o_61,o_62,o_63);
    //         #2;
    //     end
    //     $fclose(fp_w);
    //     //32x32
    //     fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_32x32.txt", "w");
    //     for (i = 0; i < 16; i = i + 1) begin
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
    //                 o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31);
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
    //                 o_32,o_33,o_34,o_35,o_36,o_37,o_38,o_39,o_40,o_41,o_42,o_43,o_44,o_45,o_46,o_47,o_48,o_49,o_50,o_51,o_52,o_53,o_54,o_55,o_56,o_57,o_58,o_59,o_60,o_61,o_62,o_63);
    //         #2;
    //     end
    //     $fclose(fp_w);
    //     //16x16
    //     fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_16x16.txt", "w");
    //     for (i = 0; i < 4; i = i + 1) begin
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15);
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31);
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", o_32,o_33,o_34,o_35,o_36,o_37,o_38,o_39,o_40,o_41,o_42,o_43,o_44,o_45,o_46,o_47);
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", o_48,o_49,o_50,o_51,o_52,o_53,o_54,o_55,o_56,o_57,o_58,o_59,o_60,o_61,o_62,o_63);
    //         #2;
    //     end
    //     $fclose(fp_w);
    //     //8x8
    //     fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_8x8.txt", "w");
    //     for (i = 0; i < 1; i = i + 1) begin
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7);
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15);
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23);
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31);
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", o_32,o_33,o_34,o_35,o_36,o_37,o_38,o_39);
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", o_40,o_41,o_42,o_43,o_44,o_45,o_46,o_47);
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", o_48,o_49,o_50,o_51,o_52,o_53,o_54,o_55);
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", o_56,o_57,o_58,o_59,o_60,o_61,o_62,o_63);
    //         #2;
    //     end
    //     $fclose(fp_w);
    //     //4x4
    //     fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_4x4.txt", "w"); 
    //     for (i = 0; i < 1; i = i + 1) begin
    //         $fwrite(fp_w, "%6d %6d %6d %6d\n", o_0,o_1,o_2,o_3);
    //         $fwrite(fp_w, "%6d %6d %6d %6d\n", o_4,o_5,o_6,o_7);
    //         $fwrite(fp_w, "%6d %6d %6d %6d\n", o_8,o_9,o_10,o_11);
    //         $fwrite(fp_w, "%6d %6d %6d %6d\n", o_12,o_13,o_14,o_15);
    //         #2;
    //     end
    //     $fclose(fp_w);
    //     //32x64
    //     fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_32x64.txt", "w");
    //     for (i = 0; i < 32; i = i + 1) begin
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
    //                 o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31,
    //                 o_32,o_33,o_34,o_35,o_36,o_37,o_38,o_39,o_40,o_41,o_42,o_43,o_44,o_45,o_46,o_47,o_48,o_49,o_50,o_51,o_52,o_53,o_54,o_55,o_56,o_57,o_58,o_59,o_60,o_61,o_62,o_63);
    //         #2;
    //     end
    //     $fclose(fp_w);
    //     //64x32
    //     fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_64x32.txt", "w");
    //     for (i = 0; i < 32; i = i + 1) begin
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
    //                 o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31);
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
    //                 o_32,o_33,o_34,o_35,o_36,o_37,o_38,o_39,o_40,o_41,o_42,o_43,o_44,o_45,o_46,o_47,o_48,o_49,o_50,o_51,o_52,o_53,o_54,o_55,o_56,o_57,o_58,o_59,o_60,o_61,o_62,o_63);
    //         #2;
    //     end
    //     $fclose(fp_w);
    // end

`elsif use_pipeline0
    //read
    initial begin
        clk = 0;
        rst_n = 0;
        cnt = 0;
        i_width = 0; i_height = 0;
        i_valid = 0;
        i_0 = 0; i_1 = 0; i_2 = 0; i_3 = 0; i_4 = 0; i_5 = 0; i_6 = 0; i_7 = 0; i_8 = 0; i_9 = 0; i_10 = 0; i_11 = 0; i_12 = 0; i_13 = 0; i_14 = 0; i_15 = 0; 
        i_16 = 0; i_17 = 0; i_18 = 0; i_19 = 0; i_20 = 0; i_21 = 0; i_22 = 0; i_23 = 0; i_24 = 0; i_25 = 0; i_26 = 0; i_27 = 0; i_28 = 0; i_29 = 0; i_30 = 0; i_31 = 0; 
        i_32 = 0; i_33 = 0; i_34 = 0; i_35 = 0; i_36 = 0; i_37 = 0; i_38 = 0; i_39 = 0; i_40 = 0; i_41 = 0; i_42 = 0; i_43 = 0; i_44 = 0; i_45 = 0; i_46 = 0; i_47 = 0; 
        i_48 = 0; i_49 = 0; i_50 = 0; i_51 = 0; i_52 = 0; i_53 = 0; i_54 = 0; i_55 = 0; i_56 = 0; i_57 = 0; i_58 = 0; i_59 = 0; i_60 = 0; i_61 = 0; i_62 = 0; i_63 = 0; 
        #2;
        rst_n = 1;

        //64x64
        i_valid = 1;
        i_width = 5; i_height = 5;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_64x64.txt", "r");
        cnt = 0;
        while (cnt < DCT_64) begin
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
                        i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7,i_8,i_9,i_10,i_11,i_12,i_13,i_14,i_15,i_16,i_17,i_18,i_19,i_20,i_21,i_22,i_23,i_24,i_25,i_26,i_27,i_28,i_29,i_30,i_31,
                        i_32,i_33,i_34,i_35,i_36,i_37,i_38,i_39,i_40,i_41,i_42,i_43,i_44,i_45,i_46,i_47,i_48,i_49,i_50,i_51,i_52,i_53,i_54,i_55,i_56,i_57,i_58,i_59,i_60,i_61,i_62,i_63);
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end
        $fclose(fp_r);
        //32x32
        i_valid = 1;
        i_width = 4; i_height = 4;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_32x32.txt", "r");
        cnt = 0;
        while (cnt < DCT_32) begin
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
                        i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7,i_8,i_9,i_10,i_11,i_12,i_13,i_14,i_15,i_16,i_17,i_18,i_19,i_20,i_21,i_22,i_23,i_24,i_25,i_26,i_27,i_28,i_29,i_30,i_31);
            i_32 = 0; i_33 = 0; i_34 = 0; i_35 = 0; i_36 = 0; i_37 = 0; i_38 = 0; i_39 = 0; i_40 = 0; i_41 = 0; i_42 = 0; i_43 = 0; i_44 = 0; i_45 = 0; i_46 = 0; i_47 = 0; 
            i_48 = 0; i_49 = 0; i_50 = 0; i_51 = 0; i_52 = 0; i_53 = 0; i_54 = 0; i_55 = 0; i_56 = 0; i_57 = 0; i_58 = 0; i_59 = 0; i_60 = 0; i_61 = 0; i_62 = 0; i_63 = 0; 
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end 
        $fclose(fp_r);
        //16x16
        i_valid = 1;
        i_width = 3; i_height = 3;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_16x16.txt", "r");
        cnt = 0;
        while (cnt < DCT_16) begin
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7,i_8,i_9,i_10,i_11,i_12,i_13,i_14,i_15);
            i_16 = 0; i_17 = 0; i_18 = 0; i_19 = 0; i_20 = 0; i_21 = 0; i_22 = 0; i_23 = 0; i_24 = 0; i_25 = 0; i_26 = 0; i_27 = 0; i_28 = 0; i_29 = 0; i_30 = 0; i_31 = 0; 
            i_32 = 0; i_33 = 0; i_34 = 0; i_35 = 0; i_36 = 0; i_37 = 0; i_38 = 0; i_39 = 0; i_40 = 0; i_41 = 0; i_42 = 0; i_43 = 0; i_44 = 0; i_45 = 0; i_46 = 0; i_47 = 0; 
            i_48 = 0; i_49 = 0; i_50 = 0; i_51 = 0; i_52 = 0; i_53 = 0; i_54 = 0; i_55 = 0; i_56 = 0; i_57 = 0; i_58 = 0; i_59 = 0; i_60 = 0; i_61 = 0; i_62 = 0; i_63 = 0; 
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end 
        $fclose(fp_r);
        //8x8
        i_valid = 1;
        i_width = 2; i_height = 2;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_8x8.txt", "r");
        cnt = 0;
        while (cnt < DCT_8) begin
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d", i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7);
            i_8 = 0; i_9 = 0; i_10 = 0; i_11 = 0; i_12 = 0; i_13 = 0; i_14 = 0; i_15 = 0; 
            i_16 = 0; i_17 = 0; i_18 = 0; i_19 = 0; i_20 = 0; i_21 = 0; i_22 = 0; i_23 = 0; i_24 = 0; i_25 = 0; i_26 = 0; i_27 = 0; i_28 = 0; i_29 = 0; i_30 = 0; i_31 = 0; 
            i_32 = 0; i_33 = 0; i_34 = 0; i_35 = 0; i_36 = 0; i_37 = 0; i_38 = 0; i_39 = 0; i_40 = 0; i_41 = 0; i_42 = 0; i_43 = 0; i_44 = 0; i_45 = 0; i_46 = 0; i_47 = 0; 
            i_48 = 0; i_49 = 0; i_50 = 0; i_51 = 0; i_52 = 0; i_53 = 0; i_54 = 0; i_55 = 0; i_56 = 0; i_57 = 0; i_58 = 0; i_59 = 0; i_60 = 0; i_61 = 0; i_62 = 0; i_63 = 0; 
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end 
        $fclose(fp_r);
        //4x4
        i_valid = 1;
        i_width = 1; i_height = 1;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_4x4.txt", "r");
        cnt = 0;
        while (cnt < DCT_4) begin
            $fscanf(fp_r, "%d %d %d %d", i_0,i_1,i_2,i_3);
            i_4 = 0; i_5 = 0; i_6 = 0; i_7 = 0; i_8 = 0; i_9 = 0; i_10 = 0; i_11 = 0; i_12 = 0; i_13 = 0; i_14 = 0; i_15 = 0; 
            i_16 = 0; i_17 = 0; i_18 = 0; i_19 = 0; i_20 = 0; i_21 = 0; i_22 = 0; i_23 = 0; i_24 = 0; i_25 = 0; i_26 = 0; i_27 = 0; i_28 = 0; i_29 = 0; i_30 = 0; i_31 = 0; 
            i_32 = 0; i_33 = 0; i_34 = 0; i_35 = 0; i_36 = 0; i_37 = 0; i_38 = 0; i_39 = 0; i_40 = 0; i_41 = 0; i_42 = 0; i_43 = 0; i_44 = 0; i_45 = 0; i_46 = 0; i_47 = 0; 
            i_48 = 0; i_49 = 0; i_50 = 0; i_51 = 0; i_52 = 0; i_53 = 0; i_54 = 0; i_55 = 0; i_56 = 0; i_57 = 0; i_58 = 0; i_59 = 0; i_60 = 0; i_61 = 0; i_62 = 0; i_63 = 0; 
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end   
        $fclose(fp_r);
        //32x64
        i_valid = 1;
        i_width = 5; i_height = 4;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_32x64.txt", "r");
        cnt = 0;
        while (cnt < DCT_32) begin
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
                        i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7,i_8,i_9,i_10,i_11,i_12,i_13,i_14,i_15,i_16,i_17,i_18,i_19,i_20,i_21,i_22,i_23,i_24,i_25,i_26,i_27,i_28,i_29,i_30,i_31,
                        i_32,i_33,i_34,i_35,i_36,i_37,i_38,i_39,i_40,i_41,i_42,i_43,i_44,i_45,i_46,i_47,i_48,i_49,i_50,i_51,i_52,i_53,i_54,i_55,i_56,i_57,i_58,i_59,i_60,i_61,i_62,i_63);
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end 
        $fclose(fp_r);
        //64x32
        i_valid = 1;
        i_width = 4; i_height = 5;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_64x32.txt", "r");
        cnt = 0;
        while (cnt < DCT_64) begin
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
                        i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7,i_8,i_9,i_10,i_11,i_12,i_13,i_14,i_15,i_16,i_17,i_18,i_19,i_20,i_21,i_22,i_23,i_24,i_25,i_26,i_27,i_28,i_29,i_30,i_31);
            i_32 = 0; i_33 = 0; i_34 = 0; i_35 = 0; i_36 = 0; i_37 = 0; i_38 = 0; i_39 = 0; i_40 = 0; i_41 = 0; i_42 = 0; i_43 = 0; i_44 = 0; i_45 = 0; i_46 = 0; i_47 = 0; 
            i_48 = 0; i_49 = 0; i_50 = 0; i_51 = 0; i_52 = 0; i_53 = 0; i_54 = 0; i_55 = 0; i_56 = 0; i_57 = 0; i_58 = 0; i_59 = 0; i_60 = 0; i_61 = 0; i_62 = 0; i_63 = 0; 
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end 
        $fclose(fp_r);

        #200;
        $stop;
    end

    // //write
    // initial begin 
    //     #156;//delay 78 clk
    //     //64x64
    //     fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_64x64.txt", "w");
    //     for (i = 0; i < DCT_32; i = i + 1) begin//高频置零优化后只有32clk
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
    //                 o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31,
    //                 o_32,o_33,o_34,o_35,o_36,o_37,o_38,o_39,o_40,o_41,o_42,o_43,o_44,o_45,o_46,o_47,o_48,o_49,o_50,o_51,o_52,o_53,o_54,o_55,o_56,o_57,o_58,o_59,o_60,o_61,o_62,o_63);
    //         #2;
    //     end
    //     for (i = 0; i < DCT_32; i = i + 1) begin//直接存0
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
    //                 o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31,
    //                 o_32,o_33,o_34,o_35,o_36,o_37,o_38,o_39,o_40,o_41,o_42,o_43,o_44,o_45,o_46,o_47,o_48,o_49,o_50,o_51,o_52,o_53,o_54,o_55,o_56,o_57,o_58,o_59,o_60,o_61,o_62,o_63);
    //     end
    //     $fclose(fp_w);
    //     //32x32
    //     fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_32x32.txt", "w");
    //     for (i = 0; i < DCT_32; i = i + 1) begin
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
    //                 o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31);
    //         #2;
    //     end
    //     $fclose(fp_w);
    //     //16x16
    //     fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_16x16.txt", "w");
    //     for (i = 0; i < DCT_16; i = i + 1) begin
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15);
    //         #2;
    //     end
    //     $fclose(fp_w);
    //     //8x8
    //     fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_8x8.txt", "w");
    //     for (i = 0; i < DCT_8; i = i + 1) begin
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7);
    //         #2;
    //     end
    //     $fclose(fp_w);
    //     //4x4
    //     fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_4x4.txt", "w"); 
    //     for (i = 0; i < DCT_4; i = i + 1) begin
    //         $fwrite(fp_w, "%6d %6d %6d %6d\n", o_0,o_1,o_2,o_3);
    //         #2;
    //     end
    //     $fclose(fp_w);
    //     //32x64
    //     fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_32x64.txt", "w");
    //     for (i = 0; i < DCT_32; i = i + 1) begin
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
    //                 o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31);
    //         #2;
    //     end
    //     for (i = 0; i < DCT_32; i = i + 1) begin
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
    //                 o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31);
    //     end
    //     $fclose(fp_w);
    //     //64x32
    //     fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_64x32.txt", "w");
    //     for (i = 0; i < DCT_32; i = i + 1) begin
    //         $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
    //                 o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31,
    //                 o_32,o_33,o_34,o_35,o_36,o_37,o_38,o_39,o_40,o_41,o_42,o_43,o_44,o_45,o_46,o_47,o_48,o_49,o_50,o_51,o_52,o_53,o_54,o_55,o_56,o_57,o_58,o_59,o_60,o_61,o_62,o_63);
    //         #2;
    //     end
    //     $fclose(fp_w);
    // end

`else
    initial begin
        clk = 0;
        rst_n = 0;
        cnt = 0;
        i_width = 0; i_height = 0;
        i_valid = 0;
        i_0 = 0; i_1 = 0; i_2 = 0; i_3 = 0; i_4 = 0; i_5 = 0; i_6 = 0; i_7 = 0; i_8 = 0; i_9 = 0; i_10 = 0; i_11 = 0; i_12 = 0; i_13 = 0; i_14 = 0; i_15 = 0; 
        i_16 = 0; i_17 = 0; i_18 = 0; i_19 = 0; i_20 = 0; i_21 = 0; i_22 = 0; i_23 = 0; i_24 = 0; i_25 = 0; i_26 = 0; i_27 = 0; i_28 = 0; i_29 = 0; i_30 = 0; i_31 = 0; 
        i_32 = 0; i_33 = 0; i_34 = 0; i_35 = 0; i_36 = 0; i_37 = 0; i_38 = 0; i_39 = 0; i_40 = 0; i_41 = 0; i_42 = 0; i_43 = 0; i_44 = 0; i_45 = 0; i_46 = 0; i_47 = 0; 
        i_48 = 0; i_49 = 0; i_50 = 0; i_51 = 0; i_52 = 0; i_53 = 0; i_54 = 0; i_55 = 0; i_56 = 0; i_57 = 0; i_58 = 0; i_59 = 0; i_60 = 0; i_61 = 0; i_62 = 0; i_63 = 0; 
        #2;
        rst_n = 1;

        //64x64
        i_width = 5; i_height = 5;
        i_valid = 1;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_64x64.txt", "r");
        fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_64x64.txt", "w");
        cnt = 0;
        while (cnt < DCT_64) begin
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
                        i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7,i_8,i_9,i_10,i_11,i_12,i_13,i_14,i_15,i_16,i_17,i_18,i_19,i_20,i_21,i_22,i_23,i_24,i_25,i_26,i_27,i_28,i_29,i_30,i_31,
                        i_32,i_33,i_34,i_35,i_36,i_37,i_38,i_39,i_40,i_41,i_42,i_43,i_44,i_45,i_46,i_47,i_48,i_49,i_50,i_51,i_52,i_53,i_54,i_55,i_56,i_57,i_58,i_59,i_60,i_61,i_62,i_63);
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end 
        #30;
        for (i = 0; i < DCT_32; i = i + 1) begin//高频置零优化后只有32clk
            $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
                    o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31,
                    o_32,o_33,o_34,o_35,o_36,o_37,o_38,o_39,o_40,o_41,o_42,o_43,o_44,o_45,o_46,o_47,o_48,o_49,o_50,o_51,o_52,o_53,o_54,o_55,o_56,o_57,o_58,o_59,o_60,o_61,o_62,o_63);
            #2;
        end
        for (i = 0; i < DCT_32; i = i + 1) begin//直接存0
            $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
                    o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31,
                    o_32,o_33,o_34,o_35,o_36,o_37,o_38,o_39,o_40,o_41,o_42,o_43,o_44,o_45,o_46,o_47,o_48,o_49,o_50,o_51,o_52,o_53,o_54,o_55,o_56,o_57,o_58,o_59,o_60,o_61,o_62,o_63);
        end
        $fclose(fp_r);
        $fclose(fp_w);
        //32x32
        i_width = 4; i_height = 4;
        i_valid = 1;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_32x32.txt", "r");
        fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_32x32.txt", "w");
        cnt = 0;
        while (cnt < DCT_32) begin
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
                        i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7,i_8,i_9,i_10,i_11,i_12,i_13,i_14,i_15,i_16,i_17,i_18,i_19,i_20,i_21,i_22,i_23,i_24,i_25,i_26,i_27,i_28,i_29,i_30,i_31);
            i_32 = 0; i_33 = 0; i_34 = 0; i_35 = 0; i_36 = 0; i_37 = 0; i_38 = 0; i_39 = 0; i_40 = 0; i_41 = 0; i_42 = 0; i_43 = 0; i_44 = 0; i_45 = 0; i_46 = 0; i_47 = 0; 
            i_48 = 0; i_49 = 0; i_50 = 0; i_51 = 0; i_52 = 0; i_53 = 0; i_54 = 0; i_55 = 0; i_56 = 0; i_57 = 0; i_58 = 0; i_59 = 0; i_60 = 0; i_61 = 0; i_62 = 0; i_63 = 0; 
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end 
        #64;
        #30;
        for (i = 0; i < DCT_32; i = i + 1) begin
            $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
                    o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31);
            #2;
        end
        $fclose(fp_r);
        $fclose(fp_w);
        //16x16
        i_width = 3; i_height = 3;
        i_valid = 1;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_16x16.txt", "r");
        fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_16x16.txt", "w");
        cnt = 0;
        while (cnt < DCT_16) begin
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7,i_8,i_9,i_10,i_11,i_12,i_13,i_14,i_15);
            i_16 = 0; i_17 = 0; i_18 = 0; i_19 = 0; i_20 = 0; i_21 = 0; i_22 = 0; i_23 = 0; i_24 = 0; i_25 = 0; i_26 = 0; i_27 = 0; i_28 = 0; i_29 = 0; i_30 = 0; i_31 = 0; 
            i_32 = 0; i_33 = 0; i_34 = 0; i_35 = 0; i_36 = 0; i_37 = 0; i_38 = 0; i_39 = 0; i_40 = 0; i_41 = 0; i_42 = 0; i_43 = 0; i_44 = 0; i_45 = 0; i_46 = 0; i_47 = 0; 
            i_48 = 0; i_49 = 0; i_50 = 0; i_51 = 0; i_52 = 0; i_53 = 0; i_54 = 0; i_55 = 0; i_56 = 0; i_57 = 0; i_58 = 0; i_59 = 0; i_60 = 0; i_61 = 0; i_62 = 0; i_63 = 0; 
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end 
        #96;
        #30;
        for (i = 0; i < DCT_16; i = i + 1) begin
            $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15);
            #2;
        end
        $fclose(fp_r);
        $fclose(fp_w);
        #6
        //8x8
        i_width = 2; i_height = 2;
        i_valid = 1;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_8x8.txt", "r");
        fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_8x8.txt", "w");
        cnt = 0;
        while (cnt < DCT_8) begin
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d", i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7);
            i_8 = 0; i_9 = 0; i_10 = 0; i_11 = 0; i_12 = 0; i_13 = 0; i_14 = 0; i_15 = 0; 
            i_16 = 0; i_17 = 0; i_18 = 0; i_19 = 0; i_20 = 0; i_21 = 0; i_22 = 0; i_23 = 0; i_24 = 0; i_25 = 0; i_26 = 0; i_27 = 0; i_28 = 0; i_29 = 0; i_30 = 0; i_31 = 0; 
            i_32 = 0; i_33 = 0; i_34 = 0; i_35 = 0; i_36 = 0; i_37 = 0; i_38 = 0; i_39 = 0; i_40 = 0; i_41 = 0; i_42 = 0; i_43 = 0; i_44 = 0; i_45 = 0; i_46 = 0; i_47 = 0; 
            i_48 = 0; i_49 = 0; i_50 = 0; i_51 = 0; i_52 = 0; i_53 = 0; i_54 = 0; i_55 = 0; i_56 = 0; i_57 = 0; i_58 = 0; i_59 = 0; i_60 = 0; i_61 = 0; i_62 = 0; i_63 = 0; 
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end 
        #112;
        #30;
        for (i = 0; i < DCT_8; i = i + 1) begin
            $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7);
            #2;
        end
        $fclose(fp_r);
        $fclose(fp_w);
        #26
        //4x4
        i_width = 1; i_height = 1;
        i_valid = 1;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_4x4.txt", "r");
        fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_4x4.txt", "w");
        cnt = 0;
        while (cnt < DCT_4) begin
            $fscanf(fp_r, "%d %d %d %d", i_0,i_1,i_2,i_3);
            i_4 = 0; i_5 = 0; i_6 = 0; i_7 = 0; i_8 = 0; i_9 = 0; i_10 = 0; i_11 = 0; i_12 = 0; i_13 = 0; i_14 = 0; i_15 = 0; 
            i_16 = 0; i_17 = 0; i_18 = 0; i_19 = 0; i_20 = 0; i_21 = 0; i_22 = 0; i_23 = 0; i_24 = 0; i_25 = 0; i_26 = 0; i_27 = 0; i_28 = 0; i_29 = 0; i_30 = 0; i_31 = 0; 
            i_32 = 0; i_33 = 0; i_34 = 0; i_35 = 0; i_36 = 0; i_37 = 0; i_38 = 0; i_39 = 0; i_40 = 0; i_41 = 0; i_42 = 0; i_43 = 0; i_44 = 0; i_45 = 0; i_46 = 0; i_47 = 0; 
            i_48 = 0; i_49 = 0; i_50 = 0; i_51 = 0; i_52 = 0; i_53 = 0; i_54 = 0; i_55 = 0; i_56 = 0; i_57 = 0; i_58 = 0; i_59 = 0; i_60 = 0; i_61 = 0; i_62 = 0; i_63 = 0; 
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end   
        #120;
        #30;
        for (i = 0; i < DCT_4; i = i + 1) begin
            $fwrite(fp_w, "%6d %6d %6d %6d\n", o_0,o_1,o_2,o_3);
            #2;
        end
        $fclose(fp_r);
        $fclose(fp_w);
        #100
        //32x64
        i_width = 5; i_height = 4;
        i_valid = 1;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_32x64.txt", "r");
        fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_32x64.txt", "w");
        cnt = 0;
        while (cnt < DCT_32) begin
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
                        i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7,i_8,i_9,i_10,i_11,i_12,i_13,i_14,i_15,i_16,i_17,i_18,i_19,i_20,i_21,i_22,i_23,i_24,i_25,i_26,i_27,i_28,i_29,i_30,i_31,
                        i_32,i_33,i_34,i_35,i_36,i_37,i_38,i_39,i_40,i_41,i_42,i_43,i_44,i_45,i_46,i_47,i_48,i_49,i_50,i_51,i_52,i_53,i_54,i_55,i_56,i_57,i_58,i_59,i_60,i_61,i_62,i_63);
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end 
        #64;
        #30;
        for (i = 0; i < DCT_32; i = i + 1) begin
            $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
                    o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31);
            #2;
        end
        for (i = 0; i < DCT_32; i = i + 1) begin
            $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
                    o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31);
        end
        $fclose(fp_r);
        $fclose(fp_w);
        #100
        //64x32
        i_width = 4; i_height = 5;
        i_valid = 1;
        fp_r = $fopen("../../../../../result/origin_data/origin_data_64x32.txt", "r");
        fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_64x32.txt", "w");
        cnt = 0;
        while (cnt < DCT_64) begin
            $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
                        i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7,i_8,i_9,i_10,i_11,i_12,i_13,i_14,i_15,i_16,i_17,i_18,i_19,i_20,i_21,i_22,i_23,i_24,i_25,i_26,i_27,i_28,i_29,i_30,i_31);
            i_32 = 0; i_33 = 0; i_34 = 0; i_35 = 0; i_36 = 0; i_37 = 0; i_38 = 0; i_39 = 0; i_40 = 0; i_41 = 0; i_42 = 0; i_43 = 0; i_44 = 0; i_45 = 0; i_46 = 0; i_47 = 0; 
            i_48 = 0; i_49 = 0; i_50 = 0; i_51 = 0; i_52 = 0; i_53 = 0; i_54 = 0; i_55 = 0; i_56 = 0; i_57 = 0; i_58 = 0; i_59 = 0; i_60 = 0; i_61 = 0; i_62 = 0; i_63 = 0; 
            cnt = cnt + 1;
            #2;
            if (cnt == 1) i_valid = 0; 
        end 
        #30;
        for (i = 0; i < DCT_32; i = i + 1) begin
            $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
                    o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,o_28,o_29,o_30,o_31,
                    o_32,o_33,o_34,o_35,o_36,o_37,o_38,o_39,o_40,o_41,o_42,o_43,o_44,o_45,o_46,o_47,o_48,o_49,o_50,o_51,o_52,o_53,o_54,o_55,o_56,o_57,o_58,o_59,o_60,o_61,o_62,o_63);
            #2;
        end
        $fclose(fp_r);
        $fclose(fp_w);

        #10;
        $stop;
    end    
`endif         

endmodule

