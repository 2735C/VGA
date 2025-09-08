`timescale 1ps / 1ps

module VGA_RGB_SMPTE (
    input  logic       DE,
    input  logic [9:0] x_pixel,
    input  logic [9:0] y_pixel,
    output logic [3:0] r_port,
    output logic [3:0] g_port,
    output logic [3:0] b_port
);

    logic [11:0] RGB; // {R[3:0], G[3:0], B[3:0]}

    always_comb begin
        if (DE) begin
            // =========================
            // 상단: 0 ~ 299 (가로 8개 컬러)
            // =========================
            if (y_pixel < 300) begin
                if (x_pixel <= 91)        RGB = {4'hF,4'hF,4'hF}; // White
                else if (x_pixel <= 183)  RGB = {4'hF,4'hF,4'h0}; // Yellow
                else if (x_pixel <= 274)  RGB = {4'h0,4'hF,4'hF}; // Cyan
                else if (x_pixel <= 366)  RGB = {4'h0,4'hF,4'h0}; // Green
                else if (x_pixel <= 457)  RGB = {4'hF,4'h0,4'hF}; // Magenta
                else if (x_pixel <= 549)  RGB = {4'hF,4'h0,4'h0}; // Red
                else                       RGB = {4'h0,4'h0,4'hF}; // Blue
            end
            // =========================
            // 중단: 300 ~ 339 (가로 7개 색상 + 검정)
            // =========================
            else if (y_pixel < 340) begin
                if (x_pixel <= 91)        RGB = {4'h0,4'h0,4'hF}; // Blue
                else if (x_pixel <= 183)  RGB = {4'h0,4'h0,4'h0}; // Black
                else if (x_pixel <= 274)  RGB = {4'hF,4'h0,4'hF}; // Magenta
                else if (x_pixel <= 366)  RGB = {4'h0,4'h0,4'h0}; // Black
                else if (x_pixel <= 457)  RGB = {4'h0,4'hF,4'hF}; // Cyan
                else if (x_pixel <= 549)  RGB = {4'h0,4'h0,4'h0}; // Black
                else                       RGB = {4'hF,4'hF,4'hF}; // White
            end
            // =========================
            // 하단: 340 ~ 524 (가로 그레이 스케일 + 검정/화이트)
            // =========================
            else begin
                if (x_pixel <= 114)        RGB = {4'h0,4'h0,4'h8}; // Dark Blue
                else if (x_pixel <= 228)   RGB = {4'hF,4'hF,4'hF}; // White
                else if (x_pixel <= 342)   RGB = {4'h8,4'h0,4'h8}; // Purple
                else if (x_pixel <= 457)   RGB = {4'h0,4'h0,4'h0}; // Black
                else if (x_pixel <= 487)   RGB = {4'h1,4'h1,4'h1}; // Dark Gray
                else if (x_pixel <= 518)   RGB = {4'h3,4'h3,4'h3}; // Gray
                else if (x_pixel <= 548)   RGB = {4'h4,4'h4,4'h4}; // Light Gray
                else                        RGB = {4'h0,4'h0,4'h0}; // Black
            end
        end else begin
            RGB = 12'h000;
        end
    end

    assign r_port = RGB[11:8];
    assign g_port = RGB[7:4];
    assign b_port = RGB[3:0];

endmodule
