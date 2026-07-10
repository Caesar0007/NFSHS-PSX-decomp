/* eaclib/psx/pad.cpp  -- RECONSTRUCTED  (converted from PAD.C; D:\nfs4\EACLIB\PSX\PAD.C)
 *   PAD.C is a C source whose 4 exported symbols are UNMANGLED in the SYM; compiled here
 *   as C++ with C linkage (extern "C" in pad.h) so the symbol names match the SYM exactly.
 *   Bodies      : Ghidra decompiler (nfs4-f.exe MIPS code).
 *   Line numbers: PsyQ SLD per-instruction stream (the 8c 'Function start line' is unreliable
 *                 for PAD_convert/PAD_update by +21/+22; SLD is authoritative).
 *   Signatures  : SYM-faithful.  padinit/PAD_restore = void (SYM FCN VOID; the prior 'int'
 *                 was a decompiler $v0-liveness artifact - SYM records 0 locals for both).
 *                 PAD_convert = class STAT -> file-local static (not exported).
 *   pad.cpp = EXACTLY 5 functions filling 0x800E40E8-0x800E4318. Inter-fn line gaps are
 *   static data / macros / comments, NOT hidden functions. Original EA source is not public.
 *   LOCAL NAMES: only PAD_update's 'i' is SYM-authentic (REG $t0 loop index); all other local
 *   names across all 5 fns are SEMANTIC reconstructions (debug info preserved no other locals).
 */
#include "pad.h"           /* extern "C" prototypes for the 4 exported fns + globals */
#include "pad_externs.h"   /* libpad + eaclib prototypes */

/* PAD_convert is SYM class STAT (file-local static); forward-declared for PAD_state. */
static u_short PAD_convert(PAD_COMMON *pad);

/* lines 1-65: file header, #includes, static data, macros (no symbols emitted) */

/* ---- padinit  (pad.cpp:66, code lines 66-79) ---- */
void padinit(void)
{
  if (gPadinfo.initialized == 0) {
    PadInitDirect(&Padglobal[0].nopad, &Padglobal[1].nopad);
    PadStartCom();
    blockclear(&gPadinfo, 0x54);
    gPadinfo.initialized = 1;
    addtimer(PAD_update);
  }
}

/* lines 80-82: (static data / macros / comments - no emitted code) */

/* ---- PAD_restore  (pad.cpp:83, code lines 83-89) ---- */
void PAD_restore(void)
{
  /* RESIDUAL (10-diff, per-obj TOOLCHAIN-IDENTITY floor, methodology 3.25): the PAD.OBJ
   * oracle has EVERY delay slot as a nop (beqz/jal/jr) + an unfused `la gPadinfo`
   * (lui+addiu, loads at 0(s0)) -- reproduced exactly by cc1 -fno-delayed-branch, NOT
   * by repo -O2/-O1 flags (both fill the slots; %lo stays fused even w/ a pointer
   * local, w/ -fno-delayed-branch, and at -O1).  Not source-reachable under the fixed
   * repo CC1 lane; needs a per-obj flag lane (build-config, out of worker scope). */
  if (gPadinfo.initialized != 0) {
    deltimer(PAD_update);
    PadStopCom();
    gPadinfo.initialized = 0;
  }
}

/* lines 90-171: (static data / macros / comments - no emitted code) */

/* ---- PAD_state  (pad.cpp:172, code lines 172-186) ---- */
u_short PAD_state(int padID)
{
  uint buttons;

  if ((gPadinfo.initialized == 0) || (7 < (uint)padID)) {
    buttons = 0;
  }
  else {
    buttons = PAD_convert(gPadinfo.buf + padID);
    buttons = buttons & 0xffff;
  }
  return buttons;
}

/* lines 187-277: (static data / macros / comments - no emitted code) */

/* ---- PAD_convert  (pad.cpp:278, code lines 278-278)  [static] ---- */
static u_short PAD_convert(PAD_COMMON *pad)
{
  return ~(uint)(pad->data).standard.state & 0xffff;
}

/* lines 279-319: (static data / macros / comments - no emitted code) */

/* ---- PAD_update  (pad.cpp:320, code lines 320-375) ---- */
/* locals provenance: 'i' = SYM-authentic (REG $t0 loop index); liveDst/deltaDst/padOff/
   fillLen/fillDst/btnOff/debTimer/btnState/rawBtn/debCount = SEMANTIC names inferred from
   data-flow analysis (original source names not in debug info). */
void PAD_update(void)
{
  byte *liveDst;
  byte *fillDst;
  char *debTimer;
  int fillLen;
  tActiveTime *btnState;
  int btnOff;
  int i;
  int padOff;
  byte *deltaDst;
  byte rawBtn;
  byte debCount;

  liveDst = &gPadinfo.buf[0].nopad;
  deltaDst = &gPadinfo.buf[1].nopad;
  padOff = 0;
  do {
    if ((&Padglobal[0].nopad)[padOff] == '\0') {
      blockmove(&Padglobal[0].nopad + padOff, liveDst, 8);
      fillLen = 0x18;
      fillDst = deltaDst;
    }
    else {
      fillLen = 0x20;
      fillDst = liveDst;
    }
    blockfill(fillDst, fillLen, 0xff);
    deltaDst = deltaDst + 0x20;
    padOff = padOff + 8;
    liveDst = liveDst + 0x20;
  } while (padOff < 0x10);
  i = 0;
  debTimer = &gPadinfo.state[0].time;
  btnState = gPadinfo.state;
  btnOff = 0;
  do {
    rawBtn = (&gPadinfo.buf[0].nopad)[btnOff];
    if (((rawBtn == 0) != (bool)btnState->bActive) &&
       (debCount = *debTimer, *debTimer = debCount + 1, 5 < debCount)) {
      btnState->bActive = rawBtn == 0;
      *debTimer = 0;
    }
    debTimer = debTimer + 2;
    btnState = btnState + 1;
    i = i + 1;
    btnOff = btnOff + 8;
  } while (i < 8);
}

/* end of pad.cpp (~line 375 per SLD) */
