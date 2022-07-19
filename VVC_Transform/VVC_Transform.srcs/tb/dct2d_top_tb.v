`timescale 1ns / 1ns

module dct2d_top_tb();

parameter   BIT_DEPTH = 8,
            OUT_WIDTH = 16;

integer fp_r, fp_w, rd_i, rd_j, rd_k, wr_i, wr_j, wr_k;

//system input
    reg clk;
    reg rst_n;
//input parameter 
    reg [2 : 0] i_width;
    reg [2 : 0] i_height;
//input data
    reg i_valid;
    reg signed [BIT_DEPTH : 0] i_data[0 : 15];
//output parameter 
    wire [2 : 0] o_width;
    wire [2 : 0] o_height;
//output coeff
    wire o_valid;
    wire signed [OUT_WIDTH - 1 : 0] o_data[0 : 15];

//txt rd/wr
    reg signed [BIT_DEPTH : 0] rd_data[0 : 63];
    reg signed [OUT_WIDTH - 1 : 0] wr_data[0 : 63];

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
    .i_0         (i_data[0 ]  ),
    .i_1         (i_data[1 ]  ),
    .i_2         (i_data[2 ]  ),
    .i_3         (i_data[3 ]  ),
    .i_4         (i_data[4 ]  ),
    .i_5         (i_data[5 ]  ),
    .i_6         (i_data[6 ]  ),
    .i_7         (i_data[7 ]  ),
    .i_8         (i_data[8 ]  ),
    .i_9         (i_data[9 ]  ),
    .i_10        (i_data[10]  ),
    .i_11        (i_data[11]  ),
    .i_12        (i_data[12]  ),
    .i_13        (i_data[13]  ),
    .i_14        (i_data[14]  ),
    .i_15        (i_data[15]  ),
//output parameter
    .o_width     (o_width     ),
    .o_height    (o_height    ),
//output coeff
    .o_valid     (o_valid     ),
    .o_0         (o_data[0 ]  ),
    .o_1         (o_data[1 ]  ),
    .o_2         (o_data[2 ]  ),
    .o_3         (o_data[3 ]  ),
    .o_4         (o_data[4 ]  ),
    .o_5         (o_data[5 ]  ),
    .o_6         (o_data[6 ]  ),
    .o_7         (o_data[7 ]  ),
    .o_8         (o_data[8 ]  ),
    .o_9         (o_data[9 ]  ),
    .o_10        (o_data[10]  ),
    .o_11        (o_data[11]  ),
    .o_12        (o_data[12]  ),
    .o_13        (o_data[13]  ),
    .o_14        (o_data[14]  ),
    .o_15        (o_data[15]  )
);

always #1 begin
    clk <= ~clk;
end

//read
initial begin
    clk = 0;
    rst_n = 0;
    i_width = 0; i_height = 0;
    i_valid = 0;
    for (rd_i = 0; rd_i < 16; rd_i = rd_i + 1) begin
        i_data[rd_i] = 0;
    end
    #2;
    rst_n = 1;

    //64x64
    i_valid = 1;
    i_width = 5; i_height = 5;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_64x64.txt", "r");
    for (rd_i = 0; rd_i < 64; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15], 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31], 
            rd_data[32], rd_data[33], rd_data[34], rd_data[35], rd_data[36], rd_data[37], rd_data[38], rd_data[39], rd_data[40], rd_data[41], rd_data[42], rd_data[43], rd_data[44], rd_data[45], rd_data[46], rd_data[47], 
            rd_data[48], rd_data[49], rd_data[50], rd_data[51], rd_data[52], rd_data[53], rd_data[54], rd_data[55], rd_data[56], rd_data[57], rd_data[58], rd_data[59], rd_data[60], rd_data[61], rd_data[62], rd_data[63]);
        for (rd_j = 0; rd_j < 4; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 16; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 16 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //32x32
    i_valid = 1;
    i_width = 4; i_height = 4;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_32x32.txt", "r");
    for (rd_i = 0; rd_i < 32; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15], 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 2; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 16; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 16 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //16x16
    i_valid = 1;
    i_width = 3; i_height = 3;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_16x16.txt", "r");
    for (rd_i = 0; rd_i < 16; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 16; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 16 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //8x8
    i_valid = 1;
    i_width = 2; i_height = 2;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_8x8.txt", "r");
    for (rd_i = 0; rd_i < 4; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 16; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 16 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //4x4
    i_valid = 1;
    i_width = 1; i_height = 1;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_4x4.txt", "r");
    for (rd_i = 0; rd_i < 1; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 16; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 16 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //32x64
    i_valid = 1;
    i_width = 5; i_height = 4;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_32x64.txt", "r");
    for (rd_i = 0; rd_i < 32; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15], 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31], 
            rd_data[32], rd_data[33], rd_data[34], rd_data[35], rd_data[36], rd_data[37], rd_data[38], rd_data[39], rd_data[40], rd_data[41], rd_data[42], rd_data[43], rd_data[44], rd_data[45], rd_data[46], rd_data[47], 
            rd_data[48], rd_data[49], rd_data[50], rd_data[51], rd_data[52], rd_data[53], rd_data[54], rd_data[55], rd_data[56], rd_data[57], rd_data[58], rd_data[59], rd_data[60], rd_data[61], rd_data[62], rd_data[63]);
        for (rd_j = 0; rd_j < 4; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 16; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 16 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //64x32
    i_valid = 1;
    i_width = 4; i_height = 5;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_64x32.txt", "r");
    for (rd_i = 0; rd_i < 64; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15], 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 2; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 16; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 16 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);

    i_width = 0; i_height = 0;
    i_valid = 0;
    for (rd_i = 0; rd_i < 16; rd_i = rd_i + 1) begin
        i_data[rd_i] = 0;
    end

    #200;
    $stop;
end

//write
initial begin 
    #2;
    #100; //delay  clk
    //64x64
    fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_64x64.txt", "w");
    for (wr_i = 0; wr_i < 64; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 4; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 16; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 16] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15], 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31], 
            wr_data[32], wr_data[33], wr_data[34], wr_data[35], wr_data[36], wr_data[37], wr_data[38], wr_data[39], wr_data[40], wr_data[41], wr_data[42], wr_data[43], wr_data[44], wr_data[45], wr_data[46], wr_data[47], 
            wr_data[48], wr_data[49], wr_data[50], wr_data[51], wr_data[52], wr_data[53], wr_data[54], wr_data[55], wr_data[56], wr_data[57], wr_data[58], wr_data[59], wr_data[60], wr_data[61], wr_data[62], wr_data[63]);
    end
    $fclose(fp_w);
    //32x32
    fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_32x32.txt", "w");
    for (wr_i = 0; wr_i < 32; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 2; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 16; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 16] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15], 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //16x16
    fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_16x16.txt", "w");
    for (wr_i = 0; wr_i < 16; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 16; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 16] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
    end
    $fclose(fp_w);
    //8x8
    fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_8x8.txt", "w");
    for (wr_i = 0; wr_i < 4; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 16; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 16] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
    end
    $fclose(fp_w);
    //4x4
    fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_4x4.txt", "w"); 
    for (wr_i = 0; wr_i < 1; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 16; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 16] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
    end
    $fclose(fp_w);
    //32x64
    fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_32x64.txt", "w");
    for (wr_i = 0; wr_i < 64; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 2; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 16; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 16] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15], 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //64x32
    fp_w = $fopen("../../../../../result/fpga_coeff/fpga_coeff_64x32.txt", "w");
    for (wr_i = 0; wr_i < 32; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 4; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 16; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 16] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15], 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31], 
            wr_data[32], wr_data[33], wr_data[34], wr_data[35], wr_data[36], wr_data[37], wr_data[38], wr_data[39], wr_data[40], wr_data[41], wr_data[42], wr_data[43], wr_data[44], wr_data[45], wr_data[46], wr_data[47], 
            wr_data[48], wr_data[49], wr_data[50], wr_data[51], wr_data[52], wr_data[53], wr_data[54], wr_data[55], wr_data[56], wr_data[57], wr_data[58], wr_data[59], wr_data[60], wr_data[61], wr_data[62], wr_data[63]);
    end
    $fclose(fp_w);
end       

endmodule

