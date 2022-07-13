//describe  : 存储一维变换的数据(64并入，64并出，对角线式存储结构)，存完后再进行第二次一维变换
//input     : 64个一维变换系数(一列),同时存到64个ram里
//output    : 存完一个矩阵后，取64个一维变换系数(一行)
//delay     : 1 clk(wr) + (height-1) clk(wait) + 1 clk(rd)
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

localparam  DCT_4  = 0,
            DCT_8  = 1,
            DCT_16 = 2,
            DCT_32 = 3,
            DCT_64 = 4;
//存储/读取周期
localparam [5:0] wr_count_max  = 6'd63;
localparam [5:0] rd_count_max  = 6'd31;

integer i;
reg     [2:0]i_width_d  [65:0];
reg     [2:0]i_height_d [65:0];
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin 
        for (i = 0; i < 66; i = i + 1) begin
            i_width_d[i] <= 0;
            i_height_d[i] <= 0;
        end
    end
    else begin
        i_width_d[0] <= i_width;
        for (i = 0; i < 5; i = i + 1) begin
            i_width_d[i + 1] <= i_width_d[i];
        end
    end
end

//input
    wire    signed [WIDTH - 1 : 0]  i_data[63 : 0];
    reg     signed [WIDTH - 1 : 0]  i_data_d1[63 : 0];
    //数据延迟一拍
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
    
    always@(posedge clk or negedge rst_n)
    if(!rst_n)begin
        for(i = 0; i<64;i= i+1)begin
            i_data_d1[i]    <=  0;
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
    

//ram
    reg i_valid_d1;
    reg i_upedge_flag;
    
    reg [5 : 0] count;
    reg rd_vaild;//0 : wr /  1 : rd
    
    reg write_enable[63:0];
    reg wen_i[63:0];
    
    wire ram_wr_n = ~i_upedge_flag;//ram write enable, low active
    wire ram_cs_n = (~i_upedge_flag) && (~rd_vaild);//ram读、写有效 chip enable, low active
    //存入地址：列(ram的地址)
    reg [4 : 0] addr[63 : 0];
    //选择存入对应ram的数据; 存入地址：行(第几个ram)          
    reg signed [WIDTH - 1 : 0] ram_wr_data[63 : 0];
    //读出的数据
    reg rd_vaild_d1;
    wire signed [WIDTH - 1 : 0] ram_rd_data[63 : 0];
//output
    reg signed [WIDTH - 1 : 0] o_data[63 : 0];
    reg [65:0]i_valid_d;
    
 //out_valid 延迟   
always@(posedge clk or negedge rst_n)
if(!rst_n)
    i_valid_d <= 0;
else
    i_valid_d <= {i_valid_d[64 : 0], i_valid};
//i_valid延迟一拍抓取上升沿
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) 
        i_valid_d1 <= 0;
    else 
        i_valid_d1 <= i_valid;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        i_upedge_flag <= 0;
    else if(i_valid & ~i_valid_d1)
        i_upedge_flag <= 1;
    else if(count == wr_count_max)
        i_upedge_flag <= 0;
end

//在读写阶段的计数器,读写一次+1
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count <= 0;
        rd_vaild <= 0;
    end
    else if (i_upedge_flag) begin//写
        if (count == wr_count_max) begin//写完
            if (i_upedge_flag) begin
                rd_vaild <= 1;
            end
            count <= 0;
        end
        else
            count <= count + 1;  
    end
    else if (rd_vaild) begin//读
        count <= count + 1;  
        if (count == rd_count_max) begin//读完
            if (rd_vaild) begin
                rd_vaild <= 0;
            end
        end
    end
    else
        count <= 0;
end

//write_enable is used to restrict the addr exceed 32
always@(*)
begin
    if (!rst_n) 
    begin
        for(i=0;i<64;i=i+1)
        begin
            wen_i[i] <= 1'b1;
        end
    end  
    else
    begin
        for(i=0;i<64;i=i+1)
        begin
            wen_i[i] <= ram_wr_n | write_enable[i];
        end
    end
end

//选择当前组每个ram存的数据和地址, 读出的地址
always @(*) begin
    for(i=0;i<64;i=i+1)
        write_enable[i] <= 1'b1;
    if (i_upedge_flag) begin//写数据和地址
        for (i = 0; i < 64; i = i + 1) begin//循环右移cnt输入数据
            if (i >= count) begin
                ram_wr_data[i] <= i_data[i - count];
                addr[i] <= i - count; 
                if( i-count > 31)
                    write_enable[i] <= 1;
                else
                    write_enable[i] <= 0;
            end
            else begin
                ram_wr_data[i] <= i_data[64 + i - count];
                addr[i] <= 64 + i - count; 
                if( 64 + i - count > 31)
                    write_enable[i] <= 1;
                else
                    write_enable[i] <= 0;
            end
        end
    end
    else if (rd_vaild) begin//读出地址
        for (i = 0; i < 64; i = i + 1) begin
            addr[i] <= count;
            ram_wr_data[i] <= 0;
        end
    end
    else begin
        for (i = 0; i < 64; i = i + 1) begin
            ram_wr_data[i] <= 0;
            addr[i] <= 0;
        end
    end  
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) 
        rd_vaild_d1 <= 0;
    else 
        rd_vaild_d1 <= rd_vaild;
end

//读出数据
always @(*) begin
    if (rd_vaild_d1) begin
        for (i = 0; i < 64; i = i + 1) begin//循环左移cnt输出数据
                if (i + count < 65) begin
                    o_data[i] <= ram_rd_data[i + count - 1];
                end
                else begin
                    o_data[i] <= ram_rd_data[i + count - 65];
                end
            end
    end
    else begin
        for (i = 0; i < 64; i = i + 1) begin
            o_data[i] <= 0;
        end
    end
end

//ram
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_0 (.data_o(ram_rd_data[0 ]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[0 ]), .addr_i(addr[0 ]), .data_i(ram_wr_data[0 ]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_1 (.data_o(ram_rd_data[1 ]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[1 ]), .addr_i(addr[1 ]), .data_i(ram_wr_data[1 ]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_2 (.data_o(ram_rd_data[2 ]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[2 ]), .addr_i(addr[2 ]), .data_i(ram_wr_data[2 ]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_3 (.data_o(ram_rd_data[3 ]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[3 ]), .addr_i(addr[3 ]), .data_i(ram_wr_data[3 ]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_4 (.data_o(ram_rd_data[4 ]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[4 ]), .addr_i(addr[4 ]), .data_i(ram_wr_data[4 ]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_5 (.data_o(ram_rd_data[5 ]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[5 ]), .addr_i(addr[5 ]), .data_i(ram_wr_data[5 ]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_6 (.data_o(ram_rd_data[6 ]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[6 ]), .addr_i(addr[6 ]), .data_i(ram_wr_data[6 ]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_7 (.data_o(ram_rd_data[7 ]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[7 ]), .addr_i(addr[7 ]), .data_i(ram_wr_data[7 ]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_8 (.data_o(ram_rd_data[8 ]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[8 ]), .addr_i(addr[8 ]), .data_i(ram_wr_data[8 ]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_9 (.data_o(ram_rd_data[9 ]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[9 ]), .addr_i(addr[9 ]), .data_i(ram_wr_data[9 ]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_10(.data_o(ram_rd_data[10]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[10]), .addr_i(addr[10]), .data_i(ram_wr_data[10]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_11(.data_o(ram_rd_data[11]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[11]), .addr_i(addr[11]), .data_i(ram_wr_data[11]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_12(.data_o(ram_rd_data[12]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[12]), .addr_i(addr[12]), .data_i(ram_wr_data[12]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_13(.data_o(ram_rd_data[13]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[13]), .addr_i(addr[13]), .data_i(ram_wr_data[13]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_14(.data_o(ram_rd_data[14]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[14]), .addr_i(addr[14]), .data_i(ram_wr_data[14]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_15(.data_o(ram_rd_data[15]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[15]), .addr_i(addr[15]), .data_i(ram_wr_data[15]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_16(.data_o(ram_rd_data[16]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[16]), .addr_i(addr[16]), .data_i(ram_wr_data[16]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_17(.data_o(ram_rd_data[17]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[17]), .addr_i(addr[17]), .data_i(ram_wr_data[17]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_18(.data_o(ram_rd_data[18]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[18]), .addr_i(addr[18]), .data_i(ram_wr_data[18]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_19(.data_o(ram_rd_data[19]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[19]), .addr_i(addr[19]), .data_i(ram_wr_data[19]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_20(.data_o(ram_rd_data[20]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[20]), .addr_i(addr[20]), .data_i(ram_wr_data[20]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_21(.data_o(ram_rd_data[21]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[21]), .addr_i(addr[21]), .data_i(ram_wr_data[21]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_22(.data_o(ram_rd_data[22]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[22]), .addr_i(addr[22]), .data_i(ram_wr_data[22]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_23(.data_o(ram_rd_data[23]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[23]), .addr_i(addr[23]), .data_i(ram_wr_data[23]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_24(.data_o(ram_rd_data[24]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[24]), .addr_i(addr[24]), .data_i(ram_wr_data[24]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_25(.data_o(ram_rd_data[25]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[25]), .addr_i(addr[25]), .data_i(ram_wr_data[25]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_26(.data_o(ram_rd_data[26]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[26]), .addr_i(addr[26]), .data_i(ram_wr_data[26]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_27(.data_o(ram_rd_data[27]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[27]), .addr_i(addr[27]), .data_i(ram_wr_data[27]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_28(.data_o(ram_rd_data[28]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[28]), .addr_i(addr[28]), .data_i(ram_wr_data[28]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_29(.data_o(ram_rd_data[29]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[29]), .addr_i(addr[29]), .data_i(ram_wr_data[29]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_30(.data_o(ram_rd_data[30]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[30]), .addr_i(addr[30]), .data_i(ram_wr_data[30]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_31(.data_o(ram_rd_data[31]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[31]), .addr_i(addr[31]), .data_i(ram_wr_data[31]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_32(.data_o(ram_rd_data[32]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[32]), .addr_i(addr[32]), .data_i(ram_wr_data[32]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_33(.data_o(ram_rd_data[33]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[33]), .addr_i(addr[33]), .data_i(ram_wr_data[33]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_34(.data_o(ram_rd_data[34]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[34]), .addr_i(addr[34]), .data_i(ram_wr_data[34]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_35(.data_o(ram_rd_data[35]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[35]), .addr_i(addr[35]), .data_i(ram_wr_data[35]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_36(.data_o(ram_rd_data[36]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[36]), .addr_i(addr[36]), .data_i(ram_wr_data[36]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_37(.data_o(ram_rd_data[37]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[37]), .addr_i(addr[37]), .data_i(ram_wr_data[37]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_38(.data_o(ram_rd_data[38]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[38]), .addr_i(addr[38]), .data_i(ram_wr_data[38]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_39(.data_o(ram_rd_data[39]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[39]), .addr_i(addr[39]), .data_i(ram_wr_data[39]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_40(.data_o(ram_rd_data[40]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[40]), .addr_i(addr[40]), .data_i(ram_wr_data[40]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_41(.data_o(ram_rd_data[41]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[41]), .addr_i(addr[41]), .data_i(ram_wr_data[41]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_42(.data_o(ram_rd_data[42]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[42]), .addr_i(addr[42]), .data_i(ram_wr_data[42]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_43(.data_o(ram_rd_data[43]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[43]), .addr_i(addr[43]), .data_i(ram_wr_data[43]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_44(.data_o(ram_rd_data[44]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[44]), .addr_i(addr[44]), .data_i(ram_wr_data[44]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_45(.data_o(ram_rd_data[45]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[45]), .addr_i(addr[45]), .data_i(ram_wr_data[45]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_46(.data_o(ram_rd_data[46]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[46]), .addr_i(addr[46]), .data_i(ram_wr_data[46]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_47(.data_o(ram_rd_data[47]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[47]), .addr_i(addr[47]), .data_i(ram_wr_data[47]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_48(.data_o(ram_rd_data[48]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[48]), .addr_i(addr[48]), .data_i(ram_wr_data[48]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_49(.data_o(ram_rd_data[49]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[49]), .addr_i(addr[49]), .data_i(ram_wr_data[49]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_50(.data_o(ram_rd_data[50]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[50]), .addr_i(addr[50]), .data_i(ram_wr_data[50]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_51(.data_o(ram_rd_data[51]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[51]), .addr_i(addr[51]), .data_i(ram_wr_data[51]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_52(.data_o(ram_rd_data[52]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[52]), .addr_i(addr[52]), .data_i(ram_wr_data[52]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_53(.data_o(ram_rd_data[53]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[53]), .addr_i(addr[53]), .data_i(ram_wr_data[53]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_54(.data_o(ram_rd_data[54]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[54]), .addr_i(addr[54]), .data_i(ram_wr_data[54]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_55(.data_o(ram_rd_data[55]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[55]), .addr_i(addr[55]), .data_i(ram_wr_data[55]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_56(.data_o(ram_rd_data[56]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[56]), .addr_i(addr[56]), .data_i(ram_wr_data[56]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_57(.data_o(ram_rd_data[57]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[57]), .addr_i(addr[57]), .data_i(ram_wr_data[57]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_58(.data_o(ram_rd_data[58]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[58]), .addr_i(addr[58]), .data_i(ram_wr_data[58]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_59(.data_o(ram_rd_data[59]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[59]), .addr_i(addr[59]), .data_i(ram_wr_data[59]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_60(.data_o(ram_rd_data[60]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[60]), .addr_i(addr[60]), .data_i(ram_wr_data[60]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_61(.data_o(ram_rd_data[61]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[61]), .addr_i(addr[61]), .data_i(ram_wr_data[61]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_62(.data_o(ram_rd_data[62]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[62]), .addr_i(addr[62]), .data_i(ram_wr_data[62]), .oen_i(1'b0));
    ram_1p#(.Addr_Width(5), .Word_Width(WIDTH)) ram_1p_63(.data_o(ram_rd_data[63]), .clk(clk), .cen_i(ram_cs_n), .wen_i(wen_i[63]), .addr_i(addr[63]), .data_i(ram_wr_data[63]), .oen_i(1'b0));
  
//output
    assign o_valid = i_valid_d[65];
    assign o_width = i_width_d[65];
    assign o_height = i_height_d[65];
    assign o_0  = o_data[0 ];
    assign o_1  = o_data[1 ];
    assign o_2  = o_data[2 ];
    assign o_3  = o_data[3 ];
    assign o_4  = o_data[4 ];
    assign o_5  = o_data[5 ];
    assign o_6  = o_data[6 ];
    assign o_7  = o_data[7 ];
    assign o_8  = o_data[8 ];
    assign o_9  = o_data[9 ];
    assign o_10 = o_data[10];
    assign o_11 = o_data[11];
    assign o_12 = o_data[12];
    assign o_13 = o_data[13];
    assign o_14 = o_data[14];
    assign o_15 = o_data[15];
    assign o_16 = o_data[16];
    assign o_17 = o_data[17];
    assign o_18 = o_data[18];
    assign o_19 = o_data[19];
    assign o_20 = o_data[20];
    assign o_21 = o_data[21];
    assign o_22 = o_data[22];
    assign o_23 = o_data[23];
    assign o_24 = o_data[24];
    assign o_25 = o_data[25];
    assign o_26 = o_data[26];
    assign o_27 = o_data[27];
    assign o_28 = o_data[28];
    assign o_29 = o_data[29];
    assign o_30 = o_data[30];
    assign o_31 = o_data[31];
    assign o_32 = o_data[32];
    assign o_33 = o_data[33];
    assign o_34 = o_data[34];
    assign o_35 = o_data[35];
    assign o_36 = o_data[36];
    assign o_37 = o_data[37];
    assign o_38 = o_data[38];
    assign o_39 = o_data[39];
    assign o_40 = o_data[40];
    assign o_41 = o_data[41];
    assign o_42 = o_data[42];
    assign o_43 = o_data[43];
    assign o_44 = o_data[44];
    assign o_45 = o_data[45];
    assign o_46 = o_data[46];
    assign o_47 = o_data[47];
    assign o_48 = o_data[48];
    assign o_49 = o_data[49];
    assign o_50 = o_data[50];
    assign o_51 = o_data[51];
    assign o_52 = o_data[52];
    assign o_53 = o_data[53];
    assign o_54 = o_data[54];
    assign o_55 = o_data[55];
    assign o_56 = o_data[56];
    assign o_57 = o_data[57];
    assign o_58 = o_data[58];
    assign o_59 = o_data[59];
    assign o_60 = o_data[60];
    assign o_61 = o_data[61];
    assign o_62 = o_data[62];
    assign o_63 = o_data[63];

endmodule
