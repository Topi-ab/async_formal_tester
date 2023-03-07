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

The output should be:

```
SBY 19:13:51 [async_test_bmc] Removing directory '/root/async_test_bmc'.
SBY 19:13:51 [async_test_bmc] Copy '/root/dut.vhdl' to '/root/async_test_bmc/src/dut.vhdl'.
SBY 19:13:51 [async_test_bmc] Copy '/root/tb_dut.vhdl' to '/root/async_test_bmc/src/tb_dut.vhdl'.
SBY 19:13:51 [async_test_bmc] engine_0: smtbmc
SBY 19:13:51 [async_test_bmc] base: starting process "cd async_test_bmc/src; yosys -m ghdl -ql ../model/design.log ../model/design.ys"
SBY 19:13:51 [async_test_bmc] base: finished (returncode=0)
SBY 19:13:51 [async_test_bmc] prep: starting process "cd async_test_bmc/model; yosys -m ghdl -ql design_prep.log design_prep.ys"
SBY 19:13:51 [async_test_bmc] prep: finished (returncode=0)
SBY 19:13:51 [async_test_bmc] smt2: starting process "cd async_test_bmc/model; yosys -m ghdl -ql design_smt2.log design_smt2.ys"
SBY 19:13:51 [async_test_bmc] smt2: finished (returncode=0)
SBY 19:13:51 [async_test_bmc] engine_0: starting process "cd async_test_bmc; yosys-smtbmc --presat --unroll --noprogress -t 50  --append 0 --dump-vcd engine_0/trace.vcd --dump-yw engine_0/trace.yw --dump-vlogtb engine_0/trace_tb.v --dump-smtc engine_0/trace.smtc model/design_smt2.smt2"
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Solver: yices
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 0..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 0..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 1..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 1..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 2..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 2..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 3..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 3..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 4..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 4..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 5..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 5..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 6..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 6..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 7..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 7..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 8..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 8..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 9..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 9..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 10..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 10..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 11..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 11..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 12..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 12..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 13..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 13..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 14..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 14..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 15..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 15..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 16..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 16..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 17..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 17..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 18..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 18..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 19..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 19..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assumptions in step 20..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Checking assertions in step 20..
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  BMC failed!
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Assert failed in tb_dut: b2_nonasync_5
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Assert failed in tb_dut: b2_nonasync_4
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Assert failed in tb_dut: b2_nonasync_3
SBY 19:13:51 [async_test_bmc] engine_0: ##   0:00:00  Writing trace to VCD file: engine_0/trace.vcd
SBY 19:13:52 [async_test_bmc] engine_0: ##   0:00:00  Writing trace to Verilog testbench: engine_0/trace_tb.v
SBY 19:13:52 [async_test_bmc] engine_0: ##   0:00:00  Writing trace to constraints file: engine_0/trace.smtc
SBY 19:13:52 [async_test_bmc] engine_0: ##   0:00:00  Writing trace to Yosys witness file: engine_0/trace.yw
SBY 19:13:52 [async_test_bmc] engine_0: ##   0:00:00  Status: failed
SBY 19:13:52 [async_test_bmc] engine_0: finished (returncode=1)
SBY 19:13:52 [async_test_bmc] engine_0: Status returned by engine: FAIL
SBY 19:13:52 [async_test_bmc] summary: Elapsed clock time [H:MM:SS (secs)]: 0:00:00 (0)
SBY 19:13:52 [async_test_bmc] summary: Elapsed process time [H:MM:SS (secs)]: 0:00:00 (0)
SBY 19:13:52 [async_test_bmc] summary: engine_0 (smtbmc) returned FAIL
SBY 19:13:52 [async_test_bmc] summary: counterexample trace: async_test_bmc/engine_0/trace.vcd
SBY 19:13:52 [async_test_bmc] summary:   failed assertion tb_dut.b2_nonasync_3 at  in step 20
SBY 19:13:52 [async_test_bmc] summary:   failed assertion tb_dut.b2_nonasync_4 at  in step 20
SBY 19:13:52 [async_test_bmc] summary:   failed assertion tb_dut.b2_nonasync_5 at  in step 20
SBY 19:13:52 [async_test_bmc] DONE (FAIL, rc=2)
SBY 19:13:52 The following tasks failed: ['bmc']
```
