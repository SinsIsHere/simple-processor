# simple-processor
A processor module mimicking that of MIPS processor, using Verilog.

This processor contains a number of 16-bit registers, a multiplexer, an adder/subtracter, and a control unit (finite state machine). Information is input to this system via the 16-bit DIN input, which is loaded into the IR register. Data can be transferred through the 16-bit wide multiplexer from one register in the system to another, such as from register IR into one of the general purpose registers r0, . . . , r7. The multiplexer’s output is called Buswires in the figure because the term bus is often used for wiring that allows data to be transferred from one location in a system to another. The FSM controls the Select lines of the multiplexer, which allows any of its inputs to be transferred to any register that is connected to the bus wires.

The system can perform different operations in each clock cycle, as governed by the FSM. It determines when particular data is placed onto the bus wires and controls which of the registers is to be loaded with this data. For example, if the FSM selects r0 as the output of the bus multiplexer and also asserts Ain, then the contents of register r0 will be loaded on the next active clock edge into register A.

Addition or subtraction of signed numbers is performed by using the multiplexer to first place one 16-bit number onto the bus wires, and then loading this number into register A. Once this is done, a second 16-bit number is placed onto the bus, the adder/subtracter performs the required operation, and the result is loaded into register G. The data in G can then be transferred via the multiplexer to one of the other registers, as required.

The main module file is **a_simple_processor.v**.

The result of the simulation can be found in the image **simulation_1.png** or the file **Waveform.vwf**.

(https://github.com/SinsIsHere/simple-processor/blob/5c60c0a7eed7bd715731366705f5c5a9053e2a17/simulation_1.png)
