module \$__RAM_1024x8_1RW_ (...);

    parameter INIT = 0;

    // 1 for posedge clocks and 0 for negedge
    parameter PORT_A_CLK_POL = 1;

    localparam WIDTH = 8;
    localparam ABITS = 10;

    input  PORT_A_CLK;
    input  PORT_A_CLK_EN;
    input  [WIDTH-1:0] PORT_A_WR_DATA;
    input  [ABITS-1:0] PORT_A_ADDR;
    input  PORT_A_WR_EN;
    input  [WIDTH-1:0] PORT_A_WR_BE;
    output [WIDTH-1:0] PORT_A_RD_DATA;

    GF_SRAM_1024x8_1RW #(
        .INIT_0(INIT[255:0]),
        .INIT_1(INIT[511:256]),
        .INIT_2(INIT[767:512]),
        .INIT_3(INIT[1023:768]),
        .INIT_4(INIT[1279:1024]),
        .INIT_5(INIT[1535:1280]),
        .INIT_6(INIT[1791:1536]),
        .INIT_7(INIT[2047:1792]),
        .INIT_8(INIT[2303:2048]),
        .INIT_9(INIT[2559:2304]),
        .INIT_10(INIT[2815:2560]),
        .INIT_11(INIT[3071:2816]),
        .INIT_12(INIT[3327:3072]),
        .INIT_13(INIT[3583:3328]),
        .INIT_14(INIT[3839:3584]),
        .INIT_15(INIT[4095:3840]),
        .INIT_16(INIT[4351:4096]),
        .INIT_17(INIT[4607:4352]),
        .INIT_18(INIT[4863:4608]),
        .INIT_19(INIT[5119:4864]),
        .INIT_20(INIT[5375:5120]),
        .INIT_21(INIT[5631:5376]),
        .INIT_22(INIT[5887:5632]),
        .INIT_23(INIT[6143:5888]),
        .INIT_24(INIT[6399:6144]),
        .INIT_25(INIT[6655:6400]),
        .INIT_26(INIT[6911:6656]),
        .INIT_27(INIT[7167:6912]),
        .INIT_28(INIT[7423:7168]),
        .INIT_29(INIT[7679:7424]),
        .INIT_30(INIT[7935:7680]),
        .INIT_31(INIT[8191:7936]),
        .CLK_INV (PORT_A_CLK_POL != 1'b1)
    ) _TECHMAP_REPLACE_ (
        // Port A - Read/Write
        .CLK    (PORT_A_CLK),
        .ADDR0  (PORT_A_ADDR[0]),
        .ADDR1  (PORT_A_ADDR[1]),
        .ADDR2  (PORT_A_ADDR[2]),
        .ADDR3  (PORT_A_ADDR[3]),
        .ADDR4  (PORT_A_ADDR[4]),
        .ADDR5  (PORT_A_ADDR[5]),
        .ADDR6  (PORT_A_ADDR[6]),
        .ADDR7  (PORT_A_ADDR[7]),
        .ADDR8  (PORT_A_ADDR[8]),
        .ADDR9  (PORT_A_ADDR[9]),
        .DIN0   (PORT_A_WR_DATA[0]),
        .DIN1   (PORT_A_WR_DATA[1]),
        .DIN2   (PORT_A_WR_DATA[2]),
        .DIN3   (PORT_A_WR_DATA[3]),
        .DIN4   (PORT_A_WR_DATA[4]),
        .DIN5   (PORT_A_WR_DATA[5]),
        .DIN6   (PORT_A_WR_DATA[6]),
        .DIN7   (PORT_A_WR_DATA[7]),
        .BM0    (PORT_A_WR_BE[0]),
        .BM1    (PORT_A_WR_BE[1]),
        .BM2    (PORT_A_WR_BE[2]),
        .BM3    (PORT_A_WR_BE[3]),
        .BM4    (PORT_A_WR_BE[4]),
        .BM5    (PORT_A_WR_BE[5]),
        .BM6    (PORT_A_WR_BE[6]),
        .BM7    (PORT_A_WR_BE[7]),
        .WEN    (PORT_A_WR_EN),
        .MEN    (PORT_A_CLK_EN),
        .DOUT0  (PORT_A_RD_DATA[0]),
        .DOUT1  (PORT_A_RD_DATA[1]),
        .DOUT2  (PORT_A_RD_DATA[2]),
        .DOUT3  (PORT_A_RD_DATA[3]),
        .DOUT4  (PORT_A_RD_DATA[4]),
        .DOUT5  (PORT_A_RD_DATA[5]),
        .DOUT6  (PORT_A_RD_DATA[6]),
        .DOUT7  (PORT_A_RD_DATA[7])
    );

endmodule
