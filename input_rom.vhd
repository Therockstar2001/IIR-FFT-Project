-- ==========================================================
--  File: input_rom.vhd
--  Purpose: ROM containing input samples for IIR/FFT project
--  Device family: Cyclone II (works for all Quartus devices)
-- ==========================================================

library ieee;
use ieee.std_logic_1164.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

entity input_rom is
  port (
    address : in  std_logic_vector(5 downto 0);  -- 6-bit address (0–63)
    clock   : in  std_logic;
    q       : out std_logic_vector(15 downto 0)  -- 16-bit data output
  );
end entity;

architecture rtl of input_rom is
begin
  rom_inst : altsyncram
    generic map (
      clock_enable_input_a  => "BYPASS",
      clock_enable_output_a => "BYPASS",
      init_file             => "input_rom.mif",
      intended_device_family=> "Cyclone II",
      lpm_hint              => "ENABLE_RUNTIME_MOD=NO",
      lpm_type              => "altsyncram",
      numwords_a            => 64,
      operation_mode        => "ROM",
      outdata_aclr_a        => "NONE",
      outdata_reg_a         => "CLOCK0",
      widthad_a             => 6,
      width_a               => 16,
      width_byteena_a       => 1
    )
    port map (
      clock0     => clock,
      address_a  => address,
      q_a        => q
    );
end architecture;
