module zero_cross_pulse (
    input  wire clk,      // clock de 27 MHz
    input  wire sinc,     // sinal de zero crossing (qualquer borda)
    output reg  ctr1      // pulso de saída
);

    // =============================
    // Detecta qualquer borda em SINC
    // =============================
    reg sinc_d = 0;
    wire sinc_edge;

    always @(posedge clk) sinc_d <= sinc;
    assign sinc_edge = sinc ^ sinc_d; // XOR detecta subida ou descida

    // =============================
    // Contador de delay (4,17 ms)
    // =============================
    reg [17:0] delay_counter = 0;  // 18 bits suficiente para 112.590
    reg delay_active = 0;

    // =============================
    // Contador de pulso (1 ms)
    // =============================
    reg [15:0] pulse_counter = 0;  // 16 bits suficiente para 27.000
    reg pulse_active = 0;

    always @(posedge clk) begin
        // Detecção de borda: inicia o delay
        if (sinc_edge) begin
            delay_active <= 1;
            delay_counter <= 0;
        end

        // Delay de 4,17 ms
        if (delay_active) begin
            if (delay_counter >= 112590 - 1) begin
                delay_active <= 0;
                pulse_active <= 1;
                pulse_counter <= 0;
            end else begin
                delay_counter <= delay_counter + 1;
            end
        end

        // Pulso de 1 ms
        if (pulse_active) begin
            ctr1 <= 1;
            if (pulse_counter >= 27000 - 1) begin
                pulse_active <= 0;
                ctr1 <= 0;
            end else begin
                pulse_counter <= pulse_counter + 1;
            end
        end else begin
            ctr1 <= 0;
        end
    end

endmodule
