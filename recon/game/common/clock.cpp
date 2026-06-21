/* game/common/clock.cpp -- RECONSTRUCTED (NFS4 game clock: 128Hz EAC timer chain + master IRQ handler).
 *   3 fns: MasterInterruptHandler / SystemStartUp / SystemCleanUp. SYM-v3 locals; owns 4 globals.
 *   Verified vs disasm-v2.txt (addtimer/deltimer 1-arg = &Clock_MasterInterruptHandler). Self-contained.
 */
#include "../../nfs4_types.h"
#include "clock_externs.h"


/* ---- clock.obj-owned globals (.bss zero) ---- */
Clock_tGameClock clock_realTime;   /* @0x80110c24  (bss(zero)) */
int          clock_InterruptStarted;   /* @0x8013c820  (bss(zero)) */
int          stopClock;   /* @0x8013c824  (bss(zero)) */
int          generic128HzClock;   /* @0x8013c828  (bss(zero)) */


/* ---- intra-TU forward declarations ---- */
void Clock_MasterInterruptHandler(void);
void Clock_SystemStartUp(void);
void Clock_SystemCleanUp(void);


/* ---- Clock_MasterInterruptHandler__Fv  [@0x8008b938] ---- */
void Clock_MasterInterruptHandler(void)
{
  long gp;
  u_int local_10 [2];
  
  savegp(local_10);
  if (stopClock == 0) {
    clock_realTime.time128Hz = clock_realTime.time128Hz + 1;
    generic128HzClock = generic128HzClock + 1;
    if (((clock_realTime.time128Hz & 1U) == 0) &&
       (clock_realTime.time64Hz = clock_realTime.time64Hz + 1, (clock_realTime.time64Hz & 1U) == 0))
    {
      clock_realTime.time32Hz = clock_realTime.time32Hz + 1;
      if ((clock_realTime.time32Hz & 1U) == 0) {
        Input_Update();
      }
      Input_Store();
    }
  }
  restoregp(local_10[0]);
  return;
}

/* ---- Clock_SystemStartUp__Fv  [@0x8008b9e4] ---- */
void Clock_SystemStartUp(void)
{
  
  stopClock = 0;
  generic128HzClock = 0;
  if (clock_InterruptStarted == 0) {
    clock_InterruptStarted = 1;
    addtimer(Clock_MasterInterruptHandler);
    clock_realTime.time128Hz = 0;
    clock_realTime.time64Hz = 0;
    clock_realTime.time32Hz = 0;
    Input_gTime = 0;
  }
  R3DCar_ClockLast = 0;
  return;
}

/* ---- Clock_SystemCleanUp__Fv  [@0x8008ba40] ---- */
void Clock_SystemCleanUp(void)
{
  int gp;
  
  if (clock_InterruptStarted != 0) {
    clock_InterruptStarted = 0;
    deltimer(Clock_MasterInterruptHandler);
  }
  return;
}
