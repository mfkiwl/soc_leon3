------------------------------------------------------------------------------
--  INFORMATION:  http://www.GNSS-sensor.com
--  PROPERTY:     GNSS Sensor Ltd
--
--  E-MAIL:       gnss.sensor@gmail.com
--
--  DESCRIPTION:  This file contains GNSS DSP module description
------------------------------------------------------------------------------
--  WARNING:      
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library grlib;
use grlib.amba.all;
use grlib.stdlib.all;
library techmap;
use techmap.gencomp.all;

package gnssmodule is

------------------------------------------------------------------------------
-- RF front-end controller module

  component rfctrl is
  generic (
    pindex   : integer := 0;
    paddr    : integer := 0;
    pmask    : integer := 16#fff#
  );
  port (
    rst    : in  std_ulogic;
    clk    : in  std_ulogic;
    apbi   : in  apb_slv_in_type;
    apbo   : out apb_slv_out_type;
    inLD     : in std_logic_vector(1 downto 0);
    outSCLK  : out std_ulogic;
    outSDATA : out std_ulogic;
    outCSn   : out std_logic_vector(1 downto 0);
    -- Antenna control:
    inExtAntStat   : in std_ulogic;
    inExtAntDetect : in std_ulogic;
    outExtAntEna   : out std_ulogic
  );
  end component; 

------------------------------------------------------------------------------
-- 3-axis STMicroelectronics Gyroscope SPI controller (4-wires mode)

  component gyrospi is
  generic (
    pindex   : integer := 0;
    paddr    : integer := 0;
    pmask    : integer := 16#ffe#
  );
  port (
    rst    : in  std_ulogic;
    clk    : in  std_ulogic;
    apbi   : in  apb_slv_in_type;
    apbo   : out apb_slv_out_type;
    inInt1 : in std_ulogic;
    inInt2 : in std_ulogic;
    inSDI  : in std_ulogic;
    outSPC : out std_ulogic;
    outSDO : out std_ulogic;
    outCSn : out std_ulogic
  );
  end component; 

------------------------------------------------------------------------------
-- 3-axis STMicroelectronics Accelerometer SPI controller (4-wires mode)

  component accelspi is
    generic (
      pindex   : integer := 0;
      paddr    : integer := 0;
      pmask    : integer := 16#ffe#
    );
    port (
      rst    : in  std_ulogic;
      clk    : in  std_ulogic;
      apbi   : in  apb_slv_in_type;
      apbo   : out apb_slv_out_type;
      inInt1 : in std_ulogic;
      inInt2 : in std_ulogic;
      inSDI  : in std_ulogic;
      outSPC : out std_ulogic;
      outSDO : out std_ulogic;
      outCSn : out std_ulogic
    );
  end component; 


  ------------------------------------------------------------------------------
  -- GNSS Engine, top level


  constant CFG_GNSS_CHANNELS_TOTAL :  integer := 32;
  constant CFG_GNSS_MEMORY_SIZE64  :  integer := 8*CFG_GNSS_CHANNELS_TOTAL+8;
  constant CFG_GNSS_ADDR_WIDTH     :  integer := log2x(CFG_GNSS_MEMORY_SIZE64/8)+6;
  
  component gnssengine is
  generic
  (
    hindex : integer := 0;
    haddr  : integer := 0;
    hmask  : integer := 16#FFF#  
  );
  port
  (
    rst      : in  std_ulogic;
    clk      : in  std_ulogic;
    ahbsi    : in  ahb_slv_in_type;
    ahbso    : out ahb_slv_out_type;
    -- Inputs from RF
    inAdcClk : in  std_ulogic;
    inGpsI   : in  std_logic_vector(1 downto 0);
    inGpsQ   : in  std_logic_vector(1 downto 0);
    inGloI   : in  std_logic_vector(1 downto 0);
    inGloQ   : in  std_logic_vector(1 downto 0)
  );
  end component;

  -- GNNS module Internal data interface
  type GnssMuxBus is record
    wRdEna         : std_ulogic;
    wbRdModuleSel  : std_logic_vector(CFG_GNSS_ADDR_WIDTH-1 downto 0);
    wbRdFieldSel   : std_logic_vector(2 downto 0);
    wWrEna         : std_ulogic;
    wbWrModuleSel  : std_logic_vector(CFG_GNSS_ADDR_WIDTH-1 downto 0);
    wbWrFieldSel   : std_logic_vector(3 downto 0);
    wbWrData       : std_ulogic;
  end record;


end;
