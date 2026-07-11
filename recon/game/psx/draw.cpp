/* game/psx/draw.cpp -- RECONSTRUCTED (NFS4 PSX base render-management; C++ TU)
 *   25 fns: view/OT setup (Draw_SetView/InitViews/InitViewOT[InGame]/DeInitViews), primitive-buffer
 *   alloc/clear, frame render start/stop (Start/StopRenderingView, Start/StopFrameRender), draw
 *   environment, render-engine init. GTE-free (0 cop2 stubs). Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "draw_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
int Draw_gDoVSync;
int Draw_gMaxPrim;
int Draw_gMidGroundOtz;
int Draw_gNumView;
int Draw_gViewOtSize;
int gFlip;
int gLoop;
int gTotalMem;

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
int Draw_SetView(int x0,int y0,int x1,int y1,int w,int h,int dtd,int isbg,int otsize);
void Draw_InitViews(void);
void Draw_InitViewOT(void);
void Draw_InitViewOTInGame(void);
void Draw_DeInitViews(void);
void Draw_DeInitViewsInGame(void);
DRAWENV * Draw_GetDRAWENV(int viewid,int page);
void Draw_SetViewMemBudget(int viewid,int totalmem);
void Draw_SetViewColor(int viewid,int r,int g,int b);
void AllocatePrimitivesBuffer(void);
void ClearPrimitivesBuffer(void);
void ClearPlatformPrimitivesBuffer(void);
void Draw_StartRenderingView(int viewid);
void Draw_StopRenderingView(int viewid);
void Draw_CheckFirstFrameRender(void);
void Draw_StartFrameRender(void);
void Draw_SetDrawSyncCallback(fn_void *p);
void Draw_StopFrameRender(void);
void Draw_DrawDirectScreen(shapetbl *tile,int x,int y);
void Draw_DirectSetEnvironment(int x,int y,int w,int h,int edraw,int edisplay,int erase,int r,int g,int b);
void Draw_SetEnvironment(int w,int h,int edraw,int edisplay,int erase,int r,int g,int b);
void Draw_InitRenderEngine(int x0,int y0,int x1,int y1,int w,int h);
void Draw_RestartRenderEngine(void);
void Draw_DeInitRenderEngine(void);
void Draw_InitLibRender(void);


/* ---- Draw_SetView__Fiiiiiiiii  [DRAW.CPP:72-101] SLD-VERIFIED ---- */
int Draw_SetView(int x0,int y0,int x1,int y1,int w,int h,int dtd,int isbg,int otsize)

{
  /* SYM (nfs4-f-v3.txt @0x800BDAC0) names `newview` (Draw_tView*) + `e00`/`e10`
     (DRAWENV*, both 92 bytes) as real locals -- NOT raw Draw_gView[iVar1].drawenv[N]
     array-index expressions everywhere. Rewritten to cache the two DRAWENV pointers
     once per the SYM, matching the oracle's s1/s2-hold-e00/e10-address shape. */
  int iVar1;
  int iVar2;
  Draw_tView *newview;
  DRAWENV *e00;
  DRAWENV *e10;

  iVar1 = Draw_gNumView;
  newview = Draw_gView + Draw_gNumView;
  e00 = newview->drawenv;
  e10 = newview->drawenv + 1;
  SetDefDrawEnv(e00,x0,y0,w,h);
  SetDefDrawEnv(e10,x1,y1,w,h);
  e00->r0 = '\0';
  e00->g0 = '\0';
  e00->b0 = '\0';
  e10->r0 = '\0';
  e10->g0 = '\0';
  e10->b0 = '\0';
  e10->isbg = (u_char)isbg;
  e00->isbg = (u_char)isbg;
  e10->dtd = (u_char)dtd;
  e00->dtd = (u_char)dtd;
  iVar2 = Draw_gNumView;
  newview->otsize = otsize;
  newview->membudget = 0;
  Draw_gNumView = Draw_gNumView + 1;
  return iVar2;
}

/* ---- Draw_InitViews__Fv  [DRAW.CPP:113-114] SLD-VERIFIED ---- */
void Draw_InitViews(void)

{
  Draw_gNumView = 0;
  return;
}

/* ---- Draw_InitViewOT__Fv  [DRAW.CPP:127-134] SLD-VERIFIED ---- */
void Draw_InitViewOT(void)

{
  /* FIXED: oracle is top-tested-while-no-guard -- falls straight from the prologue
     into the test label (NO entry jump), `beqz` skips to the shared epilogue, body
     ends with an UNCONDITIONAL `j` back to the test label (increment is folded into
     the body, not the branch's delay slot). A `goto TEST;do{}while(cond)` (entry-jump
     to a bottom test, conditional `bnez` back-edge) is the OPPOSITE topology and was
     the true residual cause (not a "loop-rotation floor"). Correct C shape = the
     if-guarded backward-goto idiom (catalog §B row 56 / same family as the sibling
     Draw_DeInitViews, which already sealed 100% with this exact form): a `TEST:` label
     directly after init, `if(cond){body; goto TEST;}`, `return;` after. */
  u_long *puVar1;
  Draw_tView *pDVar2;
  int i;
  int iVar3;

  iVar3 = 0;
  pDVar2 = Draw_gView;
 TEST:
  if (iVar3 < Draw_gNumView) {
    puVar1 = reservememadr("ot0",pDVar2->otsize << 2,0x10);
    pDVar2->ot[0] = puVar1;
    puVar1 = reservememadr("ot1",pDVar2->otsize << 2,0x10);
    pDVar2->ot[1] = puVar1;
    pDVar2 = pDVar2 + 1;
    iVar3 = iVar3 + 1;
    goto TEST;
  }
  return;
}

/* ---- Draw_InitViewOTInGame__Fv  [DRAW.CPP:138-145] SLD-VERIFIED ---- */
void Draw_InitViewOTInGame(void)

{
  /* FIXED -- same fix/rationale as the sibling Draw_InitViewOT (see its comment): the
     oracle is top-tested-while-no-guard (fallthrough into the test, unconditional `j`
     back-edge, no entry jump); the if-guarded backward-goto idiom reproduces it
     exactly, plus the s1(count)-before-s0(pointer) init order to match the prologue
     save order. */
  u_long *puVar1;
  Draw_tView *pDVar2;
  int i;
  int iVar3;

  iVar3 = 0;
  pDVar2 = Draw_gView;
 TEST:
  if (iVar3 < Draw_gNumView) {
    puVar1 = (u_long *)Platform_ReserveMemory(pDVar2->otsize << 2,"ot0");
    pDVar2->ot[0] = puVar1;
    puVar1 = (u_long *)Platform_ReserveMemory(pDVar2->otsize << 2,"ot1");
    pDVar2->ot[1] = puVar1;
    pDVar2 = pDVar2 + 1;
    iVar3 = iVar3 + 1;
    goto TEST;
  }
  return;
}

/* ---- Draw_DeInitViews__Fv  [DRAW.CPP:157-168] SLD-VERIFIED ---- */
void Draw_DeInitViews(void)

{
  Draw_tView *pDVar1;
  int i;
  int iVar2;

  /* MATCH: SYM (nfs4-f-v3.txt @0x800BDCE0) names exactly ONE local (`i`); the oracle is a
     genuine top-tested while (test-block-first-with-fallthrough, unconditional `j` back-
     edge, NO zero-trip `blez` guard) -- same family as the sibling Draw_DeInitViewsInGame.
     LEVER: `label: if(cond){body; goto label;}` (an if-guarded explicit backward goto,
     NOT a `goto TEST;do{}while()` do-while) is the C shape gcc-2.8.0 lowers to this exact
     topology -- confirmed against the PASSing sibling AIPerson_SetPersonalityPointers,
     the only other function in the whole oracle corpus with this fallthrough-test/
     unconditional-back-j shape. Sealed 100% (was a documented "floor"). */
  iVar2 = 0;
  pDVar1 = Draw_gView;
 loopTop:
  if (iVar2 < Draw_gNumView) {
    if (pDVar1->ot[0] != (u_long *)0x0) {
      purgememadr(pDVar1->ot[0]);
    }
    if (pDVar1->ot[1] != (u_long *)0x0) {
      purgememadr(pDVar1->ot[1]);
    }
    pDVar1->ot[0] = (u_long *)0x0;
    pDVar1->ot[1] = (u_long *)0x0;
    pDVar1 = pDVar1 + 1;
    iVar2 = iVar2 + 1;
    goto loopTop;
  }
  return;
}

/* ---- Draw_DeInitViewsInGame__Fv  [DRAW.CPP:172-183] SLD-VERIFIED ---- */
void Draw_DeInitViewsInGame(void)

{
  int i;
  int iVar2;
  Draw_tView *pDVar3;

  /* MATCH: SYM (nfs4-f-v3.txt @0x800BDD68) names exactly ONE local (`i`) -- the pointer
     walk + cached-count temps below are compiler-internal, not separately named, so their
     C form is chosen purely to reproduce the oracle's addressing/stride (base-pointer `v1`
     walked +0xC8/struct with `sw` at +0xC0/+0xC4, NOT a field-biased pointer).
     NEAR-MISS FLOOR (10 diffs, down from 17): the goto-TEST do-while below reproduces the
     oracle's exact insn COUNT (13) and the exact addressing/stride/register-coloring; the
     residual 10-diff is a genuine LOOP-ROTATION direction swap -- oracle is test-block-
     first-with-plain-fallthrough + unconditional back-jump (`slt;beqz-fwd` then body then
     `j`-back), ours is body-first-with-goto-skip + conditional back-branch (`j`-fwd-skip
     then body then `slt;bnez`-back). Tried 12 source shapes this session (plain `while`,
     `for`, `for(;;)+break`, do-while-with-precheck, array-indexed `Draw_gView[i]` instead
     of the pointer, ot[0]/ot[1] store-order swap, pointer-vs-counter increment order) --
     every natural `while`/`for` gcc-2.8 idiom inserts a `blez`-zero-trip guard the oracle
     doesn't have; every `goto`-based do-while gets the body/test blocks in the OPPOSITE
     position from the oracle. Not reachable by a source lever at this opt level; permuter
     (no cast) or accept. */
  i = 0;
  iVar2 = Draw_gNumView;
  pDVar3 = Draw_gView;
 loopTop:
  if (i < iVar2) {
    pDVar3->ot[0] = (u_long *)0x0;
    pDVar3->ot[1] = (u_long *)0x0;
    pDVar3 = pDVar3 + 1;
    i = i + 1;
    goto loopTop;
  }
  return;
}

/* ---- Draw_GetDRAWENV__Fii  [DRAW.CPP:187-188] SLD-VERIFIED ---- */
DRAWENV * Draw_GetDRAWENV(int viewid,int page)

{
  return &Draw_gView[viewid].drawenv[page];
}

/* ---- Draw_SetViewMemBudget__Fii  [DRAW.CPP:197-198] SLD-VERIFIED ---- */
void Draw_SetViewMemBudget(int viewid,int totalmem)

{
  Draw_gView[viewid].membudget = totalmem;
  return;
}

/* ---- Draw_SetViewColor__Fiiii  [DRAW.CPP:213-219] SLD-VERIFIED ---- */
void Draw_SetViewColor(int viewid,int r,int g,int b)

{
  Draw_tView *view;

  view = &Draw_gView[viewid];
  if (view->drawenv[0].isbg != '\0') {
    view->drawenv[0].r0 = (u_char)r;
    view->drawenv[0].g0 = (u_char)g;
    view->drawenv[0].b0 = (u_char)b;
  }
  if (view->drawenv[1].isbg != '\0') {
    view->drawenv[1].r0 = (u_char)r;
    view->drawenv[1].g0 = (u_char)g;
    view->drawenv[1].b0 = (u_char)b;
  }
  return;
}

/* ---- AllocatePrimitivesBuffer__Fv  [DRAW.CPP:237-292] SLD-VERIFIED ---- */
void AllocatePrimitivesBuffer(void)

{
  /* SYM (nfs4-f-v3.txt @0x800BDE60) names exactly 3 locals, all `Draw_tView *`, in TWO
     DISJOINT block scopes: view0+view1 in the if(commMode==1) block (lines 33-37), view
     ALONE in the else block (lines 49-56) -- there is NO function-scope `membudget`
     local anywhere (the outer line=1 block has zero named locals). The oracle's shared
     tail `sw a0,4(vN)` reached from BOTH the if-block (via an explicit `j`) and the
     else-block (via fallthrough) is gcc's CROSS-JUMP TAIL-MERGE of two INDEPENDENT,
     textually-identical store statements (§D "gcc tail-merged duplicate ... KEEP the
     duplicated-C" family) -- not a shared variable. Each branch computes+stores its OWN
     membudget expression directly on each Draw_tView*; the if-block's two IDENTICAL
     `(gTotalMem>>1)+-0x1a00` computations fold to one physical value via ordinary local
     CSE (both stores are in the same straight-line block), matching the oracle's single
     `sra/addiu` reused for the view0 AND view1 stores, while the tail-merge pass unifies
     the if-block's 2nd store with the else-block's only store into the shared `sw`. This
     also reproduces the oracle's exact scheduling: `&Draw_gView[Draw_gPlayer1View]`'s
     multiply is computed BEFORE the `gTotalMem>>1` shift (no local ever occupies `$v0`
     between the `commMode==1` compare and the multiply), so gcc reuses the still-live
     compare constant register as the shift-amount operand (a variable-form `sllv`) --
     an allocator artifact of NOT introducing an intervening `membudget` computation. */
  Draw_tView *view0;
  Draw_tView *view1;
  Draw_tView *view;

  if (GameSetup_gData.commMode == 1) {
    Draw_InitViewOT();
  }
  else {
    Draw_InitViewOTInGame();
  }
  if (GameSetup_gData.commMode == 1) {
    gTotalMem = 0x22500;
  }
  else {
    gTotalMem = 0x1f600;
  }
  gEnviro[0].server = Platform_ReserveMemory(gTotalMem,"ps0");
  gEnviro[1].server = Platform_ReserveMemory(gTotalMem,"ps1");
  if (GameSetup_gData.commMode == 1) {
    view0 = &Draw_gView[Draw_gPlayer1View];
    view0->membudget = (gTotalMem >> 1) + -0x1a00;
    view1 = &Draw_gView[Draw_gPlayer2View];
    view1->membudget = (gTotalMem >> 1) + -0x1a00;
  }
  else {
    view = &Draw_gView[Draw_gPlayer1View];
    view->membudget = gTotalMem + -0x1a00;
  }
  return;
}

/* ---- ClearPrimitivesBuffer__Fv  [DRAW.CPP:312-320] SLD-VERIFIED ---- */
void ClearPrimitivesBuffer(void)

{
  DrawSync(0);
  if (gEnviro[0].server != (char *)0x0) {
    purgememadr(gEnviro[0].server);
  }
  if (gEnviro[1].server != (char *)0x0) {
    purgememadr(gEnviro[1].server);
  }
  gEnviro[1].server = (char *)0x0;
  gEnviro[0].server = (char *)0x0;
  Draw_DeInitViews();
  return;
}

/* ---- ClearPlatformPrimitivesBuffer__Fv  [DRAW.CPP:325-339] SLD-VERIFIED ---- */
void ClearPlatformPrimitivesBuffer(void)

{
  DrawSync(0);
  gEnviro[1].server = (char *)0x0;
  gEnviro[0].server = (char *)0x0;
  if (GameSetup_gData.commMode == 1) {
    Draw_DeInitViews();
  }
  else {
    Draw_DeInitViewsInGame();
  }
  return;
}

/* ---- Draw_StartRenderingView__Fi  [DRAW.CPP:352-374] SLD-VERIFIED ---- */
void Draw_StartRenderingView(int viewid)

{
  /* FIXED: the oracle materializes ONE literal scratchpad base register (0x1F800000)
     and addresses every field below it by DISPLACEMENT -- NOT via the normal
     Render_gPacketLenLo/Hi, Render_gPacketEnd, Render_gMenuRenderFlag externs (which
     compile to %hi/%lo(sym) 2-insn loads, the whole prior residual). The SYM already
     names the real local `sd` (Draw_DCache*, reg $a3) for exactly this purpose -- it
     was declared but unwired. Draw_DCache's head (Draw_tCacheHeader) field layout
     supplies the real names for each scratch offset: cprim.LastPrim@+0=Render_gPalettePtr,
     cprim.PrimPtr@+4=Render_gPacketPtr, cprim.MPrimPtr@+8=Render_gPacketEnd,
     mirror@+0xC=Render_gMenuRenderFlag, clipW/clipH@+0x10/+0x12=Render_gPacketLenLo/Hi.
     Header wish: promote Render_gPacketEnd/Render_gMenuRenderFlag/Render_gPacketLenLo/Hi
     to `sd->head...`-style scratchpad accessors tree-wide (not done here -- function
     bodies only per this pass's scope). */
  Draw_DCache *sd;
  Draw_tView *view;
  int iVar1;

  sd = (Draw_DCache *)0x1F800000;
  view = Draw_gView + viewid;
  iVar1 = view->otsize * 7;
  Draw_gViewOtSize = view->otsize;
  if (iVar1 < 0) {
    iVar1 = iVar1 + 7;
  }
  sd->head.clipW = Draw_gView[viewid].drawenv[0].clip.w;
  sd->head.clipH = Draw_gView[viewid].drawenv[0].clip.h;
  Draw_gMidGroundOtz = iVar1 >> 3;
  sd->head.cprim.LastPrim = (u_long *)view->ot[gFlip];
  if ((viewid == Draw_gPlayer1View) || (viewid == Draw_gPlayer2View)) {
    sd->head.cprim.MPrimPtr = sd->head.cprim.PrimPtr + Draw_gView[viewid].membudget;
  }
  else {
    sd->head.cprim.MPrimPtr = (char *)Draw_gMaxPrim;
  }
  sd->head.mirror = 0;
  return;
}

/* ---- Draw_StopRenderingView__Fi  [DRAW.CPP:387-398] SLD-VERIFIED ---- */
void Draw_StopRenderingView(int viewid)

{
  /* FIXED: SYM (nfs4-f-v3.txt @0x800BE118) names exactly THREE locals -- LEnv (DRAWENV,
     AUTO stack, sp+0x10, matches `addiu a3,sp,0x10`), pEnv (DR_ENV*, reg $a0), view
     (Draw_tView*, reg $a1) -- NOT the ~15 raw byte-offset iterator temps the previous
     manual copy-loop reconstruction invented. The oracle's "copy loop + 3-word tail"
     (0x50 bytes in 5x16-byte chunks, then 0xC bytes = 12 more, totaling exactly 0x5C =
     sizeof(DRAWENV)) is gcc's OWN `movstrsi` expansion of a PLAIN STRUCT ASSIGNMENT
     (catalog §D "oracle expands a struct-sized region copy as an INLINE unrolled
     sequence... write a plain C struct assignment" -- confirmed here: raw-traced the
     exact byte range copied is [0,0x5C) of view->drawenv[gFlip], i.e. the WHOLE
     struct, not a shifted/partial range as first appeared). `LEnv = view->drawenv[gFlip];`
     lets gcc regenerate the identical unrolled sequence. Render_gPacketPtr/
     Render_gPalettePtr are read LAZILY (right where first used, after the struct copy)
     and held in registers for BOTH later re-uses -- the previous reconstruction's
     eager `cur_pkt`/`prev_pkt` cache at function TOP (before the copy) forced the
     scratchpad loads to the wrong position; removed, using the macros directly at
     their oracle-verified use points instead (view->otsize read twice independently,
     matching the oracle's two separate `lw` of the same field through separate register
     copies of `view`, not a single cached local). */
  Draw_tView *view;
  DR_ENV *pEnv;
  DRAWENV LEnv;

  view = Draw_gView + viewid;
  LEnv = view->drawenv[gFlip];
  pEnv = (DR_ENV *)Render_gPacketPtr;
  *(u_int *)Render_gPacketPtr =
       *(u_int *)Render_gPacketPtr & 0xff000000 |
       *(u_int *)(Render_gPalettePtr + view->otsize * 4 + -4) & 0xffffff;
  Render_gPacketPtr = (char *)pEnv + 0x40;
  *(u_int *)(Render_gPalettePtr + view->otsize * 4 + -4) =
       *(u_int *)(Render_gPalettePtr + view->otsize * 4 + -4) & 0xff000000 |
       (u_int)pEnv & 0xffffff;
  SetDrawEnv(pEnv,&LEnv);
  return;
}

/* ---- Draw_CheckFirstFrameRender__Fv  [DRAW.CPP:409-419] SLD-VERIFIED ---- */
void Draw_CheckFirstFrameRender(void)

{
  if (gFlip == -1) {
    Draw_DirectSetEnvironment(0x140,0x100,0x140,0xf0,1,0,1,0,0,0);
    Draw_DirectSetEnvironment(0,0x100,0x140,0xf0,1,1,1,0,0,0);
    gFlip = 1;
    AllocatePrimitivesBuffer();
  }
  return;
}

/* ---- Draw_StartFrameRender__Fv  [DRAW.CPP:432-443] SLD-VERIFIED ---- */
void Draw_StartFrameRender(void)

{
  /* MATCH: SYM (nfs4-f-v3.txt @0x800BE2C0) names exactly ONE local (`i`, reg $s1); oracle
     is the same top-tested-while-no-guard family as the DeInitViews(InGame)/
     kCtrlWorld_High/StripDraw_High siblings (see their comments).
     FIXED (was 34-diff floor via a "safe partial fix" comma-while that a prior pass
     reverted from `goto TEST` over a suspected miscompile; now 21-diff via a CAREFULLY
     re-verified `goto TEST` do-while): re-checked the compiled disasm directly -- `s0`
     (pDVar4=&Draw_gView[0]) is written at the prologue BEFORE the `goto TEST`'s forward
     jump, and the loop body (which reads `pDVar4`) is reached ONLY via the back-branch
     from the test, never as straight-line fallthrough from the prologue -- so there is
     NO read-before-write; the earlier miscompile report must have been a different
     (buggier) source shape. This do-while now reproduces the oracle's loop EXACTLY (same
     insns, pure test/body rotation floor, same family as Draw_DeInitViewsInGame -- not
     reachable by a source lever at this opt level, see that fn's 12-shape survey).
     Residual 21 diffs = (a) the loop-rotation floor (test-block-first-with-fallthrough +
     unconditional back-`j` w/ increment in the exit-beqz's delay slot, vs ours body-first-
     with-goto-skip + conditional back-branch) + (b) a SEPARATE, pre-existing, loop-
     independent tail near-miss: the oracle re-reads `gEnviro[gFlip].server` from memory
     TWICE (once per consuming statement, interleaved with the s0/s1/ra epilogue restores)
     while our -O2 build CSEs it to one load reused for both `Render_gPacketPtr` and
     `Draw_gMaxPrim` -- confirmed pre-existing (byte-identical in the git HEAD baseline
     before this session's loop fix) and unaffected by statement reordering (tried both
     orders). Permuter or accept. */
  int *piVar2;
  u_long **ppuVar3;
  Draw_tView *pDVar4;
  int i;
  int iVar5;

  iVar5 = 0;
  pDVar4 = Draw_gView;
 TEST:
  if (iVar5 < Draw_gNumView) {
    piVar2 = &pDVar4->otsize;
    ppuVar3 = pDVar4->ot;
    ClearOTagR(ppuVar3[gFlip],*piVar2);
    pDVar4 = pDVar4 + 1;
    iVar5 = iVar5 + 1;
    goto TEST;
  }
  Render_gPacketPtr = gEnviro[gFlip].server;
  Draw_gMaxPrim = gEnviro[gFlip].server + gTotalMem;
  return;
}

/* ---- Draw_SetDrawSyncCallback__FPFv_v  [DRAW.CPP:448-449] SLD-VERIFIED ---- */
void Draw_SetDrawSyncCallback(fn_void *p)

{
  
  Draw_gSyncCallback = p;
  return;
}

/* ---- Draw_StopFrameRender__Fv  [DRAW.CPP:463-487] SLD-VERIFIED ---- */
void Draw_StopFrameRender(void)

{
  Draw_tView *pDVar2;
  int i;
  int iVar3;

  /* MATCH: SYM (nfs4-f-v3.txt @0x800BE36C) names exactly ONE local (`i`), live range
     starting at the merge point right after the VSync if-block (0x800BE3BC) -- matches
     oracle's loop counter $s1 (init `addu s1,zero,zero` once, straight `sll v0,v1,1` for
     the gEnviro[gFlip]*24 address calc, NOT a variable shift).
     FIXED (was 24-diff floor via a comma-`while`; then 11-diff via `goto TEST` do-while,
     same family as Draw_DeInitViews/Draw_DeInitViewsInGame; the comma-while shape kept
     `iVar3`/$s1 live back across the gEnviro[gFlip]*24 calc, so gcc reused $s1 for BOTH the
     loop counter AND the *3 sub-multiply -- the do-while broke that false liveness overlap).
     LEVER: `label: if(cond){body; goto label;}` (an if-guarded explicit backward goto, NOT
     a `goto TEST;do{}while()` do-while) is the C shape gcc-2.8.0 lowers to the oracle's
     test-block-first-fallthrough + unconditional-back-`j` topology -- confirmed against the
     PASSing sibling AIPerson_SetPersonalityPointers, the only other function in the whole
     oracle corpus with this shape. Keeps the same liveness break (still no comma-while).
     Sealed 100% (was a documented "floor"). */
  DrawSync(0);
  gLoop = gLoop + 1;
  if (Draw_gSyncCallback != (void *)0x0) {
    (*Draw_gSyncCallback)();
  }
  if (Draw_gDoVSync != 0) {
    VSync(0);
  }
  PutDispEnv(&gEnviro[gFlip].disp);
  iVar3 = 0;
  pDVar2 = Draw_gView;
 loopTop:
  if (iVar3 < Draw_gNumView) {
    DrawOTag(pDVar2->ot[gFlip] + pDVar2->otsize + -1);
    pDVar2 = pDVar2 + 1;
    iVar3 = iVar3 + 1;
    goto loopTop;
  }
  gFlip = 1 - gFlip;
  return;
}

/* ---- Draw_DrawDirectScreen__FP8shapetblii  [DRAW.CPP:493-498] SLD-VERIFIED ---- */
void Draw_DrawDirectScreen(shapetbl *tile,int x,int y)

{
  
  Texture_Vramcf(tile,x,y + 0x100,0,0);
  return;
}

/* ---- Draw_DirectSetEnvironment__Fiiiiiiiiii  [DRAW.CPP:513-546] SLD-VERIFIED ---- */
void Draw_DirectSetEnvironment(int x,int y,int w,int h,int edraw,int edisplay,int erase,int r,int g,int b)

{
  /* SYM (nfs4-f-v3.txt @0x800BE478) names TWO `AUTO` locals both called `e` (one typed
     DRAWENV/92B, one DISPENV/20B) -- but the RAW oracle disproves "two independent
     slots": both SetDefDrawEnv's and SetDefDispEnv's buffer args resolve to the exact
     SAME address `sp+0x18` (`addiu a0,sp,0x18` at all 3 call sites). So the two SYM
     `e`s are typed views of ONE shared stack buffer -- the original bug was the buffer
     being declared as the SMALLER `DISPENV` (20B, too small for a real DRAWENV) and
     cast; fix is a single buffer big enough for both, sized/typed as `DRAWENV` (92B),
     used directly for the draw-env call and passed to SetDefDispEnv via a DISPENV*
     reinterpret for the disp-env call (matches oracle's single shared address).
     🔴 ALSO: the oracle has a WHOLE MISSING FEATURE -- a `beqz $s0,...` (erase==0)
     gate right after SetDefDrawEnv, writing e.r0/e.g0/e.b0 (DRAWENV +0x19/+0x1A/+0x1B)
     from the r/g/b params and setting e.isbg=1 when erase!=0 (else e.isbg=0), all
     BEFORE PutDrawEnv -- confirmed by decoding the buffer offsets 0x31/0x32/0x33/0x30
     (relative to the sp+0x18 base) against the real DRAWENV field layout. The prior
     reconstruction dropped this whole block (treating erase/r/g/b as unused params). */
  DRAWENV e;

  if (edraw != 0) {
    SetDefDrawEnv(&e,x,y,w,h);
    if (erase != 0) {
      e.r0 = (u_char)r;
      e.g0 = (u_char)g;
      e.b0 = (u_char)b;
      e.isbg = 1;
    }
    else {
      e.isbg = 0;
    }
    PutDrawEnv(&e);
  }
  if (edisplay != 0) {
    SetDefDispEnv((DISPENV *)&e,x,y,w,h);
    SetDispMask(0);
    PutDispEnv((DISPENV *)&e);
    timedwait(timerhz >> 1);
    SetDispMask(1);
  }
  return;
}

/* ---- Draw_SetEnvironment__Fiiiiiiii  [DRAW.CPP:551-553] SLD-VERIFIED ---- */
void Draw_SetEnvironment(int w,int h,int edraw,int edisplay,int erase,int r,int g,int b)

{
  
  Draw_DirectSetEnvironment(0,0x100,w,h,edraw,edisplay,erase,r,g,b);
  return;
}

/* ---- Draw_InitRenderEngine__Fiiiiii  [DRAW.CPP:577-591] SLD-VERIFIED ---- */
void Draw_InitRenderEngine(int x0,int y0,int x1,int y1,int w,int h)

{
  
  gFlip = -1;
  gEnviro[0].server = (char *)0x0;
  gEnviro[1].server = (char *)0x0;
  SetDefDispEnv(&gEnviro[0].disp,x0,y0,w,h);
  SetDefDispEnv(&gEnviro[1].disp,x1,y1,w,h);
  Draw_SetDrawSyncCallback((fn_void *)0x0);
  return;
}

/* ---- Draw_RestartRenderEngine__Fv  [DRAW.CPP:596-597] SLD-VERIFIED ---- */
void Draw_RestartRenderEngine(void)

{
  return;
}

/* ---- Draw_DeInitRenderEngine__Fv  [DRAW.CPP:600-603] SLD-VERIFIED ---- */
void Draw_DeInitRenderEngine(void)

{
  ClearPlatformPrimitivesBuffer();
  gFlip = -1;
  return;
}

/* ---- Draw_InitLibRender__Fv  [DRAW.CPP:609-613] SLD-VERIFIED ---- */
void Draw_InitLibRender(void)

{
  gLoop = 1;
  InitGeom();
  return;
}

/* end of draw.cpp */

/* owning-TU def (extern-declared, never defined; link-harness) */
fn_void *Draw_gSyncCallback;
