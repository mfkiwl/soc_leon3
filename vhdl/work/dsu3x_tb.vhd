
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
use gaisler.leon3.all;
use gaisler.libiu.all;
use gaisler.libcache.all;
library work;
use work.config.all;
use work.util_tb.all;

entity dsu3x_tb is
  constant CLK_HPERIOD : time := 10 ps;
  constant STRING_SIZE : integer := 782; -- string size = index of the last element

  
end dsu3x_tb;
architecture behavior of dsu3x_tb is
  -- input/output signals:
  signal inNRst   : std_logic:= '0';
  signal inClk    : std_logic:= '0';

  signal in_ahbmi  : ahb_mst_in_type;
  signal in_ahbsi  : ahb_slv_in_type;
  signal ch_ahbso  : ahb_slv_out_type;
  signal ahbso  : ahb_slv_out_type;
  signal in_dbgi   : l3_debug_out_vector(0 to CFG_NCPU-1);
  signal ch_dbgo   : l3_debug_in_vector(0 to CFG_NCPU-1);
  signal dbgo   : l3_debug_in_vector(0 to CFG_NCPU-1);
  signal in_dsui   : dsu_in_type;
  signal ch_dsuo   : dsu_out_type;
  signal dsuo   : dsu_out_type;
  signal in_hclken : std_ulogic;
  signal t_v_act  : std_logic;
  signal t_trin_tbreg2_addr  : std_logic_vector(31 downto 2);

                     					
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
    file InputFile:TEXT is "e:/dsu3x_tb.txt";
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
      if(iClkCnt=365) then
        print("break");
      end if;

    end loop;
  end process procReadingFile;


  -- Input signals:

  inNRst <= S(0);
  in_hclken <= S(1);
  in_ahbmi.hgrant <= S(17 downto 2);
  in_ahbmi.hready <= S(18);
  in_ahbmi.hresp <= S(20 downto 19);
  in_ahbmi.hrdata <= S(52 downto 21);
  in_ahbmi.hcache <= S(53);
  in_ahbmi.hirq <= S(85 downto 54);
  in_ahbmi.testen <= S(86);
  in_ahbmi.testrst <= S(87);
  in_ahbmi.scanen <= S(88);
  in_ahbmi.testoen <= S(89);
  in_ahbsi.hsel <= S(105 downto 90);
  in_ahbsi.haddr <= S(137 downto 106);
  in_ahbsi.hwrite <= S(138);
  in_ahbsi.htrans <= S(140 downto 139);
  in_ahbsi.hsize <= S(143 downto 141);
  in_ahbsi.hburst <= S(146 downto 144);
  in_ahbsi.hwdata <= S(178 downto 147);
  in_ahbsi.hprot <= S(182 downto 179);
  in_ahbsi.hready <= S(183);
  in_ahbsi.hmaster <= S(187 downto 184);
  in_ahbsi.hmastlock <= S(188);
  in_ahbsi.hmbsel <= S(192 downto 189);
  in_ahbsi.hcache <= S(193);
  in_ahbsi.hirq <= S(225 downto 194);
  in_ahbsi.testen <= S(226);
  in_ahbsi.testrst <= S(227);
  in_ahbsi.scanen <= S(228);
  in_ahbsi.testoen <= S(229);
  in_dbgi(0).data <= S(261 downto 230);
  in_dbgi(0).crdy <= S(262);
  in_dbgi(0).dsu <= S(263);
  in_dbgi(0).dsumode <= S(264);
  in_dbgi(0).error <= S(265);
  in_dbgi(0).halt <= S(266);
  in_dbgi(0).pwd <= S(267);
  in_dbgi(0).idle <= S(268);
  in_dbgi(0).ipend <= S(269);
  in_dbgi(0).icnt <= S(270);
  in_dbgi(0).fcnt <= S(271);
  in_dbgi(0).optype <= S(277 downto 272);
  in_dbgi(0).bpmiss <= S(278);
  in_dbgi(0).istat.cmiss <= S(279);
  in_dbgi(0).istat.tmiss <= S(280);
  in_dbgi(0).istat.chold <= S(281);
  in_dbgi(0).istat.mhold <= S(282);
  in_dbgi(0).dstat.cmiss <= S(283);
  in_dbgi(0).dstat.tmiss <= S(284);
  in_dbgi(0).dstat.chold <= S(285);
  in_dbgi(0).dstat.mhold <= S(286);
  in_dbgi(0).wbhold <= S(287);
  in_dbgi(0).su <= S(288);
  in_dsui.enable <= S(289);
  in_dsui.break <= S(290);
  ch_ahbso.hready <= S(291);
  ch_ahbso.hresp <= S(293 downto 292);
  ch_ahbso.hrdata <= S(325 downto 294);
  ch_ahbso.hsplit <= S(341 downto 326);
  ch_ahbso.hcache <= S(342);
  ch_ahbso.hirq <= S(374 downto 343);
  ch_ahbso.hconfig(0) <= S(406 downto 375);
  ch_ahbso.hconfig(1) <= S(438 downto 407);
  ch_ahbso.hconfig(2) <= S(470 downto 439);
  ch_ahbso.hconfig(3) <= S(502 downto 471);
  ch_ahbso.hconfig(4) <= S(534 downto 503);
  ch_ahbso.hconfig(5) <= S(566 downto 535);
  ch_ahbso.hconfig(6) <= S(598 downto 567);
  ch_ahbso.hconfig(7) <= S(630 downto 599);
  ch_ahbso.hindex <= conv_integer(S(634 downto 631));
  ch_dbgo(0).dsuen <= S(635);
  ch_dbgo(0).denable <= S(636);
  ch_dbgo(0).dbreak <= S(637);
  ch_dbgo(0).step <= S(638);
  ch_dbgo(0).halt <= S(639);
  ch_dbgo(0).reset <= S(640);
  ch_dbgo(0).dwrite <= S(641);
  ch_dbgo(0).daddr <= S(663 downto 642);
  ch_dbgo(0).ddata <= S(695 downto 664);
  ch_dbgo(0).btrapa <= S(696);
  ch_dbgo(0).btrape <= S(697);
  ch_dbgo(0).berror <= S(698);
  ch_dbgo(0).bwatch <= S(699);
  ch_dbgo(0).bsoft <= S(700);
  ch_dbgo(0).tenable <= S(701);
  ch_dbgo(0).timer <= S(732 downto 702);
  ch_dsuo.active <= S(733);
  ch_dsuo.tstop <= S(734);
  ch_dsuo.pwd <= S(750 downto 735);
  t_v_act <= S(751);
  t_trin_tbreg2_addr <= S(781 downto 752);
  

  tt : dsu3x generic map 
  (
    1,--hindex    : integer               := 0;
    16#900#,
    16#f00#,
    CFG_NCPU,
    30,--CFG_DSU_TBITS,
    0,
    0,--irq
    CFG_ATBSZ,--kbytes
    0,--clk2x
    0--testen
  )port map 
  (
		inNRst,
    inClk,
    inClk,
    in_ahbmi,
    in_ahbsi,
    ahbso,
    in_dbgi,
    dbgo,
    in_dsui,
    dsuo,
    in_hclken
  );
  
  check : process(inNRst,inClk, ch_ahbso, ch_dbgo, ch_dsuo)
  begin
    if(rising_edge(inClk) and (iClkCnt>3)) then
      if(ch_dsuo/=dsuo) then print("Err: dsuo");  iErrCnt:=iErrCnt+1; end if;
      if(dbgo(0).ddata/="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU") then
        if(ch_dbgo/=dbgo) then print("Err: dbgo");  iErrCnt:=iErrCnt+1; end if;
      end if;
      if(ch_ahbso.hready/=ahbso.hready) then print("Err: ahbso.hready");  iErrCnt:=iErrCnt+1; end if;
      if((ahbso.hrdata(31)/='U')and(ahbso.hrdata(20)/='U')and(ahbso.hrdata(10)/='U')and(ahbso.hrdata(10)/='X')) then
        if(ch_ahbso.hrdata/=ahbso.hrdata) then print("Err: ahbso.hrdata");  iErrCnt:=iErrCnt+1; end if;
      end if;
    end if;
  end process check;
  

  
end;