--------------------------------------------------------------------------------
--! @file width_pulse_sync.vhd
--! @brief Produce a pulse of specified width in a different clock domain.
--! @author Yuan Mei
--!
--! Produce a pulse of specified width in a different clock domain
--! following a 1-CLKO wide reset pulse.
--! Ideally suited to change iodelay taps and iserdes bitslip
--!               MODE := 0   output one pulse of duration PW
--!                    := 1   a train of 1-clk wide pulses (of number PW)
--! PW = 0 will still generate RSTO but no PO.
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

ENTITY width_pulse_sync IS
  GENERIC (
    DATA_WIDTH : positive := 8;
    MODE       : natural  := 0          -- 0: output one pulse of duration PW
                                        -- 1: a train of 1-clk wide pulses (of number PW)
  );
  PORT (
    RESET : IN  std_logic;
    CLK   : IN  std_logic;
    PW    : IN  std_logic_vector(DATA_WIDTH-1 DOWNTO 0);
    START : IN  std_logic;              -- should be synchronous to CLK, of any width
    BUSY  : OUT std_logic;
    --
    CLKO  : IN  std_logic;
    RSTO  : OUT std_logic;
    PO    : OUT std_logic
  );
END width_pulse_sync;

ARCHITECTURE Behavioral OF width_pulse_sync IS

  SIGNAL prev       : std_logic;
  SIGNAL prevb      : std_logic;
  SIGNAL prevb1     : std_logic;
  SIGNAL prevo      : std_logic;
  SIGNAL prevo1     : std_logic;
  SIGNAL busy_buf   : std_logic;
  SIGNAL busy_bufo  : std_logic;
  SIGNAL pw_buf     : std_logic_vector(DATA_WIDTH-1 DOWNTO 0);
  SIGNAL po_buf     : std_logic;

BEGIN

  PROCESS (CLK, RESET) IS
  BEGIN
    IF RESET = '1' THEN
      prev     <= '0';
      busy_buf <= '0';
      pw_buf   <= (OTHERS => '0');
      prevb    <= '0';
      prevb1   <= '0';
    ELSIF rising_edge(CLK) THEN
      prev <= START;
      -- Capture the rising edge of START, which is synchronous to CLK, of any width
      IF (prev = '0' AND START = '1' AND prevb1 = '0') THEN
        busy_buf <= '1';
        pw_buf   <= PW;
      END IF;
      prevb  <= busy_bufo;
      prevb1 <= prevb;
      -- Capture the falling edge of busy_bufo
      IF (prevb = '0' AND prevb1 = '1') THEN
        busy_buf <= '0';
      END IF;
    END IF;
  END PROCESS;
  BUSY <= busy_buf;

  -- output clock domain
  PROCESS (CLKO) IS
    VARIABLE counter : unsigned(DATA_WIDTH DOWNTO 0);
  BEGIN
    IF rising_edge(CLKO) THEN
      prevo     <= busy_buf;
      prevo1    <= prevo;
      busy_bufo <= '0';
      po_buf    <= '0';
      RSTO      <= '0';
      -- Capture the rising edge of busy_buf
      IF (prevo1 = '0' AND prevo = '1') THEN
        busy_bufo <= '1';
        counter   := (OTHERS => '0');
        RSTO      <= '1';
      ELSIF counter = 0 THEN
        busy_bufo <= '1';
        counter   := counter + 1;
      ELSIF counter <= unsigned(pw_buf) THEN
        busy_bufo <= '1';
        IF MODE = 0 THEN
          counter := counter + 1;
          po_buf  <= '1';
        ELSIF MODE = 1 THEN
          IF po_buf = '0' THEN
            counter := counter + 1;
          END IF;
          po_buf <= NOT po_buf;
        END IF;
      END IF;
    END IF;
  END PROCESS;
  PO <= po_buf;

END Behavioral;
