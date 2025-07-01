module PWM (
    input wire clk,
    input wire rst_n,
    input wire [15:0] duty_cycle, // duty_cycle = period * duty_porcent, 0 <= duty_porcent <= 1
    input wire [15:0] period, // clk_freq / pwm_freq = period
    output reg pwm_out
);
    reg [15:0] counter;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 16'd0;
            pwm_out <= 1'b0;
        end else begin
            if (counter < period - 1)
                counter <= counter + 16'd1;
            else
                counter <= 16'd0;
            // compara contra duty_cycle
            if (counter < duty_cycle)
                pwm_out <= 1'b1;
            else
                pwm_out <= 1'b0;
        end
    end
endmodule
