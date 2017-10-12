--------------------------------------------------------------------------------
--! @file clk_fwd.vhd
--! @brief Clock forwarding
--! @author Yuan Mei
--!
--! Allow both single_ended and differential outputs.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
LIBRARY UNISIM;
USE UNISIM.VComponents.ALL;

ENTITY clk_fwd IS
  GENERIC (
    INV  : boolean := false;
    SLEW : string  := "SLOW"
  );
  PORT (
    R   : IN  std_logic;
    I   : IN  std_logic;
    O   : OUT std_logic;
    O_P : OUT std_logic;
    O_N : OUT std_logic
  );
END clk_fwd;

ARCHITECTURE Behavioral OF clk_fwd IS
  SIGNAL d1 : std_logic := '1';
  SIGNAL d2 : std_logic := '0';
  SIGNAL os : std_logic;
BEGIN
  d1 <= '1' WHEN INV = false ELSE '0';
  d2 <= '0' WHEN INV = false ELSE '1';
  ODDR_inst : ODDR
    GENERIC MAP (
      DDR_CLK_EDGE => "OPPOSITE_EDGE",
      INIT         => '0',
      SRTYPE       => "ASYNC"
    )
    PORT MAP (
      Q  => os,
      C  => I,
      CE => '1',
      D1 => d1,
      D2 => d2,
      R  => R,
      S  => '0'
    );
  clk_fwd_obufds_inst : OBUFDS
    GENERIC MAP(
      IOSTANDARD => "DEFAULT",
      SLEW       => SLEW
    )
    PORT MAP (
      O  => O_P,
      OB => O_N,
      I  => os
    );
  O <= os;

END Behavioral;
