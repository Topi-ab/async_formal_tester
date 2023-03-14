#!/bin/bash

sby --yosys "yosys -m ghdl" -f async_test.sby cover bmc

