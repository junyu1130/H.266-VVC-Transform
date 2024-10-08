`timescale 1ns / 1ns

module transform2d_top_tb();

localparam  BIT_DEPTH = 8,
            OUT_WIDTH = 16;
localparam  DCT2   = 2'd0,
            DCT8   = 2'd1,
            DST7   = 2'd2;
localparam  SIZE4  = 3'd1,
            SIZE8  = 3'd2,
            SIZE16 = 3'd3,
            SIZE32 = 3'd4,
            SIZE64 = 3'd5;

integer fp_r, fp_w, rd_i, rd_j, rd_k, wr_i, wr_j, wr_k;

//system input
    reg clk;
    reg reset;
//input parameter 
    reg [1 : 0] i_type_h;//0:DCT2 1:DCT8 2:DST7   
    reg [1 : 0] i_type_v;
    reg [2 : 0] i_width;//1:4x4, 2:8x8, 3:16x16, 4:32x32, 5:64x64
    reg [2 : 0] i_height;
//input data
    reg i_valid;
    reg signed [BIT_DEPTH : 0] i_data[0 : 31];
//output parameter 
    wire [1 : 0] o_type_h;
    wire [1 : 0] o_type_v;
    wire [2 : 0] o_width;
    wire [2 : 0] o_height;
//output coeff
    wire o_valid;
    wire signed [OUT_WIDTH - 1 : 0] o_data[0 : 31];

//txt rd/wr
    reg signed [BIT_DEPTH : 0] rd_data[0 : 63];
    reg signed [OUT_WIDTH - 1 : 0] wr_data[0 : 63];

transform2d_top#(
    .BIT_DEPTH (BIT_DEPTH ),
    .OUT_WIDTH (OUT_WIDTH )
)
u_transform2d_top(
//system input
    .clk         (clk         ),
    .reset       (reset       ),
//input parameter
    .i_type_h    (i_type_h    ),
    .i_type_v    (i_type_v    ),
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
    .i_16        (i_data[16]  ),
    .i_17        (i_data[17]  ),
    .i_18        (i_data[18]  ),
    .i_19        (i_data[19]  ),
    .i_20        (i_data[20]  ),
    .i_21        (i_data[21]  ),
    .i_22        (i_data[22]  ),
    .i_23        (i_data[23]  ),
    .i_24        (i_data[24]  ),
    .i_25        (i_data[25]  ),
    .i_26        (i_data[26]  ),
    .i_27        (i_data[27]  ),
    .i_28        (i_data[28]  ),
    .i_29        (i_data[29]  ),
    .i_30        (i_data[30]  ),
    .i_31        (i_data[31]  ),
//output parameter
    .o_type_h    (o_type_h    ),
    .o_type_v    (o_type_v    ),
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
    .o_15        (o_data[15]  ),
    .o_16        (o_data[16]  ),
    .o_17        (o_data[17]  ),
    .o_18        (o_data[18]  ),
    .o_19        (o_data[19]  ),
    .o_20        (o_data[20]  ),
    .o_21        (o_data[21]  ),
    .o_22        (o_data[22]  ),
    .o_23        (o_data[23]  ),
    .o_24        (o_data[24]  ),
    .o_25        (o_data[25]  ),
    .o_26        (o_data[26]  ),
    .o_27        (o_data[27]  ),
    .o_28        (o_data[28]  ),
    .o_29        (o_data[29]  ),
    .o_30        (o_data[30]  ),
    .o_31        (o_data[31]  )
);

always #1 begin
    clk <= ~clk;
end

//read
initial begin
    clk = 0;
    reset = 0;
    i_type_h = 0;
    i_type_v = 0;
    i_width = 0; i_height = 0;
    i_valid = 0;
    for (rd_i = 0; rd_i < 32; rd_i = rd_i + 1) begin
        i_data[rd_i] = 0;
    end
    #2;
    reset = 1;
//DCT2

    //64x64
    i_valid = 1;
    i_type_h = DCT2;
    i_type_v = DCT2;
    i_width = SIZE64; i_height = SIZE64;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_64x64.txt", "r");
    for (rd_i = 0; rd_i < 64; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15], 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31], 
            rd_data[32], rd_data[33], rd_data[34], rd_data[35], rd_data[36], rd_data[37], rd_data[38], rd_data[39], rd_data[40], rd_data[41], rd_data[42], rd_data[43], rd_data[44], rd_data[45], rd_data[46], rd_data[47], 
            rd_data[48], rd_data[49], rd_data[50], rd_data[51], rd_data[52], rd_data[53], rd_data[54], rd_data[55], rd_data[56], rd_data[57], rd_data[58], rd_data[59], rd_data[60], rd_data[61], rd_data[62], rd_data[63]);
        for (rd_j = 0; rd_j < 2; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    
    //32x32
    i_valid = 1;
    i_type_h = DCT2;
    i_type_v = DCT2;
    i_width = SIZE32; i_height = SIZE32;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_32x32.txt", "r");
    for (rd_i = 0; rd_i < 32; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15], 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    
    //16x16
    i_valid = 1;
    i_type_h = DCT2;
    i_type_v = DCT2;
    i_width = SIZE16; i_height = SIZE16;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_16x16.txt", "r");
    for (rd_i = 0; rd_i < 8; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //8x8
    i_valid = 1;
    i_type_h = DCT2;
    i_type_v = DCT2;
    i_width = SIZE8; i_height = SIZE8;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_8x8.txt", "r");
    for (rd_i = 0; rd_i < 2; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //4x4
    i_valid = 1;
    i_type_h = DCT2;
    i_type_v = DCT2;
    i_width = SIZE4; i_height = SIZE4;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_4x4.txt", "r");
    for (rd_i = 0; rd_i < 1; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 16; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
                i_data[rd_k + 16] = 0;
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //4x16
    i_valid = 1;
    i_type_h = DCT2;
    i_type_v = DCT2;
    i_width = SIZE16; i_height = SIZE4;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_4x16.txt", "r");
    for (rd_i = 0; rd_i < 2; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    
    //8x4
    i_valid = 1;
    i_type_h = DCT2;
    i_type_v = DCT2;
    i_width = SIZE4; i_height = SIZE8;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_8x4.txt", "r");
    for (rd_i = 0; rd_i < 1; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[16], rd_data[17], rd_data[18], rd_data[19]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[20], rd_data[21], rd_data[22], rd_data[23]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[24], rd_data[25], rd_data[26], rd_data[27]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //32x8
    i_valid = 1;
    i_type_h = DCT2;
    i_type_v = DCT2;
    i_width = SIZE8; i_height = SIZE32;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_32x8.txt", "r");
    for (rd_i = 0; rd_i < 8; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //8x32
    i_valid = 1;
    i_type_h = DCT2;
    i_type_v = DCT2;
    i_width = SIZE32; i_height = SIZE8;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_8x32.txt", "r");
    for (rd_i = 0; rd_i < 8; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15], 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //32x4
    i_valid = 1;
    i_type_h = DCT2;
    i_type_v = DCT2;
    i_width = SIZE4; i_height = SIZE32;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_32x4.txt", "r");
    for (rd_i = 0; rd_i < 4; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[16], rd_data[17], rd_data[18], rd_data[19]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[20], rd_data[21], rd_data[22], rd_data[23]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[24], rd_data[25], rd_data[26], rd_data[27]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //16x32
    i_valid = 1;
    i_type_h = DCT2;
    i_type_v = DCT2;
    i_width = SIZE32; i_height = SIZE16;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_16x32.txt", "r");
    for (rd_i = 0; rd_i < 16; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15], 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    
    //32x64
    i_valid = 1;
    i_type_h = DCT2;
    i_type_v = DCT2;
    i_width = SIZE64; i_height = SIZE32;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_32x64.txt", "r");
    for (rd_i = 0; rd_i < 32; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15], 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31], 
            rd_data[32], rd_data[33], rd_data[34], rd_data[35], rd_data[36], rd_data[37], rd_data[38], rd_data[39], rd_data[40], rd_data[41], rd_data[42], rd_data[43], rd_data[44], rd_data[45], rd_data[46], rd_data[47], 
            rd_data[48], rd_data[49], rd_data[50], rd_data[51], rd_data[52], rd_data[53], rd_data[54], rd_data[55], rd_data[56], rd_data[57], rd_data[58], rd_data[59], rd_data[60], rd_data[61], rd_data[62], rd_data[63]);
        for (rd_j = 0; rd_j < 2; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //64x32
    i_valid = 1;
    i_type_h = DCT2;
    i_type_v = DCT2;
    i_width = SIZE32; i_height = SIZE64;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_64x32.txt", "r");
    for (rd_i = 0; rd_i < 64; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15], 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //64x8
    i_valid = 1;
    i_type_h = DCT2;
    i_type_v = DCT2;
    i_width = SIZE8; i_height = SIZE64;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_64x8.txt", "r");
    for (rd_i = 0; rd_i < 16; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //16x64
    i_valid = 1;
    i_type_h = DCT2;
    i_type_v = DCT2;
    i_width = SIZE64; i_height = SIZE16;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_16x64.txt", "r");
    for (rd_i = 0; rd_i < 16; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15], 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31], 
            rd_data[32], rd_data[33], rd_data[34], rd_data[35], rd_data[36], rd_data[37], rd_data[38], rd_data[39], rd_data[40], rd_data[41], rd_data[42], rd_data[43], rd_data[44], rd_data[45], rd_data[46], rd_data[47], 
            rd_data[48], rd_data[49], rd_data[50], rd_data[51], rd_data[52], rd_data[53], rd_data[54], rd_data[55], rd_data[56], rd_data[57], rd_data[58], rd_data[59], rd_data[60], rd_data[61], rd_data[62], rd_data[63]);
        for (rd_j = 0; rd_j < 2; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    
//DST7
    //32x32
    i_valid = 1;
    i_type_h = DST7;
    i_type_v = DST7;
    i_width = SIZE32; i_height = SIZE32;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_32x32.txt", "r");
    for (rd_i = 0; rd_i < 32; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15], 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //16x16
    i_valid = 1;
    i_type_h = DST7;
    i_type_v = DST7;
    i_width = SIZE16; i_height = SIZE16;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_16x16.txt", "r");
    for (rd_i = 0; rd_i < 8; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //8x8
    i_valid = 1;
    i_type_h = DST7;
    i_type_v = DST7;
    i_width = SIZE8; i_height = SIZE8;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_8x8.txt", "r");
    for (rd_i = 0; rd_i < 2; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //4x4
    i_valid = 1;
    i_type_h = DST7;
    i_type_v = DST7;
    i_width = SIZE4; i_height = SIZE4;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_4x4.txt", "r");
    for (rd_i = 0; rd_i < 1; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 16; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
                i_data[rd_k + 16] = 0;
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //4x16
    i_valid = 1;
    i_type_h = DST7;
    i_type_v = DST7;
    i_width = SIZE16; i_height = SIZE4;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_4x16.txt", "r");
    for (rd_i = 0; rd_i < 2; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //32x8
    i_valid = 1;
    i_type_h = DST7;
    i_type_v = DST7;
    i_width = SIZE8; i_height = SIZE32;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_32x8.txt", "r");
    for (rd_i = 0; rd_i < 8; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //8x32
    i_valid = 1;
    i_type_h = DST7;
    i_type_v = DST7;
    i_width = SIZE32; i_height = SIZE8;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_8x32.txt", "r");
    for (rd_i = 0; rd_i < 8; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15], 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //32x4
    i_valid = 1;
    i_type_h = DST7;
    i_type_v = DST7;
    i_width = SIZE4; i_height = SIZE32;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_32x4.txt", "r");
    for (rd_i = 0; rd_i < 4; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[16], rd_data[17], rd_data[18], rd_data[19]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[20], rd_data[21], rd_data[22], rd_data[23]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[24], rd_data[25], rd_data[26], rd_data[27]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //16x32
    i_valid = 1;
    i_type_h = DST7;
    i_type_v = DST7;
    i_width = SIZE32; i_height = SIZE16;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_16x32.txt", "r");
    for (rd_i = 0; rd_i < 16; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15], 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //8x4
    i_valid = 1;
    i_type_h = DST7;
    i_type_v = DST7;
    i_width = SIZE4; i_height = SIZE8;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_8x4.txt", "r");
    for (rd_i = 0; rd_i < 1; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[16], rd_data[17], rd_data[18], rd_data[19]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[20], rd_data[21], rd_data[22], rd_data[23]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[24], rd_data[25], rd_data[26], rd_data[27]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    // //invalid data
    // i_valid = 0;
    // i_type = 0;
    // i_width = 0; i_height = 0;
    // #100;
//DCT8
    //32x32
    i_valid = 1;
    i_type_h = DCT8;
    i_type_v = DCT8;
    i_width = SIZE32; i_height = SIZE32;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_32x32.txt", "r");
    for (rd_i = 0; rd_i < 32; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15], 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //16x16
    i_valid = 1;
    i_type_h = DCT8;
    i_type_v = DCT8;
    i_width = SIZE16; i_height = SIZE16;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_16x16.txt", "r");
    for (rd_i = 0; rd_i < 8; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //8x8
    i_valid = 1;
    i_type_h = DCT8;
    i_type_v = DCT8;
    i_width = SIZE8; i_height = SIZE8;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_8x8.txt", "r");
    for (rd_i = 0; rd_i < 2; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //4x4
    i_valid = 1;
    i_type_h = DCT8;
    i_type_v = DCT8;
    i_width = SIZE4; i_height = SIZE4;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_4x4.txt", "r");
    for (rd_i = 0; rd_i < 1; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 16; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
                i_data[rd_k + 16] = 0;
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //4x16
    i_valid = 1;
    i_type_h = DCT8;
    i_type_v = DCT8;
    i_width = SIZE16; i_height = SIZE4;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_4x16.txt", "r");
    for (rd_i = 0; rd_i < 2; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //32x8
    i_valid = 1;
    i_type_h = DCT8;
    i_type_v = DCT8;
    i_width = SIZE8; i_height = SIZE32;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_32x8.txt", "r");
    for (rd_i = 0; rd_i < 8; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //8x32
    i_valid = 1;
    i_type_h = DCT8;
    i_type_v = DCT8;
    i_width = SIZE32; i_height = SIZE8;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_8x32.txt", "r");
    for (rd_i = 0; rd_i < 8; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15], 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //32x4
    i_valid = 1;
    i_type_h = DCT8;
    i_type_v = DCT8;
    i_width = SIZE4; i_height = SIZE32;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_32x4.txt", "r");
    for (rd_i = 0; rd_i < 4; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[16], rd_data[17], rd_data[18], rd_data[19]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[20], rd_data[21], rd_data[22], rd_data[23]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[24], rd_data[25], rd_data[26], rd_data[27]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //16x32
    i_valid = 1;
    i_type_h = DCT8;
    i_type_v = DCT8;
    i_width = SIZE32; i_height = SIZE16;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_16x32.txt", "r");
    for (rd_i = 0; rd_i < 16; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
            rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ], rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ], rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11], rd_data[12], rd_data[13], rd_data[14], rd_data[15], 
            rd_data[16], rd_data[17], rd_data[18], rd_data[19], rd_data[20], rd_data[21], rd_data[22], rd_data[23], rd_data[24], rd_data[25], rd_data[26], rd_data[27], rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);
    //8x4
    i_valid = 1;
    i_type_h = DCT8;
    i_type_v = DCT8;
    i_width = SIZE4; i_height = SIZE8;
    fp_r = $fopen("../../../../../result/origin_data/origin_data_8x4.txt", "r");
    for (rd_i = 0; rd_i < 1; rd_i = rd_i + 1) begin
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[0 ], rd_data[1 ], rd_data[2 ], rd_data[3 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[4 ], rd_data[5 ], rd_data[6 ], rd_data[7 ]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[8 ], rd_data[9 ], rd_data[10], rd_data[11]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[12], rd_data[13], rd_data[14], rd_data[15]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[16], rd_data[17], rd_data[18], rd_data[19]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[20], rd_data[21], rd_data[22], rd_data[23]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[24], rd_data[25], rd_data[26], rd_data[27]);
        $fscanf(fp_r, "%d %d %d %d %d %d %d %d", rd_data[28], rd_data[29], rd_data[30], rd_data[31]);
        for (rd_j = 0; rd_j < 1; rd_j = rd_j + 1) begin
            for (rd_k = 0; rd_k < 32; rd_k = rd_k + 1) begin
                i_data[rd_k] = rd_data[rd_k + 32 * rd_j];
            end
            #2;
            i_valid = 0; 
        end
    end
    $fclose(fp_r);

    i_type_h = 0;
    i_type_v = 0;
    i_width = 0; i_height = 0;
    i_valid = 0;
    for (rd_i = 0; rd_i < 32; rd_i = rd_i + 1) begin
        i_data[rd_i] = 0;
    end

    #200;
    $stop;
end

//write
initial begin 
    #2;
    #290; //delay 145 clk
//DCT2
    //64x64
    fp_w = $fopen("../../../../../result/fpga_coeff/dct2/fpga_coeff_dct2_64x64.txt", "w");
    for (wr_i = 0; wr_i < 32; wr_i = wr_i + 1) begin
        for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
            wr_data[wr_k] = o_data[wr_k];
        end
        for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
            wr_data[wr_k + 32] = 0;
        end
        #4;
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15], 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31], 
            wr_data[32], wr_data[33], wr_data[34], wr_data[35], wr_data[36], wr_data[37], wr_data[38], wr_data[39], wr_data[40], wr_data[41], wr_data[42], wr_data[43], wr_data[44], wr_data[45], wr_data[46], wr_data[47], 
            wr_data[48], wr_data[49], wr_data[50], wr_data[51], wr_data[52], wr_data[53], wr_data[54], wr_data[55], wr_data[56], wr_data[57], wr_data[58], wr_data[59], wr_data[60], wr_data[61], wr_data[62], wr_data[63]);
    end
    for (wr_i = 0; wr_i < 32; wr_i = wr_i + 1) begin
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    end
    $fclose(fp_w);
    //32x32
    fp_w = $fopen("../../../../../result/fpga_coeff/dct2/fpga_coeff_dct2_32x32.txt", "w");
    for (wr_i = 0; wr_i < 32; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15], 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    
    //16x16
    fp_w = $fopen("../../../../../result/fpga_coeff/dct2/fpga_coeff_dct2_16x16.txt", "w");
    for (wr_i = 0; wr_i < 8; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //8x8
    fp_w = $fopen("../../../../../result/fpga_coeff/dct2/fpga_coeff_dct2_8x8.txt", "w");
    for (wr_i = 0; wr_i < 2; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //4x4
    fp_w = $fopen("../../../../../result/fpga_coeff/dct2/fpga_coeff_dct2_4x4.txt", "w"); 
    for (wr_i = 0; wr_i < 1; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 16; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
    end
    $fclose(fp_w);
    //4x16
    fp_w = $fopen("../../../../../result/fpga_coeff/dct2/fpga_coeff_dct2_4x16.txt", "w"); 
    for (wr_i = 0; wr_i < 2; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[16], wr_data[17], wr_data[18], wr_data[19]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[20], wr_data[21], wr_data[22], wr_data[23]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[24], wr_data[25], wr_data[26], wr_data[27]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);

    //8x4
    fp_w = $fopen("../../../../../result/fpga_coeff/dct2/fpga_coeff_dct2_8x4.txt", "w");
    for (wr_i = 0; wr_i < 1; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //32x8
    fp_w = $fopen("../../../../../result/fpga_coeff/dct2/fpga_coeff_dct2_32x8.txt", "w");
    for (wr_i = 0; wr_i < 8; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15], 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //8x32
    fp_w = $fopen("../../../../../result/fpga_coeff/dct2/fpga_coeff_dct2_8x32.txt", "w");
    for (wr_i = 0; wr_i < 8; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //32x4
    fp_w = $fopen("../../../../../result/fpga_coeff/dct2/fpga_coeff_dct2_32x4.txt", "w");
    for (wr_i = 0; wr_i < 4; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15], 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //16x32
    fp_w = $fopen("../../../../../result/fpga_coeff/dct2/fpga_coeff_dct2_16x32.txt", "w");
    for (wr_i = 0; wr_i < 16; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    
    //32x64
    fp_w = $fopen("../../../../../result/fpga_coeff/dct2/fpga_coeff_dct2_32x64.txt", "w");
    for (wr_i = 0; wr_i < 64; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15], 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //64x32
    fp_w = $fopen("../../../../../result/fpga_coeff/dct2/fpga_coeff_dct2_64x32.txt", "w");
    for (wr_i = 0; wr_i < 32; wr_i = wr_i + 1) begin
        for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
            wr_data[wr_k] = o_data[wr_k];
        end
        for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
            wr_data[wr_k + 32] = 0;
        end
        #4;
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15], 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31], 
            wr_data[32], wr_data[33], wr_data[34], wr_data[35], wr_data[36], wr_data[37], wr_data[38], wr_data[39], wr_data[40], wr_data[41], wr_data[42], wr_data[43], wr_data[44], wr_data[45], wr_data[46], wr_data[47], 
            wr_data[48], wr_data[49], wr_data[50], wr_data[51], wr_data[52], wr_data[53], wr_data[54], wr_data[55], wr_data[56], wr_data[57], wr_data[58], wr_data[59], wr_data[60], wr_data[61], wr_data[62], wr_data[63]);
    end
    $fclose(fp_w);
    //64x8
    fp_w = $fopen("../../../../../result/fpga_coeff/dct2/fpga_coeff_dct2_64x8.txt", "w");
    for (wr_i = 0; wr_i < 8; wr_i = wr_i + 1) begin
        for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
            wr_data[wr_k] = o_data[wr_k];
        end
        for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
            wr_data[wr_k + 32] = 0;
        end
        #4;
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15], 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31], 
            wr_data[32], wr_data[33], wr_data[34], wr_data[35], wr_data[36], wr_data[37], wr_data[38], wr_data[39], wr_data[40], wr_data[41], wr_data[42], wr_data[43], wr_data[44], wr_data[45], wr_data[46], wr_data[47], 
            wr_data[48], wr_data[49], wr_data[50], wr_data[51], wr_data[52], wr_data[53], wr_data[54], wr_data[55], wr_data[56], wr_data[57], wr_data[58], wr_data[59], wr_data[60], wr_data[61], wr_data[62], wr_data[63]);
    end
    $fclose(fp_w);
    //16x64
    fp_w = $fopen("../../../../../result/fpga_coeff/dct2/fpga_coeff_dct2_16x64.txt", "w");
    for (wr_i = 0; wr_i < 32; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);


    
//DST7
    //32x32
    fp_w = $fopen("../../../../../result/fpga_coeff/dst7/fpga_coeff_dst7_32x32.txt", "w");
    for (wr_i = 0; wr_i < 32; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15], 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //16x16
    fp_w = $fopen("../../../../../result/fpga_coeff/dst7/fpga_coeff_dst7_16x16.txt", "w");
    for (wr_i = 0; wr_i < 8; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //8x8
    fp_w = $fopen("../../../../../result/fpga_coeff/dst7/fpga_coeff_dst7_8x8.txt", "w");
    for (wr_i = 0; wr_i < 2; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //4x4
    fp_w = $fopen("../../../../../result/fpga_coeff/dst7/fpga_coeff_dst7_4x4.txt", "w"); 
    for (wr_i = 0; wr_i < 1; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 16; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
    end
    $fclose(fp_w);
    //4x16
    fp_w = $fopen("../../../../../result/fpga_coeff/dst7/fpga_coeff_dst7_4x16.txt", "w"); 
    for (wr_i = 0; wr_i < 2; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[16], wr_data[17], wr_data[18], wr_data[19]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[20], wr_data[21], wr_data[22], wr_data[23]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[24], wr_data[25], wr_data[26], wr_data[27]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //32x8
    fp_w = $fopen("../../../../../result/fpga_coeff/dst7/fpga_coeff_dst7_32x8.txt", "w");
    for (wr_i = 0; wr_i < 8; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15], 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //8x32
    fp_w = $fopen("../../../../../result/fpga_coeff/dst7/fpga_coeff_dst7_8x32.txt", "w");
    for (wr_i = 0; wr_i < 8; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //32x4
    fp_w = $fopen("../../../../../result/fpga_coeff/dst7/fpga_coeff_dst7_32x4.txt", "w");
    for (wr_i = 0; wr_i < 4; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15], 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //16x32
    fp_w = $fopen("../../../../../result/fpga_coeff/dst7/fpga_coeff_dst7_16x32.txt", "w");
    for (wr_i = 0; wr_i < 16; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //8x4
    fp_w = $fopen("../../../../../result/fpga_coeff/dst7/fpga_coeff_dst7_8x4.txt", "w");
    for (wr_i = 0; wr_i < 1; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
//DCT8
    // #100;
    //32x32
    fp_w = $fopen("../../../../../result/fpga_coeff/dct8/fpga_coeff_dct8_32x32.txt", "w");
    for (wr_i = 0; wr_i < 32; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15], 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //16x16
    fp_w = $fopen("../../../../../result/fpga_coeff/dct8/fpga_coeff_dct8_16x16.txt", "w");
    for (wr_i = 0; wr_i < 8; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //8x8
    fp_w = $fopen("../../../../../result/fpga_coeff/dct8/fpga_coeff_dct8_8x8.txt", "w");
    for (wr_i = 0; wr_i < 2; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //4x4
    fp_w = $fopen("../../../../../result/fpga_coeff/dct8/fpga_coeff_dct8_4x4.txt", "w"); 
    for (wr_i = 0; wr_i < 1; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 16; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
    end
    $fclose(fp_w);
    //4x16
    fp_w = $fopen("../../../../../result/fpga_coeff/dct8/fpga_coeff_dct8_4x16.txt", "w"); 
    for (wr_i = 0; wr_i < 2; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[16], wr_data[17], wr_data[18], wr_data[19]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[20], wr_data[21], wr_data[22], wr_data[23]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[24], wr_data[25], wr_data[26], wr_data[27]);
        $fwrite(fp_w, "%6d %6d %6d %6d\n", wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //32x8
    fp_w = $fopen("../../../../../result/fpga_coeff/dct8/fpga_coeff_dct8_32x8.txt", "w");
    for (wr_i = 0; wr_i < 8; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15], 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //8x32
    fp_w = $fopen("../../../../../result/fpga_coeff/dct8/fpga_coeff_dct8_8x32.txt", "w");
    for (wr_i = 0; wr_i < 8; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //32x4
    fp_w = $fopen("../../../../../result/fpga_coeff/dct8/fpga_coeff_dct8_32x4.txt", "w");
    for (wr_i = 0; wr_i < 4; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15], 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //16x32
    fp_w = $fopen("../../../../../result/fpga_coeff/dct8/fpga_coeff_dct8_16x32.txt", "w");
    for (wr_i = 0; wr_i < 16; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ], wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23], wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);
    //8x4
    fp_w = $fopen("../../../../../result/fpga_coeff/dct8/fpga_coeff_dct8_8x4.txt", "w");
    for (wr_i = 0; wr_i < 1; wr_i = wr_i + 1) begin
        for (wr_j = 0; wr_j < 1; wr_j = wr_j + 1) begin
            for (wr_k = 0; wr_k < 32; wr_k = wr_k + 1) begin
                wr_data[wr_k + wr_j * 32] = o_data[wr_k];
            end
            #2;
        end
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[0 ], wr_data[1 ], wr_data[2 ], wr_data[3 ], wr_data[4 ], wr_data[5 ], wr_data[6 ], wr_data[7 ]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[8 ], wr_data[9 ], wr_data[10], wr_data[11], wr_data[12], wr_data[13], wr_data[14], wr_data[15]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[16], wr_data[17], wr_data[18], wr_data[19], wr_data[20], wr_data[21], wr_data[22], wr_data[23]);
        $fwrite(fp_w, "%6d %6d %6d %6d %6d %6d %6d %6d\n", 
            wr_data[24], wr_data[25], wr_data[26], wr_data[27], wr_data[28], wr_data[29], wr_data[30], wr_data[31]);
    end
    $fclose(fp_w);

end       

endmodule

