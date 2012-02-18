
library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;
library ieee;
library grlib;
use grlib.stdlib.all;
use grlib.amba.all;
use grlib.sparc.all;
library techmap;
use techmap.gencomp.all;
library gaisler;
use gaisler.libiu.all;
use gaisler.libcache.all;
use gaisler.leon3.all;
use gaisler.libmmu.all;
use gaisler.mmuconfig.all;
use gaisler.mmuiface.all;
library work;
use work.config.all;
use work.util_tb.all;

entity mmu_acache_tb is
  constant CLK_HPERIOD : time := 10 ps;
  constant STRING_SIZE : integer := 2144; -- string size = index of the last element
end mmu_acache_tb;
architecture behavior of mmu_acache_tb is
  constant CFG_MMU_PAGESIZE    : integer range 0 to 5  := 0;
  constant CFG_SCANTEST_ENA    : integer := 0;
  constant CFG_CLK2X           : integer :=0;
  
  -- input/output signals:
  signal inNRst   : std_logic:= '0';
  signal inClk    : std_logic:= '0';
  signal in_mcii   : memory_ic_in_type;
  signal ch_mcio   : memory_ic_out_type;
  signal mcio   : memory_ic_out_type;
  signal in_mcdi   : memory_dc_in_type;
  signal ch_mcdo   : memory_dc_out_type;
  signal mcdo   : memory_dc_out_type;
  signal in_mcmmi  : memory_mm_in_type;
  signal ch_mcmmo  : memory_mm_out_type;
  signal mcmmo  : memory_mm_out_type; 
  signal in_ahbi   : ahb_mst_in_type;
  signal ch_ahbo   : ahb_mst_out_type;
  signal ahbo   : ahb_mst_out_type;
  signal in_ahbso  : ahb_slv_out_vector := (others => ahbs_none);
  signal in_hclken : std_ulogic;


  signal U: std_ulogic_vector(STRING_SIZE-1 downto 0);
  signal S: std_logic_vector(STRING_SIZE-1 downto 0);
  shared variable iClkCnt : integer := 0;
  shared variable iErrCnt : integer := 0;

begin

  -- Process of clock generation
  procClkgen : process
  begin
      inClk <= '0' after CLK_HPERIOD, '1' after 2*CLK_HPERIOD;
      wait for 2*CLK_HPERIOD;
  end process procClkgen;

  -- Process of reading  
  procReadingFile : process
    file InputFile:TEXT is "e:/mmu_acache_tb.txt";
    variable rdLine: line;  
    variable strLine : string(STRING_SIZE downto 1);
  begin
    while not endfile(InputFile) loop
      readline(InputFile, rdLine);
      read(rdLine, strLine);
      U <= StringToUVector(strLine);
      S <= StringToSVector(strLine);
  
      wait until rising_edge(inClk);
      --wait until falling_edge(inClk);
      iClkCnt := iClkCnt + 1;
      if(iClkCnt=68)then
        print("Break: " & tost(iClkCnt));
      end if;

    end loop;
  end process procReadingFile;


  -- Input signals:
  inNRst <= S(0);
  in_hclken <= S(1);
  in_mcii.address <= S(33 downto 2);
  in_mcii.burst <= S(34);
  in_mcii.req <= S(35);
  in_mcii.su <= S(36);
  in_mcii.flush <= S(37);
  in_mcdi.address <= S(69 downto 38);
  in_mcdi.data <= S(101 downto 70);
  in_mcdi.asi <= S(105 downto 102);
  in_mcdi.size <= S(107 downto 106);
  in_mcdi.burst <= S(108);
  in_mcdi.read <= S(109);
  in_mcdi.req <= S(110);
  in_mcdi.lock <= S(111);
  in_mcdi.cache <= S(112);
  in_mcmmi.address <= S(144 downto 113);
  in_mcmmi.data <= S(176 downto 145);
  in_mcmmi.size <= S(178 downto 177);
  in_mcmmi.burst <= S(179);
  in_mcmmi.read <= S(180);
  in_mcmmi.req <= S(181);
  in_mcmmi.lock <= S(182);
  in_ahbi.hgrant <= S(198 downto 183);
  in_ahbi.hready <= S(199);
  in_ahbi.hresp <= S(201 downto 200);
  in_ahbi.hrdata <= S(233 downto 202);
  in_ahbi.hcache <= S(234);
  in_ahbi.hirq <= S(266 downto 235);
  in_ahbi.testen <= S(267);
  in_ahbi.testrst <= S(268);
  in_ahbi.scanen <= S(269);
  in_ahbi.testoen <= S(270);
  in_ahbso(0).hready <= S(271);
  in_ahbso(0).hresp <= S(273 downto 272);
  in_ahbso(0).hrdata <= S(305 downto 274);
  in_ahbso(0).hsplit <= S(321 downto 306);
  in_ahbso(0).hcache <= S(322);
  in_ahbso(0).hirq <= S(354 downto 323);
  in_ahbso(0).hconfig(0) <= S(386 downto 355);
  in_ahbso(0).hconfig(1) <= S(418 downto 387);
  in_ahbso(0).hconfig(2) <= S(450 downto 419);
  in_ahbso(0).hconfig(3) <= S(482 downto 451);
  in_ahbso(0).hconfig(4) <= S(514 downto 483);
  in_ahbso(0).hconfig(5) <= S(546 downto 515);
  in_ahbso(0).hconfig(6) <= S(578 downto 547);
  in_ahbso(0).hconfig(7) <= S(610 downto 579);
  in_ahbso(0).hindex <= conv_integer(S(614 downto 611));
  in_ahbso(1).hready <= S(615);
  in_ahbso(1).hresp <= S(617 downto 616);
  in_ahbso(1).hrdata <= S(649 downto 618);
  in_ahbso(1).hsplit <= S(665 downto 650);
  in_ahbso(1).hcache <= S(666);
  in_ahbso(1).hirq <= S(698 downto 667);
  in_ahbso(1).hconfig(0) <= S(730 downto 699);
  in_ahbso(1).hconfig(1) <= S(762 downto 731);
  in_ahbso(1).hconfig(2) <= S(794 downto 763);
  in_ahbso(1).hconfig(3) <= S(826 downto 795);
  in_ahbso(1).hconfig(4) <= S(858 downto 827);
  in_ahbso(1).hconfig(5) <= S(890 downto 859);
  in_ahbso(1).hconfig(6) <= S(922 downto 891);
  in_ahbso(1).hconfig(7) <= S(954 downto 923);
  in_ahbso(1).hindex <= conv_integer(S(958 downto 955));
  in_ahbso(2).hready <= S(959);
  in_ahbso(2).hresp <= S(961 downto 960);
  in_ahbso(2).hrdata <= S(993 downto 962);
  in_ahbso(2).hsplit <= S(1009 downto 994);
  in_ahbso(2).hcache <= S(1010);
  in_ahbso(2).hirq <= S(1042 downto 1011);
  in_ahbso(2).hconfig(0) <= S(1074 downto 1043);
  in_ahbso(2).hconfig(1) <= S(1106 downto 1075);
  in_ahbso(2).hconfig(2) <= S(1138 downto 1107);
  in_ahbso(2).hconfig(3) <= S(1170 downto 1139);
  in_ahbso(2).hconfig(4) <= S(1202 downto 1171);
  in_ahbso(2).hconfig(5) <= S(1234 downto 1203);
  in_ahbso(2).hconfig(6) <= S(1266 downto 1235);
  in_ahbso(2).hconfig(7) <= S(1298 downto 1267);
  in_ahbso(2).hindex <= conv_integer(S(1302 downto 1299));
  in_ahbso(3).hready <= S(1303);
  in_ahbso(3).hresp <= S(1305 downto 1304);
  in_ahbso(3).hrdata <= S(1337 downto 1306);
  in_ahbso(3).hsplit <= S(1353 downto 1338);
  in_ahbso(3).hcache <= S(1354);
  in_ahbso(3).hirq <= S(1386 downto 1355);
  in_ahbso(3).hconfig(0) <= S(1418 downto 1387);
  in_ahbso(3).hconfig(1) <= S(1450 downto 1419);
  in_ahbso(3).hconfig(2) <= S(1482 downto 1451);
  in_ahbso(3).hconfig(3) <= S(1514 downto 1483);
  in_ahbso(3).hconfig(4) <= S(1546 downto 1515);
  in_ahbso(3).hconfig(5) <= S(1578 downto 1547);
  in_ahbso(3).hconfig(6) <= S(1610 downto 1579);
  in_ahbso(3).hconfig(7) <= S(1642 downto 1611);
  in_ahbso(3).hindex <= conv_integer(S(1646 downto 1643));
  ch_mcio.data <= S(1678 downto 1647);
  ch_mcio.ready <= S(1679);
  ch_mcio.grant <= S(1680);
  ch_mcio.retry <= S(1681);
  ch_mcio.mexc <= S(1682);
  ch_mcio.cache <= S(1683);
  --ch_mcio.par <= S(1687 downto 1684);
  ch_mcio.scanen <= S(1688);
  ch_mcdo.data <= S(1720 downto 1689);
  ch_mcdo.ready <= S(1721);
  ch_mcdo.grant <= S(1722);
  ch_mcdo.retry <= S(1723);
  ch_mcdo.mexc <= S(1724);
  ch_mcdo.werr <= S(1725);
  ch_mcdo.cache <= S(1726);
  ch_mcdo.ba <= S(1727);
  ch_mcdo.bg <= S(1728);
  --ch_mcdo.par <= S(1732 downto 1729);
  ch_mcdo.scanen <= S(1733);
  ch_mcdo.testen <= S(1734);
  ch_mcmmo.data <= S(1766 downto 1735);
  ch_mcmmo.ready <= S(1767);
  ch_mcmmo.grant <= S(1768);
  ch_mcmmo.retry <= S(1769);
  ch_mcmmo.mexc <= S(1770);
  ch_mcmmo.werr <= S(1771);
  ch_mcmmo.cache <= S(1772);
  ch_ahbo.hbusreq <= S(1773);
  ch_ahbo.hlock <= S(1774);
  ch_ahbo.htrans <= S(1776 downto 1775);
  ch_ahbo.haddr <= S(1808 downto 1777);
  ch_ahbo.hwrite <= S(1809);
  ch_ahbo.hsize <= S(1812 downto 1810);
  ch_ahbo.hburst <= S(1815 downto 1813);
  ch_ahbo.hprot <= S(1819 downto 1816);
  ch_ahbo.hwdata <= S(1851 downto 1820);
  ch_ahbo.hirq <= S(1883 downto 1852);
  ch_ahbo.hconfig(0) <= S(1915 downto 1884);
  ch_ahbo.hconfig(1) <= S(1947 downto 1916);
  ch_ahbo.hconfig(2) <= S(1979 downto 1948);
  ch_ahbo.hconfig(3) <= S(2011 downto 1980);
  ch_ahbo.hconfig(4) <= S(2043 downto 2012);
  ch_ahbo.hconfig(5) <= S(2075 downto 2044);
  ch_ahbo.hconfig(6) <= S(2107 downto 2076);
  ch_ahbo.hconfig(7) <= S(2139 downto 2108);
  ch_ahbo.hindex <= conv_integer(S(2143 downto 2140));


  proc_enum : process (inClk)
  begin
    if(iClkCnt>=68)then
--      print("Break: " & tost(iClkCnt));
    end if;
  end process proc_enum;


  tt : mmu_acache generic map 
  (
    0,--hindex    : integer range 0 to NAHBMST-1  := 0;
    CFG_ILINE,--ilinesize : integer range 4 to 8 := 4;
    CFG_DFIXED,--cached    : integer := 0;
    CFG_CLK2X,--clk2x     : integer := 0;
    CFG_SCANTEST_ENA--scantest  : integer := 0);
  )
  port map (inNRst, inClk, in_mcii, mcio, in_mcdi, mcdo, in_mcmmi,
    mcmmo, in_ahbi, ahbo, in_ahbso, in_hclken);



procCheck : process (inClk,ch_mcio, ch_mcdo, ch_mcmmo, ch_ahbo)
begin
  if(rising_edge(inClk) and (iClkCnt>10)) then
    if(ch_mcio/=mcio) then print("Err: mcio");  iErrCnt:=iErrCnt+1; end if;
    if(ch_mcdo/=mcdo) then print("Err: mcdo");  iErrCnt:=iErrCnt+1; end if;
    if(ch_mcmmo/=mcmmo) then print("Err: mcmmo");  iErrCnt:=iErrCnt+1; end if;
    if(ch_ahbo/=ahbo) then print("Err: ahbo");  iErrCnt:=iErrCnt+1; end if;
  end if;
end process procCheck;

  
end;
