`timescale 1ps / 1ps

module VGA_Display_Switch (
    input  logic clk,
    input  logic reset,
    output logic h_sync,
    output logic v_sync,
    output logic [3:0] r_port,
    output logic [3:0] g_port,
    output logic [3:0] b_port
);

    logic DE;
    logic [9:0] x_pixel;
    logic [9:0] y_pixel;

    // VGA 타이밍 생성
    VGA_Decoder U_VGA_DEC (
        .clk(clk),
        .reset(reset),
        .h_sync(h_sync),
        .v_sync(v_sync),
        .x_pixel(x_pixel),
        .y_pixel(y_pixel),
        .DE(DE)
    );

    // SMPTE Color Bar 출력
    VGA_RGB_SMPTE U_VGA_RGB_SW (
        .DE(DE),
        .x_pixel(x_pixel),
        .y_pixel(y_pixel),
        .r_port(r_port),
        .g_port(g_port),
        .b_port(b_port)
    );

endmodule

