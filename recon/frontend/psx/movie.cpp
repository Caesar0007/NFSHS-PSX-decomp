/* frontend/psx/movie.cpp  --  RECONSTRUCTED  (PSX .STR streaming movie player; C++ TU)
 *   Bodies: Ghidra decompiler. Line numbers: PsyQ SLD (8c-start, 8e-end).
 *   17 functions; C++ linkage (cfront-mangled in SYM). 10 EXT Movie + play_movie, 7 STAT str.
 *   Externs declared from Ghidra sigs (movie_externs.h).
 */
#include "movie.h"

/* Movie.obj STAT helpers.  strInit's reconstructed pointer callback signature is
 * codegen-correct but does not reproduce PsyQ's exact GCC-v2 spelling by itself. */
static void strSetDefDecEnv(DECENV *dec);
static void strInit(CdlLOC *loc,int frame_size,CallbackFunc callback,CallbackFunc endcallback)
  asm("strInit__FP6CdlLOCiPFe_vT2");
static void strCallback(void);
static int strNextVlc(DECENV *dec);
static u_long *strNext(DECENV *dec);
static void strSync(DECENV *dec,int mode);
static void strKickCD(CdlLOC *loc);

/* ---- Movie.obj STAT (file-local) globals ---- */
/* MATCH: every one of these statics is reached ABSOLUTELY (lui %hi / %lo) in the oracle,
 * never gp-relative -- force them out of .sdata/.sbss with an explicit .bss section
 * attribute (catalog §I-addendum; the -G4 default would put every <=4-byte scalar in sbss). */
static int     width_d asm("width") __attribute__((section(".bss")));     /* 0x80052a24 */
static int     height_d asm("height") __attribute__((section(".bss")));    /* 0x80052a28 */
static CdlLOC  loc_d asm("loc") __attribute__((section(".bss")));   /* 0x80052cf8 */
extern CdlLOC  loc_v[] asm("loc");   /* unsized view: forces base materialization */
extern int     StCdIntrFlag_v[] asm("StCdIntrFlag");
extern short   user_exit_v[] asm("user_exit");
#define user_exit user_exit_v[0]  /* unsized view (see MATCH note below) */
#define StCdIntrFlag StCdIntrFlag_v[0]
static short     PPWTop_d asm("PPWTop") __attribute__((section(".bss")));    /* 0x80052cfc */
static short     PPWBottom_d asm("PPWBottom") __attribute__((section(".bss"))); /* 0x80052cfe */
static short     gMode_d asm("gMode") __attribute__((section(".bss")));     /* 0x80052d00 */
static bool    gIsRGB24_d asm("gIsRGB24") __attribute__((section(".bss")));  /* 0x80052d04; SYM BOOL.  Accesses use the int-shaped unsized carrier below. */
static short     gMovieHeight_d asm("gMovieHeight") __attribute__((section(".bss")));/* 0x80052d08 */
static short     gMovieWidth_d asm("gMovieWidth") __attribute__((section(".bss")));/* 0x80052d0a */
static u_long  gMovieFrame_d asm("gMovieFrame") __attribute__((section(".bss")));/* 0x80052d0c */
static u_long  gEndFrame_d asm("gEndFrame") __attribute__((section(".bss")));  /* 0x80052d10 */
extern int width_v[] asm("width");
#define gWidth width_v[0]
extern int height_v[] asm("height");
#define gHeight height_v[0]
extern short PPWTop_v[] asm("PPWTop");
#define PPWTop PPWTop_v[0]
extern short PPWBottom_v[] asm("PPWBottom");
#define PPWBottom PPWBottom_v[0]
extern short gMode_v[] asm("gMode");
#define gMode gMode_v[0]
extern int gIsRGB24_v[] asm("gIsRGB24");
#define gIsRGB24 gIsRGB24_v[0]
extern short gMovieHeight_v[] asm("gMovieHeight");
#define gMovieHeight gMovieHeight_v[0]
extern short gMovieWidth_v[] asm("gMovieWidth");
#define gMovieWidth gMovieWidth_v[0]
extern u_long  gMovieFrame_v[] asm("gMovieFrame");
extern u_long  gEndFrame_v[]   asm("gEndFrame");
#define gMovieFrame gMovieFrame_v[0]
#define gEndFrame   gEndFrame_v[0]
/* MATCH: EVERY file-static above is reached through an UNSIZED-ARRAY view (asm-label
 * alias onto the same symbol).  The scalar form makes cc1 emit the single `lw/sw $r,sym`
 * ASSEMBLER MACRO (unschedulable, expands to a self-temp or an $at store); the unsized
 * form makes gcc lower %hi/%lo itself into a separate, schedulable register -- which is
 * what retail's aspsx build shows everywhere in this TU.  (catalog E/§3.12 #5.)
 * MATCH: four INDEPENDENT statics -- the oracle gives each its own %hi/%lo pair
 * (D_80052D14/18/1C/20); an array made gcc hoist one base + use displacements. */
static bool    bMovieLoaded_d asm("bMovieLoaded") __attribute__((section(".bss"))); /* 0x80052d14; SYM BOOL */
static bool    bStopMovie_d   asm("bStopMovie") __attribute__((section(".bss")));   /* 0x80052d18; SYM BOOL */
static int     bRewindMovie_d asm("bRewindMovie") __attribute__((section(".bss"))); /* 0x80052d1c */
static int     isFirstSlice_d asm("isFirstSlice") __attribute__((section(".bss"))); /* 0x80052d20 */
/* MATCH: unsized-array views onto the same four symbols -- the scalar form emits the
 * `sw $r,sym` ASSEMBLER MACRO ($at), the unsized-array form emits gcc's own lui+sw. */
extern int     bMovieLoaded_v[] asm("bMovieLoaded");
extern int     bStopMovie_v[]   asm("bStopMovie");
extern int     bRewindMovie_v[] asm("bRewindMovie");
extern int     isFirstSlice_v[] asm("isFirstSlice");
#define bMovieLoaded bMovieLoaded_v[0]
#define bStopMovie   bStopMovie_v[0]
#define bRewindMovie bRewindMovie_v[0]
#define isFirstSlice isFirstSlice_v[0]
static DECENV  dec;                                 /* 0x80052d28 */
static u_long  *vlcbuf0_d asm("vlcbuf0") __attribute__((section(".bss")));   /* 0x80052d58 (.bss=absolute, not .sbss) */
static u_long  *vlcbuf1_d asm("vlcbuf1") __attribute__((section(".bss")));   /* 0x80052d5c */
static u_short *imgbuf_d asm("imgbuf") __attribute__((section(".bss")));   /* 0x80052d60 */
static u_long  *sect_buff_d asm("sect_buff") __attribute__((section(".bss")));   /* 0x80052d64 */

/* MATCH: unsized-array VIEWS onto the same storage (asm-label aliases).  Reading the
 * scalar form folds the %hi into the dest arg reg (self-temp `lui a0; lw a0,0(a0)`);
 * the unsized-array form forces the oracle's SEPARATE scratch (`lui v0; lw a0,0(v0)`).
 * §3.12 #5 / §3.15-CORRECTION. */
extern u_long  *vlcbuf0_v[]  asm("vlcbuf0");
extern u_long  *vlcbuf1_v[]  asm("vlcbuf1");
extern u_short *imgbuf_v[]   asm("imgbuf");
extern u_long  *sect_buff_v[] asm("sect_buff");
#define vlcbuf0   vlcbuf0_v[0]
#define vlcbuf1   vlcbuf1_v[0]
#define sect_buff sect_buff_v[0]

/* lines 1-129: file header, #includes, static data, macros (no symbols emitted) */

/* ---- Movie_Init  (movie.cpp:130, code lines 130-169) ---- */
void Movie_Init(char movie)

{
  /* MATCH: the oracle materializes &movie24bit and branches on it (la + beqz) -- the
   * original source tested the table itself; gcc-2.8 does not fold "&array != 0". */
  if (movie24bit) {
    PPWTop = 3;
    PPWBottom = 2;
  }
  else {
    PPWTop = 1;
    PPWBottom = 1;
  }
  gMovieWidth = moviewidth[(u_char)movie];
  gMovieHeight = movieheight[(u_char)movie];
  Movie_SetDecodeOffset(0,0,0,0x100);
  gMovieFrame = 0;
  gEndFrame = 0;
  bMovieLoaded = 0;
  settrans(0);
  download[0] = 0;
  vlcbuf0 = (u_long *)reservememadr("vlcbuf0",0x28000,0x10);
  vlcbuf1 = (u_long *)reservememadr("vlcbuf1",0x28000,0x10);
  imgbuf_v[0] = (u_short *)reservememadr
                     ("imgbuf",((u_int)((int)PPWTop << 5) / (u_int)(int)PPWBottom) * 0x1e0,0x10);
  sect_buff = (u_long *)reservememadr("sect_buff",0x10000,0x10);
  Platform_ResetDCTBuffer();
  CD_Restart(0);
  CdControlB('\v',(u_char *)0x0,(u_char *)0x0);
  CdControlB('\t',(u_char *)0x0,(u_char *)0x0);
  CdControlB('\f',(u_char *)0x0,(u_char *)0x0);
  DecDCToutCallback((void *)0x0);
  CdDataCallback((void *)0x0);
  CdReadyCallback((void *)0x0);
  DecDCTvlcSize(0);
  return;
}

/* lines 170-174: (static data / macros / comments - no emitted code) */

/* ---- Movie_DeInit  (movie.cpp:175, code lines 175-200) ---- */
void Movie_DeInit(void)

{
  u_char param [8];
  
  bMovieLoaded = 0;
  param[0] = 0x80;
  CdControlB('\x0e',param,(u_char *)0x0);
  DecDCToutCallback((void *)0x0);
  StUnSetRing();
  CdDataCallback((void *)0x0);
  CdReadyCallback((void *)0x0);
  CdControlB('\v',(u_char *)0x0,(u_char *)0x0);
  CdControlB('\t',(u_char *)0x0,(u_char *)0x0);
  CdControlB('\f',(u_char *)0x0,(u_char *)0x0);
  purgememadr(vlcbuf0);
  purgememadr(vlcbuf1);
  purgememadr(imgbuf_v[0]);
  purgememadr(sect_buff);
  Platform_ResetDCTBuffer();
  CD_Restart(0);
  return;
}

/* lines 201-205: (static data / macros / comments - no emitted code) */

/* ---- Movie_SetDecodeOffset  (movie.cpp:206, code lines 206-212) ---- */
void Movie_SetDecodeOffset(short x0,short y0,short x1,short y1)

{
  /* MATCH: the oracle keeps &dec.rect[0] and &dec.rect[1] in registers (they are the
   * two ClearImage arguments) and writes every field through them, in the order
   * x0,y0,x1,y1,h,h,w,w -- statement order IS store order here. */
  RECT *r0; /* SYM-CODEGEN-CARRIER: r0 -- direct dec.rect field stores are measured
               FAIL 27; this base preserves the retail paired-store allocation */
  RECT *r1; /* SYM-CODEGEN-CARRIER: r1 -- direct dec.rect + 1 field stores are measured
               FAIL 27; this base preserves the retail paired-store allocation */

  r0 = dec.rect;
  r1 = dec.rect + 1;

  /* MATCH: PER-SITE storage view -- read gMovieHeight through the SCALAR static
   * (`_d`), not the unsized `_v[]` view.  The view's split %hi/%lo lowering is
   * schedulable and cc1 sinks the load past the `addiu s0,a0,8`; the scalar
   * macro form is unschedulable and issues where retail has it.  (Same symbol
   * uses the view form in strNext/Movie_Init -- both spellings are correct,
   * pick per site.) */
  r0->x = x0;
  r0->y = y0;
  r1->x = x1;
  r1->y = y1;
  r0->h = gMovieHeight_d;
  r1->h = gMovieHeight_d;
  r0->w = (short)(((int)gMovieWidth * (int)PPWTop) / (int)PPWBottom);
  r1->w = (short)(((int)gMovieWidth * (int)PPWTop) / (int)PPWBottom);
  ClearImage(r0,'\0','\0','\0');
  ClearImage(r1,'\0','\0','\0');
  DrawSync(0);
  return;
}

/* lines 213-217: (static data / macros / comments - no emitted code) */

/* ---- Movie_Load  (movie.cpp:218, code lines 218-282) ---- */
void Movie_Load(char movie)

{
  CdlFILE file;
  char gFEFileName [80];
  
  bMovieLoaded = 0;
  bRewindMovie = 0;
  bStopMovie = 0;
  download[0] = 0;
  isFirstSlice = 1;
  ResetCallback();
  sprintf(gFEFileName,"\\MOVIES\\%s;1",movienames[(u_char)movie]);
  gMovieFrame = 0;
  gEndFrame = (int)movieframes[(u_char)movie] - 1;
  gIsRGB24 = movie24bit[(u_char)movie];
  gMovieWidth = moviewidth[(u_char)movie];
  gMovieHeight = movieheight[(u_char)movie];
  /* MATCH: the oracle's beqz skips to the 1/1/2 block -- the 24-bit arm is the
   * fall-through, so it must be the `if` body. */
  if (gIsRGB24 != 0) {
    PPWTop = 3;
    PPWBottom = 2;
    gMode = 3;
  }
  else {
    PPWTop = 1;
    PPWBottom = 1;
    gMode = 2;
  }
  if (CdSearchFile(&file,gFEFileName) != (void *)0x0) {
    loc_v[0].minute = file.pos.minute;
    loc_v[0].second = file.pos.second;
    loc_v[0].sector = file.pos.sector;
    strSetDefDecEnv(&dec);
    strInit(loc_v,0xfffffff,strCallback,(CallbackFunc)0x0);
    strNextVlc(&dec);
    bMovieLoaded = 1;
  }
  return;
}

/* lines 283-286: (static data / macros / comments - no emitted code) */

/* ---- Movie_NextFrame  (movie.cpp:287, code lines 287-299) ---- */
int Movie_NextFrame(void)

{
  int ret; /* SYM-CODEGEN-CARRIER: ret -- direct/goto returns are measured FAIL 3
              (76/77), losing the retail shared-return jump */
  /* MATCH: SYM says fsize=32 with mask s0+ra and NO named locals -- the oracle's frame
   * carries 8 bytes of never-referenced slack that our expression shape does not
   * allocate; a dead 2-word local restores the exact frame + sp displacements. */
  int deadfrm[2]; /* SYM-CODEGEN-CARRIER: deadfrm -- removing this measured frame
                     carrier changes the SYM-proven 32-byte frame and stack offsets */
  /* MATCH: the oracle parks &dec in a callee-saved register (addiu s0,v0,%lo) and
   * reaches every field by displacement -- a real pointer local reproduces it. */
  (void)deadfrm;

  DecDCTin(dec.vlcbuf[dec.vlcid],(int)gMode);
  DecDCTinSync(1);
  /* MATCH: the `h-1; if(<0) h+14; >>4` sequence Ghidra shows is gcc's own signed /16
   * guard -- it is a plain `(h - 1) / 16`, not a hand-written clamp, and writing it
   * that way puts the slice.h load where the oracle has it (after the 2nd divide). */
  DecDCTout
            ((u_long *)dec.imgbuf,
             ((((dec.slice.w + -1) / (((int)PPWTop << 4) / (int)PPWBottom) + 1) *
               (((int)PPWTop << 4) / (int)PPWBottom)) << 4) *
             ((dec.slice.h + -1) / 0x10 + 1) >> 1);
  /* MATCH: the error arm is the OUT-OF-LINE branch target in the oracle (bltz skips
   * to it) and the success arm falls through -- write it in that polarity. */
  ret = strNextVlc(&dec);
  if (ret >= 0) {
    strSync(&dec,0);
    VSync(0);
    ret = 0;
  }
  else {
    ret = -1;
  }
  return ret;
}

/* lines 300-305: (static data / macros / comments - no emitted code) */

/* ---- Movie_DownloadFrame  (movie.cpp:306, code lines 306-307) ---- */
void Movie_DownloadFrame(void)

{
  download[0] = 1;
  return;
}

/* lines 308-312: (static data / macros / comments - no emitted code) */

/* ---- Movie_Stop  (movie.cpp:313, code lines 313-314) ---- */
void Movie_Stop(void)

{
  bStopMovie = 1;
  return;
}

/* lines 315-319: (static data / macros / comments - no emitted code) */

/* ---- Movie_Finished  (movie.cpp:320, code lines 320-321) ---- */
bool Movie_Finished(void)

{
  return (((gMovieFrame >= gEndFrame) || (bMovieLoaded == 0)) ||
          (bStopMovie != 0)) || (bRewindMovie != 0);
}

/* lines 322-326: (static data / macros / comments - no emitted code) */

/* ---- Movie_Play  (movie.cpp:327, code lines 327-406) ---- */
int Movie_Play(char movie)

{
  /* decl order = SYM Def-record order (disp, draw, joyval); the two non-SYM
     carriers follow it -- w86-S5, gate unchanged */
  DISPENV disp;
  DRAWENV draw;
  int joyval;
  bool dispRect; /* SYM-CODEGEN-CARRIER: dispRect -- direct repeated rectid tests are
                    measured FAIL 44 (136/132), rotating saved-register allocation */
  /* MATCH: SYM fsize=184 (disp@-0xA0, draw@-0x88, 3 saved regs) -- 16 bytes of
   * never-referenced frame slack our expression shape does not allocate. */
  int deadfrm[4]; /* SYM-CODEGEN-CARRIER: deadfrm -- removing this measured frame
                     carrier changes the SYM-proven 184-byte frame and stack offsets */

  (void)deadfrm;
  SNDcdvol(gMasterMusicLevel * 0x7f >> 7);
  Movie_Init(movie);
  Movie_Load(movie);
  /* MATCH: two SEPARATE branch tests -- the `&&`-comma form made gcc materialize
   * `frame_ret != -1` as a VALUE (nor/sltu) instead of branching on it. */
  while( true ) {
    /* MATCH: `(x ^ 1) == 0` is the ONLY spelling of "x == 1" that cc1plus keeps
     * as the oracle's `xori v0,v0,1; beqz v0`.  Plain `x == 1` (and `!(x ^ 1)`,
     * and the inverted `if (x != 1) ... else break`) all hoist a `li reg,1` out
     * of the loop and branch register-to-register -- which ALSO gave that
     * constant a 3rd reference and stole the first saved register. */
    if ((Movie_Finished() ^ 1) == 0) break;
    if (Movie_NextFrame() == -1) break;
    dispRect = dec.rectid == 0;
    SetDefDispEnv
              (&disp,(int)dec.rect[dispRect].x,(int)dec.rect[dispRect].y,(int)dec.rect[dispRect].w,
               (int)dec.rect[dispRect].h);
    disp.screen.h = 0xf0;
    SetDefDrawEnv
              (&draw,(int)dec.rect[dispRect].x,(int)dec.rect[dispRect].y,(int)dec.rect[dispRect].w,
               (int)dec.rect[dispRect].h);
    if (gIsRGB24 != 0) {
      disp.isrgb24 = '\x01';
      /* MATCH: the 0x55555556 mult-high + sign fixup IS gcc's own signed divide by 3. */
      disp.disp.w = (short)(((int)disp.disp.w << 1) / 3);
    }
    PutDispEnv(&disp);
    PutDrawEnv(&draw);
    SetDispMask(1);
    if (gIsRGB24 == 0) {
      FntFlush(-1);
    }
    Movie_DownloadFrame();
    download[0] = 1;
    PAD_update();
    /* MATCH: ONE andi on the combined value (the oracle keeps each PAD_state result
     * unmasked in a register); per-local u_short narrowing emitted two. */
    joyval = ((u_int)PAD_state(0) | (u_int)PAD_state(4)) & 0xffff;
    /* MATCH: the guard must be a plain nested `if`, NOT the comma form
     * `joyval && (Movie_Stop(), A || B)` -- inside a comma expression gcc
     * MATERIALIZES the disjunction in a register (addu v1,zero,zero / li v1,1
     * / beqz v1) instead of short-circuit branching.  And the two arms must
     * share ONE `user_exit = 1;` store: an `if/else if` pair with a store in
     * each cross-jump-merges to the same code, but flow.c still counts both
     * refs of the HImode constant 1 (7 vs 5 loop-weighted), which lifts that
     * allocno above the `&dec` base and swaps s2/s3 through the whole fn. */
    if (joyval != 0) {
      Movie_Stop();
      if ((skip_all != '\0') || (joyval == 8)) {
        user_exit = 1;
      }
    }
  }
  Movie_DeInit();
  ClearImage(dec.rect,'\0','\0','\0');
  ClearImage(dec.rect + 1,'\0','\0','\0');
  DrawSync(0);
  return (int)user_exit;
}

/* lines 407-409: (static data / macros / comments - no emitted code) */

/* ---- play_movie  (movie.cpp:410, code lines 410-412) ---- */
int play_movie(char movie)

{
  return Movie_Play(movie);
}

/* lines 413-419: (static data / macros / comments - no emitted code) */

/* ---- strSetDefDecEnv  (movie.cpp:420, code lines 420-428) ---- */
static void strSetDefDecEnv(DECENV *dec)

{
  short mh; /* SYM-CODEGEN-CARRIER: mh -- direct late gMovieHeight access is measured
               FAIL 7 (36/35); this early read restores retail scheduling */
  u_long *vb0; /* SYM-CODEGEN-CARRIER: vb0 -- the measured 16-view/24-read-order
                  search requires this early vlcbuf0 read for the retail schedule */
  u_long *vb1; /* SYM-CODEGEN-CARRIER: vb1 -- the measured 16-view/24-read-order
                  search requires this early vlcbuf1 read for the retail schedule */
  u_short *img; /* SYM-CODEGEN-CARRIER: img -- the measured view/order search requires
                   this early imgbuf read for the retail batched-lui schedule */
  int bottom; /* SYM-CODEGEN-CARRIER: bottom -- direct PPWBottom access is measured
                 FAIL 48 (35/35), changing the entire scheduled instruction order */
  int top; /* SYM-CODEGEN-CARRIER: top -- direct PPWTop access is measured FAIL 47
              (36/35), changing division placement and register allocation */
  
  /* MATCH (w44): the READ order and the STORE order must BOTH be
   * vlcbuf0, vlcbuf1, imgbuf, gMovieHeight -- i.e. the four fields written in
   * declaration order of DECENV (vlcbuf[0], vlcbuf[1], imgbuf, slice.h), which is
   * simply what a 1998 programmer writes.  Every read goes through the UNSIZED-ARRAY
   * VIEW (`_v[]`), uniformly: that is cc1's schedulable %hi/%lo split, so sched can
   * batch the three `lui`s ahead of their loads exactly as retail does, while the
   * scalar (`_d`) spelling emits the UNSCHEDULABLE `lw $r,sym` assembler macro whose
   * halves can never separate.  With the coupled orders sched1 lands the oracle's
   * shape byte-for-byte (3 batched luis, 3 loads, then vlcbuf0's own lui/lw pair).
   * The earlier 4-diff residual came from de-coupling the two orders: the previous
   * form pinned the READS with scalars but then no lui could hoist.  Exhaustively
   * measured: 16 scalar/view masks x 24 read orders on the real TU (best 4), and
   * 24 read orders x 24 store orders all-views in a standalone cc1 harness -- this
   * is the unique zero. */
  vb0 = vlcbuf0;
  vb1 = vlcbuf1;
  img = imgbuf_v[0];
  mh = gMovieHeight;
  top = (int)PPWTop;
  bottom = (int)PPWBottom;
  dec->vlcid = 0;
  dec->rectid = 0;
  dec->isdone = 0;
  (dec->slice).x = 0;
  (dec->slice).y = 0;
  dec->vlcbuf[0] = vb0;
  dec->vlcbuf[1] = vb1;
  dec->imgbuf = img;
  (dec->slice).h = mh;
  (dec->slice).w = (short)((top << 4) / bottom);
  return;
}

/* lines 429-432: (static data / macros / comments - no emitted code) */

/* ---- strInit__FP6CdlLOCiPFe_vT2  (movie.cpp:433, code lines 433-445) ---- */
static void strInit(CdlLOC *loc,int frame_size,CallbackFunc callback,CallbackFunc endcallback)

{
  
  DecDCTReset(0);
  bRewindMovie = 0;
  DecDCToutCallback((void *)callback);
  StSetRing(sect_buff,0x20);
  StClearRing();
  StSetStream(gIsRGB24,1,frame_size,(void *)0x0,(void *)endcallback);
  strKickCD(loc);
  return;
}

/* lines 446-449: (static data / macros / comments - no emitted code) */

/* ---- strCallback  (movie.cpp:450, code lines 450-488) ---- */
static void strCallback(void)

{
  int rem; /* SYM-CODEGEN-CARRIER: rem -- repeating the remainder expression is
              measured FAIL 86 (207/191), duplicating division and rotating registers */
  /* MATCH: SYM fsize=32 with mask s0+ra -- 8 bytes of never-referenced frame slack. */
  int deadfrm[2]; /* SYM-CODEGEN-CARRIER: deadfrm -- removing this measured frame
                     carrier changes the SYM-proven 32-byte frame and stack offsets */

  (void)deadfrm;
  if ((gIsRGB24 != 0) && (StCdIntrFlag != 0)) {
    StCdInterrupt();
    StCdIntrFlag = 0;
  }
  if (download[0] != 0) {
    LoadImage(&dec.slice,(u_long *)dec.imgbuf);
  }
  /* MATCH: the slice.x advance is written INSIDE each arm (the oracle joins only after
   * the store); a shared `xstep` temp merged the two adds into one block. */
  if (isFirstSlice != 0) {
    /* MATCH: keep the quotient expression direct here.  Giving it a named local
     * creates a separate pseudo and rotates the whole caller-saved pool. */
    rem = (int)dec.rect[dec.rectid].w % (((int)PPWTop << 4) / (int)PPWBottom);
    if (rem != 0) {
      isFirstSlice = 0;
      /* MATCH: the rem*PPWTop multiply belongs INSIDE the guard (the oracle schedules
       * it into the beqz delay slot); as a preceding statement it lands before the test. */
      dec.slice.x = dec.slice.x + (short)((rem * PPWTop) / (int)PPWBottom);
      goto strCallback_inlinedJoin;
    }
  }
  dec.slice.x = dec.slice.x + (short)(((int)PPWTop << 4) / (int)PPWBottom);
strCallback_inlinedJoin:
  if ((int)dec.slice.x < (int)dec.rect[dec.rectid].x + (int)dec.rect[dec.rectid].w) {
    DecDCTout
              ((u_long *)dec.imgbuf,
               ((((dec.slice.w + -1) / (((int)PPWTop << 4) / (int)PPWBottom) + 1) *
                 (((int)PPWTop << 4) / (int)PPWBottom)) << 4) *
               ((dec.slice.h + -1) / 0x10 + 1) >> 1);
  }
  else {
    /* MATCH: the `dec.isdone = 1` store must come BEFORE the rectid store in the
     * SOURCE.  Then cc1 materializes the constant 1 into a register first and cse
     * feeds that register to the rectid test -- retail's `li a1,1; sltu a0,a3,a1`
     * (register form) -- which in turn keeps rectid live past the `li` and pins it
     * to $a3.  With the rectid store first, gcc emits the immediate `sltiu a0,a1,1`
     * and rectid dies into $a1, rotating the tail.  (gcc reschedules the two stores
     * back into retail's emitted order.) */
    dec.isdone = 1;
    dec.rectid = (u_int)(dec.rectid == 0);
    dec.slice.x = dec.rect[dec.rectid].x;
    isFirstSlice = 1;
    dec.slice.y = dec.rect[dec.rectid].y + (short)((0xf0 - gHeight) / 2);
  }
  return;
}

/* lines 489-492: (static data / macros / comments - no emitted code) */

/* ---- strNextVlc  (movie.cpp:493, code lines 493-518) ---- */
static int strNextVlc(DECENV *dec)

{
  /* decl order = SYM Def-record order (cnt $s0, next $s1) -- w86-S5 */
  int cnt;
  u_long *next;

  cnt = 10;
  do {
    next = strNext(dec);
    cnt = cnt + -1;
    if (next != (u_long *)0x0) goto found;
  } while (cnt != 0);
  return -1;
found:
  dec->vlcid = (u_int)(dec->vlcid == 0);
  if (DecDCTvlc(next,dec->vlcbuf[dec->vlcid]) != 0) {
    while (DecDCTvlc((u_long *)0x0,(u_long *)0x0) != 0) {
    }
  }
  StFreeRing(next);
  return 0;
}

/* lines 519-536: (static data / macros / comments - no emitted code) */

/* ---- strNext  (movie.cpp:537, code lines 537-600) ---- */
static u_long * strNext(DECENV *dec)

{
  /* decl order = SYM Def-record order: fn scope is addr(AUTO -0x18),
     sector(AUTO -0x14), cnt(REG $s0); `rect` is a NESTED-block local (SYM
     `90 Block start line = 50`) and is declared in that block below.  The five
     non-SYM carriers follow the SYM set -- w86-S5, gate unchanged. */
  u_long *addr;
  CDSECTOR *sector;
  int cnt;
  u_long st; /* SYM-CODEGEN-CARRIER: st -- direct StGetNext testing is measured
                FAIL 5 (131/130), moving the loop decrement across the call setup */
  short mh; /* SYM-CODEGEN-CARRIER: mh -- repeating the gHeight reads is measured
               FAIL 22 (134/130), duplicating loads and changing division allocation */
  int bottom; /* SYM-CODEGEN-CARRIER: bottom -- repeating PPWBottom is measured
                 FAIL 46 (144/130), duplicating loads/divides and rotating operands */
  int wt; /* SYM-CODEGEN-CARRIER: wt -- repeating gWidth*PPWTop is measured FAIL 42
             (150/130), duplicating the multiply/divide chain */
  int *wp; /* SYM-CODEGEN-CARRIER: wp -- direct gWidth and scalar-view spellings are
              each measured one instruction long; this pointer preserves alias/schedule */

  cnt = 50000;
  while( true ) {
    st = StGetNext((u_long *)&addr,(u_long *)&sector);
    cnt = cnt + -1;
    if (st == 0) break;
    if (cnt == 0) {
      return (u_long *)0x0;
    }
  }
  /* MATCH: the oracle's header check falls through into the StFreeRing/return-0 tail and
   * BRANCHES to the accept path (bne .. free ; beq .. body). */
  if (*addr != sector->headm) goto freeit;
  if (addr[1] == sector->headv) goto accept;
freeit:
  StFreeRing(addr);
  return (u_long *)0x0;
accept:
  /* MATCH: on the rewind path the oracle does NOT store gMovieFrame (it jumps over the
   * store), and the rewind block is laid out BEFORE the store block.
   * MATCH: no `fc` temp (the SYM lists none) -- the global has to be the FIRST
   * operand evaluated so the two loads fill each other's load-delay slot. */
  if (gMovieFrame > sector->frameCount) goto rewind;
  if (sector->frameCount < gEndFrame) goto setframe;
rewind:
  bRewindMovie = 1;
  goto framedone;
setframe:
  gMovieFrame = sector->frameCount;
framedone:
  /* MATCH: reach gWidth through a POINTER LOCAL, in BOTH the test and the store.
   * (a) it anchors %hi(width) in the callee-saved reg the oracle keeps across the
   *     ClearImage call (`lui s0,%hi(width)` at the head of this block, `%lo` in
   *     both displacements);
   * (b) `*wp` is a plain indirect MEM, not an ARRAY_REF, so gcc-2.8's
   *     true_dependence no longer makes it may-alias `sector->height` -- the height
   *     `lhu` then schedules into the width `lhu`'s load-delay slot and reuses the
   *     dying sector register, exactly as retail (the direct `gWidth = ...` form
   *     leaves a `nop` there and is 1 insn long).
   * The scalar `width_d` spelling also unblocks the alias but loses the shared %hi
   * (assembler macro -> its own `lui $at`), so it stays 1 insn long too. */
  wp = width_v;
  if ((*wp != (u_int)sector->width) || (gHeight != (u_int)sector->height)) {
    RECT rect;   /* SYM `90 Block start line = 50` scopes rect to THIS block */

    rect.x = 0;
    rect.y = 0;
    rect.h = 0x1e0;
    rect.w = (short)((PPWTop * 0x280) / (int)PPWBottom);
    ClearImage(&rect,'\0','\0','\0');
    *wp = (int)sector->width;
    gHeight = (int)sector->height;
  }
  wt = gWidth * PPWTop;
  bottom = (int)PPWBottom;
  mh = (short)gHeight;
  dec->rect[1].h = (short)gHeight;
  dec->rect[0].h = mh;
  (dec->slice).h = mh;
  dec->rect[1].w = (short)(wt / bottom);
  dec->rect[0].w = (short)(wt / bottom);
  return addr;
}

/* lines 601-603: (static data / macros / comments - no emitted code) */

/* ---- strSync  (movie.cpp:604, code lines 604-621) ---- */
static void strSync(DECENV *dec,int mode)

{
  /* SYM-CODEGEN-CARRIER: mode -- the mangled `...i` proves the optimized-away
   * second int parameter; canonical PsyQ STR sample sources name it `mode`. */
  /* decl order = SYM Def-record order: the SYM's ONLY local here is
     `cnt` (AUTO -8, ULONG); the non-SYM carrier follows it -- w86-S5.
     MATCH: the spin counter lives in a STACK SLOT and is re-loaded/stored on every
     iteration (sw/lw 0(sp)) -- a plain register local can never reproduce that. */
  volatile u_long cnt;
  int viewOff; /* SYM-CODEGEN-CARRIER: viewOff -- direct loop use is measured
                  FAIL 50 (44/44), losing retail loop-invariant hoisting/allocation */

  cnt = 0x800000;
  if (dec->isdone == 0) {
    /* MATCH: the /2 is loop-invariant in the oracle. */
    viewOff = (0xf0 - gHeight) / 2;
    do {
      cnt = cnt - 1;
      if (cnt == 0) {
        dec->isdone = 1;
        dec->rectid = (u_int)(dec->rectid == 0);
        (dec->slice).x = dec->rect[dec->rectid].x;
        /* MATCH: the second access RE-READS dec->rectid from memory (the oracle emits a
         * 2nd lw 0x20 + sll) -- a cached local gets store-forwarded away. */
        (dec->slice).y = dec->rect[dec->rectid].y + (short)viewOff;
      }
    } while (dec->isdone == 0);
  }
  dec->isdone = 0;
  return;
}

/* lines 622-626: (static data / macros / comments - no emitted code) */

/* ---- strKickCD  (movie.cpp:627, code lines 627-629) ---- */
static void strKickCD(CdlLOC *loc)

{
  while (CdControl('\x15',&loc->minute,(u_char *)0x0) == 0) {
  }
  while (CdRead2(0x1c0) == 0) {
  }
  return;
}

/* end of movie.cpp */
