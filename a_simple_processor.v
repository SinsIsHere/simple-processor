module a_simple_processor (
    input clock, run, input [8:0] DIN, output reg done, output reg [8:0] BusWire, output [8:0] IR, output reg [2:0] Ystep_Q, output [8:0] R0, R1, RA, RG
);
    parameter T0 = 3'd0, T1 = 3'd1, T2 = 3'd2, T3 = 3'd3;

    wire [2:0] I;

    reg IRin;
    reg [0:7] Rin;
    reg RAin;
    reg RGin;

    reg [8:0] Rx;
    reg [8:0] Ry;
    wire [8:0] R2;
    wire [8:0] R3;
    wire [8:0] R4;
    wire [8:0] R5;
    wire [8:0] R6;
    wire [8:0] R7;

    wire [2:0] Xreg;
    wire [2:0] Yreg;

    reg [2:0] Ystep_D;

    assign I = IR[8:6];
    assign Xreg = IR[5:3];
    assign Yreg = IR[2:0];

    always @(Ystep_Q, run, I) begin
        case (Ystep_Q)
            T0: begin
                if (run) begin
                    Ystep_D = T1;
                end else begin
                    Ystep_D = T0;
                end
            end

            T1: begin
                case (I)
                    0: Ystep_D = T0;

                    1: Ystep_D = T0;

                    2: Ystep_D = T2;

                    3: Ystep_D = T2;

                    default: Ystep_D = T0;
                endcase
            end

            T2: Ystep_D = T3;

            T3: Ystep_D = T0;

            default: Ystep_D = 3'bxxx;
        endcase
    end

    always @(Ystep_Q, I, Xreg, Yreg) begin
		  done = 0;
          IRin = 0;
          Rin = 0;
          RAin = 0;
          RGin = 0;
	 
        case (Ystep_Q)
            T0: begin
                BusWire = DIN;
                IRin = 1;
                case (Xreg)
                    0: Rx = R0;
                    1: Rx = R1;
                    2: Rx = R2;
                    3: Rx = R3;
                    4: Rx = R4;
                    5: Rx = R5;
                    6: Rx = R6;
                    7: Rx = R7;
                    default: Rx = 0;
                endcase
                case (Yreg)
                    0: Ry = R0;
                    1: Ry = R1;
                    2: Ry = R2;
                    3: Ry = R3;
                    4: Ry = R4;
                    5: Ry = R5;
                    6: Ry = R6;
                    7: Ry = R7; 
                    default: Ry = 0;
                endcase
            end

            T1: begin
                case (I)
                    0: begin
                        BusWire = Ry;
                        case (Xreg)
                            0: Rin[0] = 1;
                            1: Rin[1] = 1;
                            2: Rin[2] = 1;
                            3: Rin[3] = 1;
                            4: Rin[4] = 1;
                            5: Rin[5] = 1;
                            6: Rin[6] = 1;
                            7: Rin[7] = 1;
                            default: Rin = 0;
                        endcase
                        done = 1;
                    end

                    1: begin
                        BusWire = DIN;
                        case (Xreg)
                            0: Rin[0] = 1;
                            1: Rin[1] = 1;
                            2: Rin[2] = 1;
                            3: Rin[3] = 1;
                            4: Rin[4] = 1;
                            5: Rin[5] = 1;
                            6: Rin[6] = 1;
                            7: Rin[7] = 1;
                            default: Rin = 0;
                        endcase
                        done = 1;
                    end

                    2: begin
                        BusWire = Rx;
                        RAin = 1;
                        done = 0;
                    end

                    3: begin
                        BusWire = Rx;
                        RAin = 1;
                        done = 0;
                    end

                    default: done = 0;
                endcase
            end

            T2: begin
                case (I)
                    0: begin
                        done = 0;
                    end

                    1: begin
                        done = 0;
                    end

                    2: begin
                        BusWire = Ry;
                        done = 0;
                    end

                    3: begin
                        BusWire = Ry;                        
                        done = 0;
                    end

                    default: done = 0;
                endcase
            end

            T3: begin
                case (I)
                    0: begin
                        done = 0;
                    end

                    1: begin
                        done = 0;
                    end

                    2: begin
                        BusWire = RA + Ry;
                        RGin = 1;
                        
                        done = 1;
                    end

                    3: begin
                        BusWire = RA - Ry;
                        RGin = 1;
                        
                        done = 1;
                    end

                    default: done = 0;
                endcase
            end

            default: done = 0;
        endcase
    end

    always @(posedge clock) begin
        Ystep_Q = Ystep_D;
    end

    regn reg_IR (BusWire, IRin, clock, IR);
    regn reg_R0 (BusWire, Rin[0], clock, R0);
    regn reg_R1 (BusWire, Rin[1], clock, R1);
    regn reg_R2 (BusWire, Rin[2], clock, R2);
    regn reg_R3 (BusWire, Rin[3], clock, R3);
    regn reg_R4 (BusWire, Rin[4], clock, R4);
    regn reg_R5 (BusWire, Rin[5], clock, R5);
    regn reg_R6 (BusWire, Rin[6], clock, R6);
    regn reg_R7 (BusWire, Rin[7], clock, R7);
    regn reg_RA (BusWire, RAin, clock, RA);
    regn reg_RG (BusWire, RGin, clock, RG);


endmodule



module regn (
    input [8:0] R, input Rin, clock, output reg [8:0] Q
);
    always @(posedge clock) begin
        if (Rin) begin
            Q <= R;
        end
    end
endmodule
