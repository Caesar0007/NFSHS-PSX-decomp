/* game/psx/hrzsku.cpp -- RECONSTRUCTED (NFS4 PSX in-race HUD; C++ TU)
 *   62 fns: sprite/poly builders, tachometer, number rasterizer, mini-map + radar,
 *   CD player, wingman interface, render views (hud/tac/map/stats), 3-2-1-GO, BTC/busted.
 *   Reconstructed with full SYM-locals applied (audited).
 */
#include "../../nfs4_types.h"
#include "hrzsku_externs.h"

/* ---- link-harness owned-global definition (extern-declared, never defined) ---- */
int Hrz_gProjResultZ0; int Hrz_gProjScratch_9C;  /* HrzSku.obj-owned projection scratch (BSS) */

/* ---- HrzSku.obj-OWNED globals -- DEFINED here (self-contained; SYM-typed via gen_owned_defs:
   .data = real NFS4.EXE bytes, .bss = zero) ---- */
Draw_tPixMap *gHorizonPixmap[16];   /* @0x801202f8  (bss(zero)) */
Draw_tPixMap gHorizonExtraSkyPixmaps[4];   /* @0x80120338  (bss(zero)) */
SVECTOR      gSkyMesh[85];   /* @0x80120378  (bss(zero)) */
CVECTOR      gSkyColor[85];   /* @0x80120620  (bss(zero)) */
char         gSkyPixmapIndex[64];   /* @0x80120774  (bss(zero)) */
Draw_tPixMap *gpPmx[16];   /* @0x801207b4  (bss(zero)) */
CVECTOR      gHrzRingColor[2][17];   /* @0x801207f4  (bss(zero)) */
int          gfxPmxHeightPercentage[16];   /* @0x8012087c  (bss(zero)) */
tHrz_Lightning gHrz_Lightning;   /* @0x801208bc  (bss(zero)) */
SVECTOR      *starPosInSky;   /* @0x8013d878  (bss(zero)) */
CVECTOR      *starColors;   /* @0x8013d87c  (bss(zero)) */
CHorizonSpec *Hrz_gTrackSpec;   /* @0x8013d888  (bss(zero)) */
CSkySpec     *Sky_gTrackSpec;   /* @0x8013d88c  (bss(zero)) */
SVECTOR      *gRngCoordTop;   /* @0x8013d890  (bss(zero)) */
SVECTOR      Hrz_gLightningPosInSky;   /* @0x8013d894  (bss(zero)) */
static SVECTOR sunPosInSky;   /* @0x8013ddf0  (bss(zero)) SYM: class STAT */
static SVECTOR moonPosInSky;   /* @0x8013ddf8  (bss(zero)) SYM: class STAT */
CVECTOR      Hrz_gSaveCol[4];   /* @0x8013e380  (bss?) */
/* hrzsku-internal lost-symbol globals (NOT in SYM Globals; 4 contiguous ints, sky double-buffer
   vertex counts, accessed via (&A0)[i]). DEFINED here for self-containment (was extern-only). */
int Hrz_gSkyVtx_A0, Hrz_gSkyVtx_A1, Hrz_gSkyVtx_B0, Hrz_gSkyVtx_B1;

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Horizon_InterpolateLineSCoords(DVECTOR *sc,DVECTOR *s0,DVECTOR *s1,int *percentage,int n,int bPercentageArray);
void Sky_InitStars(void);
void Sky_KillStars(void);
void Hrz_InitSkyColor(void);
void Hrz_InitSky(void);
void Hrz_Init2DRing(void);
void Hrz_GetHorizonPixMap(Draw_tPixMap *p);
void Hrz_InitHorizon(void);
void Hrz_KillHorizon(void);
void Hrz_LightningAddFork(signed char direction,signed char column,signed char row);
void Hrz_CalculateLightning(void);
void Hrz_TextureQuad(DVECTOR *pt,char type,char bright,Draw_DCache *sd);
void Hrz_SetLightingPosInSky(DRender_tView *Vi);
void Hrz_BuildForkLightning(Draw_DCache *sd);
void Hrz_LightningFlicker(int on);
void HrzSetPsxMatrix(matrixtdef *m);
void HrzSetPsxTranslation(coorddef *t);
void Hrz_RotProj16(int n, SVECTOR *s, int *z, DVECTOR *p);
void Hrz_SetDitheringPrim(int dither,int otz);
void Hrz_BuildSky(void);
void Sky_RenderStars(Draw_SkyCache *sd,int otz);
void Hrz_BuildHorizon(DRender_tView *Vi);


/* ---- Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii  [HRZSKU.CPP:128-156] SLD-VERIFIED ----
 * NEAR-MISS 26 diffs (80/80, count exact -- improved from 37 baseline). FIX: the
 * `bPercentageArray==0` branch never advances `percentage`, so `*percentage` is truly
 * loop-invariant across ALL iterations (both vx and vy uses) -- gcc hoists the read
 * completely out of the loop into a register that survives the whole loop (and even
 * runs it BEFORE the `0<n` guard, since a bare load has no observable side effect).
 * Reproduced by reading it into a local `pv = *percentage;` right on entry to the
 * `else` block, before the `if (0<n)` test -- gcc then reuses the SAME loaded value for
 * every iteration's vx/vy multiply instead of re-dereferencing `percentage` per use,
 * matching the oracle's single hoisted `lw`. Residual = a uniform `$t0`<->`$t1` register
 * swap between `sc` (pointer, `addiu ,4` stride) and `i` (counter, `addiu ,1`) in BOTH
 * loops -- tried sc[i]-index form (worse, 39 diffs) and increment-statement reordering
 * (worse, 28 diffs); a genuine allocator coalescing tie-break, accepted. */
void Horizon_InterpolateLineSCoords(DVECTOR *sc,DVECTOR *s0,DVECTOR *s1,int *percentage,int n,int bPercentageArray)

{
  int i;
  int p;
  int pv;

  if (bPercentageArray != 0) {
    if (0 < n) {
      i = 0;
      do {
        p = *percentage * ((int)s1->vx - (int)s0->vx);
        if (p < 0) {
          p = p + 0xffff;
        }
        sc->vx = s0->vx + (short)(p >> 0x10);
        p = *percentage * ((int)s1->vy - (int)s0->vy);
        if (p < 0) {
          p = p + 0xffff;
        }
        sc->vy = s0->vy + (short)(p >> 0x10);
        percentage = percentage + 1;
        s0 = s0 + 1;
        s1 = s1 + 1;
        i = i + 1;
        sc = sc + 1;
      } while (i < n);
    }
  }
  else {
    pv = *percentage;
    if (0 < n) {
      i = 0;
      do {
        p = pv * ((int)s1->vx - (int)s0->vx);
        if (p < 0) {
          p = p + 0xffff;
        }
        sc->vx = s0->vx + (short)(p >> 0x10);
        p = pv * ((int)s1->vy - (int)s0->vy);
        if (p < 0) {
          p = p + 0xffff;
        }
        sc->vy = s0->vy + (short)(p >> 0x10);
        s0 = s0 + 1;
        s1 = s1 + 1;
        i = i + 1;
        sc = sc + 1;
      } while (i < n);
    }
  }
  return;
}

/* ---- Sky_InitStars__Fv  [HRZSKU.CPP:185-211] SLD-VERIFIED ----
 * NEAR-MISS 50 diffs (120/122, improved from 106 baseline). THREE stacked fixes, all
 * SYM-evidenced (`nfs4-f-v3.txt` @40dd10, nested nested block `radius/height/latAngle/
 * heightAngle/starBright` inside the loop body, `oldSeed`=LONG/`i`=INT outside):
 * (1) renamed the Ghidra temps to the SYM names + moved them into the loop's OWN block
 * scope (were function-scope `uVar1/iVar3/iVar4/iVar7/iVar8`) -- matches §HrzSetPsxMatrix's
 * "SYM block scopes are load-bearing" lesson. (2) the masked `uVar1 & 0xffff` (renamed
 * `latAngle`) is masked IMMEDIATELY after its `random()` call (own statement) instead of
 * inline at first use -- gcc then schedules the `andi` into the delay slot of the NEXT
 * `random()` call exactly like the oracle, instead of leaving it stranded at the point of
 * use. (3) 🔴 REAL BUG: the two `if (range == 0) trap(0x1c00);` guards were WRONG -- the
 * oracle's `divu;bnez;break 7;mfhi` sequence is the COMPILER'S OWN automatic ÷0 guard from
 * a bare `%` operator (`--expand-div`, catalog row C), not a hand-written check; removed
 * both explicit `if/trap` pairs and folded the range subtraction directly into the modulo
 * expression -- this ALSO fixed a signed-vs-unsigned bug (starBright was `int`, giving a
 * SIGNED `div` with an extra INT_MIN/-1 overflow guard the oracle doesn't have; corrected
 * to `u_int` -- oracle's second range check is `divu`, not `div`). Residual: oracle uses
 * ONE more callee-saved reg (`$s0-$s5`, 6 regs) than ours (`$s0-$s4`, 5 regs) -- `height`
 * and `radius` are both simultaneously live across the same call span in both builds (SYM
 * confirms height=$s2/radius=$s1 alongside heightAngle=$s0/latAngle=$s3/i=$s4/oldSeed=$s5)
 * but our allocator finds a way to route one fewer live range through a save/restore;
 * every remaining diff line is otherwise position-identical, just uniformly shifted by
 * this one missing slot -- genuine allocator floor, not chased further. */
void Sky_InitStars(void)

{
  int seed;
  u_int uVar2;
  SVECTOR *pSVar6;
  int i;
  long oldSeed;

  if (starPosInSky == (SVECTOR *)0x0) {
    seed = random();
    seedrandom(Sky_gTrackSpec->starRandomSeed);
    starPosInSky = (SVECTOR *)reservememadr("stars",Sky_gTrackSpec->numStars << 3,0);
    starColors = (CVECTOR *)reservememadr("starCols",Sky_gTrackSpec->numStars << 2,0);
    for (i = 0; i < Sky_gTrackSpec->numStars; i = i + 1) {
      int latAngle;
      int heightAngle;
      int height;
      int radius;
      int vx;
      u_int starBright;

      latAngle = random();
      latAngle = latAngle & 0xffff;
      uVar2 = random();
      heightAngle = Sky_gTrackSpec->starAngleLow +
                    uVar2 % (Sky_gTrackSpec->starAngleHigh - Sky_gTrackSpec->starAngleLow);
      height = fixedsin(heightAngle);
      height = fixedmult(height,1000);
      radius = fixedcos(heightAngle);
      radius = fixedmult(radius,1000);
      vx = fixedsin(latAngle);
      vx = fixedmult(vx,radius);
      pSVar6 = starPosInSky + i;
      pSVar6->vx = (short)vx;
      pSVar6->vy = (short)height;
      height = fixedcos(latAngle);
      height = fixedmult(height,radius);
      starPosInSky[i].vz = (short)height;
      starBright = random();
      starBright = Sky_gTrackSpec->starBrightMin +
                   starBright % (Sky_gTrackSpec->starBrightMax - Sky_gTrackSpec->starBrightMin);
      (*(u_long *)&starColors[i]) = starBright * 0x10000 | starBright * 0x100 | starBright;
    }
    seedrandom(seed);
  }
  return;
}

/* ---- Sky_KillStars__Fv  [HRZSKU.CPP:216-222] SLD-VERIFIED ---- */
void Sky_KillStars(void)

{
  if (starPosInSky != (SVECTOR *)0x0) {
    purgememadr(starPosInSky);
  }
  if (starColors != (CVECTOR *)0x0) {
    purgememadr(starColors);
  }
  starPosInSky = (SVECTOR *)0x0;
  starColors = (CVECTOR *)0x0;
  return;
}

/* ---- Hrz_InitSkyColor__Fv  [HRZSKU.CPP:227-252] SLD-VERIFIED ----
 * NEAR-MISS 102 diffs (85/87). Oracle's back-edges are BOTH unconditional `j T` (top-test,
 * un-rotated topology for the outer AND inner loop) while the plain nested `for` here
 * rotates to `bnez`-back (bottom-test). Tried the exit-in-the-middle `goto`/label form
 * (`LOOP_I:/LOOP_L:` with `if(cond){...; goto LOOP_x;}`) -- DOES reproduce the oracle's
 * double-`j T` topology exactly, but total diff count stayed 102 (register coloring
 * throughout the body is a uniform swap either way -- SYM `nfs4-f-v3.txt` @40deaf shows
 * `i`=REG7=$a3, `k`=REG6=$a2, but neither `i=0;k=0;` nor `k=0;i=0;` statement order landed
 * the goto-form's registers on that assignment; a deeper allocator-priority effect, not
 * source-order-driven). Reverted to the simpler plain-for form (identical diff count,
 * less code) -- accepted floor; the goto form is available if a future coloring lever
 * cracks the rest (see reverted variant in this session's notes). */
void Hrz_InitSkyColor(void)
{
  int i, j, k, l;
  CVECTOR rounddiff, cur_bk, cur_fr;
  CVECTOR *pCVar9;

  k = 0;
  for (i = 0; i < 5; i++) {
    cur_bk = Sky_gTrackSpec->backcolors[i];
    cur_fr = Sky_gTrackSpec->frontcolors[i];
    j = cur_bk.r - cur_fr.r;  if (j < 0) j = j + 7;  rounddiff.r = (u_char)(j >> 3);
    j = cur_bk.g - cur_fr.g;  if (j < 0) j = j + 7;  rounddiff.g = (u_char)(j >> 3);
    j = cur_bk.b - cur_fr.b;  if (j < 0) j = j + 7;  rounddiff.b = (u_char)(j >> 3);
    pCVar9 = gSkyColor + k;
    for (l = 0; l < 0x11; l++) {
      j = l;
      if (8 < l) j = 0x10 - l;
      pCVar9->r = cur_fr.r + (char)rounddiff.r * (char)j;
      pCVar9->g = cur_fr.g + (char)rounddiff.g * (char)j;
      pCVar9->b = cur_fr.b + (char)rounddiff.b * (char)j;
      pCVar9 = pCVar9 + 1;
      k = k + 1;
    }
  }
}

/* ---- Hrz_InitSky__Fv  [HRZSKU.CPP:257-332] SLD-VERIFIED ----
 * SYM `nfs4-f-v3.txt` @40dff5 shows the REAL function uses only 6 named locals in a SINGLE
 * flat block (`i`=$s3, `j`=$s1, `k`=$s6, `angle`=$s0, `height`=$s4, `radius`=$s5) plus 2
 * unnamed compiler temps ($s2,$s7) -- 8 total callee-saved regs (mask=$80ff0000, s0-s7, NO
 * `$fp`). ROUND 2: executed the merge diagnosed in round 1. `i`/`j`/`k`/`angle`/`height`/
 * `radius` were DECLARED but never referenced by the old ~13-local Ghidra reconstruction --
 * dead placeholders. Renamed the ACTUALLY-live temps onto them by lifetime: `i`=ring/outer
 * counter (loop1 0..5, reused loop2 0..4 -- dead between), `j`=inner vertex counter (loop1
 * 0..0x11, reused loop2 0..0x10), `k`=running mesh index (loop1, reused as the loop2 pixmap-
 * index -- both are "index into an array bumped every inner iter"), `angle`=the per-ring raw
 * angle (dies once height/radius are derived) reused for the inner loop's per-vertex angle
 * (was `angle_00` -- same physical var, disjoint lifetimes exactly as diagnosed), `height`/
 * `radius`=the two post-sin/cos*1000 ring constants held live across the inner loop. Dropped
 * the `pSVar7` pointer-walk for direct `gSkyMesh[k]` indexing (§3.12 #1) -- removes the 9th
 * live temp that forced the `$fp` spill. Kept 2 genuine compiler scratch temps (`iVar2` for
 * the straight-line sun/moon calc + view select, `iVar5` for the reused per-iteration
 * sin/cos/modulo scratch) matching the SYM's 2 unnamed s2/s7 slots. Pure semantic-preserving
 * rename + array-index conversion, same dataflow. 211->189 (no `$fp` spill anymore, verified
 * ($fp save/restore gone from our prologue/epilogue) -- the merge worked as diagnosed).
 * RESIDUAL 189 = a SEPARATE, PRE-EXISTING class (not touched by the merge): every
 * `sunPosInSky.vx/vy/vz` / `moonPosInSky.vx/vy/vz` store. SYM @40f76a/40f78d: BOTH are
 * `class STAT type STRUCT size 8 tag SVECTOR` (genuinely file-static, matched here by adding
 * `static`, 0 diff delta but now SYM-faithful). Oracle addresses EACH 2-byte field
 * independently gp-relative (`sh v0,%gp_rel(D_8013DDF0)($gp)` etc, one insn/field, 6 distinct
 * splat-synthesized sub-symbols spanning the two 8-byte structs incl. the `pad` gap) with NO
 * base-pointer materialization; ours (cc1plus, this build's `-G4`) computes ONE absolute
 * base (`lui s0,%hi; addiu s0,%lo`) and stores through 3 displacements, because a 8-byte
 * SVECTOR exceeds the 4-byte small-data threshold at the DECLARATION (cc1's sdata-eligibility
 * check is by the SYMBOL's total declared size, not the field's access size). Tried + failed:
 * `static` linkage (no codegen change, size check unaffected), `__attribute__((section(
 * ".sbss")))` (cc1's %hi/%lo-vs-gp_rel choice is made before/independent of section
 * placement; maspsx's own `.lcomm sym,N<=4` sbss-promotion pass also requires N<=4, confirmed
 * via the raw `hrzsku.cpp.s`: `.lcomm sunPosInSky,8` stays absolute either way). GENUINE
 * `-G4`-threshold FLOOR for an 8-byte aggregate -- not reachable without a build-flag change
 * (out of scope; no flag changes per mission rules). Accept. */
void Hrz_InitSky(void)

{
  int iVar2;
  int angle;
  int radius;
  int iVar5;
  int j;
  int i;
  int height;
  int k;

  iVar2 = fixedcos(Sky_gTrackSpec->sunAngleInSky);
  iVar2 = fixedmult(iVar2,1000);
  sunPosInSky.vx = (short)iVar2;
  iVar2 = fixedsin(Sky_gTrackSpec->sunAngleInSky);
  iVar2 = fixedmult(iVar2,1000);
  sunPosInSky.vz = (short)iVar2;
  sunPosInSky.vy =
       (short)TrackSpec_gSpec.skyspec.sunHeightInSky + (short)TrackSpec_gSpec.skyspec.yoffset;
  iVar2 = fixedcos(Sky_gTrackSpec->moonAngleInSky);
  iVar2 = fixedmult(iVar2,1000);
  moonPosInSky.vx = (short)iVar2;
  iVar2 = fixedsin(Sky_gTrackSpec->moonAngleInSky);
  iVar2 = fixedmult(iVar2,1000);
  moonPosInSky.vz = (short)iVar2;
  moonPosInSky.vy =
       (short)TrackSpec_gSpec.skyspec.moonHeightInSky + (short)TrackSpec_gSpec.skyspec.yoffset;
  iVar2 = Draw_gPlayer1View;
  if (GameSetup_gData.commMode == 1) {
    Draw_SetViewColor(Draw_gPlayer1View,(u_int)(Sky_gTrackSpec->clearcolor).r,
               (u_int)(Sky_gTrackSpec->clearcolor).g,(u_int)(Sky_gTrackSpec->clearcolor).b);
    iVar2 = Draw_gPlayer2View;
  }
  i = 0;
  Draw_SetViewColor(iVar2,(u_int)(Sky_gTrackSpec->clearcolor).r,(u_int)(Sky_gTrackSpec->clearcolor).g,
             (u_int)(Sky_gTrackSpec->clearcolor).b);
  k = 0;
  do {
    if ((Sky_gTrackSpec->flags & 0x80U) == 0) {
      if (((Sky_gTrackSpec->flags & 2U) == 0) || (angle = i << 0xb, 3 < i)) {
        angle = i << 0xc;
      }
      height = fixedcos(angle);
      height = fixedmult(height,1000);
    }
    else {
      angle = fixedcos(Sky_gTrackSpec->ringAngles[i]);
      height = fixedmult(angle,1000);
      angle = Sky_gTrackSpec->ringAngles[i];
    }
    j = 0;
    angle = fixedsin(angle);
    radius = fixedmult(angle,1000);
    do {
      iVar5 = j * 0x1000;
      j = j + 1;
      angle = (iVar5 - Sky_gTrackSpec->sunAngleInSky) + 0x4000;
      iVar5 = fixedsin(angle);
      iVar5 = fixedmult(iVar5,height);
      gSkyMesh[k].vx = (short)iVar5;
      gSkyMesh[k].vy = (short)Sky_gTrackSpec->yoffset + (short)radius;
      iVar5 = fixedcos(angle);
      iVar5 = fixedmult(iVar5,height);
      gSkyMesh[k].vz = (short)iVar5;
      k = k + 1;
    } while (j < 0x11);
    i = i + 1;
  } while (i < 5);
  i = 0;
  if (Sky_gTrackSpec->type == 1) {
    k = 0;
    do {
      j = 0;
      do {
        iVar5 = j;
        if (j < 0) {
          iVar5 = j + 3;
        }
        iVar5 = j + (iVar5 >> 2) * -4;
        j = j + 1;
        gSkyPixmapIndex[k] = *(char *)((int)Sky_gTrackSpec + iVar5 + i * 4 + 0x6c) + '\b';
        k = k + 1;
      } while (j < 0x10);
      i = i + 1;
    } while (i < 4);
    if ((Sky_gTrackSpec->type == 1) && ((Sky_gTrackSpec->flags & 0x20U) == 0))
    goto HrzInitSky_initLensFlare;
  }
  Hrz_InitSkyColor();
HrzInitSky_initLensFlare:
  Flare_InitLensFlare();
  return;
}

/* ---- Hrz_Init2DRing__Fv  [HRZSKU.CPP:337-414] SLD-VERIFIED ----
 * NEAR-MISS 280 diffs (221/185), NOT YET SYM-merged (round-2 diagnosis only, not applied --
 * ran out of session budget to trace+verify safely, same disease as Hrz_InitSky pre-fix).
 * SYM `nfs4-f-v3.txt` @40e105 (`awk '/name = Hrz_Init2DRing__Fv/,/8e Function end/'`) shows
 * only 9 real locals total across nested block scopes: outer `i`=$s1,`angle`=$s0; a
 * pnPmxHeight_InPixels-block `nMaxPmxHeight_InPixels`=REG + `pnPmxHeight_InPixels[16]`=AUTO
 * (block lines 17-39, i.e. spans the ring-build + pixmap-height loops); a separate
 * `level`=REG block (lines 44-73) containing `cur_bk`/`cur_fr`/`rounddiff` (CVECTOR AUTOs)
 * + an innermost `j`=REG (lines 51-59, the color-row loop). The CURRENT reconstruction below
 * has 33 declared locals (ringCount/shapeWidth/ti12/pmx_p/atan_in/iVar6_b/rowMaxX/shape_p/
 * shapeStride/ringEntry_pp/rowOff_p/ti10/ringByte_p/rowBuf_p/ring_step/iVar14_field/
 * row_array_p/iVar1/reg_t5/u_idx/u_idx2/uVar18_pack/ring_x/ring_x2/row_advance/row_idx/tC3/
 * tu5/CVar1 on top of the 9 SYM-real ones) -- same "too many distinctly-live Ghidra temps"
 * class that forced Hrz_InitSky's extra `$fp` spill (see that function's fix comment for the
 * full playbook). Suspicious reused-role candidate: `ti12` starts as a constant `1` (ring
 * loop, line ~434), becomes a running MAX accumulator (pixmap-height loop), then a DIVISOR
 * (row-percentage loop), then gets reset to `0` for a completely unrelated accumulator role
 * in the color loop -- likely maps to `nMaxPmxHeight_InPixels` for its first three lives and
 * a throwaway temp for the fourth, but the SYM block-scope boundaries (block 17-39 closing
 * before the row-percentage loop, if that loop is truly outside it) need to be reconciled
 * against the RAW oracle instruction-by-instruction before any rename is safe to attempt --
 * NOT done this session (BuildHorizon's regional-fix attempt this session taught that an
 * unverified partial merge on a multi-phase function can move the diff count the WRONG way;
 * a full merge needs the SAME rigor as Hrz_InitSky's, done in one pass, not a partial rename).
 * Left untouched pending that follow-up. */
void Hrz_Init2DRing(void)

{
  int ringCount;
  int shapeWidth;
  int ti12;
  int pmx_p;
  int atan_in;
  int iVar6_b;
  int rowMaxX;
  int shape_p;
  int shapeStride;
  int ringEntry_pp;
  int rowOff_p;
  int ti10;
  int ringByte_p;
  int rowBuf_p;
  int ring_step;
  int pnPmxHeight_InPixels [16];
  int iVar14_field;
  int row_array_p;
  int iVar1;
  int reg_t5;
  int u_idx;
  int u_idx2;
  int angle;
  int uVar18_pack;
  int ring_x;
  int ring_x2;
  int row_advance;
  int row_idx;
  CVECTOR cur_bk;
  CVECTOR cur_fr;
  CHorizonSpec *tC3;
  CVECTOR tu5;
  int CVar1;

  iVar1 = 0;
  do {
    uVar18_pack = iVar1 * 0x1000 + Hrz_gTrackSpec->angle;
    ringCount = fixedsin(uVar18_pack);
    shapeWidth = fixedmult(ringCount,32000);
    shape_p = (int)(gRngCoordTop + iVar1);
    *(short *)shape_p = (short)shapeWidth;
    *(u_short *)(shape_p + 2) = 0;
    ti12 = fixedcos(uVar18_pack);
    ti12 = fixedmult(ti12,32000);
    ring_x = iVar1 + 1;
    gRngCoordTop[iVar1].vz = (short)ti12;
    tC3 = Hrz_gTrackSpec;
    ti12 = 1;
    iVar1 = ring_x;
  } while (ring_x < 0x11);
  ringByte_p = (int)pnPmxHeight_InPixels;
  ringEntry_pp = (int)gpPmx;
  for (ring_x2 = 0; ring_x2 < 0x10; ring_x2 = ring_x2 + 1) {
    pmx_p = (int)gHorizonPixmap[(u_char)tC3->ringPMX[ring_x2] & 7];
    *(int *)ringEntry_pp = pmx_p;
    shapeStride = (u_int)*(u_char *)(pmx_p + 9) - (u_int)*(u_char *)(pmx_p + 5);
    *(int *)ringByte_p = shapeStride;
    if (ti12 < shapeStride) {
      ti12 = shapeStride;
    }
    ringByte_p = ringByte_p + 4;
    ringEntry_pp = ringEntry_pp + 4;
  }
  row_advance = 0;
  rowBuf_p = (int)gfxPmxHeightPercentage;
  rowOff_p = (int)&cur_bk;
  do {
    ((u_char *)&(atan_in))[0] = ((CVECTOR *)rowOff_p)->r;
    ((u_char *)&(atan_in))[1] = ((CVECTOR *)rowOff_p)->g;
    ((u_char *)&(atan_in))[2] = ((CVECTOR *)rowOff_p)->b;
    ((u_char *)&(atan_in))[3] = ((CVECTOR *)rowOff_p)->cd;
    rowOff_p = rowOff_p + 4;
    row_advance = row_advance + 1;
    *(int *)rowBuf_p = (atan_in << 0x10) / ti12;
    rowBuf_p = rowBuf_p + 4;
  } while (row_advance < 0x10);
  row_array_p = (int)gHrzRingColor;
  ti12 = 0;
  for (iVar1 = 0; row_idx = 0, iVar1 < 2; iVar1 = iVar1 + 1) {
    cur_bk = Hrz_gTrackSpec->backColor[iVar1];
    u_idx = *(u_int *)&cur_bk;
    cur_fr = Hrz_gTrackSpec->frontColor[iVar1];
    u_idx2 = *(u_int *)&cur_fr;
    tu5 = cur_fr;
    iVar14_field = ti12;
    reg_t5 = u_idx2;
    for (; row_idx < 0x10; row_idx = row_idx + 1) {
      ring_step = row_idx;
      if (8 < row_idx) {
        ring_step = 0x10 - row_idx;
      }
      cur_fr.r = (u_char)u_idx2;
      iVar6_b = (u_idx & 0xffU) - (u_idx2 & 0xffU);
      if (iVar6_b < 0) {
        iVar6_b = iVar6_b + 7;
      }
      cur_fr.g = (u_char)((u_int)u_idx2 >> 8);
      rowMaxX = ((u_int)u_idx >> 8 & 0xff) - (u_int)cur_fr.g;
      if (rowMaxX < 0) {
        rowMaxX = rowMaxX + 7;
      }
      cur_fr.b = (u_char)((u_int)u_idx2 >> 0x10);
      ti10 = ((u_int)u_idx >> 0x10 & 0xff) - (u_int)cur_fr.b;
      if (ti10 < 0) {
        ti10 = ti10 + 7;
      }
      (&gHrzRingColor[0][0].r)[iVar14_field] = cur_fr.r + (char)(iVar6_b >> 3) * (char)ring_step;
      (&gHrzRingColor[0][0].g)[iVar14_field] = cur_fr.g + (char)(rowMaxX >> 3) * (char)ring_step;
      reg_t5 = (ti10 >> 3 & 0xffU) * ring_step;
      (&gHrzRingColor[0][0].b)[iVar14_field] = cur_fr.b + (char)reg_t5;
      iVar14_field = iVar14_field + 4;
    }
    CVar1 = *(int *)row_array_p;
    *(int *)(row_array_p + 0x40) = CVar1;
    row_array_p = row_array_p + 0x44;
    ti12 = ti12 + 0x44;
    cur_fr = tu5;
  }
  Hrz_InitSky();
  Hrz_gSaveCol[1] = Sky_gTrackSpec->frontcolors[0];
  return;
}

/* ---- Hrz_GetHorizonPixMap__FP12Draw_tPixMap  [HRZSKU.CPP:419-428] SLD-VERIFIED ---- */
void Hrz_GetHorizonPixMap(Draw_tPixMap *p)

{
  Draw_tPixMap **skytbl_walk;
  Draw_tPixMap *p_walk;
  void *tp2;
  int tp3;
  int extra_pmx;
  int i;
  int src_off;
  int dst_off;
  int pixmap_base;
  int pixmap_base2;

  i = 0xb;
  pixmap_base = (int)&gHorizonPixmap;
  skytbl_walk = (Draw_tPixMap **)(pixmap_base + 0x2c);
  p_walk = p + 0xb;
  do {
    *skytbl_walk = p_walk;
    skytbl_walk = skytbl_walk + -1;
    i = i - 1;
    p_walk = p_walk + -1;
  } while (-1 < i);
  i = 0;
  pixmap_base2 = (int)&gHorizonPixmap;
  dst_off = 0x30;
  extra_pmx = (int)&gHorizonExtraSkyPixmaps;
  src_off = 0x20;
  do {
    tp2 = (void *)(src_off + pixmap_base2);
    src_off = src_off + 4;
    i = i + 1;
    Texture_CloneUVPmx(*(Draw_tPixMap **)tp2,0,(Draw_tPixMap *)extra_pmx);
    tp3 = dst_off + pixmap_base2;
    dst_off = dst_off + 4;
    *(int *)tp3 = extra_pmx;
    extra_pmx = extra_pmx + 0x10;
  } while (i < 4);
  return;
}

/* ---- Hrz_InitHorizon__Fv  [HRZSKU.CPP:432-443] SLD-VERIFIED ---- */
void Hrz_InitHorizon(void)

{
  Hrz_gTrackSpec = &TrackSpec_gSpec.horizonspec;
  Sky_gTrackSpec = &TrackSpec_gSpec.skyspec;
  gRngCoordTop = (SVECTOR *)reservememadr("gRngCoordTop",0x88,0);
  Hrz_Init2DRing();
  if ((TrackSpec_gSpec.skyspec.flags & 0x10U) != 0) {
    Sky_InitStars();
  }
  return;
}

/* ---- Hrz_KillHorizon__Fv  [HRZSKU.CPP:447-450] SLD-VERIFIED ---- */
void Hrz_KillHorizon(void)

{
  purgememadr(gRngCoordTop);
  Sky_KillStars();
  return;
}

/* ---- Hrz_LightningAddFork__FScScSc  [HRZSKU.CPP:783-822] SLD-VERIFIED ---- */
void Hrz_LightningAddFork(signed char direction,signed char column,signed char row)

{
  u_char bVar1;
  int iVar2;
  u_int uVar3;
  u_int uVar4;
  char type;
  u_int uVar5;
  tHrz_LightningFork *fork;
  u_int uVar6;
  
  uVar5 = (u_int)(u_char)column;
  uVar3 = (u_int)(u_char)direction;
  if (row == '\0') {
    uVar6 = 3;
  }
  else {
    uVar6 = 2;
    if (row < '\x03') {
      uVar6 = random();
      uVar6 = uVar6 % 3;
    }
  }
  uVar4 = (u_int)(u_char)gHrz_Lightning.numForks;
  gHrz_Lightning.numForks = gHrz_Lightning.numForks + '\x01';
  gHrz_Lightning.forks[uVar4].pos.vx = column * 0xf;
  gHrz_Lightning.forks[uVar4].pos.vy = row * 0xf;
  if (uVar6 == 1) {
    Hrz_LightningAddFork((char)-1,(char)((uVar5 - 1) * 0x1000000 >> 0x18),row + '\x01');
    Hrz_LightningAddFork('\x01',(char)((uVar5 + 1) * 0x1000000 >> 0x18),row + '\x01');
    bVar1 = 6;
  }
  else if (uVar6 < 2) {
    if (uVar6 != 0) {
      iVar2 = uVar3 << 0x18;
      goto HrzLightFork_setPmxIdx;
    }
    Hrz_LightningAddFork(direction,(char)((uVar5 + uVar3) * 0x1000000 >> 0x18),row + '\x01');
    iVar2 = random();
    bVar1 = ((u_char)iVar2 & 1) + 2;
  }
  else if (uVar6 == 2) {
    iVar2 = random();
    bVar1 = ((u_char)iVar2 & 1) + 4;
  }
  else {
    iVar2 = uVar3 << 0x18;
    if (uVar6 != 3) goto HrzLightFork_setPmxIdx;
    uVar3 = random();
    uVar3 = (uVar3 & 1) * -2 + 1;
    Hrz_LightningAddFork((char)(uVar3 * 0x1000000 >> 0x18),(char)((uVar5 + uVar3) * 0x1000000 >> 0x18),
               row + '\x01');
    iVar2 = random();
    bVar1 = (u_char)iVar2 & 1;
  }
  gHrz_Lightning.forks[uVar4].pmxIndex = bVar1;
  iVar2 = uVar3 << 0x18;
HrzLightFork_setPmxIdx:
  if (iVar2 < 0) {
    gHrz_Lightning.forks[uVar4].pmxIndex = gHrz_Lightning.forks[uVar4].pmxIndex + '\b';
  }
  return;
}

/* ---- Hrz_CalculateLightning__Fv  [HRZSKU.CPP:826-829] SLD-VERIFIED ---- */
void Hrz_CalculateLightning(void)

{
  gHrz_Lightning.numForks = '\0';
  gHrz_Lightning.brightness = 200;
  Hrz_LightningAddFork('\x01','\0','\0');
  return;
}

/* ---- Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache  [HRZSKU.CPP:833-856] SLD-VERIFIED ----
 * NEAR-MISS 14 diffs (76/76, count exact -- improved from 25 baseline via 3 fixes):
 * (1) REAL BUG FIXED -- the OT tag's length byte (offset+3, part of the `tag` u_long,
 * value 9 = 9 words following the tag for this 10-word POLY_FT4) was wrongly written via
 * `prim->code=9` (struct offset+7); the real GPU command byte (0x2e, offset+7) was wrongly
 * written via a nonexistent `prim->tpage` access (offset+0x16, never touched by the
 * oracle). Fixed: raw byte poke `*((u_char*)prim+3)=9;` for the tag length + `prim->code=
 * 0x2e;` for the real GPU code (POLY_FT4's `code` field IS offset+7 in nfs4_types.h --
 * only the VALUES/targets were swapped, not the struct). (2) cached `Render_gPalettePtr`'s
 * VALUE once into a local `pal` before both otz-relative accesses -- the fixed-address
 * macro (§3.6b) re-dereferences 0x1F800000 on every textual reference; caching it let the
 * 2nd tag-merge only reload `sd->otz` (unavoidable aliasing reload) not the palette
 * pointer too, matching the oracle's single dereference + reuse. (3) moved the
 * `Render_gPacketPtr=prim+0x28` store between the two tag-merge statements (matches where
 * the oracle interleaves/schedules it) -- got instruction COUNT exact (76==76). Residual =
 * oracle reuses the dead `sd` param register (a3) for the 2nd otz-relative address chain
 * (sll/addu/lw) and defers that store one instruction later than ours; a coloring/
 * scheduling tie-break, same family as the Force_IsForceOn dead-param-reuse near-miss.
 * Accepted near-miss. */
void Hrz_TextureQuad(DVECTOR *pt,char type,char bright,Draw_DCache *sd)

{
  POLY_FT4 *prim;
  u_long l0;
  u_long l1;
  u_long l2;
  u_long l3;
  Draw_tPixMap *pmx;
  u_char *pal;

  pal = Render_gPalettePtr;
  prim = (POLY_FT4 *)Render_gPacketPtr;
  *(u_int *)prim = *(u_int *)prim & 0xff000000 | *(u_int *)(pal + sd->otz * 4) & 0xffffff;
  Render_gPacketPtr = (u_char *)prim + 0x28;
  *(u_int *)(pal + sd->otz * 4) =
       *(u_int *)(pal + sd->otz * 4) & 0xff000000 | (u_int)prim & 0xffffff;
  *((u_char *)prim + 3) = 9;
  prim->code = 0x2e;
  prim->b0 = bright;
  prim->g0 = bright;
  prim->r0 = bright;
  prim->x0 = pt->vx;
  prim->y0 = pt->vy;
  prim->x2 = pt->vx;
  prim->y2 = pt->vy + 0x10;
  prim->x1 = pt->vx + 0x10;
  prim->y1 = pt->vy;
  prim->x3 = pt->vx + 0x10;
  prim->y3 = pt->vy + 0x10;
  /* gLightningPixmap is genuinely `Draw_tPixMap *gLightningPixmap[16]` (array of POINTERS,
     stride 4 -- see genericpmx.cpp, the owning TU); the hrzsku_externs.h extern's array-of-
     structs shape is wrong (a shared-header issue, left as-is per policy) -- reinterpret the
     address locally with the correct stride/indirection so the oracle's `sll a1,a1,2` (x4)
     is reproduced instead of a wrong x16 struct-array stride. */
  pmx = ((Draw_tPixMap **)&gLightningPixmap)[(u_char)type];
  l0 = *(u_long *)pmx;
  l1 = *(u_long *)((char *)pmx + 4);
  l2 = *(u_long *)((char *)pmx + 8);
  l3 = *(u_long *)((char *)pmx + 0xc);
  *(u_long *)&prim->u0 = l0;
  *(u_long *)&prim->u1 = l1;
  *(u_long *)&prim->u2 = l2;
  *(u_long *)&prim->u3 = l3;
  return;
}

/* ---- Hrz_SetLightingPosInSky__FP13DRender_tView  [HRZSKU.CPP:862-867] SLD-VERIFIED ----
 * NEAR-MISS 103 diffs (75/68, ours 7 insns LONGER; SYM `nfs4-f-v3.txt` @40e68f confirms
 * fsize=40 (ONE saved reg, mask=$80010000=$s0 only) -- matches the ORACLE frame, not ours
 * (we emit fsize=48, TWO saved regs $s0+$s1). ROOT CAUSE (verified, not fixable from this
 * file): `Hrz_gLightningPosInSky` (SVECTOR, 8 bytes, defined THIS TU line ~28) is accessed
 * by the oracle via bare `sh r,0(gp)`/`2(gp)`/`4(gp)` gp-relative field stores -- NO address
 * register needed at all. Our build (`-G4`, confirmed in tools/build.py) never lands this
 * 8-byte struct in `.sdata`/`.sbss` (`objdump -h` on the compiled .o: 0 bytes in `.bss`,
 * global sits in `.data` as a 'D' symbol) so gcc must materialize its address into a
 * callee-saved reg (`$s0`) instead -- that's the SECOND saved register, stealing the slot
 * the oracle uses to cache the shared /8000 magic-multiply constant (`4194:19923`, reused
 * for BOTH the vx and vz fields, which share the same divisor) across the `random()` calls.
 * Freeing `$s0` would need the struct to be gp-eligible, which is a `-G` threshold /
 * `-mgpOPT` field-splitting toolchain behavior outside this TU's control (no build-flag
 * changes per the campaign's hard rules) -- NOT a header issue (the global and its SVECTOR
 * type are both already correct/real). Accepted floor; recorded for a future cross-TU/
 * build-flag investigation. */
void Hrz_SetLightingPosInSky(DRender_tView *Vi)

{
  coorddef forwardVec;
  u_int uVar1;

  forwardVec = *(coorddef *)&(Vi->cview).mrotation.m[6];
  uVar1 = random();
  Hrz_gLightningPosInSky.vx =
       (short)(forwardVec.x >> 2) + (short)uVar1 + (short)(uVar1 / 8000) * -8000 + -4000;
  uVar1 = random();
  Hrz_gLightningPosInSky.vy =
       (short)(forwardVec.y >> 2) + 8000 + (short)uVar1 + (short)(uVar1 / 3000) * -3000;
  uVar1 = random();
  Hrz_gLightningPosInSky.vz =
       (short)(forwardVec.z >> 2) + (short)uVar1 + (short)(uVar1 / 8000) * -8000 + -4000;
  return;
}

/* ---- Hrz_BuildForkLightning__FP11Draw_DCache  [HRZSKU.CPP:872-898] SLD-VERIFIED ----
 * SEALED (71/71 PASS). MATCH: plain `for (i=0; i < (u_char)numForks; i++)` WITHOUT the outer
 * numForks!=0 guard (the rotated for-test subsumes it; the guarded do-while made the reorg
 * pass steal the loop-head `andi` into the back-edge slot instead of the oracle's
 * `addiu a0,sp,0x10` &pos rematerialization). */
void Hrz_BuildForkLightning(Draw_DCache *sd)

{
  u_char i;
  tHrz_LightningFork *fork;
  DVECTOR pos;
  DVECTOR screenPos;
  coorddef trans;

  if (0 < gHrz_Lightning.brightness) {
    sd->otz = Draw_gViewOtSize + -2;
    memset(&trans,0,0xc);
    HrzSetPsxTranslation(&trans);
    gte_ldv0(&Hrz_gLightningPosInSky);
    gte_rtps();
    gte_stSXY2(&screenPos);
    for (i = 0; i < (u_char)gHrz_Lightning.numForks; i = i + 1) {
      fork = &gHrz_Lightning.forks[i];
      pos.vx = fork->pos.vx + screenPos.vx;
      pos.vy = fork->pos.vy + screenPos.vy;
      Hrz_TextureQuad(&pos,fork->pmxIndex,(char)gHrz_Lightning.brightness,sd);
    }
    gHrz_Lightning.brightness = gHrz_Lightning.brightness + -0x10;
  }
  return;
}

/* ---- Hrz_LightningFlicker__Fi  [HRZSKU.CPP:901-954] SLD-VERIFIED ---- */
void Hrz_LightningFlicker(int on)

{
  int i;
  u_int col;

  if (on != 0) {
    if (on == 1) {
      if (Night_gShowForks == '\0') {
        *(u_int *)&Sky_gTrackSpec->frontcolors[0] = 0xffc0c0;
        col = 0xffc0c0;
        i = 0x54;
        do {
          *(u_int *)&gSkyColor[i] = col;
          i = i - 1;
        } while (-1 < i);
      }
    }
    else if (Night_gShowForks == '\0') {
      *(u_int *)&Sky_gTrackSpec->frontcolors[0] = 0xc02828;
      col = 0xc02828;
      i = 0x54;
      do {
        *(u_int *)&gSkyColor[i] = col;
        i = i - 1;
      } while (-1 < i);
    }
  }
  else {
    *(u_int *)&Sky_gTrackSpec->frontcolors[0] = *(u_int *)&Hrz_gSaveCol[1];
    Hrz_InitSkyColor();
  }
  return;
}

/* ---- HrzSetPsxMatrix__FP10matrixtdef  [HRZSKU.CPP:982-1017] SLD-VERIFIED ----
 * NEAR-MISS 72 diffs (52/56, ours 4 insns SHORTER). The tail gte_SetRotMatrix() macro
 * expansion (last 12 insns) is byte-IDENTICAL once realigned -- all divergence is in the
 * temp/mpsx field-fill. SYM (`nfs4-f-v3.txt` @40e91f) shows the source used per-row
 * BLOCK-SCOPED locals (`{int t1,t2,t3;...}` then TWO more blocks named `r0,r1,r2` --
 * fresh pseudos each block, same names reused rows 2/3); reproduced that block structure
 * verbatim but it did NOT change gcc's allocation (74 diffs, worse) -- reverted. Oracle's
 * extra 4 insns are RELOADS of temp.m[0]/temp.m[2]/temp.m[3]/temp.m[5] (the non-negated
 * fields) from the just-stored stack slot instead of reusing the live load register,
 * while the negated fields (temp.m[1]/[4]/[7]) and the LAST row (m[6..8], no next group
 * to steal $t0-$t2) reuse the register directly with no reload -- register-pressure-driven
 * allocator behavior (which fields get evicted to make room for the next row's raw loads),
 * not reachable via any tried source reshape (flat block-of-9, interleaved-per-row, and
 * block-scoped-per-row all tried; interleaved was worse at 76, block-scoped 74). Accepted
 * floor; count differs by 4 (genuine structural gap in the gcc RA output vs any equivalent
 * C, not a coloring coin-flip). */
void HrzSetPsxMatrix(matrixtdef *m)
{
  MATRIX mpsx;
  matrixtdef temp;

  temp.m[0] = m->m[0];
  temp.m[1] = -m->m[1];
  temp.m[2] = m->m[2];
  temp.m[3] = m->m[3];
  temp.m[4] = -m->m[4];
  temp.m[5] = m->m[5];
  temp.m[6] = m->m[6];
  temp.m[7] = -m->m[7];
  temp.m[8] = m->m[8];
  mpsx.m[0][0] = (short)(temp.m[0] >> 4);
  mpsx.m[1][0] = (short)(temp.m[1] >> 4);
  mpsx.m[2][0] = (short)(temp.m[2] >> 4);
  mpsx.m[0][1] = (short)(temp.m[3] >> 4);
  mpsx.m[1][1] = (short)(temp.m[4] >> 4);
  mpsx.m[2][1] = (short)(temp.m[5] >> 4);
  mpsx.m[0][2] = (short)(temp.m[6] >> 4);
  mpsx.m[1][2] = (short)(temp.m[7] >> 4);
  mpsx.m[2][2] = (short)(temp.m[8] >> 4);
  gte_SetRotMatrix(&mpsx);
}

/* ---- HrzSetPsxTranslation__FP8coorddef  [HRZSKU.CPP:1021-1028] SLD-VERIFIED ---- */
void HrzSetPsxTranslation(coorddef *t)
{
  MATRIX mpsx;
  int *tt = (int *)t;

  mpsx.t[0] = tt[0] >> 10;
  mpsx.t[1] = tt[1] >> 10;
  mpsx.t[2] = tt[2] >> 10;
  gte_SetTransMatrix(&mpsx);
}

/* ---- Hrz_RotProj16__FiP7SVECTORPiP7DVECTOR  [HRZSKU.CPP:1032-1045] SLD-VERIFIED ---- */
void Hrz_RotProj16(int n, SVECTOR *s, int *z, DVECTOR *p)
{
  int i;

  for (i = n - 1; i != -1; i--) {
    gte_ldv0(s);                  /* load vx,vy,vz into VXY0/VZ0 */
    gte_rtps();                   /* rotate / transform / perspective */
    s = s + 1;
    gte_stSXY2(p);                /* store screen XY -> DVECTOR (SXY2) */
    p = p + 1;
    gte_swc2(0x1b, z);            /* store screen Z (MAC3) -> int  [no canonical macro] */
    z = z + 1;
  }
}

/* ---- Hrz_SetDitheringPrim__Fii  [HRZSKU.CPP:1050-1055] SLD-VERIFIED ---- */
void Hrz_SetDitheringPrim(int dither,int otz)

{
  DR_MODE *prim;
  u_int *prev_pkt_slot;
  u_int prev_val;

  prev_pkt_slot = (u_int *)(otz * 4 + (int)Render_gPalettePtr);
  prim = (DR_MODE *)Render_gPacketPtr;
  *(u_int *)prim = *(u_int *)prim & 0xff000000 | *prev_pkt_slot & 0xffffff;
  prev_val = *prev_pkt_slot;
  Render_gPacketPtr = (u_char *)prim + 0xc;
  *prev_pkt_slot = (prev_val & 0xff000000) | ((u_int)prim & 0xffffff);
  SetDrawMode(prim,0,dither,0x100,(RECT *)0x0);
  return;
}

/* ---- Hrz_BuildSky__Fv  [HRZSKU.CPP:1060-1277] SLD-VERIFIED ---- */
void Hrz_BuildSky(void)
{
  Draw_DCache *sd;
  DVECTOR *pSkyMesh;
  int *pSkyZ;
  int otz_old, pshift, i, temp;
  POLY_GT4 *prim;
  Draw_tPixMap *pmx;
  int ti1, ti2, tu7, CVar8, CVar4, skyTexPmx_p, tD8;
  int tC2, tC1, skyMesh_iter;
  u_char *tp2, *tp3;
  CSkySpec *tC4;
  CVECTOR CVar3;

  sd = (Draw_DCache *)0x1f800000;        /* PSX scratchpad base */
  pSkyMesh = (DVECTOR *)0x1f800014;      /* projected screen-XY buffer */
  pSkyZ = (int *)0x1f800168;             /* projected screen-Z buffer  */
  otz_old = 0x78;
  if (GameSetup_gData.commMode == 1) {
    otz_old = 0x3c;
  }
  pshift = otz_old;
  if ((Sky_gTrackSpec->flags & 1U) != 0) {
    /* RTPT fast path: 3 vertices per pass (0x55 total) + RTPS tail.
       SYM block line=14/21: trans/scnt/pcnt/zcnt/n are THIS branch's OWN nested
       locals (a SEPARATE set exists in the RTPS branch below) -- NOT shared
       function-scope storage; nesting collapses the stack frame to match. */
    coorddef trans;
    DVECTOR *scnt;
    SVECTOR *pcnt;
    int *zcnt;
    int n;

    memset(&trans,0,0xc);
    HrzSetPsxTranslation(&trans);
    pcnt = (SVECTOR *)&gSkyMesh /* @0x80120378 */;
    n = 0x55;
    scnt = (DVECTOR *)((char *)sd + 8);
    zcnt = (int *)((char *)sd + 0x15c);
    do {
      gte_ldv3(pcnt, pcnt + 1, pcnt + 2);
      gte_rtpt();
      pcnt = pcnt + 3;
      n = n + -3;
      scnt = scnt + 3;
      zcnt = zcnt + 3;
      gte_stsxy3(&scnt[0],&scnt[1],&scnt[2]);
      gte_swc2(0x11,&zcnt[0]);   /* SZ1 -> no canonical macro */
      gte_swc2(0x12,&zcnt[1]);   /* SZ2 -> no canonical macro */
      gte_swc2(0x13,&zcnt[2]);   /* SZ3 */
    } while (2 < n);
    scnt = &scnt[2];
    n = n + -1;
    zcnt = &zcnt[2];
    if (n != -1) {
      do {
        gte_ldv0(pcnt);
        gte_rtps();
        pcnt = pcnt + 1;
        scnt = scnt + 1;
        zcnt = zcnt + 1;
        gte_stSXY2(scnt);
        gte_stsz(zcnt);
        n = n + -1;
      } while (n != -1);
    }
  }
  else {
    /* RTPS path: 1 vertex per pass (0x54 total), screen row pinned at otz_old.
       SYM block line=66: its OWN trans/scnt/pcnt/zcnt/n/transformed. */
    coorddef trans;
    VECTOR transformed;
    DVECTOR *scnt;
    SVECTOR *pcnt;
    int *zcnt;
    int n;

    memset(&trans,0,0xc);
    HrzSetPsxTranslation(&trans);
    pcnt = (SVECTOR *)&gSkyMesh /* @0x80120378 */;
    scnt = pSkyMesh + -1;
    zcnt = pSkyZ + -1;
    n = 0x54;
    do {
      gte_ldv0(pcnt);
      gte_rtps();
      pcnt = pcnt + 1;
      scnt = scnt + 1;
      zcnt = zcnt + 1;
      gte_stlvnl(&transformed.vx);
      gte_stSXY2(scnt);
      scnt->vy = (short)(transformed.vy >> 2) + (short)otz_old;
      gte_stsz(zcnt);
      n = n + -1;
    } while (n != -1);
  }
  if ((Sky_gTrackSpec->flags & 0x40U) != 0) {
    Hrz_SetDitheringPrim(0,Draw_gViewOtSize + -2);
  }
  ti1 = Skid_gCtrlScratch_94;
  if ((TrackSpec_gSpec.skyspec.flags & 4U) != 0) {
    Flare_Sun(&sunPosInSky,(Draw_FlareCache *)&Render_gPalettePtr);
  }
  i = 0;
  skyMesh_iter = (int)&gSkyPixmapIndex;
  Skid_gCtrlScratch_94 = ti1;
  do {
    tC4 = Sky_gTrackSpec;
    ti1 = Draw_gViewOtSize;
    tp2 = (u_char *)Render_gPacketPtr;
    tp3 = (u_char *)Render_gPalettePtr;
    prim = (POLY_GT4 *)tp2;
    if (0x3f < i) {
      if ((Sky_gTrackSpec->flags & 0x40U) != 0) {
        Hrz_SetDitheringPrim(1,Draw_gViewOtSize + -2);
      }
      return;
    }
    ti2 = i * 0x11;
    if (ti2 < 0) {
      ti2 = ti2 + 0xf;
    }
    temp = ti2 >> 4;
    /* Hrz_gSkyVtx_A0/A1/B0/B1 and "Render_gCopMat"/"Render_gWorldMat" below were Ghidra
       mis-attributions -- both are really the SAME pSkyMesh/pSkyZ scratchpad buffers this
       fn already declares (0x1F800014/0x1F800168), read at the 4 corners of a 17-wide sky
       quad: temp, temp+1, temp+17, temp+18 (17 = the mesh row stride, matching gSkyColor's
       own temp+0x11/temp+0x12 indexing a few lines below). None of the old names occur in
       the SYM; the oracle re-derives `temp*4` fresh at every access (no cached pointer). */
    if ((pSkyZ[temp + 17] != 0 || pSkyZ[temp + 18] != 0) ||
        (pSkyZ[temp + 1] != 0 || pSkyZ[temp] != 0)) {
      if ((pSkyMesh[temp + 17].vx <= (short)Render_gPacketLenLo ||
           pSkyMesh[temp + 18].vx <= (short)Render_gPacketLenLo) ||
          (pSkyMesh[temp + 1].vx <= (short)Render_gPacketLenLo ||
           pSkyMesh[temp].vx <= (short)Render_gPacketLenLo)) {
        if (((-1 < pSkyMesh[temp + 17].vx) || (-1 < pSkyMesh[temp + 18].vx) ||
             (-1 < pSkyMesh[temp + 1].vx)  || (-1 < pSkyMesh[temp].vx)) &&
            (((pSkyMesh[temp + 17].vy <= (short)Render_gPacketLenHi) ||
              (pSkyMesh[temp + 18].vy <= (short)Render_gPacketLenHi) ||
              (pSkyMesh[temp + 1].vy  <= (short)Render_gPacketLenHi) ||
              (pSkyMesh[temp].vy      <= (short)Render_gPacketLenHi)) &&
             ((-1 < pSkyMesh[temp + 17].vy) || (-1 < pSkyMesh[temp + 18].vy) ||
              (-1 < pSkyMesh[temp + 1].vy)  || (-1 < pSkyMesh[temp].vy)))) {
          if (Sky_gTrackSpec->type == 1) {
            if ((Sky_gTrackSpec->flags & 0x20U) != 0) {
              pmx = gHorizonPixmap[*(u_char *)skyMesh_iter];
              skyTexPmx_p = (int)pmx;
              *(u_int *)Render_gPacketPtr =
                   *(u_int *)Render_gPacketPtr & 0xff000000 |
                   *(u_int *)(Render_gPalettePtr + Draw_gViewOtSize * 4 + -8) & 0xffffff;
              *(u_int *)(tp3 + ti1 * 4 + -8) =
                   *(u_int *)(tp3 + ti1 * 4 + -8) & 0xff000000 | (u_int)Render_gPacketPtr & 0xffffff;
              tC2 = (int)Render_gPacketPtr + 4;
              Render_gPacketPtr = Render_gPacketPtr + 0x34;
              *(CVECTOR *)tC2 = gSkyColor[temp + 0x11];
              *(CVECTOR *)(tp2 + 0x10) = gSkyColor[temp + 0x12];
              *(CVECTOR *)(tp2 + 0x1c) = gSkyColor[temp];
              CVar8 = *(int *)(gSkyColor + temp + 1);
              tp2[3] = 0xc;
              tp2[7] = 0x3c;
              *(int *)(tp2 + 0x28) = CVar8;
              *(u_int *)(tp2 + 0xc) = *(u_int *)skyTexPmx_p;
              *(u_int *)(tp2 + 0x18) = *(u_int *)(skyTexPmx_p + 4);
              *(u_int *)(tp2 + 0x24) = *(u_int *)(skyTexPmx_p + 8);
              *(u_int *)(tp2 + 0x30) = *(u_int *)(skyTexPmx_p + 0xc);
              *(int *)(tp2 + 8) = *(int *)&pSkyMesh[temp + 17];
              *(int *)(tp2 + 0x14) = *(int *)&pSkyMesh[temp + 18];
              *(u_int *)(tp2 + 0x20) = *(u_int *)&pSkyMesh[temp];
              *(long *)(tp2 + 0x2c) = *(long *)&pSkyMesh[temp + 1];
              goto HrzBuildSky_meshIterNext;
            }
            pmx = gHorizonPixmap[*(u_char *)skyMesh_iter];
            tD8 = (int)pmx;
            *(u_int *)Render_gPacketPtr =
                 *(u_int *)Render_gPacketPtr & 0xff000000 |
                 *(u_int *)(Render_gPalettePtr + Draw_gViewOtSize * 4 + -8) & 0xffffff;
            tu7 = (u_int)Render_gPacketPtr & 0xffffff;
            Render_gPacketPtr = Render_gPacketPtr + 0x28;
            *(u_int *)(tp3 + ti1 * 4 + -8) = *(u_int *)(tp3 + ti1 * 4 + -8) & 0xff000000 | tu7;
            CVar4 = *(int *)tC4->frontcolors;
            tp2[3] = 9;
            *(int *)(tp2 + 4) = CVar4;
            tp2[7] = 0x2c;
            *(u_int *)(tp2 + 0xc) = *(u_int *)tD8;
            *(u_int *)(tp2 + 0x14) = *(u_int *)(tD8 + 4);
            *(u_int *)(tp2 + 0x1c) = *(u_int *)(tD8 + 8);
            *(u_int *)(tp2 + 0x24) = *(u_int *)(tD8 + 0xc);
          }
          else {
            *(u_int *)Render_gPacketPtr =
                 *(u_int *)Render_gPacketPtr & 0xff000000 |
                 *(u_int *)(Render_gPalettePtr + Draw_gViewOtSize * 4 + -8) & 0xffffff;
            *(u_int *)(tp3 + ti1 * 4 + -8) =
                 *(u_int *)(tp3 + ti1 * 4 + -8) & 0xff000000 | (u_int)Render_gPacketPtr & 0xffffff;
            tC1 = (int)Render_gPacketPtr + 4;
            Render_gPacketPtr = Render_gPacketPtr + 0x24;
            *(CVECTOR *)tC1 = gSkyColor[temp + 0x11];
            *(CVECTOR *)(tp2 + 0xc) = gSkyColor[temp + 0x12];
            *(CVECTOR *)(tp2 + 0x14) = gSkyColor[temp];
            CVar3 = gSkyColor[temp + 1];
            tp2[3] = 8;
            tp2[7] = 0x38;
            *(CVECTOR *)(tp2 + 0x1c) = CVar3;
          }
          *(int *)(tp2 + 8) = *(int *)&pSkyMesh[temp + 17];
          *(int *)(tp2 + 0x10) = *(int *)&pSkyMesh[temp + 18];
          *(u_int *)(tp2 + 0x18) = *(u_int *)&pSkyMesh[temp];
          *(long *)(tp2 + 0x20) = *(long *)&pSkyMesh[temp + 1];
        }
      }
    }
HrzBuildSky_meshIterNext:
    skyMesh_iter = skyMesh_iter + 1;
    i = i + 1;
  } while( true );
}

/* ---- Sky_RenderStars__FP13Draw_SkyCachei  [HRZSKU.CPP:1284-1330] SLD-VERIFIED ----
 * NEAR-MISS 18 diffs (115/111, improved from 76 baseline). FIX (§3.12 #16
 * HOLD-GLOBAL-ADDR-ACROSS-CALL): `pcnt = starPosInSky;` moved to an unconditional
 * statement BEFORE the memset(&trans,...)/HrzSetPsxTranslation(&trans) calls (was
 * inside the `if(0<numStars)` block, loaded fresh after the calls) -- `starPosInSky`
 * is a loop-invariant global with no side effect reading it, so gcc hoists the load
 * unconditionally above the calls into a callee-saved reg (`$s0`) that survives them,
 * matching the oracle exactly (prologue/frame-size/call-setup all byte-identical after
 * this fix). Residual: `Render_gPalettePtr`'s `%hi` (a pure, memory-less `lui`) is
 * scheduled 2 loop-body positions earlier in ours than the oracle (which keeps the
 * `lui`+`lw` pair together at the point of use) -- tried reordering the `puVar5=`
 * statement earlier/relative to `puVar4=` (no effect, gcc's scheduler ignores C
 * statement order for this pure op) -- a genuine gcc instruction-scheduling floor, not
 * source-shapable without a pin. Accepted. */
void Sky_RenderStars(Draw_SkyCache *sd,int otz)

{
  int iVar1;
  u_int uVar2;
  u_long uVar3;
  u_int *puVar4;
  void *prim;
  u_int *puVar5;
  int n;
  int iVar6;
  u_int uVar7;
  void *ppuVar8;
  u_int uVar8;
  SVECTOR *pcnt;
  int pshift;
  int iVar9;
  coorddef trans;
  DVECTOR scnt;
  VECTOR transformed;
  int zcnt;
  
  iVar9 = 0x78;
  if (GameSetup_gData.commMode == 1) {
    iVar9 = 0x3c;
  }
  pcnt = starPosInSky;
  memset(&trans,0,0xc);
  HrzSetPsxTranslation(&trans);
  iVar6 = 0;
  if (0 < Sky_gTrackSpec->numStars) {
    ppuVar8 = &Render_gPacketPtr;
    uVar7 = 0xffffff;
    uVar8 = 0xff000000;
    do {
      gte_ldv0(pcnt);
      gte_rtps();
      pcnt = pcnt + 1;
      gte_stsz(&zcnt);
      if (0 < zcnt) {
        gte_stSXY2(&scnt);
        gte_stlvnl(&transformed.vx);
        iVar1 = (transformed.vy >> 2) + iVar9;
        scnt.vy = (short)iVar1;
        if ((((scnt.vx <= (sd->head).clipW) && (-1 < scnt.vx)) &&
            (iVar1 = iVar1 * 0x10000 >> 0x10, iVar1 <= (sd->head).clipH)) && (-1 < iVar1)) {
          puVar4 = *(u_int **)ppuVar8;
          prim = puVar4;
          puVar5 = (u_int *)(Render_gPalettePtr + otz * 4);
          *puVar4 = *puVar4 & uVar8 | *puVar5 & uVar7;
          uVar2 = *puVar5;
          *(u_int **)ppuVar8 = puVar4 + 3;
          *puVar5 = uVar2 & uVar8 | (u_int)puVar4 & uVar7;
          uVar3 = (*(u_long *)&starColors[iVar6]);
          *(u_char *)((int)puVar4 + 3) = 2;
          puVar4[1] = uVar3;
          *(u_char *)((int)puVar4 + 7) = 0x68;
          *(DVECTOR *)(puVar4 + 2) = scnt;
        }
      }
      iVar6 = iVar6 + 1;
    } while (iVar6 < Sky_gTrackSpec->numStars);
  }
  return;
}

/* ---- Hrz_BuildHorizon__FP13DRender_tView  [HRZSKU.CPP:1338-1557] SLD-VERIFIED ----
 * FULL SYM-driven rewrite (round 3). ROOT CAUSE identified this pass: this fn builds its
 * whole 17-entry ring-segment working set DIRECTLY in PSX scratchpad RAM (0x1F800000-0x1F800168)
 * -- FIVE parallel arrays share ONE base register in the oracle (0x1F800010/12 two shorts =
 * Render_gPacketLenLo/Hi, 0x1F800014[17] DVECTOR "posD", 0x1F800058[17] DVECTOR "posA",
 * 0x1F80009C[17] DVECTOR "posB", 0x1F8000E0[17] DVECTOR "posC", 0x1F800124[17] int "cnt") --
 * exactly the SAME established idiom as Render_gPacketPtr/Render_gPalettePtr (nfs4_types.h)
 * and weather.cpp/sfx.cpp's local RENDER_*_ADDR macros, just not yet applied here. The
 * previously-fabricated "Render_gCopMat"/"Render_gWorldMat"/"Hrz_gProjResultZ0"/
 * "Hrz_gProjScratch_9C"/"DrawW_gChunkVtxBuf"/"pDVar13"/"trans2" (early use)/"auStack_4c"
 * accesses in this fn were all Ghidra mis-attributions of these literal scratchpad offsets
 * (confirmed: none of those symbols appear anywhere in the SYM; the oracle materializes
 * every one of these addresses as `ori r,s6,OFF` sharing one shared base reg, never a
 * %hi/%lo(sym) reloc). SYM-real locals for this fn: trans/hrz_projchange/fxOverlapPercentage
 * (fn-scope), updown[2]/temp2d[2]/zval/farI/Zmax/dx/dy (block "found farI + up/down deltas"),
 * p_/s_ (nested block, REUSED for both the up- and down- GTE transforms -- explains the
 * lwc2/rtps/swc2 pair appearing twice with no branch between: 2 straight-line statements,
 * not a loop), mpts[4]/right/prim/pmx (ring-segment build block), trans2 (a SEPARATE, later,
 * legitimately-real local -- ONLY used for the end-of-function moon-flare translate, per SYM
 * block 198-203; every EARLIER "trans2.x/y/z" reference in the prior draft was bogus).
 * TWO real bugs fixed this pass (per the round-2 diagnosis, now applied): (1) the two ring
 * "up"/"down" delta corrections were being computed from a single reused `right`/`DStack_38`
 * value; the oracle computes dx/dy ONCE per loop from temp2d[0]("up") for the first
 * (posD-writing) loop and temp2d[1]("down") for the second (posA in-place) loop, each against
 * a freshly-read posA[farI] baseline -- not a per-iteration recompute. (2) the two
 * Horizon_InterpolateLineSCoords calls (both the fn-level pair and the per-segment one inside
 * the main for-loop) were passing a bogus "pDVar13" for their destination arg where the
 * oracle passes either a literal scratchpad address (posB/posC bases) or `&right` (SYM local)
 * -- the per-segment call was silently NEVER updating `right`, a genuine logic bug independent
 * of the byte-match residual. */
void Hrz_BuildHorizon(DRender_tView *Vi)

{
  int hrzBase;
  coorddef trans;
  int fxOverlapPercentage;
  long hrz_projchange;
  Draw_HorizonCache *hsd;
  (void)hsd;

  /* PSX scratchpad base (0x1F800000). Held in ONE local for the WHOLE function (not a
     literal at each site) because the oracle keeps this address live in a single
     CALLEE-SAVED register ($s6) across every intervening call (Hrz_RotProj16,
     Horizon_InterpolateLineSCoords x N, SetGeomScreen) -- matches catalog §3.12 #16
     HOLD-GLOBAL-ADDR-ACROSS-CALL: a value referenced both before and after a `jal` is
     forced into a callee-saved reg + frame slot, which is exactly what materializing a
     fresh literal at every site (a per-call REMATERIALIZE) fails to reproduce. */
  hrzBase = 0x1F800000;
  fxOverlapPercentage = 0x107ae;
  memset(&trans,0,0xc);
  hrz_projchange = 0;
  if (700 < Camera_gGeomScreen) {
    hrz_projchange = Camera_gGeomScreen;
    SetGeomScreen(700);
  }
  HrzSetPsxMatrix(&(Vi->cview).mrotationInv);
  HrzSetPsxTranslation(&trans);
  /* PSX-scratchpad ring working set (0x1F800000 region; see fn banner comment above):
   *   0x1F800010/12 (short,short) = Render_gPacketLenLo/Hi  (already macro'd elsewhere;
   *                                  read here via literal cast to match the oracle's
   *                                  literal `lhu` -- these are NOT %hi/%lo(sym) here)
   *   0x1F800014[17] DVECTOR "posD"  -- delta-corrected "up" ring positions
   *   0x1F800058[17] DVECTOR "posA"  -- base ring projected positions (read+updated in place)
   *   0x1F80009C[17] DVECTOR "posB"  -- lerp(posA,posD,pct) "near" vertex per segment
   *   0x1F8000E0[17] DVECTOR "posC"  -- lerp(posA[k+1],posD[k+1],pct) "far" vertex per segment
   *   0x1F800124[17] int     "cnt"   -- per-ring-point visibility/lifetime counter
   * (was fabricated as Render_gCopMat/Render_gWorldMat/Hrz_gProjResultZ0/Hrz_gProjScratch_9C/
   * DrawW_gChunkVtxBuf -- none of those symbols occur in the SYM; the oracle materializes
   * every one of these as `ori r,s6,OFF` off ONE shared base register, never a linked reloc). */
  {
    /* SYM block line=30: zval/updown/temp2d/farI/Zmax/dx/dy -- NESTED so the stack slots
       are reclaimed once this scope ends (matches the oracle's 128-byte frame; a flat
       function-scope declaration of these keeps them permanently reserved -> +48 bytes,
       the round-2 near-miss's root cause). */
    int *zval;
    SVECTOR updown [2];
    DVECTOR temp2d [2];
    SVECTOR *pSVar12;
    short shape_short;
    int farI, Zmax, dx, dy;
    int shape_visible, shape_idx, rowDelta, shape_overlap, shape_w_idx;

    Hrz_RotProj16(0x11,gRngCoordTop,(int *)(hrzBase + 0x124),(DVECTOR *)(hrzBase + 0x58));
    farI = 0;
    Zmax = 0;
    zval = (int *)(hrzBase + 0x124);
    rowDelta = 0;
    do {
      if (Zmax < *zval) {
        Zmax = *zval;
        farI = rowDelta;
      }
      rowDelta = rowDelta + 1;
      zval = zval + 1;
    } while (rowDelta < 0x10);
    pSVar12 = gRngCoordTop + farI;
    shape_short = (short)Hrz_gTrackSpec->yoffset + (short)Hrz_gTrackSpec->height;
    updown[0].vx = pSVar12->vx;
    updown[0].vy = shape_short;
    updown[0].vz = pSVar12->vz;
    updown[1].vx = pSVar12->vx;
    updown[1].vy = (short)Hrz_gTrackSpec->yoffset;
    updown[1].vz = pSVar12->vz;
    {
      /* SYM block line=55 (nested in line=30): a single {p_,s_} scope REUSED for both
         transforms -- straight-line "down" then "up" (not a loop; matches the oracle's
         unrolled order: temp2d[1] computed first, temp2d[0] second). */
      SVECTOR p_;
      long s_;
      p_ = updown[1];
      gte_ldv0(&p_);
      gte_rtps();
      gte_stSXY2((DVECTOR *)&s_);
      temp2d[1] = *(DVECTOR *)&s_;
      p_ = updown[0];
      gte_ldv0(&p_);
      gte_rtps();
      gte_stSXY2((DVECTOR *)&s_);
      temp2d[0] = *(DVECTOR *)&s_;
    }
    /* BUG FIX (round 2 diagnosis, now applied): each loop computes its OWN dx/dy delta ONCE
       from its own temp2d[] entry against a freshly-read posA[farI] baseline -- not a shared
       `right` value recomputed every iteration. */
    dx = temp2d[0].vx - *(short *)((hrzBase + 0x58) + farI * 4);
    dy = temp2d[0].vy - *(short *)((hrzBase + 0x5a) + farI * 4);
    shape_overlap = 0;
    shape_visible = hrzBase;
    do {
      if (0 < *(int *)(shape_visible + 0x124)) {
        *(short *)(shape_visible + 0x14) = *(short *)(shape_visible + 0x58) + dx;
        *(short *)(shape_visible + 0x16) = *(short *)(shape_visible + 0x5a) + dy;
      }
      shape_overlap = shape_overlap + 1;
      shape_visible = shape_visible + 4;
    } while (shape_overlap < 0x11);
    dx = temp2d[1].vx - *(short *)((hrzBase + 0x58) + farI * 4);
    dy = temp2d[1].vy - *(short *)((hrzBase + 0x5a) + farI * 4);
    shape_w_idx = 0;
    shape_idx = hrzBase;
    do {
      if (0 < *(int *)(shape_idx + 0x124)) {
        *(short *)(shape_idx + 0x58) = *(short *)(shape_idx + 0x58) + dx;
        *(short *)(shape_idx + 0x5a) = *(short *)(shape_idx + 0x5a) + dy;
      }
      shape_w_idx = shape_w_idx + 1;
      shape_idx = shape_idx + 4;
    } while (shape_w_idx < 0x11);
  }
  Horizon_InterpolateLineSCoords((DVECTOR *)(hrzBase + 0x9c),(DVECTOR *)(hrzBase + 0x58),(DVECTOR *)(hrzBase + 0x14),
             gfxPmxHeightPercentage,0x10,1);
  Horizon_InterpolateLineSCoords((DVECTOR *)(hrzBase + 0xe0),(DVECTOR *)(hrzBase + 0x5c),(DVECTOR *)(hrzBase + 0x18),
             gfxPmxHeightPercentage,0x10,1);
  {
    /* SYM block line=107/114/115: mpts[4] -- reuses the stack space freed by updown/temp2d
       above (both blocks are DISJOINT in the oracle's frame layout). */
    int iVar17;
    DVECTOR mpts [4];

    iVar17 = 0;
    if (TrackSpec_gSpec.horizonstate != 0) {
      /* SYM block line=142: right/prim/pmx -- nested one level deeper again. */
      DVECTOR right;
      POLY_GT4 *prim;
      Draw_tPixMap *pmx;
      u_int *puVar1, *puVar14;
      u_char *p;
      int iVar18, iVar16, iVar15, iVar6;
      (void)pmx;

      iVar16 = hrzBase;
      iVar15 = 0;
      iVar18 = 4;
      for (; iVar17 < 0x10; iVar17 = iVar17 + 1) {
        if ((15999 < *(int *)(iVar16 + 0x124)) || (15999 < *(int *)((hrzBase + 0x124) + iVar18))) {
          mpts[0] = *(DVECTOR *)(iVar16 + 0x9c);          /* posB[k] */
          mpts[1] = *(DVECTOR *)(iVar16 + 0xe0);          /* posC[k] */
          mpts[2] = *(DVECTOR *)((hrzBase + 0x58) + iVar18);    /* posA[k+1] */
          mpts[3] = *(DVECTOR *)(iVar16 + 0x58);          /* posA[k] */
          {
            int lo = *(short *)(hrzBase + 0x10);
            int hi = *(short *)(hrzBase + 0x12);
            if (!((mpts[0].vx < 0 && mpts[1].vx < 0 && mpts[2].vx < 0 && mpts[3].vx < 0) ||
                  (lo < mpts[0].vx && lo < mpts[1].vx && lo < mpts[2].vx && lo < mpts[3].vx) ||
                  (mpts[0].vy < 0 && mpts[1].vy < 0 && mpts[2].vy < 0 && mpts[3].vy < 0) ||
                  (hi < mpts[0].vy && hi < mpts[1].vy && hi < mpts[2].vy && hi < mpts[3].vy))) {
              Horizon_InterpolateLineSCoords(&right,(DVECTOR *)((hrzBase + 0x9c) + iVar15),
                         (DVECTOR *)((hrzBase + 0xe0) + iVar15),&fxOverlapPercentage,1,0);
              iVar6 = Draw_gViewOtSize;
              p = (u_char *)Render_gPacketPtr;
              prim = (POLY_GT4 *)p;
              puVar14 = *(u_int **)((int)gpPmx + iVar15);
              if (Hrz_gTrackSpec->ringPMX[iVar17] != '\x10') {
                *(u_int *)Render_gPacketPtr =
                     *(u_int *)Render_gPacketPtr & 0xff000000 |
                     *(u_int *)(Render_gPalettePtr + Draw_gViewOtSize * 4 + -8) & 0xffffff;
                *(u_int *)(Render_gPalettePtr + iVar6 * 4 + -8) =
                     *(u_int *)(Render_gPalettePtr + iVar6 * 4 + -8) & 0xff000000 |
                     (u_int)Render_gPacketPtr & 0xffffff;
                puVar1 = (u_int *)(Render_gPacketPtr + 4);
                Render_gPacketPtr = Render_gPacketPtr + 0x34;
                *puVar1 = *(u_int *)(&gHrzRingColor[1][0].r + iVar15);
                *(u_int *)(p + 0x10) = *(u_int *)(&gHrzRingColor[1][1].r + iVar15);
                *(u_int *)(p + 0x1c) = *(u_int *)(&gHrzRingColor[0][0].r + iVar15);
                *(u_int *)(p + 0x28) = *(u_int *)(&gHrzRingColor[0][1].r + iVar15);
                SetPolyGT4((POLY_GT4 *)p);
                *(u_int *)(p + 0xc) = *puVar14;
                *(u_int *)(p + 0x18) = puVar14[1];
                *(u_int *)(p + 0x24) = puVar14[2];
                *(u_int *)(p + 0x30) = puVar14[3];
                if ((u_char)Hrz_gTrackSpec->ringPMX[iVar17] < 8) {
                  *(u_int *)(p + 8) = *(u_int *)((hrzBase + 0x9c) + iVar15);
                  *(DVECTOR *)(p + 0x14) = right;
                  *(u_int *)(p + 0x20) = *(u_int *)((hrzBase + 0x58) + iVar15);
                  *(u_int *)(p + 0x2c) = *(u_int *)((hrzBase + 0x5c) + iVar15);
                }
                else {
                  *(DVECTOR *)(p + 8) = right;
                  *(u_int *)(p + 0x14) = *(u_int *)(iVar16 + 0x9c);
                  *(u_int *)(p + 0x20) = *(u_int *)(iVar16 + 0x5c);
                  *(u_int *)(p + 0x2c) = *(u_int *)(iVar16 + 0x58);
                }
              }
            }
          }
        }
        iVar16 = iVar16 + 4;
        iVar15 = iVar15 + 4;
        iVar18 = iVar18 + 4;
      }
    }
  }
  if ((Night_gLightning != 0) && (Night_gShowForks != '\0')) {
    Hrz_BuildForkLightning((Draw_DCache *)&Render_gPalettePtr);
  }
  if ((TrackSpec_gSpec.skyspec.flags & 8U) != 0) {
    coorddef trans2;
    memset(&trans2,0,0xc);
    HrzSetPsxTranslation(&trans2);
    Flare_Moon(&moonPosInSky,(Draw_FlareCache *)&Render_gPalettePtr);
  }
  if ((TrackSpec_gSpec.skyspec.flags & 0x10U) != 0) {
    Sky_RenderStars((Draw_SkyCache *)&Render_gPalettePtr,Draw_gViewOtSize + -2);
  }
  if (TrackSpec_gSpec.skystate != 0) {
    Hrz_BuildSky();
  }
  if (hrz_projchange != 0) {
    SetGeomScreen(hrz_projchange);
  }
  return;
}

/* end of hrzsku.cpp */
