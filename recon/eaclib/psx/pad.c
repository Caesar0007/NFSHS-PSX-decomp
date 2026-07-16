/* eaclib/psx/pad.c  -- RECONSTRUCTED  (SLD source D:\nfs4\EACLIB\PSX\PAD.C)
 *   C TU: SLD-proven .C -> CC1PSX lane (methodology 3.25; migrated from pad.cpp, task #90).
 *   Self-contained per C-lane convention (local types; unmangled C symbols match the SYM).
 *   Bodies      : Ghidra decompiler (nfs4-f.exe MIPS code).
 *   Line numbers: PsyQ SLD per-instruction stream (the 8c 'Function start line' is unreliable
 *                 for PAD_convert/PAD_update by +21/+22; SLD is authoritative).
 *   Signatures  : SYM-faithful.  padinit/PAD_restore = void (SYM FCN VOID; the prior 'int'
 *                 was a decompiler $v0-liveness artifact - SYM records 0 locals for both).
 *                 PAD_convert = class STAT -> file-local static (not exported).
 *   pad.c = EXACTLY 5 functions filling 0x800E40E8-0x800E4318. Inter-fn line gaps are
 *   static data / macros / comments, NOT hidden functions. Original EA source is not public.
 *   LOCAL NAMES: only PAD_update's 'i' is SYM-authentic (REG $t0 loop index); all other local
 *   names across all 5 fns are SEMANTIC reconstructions (debug info preserved no other locals).
 */

typedef unsigned char  u_char;
typedef unsigned char  byte;
typedef unsigned short u_short;
typedef unsigned int   uint;

/* ---- local mirrors of the shared pad types (nfs4_types.h is C++-only) ---- */
typedef struct PAD_PSX {              /* 6 bytes */
    u_short state;                    /* +0x0 */
    u_short unused[2];                /* +0x2 */
} PAD_PSX;

typedef union tPadVariantData {       /* 6 bytes (only .standard read in this TU) */
    PAD_PSX standard;
} tPadVariantData;

typedef struct PAD_COMMON {           /* 8 bytes */
    u_char          nopad, ID;        /* +0x0 */
    tPadVariantData data;             /* +0x2 */
} PAD_COMMON;

typedef struct tActiveTime {          /* 2 bytes */
    char bActive, time;               /* +0x0 */
} tActiveTime;

typedef struct tPadModuleState {      /* 84 bytes */
    int         initialized;          /* +0x0 */
    PAD_COMMON  buf[8];               /* +0x4 */
    tActiveTime state[8];             /* +0x44 */
} tPadModuleState;

/* ---- pad.obj data globals (eaclib/psx, from canonical Globals) ---- */
extern PAD_COMMON      Padglobal[2];  /* 0x8013e8f0  per-port pad buffers   */
extern tPadModuleState gPadinfo;      /* 0x8013e89c  module state (84 B)    */

/* ---- PsyQ libpad (direct mode) ---- */
extern void PadInitDirect(unsigned char *pad1, unsigned char *pad2);
extern void PadStartCom(void);
extern void PadStopCom(void);

/* ---- eaclib (EACPSXZ) ---- */
extern void blockclear(void *dst, int size);
extern void blockmove(void *src, void *dst, int size);
extern void blockfill(void *dst, int size, int val);
extern int  addtimer(void (*proc)(void));
extern int  deltimer(void (*proc)(void));

/* PAD_convert is SYM class STAT (file-local static); forward-declared for PAD_state. */
static u_short PAD_convert(PAD_COMMON *pad);
void PAD_update(void);

/* lines 1-65: file header, #includes, static data, macros (no symbols emitted) */

/* ---- padinit  (PAD.C:66, code lines 66-79) ---- */
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

/* ---- PAD_restore  (PAD.C:83, code lines 83-89) ---- */
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

/* ---- PAD_state  (PAD.C:172, code lines 172-186) ---- */
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

/* ---- PAD_convert  (PAD.C:278, code lines 278-278)  [static] ---- */
static u_short PAD_convert(PAD_COMMON *pad)
{
  return ~(uint)(pad->data).standard.state & 0xffff;
}

/* lines 279-319: (static data / macros / comments - no emitted code) */

/* ---- PAD_update  (PAD.C:320, code lines 320-375) ---- */
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
    if (((rawBtn == 0) != (btnState->bActive != 0)) &&
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

/* end of pad.c (~line 375 per SLD) */
