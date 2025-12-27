library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- BUFFS=0 => passthrough without any registers
-- BUFFS=1 => skid buffer or similar. One register. Max 50% throughput.
-- BUFFS=2 => elastic buffer. Can do 100% throughput.
-- BUFFS>2 => FIFO (kind of expensive). Can do 100% throughput.

entity elastic_buffer is
	generic(
		data_bits: natural;
		buffs: natural := 2
	);
	port(
		clk_in: std_logic;
		sreset_in: in std_logic;
		sink_ready_out: out std_logic;
		sink_valid_in: in std_logic;
		sink_tlast_in: in std_logic := '0';
		sink_data_in: in std_logic_vector(DATA_BITS-1 downto 0);
		src_ready_in: in std_logic;
		src_valid_out: out std_logic;
		src_tlast_out: out std_logic;
		src_data_out: out std_logic_vector(DATA_BITS-1 downto 0)
	);
end;

architecture rtl of elastic_buffer is
	signal full: std_logic_vector(0 to BUFFS-1);
	signal head: integer range 0 to BUFFS-1;
	signal tail: integer range 0 to BUFFS-1;
	type data_t is array(0 to BUFFS-1) of std_logic_vector(DATA_BITS+1-1 downto 0);
	signal data: data_t;
begin
	passthrough: if BUFFS = 0 generate
		process(all)
		begin
			sink_ready_out <= src_ready_in;
			src_valid_out <= sink_valid_in;
			src_data_out <= sink_data_in;
			src_tlast_out <= sink_tlast_in;
		end process;
	end generate;
	
	eb: if BUFFS > 0 generate
		process(all)
		begin
			-- src_valid_out <= or(full);
			src_valid_out <= '0';
			for i in full'range loop
				if full(i) = '1' then
					src_valid_out <= '1';
				end if;
			end loop;
			
			-- sink_ready_out <= or(not(full));
			sink_ready_out <= '0';
			for i in full'range loop
				if full(i) = '0' then
					sink_ready_out <= '1';
				end if;
			end loop;
			
			src_tlast_out <= data(head)(DATA_BITS);
			src_data_out <= data(head)(DATA_BITS-1 downto 0);
		end process;
		
		process(clk_in)
		begin
			if rising_edge(clk_in) then
				if sink_valid_in = '1' and full(tail) = '0' then
					full(tail) <= '1';
					data(tail) <= sink_tlast_in & sink_data_in;
					tail <= (tail + 1) mod BUFFS;
				end if;
				if src_ready_in = '1' and full(head) = '1' then
					full(head) <= '0';
					head <= (head + 1) mod BUFFS;
				end if;
				if sreset_in = '1' then
					tail <= 0;
					head <= 0;
					full <= (others => '0');
				end if;
			end if;
		end process;
	end generate;
end;