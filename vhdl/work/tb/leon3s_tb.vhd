
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;--"unsgined", SHIFT_RIGHT(), etc
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
use gaisler.leon3.all;
use gaisler.libiu.all;
use gaisler.libcache.all;
use gaisler.arith.all;
use grlib.sparc_disas.all;
library work;
use work.config.all;
use work.util_tb.all;

entity leon3s_tb is
  constant CLK_HPERIOD : time := 10 ps;
  constant STRING_SIZE : integer := 1827; -- string size = index of the last element

  
end leon3s_tb;
architecture behavior of leon3s_tb is
  -- input/output signals:
  signal inNRst   : std_logic:= '0';
  signal inClk    : std_logic:= '0';

  signal in_ahbi   : ahb_mst_in_type;
  signal ch_ahbo   : ahb_mst_out_type;
  signal ahbo   : ahb_mst_out_type;
  signal in_ahbsi  : ahb_slv_in_type;
  signal in_ahbso  : ahb_slv_out_vector := (others => ahbs_none);
  signal in_irqi   : l3_irq_in_type;
  signal ch_irqo   : l3_irq_out_type;
  signal irqo   : l3_irq_out_type;
  signal in_dbgi   : l3_debug_in_type;
  signal ch_dbgo   : l3_debug_out_type;
  signal dbgo   : l3_debug_out_type;

                     					
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
    file InputFile:TEXT is "e:/leon3s_tb.txt";
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
      if(iClkCnt=152) then
        --print("break");
      end if;

    end loop;
  end process procReadingFile;


  -- Input signals:

  inNRst <= S(0);
  in_ahbi.hgrant <= S(16 downto 1);
  in_ahbi.hready <= S(17);
  in_ahbi.hresp <= S(19 downto 18);
  in_ahbi.hrdata <= S(51 downto 20);
  in_ahbi.hcache <= S(52);
  in_ahbi.hirq <= S(84 downto 53);
  in_ahbi.testen <= S(85);
  in_ahbi.testrst <= S(86);
  in_ahbi.scanen <= S(87);
  in_ahbi.testoen <= S(88);
  in_ahbsi.hsel <= S(104 downto 89);
  in_ahbsi.haddr <= S(136 downto 105);
  in_ahbsi.hwrite <= S(137);
  in_ahbsi.htrans <= S(139 downto 138);
  in_ahbsi.hsize <= S(142 downto 140);
  in_ahbsi.hburst <= S(145 downto 143);
  in_ahbsi.hwdata <= S(177 downto 146);
  in_ahbsi.hprot <= S(181 downto 178);
  in_ahbsi.hready <= S(182);
  in_ahbsi.hmaster <= S(186 downto 183);
  in_ahbsi.hmastlock <= S(187);
  in_ahbsi.hmbsel <= S(191 downto 188);
  in_ahbsi.hcache <= S(192);
  in_ahbsi.hirq <= S(224 downto 193);
  in_ahbsi.testen <= S(225);
  in_ahbsi.testrst <= S(226);
  in_ahbsi.scanen <= S(227);
  in_ahbsi.testoen <= S(228);
  in_ahbso(0).hready <= S(229);
  in_ahbso(0).hresp <= S(231 downto 230);
  in_ahbso(0).hrdata <= S(263 downto 232);
  in_ahbso(0).hsplit <= S(279 downto 264);
  in_ahbso(0).hcache <= S(280);
  in_ahbso(0).hirq <= S(312 downto 281);
  in_ahbso(0).hconfig(0) <= S(344 downto 313);
  in_ahbso(0).hconfig(1) <= S(376 downto 345);
  in_ahbso(0).hconfig(2) <= S(408 downto 377);
  in_ahbso(0).hconfig(3) <= S(440 downto 409);
  in_ahbso(0).hconfig(4) <= S(472 downto 441);
  in_ahbso(0).hconfig(5) <= S(504 downto 473);
  in_ahbso(0).hconfig(6) <= S(536 downto 505);
  in_ahbso(0).hconfig(7) <= S(568 downto 537);
  in_ahbso(0).hindex <= conv_integer(S(572 downto 569));
  in_ahbso(1).hready <= S(573);
  in_ahbso(1).hresp <= S(575 downto 574);
  in_ahbso(1).hrdata <= S(607 downto 576);
  in_ahbso(1).hsplit <= S(623 downto 608);
  in_ahbso(1).hcache <= S(624);
  in_ahbso(1).hirq <= S(656 downto 625);
  in_ahbso(1).hconfig(0) <= S(688 downto 657);
  in_ahbso(1).hconfig(1) <= S(720 downto 689);
  in_ahbso(1).hconfig(2) <= S(752 downto 721);
  in_ahbso(1).hconfig(3) <= S(784 downto 753);
  in_ahbso(1).hconfig(4) <= S(816 downto 785);
  in_ahbso(1).hconfig(5) <= S(848 downto 817);
  in_ahbso(1).hconfig(6) <= S(880 downto 849);
  in_ahbso(1).hconfig(7) <= S(912 downto 881);
  in_ahbso(1).hindex <= conv_integer(S(916 downto 913));
  in_ahbso(2).hready <= S(917);
  in_ahbso(2).hresp <= S(919 downto 918);
  in_ahbso(2).hrdata <= S(951 downto 920);
  in_ahbso(2).hsplit <= S(967 downto 952);
  in_ahbso(2).hcache <= S(968);
  in_ahbso(2).hirq <= S(1000 downto 969);
  in_ahbso(2).hconfig(0) <= S(1032 downto 1001);
  in_ahbso(2).hconfig(1) <= S(1064 downto 1033);
  in_ahbso(2).hconfig(2) <= S(1096 downto 1065);
  in_ahbso(2).hconfig(3) <= S(1128 downto 1097);
  in_ahbso(2).hconfig(4) <= S(1160 downto 1129);
  in_ahbso(2).hconfig(5) <= S(1192 downto 1161);
  in_ahbso(2).hconfig(6) <= S(1224 downto 1193);
  in_ahbso(2).hconfig(7) <= S(1256 downto 1225);
  in_ahbso(2).hindex <= conv_integer(S(1260 downto 1257));
  in_irqi.irl <= S(1264 downto 1261);
  in_irqi.rst <= S(1265);
  in_irqi.run <= S(1266);
  in_irqi.rstvec <= S(1286 downto 1267);
  in_irqi.iact <= S(1287);
  in_irqi.index <= S(1291 downto 1288);
  in_dbgi.dsuen <= S(1292);
  in_dbgi.denable <= S(1293);
  in_dbgi.dbreak <= S(1294);
  in_dbgi.step <= S(1295);
  in_dbgi.halt <= S(1296);
  in_dbgi.reset <= S(1297);
  in_dbgi.dwrite <= S(1298);
  in_dbgi.daddr <= S(1320 downto 1299);
  in_dbgi.ddata <= S(1352 downto 1321);
  in_dbgi.btrapa <= S(1353);
  in_dbgi.btrape <= S(1354);
  in_dbgi.berror <= S(1355);
  in_dbgi.bwatch <= S(1356);
  in_dbgi.bsoft <= S(1357);
  in_dbgi.tenable <= S(1358);
  in_dbgi.timer <= S(1389 downto 1359);
  ch_ahbo.hbusreq <= S(1390);
  ch_ahbo.hlock <= S(1391);
  ch_ahbo.htrans <= S(1393 downto 1392);
  ch_ahbo.haddr <= S(1425 downto 1394);
  ch_ahbo.hwrite <= S(1426);
  ch_ahbo.hsize <= S(1429 downto 1427);
  ch_ahbo.hburst <= S(1432 downto 1430);
  ch_ahbo.hprot <= S(1436 downto 1433);
  ch_ahbo.hwdata <= S(1468 downto 1437);
  ch_ahbo.hirq <= S(1500 downto 1469);
  ch_ahbo.hconfig(0) <= S(1532 downto 1501);
  ch_ahbo.hconfig(1) <= S(1564 downto 1533);
  ch_ahbo.hconfig(2) <= S(1596 downto 1565);
  ch_ahbo.hconfig(3) <= S(1628 downto 1597);
  ch_ahbo.hconfig(4) <= S(1660 downto 1629);
  ch_ahbo.hconfig(5) <= S(1692 downto 1661);
  ch_ahbo.hconfig(6) <= S(1724 downto 1693);
  ch_ahbo.hconfig(7) <= S(1756 downto 1725);
  ch_ahbo.hindex <= conv_integer(S(1760 downto 1757));
  ch_irqo.intack <= S(1761);
  ch_irqo.irl <= S(1765 downto 1762);
  ch_irqo.pwd <= S(1766);
  --ch_irqo.fpen <= S(1767);
  ch_dbgo.data <= S(1799 downto 1768);
  ch_dbgo.crdy <= S(1800);
  ch_dbgo.dsu <= S(1801);
  ch_dbgo.dsumode <= S(1802);
  ch_dbgo.error <= S(1803);
  ch_dbgo.halt <= S(1804);
  ch_dbgo.pwd <= S(1805);
  ch_dbgo.idle <= S(1806);
  ch_dbgo.ipend <= S(1807);
  ch_dbgo.icnt <= S(1808);
  --ch_dbgo.fcnt <= S(1809);
  --ch_dbgo.optype <= S(1815 downto 1810);
  --ch_dbgo.bpmiss <= S(1816);
  --ch_dbgo.istat.cmiss <= S(1817);
  --ch_dbgo.istat.tmiss <= S(1818);
  --ch_dbgo.istat.chold <= S(1819);
  --ch_dbgo.istat.mhold <= S(1820);
  --ch_dbgo.dstat.cmiss <= S(1821);
  --ch_dbgo.dstat.tmiss <= S(1822);
  --ch_dbgo.dstat.chold <= S(1823);
  --ch_dbgo.dstat.mhold <= S(1824);
  --ch_dbgo.wbhold <= S(1825);
  --ch_dbgo.su <= S(1826);


  tt : leon3s generic map 
  (
    0,--hindex    : integer               := 0;
    inferred,--fabtech   : integer range 0 to NTECH  := DEFFABTECH;
    inferred,--memtech   : integer range 0 to NTECH  := DEFMEMTECH;
    CFG_NWIN,--nwindows  : integer range 2 to 32 := 8;
    CFG_DSU,--dsu       : integer range 0 to 1  := 0;
    CFG_FPU,--fpu       : integer range 0 to 31 := 0;
    CFG_V8,--v8        : integer range 0 to 63 := 0;
    0,--cp        : integer range 0 to 1  := 0;
    CFG_MAC,--mac       : integer range 0 to 1  := 0;
    CFG_PCLOW,--pclow     : integer range 0 to 2  := 2;
    CFG_NOTAG,--notag     : integer range 0 to 1  := 0;
    CFG_NWP,--nwp       : integer range 0 to 4  := 0;
    CFG_ICEN,--icen      : integer range 0 to 1  := 0;
    CFG_IREPL,--irepl     : integer range 0 to 3  := 2;
    CFG_ISETS,--isets     : integer range 1 to 4  := 1;
    CFG_ILINE,--ilinesize : integer range 4 to 8  := 4;
    CFG_ISETSZ,--isetsize  : integer range 1 to 256 := 1;
    CFG_ILOCK,--isetlock  : integer range 0 to 1  := 0;
    CFG_DCEN,--dcen      : integer range 0 to 1  := 0;
    CFG_DREPL,--drepl     : integer range 0 to 3  := 2;
    CFG_DSETS,--dsets     : integer range 1 to 4  := 1;
    CFG_DLINE,--dlinesize : integer range 4 to 8  := 4;
    CFG_DSETSZ,--dsetsize  : integer range 1 to 256 := 1;
    CFG_DLOCK,--dsetlock  : integer range 0 to 1  := 0;
    CFG_DSNOOP,--dsnoop    : integer range 0 to 6  := 0;
    CFG_ILRAMEN,--ilram      : integer range 0 to 1 := 0;
    CFG_ILRAMSZ,--ilramsize  : integer range 1 to 512 := 1;
    CFG_ILRAMADDR,--ilramstart : integer range 0 to 255 := 16#8e#;
    CFG_DLRAMEN,--dlram      : integer range 0 to 1 := 0;
    CFG_DLRAMSZ,--dlramsize  : integer range 1 to 512 := 1;
    CFG_DLRAMADDR,--dlramstart : integer range 0 to 255 := 16#8f#;
    CFG_MMUEN,--mmuen     : integer range 0 to 1  := 0;
    CFG_ITLBNUM,--itlbnum   : integer range 2 to 64 := 8;
    CFG_DTLBNUM,--dtlbnum   : integer range 2 to 64 := 8;
    CFG_TLB_TYPE,--tlb_type  : integer range 0 to 3  := 1;
    CFG_TLB_REP,--tlb_rep   : integer range 0 to 1  := 0;
    CFG_LDDEL,--lddel     : integer range 1 to 2  := 2;
    CFG_DISAS,--disas     : integer range 0 to 2  := 0;
    CFG_ITBSZ,--tbuf      : integer range 0 to 64 := 0;
    CFG_PWD,--pwd       : integer range 0 to 2  := 2;     -- power-down
    CFG_SVT,--svt       : integer range 0 to 1  := 1;     -- single vector trapping
    CFG_RSTADDR,--rstaddr   : integer               := 0;
    (CFG_NCPU-1),--smp       : integer range 0 to 15 := 0;     -- support SMP systems
    CFG_DFIXED,--cached    : integer               := 0;	-- cacheability table
    0,--scantest  : integer               := 0;
    0,--mmupgsz   : integer range 0 to 5  := 0;
    CFG_BP--bp        : integer               := 1

  )port map 
  (
    inClk,
    inNRst,
    in_ahbi,
    ahbo,
    in_ahbsi,
    in_ahbso,
    in_irqi,
    irqo,
    in_dbgi,
    dbgo
  );
  
  comb : process(inNRst,inClk, ch_ahbo, ch_irqo, ch_dbgo)
  begin
    
    if(rising_edge(inClk) and (iClkCnt>14)) then
     if(ch_dbgo/=dbgo) then print("Err: dbgo");  iErrCnt:=iErrCnt+1; end if;
     if(ch_irqo/=irqo) then print("Err: irqo");  iErrCnt:=iErrCnt+1; end if;
    end if;
  end process comb;
  

procCheck : process (inClk)
begin
  if(rising_edge(inClk) and (iClkCnt>6)) then
--    if(ch_dbgm/=ch_ico.idle)then print("Err: ico.idle");  iErrCnt:=iErrCnt+1; end if;
  end if;
end process procCheck;

  
end;