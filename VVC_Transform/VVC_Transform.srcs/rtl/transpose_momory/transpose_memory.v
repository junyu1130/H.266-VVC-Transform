//describe  : 转置存储器
//input     : 16个变换系数(H)
//output    : 16个变换系数(V)
//delay     : 259(64x64) / 131(other) clk (1 + 256/128 + 2)
module transpose_memory#(
    parameter  WIDTH  = 16
)
(
//system input
    input                               clk     ,
    input                               rst_n   ,
//input parameter
    input           [1 : 0]             i_type  ,//0:DCT2 1:DCT8 2:DST7                    
    input           [2 : 0]             i_width ,//1st 1:4x4, 2:8x8, 3:16x16, 4:32x32, 5:64x64
    input           [2 : 0]             i_height,//2nd
//input coeff
    input                               i_valid ,
    input   signed  [WIDTH - 1 : 0]     i_0     ,
    input   signed  [WIDTH - 1 : 0]     i_1     ,
    input   signed  [WIDTH - 1 : 0]     i_2     ,
    input   signed  [WIDTH - 1 : 0]     i_3     ,
    input   signed  [WIDTH - 1 : 0]     i_4     ,
    input   signed  [WIDTH - 1 : 0]     i_5     ,
    input   signed  [WIDTH - 1 : 0]     i_6     ,
    input   signed  [WIDTH - 1 : 0]     i_7     ,
    input   signed  [WIDTH - 1 : 0]     i_8     ,
    input   signed  [WIDTH - 1 : 0]     i_9     ,
    input   signed  [WIDTH - 1 : 0]     i_10    ,
    input   signed  [WIDTH - 1 : 0]     i_11    ,
    input   signed  [WIDTH - 1 : 0]     i_12    ,
    input   signed  [WIDTH - 1 : 0]     i_13    ,
    input   signed  [WIDTH - 1 : 0]     i_14    ,
    input   signed  [WIDTH - 1 : 0]     i_15    ,
//output parameter
    output          [1 : 0]             o_type  ,
    output          [2 : 0]             o_width ,
    output          [2 : 0]             o_height,
//output coeff
    output                              o_valid ,
    output  signed  [WIDTH - 1 : 0]     o_0     ,
    output  signed  [WIDTH - 1 : 0]     o_1     ,
    output  signed  [WIDTH - 1 : 0]     o_2     ,
    output  signed  [WIDTH - 1 : 0]     o_3     ,
    output  signed  [WIDTH - 1 : 0]     o_4     ,
    output  signed  [WIDTH - 1 : 0]     o_5     ,
    output  signed  [WIDTH - 1 : 0]     o_6     ,
    output  signed  [WIDTH - 1 : 0]     o_7     ,
    output  signed  [WIDTH - 1 : 0]     o_8     ,
    output  signed  [WIDTH - 1 : 0]     o_9     ,
    output  signed  [WIDTH - 1 : 0]     o_10    ,
    output  signed  [WIDTH - 1 : 0]     o_11    ,
    output  signed  [WIDTH - 1 : 0]     o_12    ,
    output  signed  [WIDTH - 1 : 0]     o_13    ,
    output  signed  [WIDTH - 1 : 0]     o_14    ,
    output  signed  [WIDTH - 1 : 0]     o_15    
);

localparam  SIZE4  = 3'd1,
            SIZE8  = 3'd2,
            SIZE16 = 3'd3,
            SIZE32 = 3'd4,
            SIZE64 = 3'd5;
integer i, j, k;

//input
    wire signed [WIDTH - 1 : 0] i_data[0 : 15];
    reg  signed [WIDTH - 1 : 0] i_data_d1[0 : 15];
    reg         [1 : 0]         i_type_d[0 : 255];
    reg         [2 : 0]         i_width_d[0 : 255];
    reg         [2 : 0]         i_height_d[0 : 255];
    reg         [255 : 0]       i_valid_d;
    reg         [7 : 0]         transpose_delay;
//ram wr
    reg                         wr_en;
    reg  signed [WIDTH - 1 : 0] wr_data[0 : 15];
    reg  signed [WIDTH - 1 : 0] wr_data_shift[0 : 15];
    reg         [7 : 0]         wr_addr[0 : 15]; 
    reg         [7 : 0]         wr_addr_shift[0 : 15];  
    reg         [7 : 0]         wr_count;
    reg         [7 : 0]         wr_count_max;
    reg         [7 : 0]         wr_point;
    reg         [3 : 0]         wr_shift;
    wire                        is_maxblock_zero_data;
//ram rd
    reg                         rd_en, rd_en_d1;
    wire signed [WIDTH - 1 : 0] rd_data[0 : 15];
    reg  signed [WIDTH - 1 : 0] rd_data_shift[0 : 15];
    reg         [6 : 0]         rd_count;
    reg         [6 : 0]         rd_count_max;
    reg         [7 : 0]         rd_point;
    wire        [1 : 0]         rd_type = i_type_d[transpose_delay];
    wire        [2 : 0]         rd_width = i_width_d[transpose_delay];
    wire        [2 : 0]         rd_height = i_height_d[transpose_delay];
    wire                        rd_valid = i_valid_d[transpose_delay];
    reg         [3 : 0]         rd_shift;
//output
    reg         [1 : 0]         rd_type_d1, rd_type_d2;   
    reg         [2 : 0]         rd_width_d1, rd_width_d2;
    reg         [2 : 0]         rd_height_d1, rd_height_d2;
    reg                         rd_valid_d1, rd_valid_d2; 

//input
    assign i_data[0 ] = i_0 ;
    assign i_data[1 ] = i_1 ;
    assign i_data[2 ] = i_2 ;
    assign i_data[3 ] = i_3 ;
    assign i_data[4 ] = i_4 ;
    assign i_data[5 ] = i_5 ;
    assign i_data[6 ] = i_6 ;
    assign i_data[7 ] = i_7 ;
    assign i_data[8 ] = i_8 ;
    assign i_data[9 ] = i_9 ;
    assign i_data[10] = i_10;
    assign i_data[11] = i_11;
    assign i_data[12] = i_12;
    assign i_data[13] = i_13;
    assign i_data[14] = i_14;
    assign i_data[15] = i_15;

//input data delay 1 clk
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i = 0; i < 16; i = i + 1) begin
            i_data_d1[i] <= 0;
        end
    end
    else begin
        for (i = 0;i < 16; i = i + 1) begin
            i_data_d1[i] <= i_data[i];
        end
    end
end

//input delay
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin 
        for (i = 0; i < 256; i = i + 1) begin
            i_type_d[i] <= 0;
            i_width_d[i] <= 0;
            i_height_d[i] <= 0;
        end
        i_valid_d <= 0;
    end
    else begin
        i_type_d[0] <= i_type;
        i_width_d[0] <= i_width;
        i_height_d[0] <= i_height;
        for (i = 0; i < 127; i = i + 1) begin
            i_type_d[i + 1] <= i_type_d[i];
            i_width_d[i + 1] <= i_width_d[i];
            i_height_d[i + 1] <= i_height_d[i];
        end
        i_valid_d[127 : 0] <= {i_valid_d[126 : 0], i_valid};

        if (transpose_delay == 255) begin //64x64才允许沿256个clk，避免前边小块的影响
            for (i = 127; i < 255; i = i + 1) begin
                i_type_d[i + 1] <= i_type_d[i];
                i_width_d[i + 1] <= i_width_d[i];
                i_height_d[i + 1] <= i_height_d[i];
            end
            i_valid_d[255 : 128] <= {i_valid_d[254 : 128], i_valid_d[127]};
        end
        else begin
            for (i = 127; i < 255; i = i + 1) begin
                i_type_d[i + 1] <= 0;
                i_width_d[i + 1] <= 0;
                i_height_d[i + 1] <= 0;
            end
            i_valid_d[255 : 128] <= 0;
        end
    end
end

//decide the transpose_delay
always @(*) begin
    if (i_width_d[127] == SIZE64 && i_height_d[127] == SIZE64) //64x64
        transpose_delay <= 255;
    else 
        transpose_delay <= 127;
end

//ram wr enable
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        wr_en <= 0;
    else if (i_valid)
        wr_en <= 1;
    else if (wr_count == wr_count_max) //无效数据
        wr_en <= 0;
end

//decide the wr_count_max
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        wr_count_max <= 0;
    end
    else begin
        case ({i_width, i_height})
            {SIZE4 , SIZE4 } : wr_count_max <= 0;
            {SIZE8 , SIZE4 } : wr_count_max <= 1;
            {SIZE16, SIZE4 } : wr_count_max <= 3;
            {SIZE32, SIZE4 } : wr_count_max <= 7;
            {SIZE64, SIZE4 } : wr_count_max <= 15;
            {SIZE4 , SIZE8 } : wr_count_max <= 1;
            {SIZE8 , SIZE8 } : wr_count_max <= 3;
            {SIZE16, SIZE8 } : wr_count_max <= 7;
            {SIZE32, SIZE8 } : wr_count_max <= 15;
            {SIZE64, SIZE8 } : wr_count_max <= 31;
            {SIZE4 , SIZE16} : wr_count_max <= 3;
            {SIZE8 , SIZE16} : wr_count_max <= 7;
            {SIZE16, SIZE16} : wr_count_max <= 15;
            {SIZE32, SIZE16} : wr_count_max <= 31;
            {SIZE64, SIZE16} : wr_count_max <= 63;
            {SIZE4 , SIZE32} : wr_count_max <= 7;
            {SIZE8 , SIZE32} : wr_count_max <= 15;
            {SIZE16, SIZE32} : wr_count_max <= 31;
            {SIZE32, SIZE32} : wr_count_max <= 63;
            {SIZE64, SIZE32} : wr_count_max <= 127;
            {SIZE4 , SIZE64} : wr_count_max <= 15;
            {SIZE8 , SIZE64} : wr_count_max <= 31;
            {SIZE16, SIZE64} : wr_count_max <= 63;
            {SIZE32, SIZE64} : wr_count_max <= 127;
            {SIZE64, SIZE64} : wr_count_max <= 255;
            default          : wr_count_max <= 0;
        endcase
    end
end

//wr count 
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        wr_count <= 0;
    else if (wr_en)
        if (wr_count == wr_count_max)
            wr_count <= 0;
        else
            wr_count <= wr_count + 1;
end

assign is_maxblock_zero_data = (i_width_d[wr_count] == SIZE64 && i_height_d[wr_count] == SIZE64) && (wr_count % 4 == 2 || wr_count % 4 == 3);//64x64高频置零的无效数据

//wr address point
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        wr_point <= 0;
    else if (wr_en && wr_count == wr_count_max)
        if (wr_count_max == 255) //64x64
            wr_point <= wr_point + 128;
        else
            wr_point <= wr_point + wr_count_max + 1;
end

//ram storage structure
always @(*) begin
    for (i = 0; i < 16; i = i + 1) begin
        wr_data[i] <= 0;
        wr_addr[i] <= 0;
    end
    case ({i_width_d[wr_count], i_height_d[wr_count]})
        {SIZE4 , SIZE4 } : begin 
            for (i = 0; i < 4; i = i + 1) begin
                for (j = 0; j < 1; j = j + 1) begin
                    for (k = 0; k < 4; k = k + 1) begin
                        wr_data[i * 4 + j * 4 + k] <= i_data_d1[i + 4 * j + 4 * k];
                        wr_addr[i * 4 + j * 4 + k] <= wr_point + j;
                    end
                end
            end
        end
        {SIZE8 , SIZE4 } : begin 
            for (i = 0; i < 4; i = i + 1) begin
                for (j = 0; j < 2; j = j + 1) begin
                    for (k = 0; k < 2; k = k + 1) begin
                        wr_data[i * 4 + j * 2 + k] <= i_data_d1[i + 4 * j + 8 * k];
                        wr_addr[i * 4 + j * 2 + k] <= wr_point + j;
                    end
                end
            end
        end
        {SIZE16, SIZE4 } : begin
            for (i = 0; i < 4; i = i + 1) begin
                for (j = 0; j < 4; j = j + 1) begin
                    for (k = 0; k < 1; k = k + 1) begin
                        wr_data[i * 4 + j * 1 + k] <= i_data_d1[i + 4 * j + 16 * k];
                        wr_addr[i * 4 + j * 1 + k] <= wr_point + j;
                    end
                end
            end
        end
        {SIZE32, SIZE4 } : begin 
            for (i = 0; i < 4; i = i + 1) begin
                for (j = 0; j < 4; j = j + 1) begin
                    for (k = 0; k < 1; k = k + 1) begin
                        wr_data[i * 4 + j * 1 + k] <= i_data_d1[i + 4 * j + 16 * k];
                        if (wr_count % 2 == 0) begin
                            wr_addr[i * 4 + j * 1 + k] <= wr_point + j;
                        end
                        else begin
                            wr_addr[i * 4 + j * 1 + k] <= wr_point + j + 4;
                        end
                    end
                end
            end
        end
        {SIZE64, SIZE4 } : begin 
            for (i = 0; i < 4; i = i + 1) begin
                for (j = 0; j < 4; j = j + 1) begin
                    for (k = 0; k < 1; k = k + 1) begin
                        wr_data[i * 4 + j * 1 + k] <= i_data_d1[i + 4 * j + 16 * k];
                        if (wr_count % 4 == 0) begin
                            wr_addr[i * 4 + j * 1 + k] <= wr_point + j;
                        end
                        else if (wr_count % 4 == 1) begin
                            wr_addr[i * 4 + j * 1 + k] <= wr_point + j + 4;
                        end
                        if (wr_count % 4 == 2) begin
                            wr_addr[i * 4 + j * 1 + k] <= wr_point + j + 8;
                        end
                        else begin
                            wr_addr[i * 4 + j * 1 + k] <= wr_point + j + 12;
                        end
                    end
                end
            end
        end
        {SIZE4 , SIZE8 } : begin
            for (i = 0; i < 2; i = i + 1) begin
                for (j = 0; j < 2; j = j + 1) begin
                    for (k = 0; k < 4; k = k + 1) begin
                        wr_data[i * 8 + j * 4 + k] <= i_data_d1[i + 2 * j + 4 * k];
                        wr_addr[i * 8 + j * 4 + k] <= wr_point + j;
                    end
                end
            end
        end
        {SIZE8 , SIZE8 } : begin
            for (i = 0; i < 2; i = i + 1) begin
                for (j = 0; j < 4; j = j + 1) begin
                    for (k = 0; k < 2; k = k + 1) begin
                        wr_data[i * 8 + j * 2 + k] <= i_data_d1[i + 2 * j + 8 * k];
                        wr_addr[i * 8 + j * 2 + k] <= wr_point + j;
                    end
                end
            end
        end
        {SIZE16, SIZE8 } : begin 
            for (i = 0; i < 2; i = i + 1) begin
                for (j = 0; j < 8; j = j + 1) begin
                    for (k = 0; k < 1; k = k + 1) begin
                        wr_data[i * 8 + j * 1 + k] <= i_data_d1[i + 2 * j + 16 * k];
                        wr_addr[i * 8 + j * 1 + k] <= wr_point + j;
                    end
                end
            end
        end
        {SIZE32, SIZE8 } : begin
            for (i = 0; i < 2; i = i + 1) begin
                for (j = 0; j < 8; j = j + 1) begin
                    for (k = 0; k < 1; k = k + 1) begin
                        wr_data[i * 8 + j * 1 + k] <= i_data_d1[i + 2 * j + 16 * k];
                        if (wr_count % 2 == 0) begin
                            wr_addr[i * 8 + j * 1 + k] <= wr_point + j;
                        end
                        else begin
                            wr_addr[i * 8 + j * 1 + k] <= wr_point + j + 8;
                        end
                    end
                end
            end
        end
        {SIZE64, SIZE8 } : begin
            for (i = 0; i < 2; i = i + 1) begin
                for (j = 0; j < 8; j = j + 1) begin
                    for (k = 0; k < 1; k = k + 1) begin
                        wr_data[i * 8 + j * 1 + k] <= i_data_d1[i + 2 * j + 16 * k];
                        if (wr_count % 4 == 0) begin
                            wr_addr[i * 8 + j * 1 + k] <= wr_point + j;
                        end
                        else if (wr_count % 4 == 1) begin
                            wr_addr[i * 8 + j * 1 + k] <= wr_point + j + 8;
                        end
                        else if (wr_count % 4 == 2) begin
                            wr_addr[i * 8 + j * 1 + k] <= wr_point + j + 16;
                        end
                        else begin
                            wr_addr[i * 8 + j * 1 + k] <= wr_point + j + 24;
                        end
                    end
                end
            end
        end
        {SIZE4 , SIZE16} : begin
            for (i = 0; i < 1; i = i + 1) begin
                for (j = 0; j < 4; j = j + 1) begin
                    for (k = 0; k < 4; k = k + 1) begin
                        wr_data[i * 16 + j * 4 + k] <= i_data_d1[i + j + 4 * k];
                        wr_addr[i * 16 + j * 4 + k] <= wr_point + j;
                    end
                end
            end
        end
        {SIZE8 , SIZE16} : begin
            for (i = 0; i < 1; i = i + 1) begin
                for (j = 0; j < 8; j = j + 1) begin
                    for (k = 0; k < 2; k = k + 1) begin
                        wr_data[i * 16 + j * 2 + k] <= i_data_d1[i + j + 8 * k];
                        wr_addr[i * 16 + j * 2 + k] <= wr_point + j;
                    end
                end
            end
        end
        {SIZE16, SIZE16} : begin
            for (i = 0; i < 1; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    for (k = 0; k < 1; k = k + 1) begin
                        wr_data[i * 16 + j * 1 + k] <= i_data_d1[i + j + 16 * k];
                        wr_addr[i * 16 + j * 1 + k] <= wr_point + j;
                    end
                end
            end
        end
        {SIZE32, SIZE16} : begin
            for (i = 0; i < 1; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    for (k = 0; k < 1; k = k + 1) begin
                        wr_data[i * 16 + j * 1 + k] <= i_data_d1[i + j + 16 * k];
                        if (wr_count % 2 == 0) begin
                            wr_addr[i * 16 + j * 1 + k] <= wr_point + j;
                        end
                        else begin
                            wr_addr[i * 16 + j * 1 + k] <= wr_point + j + 16;
                        end
                    end
                end
            end
        end
        {SIZE64, SIZE16} : begin
            for (i = 0; i < 1; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    for (k = 0; k < 1; k = k + 1) begin
                        wr_data[i * 16 + j * 1 + k] <= i_data_d1[i + j + 16 * k];
                        if (wr_count % 4 == 0) begin
                            wr_addr[i * 16 + j * 1 + k] <= wr_point + j;
                        end
                        else if (wr_count % 4 == 1) begin
                            wr_addr[i * 16 + j * 1 + k] <= wr_point + j + 16;
                        end
                        else if (wr_count % 4 == 2) begin
                            wr_addr[i * 16 + j * 1 + k] <= wr_point + j + 32;
                        end
                        else begin
                            wr_addr[i * 16 + j * 1 + k] <= wr_point + j + 48;
                        end
                    end
                end
            end
        end
        {SIZE4 , SIZE32} : begin
            for (j = 0; j < 4; j = j + 1) begin
                for (k = 0; k < 4; k = k + 1) begin
                    wr_data[j * 4 + k] <= i_data_d1[j + 4 * k];
                    if (wr_count < 4) begin
                        wr_addr[j * 4 + k] <= wr_point + 2 * j;
                    end
                    else begin
                        wr_addr[j * 4 + k] <= wr_point + 2 * j + 1;
                    end
                end
            end
        end
        {SIZE8 , SIZE32} : begin
            for (j = 0; j < 8; j = j + 1) begin
                for (k = 0; k < 2; k = k + 1) begin
                    wr_data[j * 2 + k] <= i_data_d1[j + 8 * k];
                    if (wr_count < 8) begin
                        wr_addr[j * 2 + k] <= wr_point + 2 * j;
                    end
                    else begin
                        wr_addr[j * 2 + k] <= wr_point + 2 * j + 1;
                    end
                end
            end
        end
        {SIZE16, SIZE32} : begin
            for (j = 0; j < 16; j = j + 1) begin
                for (k = 0; k < 1; k = k + 1) begin
                    wr_data[j * 1 + k] <= i_data_d1[j + 16 * k];
                    if (wr_count < 16) begin
                        wr_addr[j * 1 + k] <= wr_point + 2 * j;
                    end
                    else begin
                        wr_addr[j * 1 + k] <= wr_point + 2 * j + 1;
                    end
                end
            end
        end
        {SIZE32, SIZE32} : begin
            for (j = 0; j < 16; j = j + 1) begin
                wr_data[j] <= i_data_d1[j];
                if (wr_count < 32) begin
                    if (wr_count % 2 == 0) begin
                        wr_addr[j] <= wr_point + 2 * j;
                    end
                    else begin
                        wr_addr[j] <= wr_point + 2 * j + 32;
                    end
                end
                else begin
                    if (wr_count % 2 == 0) begin
                        wr_addr[j] <= wr_point + 2 * j + 1;
                    end
                    else begin
                        wr_addr[j] <= wr_point + 2 * j + 33;
                    end
                end
            end
        end
        {SIZE64, SIZE32} : begin
            for (j = 0; j < 16; j = j + 1) begin
                wr_data[j] <= i_data_d1[j];
                if (wr_count < 64) begin
                    if (wr_count % 4 == 0) begin
                        wr_addr[j] <= wr_point + 2 * j;
                    end
                    else if (wr_count % 4 == 1) begin
                        wr_addr[j] <= wr_point + 2 * j + 32;
                    end
                    else if (wr_count % 4 == 2) begin
                        wr_addr[j] <= wr_point + 2 * j + 64;
                    end
                    else begin
                        wr_addr[j] <= wr_point + 2 * j + 96;
                    end
                end
                else begin
                    if (wr_count % 4 == 0) begin
                        wr_addr[j] <= wr_point + 2 * j + 1;
                    end
                    else if (wr_count % 4 == 1) begin
                        wr_addr[j] <= wr_point + 2 * j + 33;
                    end
                    else if (wr_count % 4 == 2) begin
                        wr_addr[j] <= wr_point + 2 * j + 65;
                    end
                    else begin
                        wr_addr[j] <= wr_point + 2 * j + 97;
                    end
                end
            end
        end
        {SIZE4 , SIZE64} : begin
            for (j = 0; j < 4; j = j + 1) begin
                for (k = 0; k < 4; k = k + 1) begin
                    wr_data[j * 4 + k] <= i_data_d1[j + 4 * k];
                    if (wr_count < 4) begin
                        wr_addr[j * 4 + k] <= wr_point + 4 * j;
                    end
                    else if (wr_count < 8) begin
                        wr_addr[j * 4 + k] <= wr_point + 4 * j + 1;
                    end
                    else if (wr_count < 12) begin
                        wr_addr[j * 4 + k] <= wr_point + 4 * j + 2;
                    end
                    else begin
                        wr_addr[j * 4 + k] <= wr_point + 4 * j + 3;
                    end
                end
            end
        end
        {SIZE8 , SIZE64} : begin
            for (j = 0; j < 8; j = j + 1) begin
                for (k = 0; k < 2; k = k + 1) begin
                    wr_data[j * 2 + k] <= i_data_d1[j + 8 * k];
                    if (wr_count < 8) begin
                        wr_addr[j * 2 + k] <= wr_point + 4 * j;
                    end
                    else if (wr_count < 16) begin
                        wr_addr[j * 2 + k] <= wr_point + 4 * j + 1;
                    end
                    else if (wr_count < 24) begin
                        wr_addr[j * 2 + k] <= wr_point + 4 * j + 2;
                    end
                    else begin
                        wr_addr[j * 2 + k] <= wr_point + 4 * j + 3;
                    end
                end
            end
        end
        {SIZE16, SIZE64} : begin
            for (j = 0; j < 16; j = j + 1) begin
                for (k = 0; k < 1; k = k + 1) begin
                    wr_data[j * 1 + k] <= i_data_d1[j + 16 * k];
                    if (wr_count < 16) begin
                        wr_addr[j * 1 + k] <= wr_point + 4 * j;
                    end
                    else if (wr_count < 32) begin
                        wr_addr[j * 1 + k] <= wr_point + 4 * j + 1;
                    end
                    else if (wr_count < 48) begin
                        wr_addr[j * 1 + k] <= wr_point + 4 * j + 2;
                    end
                    else begin
                        wr_addr[j * 1 + k] <= wr_point + 4 * j + 3;
                    end
                end
            end
        end
        {SIZE32, SIZE64} : begin
            for (j = 0; j < 16; j = j + 1) begin
                wr_data[j] <= i_data_d1[j];
                if (wr_count < 32) begin
                    if (wr_count % 2 == 0) begin
                        wr_addr[j] <= wr_point + 4 * j;
                    end
                    else begin
                        wr_addr[j] <= wr_point + 4 * j + 64;
                    end
                end
                else if (wr_count < 64) begin
                    if (wr_count % 2 == 0) begin
                        wr_addr[j] <= wr_point + 4 * j + 1;
                    end
                    else begin
                        wr_addr[j] <= wr_point + 4 * j + 65;
                    end
                end
                else if (wr_count < 96) begin
                    if (wr_count % 2 == 0) begin
                        wr_addr[j] <= wr_point + 4 * j + 2;
                    end
                    else begin
                        wr_addr[j] <= wr_point + 4 * j + 66;
                    end
                end
                else begin
                    if (wr_count % 2 == 0) begin
                        wr_addr[j] <= wr_point + 4 * j + 3;
                    end
                    else begin
                        wr_addr[j] <= wr_point + 4 * j + 67;
                    end
                end
            end
        end
        {SIZE64, SIZE64} : begin
            for (j = 0; j < 16; j = j + 1) begin
                wr_data[j] <= i_data_d1[j];
                if (wr_count < 64) begin
                    if (wr_count % 4 == 0) begin
                        wr_addr[j] <= wr_point + 4 * j;
                    end
                    else if (wr_count % 4 == 1) begin
                        wr_addr[j] <= wr_point + 4 * j + 64;
                    end
                    else begin //zero
                        wr_addr[j] <= 0;
                    end
                end
                else if (wr_count < 128) begin
                    if (wr_count % 4 == 0) begin
                        wr_addr[j] <= wr_point + 4 * j + 1;
                    end
                    else if (wr_count % 4 == 1) begin
                        wr_addr[j] <= wr_point + 4 * j + 65;
                    end
                    else begin //zero
                        wr_addr[j] <= 0;
                    end
                end
                else if (wr_count < 192) begin
                    if (wr_count % 4 == 0) begin
                        wr_addr[j] <= wr_point + 4 * j + 2;
                    end
                    else if (wr_count % 4 == 1) begin
                        wr_addr[j] <= wr_point + 4 * j + 66;
                    end
                    else begin //zero
                        wr_addr[j] <= 0;
                    end
                end
                else begin
                    if (wr_count % 4 == 0) begin
                        wr_addr[j] <= wr_point + 4 * j + 3;
                    end
                    else if (wr_count % 4 == 1) begin
                        wr_addr[j] <= wr_point + 4 * j + 67;
                    end
                    else begin //zero
                        wr_addr[j] <= 0;
                    end
                end
            end
        end
    endcase
end

//wr shift
always @(*) begin
    case (i_width_d[wr_count])
        SIZE4   : wr_shift <= 4;
        SIZE8   : wr_shift <= 2;
        SIZE16  : wr_shift <= 1;
        SIZE32  : wr_shift <= 1;
        SIZE64  : wr_shift <= 1;
        default : wr_shift <= 0;
    endcase
end
always @(negedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i = 0; i < 16; i = i + 1) begin
            wr_data_shift[i] <= 0;
            wr_addr_shift[i] <= 0;
        end
    end
    else if (wr_en) begin
        if (i_width_d[wr_count] == SIZE64 && i_height_d[wr_count] == SIZE64) begin//64x64
            if (wr_count < 64) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= wr_count / 4) begin
                        wr_data_shift[i] <= wr_data[i - wr_count / 4];
                        wr_addr_shift[i] <= wr_addr[i - wr_count / 4];
                    end
                    else begin
                        wr_data_shift[i] <= wr_data[i - wr_count / 4 + 16];
                        wr_addr_shift[i] <= wr_addr[i - wr_count / 4 + 16];
                    end
                end
            end
            else if (wr_count < 128) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= (wr_count - 64) / 4) begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - 64) / 4];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - 64) / 4];
                    end
                    else begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - 64) / 4 + 16];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - 64) / 4 + 16];
                    end
                end
            end
            else if (wr_count < 192) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= (wr_count - 128) / 4) begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - 128) / 4];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - 128) / 4];
                    end
                    else begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - 128) / 4 + 16];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - 128) / 4 + 16];
                    end
                end
            end
            else begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= (wr_count - 192) / 4) begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - 192) / 4];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - 192) / 4];
                    end
                    else begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - 192) / 4 + 16];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - 192) / 4 + 16];
                    end
                end
            end
        end
        else if (i_width_d[wr_count] == SIZE64 && i_height_d[wr_count] == SIZE32) begin//32x64
            if (wr_count < 64) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= wr_count / 4) begin
                        wr_data_shift[i] <= wr_data[i - wr_count / 4];
                        wr_addr_shift[i] <= wr_addr[i - wr_count / 4];
                    end
                    else begin
                        wr_data_shift[i] <= wr_data[i - wr_count / 4 + 16];
                        wr_addr_shift[i] <= wr_addr[i - wr_count / 4 + 16];
                    end
                end
            end
            else begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= (wr_count - 64) / 4) begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - 64) / 4];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - 64) / 4];
                    end
                    else begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - 64) / 4 + 16];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - 64) / 4 + 16];
                    end
                end
            end
        end
        else if (i_width_d[wr_count] == SIZE32 && i_height_d[wr_count] == SIZE64) begin//64x32
            if (wr_count < 32) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= wr_count / 2) begin
                        wr_data_shift[i] <= wr_data[i - wr_count / 2];
                        wr_addr_shift[i] <= wr_addr[i - wr_count / 2];
                    end
                    else begin
                        wr_data_shift[i] <= wr_data[i - wr_count / 2 + 16];
                        wr_addr_shift[i] <= wr_addr[i - wr_count / 2 + 16];
                    end
                end
            end
            else if (wr_count < 64) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= (wr_count - 32) / 2) begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - 32) / 2];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - 32) / 2];
                    end
                    else begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - 32) / 2 + 16];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - 32) / 2 + 16];
                    end
                end
            end
            else if (wr_count < 96) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= (wr_count - 64) / 2) begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - 64) / 2];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - 64) / 2];
                    end
                    else begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - 64) / 2 + 16];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - 64) / 2 + 16];
                    end
                end
            end
            else begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= (wr_count - 96) / 2) begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - 96) / 2];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - 96) / 2];
                    end
                    else begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - 96) / 2 + 16];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - 96) / 2 + 16];
                    end
                end
            end
        end
        else if (i_width_d[wr_count] == SIZE32 && i_height_d[wr_count] == SIZE32) begin//32x32
            if (wr_count < 32) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= wr_count / 2) begin
                        wr_data_shift[i] <= wr_data[i - wr_count / 2];
                        wr_addr_shift[i] <= wr_addr[i - wr_count / 2];
                    end
                    else begin
                        wr_data_shift[i] <= wr_data[i - wr_count / 2 + 16];
                        wr_addr_shift[i] <= wr_addr[i - wr_count / 2 + 16];
                    end
                end
            end
            else begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= (wr_count - 32) / 2) begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - 32) / 2];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - 32) / 2];
                    end
                    else begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - 32) / 2 + 16];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - 32) / 2 + 16];
                    end
                end
            end
        end
        else if (i_width_d[wr_count] == SIZE32) begin //2个地址的移位保持一样
            for (i = 0; i < 16; i = i + 1) begin
                if (i >= wr_count / 2 * wr_shift) begin
                    wr_data_shift[i] <= wr_data[i - wr_count / 2 * wr_shift];
                    wr_addr_shift[i] <= wr_addr[i - wr_count / 2 * wr_shift];
                end
                else begin
                    wr_data_shift[i] <= wr_data[i - wr_count / 2 * wr_shift + 16];
                    wr_addr_shift[i] <= wr_addr[i - wr_count / 2 * wr_shift + 16];
                end
            end
        end
        else if (i_width_d[wr_count] == SIZE64) begin //4个地址的移位保持一样
            for (i = 0; i < 16; i = i + 1) begin
                if (i >= wr_count / 4 * wr_shift) begin
                    wr_data_shift[i] <= wr_data[i - wr_count / 4 * wr_shift];
                    wr_addr_shift[i] <= wr_addr[i - wr_count / 4 * wr_shift];
                end
                else begin
                    wr_data_shift[i] <= wr_data[i - wr_count / 4 * wr_shift + 16];
                    wr_addr_shift[i] <= wr_addr[i - wr_count / 4 * wr_shift + 16];
                end
            end
        end
        else if (i_height_d[wr_count] == SIZE32) begin //后一半数据移位跟前一半一样
            if (wr_count < (wr_count_max + 1) / 2) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= wr_count * wr_shift) begin
                        wr_data_shift[i] <= wr_data[i - wr_count * wr_shift];
                        wr_addr_shift[i] <= wr_addr[i - wr_count * wr_shift];
                    end
                    else begin
                        wr_data_shift[i] <= wr_data[i - wr_count * wr_shift + 16];
                        wr_addr_shift[i] <= wr_addr[i - wr_count * wr_shift + 16];
                    end
                end
            end
            else begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= (wr_count - (wr_count_max + 1) / 2) * wr_shift) begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - (wr_count_max + 1) / 2) * wr_shift];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - (wr_count_max + 1) / 2) * wr_shift];
                    end
                    else begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - (wr_count_max + 1) / 2) * wr_shift + 16];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - (wr_count_max + 1) / 2) * wr_shift + 16];
                    end
                end
            end
        end
        else if (i_height_d[wr_count] == SIZE64) begin
            if (wr_count < (wr_count_max + 1) / 4) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= wr_count * wr_shift) begin
                        wr_data_shift[i] <= wr_data[i - wr_count * wr_shift];
                        wr_addr_shift[i] <= wr_addr[i - wr_count * wr_shift];
                    end
                    else begin
                        wr_data_shift[i] <= wr_data[i - wr_count * wr_shift + 16];
                        wr_addr_shift[i] <= wr_addr[i - wr_count * wr_shift + 16];
                    end
                end
            end
            else if (wr_count < (wr_count_max + 1) / 2) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= (wr_count - (wr_count_max + 1) / 4) * wr_shift) begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - (wr_count_max + 1) / 4) * wr_shift];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - (wr_count_max + 1) / 4) * wr_shift];
                    end
                    else begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - (wr_count_max + 1) / 4) * wr_shift + 16];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - (wr_count_max + 1) / 4) * wr_shift + 16];
                    end
                end
            end
            else if (wr_count < (wr_count_max + 1) * 3 / 4) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= (wr_count - (wr_count_max + 1) / 2) * wr_shift) begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - (wr_count_max + 1) / 2) * wr_shift];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - (wr_count_max + 1) / 2) * wr_shift];
                    end
                    else begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - (wr_count_max + 1) / 2) * wr_shift + 16];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - (wr_count_max + 1) / 2) * wr_shift + 16];
                    end
                end
            end
            else begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= (wr_count - (wr_count_max + 1) * 3 / 4) * wr_shift) begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - (wr_count_max + 1) * 3 / 4) * wr_shift];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - (wr_count_max + 1) * 3 / 4) * wr_shift];
                    end
                    else begin
                        wr_data_shift[i] <= wr_data[i - (wr_count - (wr_count_max + 1) * 3 / 4) * wr_shift + 16];
                        wr_addr_shift[i] <= wr_addr[i - (wr_count - (wr_count_max + 1) * 3 / 4) * wr_shift + 16];
                    end
                end
            end
        end
        else begin
            for (i = 0; i < 16; i = i + 1) begin
                if (i >= wr_count * wr_shift) begin
                    wr_data_shift[i] <= wr_data[i - wr_count * wr_shift];
                    wr_addr_shift[i] <= wr_addr[i - wr_count * wr_shift];
                end
                else begin
                    wr_data_shift[i] <= wr_data[i - wr_count * wr_shift + 16];
                    wr_addr_shift[i] <= wr_addr[i - wr_count * wr_shift + 16];
                end
            end
        end
    end
end 

//ram rd enable
always @(negedge clk or negedge rst_n) begin
    if (!rst_n)
        rd_en <= 0;
    else if (rd_valid) 
        rd_en <= 1;
    else if (!rd_valid_d1 && rd_count == rd_count_max) //等待下次有效数据
        rd_en <= 0;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        rd_en_d1 <= 0;
    else
        rd_en_d1 <= rd_en;
end

//decide the rd_count_max
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        rd_count_max <= 0;
    end
    else begin
        case ({rd_width, rd_height})
            {SIZE4 , SIZE4 } : rd_count_max <= 0;
            {SIZE8 , SIZE4 } : rd_count_max <= 1;
            {SIZE16, SIZE4 } : rd_count_max <= 3;
            {SIZE32, SIZE4 } : rd_count_max <= 7;
            {SIZE64, SIZE4 } : rd_count_max <= 15;
            {SIZE4 , SIZE8 } : rd_count_max <= 1;
            {SIZE8 , SIZE8 } : rd_count_max <= 3;
            {SIZE16, SIZE8 } : rd_count_max <= 7;
            {SIZE32, SIZE8 } : rd_count_max <= 15;
            {SIZE64, SIZE8 } : rd_count_max <= 31;
            {SIZE4 , SIZE16} : rd_count_max <= 3;
            {SIZE8 , SIZE16} : rd_count_max <= 7;
            {SIZE16, SIZE16} : rd_count_max <= 15;
            {SIZE32, SIZE16} : rd_count_max <= 31;
            {SIZE64, SIZE16} : rd_count_max <= 63;
            {SIZE4 , SIZE32} : rd_count_max <= 7;
            {SIZE8 , SIZE32} : rd_count_max <= 15;
            {SIZE16, SIZE32} : rd_count_max <= 31;
            {SIZE32, SIZE32} : rd_count_max <= 63;
            {SIZE64, SIZE32} : rd_count_max <= 127;
            {SIZE4 , SIZE64} : rd_count_max <= 15;
            {SIZE8 , SIZE64} : rd_count_max <= 31;
            {SIZE16, SIZE64} : rd_count_max <= 63;
            {SIZE32, SIZE64} : rd_count_max <= 127;
            {SIZE64, SIZE64} : rd_count_max <= 127;
            default          : rd_count_max <= 0;
        endcase
    end
end

//rd count 
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        rd_count <= 0;
    else if (rd_en_d1)
        if (rd_count == rd_count_max) 
            rd_count <= 0;
        else    
            rd_count <= rd_count + 1;
end

//rd point 
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        rd_point <=  0;
    else if (rd_en) 
        rd_point <= rd_point + 1;
end

//rd delay
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin 
        rd_type_d1 <= 0;
        rd_width_d1 <= 0;
        rd_height_d1 <= 0;
        rd_valid_d1 <= 0;

        rd_type_d2 <= 0;
        rd_width_d2 <= 0;
        rd_height_d2 <= 0;
        rd_valid_d2 <= 0;
    end
    else begin
        rd_type_d1 <= rd_type;
        rd_width_d1 <= rd_width;
        rd_height_d1 <= rd_height;
        rd_valid_d1 <= rd_valid;

        rd_type_d2 <= rd_type_d1;
        rd_width_d2 <= rd_width_d1;
        rd_height_d2 <= rd_height_d1;
        rd_valid_d2 <= rd_valid_d1;
    end
end

//rd data shift
always @(*) begin
    case (rd_width_d1)
        SIZE4   : rd_shift <= 4;
        SIZE8   : rd_shift <= 2;
        SIZE16  : rd_shift <= 1;
        SIZE32  : rd_shift <= 1;
        SIZE64  : rd_shift <= 1;
        default : rd_shift <= 0;
    endcase
end
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i = 0; i < 16; i = i + 1) begin
            rd_data_shift[i] <= 0;
        end
    end
    else begin
        if (rd_width_d1 == SIZE64 && rd_height_d1 == SIZE64) begin //64x64
            if (rd_count < 64) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i + rd_count / 4 < 16) begin
                        rd_data_shift[i] <= rd_data[i + rd_count / 4];
                    end
                    else begin
                        rd_data_shift[i] <= rd_data[i + rd_count / 4 - 16];
                    end
                end
            end
            else begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i + (rd_count - 64) / 4 < 16) begin
                        rd_data_shift[i] <= rd_data[i + (rd_count - 64) / 4];
                    end
                    else begin
                        rd_data_shift[i] <= rd_data[i + (rd_count - 64) / 4 - 16];
                    end
                end
            end
        end
        else if (rd_width_d1 == SIZE64 && rd_height_d1 == SIZE32) begin //32x64
            if (rd_count < 32) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i + rd_count / 2 < 16) begin
                        rd_data_shift[i] <= rd_data[i + rd_count / 2];
                    end
                    else begin
                        rd_data_shift[i] <= rd_data[i + rd_count / 2 - 16];
                    end
                end
            end
            else if (rd_count < 64) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i + (rd_count - 32) / 2 < 16) begin
                        rd_data_shift[i] <= rd_data[i + (rd_count - 32) / 2];
                    end
                    else begin
                        rd_data_shift[i] <= rd_data[i + (rd_count - 32) / 2 - 16];
                    end
                end
            end
            else begin //zero
                for (i = 0; i < 16; i = i + 1) begin 
                    rd_data_shift[i] <= 0;
                end
            end
        end
        else if (rd_width_d1 == SIZE32 && rd_height_d1 == SIZE64) begin //64x32
            if (rd_count < 64) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i + rd_count / 4 < 16) begin
                        rd_data_shift[i] <= rd_data[i + rd_count / 4];
                    end
                    else begin
                        rd_data_shift[i] <= rd_data[i + rd_count / 4 - 16];
                    end
                end
            end
            else begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i + (rd_count - 64) / 4 < 16) begin
                        rd_data_shift[i] <= rd_data[i + (rd_count - 64) / 4];
                    end
                    else begin
                        rd_data_shift[i] <= rd_data[i + (rd_count - 64) / 4 - 16];
                    end
                end
            end
        end
        else if (rd_width_d1 == SIZE32 && rd_height_d1 == SIZE32) begin //32x32
            if (rd_count < 32) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i + rd_count / 2 < 16) begin
                        rd_data_shift[i] <= rd_data[i + rd_count / 2];
                    end
                    else begin
                        rd_data_shift[i] <= rd_data[i + rd_count / 2 - 16];
                    end
                end
            end
            else begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i + (rd_count - 32) / 2 < 16) begin
                        rd_data_shift[i] <= rd_data[i + (rd_count - 32) / 2];
                    end
                    else begin
                        rd_data_shift[i] <= rd_data[i + (rd_count - 32) / 2 - 16];
                    end
                end
            end
        end
        else if (rd_width_d1 == SIZE32) begin //后一半地址的数据移位跟前一半一样
            if (rd_count < (rd_count_max + 1) / 2) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i + rd_count * rd_shift < 16) begin
                        rd_data_shift[i] <= rd_data[i + rd_count * rd_shift];
                    end
                    else begin
                        rd_data_shift[i] <= rd_data[i + rd_count * rd_shift - 16];
                    end
                end
            end
            else begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i + (rd_count - (rd_count_max + 1) / 2) * rd_shift < 16) begin
                        rd_data_shift[i] <= rd_data[i + (rd_count - (rd_count_max + 1) / 2) * rd_shift];
                    end
                    else begin
                        rd_data_shift[i] <= rd_data[i + (rd_count - (rd_count_max + 1) / 2) * rd_shift - 16];
                    end
                end
            end
        end
        else if (rd_width_d1 == SIZE64) begin
            if (rd_count < (rd_count_max + 1) / 4) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i + rd_count * rd_shift < 16) begin
                        rd_data_shift[i] <= rd_data[i + rd_count * rd_shift];
                    end
                    else begin
                        rd_data_shift[i] <= rd_data[i + rd_count * rd_shift - 16];
                    end
                end
            end
            else if (rd_count < (rd_count_max + 1) / 2) begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i + (rd_count - (rd_count_max + 1) / 4) * rd_shift < 16) begin
                        rd_data_shift[i] <= rd_data[i + (rd_count - (rd_count_max + 1) / 4) * rd_shift];
                    end
                    else begin
                        rd_data_shift[i] <= rd_data[i + (rd_count - (rd_count_max + 1) / 4) * rd_shift - 16];
                    end
                end
            end
            else begin //zero
                for (i = 0; i < 16; i = i + 1) begin 
                    rd_data_shift[i] <= 0;
                end
            end
        end
        else if (rd_height_d1 == SIZE32) begin //2个地址的移位保持一样
            for (i = 0; i < 16; i = i + 1) begin
                if (i + rd_count / 2 * rd_shift < 16) begin
                    rd_data_shift[i] <= rd_data[i + rd_count / 2 * rd_shift];
                end
                else begin
                    rd_data_shift[i] <= rd_data[i + rd_count / 2 * rd_shift - 16];
                end
            end
        end
        else if (rd_height_d1 == SIZE64) begin
            for (i = 0; i < 16; i = i + 1) begin
                if (i + rd_count / 4 * rd_shift < 16) begin
                    rd_data_shift[i] <= rd_data[i + rd_count / 4 * rd_shift];
                end
                else begin
                    rd_data_shift[i] <= rd_data[i + rd_count / 4 * rd_shift - 16];
                end
            end
        end
        else begin
            for (i = 0; i < 16; i = i + 1) begin
                if (i + rd_count * rd_shift < 16) begin
                    rd_data_shift[i] <= rd_data[i + rd_count * rd_shift];
                end
                else begin
                    rd_data_shift[i] <= rd_data[i + rd_count * rd_shift - 16];
                end
            end
        end
    end
end 

//ram 16 * 256
    dual_port_ram#(.RAM_WIDTH(WIDTH), .ADDR_LINE(8)) dual_port_ram_0 (.clk(clk), .wr_en(wr_en && !is_maxblock_zero_data), .rd_en(rd_en), .wr_data(wr_data_shift[0 ]), .rd_data(rd_data[0 ]), .wr_addr(wr_addr_shift[0 ]), .rd_addr(rd_point));
    dual_port_ram#(.RAM_WIDTH(WIDTH), .ADDR_LINE(8)) dual_port_ram_1 (.clk(clk), .wr_en(wr_en && !is_maxblock_zero_data), .rd_en(rd_en), .wr_data(wr_data_shift[1 ]), .rd_data(rd_data[1 ]), .wr_addr(wr_addr_shift[1 ]), .rd_addr(rd_point));
    dual_port_ram#(.RAM_WIDTH(WIDTH), .ADDR_LINE(8)) dual_port_ram_2 (.clk(clk), .wr_en(wr_en && !is_maxblock_zero_data), .rd_en(rd_en), .wr_data(wr_data_shift[2 ]), .rd_data(rd_data[2 ]), .wr_addr(wr_addr_shift[2 ]), .rd_addr(rd_point));
    dual_port_ram#(.RAM_WIDTH(WIDTH), .ADDR_LINE(8)) dual_port_ram_3 (.clk(clk), .wr_en(wr_en && !is_maxblock_zero_data), .rd_en(rd_en), .wr_data(wr_data_shift[3 ]), .rd_data(rd_data[3 ]), .wr_addr(wr_addr_shift[3 ]), .rd_addr(rd_point));
    dual_port_ram#(.RAM_WIDTH(WIDTH), .ADDR_LINE(8)) dual_port_ram_4 (.clk(clk), .wr_en(wr_en && !is_maxblock_zero_data), .rd_en(rd_en), .wr_data(wr_data_shift[4 ]), .rd_data(rd_data[4 ]), .wr_addr(wr_addr_shift[4 ]), .rd_addr(rd_point));
    dual_port_ram#(.RAM_WIDTH(WIDTH), .ADDR_LINE(8)) dual_port_ram_5 (.clk(clk), .wr_en(wr_en && !is_maxblock_zero_data), .rd_en(rd_en), .wr_data(wr_data_shift[5 ]), .rd_data(rd_data[5 ]), .wr_addr(wr_addr_shift[5 ]), .rd_addr(rd_point));
    dual_port_ram#(.RAM_WIDTH(WIDTH), .ADDR_LINE(8)) dual_port_ram_6 (.clk(clk), .wr_en(wr_en && !is_maxblock_zero_data), .rd_en(rd_en), .wr_data(wr_data_shift[6 ]), .rd_data(rd_data[6 ]), .wr_addr(wr_addr_shift[6 ]), .rd_addr(rd_point));
    dual_port_ram#(.RAM_WIDTH(WIDTH), .ADDR_LINE(8)) dual_port_ram_7 (.clk(clk), .wr_en(wr_en && !is_maxblock_zero_data), .rd_en(rd_en), .wr_data(wr_data_shift[7 ]), .rd_data(rd_data[7 ]), .wr_addr(wr_addr_shift[7 ]), .rd_addr(rd_point));
    dual_port_ram#(.RAM_WIDTH(WIDTH), .ADDR_LINE(8)) dual_port_ram_8 (.clk(clk), .wr_en(wr_en && !is_maxblock_zero_data), .rd_en(rd_en), .wr_data(wr_data_shift[8 ]), .rd_data(rd_data[8 ]), .wr_addr(wr_addr_shift[8 ]), .rd_addr(rd_point));
    dual_port_ram#(.RAM_WIDTH(WIDTH), .ADDR_LINE(8)) dual_port_ram_9 (.clk(clk), .wr_en(wr_en && !is_maxblock_zero_data), .rd_en(rd_en), .wr_data(wr_data_shift[9 ]), .rd_data(rd_data[9 ]), .wr_addr(wr_addr_shift[9 ]), .rd_addr(rd_point));
    dual_port_ram#(.RAM_WIDTH(WIDTH), .ADDR_LINE(8)) dual_port_ram_10(.clk(clk), .wr_en(wr_en && !is_maxblock_zero_data), .rd_en(rd_en), .wr_data(wr_data_shift[10]), .rd_data(rd_data[10]), .wr_addr(wr_addr_shift[10]), .rd_addr(rd_point));
    dual_port_ram#(.RAM_WIDTH(WIDTH), .ADDR_LINE(8)) dual_port_ram_11(.clk(clk), .wr_en(wr_en && !is_maxblock_zero_data), .rd_en(rd_en), .wr_data(wr_data_shift[11]), .rd_data(rd_data[11]), .wr_addr(wr_addr_shift[11]), .rd_addr(rd_point));
    dual_port_ram#(.RAM_WIDTH(WIDTH), .ADDR_LINE(8)) dual_port_ram_12(.clk(clk), .wr_en(wr_en && !is_maxblock_zero_data), .rd_en(rd_en), .wr_data(wr_data_shift[12]), .rd_data(rd_data[12]), .wr_addr(wr_addr_shift[12]), .rd_addr(rd_point));
    dual_port_ram#(.RAM_WIDTH(WIDTH), .ADDR_LINE(8)) dual_port_ram_13(.clk(clk), .wr_en(wr_en && !is_maxblock_zero_data), .rd_en(rd_en), .wr_data(wr_data_shift[13]), .rd_data(rd_data[13]), .wr_addr(wr_addr_shift[13]), .rd_addr(rd_point));
    dual_port_ram#(.RAM_WIDTH(WIDTH), .ADDR_LINE(8)) dual_port_ram_14(.clk(clk), .wr_en(wr_en && !is_maxblock_zero_data), .rd_en(rd_en), .wr_data(wr_data_shift[14]), .rd_data(rd_data[14]), .wr_addr(wr_addr_shift[14]), .rd_addr(rd_point));
    dual_port_ram#(.RAM_WIDTH(WIDTH), .ADDR_LINE(8)) dual_port_ram_15(.clk(clk), .wr_en(wr_en && !is_maxblock_zero_data), .rd_en(rd_en), .wr_data(wr_data_shift[15]), .rd_data(rd_data[15]), .wr_addr(wr_addr_shift[15]), .rd_addr(rd_point));

//output
    assign o_type = rd_type_d2;
    assign o_width = rd_width_d2;
    assign o_height = rd_height_d2;
    assign o_valid = rd_valid_d2;
    assign o_0  = rd_data_shift[0 ];
    assign o_1  = rd_data_shift[1 ];
    assign o_2  = rd_data_shift[2 ];
    assign o_3  = rd_data_shift[3 ];
    assign o_4  = rd_data_shift[4 ];
    assign o_5  = rd_data_shift[5 ];
    assign o_6  = rd_data_shift[6 ];
    assign o_7  = rd_data_shift[7 ];
    assign o_8  = rd_data_shift[8 ];
    assign o_9  = rd_data_shift[9 ];
    assign o_10 = rd_data_shift[10];
    assign o_11 = rd_data_shift[11];
    assign o_12 = rd_data_shift[12];
    assign o_13 = rd_data_shift[13];
    assign o_14 = rd_data_shift[14];
    assign o_15 = rd_data_shift[15];

endmodule