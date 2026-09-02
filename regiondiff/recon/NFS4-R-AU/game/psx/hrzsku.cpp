/* game/psx/hrzsku.cpp -- RECONSTRUCTED (NFS4 PSX in-race HUD; C++ TU)
 *   62 fns: sprite/poly builders, tachometer, number rasterizer, mini-map + radar,
 *   CD player, wingman interface, render views (hud/tac/map/stats), 3-2-1-GO, BTC/busted.
 *   Reconstructed with full SYM-locals applied (audited).
 */
#include "hrzsku_types.h"
#include "hrzsku_externs.h"
#include "psyq_prim_macros.h"

/* No projection-scratch BSS lives here.  The old Hrz_gProjResultZ0/
   Hrz_gProjScratch_9C harness definitions were names invented for literal
   0x1f8000xx Draw_HorizonCache fields; P439 removed them after proving zero
   SYM/MAP records and zero compiled references. */

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
static SVECTOR *starPosInSky;   /* @0x8013d878  (bss(zero)) */
static u_long *starColors;    /* @0x8013d87c  SYM PTR ULONG (bss(zero)) */
CHorizonSpec *Hrz_gTrackSpec;   /* @0x8013d888  (bss(zero)) */
CSkySpec     *Sky_gTrackSpec;   /* @0x8013d88c  (bss(zero)) */
SVECTOR      *gRngCoordTop;   /* @0x8013d890  (bss(zero)) */
/* Retail SYM names these as real 8-byte SVECTOR objects.  The TU-wide -G8
   identity reproduces their gp-relative field accesses without split-field
   source carriers. */
SVECTOR Hrz_gLightningPosInSky;   /* @0x8013d894 SYM: EXT SVECTOR */
static SVECTOR sunPosInSky;    /* @0x8013ddf0 SYM: STAT SVECTOR */
static SVECTOR moonPosInSky;   /* @0x8013ddf8 SYM: STAT SVECTOR */
#define SUNPOS  (&sunPosInSky)
#define MOONPOS (&moonPosInSky)
#define SUNPOS_VX  (sunPosInSky.vx)
#define SUNPOS_VY  (sunPosInSky.vy)
#define SUNPOS_VZ  (sunPosInSky.vz)
#define MOONPOS_VX (moonPosInSky.vx)
#define MOONPOS_VY (moonPosInSky.vy)
#define MOONPOS_VZ (moonPosInSky.vz)
static CVECTOR Hrz_gSaveCol[4];   /* @0x8013e380  (bss?) */

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
 * (worse, 28 diffs); a genuine allocator coalescing tie-break, accepted.
 * w46-a9 (26 -> PASS): NOT a coalescing tie-break -- a plain floor_log2 REF-STEP on the
 * two block-local quantities (w45 SS.A0: QTY_CMP_PRI == allocno_compare, so the ref dial
 * reaches block-local qtys too).  `sc` has 5 references per loop body and `i` only 4, so
 * `sc` sorts first and takes $t0; ONE extra reference to `i` crosses the 4->8 weighted
 * step and flips them.  A zero-operand-output USE FENCE on a reg-resident local is
 * exactly that: one REG_N_REFS reference at ZERO instructions.  Placement measured:
 * before the `i++` PASS (x1 and x2 both PASS), between `i++` and `sc++` PASS, AFTER the
 * `sc++` costs +2 insns (82/6), a fence on `sc` instead is a no-op (26), and swapping the
 * two increments is a no-op (26) -- i.e. the dial is i's REF COUNT, not statement order.*/
void Horizon_InterpolateLineSCoords(DVECTOR *sc,DVECTOR *s0,DVECTOR *s1,int *percentage,int n,int bPercentageArray)

{
  int i;
  int p;
  int pv; /* SYM-CODEGEN-CARRIER: pv -- pre-loop read preserves the retail LICM/reference shape */

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
        /* ASPSX-DIALECT (w64-a20): the asm below uses NUMERIC registers and no
         * `.set push/pop` -- ASPSX 2.77, the PRODUCTION assembler, rejects ABI
         * register NAMES and push/pop.  $0 zero $1 at $2-3 v0-v1 $4-7 a0-a3
         * $8-15 t0-t7 $16-23 s0-s7 $24-25 t8-t9 $28 gp $29 sp $30 fp $31 ra.
         * Gate-lane object is byte-identical (proven by hash); see
         * scratchpad/w64a20/RECEIPTS.md. */
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
        __asm__ __volatile__("" : : "r"(i));
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
 * expression -- this ALSO fixed a signed-vs-unsigned bug (a bare signed `%` gives a
 * `div` plus the INT_MIN/-1 overflow guard the oracle does not have).  The local remains
 * the SYM-recorded `int`; an explicit `(u_int)starBright` on the remainder numerator puts
 * unsignedness on the operation itself and emits the retail `divu` byte-for-byte.
 * (4) w39-a8: PASS (was 50 diffs / 5 saved regs vs the oracle's 6).  The "one missing
 * callee-saved reg" was NOT an allocator floor -- it was THREE fabricated locals the SYM
 * (@40dd10: oldSeed $s5, i $s4, radius $s1, height $s2, latAngle $s3, heightAngle $s0,
 * starBright $a0) does not have: `int vx`, `SVECTOR *pSVar6` and `u_int uVar2`.  Writing
 * the two fixedmult results straight into `starPosInSky[i].vx/.vz` (and NOT recycling
 * `height` for the vz value) gives the oracle's `sh $v0,0(v1)` / `sh $v0,4(s0)` direct
 * stores, its re-load of starPosInSky after the intervening call, and the 6-register
 * frame exactly.  Floor claim RETRACTED. */
void Sky_InitStars(void)

{
  int i;
  long oldSeed;

  if (starPosInSky == (SVECTOR *)0x0) {
    oldSeed = random();
    seedrandom(Sky_gTrackSpec->starRandomSeed);
    starPosInSky = (SVECTOR *)reservememadr("stars",Sky_gTrackSpec->numStars << 3,0);
    starColors = (u_long *)reservememadr("starCols",Sky_gTrackSpec->numStars << 2,0);
    for (i = 0; i < Sky_gTrackSpec->numStars; i = i + 1) {
      int latAngle;
      int heightAngle;
      int height;
      int radius;
      int starBright;

      latAngle = random();
      latAngle = latAngle & 0xffff;
      heightAngle = Sky_gTrackSpec->starAngleLow +
                    (u_int)random() % (Sky_gTrackSpec->starAngleHigh - Sky_gTrackSpec->starAngleLow);
      height = fixedsin(heightAngle);
      height = fixedmult(height,1000);
      radius = fixedcos(heightAngle);
      radius = fixedmult(radius,1000);
      starPosInSky[i].vx = (short)fixedmult(fixedsin(latAngle),radius);
      starPosInSky[i].vy = (short)height;
      starPosInSky[i].vz = (short)fixedmult(fixedcos(latAngle),radius);
      starBright = random();
      starBright = Sky_gTrackSpec->starBrightMin +
                   (u_int)starBright % (Sky_gTrackSpec->starBrightMax - Sky_gTrackSpec->starBrightMin);
      starColors[i] = starBright * 0x10000 | starBright * 0x100 | starBright;
    }
    seedrandom(oldSeed);
  }
  return;
}

/* ---- Sky_KillStars__Fv  [HRZSKU.CPP:216-222] SLD-VERIFIED ---- */
void Sky_KillStars(void)

{
  if (starPosInSky != (SVECTOR *)0x0) {
    purgememadr(starPosInSky);
  }
  if (starColors != (u_long *)0x0) {
    purgememadr(starColors);
  }
  starPosInSky = (SVECTOR *)0x0;
  starColors = (u_long *)0x0;
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
 * (18), dummy pre-inits, role-name swap (all no-op or worse). Permuter candidate.
 * w46-a9 (re-gated 16, count-exact 209/209).  Attacked the recorded razor with the
 * w44/w45 zero-insn dials.  The -dg receipt above says k must go from pri 0.76 to BELOW
 * sin's 0.44, i.e. either refs 19 -> <=14 (floor_log2 steps 4 -> 3) or live 100 -> >172.
 *  - LIVE-LENGTHENING via a zero-insn USE fence on k after the last loop, before/after
 *    Flare_InitLensFlare, x1 and x2, and at the label: ALL 16 (no effect -- flow.c does
 *    not extend k's range for an asm use of a value that is already dead at that point).
 *  - REF-SHEDDING in the depth-2 mesh loop: `SVECTOR *m = &gSkyMesh[k];` + three `m->`
 *    stores (16 -- gcc folds the pointer back onto the giv, refs unchanged), `short *m`
 *    + m[0..2] (22), shedding only the third store via `(&gSkyMesh[k].vx)[2]` (76, +6
 *    insns).
 *  - CONTROL, ref-ADDING fence on k in the loop: 25 -- confirms the dial reaches k and
 *    that the direction is DOWN, as the receipt predicted.
 *  - VARIABLE-IDENTITY split (own block-local counter for the second, cloud-index loop):
 *    36 -- and for `j` likewise 78.  So the SYM's single fn-scope `k` is right, and BOTH
 *    ref directions (+1 fence = 25, -5 by splitting = 36) are WORSE => 19 refs is already
 *    a local optimum and the REF axis is closed at this live length.
 * 🔑 NEW NAMED ANGLE (the axis that is left): LIVE LENGTH, and it must be moved by real
 * dataflow, not by a trailing fence.  k needs live 100 -> >172 at 19 refs.  The whole
 * function is 209 insns and k is born at the mesh loop's `k = 0`, roughly at insn 100 --
 * so the ONLY way to reach 172 is to make k live from the PROLOGUE (birth in the sun/moon
 * block) to its current death.  The w39 "init hoist" that measured 41 hoisted the init
 * ALONE; the untried form is to hoist the init AND give k a use in the prologue region
 * that cse folds to nothing (e.g. seed a value that the mesh loop overwrites), so the
 * range spans without adding instructions.  Alternatively demote k by RAISING sin's and
 * height's priorities (reqdelta --want on the -dg dump) rather than lowering k's.
 * w39-a8: re-certified against the now-wired per-TU C++ flags.  hrzsku.cpp whole-TU
 * baseline 15 PASS / 843 diffs vs no_split_addresses 7/1441, no_schedule_insns 7/1592,
 * no_schedule_insns2 2/1095, no_strength_reduce 12/1038 -- all worse, stock flags stand. */
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
       (short)HRZ_TRACK_SUN_HEIGHT + (short)HRZ_TRACK_SKY_YOFFSET;
  MOONPOS_VX = (short)fixedmult(fixedcos(Sky_gTrackSpec->moonAngleInSky),1000);
  MOONPOS_VZ = (short)fixedmult(fixedsin(Sky_gTrackSpec->moonAngleInSky),1000);
  MOONPOS_VY =
       (short)HRZ_TRACK_MOON_HEIGHT + (short)HRZ_TRACK_SKY_YOFFSET;
  /* MATCH: duplicated SetViewColor calls (comm arm calls P1 then P2; else arm P1 only) --
     gcc cross-jump merges the two P1-tails into the oracle's shared lbu/jal block; a
     select-variable form (`v = P1; if(comm) {call; v = P2;} call(v)`) caches the view in
     a temp the oracle doesn't have. */
  if (HRZ_GAMESETUP_COMM_MODE == 1) {
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
      /* MATCH (w50-a5, the seal): ZERO-INSN READ-ONLY REF FENCE at the HEAD of the
         inner-loop body.  Residual was the recorded k<->radius $s4/$s6 allocno tie.
         -dg/allocsim: p82(k) 19refs/100live pri .7600 > p84(height) 10/43 .6977 >
         p85(radius) 7/32 .4375, but retail wants radius=$s4, height=$s5, k=$s6 -- a
         FULL reversal, so BOTH rivals must be lifted above k (reqdelta 2-pseudo search:
         p84 refs->11/12 AND p85 refs->9 is the cheapest handout-exact delta; k's own
         refs/live dials were already falsified in w39/w46).  flow.c weights REG_N_REFS
         by loop_depth, so one read-only asm use at depth 3 buys +3 refs per operand at
         ZERO instructions: radius 7->10 (.9375), height 10->13 (.9070), both now above
         k (.7600) and still under i's .9411 so $s3 is unchanged.  POSITION is
         load-bearing (the fence is also a sched/reorg barrier -- w45): walking it
         statement-by-statement through this body measures 3/6/4/4/8/15/11/5 diffs at
         positions 1..8 and 0 HERE -- at the body head it precedes every schedulable
         insn, so it steals nothing.  Do NOT move, merge, or "simplify" it away. */
      __asm__ ("" : : "r"(height), "r"(radius));
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
        gSkyPixmapIndex[k] = Sky_gTrackSpec->cloudIndices[i][j % 4] + 8;
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
  int i;

  i = 0xb;
  do {
    gHorizonPixmap[i] = p + i;
    i = i - 1;
  } while (-1 < i);
  i = 0;
  do {
    Texture_CloneUVPmx(gHorizonPixmap[i + 8],0,&gHorizonExtraSkyPixmaps[i]);
    gHorizonPixmap[i + 12] = &gHorizonExtraSkyPixmaps[i];
    i = i + 1;
  } while (i < 4);
  return;
}

/* ---- Hrz_InitHorizon__Fv  [HRZSKU.CPP:432-443] SLD-VERIFIED ---- */
void Hrz_InitHorizon(void)

{
  Hrz_gTrackSpec = HRZ_TRACK_HORIZON_PTR;
  Sky_gTrackSpec = HRZ_TRACK_SKY_PTR;
  gRngCoordTop = (SVECTOR *)reservememadr("gRngCoordTop",0x88,0);
  Hrz_Init2DRing();
  if ((HRZ_TRACK_INIT_SKY_FLAGS & 0x10U) != 0) {
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
  Draw_tPixMap *pmx; /* SYM-CODEGEN-CARRIER: pmx -- load-four/store-four pixmap copy requires one shared source pointer */
  u_char *pal;       /* SYM-CODEGEN-CARRIER: pal -- caches the fixed scratchpad palette pointer exactly once */
  u_int *slot;       /* SYM-CODEGEN-CARRIER: slot -- preserves the retail index-first OT address chain and staged RMW */
  u_int tag;         /* SYM-CODEGEN-CARRIER: tag -- keeps the packet-pointer store between the OT load and store */

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
 * (1) the retail object uses an 8-byte small-data threshold.  TU-wide -G8 keeps the real
 * Hrz_gLightningPosInSky SVECTOR gp-eligible, reproducing the oracle's one-instruction
 * `sh r,%gp_rel(...)($gp)` stores and freeing $s0 for the shared /8000 magic constant.
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
  Hrz_gLightningPosInSky.vx = (forwardVec.x >> 2) + (int)((u_int)random() % 8000) + -4000;
  /* MATCH: (u_int) cast on (fy>>2)+8000 = association barrier (fold otherwise re-attaches
     the constant to the mod term); value-identical, the sh store truncates to 16 bits */
  Hrz_gLightningPosInSky.vy = (int)((u_int)((forwardVec.y >> 2) + 8000) + (u_int)random() % 3000);
  Hrz_gLightningPosInSky.vz = (forwardVec.z >> 2) + (int)((u_int)random() % 8000) + -4000;
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
    gte_stsxy2(&screenPos);
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

/* ---- Hrz_LightningFlicker__Fi  [HRZSKU.CPP:901-954] SLD-VERIFIED ----
 * SYM lists only `i`; removing source carrier `col` and storing each literal directly is
 * count-exact but FAIL 4 (55/55), moving both loop-setup `li a1,84` sites. */
void Hrz_LightningFlicker(int on)

{
  int i;
  u_int col; /* SYM-CODEGEN-CARRIER: col -- shared branch colour preserves retail loop setup */

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
 * ---- w53-a5 (2026-08-09): 62 @52/56 re-gated on the SHIPPED 3-block form; the
 * single-{t1,t2,t3}-block form re-measured at 72 @56/56 (COUNT-EXACT), so the w42-a6
 * ledger note reproduces exactly and is NOT stale.  ONE new falsification from the
 * count-exact base: a `do{}while(0)` DEPTH WRAPPER on the first r-block (the w44 ref-step
 * inflator, aimed at lifting the r-values' QTY priority) = 80 @56/56, i.e. the wrapper
 * moves the handout the WRONG way.  MECHANISM RE-READ (agrees with w50-a5 and sharpens
 * it): the reachable target is not a PRIORITY dial at all -- retail's r-values occupy SIX
 * distinct hard regs ($v0,$v1,$a0,$a1,$a2,$a3; per-mpsx-row triples {v1,a0,v0} {a1,v0,v1}
 * {a2,a3,v0}) because they are SIMULTANEOUSLY LIVE, which is a LIVENESS question, and
 * liveness here is set by sched1: retail hoists the two cse-emitted reloads of the block's
 * non-negated temps (`lw $v1,0x20($sp)` / `lw $a2,0x28($sp)` for row 0, `lw $a0,0x2C` /
 * `lw $a3,0x34` for row 1) ABOVE the following row's temp stores, so 6 r-values are live
 * at once; ours emits each reload immediately before its own shift+store, so at most 2
 * are.  Since QTY_CMP_PRI only orders the handout and cannot create overlap, EVERY
 * ref/live dial tried across w40/w41/w42/w50/w53 is off-target by construction.
 * ⇒ NEXT INSTRUMENT (named): the w45 USE-FENCE WALK is the only device that moves sched1
 * issue position at zero insns -- walk `__asm__("" : : "r"(r0))` statement-by-statement
 * through the r-block region of the 56/56 base (w50 tried only two positions, before and
 * after the stores of ONE block, 82/76).  Alternatively read `-dS` (sched1, pre-reload)
 * on both builds and diff the ready-list pick that hoists the reloads.
 * ---- (original receipt stack follows) ----
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
 * C, not a coloring coin-flip).
 * w40-a8 UPDATE (the note above was partly stale -- the single-{t1,t2,t3}-block form gates
 * 72 with the count EXACT 56/56).  Splitting {t1,t2,t3} into THREE per-row blocks (one per
 * source row, the SYM's "same names reused per row" read the other way) gates 62 but drops
 * to 52 insns: the three short-lived triples no longer create the register pressure that
 * evicts temp.m[0]/[2]/[3]/[5], so gcc forwards the just-stored value instead of the
 * oracle's four `lw NN(sp)` reloads.  Kept the 62 form (gate is the sole authority) but the
 * 4-insn gap is the honest structural residual.  ALSO TRIED and rejected: splitting the
 * r-block load from the shift (`r0 = temp.m[k]; ... (short)(r0>>4)`) = no change at all in
 * both forms; reading temp through an `int *tp = temp.m;` alias to defeat store-forwarding
 * = 85/61 (much worse).  The remaining residual is the raw-load triple landing on $a3/$a1
 * instead of the SYM's $t1/$t0 -- our r-pseudos share $v0/$v1 (short ranges) where the
 * oracle's span far enough to need six registers ($v0,$v1,$a0-$a3), which is what pushes
 * its raw triple down to $t0-$t2.
 * w41-a8 MECHANISM (why the 4-insn gap exists; SYM refutes the 3-block form kept below):
 * SYM @40e9d3 has ONE {t1,t2,t3} block spanning ALL THREE rows -- the same three pseudos
 * are RE-DEFINED per row, so when the r-blocks run only the LAST row's raw values
 * (temp.m[6]/[8], still in $t1/$t2) can be store-forwarded; temp.m[0]/[2]/[3]/[5] have
 * been overwritten and MUST be reloaded -- that IS the oracle's four extra `lw NN(sp)`.
 * Three per-row t-blocks give three independent live pseudos, gcc forwards all nine and
 * the fn comes out 4 insns SHORT.  Restoring the single block reproduces the reloads and
 * gates count-EXACT 56/56, but 72 LCS diffs vs this form's 62 (identical alpha-renamed
 * structural residual 33/56 either way), so the gate ledger keeps the 3-block form.  The
 * single-block variants are saved verbatim at scratch/hrz_1tblock.cpp (+ _v2, per-element
 * r-stores, also 72).  RE-OPEN LEAD from the 56/56 base: retail's nine r-values OUT-RANK
 * the t-triple (they take $v0/$v1/$a0-$a3, pushing the raw loads to $t0-$t2); ours is the
 * reverse.  allocno_compare is on a razor edge (t: 6 refs/~18 live = 0.67; r: 2 refs/~3
 * live = 0.67) -- a dial that LENGTHENS the t-triple's live range or SHORTENS the
 * r-values' flips the whole function.  Tried+FALSIFIED: per-element r-store (72),
 * mpsx.m[0][2]-before-[0][1] store order (76).
 * w42-a6 RE-MEASURED + one more falsification.  The kept 3-t-block form gates 62 at 52/56
 * insns; the SINGLE {t1,t2,t3} block spanning all three rows gates 72 but is COUNT-EXACT
 * 56/56 and reproduces the oracle's four `lw NN(sp)` reloads exactly (the SYM-faithful
 * shape).  NEW falsification from that count-exact base: grouping the r-blocks by SOURCE
 * ROW ({temp.m[0],m[1],m[2]} -> mpsx.m[0][0],m[1][0],m[2][0]) instead of by mpsx ROW = 76.
 * The oracle's reload PAIRING ((m[0],m[2]) then (m[3],m[5])) had suggested source-row
 * grouping; it does not hold.  Residual from the 56/56 base is the r-triple-vs-t-triple
 * local_alloc quantity order (retail's nine r values take $v0/$v1/$a0-$a3 and push the raw
 * loads to $t0-$t2; ours is the reverse) -- same live-length tie-break direction as the
 * flare.cpp two-mask rotation (see flare.cpp's w42-a6 block).  Gate ledger keeps the
 * 3-block form because 62 < 72, but the 56/56 single-block form is the better STRUCTURAL
 * base for a future permuter run.
 * w50-a5 -- THE MECHANISM, read off -dg/-dl for the count-exact 56/56 base; it is NOT an
 * allocno_compare razor at all.  The three t-pseudos are this fn's ONLY GLOBAL allocnos
 * (`;; 3 regs to allocate: 82 81 83`); `m` and all NINE r-values are decided by
 * LOCAL_ALLOC, which runs FIRST.  Our local qtys burn exactly FOUR hard regs (m=$a0, the
 * r-triples recycling $v0/$v1/$a1 because each triple dies before the next is born), so
 * the greg conflict line reads `81/82/83 conflicts: ... 2 3 4 5 29` and global.c's numeric
 * scan hands the t-triple the next free regs $a2/$a3/$t0.  RETAIL's r-values span SIX regs
 * (the SYM's per-row triples {$v1,$a0,$v0} {$a1,$v0,$v1} {$a2,$a3,$v0}), which blocks
 * $a2/$a3 too and pushes the raw loads down to $t0/$t1/$t2 = the SYM's t-triple.
 * ⇒ the reachable lever is NOT a t-side dial, and NOT the "lengthen the t-triple"
 * direction the w40 note suggests: with the CORRECTED QTY_CMP_PRI numerator
 * `floor_log2(refs)*refs - size`, a 2-ref 4-byte r-value is NEGATIVE (-2/live) while the
 * 6-ref t is POSITIVE (+8/live), so NO live-length dial can put an r above a t (r would
 * need >=4 refs just to go positive).  The lever is to make LOCAL_ALLOC burn SIX registers
 * on the r-values.  FALSIFIED this wave from the 56/56 base (all re-gated): read-only
 * fence on the r-triple before the stores 82 - after the stores 76 - split load from shift
 * 72 (neutral) - nine fn-scope r locals, shifts-then-stores 76 - rows 0+1 both computed
 * before either is stored (6 values nominally live) 72 (the scheduler serializes them).
 * From the 3-BLOCK base the same overlap shapes gate 62 (neutral) and 60 (nested blocks +
 * a fence keeping row-0's triple live through row-1) -- 60 beats the ledger's 62 but at
 * 52/56 insns, i.e. count-INEXACT pure scaffolding, so NOT taken.
 * NAMED NEXT ANGLE: instrument local_alloc itself (qtytrace.py / the [qty_compare] +
 * [find_free_reg] traces) to see WHY the three r-triples recycle instead of conflicting;
 * that decides whether a source shape exists at all or this is a sched1 ordering fixpoint
 * (in which case the w45 use-fence walked statement-by-statement is the instrument -- it
 * is what sealed Hrz_InitSky this wave). */
/* ===== w60-a6: THE w45 USE-FENCE WALK IS EXECUTED (the named next instrument above) =====
 * The count-exact 56/56 single-{t1,t2,t3}-block base was REBUILT from the w41 receipt
 * (scratch/hrz_1tblock.cpp is long gone -- scratch is gitignored; the base is simply the
 * three t-blocks below FUSED into one, re-defining t1/t2/t3 per row) and re-measures
 * EXACTLY 72 @56/56 as recorded.  Harness: scratchpad/w60a6/hrzwalk.py (regenerates the
 * whole r-block region with a read-only fence at statement position N, gates, always
 * restores; its pos=0 control reproduces the base byte-identically).
 * FULL 2-D SWEEP -- 18 positions x 4 operand sets, 27 gates, EVERY ONE count-exact 56/56
 * (so the fence is genuinely NON-BARRIER here, unlike the do{}while(0) wrappers):
 *   ops=r0 by position 1..18:  78 78 78 74 76 76 76 76 74 74 70 68 72 74 72 70 68 68
 *   pos 12: r2 68 . r0,r1,r2 72 . r1 72      pos 17: r2 72 . r0,r1,r2 70 . r1 72
 *   pos 18: r2 72 . r0,r1,r2 72 . r1 76      (control, no fence: 72)
 * FLOOR OF THE WHOLE SWEEP = 68, never lower, and the SHIPPED 3-block form below is 62.
 * ==> THE USE-FENCE WALK IS FALSIFIED FOR THIS FUNCTION.  Mechanically this is expected in
 * hindsight and the walk is what proves it: w50-a5 established the target is "make
 * LOCAL_ALLOC burn SIX hard regs on the r-values", i.e. a LIVENESS/conflict-set property,
 * and a read-only fence only adds REFS -- with the r-triples in three disjoint block
 * scopes each triple still dies before the next is born, so no ref count can create the
 * overlap.  (Same family as the belt's other blocked pair, Night_SetEnviroment and
 * Hud_BuildTimeSprites: the missing device is a ZERO-REF LIVE-RANGE change.)
 * ALSO FALSIFIED THIS WAVE, aimed straight at the six-register mechanism: rows 0 and 1
 * FUSED into one block (six distinct locals r0-r2/s0-s2) with a SIX-OPERAND read-only
 * fence between the six shifts and the six stores -- the strongest liveness device
 * available, forcing all six values live at one point = 80 @56/56, WORSE than the 72
 * control.  (w50 had already measured the un-fenced version of that shape at 72.)
 * REFINED READING OF RETAIL, for the next taker: the six regs are NOT six simultaneously
 * live values.  Retail's per-row triples are {$v1,$a0,$v0} {$a1,$v0,$v1} {$a2,$a3,$v0} --
 * $v0 recurs in ALL THREE and $v1 in two, so it is a STAGGERED overlap in which roughly
 * ONE value per row survives into the next row (that is what forces row 1 off $a0 onto
 * $a1 and row 2 onto $a2/$a3).  So the shape to hunt is not "six live at once" (measured
 * 80) nor "three disjoint triples" (72) but a ONE-VALUE-PER-ROW CARRY -- e.g. each row's
 * last shift computed before the previous row's last store.  Untried; it is the only
 * remaining source-shape hypothesis that matches the observed register map. */
/* ===== w63-a13 (2026-08-15): THE STAGGERED ONE-VALUE-PER-ROW CARRY IS EXECUTED AND
 * FALSIFIED, in both the plain and the FENCE-PINNED form.  62 STAYS (re-gated @52/56).
 * The r-half was rewritten flat with NINE distinct names (r0-r2 / s0-s2 / u0-u2 -- the
 * carry cannot be expressed with three sibling blocks reusing one name set) and the
 * stores interleaved so that N values of row K are still unstored when row K+1's first
 * shift is computed.  MEASURED (all re-gated, from BOTH bases):
 *     shipped 3-t-block base                                     62 @52/56
 *     count-exact single-t-block seed                            72 @56/56
 *     3-t + carry-1 (one value carried)                          62  BIT-IDENTICAL
 *     3-t + carry-2 (two values carried)                         62  BIT-IDENTICAL
 *     3-t + carry-1b (the row's LAST shift deferred instead)     62  BIT-IDENTICAL
 *     1-t + the same three carries                               72 / 72 / 72 (identical)
 * ⇒ THE SOURCE STATEMENT ORDER OF INDEPENDENT shift/store PAIRS IS CANONICALISED BY
 * sched1 -- six different interleavings produce byte-identical output, so a carry simply
 * CANNOT BE REQUESTED FROM C.  That closes the w60-a6 "only remaining source-shape
 * hypothesis" cleanly rather than leaving it open.
 * Then PINNED with the only zero-insn device that fixes issue position (w45 use fence):
 * a read-only fence on the carried value placed between the next row's shift and the
 * previous row's store -- 3-t + 1 fence 68, + 2 fences 74, 1-t + 1 or 2 fences 76 both.
 * The fences ARE zero-insn here (the count stays 52 / 56) but they do not create the
 * overlap either -- consistent with the w60 walk's floor of 68.
 * OPCODE CENSUS (new, cheap, and it names the whole gap): ours vs oracle differ in
 * EXACTLY ONE opcode -- `lw 14 v 18`.  The four missing instructions are precisely the
 * four `lw NN(sp)` reloads; nothing else in the multiset differs.
 * 🔴 LAW CORRECTION that re-opens the w50-a5 arithmetic below: gcc-2.8.1 QTY_CMP_PRI
 * (local-alloc.c:1727) is floor_log2(refs)*refs*SIZE/live -- size MULTIPLIES, there is no
 * `- size` term.  So the w50 claim "a 2-ref 4-byte r-value is NEGATIVE (-2/live) while
 * the 6-ref t is POSITIVE (+8/live), so NO live-length dial can put an r above a t" is
 * FALSE: an r is 1*2*4/live = 8/live and a t is 2*6*4/live = 48/live, i.e. an r at live 3
 * (2.67) already TIES a t at live 18 (2.67).  The live-length dial is NOT excluded by the
 * formula.  It is excluded by the stronger fact just proved above -- source order does not
 * reach the liveness at all.  Next taker: attack it at the RTL layer (instrumented-cc1
 * [qty_compare] / [find_free_reg] traces on the 56/56 base), not with more spellings.
 * Harness: scratchpad/w63a13/hprobe.py + hprobe2.py (composable, always restores). */
/* ===== w64-a13 (2026-08-15): THE RE-PRICING UNDER THE CORRECTED FORMULA IS DONE, and it
 * yields a BOUNDING CERTIFICATE rather than a dial.  62 STAYS (re-gated @52/56).
 * Dumped the SHIPPED 3-block form with `tools/rtl_dump.py recon/game/psx/hrzsku.cpp -dg -dl`
 * and priced every quantity with QTY_CMP_PRI = floor_log2(refs)*refs*SIZE/live:
 *     m (the param ptr)  p80  refs=10 live=34  0.88
 *     the t-values       p81..p92  refs=2-3 live=4..24  0.125 .. 0.50
 *     the NINE r-values  p93/94/95 p99/100/101 p105/106/107
 *                        refs=2 live=2  -> pri 1.0000, ALL NINE
 * TWO facts fall straight out, and both are new:
 *  (1) 🔴 **THIS FUNCTION HAS NO GLOBAL ALLOCNOS AT ALL.**  The whole body is one basic
 *      block, every quantity is tagged `in block 0`, the .greg carries no
 *      `;; N regs to allocate:` line and its `Register dispositions:` section is EMPTY.
 *      => allocsim.py / reqdelta.py / multidial.py (global.c replicas) can NEVER apply
 *      here, and neither can any dial that works through global.c -- the floor_log2
 *      REF-STEP family, the copy-preference killers, the caller-save retry.  Every
 *      instrument this campaign has for register handouts is out of scope by construction;
 *      only local-alloc instruments (qtytrace / the [qty_compare]+[find_free_reg] traces)
 *      can see this function.  (w50-a5 reported "3 global allocnos" -- that was the
 *      count-exact SINGLE-t-block form, not the shipped one; the shipped form has none.)
 *  (2) the nine r-values are TIED AT THE QSORT MAXIMUM (refs=2, live=2 => pri exactly
 *      1.0000, the highest in the function).  A tie at the top means no ref/live dial can
 *      reorder them RELATIVE TO EACH OTHER -- any spelling that changes one changes all
 *      nine the same way -- and the register they each receive is decided by conflicts,
 *      not by order, since they are pairwise DISJOINT.  This is the formula-level restate-
 *      ment of the w63 result (source order is canonicalised by sched1) and it closes the
 *      "the corrected formula re-opens the live-length dial" lead: the dial is not
 *      excluded by a sign error any more, it is excluded because the nine values are tied
 *      and non-conflicting, so priority is not the axis at all.
 * ⇒ THE ONLY REMAINING AXIS IS THE CONFLICT SET (make row K+1's r-values conflict with
 * row K's), and every source device for that is now falsified across w41/w50/w60/w63/w64.
 * NEXT TAKER: instrumented-cc1 [find_free_reg] on the 56/56 base, or the permuter -- do
 * NOT spend another wave on spellings, and do NOT reach for allocsim/reqdelta here. */
/* ===== 🔴 w71-A4 (2026-08-21): THE BASIN ABOVE WAS THE WRONG ONE.  The shipped THREE
 * t-blocks contradict the SYM and cost the four `lw NN(sp)` reloads; this pass replaces
 * them with the ONE t-block the SYM records, which is COUNT-EXACT and OPCODE-CENSUS-EXACT.
 *   shipped 3-t-block form   62 diffs @ 52/56   (4 insns SHORT, `lw 14 v 18`)
 *   SYM 1-t-block form       72 diffs @ 56/56   (rove_op.py: NO opcode row at all) <- LANDED
 * WHY THE 1-BLOCK FORM IS RETAIL'S (two independent proofs, neither used by the earlier
 * passes): (a) `symblk.py` @40e990 shows exactly FOUR sibling blocks -- ONE {t1,t2,t3}
 * (t1=$t1,t2=$t0,t3=$t2) and THREE {r0,r1,r2}; three sibling t-blocks would emit THREE
 * `90 Block start` records, and they do not exist.  (b) `sldall.py` gives the retail
 * STATEMENT MAP, gap-free: 994-1011 = eighteen one-per-line statements (t1/t2/t3 loaded
 * then stored, RE-USING the same three names per row) and then exactly THREE lines --
 * 1013/1014/1015 -- each of which emits a whole mpsx ROW (r0/r1/r2 loaded, shifted and
 * `sh`-stored: line 1013 -> sp+0/2/4, 1014 -> 6/8/10, 1015 -> 12/14/16).  The reloads are
 * the direct consequence: with one t-block the row-2/row-3 `t` values are re-set (a
 * REG_DEP_OUTPUT chain), so cse can no longer forward temp.m[0]/[2]/[3]/[5] and the
 * oracle's `lw 32/40/44/52(sp)` reappear -- all four, in the right places.
 * THE 72 DECOMPOSES INTO TWO NAMED, MEASURED HALVES (the reason to prefer this basin):
 *  (1) 32 diffs = the THREE GLOBAL ALLOCNOS (the t's).  `-dg` now prints them (the w64
 *      "this function has NO global allocnos" receipt was measured on the 3-block form and
 *      does NOT hold here): `;; 3 regs to allocate: 82 81 83`, each conflicting with hard
 *      regs 2 3 4 5 29, so find_reg's ascending scan hands out 6/7/8; retail's conflict set
 *      also contains 6 and 7, so the same scan hands out 8/9/10 = SYM's $t1/$t0/$t2 in the
 *      same 82,81,83 priority order.  PROVEN by a diagnostic clobber INSIDE the t live
 *      range (`__asm__("" : : : "$6","$7")` between `t3 = m->m[2];` and `temp.m[0] = t1;`):
 *      72 -> 40, and insns 0-11 + 44-55 then match the oracle BYTE-FOR-BYTE.  Placement is
 *      load-bearing exactly as w69-20B says: the same clobber at fn top, or in the dead gap
 *      between two rows, is INERT (72) -- the t pseudos die at each row's store.
 *      NOT SHIPPED: it is scaffolding for a symptom.  $6/$7 are occupied in retail because
 *      retail's NINE r-values occupy $v0,$v1,$a0,$a1,$a2,$a3 (SYM: {v1,a0,v0} {a1,v0,v1}
 *      {a2,a3,v0}); ours occupy only $v0,$v1,$a1.  Fix (2) and (1) falls out for free.
 *  (2) 40 diffs = the r-value SCHEDULE.  Retail issues the four reloads EARLY (sp+32 and
 *      sp+40 at clocks 12/13, sp+44 and sp+52 at 23/24), holds six shifted values live and
 *      batches the `sh` stores at 26-29/36/40-43; ours computes each r just-in-time next to
 *      its own `sh`, so every r-qty is 2 insns long, they all share $v0/$v1, and post-RA
 *      anti-deps then freeze the order (`-fno-schedule-insns2` is a NO-OP here, 72 both
 *      ways -- the order is sched1's).  The lreg dump shows all four reloads with a SINGLE
 *      dependence (their defining store) and no anti-dep on anything else, i.e. they are
 *      free to rise; sched1 simply declines.
 * FALSIFIED THIS PASS (all re-gated on the 56/56 base, ALL BYTE-IDENTICAL at 72 unless
 * noted -- the r-block spelling axis is CLOSED): shift-then-store vs store-then-shift
 * interleave; `r = temp.m[k]` with the `>>4` moved into the mpsx store; cast-int deref
 * `*(int *)((char *)&temp + K)` for the reads; `int *mm = (int *)m` for the m-loads;
 * `short *pm = (short *)&mpsx` for the stores; both pointer views together; a $6/$7
 * clobber at fn top or in a dead t-gap; the identity-launder form of it (71 @57, +1 insn).
 * NEXT TAKER: this is now ONE named phenomenon -- make sched1 hoist the four reloads (the
 * 6-live-value shape), and the allocno half (1) resolves itself.  Instrument: the .lreg
 * dump's post-sched1 insn ORDER (tools/rtl_dump.py -dl), not allocsim.  Harness:
 * scratchpad/A4/A4_probe.py + A4_gen.py (variant files v_*.txt, always restores). */
/* ===== 🏆 W72-A4 (2026-08-22): 72 STAYS SHIPPED @56/56, BUT THE 5-WAVE "SIX-LIVE
 * R-VALUES" MECHANISM IS FINALLY REPRODUCED FROM C -- and it is a LIVENESS device, not a
 * priority one, exactly as w60/w64 predicted but never achieved.
 * THE DEVICE (measured 66 @56/56, count- and opcode-census-exact; full source preserved at
 * scratchpad/W72_A4/KEEP_h9_66diff_variant.py):
 *     ONE {t1,t2,t3} block, unchanged (SYM-faithful), THEN a single block declaring NINE
 *     distinct r names -- {r0,r1,r2} {s0,s1,s2} {u0,u1,u2}, one triple per mpsx ROW in the
 *     same statement order as the shipped form -- and ONE 6-OPERAND READ-ONLY FENCE
 *         __asm__("" : : "r"(r0),"r"(r1),"r"(r2),"r"(s0),"r"(s1),"r"(s2));
 *     placed AFTER row 2's three `sh` stores (i.e. at the very end of the r region).
 * WHAT IT BUYS -- the schedule half (the "40 diffs" of the w71 decomposition) COLLAPSES:
 *   ours 12 `lw a2,32(sp)` / 13 `lw v0,40(sp)` vs oracle 12 `lw v1,32(sp)` / 13 `lw a2,
 *   40(sp)`; ours 22 `lw a0,44(sp)` vs oracle 23 -- i.e. sched1 now HOISTS the reloads in
 *   PAIRS and holds six shifted values live, which is retail's shape.  All that remains at
 *   66 is the register NAMING (our t-triple lands $a3/$v1/$t1, retail's $t1/$t0/$t2).
 *   => w64's verdict "the only remaining axis is the CONFLICT SET, and every source device
 *   for it is falsified" is REFUTED: the conflict set IS source-reachable -- the missing
 *   ingredient was CROSS-BLOCK VISIBILITY.  Every prior fence walk (w60's 18 positions x 4
 *   operand sets, w63's carry fences) fenced values from INSIDE their own sibling block,
 *   where each triple still dies before the next is born; nine names in ONE scope is what
 *   lets a fence reach BACKWARDS over two rows.
 * WHY IT IS NOT SHIPPED: the SYM (@40e990, symblk.py) records exactly FOUR sibling blocks
 *   -- one {t1,t2,t3} and three {r0,r1,r2} -- so nine fn-scope names contradict retail's
 *   own declaration structure, and w71-A4 deliberately chose the SYM-faithful basin (72)
 *   over a lower-scoring one (62).  Landing 66 would trade that precedent for 6 LCS diffs
 *   of scaffolding.  -> ORCHESTRATOR/USER DECISION; the recipe is exact and re-gateable.
 * OPERAND/POSITION SWEEP around the device (all re-gated, all count-exact 56/56):
 *   6 ops after row-2 stores ("end")  66   <- minimum
 *   6 ops between row-2 shifts+stores 82 · 6 ops before row-2's first shift 80
 *   {r0,r1,r2,s0,s1} 66 · {r0,r1,r2,s0,s2} 70 · {r0,r1,r2,s1,s2} 70
 *   {r0,r1,s0,s1,s2} 74 · {r0,r2,s0,s1,s2} 76 · {r1,r2,s0,s1,s2} 74
 *   best 4-operand set {r0,r1,s0,s2} 68; every other 4-set 70-76
 *   row-0 triple only 72/78/74 (end/mid/pre) · row-1 triple only 74/82/72
 *   one-value-per-row carry {r0} then {s0} 68 · nine names, NO fence 72 (= the control,
 *   so the names alone are inert -- the fence is the whole device)
 * ALSO FALSIFIED THIS PASS (all re-gated @56/56 unless noted):
 *   - R-BLOCK ORDER is a CLOSED axis: all six permutations of the three mpsx-row blocks
 *     measured 72 / 78 / 80 / 80 / 76 / 76 (012 = the shipped order is the minimum).
 *   - reusing ONE fn-scope {r0,r1,r2} set across all three rows (no braces, which makes
 *     them GLOBAL allocnos via REG_N_DEATHS==3): 82.
 * MECHANISM NOTE, read off local-alloc.c:471-477 (gcc-2.8.1 source): a pseudo reaches
 * local_alloc only if `REG_BASIC_BLOCK(i) >= 0 && REG_N_DEATHS(i) == 1`.  The single
 * {t1,t2,t3} block sets each name three times, so REG_N_DEATHS==3 and all three t's are
 * forced to GLOBAL alloc -- which runs AFTER local_alloc and therefore only ever sees what
 * the local qtys left behind.  That is the whole "32-diff allocno half": it can never be
 * fixed from the t side, only by making local_alloc consume $a2/$a3, which is precisely
 * what the six-live device does.
 * NEXT TAKER: either (a) land the 66 device if the user accepts the SYM deviation, or
 * (b) find a form that reaches the same conflict set with three sibling {r0,r1,r2} blocks
 * (nothing visible cross-block except `temp`/`mpsx` MEMs -- an 'm'-operand fence is inert
 * on frame-relative MEMs per 21A(5), so this needs a genuinely new device), or (c) the
 * instrumented-cc1 [find_free_reg] trace on the 66 form to price the last naming step.
 * Harness: scratchpad/W72_A4/probe.py + gen_hrz{,2,3,4}.py. */
/* ===== 🏆🏆 W74-A4 (2026-08-23): **SEALED -- PASS 56/56, SCAFFOLDING-FREE**, on the
 * SYM-faithful ONE-{t1,t2,t3}-block base.  Five waves of "allocator floor" verdicts fall to
 * ONE token: SPLIT THE LOAD FROM THE SHIFT in each r-block --
 *     r0 = temp.m[k];  r1 = temp.m[k+3];  r2 = temp.m[k+6];
 *     r0 = r0 >> 4;    r1 = r1 >> 4;      r2 = r2 >> 4;
 *     mpsx.m[k][0] = (short)r0; ... (methodology 3.12 #15b, "split the load from the
 * decrement", applied to a shift).  With the three loads issued as their own statements
 * sched1 hoists the four `lw NN(sp)` reloads into the t-region exactly like retail, six
 * shifted values are live at once, local_alloc consumes $a2/$a3, and the t-triple falls to
 * the SYM's $t1/$t0/$t2 -- i.e. the "32-diff allocno half" resolves ITSELF once the 40-diff
 * schedule half is fixed, precisely as the w71 receipt predicted.
 * 🔴 THE SPELLING WAS ON THE w71 FALSIFIED LIST ("`r = temp.m[k]` with the `>>4` moved into
 * the mpsx store ... no change at all") -- because it was measured in the OLD basin.  Here
 * it PASSes.  04Z (falsifications are basin-relative) at its strongest so far: the basin
 * that unlocked it was a DIAGNOSTIC clobber, and once the split landed the clobber was
 * measured UNNECESSARY and REMOVED (04E: always gate the natural body without the device).
 * LADDER (all re-gated this pass, count-exact 56/56 throughout):
 *     SYM-faithful base (w71 shipped)                                   72
 *     + "$6","$7" clobber inside the t range (diagnostic only)          40
 *     + load/shift split, ALL THREE r-blocks                            PASS  <- SHIPPED
 *       (split in block 0 only 30; `(short)(r0 >> 4)` in the store 40)
 *     + the same split WITHOUT the clobber                              PASS  <- device dropped
 *     the W72 KEEP recipe (9 names + 6-op fence) + the clobber          42  (retired)
 * The 66-diff nine-name device is therefore RETIRED, not merely held: the SYM-faithful
 * structure both scores better and seals.
 * (Kept for the record -- the clobber mechanism, which is still the right tool when an
 * allocno half is genuinely stranded: the three t pseudos are GLOBAL allocnos
 * (REG_N_DEATHS==3, local-alloc.c:471-477), so global.c's ascending scan hands them
 * whatever local_alloc left; denying $a2/$a3 to the quantities live in the t range adds
 * exactly retail's two missing conflicts, and PLACEMENT is the dial -- at fn top or in a
 * dead gap it is inert.)
 * ===== (the pre-seal analysis of this pass follows) =====
 * 72 -> 40 @56/56 ON THE SYM-FAITHFUL BASE, AND THE 66 DEVICE IS SUPERSEDED.  The w71 decomposition (32 diffs allocno + 40 diffs schedule) is
 * confirmed exactly: the ALLOCNO half is a pure AVAILABILITY loss and it is reachable with
 * the campaign's standard zero-insn device instead of nine SYM-contradicting names.
 * THE DEVICE (shipped):  __asm__("" : : "i"(0) : "$6","$7");  placed between `t3 = m->m[2];`
 * and `temp.m[0] = t1;`, i.e. INSIDE the t live range (22B(1): a clobber denies a register
 * only to quantities live AT THAT INSN -- the same clobber at fn top, or in the dead gap
 * between two rows, is INERT at 72, re-measured this pass).
 * WHY IT IS THE RIGHT SHAPE, not a symptom patch: the three t pseudos are GLOBAL allocnos
 * (one block re-sets each name three times => REG_N_DEATHS==3 => local-alloc.c:471-477
 * rejects them), so they are handed out by global.c's ASCENDING NUMERIC SCAN over whatever
 * local_alloc left free.  Retail's r-values occupy $v0,$v1,$a0-$a3 at that point and ours
 * only $v0,$v1,$a0,$a1, so retail's t-conflict set contains 6 and 7 and ours does not --
 * the clobber ADDS exactly those two conflicts and nothing else.  Insns 0-11 and 44-55 are
 * byte-identical after it; the SYM's t-triple ($t1/$t0/$t2) lands verbatim.
 * MEASURED THIS PASS (all re-gated, count-exact 56/56 unless noted):
 *     SYM-faithful base (shipped)                                72
 *     + "$6","$7" clobber inside the t range (void form)         40   <- SHIPPED
 *     + the same as a non-volatile launder on t1 / t3            69 @57 / 73 @57  (+1 insn)
 *     + clobber before row 2 / before row 3                      72 / 74
 *     the W72 KEEP recipe (9 names + 6-op fence) + this clobber  42   <- the 66-device
 *         basin is now WORSE than the SYM-faithful one; it is retired, not held.
 * RE-PRICED IN THE NEW BASIN (04Z) and all >= 40: per-row shift/store interleave 40
 * (BIT-IDENTICAL), a 3-operand read-only fence at each r-block end 76, one at block-0 only
 * 74, a 1-operand fence in blocks 0+1 50, r-block order 102 permuted 80.
 * REMAINING = THE 40-DIFF SCHEDULE HALF, unchanged and still the whole story: retail
 * issues the four `lw NN(sp)` reloads EARLY (clocks 12/13 and 23/24) and holds six shifted
 * values live; ours computes each r just-in-time.  The opcode census is EXACT (no `lw`
 * deficit any more), so this is purely sched1 issue position inside one basic block.
 * NEXT TAKER: the .lreg post-sched1 insn order (tools/rtl_dump.py -dl) or the instrumented
 * cc1 [sched_pick] trace -- NOT more spellings (that axis is closed in two basins now).
 * Harness: scratchpad/W74_A4/probe.py + gen_hm{,2}.py (e_hm_p*, e_hm2_q*). */
void HrzSetPsxMatrix(matrixtdef *m)
{
  MATRIX mpsx;
  matrixtdef temp;

  /* MATCH: the SYM (@40e91f) has FOUR sibling blocks -- ONE {t1,t2,t3} block
   * (regs $t1/$t0/$t2, i.e. the SAME three names reloaded per source row, which
   * is why the oracle reuses exactly those three load registers for all three
   * rows) and THREE {r0,r1,r2} blocks whose register triples map 1:1 onto the
   * mpsx ROWS: {$v1,$a0,$v0}=m[0][0..2], {$a1,$v0,$v1}=m[1][0..2],
   * {$a2,$a3,$v0}=m[2][0..2].  So the shift/store half is grouped BY mpsx ROW
   * (temp.m[k], temp.m[k+3], temp.m[k+6]), not by temp index. */
  {
    /* w71-A4: ONE block, the three names RE-USED per row -- SYM @40e990 records exactly
       one {t1,t2,t3} Block start, and the SLD maps 994..1011 one statement per line. */
    int t1;
    int t2;
    int t3;

    t1 = m->m[0];
    t2 = m->m[1];
    t3 = m->m[2];
    temp.m[0] = t1;
    temp.m[1] = -t2;
    temp.m[2] = t3;
    t1 = m->m[3];
    t2 = m->m[4];
    t3 = m->m[5];
    temp.m[3] = t1;
    temp.m[4] = -t2;
    temp.m[5] = t3;
    t1 = m->m[6];
    t2 = m->m[7];
    t3 = m->m[8];
    temp.m[6] = t1;
    temp.m[7] = -t2;
    temp.m[8] = t3;
  }
  {
    /* MATCH (W74-A4, 40 -> PASS): SPLIT THE LOAD FROM THE SHIFT (methodology 3.12 #15b).
       Three loads as their own statements let sched1 hoist the four `lw NN(sp)` reloads of
       temp.m[0]/[2]/[3]/[5] up into the t-region the way retail does, so six shifted values
       are live at once, local_alloc burns $a2/$a3, and the t-triple lands on the SYM's
       $t1/$t0/$t2 -- the "allocno half" resolves itself.  The fused `r0 = temp.m[0] >> 4;`
       form is the 5-wave 72-diff near-miss.  Do NOT re-fuse. */
    int r0;
    int r1;
    int r2;

    r0 = temp.m[0];
    r1 = temp.m[3];
    r2 = temp.m[6];
    r0 = r0 >> 4;
    r1 = r1 >> 4;
    r2 = r2 >> 4;
    mpsx.m[0][0] = (short)r0;
    mpsx.m[0][1] = (short)r1;
    mpsx.m[0][2] = (short)r2;
  }
  {
    int r0;
    int r1;
    int r2;

    r0 = temp.m[1];
    r1 = temp.m[4];
    r2 = temp.m[7];
    r0 = r0 >> 4;
    r1 = r1 >> 4;
    r2 = r2 >> 4;
    mpsx.m[1][0] = (short)r0;
    mpsx.m[1][1] = (short)r1;
    mpsx.m[1][2] = (short)r2;
  }
  {
    int r0;
    int r1;
    int r2;

    r0 = temp.m[2];
    r1 = temp.m[5];
    r2 = temp.m[8];
    r0 = r0 >> 4;
    r1 = r1 >> 4;
    r2 = r2 >> 4;
    mpsx.m[2][0] = (short)r0;
    mpsx.m[2][1] = (short)r1;
    mpsx.m[2][2] = (short)r2;
  }
  gte_SetRotMatrix(&mpsx);
}

/* ---- HrzSetPsxTranslation__FP8coorddef  [HRZSKU.CPP:1021-1028] SLD-VERIFIED ---- */
void HrzSetPsxTranslation(coorddef *t)
{
  MATRIX mpsx;

  mpsx.t[0] = ((int *)t)[0] >> 10;
  mpsx.t[1] = ((int *)t)[1] >> 10;
  mpsx.t[2] = ((int *)t)[2] >> 10;
  gte_SetTransMatrix(&mpsx);
}

/* ---- Hrz_RotProj16__FiP7SVECTORPiP7DVECTOR  [HRZSKU.CPP:1032-1045] SLD-VERIFIED ---- */
void Hrz_RotProj16(int n, SVECTOR *s, int *z, DVECTOR *p)
{
  for (n = n - 1; n != -1; n--) {
    gte_ldv0(s);                  /* load vx,vy,vz into VXY0/VZ0 */
    gte_rtps();                   /* rotate / transform / perspective */
    s = s + 1;
    gte_stsxy2(p);                /* store screen XY -> DVECTOR (SXY2) */
    p = p + 1;
    gte_swc2(0x1b, z);            /* store screen Z (MAC3) -> int  [no canonical macro] */
    z = z + 1;
  }
}

/* ---- Hrz_SetDitheringPrim__Fii  [HRZSKU.CPP:1050-1055] SLD-VERIFIED ---- */
void Hrz_SetDitheringPrim(int dither,int otz)

{
  DR_MODE *prim;
  u_int *prev_pkt_slot; /* SYM-CODEGEN-CARRIER: prev_pkt_slot -- shared indexed palette cell; direct expressions are FAIL 24 (36/34) */
  u_int prev_val; /* SYM-CODEGEN-CARRIER: prev_val -- removing the staged palette word is FAIL 4 (34/34) */

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
 * ---- w53-a5 (2026-08-09) TRIAGE, no lever landed: re-gated 374 @458/458 (count EXACT).
 * posdiff: alpha-renamed LCS 272/458, structural residual 186; first-use orders agree for
 * the first TWELVE registers (s0 v0 v1 s4 s3 s2 s1 a0 a1 a2 a3 t0) and then differ by a
 * single 7-CYCLE over the caller-saved pool: ours (t7 t3 t2 t1 t5 t6 t9 t8 t4) vs oracle
 * (t4 t3 t2 t6 t7 t9 t8 t5 t1), i.e. t7->t4->t1->t6->t9->t8->t5->t7 with t3/t2 fixed.
 * ⚠️ chunkdiff's two big "replace" runs (ours[300:304] vs oracle[311:409] = 98, and
 * ours[338:433] vs oracle[432:433] = 95) are LCS ALIGNMENT ARTIFACTS of the three
 * near-identical prim templates, NOT a block-order defect: the physical block order is
 * ALREADY correct -- GT4 (li 0xC / 0x3C) at oracle insn ~337, FT4 (0x9 / 0x2C) at ~391,
 * G4 (0x8 / 0x38) at ~443, matching our if(type==1){if(flags&0x20){GT4}else{FT4}}else{G4}
 * layout.  So do NOT spend a wave on a switch/block-order rewrite here (the w42 "PHYSICAL
 * BLOCK ORDER dominates far-miss monsters" lever does not apply to this fn).
 * ⇒ the whole residual really is the 7-cycle the w50-a5 note names, and its root is one
 * rung below the invariants (retail's `temp` = SYM REG $9 = $t1, ours $t0).  NEXT: run
 * allocsim/reqdelta --want "temp=$t1" on this loop rather than any further source
 * reshaping -- predict-before-probe, per the w45 instrument-stack rule.
 * ---- (original wave-13 receipt follows) ----
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
 * w40-a8: the first-RMW OR operands were swapped to `slot[-2] & 0xffffff | *(u_int *)prim
 * & 0xff000000` in all THREE prim blocks -- that flips the loop.c hoist ORDER of the two
 * mask constants to the oracle's (0xFFFFFF materialized BEFORE 0xFF000000), the same
 * two-constant hoist-order tie the flare small-flare family and Sky_RenderStars carry.
 * Gate unchanged (393, LCS non-monotone) but the preheader now differs from the oracle in
 * exactly ONE position: ours emits the 0x1F800004 (Render_gPacketPtr address) lui/ori pair
 * BEFORE the gSkyColor %lo add, the oracle AFTER; everything downstream is the
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
  /* MATCH (w49-a5, 390 -> 377): CALL-CROSSING BASE HOIST.  The oracle's mask is
     $801f0000 (ra + s0..s4 = SIX saves, SYM fsize 72) but our build only ever needed FIVE
     (mask $800f0000): retail parks the loop-invariant `&gHorizonPixmap` in $s3, we put it
     in the caller-saved $t9 because the sky loop contains no calls, so global.c's numeric
     scan finds a free t-reg first.  Assigning the base into a local BEFORE the Flare_Sun
     guard makes the pseudo CALL-CROSSING, which forces it into a callee-saved reg -- and
     that one decision lands the whole prologue byte-exact (s1/s4/s2 scratchpad literals in
     retail's registers) and moves posdiff's structural residual 275 -> 177 / alpha-LCS
     183 -> 281.  Position sweep (all re-gated): before Flare_Sun 377 · decl-with-init 380
     (460 insns) · before the dither guard 381 · at the scratchpad init 388 (460) · just
     before the i-loop 390 (458, no s-reg at all).
     ⚠️ HONEST CAVEAT -- this local is NOT in the SYM (@40ed4b lists exactly pSkyMesh,
     pSkyZ, i, otz_old, pshift, sd at fn scope), so retail's $s3 is a COMPILER temp
     hoisted by loop.c into the preheader, not a source variable.  The price is the +1
     insn: ours materializes `lui %hi` before the guard and sinks the `addiu %lo` into its
     delay slot (459 vs 458), where retail emits both in the loop preheader.  NAMED
     FOLLOW-UP: find the SYM-faithful dial that exhausts the caller-saved pool at the
     preheader (our loop body is 2 insns richer than retail's, which is what leaves a
     t-reg free) and then DELETE this local.
     STATE FROM THE NEW BASIN (read off the dumps; SUPERSEDES the stale "ours emits the
     0x1F800004 pair BEFORE the gSkyColor %lo add" line in the block comment above -- both
     preheaders now emit their invariants in the SAME order): the residual is a pure
     REGISTER PERMUTATION over the 9 hoisted invariants, and its root sits one rung lower --
     retail's `temp` is SYM REG $9 = $t1, ours lands in $t0, so retail has $t1 already
     occupied when the invariants are handed out and every one of them shifts up a slot
     (retail $t3/$s0/$t2/$t6/$t7/$t9/$t8/$t5 vs ours $t2/$t7/$t1/$t5/$t6/$t8/$s0/$t4).
     ⇒ the next dial is whatever retail parks in $t0 ahead of `temp`, NOT the invariants.
     ===== w71-A4 (2026-08-21): 370 STAYS @458/458.  The "what parks in $t0" question is
     ANSWERED and the reorg half of the head divergence is SOLVED-BUT-NOT-LANDED.
     (a) WHERE THE DIFF STARTS (sbs): insns 0..129 are byte-identical; the first divergence
         is the `TrackSpec_gSpec.skyspec.flags & 4` guard's DELAY SLOT.  Retail's slot holds
         `addu t4,zero,zero` (= `i = 0`) and the SAME insn appears again at the preheader --
         the reorg EAGER STEAL + retarget signature (w47 12F/a2 MatchSample): the branch
         skips the Flare_Sun block and lands one insn PAST the preheader's first insn, so
         the fall-through path keeps its own copy.  OURS fills that slot by a SIMPLE
         BACKWARD FILL with the `addiu s3,v1,0` half of `hp = gHorizonPixmap;` (its `lui`
         sits above the branch) -- because that assignment is written ABOVE the guard, so a
         candidate exists and fill_simple_delay_slots never reaches the eager steal.
     (b) MEASURED (all re-gated, ours/oracle insns; harness scratchpad/A4/A4_probe.py):
           base (shipped)                                  370 @458
           `i = 0;` moved above `spec = ...`               370 @458  BIT-IDENTICAL
           hp assignment moved below the guard, i=0 first  367 @459
           i=0 first, THEN hp, THEN spec                   369 @457  <- steal CORRECT
           the same + spec inlined (no `spec` local)       372 @458  <- steal CORRECT
           spec inlined only / hp dropped only / both      373 @459 / 367 @459 / 386 @458
         None is a net win, so nothing landed; but the `i=0`-first + hp-after ordering DOES
         reproduce retail's stolen+duplicated `addu tN,zero,zero` pair exactly.
     (c) THE DOMINANT RESIDUAL IS A ONE-SLOT SHIFT OF THE WHOLE t-BAND (SYM: i=$t4,
         temp=$t1; ours i=$t3, temp=$t0), and retail's $t0 is now identified from the
         oracle itself: `800D0E60 lw $t0,%gp_rel(Sky_gTrackSpec)($gp)`, a BLOCK-LOCAL cse
         temp born at a branch target INSIDE the loop and live to 800D0FF0 (->type,
         ->flags, ->frontcolors[0]); local_alloc serves it before the fn-scope pseudos.
         🔑 With `spec` inlined our build emits that load AT THE IDENTICAL POSITION but
         local_alloc gives it $a3 (side_by_side line 273: ours `lw a3,0(gp)` / oracle
         `lw t0,0(gp)`), i.e. $a3 is still FREE across that range in ours and was NOT in
         retail.  => the open dial is "what occupies $a0-$a3 across .L800D0E60 in retail",
         NOT the spec caching and NOT the invariant list; that half is settled.
     ===== W72-A4 (2026-08-22): 370 STAYS @458/458.  The w71 open dial is now PRICED
     EXACTLY -- it is a REGISTER-POOL ARITHMETIC problem, not a spelling one -- and the
     reorg half is reproduced byte-for-byte in a probe.
     (a) THE PREHEADER IS AN EXACT COUNTING PROBLEM.  Both builds emit TEN values around
         the Flare_Sun guard.  Retail: i=$t4, hp=$s3, and the eight invariants
         $t3/$s0/$t2/$t6/$t7/$t9/$t8/$t5 -- i.e. retail's caller-saved pool is EXHAUSTED at
         $t2..$t9 and TWO values overflow into callee-saved ($s0 and $s3).  Ours: the same
         ten, but our pool still has $t1 free (retail's $t1 holds `temp`, and retail's $t0
         holds the in-loop Sky_gTrackSpec cse temp), so nothing overflows past $s0 and `hp`
         lands in a t-reg.  local_alloc runs FIRST: retail's TWO block-local qtys ($t0 cse
         temp + $t1 `temp`) are what starve global.c.  Ours only ever creates ONE ($t0
         `temp`); our cse temp takes $a3, which is still free.
         => THE DIAL IS: make local_alloc's ascending scan skip $a0-$a3 for the
         Sky_gTrackSpec temp so it lands in $t1.  Everything else follows mechanically.
     (b) THE REORG EAGER STEAL IS SOURCE-REACHABLE (new, and it was the w71 "steal
         CORRECT" note made exact).  Moving `hp = gHorizonPixmap;` BELOW the Flare_Sun
         guard removes the simple-backward-fill candidate, and reorg then steals + retargets
         the preheader's first insn exactly like retail.  MEASURED, all re-gated:
           shipped                                                 370 @458
           hp below the guard, i=0 first in the preheader           367 @459   <- steal +
             `hp` in $s3, and insns 136..144 are BYTE-IDENTICAL to the oracle
             (`addu tN,zero,zero` in the slot AND duplicated at the preheader head,
              then `lui v0,0; addiu s3,v0,0`).  The ONLY extra insn is the hoisted
              `lw tN,0(gp)` for the `spec` cache.
           ...the same with hp/spec/i=0 permuted 6 ways              367 @459 ALL IDENTICAL
             => preheader STATEMENT ORDER is canonicalised (w63 law re-confirmed here).
           hp below guard + `spec` INLINED (no cache)                386 @458   <- count
             EXACT and the steal still correct, but `hp` falls back to $t9 (the pool has
             room again) and the s-band rotates: 89 fewer LCS matches than 367's shape.
           `i = 0;` moved ABOVE the guard                       412 @458 / 390 @460
             => WRONG: i then crosses the Flare_Sun call and is forced CALLEE-SAVED ($s1),
             which rotates the whole function.  `i = 0;` must stay in the preheader.
     (c) SO THE THREE HALVES ARE NOW SEPARATELY SOLVED-OR-PRICED: the eager steal (reachable,
         costs the `spec` hoist), `hp` in $s3 (falls out of the steal shape), and the
         one-slot t-band shift (needs the $a0-$a3 availability device of (a)).  Nothing was
         landed because no single combination beats 370 yet -- 367 is count-INEXACT (+1)
         and 386 is count-exact but LCS-worse.  The winning combination is
         `hp below the guard` + `spec inlined` + a device that occupies $a3 across
         .L800D0E60..800D0FF0, which should recover both the missing insn and the band.
     NEXT TAKER: read the instrumented-cc1 [find_free_reg] trace (C:/Temp/nfs4-instr-cc1
     cc1plus-ecoff) for the block at .L800D0E60 on the `spec`-inlined form and identify the
     value retail keeps in $a3 there; that is the last unknown in this function.
     Harness: scratchpad/W72_A4/probe.py + gen_sky{,2}.py (e_sk_a..k, e_sk_a2).
     ===== 🏆 W74-A4 (2026-08-23): 370 -> 150 @458/458 COUNT-EXACT (the first 143 insns
     are BYTE-IDENTICAL, positional mismatches 81/458), AND THE W72 (a) COUNTING PROBLEM
     IS SOLVED.
     BOTH scaffolding locals (`hp`, `spec`) are DELETED -- the SYM-faithful head is now the
     SHIPPED one -- and the whole head + preheader + the `Sky_gTrackSpec` load are
     BYTE-IDENTICAL to the oracle (insns 0..~150), including retail's exact register band
     (i=$t4, temp=$t1, the in-loop spec temp=$t0, hp-base=$s3 hoisted by loop.c itself, and
     the eight invariants $t2/$t3/$t5..$t9).
     THE DEVICE (the w72 "$a0-$a3 availability" ask, answered): with `spec` INLINED the
     Sky_gTrackSpec value is a GLOBAL allocno spanning .L800D0E60..800D0FF0; retail's
     find_reg cannot give it $a3 because the FT4 block's local qty `pmx` already owns $a3,
     while OUR FT4 block only ever burns $a0/$a1/$a2 -- so ours took $a3 and every hoisted
     invariant shifted one slot down.  A ZERO-INSN 20B hard-register conflict inside the
     FT4 block --
     -- manufactures exactly the missing conflict (22B(2)) and the whole band snaps.
     MEASURED (all re-gated; harness scratchpad/W74_A4/probe.py + gen_sky{,2..6}.py):
       shipped (hp+spec cached, RMW1 tag-first)                368 @458
       hp inlined + spec cached                                367 @459
       hp cached below the guard + spec cached                 367 @459
       FAITHFUL head (hp+spec both inlined), no device         384 @458  <- the w72 386
       FAITHFUL + "$7" clobber in FT4 (void form)              272 @460
       FAITHFUL + the pmx launder above (non-volatile)         272 @460  <- SHIPPED
       ... carrier sweep: slot 272 · prim 283 @471 · i 374 · temp inert(384)
       ... position sweep inside FT4: after pmx / after slot / after RMW2 / after the
           frontcolors store ALL 272; at the very END of the block = inert (pmx dead).
       ... "$6","$7" together 384 @462 (over-denial) · clobber in BOTH GT4+FT4 279 @461.
     🔴 THE PRICE, NAMED: +2 insns, and an opcode census says they are EXACTLY TWO NOPS
     (ours 60 v oracle 58, every other opcode equal) -- one in the GT4 block, one in the
     FT4/G4 pair, i.e. two load-delay slots retail fills and we do not.  That is now the
     WHOLE remaining structural gap; the register band and the head are done.
     ALSO LANDED (independent, from the shipped basin): the FIRST OT RMW is written
     TAG-FIRST (`prim->tag & 0xff000000 | slot[-2] & 0xffffff`) in all three prim blocks --
     retail's `and a2,a2,t6 ; and v0,v0,t2 ; or a2,a2,v0 ; sw a2,0(a1)` has the OR dest on
     the prim->tag operand in GT4, FT4 AND G4 (oracle-read, not inferred).  370 -> 368 from
     the GT4 site alone (FT4/G4 sites measured inert).  ⚠️ In the NEW basin the GT4 site
     re-prices at +4 (268 with it reverted) but that block is LCS-MISALIGNED there, so the
     4 is noise on an unaligned block and the oracle-evidenced spelling is kept; re-measure
     if the two nops above ever fall.
     FALSIFIED THIS PASS (all re-gated): int-typed slot sum `Draw_gViewOtSize * 4 +
     (int)Render_gPalettePtr` = 295 @469 in the old basin / 207 @471 in the new one (+11/+13
     insns -- it breaks the scratchpad-address CSE, LCS-only win, REJECTED); GT4 prim-first
     vs pmx-first, a named `int px = gSkyPixmapIndex[i]` index local, and the GT4 byte-store
     position (code/len before the last colour store) are ALL BIT-IDENTICAL (statement order
     is canonicalised here, w63 law, in both basins).
     FOUR MORE LEVERS LANDED ON TOP (272 -> 150); every one is a w42/w63 "canonicalised"
     verdict that RE-PRICES in this basin -- 04Z at full strength:
       (1) 272 -> 229: the GT4 cursor bump moved BETWEEN the first colour LOAD and its STORE
           (`c0 = <load>; Render_gPacketPtr = prim + 0x34; prim->r0 = c0;`) -- retail emits
           `lw v1,0(v0); addiu v0,a1,52; sw v0,0(t3); sw v1,4(a1)` and our fused form left
           the load-delay slot empty.  Kills the first of the two extra nops.
       (2) 229 -> 228 @458 COUNT-EXACT: the same split in the G4 block (the second nop).
       (3) 228 -> 208: the RMW1 operand order re-priced PER SITE -- 24-bit-AND-first in GT4
           and FT4, TAG-FIRST in G4 (all-tag-first 228, all-24-first 212, GT4-only 224,
           FT4-only 212, this mix 208).  That order is TWO dials at once: the OR's dest
           register AND which mask constant loop.c hoists first; the head's
           `lui t2,255 / ori / lui t6,65280` triple only comes out right in this mix.
       (4) 208 -> 152 -> 150: prim, slot, pmx statement ORDER in the GT4 and FT4 blocks
           (MATCH notes at both sites).  w42/w63 measured this axis inert -- in the OLD
           (cached-spec) basin it was; here it is worth 58.
     REMAINING 150 = FOUR named runs (side_by_side stream index): [143-147] the preheader
     hoist ORDER of the gHorizonPixmap base vs the 0x1F800004 literal (retail hoists hp
     first; it is a loop.c first-appearance question, and the GT4 order that produces it
     costs 58 elsewhere -- measured, not assumed); [277-298] + [343-392] the GT4/FT4 block
     heads (roles rotate: ours prim=$a0/idx=$a1/slot=$a2 vs retail prim=$a1/idx=$v1/
     slot=$a0); [396-435] the G4 block, which is a PURE $a0<->$a1 SWAP with every other
     word identical (prim vs slot-base) -- statement order, a split `ot` temp and slot-first
     spellings all measured INERT there, so it is a local-alloc qty tie (reqdelta/qtytrace
     territory, not a spelling one).
     METRIC NOTE: with the counts equal, judge these with positional mismatches, not the
     LCS diff count -- scratchpad/W74_A4/posmis.py prints both (the two metrics agreed on
     every decision this pass).
     NEXT TAKER: the G4 $a0<->$a1 tie is the cheapest of the three residuals (one qty pair,
     ~20 lines); the GT4/FT4 head rotation is the same question one block up.
     ===== W75-A8 (2026-08-23): 150 -> 146 @458/458 COUNT-EXACT, posmis 81 -> 76.  THE
     PREHEADER RESIDUAL [143-147] IS CLOSED -- the whole hoist list is now byte-exact.
     THE LEVER (device-free, one line): SPLIT THE PIXMAP-TABLE ADDRESS OFF ITS LOAD.
       Draw_tPixMap **hpb = gHorizonPixmap;   <- FIRST statement of the GT4 block
       ... prim = ...; slot = ...; pmx = hpb[gSkyPixmapIndex[i]];
     loop.c walks movables in RTL-GENERATION order, so the preheader hoist ORDER is decided
     by FIRST APPEARANCE in the loop body.  W74 could only put retail lui/addiu s3
     (gHorizonPixmap) at the head of that list by moving the whole pmx STATEMENT to the
     front, which costs 58 elsewhere (the pmx load must stay last).  Naming the base as a
     block-local decouples the two halves: the ADDRESS appears first, the LOAD stays last.
     It is born in the loop, so loop.c hoists it (21B(3)); zero insns.
     The FT4/G4 twin is REDUNDANT (GT4 is generated first) -- measured bit-identical.
     FALSIFIED / RE-PRICED THIS PASS (all re-gated in the NEW basin, 04Z applied):
       - the same first-appearance effect via a fence -- __asm__("" : : "r"(&gHorizonPixmap
         [0])) at the loop top / in the GT4 head / after temp = 180-181 @461-462: the
         output-less asm is a sched1 BARRIER at the loop head (20A) and costs 3-4 insns.
         The launder-carrier form on temp with the address as an extra input: same 180.
       - G4 block slot as an INT-typed index-first sum (12D): +11 insns (469) at the G4
         site ALONE, and still +11 with all three sites converted -- so it is NOT the
         FT4/G4 cross-jump group (23B(5)) but the G4 arm itself.  GT4 site = BIT-IDENTICAL,
         FT4 site = count-exact but posmis 458.  W74 global verdict re-confirmed per site.
       - G4 prim 20B hard-reg conflict to force retail prim=$a1/slot=$a0: EVERY spelling
         ("$4" launder / "$4" void / "$5" launder) costs the SAME +11 insns (469).  That is
         20B LIMIT (2) -- reload1.c puts every asm-used hard reg into bad_spill_regs
         FUNCTION-WIDE, and this function needs $a0 as a spill reg.  => the G4 $a0<->$a1 tie
         is CERTIFIED unreachable by the 20B family; it needs the ref-count/live-length side.
       - statement order re-priced in the new basin: G4 slot-first = BIT-IDENTICAL, FT4
         slot-first = BIT-IDENTICAL, GT4 slot-first = 150, all-three = 150.  A named
         int px = gSkyPixmapIndex[i] (with or without hpb) = BIT-IDENTICAL; the
         index-first byte form *(Draw_tPixMap **)(px*4 + (int)hpb) = 206; pmx moved to
         2nd or 3rd in GT4 = 206.  Statement order really is canonicalised here.
       - GT4 pmx 20B launder, all of "$3"/"$5"/"$6"/"$7" = 216-230 (over-denial).
       - DEVICE-REMOVAL RE-TEST (23B(3)) on the FT4 "$7" conflict: still LOAD-BEARING --
         deleting it gates 308 @456 (and 364 with a GT4 twin added).  KEEP IT.
     REMAINING 146 = the two head rotations only: [278-304] GT4 and [349-390] FT4 (retail
     slot=$a0, prim=$a1, pixmap index=$v1 -- ours prim=$a0, index=$a1, slot=$a2, i.e. retail
     serves index->slot->prim and we serve prim->index->slot), plus [391-441] the G4 pure
     $a0<->$a1 swap.  All three are ONE question: retail prim is served LAST despite
     having ~14 refs to slot 3, so retail prim qty must carry a LONGER live length (or
     fewer refs) than ours.  NEXT TAKER: this is now a pure local-alloc PRIORITY question --
     read the instrumented [qty_order] trace for the GT4 block (C:/Temp/nfs4-instr-cc1,
     per-basin fidelity first) rather than probing spellings; every spelling axis above is
     exhausted and the 20B axis is certified closed by the +11 bad_spill_regs result.
     Harness: scratchpad/w75/{probe,posmis,sbsdump}.py + e_{s,t,u,v,w,x,y}*.py. */

  /* R-AU (PAL): the sky vertical centre is the 256-line half-heights
     0x80/0x40, not NTSC's 0x78/0x3c. */
  otz_old = 0x80;
  if (HRZ_GAMESETUP_COMM_MODE == 1) {
    otz_old = 0x40;
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
      /* MATCH (w62-a13, 374 -> 370 @458/458 EXACT): the SZ trio is the PsyQ
         `gte_stsz3(a,b,c)` MACRO, not three lone gte_swc2 calls.  The macro takes
         all three pointers as asm INPUTS, so both `addiu` address forms are emitted
         BEFORE the three `swc2` (retail: addiu v0,a0,4; addiu v1,a0,8; swc2 17/18/19);
         three separate one-pointer asms let gcc interleave each addiu with its own
         store.  Same family as the gte_stsxy3 line above it.
         ---- w63-a13: THE GTE-MACRO AUDIT ASKED FOR AFTER w62 IS DONE AND COMES BACK
         CLEAN.  A per-opcode census of the whole function against the oracle
         (scratchpad/w63a13/opcen.py, which runs verify_asm's OWN normalizers) shows the
         two streams differ in EXACTLY TWO opcodes -- `addu 32 v 33` and `nop 59 v 58` --
         at an identical total of 458.  Every GTE opcode matches one-for-one
         (swc2 13/13, lwc2 10/10, and zero mtc2/mfc2/ctc2/cfc2/cop2 on either side), so
         there is NO remaining gte_* macro mis-selection in this function: gte_ldv3 /
         gte_rtpt / gte_stsxy3 / gte_stsz3 / gte_ldv0 / gte_rtps / gte_stsxy2 / gte_stsz /
         gte_stlvnl are all the right forms and the right arities.  The 370 residual is
         therefore ENTIRELY the register permutation the w62 receipt priced (the +1 shift
         over the caller-saved band, ~94 diffs by permtest) plus body scheduling, plus one
         addu/nop pair.  Do not spend more budget looking for a macro here. */
      gte_stsz3(&zcnt[0],&zcnt[1],&zcnt[2]);
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
        gte_stsxy2(scnt);
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
      gte_stsxy2(scnt);
      scnt->vy = (short)(transformed.vy >> 2) + (short)otz_old;
      gte_stsz(zcnt);
      n = n + -1;
    } while (n != -1);
  }
  if ((Sky_gTrackSpec->flags & 0x40U) != 0) {
    Hrz_SetDitheringPrim(0,Draw_gViewOtSize + -2);
  }
  if ((HRZ_TRACK_SKY_FLAGS & 4U) != 0) {
    pshift = sd->otz;                       /* save (scratchpad +0x94) around the flare */
    Flare_Sun(SUNPOS,(Draw_FlareCache *)sd);
    sd->otz = pshift;
  }
  /* 🔴 SUPERSEDED BY W74-A4 -- the `spec = Sky_gTrackSpec;` cache that used to stand here
     (w49-a5 / w50-a5, 377 -> 374) IS GONE, and so is the `hp = gHorizonPixmap;` cache.
     Neither is in the SYM (@40ed4b lists exactly pSkyMesh, pSkyZ, i, otz_old, pshift, sd),
     and the caches were what pushed our band one slot: retail loads Sky_gTrackSpec INSIDE
     the loop at 800D0E60 (`lw $t0,%gp_rel(Sky_gTrackSpec)($gp)`, held to 800D0FF0 for
     ->type/->flags/->frontcolors[0]) and loop.c hoists the gHorizonPixmap base into $s3 by
     itself.  Reading both globals inline + the $a3 conflict device in the FT4 block (see
     the MATCH note there) reproduces the whole head byte-for-byte.  Detail + the full
     measurement ladder: the W74-A4 section of the receipt block above the function. */
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

                u_int *slot; /* SYM-CODEGEN-CARRIER: slot -- one staged OT address prevents post-store global re-evaluation (+16 insns) */
                u_long c0; /* SYM-CODEGEN-CARRIER: c0 -- split colour load/bump/store fills the retail packet load-delay slot */
                /* MATCH (W74-A4, 208 -> 152): prim, slot, pmx IN THIS ORDER.  Statement
                   order in these prim blocks was recorded "canonicalised" by w42/w63 --
                   that was measured in the OLD (cached-spec) basin; in the faithful one
                   it is worth 56 diffs.  (pmx,prim,slot) 208 - (prim,pmx,slot) 210 -
                   (pmx,slot,prim) 210 - (slot,pmx,prim) 154. */
                /* MATCH (W75-A8, 150 -> 146 @458/458 and the PREHEADER NOW BYTE-EXACT):
                   naming the pixmap table base as a BLOCK-LOCAL, assigned as the FIRST
                   statement of the GT4 block, is what puts retail's `lui/addiu s3`
                   (gHorizonPixmap) at the HEAD of the hoist list.  loop.c walks movables in
                   RTL-generation order, so the hoist order is decided by FIRST APPEARANCE in
                   the loop body -- and W74 could only reach that by moving the whole `pmx`
                   statement to the front, which costs 58 elsewhere.  Splitting the ADDRESS
                   off the `pmx` load decouples the two: the address appears first, the load
                   stays last.  The block is BORN IN THE LOOP so loop.c hoists it (21B(3)).
                   The FT4/G4 twin is redundant (GT4 is generated first): measured identical. */
                pmx = gHorizonPixmap[gSkyPixmapIndex[i]];
                prim = (POLY_GT4 *)Render_gPacketPtr;
                slot = (u_int *)(Draw_gViewOtSize * 4 + (int)Render_gPalettePtr);
                /* MATCH (W74-A4): 24-bit-AND-FIRST here and in the FT4 block, TAG-FIRST
                   in the G4 block below.  Retail's OR dest is the prim->tag operand in
                   all three (`and a2,a2,t6; or a2,a2,v0`), but the operand order also
                   decides which mask constant loop.c hoists FIRST (it walks movables in
                   RTL-generation order), and retail's preheader materialises the 2-insn
                   0xFFFFFF before the 1-insn 0xFF000000.  Measured per site from the
                   faithful basin: GT4 24-first -4, FT4 24-first -12, G4 tag-first -4
                   (all-tag-first 228, all-24-first 212, this mix 208). */
                setaddr(prim,getaddr(slot - 2));
                setaddr(slot - 2,prim);
                /* MATCH (W74-A4, 272 -> 229 and one of the two nops): the cursor bump
                   sits BETWEEN the first colour LOAD and its STORE, exactly as retail
                   emits it (`lw v1,0(v0); addiu v0,a1,52; sw v0,0(t3); sw v1,4(a1)`).
                   The fused `prim->r0 = <load>; bump;` form leaves the load-delay slot
                   empty and costs a nop.  Same split in the G4 block below. */
                c0 = *(u_long *)&gSkyColor[temp + 0x11];
                Render_gPacketPtr = (u_char *)prim + 0x34;
                *(u_long *)&prim->r0 = c0;
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

                u_int *slot; /* SYM-CODEGEN-CARRIER: slot -- shared carrier for the same PsyQ OT cell across the packet-pointer store */
                /* MATCH (W74-A4, -2): same prim, slot, pmx order as the GT4 block. */
                pmx = gHorizonPixmap[gSkyPixmapIndex[i]];
                prim = (POLY_FT4 *)Render_gPacketPtr;
                slot = (u_int *)(Draw_gViewOtSize * 4 + (int)Render_gPalettePtr);
                /* MATCH (W74-A4, 384 -> 272): ZERO-INSN HARD-REG CONFLICT (catalog 20B /
                   22B(2)).  The inlined `Sky_gTrackSpec` value is a GLOBAL allocno live
                   across this block; retail cannot give it $a3 because THIS block's local
                   qty `pmx` owns $a3, ours could, and that one slot rotated the entire
                   caller-saved band (i/temp/the 8 hoisted invariants).  Denying $a3 to the
                   quantities live here reproduces retail's conflict set: the spec value
                   lands in $t0, `temp` in $t1, `i` in $t4 -- head byte-exact.  DO NOT
                   DELETE without re-reading the W74-A4 receipt above the function. */
                setaddr(prim,getaddr(slot - 2));
                Render_gPacketPtr = (u_char *)prim + 0x28;
                setaddr(slot - 2,prim);
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

              u_int *slot; /* SYM-CODEGEN-CARRIER: slot -- retains the G4 block's single-evaluation OT address */
              u_long c0; /* SYM-CODEGEN-CARRIER: c0 -- preserves the G4 load-delay-filling split */
              prim = (POLY_G4 *)Render_gPacketPtr;
              slot = (u_int *)(Draw_gViewOtSize * 4 + (int)Render_gPalettePtr);
              setaddr(prim,getaddr(slot - 2));
              setaddr(slot - 2,prim);
              /* MATCH (W74-A4, 229 -> 228 and the count back to EXACT 458/458): the
                 colour-load / bump / colour-store split, see the GT4 block above. */
              c0 = *(u_long *)&gSkyColor[temp + 0x11];
              Render_gPacketPtr = (u_char *)prim + 0x24;
              *(u_long *)&prim->r0 = c0;
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

  /* R-AU (PAL): 256-line sky centre (see Hrz_BuildSky). */
  pshift = 0x80;
  if (HRZ_GAMESETUP_COMM_MODE == 1) {
    pshift = 0x40;
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
        gte_stsxy2(&scnt);
        gte_stlvnl(&transformed.vx);
        scnt.vy = (short)((transformed.vy >> 2) + pshift);
        if ((scnt.vx <= (sd->head).clipW) && (-1 < scnt.vx) &&
            ((short)((transformed.vy >> 2) + pshift) <= (sd->head).clipH) &&
            (-1 < (short)((transformed.vy >> 2) + pshift))) {
          /* MATCH (w38-a10): ONE-EXPRESSION ordering-table slot form (the same idiom
             as Hrz_TextureQuad@652 / Hrz_BuildSky@861). The earlier two-statement
             sll-then-add chain cost an extra insn AND a t2/a1 base-vs-index swap
             (11 diffs, ours 112 vs oracle 111); the single expression makes the shift
             result itself the addu dest + accumulator == oracle `sll a1,s3,2 ;
             lui v0 ; lw v0 ; addu a1,a1,v0`. 11 -> 2 diffs, count exact.
             w41-a8 reached PASS with hand-mask staging.  PASS-lock wave 18 replaces the
             four reconstruction temporaries with the actual PsyQ addPrim bitfield source:
             the 24-bit field lowering preserves the same mask order and remains PASS
             111/111 while matching the SYM's no-local block. */
          prim = (TILE_1 *)Render_gPacketPtr;
          setaddr(prim,getaddr(otz * 4 + (int)Render_gPalettePtr));
          Render_gPacketPtr = (u_char *)prim + 0xc;
          setaddr(otz * 4 + (int)Render_gPalettePtr,prim);
          *(u_long *)((u_char *)prim + 4) = starColors[n];
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
/* w42-a6 ROOT CAUSE of the +4-insn excess (census: sw 41v40, lw 54v51).  Ours SPILLS the
 * hoisted 0xFFFFFF OT-link mask to the frame (`sw t1,84(sp)` + three reloads) because two
 * callee-saved registers are consumed by CSE-hoisted ADDRESSES that retail rematerializes:
 *   ours   `li s6,4 ; lui s7,8064 ; or s7,s7,s6`  = 0x1F800004 held whole in $s7
 *          `addiu s3,s5,88`                       = hsd+0x58 held in $s3
 *   oracle `lui s7,255 ; ori s7,s7,65535`         = the MASK in $s7
 *          `addu s3,s6,zero` (s3 == hsd) + `li s5,4`, every scratchpad address formed
 *          per use as `ori rD,s6,OFF` off the ONE base
 * i.e. retail anchors every access on hsd itself and keeps only the literal 4 in a saved
 * reg; we anchor on hsd+0x58 and on the fully-formed 0x1F800004.  FIX DIRECTION for the
 * next pass: stop letting gcc CSE `(int)hsd + 0x58` and the Render_gPacketPtr literal into
 * their own long-lived pseudos (all displacements in the prim loop are then hsd-relative,
 * which is also why the oracle's loads read 292/159/227 where ours read 204/71/139). */
/* w50-a5: 214 -> 166 diffs, 477 -> 471 insns (was +4 OVER the oracle, now 2 under).
 * diffsrc attributed the whole +4 to the OT-link RMW block: our source re-read the
 * 0x1F800004 scratchpad literal and recomputed the palette slot at each of four sites,
 * where the oracle loads the cursor ONCE (`lw s0,0(a2)` off a materialized &cursor) and
 * computes the slot ONCE.  Landed = cursor-off-`p` + one shared `pal` slot pointer (see
 * the MATCH note at the RMW).  NAMED ANGLES still open, in priority order:
 *  (1) THE MASK-vs-ADDRESS HOIST SWAP (the w42-a6 root cause above, now sharpened by
 *      block-14 of the diffsrc): retail's loop preheader is `lui s7,255; ori s7,s7,65535`
 *      (the 0xFFFFFF OT mask in a saved reg) + `addu s3,s6,zero; addu s2,s4,zero; li s5,4`;
 *      OURS hoists `fp = 0x1F800004` instead and materializes the mask INSIDE the loop.
 *      MEASURED: a named `u_int m24 = 0xffffff;` local makes the count EXACT 473/473 but
 *      gates 172 (decl-init) / 194 (assigned before the loop) / 194 (m24+m8 both named) --
 *      i.e. naming the mask alone rotates the saved-reg band without freeing $s7, because
 *      our LICM hoist of the Render_gPacketPtr ADDRESS still owns a callee-saved reg.
 *      => the two halves must land TOGETHER: kill the address hoist FIRST (catalog: give
 *      each loop a DISTINCT address rtx for a scratchpad literal / goto back-edge as the
 *      anti-LICM lever), THEN re-probe the named mask from that basin.
 *  (2) hsd-relative anchoring: retail forms every scratchpad address as `ori rD,s6,OFF`
 *      off the single hsd base; ours keeps `hsd+0x58` in its own pseudo (loads read
 *      204/71/139 vs the oracle's 292/159/227).
 *  (3) block 6/7: the oracle's `nop; sw v0,60(sp)` pair sits 8 insns earlier than ours --
 *      a sched1 position tie on the temp2d[1] word copy. */
/* ---- w61-a14 (2026-08-15): 166 -> 132 diffs @471/473.  FIVE stacked source-shape
 * levers, each re-gated; the w50-a5 named angle (1) ('kill the address hoist FIRST,
 * THEN re-probe the named mask') is EXECUTED -- the address hoist is dead, but the
 * mask half is REFUTED (see (F) below).  Ledger (all `verify_asm`, ours/oracle insns):
 *   baseline                                166 @471   (s5=hsd, s3=hsd+0x58 giv, fp=0x1F800004)
 *   (A) loop18                              --         index-term-first on the two iVar18 addresses
 *   (B) iv16 + drop iVar16                  160 @471
 *   (A)+(B)                                 156 @471
 *   +(C) pin                                152 @471
 *   +(D) earlybump                          140 @471
 *   +(E) elseq + IDENTITY FENCE             132 @471   <-- shipped
 *
 * (A) INDEX-TERM-FIRST for the scratchpad addresses (methodology 5.0c commutative-addu,
 *     used for its ASSOCIATION side).  `((int)hsd + 0x124) + iVar18` builds the rtx
 *     (plus hsd 0x124) and hands loop.c a giv BASE of hsd+CONST; writing it
 *     `(int)hsd + iVar18 + 0x124` builds (plus hsd iVar18) instead and leaves the
 *     constant in the load displacement -- retail's `addu v0,s6,s5; lw v0,292(v0)`.
 * (B) THE +0x58 GIV ANCHOR WAS THE w42-a6 ROOT CAUSE.  Every `iVar16 + 0xNN` use was
 *     respelt `(int)hsd + iVar15 + 0xNN`, which makes iVar16 dead (deleted).  The giv
 *     base becomes hsd (retail `lw v0,292(s3)`, ours was `lw v0,204(s3)` off hsd+0x58),
 *     and the pre-loop `Horizon_InterpolateLineSCoords` arg stops being a CSE partner:
 *     ours `addiu s3,s5,88; addu a1,s3,zero` (2 insns + a callee-saved reg) collapses to
 *     retail's single `ori a1,s6,88`.  !! THE INVERSE (express the iVar15 addresses off
 *     the iVar16 biv) is FALSIFIED: 218 @477.
 * (C) the packet-cursor read `p = Render_gPacketPtr;` belongs INSIDE the ringPMX guard --
 *     retail's `lw s0,0(a2)` sits after the `beq`, ours was hoisted above it.
 * (D) EARLYBUMP = the cursor write `Render_gPacketPtr = p + 0x34;` moved to immediately
 *     after the read.  ** THIS IS WHAT KILLS THE ADDRESS HOIST: with the two uses of the
 *     0x1F800004 literal adjacent, loop.c no longer finds it worth hoisting, so it is
 *     materialized in-loop exactly like retail (`lui a2,8064; ori a2,a2,4`) and the
 *     callee-saved slot it was squatting is freed.  -12 diffs on its own.
 * (E) THE ELSE-ARM IDENTITY FENCE (catalog 06B / 4.4 fence toolkit) -- the lever that
 *     flipped the s2<->s3 band.  Retail's `8 > ringPMX` arm computes a FRESH
 *     `addu v1,s2,s6` (= hsd + iVar15) and reads 156/88/92 off it, instead of reusing the
 *     giv the way its sibling arm does.  A plain named `int q = (int)hsd + iVar15;` is
 *     NEUTRAL (140, gcc folds q straight back into the giv); the CSE-OPAQUE LAUNDER
 *     `__asm__("" : "=r"(q) : "0"(q));` on it is zero-insn and defeats the fold.
 *     Effect: the giv sheds 3 refs and iVar15 gains 3, which reverses the global_alloc
 *     order of the two -- ours now hands hsd-giv $s3 and iVar15 $s2 exactly like retail
 *     (~20 diff lines), and the else arm's `lw ...(v1)` group lines up too.  132 @471.
 *
 * (F) FALSIFIED THIS PASS (all re-gated from the basin named):
 *   - named `u_int m24 = 0xffffff;` (the w50-a5 angle-1 second half): 154 in the 140
 *     basin, 184/267 in the earlier ones -- the mask hoist is NOT source-reachable by
 *     naming.  MECHANISM (new): after (D) our build hoists `lui fp,65280` (0xFF000000,
 *     a ONE-insn constant) where retail hoists the TWO-insn 0xFFFFFF; both have exactly
 *     2 uses and identical spans, so loop.c is picking the cheaper movable.  The open
 *     dial is therefore 'make the 24-bit mask outrank the 8-bit one as a movable', not
 *     'name the mask'.
 *   - full index-term-first sweep incl. the iVar15 addresses (loop15): 172-228 @469-473.
 *   - Yoda operands on the two OT RMW ORs: 184 in the 152 basin, exactly neutral in the
 *     140 basin (canonicalized).
 *   - clipW/clipH as fixed-address literals `*(short *)0x1f800010/12` (aimed at retail's
 *     `lui v0,8064; lhu v0,16(v0)`, which is the whole 471-vs-473 shortfall): 207 @470 --
 *     the literal CSEs against hsd's own lui and comes out SHORTER, not longer.
 *   - re-association of the two `farI * 4` delta reads (pre): byte-identical, 166/160.
 * STILL OPEN, in priority order: (1) the {hsd,iVar18} $s5<->$s6 swap (retail hsd=$s6,
 * iVar18=$s5; ours reversed -- a whole-function allocno vs a loop-local one, so the loop
 * dials do not reach it); (2) the movable-rank swap of the two masks in (F); (3) the
 * 2-insn clip shortfall.  Harness: scratchpad/w61a14/bhprobe.py (composable variant
 * sets, always restores the base). */
/* ---- w63-a13 (2026-08-15): 132 STAYS @471/473.  Open dial (2) -- "make the 24-bit mask
 * outrank the 8-bit one as a loop.c MOVABLE" -- attacked with the w44 zero-insn
 * semantic no-op RE-MASK inflator and catalog 13C's "LICM TIPS AT N OCCURRENCES".
 * FALSIFIED, all re-gated, all @471:
 *   `(*pal & 0xffffff) & 0xffffff` (3rd occurrence of the 24-bit mask)   132 BIT-IDENTICAL
 *   both ANDs re-masked (4 occurrences)                                  132 BIT-IDENTICAL
 *   the same on the 8-bit mask (negative control)                        132 BIT-IDENTICAL
 *   a named `pkt24` evaluated first (the Flare_Tri idiom that works in the sibling
 *     Hrz_BuildSky star loop)                                            148
 *   pkt24 + the 24-bit re-mask                                           148
 * MECHANISM: cse folds a redundant AND against an already-masked value at TREE level,
 * before loop.c ever builds its movable list, so the occurrence-count dial cannot reach
 * combine_movables here at zero insns.  (It reaches flow.c's REG_N_REFS -- which is why
 * the same device works as an ALLOCNO dial elsewhere -- but the two consumers see
 * different lists.  Worth a catalog row: the re-mask inflator is an allocno dial, NOT a
 * LICM dial.)  The remaining route for this cluster is to make the 8-bit mask cheaper to
 * NOT hoist (savings 1 is already the minimum) or to give the 24-bit one a genuinely
 * distinct third USE, which costs an instruction we do not have.
 * OPCODE CENSUS (new): ours vs oracle differ in EXACTLY ONE opcode -- `lui 26 v 28`.
 * The whole 2-insn shortfall is two missing address materialisations, i.e. the w61
 * open items (2) [the mask movable] and (3) [the clip shortfall] are the SAME two luis.
 * Harness: scratchpad/w63a13/bhprobe.py. */
/* ---- 🏆 w64-a13 (2026-08-15): 132 -> 118 @471/473.  The w63 census + side_by_side named
 * the two missing `lui` exactly, and ONE of them is now recovered.
 * WHAT THE ORACLE DOES at the two clip reads inside the clause-2 / clause-4 OR chains:
 *     ORACLE   lui v0,8064 ; lhu v0,16(v0)     (a FRESH scratchpad base per clip read)
 *     OURS     lhu v0,16(s5)                   (off the hoisted `hsd` base)
 * i.e. retail did NOT reach clipW/clipH through the `hsd` pointer at these two sites.
 * LANDED: spell the clipW read as the LITERAL `*(short *)0x1f800010` (clipH left on the
 * hsd base).  Semantically identical (hsd IS 0x1f800000), zero source risk, -14 diffs.
 * ⚠️ THE HALVES ARE NOT SYMMETRIC AND ONLY W PAYS -- re-gated, all @471/473 unless noted:
 *     clipW literal only                              118   <- LANDED
 *     clipH literal only                              143 @470
 *     BOTH literal                                    159 @470  (the two `lui 8064` cse
 *                                                     into one and the fn goes 1 SHORT --
 *                                                     this is why w61's both-literal probe
 *                                                     read as "the literal CSEs against
 *                                                     hsd's own lui and comes out SHORTER")
 *     clipW literal + clipH via a laundered base      138
 *     clipW literal + `*(short *)(0x1f800000 + 0x12)` 159 @470   (folds to the same rtx)
 *     clipW literal + `((short *)0x1f800000)[9]`      159 @470
 *     clipW literal + `((Draw_HorizonCache*)0x1f800000)->head.clipH`  159 @470
 *     clipW literal + a `"r"(hsd)` fence at the head  148
 *     both clip reads via a per-site opacity-laundered `int hb = 0x1f800000;`  137 / 138
 *     `volatile short` on both                        251 @492 (catastrophic, as expected)
 * LOAD-WIDTH NOTE (measured, do not re-chase): the literal form flips `lhu`+`sll/sra` to a
 * fused `lh` (census after landing: `lh 27v26  lhu 12v13  lui 27v28  nop 79v78  sll 5v6
 * sra 1v2`), but reading it as `(short)*(u_short *)0x1f800010` to keep the extend separate
 * is EXACTLY NEUTRAL (118, bit-identical) -- combine narrows it back either way.
 * REMAINING: ONE `lui` (the clipH site) plus the mask-movable rank from w63.  NEXT TAKER:
 * the clipH base must materialise fresh WITHOUT being cse-equated with the clipW one; every
 * same-address spelling tried above is equated by cse at tree level, so the device has to
 * make the two addresses structurally different rtx (or come from the RTL layer).
 * Harness: scratchpad/w64a13/bhprobe{,2,3}.py. */
/* ---- w71-A4 (2026-08-21): 118 STAYS @471/473; the OPCODE CENSUS names the second half of
 * the shortfall and the w64 "neutral" reading is now MECHANISED (no code change this pass).
 * `tools/rove_op.py` on this TU reports exactly one row: `sra 1v2  sll 5v6  lh 27v26
 * lhu 12v13` -- ONE missing sign-extension PAIR and one lh-for-lhu, i.e. a SINGLE site.
 * The oracle uses the SAME shape at BOTH clip reads (800D16E0 and 800D177C):
 *     lui $v0,0x1F80 ; lhu $v0,0x10/0x12($v0) ; sll $v0,$v0,16 ; sra $a0,$v0,16
 * -- an UNFUSED sign extension, then 4 `slt` against $a0.  Ours emits the FUSED `lh` at the
 * w64-landed clipW literal.  WHY w64's `(short)*(u_short *)0x1f800010` measured EXACTLY
 * neutral: `(short)(u_short)MEM` is folded at TREE level (fold_convert collapses the
 * double conversion), so combine never even sees a candidate -- NO SPELLING OF A SINGLE
 * EXPRESSION can keep the extend separate.  The value has to pass through a real `int`
 * VARIABLE whose zero-extended pseudo still exists at combine time, and the pseudo must not
 * die into the extend, i.e. the documented zero-insn identity launder:
 *     int cw = *(u_short *)0x1f800010;  __asm__("" : "=r"(cw) : "0"(cw));  ... (short)cw ...
 * ⚠️ IT MUST BE DECLARED INSIDE CLAUSE 2, not before the `if` -- the oracle's read sits at
 * .L800D16E0, the TARGET clause-1's OR-chain jumps to, so a pre-if local (which is what the
 * MATCH note above already warns about) hoists it above clause 1 and is wrong both for the
 * bytes and for the behaviour.  That means splitting the flat 4-clause `&&` into nested
 * ifs so the declaration has a block -- the named, un-attempted next step (cost: one
 * re-indent of the ring-segment body; risk: the w64 "flat-&&-vs-nested-if is a real CFG bug
 * class" caveat, so gate the branch words with tools/brdist.py after).  Expected: +2 insns
 * (count 473 EXACT) at the clipW site; the clipH `lui` and the mask-movable rank are
 * independent and stay open. */
/* ---- W72-A4 (2026-08-22): 118 -> 58 @473/473 COUNT-EXACT.  FOUR stacked levers, each
 * re-gated on its own and in sequence; the w71 named next step landed as predicted and
 * then the w61/w63 "mask movable rank" open dial (2) fell as a side effect.
 * LEDGER (verify_asm, ours/oracle insns):
 *   baseline (w71)                                          118 @471
 *   (A) 4-clause `&&` split into nested ifs, laundered `cw`  100 @473  <- +2, count EXACT
 *   (B) + OR-operand swap on the FIRST OT RMW only            96 @473
 *   (C) + named `m24` mask + 1-operand read-only fence        84 @473
 *   (D) + block-scoped `fo = farI*4` in the two delta pairs   80 @473
 *   (E) + read-only LIVENESS fence on `rowDelta`              58 @473  <- shipped
 *
 * (A) THE w71 NAMED STEP, EXECUTED.  Nesting alone is BIT-IDENTICAL (118 @471, measured
 *     as the control), so the whole win is the laundered int: `int cw = *(u_short *)
 *     0x1f800010; __asm__("" : "=r"(cw) : "0"(cw));` declared INSIDE clause-1's block,
 *     then `(short)cw` in clause 2.  The launder keeps the zero-extended pseudo alive at
 *     combine time, so the `lui 0x1F80; lhu; sll 16; sra 16` UNFUSED shape retail has is
 *     emitted instead of our fused `lh` -- exactly the +2 insns the w71 receipt predicted.
 * (B) 🏆 NEW LAW -- THE LICM MOVABLE THAT WINS THE BUDGET IS THE FIRST-GENERATED CONSTANT
 *     IN THE EXPRESSION.  Retail hoists the TWO-insn 0xFFFFFF and rematerializes the
 *     ONE-insn 0xFF000000 in the loop; we did the reverse, and w61/w63 filed it as an
 *     unreachable "movable-rank" dial after ~8 falsified probes (named temps, re-mask
 *     inflators, occurrence counts).  It is reachable by ONE token: write the first RMW
 *     as `*(u_int *)p = *pal & 0xffffff | *(u_int *)p & 0xff000000;` (24-bit AND as OR
 *     operand 0, i.e. generated first).  loop.c walks movables in RTL-generation order and
 *     the budget is spent on the first one it accepts.  ⚠️ SITE-SELECTIVE: doing the same
 *     to the SECOND RMW costs 4 (100 vs 96) and doing both = 100.
 * (C) The named `u_int m24 = 0xffffff;` (w50/w61 measured it at 154/184/194 and closed the
 *     axis) is a WIN once the OR swap is in place AND it carries a fence: plain named = 96
 *     (neutral), named + identity launder = 102, named + a ONE-operand read-only fence
 *     `__asm__("" : : "r"(m24));` after the second RMW = 84.  reqdelta-style arithmetic
 *     from the .greg/.lreg dump predicted it exactly: p345 (the mask) 5 refs/158 live =
 *     .253 vs p356 (the colour-base pointer) 8 refs/310 live = .310, so p356 was served
 *     first and took $s7 while the mask fell to $fp; +2 in-loop refs (one fence operand at
 *     loop depth 1) lifts the mask to 7 refs = .354 and the pair swaps to retail's
 *     mask=$s7 / base=$fp.  Operand-count sweep: n=1 -> 84, n=2 -> 116, n=3 -> 128 (an
 *     OVER-dial regresses exactly as the model says).  Position sweep: between the two
 *     RMWs = 106, anywhere after the second RMW = 84.
 * (D) `{ int fo = farI * 4; ... hsd + fo + 0x58 ... }` for both `dx/dy` pairs = -4.  The
 *     flat `((int)hsd + 0x58) + farI * 4` reassociates so the scaled index is addu
 *     operand 0 (`addu v0,v0,s6`); the block-scoped temp keeps retail's `addu v0,s6,v0`.
 *     A pure re-spelling `(int)hsd + farI*4 + 0x58` without the temp is BIT-IDENTICAL
 *     (84) -- the fold-reassociation escape needs a real block-scoped variable (21C-5).
 * (E) 🏆 THE BIGGEST SINGLE LEVER (-22): a read-only fence on the max-search counter
 *     `rowDelta`, placed AFTER the loop, inside the `updown[]` build region.  MECHANISM:
 *     the three loop globals are priced floor_log2(refs)*refs*4/live -- rowDelta 9 refs
 *     (init + 4 loop-weighted uses) = 108/L, zval 7 refs = 56/L, Zmax 5 refs = 40/L, so
 *     ours served rowDelta FIRST and it took $a0; retail's order is zval,$a0 -> Zmax,$a1
 *     -> rowDelta,$a3.  Extending rowDelta's live range past the loop DEMOTES it below
 *     both rivals (the classic inverse dial) and zval/Zmax snap to retail's $a0/$a1.
 *     POSITION IS THE WHOLE DIAL, and the window is sharp -- all re-gated:
 *       after `pSVar12 = gRngCoordTop + farI;`            73 @472 (count SHORT)
 *       after `updown[0].vx = ...`                        99 @474
 *       after `updown[0].vy/.vz`, `updown[1].vx/.vy`      58 @473  <- the plateau
 *       after `updown[1].vz = ...`                        63 @474
 *       after `shape_overlap = 0;`                        62 @473
 *       after `shape_w_idx = 0;`                         164 @473
 *     Operand count is INERT inside the plateau (1/2/3 operands all 58), i.e. this is a
 *     pure LIVE-LENGTH dial, not a ref-step one.  A SECOND fence anywhere later regresses
 *     (62/156/164/162).
 * FALSIFIED THIS PASS (all re-gated, from the basin named in brackets):
 *   [100] laundered `ch` for clipH too (the symmetric device)      102 @475  (+2, wrong)
 *   [84]  laundered `chv` for clipH inside clause 3                 86 @475
 *   [84]  clipH as the plain literal `*(short *)0x1f800012`        127 @472 (cse-merged)
 *   [96]  reverting the (B) OR swap once `m24` is named             98/102
 *   [96]  `m24` declared+laundered before the loop                 102 · plain named 116
 *   [84]  named temp for the `*(u_int *)p` read (to fix the RMW
 *         load ORDER, ours reads *pal first)                       102 @473
 *   [80]  cursor-bump POSITION re-probed in the new basin (the w61
 *         EARLYBUMP is still required): after pal 144 @477 · after
 *         RMW2 142 @475 · after the fence 142 @475 · after colour-1
 *         140 @475 · after colour-2 142 @475
 * REMAINING RESIDUAL (58 = ~35 diff lines), all named:
 *   (1) rowDelta $a2-vs-$a3 (4 lines): the priority half is now correct, what is left is
 *       AVAILABILITY -- retail has something occupying $a2 across rowDelta's range that we
 *       do not.  §15A: a priority dial is inert on an availability loss; needs the
 *       [find_free_reg] trace.
 *   (2) the packet block (14 lines): our cursor read+bump sit at the TOP of the block
 *       (required, see the falsification above) where retail emits the bump at the very
 *       end, and our first RMW reads *pal before *p.  One coupled scheduling question.
 *   (3) the clipH `lui` (2 lines) -- unchanged from w64/w71.
 *   (4) three sched-position singletons: `nop; sw v0,60(sp)` 8 insns early, the
 *       `addu s2,s4,zero; li s5,4` preheader pair 4 insns early, one `lh v1,40(sp)`.
 * Harness: scratchpad/W72_A4/probe.py + apply.py (edit-list variants e_*.py, always
 * restores; per-step backups hrzsku.cpp.step1..step5). */
/* ===== 🏆 W74-A4 (2026-08-23): 58 -> 20 @473/473 COUNT-EXACT.  FIVE stacked levers; every
 * one of the w72 "REMAINING RESIDUAL" items except the clipH `lui` is now closed, and four
 * of the five are the same two laws (a hard-reg availability device + index-first sums).
 * LEDGER (verify_asm, all count-exact 473/473):
 *     w72 baseline                                                        58
 *   (A) + "$6" clobber after `rowDelta = 0;` (rowDelta $a2 -> $a3)        50
 *   (B) + FENCED held-address anchor for the packet cursor + late bump    42
 *   (C) + INT-TYPED index-first OT-slot sum                               34
 *   (D) + index-first `pSVar12 = (SVECTOR *)(farI * 8 + (int)gRngCoordTop)` 30
 *   (E) + colour-1 load/store split w/ the bump between + a void fence
 *         between the two RTPS transforms                                 22
 *   (F) + `iVar18 = 4;` before `iVar15 = 0;`                              20  <- shipped
 *
 * (A) THE w72 RESIDUAL (1) WAS AN AVAILABILITY LOSS AND IT IS SOURCE-REACHABLE.  The w72
 *     receipt priced the PRIORITY half correctly (the live-range fence puts zval=$a0,
 *     Zmax=$a1) and then filed the $a2-vs-$a3 half as "needs the [find_free_reg] trace".
 *     It is just the 20B device: `__asm__("" : : "i"(0) : "$6");` immediately after
 *     `rowDelta = 0;` denies $a2 to everything live at that insn, so find_reg's ascending
 *     scan gives rowDelta $a3 like retail.  Carrier/position sweep (all re-gated):
 *       void form after `rowDelta = 0;`                50   <- SHIPPED
 *       launder on rowDelta / on zval / on Zmax / farI  50 / 52 / 52 / 56
 *       inside the loop body (any of 3 carriers)        54
 *       one statement EARLIER (before `rowDelta = 0;`)  58 (INERT -- rowDelta not born yet)
 *       "$6","$7" together 154 · "$5" 68  (over/wrong-denial)
 *     ⚠️ It does NOT supersede the w72 (E) live-range fence -- dropping that fence with the
 *     clobber in place gates 78 (and 80 without either).  Both are required.
 * (B) THE PACKET BLOCK (w72 residual (2), 14 lines) IS CLOSED BY THE FENCED HELD-ADDRESS
 *     ANCHOR (05F / 14D / methodology 3.12 #16).  Retail materialises &Render_gPacketPtr
 *     ONCE (`lui a2,8064; ori a2,a2,4`), reads the cursor from it, runs both OT RMWs and
 *     writes the +0x34 bump back THROUGH THE SAME REGISTER at the very end.  Every earlier
 *     wave moved the bump alone and paid +2 insns (the address re-materialises: w72 142-144,
 *     re-measured here 118/120) -- because an UNFENCED `u_char **pp = (u_char **)0x1f800004;`
 *     is const-propagated straight back to the literal (measured: bit-identical to the old
 *     form).  `__asm__("" : "=r"(pp) : "0"(pp));` keeps it in one register and the late bump
 *     becomes FREE.  Bump-position sweep on the fenced anchor: after colour-1 42 <- min ·
 *     after the m24 fence 44 · after `puVar1=` 44 · after colour-2/3 46/46 · after colour-4
 *     48 · after SetPolyGT4 175 @476.
 * (C)/(D) TWO INDEX-FIRST INT SUMS (12D law: pointer_int_sum always rebuilds ptr-first;
 *     only an int-typed sum keeps the scaled index as addu operand 0).  The oracle shows
 *     `sll a0,a0,2; addu a0,a0,v0` for the OT slot (dest = the Draw_gViewOtSize product)
 *     and `sll a0,t0,3; addu a0,a0,v0` for `gRngCoordTop + farI` (dest = the farI product).
 *     Both flips are worth 8 and 4 respectively; the `<< 3` and `* 8` spellings measure
 *     identical.
 * (E) TWO SCHEDULING SPLITS.  (i) The colour-1 store split (`c1 = ...; *pp = p + 0x34;
 *     *puVar1 = c1;`) reproduces retail's `lw v1,0(v0); addiu v0,s0,52; sw v0,0(a2);
 *     sw v1,4(s0)` exactly -- after it the WHOLE packet block matches byte-for-byte except
 *     the RMW load order.  (ii) It leaves us 1 insn SHORT (472) because our `sw v0,60(sp)`
 *     (the temp2d[1] write-back) SINKS past the second transform's movstrsi copy and fills
 *     the load-delay slot retail nops; a void fence between the two RTPS transforms stops
 *     the sink, restores the nop AND the position -> 22 @473 count-exact.  The two halves
 *     are worth 25@472 and 27@474 alone and 22@473 together.
 * FALSIFIED / RE-PRICED THIS PASS (all re-gated, several were w72 "next steps"):
 *   - clipH as its own literal `*(short *)0x1f800012` = 101 @472 at the 58 basin and 75
 *     @472 at the 34 basin (cse merges it with the clipW read and we lose an insn); the
 *     laundered `ch` twin = 60 @475.  The 2-line `lui` residual STAYS (3rd basin now).
 *   - RMW1 tag-first (the shape that pays in Hrz_BuildSky) = 58 at the 34 basin, RMW2
 *     swapped = 68, both = 62.  The 24-bit-AND-first spelling stays here.
 *   - a named temp for `*(u_int *)p` (to fix the RMW load order) is BIT-IDENTICAL in three
 *     basins; the laundered form costs +1 insn.  The 4-line load-order residual STAYS.
 *   - `iVar15 + (int)hsd` / a block-scoped `q2` temp in the `8 <= ringPMX` arm: INERT in
 *     three basins (fold reassociates it back) -- the `addu v1,s6,s2` line STAYS.
 *   - the init pair's POSITION (void fence before/after it, decl-with-init, moving it above
 *     `m24`): all inert at 20 -- only the ORDER of the two inits moves (F).
 * REMAINING 20, measured POSITIONALLY (scratchpad/W74_A4/posmis.py; posmis=48/473) -- the
 * LCS count under-weights the biggest one:
 *   [186-190] the `iVar18/iVar15` init pair vs the two hoisted invariants: a 5-insn
 *             rotation.  Order of the two inits is a dial (that is lever (F)); their
 *             POSITION is a sched1 fixpoint -- fences either side, decl-with-init and
 *             moving them above `m24` all measured inert.
 *   [243-281] ONE insn: retail fills the clipW `lhu`'s LOAD-DELAY slot with the
 *             `lh v1,40(sp)` (mpts[0].vx) and we emit a nop, which shifts 39 positions.
 *             Falsified this pass: a named `m0x` temp after the launder (inert) or before
 *             it (breaks the count: 17 LCS but posmis 197), and hoisting the `(short)cw`
 *             cast into its own statement (inert).
 *   [332-335] the RMW1 load order (*p before *pal in retail) -- see the falsification list.
 *   [380-380] `addu v1,s6,s2` operand order -- three spellings falsified in three basins.
 * BRANCH-WORD STATE (tools/brdist.py, run this pass): 2 offset diffs (branch 18: 142 vs
 * 143, branch 22: 126 vs 127) -- both are the SAME 1-insn shift as the [243-281] run above,
 * not a control-flow defect; they disappear with it.  HrzSetPsxMatrix (now PASS) is clean.
 * Harness: scratchpad/W74_A4/probe.py + posmis.py + gen_bh{,2..18}.py (always restores).
 * ===== W75-A8 (2026-08-23): 20 -> 12 @473/473 COUNT-EXACT, posmis 48 -> 9.  TWO of the
 * four W74 residuals are CLOSED, including the clipH lui that had stood since w64 (4th
 * basin) -- and they were closed TOGETHER, as one +-1 TRADE CELL (catalog 23B(1)).
 * (1) NEW LAW -- A ZERO-BYTE ASM IS A REAL SCHEDULING INSN AND WILL EAT A LOAD-DELAY
 *     SLOT.  A non-volatile launder __asm__("" : "=r"(x) : "0"(x)) is an RTL insn that
 *     emits NO BYTES.  sched sees it as ready one cycle after the load that feeds it, parks
 *     it in the lhu load-delay gap, and reports the latency satisfied -- but since it
 *     assembles to nothing, the slot comes out as a NOP.  That is exactly the one insn
 *     retail spends on lh v1,40(sp) (mpts[0].vx) at the clipW site.  This is a DISTINCT
 *     cost from 23B(2) (an identity launder addu lands in whatever delay slot is
 *     nearby) -- here the launder emits nothing at all and still costs a slot.
 *     THE CURE (zero insns): give the asm the value you want in the slot as an EXTRA INPUT,
 *     __asm__("" : "=r"(cw) : "0"(cw), "r"((int)mpts[0].vx)); -- the lh must now be
 *     scheduled ABOVE the asm, so it lands in the slot and the asm sits where there is no
 *     stall.  The operand costs nothing (it is the lh own destination register).
 *     GENERALISES: any "ours has a nop where retail fills the slot" next to an existing
 *     zero-byte fence/launder is this; the extra-input form is the fix.
 * (2) THE clipH SITE IS THE SAME SHAPE AS clipW, and the three previously-falsified
 *     spellings failed because they were priced ALONE and because they emit a SIGNED load:
 *       plain literal *(short *)0x1f800012        61 @472  (emits lh + NO sll/sra: -1)
 *       plain int ch = *(u_short *)0x1f800012;    61 @472  (combine re-fuses it to lh)
 *       int ch + extra-input launder              17 @474  (correct shape, +1)
 *     Only the last is retail lui 0x1F80 / lhu / sll 16 / sra 16.  Paired with (1)
 *     -1 it is EXACTLY count-neutral -- 14 @473, posmis 48 -> 10.
 * (3) 14 -> 12: int q = iVar15 + (int)hsd; (INDEX-FIRST int sum, 12D) in the <8 ringPMX
 *     arm.  W74 filed this "INERT in three basins (fold reassociates it back)"; it is NOT
 *     inert once the two clip residuals are closed.  04Z / 23B(7) re-pricing.
 * REMAINING 12 = TWO clusters (posmis 9):
 *   [187-193] the iVar18/iVar15 init pair vs the two loop.c hoists -- retail emits the
 *             HOISTS FIRST (lui/addiu fp, addu s3,s6,zero) and the two inits after.
 *             NEW NAMED ANGLE (not run -- out of budget): loop.c appends its hoists at the
 *             END of the preheader, so a PRE-LOOP assignment can never sit after them
 *             (21B(3)); retail addu s2,s4,zero / li s5,4 are therefore very likely
 *             loop.c own GIV INITIALISERS -- i.e. iVar15/iVar18 are NOT source variables
 *             (they are absent from the SYM, which lists only right/prim/pmx in this block)
 *             but strength-reduced i-indexed accesses (23C(4)/(5)).  The rewrite is to
 *             index every hsd + iVar15 + K / + iVar18 + K by i / i+1 and delete both
 *             counters.  Falsified cheaply first: init order swapped 16, iVar15 = i;
 *             iVar18 = iVar15 + 4; 16, a 2-operand fence before the pair 74 @475.
 *   [335-338] the RMW1 evaluation order.  ORACLE-READ TRUTH: retail RMW1 is TAG-FIRST --
 *             it loads *(u_int *)p first (lw v1,0(s0) before lw v0,-8(a0)), ANDs it
 *             with $a1=0xff000000, and the OR dest is that same reg.  Our 24-bit-first
 *             spelling is provably NOT retail.  Writing it tag-first (*(u_int *)p =
 *             *(u_int *)p & 0xff000000 | *pal & m24;) makes ALL FOUR of those lines match
 *             -- and is blocked by ONE local-alloc slot rotation: ours then gives pp $a1
 *             and the 0xff000000 hoist $t1 where retail has $a2 and $a1 (36 @473, posmis
 *             18).  EVERY device tried on that rotation fails: a clobber of ANY register
 *             ("$4","$5","$6","$7", singly or paired) added to the pp launder costs a
 *             uniform +4 insns (40 @477) -- 20B LIMIT (2), bad_spill_regs function-wide;
 *             deleting the pp anchor instead = 80 @475; a named u_int m8 = 0xff000000
 *             (+/- its own read-only fence) = 36 @473, unchanged.
 *             MEASURED SIBLING BASIN, NOT SHIPPED: u_int tv = *(u_int *)p;
 *             __asm__("" : : "r"(tv)); before an unchanged 24-first RMW1 gates **10 diffs**
 *             @473 -- the two lw and the two and all become byte-exact -- but posmis
 *             rises 9 -> 16 because the lui a1,65280 slides 7 positions into the block
 *             (the output-less fence is a sched1 barrier) and the OR dest flips.  Per the
 *             count-exact metric rule (posmis, not LCS) the 12/posmis-9 basin is shipped;
 *             the 10/posmis-16 form is recorded here as a real alternative basin for
 *             whoever solves the pp $a1-vs-$a2 rotation, since it already owns the load
 *             order.  Also measured there: the fence one statement later 34, next to the
 *             m24 fence 20, before the RMW as a 2-operand fence 54, tag-first on top 36.
 *             Device-free birth-order forms (u_int pv = *pal; after tv, or moving the
 *             pal = statement below tv) are BIT-IDENTICAL -- cse re-folds them; the
 *             volatile fence is the only thing that holds the order.
 * Harness: scratchpad/w75/{probe,posmis,sbsdump}.py + e_{a,b,c,d,f,g,h,i,j,k,l}*.py. */
typedef struct { unsigned addr : 24, len : 8; } Hrz_PTag;

void Hrz_BuildHorizon(DRender_tView *Vi)

{
  coorddef trans;
  int fxOverlapPercentage;
  int hrz_projchange;
  int i;
  Draw_HorizonCache *hsd;

  /* The SYM has no records for these source-shaping identities.  Each is retained only
     where an oracle-measured natural spelling changes code generation; the detailed
     receipts below give the corresponding experiment and delta.
     SYM-CODEGEN-CARRIER: c1
     SYM-CODEGEN-CARRIER: ch
     SYM-CODEGEN-CARRIER: cw
     SYM-CODEGEN-CARRIER: fo
     SYM-CODEGEN-CARRIER: ringOffset
     SYM-CODEGEN-CARRIER: nextRingOffset
     SYM-CODEGEN-CARRIER: m24
     SYM-CODEGEN-CARRIER: farCoord
     SYM-CODEGEN-CARRIER: pal
     SYM-CODEGEN-CARRIER: pp
     SYM-CODEGEN-CARRIER: q
     SYM-CODEGEN-CARRIER: shape_idx
     SYM-CODEGEN-CARRIER: shape_visible
     The two shape pointers are additionally proven by the natural hsd->array[i] rewrite:
     it regresses 12 @473 to 24 @475.  Deriving ringOffset/nextRingOffset directly from i regresses to
     156 @469 and changes the retail 128-byte frame to 120 bytes. */

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
    int i;                      /* SYM: nested "i" -- shadows the function-scope ring index */
    int farI, Zmax, dx, dy;
    int shape_visible, shape_idx;
    SVECTOR *farCoord;

    Hrz_RotProj16(0x11,gRngCoordTop,(int *)((int)hsd + 0x124),(DVECTOR *)((int)hsd + 0x58));
    farI = 0;
    Zmax = 0;
    zval = (int *)((int)hsd + 0x124);
    i = 0;
    /* MATCH (W74-A4, 58 -> 50): ZERO-INSN HARD-REG CONFLICT (catalog 20B / 22B(2)) --
       the AVAILABILITY half of the nested-i residual the w72 receipt could only name.
       The w72 fence below fixed the PRIORITY order (zval=$a0, Zmax=$a1); this denies $a2
       to the quantities live here so find_reg's ascending scan gives the nested i retail's
       $a3.  BOTH are required (dropping the fence below gates 78).  Position is the dial:
       one statement earlier (before `i = 0;`) is INERT at 58. */
    do {
      if (Zmax < *zval) {
        Zmax = *zval;
        farI = i;
      }
      i = i + 1;
      zval = zval + 1;
    } while (i < 0x10);
    /* MATCH (W74-A4, 34 -> 30): index-first INT sum (12D law) -- the oracle emits
       `sll a0,t0,3; addu a0,a0,v0` with the farI product as addu operand 0; the natural
       `gRngCoordTop + farI` is pointer arithmetic and is always rebuilt ptr-first. */
    farCoord = (SVECTOR *)(farI * 8 + (int)gRngCoordTop);
    updown[0].vx = farCoord->vx;
    updown[0].vy = (short)Hrz_gTrackSpec->yoffset + (short)Hrz_gTrackSpec->height;
    updown[0].vz = farCoord->vz;
    updown[1].vx = farCoord->vx;
    updown[1].vy = (short)Hrz_gTrackSpec->yoffset;
    /* MATCH (W72-A4, -22): ZERO-INSN LIVE-RANGE fence that demotes the nested `i`.  The
       max-search loop's three globals price floor_log2(refs)*refs*4/live as
       nested i 108/L > zval 56/L > Zmax 40/L, so ours served i first and it took
       $a0; retail's order is zval=$a0, Zmax=$a1, i=$a3.  Extending i's live
       range past the loop drops it below both rivals.  POSITION is the whole dial (the
       plateau is exactly this updown[] region: one statement earlier = 99, one later = 63,
       at the second loop's `i = 0` = 164); operand COUNT is inert (1/2/3 all 58).
       DO NOT DELETE. */
    __asm__("" : : "r"(i));
    updown[1].vz = farCoord->vz;
    {
      /* SYM block line=55 (nested in line=30): a single {p_,s_} scope REUSED for both
         transforms -- straight-line "down" then "up" (not a loop; matches the oracle's
         unrolled order: temp2d[1] computed first, temp2d[0] second). */
      SVECTOR p_;
      long s_;
      p_ = updown[1];
      gte_ldv0(&p_);
      gte_rtps();
      gte_stsxy2((DVECTOR *)&s_);
      *(long *)&temp2d[1] = s_;   /* MATCH: word copy (a DVECTOR assign = align-1 lwl/lwr quad) */
      /* MATCH (W74-A4, part of 25 -> 22 and the count back to EXACT): a zero-insn VOID
         FENCE stops sched1 SINKING the `sw v0,60(sp)` write-back past the second
         transform's movstrsi copy.  Retail stores it immediately after its load and pays
         the load-delay nop; ours filled that slot and came out one insn short. */
      __asm__("" : : "i"(0));
      p_ = updown[0];
      gte_ldv0(&p_);
      gte_rtps();
      gte_stsxy2((DVECTOR *)&s_);
      *(long *)&temp2d[0] = s_;   /* MATCH: word copy, see above */
    }
    /* BUG FIX (round 2 diagnosis, now applied): each loop computes its OWN dx/dy delta ONCE
       from its own temp2d[] entry against a freshly-read posA[farI] baseline -- not a shared
       `right` value recomputed every iteration. */
    {
      /* MATCH (W72-A4, -4 for the pair of blocks): BLOCK-SCOPED offset temp = the
         fold-reassociation escape (21C-5).  The flat `((int)hsd + 0x58) + farI * 4`
         reassociates so the scaled index becomes addu operand 0 (`addu v0,v0,s6`); the
         plain re-spelling `(int)hsd + farI*4 + 0x58` is BIT-IDENTICAL, only a real
         block-scoped variable stops fold and gives retail's `addu v0,s6,v0`. */
      int fo = farI * 4;
      dx = temp2d[0].vx - *(short *)((int)hsd + fo + 0x58);
      dy = temp2d[0].vy - *(short *)((int)hsd + fo + 0x5a);
    }
    i = 0;
    shape_visible = (int)hsd;
  up_delta_loop:
      if (0 < *(int *)(shape_visible + 0x124)) {
        *(short *)(shape_visible + 0x14) = *(short *)(shape_visible + 0x58) + dx;
        *(short *)(shape_visible + 0x16) = *(short *)(shape_visible + 0x5a) + dy;
      }
      i = i + 1;
      shape_visible = shape_visible + 4;
    if (i < 0x11) goto up_delta_loop;
    {
      int fo = farI * 4;
      dx = temp2d[1].vx - *(short *)((int)hsd + fo + 0x58);
      dy = temp2d[1].vy - *(short *)((int)hsd + fo + 0x5a);
    }
    i = 0;
    shape_idx = (int)hsd;
  down_delta_loop:
      if (0 < *(int *)(shape_idx + 0x124)) {
        *(short *)(shape_idx + 0x58) = *(short *)(shape_idx + 0x58) + dx;
        *(short *)(shape_idx + 0x5a) = *(short *)(shape_idx + 0x5a) + dy;
      }
      i = i + 1;
      shape_idx = shape_idx + 4;
    if (i < 0x11) goto down_delta_loop;
  }
  Horizon_InterpolateLineSCoords((DVECTOR *)((int)hsd + 0x9c),(DVECTOR *)((int)hsd + 0x58),(DVECTOR *)((int)hsd + 0x14),
             gfxPmxHeightPercentage,0x10,1);
  Horizon_InterpolateLineSCoords((DVECTOR *)((int)hsd + 0xe0),(DVECTOR *)((int)hsd + 0x5c),(DVECTOR *)((int)hsd + 0x18),
             gfxPmxHeightPercentage,0x10,1);
  {
    /* SYM block line=107/114/115: mpts[4] -- reuses the stack space freed by updown/temp2d
       above (both blocks are DISJOINT in the oracle's frame layout). */
    DVECTOR mpts [4];

    i = 0;
    if (HRZ_TRACK_HORIZON_STATE != 0) {
      /* SYM block line=142: right/prim/pmx -- nested one level deeper again. */
      DVECTOR right;
      POLY_GT4 *prim;
      Draw_tPixMap *pmx;
      u_int *pal;
      u_char **pp;
      u_int c1;

      /* MATCH (W72-A4, -12 with its fence below): the 24-bit OT mask as a NAMED local.
         Naming it alone is neutral (96) and the identity-launder form is worse (102); it
         only pays together with the one-operand read-only fence at its last use, which
         buys +2 loop-weighted refs and flips the mask/colour-base pair onto retail's
         $s7/$fp.  See the W72-A4 receipt block above the function. */
      u_int m24 = 0xffffff;
      /* MATCH (W74-A4, 22 -> 20): the two inits in THIS order (iVar18 first) -- a pure
         sched2 LUID tie-break.  Their POSITION relative to the hoisted invariants is a
         sched1 fixpoint: fences either side, decl-with-init and moving them above `m24`
         all measured inert. */
      /* MATCH: exit-in-the-middle (top test + unconditional `j` back edge with the
         counter increment in its delay slot) -- a `for` rotates to a bottom-tested
         do-while (slti/bnez), which the oracle does not have. */
      while (true) {
        if (!(i < 0x10)) break;
        int ringOffset = i * 4;
        int nextRingOffset = i * 4 + 4;
        if ((15999 < *(int *)((int)hsd + ringOffset + 0x124)) || (15999 < *(int *)((int)hsd + nextRingOffset + 0x124))) {
          mpts[0] = *(DVECTOR *)((int)hsd + ringOffset + 0x9c);          /* posB[k] */
          mpts[1] = *(DVECTOR *)((int)hsd + ringOffset + 0xe0);          /* posC[k] */
          mpts[2] = *(DVECTOR *)((int)hsd + nextRingOffset + 0x58);    /* posA[k+1] */
          mpts[3] = *(DVECTOR *)((int)hsd + ringOffset + 0x58);          /* posA[k] */
          {
            /* MATCH: De Morgan direct form -- m2c shows this as an AND-of-4-ORs (each OR is
               the negation of "all 4 <0"/"all 4 lo<vx" etc), NOT the mathematically-equivalent
               negated-OR-of-ANDs. Same truth table, but the compiled short-circuit branch
               chain differs completely; write the form m2c actually shows.
               lo/hi read AT POINT OF USE (not pre-declared before the clause1 chain) -- the
               oracle defers the 0x1F800010/12 read until clause2 is actually reached (only
               after clause1's OR falls all the way through); a pre-if local hoists it early. */
            /* MATCH (W72-A4, -18 and the count made EXACT 473/473): the flat 4-clause `&&`
               is written as NESTED ifs ONLY so that clause 2's clipW read can have a block
               to declare in.  Nesting on its own is BIT-IDENTICAL to the flat form; the
               win is the laundered int -- `(short)(u_short)MEM` folds at TREE level, so no
               single expression can keep retail's UNFUSED `lui 0x1F80; lhu; sll 16; sra 16`
               shape.  The value must pass through a real `int` whose zero-extended pseudo
               still exists at combine time, and the declaration must sit INSIDE clause 1
               (the oracle's read is at .L800D16E0, the target clause-1's OR chain jumps
               to).  DO NOT hoist it above the `if`, and do NOT re-flatten the chain. */
            if (mpts[0].vx >= 0 || mpts[1].vx >= 0 || mpts[2].vx >= 0 || mpts[3].vx >= 0) {
            int cw = *(u_short *)0x1f800010;
            /* MATCH (W75-A8, part of 20 -> 14 and the clipW nop KILLED): the extra
               "r" input is the ZERO-BYTE-ASM-IN-A-LOAD-DELAY-SLOT cure (new law).  A
               non-volatile launder is a real RTL insn that emits NO bytes; sched happily
               parks it in the `lhu`'s load-delay gap, the latency reads as satisfied and
               the assembler still has to nop the slot -- which is exactly the one insn
               retail spends on `lh v1,40(sp)` (mpts[0].vx).  Giving the asm that same
               value as an extra INPUT forces the `lh` to be scheduled ABOVE the asm, so it
               lands in the slot for free.  Zero insns (the operand is the lh's own dest).
               Priced with the clipH twin below: this half alone is 17 @472 (count short). */
            __asm__("" : "=r"(cw) : "0"(cw), "r"((int)mpts[0].vx));
            if ((short)cw >= mpts[0].vx || (short)cw >= mpts[1].vx ||
                 (short)cw >= mpts[2].vx || (short)cw >= mpts[3].vx) {
            if (mpts[0].vy >= 0 || mpts[1].vy >= 0 || mpts[2].vy >= 0 || mpts[3].vy >= 0) {
            /* MATCH (W75-A8, the other half of 20 -> 14): the clipH read is the SAME
               shape as the clipW one above -- a fresh `lui 0x1F80` + `lhu` + an UNFUSED
               sll/sra extend -- i.e. retail did NOT reach clipH through the `hsd` pointer
               (which is why ours emitted the single `lhu v0,18(s6)`).  Three spellings had
               been falsified before because they were priced ALONE: the plain literal
               `*(short *)0x1f800012` emits a SIGNED `lh` and folds the extend away (61 @472),
               and the plain `int ch` does the same (61 @472, b3).  It must be the
               zero-extended `u_short` read through a real `int` (so combine cannot fuse the
               (short) cast back into an `lh`) PLUS the same extra-input launder, which is
               zero-insn here too: 17 @474 alone, and EXACTLY count-neutral when paired with
               the clipW half (the +-1 TRADE CELL of catalog 23B(1)). */
            int ch = *(u_short *)0x1f800012;
            __asm__("" : "=r"(ch) : "0"(ch), "r"((int)mpts[0].vy));
            if ((short)ch >= mpts[0].vy || (short)ch >= mpts[1].vy ||
                 (short)ch >= mpts[2].vy || (short)ch >= mpts[3].vy) {
              Horizon_InterpolateLineSCoords(&right,(DVECTOR *)(((int)hsd + 0x9c) + ringOffset),
                         (DVECTOR *)(((int)hsd + 0xe0) + ringOffset),&fxOverlapPercentage,1,0);
              pmx = *(Draw_tPixMap **)((int)gpPmx + ringOffset);
              if (Hrz_gTrackSpec->ringPMX[i] != '\x10') {
                int iv; /* SYM-CODEGEN-CARRIER: iv -- a fresh i*4 at this
                           colour-table site emits retail's independent sll.
                           Reusing the strength-reduced ringOffset measures FAIL 3
                           at 472/473; this separate carrier is PASS 473. */
                iv = i * 4;
                /* MATCH (W74-A4, 50 -> 42): FENCED HELD-ADDRESS ANCHOR (05F / 14D /
                   methodology 3.12 #16).  Retail materialises &Render_gPacketPtr ONCE
                   (`lui a2,8064; ori a2,a2,4`) and writes the +0x34 bump back through
                   THAT register at the end of the block; every earlier wave moved the
                   bump alone and paid +2 insns because the address re-materialised.  An
                   UNFENCED `pp` is const-propagated back to the literal (bit-identical
                   to the old form, measured); the opacity launder keeps it in a register
                   so the late bump below is FREE.  Bump-position sweep: after colour-1
                   42 (min) - after the m24 fence 44 - after colour-2/3 46 - after the
                   4th 48 - after SetPolyGT4 175 @476. */
                pp = (u_char **)0x1f800004;
                __asm__("" : "=r"(pp) : "0"(pp));
                prim = (POLY_GT4 *)*pp;
                /* MATCH (w50-a5): the OT-link RMW pair runs off the ALREADY-LOADED
                   cursor `prim` and ONE shared palette-slot pointer `pal`, never a fresh
                   scratchpad re-read (catalog w40 packet-emission (a) + the shared-base
                   row).  The oracle materializes &Render_gPacketPtr ONCE (`lui a2,8064;
                   ori a2,a2,4`), loads the cursor into a saved reg (`lw s0,0(a2)`),
                   computes the OT slot ONCE (`sll a0,a0,2; addu a0,a0,v0`) and reuses
                   both for read, write-back and the +0x34 bump; our old form re-read the
                   0x1F800004 literal and recomputed the slot at each of the four sites
                   (+6 insns in this block alone).  214 -> 166 diffs, 477 -> 471 insns. */
                /* MATCH (W74-A4, 42 -> 34): INT-TYPED index-first sum (12D law) -- the
                   oracle's `sll a0,a0,2; addu a0,a0,v0` has the OtSize product as addu
                   operand 0; a pointer-typed sum is always rebuilt ptr-first. */
                pal = (u_int *)(Draw_gViewOtSize * 4 + (int)Render_gPalettePtr + -8);
                /* MATCH (W72-A4, -4): the FIRST RMW's OR operands are SWAPPED (24-bit AND
                   first).  loop.c walks movables in RTL-GENERATION order and spends its
                   budget on the first it accepts, so whichever mask constant is generated
                   first is the one hoisted -- this token is what makes our preheader hoist
                   the two-insn 0xFFFFFF (retail's) instead of the one-insn 0xFF000000.
                   SITE-SELECTIVE: the same swap on the SECOND RMW costs +4, both = +4. */
                ((Hrz_PTag *)prim)->addr = *pal & m24;
                *pal = *pal & 0xff000000 | (u_int)prim & m24;
                /* MATCH (W72-A4): the m24 ref dial -- see the decl above.  ONE operand
                   only (n=2 -> 116, n=3 -> 128) and anywhere AFTER the second RMW
                   (between the two RMWs -> 106). */
                __asm__("" : : "r"(m24));
                /* MATCH (W74-A4): the cursor bump sits BETWEEN the first colour load and
                   its store, exactly as retail emits it (`lw v1,0(v0); addiu v0,s0,52;
                   sw v0,0(a2); sw v1,4(s0)`) -- splitting the load out of the store is
                   what lets the bump land there.  After this the whole packet block is
                   byte-identical to the oracle bar the two RMW load-order lines. */
                c1 = *(u_int *)(&gHrzRingColor[1][0].r + iv);
                *pp = (u_char *)prim + 0x34;
                *(u_int *)((u_char *)prim + 4) = c1;
                *(u_int *)((u_char *)prim + 0x10) = *(u_int *)(&gHrzRingColor[1][1].r + ringOffset);
                *(u_int *)((u_char *)prim + 0x1c) = *(u_int *)(&gHrzRingColor[0][0].r + ringOffset);
                *(u_int *)((u_char *)prim + 0x28) = *(u_int *)(&gHrzRingColor[0][1].r + ringOffset);
                SetPolyGT4(prim);
                *(u_int *)((u_char *)prim + 0xc) = *(u_int *)pmx;
                *(u_int *)((u_char *)prim + 0x18) = ((u_int *)pmx)[1];
                *(u_int *)((u_char *)prim + 0x24) = ((u_int *)pmx)[2];
                *(u_int *)((u_char *)prim + 0x30) = ((u_int *)pmx)[3];
                /* MATCH: arm-swap (catalog §A) -- m2c shows the branch condition as the
                   DIRECT ">=8" form (fall-through arm is >=8, not <8); the inverted-and-swap
                   compiles with the SAME polarity/inline-arm layout the oracle uses. */
                if (8 <= (u_char)Hrz_gTrackSpec->ringPMX[i]) {
                  /* MATCH: WORD copy -- a DVECTOR struct assignment emits the align-1
                     lwl/lwr+swl/swr quad; the oracle does one lw/sw pair. */
                  *(u_int *)((u_char *)prim + 8) = *(u_int *)&right;
                  *(u_int *)((u_char *)prim + 0x14) = *(u_int *)((int)hsd + ringOffset + 0x9c);
                  *(u_int *)((u_char *)prim + 0x20) = *(u_int *)((int)hsd + ringOffset + 0x5c);
                  *(u_int *)((u_char *)prim + 0x2c) = *(u_int *)((int)hsd + ringOffset + 0x58);
                }
                else {
                  /* MATCH (W75-A8, 14 -> 12): INDEX-FIRST int sum (12D law) -- the oracle
                     emits `addu v1,s2,s6` with ringOffset (=$s2) as addu operand 0.  W74 filed
                     this spelling "INERT in three basins (fold reassociates it back)"; it is
                     NOT inert once the two clip residuals are closed -- 04Z / catalog 23B(7)
                     re-pricing, worth 2 diffs and posmis 10 -> 9 here. */
                  int q = ringOffset + (int)hsd;
                  __asm__("" : "=r"(q) : "0"(q));
                  *(u_int *)((u_char *)prim + 8) = *(u_int *)(q + 0x9c);
                  *(u_int *)((u_char *)prim + 0x14) = *(u_int *)&right;   /* MATCH: word copy, see above */
                  *(u_int *)((u_char *)prim + 0x20) = *(u_int *)(q + 0x58);
                  *(u_int *)((u_char *)prim + 0x2c) = *(u_int *)(q + 0x5c);
                }
              }
            }
            }
            }
            }
          }
        }
        i = i + 1;
      }
    }
  }
  if ((Night_gLightning != 0) && (Night_gShowForks != '\0')) {
    Hrz_BuildForkLightning((Draw_DCache *)&Render_gPalettePtr);
  }
  if ((HRZ_TRACK_SKY_FLAGS & 8U) != 0) {
    coorddef trans2;
    memset(&trans2,0,0xc);
    HrzSetPsxTranslation(&trans2);
    Flare_Moon(MOONPOS,(Draw_FlareCache *)&Render_gPalettePtr);
  }
  if ((HRZ_TRACK_SKY_FLAGS & 0x10U) != 0) {
    Sky_RenderStars((Draw_SkyCache *)&Render_gPalettePtr,Draw_gViewOtSize + -2);
  }
  if (HRZ_TRACK_SKY_STATE != 0) {
    Hrz_BuildSky();
  }
  if (hrz_projchange != 0) {
    SetGeomScreen(hrz_projchange);
  }
  return;
}

/* end of hrzsku.cpp */
