#pragma once

const enum 
{
  AHB_MASTER_LEON3=0,
  AHB_MASTER_DSU,
  AHB_MASTER_JTAG,
  AHB_MASTER_UART,
  AHB_MASTER_TOTAL
};

const enum 
{
  AHB_SLAVE_ROM=0,
  AHB_SLAVE_MEM,
  AHB_SLAVE_APBBRIDGE,
  AHB_SLAVE_TOTAL
};

const enum
{
  IRQ_DSU,
  IRQ_TOTAL
};

// Set REREAD to 1 to include support for re-read operation when host reads
// out data register before jtagcom has completed the current AMBA access and
// returned to state 'shft'.
#define REREAD


//-----------------------------------------------------------------------------
// AMBA configuration
//-----------------------------------------------------------------------------
// AHBDW - AHB data with
//
// Valid values are 32, 64, 128 and 256
//
// The value here sets the width of the AMBA AHB data vectors for all
// cores in the library.
//
const int CFG_AHBDW     = 32; // Valid values are 32, 64, 128 and 256
const int AHBDW = CFG_AHBDW;

// CORE_ACDM - Enable AMBA Compliant Data Muxing in cores
//
// Valid values are 0 and 1
//
// 0: All GRLIB cores that use the ahbread* programs defined in this package
//    will read their data from the low part of the AHB data vector.
//
// 1: All GRLIB cores that use the ahbread* programs defined in this package
//    will select valid data, as defined in the AMBA AHB standard, from the
//    AHB data vectors based on the address input. If a core uses a function
//    that does not have the address input, a failure will be asserted.
//
const int CFG_AHB_ACDM      = 0;  // Valid values are 0 or 1
const int CORE_ACDM         = CFG_AHB_ACDM; 


const int AHB_MASTERS_MAX   = 16;  // maximum AHB masters <NAHBMST>
const int AHB_SLAVES_MAX    = 16;  // maximum AHB slaves <NAHBSLV>
const int APB_SLAVES_MAX    = 16; // maximum APB slaves <NAPBSLV>
const int AHB_IRQ_MAX       = 32; // maximum interrupts <NAHBIRQ>
const int AHB_MEM_ID_WIDTH  = 4;  // maximum address mapping registers  <NAHBAMR>
const int AHB_REG_ID_WIDTH  = 4;  // maximum AHB identification registers  <NAHBIR>
const int AHB_CFG_WORDS     = AHB_REG_ID_WIDTH + AHB_MEM_ID_WIDTH;  // words in AHB config block <NAHBCFG>
const int NAPBIR            = 1;  // maximum APB configuration words
const int NAPBAMR           = 1;  // maximum APB configuration words
const int APB_CFGWORD_NUM   = NAPBIR + NAPBAMR;  // words in APB config block <NAPBCFG>
const int NBUS              = 4;


//------------------------
// ctrl_tmp variables
#define CONFIG_AHB_DEFMST     0
#define CONFIG_AHB_RROBIN     1
#define CONFIG_AHB_SPLIT      1
#define CONFIG_AHB_IOADDR     0xFFF
#define CONFIG_APB_HADDR      0x800


// Description: this define determine area for plug-n-play in "ahbctrl"
//              0xFFFFF000 .. 0xFFFFFFFF
#define AHBCTRL_IO_AREA_ENABLE          //SH: ioen

// Description: if FULLPNP enabled, then there may be read all hconfig[0..7] data
//              otherwise only hconfig[0] is accessible:
//#define AHBCTRL_FULLPNP_ENABLE          //SH: fpnpen

#define AHBCTRL_FIXLENGTH_BURST         //SH: fixbrst
//#define AHBCTRL_IRQROUTING_DISABLE      //SH: disirq
//#define AHBCTRL_COMPL_DATAMUX_ENABLE    //SH: acdm
#define AHBCTRL_ADR_IO_MASK     0xFFF   //SH: iomask
#define AHBCTRL_ADR_CFG_AREA    0xFF0   //SH: cfgaddr
#define AHBCTRL_ADR_CFG_MASK    0xFF0   //SH: cfgmask
#define AHBCTRL_DEVICE_ID       XILINX_ML605


const uint32 grlib_version    = 1100;//version.vhd
const uint32 grlib_build      = 4108;//version.vhd
//constant grlib_date : string := "20110628";
const uint32 LIBVHDL_VERSION  = grlib_version;// stdlib.vhd
const uint32 LIBVHDL_BUILD    = grlib_build;// stdlib.vhd
const uint32 LEON3_VERSION    = 0;

const uint32 ADDR_CONFIG_MIN     = 0xFFFFF000;
const uint32 ADDR_CONFIG_MAX     = 0xFFFFFFFF;
const uint32 ADDR_MSTCFG_MIN     = 0xFFFFF000;
const uint32 ADDR_MSTCFG_MAX     = ADDR_MSTCFG_MIN + ((AHB_MASTER_TOTAL*AHB_CFG_WORDS)<<2);
const uint32 ADDR_SLVCFG_MIN     = 0xFFFFF800;
const uint32 ADDR_SLVCFG_MAX     = ADDR_SLVCFG_MIN + ((AHB_SLAVES_MAX*AHB_CFG_WORDS)<<2);
const uint32 ADDR_BUILD_LIB_MIN  = 0xFFFFFFF0;
const uint32 ADDR_BUILD_LIB_MAX  = 0xFFFFFFFF;


// LEON3 processor core
#define CFG_LEON3                     1
#define CFG_NCPU                      (1)
#define CFG_NWIN                      (8)
#define NWINLOG2  (log2[CFG_NWIN])// : integer range 1 to 5 := log2(NWIN);
#define RFBITS    (log2[CFG_NWIN+1]+4)//: integer range 6 to 10 := log2(NWIN+1) + 4;

#define CFG_IRFBITS                   (log2[CFG_NWIN+1]+4)  //: integer range 6 to 10 := log2(NWINDOWS+1) + 4;
#define CFG_IREGNUM                   (16*CFG_NWIN+8)       //: integer := NWINDOWS * 16 + 8;
#define CFG_V8                        0x32//16#32# + 4*0;
#define CFG_MULTYPE                  (CFG_V8/16)//: integer range 0 to 3 := 0;
#define CFG_MULPIPE                  ((CFG_V8%4)/2)//: integer range 0 to 1 := 0;
#define CFG_MULARCH                  ((CFG_V8%16)/4)//: integer range 0 to 3 := 0

#define CFG_MAC                       0
#define CFG_BP                        1
#define CFG_SVT                       1
#define CFG_RSTADDR                   0x00000//16#00000#;
#define CFG_LDDEL                     (1)
#define CFG_NOTAG                     0
#define CFG_NWP                       (2)     // Number of the Watchpoint register.
#define CFG_PWD                       (1*2)
#define CFG_FPU                       (0+16*0)
#define CFG_GRFPUSH                   0
#define CFG_ICEN                      1
#define CFG_ISETS                     2
#define ISETMSB   (log2x[CFG_ISETS]-1)//: integer := log2x(isets)-1;
#define CFG_ISETSZ                    8
#define CFG_ILINE                     8
#define ILINE_BITS                   (log2[CFG_ILINE])//: integer := log2(ilinesize);
#define IOFFSET_BITS                 (8+log2[CFG_ISETSZ]-ILINE_BITS)//: integer := 8 +log2(isetsize) - ILINE_BITS;
#define LINE_LOW      (2)//: integer := 2;

#define CFG_IREPL                     0
#define CFG_ILOCK                     0
#define CFG_ILRAMEN                   0
#define CFG_ILRAMADDR                 0x8E//16#8E#;
#define CFG_ILRAMSZ                   1
#define CFG_DCEN                      1
#define CFG_DSETS                     2
#define DSETMSB   (log2x[CFG_DSETS]-1)//: integer := log2x(dsets)-1;
#define CFG_DSETSZ                    4
#define CFG_DLINE                     4
#define DLINE_BITS   (log2[CFG_DLINE])
#define DOFFSET_BITS (8 +log2[CFG_DSETSZ] - DLINE_BITS)

#define CFG_DREPL                     0
#define CFG_DLOCK                     0
#define CFG_DSNOOP                    (1 + 1 + 4*1)
#define CFG_DFIXED                    0x0//16#0#;
#define CFG_DLRAMEN                   0
#define CFG_DLRAMADDR                 0x8F//16#8F#;
#define CFG_DLRAMSZ                   1
#define CFG_MMUEN                     1
#define CFG_ITLBNUM                   8
#define CFG_DTLBNUM                   8
#define CFG_TLB_TYPE                  (0 + 1*2)
#define CFG_TLB_REP                   0
#define CFG_MMU_PAGE                  0
#define CFG_DSU                       1
#define CFG_ITBSZ                     4
#define CFG_ATBSZ                     4
#define CFG_LEON3FT_EN                0
#define CFG_IUFT_EN                   0
#define CFG_FPUFT_EN                  0
#define CFG_RF_ERRINJ                 0
#define CFG_CACHE_FT_EN               0
#define CFG_CACHE_ERRINJ              0
#define CFG_LEON3_NETLIST             0
#define CFG_DISAS                     (0 + 0)
#define CFG_PCLOW                     2


#define CFG_COPROC_ENA      0 // co-copressor 1=ena; 0=dis
#define CFG_MMU_PAGESIZE    0//integer range 0 to 5  := 0;
#define CFG_SCANTEST_ENA    0//
#define CFG_IRFWT           1//   = 1; --regfile_3p_write_through(memtech);
#define CFG_MEMTECH         0
#define CFG_FABTECH         0
#define CFG_CLK2X           0
#define CFG_DSU_TBITS       30
