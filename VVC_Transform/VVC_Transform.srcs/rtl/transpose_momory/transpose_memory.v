//describe  : ×ªÖÃ´æ´¢Æ÷£¬¶Ô½Ç´æ´¢
//input     : 16 data(col)
//output    : 16 data(row)
//delay     : 66 clk
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
    output           [1 : 0]            o_type  ,
    output           [2 : 0]            o_width ,
    output           [2 : 0]            o_height,
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
localparam  MATRIX_4X4   = 5'd1 , MATRIX_4X8   = 5'd2 , MATRIX_4X16  = 5'd3 , MATRIX_4X32  = 5'd4 , MATRIX_4X64  = 5'd5 ,
            MATRIX_8X4   = 5'd6 , MATRIX_8X8   = 5'd7 , MATRIX_8X16  = 5'd8 , MATRIX_8X32  = 5'd9 , MATRIX_8X64  = 5'd10,
            MATRIX_16X4  = 5'd11, MATRIX_16X8  = 5'd12, MATRIX_16X16 = 5'd13, MATRIX_16X32 = 5'd14, MATRIX_16X64 = 5'd15,
            MATRIX_32X4  = 5'd16, MATRIX_32X8  = 5'd17, MATRIX_32X16 = 5'd18, MATRIX_32X32 = 5'd19, MATRIX_32X64 = 5'd20,
            MATRIX_64X4  = 5'd21, MATRIX_64X8  = 5'd22, MATRIX_64X16 = 5'd23, MATRIX_64X32 = 5'd24, MATRIX_64X64 = 5'd25;

    integer i;
    integer j;
    reg            [  255  :   0 ]              i_valid_d;
    reg                                         i_valid_d1;
    reg     signed [WIDTH - 1 : 0]  i_data_d1   [15 : 0];
    wire    signed [WIDTH - 1 : 0]  i_data      [15 : 0];
    reg     signed [WIDTH - 1 : 0]  o_data      [15 : 0];

    reg     write_flag;
    reg     read_flag;
    reg     read_flag_d1;
    

    reg     signed  [WIDTH - 1 : 0]     wr_data     [15:0];
    reg             [7:0]               wr_addr     [15:0];    
    wire    signed  [WIDTH - 1 : 0]     rd_data     [15:0];
    reg             [7:0]               rd_addr     [15:0];


    reg             [2:0]               i_width_d1;
    reg             [2:0]               i_height_d1;
    //counter
    wire            [7:0]               wr_count;
    reg             [7:0]               wr_count_t;
    reg             [7:0]               wr_count_64;
    reg             [7:0]               wr_count_max;
    reg             [1:0]               bank_max;//width 16,32,64
    reg             [2:0]               continuous_max;//width 4,8

    reg             [7:0]               rd_count;
    reg             [7:0]               rd_count_d1;
    reg             [7:0]               rd_count_max;
    reg             [2:0]               rd_bank_max;
    reg             [2:0]               rd_bank_max_d1;
    reg             [2:0]               rd_bank_interval;
    reg             [2:0]               rd_continuous_max;
    reg             [2:0]               rd_continuous_max_d1;
    wire            [7:0]               inf_counter;
    
    reg             [7:0]               addr_pointer;
    reg             [7:0]               rd_addr_pointer;

    reg             [6:0]               matrix_height;
    reg             [6:0]               matrix_height_d1;
    reg             [6:0]               matrix_width;
    reg             [6:0]               matrix_width_d1;
    reg             [6:0]               read_matrix_height;
    reg             [6:0]               read_matrix_width;
    reg             [4:0]               wr_matrix;
    reg             [4:0]               wr_matrix_d1;
    reg             [4:0]               wr_matrix_d     [255:0];
    reg             [4:0]               rd_matrix_t;
    reg             [4:0]               rd_matrix_d1;
    reg             [4:0]               rd_matrix_d2;

    reg             [2:0]               o_height_t;
    reg             [2:0]               o_width_t;
    wire                                o_valid_t;
    reg             [2:0]               o_height_d1;
    reg             [2:0]               o_height_d2;
    reg             [2:0]               o_width_d1;
    reg             [2:0]               o_width_d2;
    reg                                 o_valid_d1;
    reg                                 o_valid_d2;


//data_in delay 1 clk
always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        for(i = 0;i < 16;i = i + 1) begin
            i_data_d1[i] <= 0;
        end
    end
    else begin
        i_data_d1[0 ] = i_0 ;
        i_data_d1[1 ] = i_1 ;
        i_data_d1[2 ] = i_2 ;
        i_data_d1[3 ] = i_3 ;
        i_data_d1[4 ] = i_4 ;
        i_data_d1[5 ] = i_5 ;
        i_data_d1[6 ] = i_6 ;
        i_data_d1[7 ] = i_7 ;
        i_data_d1[8 ] = i_8 ;
        i_data_d1[9 ] = i_9 ;
        i_data_d1[10] = i_10;
        i_data_d1[11] = i_11;
        i_data_d1[12] = i_12;
        i_data_d1[13] = i_13;
        i_data_d1[14] = i_14;
        i_data_d1[15] = i_15;
    end
end

//matrix select
always @(*) begin
    case ({i_width, i_height}) 
        {SIZE4 , SIZE4 } : wr_matrix <= MATRIX_4X4  ;
        {SIZE8 , SIZE4 } : wr_matrix <= MATRIX_4X8  ;
        {SIZE16, SIZE4 } : wr_matrix <= MATRIX_4X16 ;
        {SIZE32, SIZE4 } : wr_matrix <= MATRIX_4X32 ;
        {SIZE64, SIZE4 } : wr_matrix <= MATRIX_4X64 ;
        {SIZE4 , SIZE8 } : wr_matrix <= MATRIX_8X4  ;
        {SIZE8 , SIZE8 } : wr_matrix <= MATRIX_8X8  ;
        {SIZE16, SIZE8 } : wr_matrix <= MATRIX_8X16 ;
        {SIZE32, SIZE8 } : wr_matrix <= MATRIX_8X32 ;
        {SIZE64, SIZE8 } : wr_matrix <= MATRIX_8X64 ;
        {SIZE4 , SIZE16} : wr_matrix <= MATRIX_16X4 ;
        {SIZE8 , SIZE16} : wr_matrix <= MATRIX_16X8 ;
        {SIZE16, SIZE16} : wr_matrix <= MATRIX_16X16;
        {SIZE32, SIZE16} : wr_matrix <= MATRIX_16X32;
        {SIZE64, SIZE16} : wr_matrix <= MATRIX_16X64;
        {SIZE4 , SIZE32} : wr_matrix <= MATRIX_32X4 ;
        {SIZE8 , SIZE32} : wr_matrix <= MATRIX_32X8 ;
        {SIZE16, SIZE32} : wr_matrix <= MATRIX_32X16;
        {SIZE32, SIZE32} : wr_matrix <= MATRIX_32X32;
        {SIZE64, SIZE32} : wr_matrix <= MATRIX_32X64;
        {SIZE4 , SIZE64} : wr_matrix <= MATRIX_64X4 ;
        {SIZE8 , SIZE64} : wr_matrix <= MATRIX_64X8 ;
        {SIZE16, SIZE64} : wr_matrix <= MATRIX_64X16;
        {SIZE32, SIZE64} : wr_matrix <= MATRIX_64X32;
        {SIZE64, SIZE64} : wr_matrix <= MATRIX_64X64;
        default          : wr_matrix <= 0;
    endcase
end


//matrix information counter record
assign inf_counter = 254;

//in)valid delay 64clk
assign o_valid_t =  i_valid_d[inf_counter];

//matrix delay 64clk 
always @(*) begin
    case (wr_matrix_d[inf_counter]) 
        {MATRIX_4X4  } : {o_height_t, o_width_t} <= {SIZE4 , SIZE4  };
        {MATRIX_4X8  } : {o_height_t, o_width_t} <= {SIZE4 , SIZE8  };
        {MATRIX_4X16 } : {o_height_t, o_width_t} <= {SIZE4 , SIZE16 };
        {MATRIX_4X32 } : {o_height_t, o_width_t} <= {SIZE4 , SIZE32 };
        {MATRIX_4X64 } : {o_height_t, o_width_t} <= {SIZE4 , SIZE64 };
        {MATRIX_8X4  } : {o_height_t, o_width_t} <= {SIZE8 , SIZE4  };
        {MATRIX_8X8  } : {o_height_t, o_width_t} <= {SIZE8 , SIZE8  };
        {MATRIX_8X16 } : {o_height_t, o_width_t} <= {SIZE8 , SIZE16 };
        {MATRIX_8X32 } : {o_height_t, o_width_t} <= {SIZE8 , SIZE32 };
        {MATRIX_8X64 } : {o_height_t, o_width_t} <= {SIZE8 , SIZE64 };
        {MATRIX_16X4 } : {o_height_t, o_width_t} <= {SIZE16, SIZE4  };
        {MATRIX_16X8 } : {o_height_t, o_width_t} <= {SIZE16, SIZE8  };
        {MATRIX_16X16} : {o_height_t, o_width_t} <= {SIZE16, SIZE16 };
        {MATRIX_16X32} : {o_height_t, o_width_t} <= {SIZE16, SIZE32 };
        {MATRIX_16X64} : {o_height_t, o_width_t} <= {SIZE16, SIZE64 };
        {MATRIX_32X4 } : {o_height_t, o_width_t} <= {SIZE32, SIZE4  };
        {MATRIX_32X8 } : {o_height_t, o_width_t} <= {SIZE32, SIZE8  };
        {MATRIX_32X16} : {o_height_t, o_width_t} <= {SIZE32, SIZE16 };
        {MATRIX_32X32} : {o_height_t, o_width_t} <= {SIZE32, SIZE32 };
        {MATRIX_32X64} : {o_height_t, o_width_t} <= {SIZE32, SIZE64 };
        {MATRIX_64X4 } : {o_height_t, o_width_t} <= {SIZE64, SIZE4  };
        {MATRIX_64X8 } : {o_height_t, o_width_t} <= {SIZE64, SIZE8  };
        {MATRIX_64X16} : {o_height_t, o_width_t} <= {SIZE64, SIZE16 };
        {MATRIX_64X32} : {o_height_t, o_width_t} <= {SIZE64, SIZE32 };
        {MATRIX_64X64} : {o_height_t, o_width_t} <= {SIZE64, SIZE64 };
        default        : {o_height_t, o_width_t} <= {3'd0, 3'd0 };
    endcase
end


//write_matrix_width
always@(*)
    if(!rst_n)
        matrix_width <= 0;
    else    
        case(i_width)
            SIZE4  :    matrix_width <= 7'd4;
            SIZE8  :    matrix_width <= 7'd8;
            SIZE16 :    matrix_width <= 7'd16;
            SIZE32 :    matrix_width <= 7'd32;
            SIZE64 :    matrix_width <= 7'd64;
            default:    matrix_width <= 0;
        endcase

//write_matrix_height
always@(*)
    if(!rst_n)
        matrix_height <= 0;
    else    
        case(i_height)
            SIZE4  :   matrix_height <= 7'd4;
            SIZE8  :   matrix_height <= 7'd8;
            SIZE16 :   matrix_height <= 7'd16;
            SIZE32 :   matrix_height <= 7'd32;
            SIZE64 :   matrix_height <= 7'd64;
            default:matrix_height <= 0;
        endcase

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        matrix_width_d1 <=  0;
    else
        matrix_width_d1 <=  matrix_width;

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        matrix_height_d1 <=  0;
    else
        matrix_height_d1 <=  matrix_height;

//read_matrix_width
always@(*)
    if(!rst_n)
        read_matrix_width <= 0;
    else    
        case(o_width_t)
            SIZE4  :    read_matrix_width <= 7'd4;
            SIZE8  :    read_matrix_width <= 7'd8;
            SIZE16 :    read_matrix_width <= 7'd16;
            SIZE32 :    read_matrix_width <= 7'd32;
            SIZE64 :    read_matrix_width <= 7'd64;
            default:    read_matrix_width <= 0;
        endcase

//read_matrix_height
always@(*)
    if(!rst_n)
        read_matrix_height <= 0;
    else    
        case(o_height_t)
            SIZE4  :   read_matrix_height <= 7'd4;
            SIZE8  :   read_matrix_height <= 7'd8;
            SIZE16 :   read_matrix_height <= 7'd16;
            SIZE32 :   read_matrix_height <= 7'd32;
            SIZE64 :   read_matrix_height <= 7'd64;
            default:read_matrix_height <= 0;
        endcase

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        i_width_d1  <=  0;
    else
        i_width_d1  <=  i_width;

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        i_height_d1  <=  0;
    else
        i_height_d1  <=  i_height;

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        wr_matrix_d1    <=  0;
    else 
        wr_matrix_d1    <=  wr_matrix;

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        for( i = 0 ; i < 256 ; i = i + 1)
            wr_matrix_d[i]  <= 0;
    else begin
        for(i = 255 ; i > 0 ; i = i - 1) begin
            wr_matrix_d[i] = wr_matrix_d[i-1];
        end
        wr_matrix_d[0]  =  wr_matrix_d1;
    end

//i_valid shift
always@(posedge clk or negedge rst_n)
    if(!rst_n)
        i_valid_d1  <= 0; 
    else 
        i_valid_d1  <=  i_valid;

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        i_valid_d <= 0; 
    else 
        i_valid_d[255:0]   <=  {i_valid_d[254:0],i_valid_d1};

//ram write enable
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        write_flag  <=  0;
    else if(i_valid)
        write_flag  <=  1;
    else if(i_width == 0 && i_height == 0)
        write_flag  <=  0;
    else
        write_flag  <=  write_flag;
end

//as write count max 
always@(posedge clk or negedge rst_n)
    if(!rst_n)
        wr_count_max    <=  0;
    else
        wr_count_max    <= matrix_height * matrix_width /16 < 1 ? 0 :matrix_height * matrix_width / 16 - 1;

//wr count 
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        wr_count_t   <=  0;
    else if (i_valid)//in case of data interrupt
        wr_count_t <= 0;
    else if(write_flag) begin
        if(wr_count_t == wr_count_max || wr_count_max == 0) 
            wr_count_t    <=  0;
        else    
            wr_count_t    <=  wr_count_t + 1;
    end
    else    
        wr_count_t   <=  0;
end

reg wr_count_64_valid;

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        wr_count_64 <=  0;
    else if(i_valid)
        wr_count_64 <=  0;
    else if( write_flag && wr_count_t % 4 / 2 == 0)
        wr_count_64 <=  wr_count_64 + 1;
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        wr_count_64_valid <=  1;
    else if( write_flag && (wr_count_t + 1) % 4 /2 != 0 && i_width == SIZE64)
        wr_count_64_valid   <=  0;
    else
        wr_count_64_valid   <=  1;
end

assign  wr_count    =   i_width == SIZE64 ? wr_count_64 :wr_count_t;

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        bank_max    <=  0;
    else
        case(i_width)
            SIZE16 :    bank_max <= 2'd1;
            SIZE32 :    bank_max <= 2'd2;
            SIZE64 :    bank_max <= 2'd2;
            SIZE8  :    bank_max <= matrix_height / 16 < 2 ? 1 : matrix_height / 16;
            SIZE4  :    bank_max <= matrix_height / 16 < 2 ? 1 : matrix_height / 16;
            default:    bank_max <= 0;
        endcase

always@(posedge clk or negedge rst_n)
    if(!rst_n)  
        continuous_max  <=  0;
    else    
        case(i_width)
            SIZE4  :    continuous_max <= 3'd4;
            SIZE8  :    continuous_max <= 3'd2;
            default:    continuous_max <= 0;
        endcase




//ram read enable
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        read_flag   <=  0;
    else if( i_valid_d[inf_counter - 1])
        read_flag   <=  1;
end

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        read_flag_d1    <=  0;
    else
        read_flag_d1    <=  read_flag;

//as read count max 
always@(posedge clk or negedge rst_n)
    if(!rst_n)
        rd_count_max    <=  0;
    else
        rd_count_max    <=  read_matrix_height * read_matrix_width / 16 < 1 ? 0 : read_matrix_height * read_matrix_width / 16 - 1;

//rd count 
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        rd_count   <=  0;
    else if(read_flag) begin
        if(rd_count == rd_count_max)// || rd_matrix_d2 == MATRIX_4X4) 
            rd_count    <=  0;
        else    
            rd_count    <=  rd_count + 1;
    end
    else    
        rd_count   <=  0;
end

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        rd_count_d1 <=  0;
    else    
        rd_count_d1 <=  rd_count;

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        rd_bank_max <=  0;
    else
        rd_bank_max <=  read_matrix_height / 16 < 1 ? 1 : read_matrix_height / 16;

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        rd_bank_max_d1  <=  0;
    else
        rd_bank_max_d1  <=  rd_bank_max;

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        rd_bank_interval    <=  0;
    else
        case(o_width_t)
            SIZE16 :    rd_bank_interval <= 2'd1;
            SIZE32 :    rd_bank_interval <= 2'd2;
            SIZE64 :    rd_bank_interval <= 2'd2;
            default:    rd_bank_interval <= 0;
        endcase

always@(posedge clk or negedge rst_n)
    if(!rst_n)  
        rd_continuous_max  <=  0;
    else    
        case(o_width_t)
            SIZE4  :    rd_continuous_max <= 3'd4;
            SIZE8  :    rd_continuous_max <= 3'd2;
            default:    rd_continuous_max <= 0;
        endcase

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        rd_continuous_max_d1  <=  0;
    else
        rd_continuous_max_d1  <=  rd_continuous_max;

//as output o_valid
always@(posedge clk  or negedge rst_n) begin
    if(!rst_n)
        o_valid_d1 <= 0;
    else
        o_valid_d1 <= o_valid_t;
end
always@(posedge clk  or negedge rst_n) begin
    if(!rst_n)
        o_valid_d2 <= 0;
    else
        o_valid_d2 <= o_valid_d1;
end
//as output o_height
always@(posedge clk  or negedge rst_n) begin
    if(!rst_n)
        o_height_d1 <= 0;
    else
        o_height_d1 <= o_height_t;
end
always@(posedge clk  or negedge rst_n) begin
    if(!rst_n)
        o_height_d2 <= 0;
    else
        o_height_d2 <= o_height_d1;
end
//as output o_width
always@(posedge clk  or negedge rst_n) begin
    if(!rst_n)
        o_width_d1 <= 0;
    else
        o_width_d1 <= o_width_t;
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        o_width_d2  <=  0;
    else
        o_width_d2  <=  o_width_d1;
end

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        rd_matrix_t   <=    0;
    else    
        rd_matrix_t   <=    wr_matrix_d[inf_counter];

//rd_matrix delay 2 clk : as condition for data read
always@(posedge clk or negedge rst_n)
    if(!rst_n)
        rd_matrix_d1   <=    0;
    else    
        rd_matrix_d1   <=    rd_matrix_t;
        /***********/

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        rd_matrix_d2   <=    0;
    else    
        rd_matrix_d2   <=    rd_matrix_d1;

        /********************ram_rd**************************ram_wr*********************/

//confirm  write addr pointer(as same as addr offset)
always@(posedge clk or negedge rst_n)
    if(!rst_n)
        addr_pointer    <=  0;
    else begin
        case(i_width_d1)
        //4&8 have problem//
            SIZE4  :    if ( (wr_count+1) % matrix_width == 0 && wr_count != 0 && wr_count_64_valid || i_height_d1 == SIZE4)
                            if(i_height_d1 == SIZE4 || i_height_d1 == SIZE8)
                                addr_pointer <= addr_pointer + wr_count_max + 1;
                            else
                                addr_pointer <= addr_pointer + matrix_width_d1 * bank_max;
            SIZE8  :    if ( (wr_count+1) % matrix_width == 0 && wr_count != 0 && wr_count_64_valid)
                            if(i_height_d1 == SIZE4 || i_height_d1 == SIZE8)
                                addr_pointer <= addr_pointer + wr_count_max + 1;
                            else
                                addr_pointer <= addr_pointer + matrix_width_d1 * bank_max;
            SIZE16 :    if ( (wr_count+1) % (16 * bank_max) == 0 && wr_count != 0 && wr_count_64_valid)
                            addr_pointer <= addr_pointer + 16 * bank_max;
            SIZE32 :    if ( (wr_count+1) % (16 * bank_max) == 0 && wr_count != 0 && wr_count_64_valid)
                            addr_pointer <= addr_pointer + 16 * bank_max;
            SIZE64 :    if ( (wr_count+1) % (16 * bank_max) == 0 && wr_count != 0 && wr_count_64_valid)
                            addr_pointer <= addr_pointer + 16 * bank_max;
            default:        addr_pointer <= addr_pointer;
        endcase
end


//diagonal storage :assign write data write addr
/*
always @(*) begin
    for (i = 0; i < 16; i = i + 1)  begin
        wr_data[ i ]    <=  0; 
        wr_addr[ i ]    <=  0;
    end
    if (write_flag) begin
        case (wr_matrix_d1) 
            {MATRIX_4X4  } :
                    for (j = 0; j < 16; j = j + 1) begin
                        if (j >= continuous_max * (wr_count % matrix_width_d1)) begin
                            wr_addr[j] <= j / continuous_max - wr_count % matrix_width_d1 + addr_pointer;
                            wr_data[j] <= i_data[j - continuous_max * (wr_count % matrix_width_d1)];
                        end
                        else begin
                            wr_addr[j] <= matrix_width_d1 + j / continuous_max - wr_count % matrix_width_d1 + addr_pointer;
                            wr_data[j] <= i_data[16 + j - continuous_max * (wr_count % matrix_width_d1)];
                        end
                    end
            {MATRIX_8X8  } :         
                    for (j = 0; j < 16; j = j + 1) begin
                        if (j >= continuous_max * (wr_count % matrix_width_d1)) begin
                            wr_addr[j] <= j / continuous_max - wr_count % matrix_width_d1 + addr_pointer;
                            wr_data[j] <= i_data[j - continuous_max * (wr_count % matrix_width_d1)];
                        end
                        else begin
                            wr_addr[j] <= matrix_width_d1 + j / continuous_max - wr_count % matrix_width_d1 + addr_pointer;
                            wr_data[j] <= i_data[16 + j - continuous_max * (wr_count % matrix_width_d1)];
                        end
                    end
            {MATRIX_16X16} : begin
                    for (j = 0; j < 16; j = j + 1) begin
                            if (j >= (wr_count / bank_max) % 16) begin
                                wr_addr[j] <= j - (wr_count / bank_max) % 16 + (wr_count % bank_max) * 16 + addr_pointer;
                                wr_data[j] <= i_data[j - (wr_count / bank_max) % 16];
                            end
                            else begin
                                wr_addr[j] <= 16 + j - (wr_count / bank_max) % 16 + (wr_count % bank_max) * 16 + addr_pointer;
                                wr_data[j] <= i_data[16 + j - (wr_count / bank_max) % 16];
                            end
                    end
            end
            {MATRIX_32X32} : begin
                    for (j = 0; j < 16; j = j + 1) begin
                            if (j >= (wr_count / bank_max) % 16) begin
                                wr_addr[j] <= j - (wr_count / bank_max) % 16 + (wr_count % bank_max) * 16 + addr_pointer;
                                wr_data[j] <= i_data[j - (wr_count / bank_max) % 16];
                            end
                            else begin
                                wr_addr[j] <= 16 + j - (wr_count / bank_max) % 16 + (wr_count % bank_max) * 16 + addr_pointer;
                                wr_data[j] <= i_data[16 + j - (wr_count / bank_max) % 16];
                            end
                    end
            end
            {MATRIX_64X64} : begin
                    for (j = 0; j < 16; j = j + 1) begin
                        if (j >= (wr_count / bank_max) % 16) begin
                            wr_addr[j] <= {16{wr_count_64_valid}} & ( j - (wr_count / bank_max) % 16 + (wr_count % bank_max) * 16 + addr_pointer );
                            wr_data[j] <= i_data[{16{wr_count_64_valid}} & ( j - (wr_count / bank_max) % 16 )];
                        end
                        else begin
                            wr_addr[j] <= {16{wr_count_64_valid}} & ( 16 + j - (wr_count / bank_max) % 16 + (wr_count % bank_max) * 16 + addr_pointer );
                            wr_data[j] <= i_data[{16{wr_count_64_valid}} & ( 16 + j - (wr_count / bank_max) % 16 )];
                        end
                    end
            end
            default        : begin
                for (i = 0; i < 16; i = i + 1)  begin
                    wr_data[ i ]    <=  0; 
                    wr_addr[ i ]    <=  0;
                end
            end
        endcase

    end
end
*/
always @(*) begin
    for (i = 0; i < 16; i = i + 1)  begin
        wr_data[ i ]    <=  0; 
        wr_addr[ i ]    <=  0;
    end
    if (write_flag) begin
        case (i_width_d1) 
            SIZE4 : begin
                if(i_height_d1 == SIZE4 || i_height_d1 == SIZE8) begin
                    for (i = 0; i < 16; i = i + 1) begin
                        if (i >= wr_count * continuous_max) begin
                            j = i - wr_count * continuous_max;
                            wr_addr[i] <= j / continuous_max % (matrix_height_d1 * matrix_width_d1 / 16) + addr_pointer;
                            wr_data[i] <= i_data[j / continuous_max % (matrix_height_d1 * matrix_width_d1 / 16) * (16 / matrix_height_d1) + j % continuous_max * matrix_width_d1 + j / matrix_height_d1];
                        end
                        else begin
                            j = 16 + i - wr_count * continuous_max;
                            wr_addr[i] <= j / continuous_max % (matrix_height_d1 * matrix_width_d1 / 16) + addr_pointer;
                            wr_data[i] <= i_data[j / continuous_max % (matrix_height_d1 * matrix_width_d1 / 16) * (16 / matrix_height_d1) + j % continuous_max * matrix_width_d1 + j / matrix_height_d1];
                        end
                    end
                end 
                else begin
                    for (j = 0; j < 16; j = j + 1) begin
                        if (j >= continuous_max * (wr_count % matrix_width_d1)) begin
                            wr_addr[j] <= j / continuous_max - wr_count % matrix_width_d1 + addr_pointer;
                            wr_data[j] <= i_data[j % continuous_max * matrix_width_d1 + j / continuous_max - wr_count % matrix_width_d1];
                        end
                        else begin
                            wr_addr[j] <= matrix_width_d1 + j / continuous_max - wr_count % matrix_width_d1 + addr_pointer;
                            wr_data[j] <= i_data[matrix_width_d1 + j % continuous_max * matrix_width_d1 + j / continuous_max - wr_count % matrix_width_d1];
                        end
                    end
                end
            end
            SIZE8 : begin
                if(i_height_d1 == SIZE4 || i_height_d1 == SIZE8) begin
                    for (i = 0; i < 16; i = i + 1) begin
                        if (i >= wr_count * continuous_max) begin
                            j = i - wr_count * continuous_max;
                            wr_addr[i] <= j / continuous_max % (matrix_height_d1 * matrix_width_d1 / 16) + addr_pointer;
                            wr_data[i] <= i_data[j / continuous_max % (matrix_height_d1 * matrix_width_d1 / 16) * (16 / matrix_height_d1) + j % continuous_max * matrix_width_d1 + j / matrix_height_d1];
                        end
                        else begin
                            j = 16 + i - wr_count * continuous_max;
                            wr_addr[i] <= j / continuous_max % (matrix_height_d1 * matrix_width_d1 / 16) + addr_pointer;
                            wr_data[i] <= i_data[j / continuous_max % (matrix_height_d1 * matrix_width_d1 / 16) * (16 / matrix_height_d1) + j % continuous_max * matrix_width_d1 + j / matrix_height_d1];
                        end
                    end
                end 
                else begin
                    for (j = 0; j < 16; j = j + 1) begin
                        if (j >= continuous_max * (wr_count % matrix_width_d1)) begin
                            wr_addr[j] <= j / continuous_max - wr_count % matrix_width_d1 + addr_pointer;
                            wr_data[j] <= i_data[j % continuous_max * matrix_width_d1 + j / continuous_max - wr_count % matrix_width_d1];
                        end
                        else begin
                            wr_addr[j] <= matrix_width_d1 + j / continuous_max - wr_count % matrix_width_d1 + addr_pointer;
                            wr_data[j] <= i_data[matrix_width_d1 + j % continuous_max * matrix_width_d1 + j / continuous_max - wr_count % matrix_width_d1];
                        end
                    end
                end
            end
            SIZE16 : begin
                for (j = 0; j < 16; j = j + 1) begin
                        if (j >= (wr_count / bank_max) % 16) begin
                            wr_addr[j] <= j - (wr_count / bank_max) % 16 + (wr_count % bank_max) * 16 + addr_pointer;
                            wr_data[j] <= i_data[j - (wr_count / bank_max) % 16];
                        end
                        else begin
                            wr_addr[j] <= 16 + j - (wr_count / bank_max) % 16 + (wr_count % bank_max) * 16 + addr_pointer;
                            wr_data[j] <= i_data[16 + j - (wr_count / bank_max) % 16];
                        end
                end
            end
            SIZE32 : begin
                for (j = 0; j < 16; j = j + 1) begin
                        if (j >= (wr_count / bank_max) % 16) begin
                            wr_addr[j] <= j - (wr_count / bank_max) % 16 + (wr_count % bank_max) * 16 + addr_pointer;
                            wr_data[j] <= i_data[j - (wr_count / bank_max) % 16];
                        end
                        else begin
                            wr_addr[j] <= 16 + j - (wr_count / bank_max) % 16 + (wr_count % bank_max) * 16 + addr_pointer;
                            wr_data[j] <= i_data[16 + j - (wr_count / bank_max) % 16];
                        end
                end
            end
            SIZE64 : begin
                for (j = 0; j < 16; j = j + 1) begin
                    if (j >= (wr_count / bank_max) % 16) begin
                        wr_addr[j] <= {16{wr_count_64_valid}} & ( j - (wr_count / bank_max) % 16 + (wr_count % bank_max) * 16 + addr_pointer );
                        wr_data[j] <= i_data[{16{wr_count_64_valid}} & ( j - (wr_count / bank_max) % 16 )];
                    end
                    else begin
                        wr_addr[j] <= {16{wr_count_64_valid}} & ( 16 + j - (wr_count / bank_max) % 16 + (wr_count % bank_max) * 16 + addr_pointer );
                        wr_data[j] <= i_data[{16{wr_count_64_valid}} & ( 16 + j - (wr_count / bank_max) % 16 )];
                    end
                end
            end
            default        : begin
                for (i = 0; i < 16; i = i + 1)  begin
                    wr_data[ i ]    <=  0; 
                    wr_addr[ i ]    <=  0;
                end
            end
        endcase

    end
end

//diagonal storage :assign o_data
/*
always @(*) begin
    for (i = 0; i < 16; i = i + 1)
        o_data [ i ]    <=  0;
    if (read_flag) begin
        case (rd_matrix_d2) 
            {MATRIX_4X4  } : begin
                for (j = 0; j < 16; j = j + 1) begin
                    if (j < 16 - rd_count_d1 / rd_bank_max_d1 * 16 / o_width_d1) 
                        o_data[j] <= rd_data[j + rd_count_d1 / rd_bank_max_d1 * 16 / o_width_d1]; 
                    else 
                        o_data[j] <= rd_data[j + rd_count_d1 / rd_bank_max_d1 * 16 / o_width_d1 - 16]; 
                end
            end
            {MATRIX_8X8  } : begin
                for (j = 0; j < 16; j = j + 1) begin
                    if (j < 16 - rd_count_d1 / rd_bank_max_d1 * 16 / o_width_d1) 
                        o_data[j] <= rd_data[j + rd_count_d1 / rd_bank_max_d1 * 16 / o_width_d1]; 
                    else 
                        o_data[j] <= rd_data[j + rd_count_d1 / rd_bank_max_d1 * 16 / o_width_d1 - 16]; 
                end
            end
            {MATRIX_16X16} : begin
                for (j = 0; j < 16; j = j + 1) begin
                    if (j < 16 - rd_count_d1 / rd_bank_max_d1 % 16)
                        o_data[j] <= rd_data[j + rd_count_d1 / rd_bank_max_d1 % 16];
                    else
                        o_data[j] <= rd_data[j + rd_count_d1 / rd_bank_max_d1 % 16 - 16];
                end               
            end
            {MATRIX_32X32} : begin        
                for (j = 0; j < 16; j = j + 1) begin
                    if (j < 16 - rd_count_d1 / rd_bank_max_d1 % 16)
                        o_data[j] <= rd_data[j + rd_count_d1 / rd_bank_max_d1 % 16];
                    else
                        o_data[j] <= rd_data[j + rd_count_d1 / rd_bank_max_d1 % 16 - 16];
                end
            end
            {MATRIX_64X64} : begin        
                for (j = 0; j < 16; j = j + 1) begin
                    if (j <16 - rd_count_d1 / rd_bank_max_d1 % 16)
                        o_data[j] <= rd_count_d1 < (rd_count_max + 1) / 2 ? rd_data[j + rd_count_d1 / rd_bank_max_d1 % 16] : 0;
                    else 
                        o_data[j] <= rd_count_d1 < (rd_count_max + 1) / 2 ? rd_data[j + rd_count_d1 / rd_bank_max_d1 % 16 - 16] : 0;
                end
            end
            default        : begin
                for (i = 0; i < 16; i = i + 1)
                    o_data [ i ]    <=  0; 
            end
        endcase

    end
end
*/
always @(*) begin
    for (i = 0; i < 16; i = i + 1)
        o_data [ i ]    <=  0;
    if (read_flag) begin
        case (o_width_d2) 
            SIZE4 : begin
                if(o_height_d2 == SIZE4 || o_height_d2 == SIZE8)
                    for(j = 0; j < 16; j = j + 1) begin
                        if (j < 16 - rd_count_d1 * rd_continuous_max_d1)
                            o_data[j] <= rd_data[j + rd_count_d1 * rd_continuous_max_d1];
                        else
                            o_data[j] <= rd_data[j + rd_count_d1 * rd_continuous_max_d1 - 16];
                    end
                else
                    for (j = 0; j < 16; j = j + 1) begin
                        if (j < 16 - rd_count_d1 / rd_bank_max_d1 * 16 / o_width_d1) 
                            o_data[j] <= rd_data[j + rd_count_d1 / rd_bank_max_d1 * 16 / o_width_d1]; 
                        else 
                            o_data[j] <= rd_data[j + rd_count_d1 / rd_bank_max_d1 * 16 / o_width_d1 - 16]; 
                    end
            end
            SIZE8 : begin
                if(o_height_d2 == SIZE4 || o_height_d2 == SIZE8)
                    for(j = 0; j < 16; j = j + 1) begin
                        if (j < 16 - rd_count_d1 * rd_continuous_max_d1)
                            o_data[j] <= rd_data[j + rd_count_d1 * rd_continuous_max_d1];
                        else
                            o_data[j] <= rd_data[j + rd_count_d1 * rd_continuous_max_d1 - 16];
                    end
                else
                    for (j = 0; j < 16; j = j + 1) begin
                        if (j < 16 - rd_count_d1 / rd_bank_max_d1 * 16 / o_width_d1) 
                            o_data[j] <= rd_data[j + rd_count_d1 / rd_bank_max_d1 * 16 / o_width_d1]; 
                        else 
                            o_data[j] <= rd_data[j + rd_count_d1 / rd_bank_max_d1 * 16 / o_width_d1 - 16]; 
                    end
            end
            SIZE16 : begin
                for (j = 0; j < 16; j = j + 1) begin
                    if (j < 16 - rd_count_d1 / rd_bank_max_d1 % 16)
                        o_data[j] <= rd_data[j + rd_count_d1 / rd_bank_max_d1 % 16];
                    else
                        o_data[j] <= rd_data[j + rd_count_d1 / rd_bank_max_d1 % 16 - 16];
                end               
            end
            SIZE32 : begin        
                for (j = 0; j < 16; j = j + 1) begin
                    if (j < 16 - rd_count_d1 / rd_bank_max_d1 % 16)
                        o_data[j] <= rd_data[j + rd_count_d1 / rd_bank_max_d1 % 16];
                    else
                        o_data[j] <= rd_data[j + rd_count_d1 / rd_bank_max_d1 % 16 - 16];
                end
            end
            SIZE64 : begin        
                for (j = 0; j < 16; j = j + 1) begin
                    if (j <16 - rd_count_d1 / rd_bank_max_d1 % 16)
                        o_data[j] <= rd_count_d1 < (rd_count_max + 1) / 2 ? rd_data[j + rd_count_d1 / rd_bank_max_d1 % 16] : 0;
                    else 
                        o_data[j] <= rd_count_d1 < (rd_count_max + 1) / 2 ? rd_data[j + rd_count_d1 / rd_bank_max_d1 % 16 - 16] : 0;
                end
            end
            default        : begin
                for (i = 0; i < 16; i = i + 1)
                    o_data [ i ]    <=  0; 
            end
        endcase

    end
end


//confirm  rd addr pointer(as same as addr offset)
always@(posedge clk or negedge rst_n)
    if(!rst_n)
        rd_addr_pointer    <=  0;
    else begin
        case(o_width_d1)
            SIZE4  :    
                if(rd_count == rd_count_max)
                    rd_addr_pointer <= rd_addr_pointer + rd_count_max + 1;
                else
                    rd_addr_pointer <= rd_addr_pointer;
            SIZE8  :    
                if(rd_count == rd_count_max)
                    rd_addr_pointer <= rd_addr_pointer + rd_count_max + 1;
                else
                    rd_addr_pointer <= rd_addr_pointer;
            SIZE16 :    
                if(rd_count == rd_count_max)
                    rd_addr_pointer <= rd_addr_pointer + rd_count_max + 1;
                else
                    rd_addr_pointer <= rd_addr_pointer;
            SIZE32 :    
                if(rd_count == rd_count_max)
                    rd_addr_pointer <= rd_addr_pointer + rd_count_max + 1;
                else
                    rd_addr_pointer <= rd_addr_pointer;
            SIZE64 :    
                if(rd_count == rd_count_max )
                    rd_addr_pointer <= rd_addr_pointer + (rd_count_max + 1) / 2;
                        
            default:        rd_addr_pointer <= rd_addr_pointer;
        endcase
end

//diagonal storage :assign rd_addr
/*
always @(*) begin
    for (i = 0; i < 16; i = i + 1)
        rd_addr[ i ]    <=  0;
    if (read_flag) begin
        case (rd_matrix_d1) 
            {MATRIX_4X4  } : begin
                for (i = 0; i < 16; i = i + 1)
                    rd_addr[i] <= rd_count % rd_bank_max * o_width_d1 + rd_count / rd_bank_max + rd_addr_pointer;
            end
            {MATRIX_8X8  } : begin
                for (i = 0; i < 16; i = i + 1)
                    rd_addr[i] <= rd_count % rd_bank_max * o_width_d1 + rd_count / rd_bank_max + rd_addr_pointer;
            end
            {MATRIX_16X16} : begin
                for (i = 0; i < 16; i = i + 1)
                    rd_addr[i] <= rd_count % rd_bank_max * (16 * rd_bank_interval) + rd_count / rd_bank_max + rd_addr_pointer;
            end
            {MATRIX_32X32} : begin
                for (i = 0; i < 16; i = i + 1)
                    rd_addr[i] <= rd_count % rd_bank_max * (16 * rd_bank_interval) + rd_count / rd_bank_max + rd_addr_pointer;
            end
            {MATRIX_64X64} : begin     
                for (i = 0; i < 16; i = i + 1)
                    rd_addr[i] <= rd_count % rd_bank_max * (16 * rd_bank_interval) + rd_count / rd_bank_max + rd_addr_pointer;
            end
            default        : begin
                for (i = 0; i < 16; i = i + 1)
                    rd_addr[ i ]    <=  0;
            end
        endcase

    end
end
*/
always @(*) begin
    for (i = 0; i < 16; i = i + 1)
        rd_addr[ i ]    <=  0;
    if (read_flag) begin
        case (o_width_d1) 
            SIZE4 : begin
                for (i = 0; i < 16; i = i + 1)
                    rd_addr[i] <= rd_count % rd_bank_max * o_width_d1 + rd_count / rd_bank_max + rd_addr_pointer;
            end
            SIZE8 : begin
                for (i = 0; i < 16; i = i + 1)
                    rd_addr[i] <= rd_count % rd_bank_max * o_width_d1 + rd_count / rd_bank_max + rd_addr_pointer;
            end
            SIZE16 : begin
                for (i = 0; i < 16; i = i + 1)
                    rd_addr[i] <= rd_count % rd_bank_max * (16 * rd_bank_interval) + rd_count / rd_bank_max + rd_addr_pointer;
            end
            SIZE32 : begin
                for (i = 0; i < 16; i = i + 1)
                    rd_addr[i] <= rd_count % rd_bank_max * (16 * rd_bank_interval) + rd_count / rd_bank_max + rd_addr_pointer;
            end
            SIZE64 : begin     
                for (i = 0; i < 16; i = i + 1)
                    rd_addr[i] <= rd_count % rd_bank_max * (16 * rd_bank_interval) + rd_count / rd_bank_max + rd_addr_pointer;
            end
            default        : begin
                for (i = 0; i < 16; i = i + 1)
                    rd_addr[ i ]    <=  0;
            end
        endcase

    end
end


//ram 64 * 128
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(4'd8)) dual_port_ram_0  (.clk(clk), .wr_en(write_flag & wr_count_64_valid), .rd_en(read_flag_d1), .wr_data(wr_data[0 ]), .rd_data(rd_data[0 ]), .wr_addr(wr_addr[0 ]), .rd_addr(rd_addr[0 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(4'd8)) dual_port_ram_1  (.clk(clk), .wr_en(write_flag & wr_count_64_valid), .rd_en(read_flag_d1), .wr_data(wr_data[1 ]), .rd_data(rd_data[1 ]), .wr_addr(wr_addr[1 ]), .rd_addr(rd_addr[1 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(4'd8)) dual_port_ram_2  (.clk(clk), .wr_en(write_flag & wr_count_64_valid), .rd_en(read_flag_d1), .wr_data(wr_data[2 ]), .rd_data(rd_data[2 ]), .wr_addr(wr_addr[2 ]), .rd_addr(rd_addr[2 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(4'd8)) dual_port_ram_3  (.clk(clk), .wr_en(write_flag & wr_count_64_valid), .rd_en(read_flag_d1), .wr_data(wr_data[3 ]), .rd_data(rd_data[3 ]), .wr_addr(wr_addr[3 ]), .rd_addr(rd_addr[3 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(4'd8)) dual_port_ram_4  (.clk(clk), .wr_en(write_flag & wr_count_64_valid), .rd_en(read_flag_d1), .wr_data(wr_data[4 ]), .rd_data(rd_data[4 ]), .wr_addr(wr_addr[4 ]), .rd_addr(rd_addr[4 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(4'd8)) dual_port_ram_5  (.clk(clk), .wr_en(write_flag & wr_count_64_valid), .rd_en(read_flag_d1), .wr_data(wr_data[5 ]), .rd_data(rd_data[5 ]), .wr_addr(wr_addr[5 ]), .rd_addr(rd_addr[5 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(4'd8)) dual_port_ram_6  (.clk(clk), .wr_en(write_flag & wr_count_64_valid), .rd_en(read_flag_d1), .wr_data(wr_data[6 ]), .rd_data(rd_data[6 ]), .wr_addr(wr_addr[6 ]), .rd_addr(rd_addr[6 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(4'd8)) dual_port_ram_7  (.clk(clk), .wr_en(write_flag & wr_count_64_valid), .rd_en(read_flag_d1), .wr_data(wr_data[7 ]), .rd_data(rd_data[7 ]), .wr_addr(wr_addr[7 ]), .rd_addr(rd_addr[7 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(4'd8)) dual_port_ram_8  (.clk(clk), .wr_en(write_flag & wr_count_64_valid), .rd_en(read_flag_d1), .wr_data(wr_data[8 ]), .rd_data(rd_data[8 ]), .wr_addr(wr_addr[8 ]), .rd_addr(rd_addr[8 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(4'd8)) dual_port_ram_9  (.clk(clk), .wr_en(write_flag & wr_count_64_valid), .rd_en(read_flag_d1), .wr_data(wr_data[9 ]), .rd_data(rd_data[9 ]), .wr_addr(wr_addr[9 ]), .rd_addr(rd_addr[9 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(4'd8)) dual_port_ram_10 (.clk(clk), .wr_en(write_flag & wr_count_64_valid), .rd_en(read_flag_d1), .wr_data(wr_data[10]), .rd_data(rd_data[10]), .wr_addr(wr_addr[10]), .rd_addr(rd_addr[10]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(4'd8)) dual_port_ram_11 (.clk(clk), .wr_en(write_flag & wr_count_64_valid), .rd_en(read_flag_d1), .wr_data(wr_data[11]), .rd_data(rd_data[11]), .wr_addr(wr_addr[11]), .rd_addr(rd_addr[11]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(4'd8)) dual_port_ram_12 (.clk(clk), .wr_en(write_flag & wr_count_64_valid), .rd_en(read_flag_d1), .wr_data(wr_data[12]), .rd_data(rd_data[12]), .wr_addr(wr_addr[12]), .rd_addr(rd_addr[12]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(4'd8)) dual_port_ram_13 (.clk(clk), .wr_en(write_flag & wr_count_64_valid), .rd_en(read_flag_d1), .wr_data(wr_data[13]), .rd_data(rd_data[13]), .wr_addr(wr_addr[13]), .rd_addr(rd_addr[13]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(4'd8)) dual_port_ram_14 (.clk(clk), .wr_en(write_flag & wr_count_64_valid), .rd_en(read_flag_d1), .wr_data(wr_data[14]), .rd_data(rd_data[14]), .wr_addr(wr_addr[14]), .rd_addr(rd_addr[14]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(4'd8)) dual_port_ram_15 (.clk(clk), .wr_en(write_flag & wr_count_64_valid), .rd_en(read_flag_d1), .wr_data(wr_data[15]), .rd_data(rd_data[15]), .wr_addr(wr_addr[15]), .rd_addr(rd_addr[15]));
//

//assign i_data i_data_d1
    assign i_data[0 ] = i_data_d1[0 ];
    assign i_data[1 ] = i_data_d1[1 ];
    assign i_data[2 ] = i_data_d1[2 ];
    assign i_data[3 ] = i_data_d1[3 ];
    assign i_data[4 ] = i_data_d1[4 ];
    assign i_data[5 ] = i_data_d1[5 ];
    assign i_data[6 ] = i_data_d1[6 ];
    assign i_data[7 ] = i_data_d1[7 ];
    assign i_data[8 ] = i_data_d1[8 ];
    assign i_data[9 ] = i_data_d1[9 ];
    assign i_data[10] = i_data_d1[10];
    assign i_data[11] = i_data_d1[11];
    assign i_data[12] = i_data_d1[12];
    assign i_data[13] = i_data_d1[13];
    assign i_data[14] = i_data_d1[14];
    assign i_data[15] = i_data_d1[15];


//output
    assign o_valid  =   o_valid_d2 ;   
    assign o_height =   o_height_d2;
    assign o_width  =   o_width_d2 ;

    assign o_0      =   o_data[0 ];
    assign o_1      =   o_data[1 ];
    assign o_2      =   o_data[2 ];
    assign o_3      =   o_data[3 ];
    assign o_4      =   o_data[4 ];
    assign o_5      =   o_data[5 ];
    assign o_6      =   o_data[6 ];
    assign o_7      =   o_data[7 ];
    assign o_8      =   o_data[8 ];
    assign o_9      =   o_data[9 ];
    assign o_10     =   o_data[10];
    assign o_11     =   o_data[11];
    assign o_12     =   o_data[12];
    assign o_13     =   o_data[13];
    assign o_14     =   o_data[14];
    assign o_15     =   o_data[15];

endmodule


