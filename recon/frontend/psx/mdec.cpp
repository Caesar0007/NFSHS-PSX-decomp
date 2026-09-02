/* frontend/psx/mdec.cpp  --  RECONSTRUCTED  (PSX MDEC / DCT video-frame decode)
 *   Bodies      : Ghidra decompiler (nfs4-f.exe MIPS), full re-decompile.
 *   Line numbers: PsyQ SLD per-instruction stream (cross-checked 8c-start/8e-end).
 *   Field names : SYM-authentic MDECSTRUCT layout incl. nested RECT framerect/striprect.
 *   Linkage     : initmdec/restoremdec/mdec/mdecdone = extern "C" (unmangled in SYM);
 *                 mdecreset/MDECCompleteHandler = normal C++ (cfront-mangled in SYM).
 *   Locals      : SYM-EXACT -- the SYM's only named locals in this TU are `mdec`
 *                 (initmdec/restoremdec/mdec/MDECCompleteHandler) and `timeout` (mdec).
 *                 initmdec additionally keeps four NON-SYM codegen carriers
 *                 (area/stripsize/stride/bufsize), each with a measured cost below;
 *                 every other Ghidra temp (buf/hs/mode/drawsync/nextx) was folded away.
 *                 Magic 0x4345444d='MDEC'.
 */
#include "mdec.h"
#include "mdec_externs.h"

/* lines 1-91: file header, #includes, static data (DECDCTTAB), macros (no symbols) */

/* ---- initmdec  (mdec.cpp:92, code lines 92-145) ---- */
int initmdec(int width,int height,int bpp,int memtype)

{
  /* SYM 8c records exactly ONE local here: mdec (REG $18, MDECSTRUCT*).  It is
     declared first, per SYM order; the four below have NO SYM record and are
     kept only as measured codegen carriers (w86-S5 re-ordering, gate unchanged). */
  struct MDECSTRUCT *mdec;
  int area; /* SYM-CODEGEN-CARRIER: area -- folding it into stripsize is measured
               FAIL 22 at the same 101-instruction count */
  int stripsize; /* SYM-CODEGEN-CARRIER: stripsize -- folding into bufsize is
                    measured FAIL 6 (101/101) from chain scheduling alone */
  /* strip buffer is assigned directly; SYM records no `buf` local. */
  int stride; /* SYM-CODEGEN-CARRIER: stride -- reusing area rotates both divide
                 chains and is measured FAIL 16 at the same 101-instruction count */
  int bufsize; /* SYM-CODEGEN-CARRIER: bufsize -- reusing stripsize is count-exact
                    but forces the RMW operand order and is measured FAIL 2 */

  mdec = (struct MDECSTRUCT *)reservememadr("MDECstruct",0x2c,memtype);
  blockclear(mdec,0x2c);
  mdec->id = 0x4345444d;   /* 'MDEC' */
  if (gMDECinfo.numhandles == 0) {
    DecDCTReset(0);
    DecDCToutCallback(MDECCompleteHandler);
  }
  area = ((width + 0xfU) & 0xfffffff0) * ((height + 0xfU) & 0xfffffff0);
  mdec->width = width;
  mdec->height = height;
  mdec->bpp = bpp;
  if (area < 0) {
    area = area + 0xff;
  }
  /* MATCH: the strip-buffer term is its OWN statement (lower luid) so sched1 issues the
     area chain before the bpp chain, while the sum keeps `bpp*0x1e0` as addu operand 1.
     A one-expression form gets the two independent chains in the opposite order; folding
     the term back into `area`/`bufsize` makes the add an in-place RMW (addu s0,s0,s1). */
  stripsize = (area >> 8) * 0x300;
  bufsize = bpp * 0x1e0 + stripsize;
  mdec->stripbuf = (u_long *)reservememadr("MDEC buffers",bufsize,memtype);
  /* assignment performed at allocation */
  blockclear(mdec->stripbuf,bufsize);
  stride = width * bpp;
  mdec->striprect.w = (short)bpp;
  mdec->vlcbuf = (u_long *)((int)mdec->stripbuf + bpp * 0x1e0);
  if (stride < 0) {
    stride = stride + 0xf;
  }
  mdec->framerect.h = (short)height;
  /* MATCH: no `hs` local in the SYM -- retail narrows `height` IN PLACE, so the
     sign-extended value lands back in height's own register (oracle $s3). */
  height = (short)height;
  mdec->framerect.w = (short)(stride >> 4);
  mdec->striprect.h = (short)height;
  mdec->striprectsize =
       ((int)mdec->striprect.w * height) / 2;
  gMDECinfo.numhandles = gMDECinfo.numhandles + 1;
  return (int)mdec;
}

/* lines 146-179: (static data / macros / comments - no emitted code) */

/* ---- restoremdec  (mdec.cpp:180, code lines 180-205) ---- */
void restoremdec(int handle)

{
  struct MDECSTRUCT *mdec = (struct MDECSTRUCT *)handle;

  gMDECinfo.numhandles = gMDECinfo.numhandles + -1;
  if (gMDECinfo.numhandles == 0) {
    DecDCToutCallback(0);
  }
  purgememadr(mdec->stripbuf);
  mdec->id = 0;
  purgememadr(mdec);
  return;
}

/* lines 206-238: (static data / macros / comments - no emitted code) */

/* ---- mdecreset  (mdec.cpp:239, code lines 239-245) ---- */
void mdecreset(void)

{
  if (gMDECinfo.numhandles != 0) {
    DecDCTReset(0);
    DecDCToutCallback(MDECCompleteHandler);
  }
  gMDECinfo.hDecode = 0;
  return;
}

/* lines 246-294: (static data / macros / comments - no emitted code) */

/* ---- mdec  (mdec.cpp:295, code lines 295-338) ---- */
void mdec(int handle,char *src,int x,int y)

{
  /* mode is selected directly at the DecDCTin call; SYM records no local. */
  int timeout;
  struct MDECSTRUCT *mdec = (struct MDECSTRUCT *)handle;

  timeout = ticks + timerhz * 4;
  /* MATCH: exit-in-the-middle prevents gcc's loop rotation -- the oracle keeps the
     hDecode test at the TOP of the loop with an unconditional `j` back-edge. */
  while (1) {
    if (gMDECinfo.hDecode == 0) break;
    systemtask(0);
    if (timeout < ticks) {
      mdecreset();
    }
  }
  gMDECinfo.hDecode = handle;
  DecDCTvlc((u_long *)(src + 8),mdec->vlcbuf);
  mdec->striprect.x = (short)x;
  mdec->framerect.x = (short)x;
  mdec->striprect.y = (short)y;
  mdec->framerect.y = (short)y;
  DecDCTin(mdec->vlcbuf,(mdec->bpp == 0x18) ? 3 : 2);
  DecDCTout(mdec->stripbuf,mdec->striprectsize);
  return;
}

/* lines 339-380: (static data / macros / comments - no emitted code) */

/* ---- mdecdone  (mdec.cpp:381, code lines 381-382) ---- */
int mdecdone(int handle)

{ /* MATCH (w44): the oracle materializes &gMDECinfo as an ADDRESS VALUE (lui+addiu = `la`)
   and keeps the field offset as the load DISPLACEMENT (lw 4(v0)) -- 3 insns, where the plain
   read folds to the 2-insn `lui %hi(sym+4); lw %lo(sym+4)` split.  MECHANISM: gcc-2.8's
   TARGET_SPLIT_ADDRESSES lowering (mips_check_split -> HIGH/LO_SUM of the WHOLE `sym+4`) is
   NOT applied to a VOLATILE MEM -- a volatile reference must have a plain REG(+disp) address,
   so cc1 forces `&gMDECinfo` into a register first.  The `volatile` is also the semantically
   honest reading: mdecdone is the POLLING predicate for an asynchronous decode, and
   gMDECinfo.hDecode is cleared behind the compiler's back by MDECCompleteHandler (the
   DecDCTout completion callback) -- exactly the read that must not be cached (methodology
   §3.12 #13).  PER-SITE only: qualifying the whole object, or the hDecode field, TU-wide
   regresses restoremdec (11) / mdecreset (16) respectively -- retail's setters used the plain
   struct.  (All five earlier shapes -- ptr-temp, ((int*)&g)[1], unsized asm-label views
   int[]/int[2]/int[4]/T[1]/T[], -G0 and -mno-split-addresses -- fold back; measured again.) */
  return (u_int)(((volatile __typeof__(gMDECinfo) *)&gMDECinfo)->hDecode != handle);
}

/* lines 383-387: (static data / macros / comments - no emitted code) */

/* ---- MDECCompleteHandler  (mdec.cpp:388, code lines 388-415) ---- */
void MDECCompleteHandler(void)

{
  /* striprect.x is updated and tested directly; SYM records no temporary. */
  /* DrawSync is tested directly; SYM records no result local. */
  struct MDECSTRUCT *mdec = (struct MDECSTRUCT *)gMDECinfo.hDecode;

  LoadImage
            (&mdec->striprect,mdec->stripbuf);
  /* call remains at the original SLD statement */
  if (DrawSync(0) != 0) {
    g_mdecdrawsyncfailed[0] = 1;
  }
  mdec->striprect.x = mdec->striprect.x + mdec->bpp;
  /* the stored short value is the comparison operand */
  if ((int)mdec->striprect.x < (int)mdec->framerect.x + (int)mdec->framerect.w) {
    DecDCTout(mdec->stripbuf,mdec->striprectsize);
  }
  else {
    gMDECinfo.hDecode = 0;
  }
  return;
}

/* end of mdec.cpp */
