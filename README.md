# async_formal_tester

This is a study how SymbiYosys formal model checker can be used to verify non-asynchronous response requirements.

In this demo code, the dut.vhdl has two datapaths:

- a1_in => b1_out
  - This is implemented purely in synchronous manner
- a2_in => b2_out
  - This is synchronous for the first 20 cycles, and after 20 cycles it is purely asynchronous.
  
The tb_dut.vhdl is formal test bench. The requirement is
- a1_in to b1_out has to be through register (no async path between them). 
  - This is satisfied in the dut.
- a2_in to b2_out has to be through register (no async path between them). 
  - This is violated in the dut.

The formal testing is done by instantiating two (identical) copies of dut, and making all inputs to be equal for some duration, and then for one clock cycle to have
dut1_a1_in differ from dut2_a1_in (and similarly for dut2), requiring that on the same clock cycle where inputs differ, the dut1_b1_out must be equal to dut2_b1_out.

The PSL building of GHDL (at the time of writing) seem to generate checkers that do not work in all cases.

b2_nonasync_3, b2_nonasync_4 and b2_nonasync_5 are asserted, which is as it should be.

b2_nonasync_1 and b2_nonasync_2 are not asserted, which might be an error in GHDL synthesis backend.

How to run:
- Clone the project to Linux machine with docker (usually you must run as root).
- On the project root directory, run<br>
`docker run -v $PWD:/root --rm -it hdlc/formal:all bash -c "cd /root; ./run.sh"`

