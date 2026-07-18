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
/* PER-FIELD SPLIT (wave-13, catalog per-element gp-rel lever): the oracle stores each
   16-bit field of these three 8-byte SVECTORs via its OWN %gp_rel sub-symbol
   (D_8013D894/96/98, D_8013DDF0/F2/F4, D_8013DDF8/FA/FC) -- an 8-byte struct under OUR
   -G4 can never be gp-addressed (the old "genuine -G4 floor"), but four 2-byte SHORT
   scalars each qualify individually, reproducing every `sh r,%gp_rel(...)($gp)` store;
   address-takes (&sun/&moon/&lightning as SVECTOR*) still emit la %hi/%lo of the _vx
   symbol exactly like the oracle's lui/addiu. DUALITY HAZARD (documented): the SVECTOR*
   casts assume vx/vy/vz/pad stay contiguous+ordered in .sbss (true for gcc emission order;
   original was a real SVECTOR under a bigger per-obj -G). Only this TU references them. */
short Hrz_gLightningPosInSky_vx, Hrz_gLightningPosInSky_vy, Hrz_gLightningPosInSky_vz, Hrz_gLightningPosInSky_pad;   /* @0x8013d894 */
static short sunPosInSky_vx, sunPosInSky_vy, sunPosInSky_vz, sunPosInSky_pad;    /* @0x8013ddf0 SYM: STAT SVECTOR */
static short moonPosInSky_vx, moonPosInSky_vy, moonPosInSky_vz, moonPosInSky_pad; /* @0x8013ddf8 SYM: STAT SVECTOR */
/* struct-typed views over the split fields: keeps the 1-insn %gp_rel stores AND restores
   MEM_IN_STRUCT_P on each store (a scalar-symbol store is considered no-alias vs any
   pointer deref by gcc-2.8, letting the next statement's gts->angle loads hoist ABOVE the
   store -- the oracle's struct-field stores block that hoist). Offset-0 puns only (an
   offset pun kills the bare-symbol gp macro). */
#define SUNPOS  ((SVECTOR *)&sunPosInSky_vx)
#define MOONPOS ((SVECTOR *)&moonPosInSky_vx)
#define SUNPOS_VX  (((SVECTOR *)&sunPosInSky_vx)->vx)
#define SUNPOS_VY  (((SVECTOR *)&sunPosInSky_vy)->vx)
#define SUNPOS_VZ  (((SVECTOR *)&sunPosInSky_vz)->vx)
#define MOONPOS_VX (((SVECTOR *)&moonPosInSky_vx)->vx)
#define MOONPOS_VY (((SVECTOR *)&moonPosInSky_vy)->vx)
#define MOONPOS_VZ (((SVECTOR *)&moonPosInSky_vz)->vx)
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
 * SEALED 87/87 PASS (wave-13; was a 102-diff "accepted floor"). FOUR stacked levers, all
 * SYM/oracle-driven (SYM @40def9: i=$7, j=$3, k=$6 fn-scope + rounddiff AUTO; cur_bk/cur_fr
 * in a NESTED block line=5; l=$4 in its OWN innermost block line=17):
 * (1) BOTH loops are exit-in-the-middle `while(true){ if(!(cond)) break; ... }` (catalog
 * B): keeps the top test + unconditional `j` back-edge topology AND stays a natural loop,
 * so loop opt still hoists the invariants (`li t0,16`, `&gSkyColor` base t1) and
 * strength-reduces `gSkyColor[k]` into the oracle's a1 walker (a plain `for` rotates to
 * bnez-back; a goto-label loop keeps topology but loses the hoists/giv -- both wrong).
 * (2) the old Ghidra `j = bk-fr; if(j<0)j+=7; (j>>3)` chains are gcc's OWN signed /8:
 * write `rounddiff.r = (u_char)((cur_bk.r-cur_fr.r)/8)` -- the div temp is ANONYMOUS ($v0,
 * no SYM record), which also forces the oracle's `bgez;nop` (a named var freed the sb into
 * the slot = ours 2-shorter before). (3) the inner counter is `j` (SYM $3) with the select
 * var `l` block-scoped (SYM line=17) -- roles were swapped in the old recon. (4) init order
 * `i=0; k=0;` (i first wins $a3 per SYM REG7) + increment order `j++; k++;` at the body
 * tail. No pointer local exists in the SYM -- the a1 walker is pure strength reduction. */
void Hrz_InitSkyColor(void)
{
  int i, j, k;
  CVECTOR rounddiff;

  i = 0;
  k = 0;
  while (true) {
    if (!(i < 5)) break;
    {
      CVECTOR cur_bk, cur_fr;
      cur_bk = Sky_gTrackSpec->backcolors[i];
      cur_fr = Sky_gTrackSpec->frontcolors[i];
      rounddiff.r = (u_char)((cur_bk.r - cur_fr.r) / 8);
      rounddiff.g = (u_char)((cur_bk.g - cur_fr.g) / 8);
      rounddiff.b = (u_char)((cur_bk.b - cur_fr.b) / 8);
      j = 0;
      while (true) {
        if (!(j < 0x11)) break;
        {
          int l;
          l = j;
          if (8 < j) l = 0x10 - j;
          gSkyColor[k].r = cur_fr.r + rounddiff.r * l;
          gSkyColor[k].g = cur_fr.g + rounddiff.g * l;
          gSkyColor[k].b = cur_fr.b + rounddiff.b * l;
        }
        j = j + 1;
        k = k + 1;
      }
    }
    i = i + 1;
  }
}

/* ---- Hrz_InitSky__Fv  [HRZSKU.CPP:257-332] SLD-VERIFIED ----
 * NEAR-MISS 16 diffs, COUNT-EXACT 209/209 (wave-13; was 189). Levers that landed:
 * (1) per-field SVECTOR split (defs banner above) turned every sun/moon field store into
 * the oracle's 1-insn %gp_rel sh; (2) KEY: struct-typed per-field PUNS (SUNPOS_VX etc.,
 * `((SVECTOR*)&sym)->vx`): a plain scalar-symbol store is treated as no-alias vs any
 * pointer deref by gcc-2.8 (!MEM_IN_STRUCT_P), letting the NEXT statement's
 * gts->angle loads hoist ABOVE the store (+2 nops, wrong interleave); the pun restores
 * MEM_IN_STRUCT_P => the oracle's store-then-load interleave, at offset 0 of each split
 * symbol so the bare-symbol gp macro survives (an offset pun `base->vz` kills gp-rel);
 * (3) fully-inline anonymous trig chains (SYM @40e03a: exactly i,j,k,angle,height,radius
 * -- NO iVar temps); (4) duplicated SetViewColor (comm: P1+P2, else: P1) cross-jump
 * merged; (5) flags&0x80 arm-swap (ringPMX arm = fall-through) + `(flags&2)&&(i<4)`
 * if/else select; (6) in-place angle mutation chain (j*0x1000; -sunAngle; +0x4000) keeps
 * the whole chain in $s0; (7) duplicated height/radius= mult tails in both ring arms
 * (per-arm $a0 setup, shared jal tails); (8) real `cloudIndices[i][j%4]` field access +
 * plain signed `j % 4` idiom, do-while with explicit j++;k++ order. RESIDUAL 16 = ONE
 * allocno tie: k<->sin-value swap $s4/$s6 (ours k=s4; oracle k=s6). -dg dump: ours
 * k pri=4*19/100=0.76 vs sin 2*7/32=0.44, height 3*10/43=0.70 -- k allocates 5th, oracle
 * wants it LAST. Tried+failed: decl order, k=i copy, init hoist (41, reverted), k-before-i
 * (18), dummy pre-inits, role-name swap (all no-op or worse). Permuter candidate. */
void Hrz_InitSky(void)

{
  int i;
  int j;
  int k;
  int angle;
  int height;
  int radius;

  SUNPOS_VX = (short)fixedmult(fixedcos(Sky_gTrackSpec->sunAngleInSky),1000);
  SUNPOS_VZ = (short)fixedmult(fixedsin(Sky_gTrackSpec->sunAngleInSky),1000);
  SUNPOS_VY =
       (short)TrackSpec_gSpec.skyspec.sunHeightInSky + (short)TrackSpec_gSpec.skyspec.yoffset;
  MOONPOS_VX = (short)fixedmult(fixedcos(Sky_gTrackSpec->moonAngleInSky),1000);
  MOONPOS_VZ = (short)fixedmult(fixedsin(Sky_gTrackSpec->moonAngleInSky),1000);
  MOONPOS_VY =
       (short)TrackSpec_gSpec.skyspec.moonHeightInSky + (short)TrackSpec_gSpec.skyspec.yoffset;
  /* MATCH: duplicated SetViewColor calls (comm arm calls P1 then P2; else arm P1 only) --
     gcc cross-jump merges the two P1-tails into the oracle's shared lbu/jal block; a
     select-variable form (`v = P1; if(comm) {call; v = P2;} call(v)`) caches the view in
     a temp the oracle doesn't have. */
  if (GameSetup_gData.commMode == 1) {
    Draw_SetViewColor(Draw_gPlayer1View,(u_int)(Sky_gTrackSpec->clearcolor).r,
               (u_int)(Sky_gTrackSpec->clearcolor).g,(u_int)(Sky_gTrackSpec->clearcolor).b);
    Draw_SetViewColor(Draw_gPlayer2View,(u_int)(Sky_gTrackSpec->clearcolor).r,
               (u_int)(Sky_gTrackSpec->clearcolor).g,(u_int)(Sky_gTrackSpec->clearcolor).b);
  }
  else {
    Draw_SetViewColor(Draw_gPlayer1View,(u_int)(Sky_gTrackSpec->clearcolor).r,
               (u_int)(Sky_gTrackSpec->clearcolor).g,(u_int)(Sky_gTrackSpec->clearcolor).b);
  }
  i = 0;
  k = 0;
  do {
    if ((Sky_gTrackSpec->flags & 0x80U) != 0) {
      /* MATCH: radius= duplicated in BOTH arms; gcc cross-jumps the common
         fixedsin/fixedmult tails, leaving the per-arm a0 setup (ringAngles[i]
         re-read straight into $a0 here vs addu a0,s0 in the else arm). */
      height = fixedmult(fixedcos(Sky_gTrackSpec->ringAngles[i]),1000);
      radius = fixedmult(fixedsin(Sky_gTrackSpec->ringAngles[i]),1000);
    }
    else {
      if (((Sky_gTrackSpec->flags & 2U) != 0) && (i < 4)) {
        angle = i << 0xb;
      }
      else {
        angle = i << 0xc;
      }
      height = fixedmult(fixedcos(angle),1000);
      radius = fixedmult(fixedsin(angle),1000);
    }
    j = 0;
    do {
      angle = j * 0x1000;
      j = j + 1;
      angle = angle - Sky_gTrackSpec->sunAngleInSky;
      angle = angle + 0x4000;
      gSkyMesh[k].vx = (short)fixedmult(fixedsin(angle),height);
      gSkyMesh[k].vy = (short)Sky_gTrackSpec->yoffset + (short)radius;
      gSkyMesh[k].vz = (short)fixedmult(fixedcos(angle),height);
      k = k + 1;
    } while (j < 0x11);
    i = i + 1;
  } while (i < 5);
  if (Sky_gTrackSpec->type == 1) {
    i = 0;
    k = 0;
    do {
      j = 0;
      do {
        gSkyPixmapIndex[k] = Sky_gTrackSpec->cloudIndices[i][j % 4] + '';
        j = j + 1;
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
 * wave-13 FULL rule-8 rewrite from SYM @40e105 + oracle trace. SYM truth: fn-scope
 * i=$17(s1) -- ONE counter REUSED by all four loops -- + angle=$16(s0); block(17-39):
 * nMaxPmxHeight_InPixels REG + pnPmxHeight_InPixels[16] AUTO @-0x50; block(44-73):
 * level=$9(t1) + cur_bk/-0x50 cur_fr/-0x48 rounddiff/-0x40 (frame slots REUSED across
 * the two disjoint blocks -> block scoping mandatory); innermost block(51-59): j=$5(a1)
 * = the SELECT variable (j = i or 16-i), NOT a counter. rounddiff = the signed /8 idiom
 * recomputed EVERY inner iteration (matches oracle); ring-color dest = index form
 * gHrzRingColor[level][i] (givs t2/a3/t0 are loop-opt products); loops 2/4 =
 * exit-in-the-middle while(true) (top test + j back-edge, invariants 16/&gHrzRingColor
 * hoisted); loops 1/3 = plain do-while (rotated bottom-test). Level-end [16]=[0]
 * wrap copy = plain CVECTOR assign (char-aligned -> lwl/lwr). Tail Hrz_gSaveCol[1]
 * copy = u_long pun (oracle uses ALIGNED lw/sw, a CVECTOR assign would emit lwl/lwr). */
void Hrz_Init2DRing(void)

{
  int i;
  int angle;

  i = 0;
  do {
    angle = i * 0x1000 + Hrz_gTrackSpec->angle;
    gRngCoordTop[i].vx = (short)fixedmult(fixedsin(angle),32000);
    gRngCoordTop[i].vy = 0;
    gRngCoordTop[i].vz = (short)fixedmult(fixedcos(angle),32000);
    i = i + 1;
  } while (i < 0x11);
  {
    int nMaxPmxHeight_InPixels;
    int pnPmxHeight_InPixels [16];

    nMaxPmxHeight_InPixels = 1;
    i = 0;
    while (true) {
      if (!(i < 0x10)) break;
      gpPmx[i] = gHorizonPixmap[(u_char)Hrz_gTrackSpec->ringPMX[i] & 7];
      pnPmxHeight_InPixels[i] = gpPmx[i]->v2 - gpPmx[i]->v1;
      if (nMaxPmxHeight_InPixels < pnPmxHeight_InPixels[i]) {
        nMaxPmxHeight_InPixels = pnPmxHeight_InPixels[i];
      }
      i = i + 1;
    }
    i = 0;
    do {
      gfxPmxHeightPercentage[i] = (pnPmxHeight_InPixels[i] << 0x10) / nMaxPmxHeight_InPixels;
      i = i + 1;
    } while (i < 0x10);
  }
  {
    int level;

    level = 0;
    while (true) {
      if (!(level < 2)) break;
      {
        CVECTOR cur_bk;
        CVECTOR cur_fr;
        CVECTOR rounddiff;

        cur_bk = Hrz_gTrackSpec->backColor[level];
        cur_fr = Hrz_gTrackSpec->frontColor[level];
        i = 0;
        while (true) {
          if (!(i < 0x10)) break;
          {
            int j;

            j = i;
            if (8 < i) j = 0x10 - i;
            rounddiff.r = (u_char)((cur_bk.r - cur_fr.r) / 8);
            rounddiff.g = (u_char)((cur_bk.g - cur_fr.g) / 8);
            rounddiff.b = (u_char)((cur_bk.b - cur_fr.b) / 8);
            gHrzRingColor[level][i].r = cur_fr.r + rounddiff.r * j;
            gHrzRingColor[level][i].g = cur_fr.g + rounddiff.g * j;
            gHrzRingColor[level][i].b = cur_fr.b + rounddiff.b * j;
          }
          i = i + 1;
        }
        gHrzRingColor[level][16] = gHrzRingColor[level][0];
      }
      level = level + 1;
    }
  }
  Hrz_InitSky();
  *(u_long *)&Hrz_gSaveCol[1] = *(u_long *)&Sky_gTrackSpec->frontcolors[0];
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

/* ---- Hrz_LightningAddFork__FScScSc  [HRZSKU.CPP:783-822] SLD-VERIFIED ----
 * wave-13 rewrite from SYM @40e44b + oracle: only TWO locals (type=char @$5, fork=ptr
 * @$17) -- the old uVar3/4/5/6 soup was Ghidra. Key shapes: post-increment slot index
 * `fork = forks + numForks; numForks += 1;` (postinc emitted a char re-mask andi;
 * the pointer-add two-statement form gives the oracle's lbu/incr/sb/*6 with no mask);
 * params MUTATED in place (row+=1 before the type==1 pair of recursive calls; direction
 * reassigned in the type==3 arm and the FINAL dir<0 test reads the mutated value);
 * `1 - (random()&1)*2` keeps the s3=1 shared constant (CSE with the type==1 beq);
 * dispatch = a REAL `switch(type)` (gcc balanced tree beq1/slti2/beqz0/beq2/beq3 with
 * arms out-of-line in ASCENDING case order + cross-jumped pmxIndex sb tail); the earlier
 * if/else-if chain inlined the ==1 arm + flipped polarities (57 diffs). SEALED 134/134. */
void Hrz_LightningAddFork(signed char direction,signed char column,signed char row)

{
  char type;
  tHrz_LightningFork *fork;

  if (row == 0) {
    type = 3;
  }
  else if (row < 3) {
    type = (u_int)random() % 3;
  }
  else {
    type = 2;
  }
  fork = gHrz_Lightning.forks + gHrz_Lightning.numForks;
  gHrz_Lightning.numForks = gHrz_Lightning.numForks + 1;
  fork->pos.vx = column * 0xf;
  fork->pos.vy = row * 0xf;
  switch (type) {
  case 0:
    Hrz_LightningAddFork(direction,column + direction,row + 1);
    fork->pmxIndex = (random() & 1) + 2;
    break;
  case 1:
    row = row + 1;
    Hrz_LightningAddFork(-1,column + -1,row);
    Hrz_LightningAddFork(1,column + 1,row);
    fork->pmxIndex = 6;
    break;
  case 2:
    fork->pmxIndex = (random() & 1) + 4;
    break;
  case 3:
    direction = 1 - (random() & 1) * 2;
    Hrz_LightningAddFork(direction,column + direction,row + 1);
    fork->pmxIndex = random() & 1;
    break;
  }
  if (direction < 0) {
    fork->pmxIndex = fork->pmxIndex + 8;
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
 * pointer too, matching the oracle's single dereference + reuse. (3) SEALED 76/76
 * PASS (wave-13; was a 14-diff "accepted near-miss"). The crack was the 2nd tag-merge's
 * SHAPE: a cached slot POINTER + tag read, with the Render_gPacketPtr store BETWEEN the
 * RMW's load and store (`slot=...; tag=*slot; Render_gPacketPtr=prim+0x28; *slot=tag&...`)
 * -- the oracle's `sw v1,0(t4)` sits between `lw v0,0(a3)` and `sw v0,0(a3)`, unreachable
 * from any single-statement RMW (may-alias anti-dependence pins the order) -- PLUS the
 * index-first addu `slot=(u_int*)(sd->otz*4+(int)pal)` (catalog commutative-addu lever):
 * scaled-index-first makes the address chain mutate IN PLACE in the dead `sd` param's $a3
 * (`lw a3,148(a3); sll a3; addu a3,a3,t2`) and lets `pal` die at the addu, which also
 * flips the t1/t2 mask/pal allocation to the oracle's. Base-first `pal + otz*4` coalesced
 * the chain onto pal's $t1 instead (26 diffs); a naive `sd = ...` in-place param mutate
 * recolored the whole head (83 diffs, defensive-param-copy trap). */
void Hrz_TextureQuad(DVECTOR *pt,char type,char bright,Draw_DCache *sd)

{
  POLY_FT4 *prim;
  u_long l0;
  u_long l1;
  u_long l2;
  u_long l3;
  Draw_tPixMap *pmx;
  u_char *pal;
  u_int *slot;
  u_int tag;

  prim = (POLY_FT4 *)Render_gPacketPtr;
  pal = Render_gPalettePtr;
  *(u_int *)prim = *(u_int *)prim & 0xff000000 | *(u_int *)(pal + sd->otz * 4) & 0xffffff;
  slot = (u_int *)(sd->otz * 4 + (int)pal);  /* MATCH: index-first addu -- chain lives in dead $a3, pal dies at the addu */
  tag = *slot;
  Render_gPacketPtr = (u_char *)prim + 0x28;
  *slot = tag & 0xff000000 | (u_int)prim & 0xffffff;
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
 * SEALED 68/68 PASS (wave-13; was a 103-diff "accepted floor"). THREE stacked levers:
 * (1) the "-G4 floor" on the 8-byte Hrz_gLightningPosInSky SVECTOR fell to the PER-FIELD
 * SPLIT (see the definitions banner at the top of this file): each 2-byte short is
 * individually gp-eligible, reproducing the oracle's `sh r,%gp_rel(...)($gp)` one-insn
 * stores and freeing $s0 for the shared /8000 magic constant (frame 48->40, 1 saved reg).
 * (2) the Ghidra `(short)uVar1 + (short)(uVar1/8000)*-8000` soup is a plain UNSIGNED
 * modulo written INLINE with the call -- `(int)((u_int)random() % 8000)` -- SYM @40e6ef
 * shows NO named local (Vi + forwardVec only), so the random value is an anonymous temp:
 * an inline call keeps it in $v0 (multu v0,s0; subu v0,v0,v1 in place, no `addu a1,v0`
 * copy) and the field load takes the dead Vi param's $a0. A named uVar1 (any variant)
 * costs the copy + a reg. (3) vy's `+8000` must bind to (fy>>2); see the in-body MATCH
 * comment (association barrier). */
void Hrz_SetLightingPosInSky(DRender_tView *Vi)

{
  coorddef forwardVec;

  forwardVec = *(coorddef *)&(Vi->cview).mrotation.m[6];
  Hrz_gLightningPosInSky_vx = (forwardVec.x >> 2) + (int)((u_int)random() % 8000) + -4000;
  /* MATCH: (u_int) cast on (fy>>2)+8000 = association barrier (fold otherwise re-attaches
     the constant to the mod term); value-identical, the sh store truncates to 16 bits */
  Hrz_gLightningPosInSky_vy = (int)((u_int)((forwardVec.y >> 2) + 8000) + (u_int)random() % 3000);
  Hrz_gLightningPosInSky_vz = (forwardVec.z >> 2) + (int)((u_int)random() % 8000) + -4000;
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
    gte_ldv0((SVECTOR *)&Hrz_gLightningPosInSky_vx);
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

/* ---- Hrz_BuildSky__Fv  [HRZSKU.CPP:1060-1277] SLD-VERIFIED ----
 * wave-13 FULL rewrite from SYM @40ed4b + oracle. SYM fn-scope: pSkyMesh=$s1, pSkyZ=$s4,
 * i=$t4 (CALLER-saved -- the mesh loop has NO calls once the exit-dither moves AFTER the
 * loop), otz_old=$s0, pshift=$s0 (SAME reg, disjoint -- pshift is the sd->otz SAVE var
 * around Flare_Sun), sd=$s2 = (Draw_DCache*)0x1F800000 scratchpad base (BODY-LOCAL
 * template): Flare arg = (Draw_FlareCache*)sd copy, save/restore = sd->otz (+0x94), and
 * every literal 0x1F80xxxx materialization CSEs onto s2's lui (addu+ori / disp forms).
 * Loop = exit-in-the-middle while(true) (invariant masks/&PacketPtr/color-bases hoisted);
 * temp = i*0x11/0x10 (plain signed divide); pixmap index = gSkyPixmapIndex[i] (t5 walker
 * is a GIV, not a source pointer); packet copies = u_long puns (aligned lw/sw, serialized
 * with load-delay nops -- NOT lwl/lwr CVECTOR assigns, NOT load-3 grouping); block-local
 * POLY_GT4/POLY_FT4/POLY_G4 prim + pmx per SYM blocks 141/169/195; FT4+G4 share the
 * cross-jumped 4-word mesh tail; slot-var + slot[-2] displacement = ONE palette-address
 * evaluation per block (a repeated full expression re-loads pal/ViewOtSize after the
 * may-alias *prim store = +16 insns); FT4 uses the TextureQuad tag-split bump.
 * STATE wave-13: 615 -> 393 diffs, count 459 vs 458 (was 513/458). The residual is a
 * near-uniform ALLOCNO RENAME cascade over ~12 loop pseudos (i t2 vs t4, temp a3 vs t1,
 * pmx a2 vs a3, pSkyZ s3 vs s4, palette-hi t4 vs s0, color bases shifted): body content,
 * frame (72), and every access shape match line-for-line under the renames. Root = the
 * allocation ORDER of the hoisted invariants vs temp/pmx (oracle allocates pmx before
 * temp); fn-scope temp tried (no-op, reverted to SYM block scope). Permuter / -dg
 * comparison territory; single remaining +1 insn not yet localized. */
void Hrz_BuildSky(void)
{
  DVECTOR *pSkyMesh;
  int *pSkyZ;
  int i;
  int otz_old;
  int pshift;
  Draw_DCache *sd;

  otz_old = 0x78;
  if (GameSetup_gData.commMode == 1) {
    otz_old = 0x3c;
  }
  sd = (Draw_DCache *)0x1f800000;        /* PSX scratchpad base (held in $s2) */
  pSkyMesh = (DVECTOR *)0x1f800014;
  pSkyZ = (int *)0x1f800168;
  if ((Sky_gTrackSpec->flags & 1U) != 0) {
    /* RTPT fast path: 3 vertices per pass (0x55 total) + RTPS tail. */
    coorddef trans;
    DVECTOR *scnt;
    SVECTOR *pcnt;
    int *zcnt;
    int n;

    memset(&trans,0,0xc);
    HrzSetPsxTranslation(&trans);
    pcnt = (SVECTOR *)&gSkyMesh /* @0x80120378 */;
    n = 0x55;
    scnt = (DVECTOR *)0x1f800008;
    zcnt = (int *)0x1f80015c;
    do {
      gte_ldv3(pcnt, pcnt + 1, pcnt + 2);
      gte_rtpt();
      pcnt = pcnt + 3;
      n = n + -3;
      scnt = scnt + 3;
      zcnt = zcnt + 3;
      gte_stsxy3(&scnt[0],&scnt[1],&scnt[2]);
      gte_swc2(0x11,&zcnt[0]);   /* SZ1 */
      gte_swc2(0x12,&zcnt[1]);   /* SZ2 */
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
    /* RTPS path: 1 vertex per pass (0x54 total), screen row pinned at otz_old. */
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
  if ((TrackSpec_gSpec.skyspec.flags & 4U) != 0) {
    pshift = sd->otz;                       /* save (scratchpad +0x94) around the flare */
    Flare_Sun(SUNPOS,(Draw_FlareCache *)sd);
    sd->otz = pshift;
  }
  i = 0;
  while (true) {
    if (!(i < 0x40)) break;
    {
      int temp;

      temp = i * 0x11 / 0x10;
      if ((pSkyZ[temp + 17] != 0 || pSkyZ[temp + 18] != 0) ||
          (pSkyZ[temp + 1] != 0 || pSkyZ[temp] != 0)) {
        if ((pSkyMesh[temp + 17].vx <= (short)*(u_short *)((char *)sd + 0x10) ||
             pSkyMesh[temp + 18].vx <= (short)*(u_short *)((char *)sd + 0x10)) ||
            (pSkyMesh[temp + 1].vx <= (short)*(u_short *)((char *)sd + 0x10) ||
             pSkyMesh[temp].vx <= (short)*(u_short *)((char *)sd + 0x10))) {
          if (((-1 < pSkyMesh[temp + 17].vx) || (-1 < pSkyMesh[temp + 18].vx) ||
               (-1 < pSkyMesh[temp + 1].vx)  || (-1 < pSkyMesh[temp].vx)) &&
              (((pSkyMesh[temp + 17].vy <= (short)*(u_short *)((char *)sd + 0x12)) ||
                (pSkyMesh[temp + 18].vy <= (short)*(u_short *)((char *)sd + 0x12)) ||
                (pSkyMesh[temp + 1].vy  <= (short)*(u_short *)((char *)sd + 0x12)) ||
                (pSkyMesh[temp].vy      <= (short)*(u_short *)((char *)sd + 0x12))) &&
               ((-1 < pSkyMesh[temp + 17].vy) || (-1 < pSkyMesh[temp + 18].vy) ||
                (-1 < pSkyMesh[temp + 1].vy)  || (-1 < pSkyMesh[temp].vy)))) {
            if (Sky_gTrackSpec->type == 1) {
              if ((Sky_gTrackSpec->flags & 0x20U) != 0) {
                POLY_GT4 *prim;
                Draw_tPixMap *pmx;

                u_int *slot;
                prim = (POLY_GT4 *)Render_gPacketPtr;
                pmx = gHorizonPixmap[gSkyPixmapIndex[i]];
                slot = (u_int *)(Render_gPalettePtr + Draw_gViewOtSize * 4);
                *(u_int *)prim = *(u_int *)prim & 0xff000000 | slot[-2] & 0xffffff;
                slot[-2] = slot[-2] & 0xff000000 | (u_int)prim & 0xffffff;
                *(u_long *)&prim->r0 = *(u_long *)&gSkyColor[temp + 0x11];
                Render_gPacketPtr = (u_char *)prim + 0x34;
                *(u_long *)&prim->r1 = *(u_long *)&gSkyColor[temp + 0x12];
                *(u_long *)&prim->r2 = *(u_long *)&gSkyColor[temp];
                *(u_long *)&prim->r3 = *(u_long *)&gSkyColor[temp + 1];
                *((u_char *)prim + 3) = 0xc;
                prim->code = 0x3c;
                *(u_long *)&prim->u0 = *(u_long *)pmx;
                *(u_long *)&prim->u1 = *(u_long *)((char *)pmx + 4);
                *(u_long *)&prim->u2 = *(u_long *)((char *)pmx + 8);
                *(u_long *)&prim->u3 = *(u_long *)((char *)pmx + 0xc);
                *(u_long *)&prim->x0 = *(u_long *)&pSkyMesh[temp + 17];
                *(u_long *)&prim->x1 = *(u_long *)&pSkyMesh[temp + 18];
                *(u_long *)&prim->x2 = *(u_long *)&pSkyMesh[temp];
                *(u_long *)&prim->x3 = *(u_long *)&pSkyMesh[temp + 1];
              }
              else {
                POLY_FT4 *prim;
                Draw_tPixMap *pmx;

                u_int *slot;
                u_int tag;
                prim = (POLY_FT4 *)Render_gPacketPtr;
                pmx = gHorizonPixmap[gSkyPixmapIndex[i]];
                slot = (u_int *)(Render_gPalettePtr + Draw_gViewOtSize * 4);
                *(u_int *)prim = *(u_int *)prim & 0xff000000 | slot[-2] & 0xffffff;
                tag = slot[-2];
                Render_gPacketPtr = (u_char *)prim + 0x28;
                slot[-2] = tag & 0xff000000 | (u_int)prim & 0xffffff;
                *(u_long *)&prim->r0 = *(u_long *)&Sky_gTrackSpec->frontcolors[0];
                *((u_char *)prim + 3) = 9;
                prim->code = 0x2c;
                *(u_long *)&prim->u0 = *(u_long *)pmx;
                *(u_long *)&prim->u1 = *(u_long *)((char *)pmx + 4);
                *(u_long *)&prim->u2 = *(u_long *)((char *)pmx + 8);
                *(u_long *)&prim->u3 = *(u_long *)((char *)pmx + 0xc);
                *(u_long *)&prim->x0 = *(u_long *)&pSkyMesh[temp + 17];
                *(u_long *)&prim->x1 = *(u_long *)&pSkyMesh[temp + 18];
                *(u_long *)&prim->x2 = *(u_long *)&pSkyMesh[temp];
                *(u_long *)&prim->x3 = *(u_long *)&pSkyMesh[temp + 1];
              }
            }
            else {
              POLY_G4 *prim;

              u_int *slot;
              prim = (POLY_G4 *)Render_gPacketPtr;
              slot = (u_int *)(Render_gPalettePtr + Draw_gViewOtSize * 4);
              *(u_int *)prim = *(u_int *)prim & 0xff000000 | slot[-2] & 0xffffff;
              slot[-2] = slot[-2] & 0xff000000 | (u_int)prim & 0xffffff;
              *(u_long *)&prim->r0 = *(u_long *)&gSkyColor[temp + 0x11];
              Render_gPacketPtr = (u_char *)prim + 0x24;
              *(u_long *)&prim->r1 = *(u_long *)&gSkyColor[temp + 0x12];
              *(u_long *)&prim->r2 = *(u_long *)&gSkyColor[temp];
              *(u_long *)&prim->r3 = *(u_long *)&gSkyColor[temp + 1];
              *((u_char *)prim + 3) = 8;
              prim->code = 0x38;
              *(u_long *)&prim->x0 = *(u_long *)&pSkyMesh[temp + 17];
              *(u_long *)&prim->x1 = *(u_long *)&pSkyMesh[temp + 18];
              *(u_long *)&prim->x2 = *(u_long *)&pSkyMesh[temp];
              *(u_long *)&prim->x3 = *(u_long *)&pSkyMesh[temp + 1];
            }
          }
        }
      }
    }
    i = i + 1;
  }
  if ((Sky_gTrackSpec->flags & 0x40U) != 0) {
    Hrz_SetDitheringPrim(1,Draw_gViewOtSize + -2);
  }
  return;
}

/* ---- Sky_RenderStars__FP13Draw_SkyCachei  [HRZSKU.CPP:1284-1330] SLD-VERIFIED ----
 * wave-13 rewrite from SYM @40f0c6 (locals: pcnt=$s0, n=$a2, prim=TILE_1*$a0, pshift=$s1
 * + trans/scnt/transformed/zcnt AUTOs -- NO puVar/uVar soup). Shapes: TextureQuad-style
 * slot/tag OT-link (packet-ptr store between the RMW's load and store; index-first addu
 * `otz*4 + (int)pal`); the vy value is an ANONYMOUS common subexpr (written twice, CSE
 * unifies; (short) casts at the tests, no reload of scnt.vy); visibility = a clean
 * &&-chain in oracle test order (clipW, vx<0, clipH, v<0 -- the old comma-assignment
 * form emitted a stored-bool xori); scnt copied into the prim as a u_long pun (aligned
 * lw/sw; a DVECTOR struct assign emits lwl/lwr). RESIDUAL 11 (was 18): ours hoists the
 * invariant `sll otz*4` to the loop preheader (life>=5 -> loop.c moves it; oracle keeps
 * it in the bltz delay slot) -- tried single-expr both operand orders, in-place slot
 * chain, block-scoped locals, pal-preload: -dL shows it moved regardless (likely
 * cse_around_loop, not movables). Downstream a1/v0 pair swap rides on it. Floor-ish;
 * permuter candidate. */
void Sky_RenderStars(Draw_SkyCache *sd,int otz)

{
  SVECTOR *pcnt;
  int n;
  TILE_1 *prim;
  int pshift;
  coorddef trans;
  DVECTOR scnt;
  VECTOR transformed;
  int zcnt;

  pshift = 0x78;
  if (GameSetup_gData.commMode == 1) {
    pshift = 0x3c;
  }
  pcnt = starPosInSky;
  memset(&trans,0,0xc);
  HrzSetPsxTranslation(&trans);
  n = 0;
  if (0 < Sky_gTrackSpec->numStars) {
    do {
      gte_ldv0(pcnt);
      gte_rtps();
      pcnt = pcnt + 1;
      gte_stsz(&zcnt);
      if (0 < zcnt) {
        gte_stSXY2(&scnt);
        gte_stlvnl(&transformed.vx);
        scnt.vy = (short)((transformed.vy >> 2) + pshift);
        if ((scnt.vx <= (sd->head).clipW) && (-1 < scnt.vx) &&
            ((short)((transformed.vy >> 2) + pshift) <= (sd->head).clipH) &&
            (-1 < (short)((transformed.vy >> 2) + pshift))) {
          /* MATCH: in-place slot chain (sll then add in the SAME pseudo) -- a single
             `otz*4 + pal` expression lets LICM hoist the invariant sll to the preheader
             (oracle keeps it in the bltz delay slot; a twice-set reg is not movable) */
          u_int *slot;
          u_int tag;
          u_char *pal;
          pal = Render_gPalettePtr;
          slot = (u_int *)(otz * 4);
          slot = (u_int *)((int)slot + (int)pal);
          prim = (TILE_1 *)Render_gPacketPtr;
          *(u_int *)prim = *(u_int *)prim & 0xff000000 | *slot & 0xffffff;
          tag = *slot;
          Render_gPacketPtr = (u_char *)prim + 0xc;
          *slot = tag & 0xff000000 | (u_int)prim & 0xffffff;
          *(u_long *)((u_char *)prim + 4) = (*(u_long *)&starColors[n]);
          *((u_char *)prim + 3) = 2;
          *((u_char *)prim + 7) = 0x68;
          *(u_long *)((u_char *)prim + 8) = *(u_long *)&scnt;
        }
      }
      n = n + 1;
    } while (n < Sky_gTrackSpec->numStars);
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
  coorddef trans;
  int fxOverlapPercentage;
  long hrz_projchange;
  Draw_HorizonCache *hsd;

  /* PSX scratchpad base (0x1F800000). Held in ONE local for the WHOLE function (not a
     literal at each site) because the oracle keeps this address live in a single
     CALLEE-SAVED register ($s6) across every intervening call (Hrz_RotProj16,
     Horizon_InterpolateLineSCoords x N, SetGeomScreen) -- matches catalog §3.12 #16
     HOLD-GLOBAL-ADDR-ACROSS-CALL: a value referenced both before and after a `jal` is
     forced into a callee-saved reg + frame slot, which is exactly what materializing a
     fresh literal at every site (a per-call REMATERIALIZE) fails to reproduce.
     MATCH: this is the SYM's real "hsd" (Draw_HorizonCache*) local, not a synthetic int
     -- reusing the SAME nfs4_types.h struct (head.clipW/clipH @0x10/0x12, scptTop[17]
     @0x14, scptMidBot[17] @0x58, scptPmxLeft[17] @0x9c, scptPmxRight[17] @0xe0,
     vertexTop[18] @0x124 -- byte-for-byte the "posD/posA/posB/posC/cnt" arrays this fn's
     banner already documents). An extra invented int local not backed by the SYM (the
     prior "(int)hsd") shifts pseudo-numbering/register-coloring for the WHOLE function
     (rule 8's "adding any new pseudo can re-color the head" converse trap) -- eliminated. */
  hsd = (Draw_HorizonCache *)0x1f800000;
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
    int rowDelta;               /* SYM: nested "i" -- the farI/Zmax search counter */
    int farI, Zmax, dx, dy;
    SVECTOR *pSVar12;
    short shape_short;
    int shape_visible, shape_idx, shape_overlap, shape_w_idx;

    Hrz_RotProj16(0x11,gRngCoordTop,(int *)((int)hsd + 0x124),(DVECTOR *)((int)hsd + 0x58));
    farI = 0;
    Zmax = 0;
    zval = (int *)((int)hsd + 0x124);
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
    updown[0].vx = pSVar12->vx;
    shape_short = (short)Hrz_gTrackSpec->yoffset + (short)Hrz_gTrackSpec->height;
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
    dx = temp2d[0].vx - *(short *)(((int)hsd + 0x58) + farI * 4);
    dy = temp2d[0].vy - *(short *)(((int)hsd + 0x5a) + farI * 4);
    shape_overlap = 0;
    shape_visible = (int)hsd;
    do {
      if (0 < *(int *)(shape_visible + 0x124)) {
        *(short *)(shape_visible + 0x14) = *(short *)(shape_visible + 0x58) + dx;
        *(short *)(shape_visible + 0x16) = *(short *)(shape_visible + 0x5a) + dy;
      }
      shape_overlap = shape_overlap + 1;
      shape_visible = shape_visible + 4;
    } while (shape_overlap < 0x11);
    dx = temp2d[1].vx - *(short *)(((int)hsd + 0x58) + farI * 4);
    dy = temp2d[1].vy - *(short *)(((int)hsd + 0x5a) + farI * 4);
    shape_w_idx = 0;
    shape_idx = (int)hsd;
    do {
      if (0 < *(int *)(shape_idx + 0x124)) {
        *(short *)(shape_idx + 0x58) = *(short *)(shape_idx + 0x58) + dx;
        *(short *)(shape_idx + 0x5a) = *(short *)(shape_idx + 0x5a) + dy;
      }
      shape_w_idx = shape_w_idx + 1;
      shape_idx = shape_idx + 4;
    } while (shape_w_idx < 0x11);
  }
  Horizon_InterpolateLineSCoords((DVECTOR *)((int)hsd + 0x9c),(DVECTOR *)((int)hsd + 0x58),(DVECTOR *)((int)hsd + 0x14),
             gfxPmxHeightPercentage,0x10,1);
  Horizon_InterpolateLineSCoords((DVECTOR *)((int)hsd + 0xe0),(DVECTOR *)((int)hsd + 0x5c),(DVECTOR *)((int)hsd + 0x18),
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

      iVar16 = (int)hsd;
      iVar15 = 0;
      iVar18 = 4;
      for (; iVar17 < 0x10; iVar17 = iVar17 + 1) {
        if ((15999 < *(int *)(iVar16 + 0x124)) || (15999 < *(int *)(((int)hsd + 0x124) + iVar18))) {
          mpts[0] = *(DVECTOR *)(iVar16 + 0x9c);          /* posB[k] */
          mpts[1] = *(DVECTOR *)(iVar16 + 0xe0);          /* posC[k] */
          mpts[2] = *(DVECTOR *)(((int)hsd + 0x58) + iVar18);    /* posA[k+1] */
          mpts[3] = *(DVECTOR *)(iVar16 + 0x58);          /* posA[k] */
          {
            /* MATCH: De Morgan direct form -- m2c shows this as an AND-of-4-ORs (each OR is
               the negation of "all 4 <0"/"all 4 lo<vx" etc), NOT the mathematically-equivalent
               negated-OR-of-ANDs. Same truth table, but the compiled short-circuit branch
               chain differs completely; write the form m2c actually shows.
               lo/hi read AT POINT OF USE (not pre-declared before the clause1 chain) -- the
               oracle defers the 0x1F800010/12 read until clause2 is actually reached (only
               after clause1's OR falls all the way through); a pre-if local hoists it early. */
            if ((mpts[0].vx >= 0 || mpts[1].vx >= 0 || mpts[2].vx >= 0 || mpts[3].vx >= 0) &&
                (*(short *)((int)hsd + 0x10) >= mpts[0].vx || *(short *)((int)hsd + 0x10) >= mpts[1].vx ||
                 *(short *)((int)hsd + 0x10) >= mpts[2].vx || *(short *)((int)hsd + 0x10) >= mpts[3].vx) &&
                (mpts[0].vy >= 0 || mpts[1].vy >= 0 || mpts[2].vy >= 0 || mpts[3].vy >= 0) &&
                (*(short *)((int)hsd + 0x12) >= mpts[0].vy || *(short *)((int)hsd + 0x12) >= mpts[1].vy ||
                 *(short *)((int)hsd + 0x12) >= mpts[2].vy || *(short *)((int)hsd + 0x12) >= mpts[3].vy)) {
              Horizon_InterpolateLineSCoords(&right,(DVECTOR *)(((int)hsd + 0x9c) + iVar15),
                         (DVECTOR *)(((int)hsd + 0xe0) + iVar15),&fxOverlapPercentage,1,0);
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
                /* MATCH: arm-swap (catalog §A) -- m2c shows the branch condition as the
                   DIRECT ">=8" form (fall-through arm is >=8, not <8); the inverted-and-swap
                   compiles with the SAME polarity/inline-arm layout the oracle uses. */
                if (8 <= (u_char)Hrz_gTrackSpec->ringPMX[iVar17]) {
                  *(DVECTOR *)(p + 8) = right;
                  *(u_int *)(p + 0x14) = *(u_int *)(iVar16 + 0x9c);
                  *(u_int *)(p + 0x20) = *(u_int *)(iVar16 + 0x5c);
                  *(u_int *)(p + 0x2c) = *(u_int *)(iVar16 + 0x58);
                }
                else {
                  *(u_int *)(p + 8) = *(u_int *)(((int)hsd + 0x9c) + iVar15);
                  *(DVECTOR *)(p + 0x14) = right;
                  *(u_int *)(p + 0x20) = *(u_int *)(((int)hsd + 0x58) + iVar15);
                  *(u_int *)(p + 0x2c) = *(u_int *)(((int)hsd + 0x5c) + iVar15);
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
    Flare_Moon(MOONPOS,(Draw_FlareCache *)&Render_gPalettePtr);
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
