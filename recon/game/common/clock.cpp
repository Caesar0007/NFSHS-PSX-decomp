/* game/common/clock.cpp -- RECONSTRUCTED (NFS4 game clock: 128Hz EAC timer chain + master IRQ handler).
 *   3 fns: MasterInterruptHandler / SystemStartUp / SystemCleanUp. SYM-v3 locals; owns 4 globals.
 *   Verified vs disasm-v2.txt (addtimer/deltimer 1-arg = &Clock_MasterInterruptHandler). Self-contained. */
#define NFS4_TU_CLOCK   /* owner key: Clock_tGameClock keep retail's C-style typedef form (2nd TPDEF at the definition) */
#include "clock_types.h"
#include "clock_externs.h"

/* Retail clock.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }
extern "C" int sprintf(char *buffer, char *fmt, ...);


/* ---- clock.obj-owned globals (.bss zero) ---- */
Clock_tGameClock clock_realTime;   /* @0x80110c24  (bss(zero)) */
/* Explicit zero initialization is source-significant here: GCC 2.8.1 emits
 * this file-static word in .sdata, matching the SYM/retail slot at 0x8013c820;
 * a tentative definition instead falls into .sbss and shifts every later
 * small-data owner by four bytes. */
static int   clock_InterruptStarted = 0;   /* @0x8013c820  (SYM STAT) */
int          stopClock;   /* @0x8013c824  (bss(zero)) */
volatile int generic128HzClock;   /* @0x8013c828  (bss(zero)) -- ISR-shared (user ruling 2026-11-06):
                                     written by this timer ISR, polled by r3dcar/fe3dmenu (their retail
                                     code re-loads it, see r3dcar_externs.h). The volatile store also leaves
                                     the parity bnez delay slot empty (retail nop) - replaces the old fence. */


/* ---- intra-TU forward declarations ---- */
void Clock_MasterInterruptHandler(void);
void Clock_SystemStartUp(void);
void Clock_SystemCleanUp(void);


/* ---- Clock_MasterInterruptHandler__Fv  [@0x8008b938] ---- */

#line 114 "C:/nfs4/GAME/COMMON/CLOCK.CPP"
void Clock_MasterInterruptHandler(void)
{
  long gp;

  savegp((u_int *)&gp);
  /* Retail shape: no early return -- one if (stopClock == 0) { ... } and a
     single restoregp, so no return_label follows the root block end and
     sched1 hoists the end note to the head of the restoregp block (retail
     SYM: root end +090).  Statement lines follow retail's SLD (savegp +3,
     stop test +14, counters +16/+18, parity test +20 ...).  The volatile
     store to generic128HzClock keeps reorg from moving the `addiu a0,%lo`
     base into the parity bnez delay slot (retail: nop); this also made the
     former record-less even128 const unnecessary (GAME5 round 7).
     Earlier receipts: CAMIN/GAME5 reports. */

  if (stopClock == 0) {

  clock_realTime.time128Hz = clock_realTime.time128Hz + 1;

  generic128HzClock = generic128HzClock + 1;

  if (!(clock_realTime.time128Hz & 1U)) {

    clock_realTime.time64Hz = clock_realTime.time64Hz + 1;
    if (!(clock_realTime.time64Hz & 1U)) {

      clock_realTime.time32Hz = clock_realTime.time32Hz + 1;

      if (!(clock_realTime.time32Hz & 1U))
        Input_Update();

      Input_Store();
    }
  }
  }




  restoregp(gp); }

/* ---- Clock_SystemStartUp__Fv  [@0x8008b9e4] ---- */

#line 156 "C:/nfs4/GAME/COMMON/CLOCK.CPP"
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







  R3DCar_ClockLast = 0; }

/* ---- Clock_SystemCleanUp__Fv  [@0x8008ba40] ---- */

#line 181 "C:/nfs4/GAME/COMMON/CLOCK.CPP"
void Clock_SystemCleanUp(void)
{
  if (clock_InterruptStarted != 0)
  {
    clock_InterruptStarted = 0;
    deltimer(Clock_MasterInterruptHandler);
  }
}
