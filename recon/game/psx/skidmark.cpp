/* game/psx/skidmark.cpp -- RECONSTRUCTED (NFS4 PSX tyre skid-mark system; C++ TU)
 *   11 fns: Calc{Start,One}Segment (perp-offset segment geometry), Skidmark_CheckChunk
 *   (24-slot chunk allocator), Skidmark_Add/AddStretch/Stretch/EndStretch (append/extend
 *   skid trails), Skidmark_OnyxBuildFacets (queue render), Init/Restart/Kill. No GTE.
 */
#include "skidmark_externs.h"

/* ---- Skidmark.obj-OWNED globals -- DEFINED here (self-contained; SYM-typed via gen_owned_defs:
   .data = real NFS4.EXE bytes, .bss = zero) ---- */
Skidmark_Chunk *gSm;   /* @0x8013dac8  (bss(zero)) */
int          gCountSm;   /* @0x8013dacc  (bss(zero)) */
int          gUseSm;   /* @0x8013dad0  (bss(zero)) */
int          gMaxSChunk;   /* @0x8013dad4  (bss(zero)) */
/* skid-spline control-point + scratch state (extern-declared in draww/bworld externs,
   defined here in the owning Skidmark.obj TU; BSS zero -- runtime spline work area).
   🔴 AUDIT (w40-a9, at the coordinator's request after a2's Draw_kCtrlSkidmark fix):
   these are LINK-HARNESS STORAGE ONLY -- there is NO writer and no reader anywhere in
   skidmark.cpp (grep: the four lines below are the only occurrences in this TU), and
   NO Skidmark_* oracle contains a scratchpad literal at all: the complete `lui`
   immediate census over asm/nonmatchings/main/Skidmark_*.s is
     2x (0xFFFFF...), 1x %hi(D_801131F8), 1x %hi(D_80056A14)
   -- zero `lui 0x1F80`, zero swc2/GTE (this TU uses none).  So the scratchpad-vs-.bss
   stale-data bug class (Skid_gCtrlScratch_94 @0x1F800094, Skid_gScratchPos1/2 @0x1F8000DC
   /0xDE) is entirely contained in draww.cpp/hrzsku.cpp, which own BOTH the writes (GTE
   swc2 to the literal address) and the reads.  These definitions exist only so those TUs
   link; none of them appears in configs/symbol_addrs.txt or asm/data (they are Ghidra
   "lost-symbol" inventions, not real NFS4.EXE symbols).  When draww/hrzsku convert the
   cluster to fixed-address lvalue macros (methodology sec.3.6b) these four lines must be
   DELETED in the same pass -- a macro collides with an extern decl.  Deliberately left in
   place this wave: removing them alone would break the draww/hrzsku link with no gate
   benefit here (skidmark.cpp's own gates are unaffected either way, verified). */
int          Skid_gCtrlPoint_0, Skid_gCtrlPoint_1, Skid_gCtrlPoint_2, Skid_gCtrlPoint_3;
int          Skid_gCtrlPoint_4, Skid_gCtrlPoint_5, Skid_gCtrlPoint_6;
int          Skid_gCtrlScratch_94, Skid_gCtrlScratch_98;
int          Skid_gScratchPos1, Skid_gScratchPos2;


/* ---- CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i  [SKIDMARK.CPP:48-72] SLD-VERIFIED ---- */
void CalcStartSegment(Skidmark_Segment *r1,Skidmark_Segment *r2,coorddef *cp,coorddef *pt1,
                      coorddef *pt2,int tireWidth)

{
  int angle;
  int pxp;
  int pzp;

  angle = intatan(pt2->x - pt1->x,pt2->z - pt1->z);
  pxp = fixedmult(tireWidth,-fastintcos(angle)) >> 1;
  pzp = fixedmult(tireWidth,fastintsin(angle)) >> 1;
  r1->svx[0].vx = (short)((pt1->x + pxp) - cp->x >> 6);
  r1->svx[0].vy = (short)(pt1->y - cp->y >> 6);
  r1->svx[0].vz = (short)((pt1->z + pzp) - cp->z >> 6);
  r1->svx[1].vx = (short)((pt1->x - pxp) - cp->x >> 6);
  r1->svx[1].vy = (short)(pt1->y - cp->y >> 6);
  r1->svx[1].vz = (short)((pt1->z - pzp) - cp->z >> 6);
  r2->svx[1].vx = (short)((pt2->x - pxp) - cp->x >> 6);
  r2->svx[1].vy = (short)(pt2->y - cp->y >> 6);
  r2->svx[1].vz = (short)((pt2->z - pzp) - cp->z >> 6);
  r2->svx[0].vx = (short)((pt2->x + pxp) - cp->x >> 6);
  r2->svx[0].vy = (short)(pt2->y - cp->y >> 6);
  r2->svx[0].vz = (short)((pt2->z + pzp) - cp->z >> 6);
  return;
}

/* ---- CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i  [SKIDMARK.CPP:81-99] SLD-VERIFIED ---- */
void CalcOneSegment(Skidmark_Segment *r1,coorddef *cp,coorddef *pt1,coorddef *pt2,int tireWidth)

{
  int angle;
  int pxp;
  int pzp;

  angle = intatan(pt2->x - pt1->x,pt2->z - pt1->z);
  pxp = fixedmult(tireWidth,-fastintcos(angle)) >> 1;
  pzp = fixedmult(tireWidth,fastintsin(angle)) >> 1;
  r1->svx[0].vx = (short)((pt2->x + pxp) - cp->x >> 6);
  r1->svx[0].vy = (short)(pt2->y - cp->y >> 6);
  r1->svx[0].vz = (short)((pt2->z + pzp) - cp->z >> 6);
  r1->svx[1].vx = (short)((pt2->x - pxp) - cp->x >> 6);
  r1->svx[1].vy = (short)(pt2->y - cp->y >> 6);
  r1->svx[1].vz = (short)((pt2->z - pzp) - cp->z >> 6);
  return;
}

/* ---- Skidmark_CheckChunk__FP8coorddefii  [SKIDMARK.CPP:115-151] SLD-VERIFIED ---- */
Skidmark_Chunk *
Skidmark_CheckChunk(coorddef *skidpt,int newsegs,int slice)

{
  int NewChunk;
  int d; /* SYM-CODEGEN-CARRIER: d -- preserves separate signed axis compare arms */
  int nseg; /* SYM-CODEGEN-CARRIER: nseg -- required for the in-place segment sum */
  Skidmark_Chunk *returnsm;

  returnsm = gSm + gUseSm;
  /* MATCH (w39-a10): the segment total must be a NAMED local MUTATED IN PLACE
     (`nseg = returnsm->n; nseg = nseg + newsegs;`) -- the one-expression form
     `0x18 < returnsm->n + newsegs` gives the sum its own anonymous pseudo, which
     local-alloc parks in $t1 (needNew's home) instead of reusing the dying $v0
     that held returnsm->n.  Same pseudo on both sides of the `+` guarantees the
     oracle's in-place `addu $v0,$v0,$a1; slti $v0,$v0,0x19`.  (Reusing the
     existing `d` for this REGRESSES 4 -> 55: `d` is live across the three axis
     arms, so it becomes a global allocno and drags the whole compare chain.) */
  nseg = returnsm->n;
  nseg = nseg + newsegs;
  NewChunk = 0x18 < nseg;
  /* The oracle does NOT compute |d| once and compare once -- it materializes the
     0xFFFFF limit and does a SEPARATE `slt 0xFFFFF,<diff>` in EACH arm
     (`blez a1,.L800DEA48` + a duplicated `lui/ori 0xFFFFF`), i.e. the source is a
     two-comparison ternary per axis, not an abs-then-compare. */
  d = (returnsm->cp).x - skidpt->x;
  if ((0 < d) ? (0xfffff < d) : (0xfffff < skidpt->x - (returnsm->cp).x)) {
    NewChunk = true;
  }
  else {
    d = (returnsm->cp).y - skidpt->y;
    if ((0 < d) ? (0xfffff < d) : (0xfffff < skidpt->y - (returnsm->cp).y)) {
      NewChunk = true;
    }
    else {
      d = (returnsm->cp).z - skidpt->z;
      if ((0 < d) ? (0xfffff < d) : (0xfffff < skidpt->z - (returnsm->cp).z)) {
        NewChunk = true;
      }
    }
  }
  if (NewChunk) {
    if (gCountSm < gMaxSChunk) {
      gUseSm = gCountSm;
      gCountSm = gCountSm + 1;
    }
    else if (gUseSm < gMaxSChunk + -1) {
      gUseSm = gUseSm + 1;
    }
    else {
      gUseSm = 0;
    }
    returnsm = gSm + gUseSm;
    returnsm->n = 0;
  }
  if (returnsm->n == 0) {
    returnsm->cp = *skidpt;
    returnsm->slice = (short)slice;
  }
  return returnsm;
}

/* ---- Skidmark_Add__FP5tSkidP8coorddefP7CVECTORiii  [SKIDMARK.CPP:159-239] SLD-VERIFIED ----
 * NEAR-MISS 14 diffs (w39-a10, was 98).  The w38 note that blamed a "$s4<->$s5
 * parameter tie" was WRONG -- the whole rotation was a CROSS-JUMP-DEPTH artifact:
 *   (1) `sm->seg[n].type = type;` must live INSIDE EACH ARM (arm1 indexes the arm's
 *       own `n` = sm->n, arm3 recomputes `sm->n + 1`), NOT in the shared tail.  With
 *       one shared `n` variable both arms feed the SAME hard reg, so gcc's post-reload
 *       cross-jump merges 2 insns deeper than retail (`sll ,3; subu` get merged too)
 *       and the whole index web re-colours.  Retail's tail starts at `sll $v0,$v0,2`.
 *   (2) arm3's CalcStartSegment must use the INLINE `&sm->seg[sm->n]` /
 *       `&sm->seg[sm->n + 1]` form, not a named `n` -- the named local takes $a0 where
 *       retail's anonymous CSE temp takes $v0 (arm1 already used the inline form and
 *       already matched).  Adding a named `n` to arm1's call regresses 6 -> 12.
 * Residual 14 = the `prevskid->chunk = gUseSm;` load-placement tie at 2 sites: our
 * sched1 hoists `lw gUseSm` one insn further (into the live `$v0` address chain, so it
 * lands in $v1) than retail (which loads AFTER `sw zero,0x28($v0)`, into the freed
 * $v0) -- with the value in $v1 the store can no longer sink into the following
 * `lh $v1,0xC($s0)` load-delay slot, costing the 2 extra nops (247 vs 245).
 * Measured alternatives, none better: a named `chunk = gUseSm;` local at four
 * different source positions all give COUNT-EXACT 245/245 but 16 diffs (the load
 * moves into the `lh` load-delay slot and takes $a0); a volatile cast on the
 * `sm->seg[...].next = 0` store to block the hoist gives 19.  The sibling
 * Skidmark_AddStretch PASSES with the identical statement (`*savechunk = gUseSm;`)
 * because its preceding statement is a single pointer store, not the three
 * clr/type/pt struct copies that give our scheduler room to hoist. */
void Skidmark_Add(tSkid *prevskid,coorddef *skidpt,CVECTOR *color,int tireWidth,int type,int slice)

{
  Skidmark_Chunk *sm;
  int n; /* SYM-CODEGEN-CARRIER: n -- prevents non-retail cross-jump over-merging */

  if (prevskid->nseg == (Skidmark_Segment *)0x0) {
    sm = Skidmark_CheckChunk(skidpt,2,slice);
    CalcStartSegment(&sm->seg[sm->n],&sm->seg[sm->n + 1],&sm->cp,&prevskid->pt,skidpt,tireWidth);
    n = sm->n;
    sm->seg[n + 1].rgb = *color;
    sm->seg[n].rgb = sm->seg[n + 1].rgb;
    n = sm->n;
    sm->seg[n + 1].type = type;
    sm->seg[n].type = type;
  }
  else {
    sm = Skidmark_CheckChunk(skidpt,2,slice);
    if (prevskid->chunk == gUseSm) {
      CalcOneSegment(&sm->seg[sm->n],&sm->cp,&prevskid->pt,skidpt,tireWidth);
      sm->seg[sm->n].rgb = *color;
      sm->seg[sm->n].type = type;
      prevskid->nseg->next = &sm->seg[sm->n];
      sm->seg[sm->n].next = (Skidmark_Segment *)0x0;
      prevskid->clr = *color;
      prevskid->type = type;
      prevskid->pt = *skidpt;
      prevskid->nseg = &sm->seg[sm->n];
      prevskid->chunk = gUseSm;
      sm->n = sm->n + 1;
      return;
    }
    CalcStartSegment(&sm->seg[sm->n],&sm->seg[sm->n + 1],&sm->cp,&prevskid->pt,skidpt,tireWidth);
    sm->seg[sm->n].rgb = prevskid->clr;
    sm->seg[sm->n].type = prevskid->type;
    sm->seg[sm->n + 1].rgb = *color;
    sm->seg[sm->n + 1].type = type;
  }
  sm->seg[sm->n].next = &sm->seg[sm->n + 1];
  sm->seg[sm->n + 1].next = (Skidmark_Segment *)0x0;
  /* `chunk = gUseSm` is the LAST of the prevskid stores: the oracle issues its
     %gp_rel load only after `sm->seg[n+1].next = 0` and lands the store in the
     `lh $v1,12($s0)` LOAD-DELAY SLOT.  Written any earlier the value is allocated to
     $v1 (which `lh $v1,12($s0)` then needs), so the store has to precede the lh and
     the slot fills with a nop -- +1 insn per tail, at both tails. */
  prevskid->clr = *color;
  prevskid->type = type;
  prevskid->pt = *skidpt;
  prevskid->nseg = &sm->seg[sm->n + 1];
  prevskid->chunk = gUseSm;
  sm->n = sm->n + 2;
  return;
}

/* ---- Skidmark_AddStretch__FPP16Skidmark_SegmentPiP5tSkidP8coorddefP7CVECTORiii  [SKIDMARK.CPP:264-326] SLD-VERIFIED ----
 * PASS (w39-a10, 231/231; was 20).  Two structural corrections, both readable
 * straight off the oracle's shared-tail entry label .L800DF250 (which sits MID
 * address-computation, at `sll $v0,$v0,2`):
 *   (1) `sm->seg[n].type = type;` lives INSIDE EACH ARM -- arm1 indexes its own
 *       `n` (= sm->n, $a0), arm3 recomputes `sm->n + 1` ($v1).  A single shared `n`
 *       in the tail puts both arms' n*7 term in ONE hard reg, so gcc's post-reload
 *       cross-jump merges 2 insns deeper than retail and re-colours the index web.
 *   (2) arm3's CalcStartSegment args are spelled inline (`&sm->seg[sm->n]`,
 *       `&sm->seg[sm->n + 1]`); a named `n` local takes $a0 where retail's anonymous
 *       CSE temp takes $v0.  Converting arm1 to the named form regresses 6 -> 12. */
void Skidmark_AddStretch(Skidmark_Segment **save,int *savechunk,tSkid *prevskid,coorddef *skidpt,
                        CVECTOR *color,int tireWidth,int type,int slice)

{
  Skidmark_Chunk *sm;
  int n; /* SYM-CODEGEN-CARRIER: n -- preserves the per-arm segment-index web */

  if (prevskid->nseg == (Skidmark_Segment *)0x0) {
    sm = Skidmark_CheckChunk(skidpt,2,slice);
    CalcStartSegment(&sm->seg[sm->n],&sm->seg[sm->n + 1],&sm->cp,&prevskid->pt,skidpt,tireWidth);
    n = sm->n;
    sm->seg[n + 1].rgb = *color;
    sm->seg[n].rgb = sm->seg[n + 1].rgb;
    n = sm->n;
    sm->seg[n + 1].type = type;
    sm->seg[n].type = type;
  }
  else {
    sm = Skidmark_CheckChunk(skidpt,2,slice);
    if (prevskid->chunk == gUseSm) {
      CalcOneSegment(&sm->seg[sm->n],&sm->cp,&prevskid->pt,skidpt,tireWidth);
      sm->seg[sm->n].rgb = *color;
      sm->seg[sm->n].type = type;
      prevskid->nseg->next = &sm->seg[sm->n];
      sm->seg[sm->n].next = (Skidmark_Segment *)0x0;
      *save = &sm->seg[sm->n];
      *savechunk = gUseSm;
      sm->n = sm->n + 1;
      return;
    }
    CalcStartSegment(&sm->seg[sm->n],&sm->seg[sm->n + 1],&sm->cp,&prevskid->pt,skidpt,tireWidth);
    sm->seg[sm->n].rgb = prevskid->clr;
    sm->seg[sm->n].type = prevskid->type;
    sm->seg[sm->n + 1].rgb = *color;
    sm->seg[sm->n + 1].type = type;
  }
  sm->seg[sm->n].next = &sm->seg[sm->n + 1];
  sm->seg[sm->n + 1].next = (Skidmark_Segment *)0x0;
  *save = &sm->seg[sm->n + 1];
  *savechunk = gUseSm;
  sm->n = sm->n + 2;
  return;
}

/* ---- Skidmark_Stretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii  [SKIDMARK.CPP:336-341] SLD-VERIFIED ---- */
void Skidmark_Stretch(Skidmark_Segment *save,int savechunk,tSkid *prevskid,coorddef *skidpt,
                     CVECTOR *color,int tireWidth,int type)

{
  CalcOneSegment(save,&gSm[savechunk].cp,&prevskid->pt,skidpt,tireWidth);
  save->rgb = *color;
  save->type = type;
  return;
}

/* ---- Skidmark_EndStretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii  [SKIDMARK.CPP:350-361] SLD-VERIFIED ---- */
void Skidmark_EndStretch(Skidmark_Segment *save,int savechunk,tSkid *prevskid,coorddef *skidpt,
                        CVECTOR *color,int tireWidth,int type)

{
  CalcOneSegment(save,&gSm[savechunk].cp,&prevskid->pt,skidpt,tireWidth);
  save->rgb = *color;
  save->type = type;
  prevskid->clr = *color;
  prevskid->type = type;
  prevskid->pt = *skidpt;
  prevskid->nseg = save;
  prevskid->chunk = savechunk;
  return;
}

/* ---- Skidmark_OnyxBuildFacets__FP13DRender_tView  [SKIDMARK.CPP:365-408] SLD-VERIFIED ---- */
void Skidmark_OnyxBuildFacets(DRender_tView *Vi)

{
  Draw_tCtrlSkidmark fskidspace;
  Draw_tCtrlSkidmark *fskid;
  int t1;
  int t2;
  int t3;

  /* Oracle loads each 3-int group into THREE distinct caller-saved regs and only then
     stores them (the loads fill each other's load-delay slots); per-field
     `dst = src;` statements serialize through one reg and cost a nop each.
     `fskidspace.t = Vi->cview.translation` is a movstrsi struct assignment
     (oracle `lw a3/t0/t1; sw a3/t0/t1`). */
  fskid = &fskidspace;
  fskidspace.t = Vi->cview.translation;
  fskid->count = gCountSm;
  fskid->smp = gSm;
  t1 = Vi->cview.mrotationInv.m[0];
  t2 = Vi->cview.mrotationInv.m[1];
  t3 = Vi->cview.mrotationInv.m[2];
  fskidspace.m.m[0] = t1;
  fskid->m.m[1] = -t2;
  fskid->m.m[2] = t3;
  t1 = Vi->cview.mrotationInv.m[3];
  t2 = Vi->cview.mrotationInv.m[4];
  t3 = Vi->cview.mrotationInv.m[5];
  fskid->m.m[3] = t1;
  fskid->m.m[4] = -t2;
  fskid->m.m[5] = t3;
  t1 = Vi->cview.mrotationInv.m[6];
  t2 = Vi->cview.mrotationInv.m[7];
  t3 = Vi->cview.mrotationInv.m[8];
  fskid->m.m[6] = t1;
  fskid->m.m[7] = -t2;
  fskid->m.m[8] = t3;
  Draw_kCtrlSkidmark(fskid);
  return;
}

/* ---- Skidmark_InitSkidmark__Fv  [SKIDMARK.CPP:419-429] SLD-VERIFIED ---- */
void Skidmark_InitSkidmark(void)

{
  gMaxSChunk = 0x10;
  if (GameSetup_gData[3] == 1) {
    gMaxSChunk = 8;
  }
  gSm = reservememadr("SkidMark",gMaxSChunk * 0x2b0,0);
  gSm->n = 0;
  gCountSm = 0;
  gUseSm = 0;
  return;
}

/* ---- Skidmark_RestartSkidmark__Fv  [SKIDMARK.CPP:433-437] SLD-VERIFIED ---- */
void Skidmark_RestartSkidmark(void)

{
  gCountSm = 0;
  gUseSm = 0;
  gSm->n = 0;
  return;
}

/* ---- Skidmark_KillSkidmark__Fv  [SKIDMARK.CPP:441-443] SLD-VERIFIED ---- */
void Skidmark_KillSkidmark(void)

{
  
  if (gSm != (Skidmark_Chunk *)0x0) {
    purgememadr(gSm);
  }
  gSm = (Skidmark_Chunk *)0x0;
  return;
}

/* end of skidmark.cpp */
