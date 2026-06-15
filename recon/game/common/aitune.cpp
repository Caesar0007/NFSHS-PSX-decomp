/* game/common/AITUNE.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   bworld.obj (GAME\COMMON\bworld.cpp) = 20 fns: BWorld road geometry build/render
 *   (chunk visibility, build lists, spike belt, glare effects, render contexts). Self-contained.
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "../../nfs4_types.h"
#include "aitune_externs.h"

extern int D_80113228[];   /* GameSetup_gData.track standalone @0x80113228 (+0x3C); array form -> separate base reg */


/* ---- AITUNE.obj-owned globals (SYM-typed; .data=real EXE bytes, .bss=zero) ---- */
AITune_BTC_t AITune_BTC[3] = { {98304, 55705, 65536, 5760, 64, 1920, 5760}, {65536, 65536, 65536, 3840, 2880, 5760, 8320}, {52428, 72089, 65536, 2880, 3840, 7680, 9600} };   /* @0x8010de14 */
int          AITune_BTCPerpAccMults[3] = { 49152, 55705, 65536 };   /* @0x8010de68 */
AITune_tTrackInfo AITune_trackInfo[12] = { {0, 1, 170}, {0, 1, 130}, {0, 1, 135}, {0, 1, 120}, {0, 1, 118}, {0, -1, 130}, {0, 1, 145}, {0, -1, 110}, {0, 1, 121}, {0, 1, 140}, {0, 1, 145}, {0, 1, 90} };   /* @0x8010de74 */
accelscale_t AITune_accelerationScale[22] = { {65536}, {65536}, {65536}, {65536}, {65536}, {65536}, {65536}, {65536}, {65536}, {65536}, {65536}, {65536}, {65536}, {65536}, {65536}, {65536}, {65536}, {65536}, {65536}, {65536}, {65536}, {65536} };   /* @0x8010df04 */
copTuning_t  copTuningInfo[6] = { {65536, 78643, 6407964, 6407964}, {65536, 78643, 6407964, 6407964}, {65536, 78643, 6407964, 6407964}, {65536, 78643, 6407964, 6407964}, {65536, 78643, 6407964, 6407964}, {65536, 78643, 6407964, 6407964} };   /* @0x8010df5c */
int          AITune_MaxTraffic[2][4] = { 5, 5, 5, 5, 1, 1, 1, 1 };   /* @0x8010dfbc */
int          AITune_LifeTimer[12] = { 25, 50, 75, 100, 200, 400, 500, 800, 900, 1000, 1100, 1200 };   /* @0x8010dfdc */
int          AITune_oneWay;   /* @0x8013c5f0  (bss(zero)) */
int          AITune_driveSide;   /* @0x8013c5f4  (bss(zero)) */
int          AITune_gRoughLapTime;   /* @0x8013c5f8  (bss(zero)) */


/* ---- intra-TU forward declarations ---- */
int AITune_GetOneWay(void);
int AITune_GetDriveSide(void);
int AITune_GetRoughLapTimes(void);
void AITune_StartUp1(void);
void AITune_StartUp2(void);
void AITune_CleanUp1(void);
void AITune_CleanUp2(void);


/* ---- AITune_GetOneWay__Fv  [@0x80072e68] ---- */
int AITune_GetOneWay(void)
{
  if (D_80113228[0] < 0xc) {
    return AITune_trackInfo[D_80113228[0]].oneWay;
  }
  return (u_int)(*(u_char *)((int)BWorldSm_slices + 0x3d) >> 4 == 0);
}

/* ---- AITune_GetDriveSide__Fv  [@0x80072ec0] ---- */
int AITune_GetDriveSide(void)
{
  if (D_80113228[0] < 0xc) {
    return AITune_trackInfo[D_80113228[0]].driveSide;
  }
  return 1;
}

/* ---- AITune_GetRoughLapTimes__Fv  [@0x80072f00] ---- */
int AITune_GetRoughLapTimes(void)
{
  if (D_80113228[0] < 0xc) {
    return AITune_trackInfo[D_80113228[0]].roughLapTimeSeconds;
  }
  return 0xbe;
}

/* ---- AITune_StartUp1__Fv  [@0x80072f40] ---- */
void AITune_StartUp1(void)
{
  AITune_oneWay = AITune_GetOneWay();
  AITune_driveSide = AITune_GetDriveSide();
  AITune_gRoughLapTime = AITune_GetRoughLapTimes();
  return;
}

/* ---- AITune_StartUp2__Fv  [@0x80072f78] ---- */
void AITune_StartUp2(void)
{
  return;
}

/* ---- AITune_CleanUp1__Fv  [@0x80072f80] ---- */
void AITune_CleanUp1(void)
{
  return;
}

/* ---- AITune_CleanUp2__Fv  [@0x80072f88] ---- */
void AITune_CleanUp2(void)
{
  return;
}
