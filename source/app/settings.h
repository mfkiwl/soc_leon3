//****************************************************************************
// Property:    GNSS Sensor Limited
// License:     GNU2
// Contact:     chief@gnss-sensor.com
// Repository:  git@github.com:teeshina/soc_leon3.git
//****************************************************************************

#pragma once


enum EStringName
{
  STR_ELF_FILE,
  STR_OUT_PATH,
  STR_SYSCLK_HZ,
  STR_TIMESCALE_RATE,
  STR_CLK_DURATION,
  STR_UART_ENA,
  STR_UART_CLKSCALE,
  STR_JTAG_ENA,
  STR_JTAGCLK_HZ,

  STR_TB_jtagcom,
  STR_TB_ahbmaster,
  STR_TB_ahbjtag,
  STR_TB_ahbctrl,
  STR_TB_mmutlbcam,
  STR_TB_mmutlb,
  STR_TB_mul32,
  STR_TB_div32,
  STR_TB_mmu_icache,
  STR_TB_iu3,
  STR_TB_mmu_dcache,
  STR_TB_mmu_acache,
  STR_TB_mmutw,
  STR_TB_mmulrue,
  STR_TB_mmulru,
  STR_TB_mmu,
  STR_TB_mmu_cache,
  STR_TB_cachemem,
  STR_TB_regfile_3p,
  STR_TB_tbufmem,
  STR_TB_leon3s,
  STR_TB_dsu3x,
  STR_TB_ahbram,
  STR_TB_apbctrl,
  STR_TB_apbuart,
  STR_TB_irqmp,
  STR_TB_gptimer,
  STR_TB_finderr,
  STR_TB_soc_leon3,

  STR_PRINT_VHDLDATA,
  
  STR_UNKNOWN
};

enum EStrType
{
  STRTYPE_UNKNOWN,
  STRTYPE_STRING,
  STRTYPE_INTEGER,
  STRTYPE_DOUBLE
};

struct StringData
{
  EStringName eName;
  char        name[64];
  EStrType    eType;
};

const StringData AllStrings[] = 
{
  {STR_ELF_FILE,        "ELF file=",STRTYPE_STRING},
  {STR_OUT_PATH,        "Output path=",STRTYPE_STRING},
  {STR_SYSCLK_HZ,       "SystemClock Freq.,[Hz]=",STRTYPE_DOUBLE},
  {STR_TIMESCALE_RATE,  "Timescale rate=",STRTYPE_DOUBLE},
  {STR_CLK_DURATION,    "Clocks Total=",STRTYPE_INTEGER},
  {STR_UART_ENA,        "UART Enable=",STRTYPE_INTEGER},
  {STR_UART_CLKSCALE,   "UART Baud scale=",STRTYPE_INTEGER},
  {STR_JTAG_ENA,        "JTAG Enable=",STRTYPE_INTEGER},
  {STR_JTAGCLK_HZ,      "JtagClock Freq.,[Hz]=",STRTYPE_DOUBLE},

  {STR_TB_jtagcom,      "TB_jtagcom=",STRTYPE_INTEGER},
  {STR_TB_ahbmaster,    "TB_ahbmaster=",STRTYPE_INTEGER},
  {STR_TB_ahbjtag,      "TB_ahbjtag=",STRTYPE_INTEGER},
  {STR_TB_ahbctrl,      "TB_ahbctrl=",STRTYPE_INTEGER},
  {STR_TB_mmutlbcam,    "TB_mmutlbcam=",STRTYPE_INTEGER},
  {STR_TB_mmutlb,       "TB_mmutlb=",STRTYPE_INTEGER},
  {STR_TB_mul32,        "TB_mul32=",STRTYPE_INTEGER},
  {STR_TB_div32,        "TB_div32=",STRTYPE_INTEGER},
  {STR_TB_mmu_icache,   "TB_mmu_icache=",STRTYPE_INTEGER},
  {STR_TB_iu3,          "TB_iu3=",STRTYPE_INTEGER},
  {STR_TB_mmu_dcache,   "TB_mmu_dcache=",STRTYPE_INTEGER},
  {STR_TB_mmu_acache,   "TB_mmu_acache=",STRTYPE_INTEGER},
  {STR_TB_mmutw,        "TB_mmutw=",STRTYPE_INTEGER},
  {STR_TB_mmulrue,      "TB_mmulrue=",STRTYPE_INTEGER},
  {STR_TB_mmulru,       "TB_mmulru=",STRTYPE_INTEGER},
  {STR_TB_mmu,          "TB_mmu=",STRTYPE_INTEGER},
  {STR_TB_mmu_cache,    "TB_mmu_cache=",STRTYPE_INTEGER},
  {STR_TB_cachemem,     "TB_cachemem=",STRTYPE_INTEGER},
  {STR_TB_regfile_3p,   "TB_regfile_3p=",STRTYPE_INTEGER},
  {STR_TB_tbufmem,      "TB_tbufmem=",STRTYPE_INTEGER},
  {STR_TB_leon3s,       "TB_leon3s=",STRTYPE_INTEGER},
  {STR_TB_dsu3x,        "TB_dsu3x=",STRTYPE_INTEGER},
  {STR_TB_ahbram,       "TB_ahbram=",STRTYPE_INTEGER},
  {STR_TB_apbctrl,      "TB_apbctrl=",STRTYPE_INTEGER},
  {STR_TB_apbuart,      "TB_apbuart=",STRTYPE_INTEGER},
  {STR_TB_irqmp,        "TB_irqmp=",STRTYPE_INTEGER},
  {STR_TB_gptimer,      "TB_gptimer=",STRTYPE_INTEGER},
  {STR_TB_finderr,      "TB_finderr=",STRTYPE_INTEGER},
  {STR_TB_soc_leon3,    "TB_soc_leon3=",STRTYPE_INTEGER},
  
  {STR_PRINT_VHDLDATA,  "Print VHDL assignment=",STRTYPE_INTEGER},

  {STR_UNKNOWN,         "",STRTYPE_UNKNOWN}
};


class Settings
{
  friend class dbg;
  private:
    static const int32 STRING_LENGTH_MAX = 1024;
  
  private:
    std::ifstream *pisSettings;

    char chLine[STRING_LENGTH_MAX];

    // Settings:
    char chElfFile[STRING_LENGTH_MAX];
    double dSysClockHz;
    double dTimeScaleRate;
    double timescale;
    int32 iClkSimTotal;

    int32 iUartEna;
    uint32 uiUartClkScale;
    int32 iJtagEna;
    double dJtagClockHz;
    
    LibInitData sLibInitData;

  public:
    Settings();
    
    void LoadFromFile();
    void SaveToFile();
    void GenerateDefaultSettings();
    
    void ParseLine(char *src, EStringName type);
    void GetFieldString(char *dst, char *src, size_t namelength);
    int32 GetFieldInt(char *src, size_t namelength);
    double GetFieldDouble(char *src, size_t namelength);
    void CheckOutPathExist(char *path);

    char *GetpElfFileName() {return chElfFile;}
    double GetSysClockHz() {return dSysClockHz;} 
    double GetTimescale() {return timescale;} 
    int32 GetClkTotal() {return iClkSimTotal;}
    int32 IsUartEna() {return iUartEna; }
    uint32 GetUartClkScale() {return uiUartClkScale;}
    int32 IsJtagEna() {return iJtagEna; }
    double GetJtagClockHz() {return dJtagClockHz;} 
    LibInitData *GetpLibInitData() {return &sLibInitData;}
};

