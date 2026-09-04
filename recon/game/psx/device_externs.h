/* device_externs.h -- extern decls for game/psx/device.cpp (NFS4 PSX input/pad). */
#ifndef DEVICE_EXTERNS_H
#define DEVICE_EXTERNS_H

#include "device_types.h"

/* ---- compiler builtin ---- */
extern void trap(int);  /* Ghidra builtin = MIPS `break` (gcc div-by-zero 0x1C00 / INT_MIN/-1 overflow 0x1800 guard) */

/* ---- PsyQ libpad ---- */

/* ---- harvested from sealed *_externs.h ---- */
extern GameSetup_tData   GameSetup_gData;
extern Sim_tSimSystemVar simVar;
extern int               Replay_ReplayMode;   /* 0x8013d3f4 */
extern int             Input_gHandler[];        /* 0x80113c14  per-control packed input descriptor */
extern int gUseFrontend;
extern tPadModuleState   gPadinfo;
extern tfrontEnd         frontEnd;

extern "C" {
u_short PAD_state(int padID);
void PAD_update(void);
}

/* ---- SYM Globals + free fns ---- */
extern void InGame_ResetPSXController(int, int);

/* ---- Device.obj own globals (SYM c_type absent; widths inferred from Ghidra literals/usage) ----
   🔴 DO NOT RE-SORT (17B EXTERN-ORDER LAW).  All six are TU-owned TENTATIVE
   definitions in device.cpp, so they emit in the order their identifiers are
   FIRST DECLARED -- these lines, not the .cpp.  This order IS device.obj's
   retail .sdata run (SYM device.obj block):
     0x8013d778 gForcePause -> d77c gPausePort -> d780 gPaused ->
     0x8013d784 gToggleTime[2] -> d78c gPrev[2] -> d794 gPausePortIndex. */
extern int    Device_gForcePause;      /* nonzero requests the forced-pause state */
extern int    Device_gPausePort;       /* holds -1/0/4 */
extern int    Device_gPaused;          /* !=0 / =0,1 */
extern int    Device_gToggleTime[2];   /* per-port toggle frame-count (=0x11) */
extern int Device_gPrev[2];            /* per-port previous pad state (SYM INT[2]) */
extern char   Device_gPausePortIndex;  /* Ghidra char literal \x01/\0 */
/* Device_gFailCount -> now SYM-faithful function-local `static u_char failtime[2]` in Device_Fail (STAT @0x8013DDE4) */

#endif
