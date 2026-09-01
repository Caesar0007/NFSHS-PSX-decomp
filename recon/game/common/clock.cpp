/* game/common/clock.cpp -- RECONSTRUCTED (NFS4 game clock: 128Hz EAC timer chain + master IRQ handler).
 *   3 fns: MasterInterruptHandler / SystemStartUp / SystemCleanUp. SYM-v3 locals; owns 4 globals.
 *   Verified vs disasm-v2.txt (addtimer/deltimer 1-arg = &Clock_MasterInterruptHandler). Self-contained.
 */
#include "clock_types.h"
#include "clock_externs.h"


/* ---- clock.obj-owned globals (.bss zero) ---- */
Clock_tGameClock clock_realTime;   /* @0x80110c24  (bss(zero)) */
/* Explicit zero initialization is source-significant here: GCC 2.8.1 emits
 * this file-static word in .sdata, matching the SYM/retail slot at 0x8013c820;
 * a tentative definition instead falls into .sbss and shifts every later
 * small-data owner by four bytes. */
static int   clock_InterruptStarted = 0;   /* @0x8013c820  (SYM STAT) */
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
  int even128;

  savegp(local_10);
  if (stopClock == 0) {
    clock_realTime.time128Hz = clock_realTime.time128Hz + 1;
    /* MATCH: the 128Hz parity is read into a temp BEFORE the generic128HzClock store
       so the `andi v1,v1,1` issues ahead of the gp-rel store (oracle 8008B970/74). */
    even128 = clock_realTime.time128Hz & 1U;
    generic128HzClock = generic128HzClock + 1;
    /* MATCH: 0-insn void fence stops reorg stealing the `addiu a0,a0,%lo(clock_realTime)`
       base materialization into the bnez delay slot (oracle 8008B97C is a nop). */
    __asm__("" : : "i"(0));
    if (!even128) {
      clock_realTime.time64Hz = clock_realTime.time64Hz + 1;
      if (!(clock_realTime.time64Hz & 1U)) {
        clock_realTime.time32Hz = clock_realTime.time32Hz + 1;
        if (!(clock_realTime.time32Hz & 1U)) {
          Input_Update();
        }
        Input_Store();
      }
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
  if (clock_InterruptStarted != 0) {
    clock_InterruptStarted = 0;
    deltimer(Clock_MasterInterruptHandler);
  }
  return;
}
