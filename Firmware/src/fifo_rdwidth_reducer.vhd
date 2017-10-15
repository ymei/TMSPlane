--------------------------------------------------------------------------------
--! @file fifo_rdwidth_reducer.vhd
--! @brief Read FIFO at a reduced width by means of shift-register.
--!
--! This module is placed in between a FWFT FIFO and its consumer to match
--! difference data widths.  Only width reduction is supported.
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
LIBRARY UNISIM;
USE UNISIM.VComponents.ALL;

ENTITY fifo_rdwidth_reducer IS
  GENERIC (
    RDWIDTH    : positive := 32;
    RDRATIO    : positive := 3;
    SHIFTORDER : natural  := 1          -- 1: MSB first, 0: LSB first
  );
  PORT (
    RESET : IN  std_logic;
    CLK   : IN  std_logic;
    -- input data interface
    DIN   : IN  std_logic_vector(RDWIDTH*RDRATIO-1 DOWNTO 0);
    VALID : IN  std_logic;
    RDREQ : OUT std_logic;
    -- output
    DOUT  : OUT std_logic_vector(RDWIDTH-1 DOWNTO 0);
    EMPTY : OUT std_logic;
    RD_EN : IN  std_logic
  );
END fifo_rdwidth_reducer;

ARCHITECTURE Behavioral OF fifo_rdwidth_reducer IS

  SIGNAL soP      : integer RANGE 0 TO RDRATIO-1;  -- shiftout pointer
  SIGNAL dbuf     : std_logic_vector(RDWIDTH*RDRATIO-1 DOWNTO 0);
  TYPE state_t IS (S0, S1);
  SIGNAL state    : state_t;

BEGIN

  data_proc : PROCESS (CLK, RESET)
  BEGIN
    IF RESET = '1' THEN
      soP      <= 0;
      RDREQ    <= '0';
      EMPTY    <= '1';
      dbuf     <= (OTHERS => '0');
      state    <= S0;
    ELSIF rising_edge(CLK) THEN
      state <= S0;
      EMPTY <= '1';
      RDREQ <= '0';
      CASE state IS
        WHEN S0 =>
          soP <= 0;
          IF VALID = '1' THEN
            EMPTY    <= '0';
            dbuf     <= DIN;            -- capture the current fifo output
            RDREQ    <= '1';            -- ask for the next word in fifo
            state    <= S1;
          END IF;

        WHEN S1 =>
          state <= S1;
          EMPTY <= '0';
          IF RD_EN = '1' THEN
            soP <= soP + 1;
          END IF;
          IF soP = RDRATIO-1 AND RD_EN = '1' THEN
            soP   <= 0;
            IF VALID = '1' THEN
              dbuf  <= DIN;
              RDREQ <= '1';
            ELSE
              EMPTY <= '1';
              state <= S0;
            END IF;
          END IF;
        WHEN OTHERS =>
          state <= S0;
      END CASE;
    END IF;
  END PROCESS data_proc;

  -- output
  DOUT <= dbuf(RDWIDTH*(RDRATIO-soP)-1 DOWNTO RDWIDTH*(RDRATIO-soP-1)) WHEN SHIFTORDER = 1 ELSE
          dbuf(RDWIDTH*(soP+1)-1 DOWNTO RDWIDTH*soP);
END Behavioral;
