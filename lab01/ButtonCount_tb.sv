//////////////////////////////////////////////////////////////////////////////////
// ButtonCount_tb testbench
//////////////////////////////////////////////////////////////////////////////////

module ButtonCount_tb ();

    logic clk, btnc, btnu;
    logic [15:0] led;
    localparam NUM_INITIAL_TOGGLES = 11;
    localparam NUM_SECONDARY_TOGGLES = 17;
    integer clk_cnts;
    logic [15:0] led_d;


    // ButtonCount DUT
    ButtonCount dut (.clk(clk), .btnc(btnc), .btnu(btnu), .led(led));

    //////////////////////////////////////////////////////////////////////////////////
    // Clock Generator
    //////////////////////////////////////////////////////////////////////////////////
    always
    begin
        #5ns clk <=1;
        #5ns clk <=0;
    end

    // Always block to monitor the led output
    always_ff@(posedge clk) begin
        led_d <= led;
        if (led !== led_d) begin
            $display("[%0t] LED value: %0d", $time, led);
        end
    end

    // Task for presing buttons
    task press_buttons(integer num_presses);
        for(int i = 0; i < num_presses; i++) begin
            btnu = 1;
            // $display("[%0t] BTNU pressed", $time);
            clk_cnts = $urandom_range(5,20);
            repeat(clk_cnts) @(posedge clk);
            btnu = 0;
            clk_cnts = $urandom_range(25,100);
            repeat(clk_cnts) @(posedge clk);
        end
    endtask

    //////////////////////////////////
    // Main Test Bench Process
    //////////////////////////////////
    initial begin
        $display("===== ButtonCount Testbench =====");

        // Simulate some time with no stimulus/reset
        #100ns

        // Set  defaults
        btnu = 0;
        btnc = 0;
        #100ns

        // Test Reset
        $display("[%0t] Testing Reset", $time);
        btnc = 1;
        #80ns;
        // Un reset on negative edge
        @(negedge clk)
        $display("[%0t] Release Reset", $time);
        btnc = 0;

        #1us;
        press_buttons(NUM_INITIAL_TOGGLES);
        btnc = 1;
        $display("[%0t] Reset", $time);
        #80ns;
        btnc = 0;
        #1us;
        press_buttons(NUM_SECONDARY_TOGGLES);

        $display("[%0t] End of Simuation", $time);

        $finish;
    end

endmodule
