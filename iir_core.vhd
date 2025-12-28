library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity iir_core is
  port (
    clk   : in  std_logic;
    rst   : in  std_logic;
    x_in  : in  signed(15 downto 0);
    y_out : out signed(15 downto 0)
  );
end entity;

architecture rtl of iir_core is
  -- y[n] = 0.5*y[n-1] + 0.25*y[n-2] + x[n]
  signal y1, y2 : signed(15 downto 0) := (others => '0');
  signal y      : signed(15 downto 0) := (others => '0');
begin
  process(clk)
    variable acc : signed(17 downto 0); 
  begin
    if rising_edge(clk) then
      if rst = '1' then
        y1 <= (others => '0');
        y2 <= (others => '0');
        y  <= (others => '0');
      else
        -- Equivalent to 0.5*y1 + 0.25*y2 + x_in
        acc := shift_right(resize(y1, 18), 1)
             + shift_right(resize(y2, 18), 2)
             + resize(x_in, 18);

        y   <= resize(acc(17 downto 2), 16); 
        y2  <= y1;
        y1  <= y;
      end if;
    end if;
  end process;

  y_out <= y;
end architecture;