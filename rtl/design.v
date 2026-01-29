//==============================================
// DMA Design 
//==============================================
module dma_design (
    input  logic        clk,
    input  logic        rst_n,

    // Register Interface
    input  logic        wr_en,
    input  logic        rd_en,
    input  logic [31:0] wdata,
    input  logic [31:0] addr,
    output logic [31:0] rdata
);

    //===========================================
    // Register Addresses
    //===========================================
    parameter INTR_ADDR           = 32'h400;
    parameter CTRL_ADDR           = 32'h404;
    parameter STATUS_ADDR         = 32'h414;
    parameter TRANSFER_COUNT_ADDR = 32'h418;
    parameter ERROR_STATUS_ADDR   = 32'h420;
    parameter CONFIG_ADDR         = 32'h424;

    //===========================================
    // Register Declarations
    //===========================================

    logic [15:0] intr_status;
    logic [15:0] intr_mask;

    logic        ctrl_start_dma;
    logic [14:0] ctrl_w_count;
    logic        ctrl_io_mem;

    logic        status_busy;
    logic        status_done;
    logic        status_error;
    logic        status_paused;
    logic [3:0]  status_current_state;
    logic [7:0]  status_fifo_level;

    logic [31:0] transfer_count;

    logic        error_bus;
    logic        error_timeout;
    logic        error_alignment;
    logic        error_overflow;
    logic        error_underflow;
    logic [7:0]  error_code;
    logic [15:0] error_addr_offset;

    logic [1:0]  config_priority;
    logic        config_auto_restart;
    logic        config_interrupt_enable;
    logic [1:0]  config_burst_size;
    logic [1:0]  config_data_width;
    logic        config_descriptor_mode;

    //===========================================
    // WRITE OPERATION
    //===========================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            intr_mask   <= 16'h0;
            ctrl_start_dma <= 1'b0;
            ctrl_w_count   <= 15'h0;
            ctrl_io_mem    <= 1'b0;

            error_bus       <= 1'b0;
            error_timeout   <= 1'b0;
            error_alignment <= 1'b0;
            error_overflow  <= 1'b0;
            error_underflow <= 1'b0;

            config_priority         <= 2'b00;
            config_auto_restart     <= 1'b0;
            config_interrupt_enable <= 1'b0;
            config_burst_size       <= 2'b00;
            config_data_width       <= 2'b00;
            config_descriptor_mode  <= 1'b0;
        end
        else if (wr_en) begin
            case (addr)

                CTRL_ADDR: begin
                    ctrl_start_dma <= wdata[0];
                    ctrl_w_count   <= wdata[15:1];
                    ctrl_io_mem    <= wdata[16];
                end

                ERROR_STATUS_ADDR: begin
                    if (wdata[0]) error_bus       <= 1'b0;
                    if (wdata[1]) error_timeout   <= 1'b0;
                    if (wdata[2]) error_alignment <= 1'b0;
                    if (wdata[3]) error_overflow  <= 1'b0;
                    if (wdata[4]) error_underflow <= 1'b0;
                end

                CONFIG_ADDR: begin
                    config_priority         <= wdata[1:0];
                    config_auto_restart     <= wdata[2];
                    config_interrupt_enable <= wdata[3];
                    config_burst_size       <= wdata[5:4];
                    config_data_width       <= wdata[7:6];
                    config_descriptor_mode  <= wdata[8];
                end
            endcase
        end
        else begin
            if (ctrl_start_dma)
                ctrl_start_dma <= 1'b0;
        end
    end

    //===========================================
    // READ OPERATION
    //===========================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            rdata <= 32'h0;
        else if (rd_en) begin
            case (addr)

                CTRL_ADDR:
                    rdata <= {15'h0, ctrl_io_mem, ctrl_w_count, ctrl_start_dma};

                STATUS_ADDR: begin
                    rdata <= {16'h0,
                              status_current_state,   // should be [7:4]
                              status_fifo_level,      // should be [15:8]
                              status_paused,
                              status_error,
                              status_done,
                              status_busy};
                end

                TRANSFER_COUNT_ADDR:
                    rdata <= transfer_count;

                ERROR_STATUS_ADDR:
                    rdata <= {error_addr_offset, error_code,
                              3'b0,
                              error_underflow,
                              error_overflow,
                              error_alignment,
                              error_timeout,
                              error_bus};

                CONFIG_ADDR:
                    rdata <= {23'h0,
                              config_descriptor_mode,
                              config_data_width,
                              config_burst_size,
                              config_interrupt_enable,
                              config_auto_restart,
                              config_priority};

                default:
                    rdata <= 32'h0;
            endcase
        end
    end

    //===========================================
    // DMA LOGIC (STATUS UPDATES)
    //===========================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            intr_status          <= 16'h0;
            status_busy          <= 1'b0;
            status_done          <= 1'b0;
            status_error         <= 1'b0;
            status_paused        <= 1'b0;
            status_current_state <= 4'h0;
            status_fifo_level    <= 8'h0;
            transfer_count       <= 32'h0;
            error_code           <= 8'h0;
            error_addr_offset    <= 16'h0;
        end
        else begin
            if (ctrl_start_dma) begin
                status_busy          <= 1'b1;
                status_done          <= 1'b0;
                status_current_state <= 4'h1;
                transfer_count       <= 32'h0;
            end
            else if (status_busy) begin
                transfer_count <= transfer_count + 1;

                if (transfer_count >= {17'h0, ctrl_w_count}) begin
                    status_busy          <= 1'b0;
                    status_done          <= 1'b1;
                    status_current_state <= 4'h0;
                    intr_status[0]       <= 1'b1;
                end

                status_fifo_level <= transfer_count[7:0];
            end

        end
    end

endmodule


