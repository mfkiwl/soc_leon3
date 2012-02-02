#pragma once

#include "stdtypes.h"

//****************************************************************************
struct JTagTestInput
{
  bool   bWrite;
  uint32 uiAddr;
  uint32 uiSize;
  uint32 uiWrData[4];
  char   *pchComment;
};


static const JTagTestInput TEST[] =
{
  //write       Addr    Size    WrData[4]      Comment
  {false,   0xFFFFFFF0,  0x0,          {0}, "Device,LibVersion" },
  {false,   0xFFFFF040,  0x0,          {0}, "msto[2].hconfig[0]" },
  {false,   0x50000ffc,  0x2,          {0}, "wrong addr" },
  {false,   0x40000010,  0x3,          {0}, "slave RAM" },
  {true,    0x40000ff8,  0x3, {0x56700022, 0x11112222, 0x33334444, 0x88889999}, "Slave RAM writting with address overrun" },
  {false,   0x40000ffc,  0x3,          {0}, "Slave RAM reading with overrun and shifting" },
#if 0
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
  {false,   0x40000018,  0x2,          {0}, "slave RAM" },
#endif
};
const int32 JTAG_TEST_TOTAL = sizeof(TEST)/sizeof(JTagTestInput);
