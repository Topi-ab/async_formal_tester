library ieee;
use ieee.std_logic_1164.all;

entity simu_tb is
end;

architecture rtl of simu_tb is
	signal clk: std_logic;

	signal dut1_a1: std_logic;
	signal dut1_b1: std_logic;
	signal dut1_a2: std_logic;
	signal dut1_b2: std_logic;

	signal dut2_a1: std_logic;
	signal dut2_b1: std_logic;
	signal dut2_a2: std_logic;
	signal dut2_b2: std_logic;
begin
	clk_pr: process
	begin
		clk <= '1';
		wait for 5 ns;
		clk <= '0';
		wait for 5 ns;
	end process;

	dut1_a1 <= '0';
	dut2_a1 <= '0';

	tb_pr: process
	begin
		dut1_a2 <= '1';
		dut2_a2 <= '1';
		for i in 1 to 20 loop
			wait until rising_edge(clk);
		end loop;
		dut2_a2 <= '0';

		wait;
	end process;

	dut: entity work.tb_dut
		port map(
			clk_in => clk,
			dut1_a1_in => dut1_a1,
			dut1_b1_out => dut1_b1,
			dut1_a2_in => dut1_a2,
			dut1_b2_out => dut1_b2,
			dut2_a1_in => dut2_a1,
			dut2_b1_out => dut2_b1,
			dut2_a2_in => dut2_a2,
			dut2_b2_out => dut2_b2
		);
end;

