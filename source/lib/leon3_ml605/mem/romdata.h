//****************************************************************************
// Author:	    Jiri Gaisler - Gaisler Research
// C++ version: GNSS Sensor Limited
// License:     GNU2
// Contact:     sergey.khabarov@gnss-sensor.com
// Repository:  git@github.com:teeshina/soc_leon3.git
//****************************************************************************

#pragma once

struct RomValue
{
  uint32 adr;
  uint32 data;
};

static const uint32 ROM_SIZE = 0x1<<8;
const RomValue RomData[ROM_SIZE] =
{
    {0x00000, 0x81D82000},
    {0x00001, 0x03000004},
    {0x00002, 0x821060E0},
    {0x00003, 0x81884000},
    {0x00004, 0x81900000},
    {0x00005, 0x81980000},
    {0x00006, 0x81800000},
    {0x00007, 0xA1800000},
    {0x00008, 0x01000000},
    {0x00009, 0x03002040},
    {0x0000A, 0x8210600F},
    {0x0000B, 0xC2A00040},
    {0x0000C, 0x84100000},
    {0x0000D, 0x01000000},
    {0x0000E, 0x01000000},
    {0x0000F, 0x01000000},
    {0x00010, 0x01000000},
    {0x00011, 0x01000000},
    {0x00012, 0x80108002},
    {0x00013, 0x01000000},
    {0x00014, 0x01000000},
    {0x00015, 0x01000000},
    {0x00016, 0x01000000},
    {0x00017, 0x01000000},
    {0x00018, 0x87444000},
    {0x00019, 0x8608E01F},
    {0x0001A, 0x88100000},
    {0x0001B, 0x8A100000},
    {0x0001C, 0x8C100000},
    {0x0001D, 0x8E100000},
    {0x0001E, 0xA0100000},
    {0x0001F, 0xA2100000},
    {0x00020, 0xA4100000},
    {0x00021, 0xA6100000},
    {0x00022, 0xA8100000},
    {0x00023, 0xAA100000},
    {0x00024, 0xAC100000},
    {0x00025, 0xAE100000},
    {0x00026, 0x90100000},
    {0x00027, 0x92100000},
    {0x00028, 0x94100000},
    {0x00029, 0x96100000},
    {0x0002A, 0x98100000},
    {0x0002B, 0x9A100000},
    {0x0002C, 0x9C100000},
    {0x0002D, 0x9E100000},
    {0x0002E, 0x86A0E001},
    {0x0002F, 0x16BFFFEF},
    {0x00030, 0x81E00000},
    {0x00031, 0x82102002},
    {0x00032, 0x81904000},
    {0x00033, 0x03000004},
    {0x00034, 0x821060E0},
    {0x00035, 0x81884000},
    {0x00036, 0x01000000},
    {0x00037, 0x01000000},
    {0x00038, 0x01000000},
    {0x00039, 0x83480000},
    {0x0003A, 0x8330600C},
    {0x0003B, 0x80886001},
    {0x0003C, 0x02800024},
    {0x0003D, 0x01000000},
    {0x0003E, 0x07000000},
    {0x0003F, 0x8610E178},
    {0x00040, 0xC108C000},
    {0x00041, 0xC118C000},
    {0x00042, 0xC518C000},
    {0x00043, 0xC918C000},
    {0x00044, 0xCD18C000},
    {0x00045, 0xD118C000},
    {0x00046, 0xD518C000},
    {0x00047, 0xD918C000},
    {0x00048, 0xDD18C000},
    {0x00049, 0xE118C000},
    {0x0004A, 0xE518C000},
    {0x0004B, 0xE918C000},
    {0x0004C, 0xED18C000},
    {0x0004D, 0xF118C000},
    {0x0004E, 0xF518C000},
    {0x0004F, 0xF918C000},
    {0x00050, 0xFD18C000},
    {0x00051, 0x01000000},
    {0x00052, 0x01000000},
    {0x00053, 0x01000000},
    {0x00054, 0x01000000},
    {0x00055, 0x01000000},
    {0x00056, 0x89A00842},
    {0x00057, 0x01000000},
    {0x00058, 0x01000000},
    {0x00059, 0x01000000},
    {0x0005A, 0x01000000},
    {0x0005B, 0x10800005},
    {0x0005C, 0x01000000},
    {0x0005D, 0x01000000},
    {0x0005E, 0x00000000},
    {0x0005F, 0x00000000},
    {0x00060, 0x87444000},
    {0x00061, 0x8730E01C},
    {0x00062, 0x8688E00F},
    {0x00063, 0x1280000A},
    {0x00064, 0x03200000},
    {0x00065, 0x05040E00},
    {0x00066, 0x8410A133},
    {0x00067, 0xC4204000},
    {0x00068, 0x0539AE03},
    {0x00069, 0x8410A250},
    {0x0006A, 0xC4206004},
    {0x0006B, 0x050003FC},
    {0x0006C, 0xC4206008},
    {0x0006D, 0x05000080},
    {0x0006E, 0x82100000},
    {0x0006F, 0x80A0E000},
    {0x00070, 0x02800005},
    {0x00071, 0x01000000},
    {0x00072, 0x82004002},
    {0x00073, 0x10BFFFFC},
    {0x00074, 0x8620E001},
    {0x00075, 0x3D1003FF},
    {0x00076, 0xBC17A3E0},
    {0x00077, 0xBC278001},
    {0x00078, 0x9C27A060},
    {0x00079, 0x03100000},
    {0x0007A, 0x07200001},
    {0x0007B, 0x8610E200},
    {0x0007C, 0xC220E014},
    {0x0007D, 0x0500FFC0},
    {0x0007E, 0x8410A2FF},
    {0x0007F, 0xC420E004},
    {0x00080, 0x05000280},
    {0x00081, 0x8410A00A},
    {0x00082, 0xC420E008},
    {0x00083, 0xC420E00C},
    {0x00084, 0x050104C0},
    {0x00085, 0x8410A313},
    {0x00086, 0xC420E004},
    {0x00087, 0x84102021},
    {0x00088, 0xC420E000},
    {0x00089, 0x84102040},
    {0x0008A, 0x84A0A001},
    {0x0008B, 0x36BFFFFF},
    {0x0008C, 0xC4284002},
    {0x0008D, 0x84102040},
    {0x0008E, 0x84A0A001},
    {0x0008F, 0x36BFFFFF},
    {0x00090, 0xC6084002},
    {0x00091, 0x82006040},
    {0x00092, 0x84102040},
    {0x00093, 0x84A0A002},
    {0x00094, 0x36BFFFFF},
    {0x00095, 0xC4304002},
    {0x00096, 0x84102040},
    {0x00097, 0x84A0A002},
    {0x00098, 0x36BFFFFF},
    {0x00099, 0xC6104002},
    {0x0009A, 0x82006040},
    {0x0009B, 0x84102040},
    {0x0009C, 0x84A0A004},
    {0x0009D, 0x36BFFFFF},
    {0x0009E, 0xC4204002},
    {0x0009F, 0x84102040},
    {0x000A0, 0x84A0A004},
    {0x000A1, 0x36BFFFFF},
    {0x000A2, 0xC6004002},
    {0x000A3, 0x82006040},
    {0x000A4, 0x84102040},
    {0x000A5, 0x84A0A008},
    {0x000A6, 0x36BFFFFF},
    {0x000A7, 0xC4384002},
    {0x000A8, 0x84102040},
    {0x000A9, 0x84A0A008},
    {0x000AA, 0x36BFFFFF},
    {0x000AB, 0xC8184002},
    {0x000AC, 0x10BFFFC9},
    {0x000AD, 0x01000000},
    {0x000AE, 0xC4004000},
    {0x000AF, 0xC4184000},
    {0x000B0, 0xC4186010},
    {0x000B1, 0x82006020},
    {0x000B2, 0x10BFFFF3},
    {0x000B3, 0x01000000},
    {0x000B4, 0x81C04000},
    {0x000B5, 0x01000000},
    {0x000B6, 0x01000000},
    {0x000B7, 0x01000000},
    {0x000B8, 0x00000000},
    {0x000B9, 0x00000000},
    {0x000BA, 0x00000000},
    {0x000BB, 0x00000000},
    {0x000BC, 0x00000000},
    {0,0},
};