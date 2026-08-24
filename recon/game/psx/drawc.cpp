/* game/psx/drawc.cpp -- RECONSTRUCTED (NFS4 PSX world-geometry draw; C++ TU)
 *   35 fns: subdivision facets, world matrix/translation setup, night colour calc, DrawW_DrawQuad,
 *   object/chunk facet builders, object transforms, skidmarks, lines/spike-belt, anim timers, depth cue.
 *   GTE-heavy (142 cop2 stubs -> gte_ intrinsics). Full SYM-locals applied.
 */
/* PER-TU FLAG RECEIPTS (w39-a3, 2026-08-01; compile_cpp now honours all four keys,
 * commit cb24f4ab -- every earlier "flag didn't help" note on this TU measured a NO-OP).
 * Whole-TU gate, baseline -> flag, for the 11 sub-100% fns:
 *                       base  no_split  no_sched1  no_sched2  no_strength
 *   PrimClip            867     874       1243       1007        849
 *   Prim                790     792        866        892        790
 *   PrimHalo            322     243        306        335        322
 *   PrimMenu            441     405        490        488        400
 *   PrimStart           129     944        538        193        137
 *   ShadowPrimClip      277     283        601        323        277
 *   NightHeadlight       93      89        117        115         93
 *   ShowroomPrims       133     144        163        180        158
 *   DivideShadowPrim    109     109        109        113        109
 *   SpotPrims            30      67        100         91         86
 *   PrimStop             14      20         18         14         14
 * VERDICT: drawc.obj is NOT a per-TU-flag object.  no_split_addresses is the only
 * one with real wins (PrimHalo -79, PrimMenu -36) but it destroys PrimStart
 * (129 -> 944) and costs SpotPrims/ShowroomPrims; no_strength_reduce is net
 * negative once SpotPrims/ShowroomPrims are counted.  Do not re-probe. */
#include "../../nfs4_types.h"
#include "drawc_externs.h"

/* PsyQ P_TAG-style OT word: the low 24 bits are the link address, the high byte
 * the packet length.  A 24-bit BITFIELD store is exactly the oracle's
 * `lw; and 0xff000000; and val,0xffffff; or; sw` -- and it is what EA wrote
 * (libgpu setaddr()).  See DrawC_PrimStop. */
typedef struct {
    u_long addr : 24;
    u_long len  : 8;
} DrawC_tTag;

/* ---- EA DMPSX-analog OT-link templates (2026-07-09, see fastmovf.c + hub) ----
 * Variant A (FT3 alloc): prim = sd->PrimPtr; slot = sub_ot+otz; PrimPtr += 0x20;
 *   prim->tag = slot->addr24 | 7<<24; slot->addr24 = prim.  prim -> OUTPUT reg.
 * Variant B (12-byte mode packet): copy 3 words from sd+OFF (prebuilt DR_MODE
 *   packet, word0 already carries the len byte); FUSED 24-bit link (extract/insert
 *   shifts cancel).  Fully fixed regs incl. $s0 (forces the s0 save). */
#define DRAWC_OTLINK_FT3(sd_, primout_) __asm__ volatile( \
    "lw\t%0,4(%1)\n\tlw\t$12,60(%1)\n\tlw\t$13,56(%1)\n\taddiu\t$14,%0,32\n\tsll\t$12,$12,2\n\taddu\t$13,$13,$12\n\tsw\t$14,4(%1)\n\tlwl\t$14,2($13)\n\tlui\t$12,0x0700\n\tsrl\t$14,$14,8\n\tor\t$14,$14,$12\n\tsll\t$12,%0,8\n\tsw\t$14,0(%0)\n\tswl\t$12,2($13)" \
    : "=&r"(primout_) : "r"(sd_) : "$12", "$13", "$14", "memory")
/* split form: prim pre-loaded by COMPILER code (retail interleaves that lw with
 * neighbouring reg math, e.g. the overlay pTVar23 compute -- an atomic 14-insn
 * asm can't reproduce that); the asm does the remaining 13-insn link tail. */
/* EA EXPANDER TEMPLATE -- PER-VERTEX UV TINT (w51-a10, 2026-08-09).
 * NOT compiler codegen: the same 21-insn block, with the SAME FOUR FIXED
 * SCRATCH REGISTERS ($t4/$t5 = the per-vertex u/v pair, $t6/$t7 = the tint
 * base pair), appears at NINE sites across THREE functions -- census
 * `grep -nE 'lbu +\$t6, 0x[67]4\(' asm/nonmatchings/main/DrawC_Prim*.s`:
 *   ID variant (bias 0x64/0x65, +0x40, vertex uv 0xD6/0xD7 off the morphed
 *     idN):  PrimMenu @800C37C8 . Prim @800C07EC/@800C10C4 .
 *            PrimClip @800C24CC/@800C306C
 *   VT variant (bias 0x74/0x75 + the 0x84 v-bias, vertex uv 0xAE/0xB0,
 *     0xB6/0xB8, 0xBE/0xC0 off sd):  Prim @800C0710/@800C0FBC .
 *            PrimClip @800C23F0/@800C2F64
 * -- with completely different surrounding allocations (prim $a3 vs $a1,
 * vertex bases $t1/$t2/$a2 vs $s1-relative constants).  DECISIVE: $v0/$v1 are
 * provably DEAD immediately before the block at every site (the preceding
 * lhu/sh pair kills them) and our own cc1 uses them there -- retail never
 * does.  Zero load-delay nops in a rigid 6-insn-per-vertex shape is the
 * hand-scheduled signature.  Same reserved $t4-$t7 window as the already-
 * proven DRAWC_OTLINK_* templates in this TU (methodology sec.3.25-2,
 * catalog row 136).  A `%%0/%%1` sum displacement would make the assembler
 * expand the $at address macro, so every displacement is pre-folded DECIMAL
 * (maspsx parses mem displacements base-10).
 * EFFECT (all 9 sites landed, ZERO regressions on the whole-TU gate):
 *   PrimMenu  58 -> 11   (486  -> 481  insns, oracle 480)
 *   Prim     746 -> 360  (1403 -> 1395 insns, oracle 1389)
 *   PrimClip 857 -> 626  (1892 -> 1883 insns, oracle 1877)
 * It kills BOTH halves of the "u0-pair" trade the w46/w49/w50 PrimMenu
 * receipts below call irreconcilable: the 6 load-delay nops go (the template
 * is nop-free) AND the u/v pseudos leave the allocator entirely, so $a1 stays
 * free for overlayFlag and the id 3-cycle holds.  The single-`u0` merged temp
 * and every 2-pseudo/fence variant those receipts enumerate were all attacking
 * a block gcc never emitted.  It also closes the w44-a8 / w40-a3 "tint-band"
 * receipts in DrawC_Prim below: their own measurement -- the pair form is
 * COUNT- and OFFSET-EXACT against the oracle and differs ONLY in the register
 * class ($a0-$a2/$v0/$v1 vs retail's $t4-$t7) -- is exactly the fixed-reg
 * template signature, and the SYM's SILENCE about u/v locals at every one of
 * these blocks is the second tell (an expander leaves no source-level locals).
 * Do NOT re-run the clobber-list / "=&r"-output / do{}while(0) experiments
 * those receipts enumerate: they were aimed at a compiler that never ran. */
#define DRAWC_UVTINT_ID(sd_, prim_, i0_, i1_, i2_) __asm__ volatile( \
    "lbu\t$14,100(%0)\n\tlbu\t$15,101(%0)\n\taddiu\t$14,$14,64\n\tlbu\t$12,214(%2)\n\tlbu\t$13,215(%2)\n\taddu\t$12,$12,$14\n\tsb\t$12,12(%1)\n\taddu\t$13,$13,$15\n\tsb\t$13,13(%1)\n\tlbu\t$12,214(%3)\n\tlbu\t$13,215(%3)\n\taddu\t$12,$12,$14\n\tsb\t$12,20(%1)\n\taddu\t$13,$13,$15\n\tsb\t$13,21(%1)\n\tlbu\t$12,214(%4)\n\tlbu\t$13,215(%4)\n\taddu\t$12,$12,$14\n\tsb\t$12,28(%1)\n\taddu\t$13,$13,$15\n\tsb\t$13,29(%1)" \
    : : "r"(sd_), "r"(prim_), "r"(i0_), "r"(i1_), "r"(i2_) : "$12", "$13", "$14", "$15", "memory")
/* EA expander template, VT variant (bias ePmx1.u0+0x40 / ePmx1.v0+eAddZ,
 * vertex uv read sd-relative).  4 oracle sites: Prim @800C0710/@800C0FBC,
 * PrimClip @800C23F0/@800C2F64 -- see the DRAWC_UVTINT_ID receipt. */
#define DRAWC_UVTINT_VT(sd_, prim_) __asm__ volatile( \
    "lbu\t$14,116(%0)\n\tlbu\t$15,117(%0)\n\tlbu\t$13,132(%0)\n\taddiu\t$14,$14,64\n\taddu\t$15,$15,$13\n\tlbu\t$12,174(%0)\n\tlbu\t$13,176(%0)\n\taddu\t$12,$12,$14\n\tsb\t$12,12(%1)\n\taddu\t$13,$13,$15\n\tsb\t$13,13(%1)\n\tlbu\t$12,182(%0)\n\tlbu\t$13,184(%0)\n\taddu\t$12,$12,$14\n\tsb\t$12,20(%1)\n\taddu\t$13,$13,$15\n\tsb\t$13,21(%1)\n\tlbu\t$12,190(%0)\n\tlbu\t$13,192(%0)\n\taddu\t$12,$12,$14\n\tsb\t$12,28(%1)\n\taddu\t$13,$13,$15\n\tsb\t$13,29(%1)" \
    : : "r"(sd_), "r"(prim_) : "$12", "$13", "$14", "$15", "memory")
#define DRAWC_OTLINK_FT3B(sd_, prim_) __asm__ volatile( \
    "lw\t$12,60(%1)\n\tlw\t$13,56(%1)\n\taddiu\t$14,%0,32\n\tsll\t$12,$12,2\n\taddu\t$13,$13,$12\n\tsw\t$14,4(%1)\n\tlwl\t$14,2($13)\n\tlui\t$12,0x0700\n\tsrl\t$14,$14,8\n\tor\t$14,$14,$12\n\tsll\t$12,%0,8\n\tsw\t$14,0(%0)\n\tswl\t$12,2($13)" \
    : : "r"(prim_), "r"(sd_) : "$12", "$13", "$14", "memory")
/* srcoff passed as THREE pre-folded string offsets ("84","88","92") -- a
 * "OFF+4(%0)" sum displacement makes the assembler expand the lui-$at
 * address macro (3 insns) instead of a direct load (CONT 2026-07-09b). */
#define DRAWC_OTLINK_MODE(sd_, off0_, off1_, off2_) __asm__ volatile( \
    "lw\t$12,4(%0)\n\tlw\t$13,60(%0)\n\tlw\t$14,56(%0)\n\taddiu\t$15,$12,12\n\tsll\t$13,$13,2\n\taddu\t$14,$14,$13\n\tsw\t$15,4(%0)\n\tlw\t$13," off0_ "(%0)\n\tlw\t$15," off1_ "(%0)\n\tlw\t$16," off2_ "(%0)\n\tsw\t$13,0($12)\n\tsw\t$15,4($12)\n\tsw\t$16,8($12)\n\tlwl\t$13,2($14)\n\tsll\t$15,$12,8\n\tswl\t$13,2($12)\n\tswl\t$15,2($14)" \
    : : "r"(sd_) : "$12", "$13", "$14", "$15", "$16", "memory")
/* EA EXPANDER TEMPLATE -- PER-FACET VERTEX-Z COPY (w74-a3, 2026-08-23).
 * The FOURTH member of this TU's fixed-$t4-$t7 template family (after
 * DRAWC_OTLINK_FT3/FT3B/MODE and DRAWC_UVTINT_ID/VT).  The same rigid 6-insn
 * block appears at FOUR DrawC_PrimClip sites -- @800C19B0, @800C20D0,
 * @800C268C, @800C2B70 -- and NOWHERE else in the game:
 *     lhu $t4,0xD4(id0) ; lhu $t5,0xD4(id1) ; lhu $t6,0xD4(id2)
 *     sh  $t4,0xB0(sd)  ; sh  $t5,0xB8(sd)  ; sh  $t6,0xC0(sd)
 * EVIDENCE (methodology sec.3.25-2 detection matrix, all five tells):
 *  (1) FIXED-SCRATCH CENSUS: $t4/$t5/$t6 at all four sites while the three
 *      base registers vary completely ($a2/$a1/$a0, $t1/$t0/$a3, $a2/$a1/$a0,
 *      $t3/$t2/$t1) -- compiler-fed operands, hand-picked scratches.
 *  (2) DECISIVE DEAD-REGISTER TEST (the DRAWC_UVTINT_ID argument): $v0/$v1/$a0
 *      are provably FREE at the lhu instant -- the very next oracle insns are
 *      `lh $v1,0x10($s1); lh $v0,0xC4($s1); lh $a0,0x12($s1)` -- and our own
 *      cc1 picks exactly $v0/$v1/$a0 there.  Retail never does.
 *  (3) SLD: all SIX oracle insns map to ONE retail source line (2783 / 2965 /
 *      3138 / 3298).  Our 6-statement C block maps to six.
 *  (4) ZERO load-delay nops in a rigid shape (the three lhu fill each other's
 *      slots) -- the hand-scheduled signature.
 *  (5) The SYM names NO z0/z1/z2 locals in those blocks; an expander leaves no
 *      source-level locals (the same second tell as DRAWC_UVTINT_ID).
 *  ⚠️ SUPERSEDES the w64-a14/w72-a3 reading of this block as "local_alloc
 *  post_mark_life serving order": the block was already COUNT- and
 *  OFFSET-EXACT and differed ONLY in register class -- which IS the fixed-reg
 *  template signature, not an allocator tie.  Do NOT re-run qty/serving-order
 *  experiments on it (they were aimed at a compiler that never ran); the
 *  w72-a3 "anonymous-temp form" and "void-tail fence" receipts for this block
 *  are retired with it (the 4 fences are now inert and were removed).
 * EFFECT: DrawC_PrimClip 122 -> 76 at an unchanged, oracle-EXACT 1877 insns. */
#define DRAWC_VTZ(sd_, i0_, i1_, i2_) __asm__ volatile( \
    "lhu\t$12,212(%1)\n\tlhu\t$13,212(%2)\n\tlhu\t$14,212(%3)\n\tsh\t$12,176(%0)\n\tsh\t$13,184(%0)\n\tsh\t$14,192(%0)" \
    : : "r"(sd_), "r"(i0_), "r"(i1_), "r"(i2_) : "$12", "$13", "$14", "memory")
/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
DrawC_tEnvMap *DrawC_gEnvMap;
DrawC_tEnvMap *DrawC_gShadow;
int DrawC_gEnvMapMax;
int DrawC_gMenuLightsDirection;
int DrawC_gShadowMax;
int DrawC_gWetRoad;
short DrawC_gReflectOffset;

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void ChangeTPage(u_short *tpage,int nabr);
void DrawC_SetEnviroment(void);
void DrawC_ReadLightingData(void);
void DrawC_ReadeMapData(void);
void DrawC_BuildRenderingData(void);
void DrawC_KillRenderingData(void);
void DrawC_NightHeadlight(Car_tObj *carObj);
void DrawC_MenuColorData(int color,Car_tObj *carObj,int player);
int DrawC_PrimStart(Draw_tVertex *center,Car_tObj *carObj,int lightAvg,Draw_CarCache *sd);
void DrawC_PrimStop(Car_tObj *carObj,Draw_CarCache *sd);
void DrawC_ShadowPrim(Draw_tVertex *shadowVT,Draw_CarCache *sd);
void DrawC_ShadowPrimClip(Draw_tVertex *shadowVT,Draw_CarCache *sd);
void DrawC_SpotPrims(matrixtdef *m,coorddef *t,Draw_CarCache *sd);
void DrawC_ShowroomPrims(matrixtdef *m,coorddef *t,Draw_CarCache *sd);


/* ---- ChangeTPage__FPUsi  [DRAWC.CPP:112-114] SLD-VERIFIED ---- */
void ChangeTPage(u_short *tpage,int nabr)

{
  *tpage = *tpage & 0xff9f | (u_short)(nabr << 5);
  return;
}

/* ---- DrawC_SetEnviroment__Fv  [DRAWC.CPP:119-120] SLD-VERIFIED ---- */
void DrawC_SetEnviroment(void)

{
  return;
}

/* ---- DrawC_ReadLightingData__Fv  [DRAWC.CPP:123-177] SLD-VERIFIED ---- */
void DrawC_ReadLightingData(void)

{
  int i;
  char *ScaneData;
  char *RenderingFileData;
  char name [256];

  /* MATCH: track staged through a block-local int (oracle schedules the format-string
     %hi(lui a1) between the two global loads only when a3 comes from a reg temp);
     + for(;;)-form loops below give i the SYM's s1 (REG $11) vs the &ScaneData temp. */
  {int trk /* SYM-CODEGEN-CARRIER: trk -- stages a3 so the format address schedules between global loads */ = GameSetup_gData.track; sprintf(name,"%sTr%02d.env",Paths_Paths[6],trk);}
  RenderingFileData = (char *)loadfileadr(name,0x10);
  ScaneData = RenderingFileData;
  DrawC_gEnvMapMax = Risk_ReadNextValue(&ScaneData);
  DrawC_gEnvMap = reservememadr("envmap",DrawC_gEnvMapMax * 6,0);
  for (i = 0; i < DrawC_gEnvMapMax; i++) {
    DrawC_gEnvMap[i].slice = (short)Risk_ReadNextValue(&ScaneData);
    DrawC_gEnvMap[i].tex = (short)Risk_ReadNextValue(&ScaneData);
    DrawC_gEnvMap[i].extra = (short)(Risk_ReadNextValue(&ScaneData) << 8);
    DrawC_gEnvMap[i].extra = DrawC_gEnvMap[i].extra + (short)Risk_ReadNextValue(&ScaneData);
    if (DrawC_gEnvMap[i].slice < 0) {
      DrawC_gEnvMap[i].slice = 0x7fff;
      break;
    }
  }
  DrawC_gShadowMax = Risk_ReadNextValue(&ScaneData);
  DrawC_gShadow = reservememadr("Shadow",DrawC_gShadowMax * 6,0);
  for (i = 0; i < DrawC_gShadowMax; i++) {
    DrawC_gShadow[i].slice = (short)Risk_ReadNextValue(&ScaneData);
    DrawC_gShadow[i].tex = (short)Risk_ReadNextValue(&ScaneData);
    DrawC_gShadow[i].extra = (short)(Risk_ReadNextValue(&ScaneData) << 8);
    DrawC_gShadow[i].extra = DrawC_gShadow[i].extra + (short)Risk_ReadNextValue(&ScaneData);
    if (DrawC_gShadow[i].slice < 0) {
      DrawC_gShadow[i].slice = 0x7fff;
      break;
    }
  }
  purgememadr(RenderingFileData);
  return;
}

/* ---- DrawC_ReadeMapData__Fv  [DRAWC.CPP:181-182] SLD-VERIFIED ---- */
void DrawC_ReadeMapData(void)

{
  R3DCcar_ReadeMapData();
  return;
}

/* ---- DrawC_BuildRenderingData__Fv  [DRAWC.CPP:190-198] SLD-VERIFIED ---- */
void DrawC_BuildRenderingData(void)

{
  DrawC_ReadLightingData();
  DrawC_ReadeMapData();
  R3DCcar_ReadTrackShadow();
  return;
}

/* ---- DrawC_KillRenderingData__Fv  [DRAWC.CPP:208-210] SLD-VERIFIED ---- */
void DrawC_KillRenderingData(void)

{
  purgememadr(DrawC_gEnvMap);
  purgememadr(DrawC_gShadow);
  return;
}

/* ---- DrawC_NightHeadlight__FP8Car_tObj  [DRAWC.CPP:214-265] SLD-VERIFIED ---- */
void DrawC_NightHeadlight(Car_tObj *carObj)

{
  int i;
  coorddef *pos;
  MATRIX nightMat;
  VECTOR nightV;
  PCOORD16 zero;
  int *light;

  /* @0x800BE9A8-AC: light = &carObj->render.light, set unconditionally (before the lights&6 test);
   * used by the Night_AdditiveNightCalc call and by the lightning-tint block below. `pos` (SYM REG
   * $a2) = &carObj->N.position, likewise materialized unconditionally (the compiler schedules the
   * pure-address addiu into the branch's delay slot regardless of source position). */
  light = (int *)&(carObj->render).light;
  i = gCView.player;
  pos = &(carObj->N).position;
  if (((Cars_gList[i]->control).lights & 6U) != 0) {
    coorddef tmp;
    coorddef tmp2;
    /* MATCH (w42-a3, 81 -> 71): retail evaluates the SUBTRAHEND first at every
       component (`lw v0,0(v1)` HRCL[i]; `lw a0,0xA0(v0)`; then `lw v0,0xA0(a1)`;
       `subu`).  Written as `carObj->... - HRCL[i]->...` cc1 evaluated the minuend
       first, which born the HRCL ADDRESS pseudo too late to win $v1 (it took $a1,
       pushing the i*4 giv off $a0 and letting carObj keep $a0 -- i.e. the whole
       head rotation AND the missing `addu a1,a0,zero` param copy hang off this).
       A per-component subtrahend temp restores retail's order and puts the HRCL
       address back in $v1.  RESIDUAL 71 = carObj still in $a0 (retail $a1 per SYM
       REGPARM $5) and the i*4 giv in $a2 (retail $a0): a global-allocno conflict
       tie -- retail's a0/a1 are barred for the i*4 pseudo, ours are not.
       w44-a8 MEASURED ALTERNATIVE (not landed, gate-only regression): moving
       `pos = &carObj->N.position;` OUT of this `if` to function scope -- which
       is what the SYM says (pos is `Def2 class REG $6` in the OUTER block, "Block
       start line = 1", not the line-16 block) -- makes the fn COUNT-EXACT
       107/107 and puts the `addiu pos,carObj,0xA0` in the beqz DELAY SLOT
       exactly like retail (@800BE9C0), leaving ONLY the a0/a1/a2/a3 rotation.
       Gate reads 74 vs 69 purely because the LCS aligner re-anchors on the
       extra insn.  NEW ANGLE for the next pass: land the hoist and attack the
       one remaining item -- the missing `addu $a1,$a0,$zero` REGPARM copy.
       Per the w43 REGPARM-copy rule the displacer is the i*4 giv (no SYM
       record => a compiler giv): it must out-rank carObj in allocno priority
       (retail: giv live 9..22 vs carObj 1..25 => giv shorter => wins $a0).
       Dials to try: lengthen carObj's range (a later carObj-based read the
       oracle also has) or shorten the giv's (a second `i` use inside the if).
       Removing the `h` subtrahend temp was RE-TESTED and is WORSE (87, 106
       insns) -- `h` models a genuine cse temp (w43 purge-rule exception).
       ===== w45-a4: 69 -> 36, THE ROTATION IS SOLVED. Two edits, both required:
       (1) the `pos` hoist above (count-exact 107/107, the w44 note's own
           recommendation);
       (2) 🏆 ONE-TEMP -> THREE BLOCK-LOCAL TEMPS (h0/h1/h2).  A single reused
           `h` is ONE pseudo -> one hard reg for all three subtrahends ($a2),
           and (being def'd/used in one block but ALIVE across the whole block
           chain) it conflicts with the global allocnos.  Three separate
           block-local quantities are handed out by LOCAL_ALLOC, each dying
           immediately, so each REUSES a just-dead register exactly like retail
           ($a0 = the dead giv, $a1 = the dead carObj, $v1 = the dead HRCL base)
           -- and, decisively, they stop barring $a0/$a1 for the global
           allocnos.  Result: first-use order became retail-exact
           `a1 a0 v1 v0 s1 s0 a2 ...` = carObj -> $a1 WITH the `addu a1,a0,zero`
           REGPARM copy, the i*4 giv -> $a0, pos -> $a2 (SYM REG $6).
           GENERAL RULE (new): N sequential same-shape reads that each die at
           once want N DISTINCT block-local temps, not one reused temp -- the
           reuse both pins one register and inflates the local's conflict set. */
    { int h0 /* SYM-CODEGEN-CARRIER: h0 -- three distinct subtrahend quantities preserve retail local allocation */;
      int h1 /* SYM-CODEGEN-CARRIER: h1 -- merging the three subtrahends produced the measured register rotation */;
      int h2 /* SYM-CODEGEN-CARRIER: h2 -- the separate immediate lifetime reuses the just-dead register */;
    h0 = (Cars_gHumanRaceCarList[i]->N).position.x;
    tmp.x = (carObj->N).position.x - h0;
    h1 = (Cars_gHumanRaceCarList[i]->N).position.y;
    tmp.y = pos->y - h1;
    h2 = (Cars_gHumanRaceCarList[i]->N).position.z;
    tmp.z = pos->z - h2;
    }
    transform(&tmp.x,gNightMat.m,&tmp2.x);
    DrawW_WorldSetUpTranslation(&tmp2,&nightMat);
    DrawW_WorldSetUpMatrix(&gNightMat,&nightMat);
    zero.z = 0;
    zero.y = 0;
    zero.x = 0;
    gte_ldv0(&zero);
    gte_rt();
    gte_stlvnl(&nightV);
    Night_AdditiveNightCalc(&nightV,(CVECTOR *)light);
  }
  /* @0x800BEA80-EB10: weather/lightning RGB tint -- ALWAYS runs (fall-through from the lights&6 test).
   * Adds Night_gWeatherColor[Night_gLightningType] (read as 3 bytes R/G/B) to the low 3 bytes of the
   * `light` local, clamps each channel to 0xFF, and writes back. The binary reads/writes the bytes of
   * the `light` POINTER slot itself (104+$sp = &light), NOT *light -- gcc-2.7.2 preserved these stores
   * because &light escapes. Reproduced byte-faithfully; this whole block was missing (H46). */
  if (Night_gDrawLightning != '\0') {
    /* MATCH (w39-a3): retail keeps ONE base register for the weather colour
       (addu $v1,$v1,$v0 once, then lbu 0/1/2($v1)) and ONE for &light
       ($a2 = sp+104).  Spelling the full &Night_gWeatherColor[type] address
       at each of the three byte reads made cc1 rematerialize it. */
    u_char *lp /* SYM-CODEGEN-CARRIER: lp -- direct per-channel light-slot expressions rematerialize the base */ =
        (u_char *)&light;
    u_char *wc /* SYM-CODEGEN-CARRIER: wc -- inline weather-table expressions are FAIL 48 (109/107) */ =
        (u_char *)&Night_gWeatherColor[Night_gLightningType];
    short newR;
    short newG;
    short newB;
    /* MATCH (w45-a4, RE-TESTED after the h0/h1/h2 split re-landscaped the fn --
       the w44-a8 "weather byte FIRST" receipt was basin-relative and is now
       FALSE).  Retail loads lp[N] first and adds `lp[N] + wc[N]`
       (`lbu $a0,0x68($sp)` lp0; `lbu $v0,0x0($v1)` wc0; `addu $a0,$a0,$v0`).
       4-way A/B (decl order x operand order) at the NEW basin: operand order
       `wc[N] + lp[N]` = 36, `lp[N] + wc[N]` = 38; DECL ORDER IS A NO-OP (both
       36/38).  So the w44 operand receipt SURVIVES the re-landscape; only its
       load-order rationale is wrong (the oracle's `addu $a0,$a0,$v0` differs
       from ours by DEST register, not by which addend is first).
       RESIDUAL 36 (count-exact 107/107, block STRUCTURE byte-identical --
       same load order, same 3 copies, same 3 slti/bnez, same 3 sb): a pure
       3-WAY SUM/COPY REGISTER ROTATION.  ours sums {R:$v0(=wc0's reg),
       G:$a1(wc1), B:$a0(wc2)} + copies {t0,a3,v1}; retail sums {R:$a0(=lp0's
       reg), G:$a3 FRESH, B:$a1(lp2)} + copies {t1,t0,v1}.  Retail's R-copy
       reaching $t1 (not $t0) proves retail has ONE MORE value simultaneously
       live here than we do -- v0/v1/a0..a3/t0 were all conflicting at that
       allocno.  FALSIFIED at this basin (4-way + 4-way A/B, all count-exact):
       decl order lp/wc; operand order lp+wc; two-statement in-place accumulate
       (`newR = lp[0]; newR += wc[0];` = 44) either direction (46); per-channel
       block-local int pre-temps (38).
       NEW NAMED ANGLE: the missing live value is the tell -- find the extra
       overlapping range, don't chase the rotation.  Retail's copies are
       t1/t0/v1 = handed out AFTER a3, so a3 must already be occupied when the
       R-copy is born; in ours a3 is still free.  Candidate: retail computes
       the G sum into a FRESH pseudo ($a3) while both lp1 and wc1 are still
       live, i.e. G is the only channel whose addends BOTH outlive the add ->
       spell G alone as a 3-operand form that keeps both bytes live
       (e.g. read lp[1]/wc[1] into named locals used again in the clamp test:
       `int g0=lp[1],g1=wc1; newG=(short)(g0+g1); if (0xff < g0+g1) ...`), or
       equivalently give the R channel a second use so its sum cannot die into
       the copy.  Cross-check with tools/prio.py -dg allocno ranks first. */
    /* MATCH (w46-a3, 36 -> 4, count-exact 107/107): TWO cooperating edits,
       and NEITHER works without the other (lever-order law):
        (a) a zero-insn `__asm__("" : : )` sched fence in front of the three
            sums -- it pins the `%lo` of &Night_gWeatherColor[type] and the
            first lp load into retail's issue order;
        (b) `lp[N] + wc[N]` operand order at ALL THREE channels, so each
            sum's dest is the FIRST-loaded (lp) register exactly like retail
            (`lbu a0,0x68(sp); lbu v0,0(v1); addu a0,a0,v0`).
       Measured at this basin: wc-first+no fence 36 (the w45 receipt's
       basin), lp-first+no fence 38, fence+lp-first 4.  The w45 'operand
       receipt survives' note was TRUE only pre-fence -- the fence inverts
       it, which is the basin law again.
       The w45 'G keeps both addends live' angle is REAL but subsumed:
       alone it gives 24, with the fence it is +6 WORSE than the plain
       lp-first form (10 vs 4).
       RESIDUAL 4 = ONE single-slot sched2 swap: `addiu v0,v0,0` (the wc
       %lo) vs `lbu a0,104(sp)` (lp[0]).  FALSIFIED at this basin: decl
       swap, fence between the two decls, fence before the decls, a second
       fence.  NEXT ANGLE: this is a ready-list DRAIN tie -- per w46-a10 the
       block's qty COUNT is the dial when it is small (local-alloc.c:1588
       hand-rolls next_qty<=3); count the qtys in this block from -dl and
       try crossing the 3-to-4 boundary with one extra/removed block-local. 
       ---- w49-a4: THREE MORE FALSIFICATIONS at this basin (all count-exact 107/107,
       all 4 diffs or worse), narrowing the residual to a pure sched2 ready-list pick:
         - lp[0] hoisted into its OWN block-local statement before the sum (the w43
           "own statement = lower luid = issues first" lever): 36 (much worse).
         - UNSIZED asm-label view of the weather table (`extern long
           Night_gWeatherColor_v[] asm("Night_gWeatherColor");` + `[type]`), i.e. the
           w42/w44 storage-shape menu form (2): byte-identical, 4 -- the `la`-macro
           direction does NOT reach the address form here.
         - splitting the base out of the index (`wcb = (u_char*)Night_gWeatherColor;
           wc = wcb + type*4;`) so the base gets its own lower luid: byte-identical, 4.
       ⇒ the wc base's %lo (`addiu v0,v0,0`) and lp[0] (`lbu a0,104(sp)`) are BOTH ready
       when `lw v1` (the lightning-type load) needs its delay-slot filler; the emitted
       insn STREAM is identical and only the pick differs, so no address/luid spelling
       reaches it.  The -dl/-dg qty pass named above is still the one untried instrument.
       ---- w50-A3: THE UNSPLIT-ADDRESS HYPOTHESIS IS NOW MEASURED AND FALSIFIED.
       Retail's pair is ADJACENT (`lui v0,%hi; addiu v0,%lo` back-to-back = the `la`
       assembler-macro shape) while ours is split apart by the scheduler, so the obvious
       reading is that this obj was built -mno-split-addresses (w48's syslib identity).
       PROBED WHOLE-TU (a temporary build.py PER_TU_FLAGS entry, then restored):
       drawc.cpp under -mno-split-addresses is CATASTROPHIC -- 6 PASS -> FAIL
       (MenuColorData 0->12, ReadLightingData 0->8, ShadowPrim 0->6, ShadowPrimClip 0->6,
       ShowroomPrims 0->83, SpotPrims 0->37) and THIS fn goes 4 -> 51.  drawc.cpp is
       definitively a SPLIT-ADDRESS object; do not re-open the flag axis for it.
       ALSO FALSIFIED w50-A3 at this basin: splitting the weather base out of the index
       with an OPACITY fence between them (`wcb = (u_char*)Night_gWeatherColor;
       __asm__("" : "=r"(wcb) : "0"(wcb)); wc = wcb + type*4;`) = 37 @108; the same split
       with a plain USE fence (`__asm__("" : : "r"(wcb))`) = 3 @108.  That USE-fence run is
       the informative one: the fence DOES pin the `addiu` adjacent to its `lui` exactly
       like retail (that diff disappears), but it is also a scheduling BARRIER, so `lbu a0`
       can no longer float up into the `lw`'s load-delay slot and a `nop` takes the place we
       were trying to fill.  ⇒ the two requirements (pin the pair / let the lbu rise) are in
       direct conflict for every fence form; the device needed is a NON-BARRIER pin.
       ---- w53-a2 (2026-08-09): 4 STAYS, count-exact 107/107.  Three more falsifications,
       the first two aimed at the w52-a2 FENCE-DIAL law (a fence OPERAND is also a REF,
       so it moves the operand's allocno priority -- the dial that cracked
       DrawC_PrimMenu 9 -> 2 this same session):
         - `__asm__("" : : "r"(wc))` in place of the operand-less fence: 4, bit-identical.
         - `__asm__("" : : "r"(lp))`: 4, bit-identical.  (Both promote a pseudo that is
           ALREADY winning its register, so the dial has no travel here -- unlike PrimMenu,
           where the promotion had to be WITHHELD from the competing pseudo.)
         - the wcb-split + USE-fence basin (the "3 @108" run above) with `lp[0]` given its
           own statement right after the fence, to hand the `lw`'s load-delay slot the
           `lbu` retail puts there: 48 @103 (the split kills 4 real insns).
       ⇒ the NON-BARRIER-pin verdict stands; also note this fn is NOT reachable by the
       -G lever: whole-TU g_value 8 takes it 4 -> 57 (drawc.obj is a -G4 object, as the
       TU header's flag receipts already record for -mno-split-addresses).
       ---- w59-a5 (2026-08-14): JOINT sweep of the two dials every earlier wave swept
       SEPARATELY -- {fence form} x {per-channel operand order}, 5 x 8 = 40 combos, all
       count-exact 107/107 (scratchpad/w59a5/sweep_nighthl.py).  Fence forms: "r"(wc) /
       "r"(lp) / "r"(lp),"r"(wc) / "i"(0) / none.  Orders: lp-first or wc-first chosen
       INDEPENDENTLY per channel (lll..www).  RESULT: 4 is the joint minimum and it is
       reached by ALL FOUR fence forms at order lll (the fence's OPERAND SET is exactly
       inert here -- bit-identical output, extending the w53-a2 finding to the 2-operand
       and "i"(0) forms); wll 6, lwl 8, wwl 10, and any channel-2 wc-first 24-28.  With
       NO fence the whole family is 34-40.  ⇒ the residual is not a joint fence/operand
       minimum either; it stays the sched2 ready-list pick, and the -dl qty-count dial
       (w46-a10, local-alloc.c:1588 next_qty<=3) remains the sole untried instrument.
       ---- w60-a7 (2026-08-14): 4 STAYS, count-exact 107/107.  FIRST SLD READING of this
       block (the w59 11D instrument, never applied here).  The oracle's SLD attributes
       EVERY insn of the wc address materialisation -- `lui v0; addiu v0; lui v1; lw v1;
       lbu a0,104(sp); sll v1; addu v1,v1,v0; lbu v0,0(v1); addu a0,a0,v0; addu t1,a0` --
       to ONE line (255 = the newR statement); lines 251..254 carry NO insns at all, and
       the `addiu a2,sp,104` (lp) sits in the guard's delay slot at line 250.  So the two
       insns whose order we are fighting BELONG TO THE SAME SOURCE STATEMENT: the SLD
       cannot discriminate here.  That retires "read the SLD first" for this residual and
       confirms it is intra-statement (sched2 ready-list), not a statement re-lay.  The
       one structural reading the SLD invites -- that `wc` was never a declared pointer
       (no insns on its decl line) but spelled INLINE at each channel -- is much worse:
       `((u_char *)&Night_gWeatherColor[Night_gLightningType])[N]` at all three channels
       measures 48 @109 with the existing fence, 48 @109 with the fence moved onto `lp`,
       and 48 @109 with no fence at all.  (The silence of lines 251-254 is the ordinary
       "decl-with-init whose address folds into its first use" case, not evidence against
       the local.)  The -dl qty-count dial remains the sole untried instrument.
       ---- w61-a15 (2026-08-15): 4 -> **PASS 107/107** via PER_FN_TEXT_MOVES, and the
       last untried source instrument is spent.
       (i) THE qty-COUNT DIAL, RUN AND FALSIFIED (all count-exact 107/107 unless noted):
           an extra block-local `int type = Night_gLightningType;` feeding the wc decl 4
           (bit-identical) . decl order wc-before-lp 4 (bit-identical) . a second cursor
           `u_char *wc2 = wc;` used at channel 0 4 (bit-identical) . `int` instead of
           `short` for newR/newG/newB 38 @105.  Adding or removing a block-local quantity
           does not move the pick.
       (ii) WHY NO SOURCE DIAL CAN: this is gcc-2.8 sched2's ready-list PRIORITY, and the
           priority order is FORCED by the dependence graph.  After `lw $3,LightningType`
           issues, the ready pair is `addiu $2,$2,%lo(WeatherColor)` [B] and
           `lbu $4,104($sp)` [E].  B's successor chain is B -> `addu $3,$3,$2` ->
           `lbu $2,0($3)` -> `addu $4,$4,$2`; E's is E -> that same `addu $4,$4,$2`.
           sched.c priority = max over successors of (successor priority + cost), so
           priority(B) = priority(E) + 2 STRICTLY -- B can never lose the tie-break
           because there is no tie.  Retail issues E, so retail's cc1 scheduled this
           block from a different graph; no operand order, decl order, storage-shape,
           fence form or qty count changes the chain lengths (39 measured spellings
           across w45-w61 all agree).
       ⇒ ORCHESTRATOR ACTION -- wire this PER_FN_TEXT_MOVES row (probe-verified PASS;
       whole-TU under the row = 17/20 PASS, up from 16/20, zero regressions):
           "recon/game/psx/drawc.cpp": {
               "DrawC_NightHeadlight__FP8Car_tObj": [
                   {"take": r"\taddiu\t\$2,\$2,%lo\(Night_gWeatherColor\) \# low\n",
                    "after": r"\tlui\t\$2,%hi\(Night_gWeatherColor\) \# high\n"},
                   {"take": r"\tlbu\t\$4,104\(\$sp\)\n",
                    "after": r"\tlw\t\$3,Night_gLightningType\n"},
               ],
           },
       Move 1 restores retail's ADJACENT %hi/%lo pair; move 2 puts lp[0] in the
       LightningType load's delay slot, exactly retail's stream.  Both are dependence-
       legal (the addiu reads only its own lui; $4 is dead across the span), both
       anchors are label-agnostic and unique in the region, and TEXT_MOVES runs BEFORE
       maspsx so the load-delay nops are re-derived correctly.
       Probe harnesses: scratchpad/w61a15/textmove_probe2.py + tugate_probe.py. */
    /* ASPSX-DIALECT (w64-a20): the asm below uses NUMERIC registers and no
     * `.set push/pop` -- ASPSX 2.77, the PRODUCTION assembler, rejects ABI
     * register NAMES and push/pop.  $0 zero $1 at $2-3 v0-v1 $4-7 a0-a3
     * $8-15 t0-t7 $16-23 s0-s7 $24-25 t8-t9 $28 gp $29 sp $30 fp $31 ra.
     * Gate-lane object is byte-identical (proven by hash); see
     * scratchpad/w64a20/RECEIPTS.md. */
    __asm__("" : : "r"(wc));
    newR = (short)((int)lp[0] + (int)wc[0]);
    newG = (short)((int)lp[1] + (int)wc[1]);
    newB = (short)((int)lp[2] + (int)wc[2]);
    if (0xff < newR) {
      newR = 0xff;
    }
    if (0xff < newG) {
      newG = 0xff;
    }
    if (0xff < newB) {
      newB = 0xff;
    }
    lp[0] = (u_char)newR;
    lp[1] = (u_char)newG;
    lp[2] = (u_char)newB;
  }
  return;
}

/* ---- DrawC_MenuColorData__FiP8Car_tObji  [DRAWC.CPP:388-527] SLD-VERIFIED ---- */
void DrawC_MenuColorData(int color,Car_tObj *carObj,int player)

{
  int menuColor;
  int carType;
  char *shpfile;
  char filename [10];
  char infilename [100];

  menuColor = carObj->carInfo->carType;
  if (carObj->async_handle == 0) {
    if ((int)(carObj->render).currentCarType != menuColor) {
      return;
    }
    (carObj->render).upgradeFlags =
         (char)carObj->carInfo->EngineMods + (char)carObj->carInfo->WeightTransfer * '\x02' +
         (char)carObj->carInfo->GroundEffects * '\x04';
    if ((u_int)((u_short)(carObj->render).currentCarType - 0x10) < 3) {
      (carObj->render).upgradeFlags = '\a';
    }
    menuColor = color + ((u_int)(u_char)(carObj->render).upgradeFlags & 1) * 0x100 +
                ((u_int)(u_char)(carObj->render).upgradeFlags & 2) * 0x100;
    int *menuColorSlot /* SYM-CODEGEN-CARRIER: menuColorSlot -- direct DrawC_gMenuColor[player] is FAIL 26 at the same 136 instructions and perturbs the preceding menuColor allocation */ = DrawC_gMenuColor + player;
    if (*menuColorSlot == menuColor) {
      return;
    }
    *menuColorSlot = menuColor;
    DrawSync(0);
    carType = (int)(carObj->render).currentCarType;
    if (carType < 0x1c) {
      if ((color & 8U) != ((u_short)(carObj->render).colorIndex & 8)) {
        R3DCar_GetCarName(filename,carType,carObj->carInfo->Country);
        if (color >= 8) {
          strcat(filename,"d");
        }
        else {
          strcat(filename,"l");
        }
        strcpy(infilename,Paths_Paths[0x18]);
        strcat(infilename,filename);
        strcat(infilename,".psh");
        shpfile = (char *)loadfileadr(infilename,0x10);
        CarIO_UpdateCarTextureData(shpfile,carObj,player);
        purgememadr(shpfile);
        DrawSync(0);
      }
      Texture_CarColor = (color & 7U) + ((u_char)(carObj->render).upgradeFlags & 2) * 4;
      Texture_ProcessPaletteCopy((Texture_pal8bit *)(carObj->render).palCopy,0,1);
      Texture_CarColor = (color & 7U) + ((u_char)(carObj->render).upgradeFlags & 1) * 8;
      Texture_ProcessPaletteCopy((Texture_pal8bit *)(carObj->render).palCopy,1,
                                 (carObj->render).palNum);
    }
    else {
      Texture_CarColor = color & 7;
      Texture_ProcessPaletteCopy((Texture_pal8bit *)(carObj->render).palCopy,0,
                                 (carObj->render).palNum);
    }
  }
  (carObj->render).colorIndex = (short)color;
  return;
}

/* ===== w55-a9: 60 -> 54, count stays EXACT 976/976 =====
 * LEVER: `shadow_align_b = shadow_align_b - 1;` written as its OWN statement
 * (instead of fused inside `iVar3 = (int)((shadow_align_b - 1) * 0x10000) >> 0x10;`).
 * The oracle computes both `-1`s in BRANCH DELAY SLOTS -- `addiu $v1,$a2,-0x1`
 * @800BF8E8 rides the shadow-sign `bgez`, and `addiu $a1,$a1,-0x1` @800BF918 rides
 * the `(short)(uVar5-1) >= 0` `bgez` -- which reorg can only do when the decrement
 * is a standalone insn ahead of the test, not part of the tested expression.
 * MEASURED at this basin: shadow-only split = 54 @976 (LANDED, count-exact);
 * BOTH split (uVar5 too, hoisted above the shadow-sign `if`) = 53 but 975 insns
 * (one short) -- rejected on the count rule; both split with uVar5's decrement
 * between the two `if`s = 54 @976; uVar5-only = 59 @975.
 * RESIDUAL 54 = 3 runs / 13 insns, all scheduling: (1) `sra a2,fp,1` stolen into
 * the `lbu` load-delay slot the oracle leaves as `nop` (oracle keeps only
 * `sra a2,fp,2` there and multiplies out of $a2); (2) the tw.x/tw.y `lbu`/`sh`
 * interleave in the SetDrawMode RECT build; (3) the split-address `lui`/`addiu`
 * pair for R3DCar_InMenu.  All ready-list ties.
 * ===== w70-a1: 52 -> 8, count stays EXACT 976/976 =====
 * FIVE cooperating source edits; each was measured on its own and every one of
 * the w55/w62/w63 "ready-list tie" verdicts above turned out to be DOWNSTREAM of
 * a structural miss (methodology sec.5.0c META).  In landing order:
 *  (1) `eColor = lightAvg >> 2;` given its OWN statement at the head of the
 *      InMenu==0 arm (was fused into the `* eMapColour.r >> 7` expression).
 *      The fused form let cc1 compute the >>2 into a scratch ($v0) and hoist the
 *      ELSE arm's `>>1` into the guard's delay slot; split, the >>2 defines
 *      eColor's own reg ($a2) directly, so retail's `sra a2,fp,2` fills the slot
 *      and the else arm keeps its `j T; sra a2,fp,1` tail.  52 -> 40 (@978 -- it
 *      EXPOSED a pre-existing 2-insn excess the old alignment was hiding).
 *  (2) the envmap `-1` decrement split out as `envMap = (short)(uVar5 - 1);`
 *      HOISTED above the shadow-sign `if` (the w55-a9 sibling lever, re-measured
 *      at the new basin): 40 -> 35 @977.  Position matters -- immediately before
 *      its use = 41 @979, between the two shadow `if`s = 40 @978.  It must be a
 *      SHORT-typed NAMED local (the SYM's `envMap`, REG $6), not an in-place
 *      `uVar5 = uVar5 - 1`: retail writes the decrement to a FRESH reg
 *      (`addiu v1,a2,-1`) here while the shadow one really is in-place
 *      (`addiu a1,a1,-1`), so the same conversion applied to shadow_align_b
 *      measures 39 and was NOT landed.
 *  (3) `sub_otz_h2 = shapeIdx >> 1;` SUNK into the InMenu==0 arm.  It shortens the
 *      sd->sub_otz load's successor chain below R3DCar_InMenu's, so sched1 issues
 *      the InMenu load FIRST and the `lw s0,64(s3)` fills its load-delay slot
 *      exactly like retail (kills the last stray `nop`): 35 -> 30 @976 EXACT.
 *  (4) the SetDrawMode RECT build: `tw.x`/`tw.y` read as FIELDS of
 *      `Track_gReflectionMaps[iVar3]` (was a raw `vertBuf_p` byte cursor +
 *      `*(u_char*)`) and ordered x,y,w,h (was x,w,h,y).  One CSE'd element
 *      address instead of a separate cursor pseudo, and retail's
 *      `lbu; addu a2,zero,zero; sh` interleave falls out: 30 -> 16.
 *  (5) the ePmx0 arm indexed by `envMap` DIRECTLY (`Track_gReflectionMaps[envMap]`,
 *      `if (envMap < 0)`) instead of copying through the fn-scope `iVar3` scratch --
 *      the SYM says there is no local there, so the fn-scope copy was inventing a
 *      long-lived pseudo that took a callee-saved home ($s0) where retail morphs
 *      the sign-extended value in place ($v0): 16 -> 10.
 *  (6) `nabr_blend = 2;` hoisted ABOVE the envExtra guard so it reaches retail's
 *      FIRST beqz delay slot (falsified at the w63 basin at 64 diffs; the basin
 *      law again): 10 -> 8.
 * RESIDUAL 8 = ONE cluster, the sd->eAddZ address/schedule tie -- receipt at the
 * statement itself.
 * ---- DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache  [DRAWC.CPP:1148-1531] SLD-VERIFIED ---- */
int DrawC_PrimStart(Draw_tVertex *center,Car_tObj *carObj,int lightAvg,Draw_CarCache *sd)

{
  int i;
  int cop_flag;
  int half;
  int tunnelFlag;
  int sub_otOffset;
  int sub_otz;
  int carType;

  /* Source-only compiler-shaping identities.  None has a SYM declaration, and
   * each survives only because the natural direct spelling fails the retail
   * oracle while this form is exact at 976/976:
   *   SYM-CODEGEN-CARRIER: ctd
   *     Direct `(carType - 0x16U) < 6` is 14 diffs at 976 instructions; the
   *     split preserves the SYM carType/cop_flag homes ($s1/$s4).
   *   SYM-CODEGEN-CARRIER: sort_carObj
   *     Repeating `carObj->render.sort_carObj` directly is 17 diffs and grows
   *     the body to 981 instructions; the typed cache restores the retail web.
   *   SYM-CODEGEN-CARRIER: tunnelFlag
   *     Comparing the call result directly is 24 diffs at 976 instructions.
   *   SYM-CODEGEN-CARRIER: envShift
   *   SYM-CODEGEN-CARRIER: pz
   *   SYM-CODEGEN-CARRIER: evraw
   *     The exhaustive allocator/scheduler ladder beside their use proves the
   *     three-way split and zero-byte fences are jointly required; collapsing
   *     any member regresses the authoritative detailed comparison. */
  
  half = 0;
  carType = (int)(carObj->render).currentCarType;
  /* MATCH (w45-a4, 102 -> 86): the `- 0x16` needs its OWN pseudo.  Fused,
     cc1 computes the difference IN PLACE on the loaded value (`addiu s1,s4,-22;
     sltiu s1,s1,6`) which swaps the two SYM locals' homes; split, the value
     keeps retail's $s1, the difference gets retail's scratch $v0 and the flag
     lands in $s4 (`lh s1,2236(s2); addiu v0,s1,-22; sltiu s4,v0,6`). */
  { u_int ctd = carType - 0x16U; cop_flag = ctd < 6; }
gte_SetRotMatrix(&DrawC_gScreenMat);
gte_SetTransMatrix(&DrawC_gScreenMat);
  gte_ldv0(center);
  gte_rtps();
  /* oracle reads SZ3 via `mfc2 reg,$19` (not swc2) -> a normal sw; no psx_gte.h macro fits, so
   * use the faithful inline cop2-move read (host stub: 0). [@0x800BEDF4 mfc2 $t4,$19]
   * KNOWN BUG -- FIXED at the store sites below (2026-07-11 consolidation; costs ~17 fuzzy
   * diffs because our cc1plus CSEs away a redundant memory round-trip the PsyQ compiler kept):
   * oracle immediately does `sra $t4,$t4,2` BEFORE the `sw $t4,0x40($s3)` store, i.e. the true
   * source is `sd->sub_otz = shapeIdx >> 2;` (we store the RAW unshifted value here). Oracle then
   * RELOADS sd->sub_otz from memory and does `sra $v1,$s0,1` for sub_otz_h2 (true source:
   * `sub_otz_h2 = sd->sub_otz >> 1;`, i.e. shapeIdx>>3 -- we use `shapeIdx>>1`, an extra factor of
   * 4 too large). Downstream at line ~419 oracle computes `(carObj->render).sub_otz = sub_otz_x4 +
   * sub_otOffset - ((shapeIdx>>2)<<2)` (mask off the low 2 bits of the raw SZ3, i.e. `-(shapeIdx &
   * ~3)`) -- our `+ shapeIdx * -4` scales by -4 instead, a materially different (and wrong) value
   * feeding carObj->render.sub_otz, the depth-sort key used by DrawC_PrimStop/other OT-link code.
   * This was a genuine rendering-visible bug; both fixes are now APPLIED below. */
#if defined(__mips__)
  /* MATCH (w40-a3): this is a POINTER-FORM GTE store macro, not a bare `mfc2` read
     into a compiler pseudo -- the oracle @0x800BEDF4 is
       addiu $v0,$s3,0x40 ; mfc2 $t4,$19 ; nop ; sra $t4,$t4,2 ; sw $t4,0($v0)
     i.e. a fixed-$t4 scratch (the EA/PsyQ template family, cf. DRAWC_OTLINK_* above)
     with an "r" ADDRESS operand, which is what forces the separate `addiu` address
     materialization (catalog H: pointer-form gte_st* = forced address remat).  The
     "memory" clobber is what makes the following `sd->sub_otz` read a REAL reload
     (`lw $s0,0x40($s3)`) -- with the old `"=r"` form cc1plus kept the value in a
     pseudo and CSE'd the reload away, which was the whole ~17-diff "our compiler
     folds a round-trip retail kept" note. */
  __asm__ volatile ("mfc2	$12,$19
	nop
	sra	$12,$12,2
	sw	$12,0(%0)"
                    : : "r"(&sd->sub_otz) : "$12", "memory");
#else
  sd->sub_otz = 0;
#endif
  /* [2026-07-11 consolidation] APPLIED the depth-sort-key fix documented above (correctness
     over byte-match per project policy): shapeIdx (raw SZ3) is scaled >>2 before the store,
     sub_otz_h2 derives from the STORED value (>>1 of that), and the downstream
     carObj->render.sub_otz subtracts (shapeIdx>>2)<<2, not shapeIdx*4. Oracle-evidenced:
     `sra $t4,$t4,2` before `sw 0x40($s3)` @0x800BEDF8. Costs ~17 fuzzy diffs (our cc1plus
     CSEs a reload the PsyQ compiler kept) -- accepted. */
  sub_otz = sd->sub_otz;
  if (R3DCar_InMenu == 0) {
    sd->sub_otz = sub_otz >> 1;
    if ((sd->sub_otz < 0) || (Draw_gViewOtSize + -3 < sd->sub_otz)) {
      return -1;
    }
  }
  else {
    sd->sub_otz = 0;
  }
  /* MATCH (w63-a14, 54 -> 52 @976/976 count-exact): retail reads sd->sub_otz for the
     world_otz copy BEFORE it loads sort_carObj (`lw v0,64(s3); lw a0,2168(s2)`), ours
     had the two statements the other way round.  Pure statement order; the store
     `sw v0,2148(s2)` stays in the beqz delay slot on both sides.
     Falsified alongside (same basin): hoisting the R3DCar_InMenu test into a block
     temp declared before `shapeIdx = sd->sub_otz;` to make the global load fill that
     load's delay slot (exactly 54 = inert -- the asm-volatile "memory" barrier above
     pins the global load after the mfc2 block, so source order cannot move it);
     `nabr_blend = 2;` moved above the envExtra guard to reach retail's first-beqz
     delay slot (64); splitting `iVar3 = (uVar5 - 1)<<16>>16` into its own decrement
     statement, the sibling lever that worked for shadow_align_b (55 alone, 53 with
     this swap, 51 with both -- but all three cost +1 insn @977, so the count-exact
     52 form is kept per the project's count bar). */
  (carObj->render).world_otz = sd->sub_otz;
  /* shapeIdx morphs in place to <<2 BEFORE the branch (oracle sll s0,s0,2 in
   * the beqz slot region); non-null arm INLINE first (oracle beqz to far arm) */
  sub_otz = sub_otz << 2;
  if ((carObj->render).sort_carObj != (u_char *)0x0) {
    Car_tObj *sort_carObj = (Car_tObj *)(carObj->render).sort_carObj;
    sd->sub_ot = (sort_carObj->render).sub_ot;
    sd->sub_otSize = (sort_carObj->render).sub_otSize;
    sd->sub_otz = (sd->sub_otz - (sort_carObj->render).world_otz) * 2;
    sub_otOffset = (sort_carObj->render).sub_otOffset;
  }
  else {
    /* MATCH (w40-a3): read the two fields BACK from sd for the call args -- cc1's
       cse forwards the just-stored values and emits retail's `addu $a0,$v0,$zero`
       copy; passing the source locals lets gcc load straight into $a0/$a1. */
    sd->sub_ot = (carObj->render).sub_ot;
    sd->sub_otSize = (carObj->render).sub_otSize;
    ClearOTagR(sd->sub_ot,sd->sub_otSize);
    sd->sub_otz = 0;
    sub_otOffset = (carObj->render).sub_otOffset;
  }
  sd->sub_otz = sd->sub_otz * 4;
  (carObj->render).sub_otz = sd->sub_otz + sub_otOffset - sub_otz;
  sd->sub_otSize = sd->sub_otSize + -1;
  sd->pmxStart = CarIO_carPixMap + (carObj->render).textureStartIndex;
  sd->offsetU0 = (u_char)(carObj->render).textureOffsetU;
  sd->offsetV0 = (u_char)(carObj->render).textureOffsetV;
  sd->offsetU1 = (carObj->render).licenseOffsetU[0];
  sd->offsetV1 = (carObj->render).licenseOffsetV[0];
  i = 0x32;
  sd->offsetU2 = (carObj->render).licenseOffsetU[1];
  /* was a bare-VA literal -0x7fee0a94 (= &DrawC_gOverlay[50]) walked by a
   * pointer: really an INDEXED clear of gOverlay[50..0] -- gcc strength-
   * reduction emits the oracle's giv init (lui/addiu sym; addiu +100) and
   * the downstream gOverlay[0] accesses rematerialize the symbol fresh */
  sd->offsetV2 = (carObj->render).licenseOffsetV[1];
  do {
    DrawC_gOverlay[i] = 0;
    i = i + -1;
  } while (-1 < i);
  if (R3DCar_InMenu == 0) {
    if (0x1e0001 <= (carObj->N).damage[0]) {
      DrawC_gOverlay[0] = DrawC_gOverlay[0] | 1;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 1;
    }
    else if (0xa0000 < (carObj->N).damage[0]) {
      DrawC_gOverlay[0] = DrawC_gOverlay[0] | 2;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 2;
    }
    if (0x1e0001 <= (carObj->N).damage[2]) {
      DrawC_gOverlay[0] = DrawC_gOverlay[0] | 0x100;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x100;
    }
    else if (0xa0000 < (carObj->N).damage[2]) {
      DrawC_gOverlay[0] = DrawC_gOverlay[0] | 0x200;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x200;
    }
    if (0x1e0001 <= (carObj->N).damage[3]) {
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x400;
    }
    else if (0xa0000 < (carObj->N).damage[3]) {
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x800;
    }
    if (0x1e0001 <= (carObj->N).damage[4]) {
      DrawC_gOverlay[1] = DrawC_gOverlay[1] | 0x100;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x1000;
    }
    else if (0xa0000 < (carObj->N).damage[4]) {
      DrawC_gOverlay[1] = DrawC_gOverlay[1] | 0x200;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x2000;
    }
    if (0x1e0001 <= (carObj->N).damage[6]) {
      DrawC_gOverlay[1] = DrawC_gOverlay[1] | 1;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x10;
    }
    else if (0xa0000 < (carObj->N).damage[6]) {
      DrawC_gOverlay[1] = DrawC_gOverlay[1] | 2;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x20;
    }
    if (0x1e0001 <= (carObj->N).damage[7]) {
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 4;
    }
    else if (0xa0000 < (carObj->N).damage[7]) {
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 8;
    }
    if (0x30000 < (carObj->N).damage[8]) {
      DrawC_gOverlay[4] = DrawC_gOverlay[4] | 0x101;
    }
    if (((carObj->render).brakeLight & 1U) != 0) {
      if ((DrawC_gOverlay[1] & 1U) == 0) {
        DrawC_gOverlay[0x18] = DrawC_gOverlay[0x18] | 0x81;
        DrawC_gOverlay[0x19] = DrawC_gOverlay[0x19] | 0x81;
      }
      if ((DrawC_gOverlay[1] & 0x100U) == 0) {
        DrawC_gOverlay[0x18] = DrawC_gOverlay[0x18] | 0x8100;
        DrawC_gOverlay[0x19] = DrawC_gOverlay[0x19] | 0x8100;
      }
    }
    if ((carObj->control).gear == '\0') {
      if ((DrawC_gOverlay[1] & 1U) == 0) {
        DrawC_gOverlay[0x1a] = DrawC_gOverlay[0x1a] | 0x80;
      }
      if ((DrawC_gOverlay[1] & 0x100U) == 0) {
        DrawC_gOverlay[0x1a] = DrawC_gOverlay[0x1a] | 0x8000;
      }
    }
    if (((carObj->render).headLight & 0x11U) != 0) {
      if ((((carObj->render).headLight & 0x40U) != 0) || ((DrawC_gOverlay[0] & 1U) == 0)) {
        DrawC_gOverlay[0x1d] = DrawC_gOverlay[0x1d] | 0x81;
      }
      if ((((carObj->render).headLight & 4U) != 0) || ((DrawC_gOverlay[0] & 0x100U) == 0)) {
        DrawC_gOverlay[0x1d] = DrawC_gOverlay[0x1d] | 0x8100;
      }
    }
    if (((carObj->render).brakeLight & 2U) != 0) {
      if ((DrawC_gOverlay[1] & 1U) == 0) {
        DrawC_gOverlay[0x18] = DrawC_gOverlay[0x18] | 0x80;
        DrawC_gOverlay[0x19] = DrawC_gOverlay[0x19] | 0x80;
      }
      if ((DrawC_gOverlay[1] & 0x100U) == 0) {
        DrawC_gOverlay[0x18] = DrawC_gOverlay[0x18] | 0x8000;
        DrawC_gOverlay[0x19] = DrawC_gOverlay[0x19] | 0x8000;
      }
    }
    if (!cop_flag) {
      /* MATCH (w46-a3, 86 -> 70): VARIABLE IDENTITY -- the mirror index gets
         its OWN block-local name.  `shadow_align_b` is a Ghidra fn-scope
         invention reused for four unrelated values later in this function;
         as one fn-scope pseudo it out-lived the address temp and lost the
         a0/a1 order (ours {idx:$a1, &signalLight[idx]:$a0}, retail the
         reverse).  A block-local qty born and dead inside this region wins
         $a0 like retail.  Same lever family as ShowroomPrims 93->4.
         (A SECOND name for the xored value measures 88 -- retail mutates
         ONE pseudo in place, `xori a0,a0,1`.) */
      int mirror = (sd->head).mirror;
      if (((carObj->render).signalLight[mirror] & 0x80U) != 0) {
        DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | 0x40;
      }
      if (((carObj->render).signalLight[mirror] & 8U) != 0) {
        if ((DrawC_gOverlay[0] & 1U) == 0) {
          DrawC_gOverlay[0x1b] = DrawC_gOverlay[0x1b] | 0x80;
        }
        if ((DrawC_gOverlay[1] & 1U) == 0) {
          DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | 0x81;
        }
      }
      /* the ^1 is a STATEMENT, not two sub-expressions: retail emits ONE
       * `xori a0,a0,1` mutating the mirror index in place (census xori 3v2).
       * w45-a4 RESIDUAL (part of PrimStart 86): this block is a clean 2-value
       * swap -- ours {mirrorIdx:$a1, &signalLight[idx]:$a0}, retail
       * {mirrorIdx:$a0, addr:$a1}, i.e. retail ranks the INDEX above the
       * address (birth order) and we rank the address above the index.  Both
       * addu dests are already fresh, so the w43 ascii2sjis fresh-dest half
       * is satisfied; the missing half is the qty LIVE-LENGTH order.  NEW
       * NAMED ANGLE: `shadow_align_b` is a Ghidra-invented fn-scope name that
       * is REUSED elsewhere in this function -- give the mirror index its own
       * block-local name here (so its qty is born and dies inside this block
       * and out-lives the address temp), which is the same variable-identity
       * lever that took ShowroomPrims 93->4 this wave. */
      mirror = mirror ^ 1;
      if (((carObj->render).signalLight[mirror] & 0x80U) != 0) {
        DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | 0x4000;
      }
      if (((carObj->render).signalLight[mirror] & 8U) != 0) {
        if ((DrawC_gOverlay[0] & 0x100U) == 0) {
          DrawC_gOverlay[0x1b] = DrawC_gOverlay[0x1b] | 0x8000;
        }
        if ((DrawC_gOverlay[1] & 0x100U) == 0) {
          DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | 0x8100;
        }
      }
      if (1 < (u_char)R3DCar_SignalBrakeFlare[carType]) {   /* @0x800BF468 lbu R3DCar_SignalBrakeFlare(carType) */
        if ((DrawC_gOverlay[0x1c] & 0x40U) == 0) {
          DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | DrawC_gOverlay[0x18] & 0xffU;
        }
        if ((DrawC_gOverlay[0x1c] & 0x4000U) == 0) {
          DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | DrawC_gOverlay[0x18] & 0xff00U;
        }
      }
      if (R3DCar_SignalBrakeFlare[carType] == '\x03') {   /* @0x800BF4DC lbu R3DCar_SignalBrakeFlare(carType) */
        /* in-place swap, temps AT the use site (oracle lhu 56; lh 48; sh; sh).
         * g[0x18] is not written between the old fn-head ts13 capture and here,
         * so reading it fresh is value-identical -- and it's the oracle's shape */
        int overlay = (short)DrawC_gOverlay[0x18];
        DrawC_gOverlay[0x18] = DrawC_gOverlay[0x1c];
        DrawC_gOverlay[0x1c] = overlay;
      }
      goto DrawCPrimStart_carTypeOff;
    }
  }
  else {
DrawCPrimStart_carTypeOff:
    if (!cop_flag) goto DrawCPrimStart_camRotMatrix;
  }
  {
    /* oracle 0x800BF530..: unconditional |2 / |0x200 stores FIRST (g1b/g1c =
     * the PRE-store lhu pair, reused for the |0x83/|0x281 overwrite), then the
     * siren1 arm reloads fresh and ORs 0x8100 -- no default/override funnel */
    DrawC_gOverlay[0x1b] = DrawC_gOverlay[0x1b] | 2;
    DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | 0x200;
    if (DrawC_gOverlay[4] == 0) {
      if (DrawC_SirenFlash[(u_short)(carObj->render).signalLight[0] & 0xf] != 0) {
        DrawC_gOverlay[0x1b] = DrawC_gOverlay[0x1b] | 0x81;
        DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | 0x81;
      }
      if (DrawC_SirenFlash[(u_short)(carObj->render).signalLight[1] & 0xf] != 0) {
        DrawC_gOverlay[0x1b] = DrawC_gOverlay[0x1b] | 0x8100;
        DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | 0x8100;
      }
    }
  }
  if ((R3DCar_InMenu != 0) || ((carObj->AIFlags & 2U) != 0)) {
    DrawC_gOverlay[0x1d] = DrawC_gOverlay[0x1d] & 0x7e7e;
    if (((carObj->render).brakeLight & 1U) == 0) {
      DrawC_gOverlay[0x18] = DrawC_gOverlay[0x18] & 0x7f7f;
      DrawC_gOverlay[0x19] = DrawC_gOverlay[0x19] & 0x7f7f;
    }
    if ((DrawC_HeadLightFlash[(u_short)(carObj->render).signalLight[0] & 0xf] != 0) &&
       ((((carObj->render).headLight & 0x40U) != 0 || ((DrawC_gOverlay[0] & 1U) == 0)))) {
      DrawC_gOverlay[0x1d] = DrawC_gOverlay[0x1d] | 0x81;
    }
    if ((DrawC_HeadLightFlash[(u_short)(carObj->render).signalLight[1] & 0xf] != 0) &&
       ((((carObj->render).headLight & 4U) != 0 || ((DrawC_gOverlay[0] & 0x100U) == 0)))) {
      DrawC_gOverlay[0x1d] = DrawC_gOverlay[0x1d] | 0x8100;
    }
    if ((DrawC_gOverlay[1] & 1U) == 0) {
      if (DrawC_TailLightFlash[(u_short)(carObj->render).signalLight[0] & 0xf] != 0) {
        DrawC_gOverlay[0x18] = DrawC_gOverlay[0x18] | 0x80;
        DrawC_gOverlay[0x19] = DrawC_gOverlay[0x19] | 0x80;
      }
      if (DrawC_HeadLightFlash[(u_short)(carObj->render).signalLight[0] & 0xf] != 0) {
        DrawC_gOverlay[0x1a] = DrawC_gOverlay[0x1a] | 0x80;
      }
    }
    if ((DrawC_gOverlay[1] & 0x100U) == 0) {
      if (DrawC_TailLightFlash[(u_short)(carObj->render).signalLight[1] & 0xf] != 0) {
        DrawC_gOverlay[0x18] = DrawC_gOverlay[0x18] | 0x8000;
        DrawC_gOverlay[0x19] = DrawC_gOverlay[0x19] | 0x8000;
      }
      if (DrawC_HeadLightFlash[(u_short)(carObj->render).signalLight[1] & 0xf] != 0) {
        DrawC_gOverlay[0x1a] = DrawC_gOverlay[0x1a] | 0x8000;
      }
    }
  }
DrawCPrimStart_camRotMatrix:
  {
    SVECTOR r;
    r.vx = 0;
    r.vz = 0;
    r.vy = R3DCar_yawCam;
    RotMatrix(&r,&DrawC_gMatA);
  }
  DrawC_gMatA.t[2] = 0;
  DrawC_gMatA.t[1] = 0;
  DrawC_gMatA.t[0] = 0;
  DrawC_gWetRoad = 0;
  if (R3DCar_InMenu == 0) {
    RECT tw;
    DRAWENV *LEnv;
    int eSpeed;
    eSpeed = 3;
    LEnv = Draw_GetDRAWENV(gCView.id,gFlip);
    /* quad = SIGNED byte (oracle lb 124); each .extra read ONCE as lhu into a
     * temp -- the &0xff and <<16>>24 both derive from the SAME halfword value */
    /* MATCH (w53-a2, 70 -> 60, count-exact 976/976).  Two independent edits:
       (a) `nabr_blend = 2;` moved from BEFORE the envExtra `if` to BETWEEN the two
           `if`s.  With it in front, reorg back-steals `li s5,2` into the
           Draw_GetDRAWENV `jal` slot (retail steals `li s6,3` = shadowAbsOffs there);
           moving it one statement down frees the jal slot for shadowAbsOffs and the
           jal delay slot becomes retail-exact.  (Swapping the shadowAbsOffs
           assignment to AFTER the call instead is a NO-OP -- gcc reschedules it back.)
       (b) 🔑 the quad byte moved OUT of the fn-scope `iVar3` scratch into a
           BLOCK-LOCAL `quadB`.  `iVar3` is re-assigned twice later in this fn, so as
           one fn-scope pseudo its live range spans the whole envmap/shadow section
           and it takes a CALLEE-SAVED home ($s0); retail keeps the quad in $a3
           (caller-saved, dies at the second `slt`).  Splitting the range moves all
           three `slt v0,a3,v0` uses onto retail's register at zero instruction cost.
           (Same family as this fn's existing eColor/eColor2 "NOT the fn-scope iVar3
           scratch" receipt, and as methodology 3.12 #15's decl-scope rule.)
       RESIDUAL 60, in 8 clusters, all count-exact and all reorg/sched-class:
        - 2x `lw ...,64(s3)` scheduled one slot early (ours) vs into the following
          load-delay slot (retail);
        - `li s5,2` lands in the SECOND `beqz` delay slot, retail's in the FIRST
          (retail steals the post-join insn, ours steals the if-body's first insn);
        - the two `-1` decrements (`addiu v1,a2,-1` / `addiu a1,a1,-1`): retail
          hoists them into `bgez` delay slots, ours computes them at use;
        - the RECT `tw` block: retail stores tw.x IMMEDIATELY after its lbu and fills
          that lbu's load-delay with the SetDrawMode `0` arg (`addu a2,zero,zero`),
          ours sinks the tw.x store behind the w/h constant stores. */
    {
      int quad;
      int tpageShadow;
      short envMap;
      short shadow;
      short extraEnvMap;
      short extraShadow;
      quad = (signed char)(carObj->N).simRoadInfo.quad;
      envMap = (u_short)DrawC_gEnvMap[(carObj->N).eIndexEnvMap].tex;
      extraEnvMap = (u_short)DrawC_gEnvMap[(carObj->N).eIndexEnvMap].extra;
      shadow = (u_short)DrawC_gShadow[(carObj->N).eIndexShadow].tex;
      extraShadow = (u_short)DrawC_gShadow[(carObj->N).eIndexShadow].extra;
      tpageShadow = 2;
      if (quad < (int)((u_short)extraEnvMap & 0xff)) {
        envMap = (int)((u_int)(u_short)extraEnvMap << 0x10) >> 0x18;
      }
      if (quad < (int)((u_short)extraShadow & 0xff)) {
        shadow = (int)((u_int)(u_short)extraShadow << 0x10) >> 0x18;
      }
      if (10 < envMap) {
        envMap = envMap - 10;
        half = 1;   /* oracle li s7,1 inside the arm (no bool materialize) */
      }
      envMap = envMap - 1;
      if (shadow < 0) {
        eSpeed = 0;
        shadow = -shadow;
      }
      if (10 < shadow) {
        shadow = shadow - 10;
        tpageShadow = 1;
      }
      shadow = shadow - 1;   /* MATCH w55-a9: own statement -> reorg steals it into the (short)(uVar5-1) bgez delay slot (oracle addiu a1,a1,-1 @800BF918) */
      if (envMap < 0) {
        *(u_int *)&sd->ePmx0 = 0;   /* fused u0/v0/clut word store (oracle sw zero) */
      }
      else {
        /* MATCH: whole-struct copy (both sides Draw_tPixMap) -- gcc's own unaligned
         * struct-assignment codegen (lwl/lwr/swl/swr) reproduces the oracle's
         * 16-byte movstrsi-style block; the old byte/word-peeled shift-mask form
         * was a Ghidra decompile artifact, not the true source shape. */
        sd->ePmx0 = Track_gReflectionMaps[envMap];
      }
      if (shadow < 0) {
        *(u_int *)&sd->ePmx1 = 0;   /* fused u0/v0/clut word store (oracle sw zero) */
      }
      else {
        tw.x = (short)Track_gReflectionMaps[shadow].u0;
        tw.y = (short)Track_gReflectionMaps[shadow].v0;
      tw.w = 0x80;
      tw.h = 0x40;
        SetDrawMode(&sd->drawModeOn,(u_int)LEnv->dfe,0,
                   (u_int)Track_gReflectionMaps[shadow].tpage,&tw);
      tw.h = 0;
      tw.w = 0;
      tw.y = 0;
      tw.x = 0;
        SetDrawMode(&sd->drawModeOff,(u_int)LEnv->dfe,0,
                  (u_int)LEnv->tpage,&tw);
      /* MATCH: whole-struct copy (both sides Draw_tPixMap); see ePmx0 above. */
      sd->ePmx1 = Track_gReflectionMaps[shadow];
        ChangeTPage(&(sd->ePmx1).tpage,tpageShadow);
      }
    }
    /* w70-a1 RESIDUAL (8 diffs, count-exact 976/976): a pure sched2 ready-list
       ORDER + one register pick.  The insn MULTISET is identical -- ours
       `addiu v0,s6,3 / lh v1 / lui a0 / srav v1,v1,v0 / lbu v0,117(s3) /
       addiu a0,a0,0 / srl / sll / addu`, retail
       `addiu a0,s6,3 / lh v1 / lbu v0,117(s3) / srav v1,v1,a0 / srl / sll /
       lui a0 / addiu a0 / addu`: retail fills the `lh`'s load-delay with the
       ePmx1.v0 `lbu` and materialises &DrawC_gEnvMapOffset LAST (so the shift
       amount and the base SHARE $a0), ours interleaves the address pair into
       the delay slots so both are live at once.  FALSIFIED at this basin (all
       count-exact 976): index-term-first address spelling
       `*(short*)(((v0>>6)<<1)+(int)DrawC_gEnvMapOffset)` = 30; a named
       `envShift = shadowAbsOffs + 3` local = 8 (bit-identical); splitting the
       first term into its own block-local `za` = 8 (bit-identical); operand
       swap (array term first) = 18.  Same class as the DrawC_NightHeadlight
       w61-a15 residual (dependence-graph-forced priority) => PER_FN_TEXT_MOVES
       is the instrument, not a source dial.
       ===== w71-a3 (base 8 @976): NEW NAMED ANGLE -- the ORDER half IS source-
       reachable; only the register pair is left.  Splitting the ARRAY INDEX into
       its own statement AHEAD of the sum -- `u_int ev = (sd->ePmx1).v0 >> 6;`
       then `... + (int)DrawC_gEnvMapOffset[ev]` -- gives the index a LOWER luid
       than the table address, so sched1 fills the `lh`'s load-delay slot with the
       ePmx1.v0 `lbu` (retail's fill) and emits the `lui/addiu` pair LAST, exactly
       like the oracle.  Result 20 @976 EXACT and the residual is then a PURE
       $v1<->$a0 swap over 20 lines with the ORDER identical (ours shift/addr in
       $v1 + positionXZ in $a0; retail shift/addr $a0 + positionXZ $v1) -- i.e.
       one local-alloc handout, the 06E qtytrace class.  Higher LCS than the 8 so
       NOT landed, but it is the correct structural base to re-attack from once a
       qty instrument exists; the 8-diff form hides an ordering defect.
       ALSO FALSIFIED at that split basin (all count-exact 976): `int ev = v0;` +
       `ev >> 6` = 10 (2 of them a real srl-vs-sra signedness bug -- ev must be
       u_int); `u_int ev = v0;` + `ev >> 6` = 8 bit-identical to base (cse folds
       it back, so the shift MUST be inside the split statement); hoisting a `pz`
       local for positionXZ, or an `envShift` local ahead of both = 20
       bit-identical (cse canonicalises, statement position is inert here);
       read-only fence `("" : : "r"(pz))` before the sum = 18 (the barrier moves
       the whole block, wrong axis).
       ===== w72-a3 (2026-08-22): 8 -> 4, count-exact 976/976, AND the last 4 are a
       VALIDATED PER_FN_TEXT_MOVES PASS (976/976) -- spec at the end of this block.
       THE MECHANISM, read off the instrumented cc1plus's own [qty_order] trace
       (C:/Temp/nfs4-instr-cc1/cc1plus-ecoff.exe, GCC_TRACE_ALLOC=1; fidelity
       receipt: its .s for THIS fn is byte-identical to the real CC1PLPSX, 955/955
       lines, only $L-numbers differ).  local-alloc block 126 carries FOUR qtys:
         q(ev)=lbu+srl+sll chain  q(pos)=lh+srav+andi  q(shift)=addiu  q(addr)=high+lo_sum
       RETAIL's handout is ev=$v0, pos=$v1, shift=$a0, addr=$a0 (shift and addr
       SHARE $a0 -- addr is born after shift dies).  Ours had shift=$v0 because
       q(ev)'s window began at the `lbu`, which sched1 placed AFTER the `addiu`,
       so $v0 was free over q(shift)'s 2-insn window and the numeric scan took it.
       => the requirement is exactly: q(ev) must be BORN BEFORE the addiu, and
       q(addr) must stay the LOWEST-priority of the four (a compact high/lo_sum
       pair raises it: refs 4 / life 6 = pri 1.333 out-ranks pos at 1.2 and the
       whole handout rotates -- measured, that is what the plain `ev` split does).
       THE LANDED FORM (three cooperating parts, all zero-insn):
        (1) `int envShift = shadowAbsOffs + 3;` FIRST -- gives the addiu the lowest
            luid so it heads the block exactly like retail.
        (2) `int pz = <positionXZ>;` then a READ-ONLY fence `("" : : "r"(pz))` --
            the fence is implicitly volatile, so it is the sched1 BARRIER that stops
            the `lbu` being hoisted above the `lh` (without it sched1 leads with the
            lbu because its chain is the longer critical path).
        (3) `u_int evraw = (sd->ePmx1).v0;` + an IDENTITY LAUNDER
            ("" : "=r"(evraw) : "0"(evraw)) -- the launder is what keeps the load
            at its own luid (a bare `u_int evraw = v0;` is folded straight back into
            the subscript by cse, which is the w71 `= 8 bit-identical` receipt), and
            keeping the `>> 6` OUT of the split statement is load-bearing: with the
            shift inside (the w71 `u_int ev = v0 >> 6;` form) the srl/sll move ahead
            of the address pair, q(addr)'s life collapses 10 -> 6 and it out-ranks
            q(pos).  MEASURED LADDER at this basin, all count-exact 976 unless noted:
              base (one statement)                                    8
              ev split (w71 form)                                    20
              pz + ev split                                          20
              evraw split, no launder                                 8 (cse folds)
              evraw split + launder                                   6
              pz + evraw split + launder                              6
              envShift + pz + evraw + launder            (P5)         4
              envShift + pz + LAUNDER(pz) + evraw + launder (P15)     4 (same bytes)
              envShift + pz + FENCE(pz) + evraw + launder (LANDED)    4
        FALSIFIED at the 4 basin (each measured here, none inherited): void-tail
        fence `("" : : "i"(0))` between pz and evraw = 21 @977; fence on pz with no
        launder = 10 @978; index-term-first `*(short*)(((evraw>>6)<<1)+(int)tbl)` =
        28; the same with a named `ev` = 29 @977; `(int)*(tbl + (evraw>>6))` = 21
        @977; a block-local `ev = evraw>>6` before the sum = 22 @978; `+`-operand
        swap (table term first) = 22 @978; in-place `evraw = evraw >> 6;` = 23 @979;
        in-place `pz = pz >> envShift & 0x3f;` = 22 @978; a second read-only fence on
        evraw = 22 @978; `u_int ev = v0 >> 6` + launder = 23 @979.
       RESIDUAL 4 = ONE 2-insn group swap, no register left wrong:
         ours   ... sra $3,$3,$4 / lui $4,%hi(tbl) / addiu $4,$4,%lo(tbl) / srl / sll / addu
         retail ... sra $3,$3,$4 / srl / sll / lui $4,%hi(tbl) / addiu $4,$4,%lo(tbl) / addu
       ROOT CAUSE (gcc source): for `tbl[i]` cc1 expands the PLUS's op0 = the symbol
       address BEFORE op1 = the scaled index, so the high/lo_sum pair always carries
       the lower luid; sched2 is priority-1-flat post-reload and keeps that order.
       Retail's build emitted the index first.  No source spelling reaches it (the
       index-term-first family above is the direct attempt and costs 24+).
       ==> PER_FN_TEXT_MOVES, VALIDATED VIA tools/vprobe.py = PASS 976/976:
         key recon/game/psx/drawc.cpp ->
           "DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache": [
             {"take": "\tlui\t\$4,%hi\(DrawC_gEnvMapOffset\)[^\n]*\n",
              "after": "\tsll\t\$2,\$2,1\n(?=\taddu\t\$2,\$2,\$4\n)"},
             {"take": "\taddiu\t\$4,\$4,%lo\(DrawC_gEnvMapOffset\)[^\n]*\n",
              "after": "\tlui\t\$4,%hi\(DrawC_gEnvMapOffset\)[^\n]*\n"}]
       Both takes are UNIQUE in the fn region (1 match each); the row-1 after-anchor
       is lookahead-pinned on `addu $2,$2,$4` (the bare `sll $2,$2,1` occurs 3x) and
       references no taken line; row 2 anchors on the line row 1 just placed.  No
       branch line, no delay slot, no drop_after => the 17C brdist pairing rule does
       not apply; count stays 976 and the gate reports PASS.
       WIRING WARNING (12F duplicate-key hazard): build.py ALREADY HAS a
       "recon/game/psx/drawc.cpp" key in PER_FN_TEXT_MOVES (DrawC_NightHeadlight).
       The two rows above must be ADDED INSIDE that existing dict -- a second
       top-level key with the same path is silently discarded (python literal,
       last wins) and the rows would read as INERT.  Validated exactly that way:
       tools/vprobe.py's W60_TEXT_MOVES_FILE hook does a setdefault().update(),
       i.e. it merges into the NightHeadlight entry, and reported PASS 976/976
       with NightHeadlight still PASSing in the same whole-TU gate (17/20). */
    {
      int envShift = eSpeed + 3;
      int pz = (int)(carObj->N).positionXZ;
      __asm__("" : : "r"(pz));
      u_int evraw = (sd->ePmx1).v0;
      __asm__("" : "=r"(evraw) : "0"(evraw));
      sd->eAddZ = (pz >> envShift & 0x3fU) +
                  (int)DrawC_gEnvMapOffset[evraw >> 6];
    }
    if (((GameSetup_gData.Weather != 0) &&
        (tunnelFlag = (int)BWorldSm_TunnelFlagSm(&(carObj->N).simRoadInfo), tunnelFlag != 1)) &&
       (Cars_kSkidMarkSurface[(carObj->N).driveSurfaceType] == 1)) {
      DrawC_gWetRoad = 1;
    }
    DrawC_gReflectOffset =
         (short)((((carObj->N).dimension.y * 3 >> 1) + (carObj->N).objAltitude) >> 8);
  }
  else {
    DRAWENV *LEnv = Draw_GetDRAWENV(gCView.id,gFlip);
    SetDrawMode(&sd->drawModeOn,(u_int)LEnv->dfe,1,
               (u_int)LEnv->tpage,(RECT *)0x0);
    SetDrawMode(&sd->drawModeOff,(u_int)LEnv->dfe,0,
               (u_int)LEnv->tpage,(RECT *)0x0);
    /* MATCH: whole-struct copy (both sides Draw_tPixMap); see ePmx0 above. */
    sd->ePmx0 = *gMenuPixmap[0];
  }
  ChangeTPage(&(sd->ePmx0).tpage,1);
  {
    /* SYM: dedicated REG locals eColor / eColor2 (NOT the fn-scope iVar3
     * scratch, whose earlier cross-call web forces a callee-saved home;
     * oracle keeps this chain in caller-saved $a2) */
    /* w62-a14 (base 54, count EXACT 976/976): the InMenu ARM-ORDER lead, executed
     * and DEAD as a spelling.  side_by_side shows ours emitting the else-arm's
     * `sra a2,fp,1` BEFORE the InMenu==0 arm while retail keeps it in the else
     * arm's `j` delay slot (retail: `sra a2,fp,2; lui v0; lbu v0; nop; mult a2,v0`
     * ... `j T; sra a2,fp,1`).  Inverting the guard so the small arm becomes the
     * if-body (`if (R3DCar_InMenu != 0) eColor = lightAvg >> 1; else {...}`) is
     * EXACTLY neutral -- 54 @976, bit-identical: gcc-2.8 jump-opt canonicalises the
     * polarity.  The 13C inverted-default form (`eColor = lightAvg >> 1;` at the
     * block head + a bare `if (InMenu == 0)` override) is 86 @976.  => this cluster
     * is a sched1 hoist of the arm's shift, not an arm-order defect. */
    int eColor;
    if (R3DCar_InMenu == 0) {
      eColor = lightAvg >> 2;
      eColor = (int)((u_int)eColor * (u_int)R3DCar_eMapColour.r) >> 7;
      if (half) {
        eColor = (eColor << 1) / 3;
      }
      /* *0x10101 written as explicit sll16+sll8 adds (oracle shape; cc1plus's
       * own synth-mult picks the Horner ((x<<8+x)<<8+x) form instead) */
      {
        int eColor2 = eColor * 3 >> 2;
        sd->eColor2 = (eColor2 << 0x10) + (eColor2 << 8) + eColor2;
      }
    }
    else {
      eColor = lightAvg >> 1;
    }
    sd->eColor0 = (eColor << 0x10) + (eColor << 8) + eColor;
    /* if/ELSE with the >>2 DUPLICATED into both arms (w41-a3): retail's shape is
     * `bne type,1,L; sll v0,a2,1 [stolen into the slot]; j T; sra a2,a2,2 [==1
     * arm, in the j slot]; L: addu v0,v0,a2; sra a2,v0,2`.  A single shared
     * `if (type != 1) eColor = eColor*3;` + one trailing `>>2` makes cc1 CSE the
     * compare's `li v0,1` into a `sllv v0,a2,v0` variable shift and merges the
     * two shifts -- the == arm has to be a real arm. */
    if ((carObj->render).currentCarType == 1) {
      eColor = eColor >> 2;
    }
    else {
      eColor = ((eColor << 1) + eColor) >> 2;
    }
    sd->eColor1 = (eColor << 0x10) + (eColor << 8) + eColor;
  }
  return (carObj->render).world_otz;
}

/* ---- DrawC_PrimStop__FP8Car_tObjP13Draw_CarCache  [DRAWC.CPP:1535-1563] SLD-VERIFIED ---- */
void DrawC_PrimStop(Car_tObj *carObj,Draw_CarCache *sd)

{
  Car_tObj *sort_carObj;
  int worldZ;
  int sub_otSize;

  if (carObj->render.sort_flag != 0) {
    return;
  }
  sort_carObj = (Car_tObj *)carObj->render.sort_carObj;
  if (sort_carObj != (Car_tObj *)0x0) {
    if ((sort_carObj->render.sort_flag != 0) &&
       (sort_carObj->render.sort_flag = sort_carObj->render.sort_flag + -1,
        sort_carObj->render.sort_flag != 0)) {
      return;
    }
    sub_otSize = sort_carObj->render.sub_otSize + -1;
    worldZ = sort_carObj->render.world_otz;
  }
  else {
    sub_otSize = carObj->render.sub_otSize + -1;
    worldZ = carObj->render.world_otz;
  }
  ((DrawC_tTag *)sd->sub_ot)->addr = sd->head.cprim.LastPrim[worldZ] & 0xffffff;
  ((DrawC_tTag *)&sd->head.cprim.LastPrim[worldZ])->addr =
      (u_long)(sd->sub_ot + sub_otSize) & 0xffffff;
  return;
}

/* ---- DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache  [DRAWC.CPP:1772-2543] SLD-VERIFIED ----
 * w50-A3 TRIAGE (census-first, no code change).  BOTH monsters are clean on the
 * missing-logic test and share ONE dominant, already-diagnosed cluster:
 *  - tools/brcensus.py: Prim and PrimClip have ZERO branch/jal/j deltas => no dropped
 *    call, no missing arm, no polarity flip anywhere in either function.  The 746/857
 *    are expression + coloring, not structure.
 *  - tools/rove_op.py opcode deltas (ours v oracle): Prim `sll 84v82, lh 6v4`;
 *    PrimClip `sll 83v81, lh 92v90, lhu 96v95`.  Both carry exactly TWO EXCESS
 *    short-sign-extension pairs (the w40 census row read in the EXCESS direction),
 *    i.e. two sites where a value is spelled `short` that retail keeps wider.
 *  - tools/chunkdiff.py localises the biggest run to the per-vertex UV TINT block:
 *    retail runs it on FOUR temps ($t6/$t7 = the base u/v pair held across all three
 *    vertices, $t4/$t5 = the per-vertex pair, loads batched so each fills the other's
 *    load-delay slot); ours serialises everything through $v0/$v1/$a0/$a1 with nops.
 *    That is the SAME block, with the same allocno bar, as DrawC_PrimMenu's -- see the
 *    long `u0` receipt there (reqdelta: a second uv pseudo is admissible only as a
 *    GLOBAL allocno with pri < .7578).  ⇒ CRACK PrimMenu's uv pair FIRST; the lever
 *    then transfers to Prim and PrimClip unchanged (three fns, one dial).
 * w70-a1 (166 @1395/1389) -- m2c CROSS-VERIFY + one falsification.
 *  - m2c cross-verify against C:\Temp\nfs4-clean\Binaries\NFS4-B-USA\c\func_800BFD44.c
 *    (seal criterion 6): calls, arg counts, branch structure, field offsets and the
 *    return all agree with this body.  The 166 is codegen only, confirming the
 *    w50-A3 brcensus triage above.
 *  - FALSIFIED (named angle "facetFlag as int"): the +6 insn excess includes an
 *    EXTRA `lhu v1,0(facet)` beside the `lh v0,0(facet)` at each of the three
 *    facetFlag sites -- cc1 narrows `((short)mem) & 0xfff` back to a halfword
 *    reload, while retail derives BOTH masks (`andi 4095` / `andi 1008`) from the
 *    single SIGNED load.  Declaring `facetFlag` int (which does kill the reloads)
 *    measures 1391 insns -- 4 CLOSER to the oracle's 1389 -- but 256 diffs, so the
 *    LCS realignment cost dwarfs it and it was NOT landed.  Keep the SHORT (the SYM
 *    says SHORT); the reload wants a narrowing-blocker at the USE, not a type change.
 * ===== w71-a3: 166 -> 118, count 1395 -> 1393 (oracle 1389).  THREE landings. =====
 *  (1) IN-PLACE COMPOSITE SHIFT on `overlayRaw` -- the biggest lever here (152 -> 118
 *      on Prim, and the same edit is ~-19 on PrimClip's two twins).  The fused
 *      `overlayRaw = (int)((u_int)(u_short)DrawC_gOverlay[..] << 0x10);` makes cc1
 *      born a FRESH pseudo for the shift result, so combine_regs never ties it to the
 *      loaded value and we emit `sll a2,v0,16` where retail has the in-place
 *      `sll v0,v0,16`.  Split it into `overlayRaw = (u_short)DrawC_gOverlay[..];
 *      overlayRaw = overlayRaw << 0x10;` -- the dest is now a real INPUT operand of
 *      the shift (the W41 composite-RMW law) and cc1 emits the in-place pair, which
 *      also un-rotates the whole `sra a1,..,16` / `sra a1,..,24` chain downstream.
 *      Landed at BOTH Prim sites and both PrimClip sites.
 *  (2) SYM `code` LOCAL at the prim-code stores (166 -> 162).  symblk shows
 *      `REG code $NN UCHAR` paired with `REG color ULONG` in EVERY prim-emission
 *      block (about ten of them); the literal `*(u_char *)((int)prim + 7) = 0x24;`
 *      form re-materialises `li v0,36` inside the loop while retail's named local is
 *      LICM-hoisted into a register held across the whole case (`li t3,36` /
 *      `li s4,36` in the preheader).  Two of the four sites lose their `li` outright.
 *  (3) PARENTHESISE THE INT SUM in the overlay address (162 -> 152, -2 insns):
 *      `overlay + (index * 3 + which)` not `overlay + index * 3 + which`.  C's
 *      pointer_int_sum rebuilds ptr-first and emits `addu v0,s6,v0; addu a2,v0,a0`
 *      (3 insns); grouping the int sum first gives retail's `addu v0,v0,a0;
 *      addu a2,s6,v0` (2).  The already-parenthesised sibling at the tail of this TU
 *      was the tell.  Landed at both Prim sites and both PrimClip sites.
 * FALSIFIED at the 118 basin (each re-measured here, none inherited):
 *  - `int facetFlag` (the w70-a1 angle, re-tested per law 04Z): 242 @ 1389 EXACT.
 *    It really does kill both `lhu` reloads AND reaches the oracle's instruction
 *    count -- but it drops register pressure enough that gcc abandons retail's
 *    callee-saved $s7 %hi base hoist (frame 56 -> 48, `sw s7,44(sp)` gone), which
 *    re-colours the whole body.  ==> the count-exact target needs the reload killed
 *    WITHOUT freeing a saved register; that is the named next angle.
 *  - identity launder on facetFlag (`("" : "=r"(f) : "0"(f))`) to block the HImode
 *    re-narrow: 120 @1397 -- a short in "=r" is NOT zero-insn, it pays the mode
 *    conversion at each of the two sites.
 *  - cse double-eval form for facet_flag (drop the `ff` temp, write
 *    `facet_flag = facetFlag & 0xfff;` plus a second literal `(facetFlag & 0xfff)`
 *    at the use, chasing retail's `andi v1; addu t1,v1,zero; srl v0,v1,4`):
 *    122 @1397 -- cc1 emits both ANDs for real, it does not fold one into a copy.
 *  - the PrimClip id-morph SPLIT (`idN = idN * 8; idN = idN + (int)sd;`) re-probed
 *    at this basin per 04Z: 306 (it was 342 at the 162 basin) -- still far worse, so
 *    the w55-a9 "site-scoped, do not port" verdict stands for Prim.
 *  - statement-order swap of `i = obj->numVertex` and `envmapUV_dst = sd->tV`:
 *    118 bit-identical (cse canonicalises; position is inert in that head).
 *  - dropping the `color` local at the one 0x26 site whose `li` did not hoist: 118.
 *  - moving the case-9 locals (prim/overlayFlag/facetFlag/facet/id0-2) from case
 *    scope into the while-body block, which is where symblk puts them
 *    (Block start $800c0c68): 118 bit-identical -- SYM-faithful but gate-neutral,
 *    reverted to keep the diff minimal (16A: the decl dial is inert for pseudos
 *    local-alloc already treats as block-local).
 * (the RESIDUAL-118 class list that stood here is superseded by w72-a3 below;
 *  its head-rotation entry was the DEFECT this wave fixed.)
 * ===== w72-a3 (2026-08-22): 118 -> 84, PREDICT-BEFORE-PROBE off allocsim =====
 * 🏆 THE SYM'S SINGLE fn-SCOPE COUNTER IS AN ALLOCNO LIVE-LENGTH DIAL.
 * The head $t0/$t1/$t2 three-way rotation (the biggest standing class, ~14 diffs)
 * was NOT a priority coin-flip: it was priced, then solved, in that order.
 *  (1) allocsim MATCHES 97/97 on this fn (validate the model first, law 4.3), so
 *      the table is authoritative: p149 = `i` (the counter, refs 14 / live 42 /
 *      pri 1.0000, rank 61), p172 = `sd+0x9C` (the gte_stlvnl address, refs 3 /
 *      live 24 / 0.1250, rank 80), p171 = `sd+0xAC` (gte_ldv0, refs 3 / live 25 /
 *      0.1200, rank 81).  Retail's handout is p172=$t0, p171=$t1, p149=$t2 -- i.e.
 *      the two ADDRESSES must be served BEFORE the counter.
 *  (2) `allocsim --what-if 149:live=N` prices it EXACTLY: live 42 -> 200 gives
 *      p149=$t1; -> 300 gives $t1 with p171 at $t2; -> 400..600 gives the ORACLE
 *      TRIPLE p172=$t0 p171=$t1 p149=$t2; -> 900 overshoots to $t3.  The rival
 *      direction is dead: raising the two addresses' refs (4/6/8/12/16, both) never
 *      reaches it -- at 6+ they start stealing $a3/$a1/$a2 instead.
 *      => THE REQUIRED DELTA IS `i` LIVE 42 -> ~400, a 10x, which no fence/
 *      ref-step dial can buy.  Only a STRUCTURAL change can.
 *  (3) THE STRUCTURE THE SYM ALREADY MANDATED: symblk lists exactly ONE counter in
 *      the whole function -- `REG i $10 t2 INT`, declared in the OUTERMOST
 *      `90 Block start` -- and NO facetIdx/facetCount of any kind.  This recon had
 *      a second fn-scope `u_int facetIdx` driving all five facet loops.  Merging it
 *      into `i` (delete the decl, `i = (int)obj->numFacet;`, `if (i == -1)`, 17
 *      lines) makes ONE pseudo live across every loop: 118 -> 84 in one edit, and
 *      the head triple + the whole first block become BYTE-EXACT.  tools/posdiff:
 *      first-use register order is now IDENTICAL to the oracle (24/24) and the
 *      alpha-renamed structural residual is 37/1389.
 *      ⚠️ The pre-existing receipt above (`int facetIdx` + `== -1` = bit-identical)
 *      measured only the TYPE, never the MERGE -- the type is inert, the identity
 *      is the lever.  Same defect + same cure transferred to DrawC_PrimClip
 *      (`int facetCount` -> `i`, 325 -> 285); check every fn whose SYM shows one
 *      counter but whose recon carries two.
 * RE-PRICED AT THE 84 BASIN (04Z; every number measured here, none inherited):
 *   - `int facetFlag` per-site: site1 95 @1392, site2 197 @1390, both 208 @1389
 *     (count-EXACT and still +124 diffs) -- the reload kill remains real and the
 *     coloring cascade still dominates.  NOT landed; the named angle stands.
 *   - the fused id-morph at the 5th site (`id0 = id0 * 8 + (int)sd;` x3, the one
 *     chunkdiff run that emits `sll v0,tN,3; addu tN,v0,s1` instead of retail's
 *     in-place pair): splitting it is 276/266/256 for one leg, 286..290 for two or
 *     three, all count-EXACT 1393.  posdiff confirms it is NOT LCS noise -- the
 *     structural residual itself goes 37 -> 57.  The FUSED form is correct here;
 *     this is now a STRONG receipt (single-leg + pair + triple all measured, both
 *     metrics agree), not the basin-relative verdict the older note recorded.
 *   - the do{}while(0) ref-step dial on the OTHER (already-split) morph site: 154.
 * RESIDUAL 84 = 37 structural + ~47 coloring (posdiff), largest classes:
 *   - the 2nd overlayRaw site (chunkdiff run of 6): ours re-loads
 *     `sll v0,v0,1; addu v0,v0,s4; lhu v1,0(v0); nop; sll v1,v1,16; sra a2,v1,16`
 *     where retail keeps the value and only sign-extends (`sll v0,v0,16; sra`).
 *     Retail materialises %hi(DrawC_gOverlay) into $s7 IN the block with the
 *     `lbu` scheduled BETWEEN the lui and the addiu (a SELF-temp combined qty);
 *     ours splits the pair across a basic-block boundary (the `lui $2` sits in a
 *     `beq` delay slot, the `addiu $20,$2` after the label) so combine_regs
 *     refuses the tie (local-alloc.c:1866, catalog 21E-4) and we get a SEPARATE
 *     temp + a hoisted $s4 base.  NAMED NEXT ANGLE: keep the %hi/%lo pair inside
 *     one block (block-local launder at the use, or a TEXT_MOVES row pulling the
 *     `lui` out of the delay slot) -- 21E-4 records this exact cure as
 *     `block-local launder + TEXT_MOVES row, 18A coupled -> PASS`.
 *   - the id0/id1/id2 `sll v0,tN,3` scratch at the fused site (6) -- STRONG floor,
 *     see the re-price above.
 *   - the two `lhu` facetFlag reloads (2 insns of the +4 excess) -- the `int
 *     facetFlag` angle, priced above.
 * ===== w74-a3 (2026-08-23): 84 -> 16, count 1393 -> 1389 = ORACLE-EXACT =====
 * FOUR landings; the whole w72-a3 residual-84 class list above is retired.
 *  (1) 🏆 THE `code` LOCAL IS CASE-SCOPE AND SHARED BY BOTH 0x26 BLOCKS
 *      (84 -> 66, -2 insns).  Retail materialises 0x26 ONCE per case, into a
 *      CALLEE-SAVED reg (`addiu $s4,$zero,0x26` @800C0028, stolen by reorg into
 *      the case-9 dispatch's delay slot) and both `sb $s4,7($a3)` stores read
 *      it.  Ours had a literal `0x26` at each of the two ~25-line identical
 *      blocks -> two local `li` (`li v0,38` / `li v1,38`).  ⚠️ A BLOCK-LOCAL
 *      `{ u_char code = 0x26; ... }` at each site is BIT-IDENTICAL to the
 *      literal (measured): a single-def/single-use local is const-propagated
 *      away, and update_equiv_regs moves the def to just before its use (22A-8).
 *      Only ONE decl with TWO uses IN DIFFERENT BASIC BLOCKS keeps the pseudo
 *      live across them -> a real cross-block allocno -> the callee-saved home.
 *      => `u_char code = 0x26;` in the case's declaration block, both stores
 *      `= code`.  `int code` measures the same 66; keep `u_char` (SYM: UCHAR).
 *      GENERAL LAW: a SHARED constant is a shared VARIABLE, not N local copies.
 *  (2) 🏆 EXPLICIT `else` ARM FOR THE `code = 0x24` DEFAULT (66 -> 59 -> 52).
 *      `u_char code = 0x24; if (P) code = 0x26;` hoists the `li 36` far above
 *      the guard and leaves the `beqz` delay slot EMPTY; the oracle has
 *      `beqz v0,T; li v1,36 [slot]; li v1,38`.  Writing it as
 *      `u_char code; if (P) code = 0x26; else code = 0x24;` puts the default in
 *      the slot (methodology sec.5.0c "EXPLICIT else").  SITE-SCOPED: only the
 *      two overlay sites (DRAWC.CPP :2362/:2404 here) win, -7 each; the other
 *      six 0x24 sites in this fn measure exactly neutral, so land per site.
 *  (3) 🏆 THE facetFlag RELOAD *AND* THE ff->facet_flag COPY ARE ONE TRADE
 *      (52 -> 36 -> 20).  The w70/w71/w72 receipts priced `int facetFlag` ALONE
 *      (kills the two `lhu` reloads, count 1388 = one SHORT) and the ff/copy
 *      device ALONE (adds the oracle's `addu t1,v1,zero`, count 1390 = one
 *      LONG) and rejected both.  They are HALVES OF THE SAME +-1: landed
 *      TOGETHER they are count-exact AND both classes vanish.  Per site:
 *        site1 (:2269 decl): `int facetFlag` + `facet_flag = ff;` followed by
 *              BOTH launders `("" : "=r"(facet_flag) : "0"(facet_flag))` and
 *              `("" : "=r"(ff) : "0"(ff))`  ... 4x4 device sweep, R/R and R/P
 *              tie at the minimum; every P-, Q- and S-form at site1 costs +20.
 *        site2 (:2440 decl): `int facetFlag` + the single `ff` launder.
 *      The two launders are the 20B zero-insn non-volatile form (catalog 20B):
 *      they only stop cse from collapsing `ff` and `facet_flag` into one pseudo,
 *      which is what deletes retail's `addu` copy.  NOT pins.
 *  (4) HOIST THE `facetFlag & 0x3f0` GUARD INTO ITS OWN TEMP (`int hi`) so the
 *      test's `andi` is scheduled BEFORE the ff->facet_flag copy and reorg
 *      back-fills the copy into the guard's `beqz` delay slot (20 -> 18 -> 16).
 *      ⚠️ site2 needs the R device for this to pay (Y2 alone = 115).
 * RE-PRICED AT 16 (law 21E-1, every number measured at this basin):
 *   - the id0/id1/id2 SPLIT morph (`idN = idN * 8; idN = idN + (int)sd;`) at
 *     :2459-2461: 206 / 196 / 186 single-leg, 216 all three -- the w72-a3
 *     STRONG floor verdict SURVIVES three basin changes.  Do not re-run.
 *   - `int facetFlag` alone at site1 = 47 @1388; the R device alone = 35 @1390
 *     (both the "one short / one long" halves of landing (3)).
 * ===== 🏆 W75-A7: BOTH RESIDUAL CLASSES CLOSED -- DrawC_Prim PASS 1389/1389,
 * source-side only (no build.py row of any kind; the PER_FN_TEXT_MOVES spec at
 * the end of this block is SUPERSEDED and must NOT be wired -- post-recompile
 * instruction rewrites are forbidden by user policy, 2026-08-23).  Two landings,
 * each re-tested for device removal (23B-3) and each necessary:
 *  (A) THE id-MORPH SPLIT x THE `i` REF-STEP -- ONE CELL, not two axes (23B-1).
 *      The split at the 5th site is what mints the oracle's in-place
 *      `sll $tN,$tN,3; addu $tN,$tN,$s1`; it was measured at 198/206/216 across
 *      FOUR waves and filed a STRONG floor because it costs each idN +2 mentions
 *      => +4 loop-weighted refs (12 -> 16), crossing the floor_log2 3 -> 4 step
 *      and lifting all three id allocnos ABOVE the fn-scope counter `i` in
 *      global.c:594's allocno_compare -- a one-seat rotation of the whole $t
 *      band.  Restoring `i` to the head of the order takes refs 55 -> >=64
 *      (5*63/829 = .380 < id2's .4183, 6*64/829 = .4632 > it), i.e. FIVE
 *      read-only fence operands at loop depth 1 (+2 each).  PREDICTED ==
 *      MEASURED: n=3 194, n=4 194, n=5 PASS, n=8 PASS, n=10 PASS.  Full
 *      allocsim receipt (MATCH 97/98, order-vs-dump IDENTICAL on both dumps) in
 *      scratchpad/w75/A7_alloc_{fused,split}.txt.  Removal test: fused morph
 *      + no fence = 12; split + no fence = 194.
 *  (B) THE LAUNDER POSITION IS THE DELAY-SLOT DIAL.  The copy-vs-`beqz` class
 *      below is NOT an inherent cost of the launder device -- it is a cost of
 *      WHERE the launder sits.  reorg.c:685 stop_search_p fires at ANY asm, so
 *      a launder standing between `facet_flag = ff` and the guard branch walls
 *      reorg's backward scan off from the copy and it eager-steals the
 *      following `srl` from the target thread instead.  Moving BOTH launders
 *      INSIDE the `if (hi != 0)` body keeps their cse-breaking job (the copy
 *      still survives) while clearing the scan path: 4 -> 0.  SITE-JOINT: the
 *      device must be applied at BOTH facetFlag sites (either site alone = 2).
 *      Falsified at this basin: launder before the copy (L3/L7) 34; a read-only
 *      fence instead (L8) 16; mixed forms 107-121 @1390.
 * ===== end W75-A7; the 16-diff analysis below is retained as the receipt =====
 * RESIDUAL 16 (as of W74) = TWO classes only, at an oracle-EXACT 1389 insns:
 *   - the id0/id1/id2 `sll v0,tN,3` shared scratch at the fused site (12 of 16)
 *     -- ours `sll v0,t9,3; addu t9,v0,s1`, retail in-place `sll t9,t9,3`.
 *     STRONG floor (see the re-price).  NAMED ANGLE: the only untried route is
 *     an in-place spelling that adds NO statement and NO pseudo -- e.g. a
 *     compound-assign chain `id0 *= 8, id0 += (int)sd;` (comma, one statement)
 *     or the W41 composite-RMW law applied via a 20B tied launder on idN
 *     between the two halves.  Everything statement-shaped explodes (>=186).
 *   - 🔴 THE COPY-vs-`beqz` DELAY SLOT at both facetFlag sites (4 of 16), and
 *     it is a DIRECT COST OF THE LAUNDER DEVICE.  Both streams are otherwise
 *     IDENTICAL here (`andi v1,a2,4095; andi v0,a2,1008` then the same three
 *     insns): retail puts `addu t1,v1,zero` in the `beqz v0,T` DELAY SLOT
 *     (reorg backward-fill from the insn immediately before the branch) and
 *     `srl v0,v1,4` after; ours emits `addu t1,v1,zero; beqz v0,T` and lets
 *     reorg steal `srl v0,v1,4` from the target instead.  MECHANISM (catalog
 *     22B-5): reorg's `stop_search_p` fires on ANY asm, and the zero-insn
 *     launder RTL sits between the copy and the branch, so the backward scan
 *     never reaches the copy.  We are trading these 4 for the 20+ that the
 *     launder buys -- a measured, not assumed, trade.
 *     FALSIFIED cures (measured at this basin): launder BEFORE the copy
 *     (`("" : "=r"(ff) : "0"(ff)); facet_flag = ff; ...`) 17 @1390 -- the
 *     pre-copy launder mints a real move; launder BETWEEN 131/180; moving the
 *     `ff` launder into the `if (hi)` body 17 @1390.  NAMED ANGLE: the copy
 *     must survive WITHOUT an asm insn standing between it and the guard --
 *     i.e. either a PER_FN_TEXT_MOVES row (spec below) or a non-asm
 *     cse-breaker for the `ff`/`facet_flag` pair.
 *     🔴 SUPERSEDED BY W75-A7 (B) ABOVE AND FORBIDDEN BY POLICY -- DO NOT WIRE.
 *     (The rows were built and measured this belt: 16 -> 12, brdist clean.  They
 *     were then REMOVED when the user's no-post-recompile-rewrite rule landed,
 *     and the source-side launder-position lever closed the same class for free.)
 *     PER_FN_TEXT_MOVES ROW SPEC (historical, 2 rows, one per site;
 *     they are position-identical so they must both be present and in file
 *     order -- each row's anchor is written against the text the previous row
 *     produced, catalog 21E-8: numeric registers only, and the `after`
 *     lookahead must NOT reference the taken lines):
 *       "recon/game/psx/drawc.cpp": { "DrawC_Prim__FP10matrixtdef...": [
 *         {"take": "\\taddu\\t\\$9,\\$3,\\$0\\n",
 *          "after": "\\tbeq\\t\\$2,\\$0,\\$L\\d+\\n", "slot": true,
 *          "drop_nop": false},
 *         ... same row again for the second site ... ] }
 *     (`$9`=t1=facet_flag, `$3`=v1=ff, `$2`=v0=the `andi 1008` result; the
 *     row MOVES the copy down into the branch's delay slot and lets the
 *     stolen `srl` fall back after it, which is exactly retail's stream.
 *     ⚠️ VERIFY the emitted cc1 `.s` register numbers before wiring -- read
 *     them off `scratch/rtl/drawc.s`, not off this comment.)
 */
void DrawC_Prim(matrixtdef *m,coorddef *t,Transformer_zObj *obj,Transformer_zOverlay *overlay,
               int envmap,Draw_CarCache *sd)

{
  COORD16 * Nvertice;
  /* w60-a7: the envmap-UV cursor is the TYPED `Draw_CarVertex *` walker, not a raw
     byte cursor -- the same shape DrawC_PrimMenu's identical loop was SEALED with this
     wave.  A `char *` walked `+ 8` is a BIV whose init is an ordinary source statement
     emitted in the preheader BEFORE loop.c runs; the typed walker lets loop.c fold both
     byte stores onto ONE address giv anchored at `.v`, ELIMINATE the biv, and emit that
     init in loop.c's giv group -- which is where retail has it.  Gate 338 -> 336 at an
     unchanged count (1395/1389); on a far-miss that delta is LCS noise, the STRUCTURE
     is the reason it is kept.  NOTE the same conversion applied to DrawC_PrimClip's
     twin loop measures 552 -> 566 (also count-unchanged) and was NOT landed -- re-probe
     it there after PrimClip's block-order work, per the lever-order law. */
  int i;

  /* The SYM has no distinct records for these four source-shaping identities.
     Each remains only because the detailed W53/W60/W75 receipts below measure
     a natural direct spelling as a different instruction/allocation stream.
     SYM-CODEGEN-CARRIER: envmapUV_dst
     SYM-CODEGEN-CARRIER: ff
     SYM-CODEGEN-CARRIER: hi
     SYM-CODEGEN-CARRIER: overlayRaw
     SYM-TYPE-OVERRIDE: facetFlag -- the SYM records SHORT, but a direct short
     declaration regresses PASS to 30 differences at 1391/1389; the current
     promoted int carrier preserves the retail lhu/sign-extension/allocation shape. */
  
  Nvertice = obj->Nvertex;
  /* field-fusion: ePmx0.{u0,v0,clut} contiguous 4-byte packed -- ONE lw each */
  if ((*(u_int *)&sd->ePmx0 == 0) && (*(u_int *)&sd->ePmx1 == 0)) {
    envmap = envmap & 0xbe;
  }
  /* MATCH (w53-a2, 360 -> 338): the envmap-UV loop rebuilt to DrawC_PrimMenu's
     PROVEN loop-1 shape (PrimMenu's loop-1 is byte-exact).  Three parts:
      (a) ONE `COORD16 *vt` cursor + a block-local t1/t2/t3 x,y,z triple, instead of
          the Ghidra two-cursor form (`psVar6` for x + `vert_yz_iter` for y/z read at
          [-1]/[0]).  Strength reduction then MINTS the y/z cursor itself as a giv
          (`addiu a1,s3,4`), and a giv is emitted AFTER the LICM movables in the loop
          preheader -- exactly where retail has it (the source-assigned
          `vert_yz_iter` was emitted BEFORE the `li -1`/`addiu 172`/`addiu 156`
          hoists).  It also lands `vt` on retail's $a3.
      (b) `vt = Nvertice;` hoisted ABOVE the two gte_Set*Matrix macros (the same edit
          that took PrimMenu 11 -> 9).
      (c) loop-1 and loop-2 SHARE one fn-scope counter (`i`; the dead
          `remVerts`/`ts9`/`ts6`/`vert_yz_iter` decls deleted), exactly as PrimMenu's
          SYM-verified single fn-scope `i` does.  -8 on its own.
     RESIDUAL in this block = a 3-way {counter,172-addr,156-addr} rotation: ours
     counter=$t0 172=$t2 156=$t1, retail counter=$t2 172=$t1 156=$t0 -- retail
     allocates the two LICM-hoisted gte addresses BEFORE the counter, ours after, so
     the counter needs LOWER allocno priority (longer live length or fewer refs).
     FALSIFIED: initialising the counter above the gte macros (drags the `lhu` above
     the ctc2 block, no gain).
     ⚠️ MEASURED NO-OP on DrawC_PrimClip -- the identical (a)+(b)+(c) port there is
     626 -> 626 with the same 28 diffs in the first 130 rows, so it was NOT landed;
     PrimClip keeps its two-cursor loop-1. */
  if ((envmap & 1U) != 0) {
    COORD16 *vt = Nvertice;
    Draw_CarVertex *envmapUV_dst;
gte_SetRotMatrix(&DrawC_gMatA);
gte_SetTransMatrix(&DrawC_gMatA);
    i = (int)obj->numVertex;
    envmapUV_dst = sd->tV;
    while( true ) {
      i = i - 1;
      if (i == -1) break;
      {
        short t1, t2, t3;
        t1 = vt->x;
        t2 = vt->y;
        t3 = vt->z;
        (sd->vt0).x = t1;
        (sd->vt0).y = t2;
        (sd->vt0).z = t3;
      }
gte_ldv0((char *)sd + 0xac);
      gte_rt();
gte_stlvnl((char *)sd + 0x9c);
      int v = (sd->tv).vz;
      int u = (sd->tv).vx;    /* int load (lw) -- oracle stores its low byte */
      if (v < 0) {
        v = -v;
      }
      vt = vt + 1;
      envmapUV_dst->u = (char)u;
      envmapUV_dst->v = (char)v;
      envmapUV_dst = envmapUV_dst + 1;
    }
  }
  TrsProj_SetTransPrecision(8);
  /* SYM {r0,r1,r2} row blocks (as in PrimClip) + Prim's row-1 mirror negate */
  {
    int r0 = m->m[0];
    int r1 = m->m[3];
    int r2 = m->m[6];
    (sd->matB).m[0][0] = (short)(r0 >> 4);
    (sd->matB).m[0][1] = (short)(r1 >> 4);
    (sd->matB).m[0][2] = (short)(r2 >> 4);
  }
  {
    int r0 = m->m[1];
    int r1 = m->m[4];
    int r2 = m->m[7];
    (sd->matB).m[1][0] = (short)(r0 >> 4);
    (sd->matB).m[1][1] = (short)(r1 >> 4);
    (sd->matB).m[1][2] = (short)(r2 >> 4);
  }
  {
    /* identity-then-tweak (PrimHalo/PrimMenu-proven, w39-a3): row 1 stored
       POSITIVE above, negated IN PLACE here.  matRow1_x/ts7/ts10 carriers
       lengthened the live ranges and rotated the SYM's per-block triples. */
    int r0 = m->m[2];
    int r1 = m->m[5];
    int r2 = m->m[8];
    (sd->matB).m[1][0] = -(sd->matB).m[1][0];
    (sd->matB).m[2][0] = (short)(r0 >> 4);
    (sd->matB).m[2][1] = (short)(r1 >> 4);
    (sd->matB).m[2][2] = (short)(r2 >> 4);
    (sd->matB).m[1][1] = -(sd->matB).m[1][1];
    (sd->matB).m[1][2] = -(sd->matB).m[1][2];
  }
  (sd->matB).t[0] = t->x >> (TrsProj_precision);
  (sd->matB).t[1] = -(t->y >> (TrsProj_precision));
  (sd->matB).t[2] = t->z >> (TrsProj_precision);
  TrsProj_ResetTransPrecision();
gte_SetRotMatrix(((char *)sd + 0x14));
gte_SetTransMatrix(((char *)sd + 0x14));
  /* w60-a7: the world->cache vertex copy is DrawC_PrimMenu's loop-2 verbatim (that
     twin is a sealed PASS this wave), i.e. ONE typed `Draw_CarVertex *` walker and
     ONE `COORD16 *`, with the y,z,x read order and x,y,z store order the SYM/oracle
     show.  It replaces SIX Ghidra-invented locals (an INT cursor tV_dst walked +8, a
     second short* cursor psVar12 walked +4, a third short* psVar6 walked +3 and the
     tu11/tu12/tu14 temps) with the two the SYM names.  Gate-NEUTRAL (336, count
     unchanged 1395/1389) -- landed for FAITHFULNESS and to unblock the next
     structural pass, not for the score: an explicit `+8` byte cursor is a BIV whose
     init is emitted before every loop.c hoist, while the typed walker's biv is
     eliminated into an address giv (the PrimMenu seal law, w60-a7). */
  {
  PCOORD16 *tV = (PCOORD16 *)sd->tV;
  COORD16 *vt = obj->vertex;

  i = (int)obj->numVertex;
  while( true ) {
    i = i + -1;
    if (i == -1) break;
    {
      short t1, t2, t3;

      t2 = vt->y;
      t3 = vt->z;
      t1 = vt->x;
      tV->x = t1;
      tV->y = t2;
      tV->z = t3;
    }
    vt = vt + 1;
    tV = tV + 1;
  }
  }
  i = (int)obj->numFacet;
  /* envmap&9 computed AT the switch -- the delay-slot filler pulls the andi
   * into the copy-loop guard's slot (v1 dead in the body), oracle 0x800C0490 */
  switch (envmap & 9) {
  case 0: {
    /* SYM per-case block (wave-9 lever); MAIN loop (envmap&2==0) rebuilt per the
     * oracle 0x800C004C.. and placed FIRST (oracle physical order: main, then alt
     * @0x800C0248 -- the bnez skips forward to the alt loop). */
    POLY_FT3 *prim;
    Transformer_zFacet *facet;
    int id0;
    int id1;
    int id2;
    if ((envmap & 2U) == 0) {
      while( true ) {
        i = i - 1;
        if (i == -1) {
          return;
        }
        facet = obj->facet + i;
        id0 = facet->vertexId0;
        id1 = facet->vertexId1;
        id2 = facet->vertexId2;
        if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
        /* SYM 3.8b: id0-2 morph index->address IN PLACE (one pseudo each);
         * oracle scales the id regs themselves (sll aN,aN,3; addu aN,aN,s1)
         * and keeps tV's 0xD0 in the lwc2 displacement.
         * ===== w64-a14 (2026-08-15): THE PrimMenu TRANSFER, 336 -> 174 =====
         * The multi-wave "Prim's id block is at its own optimum, do not port the
         * PrimClip/PrimMenu lever" verdict (w55-a9 338->426..450, w62-a14 336->448,
         * w63-a14 decl-scope 336 bit-identical) was BASIN-RELATIVE (04Z): every one
         * of those measurements was taken with the Ghidra byte-offset biv `iVar7`
         * still driving the facet loop.  Two ordered landings:
         *  (1) DROP THE BIV.  `iVar7 = facetIdx*0xc; ... iVar7 += -0xc;
         *      facet = (int)obj->facet + iVar7;` is a Ghidra invention -- the SYM
         *      lists exactly ONE fn-scope counter (`i`, REG $t2 INT) and a typed
         *      per-block `facet` (PTR Transformer_zFacet), NO byte offset.  Writing
         *      `facet = (int)(obj->facet + facetIdx)` lets loop.c strength-reduce
         *      the *12 into its own giv (retail's t1/t3 base + the `addiu t2,t2,-1`
         *      counter whose dec reorg steals into the guard's delay slot with the
         *      `addiu t2,t2,1` undo on the continue path -- exactly the shape
         *      DrawC_PrimMenu's identical loop is SEALED with).  336 -> 276 at an
         *      unchanged count, all 5 sites.  `int iVar7;` is then dead: removing
         *      the declaration is BIT-IDENTICAL (measured).
         *  (2) THEN the morph lever finally bites, PER SITE (measured individually
         *      from the 276 basin; the w55/w62 "all five at once" runs hid this):
         *        site 3 (SYM block line=261, ids t1/t0/a3 -- registers ALREADY
         *          retail-exact, only the scratch differed): the plain SPLIT
         *          `idN = idN*8; idN = idN + (int)sd;` -> in-place `sll t1,t1,3;
         *          addu t1,t1,s1`.  276 -> 264.
         *        sites 1,2,4 (SYM blocks 87/178/413, ids a2/a1/a0): split + the
         *          PrimMenu floor_log2 REF-STEP dial (do{}while(0) on id1's `+= sd`
         *          and on BOTH of id2's statements) reverses the allocno order
         *          id0,id1,id2 -> id2,id1,id0 = retail a2/a1/a0.  -30 EACH,
         *          strictly additive: 264 -> 234 -> 204 -> 174.
         *        site 5 (SYM block 554, ids t9/t8/t3): the split REGRESSES there
         *          (264 -> 448) and the PrimMenu dial too (436) -- left FUSED.
         *          NAMED ANGLE: that block is the only one whose ids land in the
         *          $t8/$t9 band, i.e. they are NOT the first-served qtys; price it
         *          with qtyprio/-dl before trying another dial.
         * Falsified from the 276 basin (all still count 1395/1389 unless noted):
         *   moving the three `lbu` loads BELOW the guard = 331 @1390 (it DOES buy
         *   5 of the +6 excess insns -- retail interleaves `lw v1,8(s1)` / facet /
         *   lbu id0,id1 / `lw v0,4(s1)` / lbu id2 / sltu -- but the LCS cost is
         *   worse at this basin; re-probe it after the remaining rotations);
         *   `int facetIdx` + `== -1` (SYM says INT) = bit-identical;
         *   `facet = (int)(obj->facet) + facetIdx*12` = bit-identical. */
        id0 = id0 * 8;
        id0 = id0 + (int)sd;
        id1 = id1 * 8;
        do { id1 = id1 + (int)sd; } while (0);
        do { id2 = id2 * 8; } while (0);
        do { id2 = id2 + (int)sd; } while (0);
        gte_ldVXY0m(*(u_int *)(id0 + 0xd0));
        gte_ldVZ0m(*(u_int *)(id0 + 0xd4));
        gte_ldVXY1m(*(u_int *)(id1 + 0xd0));
        gte_ldVZ1m(*(u_int *)(id1 + 0xd4));
        gte_ldVXY2m(*(u_int *)(id2 + 0xd0));
        gte_ldVZ2m(*(u_int *)(id2 + 0xd4));
        gte_rtpt();
        gte_nclip();
        gte_stMAC0m(sd->bfct);
        {
          int bfct = sd->bfct;
          if ((sd->head).mirror != 0) {
            bfct = -bfct;
          }
          if (bfct < 1) continue;
        }
        gte_avsz3();
        gte_stOTZm(sd->otz);
        sd->otz = sd->otz + sd->sub_otz;
        if (sd->otz < 0) continue;
        if (sd->sub_otSize < sd->otz) continue;
        DRAWC_OTLINK_FT3(sd, prim);
        gte_stsxy3_ft3(prim);
        {
          u_long color = sd->color;
          u_char code = 0x24;
          ((u_int *)prim)[1] = color;
          *(u_char *)((int)prim + 7) = code;
        }
        {
          Draw_tPixMap *pmx = sd->pmxStart + facet->textureIndex;
          if ((*(u_short *)((int)pmx + 0xe) & 0x7f) != 0) {
            u_char offsetU = sd->offsetU1;
            u_char offsetV = sd->offsetV1;
            if ((*(u_short *)((int)pmx + 0xe) & 2) != 0) {
              offsetU = sd->offsetU2;
              offsetV = sd->offsetV2;
            }
            {
              u_short clut = pmx->clut;
              u_short tpage = pmx->tpage;
              *(u_short *)((int)prim + 0xe) = clut;
              *(u_short *)((int)prim + 0x16) = tpage;
            }
            {
              u_char u0 = facet->uv0.u + offsetU;
              u_char u1 = facet->uv1.u + offsetU;
              u_char u2 = facet->uv2.u + offsetU;
              *(u_char *)((u_int *)prim + 3) = u0;
              *(u_char *)((u_int *)prim + 5) = u1;
              *(u_char *)((u_int *)prim + 7) = u2;
            }
            {
              u_char v0 = facet->uv0.v + offsetV;
              u_char v1 = facet->uv1.v + offsetV;
              u_char v2 = facet->uv2.v + offsetV;
              *(u_char *)((int)prim + 0xd) = v0;
              *(u_char *)((int)prim + 0x15) = v1;
              *(u_char *)((int)prim + 0x1d) = v2;
            }
          }
          else {
            u_short clut = pmx->clut;
            u_short tpage = pmx->tpage;
            u_short uv0;
            u_short uv1;
            u_short uv2;
            *(u_short *)((int)prim + 0xe) = clut;
            *(u_short *)((int)prim + 0x16) = tpage;
            uv0 = *(u_short *)&facet->uv0;
            uv1 = *(u_short *)&facet->uv1;
            uv2 = *(u_short *)&facet->uv2;
            *(u_short *)((u_int *)prim + 3) = uv0;
            *(u_short *)((u_int *)prim + 5) = uv1;
            *(u_short *)((u_int *)prim + 7) = uv2;
          }
        }
      }
    }
    /* ALT loop (envmap&2 set; oracle 0x800C0248..0x800C045C): same skeleton as
     * the main loop -- FT3 self-loading link, code byte 0x24/0x26 by facet
     * flag&1, byte-UV path uses offsetU0/V0, halfword path when flag&1.
     * Sibling block redeclares the SYM names (fresh pseudos, wave-9 lever). */
    {
      POLY_FT3 *prim;
      Transformer_zFacet *facet;
      int id0;
      int id1;
      int id2;
      while( true ) {
        i = i - 1;
        if (i == -1) {
          return;
        }
        facet = obj->facet + i;
        id0 = facet->vertexId0;
        id1 = facet->vertexId1;
        id2 = facet->vertexId2;
        if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
        /* SYM 3.8b: id0-2 morph index->address in place (oracle sll aN,aN,3) */
        id0 = id0 * 8;
        id0 = id0 + (int)sd;
        id1 = id1 * 8;
        do { id1 = id1 + (int)sd; } while (0);
        do { id2 = id2 * 8; } while (0);
        do { id2 = id2 + (int)sd; } while (0);
        gte_ldVXY0m(*(u_int *)(id0 + 0xd0));
        gte_ldVZ0m(*(u_int *)(id0 + 0xd4));
        gte_ldVXY1m(*(u_int *)(id1 + 0xd0));
        gte_ldVZ1m(*(u_int *)(id1 + 0xd4));
        gte_ldVXY2m(*(u_int *)(id2 + 0xd0));
        gte_ldVZ2m(*(u_int *)(id2 + 0xd4));
        gte_rtpt();
        gte_nclip();
        gte_stMAC0m(sd->bfct);
        {
          int bfct = sd->bfct;
          if ((sd->head).mirror != 0) {
            bfct = -bfct;
          }
          if (bfct < 1) continue;
        }
        gte_avsz3();
        gte_stOTZm(sd->otz);
        sd->otz = sd->otz + sd->sub_otz;
        if (sd->otz < 0) continue;
        if (sd->sub_otSize < sd->otz) continue;
        DRAWC_OTLINK_FT3(sd, prim);
        gte_stsxy3_ft3(prim);
        {
          u_long color = sd->color;
          u_char code = 0x24;
          if (((u_short)facet->flag & 1) != 0) {
            code = 0x26;
          }
          ((u_int *)prim)[1] = color;
          *(u_char *)((int)prim + 7) = code;
        }
        if (((u_short)facet->flag & 1) == 0) {
          Draw_tPixMap *pmx = sd->pmxStart + facet->textureIndex;
          u_char offsetU = sd->offsetU0;
          u_char offsetV = sd->offsetV0;
          {
            u_short clut = pmx->clut;
            u_short tpage = pmx->tpage;
            *(u_short *)((int)prim + 0xe) = clut;
            *(u_short *)((int)prim + 0x16) = tpage;
          }
          {
            u_char u0 = facet->uv0.u + offsetU;
            u_char u1 = facet->uv1.u + offsetU;
            u_char u2 = facet->uv2.u + offsetU;
            *(u_char *)((u_int *)prim + 3) = u0;
            *(u_char *)((u_int *)prim + 5) = u1;
            *(u_char *)((u_int *)prim + 7) = u2;
          }
          {
            u_char v0 = facet->uv0.v + offsetV;
            u_char v1 = facet->uv1.v + offsetV;
            u_char v2 = facet->uv2.v + offsetV;
            *(u_char *)((int)prim + 0xd) = v0;
            *(u_char *)((int)prim + 0x15) = v1;
            *(u_char *)((int)prim + 0x1d) = v2;
          }
        }
        else {
          Draw_tPixMap *pmx = sd->pmxStart + facet->textureIndex;
          u_short clut = pmx->clut;
          u_short tpage = pmx->tpage;
          u_short uv0;
          u_short uv1;
          u_short uv2;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
          uv0 = *(u_short *)&facet->uv0;
          uv1 = *(u_short *)&facet->uv1;
          uv2 = *(u_short *)&facet->uv2;
          *(u_short *)((u_int *)prim + 3) = uv0;
          *(u_short *)((u_int *)prim + 5) = uv1;
          *(u_short *)((u_int *)prim + 7) = uv2;
        }
      }
    }
  }
    break;
  case 1: {
    /* SYM per-case block: literal repeated SYM names redeclared (wave-9 lever);
     * loop rebuilt as while+continue per the oracle (0x800C0460..0x800C08D8). */
    POLY_FT3 *prim;
    Transformer_zFacet *facet;
    int id0;
    int id1;
    int id2;
    while( true ) {
      i = i - 1;
      if (i == -1) {
        return;
      }
      facet = obj->facet + i;
      id0 = facet->vertexId0;
      id1 = facet->vertexId1;
      id2 = facet->vertexId2;
      if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
      /* SYM 3.8b: id0-2 morph index->address in place (oracle sll aN,aN,3) */
      id0 = id0 * 8; id0 = id0 + (int)sd;
      id1 = id1 * 8; id1 = id1 + (int)sd;
      id2 = id2 * 8; id2 = id2 + (int)sd;
      gte_ldVXY0m(*(u_int *)(id0 + 0xd0));
      gte_ldVZ0m(*(u_int *)(id0 + 0xd4));
      gte_ldVXY1m(*(u_int *)(id1 + 0xd0));
      gte_ldVZ1m(*(u_int *)(id1 + 0xd4));
      gte_ldVXY2m(*(u_int *)(id2 + 0xd0));
      gte_ldVZ2m(*(u_int *)(id2 + 0xd4));
      gte_rtpt();
      gte_nclip();
      gte_stMAC0m(sd->bfct);
      {
        int bfct = sd->bfct;
        if ((sd->head).mirror != 0) {
          bfct = -bfct;
        }
        if (bfct < 1) continue;
      }
      gte_stSXY0m(sd->dvx0);
      gte_stSXY1m(sd->dvx1);
      gte_stSXY2m(sd->dvx2);
      gte_avsz3();
      gte_stOTZm(sd->otz);
      sd->otz = sd->otz + sd->sub_otz;
      if (sd->otz < 0) continue;
      if (sd->sub_otSize < sd->otz) continue;
      if ((((u_short)facet->flag & 0x3f3) != 0) && (*(int *)&sd->ePmx1 != 0)) {
        {
          short *z = (short *)(Nvertice + facet->vertexId0);
          short t1 = z[0];
          short t2 = z[1];
          short t3 = z[2];
          (sd->vt0).x = t1;
          (sd->vt0).y = t2;
          (sd->vt0).z = t3;
        }
        {
          short *z = (short *)(Nvertice + facet->vertexId1);
          short t1 = z[0];
          short t2 = z[1];
          short t3 = z[2];
          (sd->vt1).x = t1;
          (sd->vt1).y = t2;
          (sd->vt1).z = t3;
        }
        {
          short *z = (short *)(Nvertice + facet->vertexId2);
          short t1 = z[0];
          short t2 = z[1];
          short t3 = z[2];
          (sd->vt2).x = t1;
          (sd->vt2).y = t2;
          (sd->vt2).z = t3;
        }
        DRAWC_OTLINK_MODE(sd, "84", "88", "92");
        DRAWC_OTLINK_FT3(sd, prim);
        DRAWC_OTLINK_MODE(sd, "72", "76", "80");
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          ((u_int *)prim)[2] = xy0;
          ((u_int *)prim)[4] = xy1;
          ((u_int *)prim)[6] = xy2;
        }
        ((u_int *)prim)[1] = sd->eColor0;
        *(u_char *)((int)prim + 7) = 0x26;
        {
          u_short clut = (sd->ePmx1).clut;
          u_short tpage = (sd->ePmx1).tpage;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
        }
        DRAWC_UVTINT_VT(sd, prim);
      }
      if (*(int *)&sd->ePmx0 != 0) {
        DRAWC_OTLINK_FT3(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          ((u_int *)prim)[2] = xy0;
          ((u_int *)prim)[4] = xy1;
          ((u_int *)prim)[6] = xy2;
        }
        ((u_int *)prim)[1] = sd->eColor0;
        *(u_char *)((int)prim + 7) = 0x26;
        {
          u_short clut = (sd->ePmx0).clut;
          u_short tpage = (sd->ePmx0).tpage;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
        }
        {
          u_char u = (sd->ePmx0).u0 + 0x40;
          u_char v = (sd->ePmx0).v0;
          /* ===== w44-a8 RE-AIM: THE TINT-REGISTER PREMISE, RE-MEASURED =====
             VERDICT: BOTH readings are right, PER BLOCK -- the discriminator is
             whether the SYM names the u/v locals in that block.
              * SYM block @800c0248-0474 (the facet-uv arm, `u0/u1/u2 + v0/v1/v2`)
                DOES declare `u` = `Def class REG $00000005` and `v` = `$00000006`
                => $a1/$a2, and the oracle @800C03B8 is literally
                `lbu $a1,0x3EE($s1); lbu $a2,0x3EF($s1)` with the per-vertex
                bytes in $v0/$v1/$a0.  That block already matches.
              * SYM blocks @800c0588-076c and @800c077c-0840 (the tV/ePmx tint
                arms -- THIS block and its `(char)(sd->vtN).y/.z` sibling) declare
                NO u/v at all (only xy0-2 / color / code / clut / tpage).  Their
                temps are ANONYMOUS cc1 temps, and retail put them in the
                $t4-$t7 band (oracle @800C0710 and @800C07EC).  So the "$t4-$t7 =
                template scratch only" correction does NOT apply here: the OT-link
                template scratches $t4-$t6 AND the tint temps live there, because
                they are dead across the link.
             MEASUREMENTS THIS WAVE (base Prim 746 / PrimClip 857):
              * chunkdiff: the FOUR largest mismatched runs (167 insns, incl. ALL
                +11 excess nops) are these tint blocks and nothing else.  Cracking
                the register class is the whole Prim/PrimClip residual.
              * writing the tint add INLINE (no named u/v, per the SYM's silence)
                -- cse did NOT fold: +12 insns, 758/869.  FALSIFIED.
              * pair conversion of the `(char)(sd->vtN).y/.z` sites: 1403->1394 and
                opcode-sequence-identical to retail, but posdiff STRUCTURAL residual
                also rises 399->429 and the gate goes 746->1507.  Still not landable.
              * DROPPING $t4/$t5/$t6 from the FT3 template's clobber list: ZERO
                change (746, same 1403).  The clobbers are NOT what pushes the tint
                temps out of the $t band -- they only bar live-ACROSS values, and
                these die before the next link.  FALSIFIED.
              * `"=&r"` OUTPUT SUSPECT: FALSIFIED for both fns.  Converting EVERY
                DRAWC_OTLINK_FT3 to the compiler-loaded split form (prim loaded by
                plain C, FT3B does the tail -- i.e. no compiler-allocated asm
                output at all) leaves Prim byte-identical (746 / 1403) and costs
                PrimClip +14 (857->871).  The DivideShadowPrim precedent does not
                transfer here.
              * w44-a4's do{}while(0) LOOP_BEG/END reweighting relay: wrapping
                DRAWC_OTLINK_FT3 in do{}while(0) is a NO-OP for Prim (746) and
                -14 worse for PrimClip (871).  The mechanism needs a C body with
                pseudos to reweight; our OT link is a bare asm template, so no
                LOOP notes and no refs to reweight.  FALSIFIED for drawc.
             NEW NAMED ANGLE (next pass): the class is DOWNSTREAM of the global
             allocnos, not of the tint block itself.  In retail's tint block the
             live set is sd=$s1, prim=$a1, id0=$t1, id1=$t0, id2=$a3, facet=$a2 --
             i.e. the WHOLE $v0/$v1/$a0..$a3 band is spoken for and the anonymous
             tint temps get the first free pair above it ($t4-$t7).  In ours the ids
             sit in $t0-$t2 and prim in $a2, leaving $a0/$a1/$v0/$v1 free, so the
             tint temps take them.  => attack the ID/PRIM placement first (make id2
             land in $a3 and facet in $a2), and the tint band follows for free.
             Instruments: prio.py/-dg on the ids+facet+prim allocnos; the id-morph
             statements (`id0 = id0*8; id0 = id0 + (int)sd;`) are the ref/live dial.
             ===== end w44-a8 =====
             ===== w45-a4 STATUS: Prim (746 / 1403 vs 1389) and PrimClip
             (857 / 1892 vs 1877) were NOT re-attacked this wave -- the wave's
             budget went to the six smaller drawc fns, four of which cracked
             on ONE lever family: VARIABLE IDENTITY (which named C local holds
             which value / how many distinct block-local temps a sequential
             read-run gets).  Receipts: NightHeadlight 69->36 (one reused
             subtrahend temp -> three block-local h0/h1/h2 solved the whole
             a0/a1/a2 rotation INCLUDING the missing REGPARM copy),
             ShowroomPrims 93->4 (three counters that Ghidra had called i/j
             are all retail's `index`; the tick is `j` with an anonymous /256),
             PrimStart 102->86 (a fused `-0x16` split into its own pseudo),
             PrimMenu residual = a clean id0/id2/overlayFlag 3-cycle.
             => THE RECOMMENDED NEXT ATTACK ON Prim/PrimClip IS THE SAME LENS,
             not another asm-template or clobber experiment: their ~60 flat
             fn-scope locals are still Ghidra names (iVar7/iVar8/uVar10/
             psVar6/psVar12/tp1..tp20/...).  The w44-a8 angle (make id2 land
             in $a3 and facet in $a2, then the tint band follows) is exactly
             a variable-identity problem: id0/id1/id2 have identical refs and
             monotonically increasing live lengths, so allocno_compare ranks
             id0 FIRST and it steals the low reg, while retail ranks them in
             REVERSE (longest-lived first = local_alloc's qty_compare_1).  See
             the parallel receipt in DrawC_PrimMenu, which is the same 3-cycle
             in a 480-insn function and is therefore the cheap proving ground:
             crack PrimMenu's ids first, then transcribe to Prim/PrimClip.
             LEAD (w38-a3, MEASURED, NOT APPLIED -- see the block comment at the top of
             DrawC_Prim): this 6-statement u/v block and its `(char)(sd->vtN).y/.z`
             sibling are the SOLE source of the +21 (Prim) / +17 (PrimClip) EXCESS
             NOPS.  Each statement loads one byte and immediately consumes it, so
             every `lbu` eats a load-delay nop; the oracle runs TWO parallel chains
             (`lbu t4,..; lbu t5,..; addu t4,t4,t6; sb t4,..; addu t5,t5,t7; sb t5,..`)
             where the second load fills the first's delay slot.  Rewriting each
             vertex as a PAIR of named temps (c0/c1 loaded, then both stored)
             removes 19 insns from Prim (1413->1394 vs oracle 1389) and 16 from
             PrimClip (1902->1886 vs 1877) -- but it RAISES the LCS diff count
             (790->843, 867->1083) because the surrounding saved-register colouring
             and the 8-byte frame excess are still wrong, so the aligner re-anchors.
             Apply it as part of a full block-scope/frame rewrite, not on its own.
             RE-MEASURED w39-a3 2026-08-01 on the post-matB-fix baseline (Prim 756):
             converting BOTH of Prim's ePmx0/ePmx1 tint blocks to per-vertex named
             pairs (cu0/cv0 .. cu2/cv2 loaded, then stored) gives 1413 -> 1394 insns
             (5 over oracle instead of 24) but 756 -> 1507 diffs.
             w40-a3 SPLIT THE LANDING -- the two tint FORMS behave differently:
               (a) the `*(u_char *)(idN + 0xd6/0xd7)` id-morph form (this block, 4
                   sites across Prim+PrimClip): per-vertex BLOCK-SCOPED pairs are a
                   STRICT WIN on both metrics -- Prim 756->746 (1413->1403 insns),
                   PrimClip 867->857 (1902->1892).  LANDED.
               (b) the `(char)(sd->vtN).y/.z` form (4 more sites): pairs bring the
                   insn count to 1394/1886 (5 and 9 over) AND the emitted block is
                   then COUNT-EXACT and offset-exact against the oracle -- verified
                   line-by-line with tools/side_by_side.py: ours
                     lbu a0,116; lbu a1,117; lbu a2,132; lbu v0,174; lbu v1,176;
                     addiu a0,a0,64; addu v0,v0,a0; addu a1,a1,a2; addu v1,v1,a1;
                     sb v0,12(a3); sb v1,13(a3); ...
                   vs retail's identical stream in $t4-$t7.  ONLY the register class
                   differs (retail uses the $t4-$t7 band, we use $a0-$a2/$v0/$v1) plus
                   a 1-slot addu/sb interleave.  But the LCS aligner re-anchors the
                   whole switch and the gate reads 746->1507 / 857->2073.  NOT landed:
                   it is a pure colouring residual now, so it should go in together
                   with whatever moves those five temps into the $t-band.  Frame and
                   prologue colouring are ALREADY correct for both fns (Prim 56/56 +
                   exact prologue, PrimClip 80/80), so the old "needs the frame fix
                   first" note is STALE -- what is left is the $a/$v-vs-$t class. */
          /* idN are morphed addresses: tV[id].u/v = 0xd6/0xd7(idN) (oracle t9/t8/t3) */
          DRAWC_UVTINT_ID(sd, prim, id0, id1, id2);
        }
      }
      DRAWC_OTLINK_FT3(sd, prim);
      {
        long xy0 = *(long *)&sd->dvx0;
        long xy1 = *(long *)&sd->dvx1;
        long xy2 = *(long *)&sd->dvx2;
        ((u_int *)prim)[2] = xy0;
        ((u_int *)prim)[4] = xy1;
        ((u_int *)prim)[6] = xy2;
      }
      {
        u_long color = sd->color;
        u_char code = 0x24;
        ((u_int *)prim)[1] = color;
        *(u_char *)((int)prim + 7) = code;
      }
      {
        Draw_tPixMap *pmx = sd->pmxStart + facet->textureIndex;
        u_short clut = pmx->clut;
        u_short tpage = pmx->tpage;
        u_short uv0;
        u_short uv1;
        u_short uv2;
        *(u_short *)((int)prim + 0xe) = clut;
        *(u_short *)((int)prim + 0x16) = tpage;
        uv0 = *(u_short *)&facet->uv0;
        uv1 = *(u_short *)&facet->uv1;
        uv2 = *(u_short *)&facet->uv2;
        *(u_short *)((u_int *)prim + 3) = uv0;
        *(u_short *)((u_int *)prim + 5) = uv1;
        *(u_short *)((u_int *)prim + 7) = uv2;
      }
    }
  }
  case 8: {
    /* SYM per-case block: literal repeated SYM names redeclared (wave-9 lever);
     * loop rebuilt as while+continue per the oracle (0x800C08DC..0x800C0C58,
     * tails cfLbl1/3 + otStitch24 inlined at their oracle position). */
    POLY_FT3 *prim;
    int overlayFlag;
    int overlayRaw;
    int facetFlag;
    Transformer_zFacet *facet;
    int id0;
    int id1;
    int id2;
    int facet_flag;
    int sd_otz;
    while( true ) {
      i = i - 1;
      if (i == -1) {
        return;
      }
      facet = obj->facet + i;
      id0 = facet->vertexId0;
      id1 = facet->vertexId1;
      id2 = facet->vertexId2;
      if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
      /* SYM 3.8b: id0-2 morph index->address in place (oracle sll aN,aN,3) */
      id0 = id0 * 8;
      id0 = id0 + (int)sd;
      id1 = id1 * 8;
      do { id1 = id1 + (int)sd; } while (0);
      do { id2 = id2 * 8; } while (0);
      do { id2 = id2 + (int)sd; } while (0);
      gte_ldVXY0m(*(u_int *)(id0 + 0xd0));
      gte_ldVZ0m(*(u_int *)(id0 + 0xd4));
      gte_ldVXY1m(*(u_int *)(id1 + 0xd0));
      gte_ldVZ1m(*(u_int *)(id1 + 0xd4));
      gte_ldVXY2m(*(u_int *)(id2 + 0xd0));
      gte_ldVZ2m(*(u_int *)(id2 + 0xd4));
      gte_rtpt();
      gte_nclip();
      gte_stMAC0m(sd->bfct);
      {
        int bfct = sd->bfct;
        if ((sd->head).mirror != 0) {
          bfct = -bfct;
        }
        if (bfct < 1) continue;
      }
      gte_avsz3();
      gte_stOTZm(sd->otz);
      /* raw<<16 kept live: the facetFlag<0 rescale is sra 24 of the SAME shifted
       * value (oracle lhu; sll 16; sra 16 ... sra 24 -- single table read) */
      overlayRaw = (u_short)DrawC_gOverlay[facet->textureIndex]; overlayRaw = overlayRaw << 0x10;
      overlayFlag = overlayRaw >> 0x10;
      if (overlayFlag != 0) {
        facetFlag = facet->flag;
        sd_otz = sd->otz;
        overlayFlag = overlayFlag & 0xff;
        if (facetFlag < 0) {
          overlayFlag = overlayRaw >> 0x18;
        }
        sd_otz = sd_otz + sd->sub_otz;
        if ((overlayFlag & 0x40) != 0) {
          sd_otz = sd_otz - 2;
        }
        if (sd_otz < 0) continue;
        if (sd->sub_otSize < sd_otz) continue;
        {
          /* two pseudos: ff computed (v1), facet_flag the live copy (t1) --
           * oracle andi v1,4095; addu t1,v1,zero; srl v0,v1,4 */
          int ff = facetFlag & 0xfff; int hi = facetFlag & 0x3f0;
          facet_flag = ff;
          if (hi != 0) {
            /* W75-A7: BOTH launders moved INSIDE the guard body -- see the
             * receipt above DrawC_Prim.  They still stop cse collapsing
             * ff/facet_flag (so retail's `addu $9,$3,$0` copy survives), but
             * they no longer stand BETWEEN that copy and the `beqz`, so
             * reorg.c:685 stop_search_p lets the backward scan reach the copy
             * and fill the guard's delay slot with it -- retail's stream. */
            __asm__("" : "=r"(facet_flag) : "0"(facet_flag)); __asm__("" : "=r"(ff) : "0"(ff));
            overlayFlag = overlayFlag & ((u_int)ff >> 4);
          if (overlayFlag != 0) {
            while ((overlayFlag & 3) == 0) {
              overlayFlag = overlayFlag >> 2;
            }
          }
          }
        }
        sd->otz = sd_otz;
      }
      else {
        sd->otz = sd->otz + sd->sub_otz;
        if (sd->otz < 0) continue;
        if (sd->sub_otSize < sd->otz) continue;
        facet_flag = (u_short)facet->flag & 0xfff;
      }
      if ((overlayFlag & 3) != 0) {
        /* SYM block {index,which,facetOverlay} -- FT3B overlay variant */
        int index = facet->textureIndex;
        int which = (overlayFlag & 3) - 1;
        Transformer_zOverlay *facetOverlay = overlay + (index * 3 + which);
        prim = (POLY_FT3 *)(sd->head).cprim.PrimPtr;
        DRAWC_OTLINK_FT3B(sd, prim);
        gte_stsxy3_ft3(prim);
        {
          u_long color = 0x808080;
          u_char code;
          if ((overlayFlag & 0x80) == 0) {
            color = sd->color;
          }
          if ((facet_flag & 1) != 0) {
            code = 0x26;
          } else { code = 0x24; }
          ((u_int *)prim)[1] = color;
          *(u_char *)((int)prim + 7) = code;
        }
        {
          Draw_tPixMap *pmx = sd->pmxStart + (facet->textureIndex + facetOverlay->offset);
          u_char u = facetOverlay->u;
          u_char v = facetOverlay->v;
          u_short clut = pmx->clut;
          u_short tpage = pmx->tpage;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
          {
            u_char u0 = facet->uv0.u + u;
            u_char u1 = facet->uv1.u + u;
            u_char u2 = facet->uv2.u + u;
            *(u_char *)((u_int *)prim + 3) = u0;
            *(u_char *)((u_int *)prim + 5) = u1;
            *(u_char *)((u_int *)prim + 7) = u2;
          }
          {
            u_char v0 = facet->uv0.v + v;
            u_char v1 = facet->uv1.v + v;
            u_char v2 = facet->uv2.v + v;
            *(u_char *)((int)prim + 0xd) = v0;
            *(u_char *)((int)prim + 0x15) = v1;
            *(u_char *)((int)prim + 0x1d) = v2;
          }
        }
      }
      else {
        prim = (POLY_FT3 *)(sd->head).cprim.PrimPtr;
        DRAWC_OTLINK_FT3B(sd, prim);
        gte_stsxy3_ft3(prim);
        {
          u_long color = 0x808080;
          u_char code;
          if ((overlayFlag & 0x80) == 0) {
            color = sd->color;
          }
          if ((facet_flag & 1) != 0) {
            code = 0x26;
          } else { code = 0x24; }
          ((u_int *)prim)[1] = color;
          *(u_char *)((int)prim + 7) = code;
        }
        {
          Draw_tPixMap *pmx = sd->pmxStart + facet->textureIndex;
          u_short clut = pmx->clut;
          u_short tpage = pmx->tpage;
          u_short uv0;
          u_short uv1;
          u_short uv2;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
          uv0 = *(u_short *)&facet->uv0;
          uv1 = *(u_short *)&facet->uv1;
          uv2 = *(u_short *)&facet->uv2;
          *(u_short *)((u_int *)prim + 3) = uv0;
          *(u_short *)((u_int *)prim + 5) = uv1;
          *(u_short *)((u_int *)prim + 7) = uv2;
        }
      }
    }
  }
  case 9: {
    /* SYM per-case block: literal repeated SYM names redeclared (wave-9 lever);
     * loop rebuilt as while+continue per the oracle (0x800C0C5C..0x800C12C8,
     * tails cfLbl2/4 + ePmx1UVEmit inlined at their oracle position). */
    POLY_FT3 *prim;
    int overlayFlag;
    int overlayRaw;
    int facetFlag;
    Transformer_zFacet *facet;
    int id0;
    int id1;
    int id2;
    int facet_flag;
    int sd_otz;
    u_char code = 0x26;
    while( true ) {
      i = i - 1;
      if (i == -1) {
        return;
      }
      facet = obj->facet + i;
      id0 = facet->vertexId0;
      id1 = facet->vertexId1;
      id2 = facet->vertexId2;
      if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
      /* SYM 3.8b: id0-2 morph index->address IN PLACE (oracle sll aN,aN,3).
       * ===== W75-A7: THE SPLIT + A PRICED floor_log2 REF-STEP ON `i` =====
       * The SPLIT (`idN = idN * 8; idN = idN + (int)sd;`) is what makes cc1
       * emit the oracle's in-place `sll tN,tN,3; addu tN,tN,$s1` -- the fused
       * form borns a fresh pseudo for the shift and gives `sll $v0,tN,3`.
       * The split alone measured 198 across FOUR waves (w55 448 / w62 / w63 /
       * w72 "STRONG floor" / w74 "do not re-run") because it costs each idN
       * +2 mentions => +4 loop-weighted REG_N_REFS (12 -> 16), which crosses
       * the floor_log2 step 3 -> 4 and lifts all three id allocnos ABOVE the
       * fn-scope counter `i` in global.c's allocno_compare -- rotating the
       * whole $t band by one seat (i $t2 -> $t9, id0 $t9 -> $t8, ...).
       * PROVEN, not probed (gcc-2.8.1 global.c:594, allocsim/-dg receipt in
       * scratchpad/w75/A7_alloc_{fused,split}.txt, model MATCH 97/98 and
       * order-vs-dump IDENTICAL on both dumps):
       *     pri = floor_log2(refs)*refs / live * 10000 * size
       *   fused  i p149 55/829 = .3317 > id2 p562 12/153 = .2352
       *                                > id1 p561 12/156 = .2307
       *                                > id0 p560 12/157 = .2292   (retail)
       *   split  id2 .4183 > id1 .4102 > id0 .4076 > i .3317       (rotated)
       * CURE = give `i` enough refs to re-take the head of the order.  The
       * what-if ladder says the crossing is at refs >= 64 (floor_log2 5 -> 6:
       * 5*63/829 = .380 < .4183, but 6*64/829 = .4632 > .4183), i.e. +9 over
       * 55.  This loop is depth 1, so flow.c weights each mention x2 => FIVE
       * read-only fence operands (+10 -> 65) and not four (+8 -> 63).
       * PREDICTED == MEASURED: n=3 194, n=4 194, n=5 PASS, n=8/n=10 PASS.
       * The fence is the 21A(1) read-only form: zero-insn (count stays
       * oracle-EXACT 1389) and it adds refs WITHOUT the identity launder's
       * extra copy (23B-2).  POSITION is a separate dial and was swept: at
       * the loop head (after `i = i - 1;`) or just after `facet = ...` it
       * costs a real insn (1390: it walls off a delay-slot fill) -- only the
       * two placements bracketing the morph block are free; this one and the
       * before-morph twin both PASS at n>=5.  Everything statement-shaped
       * without the ref-step still explodes (>=186), which is exactly why the
       * four earlier waves read this as a floor: they priced the SPLIT axis
       * alone and never the (split x `i`-refs) CELL (catalog 23B-1). */
      id0 = id0 * 8;
      id0 = id0 + (int)sd;
      id1 = id1 * 8;
      id1 = id1 + (int)sd;
      id2 = id2 * 8;
      id2 = id2 + (int)sd;
      __asm__("" : : "r"(i),"r"(i),"r"(i),"r"(i),"r"(i));
      gte_ldVXY0m(*(u_int *)(id0 + 0xd0));
      gte_ldVZ0m(*(u_int *)(id0 + 0xd4));
      gte_ldVXY1m(*(u_int *)(id1 + 0xd0));
      gte_ldVZ1m(*(u_int *)(id1 + 0xd4));
      gte_ldVXY2m(*(u_int *)(id2 + 0xd0));
      gte_ldVZ2m(*(u_int *)(id2 + 0xd4));
      gte_rtpt();
      gte_nclip();
      gte_stMAC0m(sd->bfct);
      {
        int bfct = sd->bfct;
        if ((sd->head).mirror != 0) {
          bfct = -bfct;
        }
        if (bfct < 1) continue;
      }
      gte_stSXY0m(sd->dvx0);
      gte_stSXY1m(sd->dvx1);
      gte_stSXY2m(sd->dvx2);
      gte_avsz3();
      gte_stOTZm(sd->otz);
      /* raw<<16 kept live: the facetFlag<0 rescale is sra 24 of the SAME shifted
       * value (oracle lhu; sll 16; sra 16 ... sra 24 -- single table read) */
      overlayRaw = (u_short)DrawC_gOverlay[facet->textureIndex]; overlayRaw = overlayRaw << 0x10;
      overlayFlag = overlayRaw >> 0x10;
      if (overlayFlag != 0) {
        facetFlag = facet->flag;
        sd_otz = sd->otz;
        overlayFlag = overlayFlag & 0xff;
        if (facetFlag < 0) {
          overlayFlag = overlayRaw >> 0x18;
        }
        sd_otz = sd_otz + sd->sub_otz;
        if (sd_otz < 0) continue;
        if (sd->sub_otSize < sd_otz) continue;
        {
          /* two pseudos: ff computed (v1), facet_flag the live copy (t1) --
           * oracle andi v1,4095; addu t1,v1,zero; srl v0,v1,4 */
          int ff = facetFlag & 0xfff; int hi = facetFlag & 0x3f0;
          facet_flag = ff;
          if (hi != 0) {
            /* W75-A7: BOTH launders moved INSIDE the guard body -- see the
             * receipt above DrawC_Prim.  They still stop cse collapsing
             * ff/facet_flag (so retail's `addu $9,$3,$0` copy survives), but
             * they no longer stand BETWEEN that copy and the `beqz`, so
             * reorg.c:685 stop_search_p lets the backward scan reach the copy
             * and fill the guard's delay slot with it -- retail's stream. */
            __asm__("" : "=r"(facet_flag) : "0"(facet_flag)); __asm__("" : "=r"(ff) : "0"(ff));
            overlayFlag = overlayFlag & ((u_int)ff >> 4);
          if (overlayFlag != 0) {
            while ((overlayFlag & 3) == 0) {
              overlayFlag = overlayFlag >> 2;
            }
          }
          }
        }
        sd->otz = sd_otz;
      }
      else {
        sd->otz = sd->otz + sd->sub_otz;
        if (sd->otz < 0) continue;
        if (sd->sub_otSize < sd->otz) continue;
        facet_flag = (u_short)facet->flag & 0xfff;
      }
      if (((facet_flag & 0x3f3) != 0) && (*(int *)&sd->ePmx1 != 0)) {
        {
          short *z = (short *)(Nvertice + facet->vertexId0);
          short t1 = z[0];
          short t2 = z[1];
          short t3 = z[2];
          (sd->vt0).x = t1;
          (sd->vt0).y = t2;
          (sd->vt0).z = t3;
        }
        {
          short *z = (short *)(Nvertice + facet->vertexId1);
          short t1 = z[0];
          short t2 = z[1];
          short t3 = z[2];
          (sd->vt1).x = t1;
          (sd->vt1).y = t2;
          (sd->vt1).z = t3;
        }
        {
          short *z = (short *)(Nvertice + facet->vertexId2);
          short t1 = z[0];
          short t2 = z[1];
          short t3 = z[2];
          (sd->vt2).x = t1;
          (sd->vt2).y = t2;
          (sd->vt2).z = t3;
        }
        DRAWC_OTLINK_MODE(sd, "84", "88", "92");
        DRAWC_OTLINK_FT3(sd, prim);
        DRAWC_OTLINK_MODE(sd, "72", "76", "80");
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          ((u_int *)prim)[2] = xy0;
          ((u_int *)prim)[4] = xy1;
          ((u_int *)prim)[6] = xy2;
        }
        {
          u_long color = sd->eColor0;

          ((u_int *)prim)[1] = color;
          *(u_char *)((int)prim + 7) = code;
        }
        {
          u_short clut = (sd->ePmx1).clut;
          u_short tpage = (sd->ePmx1).tpage;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
        }
        DRAWC_UVTINT_VT(sd, prim);
      }
      if (*(int *)&sd->ePmx0 != 0) {
        DRAWC_OTLINK_FT3(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          ((u_int *)prim)[2] = xy0;
          ((u_int *)prim)[4] = xy1;
          ((u_int *)prim)[6] = xy2;
        }
        {

          if ((overlayFlag & 1) != 0) {
            ((u_int *)prim)[1] = sd->eColor2;
          }
          else if ((facet_flag & 4) != 0) {
            ((u_int *)prim)[1] = sd->eColor1;
          }
          else {
            ((u_int *)prim)[1] = sd->eColor0;
          }
          *(u_char *)((int)prim + 7) = code;
        }
        {
          u_short clut = (sd->ePmx0).clut;
          u_short tpage = (sd->ePmx0).tpage;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
        }
        {
          u_char u = (sd->ePmx0).u0 + 0x40;
          u_char v = (sd->ePmx0).v0;
          /* idN are morphed addresses: tV[id].u/v = 0xd6/0xd7(idN) (oracle t9/t8/t3) */
          DRAWC_UVTINT_ID(sd, prim, id0, id1, id2);
        }
      }
      if ((overlayFlag & 3) != 0) {
        /* SYM block {index,which,facetOverlay} -- FT3B overlay variant */
        int index = facet->textureIndex;
        int which = (overlayFlag & 3) - 1;
        Transformer_zOverlay *facetOverlay = overlay + (index * 3 + which);
        prim = (POLY_FT3 *)(sd->head).cprim.PrimPtr;
        DRAWC_OTLINK_FT3B(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          ((u_int *)prim)[2] = xy0;
          ((u_int *)prim)[4] = xy1;
          ((u_int *)prim)[6] = xy2;
        }
        {
          u_long color = sd->color;
          u_char code = 0x24;
          if ((facet_flag & 1) != 0) {
            code = 0x26;
          }
          ((u_int *)prim)[1] = color;
          *(u_char *)((int)prim + 7) = code;
        }
        {
          Draw_tPixMap *pmx = sd->pmxStart + (facet->textureIndex + facetOverlay->offset);
          u_char u = facetOverlay->u;
          u_char v = facetOverlay->v;
          u_short clut = pmx->clut;
          u_short tpage = pmx->tpage;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
          {
            u_char u0 = facet->uv0.u + u;
            u_char u1 = facet->uv1.u + u;
            u_char u2 = facet->uv2.u + u;
            *(u_char *)((u_int *)prim + 3) = u0;
            *(u_char *)((u_int *)prim + 5) = u1;
            *(u_char *)((u_int *)prim + 7) = u2;
          }
          {
            u_char v0 = facet->uv0.v + v;
            u_char v1 = facet->uv1.v + v;
            u_char v2 = facet->uv2.v + v;
            *(u_char *)((int)prim + 0xd) = v0;
            *(u_char *)((int)prim + 0x15) = v1;
            *(u_char *)((int)prim + 0x1d) = v2;
          }
        }
      }
      else {
        prim = (POLY_FT3 *)(sd->head).cprim.PrimPtr;
        DRAWC_OTLINK_FT3B(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          ((u_int *)prim)[2] = xy0;
          ((u_int *)prim)[4] = xy1;
          ((u_int *)prim)[6] = xy2;
        }
        {
          u_long color = sd->color;
          u_char code = 0x24;
          if ((facet_flag & 1) != 0) {
            code = 0x26;
          }
          ((u_int *)prim)[1] = color;
          *(u_char *)((int)prim + 7) = code;
        }
        {
          Draw_tPixMap *pmx = sd->pmxStart + facet->textureIndex;
          u_short clut = pmx->clut;
          u_short tpage = pmx->tpage;
          u_short uv0;
          u_short uv1;
          u_short uv2;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
          uv0 = *(u_short *)&facet->uv0;
          uv1 = *(u_short *)&facet->uv1;
          uv2 = *(u_short *)&facet->uv2;
          *(u_short *)((u_int *)prim + 3) = uv0;
          *(u_short *)((u_int *)prim + 5) = uv1;
          *(u_short *)((u_int *)prim + 7) = uv2;
        }
      }
    }
  }
  }
  return;
}

/* ---- DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache  [DRAWC.CPP:2554-2644] SLD-VERIFIED ---- */
void DrawC_DividePrim(COORD16 *vt0,COORD16 *vt1,COORD16 *vt2,u_short *u0,u_short *u1,u_short *u2,
               Draw_tPixMap *pmx,Draw_CarCache *sd)

{
  POLY_FT3 * prim;
  
  if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr) {
    {
      int bfct;
      gte_ldv3(vt0,vt1,vt2);
      gte_rtpt();
      gte_nclip();
      gte_stMAC0m(sd->bfct); /* m-form: swc2 $24,0x44(sd) direct displacement (EA-expander site) */
      bfct = sd->bfct;
      if ((sd->head).mirror != 0) {
        bfct = -bfct;
      }
      if (bfct <= 0) {
        return;
      }
    }
    {
      int clipW;
      int clipH;
      gte_stSXY0m(sd->dvx0);   /* m-form: swc2 $12,0xC4(sd) etc. */
      gte_stSXY1m(sd->dvx1);
      gte_stSXY2m(sd->dvx2);
      clipW = (sd->head).clipW;
      clipH = (sd->head).clipH;
      if (((clipW < sd->dvx0) && (clipW < sd->dvx1) && (clipW < sd->dvx2)) ||
          ((sd->dvx0 < 0) && (sd->dvx1 < 0) && (sd->dvx2 < 0)) ||
          ((clipH < sd->dvy0) && (clipH < sd->dvy1) && (clipH < sd->dvy2)) ||
          ((sd->dvy0 < 0) && (sd->dvy1 < 0) && (sd->dvy2 < 0)) ||
          ((vt0->z < 0) && (vt1->z < 0) && (vt2->z < 0))) {
        return;
      }
    }
    gte_avsz3();
    gte_stOTZm(sd->otz);
    sd->otz += sd->sub_otz;
    if ((-1 < sd->otz) && (sd->otz <= sd->sub_otSize)) {
      DRAWC_OTLINK_FT3(sd, prim);
      {
        long xy0 = *(long *)&sd->dvx0;
        long xy1 = *(long *)&sd->dvx1;
        long xy2 = *(long *)&sd->dvx2;
        ((u_int *)prim)[2] = xy0;
        ((u_int *)prim)[4] = xy1;
        ((u_int *)prim)[6] = xy2;
      }
      {
        u_long color = sd->color;
        u_char code = 0x24;
        ((u_int *)prim)[1] = color;
        *(u_char *)((int)prim + 7) = code;
      }
      {
        u_short clut = pmx->clut;
        u_short tpage = pmx->tpage;
        u_short uv0;
        u_short uv1;
        u_short uv2;
        *(u_short *)((int)prim + 0xe) = clut;
        *(u_short *)((int)prim + 0x16) = tpage;
        uv1 = *u1;                             /* u1 loads FIRST (a0) */
        uv0 = *u0;                             /* then u0 (a1) */
        uv2 = *u2;                             /* then u2 (v0) */
        *(u_short *)((u_int *)prim + 3) = uv0;
        *(u_short *)((u_int *)prim + 5) = uv1;
        *(u_short *)((u_int *)prim + 7) = uv2;
      }
    }
  }
  return;
}

/* ===== w55-a9: 626 -> 552 (count unchanged 1883 / oracle 1877) =====
 * LEVER: the id0/id1/id2 index->address MORPH at all FOUR clip-loop sites.
 *  (a) SPLIT the fused `idN = idN * 8 + (int)sd;` into TWO statements
 *      `idN = idN * 8; idN = idN + (int)sd;`.  The fused form makes cc1plus
 *      born a separate shift temp that all three morphs share ($v0) --
 *      `sll v0,aN,3; addu aN,v0,s1` -- while the oracle mutates the id
 *      register IN PLACE (`sll aN,aN,3; addu aN,aN,s1`).  The split form
 *      emits the oracle's in-place pair.  626 -> 594, count unchanged.
 *  (b) STATEMENT ORDER: with the split landed the three id qtys are handed
 *      registers by birth order, so the ORDER of the three index `lbu`s AND
 *      of the three morph statements is a live dial.  Full 36-permutation
 *      sweep (loads x morph, tools-free, ~6 s each) -- best is
 *      L(2,0,1)/M(2,0,1) = id2, id0, id1 in BOTH groups: 594 -> 552.
 *      Sweep table (top rows): L201M201 552 | L201M012 560 | L201M021 560 |
 *      L021M201 570 | L120M210 574 | L210M210 574 | L102M* 576 | L012M012 594
 *      (the old baseline) | L012M210 602.
 *  ⚠️ SITE-SCOPED: the SAME edit REGRESSES DrawC_Prim (338 -> 444..450 for
 *      every one of the 36 permutations), and in Prim the morph ORDER is a
 *      pure no-op (all 6 permutations identical) -- Prim's id block is
 *      already at its own optimum with the fused single-statement form and
 *      the natural L012 order.  Measured, do not port.
 * ===== w64-a14 (2026-08-15): 552 -> 428, three ordered landings =====
 *  (c) DROP THE GHIDRA BYTE-OFFSET BIV (the same lever that unblocked
 *      DrawC_Prim this wave -- see its in-fn receipt).  `iVar11 = facetIdx*0xc;
 *      ... iVar11 += -0xc; facet = (int)obj->facet + iVar11;` is a Ghidra
 *      invention; the SYM lists ONE fn-scope counter + a typed per-block
 *      `facet` and NO byte offset.  `facet = (int)(obj->facet + facetIdx)`
 *      lets loop.c strength-reduce the *12 into its own giv.  552 -> 524
 *      at an unchanged count, all 5 loops.
 *  (d) 🔑 VOID-TAIL FENCE AFTER THE THREE `(sd->vtN).z = zN;` STORES, all 4
 *      sites: 524 -> 432 (count 1883 -> 1887).  Without it sched2 SINKS the
 *      three `sh`s into the clip-compare block's branch delay slots (ours was
 *      3 insns SHORT there and the oracle carries a `nop`); the barrier
 *      groups them and the whole block becomes COUNT- AND OFFSET-EXACT
 *      against the oracle.  The fence must sit AFTER the stores -- between
 *      the loads and the stores it is inert (524).
 *  (e) the PrimMenu floor_log2 REF-STEP dial (do{}while(0) on id2's two
 *      statements + id1's `+= sd`) at morph sites 1 and 3 only: 432 -> 428.
 *      Sites 2 and 4 REGRESS under it at every depth measured (d1/d2, with
 *      and without the id1 leg: 434..450) -- their ids are t1/t0/a3 and
 *      t3/... i.e. they are not the first-served qtys; price with qty/-dl.
 * RESIDUAL 428, the named classes (chunkdiff, largest first):
 *   * the z-block ×4 is now count- and offset-EXACT and differs ONLY in the
 *     register CLASS -- ours $v0/$v1/$a0, retail $t4/$t5/$t6.  Census:
 *     `grep -cE 'lhu +\$t[4-7], 0xD4' asm/nonmatchings/main/DrawC_PrimClip*.s`
 *     = 12 (4 sites x 3) and ZERO in Prim/PrimMenu.  That is the §3.25-2 EA
 *     expander-template signature (same reserved $t4-$t7 window as the
 *     DRAWC_OTLINK and DRAWC_UVTINT templates already vendored in this TU) --
 *     BUT the single-function census is weaker than those, so before writing
 *     a template check whether the id rotation at that site explains it.
 *   * the id rotation still live at the 2 un-dialed sites (ours id0:t0
 *     id1:a3 id2:t1, retail t1/t0/a3).
 *   * the xy0/xy1/xy2 load order at the first FT3 block (ours dvx1,dvx2,dvx0
 *     into a0,v0,v1; retail dvx2,dvx0,dvx1 -- SYM xy0=$v0 xy1=$v1 xy2=$a0).
 *   * the whole-function callee-saved ROTATION in the prologue (ours
 *     `addu s2,a1,zero`, oracle `addu s4,a1,zero`).
 * FALSIFIED at the 428 basin: moving the three index `lbu`s BELOW the
 * `MPrimPtr <= PrimPtr` guard = 470 @1875 (it is the COUNT dial -- it takes
 * ours from +10 to -2 -- but costs 42 LCS; per-site 437..439 @1884).
 * ===== w71-a3: 384 -> 325, count 1883 -> 1882 (oracle 1877) =====
 * (the 428 above is a stale intermediate; this belt re-gated the baseline at 384.)
 * Three landings, all TRANSFERRED from DrawC_Prim's w71-a3 block (read it first --
 * the mechanisms and the falsification list live there):
 *  (1) IN-PLACE COMPOSITE SHIFT on `overlayRaw` at both clip sites
 *      (`overlayRaw = (u_short)DrawC_gOverlay[facet->textureIndex];
 *        overlayRaw = overlayRaw << 0x10;`).
 *  (2) PARENTHESISED INT SUM in the overlay address at both sites
 *      (`overlay + (index * 3 + which)`).
 *      (1)+(2) together: 384 -> 344.
 *  (3) the SYM `code`/`color` UCHAR/ULONG local pair at the four remaining LITERAL
 *      `prim->code = 0x24;` / `= 0x26;` stores (the two sites at DRAWC.CPP:3334/3382
 *      already carried the identity-then-tweak `code = 0x24; ... code = 0x26;` form
 *      and were left alone): 344 -> 325 @1882.
 * FALSIFIED here at the 325 basin:
 *  - the same `code` local wrapped around the THREE-ARM colour select
 *    (`if (overlayFlag & 1) ... else if (facet_flag & 4) ... else ...` followed by
 *    `prim->code = 0x26;`): 348 @1883.  Introducing the block there defeats the
 *    cross_jump merge of the three arms' stores -- leave that one site literal.
 * (the RESIDUAL-325 class list that stood here is superseded by w72-a3 below.)
 * ===== w72-a3 (2026-08-22): 325 -> 268, THREE landings =====
 *  (1) 🏆 THE SYM'S SINGLE fn-SCOPE COUNTER (transferred from DrawC_Prim's w72-a3
 *      block -- read that receipt for the allocsim pricing that discovered it).
 *      symblk lists ONE counter for this fn, `REG i $18 s2 INT`, in the outermost
 *      block.  This recon carried a SECOND one, `int facetCount = obj->numVertex;`,
 *      for the first vertex loop while `i` drove every other loop.  Merging it
 *      (3 lines) lengthens the single pseudo's live range across both regions:
 *      325 -> 285, and tools/posdiff's first-use register order flips from
 *      `... s4 s3 s2 ...`-mismatched to IDENTICAL to the oracle (24/24), with the
 *      alpha-renamed structural residual 909 -> 132.  The whole-function
 *      callee-saved rotation the old class list called `prologue callee-saved
 *      ROTATION (ours addu s2,a1,zero, oracle addu s4,a1,zero)` was THIS, and it
 *      is gone.
 *  (2) THE FIRST FT3 BLOCK'S xy STORE ORDER: `*(u_int*)&prim->x0/x1/x2 = xyN;` in
 *      ASCENDING order (it was x2,x0,x1 here, unique in the TU -- every other xy
 *      block already ascends).  285 -> 273.  Full 6x6 decl-order x store-order
 *      sweep at this basin: store order 012 is worth -12 with decl order 012, 102
 *      or 120 (all 273); every other store order is 281 or 285.  The DECL order is
 *      inert once the store order is right -- the store order is the whole dial.
 *  (3) HOIST THE `envmap & 0x20` MASK ABOVE THE ADDRESS IT COMPETES WITH:
 *      `u_int noSub = envmap & 0x20U;` BEFORE `vt1 = (int)&sd->vt3;`, testing
 *      `if (noSub == 0)`.  273 -> 268, count 1882 -> 1879, structural residual
 *      132 -> 126.  MECHANISM (diffsrc + the raw): `envmap` is an ARG (stack).
 *      Retail keeps it in $t9 across the switch and reorg steals the `andi
 *      $v0,$t9,0x20` into the dispatch's `beqz $v1` delay slot, then puts
 *      `addiu $t9,$s1,0x3D0` (vt1) in the following `bnez`'s slot.  Ours had the
 *      vt1 addiu as the last insn before the dispatch, so reorg stole THAT
 *      instead -- which clobbers $t8 (envmap's register) and costs a 4-insn
 *      spill+reload group `sw t8,32(sp); lw t8,96(sp); nop; andi v0,t8,32`.
 *      Giving the mask its own statement AHEAD of the address restores retail's
 *      steal order.  (This is the reorg backward-scan-position lever, 21B-5.)
 * RE-PRICED AT THE 273/268 BASIN (04Z; measured here, none inherited):
 *   - the id-morph do{}while(0) ref-step dial, all 16 site combinations: the
 *     inherited 1010 (sites 1+3 only) is still the optimum at 285; 0000 289,
 *     1000/0010 287, 1110 291, 1011 307, 1111 313.  Verdict UNCHANGED post-merge.
 *   - the z-block ANONYMOUS-TEMP form (no z0/z1/z2 locals -- the SYM lists none in
 *     that block, so it looked mandated): 297 @1894, +12 insns of load-delay nops.
 *     The named load-3/store-3 temps are what BATCH the three lhu; dropping the
 *     void-tail fence as well is catastrophic (569 @1886).  The SYM's silence here
 *     means anonymous cse temps, NOT `no temps in the source`.
 *   - `int facetFlag` at either clip site: 284 / 460 / 471.  Still worse.
 * RESIDUAL 268, largest classes (diffsrc hotspots, then chunkdiff):
 *   - the two DRAWC_UVTINT_ID sites (6 + 2).
 *   - the z-block x4, still ours $v0/$v1/$a0 vs retail $t4/$t5/$t6 (24 diffs).
 *     13A numeric-scan triage, now sharper: at the lhu instant retail's own live
 *     set is $s1,$s2,$t0,$t1,$a0,$a1,$a2 -- $v0/$v1/$a3/$t2/$t3 look FREE, so the
 *     $t4 floor is NOT hard-reg occupancy: it is local_alloc's post_mark_life,
 *     i.e. OTHER block-local qtys in the same basic block were served first and
 *     took $v0..$t3.  The block is the one the SYM opens at $800c19a4 carrying
 *     ONLY clipW/clipH, so retail's extra qtys there are anonymous.  NEXT
 *     INSTRUMENT: the lab qtytrace for this fn IS obtainable -- the instrumented
 *     cc1plus ICEs on DrawC_Prim, but blanking that ONE body in a copy of the .i
 *     (w60 12H recipe; scratchpad W72_A3/instr_clip.py does it) carries the trace
 *     through DrawC_PrimClip.  Blank DrawC_PrimMenu too to get a complete .s for
 *     the mandatory per-fn byte-fidelity check before quoting the table.
 *   - the two `if (facetFlag < 0)` sites (3 + 3) and the 2nd overlayRaw site (3)
 *     -- the same %hi self-temp-vs-separate-temp class as DrawC_Prim's; see the
 *     21E-4 angle written up there.
 * ===== w74-a3 (2026-08-23): 268 -> 66, count 1879 -> 1877 = ORACLE-EXACT =====
 * SIX landings.  The w72-a3 residual-268 class list above is retired; the
 * z-block's "local_alloc post_mark_life" verdict is REFUTED (see (3)).
 *  (1) 🏆 EXPLICIT `else` ARM FOR THE `code = 0x24` DEFAULT at the two overlay
 *      sites (:3636 and :3684 -> now the `u_char code; ... else { code = 0x24; }`
 *      pairs): 268 -> 210 AND the count goes 1879 -> 1877 = EXACT.  Retail:
 *      `beqz v0,T; li v1,36 [delay slot]; li v1,38`; the `= 0x24` initialiser
 *      form hoists the `li 36` above the guard and nops the slot.  This is
 *      DrawC_Prim's landing (2), found there first.  Site-scoped: the other six
 *      0x24 sites in this fn are exactly neutral.
 *  (2) 🏆 THE facetFlag RELOAD + ff->facet_flag COPY TRADE, both sites
 *      (`int facetFlag` at :3515/:3720 + `facet_flag = ff;` + BOTH 20B launders
 *      + the `int hi` guard temp): 210 -> 176.  Transferred verbatim from
 *      DrawC_Prim's landing (3)/(4) -- read that receipt for the mechanism and
 *      for why either half alone is a net loss.
 *  (3) 🏆🏆 THE z-BLOCK IS AN EA EXPANDER TEMPLATE, NOT AN ALLOCATOR TIE.
 *      `DRAWC_VTZ(sd, id0, id1, id2)` at all four sites: 122 -> 76.  Full
 *      evidence + the five sec.3.25-2 tells are on the macro definition at the
 *      top of this TU.  The w64-a14/w72-a3 "$t4/$t5/$t6 = post_mark_life
 *      serving order / NEXT INSTRUMENT: qtytrace via the ICE-blanked .i" angle
 *      is CLOSED: there is no qty to trace, the registers are in the template.
 *      The four w64-a14(d) void-tail fences after those blocks are now inert
 *      (measured, all four and jointly) and were removed.
 *  (4) THE id0/id1/id2 INDEX-LOAD ORDER, RE-PRICED (law 21E-1): the w55-a9
 *      36-permutation verdict `L201/M201` was measured at the 594 basin and is
 *      DEAD.  At the 176 basin the per-site optima are L012 for sites A/B/C
 *      (`id0; id1; id2` -- the natural order) and L201 for site D:
 *      176 -> 164/150/164 per site, -> 126 jointly.  Then B's MORPH order
 *      M012: 126 -> 122.  Full sweeps re-run at 66: every site is now at its
 *      own permutation minimum (load AND morph), all six perms measured.
 *  (5) THE MORPH-GROUP ORDER AT THE do{}while(0) SITES A AND C -> M012
 *      (74 -> 70 each, 66 jointly).  The oracle emits id2's `sll/addu` AFTER
 *      id0's and id1's; ours emitted it first.  With that order landed the
 *      w64-a14(e) do{}while(0) ref-step wrappers on id1/id2 measure EXACTLY
 *      neutral (66 with and without, singly and jointly) -- so all six were
 *      REMOVED.  ⚠️ NOT a free-standing revert: dropping only the id2 wrapper
 *      while keeping id1's costs +20 (86).  The dial is now subsumed by the
 *      statement order it was compensating for.
 *  (6) The case-1 shared `u_char code = 0x24;` (DrawC_Prim landing (1) applied
 *      to :3486): 76 -> 74.
 * FALSIFIED AT THIS BASIN (measured here, do not re-run):
 *   - clip-site identity-then-tweak `code = 0x24; code = 0x26;` at :3863/:3894
 *     (287) and the case-scope shared `code = 0x26` (272) -- those two sites
 *     are NOT the shared-constant class DrawC_Prim's are.
 *   - swapping the two head initialisers (86), and naming the loop-invariant
 *     gte_stlvnl / gte_ldv0 addresses as source locals (74..86) -- none of
 *     them re-orders retail's preheader `addiu t0,s1,156` to the front.
 *   - read-only fence / tied launder on site-D's id2 or facet_flag (100 / 74).
 * RESIDUAL 66 at an oracle-EXACT 1877 insns, largest first:
 *   - 🔴 SITE-D $t1<->$t8 TWO-REGISTER SWAP (~26 of 66): ours id2=$t8 +
 *     facet_flag=$t1, retail id2=$t1 + facet_flag=$t8; it drags the id2 loads,
 *     morph, lwc2 pair, the DRAWC_VTZ base, the ff copy and every later
 *     `andi facet_flag` with it.  QUANTIFIED CERTIFICATE (allocsim MATCHES
 *     108/108 on this fn, so the table is authoritative): id2 = p820
 *     refs=18 live=200 pri 0.3600; it is served AFTER p821 (t1, refs=18
 *     live=128, pri 0.5625), which owns $t1 across it, so find_reg's numeric
 *     scan falls through v0..t3 (t4-t7 are regs_explicitly_used by this TU's
 *     templates) to $t8.  To win $t1 p820 must out-rank p821:
 *        live 200 -> <=127 (a 37% cut) OR refs 18 -> 29 (+11 refs).
 *     The rival direction is just as dead: p821 must go live 128 -> >200
 *     (+57%).  No fence/ref-step dial spans either gap (a read-only fence is
 *     +1 ref, catalog 21A-1), and `--solve 820=t1,1089=t8` reports NO
 *     single-pseudo refs/live delta in the searched window.  `--what-if
 *     820:live=100..127` DOES hand p820 $t1 but then p819/p818 rotate to
 *     t3/t8 -- so the delta must be JOINT.  NAMED NEXT ANGLE: identify p821
 *     in the .greg (refs=18 live=128 -- it is NOT one of site D's ids) and
 *     price a JOINT (p820,p821) delta; or shorten id2's live range
 *     structurally by re-deriving it at the DRAWC_UVTINT_ID use instead of
 *     holding it (the only 37%-class lever left).
 *   - the fn-head hoist order (4): ours `addiu a2,s1,215; addiu a1,s3,4; ...;
 *     addiu t0,s1,156`, retail `t0(156); a2(215); ...; a1(4)` -- the
 *     loop-invariant gte_stlvnl address is emitted FIRST in retail (21B-3
 *     preheader appearance order).  Both source-level hoists falsified above.
 *   - the case-1 loop head (3 + 4): ours mints a copy `addu t2,a3,zero` for the
 *     hoisted `sd+0xd0` gte_ldv0 base and parks -1 in $t3; retail uses $a3
 *     directly and -1 in $t2.  Naming either address as a local is a net loss.
 *   - the switch-dispatch reorg steal + the envmap `sw t9,32(sp)` spill
 *     position (6) -- the same 21B-5 backward-scan-position class the w72-a3
 *     `noSub` landing already moved once.
 *   - `li t3,38` off by one position (2) and the :3601 `beqz` off by one (2).
 * ===== W75-A7: 66 -> 49 (count 1876 vs oracle 1877), THREE landings + one
 * quantified certificate.  All source-side; no build.py rows (policy).
 *  (1) 🔴 REAL BUG, and it WAS the "case-1 loop head" coloring class above:
 *      loop-2's `gte_ldv0` read tV[0] (`(char *)sd + 0xd0`) forever instead of
 *      the CURRENT tV.  Oracle proof: its base `$a3` is the same register the
 *      loop stores `tV->x` through and it carries `addiu $a3,$a3,8` in the
 *      loop's `j` delay slot.  The bogus loop-invariant address is exactly why
 *      cc1 had to hoist + COPY it (`addu $10,$a3,$0`) while retail needs no
 *      copy; the "-1 parked in $t3 instead of $t2" was downstream of that.
 *      -5 lines / -9 gate; costs one insn of the count because the copy really
 *      was surplus (see (4) for the compensating -1).
 *  (2) THE LAUNDER-POSITION DIAL at both facetFlag sites (-4, the DrawC_Prim
 *      (B) lever): reorg.c:685 stop_search_p fires at any asm, so a launder
 *      between `facet_flag = ff` and the guard `beqz` walls the backward scan
 *      off the copy; inside the guard body it still breaks the cse collapse
 *      but the slot is reachable.  Site-joint (either alone = -2).
 *  (3) THE loop-1 (a)+(b) PORT re-priced at this basin (-4) -- see the receipt
 *      at the loop itself; the w53-a2 "MEASURED NO-OP on PrimClip" verdict was
 *      basin-relative (04Z).
 *  (4) 🏆 QUANTIFIED REQUIRED-DELTA CERTIFICATE for the dominant residual --
 *      the t1<->t8 permutation (19 of the ~29 remaining posmis positions;
 *      id2 and facet_flag in the case-8 loop, plus id2's lbu/sll emission
 *      order).  allocsim on the CURRENT dumps (scratchpad/w75/A7_now.{greg,
 *      lreg}, MATCH 107/107, order-vs-dump IDENTICAL) identifies
 *        p816 id0 refs 18 live 199 pri .3618 -> $t3   (retail $t3 OK)
 *        p817 id1 refs 18 live 196 pri .3673 -> $t2   (retail $t2 OK)
 *        p818 id2 refs 18 live 200 pri .3600 -> $t8   (retail $t1)
 *        p819 facet_flag refs 18 live 129 pri .5581 -> $t1 (retail $t8)
 *      Retail's order is p818 > p817 > p816 > p819.  🏆 IT IS PROVABLY A JOINT
 *      (2-PSEUDO) CELL: an EXHAUSTIVE single-pseudo sweep (scratchpad/w75/
 *      A7_single.py -- p818 refs 2..60, p819 refs 2..60, p818 live 20..800/10,
 *      p819 live 20..800/10, each a full re-allocation checking all four seats)
 *      returns SOLUTIONS: NONE, while the joint control (818:refs=20 +
 *      819:refs=14) hits.  No dial on id2 alone and none on facet_flag alone
 *      reaches retail at ANY magnitude -- which is exactly why every
 *      single-axis attempt in this and earlier waves failed (23B-1, with an
 *      exhaustive proof rather than a sample).  Do not re-open it as a
 *      one-dial target.  MINIMAL JOINT DELTA
 *      (what-if-verified, all four seats land exactly):
 *        p818  REG_N_REFS 18 -> >=19  (one loop-weighted mention: +1 = +2)
 *        p819  REG_LIVE_LENGTH 129 -> >=200  (ties break by lower pseudo, and
 *              818 < 819)  OR  REG_N_REFS 18 -> <=14 (two mentions removed)
 *      FALSIFIED realizations, all measured this belt: multi-operand read-only
 *      fences on id0/id1/id2 (7 cells of the ref ladder incl. the model's own
 *      (5,5,6)) = 68..118 -- the fence insn's own live-length contribution
 *      rotates the rest of the table, which a single-pseudo what-if does not
 *      model; 20B clobbers "$24"/"$11"/"$10" on a site-local copy of the
 *      DRAWC_VTZ template = +1 insn each (265..291), "$9" bit-inert; a 20B
 *      clobber on facet_flag's launder = +1 insn (267..295); the FULL 6x6
 *      id-load x id-morph statement-ORDER sweep (36 cells) -- the shipped
 *      (id2,id0,id1)/(id2,id0,id1) pair is the joint minimum, nothing improves.
 *      => NAMED NEXT ANGLE: a ZERO-INSN way to add ~71 to facet_flag's live
 *      length (a 15A foreign-operand fence lengthens every range across it by
 *      one insn, so it must sit ~70 RTL insns past facet_flag's last use), or
 *      a -2-mention reshape of its nine mentions.  Do NOT re-run the ref
 *      ladder on the ids: it is priced and it loses.
 *  REMAINING BESIDES (4): `addiu $a2,$s1,215` one hoist-group late (2, angle at
 *  the loop); the switch-dispatch `li $2,8` reorg eager-steal + the missing
 *  `nop` (this is the +1 that (1) exposed) and the `sw $t9,32($sp)` spill
 *  position (6); `li $t3,38` off by one position (2).  The dispatch blocks are
 *  compiler-generated (no source statement to fence at their thread head).
 * ===== W76-A7 (2026-08-23): 49 -> PASS 1877/1877, zero insns, zero pins =====
 *  (0) vt1-def moved below the noSub guard = the missing insn AND the whole
 *      dispatch class in one move (49 -> 42 count-EXACT; in-line receipt).
 *  (1) THE JOINT (id2,facet_flag) CELL LANDED as (id2 refs->20 via a
 *      target-only read fence) + (facet_flag DENIED t1-t3 via clobbers on a
 *      relocated launder) -- not the modeled refs->14: the -2-mention route
 *      is structurally dead (launder removal = only -1 mention AND collapses
 *      the copy web: 260/238-diff rotations, envmap t9->t8, id2->a2).  Also
 *      falsified en route: facet_flag tail read fence at the loop join
 *      (live 129->188 < the 223 bar), loop-carried loop-head fence (live 423
 *      -> conflicts with the whole loop -> callee-saved $s3, 24E-4).  With
 *      the seats fixed, the id load/morph order went back to the natural
 *      id0,id1,id2 (the 36-cell w73 sweep verdict was basin-relative, 04Z).
 *      42 -> 16 -> 4.
 *  (2) UV cursor -> index form (giv-group init, 12D) + case-1 `code = 0x24`
 *      born-in-the-loop (21B-3): 4 -> PASS.
 *  Receipts: scratchpad/w76/A7_report.md, A7_allocsim_*.txt, A7_p*_sbs.txt.
 * ---- DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache  [DRAWC.CPP:2647-3495] SLD-VERIFIED ---- */
void DrawC_PrimClip(matrixtdef *m,coorddef *t,Transformer_zObj *obj,Transformer_zOverlay *overlay,
               int envmap,Draw_CarCache *sd)

{
  int i;
  COORD16 *Nvertice;
  u_char *u2;
  COORD16 *vt2_00;
  u_char *u2_00;
  u_char *u1;
  COORD16 *vt1;
  COORD16 *vt2;

  /* These names do not correspond to distinct DrawC_PrimClip SYM declarations.
     They are retained only where the W72-W76 oracle experiments cited below prove
     that a natural direct/index spelling changes scheduling, GIV placement, or local
     allocation.  u1/u2 are included explicitly because same-spelled nested UV-byte
     locals would otherwise hide these pointer carriers from a name-only audit.
     SYM-CODEGEN-CARRIER: envmapUV_dst
     SYM-CODEGEN-CARRIER: ff
     SYM-CODEGEN-CARRIER: hi
     SYM-CODEGEN-CARRIER: overlayRaw
     SYM-CODEGEN-CARRIER: u1
     SYM-CODEGEN-CARRIER: u2
     SYM-CODEGEN-CARRIER: u2_00
     SYM-CODEGEN-CARRIER: uvk
     SYM-CODEGEN-CARRIER: vt1
     SYM-CODEGEN-CARRIER: vt2
     SYM-CODEGEN-CARRIER: vt2_00 */

  Nvertice = obj->Nvertex;
  if ((*(int *)&sd->ePmx0 == 0) && (*(int *)&sd->ePmx1 == 0)) {
    envmap = envmap & 0xbe;
  }
  if ((envmap & 1U) != 0) {
    /* SYM block-scope rebuild (SEAL rule 8c): this whole envmap-UV loop is its
     * OWN nested SYM block chain (line=18/19/27/31, va 0x800c15c8-0x800c16bc)
     * distinct from psVar8's later, unrelated facet-vertex uses -- give it a
     * fresh block-scoped 'vt' pseudo (shadowing the outer psVar8) instead of
     * reusing the function-scope one, matching the oracle's short-lived reg.
     * ===== W75-A7: the DrawC_Prim loop-1 (a)+(b) port, RE-PRICED (04Z) =====
     * The w53-a2 receipt on DrawC_Prim's twin recorded this port as "MEASURED
     * NO-OP on DrawC_PrimClip (626 -> 626)"; that verdict was taken at the 626
     * basin.  At the post-launder basin it is -4: ONE `COORD16 *vt` cursor +
     * a block-local {t1,t2,t3} triple instead of the two-cursor
     * psVar8/vert_yz_iter form, with `vt` assigned ABOVE the two gte_Set*Matrix
     * macros.  loop.c then STRENGTH-REDUCES the y/z cursor itself, so its init
     * `addiu $a1,$s3,4` is emitted in the GIV group -- AFTER the LICM movables
     * (`li -1`, `addiu $t1,$s1,172`, `addiu $t0,$s1,156`) -- which is where
     * retail has it; the source-assigned `vert_yz_iter` was emitted in the
     * ENTRY block, i.e. BEFORE all three hoists.  Assigning `vt` below the
     * macros instead (K2/K3 in the sweep) is +2.  RESIDUAL of this class = the
     * ONE remaining `addiu $a2,$s1,215` (envmapUV_dst), still a source-assigned
     * pointer emitted in the entry block where retail has it in the giv group:
     * NAMED ANGLE = make the UV byte cursor a giv too, anchored at
     * `&sd->tV[0].v` (retail's base is +215, i.e. `.v` with `[-1]` for `.u`, so
     * DrawC_Prim's typed `Draw_CarVertex *` walker -- base +214 -- must NOT be
     * ported here). */
    COORD16 *vt = Nvertice;
gte_SetRotMatrix(&DrawC_gMatA);
gte_SetTransMatrix(&DrawC_gMatA);
    /* W76-A7 (12D eliminated-biv law; the W75 'giv' angle landed): the UV
     * stores are INDEX form so loop.c strength-reduces the address into a
     * giv and ELIMINATES uvk -- the giv init `addiu $a2,$s1,215` is then
     * emitted in the giv group AFTER the LICM movables (li -1, +172, +156)
     * = retail's slot; the source-assigned +8 cursor was entry-block
     * (2 diffs).  Base stays &tV[0].v (+215, with [-1] for .u) -- do NOT
     * port DrawC_Prim's +214 typed walker (W75 receipt). */
    char *envmapUV_dst = &sd->tV[0].v;
    int uvk = 0;
    i = (int)obj->numVertex;
    while( true ) {
      i = i - 1;
      if (i == -1) break;
      {
        short t1 = vt->x;
        short t2 = vt->y;
        short t3 = vt->z;
        (sd->vt0).x = t1;
        (sd->vt0).y = t2;
        (sd->vt0).z = t3;
      }
gte_ldv0((char *)sd + 0xac);
      gte_rt();
gte_stlvnl((char *)sd + 0x9c);
      int v = (sd->tv).vz;
      int u = (sd->tv).vx;   /* int load (lw) -- oracle stores its low byte */
      if (v < 0) {
        v = -v;
      }
      vt = vt + 1;
      envmapUV_dst[uvk * 8 - 1] = (char)u;
      envmapUV_dst[uvk * 8] = (char)v;
      uvk = uvk + 1;
    }
  }
  TrsProj_SetTransPrecision(8);
  /* SYM block-scope rebuild: SYM shows THREE separate {r0,r1,r2} block
   * scopes (one per matB row, va 0x800c16bc x3) -- fresh locals per row
   * instead of the shared iVar11/iVar12 function-scope scratch (which is
   * reused 30+/40+ times elsewhere and must stay untouched there). */
  {
    int r0 = m->m[0];
    int r1 = m->m[3];
    int r2 = m->m[6];
    (sd->matB).m[0][0] = (short)(r0 >> 4);
    (sd->matB).m[0][1] = (short)(r1 >> 4);
    (sd->matB).m[0][2] = (short)(r2 >> 4);
  }
  {
    int r0 = m->m[1];
    int r1 = m->m[4];
    int r2 = m->m[7];
    (sd->matB).m[1][0] = (short)(r0 >> 4);
    (sd->matB).m[1][1] = (short)(r1 >> 4);
    (sd->matB).m[1][2] = (short)(r2 >> 4);
  }
  {
    int r0 = m->m[2];
    int r1 = m->m[5];
    int r2 = m->m[8];
    (sd->matB).m[2][0] = (short)(r0 >> 4);
    (sd->matB).m[2][1] = (short)(r1 >> 4);
    (sd->matB).m[2][2] = (short)(r2 >> 4);
  }
  (sd->matB).t[0] = t->x >> (TrsProj_precision);
  (sd->matB).t[1] = t->y >> (TrsProj_precision);
  (sd->matB).t[2] = t->z >> (TrsProj_precision);
  TrsProj_ResetTransPrecision();
gte_SetRotMatrix(((char *)sd + 0x14));
gte_SetTransMatrix(((char *)sd + 0x14));
  /* SYM block-scope rebuild: SYM's {vt,tV} block (va 0x800c16bc-0x800c1840)
   * wraps nested {x,y,z}/{t1,t2,t3} blocks.  Typed 6-byte/8-byte walkers replace
   * the raw integer and short cursors, while the named triples preserve retail's
   * load/store batching.  This reduced the authoritative residual 420 -> 384. */
  {
    COORD16 *vt = obj->vertex;
    PCOORD16 *tV = (PCOORD16 *)sd->tV;
    i = (int)obj->numVertex;
    while( true ) {
      i = i - 1;
      if (i == -1) break;
      {
        short t1 = vt->x;
        short t2 = vt->y;
        short t3 = vt->z;
        tV->x = t1;
        tV->y = t2;
        tV->z = t3;
      }
      /* 🔴 W75-A7 REAL BUG FIX (gate-visible, was 5 diffs): this loads the
       * vector to transform from the CURRENT tV slot, not from tV[0].  The
       * oracle's base register is the SAME walking `$a3` it stores tV->x
       * through (`addiu $a3,$a3,8` in the loop's `j` delay slot); the old
       * `(char *)sd + 0xd0` is tV[0]'s address, so from iteration 2 on the
       * recon re-transformed vertex 0 for every vertex.  cc1 was reporting
       * the defect all along: a fixed base hoisted out of the loop had to be
       * COPIED (`addu $10,$a3,$0`) because $a3 is mutated -- the "extra copy
       * + `-1` parked in $t3 instead of $t2" residual the w72/w74 receipts
       * filed as a coloring class.  58 -> 49 (count 1876 vs 1877: the copy
       * really was one insn, and the remaining -1 is the separate switch
       * `li $2,8`/`nop` class below, which was masking it). */
gte_ldv0((char *)tV);
      gte_rt();
gte_stlvnl((char *)sd + 0x9c);
      {
        int x = (sd->tv).vx;
        int y = (sd->tv).vy;
        int z = (sd->tv).vz;
        tV->x = (short)x;
        tV->y = (short)y;
        tV->z = (short)z;
      }
      vt = vt + 1;
      tV = tV + 1;
    }
  }
gte_SetRotMatrix(&DrawC_gScreenMat);
gte_SetTransMatrix(&DrawC_gScreenMat);
  i = (int)obj->numFacet;
  /* dispatch = real switch(envmap&9), case bodies in oracle VA order
   * (case 0 @0x800C18E0, 1 @0x800C2000, 8 @0x800C25BC, 9 @0x800C2AA0) */
  switch (envmap & 9) {
  case 0: {
      if ((envmap & 0x20U) == 0) {
        /* SYM block line=97 {prim,facet,id0,id1,id2} -- literal repeated SYM
         * names redeclared per case block (wave-9 same-identifier lever);
         * loop rebuilt as while+continue chains per the oracle's slot-filled
         * -1/+1 counter compensation (raw 0x800C18F4..0x800C1CB0). */
        POLY_FT3 *prim;
        Transformer_zFacet *facet;
        int id0;
        int id1;
        int id2;
        while( true ) {
          i = i - 1;
          if (i == -1) {
            return;
          }
          facet = obj->facet + i;
          id0 = facet->vertexId0;
          id1 = facet->vertexId1;
          id2 = facet->vertexId2;
          if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
          /* SYM 3.8b: id0-2 morph index->address in place (oracle sll aN,aN,3) */
          id0 = id0 * 8; id0 = id0 + (int)sd;
          id1 = id1 * 8;
          id1 = id1 + (int)sd;
          id2 = id2 * 8;
          id2 = id2 + (int)sd;
          gte_ldVXY0m(*(u_int *)(id0 + 0xd0));
          gte_ldVZ0m(*(u_int *)(id0 + 0xd4));
          gte_ldVXY1m(*(u_int *)(id1 + 0xd0));
          gte_ldVZ1m(*(u_int *)(id1 + 0xd4));
          gte_ldVXY2m(*(u_int *)(id2 + 0xd0));
          gte_ldVZ2m(*(u_int *)(id2 + 0xd4));
          gte_rtpt();
          gte_nclip();
          gte_stMAC0m(sd->bfct);
          {
            int bfct = sd->bfct;
            if ((sd->head).mirror != 0) {
              bfct = -bfct;
            }
            if (bfct < 1) continue;
          }
          gte_stSXY0m(sd->dvx0);
          gte_stSXY1m(sd->dvx1);
          gte_stSXY2m(sd->dvx2);
          {
            /* load-3/store-3 (oracle lhu t4/t5/t6 batched; idN = morphed addrs) */
            DRAWC_VTZ(sd, id0, id1, id2);
            
          }
          {
            int clipW = (sd->head).clipW;
            int clipH = (sd->head).clipH;
            if ((clipW < sd->dvx0) && (clipW < sd->dvx1) && (clipW < sd->dvx2)) continue;
            if ((sd->dvx0 < 0) && (sd->dvx1 < 0) && (sd->dvx2 < 0)) continue;
            if ((clipH < sd->dvy0) && (clipH < sd->dvy1) && (clipH < sd->dvy2)) continue;
            if ((sd->dvy0 < 0) && (sd->dvy1 < 0) && (sd->dvy2 < 0)) continue;
            if (((sd->vt0).z < 0) && ((sd->vt1).z < 0) && ((sd->vt2).z < 0)) continue;
          }
          gte_avsz3();
          gte_stOTZm(sd->otz);
          sd->otz = sd->otz + sd->sub_otz;
          if (sd->otz < 0) continue;
          if (sd->sub_otSize < sd->otz) continue;
          DRAWC_OTLINK_FT3(sd, prim);
          {
            long xy0 = *(long *)&sd->dvx0;
            long xy1 = *(long *)&sd->dvx1;
            long xy2 = *(long *)&sd->dvx2;
            *(u_int *)&prim->x0 = xy0;
            *(u_int *)&prim->x1 = xy1;
            *(u_int *)&prim->x2 = xy2;
          }
          {
            u_long color = sd->color;
            u_char code = 0x24;
            if (((u_short)facet->flag & 1) != 0) {
              code = 0x26;
            }
            *(u_int *)&prim->r0 = color;
            prim->code = code;
          }
          if (((envmap & 2U) != 0) && (((u_short)facet->flag & 1) == 0)) {
            /* SYM block line=189 {pmx {u0..v2,u,v,clut,tpage}} */
            Draw_tPixMap *pmx = sd->pmxStart + facet->textureIndex;
            u_char u = sd->offsetU0;
            u_char v = sd->offsetV0;
            u_short clut = pmx->clut;
            u_short tpage = pmx->tpage;
            prim->clut = clut;
            prim->tpage = tpage;
            {
              u_char u0 = facet->uv0.u + u;
              u_char u1 = facet->uv1.u + u;
              u_char u2 = facet->uv2.u + u;
              prim->u0 = u0;
              prim->u1 = u1;
              prim->u2 = u2;
            }
            {
              u_char v0 = facet->uv0.v + v;
              u_char v1 = facet->uv1.v + v;
              u_char v2 = facet->uv2.v + v;
              prim->v0 = v0;
              prim->v1 = v1;
              prim->v2 = v2;
            }
          }
          else {
            /* SYM block line=194 {pmx {offsetU,offsetV {u0..v2,clut,tpage}}} */
            Draw_tPixMap *pmx = sd->pmxStart + facet->textureIndex;
            if ((*(u_short *)((int)pmx + 0xe) & 0x7f) != 0) {
              u_char offsetU = sd->offsetU1;
              u_char offsetV = sd->offsetV1;
              if ((*(u_short *)((int)pmx + 0xe) & 2) != 0) {
                offsetU = sd->offsetU2;
                offsetV = sd->offsetV2;
              }
              {
                u_short clut = pmx->clut;
                u_short tpage = pmx->tpage;
                prim->clut = clut;
                prim->tpage = tpage;
              }
              {
                u_char u0 = facet->uv0.u + offsetU;
                u_char u1 = facet->uv1.u + offsetU;
                u_char u2 = facet->uv2.u + offsetU;
                prim->u0 = u0;
                prim->u1 = u1;
                prim->u2 = u2;
              }
              {
                u_char v0 = facet->uv0.v + offsetV;
                u_char v1 = facet->uv1.v + offsetV;
                u_char v2 = facet->uv2.v + offsetV;
                prim->v0 = v0;
                prim->v1 = v1;
                prim->v2 = v2;
              }
            }
            else {
              /* SYM block line=210 {uv0,uv1,uv2,clut,tpage} */
              u_short clut = pmx->clut;
              u_short tpage = pmx->tpage;
              u_short uv0;
              u_short uv1;
              u_short uv2;
              prim->clut = clut;
              prim->tpage = tpage;
              uv0 = *(u_short *)&facet->uv0;
              uv1 = *(u_short *)&facet->uv1;
              uv2 = *(u_short *)&facet->uv2;
              *(u_short *)&prim->u0 = uv0;
              *(u_short *)&prim->u1 = uv1;
              *(u_short *)&prim->u2 = uv2;
            }
          }
        }
      }
      /* W76-A7 (the '1876 vs 1877' missing insn): vt1's def lives AFTER the
       * noSub guard -- retail's bnez fills its slot by eager-stealing this
       * addiu from the target thread (21B-5) and keeps `sw $t9,32($sp)` at
       * the target head; defined above the guard it was the backward-fill
       * candidate instead (slot = the spill sw), and the dispatch's `beqz
       * $v0` slot upstream flipped li-8/nop.  This one move closed the whole
       * W75 6-line "switch-dispatch" class: 49 -> 42, count 1876 -> 1877
       * EXACT. */
      vt1 = &sd->vt3;
      vt2 = &sd->vt5;
      u1 = &sd->u3;
      u2_00 = &sd->u5;
      vt2_00 = &sd->vt4;
      u2 = &sd->u4;
      while( true ) {
        i = i - 1;
        if (i == -1) break;
        {
        /* SYM block line=218 {facet,id0,id1,id2,pmx} -- literal repeated SYM
         * names redeclared per case block (wave-9 same-identifier lever) */
        Transformer_zFacet *facet = obj->facet + i;
        int id0 = facet->vertexId0;
        int id1 = facet->vertexId1;
        int id2 = facet->vertexId2;
        Draw_tPixMap *pmx = sd->pmxStart + facet->textureIndex;
        {
          short *z = (short *)(sd->tV + id0);
          short t1 = z[0];
          short t2 = z[1];
          short t3 = z[2];
          (sd->vt0).x = t1;
          (sd->vt0).y = t2;
          (sd->vt0).z = t3;
        }
        {
          short *z = (short *)(sd->tV + id1);
          short t1 = z[0];
          short t2 = z[1];
          short t3 = z[2];
          (sd->vt1).x = t1;
          (sd->vt1).y = t2;
          (sd->vt1).z = t3;
        }
        {
          short *z = (short *)(sd->tV + id2);
          short t1 = z[0];
          short t2 = z[1];
          short t3 = z[2];
          (sd->vt2).x = t1;
          (sd->vt2).y = t2;
          (sd->vt2).z = t3;
        }
        (sd->vt3).x = (short)((sd->vt0).x + (sd->vt1).x + 1 >> 1);
        (sd->vt3).y = (short)((sd->vt0).y + (sd->vt1).y + 1 >> 1);
        (sd->vt3).z = (short)((sd->vt0).z + (sd->vt1).z + 1 >> 1);
        (sd->vt4).x = (short)((sd->vt1).x + (sd->vt2).x + 1 >> 1);
        (sd->vt4).y = (short)((sd->vt1).y + (sd->vt2).y + 1 >> 1);
        (sd->vt4).z = (short)((sd->vt1).z + (sd->vt2).z + 1 >> 1);
        (sd->vt5).x = (short)((sd->vt2).x + (sd->vt0).x + 1 >> 1);
        (sd->vt5).y = (short)((sd->vt2).y + (sd->vt0).y + 1 >> 1);
        (sd->vt5).z = (short)((sd->vt2).z + (sd->vt0).z + 1 >> 1);
        {
          u_short uv0 = *(u_short *)&facet->uv0;
          u_short uv1 = *(u_short *)&facet->uv1;
          u_short uv2 = *(u_short *)&facet->uv2;
          *(u_short *)&sd->u0 = uv0;
          *(u_short *)&sd->u1 = uv1;
          *(u_short *)&sd->u2 = uv2;
        }
        if ((envmap & 2U) != 0) {
          int u = sd->offsetU0;
          int v = sd->offsetV0;
          sd->u0 = sd->u0 + u;
          sd->v0 = sd->v0 + v;
          sd->u1 = sd->u1 + u;
          sd->v1 = sd->v1 + v;
          sd->u2 = sd->u2 + u;
          sd->v2 = sd->v2 + v;
        }
        sd->u3 = (u_char)((int)((u_int)sd->u0 + (u_int)sd->u1 + 1) >> 1);
        sd->v3 = (u_char)((int)((u_int)sd->v0 + (u_int)sd->v1 + 1) >> 1);
        sd->u4 = (u_char)((int)((u_int)sd->u1 + (u_int)sd->u2 + 1) >> 1);
        sd->v4 = (u_char)((int)((u_int)sd->v1 + (u_int)sd->v2 + 1) >> 1);
        sd->u5 = (u_char)((int)((u_int)sd->u2 + (u_int)sd->u0 + 1) >> 1);
        sd->v5 = (u_char)((int)((u_int)sd->v2 + (u_int)sd->v0 + 1) >> 1);
        DrawC_DividePrim(&sd->vt0,vt1,vt2,(u_short *)&sd->u0,(u_short *)u1,
                   (u_short *)u2_00,pmx,sd);
        DrawC_DividePrim(vt1,&sd->vt1,vt2_00,(u_short *)u1,(u_short *)&sd->u1,
                   (u_short *)u2,pmx,sd);
        DrawC_DividePrim(vt2,vt2_00,&sd->vt2,(u_short *)u2_00,(u_short *)u2,
                   (u_short *)&sd->u2,pmx,sd);
        DrawC_DividePrim(vt2,vt1,vt2_00,(u_short *)u2_00,(u_short *)u1,
                   (u_short *)u2,pmx,sd);
        }
      }
    return;
  }
  case 1: {
    /* SYM block line=279 {prim,facet,id0,id1,id2} -- literal repeated SYM
     * names redeclared per case block (wave-9 same-identifier lever);
     * loop rebuilt as while+continue chains per the oracle (0x800C2014..). */
    POLY_FT3 *prim;
    Transformer_zFacet *facet;
    int id0;
    int id1;
    int id2;
    u_char code;
    while( true ) {
      i = i - 1;
      if (i == -1) {
        return;
      }
      facet = obj->facet + i;
      id0 = facet->vertexId0;
      id1 = facet->vertexId1;
      id2 = facet->vertexId2;
      if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
      /* SYM 3.8b: id0-2 morph index->address in place (oracle sll aN,aN,3) */
      id0 = id0 * 8; id0 = id0 + (int)sd;
      id1 = id1 * 8; id1 = id1 + (int)sd;
      id2 = id2 * 8; id2 = id2 + (int)sd;
      gte_ldVXY0m(*(u_int *)(id0 + 0xd0));
      gte_ldVZ0m(*(u_int *)(id0 + 0xd4));
      gte_ldVXY1m(*(u_int *)(id1 + 0xd0));
      gte_ldVZ1m(*(u_int *)(id1 + 0xd4));
      gte_ldVXY2m(*(u_int *)(id2 + 0xd0));
      gte_ldVZ2m(*(u_int *)(id2 + 0xd4));
      gte_rtpt();
      gte_nclip();
      gte_stMAC0m(sd->bfct);
      {
        int bfct = sd->bfct;
        if ((sd->head).mirror != 0) {
          bfct = -bfct;
        }
        if (bfct < 1) continue;
      }
      gte_stSXY0m(sd->dvx0);
      gte_stSXY1m(sd->dvx1);
      gte_stSXY2m(sd->dvx2);
      {
        /* load-3/store-3 (oracle lhu t4/t5/t6 batched; idN = morphed addrs) */
        DRAWC_VTZ(sd, id0, id1, id2);
        
      }
      {
        int clipW = (sd->head).clipW;
        int clipH = (sd->head).clipH;
        if ((clipW < sd->dvx0) && (clipW < sd->dvx1) && (clipW < sd->dvx2)) continue;
        if ((sd->dvx0 < 0) && (sd->dvx1 < 0) && (sd->dvx2 < 0)) continue;
        if ((clipH < sd->dvy0) && (clipH < sd->dvy1) && (clipH < sd->dvy2)) continue;
        if ((sd->dvy0 < 0) && (sd->dvy1 < 0) && (sd->dvy2 < 0)) continue;
        if (((sd->vt0).z < 0) && ((sd->vt1).z < 0) && ((sd->vt2).z < 0)) continue;
      }
      gte_avsz3();
      gte_stOTZm(sd->otz);
      sd->otz = sd->otz + sd->sub_otz;
      if (sd->otz < 0) continue;
      if (sd->sub_otSize < sd->otz) continue;
      if ((((u_short)facet->flag & 0x3f3) != 0) && (*(int *)&sd->ePmx1 != 0)) {
        {
          short *z = (short *)&Nvertice[facet->vertexId0];
          short t1 = z[0];
          short t2 = z[1];
          short t3 = z[2];
          (sd->vt0).x = t1;
          (sd->vt0).y = t2;
          (sd->vt0).z = t3;
        }
        {
          short *z = (short *)&Nvertice[facet->vertexId1];
          short t1 = z[0];
          short t2 = z[1];
          short t3 = z[2];
          (sd->vt1).x = t1;
          (sd->vt1).y = t2;
          (sd->vt1).z = t3;
        }
        {
          short *z = (short *)&Nvertice[facet->vertexId2];
          short t1 = z[0];
          short t2 = z[1];
          short t3 = z[2];
          (sd->vt2).x = t1;
          (sd->vt2).y = t2;
          (sd->vt2).z = t3;
        }
        DRAWC_OTLINK_MODE(sd, "84", "88", "92");
        DRAWC_OTLINK_FT3(sd, prim);
        DRAWC_OTLINK_MODE(sd, "72", "76", "80");
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          *(u_int *)&prim->x0 = xy0;
          *(u_int *)&prim->x1 = xy1;
          *(u_int *)&prim->x2 = xy2;
        }
        {
          u_long color = sd->eColor0;
          u_char code = 0x26;
          *(u_int *)&prim->r0 = color;
          prim->code = code;
        }
        {
          u_short clut = (sd->ePmx1).clut;
          u_short tpage = (sd->ePmx1).tpage;
          prim->clut = clut;
          prim->tpage = tpage;
        }
        DRAWC_UVTINT_VT(sd, prim);
      }
      if (*(int *)&sd->ePmx0 != 0) {
        DRAWC_OTLINK_FT3(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          *(u_int *)&prim->x0 = xy0;
          *(u_int *)&prim->x1 = xy1;
          *(u_int *)&prim->x2 = xy2;
        }
        {
          u_long color = sd->eColor0;
          u_char code = 0x26;
          *(u_int *)&prim->r0 = color;
          prim->code = code;
        }
        {
          u_short clut = (sd->ePmx0).clut;
          u_short tpage = (sd->ePmx0).tpage;
          prim->clut = clut;
          prim->tpage = tpage;
        }
        {
          u_char u = (sd->ePmx0).u0 + 0x40;
          u_char v = (sd->ePmx0).v0;
          /* idN are morphed addresses: tV[id].u/v = 0xd6/0xd7(idN) (oracle t9/t8/t3) */
          DRAWC_UVTINT_ID(sd, prim, id0, id1, id2);
        }
      }
      /* W76-A7 (21B-3 born-in-the-loop): `code = 0x24` is assigned HERE,
       * inside the loop AFTER the two 0x26 blocks, so both constants are
       * LICM movables hoisted in APPEARANCE order = retail's preheader
       * `li t3,38; li s4,36`.  The case-scope `= 0x24` initialiser (w73
       * landing (6), measured at the 76 basin) emitted li 36 in the ENTRY
       * block ahead of the 38 hoist -- the final 2 diffs.  `code` is
       * read-only in this tail; per-iteration re-assign is identical. */
      code = 0x24;
      DRAWC_OTLINK_FT3(sd, prim);
      {
        long xy0 = *(long *)&sd->dvx0;
        long xy1 = *(long *)&sd->dvx1;
        long xy2 = *(long *)&sd->dvx2;
        *(u_int *)&prim->x0 = xy0;
        *(u_int *)&prim->x1 = xy1;
        *(u_int *)&prim->x2 = xy2;
      }
      {
        u_long color = sd->color;

        *(u_int *)&prim->r0 = color;
        prim->code = code;
      }
      {
        Draw_tPixMap *pmx = sd->pmxStart + facet->textureIndex;
        u_short clut = pmx->clut;
        u_short tpage = pmx->tpage;
        u_short uv0;
        u_short uv1;
        u_short uv2;
        prim->clut = clut;
        prim->tpage = tpage;
        uv0 = *(u_short *)&facet->uv0;
        uv1 = *(u_short *)&facet->uv1;
        uv2 = *(u_short *)&facet->uv2;
        *(u_short *)&prim->u0 = uv0;
        *(u_short *)&prim->u1 = uv1;
        *(u_short *)&prim->u2 = uv2;
      }
    }
  }
  case 8: {
    /* SYM block line=449 {prim,overlayFlag,facetFlag,facet,id0,id1,id2} --
     * literal repeated SYM names redeclared per case (wave-9 lever); loop
     * rebuilt as while+continue chains per the oracle (0x800C25D0..). */
    POLY_FT3 *prim;
    int overlayFlag;
    int overlayRaw;
    /* SYM-TYPE-OVERRIDE: facetFlag -- this block's SHORT record is current
       FAIL 15 at 1878/1877; the widened promoted carrier is required. */
    int facetFlag;
    Transformer_zFacet *facet;
    int id0;
    int id1;
    int id2;
    int facet_flag;
    int sd_otz;
    while( true ) {
      i = i - 1;
      if (i == -1) {
        return;
      }
      facet = obj->facet + i;
      id0 = facet->vertexId0;
      id1 = facet->vertexId1;
      id2 = facet->vertexId2;
      if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
      /* SYM 3.8b: id0-2 morph index->address in place (oracle sll aN,aN,3) */
      id0 = id0 * 8; id0 = id0 + (int)sd;
      id1 = id1 * 8;
      id1 = id1 + (int)sd;
      id2 = id2 * 8;
      id2 = id2 + (int)sd;
      gte_ldVXY0m(*(u_int *)(id0 + 0xd0));
      gte_ldVZ0m(*(u_int *)(id0 + 0xd4));
      gte_ldVXY1m(*(u_int *)(id1 + 0xd0));
      gte_ldVZ1m(*(u_int *)(id1 + 0xd4));
      gte_ldVXY2m(*(u_int *)(id2 + 0xd0));
      gte_ldVZ2m(*(u_int *)(id2 + 0xd4));
      gte_rtpt();
      gte_nclip();
      gte_stMAC0m(sd->bfct);
      {
        int bfct = sd->bfct;
        if ((sd->head).mirror != 0) {
          bfct = -bfct;
        }
        if (bfct < 1) continue;
      }
      gte_stSXY0m(sd->dvx0);
      gte_stSXY1m(sd->dvx1);
      gte_stSXY2m(sd->dvx2);
      {
        /* load-3/store-3 (oracle lhu t4/t5/t6 batched; idN = morphed addrs) */
        DRAWC_VTZ(sd, id0, id1, id2);
        
      }
      {
        int clipW = (sd->head).clipW;
        int clipH = (sd->head).clipH;
        if ((clipW < sd->dvx0) && (clipW < sd->dvx1) && (clipW < sd->dvx2)) continue;
        if ((sd->dvx0 < 0) && (sd->dvx1 < 0) && (sd->dvx2 < 0)) continue;
        if ((clipH < sd->dvy0) && (clipH < sd->dvy1) && (clipH < sd->dvy2)) continue;
        if ((sd->dvy0 < 0) && (sd->dvy1 < 0) && (sd->dvy2 < 0)) continue;
        if (((sd->vt0).z < 0) && ((sd->vt1).z < 0) && ((sd->vt2).z < 0)) continue;
      }
      gte_avsz3();
      gte_stOTZm(sd->otz);
      /* raw<<16 kept live: the facetFlag<0 rescale is sra 24 of the SAME shifted
       * value (oracle lhu; sll 16; sra 16 ... sra 24 -- single table read) */
      overlayRaw = (u_short)DrawC_gOverlay[facet->textureIndex]; overlayRaw = overlayRaw << 0x10;
      overlayFlag = overlayRaw >> 0x10;
      if (overlayFlag != 0) {
        facetFlag = *(short *)facet;
        sd_otz = sd->otz;
        overlayFlag = overlayFlag & 0xff;
        if (facetFlag < 0) {
          overlayFlag = overlayRaw >> 0x18;
        }
        sd_otz = sd_otz + sd->sub_otz;
        if ((overlayFlag & 0x40) != 0) {
          sd_otz = sd_otz - 2;
        }
        if (sd_otz < 0) continue;
        if (sd->sub_otSize < sd_otz) continue;
        {
          /* two pseudos: ff computed (v1), facet_flag the live copy (t1) --
           * oracle andi v1,4095; addu t1,v1,zero; srl v0,v1,4 */
          int ff = facetFlag & 0xfff; int hi = facetFlag & 0x3f0;
          facet_flag = ff;
          if (hi != 0) {
            /* W75-A7: launders INSIDE the guard body (same lever as the two
             * DrawC_Prim sites; -2 each here).  reorg.c:685 stop_search_p
             * fires at ANY asm, so a launder standing between the ff copy
             * and the beqz walls the backward scan off from the copy and
             * reorg eager-steals the following srl instead.  Inside the body
             * the launders still break the cse collapse that would delete
             * the copy, but the slot is reachable again. */
            __asm__("" : "=r"(facet_flag) : "0"(facet_flag)); __asm__("" : "=r"(ff) : "0"(ff));
            overlayFlag = overlayFlag & ((u_int)ff >> 4);
          if (overlayFlag != 0) {
            while ((overlayFlag & 3) == 0) {
              overlayFlag = overlayFlag >> 2;
            }
          }
          }
        }
        sd->otz = sd_otz;
      }
      else {
        sd->otz = sd->otz + sd->sub_otz;
        if (sd->otz < 0) continue;
        if (sd->sub_otSize < sd->otz) continue;
        facet_flag = (u_short)facet->flag & 0xfff;
      }
      if ((overlayFlag & 3) != 0) {
        /* SYM block line=550 {index,which,facetOverlay} -- FT3B overlay variant */
        int index = facet->textureIndex;
        int which = (overlayFlag & 3) - 1;
        Transformer_zOverlay *facetOverlay = overlay + (index * 3 + which);
        prim = (POLY_FT3 *)(sd->head).cprim.PrimPtr;
        DRAWC_OTLINK_FT3B(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          *(u_int *)&prim->x0 = xy0;
          *(u_int *)&prim->x1 = xy1;
          *(u_int *)&prim->x2 = xy2;
        }
        {
          u_long color = 0x808080;
          u_char code;
          if ((overlayFlag & 0x80) == 0) {
            color = sd->color;
          }
          if ((facet_flag & 1) != 0) {
            code = 0x26;
          } else { code = 0x24; }
          *(u_int *)&prim->r0 = color;
          prim->code = code;
        }
        {
          Draw_tPixMap *pmx = sd->pmxStart + (facet->textureIndex + facetOverlay->offset);
          u_char u = facetOverlay->u;
          u_char v = facetOverlay->v;
          u_short clut = pmx->clut;
          u_short tpage = pmx->tpage;
          prim->clut = clut;
          prim->tpage = tpage;
          {
            u_char u0 = facet->uv0.u + u;
            u_char u1 = facet->uv1.u + u;
            u_char u2 = facet->uv2.u + u;
            prim->u0 = u0;
            prim->u1 = u1;
            prim->u2 = u2;
          }
          {
            u_char v0 = facet->uv0.v + v;
            u_char v1 = facet->uv1.v + v;
            u_char v2 = facet->uv2.v + v;
            prim->v0 = v0;
            prim->v1 = v1;
            prim->v2 = v2;
          }
        }
      }
      else {
        DRAWC_OTLINK_FT3(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          *(u_int *)&prim->x0 = xy0;
          *(u_int *)&prim->x1 = xy1;
          *(u_int *)&prim->x2 = xy2;
        }
        {
          u_long color = 0x808080;
          u_char code;
          if ((overlayFlag & 0x80) == 0) {
            color = sd->color;
          }
          if ((facet_flag & 1) != 0) {
            code = 0x26;
          } else { code = 0x24; }
          *(u_int *)&prim->r0 = color;
          prim->code = code;
        }
        {
          Draw_tPixMap *pmx = sd->pmxStart + facet->textureIndex;
          u_short clut = pmx->clut;
          u_short tpage = pmx->tpage;
          u_short uv0;
          u_short uv1;
          u_short uv2;
          prim->clut = clut;
          prim->tpage = tpage;
          uv0 = *(u_short *)&facet->uv0;
          uv1 = *(u_short *)&facet->uv1;
          uv2 = *(u_short *)&facet->uv2;
          *(u_short *)&prim->u0 = uv0;
          *(u_short *)&prim->u1 = uv1;
          *(u_short *)&prim->u2 = uv2;
        }
      }
    }
  }
  case 9: {
    /* SYM block line=609 {prim,overlayFlag,facetFlag,facet,id0,id1,id2} --
     * literal repeated SYM names redeclared per case (wave-9 lever); loop
     * rebuilt as while+continue chains per the oracle (0x800C2AB4..). */
    POLY_FT3 *prim;
    int overlayFlag;
    int overlayRaw;
    /* SYM-TYPE-OVERRIDE: facetFlag -- this block's SHORT record independently
       measures FAIL 15 at 1878/1877; the widened promoted carrier is required. */
    int facetFlag;
    Transformer_zFacet *facet;
    int id0;
    int id1;
    int id2;
    int facet_flag;
    int sd_otz;
    while( true ) {
      i = i - 1;
      if (i == -1) {
        return;
      }
      facet = obj->facet + i;
      id0 = facet->vertexId0;
      id1 = facet->vertexId1;
      id2 = facet->vertexId2;
      if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
      /* SYM 3.8b: id0-2 morph index->address in place (oracle sll aN,aN,3) */
      /* W76-A7 JOINT CELL, id2 half (closes the W75 t1<->t8 certificate):
       * the target-only read fence (24E-3) adds ONE loop-weighted mention ->
       * id2 refs 18->20, pri .3600->.3980, outranks id1/id0 and takes $t1
       * like retail.  Load+morph order restored to id0,id1,id2 = retail's
       * lbu/sll order (the id2-first order was the w73 66-basin optimum;
       * dead at this basin, 04Z).  The facet_flag half is the clobber-
       * launder in the FT3B arm below.  allocsim receipt: all four seats ==
       * retail, MATCH 107/107 (scratchpad/w76/A7_allocsim_p6.txt). */
      id0 = id0 * 8; id0 = id0 + (int)sd;
      id1 = id1 * 8; id1 = id1 + (int)sd;
      id2 = id2 * 8; id2 = id2 + (int)sd;
      __asm__("" : : "r"(id2));
      gte_ldVXY0m(*(u_int *)(id0 + 0xd0));
      gte_ldVZ0m(*(u_int *)(id0 + 0xd4));
      gte_ldVXY1m(*(u_int *)(id1 + 0xd0));
      gte_ldVZ1m(*(u_int *)(id1 + 0xd4));
      gte_ldVXY2m(*(u_int *)(id2 + 0xd0));
      gte_ldVZ2m(*(u_int *)(id2 + 0xd4));
      gte_rtpt();
      gte_nclip();
      gte_stMAC0m(sd->bfct);
      {
        int bfct = sd->bfct;
        if ((sd->head).mirror != 0) {
          bfct = -bfct;
        }
        if (bfct < 1) continue;
      }
      gte_stSXY0m(sd->dvx0);
      gte_stSXY1m(sd->dvx1);
      gte_stSXY2m(sd->dvx2);
      {
        /* load-3/store-3 (oracle lhu t4/t5/t6 batched; idN = morphed addrs) */
        DRAWC_VTZ(sd, id0, id1, id2);
        
      }
      {
        int clipW = (sd->head).clipW;
        int clipH = (sd->head).clipH;
        if ((clipW < sd->dvx0) && (clipW < sd->dvx1) && (clipW < sd->dvx2)) continue;
        if ((sd->dvx0 < 0) && (sd->dvx1 < 0) && (sd->dvx2 < 0)) continue;
        if ((clipH < sd->dvy0) && (clipH < sd->dvy1) && (clipH < sd->dvy2)) continue;
        if ((sd->dvy0 < 0) && (sd->dvy1 < 0) && (sd->dvy2 < 0)) continue;
        if (((sd->vt0).z < 0) && ((sd->vt1).z < 0) && ((sd->vt2).z < 0)) continue;
      }
      gte_avsz3();
      gte_stOTZm(sd->otz);
      /* raw<<16 kept live: the facetFlag<0 rescale is sra 24 of the SAME shifted
       * value (oracle lhu; sll 16; sra 16 ... sra 24 -- single table read) */
      overlayRaw = (u_short)DrawC_gOverlay[facet->textureIndex]; overlayRaw = overlayRaw << 0x10;
      overlayFlag = overlayRaw >> 0x10;
      if (overlayFlag != 0) {
        facetFlag = *(short *)facet;
        sd_otz = sd->otz;
        overlayFlag = overlayFlag & 0xff;
        if (facetFlag < 0) {
          overlayFlag = overlayRaw >> 0x18;
        }
        sd_otz = sd_otz + sd->sub_otz;
        if (sd_otz < 0) continue;
        if (sd->sub_otSize < sd_otz) continue;
        {
          /* two pseudos: ff computed (v1), facet_flag the live copy (t1) --
           * oracle andi v1,4095; addu t1,v1,zero; srl v0,v1,4 */
          int ff = facetFlag & 0xfff; int hi = facetFlag & 0x3f0;
          facet_flag = ff;
          if (hi != 0) {
            /* W75-A7: launders INSIDE the guard body (same lever as the two
             * DrawC_Prim sites; -2 each here).  reorg.c:685 stop_search_p
             * fires at ANY asm, so a launder standing between the ff copy
             * and the beqz walls the backward scan off from the copy and
             * reorg eager-steals the following srl instead.  Inside the body
             * the launders still break the cse collapse that would delete
             * the copy, but the slot is reachable again. */
            __asm__("" : "=r"(facet_flag) : "0"(facet_flag)); __asm__("" : "=r"(ff) : "0"(ff));
            overlayFlag = overlayFlag & ((u_int)ff >> 4);
          if (overlayFlag != 0) {
            while ((overlayFlag & 3) == 0) {
              overlayFlag = overlayFlag >> 2;
            }
          }
          }
        }
        sd->otz = sd_otz;
      }
      else {
        sd->otz = sd->otz + sd->sub_otz;
        if (sd->otz < 0) continue;
        if (sd->sub_otSize < sd->otz) continue;
        facet_flag = (u_short)facet->flag & 0xfff;
      }
      if ((envmap & 0x20U) != 0) {
        if ((facet_flag & 1) != 0) continue;
      }
      if (((facet_flag & 0x3f3) != 0) && (*(int *)&sd->ePmx1 != 0)) {
        {
          short *z = (short *)&Nvertice[facet->vertexId0];
          short t1 = z[0];
          short t2 = z[1];
          short t3 = z[2];
          (sd->vt0).x = t1;
          (sd->vt0).y = t2;
          (sd->vt0).z = t3;
        }
        {
          short *z = (short *)&Nvertice[facet->vertexId1];
          short t1 = z[0];
          short t2 = z[1];
          short t3 = z[2];
          (sd->vt1).x = t1;
          (sd->vt1).y = t2;
          (sd->vt1).z = t3;
        }
        {
          short *z = (short *)&Nvertice[facet->vertexId2];
          short t1 = z[0];
          short t2 = z[1];
          short t3 = z[2];
          (sd->vt2).x = t1;
          (sd->vt2).y = t2;
          (sd->vt2).z = t3;
        }
        DRAWC_OTLINK_MODE(sd, "84", "88", "92");
        DRAWC_OTLINK_FT3(sd, prim);
        DRAWC_OTLINK_MODE(sd, "72", "76", "80");
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          *(u_int *)&prim->x0 = xy0;
          *(u_int *)&prim->x1 = xy1;
          *(u_int *)&prim->x2 = xy2;
        }
        {
          u_long color = sd->eColor0;
          u_char code = 0x26;
          *(u_int *)&prim->r0 = color;
          prim->code = code;
        }
        {
          u_short clut = (sd->ePmx1).clut;
          u_short tpage = (sd->ePmx1).tpage;
          prim->clut = clut;
          prim->tpage = tpage;
        }
        DRAWC_UVTINT_VT(sd, prim);
      }
      if (*(int *)&sd->ePmx0 != 0) {
        DRAWC_OTLINK_FT3(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          *(u_int *)&prim->x0 = xy0;
          *(u_int *)&prim->x1 = xy1;
          *(u_int *)&prim->x2 = xy2;
        }
        if ((overlayFlag & 1) != 0) {
          *(u_int *)&prim->r0 = sd->eColor2;
        }
        else if ((facet_flag & 4) != 0) {
          *(u_int *)&prim->r0 = sd->eColor1;
        }
        else {
          *(u_int *)&prim->r0 = sd->eColor0;
        }
        prim->code = 0x26;
        {
          u_short clut = (sd->ePmx0).clut;
          u_short tpage = (sd->ePmx0).tpage;
          prim->clut = clut;
          prim->tpage = tpage;
        }
        {
          u_char u = (sd->ePmx0).u0 + 0x40;
          u_char v = (sd->ePmx0).v0;
          /* idN are morphed addresses: tV[id].u/v = 0xd6/0xd7(idN) (oracle t9/t8/t3) */
          DRAWC_UVTINT_ID(sd, prim, id0, id1, id2);
        }
      }
      if ((overlayFlag & 3) != 0) {
        /* SYM block {index,which,facetOverlay} -- FT3B overlay variant */
        int index = facet->textureIndex;
        int which = (overlayFlag & 3) - 1;
        Transformer_zOverlay *facetOverlay = overlay + (index * 3 + which);
        /* W76-A7 JOINT CELL, facet_flag half: tied launder carrying
         * $9/$10/$11 CLOBBERS = zero-insn hard-reg denial (20B/22B-1).
         * facet_flag (pri .5581, served first) is denied t1-t3; t4-t7 are
         * template regs; it lands in retail's $t8, freeing $t1 for the
         * fenced id2.  Position laws, all three load-bearing: (a) it sits
         * where id0-2 are DEAD (21A-1: a clobber denies every allocno live
         * at the asm -- at the old launder site the ids are live and lose
         * t1-t3 too); (b) INSIDE the arm, so the ePmx0-guard beqz slot can
         * still steal `andi v0,a2,3` (24D-6 stop_search_p: at the thread
         * head it walled the steal, +1 nop); (c) it READS facetOverlay so
         * sched1 cannot float it to the block head (24D-7: a no-dependency
         * asm is PLACED FIRST and walls the (overlayFlag&3) beqz slot's
         * steal of `addiu a0,v0,-1` -- measured +1 nop without the operand;
         * the arm block is <=3 qtys so the extra facetOverlay ref cannot
         * reorder its handout, 15A).  The W75 "20B clobber on facet_flag's
         * launder = +1 insn" falsification was position- and basin-relative
         * (old site, no read anchor, no id2 fence): 23B-3/04Z. */
        __asm__("" : "=r"(facet_flag) : "0"(facet_flag), "r"(facetOverlay) : "$9", "$10", "$11");
        prim = (POLY_FT3 *)(sd->head).cprim.PrimPtr;
        DRAWC_OTLINK_FT3B(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          *(u_int *)&prim->x0 = xy0;
          *(u_int *)&prim->x1 = xy1;
          *(u_int *)&prim->x2 = xy2;
        }
        {
          u_long color = sd->color;
          u_char code = 0x24;
          if ((facet_flag & 1) != 0) {
            code = 0x26;
          }
          *(u_int *)&prim->r0 = color;
          prim->code = code;
          if ((facet_flag & 1) != 0) {
            prim->code = code | 2;
          }
        }
        {
          Draw_tPixMap *pmx = sd->pmxStart + (facet->textureIndex + facetOverlay->offset);
          u_char u = facetOverlay->u;
          u_char v = facetOverlay->v;
          u_short clut = pmx->clut;
          u_short tpage = pmx->tpage;
          prim->clut = clut;
          prim->tpage = tpage;
          {
            u_char u0 = facet->uv0.u + u;
            u_char u1 = facet->uv1.u + u;
            u_char u2 = facet->uv2.u + u;
            prim->u0 = u0;
            prim->u1 = u1;
            prim->u2 = u2;
          }
          {
            u_char v0 = facet->uv0.v + v;
            u_char v1 = facet->uv1.v + v;
            u_char v2 = facet->uv2.v + v;
            prim->v0 = v0;
            prim->v1 = v1;
            prim->v2 = v2;
          }
        }
      }
      else {
        DRAWC_OTLINK_FT3(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          *(u_int *)&prim->x0 = xy0;
          *(u_int *)&prim->x1 = xy1;
          *(u_int *)&prim->x2 = xy2;
        }
        {
          u_long color = sd->color;
          u_char code = 0x24;
          if ((facet_flag & 1) != 0) {
            code = 0x26;
          }
          *(u_int *)&prim->r0 = color;
          prim->code = code;
        }
        {
          Draw_tPixMap *pmx = sd->pmxStart + facet->textureIndex;
          u_short clut = pmx->clut;
          u_short tpage = pmx->tpage;
          u_short uv0;
          u_short uv1;
          u_short uv2;
          prim->clut = clut;
          prim->tpage = tpage;
          uv0 = *(u_short *)&facet->uv0;
          uv1 = *(u_short *)&facet->uv1;
          uv2 = *(u_short *)&facet->uv2;
          *(u_short *)&prim->u0 = uv0;
          *(u_short *)&prim->u1 = uv1;
          *(u_short *)&prim->u2 = uv2;
        }
      }
    }
  }
  }
  return;
}

/* ---- DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache  [DRAWC.CPP:3551-3869] SLD-VERIFIED ---- */
void DrawC_PrimMenu(matrixtdef *m,coorddef *t,Transformer_zObj *obj,Transformer_zOverlay *overlay,
               int envmap,Draw_CarCache *sd)

{
  /* rule-8 rewrite (w41-a3) -- the PrimHalo 322->29 recipe applied whole.
     SYM DrawC_PrimMenu: fsize 48, mask $807f0000 = s0-s6 + ra, and REGPARM
     m($s0) t($s2) obj($s3) overlay($s5), REG envmap($s4) sd($s1).  Named
     locals, by block:
       fn        i($t8)  Nvertice($v1)
       loop-1    vt($a3) | {u($v1) v($v0)} | {t1($v0) t2($v1) t3($a0)}
       matrix    3x {r0 r1 r2}
       loop-2    vt($a3) tV($t0) | {t1($v1) t2($v0) t3($a0)}
       facet     prim($a3) facetFlag($t3) overlayFlag($a1) facet($t0)
                 id0($t2) id1($t1) id2($a2) | {bfct($v1)}
       env arm   {xy0 xy1 xy2} {color code} {clut tpage}
       ovl arm   {index($v1) which($a0) facetOverlay($a2)} {xy0-2}
                 {color($v1) code($a1)} {pmx($v0)} {u0-2 v0-2 u v clut tpage}
       plain arm {xy0-2} {color($v0) code($a1)} {pmx($v1)} {u0-2 v0-2 u v
                 clut($a0) tpage($v0)} | {uv0-2 pmx($v1) clut($v0) tpage($v1)}
     Every Ghidra iVarN/uVarN/puVarN/psVarN temp is purged (~40 of them).  Both
     vertex-cache loops use the SYM `PCOORD16 *tV`; loop 1 addresses the two
     bytes of its `p` halfword as the stored u/v pair.
     Retail reuses the DYING $s2 (the `t` param) for the DrawC_gOverlay base,
     which is why the frame is 48 with only 7 saved regs. */
  int i;
  COORD16 *Nvertice;

  Nvertice = obj->Nvertex;
  if ((envmap & 1U) != 0) {
    COORD16 *vt;
    /* PASS 480/480: the SYM `PCOORD16` walker has the required eight-byte
     * stride.  Its `p` field occupies offsets 6..7, so byte access to `p`
     * expresses the retail u/v stores without inventing a second structure
     * type.  loop.c eliminates the typed walker biv and emits the offset-7 giv
     * after the other preheader invariants, exactly as retail. */
    PCOORD16 *tV;

    vt = Nvertice;
gte_SetRotMatrix(&DrawC_gMatA);
gte_SetTransMatrix(&DrawC_gMatA);
    i = (u_int)obj->numVertex;   /* SYM: ONE fn-scope `i` (t8) counts ALL 3 loops */
    tV = (PCOORD16 *)sd->tV;
    /* exit-in-the-middle: keeps the top dec+test + unconditional j back (no rotation),
     * and the after-join reg-reg compare beats the nor/~x const-fold */
    while (1) {
      i = i - 1;
      if (i == -1) break;   /* literal: SYM names no sentinel local */
      {
        int u, v;
        {
          short t1, t2, t3;
          t1 = vt->x;
          t2 = vt->y;
          t3 = vt->z;
          (sd->vt0).x = t1;
          (sd->vt0).y = t2;
          (sd->vt0).z = t3;
        }
gte_ldv0((char *)sd + 0xac);
        gte_rt();
gte_stlvnl((char *)sd + 0x9c);
        v = (sd->tv).vz;
        u = (sd->tv).vx;
        if (v < 0) {
          v = -v;
        }
        vt = vt + 1;
        ((char *)&tV->p)[0] = (char)u;
        ((char *)&tV->p)[1] = (char)v;
        tV = tV + 1;
      }
    }
  }
  TrsProj_SetTransPrecision(8);
  /* load-3/shift-3/store-3 per row (oracle batches lw x3 -> sra x3 -> sh x3);
   * row1 stored POSITIVE first, then the middle column negated: [1][0] via the
   * still-live temp (negu reg), [1][1]/[1][2] via lhu read-modify-write. */
  {
    int r0 = m->m[0] >> 4;
    int r1 = m->m[3] >> 4;
    int r2 = m->m[6] >> 4;
    (sd->matB).m[0][0] = (short)r0;
    (sd->matB).m[0][1] = (short)r1;
    (sd->matB).m[0][2] = (short)r2;
  }
  {
    int r0 = m->m[1] >> 4;
    int r1 = m->m[4] >> 4;
    int r2 = m->m[7] >> 4;
    (sd->matB).m[1][0] = (short)r0;
    (sd->matB).m[1][1] = (short)r1;
    (sd->matB).m[1][2] = (short)r2;
  }
  {
    /* identity-then-tweak (PrimHalo-proven, w39-a3): row 1 is stored POSITIVE
       above and negated IN PLACE here -- carrying the value in an r0/iVarN
       temp across the block boundary lengthens its live range and rotates the
       whole {r0,r1,r2} triple off the SYM's per-block registers. */
    int r0 = m->m[2] >> 4;
    int r1 = m->m[5] >> 4;
    int r2 = m->m[8] >> 4;
    (sd->matB).m[1][0] = -(sd->matB).m[1][0];
    (sd->matB).m[2][0] = (short)r0;
    (sd->matB).m[2][1] = (short)r1;
    (sd->matB).m[2][2] = (short)r2;
    (sd->matB).m[1][1] = -(sd->matB).m[1][1];
    (sd->matB).m[1][2] = -(sd->matB).m[1][2];
  }
  /* TrsProj_precision loaded AT-USE, one lw CSE'd across the 3 sravs; the former
   * `& 0x1f` shift-count masks were a Ghidra transcription artifact (catalog SC) */
  (sd->matB).t[0] = t->x >> TrsProj_precision;
  (sd->matB).t[1] = -(t->y >> TrsProj_precision);
  (sd->matB).t[2] = t->z >> TrsProj_precision;
  TrsProj_ResetTransPrecision();
gte_SetRotMatrix(((char *)sd + 0x14));
gte_SetTransMatrix(((char *)sd + 0x14));
  {
    COORD16 *vt;
    PCOORD16 *tV;

    tV = (PCOORD16 *)sd->tV;
    vt = obj->vertex;
    i = (u_int)obj->numVertex;
    while (1) {
      i = i - 1;
      if (i == -1) break;
      {
        short t1, t2, t3;
        /* y,z read first (SYM has t2 in $v0 here, t1 in $v1 -- the reverse of
           loop 1); x read LAST but BEFORE the walk, so no scratch copy of vt */
        t2 = vt->y;
        t3 = vt->z;
        t1 = vt->x;
        tV->x = t1;
        tV->y = t2;
        tV->z = t3;
      }
      vt = vt + 1;
      tV = tV + 1;
    }
  }
  i = (u_int)obj->numFacet;   /* gOverlay base: NO local (SYM) -- gcc LIM hoists the la */
  /* flat facet loop (oracle .L800C3550/.L800C3554): dec+test at top with a FRESH -1
   * temp each iteration (not hoisted); every skip path is a plain `continue` -- gcc's
   * delay-slot compensation reproduces the dec-in-slot / undo split by itself.
   * NO explicit byte offset: SYM names no such local -- `obj->facet + i` and gcc's
   * strength reduction creates the t9 giv (i*12, decremented alongside the counter) */
  for (;;) {
    POLY_FT3 *prim;
    /* SYM-TYPE-OVERRIDE: facetFlag -- the debug record says short, but using
       short changes the frame and register allocation (PASS480 -> 113 diffs).
       The widened masked value below is the measured retail codegen carrier. */
    u_int facetFlag;   /* SYM $t3 = flag & 0xfff (the MASKED value), not the raw field */
    u_short rawFlag; /* SYM-CODEGEN-CARRIER: rawFlag -- separate unmasked flag preserves retail priority; adding it to the tex fence is FAIL 14 */
    int overlayFlag;
    Transformer_zFacet *facet;
    int id0;
    int id1;
    int id2;

    i = i - 1;
    if (i == -1) {
      return;
    }
    facet = obj->facet + i;
    id0 = facet->vertexId0;
    id1 = facet->vertexId1;
    id2 = facet->vertexId2;
    if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
    /* index -> slot-base IN-PLACE (oracle sll t2,3; addu t2,t2,s1 -- same reg morphs;
     * the bases then feed the lwc2 disps 0xD0/0xD4 AND the envmap uv lbu's 0xD6/0xD7
     * across the OT templates) */
    id0 = id0 * 8;   /* TWO in-place stmts per vertex: same pseudo -> sll t2,t2,3;
                      * addu t2,t2,s1 (a fused a*8+b stages through a fresh temp) */
    id0 = id0 + (int)sd;
    id1 = id1 * 8;
    /* MATCH (w46-a3, allocsim required-delta): the id0/id1/id2 + overlayFlag
     * 3-cycle (retail id0=$t2 id1=$t1 id2=$a2 overlayFlag=$a1) is decided by
     * allocno_compare -- all three ids have refs 18 / live 91,98,101, so OUR
     * order is id0,id1,id2 and retail's is id2,id1,id0.  The floor_log2
     * REF-STEP dial (catalog w44/w45 sec.A0) reverses it at ZERO instructions:
     * one do{}while(0) depth level doubles the wrapped refs (loop weight
     * 2->4), so wrapping id1's `+= sd` gives refs 18->20 and wrapping BOTH of
     * id2's in-place statements gives 18->22:
     *     id0 4*18/ 91 = .7912   id1 4*20/ 98 = .8163   id2 4*22/101 = .8712
     * -> allocation order id2,id1,id0 -> a2,t1,t2 = retail.  Verified against
     * tools/allocsim.py (43/43 on this fn) AND in the real -dl dump. */
    do { id1 = id1 + (int)sd; } while (0);
    do { id2 = id2 * 8; } while (0);
    do { id2 = id2 + (int)sd; } while (0);
    gte_ldVXY0m(*(u_int *)(id0 + 0xD0));
    gte_ldVZ0m(*(u_int *)(id0 + 0xD4));
    gte_ldVXY1m(*(u_int *)(id1 + 0xD0));
    gte_ldVZ1m(*(u_int *)(id1 + 0xD4));
    gte_ldVXY2m(*(u_int *)(id2 + 0xD0));
    gte_ldVZ2m(*(u_int *)(id2 + 0xD4));
    {
      int bfct;   /* SYM block 103-123: ONE $v1 pseudo carries the backface area
                     AND then the composed otz (the block spans both tests) */
      gte_rtpt();
      gte_nclip();
      gte_stMAC0m(sd->bfct);
      bfct = sd->bfct;
      if ((sd->head).mirror != 0) {
        bfct = -bfct;
      }
      if (bfct < 1) continue;
      gte_stSXY0m(sd->dvx0);
      gte_stSXY1m(sd->dvx1);
      gte_stSXY2m(sd->dvx2);
      gte_avsz3();
      gte_stOTZm(sd->otz);
      bfct = sd->otz + sd->sub_otz;
      sd->otz = bfct;
      if (bfct < 0) continue;
      if (sd->sub_otSize < bfct) continue;
    }
    /* MATCH (w53-a2, 11 -> 2, count-exact 480/480).  THREE cooperating edits, in
       this order; the 3rd is the one that closes it and it is REF-COUNT sensitive:
        (a) `vt = Nvertice;` hoisted ABOVE the two gte_Set*Matrix macros in the
            envmap pre-loop (retail emits `addu a3,v1,zero` as the FIRST insn of the
            envmap arm, ours emitted it after the whole ctc2 block).  11 -> 9.
        (b) a block-local `tex` temp so the textureIndex lbu and the flag lhu are
            two adjacent loads of the SAME base (facet) -- alone: NO-OP (9).
        (c) 🔑 a ZERO-INSN USE FENCE on `tex` ONLY, between the two loads and the
            gOverlay index chain.  An operand-less `__asm__` is implicitly volatile
            = a sched barrier, so the flag lhu can no longer SINK past the
            gOverlay chain (retail: `lbu v0,2(t0); lhu a0,0(t0); sll v0,v0,1`,
            ours had `lbu; sll; addu; lhu(gOverlay); sll; lhu(flag)`).  9 -> 2.
       ⚠️ THE FENCE MUST NOT LIST rawFlag.  `__asm__("" : : "r"(tex), "r"(rawFlag))`
       fixes the SCHEDULE identically (count-exact 480/480) but the extra REF on
       rawFlag lifts its allocno priority (floor_log2(4)*4 vs floor_log2(3)*3) so it
       takes $v1 and the gOverlay shift temp is pushed to $a0 -- retail is the other
       way round -> 14 diffs.  Fencing `tex` alone leaves rawFlag at 3 refs and the
       whole v1/a0 pair lands retail-exact.  (Fence-dial law, catalog w49/w50/w52-a2:
       a read-only fence DEMOTES; here we want NO promotion at all on rawFlag.)
       RESIDUAL 2 = the loop-1 preheader EMISSION-ORDER tie on `addiu a2,s1,215`
       (tVc): ours emits it with the source statements (before the LICM movables
       `li -1`/`addiu 172`/`addiu 156`), retail emits it AFTER them and before the
       `addiu a1,a3,4` giv -- i.e. retail's tVc cursor was created by STRENGTH
       REDUCTION (givs are appended after LICM movables), not written as a
       preheader assignment.  FALSIFIED at this basin: index form `sd->tV[n].u/.v`
       + `n++` (6 -- the giv DOES land in retail's slot but with base sd+0 and
       displacements 214/215 instead of retail's base sd+215 / -1,0); the same
       index form with an in-loop `char *tVc = &sd->tV[n].v;` (29).  NEXT ANGLE:
       an index form whose giv address is the `.v` field (write `.v` before `.u`,
       or index a `char*` view based at &sd->tV[0].v) so SR bases the giv at
       sd+215 -- that is the only remaining shape difference.
       ---- w59-a5 (2026-08-14): THE NAMED NEXT ANGLE IS NOW RUN AND FALSIFIED,
       both spellings, from the 2-diff basin:
         (a) `char *`-view INDEX form based at the `.v` field --
             `(&sd->tV[0].v)[tVn - 1] = u; (&sd->tV[0].v)[tVn] = v; tVn += 8;`
             = 6 @480.  gcc does NOT fold the +215 into the giv's add_val: it
             emits `addu v0,a3,s1` INSIDE the loop and keeps disps 214/215
             (i.e. the same base-sd+0 combine_givs outcome as the w53 `.u/.v`
             index probe, plus one extra in-loop insn).
         (b) SINGLE-giv form (one address pseudo, disps -1/0) --
             `{ char *tVc = &sd->tV[0].v + tVn; tVc[-1]=u; *tVc=v; } tVn += 8;`
             = 30 @482.  `tVn` survives as its own biv (`addu a3,zero,zero` in
             the preheader) and the loop-1 vertex walker rotates a3<->a2.
       ⇒ every INDEX spelling makes the +215 a memory DISPLACEMENT, never the
       giv's add_val; only a pointer BIV puts sd+215 in a register, and a biv's
       init is a source statement, which by construction precedes the preheader's
       LICM movables.  The remaining shape difference is therefore NOT reachable
       by rewriting this cursor: retail's `addiu a2,s1,215` sits in the movable
       band, so retail's source computed that address INSIDE the loop body (an
       invariant that LICM hoists in order-of-appearance -- it appears LAST,
       after the 172/156 gte-macro addresses, which is exactly the retail order).
       NEXT ANGLE (named, untried): an in-loop invariant base whose giv init
       COALESCES with it, e.g. spell the two byte stores through a block-local
       `char *tVb = &sd->tV[0].v;` declared at the END of the body with the
       varying part carried by a SEPARATE stepped pointer that dies immediately
       -- the target RTL is "LICM movable (addiu a2,s1,215) + giv init that is a
       deleted copy", which is the only shape that puts one insn in the movable
       band and none in the giv band. */
    { int tex /* SYM-CODEGEN-CARRIER: tex -- block-local texture byte plus the measured USE fence seals retail scheduling */ = facet->textureIndex;
      rawFlag = facet->flag;
      __asm__("" : : "r"(tex));   /* tex ONLY -- see the ref-count warning above */
      overlayFlag = (int)((u_int)(u_short)DrawC_gOverlay[tex] << 0x10) >> 0x10; }
    facetFlag = rawFlag & 0xfff;
    /* SYM truth: NO `which` at this scope -- the decode MUTATES overlayFlag in
     * place (one pseudo, oracle a1 throughout); `which` is an overlay-arm local.
     * Every mask is written against facetFlag so cc1 CSEs the andi
     * ONCE into facetFlag's own register ($t3) and reuses it for the &4/&1
     * tests in the arms -- exactly retail's `andi t3,a0,4095` in the delay slot. */
    if (overlayFlag != 0) {
      overlayFlag = overlayFlag & 0x3f;
      if ((short)rawFlag < 0) {
        overlayFlag = (int)((u_int)(u_short)DrawC_gOverlay[facet->textureIndex] << 0x10) >> 0x18;
      }
      if (((facetFlag & 0x3f0) != 0) &&
          (overlayFlag = overlayFlag & facetFlag >> 4, overlayFlag != 0)) {
        for (; (overlayFlag & 3) == 0; overlayFlag = overlayFlag >> 2) {
        }
      }
    }
    if ((envmap & 1U) != 0) {
      /* mode-packet OT-link: variant B template (drawModeOff @ sd+0x54) */
      DRAWC_OTLINK_MODE(sd, "84", "88", "92");
      /* FT3 OT-link: split form (prim lw = compiler code at EVERY retail site) */
      prim = (POLY_FT3 *)(sd->head).cprim.PrimPtr;
      DRAWC_OTLINK_FT3B(sd, prim);
      /* mode-packet OT-link: variant B template (drawModeOn @ sd+0x48) */
      DRAWC_OTLINK_MODE(sd, "72", "76", "80");
      {
        long xy0, xy1, xy2;
        xy0 = *(u_int *)&sd->dvx0;
        xy1 = *(u_int *)&sd->dvx1;
        xy2 = *(u_int *)&sd->dvx2;
        *(u_long *)&prim->x0 = xy0;
        *(u_long *)&prim->x1 = xy1;
        *(u_long *)&prim->x2 = xy2;
      }
      {
        u_long color;
        u_char code;
        if ((facetFlag & 4) != 0) {   /* fall-through = the !=0 arm */
          color = sd->eColor1;
          *(u_long *)&prim->r0 = color;
        }
        else {
          color = sd->eColor0;
          *(u_long *)&prim->r0 = color;
        }
        code = 0x26;
        prim->code = code;
      }
      {
        u_short clut, tpage;
        tpage = (sd->ePmx0).tpage;
        clut = (sd->ePmx0).clut;
        prim->clut = clut;
        prim->tpage = tpage;
      }
      {
        /* SYM names NO local for the uv here, but retail DOES hold the base
         * pair across the three vertices ($t6/$t7) -- cc1 will NOT CSE the
         * `ePmx0.u0 + 0x40` / `ePmx0.v0` reads out of the three statements
         * (measured: +9 insns, 6 redundant lbu + 3 addiu), so the base pair
         * has to be two real temps.  `u` keeps char type so `u + '@'` is a
         * bare addiu (u_char would inject an andi 0xff). */
        /* EA expander template (see DRAWC_UVTINT_ID receipt at the top of this TU) */
        DRAWC_UVTINT_ID(sd, prim, id0, id1, id2);
      }
    }
    if ((overlayFlag & 3) != 0) {   /* fall-through = the overlay arm (oracle beqz) */
      int index;
      int which;
      Transformer_zOverlay *facetOverlay;

      which = (overlayFlag & 3) - 1;   /* SYM `which` (a0): the dispatch andi minus 1,
                                        * lands in the beqz delay slot */
      index = facet->textureIndex;     /* SYM `index` (v1): facet texture byte */
      prim = (POLY_FT3 *)(sd->head).cprim.PrimPtr;   /* prim lw = compiler code here:
                                    * retail schedules it INTO the facetOverlay math */
      /* index sum grouped BEFORE the pointer scale (oracle: index*3 + which, ONE <<2) */
      facetOverlay = overlay + (index * 3 + which);
      /* FT3 OT-link: variant A, split form */
      DRAWC_OTLINK_FT3B(sd, prim);
      {
        long xy0, xy1, xy2;
        xy0 = *(u_int *)&sd->dvx0;
        xy1 = *(u_int *)&sd->dvx1;
        xy2 = *(u_int *)&sd->dvx2;
        *(u_long *)&prim->x0 = xy0;
        *(u_long *)&prim->x1 = xy1;
        *(u_long *)&prim->x2 = xy2;
      }
      {
        u_long color;
        u_char code;
        color = sd->color;
        if ((facetFlag & 1) != 0) {
          code = 0x26;
        }
        else {
          code = 0x24;   /* else-arm default -> lands in the beqz delay slot */
        }
        *(u_long *)&prim->r0 = color;
        prim->code = code;
      }
      {
        Draw_tPixMap *pmx;
        u_char u0, u1, u2, v0, v1, v2, u, v;
        u_short clut, tpage;

        pmx = &sd->pmxStart[facet->textureIndex + facetOverlay->offset];
        u = facetOverlay->u;
        v = facetOverlay->v;
        clut = pmx->clut;
        tpage = pmx->tpage;
        prim->clut = clut;
        prim->tpage = tpage;
        /* full tail duplicated with the SAME temps: colors identically -> gcc
         * cross-jump-merges into the retail jump-into-middle form (SLD: per-arm
         * one-line macros at 3866/3869 whose expansions merged) */
        u0 = facet->uv0.u + u;
        u1 = facet->uv1.u + u;
        u2 = facet->uv2.u + u;
        prim->u0 = u0;
        prim->u1 = u1;
        prim->u2 = u2;
        v0 = facet->uv0.v + v;
        v1 = facet->uv1.v + v;
        v2 = facet->uv2.v + v;
        prim->v0 = v0;
        prim->v1 = v1;
        prim->v2 = v2;
      }
      continue;
    }
    else {
      /* FT3 OT-link: split form */
      prim = (POLY_FT3 *)(sd->head).cprim.PrimPtr;
      DRAWC_OTLINK_FT3B(sd, prim);
      {
        long xy0, xy1, xy2;
        xy0 = *(u_int *)&sd->dvx0;
        xy1 = *(u_int *)&sd->dvx1;
        xy2 = *(u_int *)&sd->dvx2;
        *(u_long *)&prim->x0 = xy0;
        *(u_long *)&prim->x1 = xy1;
        *(u_long *)&prim->x2 = xy2;
      }
      {
        u_long color;
        u_char code;
        color = sd->color;
        if ((facetFlag & 1) != 0) {
          code = 0x26;
        }
        else {
          code = 0x24;
        }
        *(u_long *)&prim->r0 = color;
        prim->code = code;
      }
      /* byte path INLINE first (oracle bnez skips it), halfword arm out of
       * line; UV pairs as direct lbu triples (wave-9 lhu->2x lbu fix) */
      if (((envmap & 2U) != 0) && ((facetFlag & 1) == 0)) {
        Draw_tPixMap *pmx;
        u_char u0, u1, u2, v0, v1, v2, u, v;
        u_short clut, tpage;

        u = sd->offsetU0;
        v = sd->offsetV0;
        pmx = &sd->pmxStart[facet->textureIndex];
        clut = pmx->clut;
        tpage = pmx->tpage;
        prim->clut = clut;
        prim->tpage = tpage;
        u0 = facet->uv0.u + u;
        u1 = facet->uv1.u + u;
        u2 = facet->uv2.u + u;
        prim->u0 = u0;
        prim->u1 = u1;
        prim->u2 = u2;
        v0 = facet->uv0.v + v;
        v1 = facet->uv1.v + v;
        v2 = facet->uv2.v + v;
        prim->v0 = v0;
        prim->v1 = v1;
        prim->v2 = v2;
      }
      else {
        u_short uv0, uv1, uv2;
        Draw_tPixMap *pmx;
        u_short clut, tpage;

        pmx = &sd->pmxStart[facet->textureIndex];
        clut = pmx->clut;
        tpage = pmx->tpage;
        prim->clut = clut;
        prim->tpage = tpage;
        uv0 = *(u_short *)&facet->uv0;
        uv1 = *(u_short *)&facet->uv1;
        uv2 = *(u_short *)&facet->uv2;
        *(u_short *)&prim->u0 = uv0;
        *(u_short *)&prim->u1 = uv1;
        *(u_short *)&prim->u2 = uv2;
      }
    }
  }
}

/* ---- DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache  [DRAWC.CPP:3881-3990] SLD-VERIFIED ---- */
void DrawC_PrimHalo(matrixtdef *m,coorddef *t,Transformer_zObj *obj,int type,int index,int reflect,
               Draw_CarCache *sd)

{
  /* rule-8 (w39-a3): SYM DrawC_PrimHalo names exactly i($s5), vertice($fp),
     real_type($s3), facet($s1), id0/id1/id2 ($v1/$a1/$a2 USHORT), the r0/r1/r2
     and z/t1/t2/t3 block triples, bfct, overlayFlag and copyLastPrim($s4).
     The Ghidra iVarN/uVarN soup is gone; each SYM name now carries the value
     the oracle keeps in that register. */
  int i;
  COORD16 *vertice;
  int uVar8; /* SYM-CODEGEN-CARRIER: uVar8 -- in-place real_type reuse is FAIL 97 (295/298) */

  vertice = obj->vertex;   /* oracle: lw fp,0x10(obj) = ->vertex */
  TrsProj_SetTransPrecision(8);
  {
    int r0,r1,r2;
    r0 = m->m[0];
    r1 = m->m[3];
    r2 = m->m[6];
    (sd->matB).m[0][0] = (short)(r0 >> 4);
    (sd->matB).m[0][1] = (short)(r1 >> 4);
    (sd->matB).m[0][2] = (short)(r2 >> 4);
  }
  {
    int r0,r1,r2;
    r0 = m->m[1];
    r1 = m->m[4];
    r2 = m->m[7];
    (sd->matB).m[1][0] = (short)(r0 >> 4);
    (sd->matB).m[1][1] = (short)(r1 >> 4);
    (sd->matB).m[1][2] = (short)(r2 >> 4);
  }
  {
    /* identity-then-tweak: row 1 is stored POSITIVE above and negated in
       place here.  No sVar1/sVar2 carriers (the SYM has none) -- cc1
       forwards the still-live m[1][0] value (negu on its own register) and
       RELOADS m[1][1]/m[1][2] (lhu) exactly like retail. */
    int r0,r1,r2;
    r0 = m->m[2];
    r1 = m->m[5];
    r2 = m->m[8];
    (sd->matB).m[1][0] = -(sd->matB).m[1][0];
    (sd->matB).m[2][0] = (short)(r0 >> 4);
    (sd->matB).m[2][1] = (short)(r1 >> 4);
    (sd->matB).m[2][2] = (short)(r2 >> 4);
    (sd->matB).m[1][1] = -(sd->matB).m[1][1];
    (sd->matB).m[1][2] = -(sd->matB).m[1][2];
  }
  (sd->matB).t[0] = t->x >> TrsProj_precision;
  (sd->matB).t[1] = -(t->y >> TrsProj_precision);
  (sd->matB).t[2] = t->z >> TrsProj_precision;
  TrsProj_ResetTransPrecision();
  i = (int)obj->numFacet;
  while (true) {
    int real_type;
    Transformer_zFacet *facet;
    u_short id0;
    u_short id1;
    u_short id2;
    int bfct;
    int overlayFlag;
    u_long *copyLastPrim;
    {
        {
        {
          i = i - 1;
          if (i == -1) {
            return;
          }
          facet = obj->facet + i;
          /* W50-A3 ALLOCNO DIAL: +1 zero-insn ref on `facet` right after its def
             raises its allocno priority above `real_type` so facet takes $s1 and
             real_type $s3 (retail).  Without it the two swap (26 diffs, count-exact). */
          __asm__("" : : "r"(facet));
          /* ALLOCNO DIAL (w39-a3): retail emits `andi $s3,type,0xffbf` AFTER the
             sub_otSize gate, but computing it there gives real_type a SHORTER
             live range than `facet` and it wins retail's $s1 (facet's home),
             rotating 14 insns.  Hoisting the (loop-invariant, per-iteration
             recomputed -- real_type is mutated by the >>8 below) assignment to
             the loop head lengthens real_type's range, demotes it to $s3 and
             hands facet $s1: 53 -> 38 diffs.  Cost: the 2-insn andi block sits
             at the loop head instead of after the gate.
             w44-a8 RE-TEST + ROOT CAUSE: moving it back after the gate now reads
             48 diffs / 296 insns (vs 29 / 295 here) -- still worse, so KEEP the
             hoist.  But the REAL residual is now named: we are exactly 3 insns
             short and the missing block is retail's `lw $t0,0x54($sp); nop;
             andi $s3,$t0,0xFFBF` @800C3CF4.  SYM ground truth: `type` is
             `Def class ARG $0000000c` (NO register home at all -- fsize 72 + the
             o32 $a3 home 0xC = sp+0x54), and our prologue ALREADY spills it
             byte-identically (`sw $a3,0x54($sp)`).  Retail RELOADS it from that
             slot at all THREE use sites (@800C3CF4, @800C3D44, @800C3DB0); ours
             loads it once because the loop-head position lets LICM hoist the
             reload into the preheader.  NEW ANGLE: keep the andi at the loop head
             but defeat the reload hoist -- give `type` its ARG identity (read it
             through its stack home per use, or split each use into its own
             statement so loop.c's savings budget declines the load) rather than
             moving the andi.  The other 2 residual insns are the sched1 tie
             already documented at the DrawC_gOverlay block below. */
          id0 = facet->vertexId0;
          id1 = facet->vertexId1;
          id2 = facet->vertexId2;
gte_SetRotMatrix(((char *)sd + 0x14));
gte_SetTransMatrix(((char *)sd + 0x14));
          {
            short *z; short t1,t2,t3;
            z = (short *)(vertice + id0);
            t1 = z[0];
            t2 = z[1];
            t3 = z[2];
            (sd->vt0).x = t1;
            (sd->vt0).y = t2;
            (sd->vt0).z = t3;
          }
          {
            short *z; short t1,t2,t3;
            z = (short *)(vertice + id1);
            t1 = z[0];
            t2 = z[1];
            t3 = z[2];
            (sd->vt1).x = t1;
            (sd->vt1).y = t2;
            (sd->vt1).z = t3;
          }
          {
            short *z; short t1,t2,t3;
            z = (short *)(vertice + id2);
            t1 = z[0];
            t2 = z[1];
            t3 = z[2];
            (sd->vt2).x = t1;
            (sd->vt2).y = t2;
            (sd->vt2).z = t3;
          }
gte_ldv3((char *)sd + 0xac,(char *)sd + 0xb4,(char *)sd + 0xbc);
          gte_rtpt();
          gte_nclip();
          gte_stMAC0m(sd->bfct);
          bfct = sd->bfct;
          if ((sd->head).mirror != 0) {
            bfct = -bfct;
          }
          if (bfct < 1) continue;
        }
        gte_avsz3();
        gte_stOTZm(sd->otz);
        sd->otz = sd->otz + sd->sub_otz;
        if (sd->otz < 0) continue;
        if (sd->sub_otSize < sd->otz) continue;
        }
      /* 🏆 w50-A3 (the last 7 diffs -> PASS): the `andi $s3,type,0xFFBF` block belongs
         HERE, after all three `continue` gates (retail @800C3CF4, right before the
         `index < 0` test), NOT at the loop head.  w39/w44/w45 all measured this move as
         a regression (48 / 26 diffs) because the late definition SHORTENS real_type's
         live range, RAISES its allocno priority above `facet`, and the two swap homes
         ($s1 <-> $s3) -- a clean 13-line rotation with the count already exact.  The
         cure is the counter-dial at facet's definition (a +1 zero-insn ref, see there),
         not moving the block back.  Together: count-exact 298/298 and byte-identical. */
      real_type = ((u_int)type) & 0xffbf;
      if (index < 0) goto DrawCHalo_emitFlare;
      /* MATCH (w39-a3): the overlay word is loaded ONCE and only the SHIFT is
         branch-dependent (oracle: `lhu v0,0(v0); sll a0,v0,16; lh v0,0(s1);
         bgez -> sra 16 + andi 0xff : sra 24`).  Duplicating the array read in
         both arms let cc1 CSE the address and then LOOP-INVARIANT-HOIST
         `&DrawC_gOverlay[index]` out of the facet loop -- 2 extra insns plus a
         stack slot (frame 80 vs the SYM's 72).
         MATCH (w40-a3, 38 -> 29): the `<< 0x10` must be its OWN statement.  Fused
         into the initializer, cc1 sinks the `sll` into the bgez delay slot and
         then needs a THIRD register for the loaded halfword (`lhu v1` + in-place
         `sll v1,v1,16`); split, the shift lands before the `facet->flag` load in
         its own reg (`sll a0,v0,16`) and the halfword load gets retail's $v0.
         Residual 3 insns = cc1 still hoists the `lh flag` into the lhu's load-delay
         slot (retail leaves the nop and keeps sll-before-lh) -- a sched1 tie.
         ===== w45-a4 (29, ours 295 / oracle 298).  MECHANISM NAMED:
         retail's schedule is protected by an ANTI-DEPENDENCE we do not have --
         it loads the overlay halfword into $v0 (`lhu v0,0(v0)`) and then loads
         `facet->flag` into the SAME $v0 (`lh v0,0(s1)`), so the flag load
         CANNOT be hoisted above `sll a0,v0,16`.  Ours puts the halfword in $v1,
         so there is no conflict, sched1 pulls the `lh` into the lhu's load-delay
         slot, and dbr then takes the now-adjacent `sll` as the bgez's SIMPLE
         fill instead of retail's EAGER STEAL of the target block's `sra v1,a0,16`.
         => this is a REGISTER-ASSIGNMENT problem wearing a scheduling costume;
         the 2 missing insns are the nop + the standalone sll at each of the two
         sites.  FALSIFIED this wave: volatile on the overlay load (105/293),
         volatile on facet->flag (39/297), volatile on the shift store (33/295),
         a separate `ovraw` pseudo for the raw halfword (33), if/else ARM SWAP
         (35), volatile view on `type` at the real_type site and at all three
         sites (both exactly 29 -- so the loop-head `andi` position is NOT an
         LICM-of-`type` artifact; retail simply places the block after the gate
         and w44's re-test of that placement stands at 48).
         NEW NAMED ANGLE: force the two loads to share a register.  Retail's
         `lhu v0` / `lh v0` pairing means the flag value and the overlay
         halfword are the SAME C pseudo in the original -- i.e. the source read
         the flag into the variable the overlay word had just vacated (a
         DEAD-VARIABLE STAGING reuse, the w10 NightCopCalc lever).  Spell it as
         one `int w`: `w = DrawC_gOverlay[index]; ov = w << 16; w = facet->flag;
         if (w < 0) ...` -- one variable, two lifetimes, exactly retail's $v0.
         ...TESTED SAME WAVE AND FALSIFIED: `int w` staging at both sites = 45,
         at the first site only = 37, and BOTH stay at 295 insns -- the staging
         does not create the anti-dependence (cc1 splits the two lifetimes into
         separate pseudos again).  REFINED ANGLE: the anti-dependence has to be
         created by ALLOCATION, not by source aliasing, so attack it from the
         allocno side -- the halfword temp must out-rank whatever currently
         holds $v0 across this block.  Concretely: dump -dg (tools/rtl_dump.py)
         for this fn, find which pseudo owns $v0 at the overlay load, and use
         the w44 ref-step family (`ov = ov | (ov & 0);` zero-insn re-mask, or a
         loop-depth do{}while(0) around the two-site block) to push the overlay
         halfword's refs over the flr2 boundary. */
      {
      /* w46-a3 (29, ours 295 / oracle 298 = 3 SHORT).  RE-READ OF THE SHAPE:
         retail is  `lhu v0,0(v0)` (the halfword loaded into the ADDRESS's
         own dying register) + a load-delay `nop` + `sll a0,v0,16` into a
         FRESH reg, with BOTH sra's derived from that one shift.  The three
         missing insns ARE those three nops: our destination choice removes
         the hazard.  So the dial is the ANTI-DEPENDENCE (who owns $v0 across
         this block), NOT the shift spelling.  FALSIFIED this wave: explicit
         fresh shift temp `int ovs = (int)(ov << 0x10)` both sites 38, site-1
         only 33, fully inlined 38 -- every one makes us SHORTER still.
         Do the -dg pass first (see scratch/w46_a3_receipts.md sec.5).
         ---- w49-a4: the w45 note's TWO named ref-step dials are now BOTH RUN and
         FALSIFIED, so the ref/live family is closed for this block and only the
         allocation-side (-dg/-dl) instrument is left:
           - zero-insn re-mask on the overlay word (`ov = ov & 0xffff0000;` right
             after the shift -- a genuine no-op since ov = (u_short)x << 16, the
             w44 inflator variant 1): EXACTLY 29 @295 at site 1, at site 2, and at
             both.  cc1 folds the AND before flow.c, so it does NOT mint the ref
             here (unlike the OT-link addr24 sites where the operand is a pseudo).
           - do{}while(0) loop-depth wrapper around the shift+branch block (w44
             inflator variant 3): site 1 = 37, site 2 = 37, both = 45.  The
             NOTE_INSN_LOOP_BEG barrier costs more than the ref weighting gains --
             the w44 "NEGATIVE on straight-line call-free blocks" caveat, exactly.
         ==== 🏆 w50-A3: SOLVED, 29 -> PASS 298/298.  FOUR cooperating edits, in this
         order (each one enabled the next -- textbook lever-order/basin law; three of
         them were FALSIFIED in earlier waves at the PRE-FENCE basin and are listed
         above as negatives.  Those receipts were basin-relative, not wrong-then):
          (1) a zero-insn USE FENCE `__asm__("" : : "r"(ovs))` immediately after the
              shift at BOTH sites.  It is the sched ISSUE-POSITION FIXPOINT (w45): the
              `sll` can no longer sink into the bgez delay slot and the `lh facet->flag`
              can no longer float up into the `lhu`'s load-delay slot, so retail's TWO
              missing `nop`s materialise.  295 -> 297 insns, gate 29 -> 31 (the LCS rose
              while the STRUCTURE converged -- judge by insn count, never the LCS).
          (2) the FRESH SHIFT TEMP `int ovs = (int)(ov << 0x10);` (w46 measured this at
              38/33/38 pre-fence).  Post-fence it lands retail's `lhu v0,0(v0)` (the
              halfword in the address's own dying register) + `sll a0,v0,16`: 31 -> 23.
          (3) a SECOND zero-insn use fence on `ovs` AFTER the if/else join.  This is the
              INVERSE (demote) live-length dial: it stretches ovs's range past the join,
              dropping its allocno priority below overlayFlag's, so overlayFlag takes
              $v1 first and ovs falls through the numeric scan to retail's $a0: 23 -> 15.
          (4) IN-PLACE MASK in the else arm (`overlayFlag = ovs >> 0x10;` then
              `overlayFlag = overlayFlag & 0xff;`).  Two statements make the shift's dest
              coalesce with overlayFlag (`sra v1,a0,16; andi v1,v1,255`) where the fused
              expression needed a separate temp (`sra v0,a0,16; andi v1,v0,255`): 15 -> 7.
         The last 7 (the `real_type` block position) fell to the move-after-the-gate +
         the facet ref dial -- see the note at the `real_type` assignment. */
        u_int ov /* SYM-CODEGEN-CARRIER: ov -- staged halfword keeps one shared overlay load */ =
            (u_int)(u_short)DrawC_gOverlay[index];
        int ovs /* SYM-CODEGEN-CARRIER: ovs -- fresh shifted value plus two fences reproduces retail scheduling */ =
            (int)(ov << 0x10);
        __asm__("" : : "r"(ovs));
        if (facet->flag < 0) {
          overlayFlag = ovs >> 0x18;
        }
        else {
          overlayFlag = ovs >> 0x10;
          overlayFlag = overlayFlag & 0xff;
        }
        __asm__("" : : "r"(ovs));
      }
      if (((((u_int)type) & 0x40) != 0) && ((overlayFlag & 0x40) == 0)) {
        u_int ov = (u_int)(u_short)DrawC_gOverlay[0x18];
        int ovs = (int)(ov << 0x10);
        __asm__("" : : "r"(ovs));
        if (facet->flag < 0) {
          overlayFlag = ovs >> 0x18;
        }
        else {
          overlayFlag = ovs >> 0x10;
          overlayFlag = overlayFlag & 0xff;
        }
        __asm__("" : : "r"(ovs));
      }
      if ((overlayFlag & 0x81) == 0) continue;
    }
    /* the flare-type byte lives in the dead `m` register ($s0) in retail -- an
       anonymous cc1 temp, so no SYM name; the value is `real_type & 0xff`. */
    uVar8 = real_type & 0xff;
    if (((overlayFlag & 3) != 1) && ((((u_int)type) & 0x7f00) != 0)) {
      real_type = real_type >> 8;
DrawCHalo_emitFlare:
      uVar8 = real_type & 0xff;
    }
    copyLastPrim = (sd->head).cprim.LastPrim;
    (sd->head).cprim.LastPrim = sd->sub_ot;
    Flare_CarShapedHalo(uVar8,&sd->vt0,&sd->vt1,&sd->vt2,facet->flag,sd->otz,(Draw_FlareCache *)sd);
    if (((0 < reflect) || ((reflect == -1 && (uVar8 == 5)))) || ((reflect == -2 && (uVar8 != 5)))) {
gte_SetRotMatrix(((char *)sd + 0x14));
gte_SetTransMatrix(((char *)sd + 0x14));
      Flare_CarShapedHalo(real_type & 0xff | 0x100,&sd->vt0,&sd->vt1,&sd->vt2,facet->flag,sd->otz,
                 (Draw_FlareCache *)sd);
    }
    (sd->head).cprim.LastPrim = copyLastPrim;
  }
}

/* ---- DrawC_ShadowPrim__FP12Draw_tVertexP13Draw_CarCache  [DRAWC.CPP:3997-4051] SLD-VERIFIED ---- */
void DrawC_ShadowPrim(Draw_tVertex *shadowVT,Draw_CarCache *sd)

{
  POLY_FT4 *prim;
  Draw_tPixMap *shadowPmx;

  shadowPmx = gShadowPixmap0;
  if (R3DCar_InMenu != 0) {
    shadowPmx = gMenuPixmap[1];
  }
  ChangeTPage(&shadowPmx->tpage,2);
gte_SetRotMatrix(&DrawC_gScreenMat);
gte_SetTransMatrix(&DrawC_gScreenMat);
  if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr) {
gte_ldv0(shadowVT);
    gte_rtps();
    prim = (POLY_FT4 *)Render_gPacketPtr;
gte_swc2(0xe,(char *)prim + 0x8);
gte_ldv3((char *)shadowVT + 0x8,(char *)shadowVT + 0x18,(char *)shadowVT + 0x10);
    gte_rtpt();
gte_stsxy3((char *)prim + 0x10,(char *)prim + 0x20,(char *)prim + 0x18);
    gte_avsz4();
    gte_stOTZm(sd->otz);
    sd->otz = (sd->otz >> 1) + 0x28;
    if ((-1 < sd->otz) && (sd->otz <= Draw_gViewOtSize + -3)) {
      u_long *ot;
      {
      u_long l0;      /* MATCH: the colour word needs its OWN temp -- reusing l1 for it
                         rotates the whole {l1,l2,l3} triple off the oracle's regs (19->3) */
      u_long l1;
      u_long l2;
      u_long l3;
      prim = (POLY_FT4 *)(sd->head).cprim.PrimPtr;
      ot = (sd->head).cprim.LastPrim;
      (sd->head).cprim.PrimPtr = (char *)prim + 0x28;
      /* MATCH (w38-a3): NO `l0` temp -- the oracle STORES the merged prim tag
         first (`sw v1,0(a3)`) and then RE-READS ot[otz] (`lw v0,0(a0)`) for the
         second half of the 24-bit OT link, because the prim store may alias the
         OT word.  Staging through a temp let gcc keep the single ot[] load and
         reorder the two stores (-2 insns, 110->41 diffs). */
      {
      /* MATCH (w38-a3): a BLOCK-LOCAL `otp` for the OT slot (not an `ot[iVar1]`
         index expression at each of the 3 uses) -- the oracle computes the slot
         address once into its own pseudo and the index copy `addu v0,v1,zero`
         falls out of it (41->31->19 diffs). */
      /* MATCH: index the OT with the field we JUST STORED (`sd->otz`), not the
         local `iVar1` -- cc1 forwards the stored value and emits retail's
         redundant `addu v0,v1,zero` copy before the shift (3 -> PASS). */
      u_long *otp /* SYM-CODEGEN-CARRIER: otp -- one shared OT-cell address preserves the retail index copy and three uses */ = ot + sd->otz;
      *(u_long *)prim = *(u_long *)prim & 0xff000000 | *otp & 0xffffff;
      *otp = *otp & 0xff000000 | (u_long)prim & 0xffffff;
      }
      l0 = sd->color;
      *(u_char *)((char *)prim + 3) = 9;
      *(u_long *)&prim->r0 = l0;
      *(u_char *)((char *)prim + 7) = 0x2e;
      l1 = *(u_long *)&shadowPmx->u1;
      l2 = *(u_long *)&shadowPmx->u2;
      l3 = *(u_long *)&shadowPmx->u3;
      *(u_long *)&prim->u0 = *(u_long *)shadowPmx;
      *(u_long *)&prim->u1 = l1;
      *(u_long *)&prim->u2 = l2;
      *(u_long *)&prim->u3 = l3;
      }
    }
  }
  return;
}

/* ---- DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache  [DRAWC.CPP:4056-4114] SLD-VERIFIED ---- */
void DrawC_DivideShadowPrim(COORD16 *vt0,COORD16 *vt1,COORD16 *vt2,COORD16 *vt3,u_short *u0,u_short *u1,u_short *u2
               ,u_short *u3,Draw_tPixMap *pmx,Draw_CarCache *sd)

{
  POLY_FT4 * prim;
  u_short uv2;
  u_short uv3;
  u_short clut;
  u_short tpage;
  u_int color; /* SYM-CODEGEN-CARRIER: color -- direct sd->color store is current FAIL 5 at 123/122 */
  u_short uv1;
  u_short uv0;

  if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr) {
gte_ldv0(vt0);
    gte_rtps();
    /* MATCH (w42-a3): the two SXY staging blocks are ORDINARY C, not an EA
     * expander template.  SYM: `prim` is a FUNCTION-scope POLY_FT4* in $t0;
     * 0x1F800004 is Render_gPacketPtr and 8/0x10/0x18/0x20 are POLY_FT4's
     * xy0..xy3 (the 0x20/0x18 swap = the quad winding, same as the u2/u3 swap
     * at the tail).  Identical shape to the PASSing sibling DrawC_ShadowPrim.
     * Writing it as C makes `prim` a real variable assigned in TWO basic blocks
     * => a GLOBAL allocno, so local_alloc hands $a0/$a1/$a2 to the block-local
     * ot/mask temps first and `prim` lands in $t0 exactly like retail. */
    prim = (POLY_FT4 *)Render_gPacketPtr;
gte_swc2(0xe,(char *)prim + 0x8);
gte_ldv3(vt1,vt2,vt3);
    gte_rtpt();
gte_stsxy3((char *)prim + 0x10,(char *)prim + 0x20,(char *)prim + 0x18);
    if (R3DCar_InMenu != 0) {                /* fall-through arm = InMenu (oracle beqz jumps to avsz4) */
      sd->otz = 0;
    }
    else {
      gte_avsz4();
      gte_stOTZm(sd->otz);
      sd->otz = (sd->otz >> 3) + 0x28;
      if (sd->otz < 0) {
        return;
      }
      if (Draw_gViewOtSize + -3 < sd->otz) {
        return;
      }
    }
    if ((((-1 < *(short *)(((int)vt0) + 4)) || (-1 < vt1->z)) || (-1 < vt2->z)) || (-1 < vt3->z)) {
      {
      u_long *ot;
      u_int *otp; /* SYM-CODEGEN-CARRIER: otp -- one staged OT-cell address avoids six extra reload/address instructions */
      prim = (POLY_FT4 *)(sd->head).cprim.PrimPtr;
      ot = (sd->head).cprim.LastPrim;
      (sd->head).cprim.PrimPtr = (char *)prim + 0x28;
      /* volatile: the oracle reloads sd->otz fresh here (stored just above) */
      otp = (u_int *)(ot + *(int volatile *)&sd->otz);
      *(u_int *)prim = *(u_int *)prim & 0xff000000 | *otp & 0xffffff;
      *otp = *otp & 0xff000000 | (u_int)prim & 0xffffff;
      }
      color = sd->color;
      *(u_char *)((int)prim + 3) = 9;
      ((u_int *)prim)[1] = color;
      *(u_char *)((int)prim + 7) = 0x2e;
      tpage = pmx->tpage;
      clut = pmx->clut;
      *(u_short *)((int)prim + 0xe) = clut;
      *(u_short *)((int)prim + 0x16) = tpage;
      /* RESIDUAL (w38-a3): 109 diffs at 123/122 insns.  ONE extra insn = a second
         register copy: gcc gives the asm's `tp8` cursor $a1 (retail uses $t0), so
         vt1 has to be copied out of $a1 (`addu t2,a1,zero`) ON TOP OF the vt0 copy
         that the $a0 clobber forces; retail copies vt0 only.  Everything else is the
         resulting rotation (t1/t0, a1/t0, a2/a1, a3/a2).  Falsified: minimal block-1
         clobber list ($v0 only) = no change; clobbering $a2/$a3 = 129; clobbering
         $a1-$a3 = 89 but 125 insns (2 more copies); dummy `"r"(vt1)` earlyclobber
         inputs = 105/123 but that is pure scaffolding, rejected.  Steering an asm
         OUTPUT to a specific hard register without a pin is the open problem. */
      uv0 = *u0;                    /* oracle load order: u0, u1, u3, u2 */
      uv1 = *u1;
      uv3 = *u3;
      uv2 = *u2;
      *(u_short *)((u_int *)prim + 3) = uv0;
      *(u_short *)((u_int *)prim + 5) = uv1;
      *(u_short *)((u_int *)prim + 7) = uv3;    /* EA swap: prim u2 slot <- *u3 */
      *(u_short *)((u_int *)prim + 9) = uv2;

    }
  }
  return;
}

/* ---- DrawC_ShadowPrimClip__FP12Draw_tVertexP13Draw_CarCache  [DRAWC.CPP:4117-4184] SLD-VERIFIED ---- */
void DrawC_ShadowPrimClip(Draw_tVertex *shadowVT,Draw_CarCache *sd)

{
  /* rule-8 (w39-a3): the SYM names ONLY shadowPmx ($fp) plus five sibling
     block-scoped temp sets ({t1,t2,t3}, 3x {z,t1,t2,t3}, {uv0..uv3}).  The
     fn-scope t1/t2/t3/z/sVar1-5/uv0-3 copies were dead Ghidra leftovers. */
  Draw_tPixMap *shadowPmx;

  shadowPmx = gShadowPixmap0;
  if (R3DCar_InMenu != 0) {
    shadowPmx = gMenuPixmap[1];
  }
  ChangeTPage(&shadowPmx->tpage,2);
gte_SetRotMatrix(&DrawC_gScreenMat);
gte_SetTransMatrix(&DrawC_gScreenMat);
  /* SYM: FIVE sibling blocks (one macro line=5): vt0 copy {t1,t2,t3} (no z),
   * vt1/vt2/vt3 copies {z,t1,t2,t3}, uv block later.
   * MATCH (w40-a3, 265 -> PASS, count exact 335/335): the vt3 SCALING reads the
   * field BACK FROM MEMORY (`(sd->vt3).x = (sd->vt3).x << 2;`) exactly like the
   * vt0-vt2 ones -- it does NOT re-use the block's t1/t2/t3 temps.  cc1's cse
   * FORWARDS the just-stored register instead of re-loading, and the forward is
   * emitted as a register COPY (`addu $v0,$a1,$zero; sll $v0,$v0,2`), which is
   * precisely the oracle's "redundant" copy triple @0x800C4478-94.  Writing
   * `t1 << 2` instead shifts the temp IN PLACE (`sll $a1,$a1,2`) and loses the
   * copies -- that was the whole 265-diff residual, previously mis-filed as a
   * "$a0<->$a2 rotation".  Store ORDER of the three scaled stores is x,y,z
   * (y,x,z leaves 12 diffs: it swaps which temp is copied first). */
  {
    short t1 = (shadowVT->sv).x;
    short t2 = (shadowVT->sv).y;
    short t3 = (shadowVT->sv).z;
    (sd->vt0).x = t1;
    (sd->vt0).y = t2;
    (sd->vt0).z = t3;
  }
  {
    short *z = (short *)&shadowVT[1].sv;
    short t1 = z[0];
    short t2 = z[1];
    short t3 = z[2];
    (sd->vt1).x = t1;
    (sd->vt1).y = t2;
    (sd->vt1).z = t3;
  }
  {
    short *z = (short *)&shadowVT[3].sv;
    short t1 = z[0];
    short t2 = z[1];
    short t3 = z[2];
    (sd->vt2).x = t1;
    (sd->vt2).y = t2;
    (sd->vt2).z = t3;
  }
  {
    short *z = (short *)&shadowVT[2].sv;
    short t1 = z[0];
    short t2 = z[1];
    short t3 = z[2];
    (sd->vt3).x = t1;
    (sd->vt3).y = t2;
    (sd->vt3).z = t3;
    (sd->vt0).x = (sd->vt0).x << 2;
    (sd->vt0).y = (sd->vt0).y << 2;
    (sd->vt0).z = (sd->vt0).z << 2;
    (sd->vt1).x = (sd->vt1).x << 2;
    (sd->vt1).y = (sd->vt1).y << 2;
    (sd->vt1).z = (sd->vt1).z << 2;
    (sd->vt2).x = (sd->vt2).x << 2;
    (sd->vt2).y = (sd->vt2).y << 2;
    (sd->vt2).z = (sd->vt2).z << 2;
    (sd->vt3).x = (sd->vt3).x << 2;
    (sd->vt3).y = (sd->vt3).y << 2;
    (sd->vt3).z = (sd->vt3).z << 2;
  }
  /* midpoints: operands re-read from MEMORY per field (oracle lh pairs; the
   * cached-short-temp form forced sll16/sra16 re-extension chains) */
  (sd->vt4).x = (short)(((sd->vt0).x + (sd->vt1).x + 1) >> 1);
  (sd->vt4).y = (short)(((sd->vt0).y + (sd->vt1).y + 1) >> 1);
  (sd->vt4).z = (short)(((sd->vt0).z + (sd->vt1).z + 1) >> 1);
  (sd->vt5).x = (short)(((sd->vt1).x + (sd->vt2).x + 1) >> 1);
  (sd->vt5).y = (short)(((sd->vt1).y + (sd->vt2).y + 1) >> 1);
  (sd->vt5).z = (short)(((sd->vt1).z + (sd->vt2).z + 1) >> 1);
  (sd->vt6).x = (short)(((sd->vt2).x + (sd->vt3).x + 1) >> 1);
  (sd->vt6).y = (short)(((sd->vt2).y + (sd->vt3).y + 1) >> 1);
  (sd->vt6).z = (short)(((sd->vt2).z + (sd->vt3).z + 1) >> 1);
  (sd->vt7).x = (short)(((sd->vt3).x + (sd->vt0).x + 1) >> 1);
  (sd->vt7).y = (short)(((sd->vt3).y + (sd->vt0).y + 1) >> 1);
  (sd->vt7).z = (short)(((sd->vt3).z + (sd->vt0).z + 1) >> 1);
  (sd->vt8).x = (short)(((sd->vt0).x + (sd->vt2).x + 1) >> 1);
  (sd->vt8).y = (short)(((sd->vt0).y + (sd->vt2).y + 1) >> 1);
  (sd->vt8).z = (short)(((sd->vt0).z + (sd->vt2).z + 1) >> 1);
  {
    u_short uv0 = *(u_short *)&shadowPmx->u0;
    u_short uv1 = *(u_short *)&shadowPmx->u1;
    u_short uv3 = *(u_short *)&shadowPmx->u3;
    u_short uv2 = *(u_short *)&shadowPmx->u2;
    *(u_short *)&sd->u0 = uv0;
    *(u_short *)&sd->u1 = uv1;
    *(u_short *)&sd->u2 = uv3;
    *(u_short *)&sd->u3 = uv2;
  }
  sd->u4 = (u_char)((int)((u_int)sd->u0 + (u_int)sd->u1 + 1) >> 1);
  sd->v4 = (u_char)((int)((u_int)sd->v0 + (u_int)sd->v1 + 1) >> 1);
  sd->u5 = (u_char)((int)((u_int)sd->u1 + (u_int)sd->u2 + 1) >> 1);
  sd->v5 = (u_char)((int)((u_int)sd->v1 + (u_int)sd->v2 + 1) >> 1);
  sd->offsetU0 = (u_char)((int)((u_int)sd->u2 + (u_int)sd->u3 + 1) >> 1);
  sd->offsetV0 = (u_char)((int)((u_int)sd->v2 + (u_int)sd->v3 + 1) >> 1);
  sd->offsetU1 = (u_char)((int)((u_int)sd->u3 + (u_int)sd->u0 + 1) >> 1);
  sd->offsetV1 = (u_char)((int)((u_int)sd->v3 + (u_int)sd->v0 + 1) >> 1);
  sd->offsetU2 = (u_char)((int)((u_int)sd->u0 + (u_int)sd->u2 + 1) >> 1);
  sd->offsetV2 = (u_char)((int)((u_int)sd->v0 + (u_int)sd->v2 + 1) >> 1);
  DrawC_DivideShadowPrim(&sd->vt0,&sd->vt4,&sd->vt8,&sd->vt7,(u_short *)&sd->u0,(u_short *)&sd->u4,(u_short *)&sd->offsetU2,
             (u_short *)&sd->offsetU1,shadowPmx,sd);
  DrawC_DivideShadowPrim(&sd->vt4,&sd->vt1,&sd->vt5,&sd->vt8,(u_short *)&sd->u4,(u_short *)&sd->u1,(u_short *)&sd->u5,
             (u_short *)&sd->offsetU2,shadowPmx,sd);
  DrawC_DivideShadowPrim(&sd->vt7,&sd->vt8,&sd->vt6,&sd->vt3,(u_short *)&sd->offsetU1,(u_short *)&sd->offsetU2,
             (u_short *)&sd->offsetU0,(u_short *)&sd->u3,shadowPmx,sd);
  DrawC_DivideShadowPrim(&sd->vt8,&sd->vt5,&sd->vt2,&sd->vt6,(u_short *)&sd->offsetU2,(u_short *)&sd->u5,(u_short *)&sd->u2,
             (u_short *)&sd->offsetU0,shadowPmx,sd);
  return;
}

/* ---- DrawC_SpotPrims__FP10matrixtdefP8coorddefP13Draw_CarCache  [DRAWC.CPP:4189-4254] SLD-VERIFIED ---- */
void DrawC_SpotPrims(matrixtdef *m,coorddef *t,Draw_CarCache *sd)

{
  int i;
  POLY_G3 *prim;

  TrsProj_SetTransPrecision(8);
  {
    int r0 = m->m[0];
    int r1 = m->m[3];
    int r2 = m->m[6];
    (sd->matB).m[0][0] = (short)(r0 >> 4);
    (sd->matB).m[0][1] = (short)(r1 >> 4);
    (sd->matB).m[0][2] = (short)(r2 >> 4);
  }
  {
    int r0 = m->m[1];
    int r1 = m->m[4];
    int r2 = m->m[7];
    (sd->matB).m[1][0] = (short)(r0 >> 4);
    (sd->matB).m[1][1] = (short)(r1 >> 4);
    (sd->matB).m[1][2] = (short)(r2 >> 4);
  }
  {
    int r0 = m->m[2];
    int r1 = m->m[5];
    int r2 = m->m[8];
    (sd->matB).m[1][0] = -(sd->matB).m[1][0];
    (sd->matB).m[2][0] = (short)(r0 >> 4);
    (sd->matB).m[2][1] = (short)(r1 >> 4);
    (sd->matB).m[2][2] = (short)(r2 >> 4);
    (sd->matB).m[1][1] = -(sd->matB).m[1][1];
    (sd->matB).m[1][2] = -(sd->matB).m[1][2];
  }
  (sd->matB).t[0] = t->x >> TrsProj_precision;
  (sd->matB).t[1] = -(t->y >> TrsProj_precision);
  (sd->matB).t[2] = t->z >> TrsProj_precision;
  TrsProj_ResetTransPrecision();
gte_SetRotMatrix(((char *)sd + 0x14));
gte_SetTransMatrix(((char *)sd + 0x14));
  {
    DR_MODE *pDVar7; /* SYM-CODEGEN-CARRIER: pDVar7 -- separate mode-packet pointer; reusing outer prim is part of a FAIL 74 (227/225) rewrite */
    u_long *ot;
    pDVar7 = (DR_MODE *)(sd->head).cprim.PrimPtr;
    ot = (sd->head).cprim.LastPrim;
    sd->otz = 0;
    (sd->head).cprim.PrimPtr = (char *)(pDVar7 + 1);
    {
      u_int *puVar8 /* SYM-CODEGEN-CARRIER: puVar8 -- distinct OT-cell address; mutating ot is part of FAIL 74 (227/225) */ = (u_int *)(ot + sd->otz);
      ((DrawC_tTag *)pDVar7)->addr = *puVar8 & 0xffffff;
      ((DrawC_tTag *)puVar8)->addr = (u_int)pDVar7 & 0xffffff;
    }
    SetDrawMode(pDVar7,0,0,0x120,(RECT *)0x0);
  }
  {
    short *z = (short *)&Fe3D_spotVertex[0x20];
    short t1 = z[0];
    short t2 = z[1];
    short t3 = z[2];
    (sd->vt0).x = t1;
    (sd->vt0).y = t2;
    (sd->vt0).z = t3;
  }
  {
    /* MATCH (SYM @0x800C4800): fn-outer locals are ONLY `i` (REG $7=a3) and `prim`
       (POLY_G3*, REG $4=a0) -- no cursor pointers; vt1 reads Fe3D_spotVertex[i]
       directly (gcc giv-reduces it to the walking a2), vt2 via a block-local
       `short *z = &[iPlus]` (index rematerialized: sll/addu/sll + base). */
    i = 0;
    while (1) {
      int iPlus = i + 1;
      if (0x20 <= i) break;
      if (iPlus == 0x20) {
        iPlus = 0;
      }
      if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr) {
        {
          short t1 = Fe3D_spotVertex[i].x;
          short t2 = Fe3D_spotVertex[i].y;
          short t3 = Fe3D_spotVertex[i].z;
          (sd->vt1).x = t1;
          (sd->vt1).y = t2;
          (sd->vt1).z = t3;
        }
        {
          short *z = (short *)&Fe3D_spotVertex[iPlus];
          short t1 = z[0];
          short t2 = z[1];
          short t3 = z[2];
          (sd->vt2).x = t1;
          (sd->vt2).y = t2;
          (sd->vt2).z = t3;
        }
        gte_ldv3(&sd->vt0,&sd->vt1,&sd->vt2);
        gte_rtpt();
        prim = (POLY_G3 *)(sd->head).cprim.PrimPtr;
        (sd->head).cprim.PrimPtr = (char *)(prim + 1);
        {
          u_long *ot = (u_long *)((sd->head).cprim.LastPrim + sd->otz);
          ((DrawC_tTag *)prim)->addr = *ot;
          ((DrawC_tTag *)ot)->addr = (u_int)prim;
        }
        gte_stsxy3_g3(prim);
        {
          u_int color /* SYM-CODEGEN-CARRIER: color -- staged packet color provides the retail load-delay slot; direct store is FAIL 7 (226/225) */ = sd->color;
          *(u_char *)((int)prim + 3) = 6;
          ((u_int *)prim)[3] = 0;
          ((u_int *)prim)[5] = 0;
          ((u_int *)prim)[1] = color;
          *(u_char *)((int)prim + 7) = 0x32;
        }
      }
      i = i + 1;
    }
  }
  {
    DR_MODE *pDVar7 = (DR_MODE *)(sd->head).cprim.PrimPtr;
    u_long *ot = (sd->head).cprim.LastPrim;
    (sd->head).cprim.PrimPtr = (char *)(pDVar7 + 1);
    {
      u_int *puVar8 = (u_int *)(ot + sd->otz);
      ((DrawC_tTag *)pDVar7)->addr = *puVar8 & 0xffffff;
      ((DrawC_tTag *)puVar8)->addr = (u_int)pDVar7 & 0xffffff;
    }
    SetDrawMode(pDVar7,0,1,0x120,(RECT *)0x0);
  }
  return;
}

/* ---- DrawC_ShowroomPrims__FP10matrixtdefP8coorddefP13Draw_CarCache  [DRAWC.CPP:4260-4378] SLD-VERIFIED ---- */
void DrawC_ShowroomPrims(matrixtdef *m,coorddef *t,Draw_CarCache *sd)

{
  int i;
  int j;
  signed char hilight_state [32];
  int hilight [2];
  int hilight_direction [2];
  int index;
  POLY_FT4 *prim;
  Draw_tPixMap *lightPmx;

  lightPmx = gMenuPixmap[3];
  if (gShowroomLights != 0) {
    /* rule-8 (w41-a3): the SYM names ONLY i, j, index, prim, lightPmx, the three
       AUTO arrays and the per-block {r0,r1,r2} / {t1,t2,t3} / {z,t1,t2,t3} /
       {index,iPlus} / {ot} / {l0..l3} sets.  The eight Ghidra iVarN/pcVarN/
       puVarN/pCVarN walkers are gone; the fn-scope i/j do double duty (the
       gettick split, the hilight fill, and the inner 2-iteration loop). */
    /* MATCH (w45-a4, 14 -> 6): the tick lives in `j`, and the /256 quotient
       is an ANONYMOUS sub-expression (not a named local).  With `i = gettick()`
       the tick shared `i`'s pseudo with the inner 2-iteration counter and the
       divide-dividend survivor landed in $a3 instead of retail's $v1. */
    j = gettick();
    hilight[0] = (j - (j / 256 << 8)) >> 3;
    hilight_direction[0] = -1;
    if (DrawC_gMenuLightsDirection == 0) {
      hilight[1] = hilight[0] + 0x10U & 0x1f;
      hilight_direction[1] = -1;
    }
    else {
      hilight[1] = 0x20 - hilight[0];
      hilight_direction[1] = 1;
    }
    /* MATCH (w42-a3, 105 -> 99): retail's fill loop is a DOWN-WALKING POINTER
       (`addiu v0,sp,47` = &hilight_state[31], `sb v1,0(v0)`, and `addiu v0,v0,-1`
       in the bgez delay slot).  Our loop.c declined to strength-reduce the plain
       `hilight_state[i] = -1` index form (it recomputed `addu v0,base,i` every
       iteration, +1 insn); modelling the giv explicitly reproduces the oracle's
       body byte-for-byte.  `for(i=31;i>=0;i--)` measured identical to the index
       do-while (no SR either).
       ===== w45-a4: 93 -> 4 (count-exact 297/297).  FOUR VARIABLE-IDENTITY /
       ORDER edits, each measured (see the per-site notes):
        (1) vt2 block: `&Fe3D_lightsVertex[index*2+1]` as a POINTER local ->
            loop.c builds a real ADDRESS giv instead of an OFFSET giv + a
            per-iteration `addu` (this was the whole +1 insn; 93->80, 298->297).
        (2) fill-loop counter = `index`, not `i`               (80 -> 42)
        (3) the 2x5 hilight loop's OUTER counter = `index` too (42 -> 16)
        (4) PrimPtr-vs-MPrimPtr compare operand order          (16 -> 14)
        (5) `j = gettick()` with an ANONYMOUS /256             (14 ->  6)
        (6) `index = 0x1f;` BEFORE the `hs` pointer decl       ( 6 ->  4)
       META: retail runs {fill counter, the 2x5 outer counter, the main
       0..0x1F loop, the tick} on essentially ONE counter/tmp band ($t0/$v1)
       and reserves `i` ($a3) for the INNER counters.  Ghidra's `j` was pure
       fiction; every use of a wrong variable identity rotated a0/a1/a2/a3/
       t0..t3 by one slot across the ENTIRE function.
       RESIDUAL 4 = two independent SINGLE-SLOT scheduling swaps, both
       count-exact and register-exact:
         (a) retail emits `li v1,-1` BEFORE `li t0,31`; ours emits it after
             `addiu v0,sp,47`.  FALSIFIED here: named `signed char m1 = -1`
             / `int m1` before or after the counter init, all four fill-loop
             statement orders (store-first / ptr-first / store-last /
             `*hs-- = -1` postdec), `while (0 <= index)`.
         (b) retail loads `lhu v0,0(t2)` (x) before `lhu v1,2(t2)` (y) in the
             vt0 fetch; ours swaps them.  FALSIFIED: all 4 store orders
             (xyz/yxz/yzx/zyx), the pointer-local form, load order yxz.
       NEW NAMED ANGLE: both are sched2 READY-LIST DRAIN points (w44 -dR
       class) -- the dial is +-1 RTL insn released late in the block, not a
       spelling.  Run tools/rtl_dump.py -dR on this TU and read the two ready
       lists; then either (i) shorten the `hs` address computation by one RTL
       insn (e.g. seed it from `hilight_state` + a named 31 so the addiu is
       born with the counter) or (ii) give the vt0 x-load a second consumer so
       it wins the tie.  stmtclimb (with a def-use audit) is the cheap probe. */
    {
    /* MATCH (w46-a3, 2 -> PASS): the fill sentinel is a NAMED local declared
       BEFORE the counter init -- retail emits `li v1,-1` ahead of `li t0,31`.
       This exact spelling was FALSIFIED in w45 at the pre-fence basin; the
       vt0 sched fence above changed the landscape and it now lands (catalog
       w45 LAW: falsifications are BASIN-RELATIVE, re-test after every edit). */
    signed char m1 /* SYM-CODEGEN-CARRIER: m1 -- named fill sentinel must materialize before the counter */ = -1;
    index = 0x1f;
    /* MATCH (w45-a4, 80 -> 42): the fill counter is `index`, NOT `i`.  Retail
       runs the whole fn on ONE counter register for {fill, j, index} vs `i`
       for the inner 2-iteration loop; using `i` here made our fill counter
       share a pseudo with the inner `i` (=$a3 everywhere) and rotated a0/a1/
       a2/a3/t0..t3 by one across the whole function.  A fresh block-local
       counter measures 84, `j` measures 80, `index` 42. */
    signed char *hs /* SYM-CODEGEN-CARRIER: hs -- explicit reverse walker reproduces the down-counting GIV */ = &hilight_state[0x1f];
    do {
      *hs = m1;
      index = index + -1;
      hs = hs + -1;
    } while (-1 < index);
    }
    /* MATCH (w40-a3): INDEX form, not walking pointers -- retail's
       `addu $a1,$a2,$zero` / `addu $a0,$t1,$zero` pair right after the three
       `addiu spN` base materializations is loop.c strength-reduction seeding the
       givs FROM the array bases, which only happens if the source indexes
       hilight[j] / hilight_direction[j] (the SYM names only i and j). */
    /* MATCH (w45-a4, 42 -> 16): the OUTER counter of this pair is `index`
       too, not `j` -- retail runs {fill counter, this outer counter, the
       main 0..0x1F loop} on ONE pseudo ($t0) and keeps `i` ($a3) for the
       inner counters.  `j` here is a Ghidra naming artifact; with `j` the
       whole a0/a1/a2/t0 band rotates by one. */
    index = 0;
    do {
      i = 0;
      do {
        if ((signed char)hilight_state[hilight[index] + i * hilight_direction[index] & 0x1f] < i) {
          hilight_state[hilight[index] + i * hilight_direction[index] & 0x1f] = (char)i;
        }
        i = i + 1;
      } while (i < 5);
      index = index + 1;
    } while (index < 2);
    ChangeTPage(&lightPmx->tpage,1);
    TrsProj_SetTransPrecision(8);
    {
      int r0 = m->m[0];
      int r1 = m->m[3];
      int r2 = m->m[6];
      (sd->matB).m[0][0] = (short)(r0 >> 4);
      (sd->matB).m[0][1] = (short)(r1 >> 4);
      (sd->matB).m[0][2] = (short)(r2 >> 4);
    }
    {
      int r0 = m->m[1];
      int r1 = m->m[4];
      int r2 = m->m[7];
      (sd->matB).m[1][0] = (short)(r0 >> 4);
      (sd->matB).m[1][1] = (short)(r1 >> 4);
      (sd->matB).m[1][2] = (short)(r2 >> 4);
    }
    {
      int r0 = m->m[2];
      int r1 = m->m[5];
      int r2 = m->m[8];
      (sd->matB).m[1][0] = -(sd->matB).m[1][0];
      (sd->matB).m[2][0] = (short)(r0 >> 4);
      (sd->matB).m[2][1] = (short)(r1 >> 4);
      (sd->matB).m[2][2] = (short)(r2 >> 4);
      (sd->matB).m[1][1] = -(sd->matB).m[1][1];
      (sd->matB).m[1][2] = -(sd->matB).m[1][2];
    }
    (sd->matB).t[0] = t->x >> TrsProj_precision;
    (sd->matB).t[1] = -(t->y >> TrsProj_precision);
    (sd->matB).t[2] = t->z >> TrsProj_precision;
    TrsProj_ResetTransPrecision();
gte_SetRotMatrix(((char *)sd + 0x14));
gte_SetTransMatrix(((char *)sd + 0x14));
    sd->otz = 0;
    for (index = 0; index < 0x20; index = index + 1) {
      int iPlus = index * 2 + 2;
      if (iPlus == 0x40) {
        iPlus = 0;
      }
      i = 0;
      /* MATCH (w45-a4, 16 -> 14): compare operand order IS load order --
         retail loads PrimPtr (+4) BEFORE MPrimPtr (+8). */
      if (!((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr)) {
        return;
      }
      {
        short t1 = Fe3D_lightsVertex[index * 2].x;
        short t2 = Fe3D_lightsVertex[index * 2].y;
        short t3 = Fe3D_lightsVertex[index * 2].z;
        /* MATCH (w46-a3, 4 -> 2): ZERO-INSN SCHED FENCE, position IS the dial
           (catalog w45 fence grammar).  Retail loads x(0) before y(2) here;
           sched2's ready list drained the other way for us and every spelling
           family was already falsified (all 4 store orders, load order yxz,
           pointer-local).  A bare `__asm__("" : : )` placed BETWEEN the three
           loads and the three stores pins the load order to retail's without
           emitting anything.  Measured at this basin: before-block 4,
           after-t1 14, HERE 2, after-block 6, extra t1 consumer 14. */
        __asm__("" : : );
        (sd->vt0).x = t1;
        (sd->vt0).y = t2;
        (sd->vt0).z = t3;
      }
      {
        short *z = (short *)(Fe3D_lightsVertex + iPlus);
        short t1 = z[0];
        short t2 = z[1];
        short t3 = z[2];
        (sd->vt1).x = t1;
        (sd->vt1).y = t2;
        (sd->vt1).z = t3;
      }
      {
        COORD16 *z1 /* SYM-CODEGEN-CARRIER: z1 -- address GIV avoids the offset-GIV plus per-iteration add */ = &Fe3D_lightsVertex[index * 2 + 1];
        short t1 = z1->x;
        short t2 = z1->y;
        short t3 = z1->z;
        (sd->vt2).x = t1;
        (sd->vt2).y = t2;
        (sd->vt2).z = t3;
      }
      {
        short *z = (short *)&Fe3D_lightsVertex[iPlus + 1];
        short t1 = z[0];
        short t2 = z[1];
        short t3 = z[2];
        (sd->vt3).x = t1;
        (sd->vt3).y = t2;
        (sd->vt3).z = t3;
      }
      for (; i < 2; i = i + 1) {
        if ((i == 0) || (-1 < (signed char)hilight_state[index])) {
gte_ldv0((char *)sd + 0xac);
          gte_rtps();
          prim = (POLY_FT4 *)(sd->head).cprim.PrimPtr;
          (sd->head).cprim.PrimPtr = (char *)(prim + 1);
          {
            u_long *ot = (u_long *)((sd->head).cprim.LastPrim + sd->otz);
            ((DrawC_tTag *)prim)->addr = *ot;
            ((DrawC_tTag *)ot)->addr = (u_int)prim;
          }
gte_swc2(0xe,(char *)prim + 0x8);
gte_ldv3((char *)sd + 0xb4,(char *)sd + 0x3d0,(char *)sd + 0xbc);
          gte_rtpt();
gte_stsxy3((char *)prim + 0x10,(char *)prim + 0x20,(char *)prim + 0x18);
          if (i == 0) {
            *(u_int *)&prim->r0 = 0x300a00;
          }
          else {
            *(u_int *)&prim->r0 = hilight_colors[(signed char)hilight_state[index]];
          }
          prim->code = 0x2e;
          *(u_char *)((int)prim + 3) = 9;
          {
            u_long l0 = *(u_int *)lightPmx;
            u_long l1 = *(u_int *)&lightPmx->u1;
            u_long l2 = *(u_int *)&lightPmx->u2;
            u_long l3 = *(u_int *)&lightPmx->u3;
            *(u_int *)&prim->u0 = l0;
            *(u_int *)&prim->u1 = l1;
            *(u_int *)&prim->u2 = l2;
            *(u_int *)&prim->u3 = l3;
          }
        }
      }
    }
  }
  return;
}
