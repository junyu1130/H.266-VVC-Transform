# H.266-VVC-Transform

### 指标

- Pipeline Structure
- Throughput Rate : 16 samples/cycle
- Transpose Memory : Dual-Port Ram 16x256x16 bits 
- Transform Type : DCT2/DCT8/DST7

### 版本记录

| 时间      | 备注                                 | LUT    | FF     | RAM(bits)        | Fmax(MHz) |
| --------- | ------------------------------------ | ------ | ------ | ---------------- | --------- |
| 2022.5    | 非流水线结构                         | 54530  | 14271  | 64x64x16         | 107       |
| 2022.7.19 | 64并行度，流水线，拼接               |        |        | 64x128x16        |           |
| 2022.7.26 | 16并行度，支持DCT2/DST7/DCT8         | 141590 | 89520  | 16x256x16        | 51        |
| 2022.7.28 | 优化：添加寄存器层次                 | 141441 | 107585 | 16x256x16        | 97        |
| 2022.7.30 | 优化：较短路径加长，中间数据位宽调整 | 136154 | 61400  | 16x256x16        | 102       |
| 2022.8.9  | <v1.3>用FIFO替代寄存器打拍缓存块信息 | 134924 | 59221  | 16x256x16+128x10 | 108       |
| 2022.8.10 | <v1.4>时序换面积                     | 134768 | 55097  | 16x256x16+128x10 | 106       |

### 1D-Transform模块

| 时间      | 备注                       | LUT    | FF     | Fmax(MHz) |
| --------- | -------------------------- | ------ | ------ | --------- |
| 2022.5    | 非流水线结构（面积最小）   | 41623  | 13065  | 107       |
| 2022.7.15 | 1D-DCT模块：流水线，不拼接 | 66563  | 27533  | 140       |
| 2022.7.16 | 1D-DCT模块：64并行度，拼接 | 131349 | 92197  | 140       |
| 2022.7.20 | 1D-DCT模块：16并行度       | 74108  | 54884  | 148       |
| 2022.7.26 | 支持DCT2/DST7/DCT8         | 121788 | 86267  | 57        |
| 2022.7.28 | 优化                       | 122346 | 104326 | 97        |

