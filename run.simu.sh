#!/bin/bash

ghdl -a --std=08 dut.vhdl simu_tb.vhdl
ghdl -r --std=08 simu_tb --stop-time=230ns --wave=out.ghw

