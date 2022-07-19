module transpose_memory#(
    parameter  WIDTH  = 16
)
(
//system input
    input                               clk     ,
    input                               rst_n   ,
//input parameter
    input           [2 : 0]             i_width     ,//rd clk
    input           [2 : 0]             i_height    ,//wr clk
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
    input   signed  [WIDTH - 1 : 0]     i_16    ,
    input   signed  [WIDTH - 1 : 0]     i_17    ,
    input   signed  [WIDTH - 1 : 0]     i_18    ,
    input   signed  [WIDTH - 1 : 0]     i_19    ,
    input   signed  [WIDTH - 1 : 0]     i_20    ,
    input   signed  [WIDTH - 1 : 0]     i_21    ,
    input   signed  [WIDTH - 1 : 0]     i_22    ,
    input   signed  [WIDTH - 1 : 0]     i_23    ,
    input   signed  [WIDTH - 1 : 0]     i_24    ,
    input   signed  [WIDTH - 1 : 0]     i_25    ,
    input   signed  [WIDTH - 1 : 0]     i_26    ,
    input   signed  [WIDTH - 1 : 0]     i_27    ,
    input   signed  [WIDTH - 1 : 0]     i_28    ,
    input   signed  [WIDTH - 1 : 0]     i_29    ,
    input   signed  [WIDTH - 1 : 0]     i_30    ,
    input   signed  [WIDTH - 1 : 0]     i_31    ,
    input   signed  [WIDTH - 1 : 0]     i_32    ,
    input   signed  [WIDTH - 1 : 0]     i_33    ,
    input   signed  [WIDTH - 1 : 0]     i_34    ,
    input   signed  [WIDTH - 1 : 0]     i_35    ,
    input   signed  [WIDTH - 1 : 0]     i_36    ,
    input   signed  [WIDTH - 1 : 0]     i_37    ,
    input   signed  [WIDTH - 1 : 0]     i_38    ,
    input   signed  [WIDTH - 1 : 0]     i_39    ,
    input   signed  [WIDTH - 1 : 0]     i_40    ,
    input   signed  [WIDTH - 1 : 0]     i_41    ,
    input   signed  [WIDTH - 1 : 0]     i_42    ,
    input   signed  [WIDTH - 1 : 0]     i_43    ,
    input   signed  [WIDTH - 1 : 0]     i_44    ,
    input   signed  [WIDTH - 1 : 0]     i_45    ,
    input   signed  [WIDTH - 1 : 0]     i_46    ,
    input   signed  [WIDTH - 1 : 0]     i_47    ,
    input   signed  [WIDTH - 1 : 0]     i_48    ,
    input   signed  [WIDTH - 1 : 0]     i_49    ,
    input   signed  [WIDTH - 1 : 0]     i_50    ,
    input   signed  [WIDTH - 1 : 0]     i_51    ,
    input   signed  [WIDTH - 1 : 0]     i_52    ,
    input   signed  [WIDTH - 1 : 0]     i_53    ,
    input   signed  [WIDTH - 1 : 0]     i_54    ,
    input   signed  [WIDTH - 1 : 0]     i_55    ,
    input   signed  [WIDTH - 1 : 0]     i_56    ,
    input   signed  [WIDTH - 1 : 0]     i_57    ,
    input   signed  [WIDTH - 1 : 0]     i_58    ,
    input   signed  [WIDTH - 1 : 0]     i_59    ,
    input   signed  [WIDTH - 1 : 0]     i_60    ,
    input   signed  [WIDTH - 1 : 0]     i_61    ,
    input   signed  [WIDTH - 1 : 0]     i_62    ,
    input   signed  [WIDTH - 1 : 0]     i_63    ,

//output parameter
    output           [2 : 0]             o_width     ,
    output           [2 : 0]             o_height    ,
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
    output  signed  [WIDTH - 1 : 0]     o_15    ,
    output  signed  [WIDTH - 1 : 0]     o_16    ,
    output  signed  [WIDTH - 1 : 0]     o_17    ,
    output  signed  [WIDTH - 1 : 0]     o_18    ,
    output  signed  [WIDTH - 1 : 0]     o_19    ,
    output  signed  [WIDTH - 1 : 0]     o_20    ,
    output  signed  [WIDTH - 1 : 0]     o_21    ,
    output  signed  [WIDTH - 1 : 0]     o_22    ,
    output  signed  [WIDTH - 1 : 0]     o_23    ,
    output  signed  [WIDTH - 1 : 0]     o_24    ,
    output  signed  [WIDTH - 1 : 0]     o_25    ,
    output  signed  [WIDTH - 1 : 0]     o_26    ,
    output  signed  [WIDTH - 1 : 0]     o_27    ,
    output  signed  [WIDTH - 1 : 0]     o_28    ,
    output  signed  [WIDTH - 1 : 0]     o_29    ,
    output  signed  [WIDTH - 1 : 0]     o_30    ,
    output  signed  [WIDTH - 1 : 0]     o_31    ,
    output  signed  [WIDTH - 1 : 0]     o_32    ,
    output  signed  [WIDTH - 1 : 0]     o_33    ,
    output  signed  [WIDTH - 1 : 0]     o_34    ,
    output  signed  [WIDTH - 1 : 0]     o_35    ,
    output  signed  [WIDTH - 1 : 0]     o_36    ,
    output  signed  [WIDTH - 1 : 0]     o_37    ,
    output  signed  [WIDTH - 1 : 0]     o_38    ,
    output  signed  [WIDTH - 1 : 0]     o_39    ,
    output  signed  [WIDTH - 1 : 0]     o_40    ,
    output  signed  [WIDTH - 1 : 0]     o_41    ,
    output  signed  [WIDTH - 1 : 0]     o_42    ,
    output  signed  [WIDTH - 1 : 0]     o_43    ,
    output  signed  [WIDTH - 1 : 0]     o_44    ,
    output  signed  [WIDTH - 1 : 0]     o_45    ,
    output  signed  [WIDTH - 1 : 0]     o_46    ,
    output  signed  [WIDTH - 1 : 0]     o_47    ,
    output  signed  [WIDTH - 1 : 0]     o_48    ,
    output  signed  [WIDTH - 1 : 0]     o_49    ,
    output  signed  [WIDTH - 1 : 0]     o_50    ,
    output  signed  [WIDTH - 1 : 0]     o_51    ,
    output  signed  [WIDTH - 1 : 0]     o_52    ,
    output  signed  [WIDTH - 1 : 0]     o_53    ,
    output  signed  [WIDTH - 1 : 0]     o_54    ,
    output  signed  [WIDTH - 1 : 0]     o_55    ,
    output  signed  [WIDTH - 1 : 0]     o_56    ,
    output  signed  [WIDTH - 1 : 0]     o_57    ,
    output  signed  [WIDTH - 1 : 0]     o_58    ,
    output  signed  [WIDTH - 1 : 0]     o_59    ,
    output  signed  [WIDTH - 1 : 0]     o_60    ,
    output  signed  [WIDTH - 1 : 0]     o_61    ,
    output  signed  [WIDTH - 1 : 0]     o_62    ,
    output  signed  [WIDTH - 1 : 0]     o_63
);
localparam  DCT_4  = 3'd1,
            DCT_8  = 3'd2,
            DCT_16 = 3'd3,
            DCT_32 = 3'd4,
            DCT_64 = 3'd5;
localparam  MATRIX_4X4   = 5'd1 , MATRIX_4X8   = 5'd2 , MATRIX_4X16  = 5'd3 , MATRIX_4X32  = 5'd4 , MATRIX_4X64  = 5'd5 ,
            MATRIX_8X4   = 5'd6 , MATRIX_8X8   = 5'd7 , MATRIX_8X16  = 5'd8 , MATRIX_8X32  = 5'd9 , MATRIX_8X64  = 5'd10,
            MATRIX_16X4  = 5'd11, MATRIX_16X8  = 5'd12, MATRIX_16X16 = 5'd13, MATRIX_16X32 = 5'd14, MATRIX_16X64 = 5'd15,
            MATRIX_32X4  = 5'd16, MATRIX_32X8  = 5'd17, MATRIX_32X16 = 5'd18, MATRIX_32X32 = 5'd19, MATRIX_32X64 = 5'd20,
            MATRIX_64X4  = 5'd21, MATRIX_64X8  = 5'd22, MATRIX_64X16 = 5'd23, MATRIX_64X32 = 5'd24, MATRIX_64X64 = 5'd25;

    integer i;
    integer j;
    reg            [   63  :   0 ]              i_valid_d;
    reg                                         i_valid_d1;
    reg     signed [WIDTH - 1 : 0]  i_data_d1   [63 : 0];
    wire    signed [WIDTH - 1 : 0]  i_data      [63 : 0];
    reg     signed [WIDTH - 1 : 0]  o_data      [63 : 0];

    reg     write_flag;
    reg     read_flag;
    

    reg     signed  [WIDTH - 1 : 0]     wr_data     [63:0];
    reg             [6:0]               wr_addr     [63:0];    
    wire    signed  [WIDTH - 1 : 0]     rd_data     [63:0];
    reg             [6:0]               rd_addr     [63:0];
    reg             [5:0]               wr_count;
    reg             [5:0]               wr_count_max;
    reg             [5:0]               rd_count;
    reg             [5:0]               rd_count_d1;
    reg             [5:0]               rd_count_max;
    wire            [5:0]               inf_counter;
    
    reg             [6:0]               addr_pointer;

    reg             [6:0]               matrix_height;
    reg             [6:0]               matrix_width;
    reg             [6:0]               read_matrix_height;
    reg             [6:0]               read_matrix_width;
    reg             [4:0]               wr_matrix;
    reg             [4:0]               wr_matrix_d1;
    reg             [4:0]               wr_matrix_d     [63:0];
    reg             [4:0]               rd_matrix_d1;
    reg             [4:0]               rd_matrix_d2;

    reg             [2:0]               o_height_t;
    reg             [2:0]               o_width_t;
    wire                                o_valid_t;
    reg             [2:0]               o_height_d1;
    reg             [2:0]               o_width_d1;
    reg                                 o_valid_d1;


//data_in delay 1 clk
always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        for(i = 0;i < 64;i = i + 1) begin
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
        i_data_d1[16] = i_16;
        i_data_d1[17] = i_17;
        i_data_d1[18] = i_18;
        i_data_d1[19] = i_19;
        i_data_d1[20] = i_20;
        i_data_d1[21] = i_21;
        i_data_d1[22] = i_22;
        i_data_d1[23] = i_23;
        i_data_d1[24] = i_24;
        i_data_d1[25] = i_25;
        i_data_d1[26] = i_26;
        i_data_d1[27] = i_27;
        i_data_d1[28] = i_28;
        i_data_d1[29] = i_29;
        i_data_d1[30] = i_30;
        i_data_d1[31] = i_31;
        i_data_d1[32] = i_32;
        i_data_d1[33] = i_33;
        i_data_d1[34] = i_34;
        i_data_d1[35] = i_35;
        i_data_d1[36] = i_36;
        i_data_d1[37] = i_37;
        i_data_d1[38] = i_38;
        i_data_d1[39] = i_39;
        i_data_d1[40] = i_40;
        i_data_d1[41] = i_41;
        i_data_d1[42] = i_42;
        i_data_d1[43] = i_43;
        i_data_d1[44] = i_44;
        i_data_d1[45] = i_45;
        i_data_d1[46] = i_46;
        i_data_d1[47] = i_47;
        i_data_d1[48] = i_48;
        i_data_d1[49] = i_49;
        i_data_d1[50] = i_50;
        i_data_d1[51] = i_51;
        i_data_d1[52] = i_52;
        i_data_d1[53] = i_53;
        i_data_d1[54] = i_54;
        i_data_d1[55] = i_55;
        i_data_d1[56] = i_56;
        i_data_d1[57] = i_57;
        i_data_d1[58] = i_58;
        i_data_d1[59] = i_59;
        i_data_d1[60] = i_60;
        i_data_d1[61] = i_61;
        i_data_d1[62] = i_62;
        i_data_d1[63] = i_63;
    end
end
//matrix select
always @(*) begin
    case ({i_width, i_height}) 
        {DCT_4 , DCT_4 } : wr_matrix <= MATRIX_4X4  ;
        {DCT_8 , DCT_4 } : wr_matrix <= MATRIX_4X8  ;
        {DCT_16, DCT_4 } : wr_matrix <= MATRIX_4X16 ;
        {DCT_32, DCT_4 } : wr_matrix <= MATRIX_4X32 ;
        {DCT_64, DCT_4 } : wr_matrix <= MATRIX_4X64 ;
        {DCT_4 , DCT_8 } : wr_matrix <= MATRIX_8X4  ;
        {DCT_8 , DCT_8 } : wr_matrix <= MATRIX_8X8  ;
        {DCT_16, DCT_8 } : wr_matrix <= MATRIX_8X16 ;
        {DCT_32, DCT_8 } : wr_matrix <= MATRIX_8X32 ;
        {DCT_64, DCT_8 } : wr_matrix <= MATRIX_8X64 ;
        {DCT_4 , DCT_16} : wr_matrix <= MATRIX_16X4 ;
        {DCT_8 , DCT_16} : wr_matrix <= MATRIX_16X8 ;
        {DCT_16, DCT_16} : wr_matrix <= MATRIX_16X16;
        {DCT_32, DCT_16} : wr_matrix <= MATRIX_16X32;
        {DCT_64, DCT_16} : wr_matrix <= MATRIX_16X64;
        {DCT_4 , DCT_32} : wr_matrix <= MATRIX_32X4 ;
        {DCT_8 , DCT_32} : wr_matrix <= MATRIX_32X8 ;
        {DCT_16, DCT_32} : wr_matrix <= MATRIX_32X16;
        {DCT_32, DCT_32} : wr_matrix <= MATRIX_32X32;
        {DCT_64, DCT_32} : wr_matrix <= MATRIX_32X64;
        {DCT_4 , DCT_64} : wr_matrix <= MATRIX_64X4 ;
        {DCT_8 , DCT_64} : wr_matrix <= MATRIX_64X8 ;
        {DCT_16, DCT_64} : wr_matrix <= MATRIX_64X16;
        {DCT_32, DCT_64} : wr_matrix <= MATRIX_64X32;
        {DCT_64, DCT_64} : wr_matrix <= MATRIX_64X64;
        default          : wr_matrix <= 0;
    endcase
end


//matrix information counter record
assign inf_counter = 63;

//in)valid delay 64clk
assign o_valid_t =  i_valid_d[inf_counter];

//matrix delay 64clk 
always @(*) begin
    case (wr_matrix_d[inf_counter]) 
        {MATRIX_4X4  } : {o_height_t, o_width_t} <= {DCT_4 , DCT_4  };
        {MATRIX_4X8  } : {o_height_t, o_width_t} <= {DCT_4 , DCT_8  };
        {MATRIX_4X16 } : {o_height_t, o_width_t} <= {DCT_4 , DCT_16 };
        {MATRIX_4X32 } : {o_height_t, o_width_t} <= {DCT_4 , DCT_32 };
        {MATRIX_4X64 } : {o_height_t, o_width_t} <= {DCT_4 , DCT_64 };
        {MATRIX_8X4  } : {o_height_t, o_width_t} <= {DCT_8 , DCT_4  };
        {MATRIX_8X8  } : {o_height_t, o_width_t} <= {DCT_8 , DCT_8  };
        {MATRIX_8X16 } : {o_height_t, o_width_t} <= {DCT_8 , DCT_16 };
        {MATRIX_8X32 } : {o_height_t, o_width_t} <= {DCT_8 , DCT_32 };
        {MATRIX_8X64 } : {o_height_t, o_width_t} <= {DCT_8 , DCT_64 };
        {MATRIX_16X4 } : {o_height_t, o_width_t} <= {DCT_16, DCT_4  };
        {MATRIX_16X8 } : {o_height_t, o_width_t} <= {DCT_16, DCT_8  };
        {MATRIX_16X16} : {o_height_t, o_width_t} <= {DCT_16, DCT_16 };
        {MATRIX_16X32} : {o_height_t, o_width_t} <= {DCT_16, DCT_32 };
        {MATRIX_16X64} : {o_height_t, o_width_t} <= {DCT_16, DCT_64 };
        {MATRIX_32X4 } : {o_height_t, o_width_t} <= {DCT_32, DCT_4  };
        {MATRIX_32X8 } : {o_height_t, o_width_t} <= {DCT_32, DCT_8  };
        {MATRIX_32X16} : {o_height_t, o_width_t} <= {DCT_32, DCT_16 };
        {MATRIX_32X32} : {o_height_t, o_width_t} <= {DCT_32, DCT_32 };
        {MATRIX_32X64} : {o_height_t, o_width_t} <= {DCT_32, DCT_64 };
        {MATRIX_64X4 } : {o_height_t, o_width_t} <= {DCT_64, DCT_4  };
        {MATRIX_64X8 } : {o_height_t, o_width_t} <= {DCT_64, DCT_8  };
        {MATRIX_64X16} : {o_height_t, o_width_t} <= {DCT_64, DCT_16 };
        {MATRIX_64X32} : {o_height_t, o_width_t} <= {DCT_64, DCT_32 };
        {MATRIX_64X64} : {o_height_t, o_width_t} <= {DCT_64, DCT_64 };
        default        : {o_height_t, o_width_t} <= {DCT_4, DCT_4 };
    endcase
end


//write_matrix_width
always@(*)
    if(!rst_n)
        matrix_width <= 0;
    else    
        case(i_width)
            DCT_4  :   matrix_width <= 7'd4;
            DCT_8  :   matrix_width <= 7'd8;
            DCT_16 :   matrix_width <= 7'd16;
            DCT_32 :   matrix_width <= 7'd32;
            DCT_64 :   matrix_width <= 7'd64;
            default:matrix_width <= 0;
        endcase

//write_matrix_height
always@(*)
    if(!rst_n)
        matrix_height <= 0;
    else    
        case(i_height)
            DCT_4  :   matrix_height <= 7'd4;
            DCT_8  :   matrix_height <= 7'd8;
            DCT_16 :   matrix_height <= 7'd16;
            DCT_32 :   matrix_height <= 7'd32;
            DCT_64 :   matrix_height <= 7'd64;
            default:matrix_height <= 0;
        endcase

//read_matrix_width
always@(*)
    if(!rst_n)
        read_matrix_width <= 0;
    else    
        case(o_width)
            DCT_4  :   read_matrix_width <= 7'd4;
            DCT_8  :   read_matrix_width <= 7'd8;
            DCT_16 :   read_matrix_width <= 7'd16;
            DCT_32 :   read_matrix_width <= 7'd32;
            DCT_64 :   read_matrix_width <= 7'd64;
            default:read_matrix_width <= 0;
        endcase

//read_matrix_height
always@(*)
    if(!rst_n)
        read_matrix_height <= 0;
    else    
        case(o_height)
            DCT_4  :   read_matrix_height <= 7'd4;
            DCT_8  :   read_matrix_height <= 7'd8;
            DCT_16 :   read_matrix_height <= 7'd16;
            DCT_32 :   read_matrix_height <= 7'd32;
            DCT_64 :   read_matrix_height <= 7'd64;
            default:read_matrix_height <= 0;
        endcase

//wr_matrix shift wr_matrix_d1
always@(posedge clk or negedge rst_n)
    if(!rst_n)
        wr_matrix_d1    <=  0;
    else 
        wr_matrix_d1    <=  wr_matrix;

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        for( i = 0 ; i < 64 ; i = i + 1)
            wr_matrix_d[i]  <= 0;
    else begin
        for(i = 63 ; i > 0 ; i = i - 1) begin
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
        i_valid_d[63:0]   <=  {i_valid_d[62:0],i_valid_d1};

//ram write enable
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        write_flag  <=  0;
    else if(i_valid)
        write_flag  <=  1;
    else
        write_flag  <=  write_flag;
end

//ram read enable
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        read_flag   <=  0;
    else if( i_valid_d[inf_counter - 1])
        read_flag   <=  1;
end


//as write count max 
always@(posedge clk or negedge rst_n)
    if(!rst_n)
        wr_count_max    <=  0;
    else
        wr_count_max    <= matrix_height * matrix_width /64 < 1 ? 0 :matrix_height * matrix_width / 64 - 1;

//wr count 
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        wr_count   <=  0;
    else if (i_valid)//in case of data interrupt
        wr_count <= 0;
    else if(write_flag) begin
        if(wr_count == wr_count_max || wr_count_max == 0) 
            wr_count    <=  0;
        else    
            wr_count    <=  wr_count + 1;
    end
    else    
        wr_count   <=  0;
end

//as read count max 
always@(*) 
    rd_count_max <= ((read_matrix_height * read_matrix_width) / 64) - 1;


//rd count 
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        rd_count   <=  0;
    else if(read_flag) begin
        if(rd_count == rd_count_max || wr_matrix_d[inf_counter] == MATRIX_4X4 || wr_matrix_d[inf_counter] == MATRIX_4X8 || wr_matrix_d[inf_counter] == MATRIX_4X16 || wr_matrix_d[inf_counter] == MATRIX_8X4 || wr_matrix_d[inf_counter] == MATRIX_8X8) 
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

//as output o_valid
always@(posedge clk  or negedge rst_n) begin
    if(!rst_n)
        o_valid_d1 <= 0;
    else
        o_valid_d1 <= o_valid_t;
end

//as output o_height
always@(posedge clk  or negedge rst_n) begin
    if(!rst_n)
        o_height_d1 <= 0;
    else
        o_height_d1 <= o_height_t;
end

//as output o_width
always@(posedge clk  or negedge rst_n) begin
    if(!rst_n)
        o_width_d1 <= 0;
    else
        o_width_d1 <= o_width_t;
end

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        rd_matrix_d1   <=    0;
    else    
        rd_matrix_d1   <=    wr_matrix_d[inf_counter];

//rd_matrix delay 2 clk : as condition for data read
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
    else if(write_flag)
        if(wr_count == wr_count_max)
            addr_pointer    <=  addr_pointer + wr_count_max + 1 ;
    else
        addr_pointer    <=  addr_pointer;

//diagonal storage :assign write addr
always @(*) begin
    for (i = 0; i < 64; i = i + 1)
        wr_addr[ i ] <= 0; 
    if (write_flag) begin
        case (wr_matrix_d1) 
            {MATRIX_4X4} : begin
                for (i = 0; i < 1; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_addr[i + 0] <= i - wr_count + addr_pointer;
                            wr_addr[i + 1] <= i - wr_count + addr_pointer;
                            wr_addr[i + 2] <= i - wr_count + addr_pointer;
                            wr_addr[i + 3] <= i - wr_count + addr_pointer;
                            wr_addr[i + 4] <= i - wr_count + addr_pointer;
                            wr_addr[i + 5] <= i - wr_count + addr_pointer;
                            wr_addr[i + 6] <= i - wr_count + addr_pointer;
                            wr_addr[i + 7] <= i - wr_count + addr_pointer;
                            wr_addr[i + 8] <= i - wr_count + addr_pointer;
                            wr_addr[i + 9] <= i - wr_count + addr_pointer;
                            wr_addr[i + 10] <= i - wr_count + addr_pointer;
                            wr_addr[i + 11] <= i - wr_count + addr_pointer;
                            wr_addr[i + 12] <= i - wr_count + addr_pointer;
                            wr_addr[i + 13] <= i - wr_count + addr_pointer;
                            wr_addr[i + 14] <= i - wr_count + addr_pointer;
                            wr_addr[i + 15] <= i - wr_count + addr_pointer;
                            wr_addr[i + 16] <= i - wr_count + addr_pointer;
                            wr_addr[i + 17] <= i - wr_count + addr_pointer;
                            wr_addr[i + 18] <= i - wr_count + addr_pointer;
                            wr_addr[i + 19] <= i - wr_count + addr_pointer;
                            wr_addr[i + 20] <= i - wr_count + addr_pointer;
                            wr_addr[i + 21] <= i - wr_count + addr_pointer;
                            wr_addr[i + 22] <= i - wr_count + addr_pointer;
                            wr_addr[i + 23] <= i - wr_count + addr_pointer;
                            wr_addr[i + 24] <= i - wr_count + addr_pointer;
                            wr_addr[i + 25] <= i - wr_count + addr_pointer;
                            wr_addr[i + 26] <= i - wr_count + addr_pointer;
                            wr_addr[i + 27] <= i - wr_count + addr_pointer;
                            wr_addr[i + 28] <= i - wr_count + addr_pointer;
                            wr_addr[i + 29] <= i - wr_count + addr_pointer;
                            wr_addr[i + 30] <= i - wr_count + addr_pointer;
                            wr_addr[i + 31] <= i - wr_count + addr_pointer;
                            wr_addr[i + 32] <= i - wr_count + addr_pointer;
                            wr_addr[i + 33] <= i - wr_count + addr_pointer;
                            wr_addr[i + 34] <= i - wr_count + addr_pointer;
                            wr_addr[i + 35] <= i - wr_count + addr_pointer;
                            wr_addr[i + 36] <= i - wr_count + addr_pointer;
                            wr_addr[i + 37] <= i - wr_count + addr_pointer;
                            wr_addr[i + 38] <= i - wr_count + addr_pointer;
                            wr_addr[i + 39] <= i - wr_count + addr_pointer;
                            wr_addr[i + 40] <= i - wr_count + addr_pointer;
                            wr_addr[i + 41] <= i - wr_count + addr_pointer;
                            wr_addr[i + 42] <= i - wr_count + addr_pointer;
                            wr_addr[i + 43] <= i - wr_count + addr_pointer;
                            wr_addr[i + 44] <= i - wr_count + addr_pointer;
                            wr_addr[i + 45] <= i - wr_count + addr_pointer;
                            wr_addr[i + 46] <= i - wr_count + addr_pointer;
                            wr_addr[i + 47] <= i - wr_count + addr_pointer;
                            wr_addr[i + 48] <= i - wr_count + addr_pointer;
                            wr_addr[i + 49] <= i - wr_count + addr_pointer;
                            wr_addr[i + 50] <= i - wr_count + addr_pointer;
                            wr_addr[i + 51] <= i - wr_count + addr_pointer;
                            wr_addr[i + 52] <= i - wr_count + addr_pointer;
                            wr_addr[i + 53] <= i - wr_count + addr_pointer;
                            wr_addr[i + 54] <= i - wr_count + addr_pointer;
                            wr_addr[i + 55] <= i - wr_count + addr_pointer;
                            wr_addr[i + 56] <= i - wr_count + addr_pointer;
                            wr_addr[i + 57] <= i - wr_count + addr_pointer;
                            wr_addr[i + 58] <= i - wr_count + addr_pointer;
                            wr_addr[i + 59] <= i - wr_count + addr_pointer;
                            wr_addr[i + 60] <= i - wr_count + addr_pointer;
                            wr_addr[i + 61] <= i - wr_count + addr_pointer;
                            wr_addr[i + 62] <= i - wr_count + addr_pointer;
                            wr_addr[i + 63] <= i - wr_count + addr_pointer;
                        end
                    else begin
                            wr_addr[i + 0] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 1] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 2] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 3] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 4] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 5] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 6] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 7] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 8] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 9] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 10] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 11] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 12] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 13] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 14] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 15] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 16] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 17] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 18] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 19] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 20] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 21] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 22] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 23] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 24] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 25] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 26] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 27] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 28] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 29] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 30] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 31] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 32] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 33] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 34] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 35] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 36] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 37] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 38] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 39] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 40] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 41] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 42] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 43] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 44] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 45] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 46] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 47] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 48] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 49] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 50] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 51] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 52] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 53] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 54] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 55] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 56] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 57] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 58] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 59] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 60] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 61] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 62] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 63] <= 1 + i - wr_count + addr_pointer;
                        end
                end
            end
            {MATRIX_4X8} : begin
                for (i = 0; i < 1; i = i + 1) begin
                    if (i >= wr_count) begin
                        wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        wr_addr[i + 1] <= i - wr_count + addr_pointer;
                        wr_addr[i + 2] <= i - wr_count + addr_pointer;
                        wr_addr[i + 3] <= i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= i - wr_count + addr_pointer;
                        wr_addr[i + 5] <= i - wr_count + addr_pointer;
                        wr_addr[i + 6] <= i - wr_count + addr_pointer;
                        wr_addr[i + 7] <= i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= i - wr_count + addr_pointer;
                        wr_addr[i + 9] <= i - wr_count + addr_pointer;
                        wr_addr[i + 10] <= i - wr_count + addr_pointer;
                        wr_addr[i + 11] <= i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= i - wr_count + addr_pointer;
                        wr_addr[i + 13] <= i - wr_count + addr_pointer;
                        wr_addr[i + 14] <= i - wr_count + addr_pointer;
                        wr_addr[i + 15] <= i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= i - wr_count + addr_pointer;
                        wr_addr[i + 17] <= i - wr_count + addr_pointer;
                        wr_addr[i + 18] <= i - wr_count + addr_pointer;
                        wr_addr[i + 19] <= i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= i - wr_count + addr_pointer;
                        wr_addr[i + 21] <= i - wr_count + addr_pointer;
                        wr_addr[i + 22] <= i - wr_count + addr_pointer;
                        wr_addr[i + 23] <= i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= i - wr_count + addr_pointer;
                        wr_addr[i + 25] <= i - wr_count + addr_pointer;
                        wr_addr[i + 26] <= i - wr_count + addr_pointer;
                        wr_addr[i + 27] <= i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= i - wr_count + addr_pointer;
                        wr_addr[i + 29] <= i - wr_count + addr_pointer;
                        wr_addr[i + 30] <= i - wr_count + addr_pointer;
                        wr_addr[i + 31] <= i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        wr_addr[i + 33] <= i - wr_count + addr_pointer;
                        wr_addr[i + 34] <= i - wr_count + addr_pointer;
                        wr_addr[i + 35] <= i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= i - wr_count + addr_pointer;
                        wr_addr[i + 37] <= i - wr_count + addr_pointer;
                        wr_addr[i + 38] <= i - wr_count + addr_pointer;
                        wr_addr[i + 39] <= i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= i - wr_count + addr_pointer;
                        wr_addr[i + 41] <= i - wr_count + addr_pointer;
                        wr_addr[i + 42] <= i - wr_count + addr_pointer;
                        wr_addr[i + 43] <= i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= i - wr_count + addr_pointer;
                        wr_addr[i + 45] <= i - wr_count + addr_pointer;
                        wr_addr[i + 46] <= i - wr_count + addr_pointer;
                        wr_addr[i + 47] <= i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= i - wr_count + addr_pointer;
                        wr_addr[i + 49] <= i - wr_count + addr_pointer;
                        wr_addr[i + 50] <= i - wr_count + addr_pointer;
                        wr_addr[i + 51] <= i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= i - wr_count + addr_pointer;
                        wr_addr[i + 53] <= i - wr_count + addr_pointer;
                        wr_addr[i + 54] <= i - wr_count + addr_pointer;
                        wr_addr[i + 55] <= i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= i - wr_count + addr_pointer;
                        wr_addr[i + 57] <= i - wr_count + addr_pointer;
                        wr_addr[i + 58] <= i - wr_count + addr_pointer;
                        wr_addr[i + 59] <= i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= i - wr_count + addr_pointer;
                        wr_addr[i + 61] <= i - wr_count + addr_pointer;
                        wr_addr[i + 62] <= i - wr_count + addr_pointer;
                        wr_addr[i + 63] <= i - wr_count + addr_pointer;
                    end
                    else begin
                        wr_addr[i + 0] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 1] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 2] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 3] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 5] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 6] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 7] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 9] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 10] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 11] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 13] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 14] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 15] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 17] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 18] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 19] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 21] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 22] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 23] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 25] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 26] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 27] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 29] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 30] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 31] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 33] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 34] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 35] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 37] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 38] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 39] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 41] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 42] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 43] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 45] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 46] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 47] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 49] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 50] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 51] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 53] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 54] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 55] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 57] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 58] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 59] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 61] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 62] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 63] <= 1 + i - wr_count + addr_pointer;
                    end
                end
            end
            {MATRIX_4X16} : begin
                for (i = 0; i < 1; i = i + 1) begin
                    if (i >= wr_count) begin
                        wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        wr_addr[i + 1] <= i - wr_count + addr_pointer;
                        wr_addr[i + 2] <= i - wr_count + addr_pointer;
                        wr_addr[i + 3] <= i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= i - wr_count + addr_pointer;
                        wr_addr[i + 5] <= i - wr_count + addr_pointer;
                        wr_addr[i + 6] <= i - wr_count + addr_pointer;
                        wr_addr[i + 7] <= i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= i - wr_count + addr_pointer;
                        wr_addr[i + 9] <= i - wr_count + addr_pointer;
                        wr_addr[i + 10] <= i - wr_count + addr_pointer;
                        wr_addr[i + 11] <= i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= i - wr_count + addr_pointer;
                        wr_addr[i + 13] <= i - wr_count + addr_pointer;
                        wr_addr[i + 14] <= i - wr_count + addr_pointer;
                        wr_addr[i + 15] <= i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= i - wr_count + addr_pointer;
                        wr_addr[i + 17] <= i - wr_count + addr_pointer;
                        wr_addr[i + 18] <= i - wr_count + addr_pointer;
                        wr_addr[i + 19] <= i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= i - wr_count + addr_pointer;
                        wr_addr[i + 21] <= i - wr_count + addr_pointer;
                        wr_addr[i + 22] <= i - wr_count + addr_pointer;
                        wr_addr[i + 23] <= i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= i - wr_count + addr_pointer;
                        wr_addr[i + 25] <= i - wr_count + addr_pointer;
                        wr_addr[i + 26] <= i - wr_count + addr_pointer;
                        wr_addr[i + 27] <= i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= i - wr_count + addr_pointer;
                        wr_addr[i + 29] <= i - wr_count + addr_pointer;
                        wr_addr[i + 30] <= i - wr_count + addr_pointer;
                        wr_addr[i + 31] <= i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        wr_addr[i + 33] <= i - wr_count + addr_pointer;
                        wr_addr[i + 34] <= i - wr_count + addr_pointer;
                        wr_addr[i + 35] <= i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= i - wr_count + addr_pointer;
                        wr_addr[i + 37] <= i - wr_count + addr_pointer;
                        wr_addr[i + 38] <= i - wr_count + addr_pointer;
                        wr_addr[i + 39] <= i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= i - wr_count + addr_pointer;
                        wr_addr[i + 41] <= i - wr_count + addr_pointer;
                        wr_addr[i + 42] <= i - wr_count + addr_pointer;
                        wr_addr[i + 43] <= i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= i - wr_count + addr_pointer;
                        wr_addr[i + 45] <= i - wr_count + addr_pointer;
                        wr_addr[i + 46] <= i - wr_count + addr_pointer;
                        wr_addr[i + 47] <= i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= i - wr_count + addr_pointer;
                        wr_addr[i + 49] <= i - wr_count + addr_pointer;
                        wr_addr[i + 50] <= i - wr_count + addr_pointer;
                        wr_addr[i + 51] <= i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= i - wr_count + addr_pointer;
                        wr_addr[i + 53] <= i - wr_count + addr_pointer;
                        wr_addr[i + 54] <= i - wr_count + addr_pointer;
                        wr_addr[i + 55] <= i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= i - wr_count + addr_pointer;
                        wr_addr[i + 57] <= i - wr_count + addr_pointer;
                        wr_addr[i + 58] <= i - wr_count + addr_pointer;
                        wr_addr[i + 59] <= i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= i - wr_count + addr_pointer;
                        wr_addr[i + 61] <= i - wr_count + addr_pointer;
                        wr_addr[i + 62] <= i - wr_count + addr_pointer;
                        wr_addr[i + 63] <= i - wr_count + addr_pointer;
                    end
                    else begin
                        wr_addr[i + 0] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 1] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 2] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 3] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 5] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 6] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 7] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 9] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 10] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 11] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 13] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 14] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 15] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 17] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 18] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 19] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 21] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 22] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 23] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 25] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 26] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 27] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 29] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 30] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 31] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 33] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 34] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 35] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 37] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 38] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 39] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 41] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 42] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 43] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 45] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 46] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 47] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 49] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 50] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 51] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 53] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 54] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 55] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 57] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 58] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 59] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 61] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 62] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 63] <= 1 + i - wr_count + addr_pointer;
                    end
                end
            end
            {MATRIX_4X32} : begin
                for (i = 0; i < 2; i = i + 1) begin
                    if (i >= wr_count) begin
                        wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        wr_addr[i + 2] <= i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= i - wr_count + addr_pointer;
                        wr_addr[i + 6] <= i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= i - wr_count + addr_pointer;
                        wr_addr[i + 10] <= i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= i - wr_count + addr_pointer;
                        wr_addr[i + 14] <= i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= i - wr_count + addr_pointer;
                        wr_addr[i + 18] <= i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= i - wr_count + addr_pointer;
                        wr_addr[i + 22] <= i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= i - wr_count + addr_pointer;
                        wr_addr[i + 26] <= i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= i - wr_count + addr_pointer;
                        wr_addr[i + 30] <= i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        wr_addr[i + 34] <= i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= i - wr_count + addr_pointer;
                        wr_addr[i + 38] <= i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= i - wr_count + addr_pointer;
                        wr_addr[i + 42] <= i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= i - wr_count + addr_pointer;
                        wr_addr[i + 46] <= i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= i - wr_count + addr_pointer;
                        wr_addr[i + 50] <= i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= i - wr_count + addr_pointer;
                        wr_addr[i + 54] <= i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= i - wr_count + addr_pointer;
                        wr_addr[i + 58] <= i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= i - wr_count + addr_pointer;
                        wr_addr[i + 62] <= i - wr_count + addr_pointer;
                    end
                    else begin
                        wr_addr[i + 0] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 2] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 6] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 10] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 14] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 18] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 22] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 26] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 30] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 34] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 38] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 42] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 46] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 50] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 54] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 58] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 62] <= 2 + i - wr_count + addr_pointer;
                    end
                end
            end
            {MATRIX_4X64} : begin
                for (i = 0; i < 4; i = i + 1) begin
                    if (i >= wr_count) begin
                        wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= i - wr_count + addr_pointer;
                    end
                    else begin
                        wr_addr[i + 0] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= 4 + i - wr_count + addr_pointer;
                    end
                end
            end
            {MATRIX_8X4} : begin
                for (i = 0; i < 1; i = i + 1) begin
                    if (i >= wr_count) begin
                        wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        wr_addr[i + 1] <= i - wr_count + addr_pointer;
                        wr_addr[i + 2] <= i - wr_count + addr_pointer;
                        wr_addr[i + 3] <= i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= i - wr_count + addr_pointer;
                        wr_addr[i + 5] <= i - wr_count + addr_pointer;
                        wr_addr[i + 6] <= i - wr_count + addr_pointer;
                        wr_addr[i + 7] <= i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= i - wr_count + addr_pointer;
                        wr_addr[i + 9] <= i - wr_count + addr_pointer;
                        wr_addr[i + 10] <= i - wr_count + addr_pointer;
                        wr_addr[i + 11] <= i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= i - wr_count + addr_pointer;
                        wr_addr[i + 13] <= i - wr_count + addr_pointer;
                        wr_addr[i + 14] <= i - wr_count + addr_pointer;
                        wr_addr[i + 15] <= i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= i - wr_count + addr_pointer;
                        wr_addr[i + 17] <= i - wr_count + addr_pointer;
                        wr_addr[i + 18] <= i - wr_count + addr_pointer;
                        wr_addr[i + 19] <= i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= i - wr_count + addr_pointer;
                        wr_addr[i + 21] <= i - wr_count + addr_pointer;
                        wr_addr[i + 22] <= i - wr_count + addr_pointer;
                        wr_addr[i + 23] <= i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= i - wr_count + addr_pointer;
                        wr_addr[i + 25] <= i - wr_count + addr_pointer;
                        wr_addr[i + 26] <= i - wr_count + addr_pointer;
                        wr_addr[i + 27] <= i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= i - wr_count + addr_pointer;
                        wr_addr[i + 29] <= i - wr_count + addr_pointer;
                        wr_addr[i + 30] <= i - wr_count + addr_pointer;
                        wr_addr[i + 31] <= i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        wr_addr[i + 33] <= i - wr_count + addr_pointer;
                        wr_addr[i + 34] <= i - wr_count + addr_pointer;
                        wr_addr[i + 35] <= i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= i - wr_count + addr_pointer;
                        wr_addr[i + 37] <= i - wr_count + addr_pointer;
                        wr_addr[i + 38] <= i - wr_count + addr_pointer;
                        wr_addr[i + 39] <= i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= i - wr_count + addr_pointer;
                        wr_addr[i + 41] <= i - wr_count + addr_pointer;
                        wr_addr[i + 42] <= i - wr_count + addr_pointer;
                        wr_addr[i + 43] <= i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= i - wr_count + addr_pointer;
                        wr_addr[i + 45] <= i - wr_count + addr_pointer;
                        wr_addr[i + 46] <= i - wr_count + addr_pointer;
                        wr_addr[i + 47] <= i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= i - wr_count + addr_pointer;
                        wr_addr[i + 49] <= i - wr_count + addr_pointer;
                        wr_addr[i + 50] <= i - wr_count + addr_pointer;
                        wr_addr[i + 51] <= i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= i - wr_count + addr_pointer;
                        wr_addr[i + 53] <= i - wr_count + addr_pointer;
                        wr_addr[i + 54] <= i - wr_count + addr_pointer;
                        wr_addr[i + 55] <= i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= i - wr_count + addr_pointer;
                        wr_addr[i + 57] <= i - wr_count + addr_pointer;
                        wr_addr[i + 58] <= i - wr_count + addr_pointer;
                        wr_addr[i + 59] <= i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= i - wr_count + addr_pointer;
                        wr_addr[i + 61] <= i - wr_count + addr_pointer;
                        wr_addr[i + 62] <= i - wr_count + addr_pointer;
                        wr_addr[i + 63] <= i - wr_count + addr_pointer;
                    end
                    else begin
                        wr_addr[i + 0] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 1] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 2] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 3] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 5] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 6] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 7] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 9] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 10] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 11] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 13] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 14] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 15] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 17] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 18] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 19] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 21] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 22] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 23] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 25] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 26] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 27] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 29] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 30] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 31] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 33] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 34] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 35] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 37] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 38] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 39] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 41] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 42] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 43] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 45] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 46] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 47] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 49] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 50] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 51] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 53] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 54] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 55] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 57] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 58] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 59] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 61] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 62] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 63] <= 1 + i - wr_count + addr_pointer;
                    end
                end
            end
            {MATRIX_8X8} : begin
                for (i = 0; i < 1; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_addr[i + 0] <= i - wr_count + addr_pointer;
                            wr_addr[i + 1] <= i - wr_count + addr_pointer;
                            wr_addr[i + 2] <= i - wr_count + addr_pointer;
                            wr_addr[i + 3] <= i - wr_count + addr_pointer;
                            wr_addr[i + 4] <= i - wr_count + addr_pointer;
                            wr_addr[i + 5] <= i - wr_count + addr_pointer;
                            wr_addr[i + 6] <= i - wr_count + addr_pointer;
                            wr_addr[i + 7] <= i - wr_count + addr_pointer;
                            wr_addr[i + 8] <= i - wr_count + addr_pointer;
                            wr_addr[i + 9] <= i - wr_count + addr_pointer;
                            wr_addr[i + 10] <= i - wr_count + addr_pointer;
                            wr_addr[i + 11] <= i - wr_count + addr_pointer;
                            wr_addr[i + 12] <= i - wr_count + addr_pointer;
                            wr_addr[i + 13] <= i - wr_count + addr_pointer;
                            wr_addr[i + 14] <= i - wr_count + addr_pointer;
                            wr_addr[i + 15] <= i - wr_count + addr_pointer;
                            wr_addr[i + 16] <= i - wr_count + addr_pointer;
                            wr_addr[i + 17] <= i - wr_count + addr_pointer;
                            wr_addr[i + 18] <= i - wr_count + addr_pointer;
                            wr_addr[i + 19] <= i - wr_count + addr_pointer;
                            wr_addr[i + 20] <= i - wr_count + addr_pointer;
                            wr_addr[i + 21] <= i - wr_count + addr_pointer;
                            wr_addr[i + 22] <= i - wr_count + addr_pointer;
                            wr_addr[i + 23] <= i - wr_count + addr_pointer;
                            wr_addr[i + 24] <= i - wr_count + addr_pointer;
                            wr_addr[i + 25] <= i - wr_count + addr_pointer;
                            wr_addr[i + 26] <= i - wr_count + addr_pointer;
                            wr_addr[i + 27] <= i - wr_count + addr_pointer;
                            wr_addr[i + 28] <= i - wr_count + addr_pointer;
                            wr_addr[i + 29] <= i - wr_count + addr_pointer;
                            wr_addr[i + 30] <= i - wr_count + addr_pointer;
                            wr_addr[i + 31] <= i - wr_count + addr_pointer;
                            wr_addr[i + 32] <= i - wr_count + addr_pointer;
                            wr_addr[i + 33] <= i - wr_count + addr_pointer;
                            wr_addr[i + 34] <= i - wr_count + addr_pointer;
                            wr_addr[i + 35] <= i - wr_count + addr_pointer;
                            wr_addr[i + 36] <= i - wr_count + addr_pointer;
                            wr_addr[i + 37] <= i - wr_count + addr_pointer;
                            wr_addr[i + 38] <= i - wr_count + addr_pointer;
                            wr_addr[i + 39] <= i - wr_count + addr_pointer;
                            wr_addr[i + 40] <= i - wr_count + addr_pointer;
                            wr_addr[i + 41] <= i - wr_count + addr_pointer;
                            wr_addr[i + 42] <= i - wr_count + addr_pointer;
                            wr_addr[i + 43] <= i - wr_count + addr_pointer;
                            wr_addr[i + 44] <= i - wr_count + addr_pointer;
                            wr_addr[i + 45] <= i - wr_count + addr_pointer;
                            wr_addr[i + 46] <= i - wr_count + addr_pointer;
                            wr_addr[i + 47] <= i - wr_count + addr_pointer;
                            wr_addr[i + 48] <= i - wr_count + addr_pointer;
                            wr_addr[i + 49] <= i - wr_count + addr_pointer;
                            wr_addr[i + 50] <= i - wr_count + addr_pointer;
                            wr_addr[i + 51] <= i - wr_count + addr_pointer;
                            wr_addr[i + 52] <= i - wr_count + addr_pointer;
                            wr_addr[i + 53] <= i - wr_count + addr_pointer;
                            wr_addr[i + 54] <= i - wr_count + addr_pointer;
                            wr_addr[i + 55] <= i - wr_count + addr_pointer;
                            wr_addr[i + 56] <= i - wr_count + addr_pointer;
                            wr_addr[i + 57] <= i - wr_count + addr_pointer;
                            wr_addr[i + 58] <= i - wr_count + addr_pointer;
                            wr_addr[i + 59] <= i - wr_count + addr_pointer;
                            wr_addr[i + 60] <= i - wr_count + addr_pointer;
                            wr_addr[i + 61] <= i - wr_count + addr_pointer;
                            wr_addr[i + 62] <= i - wr_count + addr_pointer;
                            wr_addr[i + 63] <= i - wr_count + addr_pointer;
                        end
                    else begin
                            wr_addr[i + 0] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 1] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 2] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 3] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 4] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 5] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 6] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 7] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 8] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 9] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 10] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 11] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 12] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 13] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 14] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 15] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 16] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 17] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 18] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 19] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 20] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 21] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 22] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 23] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 24] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 25] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 26] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 27] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 28] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 29] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 30] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 31] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 32] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 33] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 34] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 35] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 36] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 37] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 38] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 39] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 40] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 41] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 42] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 43] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 44] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 45] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 46] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 47] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 48] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 49] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 50] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 51] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 52] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 53] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 54] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 55] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 56] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 57] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 58] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 59] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 60] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 61] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 62] <= 1 + i - wr_count + addr_pointer;
                            wr_addr[i + 63] <= 1 + i - wr_count + addr_pointer;
                        end
                end
            end
            {MATRIX_8X16} : begin
                for (i = 0; i < 2; i = i + 1) begin
                    if (i >= wr_count) begin
                        wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        wr_addr[i + 2] <= i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= i - wr_count + addr_pointer;
                        wr_addr[i + 6] <= i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= i - wr_count + addr_pointer;
                        wr_addr[i + 10] <= i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= i - wr_count + addr_pointer;
                        wr_addr[i + 14] <= i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= i - wr_count + addr_pointer;
                        wr_addr[i + 18] <= i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= i - wr_count + addr_pointer;
                        wr_addr[i + 22] <= i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= i - wr_count + addr_pointer;
                        wr_addr[i + 26] <= i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= i - wr_count + addr_pointer;
                        wr_addr[i + 30] <= i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        wr_addr[i + 34] <= i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= i - wr_count + addr_pointer;
                        wr_addr[i + 38] <= i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= i - wr_count + addr_pointer;
                        wr_addr[i + 42] <= i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= i - wr_count + addr_pointer;
                        wr_addr[i + 46] <= i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= i - wr_count + addr_pointer;
                        wr_addr[i + 50] <= i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= i - wr_count + addr_pointer;
                        wr_addr[i + 54] <= i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= i - wr_count + addr_pointer;
                        wr_addr[i + 58] <= i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= i - wr_count + addr_pointer;
                        wr_addr[i + 62] <= i - wr_count + addr_pointer;
                    end
                    else begin
                        wr_addr[i + 0] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 2] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 6] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 10] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 14] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 18] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 22] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 26] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 30] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 34] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 38] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 42] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 46] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 50] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 54] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 58] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 62] <= 2 + i - wr_count + addr_pointer;
                    end
                end
            end
            {MATRIX_8X32} : begin
                for (i = 0; i < 4; i = i + 1) begin
                    if (i >= wr_count) begin
                        wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= i - wr_count + addr_pointer;
                    end
                    else begin
                        wr_addr[i + 0] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= 4 + i - wr_count + addr_pointer;
                    end
                end
            end
            {MATRIX_8X64} : begin
                for (i = 0; i < 8; i = i + 1) begin
                    if (i >= wr_count) begin
                        wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= i - wr_count + addr_pointer;
                    end
                    else begin
                        wr_addr[i + 0] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= 8 + i - wr_count + addr_pointer;
                    end
                end
            end
            {MATRIX_16X4} : begin
                for (i = 0; i < 1; i = i + 1) begin
                    if (i >= wr_count) begin
                        wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        wr_addr[i + 1] <= i - wr_count + addr_pointer;
                        wr_addr[i + 2] <= i - wr_count + addr_pointer;
                        wr_addr[i + 3] <= i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= i - wr_count + addr_pointer;
                        wr_addr[i + 5] <= i - wr_count + addr_pointer;
                        wr_addr[i + 6] <= i - wr_count + addr_pointer;
                        wr_addr[i + 7] <= i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= i - wr_count + addr_pointer;
                        wr_addr[i + 9] <= i - wr_count + addr_pointer;
                        wr_addr[i + 10] <= i - wr_count + addr_pointer;
                        wr_addr[i + 11] <= i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= i - wr_count + addr_pointer;
                        wr_addr[i + 13] <= i - wr_count + addr_pointer;
                        wr_addr[i + 14] <= i - wr_count + addr_pointer;
                        wr_addr[i + 15] <= i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= i - wr_count + addr_pointer;
                        wr_addr[i + 17] <= i - wr_count + addr_pointer;
                        wr_addr[i + 18] <= i - wr_count + addr_pointer;
                        wr_addr[i + 19] <= i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= i - wr_count + addr_pointer;
                        wr_addr[i + 21] <= i - wr_count + addr_pointer;
                        wr_addr[i + 22] <= i - wr_count + addr_pointer;
                        wr_addr[i + 23] <= i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= i - wr_count + addr_pointer;
                        wr_addr[i + 25] <= i - wr_count + addr_pointer;
                        wr_addr[i + 26] <= i - wr_count + addr_pointer;
                        wr_addr[i + 27] <= i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= i - wr_count + addr_pointer;
                        wr_addr[i + 29] <= i - wr_count + addr_pointer;
                        wr_addr[i + 30] <= i - wr_count + addr_pointer;
                        wr_addr[i + 31] <= i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        wr_addr[i + 33] <= i - wr_count + addr_pointer;
                        wr_addr[i + 34] <= i - wr_count + addr_pointer;
                        wr_addr[i + 35] <= i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= i - wr_count + addr_pointer;
                        wr_addr[i + 37] <= i - wr_count + addr_pointer;
                        wr_addr[i + 38] <= i - wr_count + addr_pointer;
                        wr_addr[i + 39] <= i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= i - wr_count + addr_pointer;
                        wr_addr[i + 41] <= i - wr_count + addr_pointer;
                        wr_addr[i + 42] <= i - wr_count + addr_pointer;
                        wr_addr[i + 43] <= i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= i - wr_count + addr_pointer;
                        wr_addr[i + 45] <= i - wr_count + addr_pointer;
                        wr_addr[i + 46] <= i - wr_count + addr_pointer;
                        wr_addr[i + 47] <= i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= i - wr_count + addr_pointer;
                        wr_addr[i + 49] <= i - wr_count + addr_pointer;
                        wr_addr[i + 50] <= i - wr_count + addr_pointer;
                        wr_addr[i + 51] <= i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= i - wr_count + addr_pointer;
                        wr_addr[i + 53] <= i - wr_count + addr_pointer;
                        wr_addr[i + 54] <= i - wr_count + addr_pointer;
                        wr_addr[i + 55] <= i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= i - wr_count + addr_pointer;
                        wr_addr[i + 57] <= i - wr_count + addr_pointer;
                        wr_addr[i + 58] <= i - wr_count + addr_pointer;
                        wr_addr[i + 59] <= i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= i - wr_count + addr_pointer;
                        wr_addr[i + 61] <= i - wr_count + addr_pointer;
                        wr_addr[i + 62] <= i - wr_count + addr_pointer;
                        wr_addr[i + 63] <= i - wr_count + addr_pointer;
                    end
                    else begin
                        wr_addr[i + 0] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 1] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 2] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 3] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 5] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 6] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 7] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 9] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 10] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 11] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 13] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 14] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 15] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 17] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 18] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 19] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 21] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 22] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 23] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 25] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 26] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 27] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 29] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 30] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 31] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 33] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 34] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 35] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 37] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 38] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 39] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 41] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 42] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 43] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 45] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 46] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 47] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 49] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 50] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 51] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 53] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 54] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 55] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 57] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 58] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 59] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 61] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 62] <= 1 + i - wr_count + addr_pointer;
                        wr_addr[i + 63] <= 1 + i - wr_count + addr_pointer;
                    end
                end
            end
            {MATRIX_16X8} : begin
                for (i = 0; i < 2; i = i + 1) begin
                    if (i >= wr_count) begin
                        wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        wr_addr[i + 2] <= i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= i - wr_count + addr_pointer;
                        wr_addr[i + 6] <= i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= i - wr_count + addr_pointer;
                        wr_addr[i + 10] <= i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= i - wr_count + addr_pointer;
                        wr_addr[i + 14] <= i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= i - wr_count + addr_pointer;
                        wr_addr[i + 18] <= i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= i - wr_count + addr_pointer;
                        wr_addr[i + 22] <= i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= i - wr_count + addr_pointer;
                        wr_addr[i + 26] <= i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= i - wr_count + addr_pointer;
                        wr_addr[i + 30] <= i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        wr_addr[i + 34] <= i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= i - wr_count + addr_pointer;
                        wr_addr[i + 38] <= i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= i - wr_count + addr_pointer;
                        wr_addr[i + 42] <= i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= i - wr_count + addr_pointer;
                        wr_addr[i + 46] <= i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= i - wr_count + addr_pointer;
                        wr_addr[i + 50] <= i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= i - wr_count + addr_pointer;
                        wr_addr[i + 54] <= i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= i - wr_count + addr_pointer;
                        wr_addr[i + 58] <= i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= i - wr_count + addr_pointer;
                        wr_addr[i + 62] <= i - wr_count + addr_pointer;
                    end
                    else begin
                        wr_addr[i + 0] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 2] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 6] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 10] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 14] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 18] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 22] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 26] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 30] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 34] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 38] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 42] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 46] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 50] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 54] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 58] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 62] <= 2 + i - wr_count + addr_pointer;
                    end
                end
            end
            {MATRIX_16X16} : begin
                for (i = 0; i < 4; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_addr[i + 0] <= i - wr_count + addr_pointer;
                            wr_addr[i + 4] <= i - wr_count + addr_pointer;
                            wr_addr[i + 8] <= i - wr_count + addr_pointer;
                            wr_addr[i + 12] <= i - wr_count + addr_pointer;
                            wr_addr[i + 16] <= i - wr_count + addr_pointer;
                            wr_addr[i + 20] <= i - wr_count + addr_pointer;
                            wr_addr[i + 24] <= i - wr_count + addr_pointer;
                            wr_addr[i + 28] <= i - wr_count + addr_pointer;
                            wr_addr[i + 32] <= i - wr_count + addr_pointer;
                            wr_addr[i + 36] <= i - wr_count + addr_pointer;
                            wr_addr[i + 40] <= i - wr_count + addr_pointer;
                            wr_addr[i + 44] <= i - wr_count + addr_pointer;
                            wr_addr[i + 48] <= i - wr_count + addr_pointer;
                            wr_addr[i + 52] <= i - wr_count + addr_pointer;
                            wr_addr[i + 56] <= i - wr_count + addr_pointer;
                            wr_addr[i + 60] <= i - wr_count + addr_pointer;
                        end
                    else begin
                            wr_addr[i + 0] <= 4 + i - wr_count + addr_pointer;
                            wr_addr[i + 4] <= 4 + i - wr_count + addr_pointer;
                            wr_addr[i + 8] <= 4 + i - wr_count + addr_pointer;
                            wr_addr[i + 12] <= 4 + i - wr_count + addr_pointer;
                            wr_addr[i + 16] <= 4 + i - wr_count + addr_pointer;
                            wr_addr[i + 20] <= 4 + i - wr_count + addr_pointer;
                            wr_addr[i + 24] <= 4 + i - wr_count + addr_pointer;
                            wr_addr[i + 28] <= 4 + i - wr_count + addr_pointer;
                            wr_addr[i + 32] <= 4 + i - wr_count + addr_pointer;
                            wr_addr[i + 36] <= 4 + i - wr_count + addr_pointer;
                            wr_addr[i + 40] <= 4 + i - wr_count + addr_pointer;
                            wr_addr[i + 44] <= 4 + i - wr_count + addr_pointer;
                            wr_addr[i + 48] <= 4 + i - wr_count + addr_pointer;
                            wr_addr[i + 52] <= 4 + i - wr_count + addr_pointer;
                            wr_addr[i + 56] <= 4 + i - wr_count + addr_pointer;
                            wr_addr[i + 60] <= 4 + i - wr_count + addr_pointer;
                        end
                end
            end
            {MATRIX_16X32} : begin
                for (i = 0; i < 8; i = i + 1) begin
                    if (i >= wr_count) begin
                        wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= i - wr_count + addr_pointer;
                    end
                    else begin
                        wr_addr[i + 0] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= 8 + i - wr_count + addr_pointer;
                    end
                end
            end
            {MATRIX_16X64} : begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= wr_count) begin
                        wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= i - wr_count + addr_pointer;
                    end
                    else begin
                        wr_addr[i + 0] <= 16 + i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= 16 + i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= 16 + i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= 16 + i - wr_count + addr_pointer;
                    end
                end
            end
            {MATRIX_32X4} : begin
                for (i = 0; i < 2; i = i + 1) begin
                    if (i >= wr_count) begin
                        wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        wr_addr[i + 2] <= i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= i - wr_count + addr_pointer;
                        wr_addr[i + 6] <= i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= i - wr_count + addr_pointer;
                        wr_addr[i + 10] <= i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= i - wr_count + addr_pointer;
                        wr_addr[i + 14] <= i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= i - wr_count + addr_pointer;
                        wr_addr[i + 18] <= i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= i - wr_count + addr_pointer;
                        wr_addr[i + 22] <= i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= i - wr_count + addr_pointer;
                        wr_addr[i + 26] <= i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= i - wr_count + addr_pointer;
                        wr_addr[i + 30] <= i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        wr_addr[i + 34] <= i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= i - wr_count + addr_pointer;
                        wr_addr[i + 38] <= i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= i - wr_count + addr_pointer;
                        wr_addr[i + 42] <= i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= i - wr_count + addr_pointer;
                        wr_addr[i + 46] <= i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= i - wr_count + addr_pointer;
                        wr_addr[i + 50] <= i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= i - wr_count + addr_pointer;
                        wr_addr[i + 54] <= i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= i - wr_count + addr_pointer;
                        wr_addr[i + 58] <= i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= i - wr_count + addr_pointer;
                        wr_addr[i + 62] <= i - wr_count + addr_pointer;
                    end
                    else begin
                        wr_addr[i + 0] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 2] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 6] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 10] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 14] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 18] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 22] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 26] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 30] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 34] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 38] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 42] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 46] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 50] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 54] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 58] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= 2 + i - wr_count + addr_pointer;
                        wr_addr[i + 62] <= 2 + i - wr_count + addr_pointer;
                    end
                end
            end
            {MATRIX_32X8} : begin
                for (i = 0; i < 4; i = i + 1) begin
                    if (i >= wr_count) begin
                        wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= i - wr_count + addr_pointer;
                    end
                    else begin
                        wr_addr[i + 0] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= 4 + i - wr_count + addr_pointer;
                    end
                end
            end
            {MATRIX_32X16} : begin
                for (i = 0; i < 8; i = i + 1) begin
                    if (i >= wr_count) begin
                        wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= i - wr_count + addr_pointer;
                    end
                    else begin
                        wr_addr[i + 0] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= 8 + i - wr_count + addr_pointer;
                    end
                end
            end
            {MATRIX_32X32} : begin
                for (i = 0; i < 16; i = i + 1) begin
                            if (i >= wr_count) begin
                                    wr_addr[i + 0] <= i - wr_count + addr_pointer;
                                    wr_addr[i + 16] <= i - wr_count + addr_pointer;
                                    wr_addr[i + 32] <= i - wr_count + addr_pointer;
                                    wr_addr[i + 48] <= i - wr_count + addr_pointer;
                                end
                            else begin
                                    wr_addr[i + 0] <= 16 + i - wr_count + addr_pointer;
                                    wr_addr[i + 16] <= 16 + i - wr_count + addr_pointer;
                                    wr_addr[i + 32] <= 16 + i - wr_count + addr_pointer;
                                    wr_addr[i + 48] <= 16 + i - wr_count + addr_pointer;
                                end
                            end
                end
            {MATRIX_32X64} : begin
                for (i = 0; i < 32; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_addr[i + 0] <= i - wr_count + addr_pointer;
                            wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        end
                    else begin
                            wr_addr[i + 0] <= 32 + i - wr_count + addr_pointer;
                            wr_addr[i + 32] <= 32 + i - wr_count + addr_pointer;
                        end
                end
            end
            {MATRIX_64X4} : begin
                for (i = 0; i < 4; i = i + 1) begin
                    if (i >= wr_count) begin
                        wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= i - wr_count + addr_pointer;
                    end
                    else begin
                        wr_addr[i + 0] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 4] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 12] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 20] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 28] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 36] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 44] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 52] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= 4 + i - wr_count + addr_pointer;
                        wr_addr[i + 60] <= 4 + i - wr_count + addr_pointer;
                    end
                end
            end
            {MATRIX_64X8} : begin
                for (i = 0; i < 8; i = i + 1) begin
                    if (i >= wr_count) begin
                        wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= i - wr_count + addr_pointer;
                    end
                    else begin
                        wr_addr[i + 0] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 8] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 24] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 40] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= 8 + i - wr_count + addr_pointer;
                        wr_addr[i + 56] <= 8 + i - wr_count + addr_pointer;
                    end
                end
            end
            {MATRIX_64X16} : begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= wr_count) begin
                        wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= i - wr_count + addr_pointer;
                    end
                    else begin
                        wr_addr[i + 0] <= 16 + i - wr_count + addr_pointer;
                        wr_addr[i + 16] <= 16 + i - wr_count + addr_pointer;
                        wr_addr[i + 32] <= 16 + i - wr_count + addr_pointer;
                        wr_addr[i + 48] <= 16 + i - wr_count + addr_pointer;
                    end
                end
            end
            {MATRIX_64X32} : begin
                for (i = 0; i < 32; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_addr[i + 0] <= i - wr_count + addr_pointer;
                            wr_addr[i + 32] <= i - wr_count + addr_pointer;
                        end
                    else begin
                            wr_addr[i + 0] <= 32 + i - wr_count + addr_pointer;
                            wr_addr[i + 32] <= 32 + i - wr_count + addr_pointer;
                        end
                end
            end
            {MATRIX_64X64} : begin
                for (i = 0; i < 64; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        end
                    else begin
                            wr_addr[i + 0] <= 64 + i - wr_count + addr_pointer;
                        end
                end         
            end
            default        : begin
                for (i = 0; i < 64; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_addr[i + 0] <= i - wr_count + addr_pointer;
                        end
                    else begin
                            wr_addr[i + 0] <= 64 + i - wr_count + addr_pointer;
                        end
                end
            end
        endcase

    end
end

//diagonal storage :assign write data
always @(*) begin
    for (i = 0; i < 64; i = i + 1) 
        wr_data[ i ] <= 0; 
    if (write_flag) begin
        case (wr_matrix_d1) 
            {MATRIX_4X4  } : begin
                for (i = 0; i < 1; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 4 + 0];
                            wr_data[i + 1] <= i_data[(i - wr_count) * 4 + 4];
                            wr_data[i + 2] <= i_data[(i - wr_count) * 4 + 8];
                            wr_data[i + 3] <= i_data[(i - wr_count) * 4 + 12];
                            wr_data[i + 4] <= i_data[(i - wr_count) * 4 + 16];
                            wr_data[i + 5] <= i_data[(i - wr_count) * 4 + 20];
                            wr_data[i + 6] <= i_data[(i - wr_count) * 4 + 24];
                            wr_data[i + 7] <= i_data[(i - wr_count) * 4 + 28];
                            wr_data[i + 8] <= i_data[(i - wr_count) * 4 + 32];
                            wr_data[i + 9] <= i_data[(i - wr_count) * 4 + 36];
                            wr_data[i + 10] <= i_data[(i - wr_count) * 4 + 40];
                            wr_data[i + 11] <= i_data[(i - wr_count) * 4 + 44];
                            wr_data[i + 12] <= i_data[(i - wr_count) * 4 + 48];
                            wr_data[i + 13] <= i_data[(i - wr_count) * 4 + 52];
                            wr_data[i + 14] <= i_data[(i - wr_count) * 4 + 56];
                            wr_data[i + 15] <= i_data[(i - wr_count) * 4 + 60];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 4 + 1];
                            wr_data[i + 17] <= i_data[(i - wr_count) * 4 + 5];
                            wr_data[i + 18] <= i_data[(i - wr_count) * 4 + 9];
                            wr_data[i + 19] <= i_data[(i - wr_count) * 4 + 13];
                            wr_data[i + 20] <= i_data[(i - wr_count) * 4 + 17];
                            wr_data[i + 21] <= i_data[(i - wr_count) * 4 + 21];
                            wr_data[i + 22] <= i_data[(i - wr_count) * 4 + 25];
                            wr_data[i + 23] <= i_data[(i - wr_count) * 4 + 29];
                            wr_data[i + 24] <= i_data[(i - wr_count) * 4 + 33];
                            wr_data[i + 25] <= i_data[(i - wr_count) * 4 + 37];
                            wr_data[i + 26] <= i_data[(i - wr_count) * 4 + 41];
                            wr_data[i + 27] <= i_data[(i - wr_count) * 4 + 45];
                            wr_data[i + 28] <= i_data[(i - wr_count) * 4 + 49];
                            wr_data[i + 29] <= i_data[(i - wr_count) * 4 + 53];
                            wr_data[i + 30] <= i_data[(i - wr_count) * 4 + 57];
                            wr_data[i + 31] <= i_data[(i - wr_count) * 4 + 61];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 4 + 2];
                            wr_data[i + 33] <= i_data[(i - wr_count) * 4 + 6];
                            wr_data[i + 34] <= i_data[(i - wr_count) * 4 + 10];
                            wr_data[i + 35] <= i_data[(i - wr_count) * 4 + 14];
                            wr_data[i + 36] <= i_data[(i - wr_count) * 4 + 18];
                            wr_data[i + 37] <= i_data[(i - wr_count) * 4 + 22];
                            wr_data[i + 38] <= i_data[(i - wr_count) * 4 + 26];
                            wr_data[i + 39] <= i_data[(i - wr_count) * 4 + 30];
                            wr_data[i + 40] <= i_data[(i - wr_count) * 4 + 34];
                            wr_data[i + 41] <= i_data[(i - wr_count) * 4 + 38];
                            wr_data[i + 42] <= i_data[(i - wr_count) * 4 + 42];
                            wr_data[i + 43] <= i_data[(i - wr_count) * 4 + 46];
                            wr_data[i + 44] <= i_data[(i - wr_count) * 4 + 50];
                            wr_data[i + 45] <= i_data[(i - wr_count) * 4 + 54];
                            wr_data[i + 46] <= i_data[(i - wr_count) * 4 + 58];
                            wr_data[i + 47] <= i_data[(i - wr_count) * 4 + 62];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 4 + 3];
                            wr_data[i + 49] <= i_data[(i - wr_count) * 4 + 7];
                            wr_data[i + 50] <= i_data[(i - wr_count) * 4 + 11];
                            wr_data[i + 51] <= i_data[(i - wr_count) * 4 + 15];
                            wr_data[i + 52] <= i_data[(i - wr_count) * 4 + 19];
                            wr_data[i + 53] <= i_data[(i - wr_count) * 4 + 23];
                            wr_data[i + 54] <= i_data[(i - wr_count) * 4 + 27];
                            wr_data[i + 55] <= i_data[(i - wr_count) * 4 + 31];
                            wr_data[i + 56] <= i_data[(i - wr_count) * 4 + 35];
                            wr_data[i + 57] <= i_data[(i - wr_count) * 4 + 39];
                            wr_data[i + 58] <= i_data[(i - wr_count) * 4 + 43];
                            wr_data[i + 59] <= i_data[(i - wr_count) * 4 + 47];
                            wr_data[i + 60] <= i_data[(i - wr_count) * 4 + 51];
                            wr_data[i + 61] <= i_data[(i - wr_count) * 4 + 55];
                            wr_data[i + 62] <= i_data[(i - wr_count) * 4 + 59];
                            wr_data[i + 63] <= i_data[(i - wr_count) * 4 + 63];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(1 + i - wr_count) * 4 + 0];
                            wr_data[i + 1] <= i_data[(1 + i - wr_count) * 4 + 4];
                            wr_data[i + 2] <= i_data[(1 + i - wr_count) * 4 + 8];
                            wr_data[i + 3] <= i_data[(1 + i - wr_count) * 4 + 12];
                            wr_data[i + 4] <= i_data[(1 + i - wr_count) * 4 + 16];
                            wr_data[i + 5] <= i_data[(1 + i - wr_count) * 4 + 20];
                            wr_data[i + 6] <= i_data[(1 + i - wr_count) * 4 + 24];
                            wr_data[i + 7] <= i_data[(1 + i - wr_count) * 4 + 28];
                            wr_data[i + 8] <= i_data[(1 + i - wr_count) * 4 + 32];
                            wr_data[i + 9] <= i_data[(1 + i - wr_count) * 4 + 36];
                            wr_data[i + 10] <= i_data[(1 + i - wr_count) * 4 + 40];
                            wr_data[i + 11] <= i_data[(1 + i - wr_count) * 4 + 44];
                            wr_data[i + 12] <= i_data[(1 + i - wr_count) * 4 + 48];
                            wr_data[i + 13] <= i_data[(1 + i - wr_count) * 4 + 52];
                            wr_data[i + 14] <= i_data[(1 + i - wr_count) * 4 + 56];
                            wr_data[i + 15] <= i_data[(1 + i - wr_count) * 4 + 60];
                            wr_data[i + 16] <= i_data[(1 + i - wr_count) * 4 + 1];
                            wr_data[i + 17] <= i_data[(1 + i - wr_count) * 4 + 5];
                            wr_data[i + 18] <= i_data[(1 + i - wr_count) * 4 + 9];
                            wr_data[i + 19] <= i_data[(1 + i - wr_count) * 4 + 13];
                            wr_data[i + 20] <= i_data[(1 + i - wr_count) * 4 + 17];
                            wr_data[i + 21] <= i_data[(1 + i - wr_count) * 4 + 21];
                            wr_data[i + 22] <= i_data[(1 + i - wr_count) * 4 + 25];
                            wr_data[i + 23] <= i_data[(1 + i - wr_count) * 4 + 29];
                            wr_data[i + 24] <= i_data[(1 + i - wr_count) * 4 + 33];
                            wr_data[i + 25] <= i_data[(1 + i - wr_count) * 4 + 37];
                            wr_data[i + 26] <= i_data[(1 + i - wr_count) * 4 + 41];
                            wr_data[i + 27] <= i_data[(1 + i - wr_count) * 4 + 45];
                            wr_data[i + 28] <= i_data[(1 + i - wr_count) * 4 + 49];
                            wr_data[i + 29] <= i_data[(1 + i - wr_count) * 4 + 53];
                            wr_data[i + 30] <= i_data[(1 + i - wr_count) * 4 + 57];
                            wr_data[i + 31] <= i_data[(1 + i - wr_count) * 4 + 61];
                            wr_data[i + 32] <= i_data[(1 + i - wr_count) * 4 + 2];
                            wr_data[i + 33] <= i_data[(1 + i - wr_count) * 4 + 6];
                            wr_data[i + 34] <= i_data[(1 + i - wr_count) * 4 + 10];
                            wr_data[i + 35] <= i_data[(1 + i - wr_count) * 4 + 14];
                            wr_data[i + 36] <= i_data[(1 + i - wr_count) * 4 + 18];
                            wr_data[i + 37] <= i_data[(1 + i - wr_count) * 4 + 22];
                            wr_data[i + 38] <= i_data[(1 + i - wr_count) * 4 + 26];
                            wr_data[i + 39] <= i_data[(1 + i - wr_count) * 4 + 30];
                            wr_data[i + 40] <= i_data[(1 + i - wr_count) * 4 + 34];
                            wr_data[i + 41] <= i_data[(1 + i - wr_count) * 4 + 38];
                            wr_data[i + 42] <= i_data[(1 + i - wr_count) * 4 + 42];
                            wr_data[i + 43] <= i_data[(1 + i - wr_count) * 4 + 46];
                            wr_data[i + 44] <= i_data[(1 + i - wr_count) * 4 + 50];
                            wr_data[i + 45] <= i_data[(1 + i - wr_count) * 4 + 54];
                            wr_data[i + 46] <= i_data[(1 + i - wr_count) * 4 + 58];
                            wr_data[i + 47] <= i_data[(1 + i - wr_count) * 4 + 62];
                            wr_data[i + 48] <= i_data[(1 + i - wr_count) * 4 + 3];
                            wr_data[i + 49] <= i_data[(1 + i - wr_count) * 4 + 7];
                            wr_data[i + 50] <= i_data[(1 + i - wr_count) * 4 + 11];
                            wr_data[i + 51] <= i_data[(1 + i - wr_count) * 4 + 15];
                            wr_data[i + 52] <= i_data[(1 + i - wr_count) * 4 + 19];
                            wr_data[i + 53] <= i_data[(1 + i - wr_count) * 4 + 23];
                            wr_data[i + 54] <= i_data[(1 + i - wr_count) * 4 + 27];
                            wr_data[i + 55] <= i_data[(1 + i - wr_count) * 4 + 31];
                            wr_data[i + 56] <= i_data[(1 + i - wr_count) * 4 + 35];
                            wr_data[i + 57] <= i_data[(1 + i - wr_count) * 4 + 39];
                            wr_data[i + 58] <= i_data[(1 + i - wr_count) * 4 + 43];
                            wr_data[i + 59] <= i_data[(1 + i - wr_count) * 4 + 47];
                            wr_data[i + 60] <= i_data[(1 + i - wr_count) * 4 + 51];
                            wr_data[i + 61] <= i_data[(1 + i - wr_count) * 4 + 55];
                            wr_data[i + 62] <= i_data[(1 + i - wr_count) * 4 + 59];
                            wr_data[i + 63] <= i_data[(1 + i - wr_count) * 4 + 63];
                        end
                end
            end
            {MATRIX_4X8  } : begin
                for (i = 0; i < 1; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 8 + 0];
                            wr_data[i + 1] <= i_data[(i - wr_count) * 8 + 8];
                            wr_data[i + 2] <= i_data[(i - wr_count) * 8 + 16];
                            wr_data[i + 3] <= i_data[(i - wr_count) * 8 + 24];
                            wr_data[i + 4] <= i_data[(i - wr_count) * 8 + 32];
                            wr_data[i + 5] <= i_data[(i - wr_count) * 8 + 40];
                            wr_data[i + 6] <= i_data[(i - wr_count) * 8 + 48];
                            wr_data[i + 7] <= i_data[(i - wr_count) * 8 + 56];
                            wr_data[i + 8] <= i_data[(i - wr_count) * 8 + 1];
                            wr_data[i + 9] <= i_data[(i - wr_count) * 8 + 9];
                            wr_data[i + 10] <= i_data[(i - wr_count) * 8 + 17];
                            wr_data[i + 11] <= i_data[(i - wr_count) * 8 + 25];
                            wr_data[i + 12] <= i_data[(i - wr_count) * 8 + 33];
                            wr_data[i + 13] <= i_data[(i - wr_count) * 8 + 41];
                            wr_data[i + 14] <= i_data[(i - wr_count) * 8 + 49];
                            wr_data[i + 15] <= i_data[(i - wr_count) * 8 + 57];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 8 + 2];
                            wr_data[i + 17] <= i_data[(i - wr_count) * 8 + 10];
                            wr_data[i + 18] <= i_data[(i - wr_count) * 8 + 18];
                            wr_data[i + 19] <= i_data[(i - wr_count) * 8 + 26];
                            wr_data[i + 20] <= i_data[(i - wr_count) * 8 + 34];
                            wr_data[i + 21] <= i_data[(i - wr_count) * 8 + 42];
                            wr_data[i + 22] <= i_data[(i - wr_count) * 8 + 50];
                            wr_data[i + 23] <= i_data[(i - wr_count) * 8 + 58];
                            wr_data[i + 24] <= i_data[(i - wr_count) * 8 + 3];
                            wr_data[i + 25] <= i_data[(i - wr_count) * 8 + 11];
                            wr_data[i + 26] <= i_data[(i - wr_count) * 8 + 19];
                            wr_data[i + 27] <= i_data[(i - wr_count) * 8 + 27];
                            wr_data[i + 28] <= i_data[(i - wr_count) * 8 + 35];
                            wr_data[i + 29] <= i_data[(i - wr_count) * 8 + 43];
                            wr_data[i + 30] <= i_data[(i - wr_count) * 8 + 51];
                            wr_data[i + 31] <= i_data[(i - wr_count) * 8 + 59];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 8 + 4];
                            wr_data[i + 33] <= i_data[(i - wr_count) * 8 + 12];
                            wr_data[i + 34] <= i_data[(i - wr_count) * 8 + 20];
                            wr_data[i + 35] <= i_data[(i - wr_count) * 8 + 28];
                            wr_data[i + 36] <= i_data[(i - wr_count) * 8 + 36];
                            wr_data[i + 37] <= i_data[(i - wr_count) * 8 + 44];
                            wr_data[i + 38] <= i_data[(i - wr_count) * 8 + 52];
                            wr_data[i + 39] <= i_data[(i - wr_count) * 8 + 60];
                            wr_data[i + 40] <= i_data[(i - wr_count) * 8 + 5];
                            wr_data[i + 41] <= i_data[(i - wr_count) * 8 + 13];
                            wr_data[i + 42] <= i_data[(i - wr_count) * 8 + 21];
                            wr_data[i + 43] <= i_data[(i - wr_count) * 8 + 29];
                            wr_data[i + 44] <= i_data[(i - wr_count) * 8 + 37];
                            wr_data[i + 45] <= i_data[(i - wr_count) * 8 + 45];
                            wr_data[i + 46] <= i_data[(i - wr_count) * 8 + 53];
                            wr_data[i + 47] <= i_data[(i - wr_count) * 8 + 61];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 8 + 6];
                            wr_data[i + 49] <= i_data[(i - wr_count) * 8 + 14];
                            wr_data[i + 50] <= i_data[(i - wr_count) * 8 + 22];
                            wr_data[i + 51] <= i_data[(i - wr_count) * 8 + 30];
                            wr_data[i + 52] <= i_data[(i - wr_count) * 8 + 38];
                            wr_data[i + 53] <= i_data[(i - wr_count) * 8 + 46];
                            wr_data[i + 54] <= i_data[(i - wr_count) * 8 + 54];
                            wr_data[i + 55] <= i_data[(i - wr_count) * 8 + 62];
                            wr_data[i + 56] <= i_data[(i - wr_count) * 8 + 7];
                            wr_data[i + 57] <= i_data[(i - wr_count) * 8 + 15];
                            wr_data[i + 58] <= i_data[(i - wr_count) * 8 + 23];
                            wr_data[i + 59] <= i_data[(i - wr_count) * 8 + 31];
                            wr_data[i + 60] <= i_data[(i - wr_count) * 8 + 39];
                            wr_data[i + 61] <= i_data[(i - wr_count) * 8 + 47];
                            wr_data[i + 62] <= i_data[(i - wr_count) * 8 + 55];
                            wr_data[i + 63] <= i_data[(i - wr_count) * 8 + 63];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(1 + i - wr_count) * 8 + 0];
                            wr_data[i + 1] <= i_data[(1 + i - wr_count) * 8 + 8];
                            wr_data[i + 2] <= i_data[(1 + i - wr_count) * 8 + 16];
                            wr_data[i + 3] <= i_data[(1 + i - wr_count) * 8 + 24];
                            wr_data[i + 4] <= i_data[(1 + i - wr_count) * 8 + 32];
                            wr_data[i + 5] <= i_data[(1 + i - wr_count) * 8 + 40];
                            wr_data[i + 6] <= i_data[(1 + i - wr_count) * 8 + 48];
                            wr_data[i + 7] <= i_data[(1 + i - wr_count) * 8 + 56];
                            wr_data[i + 8] <= i_data[(1 + i - wr_count) * 8 + 1];
                            wr_data[i + 9] <= i_data[(1 + i - wr_count) * 8 + 9];
                            wr_data[i + 10] <= i_data[(1 + i - wr_count) * 8 + 17];
                            wr_data[i + 11] <= i_data[(1 + i - wr_count) * 8 + 25];
                            wr_data[i + 12] <= i_data[(1 + i - wr_count) * 8 + 33];
                            wr_data[i + 13] <= i_data[(1 + i - wr_count) * 8 + 41];
                            wr_data[i + 14] <= i_data[(1 + i - wr_count) * 8 + 49];
                            wr_data[i + 15] <= i_data[(1 + i - wr_count) * 8 + 57];
                            wr_data[i + 16] <= i_data[(1 + i - wr_count) * 8 + 2];
                            wr_data[i + 17] <= i_data[(1 + i - wr_count) * 8 + 10];
                            wr_data[i + 18] <= i_data[(1 + i - wr_count) * 8 + 18];
                            wr_data[i + 19] <= i_data[(1 + i - wr_count) * 8 + 26];
                            wr_data[i + 20] <= i_data[(1 + i - wr_count) * 8 + 34];
                            wr_data[i + 21] <= i_data[(1 + i - wr_count) * 8 + 42];
                            wr_data[i + 22] <= i_data[(1 + i - wr_count) * 8 + 50];
                            wr_data[i + 23] <= i_data[(1 + i - wr_count) * 8 + 58];
                            wr_data[i + 24] <= i_data[(1 + i - wr_count) * 8 + 3];
                            wr_data[i + 25] <= i_data[(1 + i - wr_count) * 8 + 11];
                            wr_data[i + 26] <= i_data[(1 + i - wr_count) * 8 + 19];
                            wr_data[i + 27] <= i_data[(1 + i - wr_count) * 8 + 27];
                            wr_data[i + 28] <= i_data[(1 + i - wr_count) * 8 + 35];
                            wr_data[i + 29] <= i_data[(1 + i - wr_count) * 8 + 43];
                            wr_data[i + 30] <= i_data[(1 + i - wr_count) * 8 + 51];
                            wr_data[i + 31] <= i_data[(1 + i - wr_count) * 8 + 59];
                            wr_data[i + 32] <= i_data[(1 + i - wr_count) * 8 + 4];
                            wr_data[i + 33] <= i_data[(1 + i - wr_count) * 8 + 12];
                            wr_data[i + 34] <= i_data[(1 + i - wr_count) * 8 + 20];
                            wr_data[i + 35] <= i_data[(1 + i - wr_count) * 8 + 28];
                            wr_data[i + 36] <= i_data[(1 + i - wr_count) * 8 + 36];
                            wr_data[i + 37] <= i_data[(1 + i - wr_count) * 8 + 44];
                            wr_data[i + 38] <= i_data[(1 + i - wr_count) * 8 + 52];
                            wr_data[i + 39] <= i_data[(1 + i - wr_count) * 8 + 60];
                            wr_data[i + 40] <= i_data[(1 + i - wr_count) * 8 + 5];
                            wr_data[i + 41] <= i_data[(1 + i - wr_count) * 8 + 13];
                            wr_data[i + 42] <= i_data[(1 + i - wr_count) * 8 + 21];
                            wr_data[i + 43] <= i_data[(1 + i - wr_count) * 8 + 29];
                            wr_data[i + 44] <= i_data[(1 + i - wr_count) * 8 + 37];
                            wr_data[i + 45] <= i_data[(1 + i - wr_count) * 8 + 45];
                            wr_data[i + 46] <= i_data[(1 + i - wr_count) * 8 + 53];
                            wr_data[i + 47] <= i_data[(1 + i - wr_count) * 8 + 61];
                            wr_data[i + 48] <= i_data[(1 + i - wr_count) * 8 + 6];
                            wr_data[i + 49] <= i_data[(1 + i - wr_count) * 8 + 14];
                            wr_data[i + 50] <= i_data[(1 + i - wr_count) * 8 + 22];
                            wr_data[i + 51] <= i_data[(1 + i - wr_count) * 8 + 30];
                            wr_data[i + 52] <= i_data[(1 + i - wr_count) * 8 + 38];
                            wr_data[i + 53] <= i_data[(1 + i - wr_count) * 8 + 46];
                            wr_data[i + 54] <= i_data[(1 + i - wr_count) * 8 + 54];
                            wr_data[i + 55] <= i_data[(1 + i - wr_count) * 8 + 62];
                            wr_data[i + 56] <= i_data[(1 + i - wr_count) * 8 + 7];
                            wr_data[i + 57] <= i_data[(1 + i - wr_count) * 8 + 15];
                            wr_data[i + 58] <= i_data[(1 + i - wr_count) * 8 + 23];
                            wr_data[i + 59] <= i_data[(1 + i - wr_count) * 8 + 31];
                            wr_data[i + 60] <= i_data[(1 + i - wr_count) * 8 + 39];
                            wr_data[i + 61] <= i_data[(1 + i - wr_count) * 8 + 47];
                            wr_data[i + 62] <= i_data[(1 + i - wr_count) * 8 + 55];
                            wr_data[i + 63] <= i_data[(1 + i - wr_count) * 8 + 63];
                        end
                end
            end
            {MATRIX_4X16 } : begin
                for (i = 0; i < 1; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 16 + 0];
                            wr_data[i + 1] <= i_data[(i - wr_count) * 16 + 16];
                            wr_data[i + 2] <= i_data[(i - wr_count) * 16 + 32];
                            wr_data[i + 3] <= i_data[(i - wr_count) * 16 + 48];
                            wr_data[i + 4] <= i_data[(i - wr_count) * 16 + 1];
                            wr_data[i + 5] <= i_data[(i - wr_count) * 16 + 17];
                            wr_data[i + 6] <= i_data[(i - wr_count) * 16 + 33];
                            wr_data[i + 7] <= i_data[(i - wr_count) * 16 + 49];
                            wr_data[i + 8] <= i_data[(i - wr_count) * 16 + 2];
                            wr_data[i + 9] <= i_data[(i - wr_count) * 16 + 18];
                            wr_data[i + 10] <= i_data[(i - wr_count) * 16 + 34];
                            wr_data[i + 11] <= i_data[(i - wr_count) * 16 + 50];
                            wr_data[i + 12] <= i_data[(i - wr_count) * 16 + 3];
                            wr_data[i + 13] <= i_data[(i - wr_count) * 16 + 19];
                            wr_data[i + 14] <= i_data[(i - wr_count) * 16 + 35];
                            wr_data[i + 15] <= i_data[(i - wr_count) * 16 + 51];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 16 + 4];
                            wr_data[i + 17] <= i_data[(i - wr_count) * 16 + 20];
                            wr_data[i + 18] <= i_data[(i - wr_count) * 16 + 36];
                            wr_data[i + 19] <= i_data[(i - wr_count) * 16 + 52];
                            wr_data[i + 20] <= i_data[(i - wr_count) * 16 + 5];
                            wr_data[i + 21] <= i_data[(i - wr_count) * 16 + 21];
                            wr_data[i + 22] <= i_data[(i - wr_count) * 16 + 37];
                            wr_data[i + 23] <= i_data[(i - wr_count) * 16 + 53];
                            wr_data[i + 24] <= i_data[(i - wr_count) * 16 + 6];
                            wr_data[i + 25] <= i_data[(i - wr_count) * 16 + 22];
                            wr_data[i + 26] <= i_data[(i - wr_count) * 16 + 38];
                            wr_data[i + 27] <= i_data[(i - wr_count) * 16 + 54];
                            wr_data[i + 28] <= i_data[(i - wr_count) * 16 + 7];
                            wr_data[i + 29] <= i_data[(i - wr_count) * 16 + 23];
                            wr_data[i + 30] <= i_data[(i - wr_count) * 16 + 39];
                            wr_data[i + 31] <= i_data[(i - wr_count) * 16 + 55];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 16 + 8];
                            wr_data[i + 33] <= i_data[(i - wr_count) * 16 + 24];
                            wr_data[i + 34] <= i_data[(i - wr_count) * 16 + 40];
                            wr_data[i + 35] <= i_data[(i - wr_count) * 16 + 56];
                            wr_data[i + 36] <= i_data[(i - wr_count) * 16 + 9];
                            wr_data[i + 37] <= i_data[(i - wr_count) * 16 + 25];
                            wr_data[i + 38] <= i_data[(i - wr_count) * 16 + 41];
                            wr_data[i + 39] <= i_data[(i - wr_count) * 16 + 57];
                            wr_data[i + 40] <= i_data[(i - wr_count) * 16 + 10];
                            wr_data[i + 41] <= i_data[(i - wr_count) * 16 + 26];
                            wr_data[i + 42] <= i_data[(i - wr_count) * 16 + 42];
                            wr_data[i + 43] <= i_data[(i - wr_count) * 16 + 58];
                            wr_data[i + 44] <= i_data[(i - wr_count) * 16 + 11];
                            wr_data[i + 45] <= i_data[(i - wr_count) * 16 + 27];
                            wr_data[i + 46] <= i_data[(i - wr_count) * 16 + 43];
                            wr_data[i + 47] <= i_data[(i - wr_count) * 16 + 59];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 16 + 12];
                            wr_data[i + 49] <= i_data[(i - wr_count) * 16 + 28];
                            wr_data[i + 50] <= i_data[(i - wr_count) * 16 + 44];
                            wr_data[i + 51] <= i_data[(i - wr_count) * 16 + 60];
                            wr_data[i + 52] <= i_data[(i - wr_count) * 16 + 13];
                            wr_data[i + 53] <= i_data[(i - wr_count) * 16 + 29];
                            wr_data[i + 54] <= i_data[(i - wr_count) * 16 + 45];
                            wr_data[i + 55] <= i_data[(i - wr_count) * 16 + 61];
                            wr_data[i + 56] <= i_data[(i - wr_count) * 16 + 14];
                            wr_data[i + 57] <= i_data[(i - wr_count) * 16 + 30];
                            wr_data[i + 58] <= i_data[(i - wr_count) * 16 + 46];
                            wr_data[i + 59] <= i_data[(i - wr_count) * 16 + 62];
                            wr_data[i + 60] <= i_data[(i - wr_count) * 16 + 15];
                            wr_data[i + 61] <= i_data[(i - wr_count) * 16 + 31];
                            wr_data[i + 62] <= i_data[(i - wr_count) * 16 + 47];
                            wr_data[i + 63] <= i_data[(i - wr_count) * 16 + 63];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(1 + i - wr_count) * 16 + 0];
                            wr_data[i + 1] <= i_data[(1 + i - wr_count) * 16 + 16];
                            wr_data[i + 2] <= i_data[(1 + i - wr_count) * 16 + 32];
                            wr_data[i + 3] <= i_data[(1 + i - wr_count) * 16 + 48];
                            wr_data[i + 4] <= i_data[(1 + i - wr_count) * 16 + 1];
                            wr_data[i + 5] <= i_data[(1 + i - wr_count) * 16 + 17];
                            wr_data[i + 6] <= i_data[(1 + i - wr_count) * 16 + 33];
                            wr_data[i + 7] <= i_data[(1 + i - wr_count) * 16 + 49];
                            wr_data[i + 8] <= i_data[(1 + i - wr_count) * 16 + 2];
                            wr_data[i + 9] <= i_data[(1 + i - wr_count) * 16 + 18];
                            wr_data[i + 10] <= i_data[(1 + i - wr_count) * 16 + 34];
                            wr_data[i + 11] <= i_data[(1 + i - wr_count) * 16 + 50];
                            wr_data[i + 12] <= i_data[(1 + i - wr_count) * 16 + 3];
                            wr_data[i + 13] <= i_data[(1 + i - wr_count) * 16 + 19];
                            wr_data[i + 14] <= i_data[(1 + i - wr_count) * 16 + 35];
                            wr_data[i + 15] <= i_data[(1 + i - wr_count) * 16 + 51];
                            wr_data[i + 16] <= i_data[(1 + i - wr_count) * 16 + 4];
                            wr_data[i + 17] <= i_data[(1 + i - wr_count) * 16 + 20];
                            wr_data[i + 18] <= i_data[(1 + i - wr_count) * 16 + 36];
                            wr_data[i + 19] <= i_data[(1 + i - wr_count) * 16 + 52];
                            wr_data[i + 20] <= i_data[(1 + i - wr_count) * 16 + 5];
                            wr_data[i + 21] <= i_data[(1 + i - wr_count) * 16 + 21];
                            wr_data[i + 22] <= i_data[(1 + i - wr_count) * 16 + 37];
                            wr_data[i + 23] <= i_data[(1 + i - wr_count) * 16 + 53];
                            wr_data[i + 24] <= i_data[(1 + i - wr_count) * 16 + 6];
                            wr_data[i + 25] <= i_data[(1 + i - wr_count) * 16 + 22];
                            wr_data[i + 26] <= i_data[(1 + i - wr_count) * 16 + 38];
                            wr_data[i + 27] <= i_data[(1 + i - wr_count) * 16 + 54];
                            wr_data[i + 28] <= i_data[(1 + i - wr_count) * 16 + 7];
                            wr_data[i + 29] <= i_data[(1 + i - wr_count) * 16 + 23];
                            wr_data[i + 30] <= i_data[(1 + i - wr_count) * 16 + 39];
                            wr_data[i + 31] <= i_data[(1 + i - wr_count) * 16 + 55];
                            wr_data[i + 32] <= i_data[(1 + i - wr_count) * 16 + 8];
                            wr_data[i + 33] <= i_data[(1 + i - wr_count) * 16 + 24];
                            wr_data[i + 34] <= i_data[(1 + i - wr_count) * 16 + 40];
                            wr_data[i + 35] <= i_data[(1 + i - wr_count) * 16 + 56];
                            wr_data[i + 36] <= i_data[(1 + i - wr_count) * 16 + 9];
                            wr_data[i + 37] <= i_data[(1 + i - wr_count) * 16 + 25];
                            wr_data[i + 38] <= i_data[(1 + i - wr_count) * 16 + 41];
                            wr_data[i + 39] <= i_data[(1 + i - wr_count) * 16 + 57];
                            wr_data[i + 40] <= i_data[(1 + i - wr_count) * 16 + 10];
                            wr_data[i + 41] <= i_data[(1 + i - wr_count) * 16 + 26];
                            wr_data[i + 42] <= i_data[(1 + i - wr_count) * 16 + 42];
                            wr_data[i + 43] <= i_data[(1 + i - wr_count) * 16 + 58];
                            wr_data[i + 44] <= i_data[(1 + i - wr_count) * 16 + 11];
                            wr_data[i + 45] <= i_data[(1 + i - wr_count) * 16 + 27];
                            wr_data[i + 46] <= i_data[(1 + i - wr_count) * 16 + 43];
                            wr_data[i + 47] <= i_data[(1 + i - wr_count) * 16 + 59];
                            wr_data[i + 48] <= i_data[(1 + i - wr_count) * 16 + 12];
                            wr_data[i + 49] <= i_data[(1 + i - wr_count) * 16 + 28];
                            wr_data[i + 50] <= i_data[(1 + i - wr_count) * 16 + 44];
                            wr_data[i + 51] <= i_data[(1 + i - wr_count) * 16 + 60];
                            wr_data[i + 52] <= i_data[(1 + i - wr_count) * 16 + 13];
                            wr_data[i + 53] <= i_data[(1 + i - wr_count) * 16 + 29];
                            wr_data[i + 54] <= i_data[(1 + i - wr_count) * 16 + 45];
                            wr_data[i + 55] <= i_data[(1 + i - wr_count) * 16 + 61];
                            wr_data[i + 56] <= i_data[(1 + i - wr_count) * 16 + 14];
                            wr_data[i + 57] <= i_data[(1 + i - wr_count) * 16 + 30];
                            wr_data[i + 58] <= i_data[(1 + i - wr_count) * 16 + 46];
                            wr_data[i + 59] <= i_data[(1 + i - wr_count) * 16 + 62];
                            wr_data[i + 60] <= i_data[(1 + i - wr_count) * 16 + 15];
                            wr_data[i + 61] <= i_data[(1 + i - wr_count) * 16 + 31];
                            wr_data[i + 62] <= i_data[(1 + i - wr_count) * 16 + 47];
                            wr_data[i + 63] <= i_data[(1 + i - wr_count) * 16 + 63];
                        end
                end
            end
            {MATRIX_4X32 } : begin
                for (i = 0; i < 2; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 16 + 0];
                            wr_data[i + 2] <= i_data[(i - wr_count) * 16 + 32];
                            wr_data[i + 4] <= i_data[(i - wr_count) * 16 + 1];
                            wr_data[i + 6] <= i_data[(i - wr_count) * 16 + 33];
                            wr_data[i + 8] <= i_data[(i - wr_count) * 16 + 2];
                            wr_data[i + 10] <= i_data[(i - wr_count) * 16 + 34];
                            wr_data[i + 12] <= i_data[(i - wr_count) * 16 + 3];
                            wr_data[i + 14] <= i_data[(i - wr_count) * 16 + 35];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 16 + 4];
                            wr_data[i + 18] <= i_data[(i - wr_count) * 16 + 36];
                            wr_data[i + 20] <= i_data[(i - wr_count) * 16 + 5];
                            wr_data[i + 22] <= i_data[(i - wr_count) * 16 + 37];
                            wr_data[i + 24] <= i_data[(i - wr_count) * 16 + 6];
                            wr_data[i + 26] <= i_data[(i - wr_count) * 16 + 38];
                            wr_data[i + 28] <= i_data[(i - wr_count) * 16 + 7];
                            wr_data[i + 30] <= i_data[(i - wr_count) * 16 + 39];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 16 + 8];
                            wr_data[i + 34] <= i_data[(i - wr_count) * 16 + 40];
                            wr_data[i + 36] <= i_data[(i - wr_count) * 16 + 9];
                            wr_data[i + 38] <= i_data[(i - wr_count) * 16 + 41];
                            wr_data[i + 40] <= i_data[(i - wr_count) * 16 + 10];
                            wr_data[i + 42] <= i_data[(i - wr_count) * 16 + 42];
                            wr_data[i + 44] <= i_data[(i - wr_count) * 16 + 11];
                            wr_data[i + 46] <= i_data[(i - wr_count) * 16 + 43];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 16 + 12];
                            wr_data[i + 50] <= i_data[(i - wr_count) * 16 + 44];
                            wr_data[i + 52] <= i_data[(i - wr_count) * 16 + 13];
                            wr_data[i + 54] <= i_data[(i - wr_count) * 16 + 45];
                            wr_data[i + 56] <= i_data[(i - wr_count) * 16 + 14];
                            wr_data[i + 58] <= i_data[(i - wr_count) * 16 + 46];
                            wr_data[i + 60] <= i_data[(i - wr_count) * 16 + 15];
                            wr_data[i + 62] <= i_data[(i - wr_count) * 16 + 47];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(2 + i - wr_count) * 16 + 0];
                            wr_data[i + 2] <= i_data[(2 + i - wr_count) * 16 + 32];
                            wr_data[i + 4] <= i_data[(2 + i - wr_count) * 16 + 1];
                            wr_data[i + 6] <= i_data[(2 + i - wr_count) * 16 + 33];
                            wr_data[i + 8] <= i_data[(2 + i - wr_count) * 16 + 2];
                            wr_data[i + 10] <= i_data[(2 + i - wr_count) * 16 + 34];
                            wr_data[i + 12] <= i_data[(2 + i - wr_count) * 16 + 3];
                            wr_data[i + 14] <= i_data[(2 + i - wr_count) * 16 + 35];
                            wr_data[i + 16] <= i_data[(2 + i - wr_count) * 16 + 4];
                            wr_data[i + 18] <= i_data[(2 + i - wr_count) * 16 + 36];
                            wr_data[i + 20] <= i_data[(2 + i - wr_count) * 16 + 5];
                            wr_data[i + 22] <= i_data[(2 + i - wr_count) * 16 + 37];
                            wr_data[i + 24] <= i_data[(2 + i - wr_count) * 16 + 6];
                            wr_data[i + 26] <= i_data[(2 + i - wr_count) * 16 + 38];
                            wr_data[i + 28] <= i_data[(2 + i - wr_count) * 16 + 7];
                            wr_data[i + 30] <= i_data[(2 + i - wr_count) * 16 + 39];
                            wr_data[i + 32] <= i_data[(2 + i - wr_count) * 16 + 8];
                            wr_data[i + 34] <= i_data[(2 + i - wr_count) * 16 + 40];
                            wr_data[i + 36] <= i_data[(2 + i - wr_count) * 16 + 9];
                            wr_data[i + 38] <= i_data[(2 + i - wr_count) * 16 + 41];
                            wr_data[i + 40] <= i_data[(2 + i - wr_count) * 16 + 10];
                            wr_data[i + 42] <= i_data[(2 + i - wr_count) * 16 + 42];
                            wr_data[i + 44] <= i_data[(2 + i - wr_count) * 16 + 11];
                            wr_data[i + 46] <= i_data[(2 + i - wr_count) * 16 + 43];
                            wr_data[i + 48] <= i_data[(2 + i - wr_count) * 16 + 12];
                            wr_data[i + 50] <= i_data[(2 + i - wr_count) * 16 + 44];
                            wr_data[i + 52] <= i_data[(2 + i - wr_count) * 16 + 13];
                            wr_data[i + 54] <= i_data[(2 + i - wr_count) * 16 + 45];
                            wr_data[i + 56] <= i_data[(2 + i - wr_count) * 16 + 14];
                            wr_data[i + 58] <= i_data[(2 + i - wr_count) * 16 + 46];
                            wr_data[i + 60] <= i_data[(2 + i - wr_count) * 16 + 15];
                            wr_data[i + 62] <= i_data[(2 + i - wr_count) * 16 + 47];
                        end
                end
            end
            {MATRIX_4X64 } : begin
                for (i = 0; i < 4; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 16 + 0];
                            wr_data[i + 4] <= i_data[(i - wr_count) * 16 + 1];
                            wr_data[i + 8] <= i_data[(i - wr_count) * 16 + 2];
                            wr_data[i + 12] <= i_data[(i - wr_count) * 16 + 3];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 16 + 4];
                            wr_data[i + 20] <= i_data[(i - wr_count) * 16 + 5];
                            wr_data[i + 24] <= i_data[(i - wr_count) * 16 + 6];
                            wr_data[i + 28] <= i_data[(i - wr_count) * 16 + 7];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 16 + 8];
                            wr_data[i + 36] <= i_data[(i - wr_count) * 16 + 9];
                            wr_data[i + 40] <= i_data[(i - wr_count) * 16 + 10];
                            wr_data[i + 44] <= i_data[(i - wr_count) * 16 + 11];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 16 + 12];
                            wr_data[i + 52] <= i_data[(i - wr_count) * 16 + 13];
                            wr_data[i + 56] <= i_data[(i - wr_count) * 16 + 14];
                            wr_data[i + 60] <= i_data[(i - wr_count) * 16 + 15];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(4 + i - wr_count) * 16 + 0];
                            wr_data[i + 4] <= i_data[(4 + i - wr_count) * 16 + 1];
                            wr_data[i + 8] <= i_data[(4 + i - wr_count) * 16 + 2];
                            wr_data[i + 12] <= i_data[(4 + i - wr_count) * 16 + 3];
                            wr_data[i + 16] <= i_data[(4 + i - wr_count) * 16 + 4];
                            wr_data[i + 20] <= i_data[(4 + i - wr_count) * 16 + 5];
                            wr_data[i + 24] <= i_data[(4 + i - wr_count) * 16 + 6];
                            wr_data[i + 28] <= i_data[(4 + i - wr_count) * 16 + 7];
                            wr_data[i + 32] <= i_data[(4 + i - wr_count) * 16 + 8];
                            wr_data[i + 36] <= i_data[(4 + i - wr_count) * 16 + 9];
                            wr_data[i + 40] <= i_data[(4 + i - wr_count) * 16 + 10];
                            wr_data[i + 44] <= i_data[(4 + i - wr_count) * 16 + 11];
                            wr_data[i + 48] <= i_data[(4 + i - wr_count) * 16 + 12];
                            wr_data[i + 52] <= i_data[(4 + i - wr_count) * 16 + 13];
                            wr_data[i + 56] <= i_data[(4 + i - wr_count) * 16 + 14];
                            wr_data[i + 60] <= i_data[(4 + i - wr_count) * 16 + 15];
                        end
                end
            end
            {MATRIX_8X4  } : begin
                for (i = 0; i < 1; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 4 + 0];
                            wr_data[i + 1] <= i_data[(i - wr_count) * 4 + 4];
                            wr_data[i + 2] <= i_data[(i - wr_count) * 4 + 8];
                            wr_data[i + 3] <= i_data[(i - wr_count) * 4 + 12];
                            wr_data[i + 4] <= i_data[(i - wr_count) * 4 + 16];
                            wr_data[i + 5] <= i_data[(i - wr_count) * 4 + 20];
                            wr_data[i + 6] <= i_data[(i - wr_count) * 4 + 24];
                            wr_data[i + 7] <= i_data[(i - wr_count) * 4 + 28];
                            wr_data[i + 8] <= i_data[(i - wr_count) * 4 + 32];
                            wr_data[i + 9] <= i_data[(i - wr_count) * 4 + 36];
                            wr_data[i + 10] <= i_data[(i - wr_count) * 4 + 40];
                            wr_data[i + 11] <= i_data[(i - wr_count) * 4 + 44];
                            wr_data[i + 12] <= i_data[(i - wr_count) * 4 + 48];
                            wr_data[i + 13] <= i_data[(i - wr_count) * 4 + 52];
                            wr_data[i + 14] <= i_data[(i - wr_count) * 4 + 56];
                            wr_data[i + 15] <= i_data[(i - wr_count) * 4 + 60];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 4 + 1];
                            wr_data[i + 17] <= i_data[(i - wr_count) * 4 + 5];
                            wr_data[i + 18] <= i_data[(i - wr_count) * 4 + 9];
                            wr_data[i + 19] <= i_data[(i - wr_count) * 4 + 13];
                            wr_data[i + 20] <= i_data[(i - wr_count) * 4 + 17];
                            wr_data[i + 21] <= i_data[(i - wr_count) * 4 + 21];
                            wr_data[i + 22] <= i_data[(i - wr_count) * 4 + 25];
                            wr_data[i + 23] <= i_data[(i - wr_count) * 4 + 29];
                            wr_data[i + 24] <= i_data[(i - wr_count) * 4 + 33];
                            wr_data[i + 25] <= i_data[(i - wr_count) * 4 + 37];
                            wr_data[i + 26] <= i_data[(i - wr_count) * 4 + 41];
                            wr_data[i + 27] <= i_data[(i - wr_count) * 4 + 45];
                            wr_data[i + 28] <= i_data[(i - wr_count) * 4 + 49];
                            wr_data[i + 29] <= i_data[(i - wr_count) * 4 + 53];
                            wr_data[i + 30] <= i_data[(i - wr_count) * 4 + 57];
                            wr_data[i + 31] <= i_data[(i - wr_count) * 4 + 61];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 4 + 2];
                            wr_data[i + 33] <= i_data[(i - wr_count) * 4 + 6];
                            wr_data[i + 34] <= i_data[(i - wr_count) * 4 + 10];
                            wr_data[i + 35] <= i_data[(i - wr_count) * 4 + 14];
                            wr_data[i + 36] <= i_data[(i - wr_count) * 4 + 18];
                            wr_data[i + 37] <= i_data[(i - wr_count) * 4 + 22];
                            wr_data[i + 38] <= i_data[(i - wr_count) * 4 + 26];
                            wr_data[i + 39] <= i_data[(i - wr_count) * 4 + 30];
                            wr_data[i + 40] <= i_data[(i - wr_count) * 4 + 34];
                            wr_data[i + 41] <= i_data[(i - wr_count) * 4 + 38];
                            wr_data[i + 42] <= i_data[(i - wr_count) * 4 + 42];
                            wr_data[i + 43] <= i_data[(i - wr_count) * 4 + 46];
                            wr_data[i + 44] <= i_data[(i - wr_count) * 4 + 50];
                            wr_data[i + 45] <= i_data[(i - wr_count) * 4 + 54];
                            wr_data[i + 46] <= i_data[(i - wr_count) * 4 + 58];
                            wr_data[i + 47] <= i_data[(i - wr_count) * 4 + 62];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 4 + 3];
                            wr_data[i + 49] <= i_data[(i - wr_count) * 4 + 7];
                            wr_data[i + 50] <= i_data[(i - wr_count) * 4 + 11];
                            wr_data[i + 51] <= i_data[(i - wr_count) * 4 + 15];
                            wr_data[i + 52] <= i_data[(i - wr_count) * 4 + 19];
                            wr_data[i + 53] <= i_data[(i - wr_count) * 4 + 23];
                            wr_data[i + 54] <= i_data[(i - wr_count) * 4 + 27];
                            wr_data[i + 55] <= i_data[(i - wr_count) * 4 + 31];
                            wr_data[i + 56] <= i_data[(i - wr_count) * 4 + 35];
                            wr_data[i + 57] <= i_data[(i - wr_count) * 4 + 39];
                            wr_data[i + 58] <= i_data[(i - wr_count) * 4 + 43];
                            wr_data[i + 59] <= i_data[(i - wr_count) * 4 + 47];
                            wr_data[i + 60] <= i_data[(i - wr_count) * 4 + 51];
                            wr_data[i + 61] <= i_data[(i - wr_count) * 4 + 55];
                            wr_data[i + 62] <= i_data[(i - wr_count) * 4 + 59];
                            wr_data[i + 63] <= i_data[(i - wr_count) * 4 + 63];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(1 + i - wr_count) * 4 + 0];
                            wr_data[i + 1] <= i_data[(1 + i - wr_count) * 4 + 4];
                            wr_data[i + 2] <= i_data[(1 + i - wr_count) * 4 + 8];
                            wr_data[i + 3] <= i_data[(1 + i - wr_count) * 4 + 12];
                            wr_data[i + 4] <= i_data[(1 + i - wr_count) * 4 + 16];
                            wr_data[i + 5] <= i_data[(1 + i - wr_count) * 4 + 20];
                            wr_data[i + 6] <= i_data[(1 + i - wr_count) * 4 + 24];
                            wr_data[i + 7] <= i_data[(1 + i - wr_count) * 4 + 28];
                            wr_data[i + 8] <= i_data[(1 + i - wr_count) * 4 + 32];
                            wr_data[i + 9] <= i_data[(1 + i - wr_count) * 4 + 36];
                            wr_data[i + 10] <= i_data[(1 + i - wr_count) * 4 + 40];
                            wr_data[i + 11] <= i_data[(1 + i - wr_count) * 4 + 44];
                            wr_data[i + 12] <= i_data[(1 + i - wr_count) * 4 + 48];
                            wr_data[i + 13] <= i_data[(1 + i - wr_count) * 4 + 52];
                            wr_data[i + 14] <= i_data[(1 + i - wr_count) * 4 + 56];
                            wr_data[i + 15] <= i_data[(1 + i - wr_count) * 4 + 60];
                            wr_data[i + 16] <= i_data[(1 + i - wr_count) * 4 + 1];
                            wr_data[i + 17] <= i_data[(1 + i - wr_count) * 4 + 5];
                            wr_data[i + 18] <= i_data[(1 + i - wr_count) * 4 + 9];
                            wr_data[i + 19] <= i_data[(1 + i - wr_count) * 4 + 13];
                            wr_data[i + 20] <= i_data[(1 + i - wr_count) * 4 + 17];
                            wr_data[i + 21] <= i_data[(1 + i - wr_count) * 4 + 21];
                            wr_data[i + 22] <= i_data[(1 + i - wr_count) * 4 + 25];
                            wr_data[i + 23] <= i_data[(1 + i - wr_count) * 4 + 29];
                            wr_data[i + 24] <= i_data[(1 + i - wr_count) * 4 + 33];
                            wr_data[i + 25] <= i_data[(1 + i - wr_count) * 4 + 37];
                            wr_data[i + 26] <= i_data[(1 + i - wr_count) * 4 + 41];
                            wr_data[i + 27] <= i_data[(1 + i - wr_count) * 4 + 45];
                            wr_data[i + 28] <= i_data[(1 + i - wr_count) * 4 + 49];
                            wr_data[i + 29] <= i_data[(1 + i - wr_count) * 4 + 53];
                            wr_data[i + 30] <= i_data[(1 + i - wr_count) * 4 + 57];
                            wr_data[i + 31] <= i_data[(1 + i - wr_count) * 4 + 61];
                            wr_data[i + 32] <= i_data[(1 + i - wr_count) * 4 + 2];
                            wr_data[i + 33] <= i_data[(1 + i - wr_count) * 4 + 6];
                            wr_data[i + 34] <= i_data[(1 + i - wr_count) * 4 + 10];
                            wr_data[i + 35] <= i_data[(1 + i - wr_count) * 4 + 14];
                            wr_data[i + 36] <= i_data[(1 + i - wr_count) * 4 + 18];
                            wr_data[i + 37] <= i_data[(1 + i - wr_count) * 4 + 22];
                            wr_data[i + 38] <= i_data[(1 + i - wr_count) * 4 + 26];
                            wr_data[i + 39] <= i_data[(1 + i - wr_count) * 4 + 30];
                            wr_data[i + 40] <= i_data[(1 + i - wr_count) * 4 + 34];
                            wr_data[i + 41] <= i_data[(1 + i - wr_count) * 4 + 38];
                            wr_data[i + 42] <= i_data[(1 + i - wr_count) * 4 + 42];
                            wr_data[i + 43] <= i_data[(1 + i - wr_count) * 4 + 46];
                            wr_data[i + 44] <= i_data[(1 + i - wr_count) * 4 + 50];
                            wr_data[i + 45] <= i_data[(1 + i - wr_count) * 4 + 54];
                            wr_data[i + 46] <= i_data[(1 + i - wr_count) * 4 + 58];
                            wr_data[i + 47] <= i_data[(1 + i - wr_count) * 4 + 62];
                            wr_data[i + 48] <= i_data[(1 + i - wr_count) * 4 + 3];
                            wr_data[i + 49] <= i_data[(1 + i - wr_count) * 4 + 7];
                            wr_data[i + 50] <= i_data[(1 + i - wr_count) * 4 + 11];
                            wr_data[i + 51] <= i_data[(1 + i - wr_count) * 4 + 15];
                            wr_data[i + 52] <= i_data[(1 + i - wr_count) * 4 + 19];
                            wr_data[i + 53] <= i_data[(1 + i - wr_count) * 4 + 23];
                            wr_data[i + 54] <= i_data[(1 + i - wr_count) * 4 + 27];
                            wr_data[i + 55] <= i_data[(1 + i - wr_count) * 4 + 31];
                            wr_data[i + 56] <= i_data[(1 + i - wr_count) * 4 + 35];
                            wr_data[i + 57] <= i_data[(1 + i - wr_count) * 4 + 39];
                            wr_data[i + 58] <= i_data[(1 + i - wr_count) * 4 + 43];
                            wr_data[i + 59] <= i_data[(1 + i - wr_count) * 4 + 47];
                            wr_data[i + 60] <= i_data[(1 + i - wr_count) * 4 + 51];
                            wr_data[i + 61] <= i_data[(1 + i - wr_count) * 4 + 55];
                            wr_data[i + 62] <= i_data[(1 + i - wr_count) * 4 + 59];
                            wr_data[i + 63] <= i_data[(1 + i - wr_count) * 4 + 63];
                        end
                end
            end
            {MATRIX_8X8  } : begin
                for (i = 0; i < 1; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 8 + 0];
                            wr_data[i + 1] <= i_data[(i - wr_count) * 8 + 8];
                            wr_data[i + 2] <= i_data[(i - wr_count) * 8 + 16];
                            wr_data[i + 3] <= i_data[(i - wr_count) * 8 + 24];
                            wr_data[i + 4] <= i_data[(i - wr_count) * 8 + 32];
                            wr_data[i + 5] <= i_data[(i - wr_count) * 8 + 40];
                            wr_data[i + 6] <= i_data[(i - wr_count) * 8 + 48];
                            wr_data[i + 7] <= i_data[(i - wr_count) * 8 + 56];
                            wr_data[i + 8] <= i_data[(i - wr_count) * 8 + 1];
                            wr_data[i + 9] <= i_data[(i - wr_count) * 8 + 9];
                            wr_data[i + 10] <= i_data[(i - wr_count) * 8 + 17];
                            wr_data[i + 11] <= i_data[(i - wr_count) * 8 + 25];
                            wr_data[i + 12] <= i_data[(i - wr_count) * 8 + 33];
                            wr_data[i + 13] <= i_data[(i - wr_count) * 8 + 41];
                            wr_data[i + 14] <= i_data[(i - wr_count) * 8 + 49];
                            wr_data[i + 15] <= i_data[(i - wr_count) * 8 + 57];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 8 + 2];
                            wr_data[i + 17] <= i_data[(i - wr_count) * 8 + 10];
                            wr_data[i + 18] <= i_data[(i - wr_count) * 8 + 18];
                            wr_data[i + 19] <= i_data[(i - wr_count) * 8 + 26];
                            wr_data[i + 20] <= i_data[(i - wr_count) * 8 + 34];
                            wr_data[i + 21] <= i_data[(i - wr_count) * 8 + 42];
                            wr_data[i + 22] <= i_data[(i - wr_count) * 8 + 50];
                            wr_data[i + 23] <= i_data[(i - wr_count) * 8 + 58];
                            wr_data[i + 24] <= i_data[(i - wr_count) * 8 + 3];
                            wr_data[i + 25] <= i_data[(i - wr_count) * 8 + 11];
                            wr_data[i + 26] <= i_data[(i - wr_count) * 8 + 19];
                            wr_data[i + 27] <= i_data[(i - wr_count) * 8 + 27];
                            wr_data[i + 28] <= i_data[(i - wr_count) * 8 + 35];
                            wr_data[i + 29] <= i_data[(i - wr_count) * 8 + 43];
                            wr_data[i + 30] <= i_data[(i - wr_count) * 8 + 51];
                            wr_data[i + 31] <= i_data[(i - wr_count) * 8 + 59];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 8 + 4];
                            wr_data[i + 33] <= i_data[(i - wr_count) * 8 + 12];
                            wr_data[i + 34] <= i_data[(i - wr_count) * 8 + 20];
                            wr_data[i + 35] <= i_data[(i - wr_count) * 8 + 28];
                            wr_data[i + 36] <= i_data[(i - wr_count) * 8 + 36];
                            wr_data[i + 37] <= i_data[(i - wr_count) * 8 + 44];
                            wr_data[i + 38] <= i_data[(i - wr_count) * 8 + 52];
                            wr_data[i + 39] <= i_data[(i - wr_count) * 8 + 60];
                            wr_data[i + 40] <= i_data[(i - wr_count) * 8 + 5];
                            wr_data[i + 41] <= i_data[(i - wr_count) * 8 + 13];
                            wr_data[i + 42] <= i_data[(i - wr_count) * 8 + 21];
                            wr_data[i + 43] <= i_data[(i - wr_count) * 8 + 29];
                            wr_data[i + 44] <= i_data[(i - wr_count) * 8 + 37];
                            wr_data[i + 45] <= i_data[(i - wr_count) * 8 + 45];
                            wr_data[i + 46] <= i_data[(i - wr_count) * 8 + 53];
                            wr_data[i + 47] <= i_data[(i - wr_count) * 8 + 61];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 8 + 6];
                            wr_data[i + 49] <= i_data[(i - wr_count) * 8 + 14];
                            wr_data[i + 50] <= i_data[(i - wr_count) * 8 + 22];
                            wr_data[i + 51] <= i_data[(i - wr_count) * 8 + 30];
                            wr_data[i + 52] <= i_data[(i - wr_count) * 8 + 38];
                            wr_data[i + 53] <= i_data[(i - wr_count) * 8 + 46];
                            wr_data[i + 54] <= i_data[(i - wr_count) * 8 + 54];
                            wr_data[i + 55] <= i_data[(i - wr_count) * 8 + 62];
                            wr_data[i + 56] <= i_data[(i - wr_count) * 8 + 7];
                            wr_data[i + 57] <= i_data[(i - wr_count) * 8 + 15];
                            wr_data[i + 58] <= i_data[(i - wr_count) * 8 + 23];
                            wr_data[i + 59] <= i_data[(i - wr_count) * 8 + 31];
                            wr_data[i + 60] <= i_data[(i - wr_count) * 8 + 39];
                            wr_data[i + 61] <= i_data[(i - wr_count) * 8 + 47];
                            wr_data[i + 62] <= i_data[(i - wr_count) * 8 + 55];
                            wr_data[i + 63] <= i_data[(i - wr_count) * 8 + 63];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(1 + i - wr_count) * 8 + 0];
                            wr_data[i + 1] <= i_data[(1 + i - wr_count) * 8 + 8];
                            wr_data[i + 2] <= i_data[(1 + i - wr_count) * 8 + 16];
                            wr_data[i + 3] <= i_data[(1 + i - wr_count) * 8 + 24];
                            wr_data[i + 4] <= i_data[(1 + i - wr_count) * 8 + 32];
                            wr_data[i + 5] <= i_data[(1 + i - wr_count) * 8 + 40];
                            wr_data[i + 6] <= i_data[(1 + i - wr_count) * 8 + 48];
                            wr_data[i + 7] <= i_data[(1 + i - wr_count) * 8 + 56];
                            wr_data[i + 8] <= i_data[(1 + i - wr_count) * 8 + 1];
                            wr_data[i + 9] <= i_data[(1 + i - wr_count) * 8 + 9];
                            wr_data[i + 10] <= i_data[(1 + i - wr_count) * 8 + 17];
                            wr_data[i + 11] <= i_data[(1 + i - wr_count) * 8 + 25];
                            wr_data[i + 12] <= i_data[(1 + i - wr_count) * 8 + 33];
                            wr_data[i + 13] <= i_data[(1 + i - wr_count) * 8 + 41];
                            wr_data[i + 14] <= i_data[(1 + i - wr_count) * 8 + 49];
                            wr_data[i + 15] <= i_data[(1 + i - wr_count) * 8 + 57];
                            wr_data[i + 16] <= i_data[(1 + i - wr_count) * 8 + 2];
                            wr_data[i + 17] <= i_data[(1 + i - wr_count) * 8 + 10];
                            wr_data[i + 18] <= i_data[(1 + i - wr_count) * 8 + 18];
                            wr_data[i + 19] <= i_data[(1 + i - wr_count) * 8 + 26];
                            wr_data[i + 20] <= i_data[(1 + i - wr_count) * 8 + 34];
                            wr_data[i + 21] <= i_data[(1 + i - wr_count) * 8 + 42];
                            wr_data[i + 22] <= i_data[(1 + i - wr_count) * 8 + 50];
                            wr_data[i + 23] <= i_data[(1 + i - wr_count) * 8 + 58];
                            wr_data[i + 24] <= i_data[(1 + i - wr_count) * 8 + 3];
                            wr_data[i + 25] <= i_data[(1 + i - wr_count) * 8 + 11];
                            wr_data[i + 26] <= i_data[(1 + i - wr_count) * 8 + 19];
                            wr_data[i + 27] <= i_data[(1 + i - wr_count) * 8 + 27];
                            wr_data[i + 28] <= i_data[(1 + i - wr_count) * 8 + 35];
                            wr_data[i + 29] <= i_data[(1 + i - wr_count) * 8 + 43];
                            wr_data[i + 30] <= i_data[(1 + i - wr_count) * 8 + 51];
                            wr_data[i + 31] <= i_data[(1 + i - wr_count) * 8 + 59];
                            wr_data[i + 32] <= i_data[(1 + i - wr_count) * 8 + 4];
                            wr_data[i + 33] <= i_data[(1 + i - wr_count) * 8 + 12];
                            wr_data[i + 34] <= i_data[(1 + i - wr_count) * 8 + 20];
                            wr_data[i + 35] <= i_data[(1 + i - wr_count) * 8 + 28];
                            wr_data[i + 36] <= i_data[(1 + i - wr_count) * 8 + 36];
                            wr_data[i + 37] <= i_data[(1 + i - wr_count) * 8 + 44];
                            wr_data[i + 38] <= i_data[(1 + i - wr_count) * 8 + 52];
                            wr_data[i + 39] <= i_data[(1 + i - wr_count) * 8 + 60];
                            wr_data[i + 40] <= i_data[(1 + i - wr_count) * 8 + 5];
                            wr_data[i + 41] <= i_data[(1 + i - wr_count) * 8 + 13];
                            wr_data[i + 42] <= i_data[(1 + i - wr_count) * 8 + 21];
                            wr_data[i + 43] <= i_data[(1 + i - wr_count) * 8 + 29];
                            wr_data[i + 44] <= i_data[(1 + i - wr_count) * 8 + 37];
                            wr_data[i + 45] <= i_data[(1 + i - wr_count) * 8 + 45];
                            wr_data[i + 46] <= i_data[(1 + i - wr_count) * 8 + 53];
                            wr_data[i + 47] <= i_data[(1 + i - wr_count) * 8 + 61];
                            wr_data[i + 48] <= i_data[(1 + i - wr_count) * 8 + 6];
                            wr_data[i + 49] <= i_data[(1 + i - wr_count) * 8 + 14];
                            wr_data[i + 50] <= i_data[(1 + i - wr_count) * 8 + 22];
                            wr_data[i + 51] <= i_data[(1 + i - wr_count) * 8 + 30];
                            wr_data[i + 52] <= i_data[(1 + i - wr_count) * 8 + 38];
                            wr_data[i + 53] <= i_data[(1 + i - wr_count) * 8 + 46];
                            wr_data[i + 54] <= i_data[(1 + i - wr_count) * 8 + 54];
                            wr_data[i + 55] <= i_data[(1 + i - wr_count) * 8 + 62];
                            wr_data[i + 56] <= i_data[(1 + i - wr_count) * 8 + 7];
                            wr_data[i + 57] <= i_data[(1 + i - wr_count) * 8 + 15];
                            wr_data[i + 58] <= i_data[(1 + i - wr_count) * 8 + 23];
                            wr_data[i + 59] <= i_data[(1 + i - wr_count) * 8 + 31];
                            wr_data[i + 60] <= i_data[(1 + i - wr_count) * 8 + 39];
                            wr_data[i + 61] <= i_data[(1 + i - wr_count) * 8 + 47];
                            wr_data[i + 62] <= i_data[(1 + i - wr_count) * 8 + 55];
                            wr_data[i + 63] <= i_data[(1 + i - wr_count) * 8 + 63];
                        end
                end
            end
            {MATRIX_8X16 } : begin
                for (i = 0; i < 2; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 8 + 0];
                            wr_data[i + 2] <= i_data[(i - wr_count) * 8 + 16];
                            wr_data[i + 4] <= i_data[(i - wr_count) * 8 + 32];
                            wr_data[i + 6] <= i_data[(i - wr_count) * 8 + 48];
                            wr_data[i + 8] <= i_data[(i - wr_count) * 8 + 1];
                            wr_data[i + 10] <= i_data[(i - wr_count) * 8 + 17];
                            wr_data[i + 12] <= i_data[(i - wr_count) * 8 + 33];
                            wr_data[i + 14] <= i_data[(i - wr_count) * 8 + 49];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 8 + 2];
                            wr_data[i + 18] <= i_data[(i - wr_count) * 8 + 18];
                            wr_data[i + 20] <= i_data[(i - wr_count) * 8 + 34];
                            wr_data[i + 22] <= i_data[(i - wr_count) * 8 + 50];
                            wr_data[i + 24] <= i_data[(i - wr_count) * 8 + 3];
                            wr_data[i + 26] <= i_data[(i - wr_count) * 8 + 19];
                            wr_data[i + 28] <= i_data[(i - wr_count) * 8 + 35];
                            wr_data[i + 30] <= i_data[(i - wr_count) * 8 + 51];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 8 + 4];
                            wr_data[i + 34] <= i_data[(i - wr_count) * 8 + 20];
                            wr_data[i + 36] <= i_data[(i - wr_count) * 8 + 36];
                            wr_data[i + 38] <= i_data[(i - wr_count) * 8 + 52];
                            wr_data[i + 40] <= i_data[(i - wr_count) * 8 + 5];
                            wr_data[i + 42] <= i_data[(i - wr_count) * 8 + 21];
                            wr_data[i + 44] <= i_data[(i - wr_count) * 8 + 37];
                            wr_data[i + 46] <= i_data[(i - wr_count) * 8 + 53];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 8 + 6];
                            wr_data[i + 50] <= i_data[(i - wr_count) * 8 + 22];
                            wr_data[i + 52] <= i_data[(i - wr_count) * 8 + 38];
                            wr_data[i + 54] <= i_data[(i - wr_count) * 8 + 54];
                            wr_data[i + 56] <= i_data[(i - wr_count) * 8 + 7];
                            wr_data[i + 58] <= i_data[(i - wr_count) * 8 + 23];
                            wr_data[i + 60] <= i_data[(i - wr_count) * 8 + 39];
                            wr_data[i + 62] <= i_data[(i - wr_count) * 8 + 55];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(2 + i - wr_count) * 8 + 0];
                            wr_data[i + 2] <= i_data[(2 + i - wr_count) * 8 + 16];
                            wr_data[i + 4] <= i_data[(2 + i - wr_count) * 8 + 32];
                            wr_data[i + 6] <= i_data[(2 + i - wr_count) * 8 + 48];
                            wr_data[i + 8] <= i_data[(2 + i - wr_count) * 8 + 1];
                            wr_data[i + 10] <= i_data[(2 + i - wr_count) * 8 + 17];
                            wr_data[i + 12] <= i_data[(2 + i - wr_count) * 8 + 33];
                            wr_data[i + 14] <= i_data[(2 + i - wr_count) * 8 + 49];
                            wr_data[i + 16] <= i_data[(2 + i - wr_count) * 8 + 2];
                            wr_data[i + 18] <= i_data[(2 + i - wr_count) * 8 + 18];
                            wr_data[i + 20] <= i_data[(2 + i - wr_count) * 8 + 34];
                            wr_data[i + 22] <= i_data[(2 + i - wr_count) * 8 + 50];
                            wr_data[i + 24] <= i_data[(2 + i - wr_count) * 8 + 3];
                            wr_data[i + 26] <= i_data[(2 + i - wr_count) * 8 + 19];
                            wr_data[i + 28] <= i_data[(2 + i - wr_count) * 8 + 35];
                            wr_data[i + 30] <= i_data[(2 + i - wr_count) * 8 + 51];
                            wr_data[i + 32] <= i_data[(2 + i - wr_count) * 8 + 4];
                            wr_data[i + 34] <= i_data[(2 + i - wr_count) * 8 + 20];
                            wr_data[i + 36] <= i_data[(2 + i - wr_count) * 8 + 36];
                            wr_data[i + 38] <= i_data[(2 + i - wr_count) * 8 + 52];
                            wr_data[i + 40] <= i_data[(2 + i - wr_count) * 8 + 5];
                            wr_data[i + 42] <= i_data[(2 + i - wr_count) * 8 + 21];
                            wr_data[i + 44] <= i_data[(2 + i - wr_count) * 8 + 37];
                            wr_data[i + 46] <= i_data[(2 + i - wr_count) * 8 + 53];
                            wr_data[i + 48] <= i_data[(2 + i - wr_count) * 8 + 6];
                            wr_data[i + 50] <= i_data[(2 + i - wr_count) * 8 + 22];
                            wr_data[i + 52] <= i_data[(2 + i - wr_count) * 8 + 38];
                            wr_data[i + 54] <= i_data[(2 + i - wr_count) * 8 + 54];
                            wr_data[i + 56] <= i_data[(2 + i - wr_count) * 8 + 7];
                            wr_data[i + 58] <= i_data[(2 + i - wr_count) * 8 + 23];
                            wr_data[i + 60] <= i_data[(2 + i - wr_count) * 8 + 39];
                            wr_data[i + 62] <= i_data[(2 + i - wr_count) * 8 + 55];
                        end
                end
            end
            {MATRIX_8X32 } : begin
                for (i = 0; i < 4; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 8 + 0];
                            wr_data[i + 4] <= i_data[(i - wr_count) * 8 + 32];
                            wr_data[i + 8] <= i_data[(i - wr_count) * 8 + 1];
                            wr_data[i + 12] <= i_data[(i - wr_count) * 8 + 33];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 8 + 2];
                            wr_data[i + 20] <= i_data[(i - wr_count) * 8 + 34];
                            wr_data[i + 24] <= i_data[(i - wr_count) * 8 + 3];
                            wr_data[i + 28] <= i_data[(i - wr_count) * 8 + 35];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 8 + 4];
                            wr_data[i + 36] <= i_data[(i - wr_count) * 8 + 36];
                            wr_data[i + 40] <= i_data[(i - wr_count) * 8 + 5];
                            wr_data[i + 44] <= i_data[(i - wr_count) * 8 + 37];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 8 + 6];
                            wr_data[i + 52] <= i_data[(i - wr_count) * 8 + 38];
                            wr_data[i + 56] <= i_data[(i - wr_count) * 8 + 7];
                            wr_data[i + 60] <= i_data[(i - wr_count) * 8 + 39];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(4 + i - wr_count) * 8 + 0];
                            wr_data[i + 4] <= i_data[(4 + i - wr_count) * 8 + 32];
                            wr_data[i + 8] <= i_data[(4 + i - wr_count) * 8 + 1];
                            wr_data[i + 12] <= i_data[(4 + i - wr_count) * 8 + 33];
                            wr_data[i + 16] <= i_data[(4 + i - wr_count) * 8 + 2];
                            wr_data[i + 20] <= i_data[(4 + i - wr_count) * 8 + 34];
                            wr_data[i + 24] <= i_data[(4 + i - wr_count) * 8 + 3];
                            wr_data[i + 28] <= i_data[(4 + i - wr_count) * 8 + 35];
                            wr_data[i + 32] <= i_data[(4 + i - wr_count) * 8 + 4];
                            wr_data[i + 36] <= i_data[(4 + i - wr_count) * 8 + 36];
                            wr_data[i + 40] <= i_data[(4 + i - wr_count) * 8 + 5];
                            wr_data[i + 44] <= i_data[(4 + i - wr_count) * 8 + 37];
                            wr_data[i + 48] <= i_data[(4 + i - wr_count) * 8 + 6];
                            wr_data[i + 52] <= i_data[(4 + i - wr_count) * 8 + 38];
                            wr_data[i + 56] <= i_data[(4 + i - wr_count) * 8 + 7];
                            wr_data[i + 60] <= i_data[(4 + i - wr_count) * 8 + 39];
                        end
                end
            end
            {MATRIX_8X64 } : begin
                for (i = 0; i < 8; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 8 + 0];
                            wr_data[i + 8] <= i_data[(i - wr_count) * 8 + 1];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 8 + 2];
                            wr_data[i + 24] <= i_data[(i - wr_count) * 8 + 3];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 8 + 4];
                            wr_data[i + 40] <= i_data[(i - wr_count) * 8 + 5];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 8 + 6];
                            wr_data[i + 56] <= i_data[(i - wr_count) * 8 + 7];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(8 + i - wr_count) * 8 + 0];
                            wr_data[i + 8] <= i_data[(8 + i - wr_count) * 8 + 1];
                            wr_data[i + 16] <= i_data[(8 + i - wr_count) * 8 + 2];
                            wr_data[i + 24] <= i_data[(8 + i - wr_count) * 8 + 3];
                            wr_data[i + 32] <= i_data[(8 + i - wr_count) * 8 + 4];
                            wr_data[i + 40] <= i_data[(8 + i - wr_count) * 8 + 5];
                            wr_data[i + 48] <= i_data[(8 + i - wr_count) * 8 + 6];
                            wr_data[i + 56] <= i_data[(8 + i - wr_count) * 8 + 7];
                        end
                end
            end
            {MATRIX_16X4 } : begin
                for (i = 0; i < 1; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 4 + 0];
                            wr_data[i + 1] <= i_data[(i - wr_count) * 4 + 4];
                            wr_data[i + 2] <= i_data[(i - wr_count) * 4 + 8];
                            wr_data[i + 3] <= i_data[(i - wr_count) * 4 + 12];
                            wr_data[i + 4] <= i_data[(i - wr_count) * 4 + 16];
                            wr_data[i + 5] <= i_data[(i - wr_count) * 4 + 20];
                            wr_data[i + 6] <= i_data[(i - wr_count) * 4 + 24];
                            wr_data[i + 7] <= i_data[(i - wr_count) * 4 + 28];
                            wr_data[i + 8] <= i_data[(i - wr_count) * 4 + 32];
                            wr_data[i + 9] <= i_data[(i - wr_count) * 4 + 36];
                            wr_data[i + 10] <= i_data[(i - wr_count) * 4 + 40];
                            wr_data[i + 11] <= i_data[(i - wr_count) * 4 + 44];
                            wr_data[i + 12] <= i_data[(i - wr_count) * 4 + 48];
                            wr_data[i + 13] <= i_data[(i - wr_count) * 4 + 52];
                            wr_data[i + 14] <= i_data[(i - wr_count) * 4 + 56];
                            wr_data[i + 15] <= i_data[(i - wr_count) * 4 + 60];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 4 + 1];
                            wr_data[i + 17] <= i_data[(i - wr_count) * 4 + 5];
                            wr_data[i + 18] <= i_data[(i - wr_count) * 4 + 9];
                            wr_data[i + 19] <= i_data[(i - wr_count) * 4 + 13];
                            wr_data[i + 20] <= i_data[(i - wr_count) * 4 + 17];
                            wr_data[i + 21] <= i_data[(i - wr_count) * 4 + 21];
                            wr_data[i + 22] <= i_data[(i - wr_count) * 4 + 25];
                            wr_data[i + 23] <= i_data[(i - wr_count) * 4 + 29];
                            wr_data[i + 24] <= i_data[(i - wr_count) * 4 + 33];
                            wr_data[i + 25] <= i_data[(i - wr_count) * 4 + 37];
                            wr_data[i + 26] <= i_data[(i - wr_count) * 4 + 41];
                            wr_data[i + 27] <= i_data[(i - wr_count) * 4 + 45];
                            wr_data[i + 28] <= i_data[(i - wr_count) * 4 + 49];
                            wr_data[i + 29] <= i_data[(i - wr_count) * 4 + 53];
                            wr_data[i + 30] <= i_data[(i - wr_count) * 4 + 57];
                            wr_data[i + 31] <= i_data[(i - wr_count) * 4 + 61];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 4 + 2];
                            wr_data[i + 33] <= i_data[(i - wr_count) * 4 + 6];
                            wr_data[i + 34] <= i_data[(i - wr_count) * 4 + 10];
                            wr_data[i + 35] <= i_data[(i - wr_count) * 4 + 14];
                            wr_data[i + 36] <= i_data[(i - wr_count) * 4 + 18];
                            wr_data[i + 37] <= i_data[(i - wr_count) * 4 + 22];
                            wr_data[i + 38] <= i_data[(i - wr_count) * 4 + 26];
                            wr_data[i + 39] <= i_data[(i - wr_count) * 4 + 30];
                            wr_data[i + 40] <= i_data[(i - wr_count) * 4 + 34];
                            wr_data[i + 41] <= i_data[(i - wr_count) * 4 + 38];
                            wr_data[i + 42] <= i_data[(i - wr_count) * 4 + 42];
                            wr_data[i + 43] <= i_data[(i - wr_count) * 4 + 46];
                            wr_data[i + 44] <= i_data[(i - wr_count) * 4 + 50];
                            wr_data[i + 45] <= i_data[(i - wr_count) * 4 + 54];
                            wr_data[i + 46] <= i_data[(i - wr_count) * 4 + 58];
                            wr_data[i + 47] <= i_data[(i - wr_count) * 4 + 62];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 4 + 3];
                            wr_data[i + 49] <= i_data[(i - wr_count) * 4 + 7];
                            wr_data[i + 50] <= i_data[(i - wr_count) * 4 + 11];
                            wr_data[i + 51] <= i_data[(i - wr_count) * 4 + 15];
                            wr_data[i + 52] <= i_data[(i - wr_count) * 4 + 19];
                            wr_data[i + 53] <= i_data[(i - wr_count) * 4 + 23];
                            wr_data[i + 54] <= i_data[(i - wr_count) * 4 + 27];
                            wr_data[i + 55] <= i_data[(i - wr_count) * 4 + 31];
                            wr_data[i + 56] <= i_data[(i - wr_count) * 4 + 35];
                            wr_data[i + 57] <= i_data[(i - wr_count) * 4 + 39];
                            wr_data[i + 58] <= i_data[(i - wr_count) * 4 + 43];
                            wr_data[i + 59] <= i_data[(i - wr_count) * 4 + 47];
                            wr_data[i + 60] <= i_data[(i - wr_count) * 4 + 51];
                            wr_data[i + 61] <= i_data[(i - wr_count) * 4 + 55];
                            wr_data[i + 62] <= i_data[(i - wr_count) * 4 + 59];
                            wr_data[i + 63] <= i_data[(i - wr_count) * 4 + 63];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(1 + i - wr_count) * 4 + 0];
                            wr_data[i + 1] <= i_data[(1 + i - wr_count) * 4 + 4];
                            wr_data[i + 2] <= i_data[(1 + i - wr_count) * 4 + 8];
                            wr_data[i + 3] <= i_data[(1 + i - wr_count) * 4 + 12];
                            wr_data[i + 4] <= i_data[(1 + i - wr_count) * 4 + 16];
                            wr_data[i + 5] <= i_data[(1 + i - wr_count) * 4 + 20];
                            wr_data[i + 6] <= i_data[(1 + i - wr_count) * 4 + 24];
                            wr_data[i + 7] <= i_data[(1 + i - wr_count) * 4 + 28];
                            wr_data[i + 8] <= i_data[(1 + i - wr_count) * 4 + 32];
                            wr_data[i + 9] <= i_data[(1 + i - wr_count) * 4 + 36];
                            wr_data[i + 10] <= i_data[(1 + i - wr_count) * 4 + 40];
                            wr_data[i + 11] <= i_data[(1 + i - wr_count) * 4 + 44];
                            wr_data[i + 12] <= i_data[(1 + i - wr_count) * 4 + 48];
                            wr_data[i + 13] <= i_data[(1 + i - wr_count) * 4 + 52];
                            wr_data[i + 14] <= i_data[(1 + i - wr_count) * 4 + 56];
                            wr_data[i + 15] <= i_data[(1 + i - wr_count) * 4 + 60];
                            wr_data[i + 16] <= i_data[(1 + i - wr_count) * 4 + 1];
                            wr_data[i + 17] <= i_data[(1 + i - wr_count) * 4 + 5];
                            wr_data[i + 18] <= i_data[(1 + i - wr_count) * 4 + 9];
                            wr_data[i + 19] <= i_data[(1 + i - wr_count) * 4 + 13];
                            wr_data[i + 20] <= i_data[(1 + i - wr_count) * 4 + 17];
                            wr_data[i + 21] <= i_data[(1 + i - wr_count) * 4 + 21];
                            wr_data[i + 22] <= i_data[(1 + i - wr_count) * 4 + 25];
                            wr_data[i + 23] <= i_data[(1 + i - wr_count) * 4 + 29];
                            wr_data[i + 24] <= i_data[(1 + i - wr_count) * 4 + 33];
                            wr_data[i + 25] <= i_data[(1 + i - wr_count) * 4 + 37];
                            wr_data[i + 26] <= i_data[(1 + i - wr_count) * 4 + 41];
                            wr_data[i + 27] <= i_data[(1 + i - wr_count) * 4 + 45];
                            wr_data[i + 28] <= i_data[(1 + i - wr_count) * 4 + 49];
                            wr_data[i + 29] <= i_data[(1 + i - wr_count) * 4 + 53];
                            wr_data[i + 30] <= i_data[(1 + i - wr_count) * 4 + 57];
                            wr_data[i + 31] <= i_data[(1 + i - wr_count) * 4 + 61];
                            wr_data[i + 32] <= i_data[(1 + i - wr_count) * 4 + 2];
                            wr_data[i + 33] <= i_data[(1 + i - wr_count) * 4 + 6];
                            wr_data[i + 34] <= i_data[(1 + i - wr_count) * 4 + 10];
                            wr_data[i + 35] <= i_data[(1 + i - wr_count) * 4 + 14];
                            wr_data[i + 36] <= i_data[(1 + i - wr_count) * 4 + 18];
                            wr_data[i + 37] <= i_data[(1 + i - wr_count) * 4 + 22];
                            wr_data[i + 38] <= i_data[(1 + i - wr_count) * 4 + 26];
                            wr_data[i + 39] <= i_data[(1 + i - wr_count) * 4 + 30];
                            wr_data[i + 40] <= i_data[(1 + i - wr_count) * 4 + 34];
                            wr_data[i + 41] <= i_data[(1 + i - wr_count) * 4 + 38];
                            wr_data[i + 42] <= i_data[(1 + i - wr_count) * 4 + 42];
                            wr_data[i + 43] <= i_data[(1 + i - wr_count) * 4 + 46];
                            wr_data[i + 44] <= i_data[(1 + i - wr_count) * 4 + 50];
                            wr_data[i + 45] <= i_data[(1 + i - wr_count) * 4 + 54];
                            wr_data[i + 46] <= i_data[(1 + i - wr_count) * 4 + 58];
                            wr_data[i + 47] <= i_data[(1 + i - wr_count) * 4 + 62];
                            wr_data[i + 48] <= i_data[(1 + i - wr_count) * 4 + 3];
                            wr_data[i + 49] <= i_data[(1 + i - wr_count) * 4 + 7];
                            wr_data[i + 50] <= i_data[(1 + i - wr_count) * 4 + 11];
                            wr_data[i + 51] <= i_data[(1 + i - wr_count) * 4 + 15];
                            wr_data[i + 52] <= i_data[(1 + i - wr_count) * 4 + 19];
                            wr_data[i + 53] <= i_data[(1 + i - wr_count) * 4 + 23];
                            wr_data[i + 54] <= i_data[(1 + i - wr_count) * 4 + 27];
                            wr_data[i + 55] <= i_data[(1 + i - wr_count) * 4 + 31];
                            wr_data[i + 56] <= i_data[(1 + i - wr_count) * 4 + 35];
                            wr_data[i + 57] <= i_data[(1 + i - wr_count) * 4 + 39];
                            wr_data[i + 58] <= i_data[(1 + i - wr_count) * 4 + 43];
                            wr_data[i + 59] <= i_data[(1 + i - wr_count) * 4 + 47];
                            wr_data[i + 60] <= i_data[(1 + i - wr_count) * 4 + 51];
                            wr_data[i + 61] <= i_data[(1 + i - wr_count) * 4 + 55];
                            wr_data[i + 62] <= i_data[(1 + i - wr_count) * 4 + 59];
                            wr_data[i + 63] <= i_data[(1 + i - wr_count) * 4 + 63];
                        end
                end
            end
            {MATRIX_16X8 } : begin
                for (i = 0; i < 2; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 4 + 0];
                            wr_data[i + 2] <= i_data[(i - wr_count) * 4 + 8];
                            wr_data[i + 4] <= i_data[(i - wr_count) * 4 + 16];
                            wr_data[i + 6] <= i_data[(i - wr_count) * 4 + 24];
                            wr_data[i + 8] <= i_data[(i - wr_count) * 4 + 32];
                            wr_data[i + 10] <= i_data[(i - wr_count) * 4 + 40];
                            wr_data[i + 12] <= i_data[(i - wr_count) * 4 + 48];
                            wr_data[i + 14] <= i_data[(i - wr_count) * 4 + 56];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 4 + 1];
                            wr_data[i + 18] <= i_data[(i - wr_count) * 4 + 9];
                            wr_data[i + 20] <= i_data[(i - wr_count) * 4 + 17];
                            wr_data[i + 22] <= i_data[(i - wr_count) * 4 + 25];
                            wr_data[i + 24] <= i_data[(i - wr_count) * 4 + 33];
                            wr_data[i + 26] <= i_data[(i - wr_count) * 4 + 41];
                            wr_data[i + 28] <= i_data[(i - wr_count) * 4 + 49];
                            wr_data[i + 30] <= i_data[(i - wr_count) * 4 + 57];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 4 + 2];
                            wr_data[i + 34] <= i_data[(i - wr_count) * 4 + 10];
                            wr_data[i + 36] <= i_data[(i - wr_count) * 4 + 18];
                            wr_data[i + 38] <= i_data[(i - wr_count) * 4 + 26];
                            wr_data[i + 40] <= i_data[(i - wr_count) * 4 + 34];
                            wr_data[i + 42] <= i_data[(i - wr_count) * 4 + 42];
                            wr_data[i + 44] <= i_data[(i - wr_count) * 4 + 50];
                            wr_data[i + 46] <= i_data[(i - wr_count) * 4 + 58];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 4 + 3];
                            wr_data[i + 50] <= i_data[(i - wr_count) * 4 + 11];
                            wr_data[i + 52] <= i_data[(i - wr_count) * 4 + 19];
                            wr_data[i + 54] <= i_data[(i - wr_count) * 4 + 27];
                            wr_data[i + 56] <= i_data[(i - wr_count) * 4 + 35];
                            wr_data[i + 58] <= i_data[(i - wr_count) * 4 + 43];
                            wr_data[i + 60] <= i_data[(i - wr_count) * 4 + 51];
                            wr_data[i + 62] <= i_data[(i - wr_count) * 4 + 59];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(2 + i - wr_count) * 4 + 0];
                            wr_data[i + 2] <= i_data[(2 + i - wr_count) * 4 + 8];
                            wr_data[i + 4] <= i_data[(2 + i - wr_count) * 4 + 16];
                            wr_data[i + 6] <= i_data[(2 + i - wr_count) * 4 + 24];
                            wr_data[i + 8] <= i_data[(2 + i - wr_count) * 4 + 32];
                            wr_data[i + 10] <= i_data[(2 + i - wr_count) * 4 + 40];
                            wr_data[i + 12] <= i_data[(2 + i - wr_count) * 4 + 48];
                            wr_data[i + 14] <= i_data[(2 + i - wr_count) * 4 + 56];
                            wr_data[i + 16] <= i_data[(2 + i - wr_count) * 4 + 1];
                            wr_data[i + 18] <= i_data[(2 + i - wr_count) * 4 + 9];
                            wr_data[i + 20] <= i_data[(2 + i - wr_count) * 4 + 17];
                            wr_data[i + 22] <= i_data[(2 + i - wr_count) * 4 + 25];
                            wr_data[i + 24] <= i_data[(2 + i - wr_count) * 4 + 33];
                            wr_data[i + 26] <= i_data[(2 + i - wr_count) * 4 + 41];
                            wr_data[i + 28] <= i_data[(2 + i - wr_count) * 4 + 49];
                            wr_data[i + 30] <= i_data[(2 + i - wr_count) * 4 + 57];
                            wr_data[i + 32] <= i_data[(2 + i - wr_count) * 4 + 2];
                            wr_data[i + 34] <= i_data[(2 + i - wr_count) * 4 + 10];
                            wr_data[i + 36] <= i_data[(2 + i - wr_count) * 4 + 18];
                            wr_data[i + 38] <= i_data[(2 + i - wr_count) * 4 + 26];
                            wr_data[i + 40] <= i_data[(2 + i - wr_count) * 4 + 34];
                            wr_data[i + 42] <= i_data[(2 + i - wr_count) * 4 + 42];
                            wr_data[i + 44] <= i_data[(2 + i - wr_count) * 4 + 50];
                            wr_data[i + 46] <= i_data[(2 + i - wr_count) * 4 + 58];
                            wr_data[i + 48] <= i_data[(2 + i - wr_count) * 4 + 3];
                            wr_data[i + 50] <= i_data[(2 + i - wr_count) * 4 + 11];
                            wr_data[i + 52] <= i_data[(2 + i - wr_count) * 4 + 19];
                            wr_data[i + 54] <= i_data[(2 + i - wr_count) * 4 + 27];
                            wr_data[i + 56] <= i_data[(2 + i - wr_count) * 4 + 35];
                            wr_data[i + 58] <= i_data[(2 + i - wr_count) * 4 + 43];
                            wr_data[i + 60] <= i_data[(2 + i - wr_count) * 4 + 51];
                            wr_data[i + 62] <= i_data[(2 + i - wr_count) * 4 + 59];
                        end
                end
            end
            {MATRIX_16X16} : begin
                for (i = 0; i < 4; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 4 + 0];
                            wr_data[i + 4] <= i_data[(i - wr_count) * 4 + 16];
                            wr_data[i + 8] <= i_data[(i - wr_count) * 4 + 32];
                            wr_data[i + 12] <= i_data[(i - wr_count) * 4 + 48];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 4 + 1];
                            wr_data[i + 20] <= i_data[(i - wr_count) * 4 + 17];
                            wr_data[i + 24] <= i_data[(i - wr_count) * 4 + 33];
                            wr_data[i + 28] <= i_data[(i - wr_count) * 4 + 49];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 4 + 2];
                            wr_data[i + 36] <= i_data[(i - wr_count) * 4 + 18];
                            wr_data[i + 40] <= i_data[(i - wr_count) * 4 + 34];
                            wr_data[i + 44] <= i_data[(i - wr_count) * 4 + 50];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 4 + 3];
                            wr_data[i + 52] <= i_data[(i - wr_count) * 4 + 19];
                            wr_data[i + 56] <= i_data[(i - wr_count) * 4 + 35];
                            wr_data[i + 60] <= i_data[(i - wr_count) * 4 + 51];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(4 + i - wr_count) * 4 + 0];
                            wr_data[i + 4] <= i_data[(4 + i - wr_count) * 4 + 16];
                            wr_data[i + 8] <= i_data[(4 + i - wr_count) * 4 + 32];
                            wr_data[i + 12] <= i_data[(4 + i - wr_count) * 4 + 48];
                            wr_data[i + 16] <= i_data[(4 + i - wr_count) * 4 + 1];
                            wr_data[i + 20] <= i_data[(4 + i - wr_count) * 4 + 17];
                            wr_data[i + 24] <= i_data[(4 + i - wr_count) * 4 + 33];
                            wr_data[i + 28] <= i_data[(4 + i - wr_count) * 4 + 49];
                            wr_data[i + 32] <= i_data[(4 + i - wr_count) * 4 + 2];
                            wr_data[i + 36] <= i_data[(4 + i - wr_count) * 4 + 18];
                            wr_data[i + 40] <= i_data[(4 + i - wr_count) * 4 + 34];
                            wr_data[i + 44] <= i_data[(4 + i - wr_count) * 4 + 50];
                            wr_data[i + 48] <= i_data[(4 + i - wr_count) * 4 + 3];
                            wr_data[i + 52] <= i_data[(4 + i - wr_count) * 4 + 19];
                            wr_data[i + 56] <= i_data[(4 + i - wr_count) * 4 + 35];
                            wr_data[i + 60] <= i_data[(4 + i - wr_count) * 4 + 51];
                        end
                end
            end
            {MATRIX_16X32} : begin
                for (i = 0; i < 8; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 4 + 0];
                            wr_data[i + 8] <= i_data[(i - wr_count) * 4 + 32];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 4 + 1];
                            wr_data[i + 24] <= i_data[(i - wr_count) * 4 + 33];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 4 + 2];
                            wr_data[i + 40] <= i_data[(i - wr_count) * 4 + 34];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 4 + 3];
                            wr_data[i + 56] <= i_data[(i - wr_count) * 4 + 35];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(8 + i - wr_count) * 4 + 0];
                            wr_data[i + 8] <= i_data[(8 + i - wr_count) * 4 + 32];
                            wr_data[i + 16] <= i_data[(8 + i - wr_count) * 4 + 1];
                            wr_data[i + 24] <= i_data[(8 + i - wr_count) * 4 + 33];
                            wr_data[i + 32] <= i_data[(8 + i - wr_count) * 4 + 2];
                            wr_data[i + 40] <= i_data[(8 + i - wr_count) * 4 + 34];
                            wr_data[i + 48] <= i_data[(8 + i - wr_count) * 4 + 3];
                            wr_data[i + 56] <= i_data[(8 + i - wr_count) * 4 + 35];
                        end
                end
            end
            {MATRIX_16X64} : begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 4 + 0];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 4 + 1];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 4 + 2];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 4 + 3];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(16 + i - wr_count) * 4 + 0];
                            wr_data[i + 16] <= i_data[(16 + i - wr_count) * 4 + 1];
                            wr_data[i + 32] <= i_data[(16 + i - wr_count) * 4 + 2];
                            wr_data[i + 48] <= i_data[(16 + i - wr_count) * 4 + 3];
                        end
                end
            end
            {MATRIX_32X4} : begin
                for (i = 0; i < 2; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 16 + 0];
                            wr_data[i + 2] <= i_data[(i - wr_count) * 16 + 32];
                            wr_data[i + 4] <= i_data[(i - wr_count) * 16 + 1];
                            wr_data[i + 6] <= i_data[(i - wr_count) * 16 + 33];
                            wr_data[i + 8] <= i_data[(i - wr_count) * 16 + 2];
                            wr_data[i + 10] <= i_data[(i - wr_count) * 16 + 34];
                            wr_data[i + 12] <= i_data[(i - wr_count) * 16 + 3];
                            wr_data[i + 14] <= i_data[(i - wr_count) * 16 + 35];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 16 + 4];
                            wr_data[i + 18] <= i_data[(i - wr_count) * 16 + 36];
                            wr_data[i + 20] <= i_data[(i - wr_count) * 16 + 5];
                            wr_data[i + 22] <= i_data[(i - wr_count) * 16 + 37];
                            wr_data[i + 24] <= i_data[(i - wr_count) * 16 + 6];
                            wr_data[i + 26] <= i_data[(i - wr_count) * 16 + 38];
                            wr_data[i + 28] <= i_data[(i - wr_count) * 16 + 7];
                            wr_data[i + 30] <= i_data[(i - wr_count) * 16 + 39];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 16 + 8];
                            wr_data[i + 34] <= i_data[(i - wr_count) * 16 + 40];
                            wr_data[i + 36] <= i_data[(i - wr_count) * 16 + 9];
                            wr_data[i + 38] <= i_data[(i - wr_count) * 16 + 41];
                            wr_data[i + 40] <= i_data[(i - wr_count) * 16 + 10];
                            wr_data[i + 42] <= i_data[(i - wr_count) * 16 + 42];
                            wr_data[i + 44] <= i_data[(i - wr_count) * 16 + 11];
                            wr_data[i + 46] <= i_data[(i - wr_count) * 16 + 43];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 16 + 12];
                            wr_data[i + 50] <= i_data[(i - wr_count) * 16 + 44];
                            wr_data[i + 52] <= i_data[(i - wr_count) * 16 + 13];
                            wr_data[i + 54] <= i_data[(i - wr_count) * 16 + 45];
                            wr_data[i + 56] <= i_data[(i - wr_count) * 16 + 14];
                            wr_data[i + 58] <= i_data[(i - wr_count) * 16 + 46];
                            wr_data[i + 60] <= i_data[(i - wr_count) * 16 + 15];
                            wr_data[i + 62] <= i_data[(i - wr_count) * 16 + 47];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(2 + i - wr_count) * 16 + 0];
                            wr_data[i + 2] <= i_data[(2 + i - wr_count) * 16 + 32];
                            wr_data[i + 4] <= i_data[(2 + i - wr_count) * 16 + 1];
                            wr_data[i + 6] <= i_data[(2 + i - wr_count) * 16 + 33];
                            wr_data[i + 8] <= i_data[(2 + i - wr_count) * 16 + 2];
                            wr_data[i + 10] <= i_data[(2 + i - wr_count) * 16 + 34];
                            wr_data[i + 12] <= i_data[(2 + i - wr_count) * 16 + 3];
                            wr_data[i + 14] <= i_data[(2 + i - wr_count) * 16 + 35];
                            wr_data[i + 16] <= i_data[(2 + i - wr_count) * 16 + 4];
                            wr_data[i + 18] <= i_data[(2 + i - wr_count) * 16 + 36];
                            wr_data[i + 20] <= i_data[(2 + i - wr_count) * 16 + 5];
                            wr_data[i + 22] <= i_data[(2 + i - wr_count) * 16 + 37];
                            wr_data[i + 24] <= i_data[(2 + i - wr_count) * 16 + 6];
                            wr_data[i + 26] <= i_data[(2 + i - wr_count) * 16 + 38];
                            wr_data[i + 28] <= i_data[(2 + i - wr_count) * 16 + 7];
                            wr_data[i + 30] <= i_data[(2 + i - wr_count) * 16 + 39];
                            wr_data[i + 32] <= i_data[(2 + i - wr_count) * 16 + 8];
                            wr_data[i + 34] <= i_data[(2 + i - wr_count) * 16 + 40];
                            wr_data[i + 36] <= i_data[(2 + i - wr_count) * 16 + 9];
                            wr_data[i + 38] <= i_data[(2 + i - wr_count) * 16 + 41];
                            wr_data[i + 40] <= i_data[(2 + i - wr_count) * 16 + 10];
                            wr_data[i + 42] <= i_data[(2 + i - wr_count) * 16 + 42];
                            wr_data[i + 44] <= i_data[(2 + i - wr_count) * 16 + 11];
                            wr_data[i + 46] <= i_data[(2 + i - wr_count) * 16 + 43];
                            wr_data[i + 48] <= i_data[(2 + i - wr_count) * 16 + 12];
                            wr_data[i + 50] <= i_data[(2 + i - wr_count) * 16 + 44];
                            wr_data[i + 52] <= i_data[(2 + i - wr_count) * 16 + 13];
                            wr_data[i + 54] <= i_data[(2 + i - wr_count) * 16 + 45];
                            wr_data[i + 56] <= i_data[(2 + i - wr_count) * 16 + 14];
                            wr_data[i + 58] <= i_data[(2 + i - wr_count) * 16 + 46];
                            wr_data[i + 60] <= i_data[(2 + i - wr_count) * 16 + 15];
                            wr_data[i + 62] <= i_data[(2 + i - wr_count) * 16 + 47];
                        end
                end
            end
            {MATRIX_32X8} : begin
                for (i = 0; i < 4; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 2 + 0];
                            wr_data[i + 4] <= i_data[(i - wr_count) * 2 + 8];
                            wr_data[i + 8] <= i_data[(i - wr_count) * 2 + 16];
                            wr_data[i + 12] <= i_data[(i - wr_count) * 2 + 24];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 2 + 32];
                            wr_data[i + 20] <= i_data[(i - wr_count) * 2 + 40];
                            wr_data[i + 24] <= i_data[(i - wr_count) * 2 + 48];
                            wr_data[i + 28] <= i_data[(i - wr_count) * 2 + 56];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 2 + 1];
                            wr_data[i + 36] <= i_data[(i - wr_count) * 2 + 9];
                            wr_data[i + 40] <= i_data[(i - wr_count) * 2 + 17];
                            wr_data[i + 44] <= i_data[(i - wr_count) * 2 + 25];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 2 + 33];
                            wr_data[i + 52] <= i_data[(i - wr_count) * 2 + 41];
                            wr_data[i + 56] <= i_data[(i - wr_count) * 2 + 49];
                            wr_data[i + 60] <= i_data[(i - wr_count) * 2 + 57];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(4 + i - wr_count) * 2 + 0];
                            wr_data[i + 4] <= i_data[(4 + i - wr_count) * 2 + 8];
                            wr_data[i + 8] <= i_data[(4 + i - wr_count) * 2 + 16];
                            wr_data[i + 12] <= i_data[(4 + i - wr_count) * 2 + 24];
                            wr_data[i + 16] <= i_data[(4 + i - wr_count) * 2 + 32];
                            wr_data[i + 20] <= i_data[(4 + i - wr_count) * 2 + 40];
                            wr_data[i + 24] <= i_data[(4 + i - wr_count) * 2 + 48];
                            wr_data[i + 28] <= i_data[(4 + i - wr_count) * 2 + 56];
                            wr_data[i + 32] <= i_data[(4 + i - wr_count) * 2 + 1];
                            wr_data[i + 36] <= i_data[(4 + i - wr_count) * 2 + 9];
                            wr_data[i + 40] <= i_data[(4 + i - wr_count) * 2 + 17];
                            wr_data[i + 44] <= i_data[(4 + i - wr_count) * 2 + 25];
                            wr_data[i + 48] <= i_data[(4 + i - wr_count) * 2 + 33];
                            wr_data[i + 52] <= i_data[(4 + i - wr_count) * 2 + 41];
                            wr_data[i + 56] <= i_data[(4 + i - wr_count) * 2 + 49];
                            wr_data[i + 60] <= i_data[(4 + i - wr_count) * 2 + 57];
                        end
                end
            end
            {MATRIX_32X16} : begin
                for (i = 0; i < 8; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 2 + 0];
                            wr_data[i + 8] <= i_data[(i - wr_count) * 2 + 16];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 2 + 32];
                            wr_data[i + 24] <= i_data[(i - wr_count) * 2 + 48];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 2 + 1];
                            wr_data[i + 40] <= i_data[(i - wr_count) * 2 + 17];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 2 + 33];
                            wr_data[i + 56] <= i_data[(i - wr_count) * 2 + 49];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(8 + i - wr_count) * 2 + 0];
                            wr_data[i + 8] <= i_data[(8 + i - wr_count) * 2 + 16];
                            wr_data[i + 16] <= i_data[(8 + i - wr_count) * 2 + 32];
                            wr_data[i + 24] <= i_data[(8 + i - wr_count) * 2 + 48];
                            wr_data[i + 32] <= i_data[(8 + i - wr_count) * 2 + 1];
                            wr_data[i + 40] <= i_data[(8 + i - wr_count) * 2 + 17];
                            wr_data[i + 48] <= i_data[(8 + i - wr_count) * 2 + 33];
                            wr_data[i + 56] <= i_data[(8 + i - wr_count) * 2 + 49];
                        end
                end
            end
            {MATRIX_32X32} : begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 2 + 0];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 2 + 32];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 2 + 1];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 2 + 33];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(16 + i - wr_count) * 2 + 0];
                            wr_data[i + 16] <= i_data[(16 + i - wr_count) * 2 + 32];
                            wr_data[i + 32] <= i_data[(16 + i - wr_count) * 2 + 1];
                            wr_data[i + 48] <= i_data[(16 + i - wr_count) * 2 + 33];
                        end
                end
                    end
            {MATRIX_32X64} : begin
                for (i = 0; i < 32; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 2 + 0];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 2 + 1];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(32 + i - wr_count) * 2 + 0];
                            wr_data[i + 32] <= i_data[(32 + i - wr_count) * 2 + 1];
                        end
                end
            end
            {MATRIX_64X4 } : begin
                for (i = 0; i < 4; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 1 + 0];
                            wr_data[i + 4] <= i_data[(i - wr_count) * 1 + 4];
                            wr_data[i + 8] <= i_data[(i - wr_count) * 1 + 8];
                            wr_data[i + 12] <= i_data[(i - wr_count) * 1 + 12];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 1 + 16];
                            wr_data[i + 20] <= i_data[(i - wr_count) * 1 + 20];
                            wr_data[i + 24] <= i_data[(i - wr_count) * 1 + 24];
                            wr_data[i + 28] <= i_data[(i - wr_count) * 1 + 28];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 1 + 32];
                            wr_data[i + 36] <= i_data[(i - wr_count) * 1 + 36];
                            wr_data[i + 40] <= i_data[(i - wr_count) * 1 + 40];
                            wr_data[i + 44] <= i_data[(i - wr_count) * 1 + 44];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 1 + 48];
                            wr_data[i + 52] <= i_data[(i - wr_count) * 1 + 52];
                            wr_data[i + 56] <= i_data[(i - wr_count) * 1 + 56];
                            wr_data[i + 60] <= i_data[(i - wr_count) * 1 + 60];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(4 + i - wr_count) * 1 + 0];
                            wr_data[i + 4] <= i_data[(4 + i - wr_count) * 1 + 4];
                            wr_data[i + 8] <= i_data[(4 + i - wr_count) * 1 + 8];
                            wr_data[i + 12] <= i_data[(4 + i - wr_count) * 1 + 12];
                            wr_data[i + 16] <= i_data[(4 + i - wr_count) * 1 + 16];
                            wr_data[i + 20] <= i_data[(4 + i - wr_count) * 1 + 20];
                            wr_data[i + 24] <= i_data[(4 + i - wr_count) * 1 + 24];
                            wr_data[i + 28] <= i_data[(4 + i - wr_count) * 1 + 28];
                            wr_data[i + 32] <= i_data[(4 + i - wr_count) * 1 + 32];
                            wr_data[i + 36] <= i_data[(4 + i - wr_count) * 1 + 36];
                            wr_data[i + 40] <= i_data[(4 + i - wr_count) * 1 + 40];
                            wr_data[i + 44] <= i_data[(4 + i - wr_count) * 1 + 44];
                            wr_data[i + 48] <= i_data[(4 + i - wr_count) * 1 + 48];
                            wr_data[i + 52] <= i_data[(4 + i - wr_count) * 1 + 52];
                            wr_data[i + 56] <= i_data[(4 + i - wr_count) * 1 + 56];
                            wr_data[i + 60] <= i_data[(4 + i - wr_count) * 1 + 60];
                        end
                end
            end
            {MATRIX_64X8 } : begin
                for (i = 0; i < 8; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 1 + 0];
                            wr_data[i + 8] <= i_data[(i - wr_count) * 1 + 8];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 1 + 16];
                            wr_data[i + 24] <= i_data[(i - wr_count) * 1 + 24];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 1 + 32];
                            wr_data[i + 40] <= i_data[(i - wr_count) * 1 + 40];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 1 + 48];
                            wr_data[i + 56] <= i_data[(i - wr_count) * 1 + 56];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(8 + i - wr_count) * 1 + 0];
                            wr_data[i + 8] <= i_data[(8 + i - wr_count) * 1 + 8];
                            wr_data[i + 16] <= i_data[(8 + i - wr_count) * 1 + 16];
                            wr_data[i + 24] <= i_data[(8 + i - wr_count) * 1 + 24];
                            wr_data[i + 32] <= i_data[(8 + i - wr_count) * 1 + 32];
                            wr_data[i + 40] <= i_data[(8 + i - wr_count) * 1 + 40];
                            wr_data[i + 48] <= i_data[(8 + i - wr_count) * 1 + 48];
                            wr_data[i + 56] <= i_data[(8 + i - wr_count) * 1 + 56];
                        end
                end
            end
            {MATRIX_64X16} : begin
                for (i = 0; i < 16; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 1 + 0];
                            wr_data[i + 16] <= i_data[(i - wr_count) * 1 + 16];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 1 + 32];
                            wr_data[i + 48] <= i_data[(i - wr_count) * 1 + 48];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(16 + i - wr_count) * 1 + 0];
                            wr_data[i + 16] <= i_data[(16 + i - wr_count) * 1 + 16];
                            wr_data[i + 32] <= i_data[(16 + i - wr_count) * 1 + 32];
                            wr_data[i + 48] <= i_data[(16 + i - wr_count) * 1 + 48];
                        end
                end
            end
            {MATRIX_64X32} : begin
                for (i = 0; i < 32; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 1 + 0];
                            wr_data[i + 32] <= i_data[(i - wr_count) * 1 + 32];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(32 + i - wr_count) * 1 + 0];
                            wr_data[i + 32] <= i_data[(32 + i - wr_count) * 1 + 32];
                        end
                end
            end
            {MATRIX_64X64} : begin
                for (i = 0; i < 64; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 1 + 0];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(64 + i - wr_count) * 1 + 0];
                        end
                end
            end
            default        : begin
                for (i = 0; i < 64; i = i + 1) begin
                    if (i >= wr_count) begin
                            wr_data[i + 0] <= i_data[(i - wr_count) * 1 + 0];
                        end
                    else begin
                            wr_data[i + 0] <= i_data[(64 + i - wr_count) * 1 + 0];
                        end
                end
            end
        endcase

    end
end

//diagonal storage :assign read data
    always@(*) begin
        for (i = 0; i < 64; i = i + 1) 
            o_data[ i ] <=  0;
        if(write_flag) begin
            case (rd_matrix_d2) 
                {MATRIX_4X4  } : begin
                    for (i = 0; i < 1; i = i + 1) begin
                        if (i + rd_count_d1 < 1) begin
                            o_data[i * 16 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 16 + 1] <= rd_data[i +  1 + rd_count_d1];
                            o_data[i * 16 + 2] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 16 + 3] <= rd_data[i +  3 + rd_count_d1];
                            o_data[i * 16 + 4] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 16 + 5] <= rd_data[i +  17 + rd_count_d1];
                            o_data[i * 16 + 6] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 16 + 7] <= rd_data[i +  19 + rd_count_d1];
                            o_data[i * 16 + 8] <= rd_data[i +   32+ rd_count_d1];
                            o_data[i * 16 + 9] <= rd_data[i +   33+ rd_count_d1];
                            o_data[i * 16 + 10] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 16 + 11] <= rd_data[i +  35 + rd_count_d1];
                            o_data[i * 16 + 12] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 16 + 13] <= rd_data[i +  49 + rd_count_d1];
                            o_data[i * 16 + 14] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 16 + 15] <= rd_data[i +  51 + rd_count_d1];
                            o_data[i * 16 + 16] <= rd_data[i +   4 + rd_count_d1];
                            o_data[i * 16 + 17] <= rd_data[i +   5 + rd_count_d1];
                            o_data[i * 16 + 18] <= rd_data[i +   6 + rd_count_d1];
                            o_data[i * 16 + 19] <= rd_data[i +   7 + rd_count_d1];
                            o_data[i * 16 + 20] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 16 + 21] <= rd_data[i +  21 + rd_count_d1];
                            o_data[i * 16 + 22] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 16 + 23] <= rd_data[i +  23 + rd_count_d1];
                            o_data[i * 16 + 24] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 16 + 25] <= rd_data[i +  25 + rd_count_d1];
                            o_data[i * 16 + 26] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 16 + 27] <= rd_data[i +  27 + rd_count_d1];
                            o_data[i * 16 + 28] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 16 + 29] <= rd_data[i +  29 + rd_count_d1];
                            o_data[i * 16 + 30] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 16 + 31] <= rd_data[i +  31 + rd_count_d1];
                            o_data[i * 16 + 32] <= rd_data[i +   8 + rd_count_d1];
                            o_data[i * 16 + 33] <= rd_data[i +   9 + rd_count_d1];
                            o_data[i * 16 + 34] <= rd_data[i +   10+ rd_count_d1];
                            o_data[i * 16 + 35] <= rd_data[i +   11+ rd_count_d1];
                            o_data[i * 16 + 36] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 16 + 37] <= rd_data[i +  37 + rd_count_d1];
                            o_data[i * 16 + 38] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 16 + 39] <= rd_data[i +  39 + rd_count_d1];
                            o_data[i * 16 + 40] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 16 + 41] <= rd_data[i +  41 + rd_count_d1];
                            o_data[i * 16 + 42] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 16 + 43] <= rd_data[i +  43 + rd_count_d1];
                            o_data[i * 16 + 44] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 16 + 45] <= rd_data[i +  45 + rd_count_d1];
                            o_data[i * 16 + 46] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 16 + 47] <= rd_data[i +  47 + rd_count_d1];
                            o_data[i * 16 + 48] <= rd_data[i +   12+ rd_count_d1];
                            o_data[i * 16 + 49] <= rd_data[i +   13+ rd_count_d1];
                            o_data[i * 16 + 50] <= rd_data[i +   14+ rd_count_d1];
                            o_data[i * 16 + 51] <= rd_data[i +   15+ rd_count_d1];
                            o_data[i * 16 + 52] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 16 + 53] <= rd_data[i +  53 + rd_count_d1];
                            o_data[i * 16 + 54] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 16 + 55] <= rd_data[i +  55 + rd_count_d1];
                            o_data[i * 16 + 56] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 16 + 57] <= rd_data[i +  57 + rd_count_d1];
                            o_data[i * 16 + 58] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 16 + 59] <= rd_data[i +  59 + rd_count_d1];
                            o_data[i * 16 + 60] <= rd_data[i +  60 + rd_count_d1];
                            o_data[i * 16 + 61] <= rd_data[i +  61 + rd_count_d1];
                            o_data[i * 16 + 62] <= rd_data[i +  62 + rd_count_d1];
                            o_data[i * 16 + 63] <= rd_data[i +  63 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 16 + 0] <= rd_data[i + -1 + rd_count_d1];
                            o_data[i * 16 + 1] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 16 + 2] <= rd_data[i +  1 + rd_count_d1];
                            o_data[i * 16 + 3] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 16 + 4] <= rd_data[i +  3 + rd_count_d1];
                            o_data[i * 16 + 5] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 16 + 6] <= rd_data[i +  5 + rd_count_d1];
                            o_data[i * 16 + 7] <= rd_data[i +  6 + rd_count_d1];
                            o_data[i * 16 + 8] <= rd_data[i +  7 + rd_count_d1];
                            o_data[i * 16 + 9] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 16 + 10] <= rd_data[i +  9 + rd_count_d1];
                            o_data[i * 16 + 11] <= rd_data[i +  10 + rd_count_d1];
                            o_data[i * 16 + 12] <= rd_data[i +  11 + rd_count_d1];
                            o_data[i * 16 + 13] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 16 + 14] <= rd_data[i +  13 + rd_count_d1];
                            o_data[i * 16 + 15] <= rd_data[i +  14 + rd_count_d1];
                            o_data[i * 16 + 16] <= rd_data[i +  15 + rd_count_d1];
                            o_data[i * 16 + 17] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 16 + 18] <= rd_data[i +  17 + rd_count_d1];
                            o_data[i * 16 + 19] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 16 + 20] <= rd_data[i +  19 + rd_count_d1];
                            o_data[i * 16 + 21] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 16 + 22] <= rd_data[i +  21 + rd_count_d1];
                            o_data[i * 16 + 23] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 16 + 24] <= rd_data[i +  23 + rd_count_d1];
                            o_data[i * 16 + 25] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 16 + 26] <= rd_data[i +  25 + rd_count_d1];
                            o_data[i * 16 + 27] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 16 + 28] <= rd_data[i +  27 + rd_count_d1];
                            o_data[i * 16 + 29] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 16 + 30] <= rd_data[i +  29 + rd_count_d1];
                            o_data[i * 16 + 31] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 16 + 32] <= rd_data[i +  31 + rd_count_d1];
                            o_data[i * 16 + 33] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 16 + 34] <= rd_data[i +  33 + rd_count_d1];
                            o_data[i * 16 + 35] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 16 + 36] <= rd_data[i +  35 + rd_count_d1];
                            o_data[i * 16 + 37] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 16 + 38] <= rd_data[i +  37 + rd_count_d1];
                            o_data[i * 16 + 39] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 16 + 40] <= rd_data[i +  39 + rd_count_d1];
                            o_data[i * 16 + 41] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 16 + 42] <= rd_data[i +  41 + rd_count_d1];
                            o_data[i * 16 + 43] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 16 + 44] <= rd_data[i +  43 + rd_count_d1];
                            o_data[i * 16 + 45] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 16 + 46] <= rd_data[i +  45 + rd_count_d1];
                            o_data[i * 16 + 47] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 16 + 48] <= rd_data[i +  47 + rd_count_d1];
                            o_data[i * 16 + 49] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 16 + 50] <= rd_data[i +  49 + rd_count_d1];
                            o_data[i * 16 + 51] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 16 + 52] <= rd_data[i +  51 + rd_count_d1];
                            o_data[i * 16 + 53] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 16 + 54] <= rd_data[i +  53 + rd_count_d1];
                            o_data[i * 16 + 55] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 16 + 56] <= rd_data[i +  55 + rd_count_d1];
                            o_data[i * 16 + 57] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 16 + 58] <= rd_data[i +  57 + rd_count_d1];
                            o_data[i * 16 + 59] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 16 + 60] <= rd_data[i +  59 + rd_count_d1];
                            o_data[i * 16 + 61] <= rd_data[i +  60 + rd_count_d1];
                            o_data[i * 16 + 62] <= rd_data[i +  61 + rd_count_d1];
                            o_data[i * 16 + 63] <= rd_data[i +  62 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_4X8  } : begin
                    for (i = 0; i < 1; i = i + 1) begin
                        if (i + rd_count_d1 < 1) begin
                            o_data[i * 8 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 8 + 1] <= rd_data[i +  1 + rd_count_d1];
                            o_data[i * 8 + 2] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 8 + 3] <= rd_data[i +  3 + rd_count_d1];
                            o_data[i * 8 + 4] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 8 + 5] <= rd_data[i +  5 + rd_count_d1];
                            o_data[i * 8 + 6] <= rd_data[i +  6 + rd_count_d1];
                            o_data[i * 8 + 7] <= rd_data[i +  7 + rd_count_d1];
                            o_data[i * 8 + 8] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 8 + 9] <= rd_data[i +  9 + rd_count_d1];
                            o_data[i * 8 + 10] <= rd_data[i +  10 + rd_count_d1];
                            o_data[i * 8 + 11] <= rd_data[i +  11 + rd_count_d1];
                            o_data[i * 8 + 12] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 8 + 13] <= rd_data[i +  13 + rd_count_d1];
                            o_data[i * 8 + 14] <= rd_data[i +  14 + rd_count_d1];
                            o_data[i * 8 + 15] <= rd_data[i +  15 + rd_count_d1];
                            o_data[i * 8 + 16] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 8 + 17] <= rd_data[i +  17 + rd_count_d1];
                            o_data[i * 8 + 18] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 8 + 19] <= rd_data[i +  19 + rd_count_d1];
                            o_data[i * 8 + 20] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 8 + 21] <= rd_data[i +  21 + rd_count_d1];
                            o_data[i * 8 + 22] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 8 + 23] <= rd_data[i +  23 + rd_count_d1];
                            o_data[i * 8 + 24] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 8 + 25] <= rd_data[i +  25 + rd_count_d1];
                            o_data[i * 8 + 26] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 8 + 27] <= rd_data[i +  27 + rd_count_d1];
                            o_data[i * 8 + 28] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 8 + 29] <= rd_data[i +  29 + rd_count_d1];
                            o_data[i * 8 + 30] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 8 + 31] <= rd_data[i +  31 + rd_count_d1];
                            o_data[i * 8 + 32] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 8 + 33] <= rd_data[i +  33 + rd_count_d1];
                            o_data[i * 8 + 34] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 8 + 35] <= rd_data[i +  35 + rd_count_d1];
                            o_data[i * 8 + 36] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 8 + 37] <= rd_data[i +  37 + rd_count_d1];
                            o_data[i * 8 + 38] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 8 + 39] <= rd_data[i +  39 + rd_count_d1];
                            o_data[i * 8 + 40] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 8 + 41] <= rd_data[i +  41 + rd_count_d1];
                            o_data[i * 8 + 42] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 8 + 43] <= rd_data[i +  43 + rd_count_d1];
                            o_data[i * 8 + 44] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 8 + 45] <= rd_data[i +  45 + rd_count_d1];
                            o_data[i * 8 + 46] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 8 + 47] <= rd_data[i +  47 + rd_count_d1];
                            o_data[i * 8 + 48] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 8 + 49] <= rd_data[i +  49 + rd_count_d1];
                            o_data[i * 8 + 50] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 8 + 51] <= rd_data[i +  51 + rd_count_d1];
                            o_data[i * 8 + 52] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 8 + 53] <= rd_data[i +  53 + rd_count_d1];
                            o_data[i * 8 + 54] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 8 + 55] <= rd_data[i +  55 + rd_count_d1];
                            o_data[i * 8 + 56] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 8 + 57] <= rd_data[i +  57 + rd_count_d1];
                            o_data[i * 8 + 58] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 8 + 59] <= rd_data[i +  59 + rd_count_d1];
                            o_data[i * 8 + 60] <= rd_data[i +  60 + rd_count_d1];
                            o_data[i * 8 + 61] <= rd_data[i +  61 + rd_count_d1];
                            o_data[i * 8 + 62] <= rd_data[i +  62 + rd_count_d1];
                            o_data[i * 8 + 63] <= rd_data[i +  63 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 8 + 0] <= rd_data[i + -1 + rd_count_d1];
                            o_data[i * 8 + 1] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 8 + 2] <= rd_data[i +  1 + rd_count_d1];
                            o_data[i * 8 + 3] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 8 + 4] <= rd_data[i +  3 + rd_count_d1];
                            o_data[i * 8 + 5] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 8 + 6] <= rd_data[i +  5 + rd_count_d1];
                            o_data[i * 8 + 7] <= rd_data[i +  6 + rd_count_d1];
                            o_data[i * 8 + 8] <= rd_data[i +  7 + rd_count_d1];
                            o_data[i * 8 + 9] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 8 + 10] <= rd_data[i +  9 + rd_count_d1];
                            o_data[i * 8 + 11] <= rd_data[i +  10 + rd_count_d1];
                            o_data[i * 8 + 12] <= rd_data[i +  11 + rd_count_d1];
                            o_data[i * 8 + 13] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 8 + 14] <= rd_data[i +  13 + rd_count_d1];
                            o_data[i * 8 + 15] <= rd_data[i +  14 + rd_count_d1];
                            o_data[i * 8 + 16] <= rd_data[i +  15 + rd_count_d1];
                            o_data[i * 8 + 17] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 8 + 18] <= rd_data[i +  17 + rd_count_d1];
                            o_data[i * 8 + 19] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 8 + 20] <= rd_data[i +  19 + rd_count_d1];
                            o_data[i * 8 + 21] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 8 + 22] <= rd_data[i +  21 + rd_count_d1];
                            o_data[i * 8 + 23] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 8 + 24] <= rd_data[i +  23 + rd_count_d1];
                            o_data[i * 8 + 25] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 8 + 26] <= rd_data[i +  25 + rd_count_d1];
                            o_data[i * 8 + 27] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 8 + 28] <= rd_data[i +  27 + rd_count_d1];
                            o_data[i * 8 + 29] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 8 + 30] <= rd_data[i +  29 + rd_count_d1];
                            o_data[i * 8 + 31] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 8 + 32] <= rd_data[i +  31 + rd_count_d1];
                            o_data[i * 8 + 33] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 8 + 34] <= rd_data[i +  33 + rd_count_d1];
                            o_data[i * 8 + 35] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 8 + 36] <= rd_data[i +  35 + rd_count_d1];
                            o_data[i * 8 + 37] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 8 + 38] <= rd_data[i +  37 + rd_count_d1];
                            o_data[i * 8 + 39] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 8 + 40] <= rd_data[i +  39 + rd_count_d1];
                            o_data[i * 8 + 41] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 8 + 42] <= rd_data[i +  41 + rd_count_d1];
                            o_data[i * 8 + 43] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 8 + 44] <= rd_data[i +  43 + rd_count_d1];
                            o_data[i * 8 + 45] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 8 + 46] <= rd_data[i +  45 + rd_count_d1];
                            o_data[i * 8 + 47] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 8 + 48] <= rd_data[i +  47 + rd_count_d1];
                            o_data[i * 8 + 49] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 8 + 50] <= rd_data[i +  49 + rd_count_d1];
                            o_data[i * 8 + 51] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 8 + 52] <= rd_data[i +  51 + rd_count_d1];
                            o_data[i * 8 + 53] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 8 + 54] <= rd_data[i +  53 + rd_count_d1];
                            o_data[i * 8 + 55] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 8 + 56] <= rd_data[i +  55 + rd_count_d1];
                            o_data[i * 8 + 57] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 8 + 58] <= rd_data[i +  57 + rd_count_d1];
                            o_data[i * 8 + 59] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 8 + 60] <= rd_data[i +  59 + rd_count_d1];
                            o_data[i * 8 + 61] <= rd_data[i +  60 + rd_count_d1];
                            o_data[i * 8 + 62] <= rd_data[i +  61 + rd_count_d1];
                            o_data[i * 8 + 63] <= rd_data[i +  62 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_4X16 } : begin
                    for (i = 0; i < 1; i = i + 1) begin
                        if (i + rd_count_d1 < 1) begin
                            o_data[i * 4 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 4 + 1] <= rd_data[i +  1 + rd_count_d1];
                            o_data[i * 4 + 2] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 4 + 3] <= rd_data[i +  3 + rd_count_d1];
                            o_data[i * 4 + 4] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 4 + 5] <= rd_data[i +  5 + rd_count_d1];
                            o_data[i * 4 + 6] <= rd_data[i +  6 + rd_count_d1];
                            o_data[i * 4 + 7] <= rd_data[i +  7 + rd_count_d1];
                            o_data[i * 4 + 8] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 4 + 9] <= rd_data[i +  9 + rd_count_d1];
                            o_data[i * 4 + 10] <= rd_data[i +  10 + rd_count_d1];
                            o_data[i * 4 + 11] <= rd_data[i +  11 + rd_count_d1];
                            o_data[i * 4 + 12] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 4 + 13] <= rd_data[i +  13 + rd_count_d1];
                            o_data[i * 4 + 14] <= rd_data[i +  14 + rd_count_d1];
                            o_data[i * 4 + 15] <= rd_data[i +  15 + rd_count_d1];
                            o_data[i * 4 + 16] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 4 + 17] <= rd_data[i +  17 + rd_count_d1];
                            o_data[i * 4 + 18] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 4 + 19] <= rd_data[i +  19 + rd_count_d1];
                            o_data[i * 4 + 20] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 4 + 21] <= rd_data[i +  21 + rd_count_d1];
                            o_data[i * 4 + 22] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 4 + 23] <= rd_data[i +  23 + rd_count_d1];
                            o_data[i * 4 + 24] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 4 + 25] <= rd_data[i +  25 + rd_count_d1];
                            o_data[i * 4 + 26] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 4 + 27] <= rd_data[i +  27 + rd_count_d1];
                            o_data[i * 4 + 28] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 4 + 29] <= rd_data[i +  29 + rd_count_d1];
                            o_data[i * 4 + 30] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 4 + 31] <= rd_data[i +  31 + rd_count_d1];
                            o_data[i * 4 + 32] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 4 + 33] <= rd_data[i +  33 + rd_count_d1];
                            o_data[i * 4 + 34] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 4 + 35] <= rd_data[i +  35 + rd_count_d1];
                            o_data[i * 4 + 36] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 4 + 37] <= rd_data[i +  37 + rd_count_d1];
                            o_data[i * 4 + 38] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 4 + 39] <= rd_data[i +  39 + rd_count_d1];
                            o_data[i * 4 + 40] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 4 + 41] <= rd_data[i +  41 + rd_count_d1];
                            o_data[i * 4 + 42] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 4 + 43] <= rd_data[i +  43 + rd_count_d1];
                            o_data[i * 4 + 44] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 4 + 45] <= rd_data[i +  45 + rd_count_d1];
                            o_data[i * 4 + 46] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 4 + 47] <= rd_data[i +  47 + rd_count_d1];
                            o_data[i * 4 + 48] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 4 + 49] <= rd_data[i +  49 + rd_count_d1];
                            o_data[i * 4 + 50] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 4 + 51] <= rd_data[i +  51 + rd_count_d1];
                            o_data[i * 4 + 52] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 4 + 53] <= rd_data[i +  53 + rd_count_d1];
                            o_data[i * 4 + 54] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 4 + 55] <= rd_data[i +  55 + rd_count_d1];
                            o_data[i * 4 + 56] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 4 + 57] <= rd_data[i +  57 + rd_count_d1];
                            o_data[i * 4 + 58] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 4 + 59] <= rd_data[i +  59 + rd_count_d1];
                            o_data[i * 4 + 60] <= rd_data[i +  60 + rd_count_d1];
                            o_data[i * 4 + 61] <= rd_data[i +  61 + rd_count_d1];
                            o_data[i * 4 + 62] <= rd_data[i +  62 + rd_count_d1];
                            o_data[i * 4 + 63] <= rd_data[i +  63 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 4 + 0] <= rd_data[i + -1 + rd_count_d1];
                            o_data[i * 4 + 1] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 4 + 2] <= rd_data[i +  1 + rd_count_d1];
                            o_data[i * 4 + 3] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 4 + 4] <= rd_data[i +  3 + rd_count_d1];
                            o_data[i * 4 + 5] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 4 + 6] <= rd_data[i +  5 + rd_count_d1];
                            o_data[i * 4 + 7] <= rd_data[i +  6 + rd_count_d1];
                            o_data[i * 4 + 8] <= rd_data[i +  7 + rd_count_d1];
                            o_data[i * 4 + 9] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 4 + 10] <= rd_data[i +  9 + rd_count_d1];
                            o_data[i * 4 + 11] <= rd_data[i +  10 + rd_count_d1];
                            o_data[i * 4 + 12] <= rd_data[i +  11 + rd_count_d1];
                            o_data[i * 4 + 13] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 4 + 14] <= rd_data[i +  13 + rd_count_d1];
                            o_data[i * 4 + 15] <= rd_data[i +  14 + rd_count_d1];
                            o_data[i * 4 + 16] <= rd_data[i +  15 + rd_count_d1];
                            o_data[i * 4 + 17] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 4 + 18] <= rd_data[i +  17 + rd_count_d1];
                            o_data[i * 4 + 19] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 4 + 20] <= rd_data[i +  19 + rd_count_d1];
                            o_data[i * 4 + 21] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 4 + 22] <= rd_data[i +  21 + rd_count_d1];
                            o_data[i * 4 + 23] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 4 + 24] <= rd_data[i +  23 + rd_count_d1];
                            o_data[i * 4 + 25] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 4 + 26] <= rd_data[i +  25 + rd_count_d1];
                            o_data[i * 4 + 27] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 4 + 28] <= rd_data[i +  27 + rd_count_d1];
                            o_data[i * 4 + 29] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 4 + 30] <= rd_data[i +  29 + rd_count_d1];
                            o_data[i * 4 + 31] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 4 + 32] <= rd_data[i +  31 + rd_count_d1];
                            o_data[i * 4 + 33] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 4 + 34] <= rd_data[i +  33 + rd_count_d1];
                            o_data[i * 4 + 35] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 4 + 36] <= rd_data[i +  35 + rd_count_d1];
                            o_data[i * 4 + 37] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 4 + 38] <= rd_data[i +  37 + rd_count_d1];
                            o_data[i * 4 + 39] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 4 + 40] <= rd_data[i +  39 + rd_count_d1];
                            o_data[i * 4 + 41] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 4 + 42] <= rd_data[i +  41 + rd_count_d1];
                            o_data[i * 4 + 43] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 4 + 44] <= rd_data[i +  43 + rd_count_d1];
                            o_data[i * 4 + 45] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 4 + 46] <= rd_data[i +  45 + rd_count_d1];
                            o_data[i * 4 + 47] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 4 + 48] <= rd_data[i +  47 + rd_count_d1];
                            o_data[i * 4 + 49] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 4 + 50] <= rd_data[i +  49 + rd_count_d1];
                            o_data[i * 4 + 51] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 4 + 52] <= rd_data[i +  51 + rd_count_d1];
                            o_data[i * 4 + 53] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 4 + 54] <= rd_data[i +  53 + rd_count_d1];
                            o_data[i * 4 + 55] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 4 + 56] <= rd_data[i +  55 + rd_count_d1];
                            o_data[i * 4 + 57] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 4 + 58] <= rd_data[i +  57 + rd_count_d1];
                            o_data[i * 4 + 59] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 4 + 60] <= rd_data[i +  59 + rd_count_d1];
                            o_data[i * 4 + 61] <= rd_data[i +  60 + rd_count_d1];
                            o_data[i * 4 + 62] <= rd_data[i +  61 + rd_count_d1];
                            o_data[i * 4 + 63] <= rd_data[i +  62 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_4X32 } : begin
                    for (i = 0; i < 2; i = i + 1) begin
                        if (i + rd_count_d1 < 2) begin
                            o_data[i * 2 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 2 + 1] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 2 + 4] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 2 + 5] <= rd_data[i +  6 + rd_count_d1];
                            o_data[i * 2 + 8] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 2 + 9] <= rd_data[i +  10 + rd_count_d1];
                            o_data[i * 2 + 12] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 2 + 13] <= rd_data[i +  14 + rd_count_d1];
                            o_data[i * 2 + 16] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 2 + 17] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 2 + 20] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 2 + 21] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 2 + 24] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 2 + 25] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 2 + 28] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 2 + 29] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 2 + 32] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 2 + 33] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 2 + 36] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 2 + 37] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 2 + 40] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 2 + 41] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 2 + 44] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 2 + 45] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 2 + 48] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 2 + 49] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 2 + 52] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 2 + 53] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 2 + 56] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 2 + 57] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 2 + 60] <= rd_data[i +  60 + rd_count_d1];
                            o_data[i * 2 + 61] <= rd_data[i +  62 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 2 + 0] <= rd_data[i + -2 + rd_count_d1];
                            o_data[i * 2 + 1] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 2 + 4] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 2 + 5] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 2 + 8] <= rd_data[i +  6 + rd_count_d1];
                            o_data[i * 2 + 9] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 2 + 12] <= rd_data[i +  10 + rd_count_d1];
                            o_data[i * 2 + 13] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 2 + 16] <= rd_data[i +  14 + rd_count_d1];
                            o_data[i * 2 + 17] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 2 + 20] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 2 + 21] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 2 + 24] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 2 + 25] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 2 + 28] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 2 + 29] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 2 + 32] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 2 + 33] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 2 + 36] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 2 + 37] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 2 + 40] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 2 + 41] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 2 + 44] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 2 + 45] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 2 + 48] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 2 + 49] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 2 + 52] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 2 + 53] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 2 + 56] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 2 + 57] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 2 + 60] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 2 + 61] <= rd_data[i +  60 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_4X64 } : begin
                    for (i = 0; i < 4; i = i + 1) begin
                        if (i + rd_count_d1 < 4) begin
                            o_data[i * 1 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 1 + 4] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 1 + 8] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 1 + 12] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 1 + 16] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 1 + 20] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 1 + 24] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 1 + 28] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 1 + 32] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 1 + 36] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 1 + 40] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 1 + 44] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 1 + 48] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 1 + 52] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 1 + 56] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 1 + 60] <= rd_data[i +  60 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 1 + 0] <= rd_data[i + -4 + rd_count_d1];
                            o_data[i * 1 + 4] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 1 + 8] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 1 + 12] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 1 + 16] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 1 + 20] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 1 + 24] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 1 + 28] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 1 + 32] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 1 + 36] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 1 + 40] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 1 + 44] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 1 + 48] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 1 + 52] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 1 + 56] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 1 + 60] <= rd_data[i +  56 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_8X4  } : begin
                    for (i = 0; i < 1; i = i + 1) begin
                        if (i + rd_count_d1 < 1) begin
                            o_data[i * 16 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 16 + 1] <= rd_data[i +  1 + rd_count_d1];
                            o_data[i * 16 + 2] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 16 + 3] <= rd_data[i +  3 + rd_count_d1];
                            o_data[i * 16 + 4] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 16 + 5] <= rd_data[i +  5 + rd_count_d1];
                            o_data[i * 16 + 6] <= rd_data[i +  6 + rd_count_d1];
                            o_data[i * 16 + 7] <= rd_data[i +  7 + rd_count_d1];
                            o_data[i * 16 + 8] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 16 + 9] <= rd_data[i +  9 + rd_count_d1];
                            o_data[i * 16 + 10] <= rd_data[i +  10 + rd_count_d1];
                            o_data[i * 16 + 11] <= rd_data[i +  11 + rd_count_d1];
                            o_data[i * 16 + 12] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 16 + 13] <= rd_data[i +  13 + rd_count_d1];
                            o_data[i * 16 + 14] <= rd_data[i +  14 + rd_count_d1];
                            o_data[i * 16 + 15] <= rd_data[i +  15 + rd_count_d1];
                            o_data[i * 16 + 16] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 16 + 17] <= rd_data[i +  17 + rd_count_d1];
                            o_data[i * 16 + 18] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 16 + 19] <= rd_data[i +  19 + rd_count_d1];
                            o_data[i * 16 + 20] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 16 + 21] <= rd_data[i +  21 + rd_count_d1];
                            o_data[i * 16 + 22] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 16 + 23] <= rd_data[i +  23 + rd_count_d1];
                            o_data[i * 16 + 24] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 16 + 25] <= rd_data[i +  25 + rd_count_d1];
                            o_data[i * 16 + 26] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 16 + 27] <= rd_data[i +  27 + rd_count_d1];
                            o_data[i * 16 + 28] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 16 + 29] <= rd_data[i +  29 + rd_count_d1];
                            o_data[i * 16 + 30] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 16 + 31] <= rd_data[i +  31 + rd_count_d1];
                            o_data[i * 16 + 32] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 16 + 33] <= rd_data[i +  33 + rd_count_d1];
                            o_data[i * 16 + 34] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 16 + 35] <= rd_data[i +  35 + rd_count_d1];
                            o_data[i * 16 + 36] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 16 + 37] <= rd_data[i +  37 + rd_count_d1];
                            o_data[i * 16 + 38] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 16 + 39] <= rd_data[i +  39 + rd_count_d1];
                            o_data[i * 16 + 40] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 16 + 41] <= rd_data[i +  41 + rd_count_d1];
                            o_data[i * 16 + 42] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 16 + 43] <= rd_data[i +  43 + rd_count_d1];
                            o_data[i * 16 + 44] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 16 + 45] <= rd_data[i +  45 + rd_count_d1];
                            o_data[i * 16 + 46] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 16 + 47] <= rd_data[i +  47 + rd_count_d1];
                            o_data[i * 16 + 48] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 16 + 49] <= rd_data[i +  49 + rd_count_d1];
                            o_data[i * 16 + 50] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 16 + 51] <= rd_data[i +  51 + rd_count_d1];
                            o_data[i * 16 + 52] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 16 + 53] <= rd_data[i +  53 + rd_count_d1];
                            o_data[i * 16 + 54] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 16 + 55] <= rd_data[i +  55 + rd_count_d1];
                            o_data[i * 16 + 56] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 16 + 57] <= rd_data[i +  57 + rd_count_d1];
                            o_data[i * 16 + 58] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 16 + 59] <= rd_data[i +  59 + rd_count_d1];
                            o_data[i * 16 + 60] <= rd_data[i +  60 + rd_count_d1];
                            o_data[i * 16 + 61] <= rd_data[i +  61 + rd_count_d1];
                            o_data[i * 16 + 62] <= rd_data[i +  62 + rd_count_d1];
                            o_data[i * 16 + 63] <= rd_data[i +  63 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 16 + 0] <= rd_data[i + -1 + rd_count_d1];
                            o_data[i * 16 + 1] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 16 + 2] <= rd_data[i +  1 + rd_count_d1];
                            o_data[i * 16 + 3] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 16 + 4] <= rd_data[i +  3 + rd_count_d1];
                            o_data[i * 16 + 5] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 16 + 6] <= rd_data[i +  5 + rd_count_d1];
                            o_data[i * 16 + 7] <= rd_data[i +  6 + rd_count_d1];
                            o_data[i * 16 + 8] <= rd_data[i +  7 + rd_count_d1];
                            o_data[i * 16 + 9] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 16 + 10] <= rd_data[i +  9 + rd_count_d1];
                            o_data[i * 16 + 11] <= rd_data[i +  10 + rd_count_d1];
                            o_data[i * 16 + 12] <= rd_data[i +  11 + rd_count_d1];
                            o_data[i * 16 + 13] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 16 + 14] <= rd_data[i +  13 + rd_count_d1];
                            o_data[i * 16 + 15] <= rd_data[i +  14 + rd_count_d1];
                            o_data[i * 16 + 16] <= rd_data[i +  15 + rd_count_d1];
                            o_data[i * 16 + 17] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 16 + 18] <= rd_data[i +  17 + rd_count_d1];
                            o_data[i * 16 + 19] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 16 + 20] <= rd_data[i +  19 + rd_count_d1];
                            o_data[i * 16 + 21] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 16 + 22] <= rd_data[i +  21 + rd_count_d1];
                            o_data[i * 16 + 23] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 16 + 24] <= rd_data[i +  23 + rd_count_d1];
                            o_data[i * 16 + 25] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 16 + 26] <= rd_data[i +  25 + rd_count_d1];
                            o_data[i * 16 + 27] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 16 + 28] <= rd_data[i +  27 + rd_count_d1];
                            o_data[i * 16 + 29] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 16 + 30] <= rd_data[i +  29 + rd_count_d1];
                            o_data[i * 16 + 31] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 16 + 32] <= rd_data[i +  31 + rd_count_d1];
                            o_data[i * 16 + 33] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 16 + 34] <= rd_data[i +  33 + rd_count_d1];
                            o_data[i * 16 + 35] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 16 + 36] <= rd_data[i +  35 + rd_count_d1];
                            o_data[i * 16 + 37] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 16 + 38] <= rd_data[i +  37 + rd_count_d1];
                            o_data[i * 16 + 39] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 16 + 40] <= rd_data[i +  39 + rd_count_d1];
                            o_data[i * 16 + 41] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 16 + 42] <= rd_data[i +  41 + rd_count_d1];
                            o_data[i * 16 + 43] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 16 + 44] <= rd_data[i +  43 + rd_count_d1];
                            o_data[i * 16 + 45] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 16 + 46] <= rd_data[i +  45 + rd_count_d1];
                            o_data[i * 16 + 47] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 16 + 48] <= rd_data[i +  47 + rd_count_d1];
                            o_data[i * 16 + 49] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 16 + 50] <= rd_data[i +  49 + rd_count_d1];
                            o_data[i * 16 + 51] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 16 + 52] <= rd_data[i +  51 + rd_count_d1];
                            o_data[i * 16 + 53] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 16 + 54] <= rd_data[i +  53 + rd_count_d1];
                            o_data[i * 16 + 55] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 16 + 56] <= rd_data[i +  55 + rd_count_d1];
                            o_data[i * 16 + 57] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 16 + 58] <= rd_data[i +  57 + rd_count_d1];
                            o_data[i * 16 + 59] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 16 + 60] <= rd_data[i +  59 + rd_count_d1];
                            o_data[i * 16 + 61] <= rd_data[i +  60 + rd_count_d1];
                            o_data[i * 16 + 62] <= rd_data[i +  61 + rd_count_d1];
                            o_data[i * 16 + 63] <= rd_data[i +  62 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_8X8  } : begin
                    for (i = 0; i < 1; i = i + 1) begin
                        if (i + rd_count_d1 < 1) begin
                            o_data[i * 8 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 8 + 1] <= rd_data[i +  1 + rd_count_d1];
                            o_data[i * 8 + 2] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 8 + 3] <= rd_data[i +  3 + rd_count_d1];
                            o_data[i * 8 + 4] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 8 + 5] <= rd_data[i +  5 + rd_count_d1];
                            o_data[i * 8 + 6] <= rd_data[i +  6 + rd_count_d1];
                            o_data[i * 8 + 7] <= rd_data[i +  7 + rd_count_d1];
                            o_data[i * 8 + 8] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 8 + 9] <= rd_data[i +  9 + rd_count_d1];
                            o_data[i * 8 + 10] <= rd_data[i +  10 + rd_count_d1];
                            o_data[i * 8 + 11] <= rd_data[i +  11 + rd_count_d1];
                            o_data[i * 8 + 12] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 8 + 13] <= rd_data[i +  13 + rd_count_d1];
                            o_data[i * 8 + 14] <= rd_data[i +  14 + rd_count_d1];
                            o_data[i * 8 + 15] <= rd_data[i +  15 + rd_count_d1];
                            o_data[i * 8 + 16] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 8 + 17] <= rd_data[i +  17 + rd_count_d1];
                            o_data[i * 8 + 18] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 8 + 19] <= rd_data[i +  19 + rd_count_d1];
                            o_data[i * 8 + 20] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 8 + 21] <= rd_data[i +  21 + rd_count_d1];
                            o_data[i * 8 + 22] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 8 + 23] <= rd_data[i +  23 + rd_count_d1];
                            o_data[i * 8 + 24] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 8 + 25] <= rd_data[i +  25 + rd_count_d1];
                            o_data[i * 8 + 26] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 8 + 27] <= rd_data[i +  27 + rd_count_d1];
                            o_data[i * 8 + 28] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 8 + 29] <= rd_data[i +  29 + rd_count_d1];
                            o_data[i * 8 + 30] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 8 + 31] <= rd_data[i +  31 + rd_count_d1];
                            o_data[i * 8 + 32] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 8 + 33] <= rd_data[i +  33 + rd_count_d1];
                            o_data[i * 8 + 34] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 8 + 35] <= rd_data[i +  35 + rd_count_d1];
                            o_data[i * 8 + 36] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 8 + 37] <= rd_data[i +  37 + rd_count_d1];
                            o_data[i * 8 + 38] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 8 + 39] <= rd_data[i +  39 + rd_count_d1];
                            o_data[i * 8 + 40] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 8 + 41] <= rd_data[i +  41 + rd_count_d1];
                            o_data[i * 8 + 42] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 8 + 43] <= rd_data[i +  43 + rd_count_d1];
                            o_data[i * 8 + 44] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 8 + 45] <= rd_data[i +  45 + rd_count_d1];
                            o_data[i * 8 + 46] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 8 + 47] <= rd_data[i +  47 + rd_count_d1];
                            o_data[i * 8 + 48] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 8 + 49] <= rd_data[i +  49 + rd_count_d1];
                            o_data[i * 8 + 50] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 8 + 51] <= rd_data[i +  51 + rd_count_d1];
                            o_data[i * 8 + 52] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 8 + 53] <= rd_data[i +  53 + rd_count_d1];
                            o_data[i * 8 + 54] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 8 + 55] <= rd_data[i +  55 + rd_count_d1];
                            o_data[i * 8 + 56] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 8 + 57] <= rd_data[i +  57 + rd_count_d1];
                            o_data[i * 8 + 58] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 8 + 59] <= rd_data[i +  59 + rd_count_d1];
                            o_data[i * 8 + 60] <= rd_data[i +  60 + rd_count_d1];
                            o_data[i * 8 + 61] <= rd_data[i +  61 + rd_count_d1];
                            o_data[i * 8 + 62] <= rd_data[i +  62 + rd_count_d1];
                            o_data[i * 8 + 63] <= rd_data[i +  63 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 8 + 0] <= rd_data[i + -1 + rd_count_d1];
                            o_data[i * 8 + 1] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 8 + 2] <= rd_data[i +  1 + rd_count_d1];
                            o_data[i * 8 + 3] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 8 + 4] <= rd_data[i +  3 + rd_count_d1];
                            o_data[i * 8 + 5] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 8 + 6] <= rd_data[i +  5 + rd_count_d1];
                            o_data[i * 8 + 7] <= rd_data[i +  6 + rd_count_d1];
                            o_data[i * 8 + 8] <= rd_data[i +  7 + rd_count_d1];
                            o_data[i * 8 + 9] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 8 + 10] <= rd_data[i +  9 + rd_count_d1];
                            o_data[i * 8 + 11] <= rd_data[i +  10 + rd_count_d1];
                            o_data[i * 8 + 12] <= rd_data[i +  11 + rd_count_d1];
                            o_data[i * 8 + 13] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 8 + 14] <= rd_data[i +  13 + rd_count_d1];
                            o_data[i * 8 + 15] <= rd_data[i +  14 + rd_count_d1];
                            o_data[i * 8 + 16] <= rd_data[i +  15 + rd_count_d1];
                            o_data[i * 8 + 17] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 8 + 18] <= rd_data[i +  17 + rd_count_d1];
                            o_data[i * 8 + 19] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 8 + 20] <= rd_data[i +  19 + rd_count_d1];
                            o_data[i * 8 + 21] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 8 + 22] <= rd_data[i +  21 + rd_count_d1];
                            o_data[i * 8 + 23] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 8 + 24] <= rd_data[i +  23 + rd_count_d1];
                            o_data[i * 8 + 25] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 8 + 26] <= rd_data[i +  25 + rd_count_d1];
                            o_data[i * 8 + 27] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 8 + 28] <= rd_data[i +  27 + rd_count_d1];
                            o_data[i * 8 + 29] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 8 + 30] <= rd_data[i +  29 + rd_count_d1];
                            o_data[i * 8 + 31] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 8 + 32] <= rd_data[i +  31 + rd_count_d1];
                            o_data[i * 8 + 33] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 8 + 34] <= rd_data[i +  33 + rd_count_d1];
                            o_data[i * 8 + 35] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 8 + 36] <= rd_data[i +  35 + rd_count_d1];
                            o_data[i * 8 + 37] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 8 + 38] <= rd_data[i +  37 + rd_count_d1];
                            o_data[i * 8 + 39] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 8 + 40] <= rd_data[i +  39 + rd_count_d1];
                            o_data[i * 8 + 41] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 8 + 42] <= rd_data[i +  41 + rd_count_d1];
                            o_data[i * 8 + 43] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 8 + 44] <= rd_data[i +  43 + rd_count_d1];
                            o_data[i * 8 + 45] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 8 + 46] <= rd_data[i +  45 + rd_count_d1];
                            o_data[i * 8 + 47] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 8 + 48] <= rd_data[i +  47 + rd_count_d1];
                            o_data[i * 8 + 49] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 8 + 50] <= rd_data[i +  49 + rd_count_d1];
                            o_data[i * 8 + 51] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 8 + 52] <= rd_data[i +  51 + rd_count_d1];
                            o_data[i * 8 + 53] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 8 + 54] <= rd_data[i +  53 + rd_count_d1];
                            o_data[i * 8 + 55] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 8 + 56] <= rd_data[i +  55 + rd_count_d1];
                            o_data[i * 8 + 57] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 8 + 58] <= rd_data[i +  57 + rd_count_d1];
                            o_data[i * 8 + 59] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 8 + 60] <= rd_data[i +  59 + rd_count_d1];
                            o_data[i * 8 + 61] <= rd_data[i +  60 + rd_count_d1];
                            o_data[i * 8 + 62] <= rd_data[i +  61 + rd_count_d1];
                            o_data[i * 8 + 63] <= rd_data[i +  62 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_8X16 } : begin
                    for (i = 0; i < 2; i = i + 1) begin
                        if (i + rd_count_d1 < 2) begin
                            o_data[i * 4 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 4 + 1] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 4 + 2] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 4 + 3] <= rd_data[i +  6 + rd_count_d1];
                            o_data[i * 4 + 8] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 4 + 9] <= rd_data[i +  10 + rd_count_d1];
                            o_data[i * 4 + 10] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 4 + 11] <= rd_data[i +  14 + rd_count_d1];
                            o_data[i * 4 + 16] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 4 + 17] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 4 + 18] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 4 + 19] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 4 + 24] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 4 + 25] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 4 + 26] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 4 + 27] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 4 + 32] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 4 + 33] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 4 + 34] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 4 + 35] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 4 + 40] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 4 + 41] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 4 + 42] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 4 + 43] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 4 + 48] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 4 + 49] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 4 + 50] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 4 + 51] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 4 + 56] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 4 + 57] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 4 + 58] <= rd_data[i +  60 + rd_count_d1];
                            o_data[i * 4 + 59] <= rd_data[i +  62 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 4 + 0] <= rd_data[i + -2 + rd_count_d1];
                            o_data[i * 4 + 1] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 4 + 2] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 4 + 3] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 4 + 8] <= rd_data[i +  6 + rd_count_d1];
                            o_data[i * 4 + 9] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 4 + 10] <= rd_data[i +  10 + rd_count_d1];
                            o_data[i * 4 + 11] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 4 + 16] <= rd_data[i +  14 + rd_count_d1];
                            o_data[i * 4 + 17] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 4 + 18] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 4 + 19] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 4 + 24] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 4 + 25] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 4 + 26] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 4 + 27] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 4 + 32] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 4 + 33] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 4 + 34] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 4 + 35] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 4 + 40] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 4 + 41] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 4 + 42] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 4 + 43] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 4 + 48] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 4 + 49] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 4 + 50] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 4 + 51] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 4 + 56] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 4 + 57] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 4 + 58] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 4 + 59] <= rd_data[i +  60 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_8X32 } : begin
                    for (i = 0; i < 4; i = i + 1) begin
                        if (i + rd_count_d1 < 4) begin
                            o_data[i * 2 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 2 + 1] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 2 + 8] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 2 + 9] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 2 + 16] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 2 + 17] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 2 + 24] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 2 + 25] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 2 + 32] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 2 + 33] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 2 + 40] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 2 + 41] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 2 + 48] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 2 + 49] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 2 + 56] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 2 + 57] <= rd_data[i +  60 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 2 + 0] <= rd_data[i + -4 + rd_count_d1];
                            o_data[i * 2 + 1] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 2 + 8] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 2 + 9] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 2 + 16] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 2 + 17] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 2 + 24] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 2 + 25] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 2 + 32] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 2 + 33] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 2 + 40] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 2 + 41] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 2 + 48] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 2 + 49] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 2 + 56] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 2 + 57] <= rd_data[i +  56 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_8X64 } : begin
                    for (i = 0; i < 8; i = i + 1) begin
                        if (i + rd_count_d1 < 8) begin
                            o_data[i * 1 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 1 + 8] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 1 + 16] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 1 + 24] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 1 + 32] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 1 + 40] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 1 + 48] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 1 + 56] <= rd_data[i +  56 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 1 + 0] <= rd_data[i + -8 + rd_count_d1];
                            o_data[i * 1 + 8] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 1 + 16] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 1 + 24] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 1 + 32] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 1 + 40] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 1 + 48] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 1 + 56] <= rd_data[i +  48 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_16X4 } : begin
                    for (i = 0; i < 1; i = i + 1) begin
                        if (i + rd_count_d1 < 1) begin
                            o_data[i * 16 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 16 + 1] <= rd_data[i +  1 + rd_count_d1];
                            o_data[i * 16 + 2] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 16 + 3] <= rd_data[i +  3 + rd_count_d1];
                            o_data[i * 16 + 4] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 16 + 5] <= rd_data[i +  5 + rd_count_d1];
                            o_data[i * 16 + 6] <= rd_data[i +  6 + rd_count_d1];
                            o_data[i * 16 + 7] <= rd_data[i +  7 + rd_count_d1];
                            o_data[i * 16 + 8] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 16 + 9] <= rd_data[i +  9 + rd_count_d1];
                            o_data[i * 16 + 10] <= rd_data[i +  10 + rd_count_d1];
                            o_data[i * 16 + 11] <= rd_data[i +  11 + rd_count_d1];
                            o_data[i * 16 + 12] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 16 + 13] <= rd_data[i +  13 + rd_count_d1];
                            o_data[i * 16 + 14] <= rd_data[i +  14 + rd_count_d1];
                            o_data[i * 16 + 15] <= rd_data[i +  15 + rd_count_d1];
                            o_data[i * 16 + 16] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 16 + 17] <= rd_data[i +  17 + rd_count_d1];
                            o_data[i * 16 + 18] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 16 + 19] <= rd_data[i +  19 + rd_count_d1];
                            o_data[i * 16 + 20] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 16 + 21] <= rd_data[i +  21 + rd_count_d1];
                            o_data[i * 16 + 22] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 16 + 23] <= rd_data[i +  23 + rd_count_d1];
                            o_data[i * 16 + 24] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 16 + 25] <= rd_data[i +  25 + rd_count_d1];
                            o_data[i * 16 + 26] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 16 + 27] <= rd_data[i +  27 + rd_count_d1];
                            o_data[i * 16 + 28] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 16 + 29] <= rd_data[i +  29 + rd_count_d1];
                            o_data[i * 16 + 30] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 16 + 31] <= rd_data[i +  31 + rd_count_d1];
                            o_data[i * 16 + 32] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 16 + 33] <= rd_data[i +  33 + rd_count_d1];
                            o_data[i * 16 + 34] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 16 + 35] <= rd_data[i +  35 + rd_count_d1];
                            o_data[i * 16 + 36] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 16 + 37] <= rd_data[i +  37 + rd_count_d1];
                            o_data[i * 16 + 38] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 16 + 39] <= rd_data[i +  39 + rd_count_d1];
                            o_data[i * 16 + 40] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 16 + 41] <= rd_data[i +  41 + rd_count_d1];
                            o_data[i * 16 + 42] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 16 + 43] <= rd_data[i +  43 + rd_count_d1];
                            o_data[i * 16 + 44] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 16 + 45] <= rd_data[i +  45 + rd_count_d1];
                            o_data[i * 16 + 46] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 16 + 47] <= rd_data[i +  47 + rd_count_d1];
                            o_data[i * 16 + 48] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 16 + 49] <= rd_data[i +  49 + rd_count_d1];
                            o_data[i * 16 + 50] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 16 + 51] <= rd_data[i +  51 + rd_count_d1];
                            o_data[i * 16 + 52] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 16 + 53] <= rd_data[i +  53 + rd_count_d1];
                            o_data[i * 16 + 54] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 16 + 55] <= rd_data[i +  55 + rd_count_d1];
                            o_data[i * 16 + 56] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 16 + 57] <= rd_data[i +  57 + rd_count_d1];
                            o_data[i * 16 + 58] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 16 + 59] <= rd_data[i +  59 + rd_count_d1];
                            o_data[i * 16 + 60] <= rd_data[i +  60 + rd_count_d1];
                            o_data[i * 16 + 61] <= rd_data[i +  61 + rd_count_d1];
                            o_data[i * 16 + 62] <= rd_data[i +  62 + rd_count_d1];
                            o_data[i * 16 + 63] <= rd_data[i +  63 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 16 + 0] <= rd_data[i + -1 + rd_count_d1];
                            o_data[i * 16 + 1] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 16 + 2] <= rd_data[i +  1 + rd_count_d1];
                            o_data[i * 16 + 3] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 16 + 4] <= rd_data[i +  3 + rd_count_d1];
                            o_data[i * 16 + 5] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 16 + 6] <= rd_data[i +  5 + rd_count_d1];
                            o_data[i * 16 + 7] <= rd_data[i +  6 + rd_count_d1];
                            o_data[i * 16 + 8] <= rd_data[i +  7 + rd_count_d1];
                            o_data[i * 16 + 9] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 16 + 10] <= rd_data[i +  9 + rd_count_d1];
                            o_data[i * 16 + 11] <= rd_data[i +  10 + rd_count_d1];
                            o_data[i * 16 + 12] <= rd_data[i +  11 + rd_count_d1];
                            o_data[i * 16 + 13] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 16 + 14] <= rd_data[i +  13 + rd_count_d1];
                            o_data[i * 16 + 15] <= rd_data[i +  14 + rd_count_d1];
                            o_data[i * 16 + 16] <= rd_data[i +  15 + rd_count_d1];
                            o_data[i * 16 + 17] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 16 + 18] <= rd_data[i +  17 + rd_count_d1];
                            o_data[i * 16 + 19] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 16 + 20] <= rd_data[i +  19 + rd_count_d1];
                            o_data[i * 16 + 21] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 16 + 22] <= rd_data[i +  21 + rd_count_d1];
                            o_data[i * 16 + 23] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 16 + 24] <= rd_data[i +  23 + rd_count_d1];
                            o_data[i * 16 + 25] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 16 + 26] <= rd_data[i +  25 + rd_count_d1];
                            o_data[i * 16 + 27] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 16 + 28] <= rd_data[i +  27 + rd_count_d1];
                            o_data[i * 16 + 29] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 16 + 30] <= rd_data[i +  29 + rd_count_d1];
                            o_data[i * 16 + 31] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 16 + 32] <= rd_data[i +  31 + rd_count_d1];
                            o_data[i * 16 + 33] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 16 + 34] <= rd_data[i +  33 + rd_count_d1];
                            o_data[i * 16 + 35] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 16 + 36] <= rd_data[i +  35 + rd_count_d1];
                            o_data[i * 16 + 37] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 16 + 38] <= rd_data[i +  37 + rd_count_d1];
                            o_data[i * 16 + 39] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 16 + 40] <= rd_data[i +  39 + rd_count_d1];
                            o_data[i * 16 + 41] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 16 + 42] <= rd_data[i +  41 + rd_count_d1];
                            o_data[i * 16 + 43] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 16 + 44] <= rd_data[i +  43 + rd_count_d1];
                            o_data[i * 16 + 45] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 16 + 46] <= rd_data[i +  45 + rd_count_d1];
                            o_data[i * 16 + 47] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 16 + 48] <= rd_data[i +  47 + rd_count_d1];
                            o_data[i * 16 + 49] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 16 + 50] <= rd_data[i +  49 + rd_count_d1];
                            o_data[i * 16 + 51] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 16 + 52] <= rd_data[i +  51 + rd_count_d1];
                            o_data[i * 16 + 53] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 16 + 54] <= rd_data[i +  53 + rd_count_d1];
                            o_data[i * 16 + 55] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 16 + 56] <= rd_data[i +  55 + rd_count_d1];
                            o_data[i * 16 + 57] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 16 + 58] <= rd_data[i +  57 + rd_count_d1];
                            o_data[i * 16 + 59] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 16 + 60] <= rd_data[i +  59 + rd_count_d1];
                            o_data[i * 16 + 61] <= rd_data[i +  60 + rd_count_d1];
                            o_data[i * 16 + 62] <= rd_data[i +  61 + rd_count_d1];
                            o_data[i * 16 + 63] <= rd_data[i +  62 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_16X8 } : begin
                    for (i = 0; i < 2; i = i + 1) begin
                        if (i + rd_count_d1 < 2) begin
                            o_data[i * 8 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 8 + 1] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 8 + 2] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 8 + 3] <= rd_data[i +  6 + rd_count_d1];
                            o_data[i * 8 + 4] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 8 + 5] <= rd_data[i +  10 + rd_count_d1];
                            o_data[i * 8 + 6] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 8 + 7] <= rd_data[i +  14 + rd_count_d1];
                            o_data[i * 8 + 16] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 8 + 17] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 8 + 18] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 8 + 19] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 8 + 20] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 8 + 21] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 8 + 22] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 8 + 23] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 8 + 32] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 8 + 33] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 8 + 34] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 8 + 35] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 8 + 36] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 8 + 37] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 8 + 38] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 8 + 39] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 8 + 48] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 8 + 49] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 8 + 50] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 8 + 51] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 8 + 52] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 8 + 53] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 8 + 54] <= rd_data[i +  60 + rd_count_d1];
                            o_data[i * 8 + 55] <= rd_data[i +  62 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 8 + 0] <= rd_data[i + -2 + rd_count_d1];
                            o_data[i * 8 + 1] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 8 + 2] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 8 + 3] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 8 + 4] <= rd_data[i +  6 + rd_count_d1];
                            o_data[i * 8 + 5] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 8 + 6] <= rd_data[i +  10 + rd_count_d1];
                            o_data[i * 8 + 7] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 8 + 16] <= rd_data[i +  14 + rd_count_d1];
                            o_data[i * 8 + 17] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 8 + 18] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 8 + 19] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 8 + 20] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 8 + 21] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 8 + 22] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 8 + 23] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 8 + 32] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 8 + 33] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 8 + 34] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 8 + 35] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 8 + 36] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 8 + 37] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 8 + 38] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 8 + 39] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 8 + 48] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 8 + 49] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 8 + 50] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 8 + 51] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 8 + 52] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 8 + 53] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 8 + 54] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 8 + 55] <= rd_data[i +  60 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_16X16} : begin
                    for (i = 0; i < 4; i = i + 1) begin
                        if(i + rd_count_d1 < 4) begin
                            o_data[i * 4 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 4 + 1] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 4 + 2] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 4 + 3] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 4 + 16] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 4 + 17] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 4 + 18] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 4 + 19] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 4 + 32] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 4 + 33] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 4 + 34] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 4 + 35] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 4 + 48] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 4 + 49] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 4 + 50] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 4 + 51] <= rd_data[i +  60 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 4 + 0] <= rd_data[i + -4 + rd_count_d1];
                            o_data[i * 4 + 1] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 4 + 2] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 4 + 3] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 4 + 16] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 4 + 17] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 4 + 18] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 4 + 19] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 4 + 32] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 4 + 33] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 4 + 34] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 4 + 35] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 4 + 48] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 4 + 49] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 4 + 50] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 4 + 51] <= rd_data[i +  56 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_16X32} : begin
                    for (i = 0; i < 8; i = i + 1) begin
                        if (i + rd_count_d1 < 8) begin
                            o_data[i * 2 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 2 + 1] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 2 + 16] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 2 + 17] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 2 + 32] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 2 + 33] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 2 + 48] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 2 + 49] <= rd_data[i +  56 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 2 + 0] <= rd_data[i + -8 + rd_count_d1];
                            o_data[i * 2 + 1] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 2 + 16] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 2 + 17] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 2 + 32] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 2 + 33] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 2 + 48] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 2 + 49] <= rd_data[i +  48 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_16X64} : begin
                    for (i = 0; i < 16; i = i + 1) begin
                        if (i + rd_count_d1 < 16) begin
                            o_data[i * 1 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 1 + 16] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 1 + 32] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 1 + 48] <= rd_data[i +  48 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 1 + 0] <= rd_data[i + -16 + rd_count_d1];
                            o_data[i * 1 + 16] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 1 + 32] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 1 + 48] <= rd_data[i +  32 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_32X4 } : begin
                    for (i = 0; i < 2; i = i + 1) begin
                        if (i + rd_count_d1 < 2) begin
                            o_data[i * 2 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 2 + 1] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 2 + 4] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 2 + 5] <= rd_data[i +  6 + rd_count_d1];
                            o_data[i * 2 + 8] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 2 + 9] <= rd_data[i +  10 + rd_count_d1];
                            o_data[i * 2 + 12] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 2 + 13] <= rd_data[i +  14 + rd_count_d1];
                            o_data[i * 2 + 16] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 2 + 17] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 2 + 20] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 2 + 21] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 2 + 24] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 2 + 25] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 2 + 28] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 2 + 29] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 2 + 32] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 2 + 33] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 2 + 36] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 2 + 37] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 2 + 40] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 2 + 41] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 2 + 44] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 2 + 45] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 2 + 48] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 2 + 49] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 2 + 52] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 2 + 53] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 2 + 56] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 2 + 57] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 2 + 60] <= rd_data[i +  60 + rd_count_d1];
                            o_data[i * 2 + 61] <= rd_data[i +  62 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 2 + 0] <= rd_data[i + -2 + rd_count_d1];
                            o_data[i * 2 + 1] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 2 + 4] <= rd_data[i +  2 + rd_count_d1];
                            o_data[i * 2 + 5] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 2 + 8] <= rd_data[i +  6 + rd_count_d1];
                            o_data[i * 2 + 9] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 2 + 12] <= rd_data[i +  10 + rd_count_d1];
                            o_data[i * 2 + 13] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 2 + 16] <= rd_data[i +  14 + rd_count_d1];
                            o_data[i * 2 + 17] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 2 + 20] <= rd_data[i +  18 + rd_count_d1];
                            o_data[i * 2 + 21] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 2 + 24] <= rd_data[i +  22 + rd_count_d1];
                            o_data[i * 2 + 25] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 2 + 28] <= rd_data[i +  26 + rd_count_d1];
                            o_data[i * 2 + 29] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 2 + 32] <= rd_data[i +  30 + rd_count_d1];
                            o_data[i * 2 + 33] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 2 + 36] <= rd_data[i +  34 + rd_count_d1];
                            o_data[i * 2 + 37] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 2 + 40] <= rd_data[i +  38 + rd_count_d1];
                            o_data[i * 2 + 41] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 2 + 44] <= rd_data[i +  42 + rd_count_d1];
                            o_data[i * 2 + 45] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 2 + 48] <= rd_data[i +  46 + rd_count_d1];
                            o_data[i * 2 + 49] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 2 + 52] <= rd_data[i +  50 + rd_count_d1];
                            o_data[i * 2 + 53] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 2 + 56] <= rd_data[i +  54 + rd_count_d1];
                            o_data[i * 2 + 57] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 2 + 60] <= rd_data[i +  58 + rd_count_d1];
                            o_data[i * 2 + 61] <= rd_data[i +  60 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_32X8 } : begin
                    for (i = 0; i < 4; i = i + 1) begin
                        if (i + rd_count_d1 < 4) begin
                            o_data[i * 8 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 8 + 1] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 8 + 2] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 8 + 3] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 8 + 4] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 8 + 5] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 8 + 6] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 8 + 7] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 8 + 32] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 8 + 33] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 8 + 34] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 8 + 35] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 8 + 36] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 8 + 37] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 8 + 38] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 8 + 39] <= rd_data[i +  60 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 8 + 0] <= rd_data[i + -4 + rd_count_d1];
                            o_data[i * 8 + 1] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 8 + 2] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 8 + 3] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 8 + 4] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 8 + 5] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 8 + 6] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 8 + 7] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 8 + 32] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 8 + 33] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 8 + 34] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 8 + 35] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 8 + 36] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 8 + 37] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 8 + 38] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 8 + 39] <= rd_data[i +  56 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_32X16} : begin
                    for (i = 0; i < 8; i = i + 1) begin
                        if (i + rd_count_d1 < 8) begin
                            o_data[i * 4 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 4 + 1] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 4 + 2] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 4 + 3] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 4 + 32] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 4 + 33] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 4 + 34] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 4 + 35] <= rd_data[i +  56 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 4 + 0] <= rd_data[i + -8 + rd_count_d1];
                            o_data[i * 4 + 1] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 4 + 2] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 4 + 3] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 4 + 32] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 4 + 33] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 4 + 34] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 4 + 35] <= rd_data[i +  48 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_32X32} : begin
                    for (i = 0; i < 16 ; i = i + 1) begin
                        if(rd_count_d1+i <16) begin
                            o_data[i * 2 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 2 + 1] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 2 + 32] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 2 + 33] <= rd_data[i +  48 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 2 + 0] <= rd_data[i + -16 + rd_count_d1];
                            o_data[i * 2 + 1] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 2 + 32] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 2 + 33] <= rd_data[i +  32 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_32X64} : begin
                    for (i = 0; i < 32; i = i + 1) begin
                        if (i + rd_count_d1 < 32) begin
                            o_data[i * 1 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 1 + 32] <= rd_data[i +  32 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 1 + 0] <= rd_data[i + -32 + rd_count_d1];
                            o_data[i * 1 + 32] <= rd_data[i +  0 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_64X4 } : begin
                    for (i = 0; i < 4; i = i + 1) begin
                        if (i + rd_count_d1 < 4) begin
                            o_data[i * 16 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 16 + 1] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 16 + 2] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 16 + 3] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 16 + 4] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 16 + 5] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 16 + 6] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 16 + 7] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 16 + 8] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 16 + 9] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 16 + 10] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 16 + 11] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 16 + 12] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 16 + 13] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 16 + 14] <= rd_data[i +  56 + rd_count_d1];
                            o_data[i * 16 + 15] <= rd_data[i +  60 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 16 + 0] <= rd_data[i + -4 + rd_count_d1];
                            o_data[i * 16 + 1] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 16 + 2] <= rd_data[i +  4 + rd_count_d1];
                            o_data[i * 16 + 3] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 16 + 4] <= rd_data[i +  12 + rd_count_d1];
                            o_data[i * 16 + 5] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 16 + 6] <= rd_data[i +  20 + rd_count_d1];
                            o_data[i * 16 + 7] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 16 + 8] <= rd_data[i +  28 + rd_count_d1];
                            o_data[i * 16 + 9] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 16 + 10] <= rd_data[i +  36 + rd_count_d1];
                            o_data[i * 16 + 11] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 16 + 12] <= rd_data[i +  44 + rd_count_d1];
                            o_data[i * 16 + 13] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 16 + 14] <= rd_data[i +  52 + rd_count_d1];
                            o_data[i * 16 + 15] <= rd_data[i +  56 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_64X8 } : begin
                    for (i = 0; i < 8; i = i + 1) begin
                        if (i + rd_count_d1 < 8) begin
                            o_data[i * 8 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 8 + 1] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 8 + 2] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 8 + 3] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 8 + 4] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 8 + 5] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 8 + 6] <= rd_data[i +  48 + rd_count_d1];
                            o_data[i * 8 + 7] <= rd_data[i +  56 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 8 + 0] <= rd_data[i + -8 + rd_count_d1];
                            o_data[i * 8 + 1] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 8 + 2] <= rd_data[i +  8 + rd_count_d1];
                            o_data[i * 8 + 3] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 8 + 4] <= rd_data[i +  24 + rd_count_d1];
                            o_data[i * 8 + 5] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 8 + 6] <= rd_data[i +  40 + rd_count_d1];
                            o_data[i * 8 + 7] <= rd_data[i +  48 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_64X16} : begin
                    for (i = 0; i < 16; i = i + 1) begin
                        if (i + rd_count_d1 < 16) begin
                            o_data[i * 4 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 4 + 1] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 4 + 2] <= rd_data[i +  32 + rd_count_d1];
                            o_data[i * 4 + 3] <= rd_data[i +  48 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 4 + 0] <= rd_data[i + -16 + rd_count_d1];
                            o_data[i * 4 + 1] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 4 + 2] <= rd_data[i +  16 + rd_count_d1];
                            o_data[i * 4 + 3] <= rd_data[i +  32 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_64X32} : begin
                    for (i = 0; i < 32; i = i + 1) begin
                        if (i + rd_count_d1 < 32) begin
                            o_data[i * 2 + 0] <= rd_data[i +  0 + rd_count_d1];
                            o_data[i * 2 + 1] <= rd_data[i +  32 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 2 + 0] <= rd_data[i + -32 + rd_count_d1];
                            o_data[i * 2 + 1] <= rd_data[i +  0 + rd_count_d1];
                        end
                    end
                end
                {MATRIX_64X64} : begin  
                    for (i = 0; i < 64; i = i + 1) begin
                        if (i + rd_count_d1 < 64) begin
                            o_data[i * 1 + 0] <= rd_data[i +  0 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 1 + 0] <= rd_data[i + -64 + rd_count_d1];
                        end
                    end
                end
                default        : begin
                    for (i = 0; i < 64; i = i + 1) begin
                        if (i + rd_count_d1 < 64) begin
                            o_data[i * 1 + 0] <= rd_data[i +  0 + rd_count_d1];
                        end
                        else begin
                            o_data[i * 1 + 0] <= rd_data[i + -64 + rd_count_d1];
                        end
                    end
                end
            endcase
        end
end

//assign read addr : continue read 0->127->0->127
always@(posedge clk or negedge rst_n)
    if(!rst_n) begin
        for (i = 0; i < 64; i = i + 1)
            rd_addr[ i ] <= 0; 
    end
    else if(read_flag) begin
        for (i = 0; i < 64; i = i + 1)
            rd_addr[ i ] <= rd_addr[ i ] + 1; 
end

//ram 64 * 128
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_0  (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[0 ]), .rd_data(rd_data[0 ]), .wr_addr(wr_addr[0 ]), .rd_addr(rd_addr[0 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_1  (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[1 ]), .rd_data(rd_data[1 ]), .wr_addr(wr_addr[1 ]), .rd_addr(rd_addr[1 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_2  (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[2 ]), .rd_data(rd_data[2 ]), .wr_addr(wr_addr[2 ]), .rd_addr(rd_addr[2 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_3  (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[3 ]), .rd_data(rd_data[3 ]), .wr_addr(wr_addr[3 ]), .rd_addr(rd_addr[3 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_4  (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[4 ]), .rd_data(rd_data[4 ]), .wr_addr(wr_addr[4 ]), .rd_addr(rd_addr[4 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_5  (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[5 ]), .rd_data(rd_data[5 ]), .wr_addr(wr_addr[5 ]), .rd_addr(rd_addr[5 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_6  (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[6 ]), .rd_data(rd_data[6 ]), .wr_addr(wr_addr[6 ]), .rd_addr(rd_addr[6 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_7  (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[7 ]), .rd_data(rd_data[7 ]), .wr_addr(wr_addr[7 ]), .rd_addr(rd_addr[7 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_8  (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[8 ]), .rd_data(rd_data[8 ]), .wr_addr(wr_addr[8 ]), .rd_addr(rd_addr[8 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_9  (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[9 ]), .rd_data(rd_data[9 ]), .wr_addr(wr_addr[9 ]), .rd_addr(rd_addr[9 ]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_10 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[10]), .rd_data(rd_data[10]), .wr_addr(wr_addr[10]), .rd_addr(rd_addr[10]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_11 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[11]), .rd_data(rd_data[11]), .wr_addr(wr_addr[11]), .rd_addr(rd_addr[11]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_12 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[12]), .rd_data(rd_data[12]), .wr_addr(wr_addr[12]), .rd_addr(rd_addr[12]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_13 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[13]), .rd_data(rd_data[13]), .wr_addr(wr_addr[13]), .rd_addr(rd_addr[13]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_14 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[14]), .rd_data(rd_data[14]), .wr_addr(wr_addr[14]), .rd_addr(rd_addr[14]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_15 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[15]), .rd_data(rd_data[15]), .wr_addr(wr_addr[15]), .rd_addr(rd_addr[15]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_16 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[16]), .rd_data(rd_data[16]), .wr_addr(wr_addr[16]), .rd_addr(rd_addr[16]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_17 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[17]), .rd_data(rd_data[17]), .wr_addr(wr_addr[17]), .rd_addr(rd_addr[17]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_18 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[18]), .rd_data(rd_data[18]), .wr_addr(wr_addr[18]), .rd_addr(rd_addr[18]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_19 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[19]), .rd_data(rd_data[19]), .wr_addr(wr_addr[19]), .rd_addr(rd_addr[19]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_20 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[20]), .rd_data(rd_data[20]), .wr_addr(wr_addr[20]), .rd_addr(rd_addr[20]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_21 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[21]), .rd_data(rd_data[21]), .wr_addr(wr_addr[21]), .rd_addr(rd_addr[21]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_22 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[22]), .rd_data(rd_data[22]), .wr_addr(wr_addr[22]), .rd_addr(rd_addr[22]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_23 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[23]), .rd_data(rd_data[23]), .wr_addr(wr_addr[23]), .rd_addr(rd_addr[23]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_24 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[24]), .rd_data(rd_data[24]), .wr_addr(wr_addr[24]), .rd_addr(rd_addr[24]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_25 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[25]), .rd_data(rd_data[25]), .wr_addr(wr_addr[25]), .rd_addr(rd_addr[25]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_26 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[26]), .rd_data(rd_data[26]), .wr_addr(wr_addr[26]), .rd_addr(rd_addr[26]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_27 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[27]), .rd_data(rd_data[27]), .wr_addr(wr_addr[27]), .rd_addr(rd_addr[27]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_28 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[28]), .rd_data(rd_data[28]), .wr_addr(wr_addr[28]), .rd_addr(rd_addr[28]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_29 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[29]), .rd_data(rd_data[29]), .wr_addr(wr_addr[29]), .rd_addr(rd_addr[29]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_30 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[30]), .rd_data(rd_data[30]), .wr_addr(wr_addr[30]), .rd_addr(rd_addr[30]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_31 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[31]), .rd_data(rd_data[31]), .wr_addr(wr_addr[31]), .rd_addr(rd_addr[31]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_32 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[32]), .rd_data(rd_data[32]), .wr_addr(wr_addr[32]), .rd_addr(rd_addr[32]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_33 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[33]), .rd_data(rd_data[33]), .wr_addr(wr_addr[33]), .rd_addr(rd_addr[33]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_34 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[34]), .rd_data(rd_data[34]), .wr_addr(wr_addr[34]), .rd_addr(rd_addr[34]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_35 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[35]), .rd_data(rd_data[35]), .wr_addr(wr_addr[35]), .rd_addr(rd_addr[35]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_36 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[36]), .rd_data(rd_data[36]), .wr_addr(wr_addr[36]), .rd_addr(rd_addr[36]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_37 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[37]), .rd_data(rd_data[37]), .wr_addr(wr_addr[37]), .rd_addr(rd_addr[37]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_38 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[38]), .rd_data(rd_data[38]), .wr_addr(wr_addr[38]), .rd_addr(rd_addr[38]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_39 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[39]), .rd_data(rd_data[39]), .wr_addr(wr_addr[39]), .rd_addr(rd_addr[39]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_40 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[40]), .rd_data(rd_data[40]), .wr_addr(wr_addr[40]), .rd_addr(rd_addr[40]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_41 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[41]), .rd_data(rd_data[41]), .wr_addr(wr_addr[41]), .rd_addr(rd_addr[41]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_42 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[42]), .rd_data(rd_data[42]), .wr_addr(wr_addr[42]), .rd_addr(rd_addr[42]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_43 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[43]), .rd_data(rd_data[43]), .wr_addr(wr_addr[43]), .rd_addr(rd_addr[43]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_44 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[44]), .rd_data(rd_data[44]), .wr_addr(wr_addr[44]), .rd_addr(rd_addr[44]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_45 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[45]), .rd_data(rd_data[45]), .wr_addr(wr_addr[45]), .rd_addr(rd_addr[45]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_46 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[46]), .rd_data(rd_data[46]), .wr_addr(wr_addr[46]), .rd_addr(rd_addr[46]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_47 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[47]), .rd_data(rd_data[47]), .wr_addr(wr_addr[47]), .rd_addr(rd_addr[47]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_48 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[48]), .rd_data(rd_data[48]), .wr_addr(wr_addr[48]), .rd_addr(rd_addr[48]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_49 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[49]), .rd_data(rd_data[49]), .wr_addr(wr_addr[49]), .rd_addr(rd_addr[49]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_50 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[50]), .rd_data(rd_data[50]), .wr_addr(wr_addr[50]), .rd_addr(rd_addr[50]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_51 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[51]), .rd_data(rd_data[51]), .wr_addr(wr_addr[51]), .rd_addr(rd_addr[51]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_52 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[52]), .rd_data(rd_data[52]), .wr_addr(wr_addr[52]), .rd_addr(rd_addr[52]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_53 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[53]), .rd_data(rd_data[53]), .wr_addr(wr_addr[53]), .rd_addr(rd_addr[53]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_54 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[54]), .rd_data(rd_data[54]), .wr_addr(wr_addr[54]), .rd_addr(rd_addr[54]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_55 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[55]), .rd_data(rd_data[55]), .wr_addr(wr_addr[55]), .rd_addr(rd_addr[55]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_56 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[56]), .rd_data(rd_data[56]), .wr_addr(wr_addr[56]), .rd_addr(rd_addr[56]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_57 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[57]), .rd_data(rd_data[57]), .wr_addr(wr_addr[57]), .rd_addr(rd_addr[57]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_58 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[58]), .rd_data(rd_data[58]), .wr_addr(wr_addr[58]), .rd_addr(rd_addr[58]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_59 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[59]), .rd_data(rd_data[59]), .wr_addr(wr_addr[59]), .rd_addr(rd_addr[59]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_60 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[60]), .rd_data(rd_data[60]), .wr_addr(wr_addr[60]), .rd_addr(rd_addr[60]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_61 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[61]), .rd_data(rd_data[61]), .wr_addr(wr_addr[61]), .rd_addr(rd_addr[61]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_62 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[62]), .rd_data(rd_data[62]), .wr_addr(wr_addr[62]), .rd_addr(rd_addr[62]));
    dual_port_ram#(.RAM_WIDTH(WIDTH),.ADDR_LINE(3'd7)) dual_port_ram_63 (.clk(clk), .wr_en(write_flag), .rd_en(read_flag), .wr_data(wr_data[63]), .rd_data(rd_data[63]), .wr_addr(wr_addr[63]), .rd_addr(rd_addr[63]));

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
    assign i_data[16] = i_data_d1[16];
    assign i_data[17] = i_data_d1[17];
    assign i_data[18] = i_data_d1[18];
    assign i_data[19] = i_data_d1[19];
    assign i_data[20] = i_data_d1[20];
    assign i_data[21] = i_data_d1[21];
    assign i_data[22] = i_data_d1[22];
    assign i_data[23] = i_data_d1[23];
    assign i_data[24] = i_data_d1[24];
    assign i_data[25] = i_data_d1[25];
    assign i_data[26] = i_data_d1[26];
    assign i_data[27] = i_data_d1[27];
    assign i_data[28] = i_data_d1[28];
    assign i_data[29] = i_data_d1[29];
    assign i_data[30] = i_data_d1[30];
    assign i_data[31] = i_data_d1[31];
    assign i_data[32] = i_data_d1[32];
    assign i_data[33] = i_data_d1[33];
    assign i_data[34] = i_data_d1[34];
    assign i_data[35] = i_data_d1[35];
    assign i_data[36] = i_data_d1[36];
    assign i_data[37] = i_data_d1[37];
    assign i_data[38] = i_data_d1[38];
    assign i_data[39] = i_data_d1[39];
    assign i_data[40] = i_data_d1[40];
    assign i_data[41] = i_data_d1[41];
    assign i_data[42] = i_data_d1[42];
    assign i_data[43] = i_data_d1[43];
    assign i_data[44] = i_data_d1[44];
    assign i_data[45] = i_data_d1[45];
    assign i_data[46] = i_data_d1[46];
    assign i_data[47] = i_data_d1[47];
    assign i_data[48] = i_data_d1[48];
    assign i_data[49] = i_data_d1[49];
    assign i_data[50] = i_data_d1[50];
    assign i_data[51] = i_data_d1[51];
    assign i_data[52] = i_data_d1[52];
    assign i_data[53] = i_data_d1[53];
    assign i_data[54] = i_data_d1[54];
    assign i_data[55] = i_data_d1[55];
    assign i_data[56] = i_data_d1[56];
    assign i_data[57] = i_data_d1[57];
    assign i_data[58] = i_data_d1[58];
    assign i_data[59] = i_data_d1[59];
    assign i_data[60] = i_data_d1[60];
    assign i_data[61] = i_data_d1[61];
    assign i_data[62] = i_data_d1[62];
    assign i_data[63] = i_data_d1[63];


//output
    assign o_valid  =   o_valid_d1 ;   
    assign o_height =   o_height_d1;
    assign o_width  =   o_width_d1 ;

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
    assign o_16     =   o_data[16];
    assign o_17     =   o_data[17];
    assign o_18     =   o_data[18];
    assign o_19     =   o_data[19];
    assign o_20     =   o_data[20];
    assign o_21     =   o_data[21];
    assign o_22     =   o_data[22];
    assign o_23     =   o_data[23];
    assign o_24     =   o_data[24];
    assign o_25     =   o_data[25];
    assign o_26     =   o_data[26];
    assign o_27     =   o_data[27];
    assign o_28     =   o_data[28];
    assign o_29     =   o_data[29];
    assign o_30     =   o_data[30];
    assign o_31     =   o_data[31];
    assign o_32     =   o_data[32];
    assign o_33     =   o_data[33];
    assign o_34     =   o_data[34];
    assign o_35     =   o_data[35];
    assign o_36     =   o_data[36];
    assign o_37     =   o_data[37];
    assign o_38     =   o_data[38];
    assign o_39     =   o_data[39];
    assign o_40     =   o_data[40];
    assign o_41     =   o_data[41];
    assign o_42     =   o_data[42];
    assign o_43     =   o_data[43];
    assign o_44     =   o_data[44];
    assign o_45     =   o_data[45];
    assign o_46     =   o_data[46];
    assign o_47     =   o_data[47];
    assign o_48     =   o_data[48];
    assign o_49     =   o_data[49];
    assign o_50     =   o_data[50];
    assign o_51     =   o_data[51];
    assign o_52     =   o_data[52];
    assign o_53     =   o_data[53];
    assign o_54     =   o_data[54];
    assign o_55     =   o_data[55];
    assign o_56     =   o_data[56];
    assign o_57     =   o_data[57];
    assign o_58     =   o_data[58];
    assign o_59     =   o_data[59];
    assign o_60     =   o_data[60];
    assign o_61     =   o_data[61];
    assign o_62     =   o_data[62];
    assign o_63     =   o_data[63];

endmodule


