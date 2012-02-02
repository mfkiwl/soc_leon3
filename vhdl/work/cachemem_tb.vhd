library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;
library ieee;
use ieee.std_logic_1164.all;
library grlib;
use grlib.amba.all;
use grlib.stdlib.all;
library techmap;
use techmap.gencomp.all;
library gaisler;
use gaisler.libiu.all;
use gaisler.libcache.all;
use gaisler.leon3.all;
library work;
use work.config.all;
use work.util_tb.all;

entity cachemem_tb is
  constant CLK_HPERIOD : time := 10 ps;
  constant STRING_SIZE : integer := 1858; -- string size = index of the last element
end cachemem_tb;
architecture behavior of cachemem_tb is

  -- input/output signals:
  signal inNRst       : std_logic:= '0';
  signal inClk        : std_logic:= '0';
  signal in_crami : cram_in_type;
  signal ch_cramo : cram_out_type;
  signal cramo : cram_out_type;
  signal t_idaddr  : std_logic_vector(10 downto 0);
  signal t_iddatain  : std_logic_vector(31 downto 0);
  signal t_idenable  : std_logic;
  signal t_idwrite  : std_logic_vector(0 to 3);
  signal t_iddataout0  : std_logic_vector(31 downto 0);  
  signal t_itaddr  : std_logic_vector(7 downto 0);
  signal t_itdatain0  : std_logic_vector(35 downto 0);
  signal t_itdataout0  : std_logic_vector(34 downto 0);
  signal t_itenable  : std_logic;
  signal t_itwrite  : std_logic_vector(0 to 3);
  signal t_dtdataout20  : std_logic_vector(31 downto 0);
  signal t_dtdataout30  : std_logic_vector(31 downto 0);
  signal t_dtenable  : std_logic_vector(0 to 3);
  signal t_dtaddr2  : std_logic_vector(7 downto 0);
  signal t_dtwrite3  : std_logic_vector(0 to 3);
  signal t_dtaddr  : std_logic_vector(7 downto 0);
  signal t_dtdatain30  : std_logic_vector(35 downto 0);

  
  signal U: std_ulogic_vector(STRING_SIZE-1 downto 0);
  signal S: std_logic_vector(STRING_SIZE-1 downto 0);
  shared variable iClkCnt : integer := 0;

begin

  -- Process of clock generation
  procClkgen : process
  begin
      inClk <= '0' after CLK_HPERIOD, '1' after 2*CLK_HPERIOD;
      wait for 2*CLK_HPERIOD;
  end process procClkgen;

  -- Process of reading  
  procReadingFile : process
    file InputFile:TEXT is "e:/cachemem_tb.txt";
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
      if(iClkCnt=3) then
        print("break");
      end if;
    end loop;
  end process procReadingFile;

  
  -- Input signals:
  inNRst <= S(0);
  in_crami.icramin.address <= S(20 downto 1);
  in_crami.icramin.tag(0) <= S(52 downto 21);
  in_crami.icramin.tag(1) <= S(84 downto 53);
  --in_crami.icramin.tag(2) <= S(116 downto 85);
  --in_crami.icramin.tag(3) <= S(148 downto 117);
  in_crami.icramin.twrite <= S(152 downto 149);
  in_crami.icramin.tenable <= S(153);
  in_crami.icramin.flush <= S(154);
  in_crami.icramin.data <= S(186 downto 155);
  in_crami.icramin.denable <= S(187);
  in_crami.icramin.dwrite <= S(191 downto 188);
  in_crami.icramin.ldramin.enable <= S(192);
  in_crami.icramin.ldramin.read <= S(193);
  in_crami.icramin.ldramin.write <= S(194);
  in_crami.icramin.ctx <= S(202 downto 195);
  --in_crami.icramin.tpar(0) <= S(206 downto 203);
  --in_crami.icramin.tpar(1) <= S(210 downto 207);
  --in_crami.icramin.tpar(2) <= S(214 downto 211);
  --in_crami.icramin.tpar(3) <= S(218 downto 215);
  --in_crami.icramin.dpar <= S(222 downto 219);
  in_crami.dcramin.address <= S(242 downto 223);
  in_crami.dcramin.tag(0) <= S(274 downto 243);
  in_crami.dcramin.tag(1) <= S(306 downto 275);
  in_crami.dcramin.tag(2) <= S(338 downto 307);
  in_crami.dcramin.tag(3) <= S(370 downto 339);
  in_crami.dcramin.ptag(0) <= S(402 downto 371);
  in_crami.dcramin.ptag(1) <= S(434 downto 403);
  in_crami.dcramin.ptag(2) <= S(466 downto 435);
  in_crami.dcramin.ptag(3) <= S(498 downto 467);
  in_crami.dcramin.twrite <= S(502 downto 499);
  in_crami.dcramin.tpwrite <= S(506 downto 503);
  in_crami.dcramin.tenable <= S(510 downto 507);
  in_crami.dcramin.flush <= S(511);
  in_crami.dcramin.data(0) <= S(543 downto 512);
  in_crami.dcramin.data(1) <= S(575 downto 544);
  in_crami.dcramin.data(2) <= S(607 downto 576);
  in_crami.dcramin.data(3) <= S(639 downto 608);
  in_crami.dcramin.denable <= S(643 downto 640);
  in_crami.dcramin.dwrite <= S(647 downto 644);
  in_crami.dcramin.senable <= S(651 downto 648);
  in_crami.dcramin.swrite <= S(655 downto 652);
  in_crami.dcramin.saddress <= S(675 downto 656);
  --ch_dcrami.faddress <= S(695 downto 676);
  --ch_dcrami.spar <= S(696);
  in_crami.dcramin.ldramin.address <= S(718 downto 697);
  in_crami.dcramin.ldramin.enable <= S(719);
  in_crami.dcramin.ldramin.read <= S(720);
  in_crami.dcramin.ldramin.write <= S(721);
  in_crami.dcramin.ctx(0) <= S(729 downto 722);
  in_crami.dcramin.ctx(1) <= S(737 downto 730);
  in_crami.dcramin.ctx(2) <= S(745 downto 738);
  in_crami.dcramin.ctx(3) <= S(753 downto 746);
  --ch_dcrami.tpar(0) <= S(757 downto 754);
  --ch_dcrami.tpar(1) <= S(761 downto 758);
  --ch_dcrami.tpar(2) <= S(765 downto 762);
  --ch_dcrami.tpar(3) <= S(769 downto 766);
  --ch_dcrami.dpar(0) <= S(773 downto 770);
  --ch_dcrami.dpar(1) <= S(777 downto 774);
  --ch_dcrami.dpar(2) <= S(781 downto 778);
  --ch_dcrami.dpar(3) <= S(785 downto 782);
  in_crami.dcramin.tdiag <= S(789 downto 786);
  in_crami.dcramin.ddiag <= S(793 downto 790);
  --ch_dcrami.sdiag <= S(797 downto 794);
  ch_cramo.icramo.tag(0) <= S(829 downto 798);
  ch_cramo.icramo.tag(1) <= S(861 downto 830);
  ch_cramo.icramo.tag(2) <= S(893 downto 862);
  ch_cramo.icramo.tag(3) <= S(925 downto 894);
  ch_cramo.icramo.data(0) <= S(957 downto 926);
  ch_cramo.icramo.data(1) <= S(989 downto 958);
  ch_cramo.icramo.data(2) <= S(1021 downto 990);
  ch_cramo.icramo.data(3) <= S(1053 downto 1022);
  ch_cramo.icramo.ctx(0) <= S(1061 downto 1054);
  ch_cramo.icramo.ctx(1) <= S(1069 downto 1062);
  ch_cramo.icramo.ctx(2) <= S(1077 downto 1070);
  ch_cramo.icramo.ctx(3) <= S(1085 downto 1078);
  ch_cramo.icramo.tpar(0) <= S(1089 downto 1086);
  ch_cramo.icramo.tpar(1) <= S(1093 downto 1090);
  ch_cramo.icramo.tpar(2) <= S(1097 downto 1094);
  ch_cramo.icramo.tpar(3) <= S(1101 downto 1098);
  ch_cramo.icramo.dpar(0) <= S(1105 downto 1102);
  ch_cramo.icramo.dpar(0) <= S(1109 downto 1106);
  ch_cramo.icramo.dpar(0) <= S(1113 downto 1110);
  ch_cramo.icramo.dpar(0) <= S(1117 downto 1114);
  ch_cramo.dcramo.tag(0) <= S(1149 downto 1118);
  ch_cramo.dcramo.tag(1) <= S(1181 downto 1150);
  ch_cramo.dcramo.tag(2) <= S(1213 downto 1182);
  ch_cramo.dcramo.tag(3) <= S(1245 downto 1214);
  ch_cramo.dcramo.data(0) <= S(1277 downto 1246);
  ch_cramo.dcramo.data(1) <= S(1309 downto 1278);
  ch_cramo.dcramo.data(2) <= S(1341 downto 1310);
  ch_cramo.dcramo.data(3) <= S(1373 downto 1342);
  ch_cramo.dcramo.stag(0) <= S(1405 downto 1374);
  ch_cramo.dcramo.stag(1) <= S(1437 downto 1406);
  ch_cramo.dcramo.stag(2) <= S(1469 downto 1438);
  ch_cramo.dcramo.stag(3) <= S(1501 downto 1470);
  ch_cramo.dcramo.ctx(0) <= S(1509 downto 1502);
  ch_cramo.dcramo.ctx(1) <= S(1517 downto 1510);
  ch_cramo.dcramo.ctx(2) <= S(1525 downto 1518);
  ch_cramo.dcramo.ctx(3) <= S(1533 downto 1526);
  ch_cramo.dcramo.tpar(0) <= S(1537 downto 1534);
  ch_cramo.dcramo.tpar(1) <= S(1541 downto 1538);
  ch_cramo.dcramo.tpar(2) <= S(1545 downto 1542);
  ch_cramo.dcramo.tpar(3) <= S(1549 downto 1546);
  ch_cramo.dcramo.dpar(0) <= S(1553 downto 1550);
  ch_cramo.dcramo.dpar(0) <= S(1557 downto 1554);
  ch_cramo.dcramo.dpar(0) <= S(1561 downto 1558);
  ch_cramo.dcramo.dpar(0) <= S(1565 downto 1562);
  ch_cramo.dcramo.spar <= S(1569 downto 1566);
  t_idaddr <= S(1580 downto 1570);
  t_iddatain <= S(1612 downto 1581);
  t_idenable <= S(1613);
  t_idwrite <= S(1617 downto 1614);
  t_iddataout0 <= S(1649 downto 1618);
  t_itaddr <= S(1657 downto 1650);
  t_itdatain0 <= S(1693 downto 1658);
  t_itdataout0 <= S(1728 downto 1694);
  t_itenable <= S(1729);
  t_itwrite <= S(1733 downto 1730);
  t_dtdataout20 <= S(1765 downto 1734);
  t_dtdataout30 <= S(1797 downto 1766);
  t_dtenable <= S(1801 downto 1798);
  t_dtaddr2 <= S(1809 downto 1802);
  t_dtwrite3 <= S(1813 downto 1810);
  t_dtaddr <= S(1821 downto 1814);
  t_dtdatain30 <= S(1857 downto 1822);



  tt : cachemem generic map
  (
    inferred,--tech      : integer range 0 to NTECH := 0;
    CFG_ICEN,--icen      : integer range 0 to 1 := 0;
    CFG_IREPL,--irepl     : integer range 0 to 3 := 0;
    CFG_ISETS,--isets     : integer range 1 to 4 := 1;
    CFG_ILINE,--ilinesize : integer range 4 to 8 := 4;
    CFG_ISETSZ,--isetsize  : integer range 1 to 256 := 1;
    CFG_ILOCK,--isetlock  : integer range 0 to 1 := 0;
    CFG_DCEN,--dcen      : integer range 0 to 1 := 0;
    CFG_DREPL,--drepl     : integer range 0 to 3 := 0;
    CFG_DSETS,--dsets     : integer range 1 to 4 := 1;
    CFG_DLINE,--dlinesize : integer range 4 to 8 := 4;
    CFG_DSETSZ,--dsetsize  : integer range 1 to 256 := 1;
    CFG_DLOCK,--dsetlock  : integer range 0 to 1 := 0;
    CFG_DSNOOP,--dsnoop    : integer range 0 to 6 := 0;
    CFG_ILRAMEN,--ilram      : integer range 0 to 1 := 0;
    CFG_ILRAMSZ,--ilramsize  : integer range 1 to 512 := 1;        
    CFG_DLRAMEN,--dlram      : integer range 0 to 1 := 0;
    CFG_DLRAMSZ,--dlramsize  : integer range 1 to 512 := 1;
    1,--mmuen     : integer range 0 to 1 := 0;
    0--testen    : integer range 0 to 3 := 0
  )port map 
  (
    inClk,
  	 in_crami,
	  cramo,
    inClk
  );


procCheck : process (inClk, ch_cramo)
  variable iErrCnt : integer := 0;
begin
  if(rising_edge(inClk) and (iClkCnt>2)) then
    if(cramo.icramo.tag(0)/="UUUUUUUUUUUUUUUUUUU000UUUUUUUUUU")then
      if(ch_cramo.icramo.tag(0)/=cramo.icramo.tag(0)) then print("Err: cramo.icramo.tag(0)");  iErrCnt:=iErrCnt+1; end if;
    end if;
    if(cramo.icramo.tag(1)/="UUUUUUUUUUUUUUUUUUU000UUUUUUUUUU")then
      if(ch_cramo.icramo.tag(1)/=cramo.icramo.tag(1)) then print("Err: cramo.icramo.tag(1)");  iErrCnt:=iErrCnt+1; end if;
    end if;
    if(cramo.icramo.data(0)/="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU")then
      if(ch_cramo.icramo.data(0)/=cramo.icramo.data(0)) then print("Err: cramo.icramo.data(0)");  iErrCnt:=iErrCnt+1; end if;
    end if;
    if(cramo.icramo.data(1)/="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU")then
      if(ch_cramo.icramo.data(1)/=cramo.icramo.data(1)) then print("Err: cramo.icramo.data(1)");  iErrCnt:=iErrCnt+1; end if;
    end if;
    if(cramo.icramo.ctx(0)/="UUUUUUUU")then
      if(ch_cramo.icramo.ctx(0)/=cramo.icramo.ctx(0)) then print("Err: cramo.icramo.ctx(0)");  iErrCnt:=iErrCnt+1; end if;
    end if;
    if(cramo.icramo.ctx(1)/="UUUUUUUU")then
      if(ch_cramo.icramo.ctx(1)/=cramo.icramo.ctx(1)) then print("Err: cramo.icramo.ctx(1)");  iErrCnt:=iErrCnt+1; end if;
    end if;

    if(cramo.dcramo.tag(0)/="UUUUUUUUUUUUUUUUUUUU00UU0000UUUU")then
      if(ch_cramo.dcramo.tag(0)/=cramo.dcramo.tag(0)) then print("Err: cramo.dcramo.tag(0)");  iErrCnt:=iErrCnt+1; end if;
    end if;
    if(cramo.dcramo.tag(1)/="UUUUUUUUUUUUUUUUUUUU00UU0000UUUU")then
      if(ch_cramo.dcramo.tag(1)/=cramo.dcramo.tag(1)) then print("Err: cramo.dcramo.tag(1)");  iErrCnt:=iErrCnt+1; end if;
    end if;
    if(cramo.dcramo.data(0)/="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU")then
      if(ch_cramo.dcramo.data(0)/=cramo.dcramo.data(0)) then print("Err: cramo.dcramo.data(0)");  iErrCnt:=iErrCnt+1; end if;
    end if;
    if(cramo.dcramo.data(1)/="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU")then
      if(ch_cramo.dcramo.data(1)/=cramo.dcramo.data(1)) then print("Err: cramo.dcramo.data(1)");  iErrCnt:=iErrCnt+1; end if;
    end if;
    if(cramo.dcramo.stag(0)/="UUUUUUUUUUUUUUUUUUUU000000000000")then
      if(ch_cramo.dcramo.stag(0)/=cramo.dcramo.stag(0)) then print("Err: cramo.dcramo.stag(0)");  iErrCnt:=iErrCnt+1; end if;
    end if;
    if(cramo.dcramo.stag(1)/="UUUUUUUUUUUUUUUUUUUU000000000000")then
      if(ch_cramo.dcramo.stag(1)/=cramo.dcramo.stag(1)) then print("Err: cramo.dcramo.stag(1)");  iErrCnt:=iErrCnt+1; end if;
    end if;
    if(cramo.dcramo.ctx(0)/="UUUUUUUU")then
      if(ch_cramo.dcramo.ctx(0)/=cramo.dcramo.ctx(0)) then print("Err: cramo.dcramo.ctx(0)");  iErrCnt:=iErrCnt+1; end if;
    end if;
    if(cramo.dcramo.ctx(1)/="UUUUUUUU")then
      if(ch_cramo.dcramo.ctx(1)/=cramo.dcramo.ctx(1)) then print("Err: cramo.dcramo.ctx(1)");  iErrCnt:=iErrCnt+1; end if;
    end if;

  end if;
end process procCheck;

  
end;