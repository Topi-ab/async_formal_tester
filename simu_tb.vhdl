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
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process;

	dut1_a1 <= '0';
	dut2_a1 <= '0';

	tb_pr: process
	begin
		dut1_a2 <= '0';
		dut2_a2 <= '0';
		for i in 1 to 20 loop
			wait until rising_edge(clk);
		end loop;
		dut1_a2 <= '1';

		wait;
	end process;

	dut_1: entity work.dut
		port map(
			clk_in => clk,
			a1_in => dut1_a1,
			b1_out => dut1_b1,
			a2_in => dut1_a2,
			b2_out => dut1_b2
		);

	dut_2: entity work.dut
		port map(
			clk_in => clk,
			a1_in => dut2_a1,
			b1_out => dut2_b1,
			a2_in => dut2_a2,
			b2_out => dut2_b2
		);
end;

