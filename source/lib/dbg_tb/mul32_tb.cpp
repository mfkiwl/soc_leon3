#include "lheaders.h"

extern leon3mp  topLeon3mp;

extern void ResetPutStr();
extern void PrintIndexStr();

#ifdef DBG_mul32
//****************************************************************************
void dbg::mul32_tb(SystemOnChipIO &io)
{

  if(io.inClk.eClock_z==SClock::CLK_POSEDGE)
  {
    uint32 tmp;
    holdnx = 1;

    switch(iClkCnt)
    {
      case 20:
        muli.start = 1;
        muli.op1 = 3;
        muli.op2 = -5;
        muli.Signed = 1;
        muli.mac = 0;
        muli.acc = 0;
        muli.flush = 0;
      break;
      case 25:
        muli.start = 1;
        muli.op1 = 0x1FFFFFFFF;
        muli.op2 = 0x0FFFFFF55;
        muli.Signed = 0;
        muli.mac = 0;
        muli.acc = 0;
        muli.flush = 0;
      break;
      case 30:
        muli.start = 1;
        muli.op1 = 0x1FFFFFFFF;
        muli.op2 = 0x1FFFFFF55;
        muli.Signed = 1;
        muli.mac = 0;
        muli.acc = 0;
        muli.flush = 0;
      break;
      default:
        if(iClkCnt>50)
        {
          muli.start = rand()&0x1;
          muli.op1 = ((((uint64)rand())<<17) + ((uint64)rand()))&0x1FFFFFFFF;
          muli.op2 = ((((uint64)rand())<<17) + ((uint64)rand()))&0x1FFFFFFFF;
          tmp = rand();
          muli.Signed = tmp&0x1;
          muli.mac = ((tmp>>1)&0x1);
          muli.acc = ((((uint64)rand())<<23) + ((uint64)rand()))&0xFFFFFFFFFF;;
          muli.flush = ((tmp>>2)&0x1);
          holdnx = ((tmp>>3)&0x1);
        }else
          muli.start = 0;
    }
  }

  tst_mul32.Update( io.inNRst,
                    io.inClk,
                    holdnx,
                    muli,
                    mulo);


  if(io.inClk.eClock==SClock::CLK_POSEDGE)
  {
    pStr = chStr;
    chStr[0] = '\0';

    ResetPutStr();
  
    // inputs:
    pStr = PutToStr(pStr, io.inNRst, 1, "inNRst");
    pStr = PutToStr(pStr, holdnx, 1, "holdnx");
    pStr = PutToStr(pStr, muli.op1, 33,"muli.op1");
    pStr = PutToStr(pStr, muli.op2, 33,"muli.op2");
    pStr = PutToStr(pStr, muli.flush, 1,"muli.flush");
    pStr = PutToStr(pStr, muli.Signed, 1,"muli.Signed");
    pStr = PutToStr(pStr, muli.start, 1,"muli.start");
    pStr = PutToStr(pStr, muli.mac, 1,"muli.mac");
    pStr = PutToStr(pStr, muli.acc, 40,"muli.acc");

    // outputs:
    pStr = PutToStr(pStr, mulo.ready, 1, "ch_mulo.ready");
    pStr = PutToStr(pStr, mulo.nready, 1, "ch_mulo.nready");
    pStr = PutToStr(pStr, mulo.icc, 4, "ch_mulo.icc");
    pStr = PutToStr(pStr, mulo.result, 64, "ch_mulo.result");
  
    // internal registers:
    pStr = PutToStr(pStr, tst_mul32.prod[0],64,"tmp_prod[63:0]");
    pStr = PutToStr(pStr, tst_mul32.prod[1],2,"tmp_prod[65:64]");
    pStr = PutToStr(pStr, tst_mul32.mop1,33,"tmp_mop1");
    pStr = PutToStr(pStr, tst_mul32.mop2,33,"tmp_mop2");
    pStr = PutToStr(pStr, tst_mul32.acc,49,"tmp_acc");
    pStr = PutToStr(pStr, tst_mul32.acc1,49,"tmp_acc1");
    pStr = PutToStr(pStr, tst_mul32.acc2,49,"tmp_acc2");

    pStr = PutToStr(pStr, tst_mul32.v.acc,64,"tmp_v_acc");
    pStr = PutToStr(pStr, tst_mul32.v.state,2,"tmp_v_state");
    pStr = PutToStr(pStr, tst_mul32.v.start,1,"tmp_v_start");
    pStr = PutToStr(pStr, tst_mul32.v.ready,1,"tmp_v_ready");
    pStr = PutToStr(pStr, tst_mul32.v.nready,1,"tmp_v_nready");

  
    PrintIndexStr();

    *posBench[TB_mul32] << chStr << "\n";
  }

  tst_mul32.ClkUpdate();
}
#endif
