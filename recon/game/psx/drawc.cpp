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
    "lw\t%0,4(%1)\n\tlw\t$t4,60(%1)\n\tlw\t$t5,56(%1)\n\taddiu\t$t6,%0,32\n\tsll\t$t4,$t4,2\n\taddu\t$t5,$t5,$t4\n\tsw\t$t6,4(%1)\n\tlwl\t$t6,2($t5)\n\tlui\t$t4,0x0700\n\tsrl\t$t6,$t6,8\n\tor\t$t6,$t6,$t4\n\tsll\t$t4,%0,8\n\tsw\t$t6,0(%0)\n\tswl\t$t4,2($t5)" \
    : "=&r"(primout_) : "r"(sd_) : "$12", "$13", "$14", "memory")
/* split form: prim pre-loaded by COMPILER code (retail interleaves that lw with
 * neighbouring reg math, e.g. the overlay pTVar23 compute -- an atomic 14-insn
 * asm can't reproduce that); the asm does the remaining 13-insn link tail. */
#define DRAWC_OTLINK_FT3B(sd_, prim_) __asm__ volatile( \
    "lw\t$t4,60(%1)\n\tlw\t$t5,56(%1)\n\taddiu\t$t6,%0,32\n\tsll\t$t4,$t4,2\n\taddu\t$t5,$t5,$t4\n\tsw\t$t6,4(%1)\n\tlwl\t$t6,2($t5)\n\tlui\t$t4,0x0700\n\tsrl\t$t6,$t6,8\n\tor\t$t6,$t6,$t4\n\tsll\t$t4,%0,8\n\tsw\t$t6,0(%0)\n\tswl\t$t4,2($t5)" \
    : : "r"(prim_), "r"(sd_) : "$12", "$13", "$14", "memory")
/* srcoff passed as THREE pre-folded string offsets ("84","88","92") -- a
 * "OFF+4(%0)" sum displacement makes the assembler expand the lui-$at
 * address macro (3 insns) instead of a direct load (CONT 2026-07-09b). */
#define DRAWC_OTLINK_MODE(sd_, off0_, off1_, off2_) __asm__ volatile( \
    "lw\t$t4,4(%0)\n\tlw\t$t5,60(%0)\n\tlw\t$t6,56(%0)\n\taddiu\t$t7,$t4,12\n\tsll\t$t5,$t5,2\n\taddu\t$t6,$t6,$t5\n\tsw\t$t7,4(%0)\n\tlw\t$t5," off0_ "(%0)\n\tlw\t$t7," off1_ "(%0)\n\tlw\t$s0," off2_ "(%0)\n\tsw\t$t5,0($t4)\n\tsw\t$t7,4($t4)\n\tsw\t$s0,8($t4)\n\tlwl\t$t5,2($t6)\n\tsll\t$t7,$t4,8\n\tswl\t$t5,2($t4)\n\tswl\t$t7,2($t6)" \
    : : "r"(sd_) : "$12", "$13", "$14", "$15", "$16", "memory")

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
  {int trk = GameSetup_gData.track; sprintf(name,"%sTr%02d.env",Paths_Paths[6],trk);}
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
    { int h0; int h1; int h2;
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
    u_char *lp = (u_char *)&light;
    u_char *wc = (u_char *)&Night_gWeatherColor[Night_gLightningType];
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
    newR = (short)((int)wc[0] + (int)lp[0]);
    newG = (short)((int)wc[1] + (int)lp[1]);
    newB = (short)((int)wc[2] + (int)lp[2]);
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
  int sVar1;
  int carType;
  int carType0;
  int iVar3;
  GameSetup_tCarData *pGVar4;
  Texture_pal8bit *palCopy;
  char *shpfile;
  char filename [10];
  char infilename [100];

  pGVar4 = carObj->carInfo;
  carType0 = pGVar4->carType;
  if (carObj->async_handle == 0) {
    if ((int)(carObj->render).currentCarType != carType0) {
      return;
    }
    (carObj->render).upgradeFlags =
         (char)pGVar4->EngineMods + (char)pGVar4->WeightTransfer * '\x02' +
         (char)pGVar4->GroundEffects * '\x04';
    if ((u_int)((u_short)(carObj->render).currentCarType - 0x10) < 3) {
      (carObj->render).upgradeFlags = '\a';
    }
    menuColor = color + ((u_int)(u_char)(carObj->render).upgradeFlags & 1) * 0x100 +
                ((u_int)(u_char)(carObj->render).upgradeFlags & 2) * 0x100;
    int *menuColorSlot = DrawC_gMenuColor + player;
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
      iVar3 = 1;
      palCopy = (Texture_pal8bit *)(carObj->render).palCopy;
      sVar1 = (carObj->render).palNum;
      Texture_CarColor = (color & 7U) + ((u_char)(carObj->render).upgradeFlags & 1) * 8;
    }
    else {
      iVar3 = 0;
      palCopy = (Texture_pal8bit *)(carObj->render).palCopy;
      sVar1 = (carObj->render).palNum;
      Texture_CarColor = color & 7;
    }
    Texture_ProcessPaletteCopy(palCopy,iVar3,sVar1);
  }
  (carObj->render).colorIndex = (short)color;
  return;
}

/* ---- DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache  [DRAWC.CPP:1148-1531] SLD-VERIFIED ---- */
int DrawC_PrimStart(Draw_tVertex *center,Car_tObj *carObj,int lightAvg,Draw_CarCache *sd)

{
  int i;
  int cop_flag;
  int half;
  int mirror;
  int overlay;
  int eSpeed;
  int quad;
  short envMap;
  int eColor;
  int eColor2;
  u_int uVar1;
  Draw_tPixMap *pDVar2;
  short tu12;
  int envColor2;
  int sub_ot_p;
  int sub_otz_x4;
  int drawEnv_p;
  int envTexShape;
  int tunnelFlag;
  int shapeData_p;
  short extraShadow;
  int sub_otz_h2;
  int sub_otOffset;
  short extraEnvMap;
  int iVar3;
  short shadow;
  u_char *puVar4;
  int lightAvgScaled;
  int envColor;
  u_int uVar5;
  int shadowQuad;
  int matPart_a;
  int menuPmx_w2;
  int matPart_b;
  int menuPmx_w3;
  int menuPmx_w0;
  int menuPmx_w1;
  int sub_otz;
  int shapeIdx;
  int vertBuf_p;
  int carType;
  int vertCount;
  DRAWENV *LEnv;
  int tpageShadow;
  int nabr_blend;
  int envSpeed;
  int shadowAbsOffs;
  int halfTransp;
  void *tp1;
  u_int shadowTex;
  Draw_tPixMap *reflMap_iter;
  u_int envMapTex;
  u_int shadow_align_a;
  u_int envMap_w0;
  short eIndexEnvMap;
  u_int envMap_w3;
  short eIndexShadow;
  short headLight_bits;
  int envMapBigBit;
  int tp2;
  void *tp3;
  short tu14;
  short tu15;
  u_int envMap_align_a;
  u_int shadowMap_w1;
  int carTypeOffRange;
  int tp8;
  u_int envMap_align_b;
  int tp12;
  u_int shadowMap_w2;
  int tp11;
  long sub_otSize_local;
  u_int shadow_align_b;
  u_int *tp17;
  u_char *tp20;
  u_char *tp4;
  u_short tu27;
  
  envMapBigBit = 0;
  vertCount = (int)(carObj->render).currentCarType;
  matPart_a = (int)&DrawC_gScreenMat;
  carTypeOffRange = vertCount - 0x16U < 6;
gte_SetRotMatrix(&DrawC_gScreenMat);
  matPart_b = (int)&DrawC_gScreenMat;
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
  __asm__ volatile ("mfc2	$t4,$19
	nop
	sra	$t4,$t4,2
	sw	$t4,0(%0)"
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
  shapeIdx = sd->sub_otz;
  sub_otz_h2 = shapeIdx >> 1;
  if (R3DCar_InMenu == 0) {
    sd->sub_otz = sub_otz_h2;
    if ((sub_otz_h2 < 0) || (Draw_gViewOtSize + -3 < sub_otz_h2)) {
      return -1;
    }
  }
  else {
    sd->sub_otz = 0;
  }
  puVar4 = (carObj->render).sort_carObj;
  (carObj->render).world_otz = sd->sub_otz;
  /* shapeIdx morphs in place to <<2 BEFORE the branch (oracle sll s0,s0,2 in
   * the beqz slot region); non-null arm INLINE first (oracle beqz to far arm) */
  shapeIdx = shapeIdx << 2;
  if (puVar4 != (u_char *)0x0) {
    sd->sub_ot = *(u_long **)(puVar4 + 0x86c);
    sd->sub_otSize = *(int *)(puVar4 + 0x870);
    sd->sub_otz = (sd->sub_otz - *(int *)(puVar4 + 0x864)) * 2;
    sub_otOffset = *(int *)(puVar4 + 0x874);
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
  sub_otz_x4 = sd->sub_otz * 4;
  sd->sub_otz = sub_otz_x4;
  (carObj->render).sub_otz = sub_otz_x4 + sub_otOffset - shapeIdx;
  sd->sub_otSize = sd->sub_otSize + -1;
  sd->pmxStart = CarIO_carPixMap + (carObj->render).textureStartIndex;
  sd->offsetU0 = (u_char)(carObj->render).textureOffsetU;
  sd->offsetV0 = (u_char)(carObj->render).textureOffsetV;
  sd->offsetU1 = (carObj->render).licenseOffsetU[0];
  sd->offsetV1 = (carObj->render).licenseOffsetV[0];
  lightAvgScaled = 0x32;
  sd->offsetU2 = (carObj->render).licenseOffsetU[1];
  /* was a bare-VA literal -0x7fee0a94 (= &DrawC_gOverlay[50]) walked by a
   * pointer: really an INDEXED clear of gOverlay[50..0] -- gcc strength-
   * reduction emits the oracle's giv init (lui/addiu sym; addiu +100) and
   * the downstream gOverlay[0] accesses rematerialize the symbol fresh */
  sd->offsetV2 = (carObj->render).licenseOffsetV[1];
  do {
    DrawC_gOverlay[lightAvgScaled] = 0;
    lightAvgScaled = lightAvgScaled + -1;
  } while (-1 < lightAvgScaled);
  if (R3DCar_InMenu == 0) {
    int damageLevel = (carObj->N).damage[0];
    if (0x1e0001 <= damageLevel) {
      DrawC_gOverlay[0] = DrawC_gOverlay[0] | 1;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 1;
    }
    else if (0xa0000 < damageLevel) {
      DrawC_gOverlay[0] = DrawC_gOverlay[0] | 2;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 2;
    }
    damageLevel = (carObj->N).damage[2];
    if (0x1e0001 <= damageLevel) {
      DrawC_gOverlay[0] = DrawC_gOverlay[0] | 0x100;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x100;
    }
    else if (0xa0000 < damageLevel) {
      DrawC_gOverlay[0] = DrawC_gOverlay[0] | 0x200;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x200;
    }
    damageLevel = (carObj->N).damage[3];
    if (0x1e0001 <= damageLevel) {
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x400;
    }
    else if (0xa0000 < damageLevel) {
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x800;
    }
    damageLevel = (carObj->N).damage[4];
    if (0x1e0001 <= damageLevel) {
      DrawC_gOverlay[1] = DrawC_gOverlay[1] | 0x100;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x1000;
    }
    else if (0xa0000 < damageLevel) {
      DrawC_gOverlay[1] = DrawC_gOverlay[1] | 0x200;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x2000;
    }
    damageLevel = (carObj->N).damage[6];
    if (0x1e0001 <= damageLevel) {
      DrawC_gOverlay[1] = DrawC_gOverlay[1] | 1;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x10;
    }
    else if (0xa0000 < damageLevel) {
      DrawC_gOverlay[1] = DrawC_gOverlay[1] | 2;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x20;
    }
    damageLevel = (carObj->N).damage[7];
    if (0x1e0001 <= damageLevel) {
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 4;
    }
    else if (0xa0000 < damageLevel) {
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
    headLight_bits = (carObj->render).headLight;
    if ((headLight_bits & 0x11U) != 0) {
      if (((headLight_bits & 0x40U) != 0) || ((DrawC_gOverlay[0] & 1U) == 0)) {
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
    if (!carTypeOffRange) {
      shadow_align_b = (sd->head).mirror;
      if (((carObj->render).signalLight[shadow_align_b] & 0x80U) != 0) {
        DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | 0x40;
      }
      if (((carObj->render).signalLight[shadow_align_b] & 8U) != 0) {
        if ((DrawC_gOverlay[0] & 1U) == 0) {
          DrawC_gOverlay[0x1b] = DrawC_gOverlay[0x1b] | 0x80;
        }
        if ((DrawC_gOverlay[1] & 1U) == 0) {
          DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | 0x81;
        }
      }
      /* the ^1 is a STATEMENT, not two sub-expressions: retail emits ONE
       * `xori a0,a0,1` mutating the mirror index in place (census xori 3v2). */
      shadow_align_b = shadow_align_b ^ 1;
      if (((carObj->render).signalLight[shadow_align_b] & 0x80U) != 0) {
        DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | 0x4000;
      }
      if (((carObj->render).signalLight[shadow_align_b] & 8U) != 0) {
        if ((DrawC_gOverlay[0] & 0x100U) == 0) {
          DrawC_gOverlay[0x1b] = DrawC_gOverlay[0x1b] | 0x8000;
        }
        if ((DrawC_gOverlay[1] & 0x100U) == 0) {
          DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | 0x8100;
        }
      }
      if (1 < (u_char)R3DCar_SignalBrakeFlare[vertCount]) {   /* @0x800BF468 lbu R3DCar_SignalBrakeFlare(carType) */
        if ((DrawC_gOverlay[0x1c] & 0x40U) == 0) {
          DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | DrawC_gOverlay[0x18] & 0xffU;
        }
        if ((DrawC_gOverlay[0x1c] & 0x4000U) == 0) {
          DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | DrawC_gOverlay[0x18] & 0xff00U;
        }
      }
      if (R3DCar_SignalBrakeFlare[vertCount] == '\x03') {   /* @0x800BF4DC lbu R3DCar_SignalBrakeFlare(carType) */
        /* in-place swap, temps AT the use site (oracle lhu 56; lh 48; sh; sh).
         * g[0x18] is not written between the old fn-head ts13 capture and here,
         * so reading it fresh is value-identical -- and it's the oracle's shape */
        u_short tc = DrawC_gOverlay[0x1c];
        int t8 = DrawC_gOverlay[0x18];   /* INT, not short: a `short` local lets
                             * combine drop the sign-extend and emit lhu (catalog C) */
        DrawC_gOverlay[0x18] = tc;
        DrawC_gOverlay[0x1c] = t8;
      }
      goto DrawCPrimStart_carTypeOff;
    }
  }
  else {
DrawCPrimStart_carTypeOff:
    if (!carTypeOffRange) goto DrawCPrimStart_camRotMatrix;
  }
  {
    /* oracle 0x800BF530..: unconditional |2 / |0x200 stores FIRST (g1b/g1c =
     * the PRE-store lhu pair, reused for the |0x83/|0x281 overwrite), then the
     * siren1 arm reloads fresh and ORs 0x8100 -- no default/override funnel */
    u_short g1b = DrawC_gOverlay[0x1b];
    u_short g1c = DrawC_gOverlay[0x1c];
    DrawC_gOverlay[0x1b] = g1b | 2;
    DrawC_gOverlay[0x1c] = g1c | 0x200;
    if (DrawC_gOverlay[4] == 0) {
      if (DrawC_SirenFlash[(u_short)(carObj->render).signalLight[0] & 0xf] != 0) {
        DrawC_gOverlay[0x1b] = g1b | 0x83;
        DrawC_gOverlay[0x1c] = g1c | 0x281;
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
    shadowAbsOffs = 3;
    drawEnv_p = (int)Draw_GetDRAWENV(gCView.id,gFlip);
    eIndexEnvMap = (carObj->N).eIndexEnvMap;
    eIndexShadow = (carObj->N).eIndexShadow;
    /* quad = SIGNED byte (oracle lb 124); each .extra read ONCE as lhu into a
     * temp -- the &0xff and <<16>>24 both derive from the SAME halfword value */
    iVar3 = (signed char)(carObj->N).simRoadInfo.quad;
    {
      u_int envExtra;
      u_int shadExtra;
      uVar5 = (u_int)(u_short)DrawC_gEnvMap[eIndexEnvMap].tex;
      envExtra = (u_short)DrawC_gEnvMap[eIndexEnvMap].extra;
      shadow_align_b = (u_int)(u_short)DrawC_gShadow[eIndexShadow].tex;
      shadExtra = (u_short)DrawC_gShadow[eIndexShadow].extra;
      nabr_blend = 2;
      if (iVar3 < (int)(envExtra & 0xff)) {
        uVar5 = (int)(envExtra << 0x10) >> 0x18;
      }
      if (iVar3 < (int)(shadExtra & 0xff)) {
        shadow_align_b = (int)(shadExtra << 0x10) >> 0x18;
      }
    }
    if (10 < (short)uVar5) {
      uVar5 = uVar5 - 10;
      envMapBigBit = 1;   /* oracle li s7,1 inside the arm (no bool materialize) */
    }
    if ((int)(shadow_align_b << 0x10) < 0) {
      shadowAbsOffs = 0;
      shadow_align_b = -shadow_align_b;
    }
    if (10 < (short)shadow_align_b) {
      shadow_align_b = shadow_align_b - 10;
      nabr_blend = 1;
    }
    iVar3 = (int)((uVar5 - 1) * 0x10000) >> 0x10;
    if (iVar3 < 0) {
      *(u_int *)&sd->ePmx0 = 0;   /* fused u0/v0/clut word store (oracle sw zero) */
    }
    else {
      /* MATCH: whole-struct copy (both sides Draw_tPixMap) -- gcc's own unaligned
       * struct-assignment codegen (lwl/lwr/swl/swr) reproduces the oracle's
       * 16-byte movstrsi-style block; the old byte/word-peeled shift-mask form
       * was a Ghidra decompile artifact, not the true source shape. */
      sd->ePmx0 = Track_gReflectionMaps[iVar3];
    }
    iVar3 = (int)((shadow_align_b - 1) * 0x10000) >> 0x10;
    if (iVar3 < 0) {
      *(u_int *)&sd->ePmx1 = 0;   /* fused u0/v0/clut word store (oracle sw zero) */
    }
    else {
      RECT tw;
      vertBuf_p = (int)(Track_gReflectionMaps + iVar3);
      tw.x = (short)*(u_char *)vertBuf_p;
      tw.w = 0x80;
      tw.h = 0x40;
      tw.y = (short)Track_gReflectionMaps[iVar3].v0;
      SetDrawMode(&sd->drawModeOn,(u_int)*(u_char *)(drawEnv_p + 0x17),0,
                 (u_int)Track_gReflectionMaps[iVar3].tpage,&tw);
      tw.h = 0;
      tw.w = 0;
      tw.y = 0;
      tw.x = 0;
      SetDrawMode(&sd->drawModeOff,(u_int)*(u_char *)(drawEnv_p + 0x17),0,
                 (u_int)*(u_short *)(drawEnv_p + 0x14),&tw);
      /* MATCH: whole-struct copy (both sides Draw_tPixMap); see ePmx0 above. */
      sd->ePmx1 = Track_gReflectionMaps[iVar3];
      ChangeTPage(&(sd->ePmx1).tpage,nabr_blend);
    }
    sd->eAddZ = ((int)(carObj->N).positionXZ >> shadowAbsOffs + 3 & 0x3fU) +
                (int)DrawC_gEnvMapOffset[(sd->ePmx1).v0 >> 6];
    if (((GameSetup_gData.Weather != 0) &&
        (tunnelFlag = (int)BWorldSm_TunnelFlagSm(&(carObj->N).simRoadInfo), tunnelFlag != 1)) &&
       (Cars_kSkidMarkSurface[(carObj->N).driveSurfaceType] == 1)) {
      DrawC_gWetRoad = 1;
    }
    DrawC_gReflectOffset =
         (short)((((carObj->N).dimension.y * 3 >> 1) + (carObj->N).objAltitude) >> 8);
  }
  else {
    shapeData_p = (int)Draw_GetDRAWENV(gCView.id,gFlip);
    SetDrawMode(&sd->drawModeOn,(u_int)*(u_char *)(shapeData_p + 0x17),1,
               (u_int)*(u_short *)(shapeData_p + 0x14),(RECT *)0x0);
    SetDrawMode(&sd->drawModeOff,(u_int)*(u_char *)(shapeData_p + 0x17),0,
               (u_int)*(u_short *)(shapeData_p + 0x14),(RECT *)0x0);
    /* MATCH: whole-struct copy (both sides Draw_tPixMap); see ePmx0 above. */
    sd->ePmx0 = *gMenuPixmap[0];
  }
  ChangeTPage(&(sd->ePmx0).tpage,1);
  {
    /* SYM: dedicated REG locals eColor / eColor2 (NOT the fn-scope iVar3
     * scratch, whose earlier cross-call web forces a callee-saved home;
     * oracle keeps this chain in caller-saved $a2) */
    int eColor;
    if (R3DCar_InMenu == 0) {
      eColor = (int)((lightAvg >> 2) * (u_int)R3DCar_eMapColour.r) >> 7;
      if (envMapBigBit) {
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

/* ---- DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache  [DRAWC.CPP:1772-2543] SLD-VERIFIED ---- */
void DrawC_Prim(matrixtdef *m,coorddef *t,Transformer_zObj *obj,Transformer_zOverlay *overlay,
               int envmap,Draw_CarCache *sd)

{
  COORD16 * Nvertice;
  COORD16 * vt;
  int u;
  int tvx;
  short t1;
  short t2;
  short t3;
  PCOORD16 * tV;
  POLY_FT3 * prim;
  Transformer_zFacet * facet;
  int id0;
  int id1;
  int id2;
  int bfct;
  u_long color;
  Draw_tPixMap * pmx;
  u_char offsetU;
  u_char offsetV;
  u_char u0;
  u_char u1;
  u_char u2;
  u_char v0;
  u_char v1;
  u_char v2;
  u_short uv0;
  u_short uv1;
  short * z;
  long xy0;
  long xy1;
  long xy2;
  int overlayFlag;
  int facet_flag;
  int sd_otz;
  int index;
  int which;
  Transformer_zOverlay * facetOverlay;
  char cVar1;
  u_short clut;
  int absZ;
  int matRow1_x;
  short *psVar6;
  u_short tpage;
  int matRow0_w1;
  int matRow_temp;
  int envmapMode;
  int bfctResult_b;
  int ti34;
  u_short uv2;
  u_char primTypeByte_b;
  u_char code;
  int iVar7;
  int facetByteOff;
  int iVar8;
  u_int uVar10;
  u_char v;
  int iVar11;
  char *envmapUV_dst;
  short *psVar12;
  int iVar13;
  int iVar14;
  COORD16 *vertex_iter;
  u_int *puVar17;
  int tV_dst;
  int facet_p_v3;
  short facetFlag;
  int remVerts;
  int vertCounter;
  u_int facetIdx;
  int loopDoneTag;
  short ts9;
  short ts10;
  u_char tu1;
  u_char tu4;
  short tu19;
  short tu11;
  short tu12;
  short tu14;
  short tu15;
  short ts6;
  short *vert_yz_iter;
  char tc6;
  short ts7;
  u_short tu21;
  u_short uVar8_00;
  
  Nvertice = obj->Nvertex;
  /* field-fusion: ePmx0.{u0,v0,clut} contiguous 4-byte packed -- ONE lw each */
  if ((*(u_int *)&sd->ePmx0 == 0) && (*(u_int *)&sd->ePmx1 == 0)) {
    envmap = envmap & 0xbe;
  }
  if ((envmap & 1U) != 0) {
    psVar6 = (short *)Nvertice;
gte_SetRotMatrix(&DrawC_gMatA);
gte_SetTransMatrix(&DrawC_gMatA);
    remVerts = (int)obj->numVertex;
    envmapUV_dst = &sd->tV[0].v;
    vert_yz_iter = &Nvertice->z;
    while( true ) {
      remVerts = remVerts - 1;
      if (remVerts == -1) break;
      ts9 = vert_yz_iter[-1];
      ts6 = *vert_yz_iter;
      (sd->vt0).x = *psVar6;
      (sd->vt0).y = ts9;
      (sd->vt0).z = ts6;
gte_ldv0((char *)sd + 0xac);
      gte_rt();
gte_stlvnl((char *)sd + 0x9c);
      absZ = (sd->tv).vz;
      tvx = (sd->tv).vx;    /* int load (lw) -- oracle stores its low byte */
      if (absZ < 0) {
        absZ = -absZ;
      }
      vert_yz_iter = vert_yz_iter + 3;
      psVar6 = psVar6 + 3;
      envmapUV_dst[-1] = (char)tvx;
      *envmapUV_dst = (char)absZ;
      envmapUV_dst = envmapUV_dst + 8;
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
  tV_dst = (int)sd->tV;
  psVar12 = &sd->tV[0].vt.z;
  vertex_iter = obj->vertex;
  vertCounter = (int)obj->numVertex;
  psVar6 = &vertex_iter->z;
  while( true ) {
    vertCounter = vertCounter + -1;
    if (vertCounter == -1) break;
    tu11 = psVar6[-1];
    tu12 = *psVar6;
    psVar6 = psVar6 + 3;
    tu14 = vertex_iter->x;
    vertex_iter = vertex_iter + 1;
    *(short *)tV_dst = tu14;
    psVar12[-1] = tu11;
    *psVar12 = tu12;
    psVar12 = psVar12 + 4;
    tV_dst = tV_dst + 8;
  }
  facetIdx = (u_int)obj->numFacet;
  /* envmap&9 computed AT the switch -- the delay-slot filler pulls the andi
   * into the copy-loop guard's slot (v1 dead in the body), oracle 0x800C0490 */
  switch (envmap & 9) {
  case 0: {
    /* SYM per-case block (wave-9 lever); MAIN loop (envmap&2==0) rebuilt per the
     * oracle 0x800C004C.. and placed FIRST (oracle physical order: main, then alt
     * @0x800C0248 -- the bnez skips forward to the alt loop). */
    u_int *prim;
    int facet;
    int id0;
    int id1;
    int id2;
    int otzSum;
    if ((envmap & 2U) == 0) {
      iVar7 = facetIdx * 0xc;
      while( true ) {
        facetIdx = facetIdx - 1;
        iVar7 = iVar7 + -0xc;
        if (facetIdx == 0xffffffff) {
          return;
        }
        facet = (int)obj->facet + iVar7;
        id0 = *(u_char *)(facet + 3);
        id1 = *(u_char *)(facet + 4);
        id2 = *(u_char *)(facet + 5);
        if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
        /* SYM 3.8b: id0-2 morph index->address IN PLACE (one pseudo each);
         * oracle scales the id regs themselves (sll aN,aN,3; addu aN,aN,s1)
         * and keeps tV's 0xD0 in the lwc2 displacement. */
        id0 = id0 * 8 + (int)sd;
        id1 = id1 * 8 + (int)sd;
        id2 = id2 * 8 + (int)sd;
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
        otzSum = sd->otz + sd->sub_otz;
        sd->otz = otzSum;
        if (otzSum < 0) continue;
        if (sd->sub_otSize < otzSum) continue;
        DRAWC_OTLINK_FT3(sd, prim);
        gte_stsxy3_ft3(prim);
        prim[1] = sd->color;
        *(u_char *)((int)prim + 7) = 0x24;
        {
          Draw_tPixMap *pmx = sd->pmxStart + *(u_char *)(facet + 2);
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
              u_char u0 = *(u_char *)(facet + 6) + offsetU;
              u_char u1 = *(u_char *)(facet + 8) + offsetU;
              u_char u2 = *(u_char *)(facet + 10) + offsetU;
              *(u_char *)(prim + 3) = u0;
              *(u_char *)(prim + 5) = u1;
              *(u_char *)(prim + 7) = u2;
            }
            {
              u_char v0 = *(u_char *)(facet + 7) + offsetV;
              u_char v1 = *(u_char *)(facet + 9) + offsetV;
              u_char v2 = *(u_char *)(facet + 11) + offsetV;
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
            uv0 = *(u_short *)(facet + 6);
            uv1 = *(u_short *)(facet + 8);
            uv2 = *(u_short *)(facet + 10);
            *(u_short *)(prim + 3) = uv0;
            *(u_short *)(prim + 5) = uv1;
            *(u_short *)(prim + 7) = uv2;
          }
        }
      }
    }
    /* ALT loop (envmap&2 set; oracle 0x800C0248..0x800C045C): same skeleton as
     * the main loop -- FT3 self-loading link, code byte 0x24/0x26 by facet
     * flag&1, byte-UV path uses offsetU0/V0, halfword path when flag&1.
     * Sibling block redeclares the SYM names (fresh pseudos, wave-9 lever). */
    {
      u_int *prim;
      int facet;
      int id0;
      int id1;
      int id2;
      int otzSum;
      iVar7 = facetIdx * 0xc;
      while( true ) {
        facetIdx = facetIdx - 1;
        iVar7 = iVar7 + -0xc;
        if (facetIdx == 0xffffffff) {
          return;
        }
        facet = (int)obj->facet + iVar7;
        id0 = *(u_char *)(facet + 3);
        id1 = *(u_char *)(facet + 4);
        id2 = *(u_char *)(facet + 5);
        if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
        /* SYM 3.8b: id0-2 morph index->address in place (oracle sll aN,aN,3) */
        id0 = id0 * 8 + (int)sd;
        id1 = id1 * 8 + (int)sd;
        id2 = id2 * 8 + (int)sd;
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
        otzSum = sd->otz + sd->sub_otz;
        sd->otz = otzSum;
        if (otzSum < 0) continue;
        if (sd->sub_otSize < otzSum) continue;
        DRAWC_OTLINK_FT3(sd, prim);
        gte_stsxy3_ft3(prim);
        {
          u_long color = sd->color;
          u_char code = 0x24;
          if ((*(u_short *)facet & 1) != 0) {
            code = 0x26;
          }
          prim[1] = color;
          *(u_char *)((int)prim + 7) = code;
        }
        if ((*(u_short *)facet & 1) == 0) {
          Draw_tPixMap *pmx = sd->pmxStart + *(u_char *)(facet + 2);
          u_char offsetU = sd->offsetU0;
          u_char offsetV = sd->offsetV0;
          {
            u_short clut = pmx->clut;
            u_short tpage = pmx->tpage;
            *(u_short *)((int)prim + 0xe) = clut;
            *(u_short *)((int)prim + 0x16) = tpage;
          }
          {
            u_char u0 = *(u_char *)(facet + 6) + offsetU;
            u_char u1 = *(u_char *)(facet + 8) + offsetU;
            u_char u2 = *(u_char *)(facet + 10) + offsetU;
            *(u_char *)(prim + 3) = u0;
            *(u_char *)(prim + 5) = u1;
            *(u_char *)(prim + 7) = u2;
          }
          {
            u_char v0 = *(u_char *)(facet + 7) + offsetV;
            u_char v1 = *(u_char *)(facet + 9) + offsetV;
            u_char v2 = *(u_char *)(facet + 11) + offsetV;
            *(u_char *)((int)prim + 0xd) = v0;
            *(u_char *)((int)prim + 0x15) = v1;
            *(u_char *)((int)prim + 0x1d) = v2;
          }
        }
        else {
          Draw_tPixMap *pmx = sd->pmxStart + *(u_char *)(facet + 2);
          u_short clut = pmx->clut;
          u_short tpage = pmx->tpage;
          u_short uv0;
          u_short uv1;
          u_short uv2;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
          uv0 = *(u_short *)(facet + 6);
          uv1 = *(u_short *)(facet + 8);
          uv2 = *(u_short *)(facet + 10);
          *(u_short *)(prim + 3) = uv0;
          *(u_short *)(prim + 5) = uv1;
          *(u_short *)(prim + 7) = uv2;
        }
      }
    }
  }
    break;
  case 1: {
    /* SYM per-case block: literal repeated SYM names redeclared (wave-9 lever);
     * loop rebuilt as while+continue per the oracle (0x800C0460..0x800C08D8). */
    u_int *prim;
    int facet;
    int id0;
    int id1;
    int id2;
    int otzSum;
    iVar7 = facetIdx * 0xc;
    while( true ) {
      facetIdx = facetIdx - 1;
      iVar7 = iVar7 + -0xc;
      if (facetIdx == 0xffffffff) {
        return;
      }
      facet = (int)obj->facet + iVar7;
      id0 = *(u_char *)(facet + 3);
      id1 = *(u_char *)(facet + 4);
      id2 = *(u_char *)(facet + 5);
      if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
      /* SYM 3.8b: id0-2 morph index->address in place (oracle sll aN,aN,3) */
      id0 = id0 * 8 + (int)sd;
      id1 = id1 * 8 + (int)sd;
      id2 = id2 * 8 + (int)sd;
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
      otzSum = sd->otz + sd->sub_otz;
      sd->otz = otzSum;
      if (otzSum < 0) continue;
      if (sd->sub_otSize < otzSum) continue;
      if (((*(u_short *)facet & 0x3f3) != 0) && (*(int *)&sd->ePmx1 != 0)) {
        {
          u_short *z = (u_short *)(Nvertice + *(u_char *)(facet + 3));
          u_short t1 = z[0];
          u_short t2 = z[1];
          u_short t3 = z[2];
          (sd->vt0).x = t1;
          (sd->vt0).y = t2;
          (sd->vt0).z = t3;
        }
        {
          u_short *z = (u_short *)(Nvertice + *(u_char *)(facet + 4));
          u_short t1 = z[0];
          u_short t2 = z[1];
          u_short t3 = z[2];
          (sd->vt1).x = t1;
          (sd->vt1).y = t2;
          (sd->vt1).z = t3;
        }
        {
          u_short *z = (u_short *)(Nvertice + *(u_char *)(facet + 5));
          u_short t1 = z[0];
          u_short t2 = z[1];
          u_short t3 = z[2];
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
          prim[2] = xy0;
          prim[4] = xy1;
          prim[6] = xy2;
        }
        prim[1] = sd->eColor0;
        *(u_char *)((int)prim + 7) = 0x26;
        {
          u_short clut = (sd->ePmx1).clut;
          u_short tpage = (sd->ePmx1).tpage;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
        }
        {
          u_char u = (sd->ePmx1).u0 + 0x40;
          u_char v = (sd->ePmx1).v0 + (char)sd->eAddZ;
          *(u_char *)(prim + 3) = (char)(sd->vt0).y + u;
          *(u_char *)((int)prim + 0xd) = (char)(sd->vt0).z + v;
          *(u_char *)(prim + 5) = (char)(sd->vt1).y + u;
          *(u_char *)((int)prim + 0x15) = (char)(sd->vt1).z + v;
          *(u_char *)(prim + 7) = (char)(sd->vt2).y + u;
          *(u_char *)((int)prim + 0x1d) = (char)(sd->vt2).z + v;
        }
      }
      if (*(int *)&sd->ePmx0 != 0) {
        DRAWC_OTLINK_FT3(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          prim[2] = xy0;
          prim[4] = xy1;
          prim[6] = xy2;
        }
        prim[1] = sd->eColor0;
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
          {
            u_char cu0 = *(u_char *)(id0 + 0xd6);
            u_char cv0 = *(u_char *)(id0 + 0xd7);
            *(u_char *)(prim + 3) = cu0 + u;
            *(u_char *)((int)prim + 0xd) = cv0 + v;
          }
          {
            u_char cu1 = *(u_char *)(id1 + 0xd6);
            u_char cv1 = *(u_char *)(id1 + 0xd7);
            *(u_char *)(prim + 5) = cu1 + u;
            *(u_char *)((int)prim + 0x15) = cv1 + v;
          }
          {
            u_char cu2 = *(u_char *)(id2 + 0xd6);
            u_char cv2 = *(u_char *)(id2 + 0xd7);
            *(u_char *)(prim + 7) = cu2 + u;
            *(u_char *)((int)prim + 0x1d) = cv2 + v;
          }
        }
      }
      DRAWC_OTLINK_FT3(sd, prim);
      {
        long xy0 = *(long *)&sd->dvx0;
        long xy1 = *(long *)&sd->dvx1;
        long xy2 = *(long *)&sd->dvx2;
        prim[2] = xy0;
        prim[4] = xy1;
        prim[6] = xy2;
      }
      prim[1] = sd->color;
      *(u_char *)((int)prim + 7) = 0x24;
      {
        Draw_tPixMap *pmx = sd->pmxStart + *(u_char *)(facet + 2);
        u_short clut = pmx->clut;
        u_short tpage = pmx->tpage;
        u_short uv0;
        u_short uv1;
        u_short uv2;
        *(u_short *)((int)prim + 0xe) = clut;
        *(u_short *)((int)prim + 0x16) = tpage;
        uv0 = *(u_short *)(facet + 6);
        uv1 = *(u_short *)(facet + 8);
        uv2 = *(u_short *)(facet + 10);
        *(u_short *)(prim + 3) = uv0;
        *(u_short *)(prim + 5) = uv1;
        *(u_short *)(prim + 7) = uv2;
      }
    }
  }
  case 8: {
    /* SYM per-case block: literal repeated SYM names redeclared (wave-9 lever);
     * loop rebuilt as while+continue per the oracle (0x800C08DC..0x800C0C58,
     * tails cfLbl1/3 + otStitch24 inlined at their oracle position). */
    u_int *prim;
    int overlayFlag;
    int overlayRaw;
    short facetFlag;
    int facet;
    int id0;
    int id1;
    int id2;
    int facet_flag;
    int sd_otz;
    int otzSum;
    iVar7 = facetIdx * 0xc;
    while( true ) {
      facetIdx = facetIdx - 1;
      iVar7 = iVar7 + -0xc;
      if (facetIdx == 0xffffffff) {
        return;
      }
      facet = (int)obj->facet + iVar7;
      id0 = *(u_char *)(facet + 3);
      id1 = *(u_char *)(facet + 4);
      id2 = *(u_char *)(facet + 5);
      if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
      /* SYM 3.8b: id0-2 morph index->address in place (oracle sll aN,aN,3) */
      id0 = id0 * 8 + (int)sd;
      id1 = id1 * 8 + (int)sd;
      id2 = id2 * 8 + (int)sd;
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
      overlayRaw = (int)((u_int)DrawC_gOverlay[*(u_char *)(facet + 2)] << 0x10);
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
          int ff = facetFlag & 0xfff;
          facet_flag = ff;
          if ((facetFlag & 0x3f0) != 0) {
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
        otzSum = sd->otz + sd->sub_otz;
        sd->otz = otzSum;
        if (otzSum < 0) continue;
        if (sd->sub_otSize < otzSum) continue;
        facet_flag = *(u_short *)facet & 0xfff;
      }
      if ((overlayFlag & 3) != 0) {
        /* SYM block {index,which,facetOverlay} -- FT3B overlay variant */
        int index = *(u_char *)(facet + 2);
        int which = (overlayFlag & 3) - 1;
        Transformer_zOverlay *facetOverlay = overlay + index * 3 + which;
        prim = (u_int *)(sd->head).cprim.PrimPtr;
        DRAWC_OTLINK_FT3B(sd, prim);
        gte_stsxy3_ft3(prim);
        {
          u_long color = 0x808080;
          u_char code = 0x24;
          if ((overlayFlag & 0x80) == 0) {
            color = sd->color;
          }
          if ((facet_flag & 1) != 0) {
            code = 0x26;
          }
          prim[1] = color;
          *(u_char *)((int)prim + 7) = code;
        }
        {
          Draw_tPixMap *pmx = sd->pmxStart + (*(u_char *)(facet + 2) + facetOverlay->offset);
          u_char u = facetOverlay->u;
          u_char v = facetOverlay->v;
          u_short clut = pmx->clut;
          u_short tpage = pmx->tpage;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
          {
            u_char u0 = *(u_char *)(facet + 6) + u;
            u_char u1 = *(u_char *)(facet + 8) + u;
            u_char u2 = *(u_char *)(facet + 10) + u;
            *(u_char *)(prim + 3) = u0;
            *(u_char *)(prim + 5) = u1;
            *(u_char *)(prim + 7) = u2;
          }
          {
            u_char v0 = *(u_char *)(facet + 7) + v;
            u_char v1 = *(u_char *)(facet + 9) + v;
            u_char v2 = *(u_char *)(facet + 11) + v;
            *(u_char *)((int)prim + 0xd) = v0;
            *(u_char *)((int)prim + 0x15) = v1;
            *(u_char *)((int)prim + 0x1d) = v2;
          }
        }
      }
      else {
        prim = (u_int *)(sd->head).cprim.PrimPtr;
        DRAWC_OTLINK_FT3B(sd, prim);
        gte_stsxy3_ft3(prim);
        {
          u_long color = 0x808080;
          u_char code = 0x24;
          if ((overlayFlag & 0x80) == 0) {
            color = sd->color;
          }
          if ((facet_flag & 1) != 0) {
            code = 0x26;
          }
          prim[1] = color;
          *(u_char *)((int)prim + 7) = code;
        }
        {
          Draw_tPixMap *pmx = sd->pmxStart + *(u_char *)(facet + 2);
          u_short clut = pmx->clut;
          u_short tpage = pmx->tpage;
          u_short uv0;
          u_short uv1;
          u_short uv2;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
          uv0 = *(u_short *)(facet + 6);
          uv1 = *(u_short *)(facet + 8);
          uv2 = *(u_short *)(facet + 10);
          *(u_short *)(prim + 3) = uv0;
          *(u_short *)(prim + 5) = uv1;
          *(u_short *)(prim + 7) = uv2;
        }
      }
    }
  }
  case 9: {
    /* SYM per-case block: literal repeated SYM names redeclared (wave-9 lever);
     * loop rebuilt as while+continue per the oracle (0x800C0C5C..0x800C12C8,
     * tails cfLbl2/4 + ePmx1UVEmit inlined at their oracle position). */
    u_int *prim;
    int overlayFlag;
    int overlayRaw;
    short facetFlag;
    int facet;
    int id0;
    int id1;
    int id2;
    int facet_flag;
    int sd_otz;
    int otzSum;
    iVar7 = facetIdx * 0xc;
    while( true ) {
      facetIdx = facetIdx - 1;
      iVar7 = iVar7 + -0xc;
      if (facetIdx == 0xffffffff) {
        return;
      }
      facet = (int)obj->facet + iVar7;
      id0 = *(u_char *)(facet + 3);
      id1 = *(u_char *)(facet + 4);
      id2 = *(u_char *)(facet + 5);
      if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
      /* SYM 3.8b: id0-2 morph index->address in place (oracle sll aN,aN,3) */
      id0 = id0 * 8 + (int)sd;
      id1 = id1 * 8 + (int)sd;
      id2 = id2 * 8 + (int)sd;
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
      overlayRaw = (int)((u_int)DrawC_gOverlay[*(u_char *)(facet + 2)] << 0x10);
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
          int ff = facetFlag & 0xfff;
          facet_flag = ff;
          if ((facetFlag & 0x3f0) != 0) {
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
        otzSum = sd->otz + sd->sub_otz;
        sd->otz = otzSum;
        if (otzSum < 0) continue;
        if (sd->sub_otSize < otzSum) continue;
        facet_flag = *(u_short *)facet & 0xfff;
      }
      if (((facet_flag & 0x3f3) != 0) && (*(int *)&sd->ePmx1 != 0)) {
        {
          u_short *z = (u_short *)(Nvertice + *(u_char *)(facet + 3));
          u_short t1 = z[0];
          u_short t2 = z[1];
          u_short t3 = z[2];
          (sd->vt0).x = t1;
          (sd->vt0).y = t2;
          (sd->vt0).z = t3;
        }
        {
          u_short *z = (u_short *)(Nvertice + *(u_char *)(facet + 4));
          u_short t1 = z[0];
          u_short t2 = z[1];
          u_short t3 = z[2];
          (sd->vt1).x = t1;
          (sd->vt1).y = t2;
          (sd->vt1).z = t3;
        }
        {
          u_short *z = (u_short *)(Nvertice + *(u_char *)(facet + 5));
          u_short t1 = z[0];
          u_short t2 = z[1];
          u_short t3 = z[2];
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
          prim[2] = xy0;
          prim[4] = xy1;
          prim[6] = xy2;
        }
        prim[1] = sd->eColor0;
        *(u_char *)((int)prim + 7) = 0x26;
        {
          u_short clut = (sd->ePmx1).clut;
          u_short tpage = (sd->ePmx1).tpage;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
        }
        {
          u_char u = (sd->ePmx1).u0 + 0x40;
          u_char v = (sd->ePmx1).v0 + (char)sd->eAddZ;
          *(u_char *)(prim + 3) = (char)(sd->vt0).y + u;
          *(u_char *)((int)prim + 0xd) = (char)(sd->vt0).z + v;
          *(u_char *)(prim + 5) = (char)(sd->vt1).y + u;
          *(u_char *)((int)prim + 0x15) = (char)(sd->vt1).z + v;
          *(u_char *)(prim + 7) = (char)(sd->vt2).y + u;
          *(u_char *)((int)prim + 0x1d) = (char)(sd->vt2).z + v;
        }
      }
      if (*(int *)&sd->ePmx0 != 0) {
        DRAWC_OTLINK_FT3(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          prim[2] = xy0;
          prim[4] = xy1;
          prim[6] = xy2;
        }
        if ((overlayFlag & 1) != 0) {
          prim[1] = sd->eColor2;
        }
        else if ((facet_flag & 4) != 0) {
          prim[1] = sd->eColor1;
        }
        else {
          prim[1] = sd->eColor0;
        }
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
          /* idN are morphed addresses: tV[id].u/v = 0xd6/0xd7(idN) (oracle t9/t8/t3) */
          {
            u_char cu0 = *(u_char *)(id0 + 0xd6);
            u_char cv0 = *(u_char *)(id0 + 0xd7);
            *(u_char *)(prim + 3) = cu0 + u;
            *(u_char *)((int)prim + 0xd) = cv0 + v;
          }
          {
            u_char cu1 = *(u_char *)(id1 + 0xd6);
            u_char cv1 = *(u_char *)(id1 + 0xd7);
            *(u_char *)(prim + 5) = cu1 + u;
            *(u_char *)((int)prim + 0x15) = cv1 + v;
          }
          {
            u_char cu2 = *(u_char *)(id2 + 0xd6);
            u_char cv2 = *(u_char *)(id2 + 0xd7);
            *(u_char *)(prim + 7) = cu2 + u;
            *(u_char *)((int)prim + 0x1d) = cv2 + v;
          }
        }
      }
      if ((overlayFlag & 3) != 0) {
        /* SYM block {index,which,facetOverlay} -- FT3B overlay variant */
        int index = *(u_char *)(facet + 2);
        int which = (overlayFlag & 3) - 1;
        Transformer_zOverlay *facetOverlay = overlay + index * 3 + which;
        prim = (u_int *)(sd->head).cprim.PrimPtr;
        DRAWC_OTLINK_FT3B(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          prim[2] = xy0;
          prim[4] = xy1;
          prim[6] = xy2;
        }
        {
          u_long color = sd->color;
          u_char code = 0x24;
          if ((facet_flag & 1) != 0) {
            code = 0x26;
          }
          prim[1] = color;
          *(u_char *)((int)prim + 7) = code;
        }
        {
          Draw_tPixMap *pmx = sd->pmxStart + (*(u_char *)(facet + 2) + facetOverlay->offset);
          u_char u = facetOverlay->u;
          u_char v = facetOverlay->v;
          u_short clut = pmx->clut;
          u_short tpage = pmx->tpage;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
          {
            u_char u0 = *(u_char *)(facet + 6) + u;
            u_char u1 = *(u_char *)(facet + 8) + u;
            u_char u2 = *(u_char *)(facet + 10) + u;
            *(u_char *)(prim + 3) = u0;
            *(u_char *)(prim + 5) = u1;
            *(u_char *)(prim + 7) = u2;
          }
          {
            u_char v0 = *(u_char *)(facet + 7) + v;
            u_char v1 = *(u_char *)(facet + 9) + v;
            u_char v2 = *(u_char *)(facet + 11) + v;
            *(u_char *)((int)prim + 0xd) = v0;
            *(u_char *)((int)prim + 0x15) = v1;
            *(u_char *)((int)prim + 0x1d) = v2;
          }
        }
      }
      else {
        prim = (u_int *)(sd->head).cprim.PrimPtr;
        DRAWC_OTLINK_FT3B(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          prim[2] = xy0;
          prim[4] = xy1;
          prim[6] = xy2;
        }
        {
          u_long color = sd->color;
          u_char code = 0x24;
          if ((facet_flag & 1) != 0) {
            code = 0x26;
          }
          prim[1] = color;
          *(u_char *)((int)prim + 7) = code;
        }
        {
          Draw_tPixMap *pmx = sd->pmxStart + *(u_char *)(facet + 2);
          u_short clut = pmx->clut;
          u_short tpage = pmx->tpage;
          u_short uv0;
          u_short uv1;
          u_short uv2;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
          uv0 = *(u_short *)(facet + 6);
          uv1 = *(u_short *)(facet + 8);
          uv2 = *(u_short *)(facet + 10);
          *(u_short *)(prim + 3) = uv0;
          *(u_short *)(prim + 5) = uv1;
          *(u_short *)(prim + 7) = uv2;
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
  int bfct;
  long xy0;
  long xy1;
  long xy2;
  u_long color;
  u_char code;
  u_short uv1;
  u_short uv2;
  int sVar1;      /* clipW held as INT (oracle: lh, no per-use re-extension) */
  int sVar2;      /* clipH likewise */
  u_short uVar3;
  u_short uVar4;
  u_int *puVar5;
  u_short clut;
  int clipW;
  u_short tpage;
  int iVar6;
  u_int *puVar7;
  u_short uv0;
  u_int uVar8;
  u_int uVar9;
  int clipH;
  u_long *puVar10;
  
  if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr) {
gte_ldv3(vt0,vt1,vt2);
    gte_rtpt();
    gte_nclip();
    gte_stMAC0m(sd->bfct);   /* m-form: swc2 $24,0x44(sd) direct displacement (EA-expander site) */
    iVar6 = sd->bfct;
    if ((sd->head).mirror != 0) {
      iVar6 = -iVar6;
    }
    if (0 < iVar6) {
      gte_stSXY0m(sd->dvx0);   /* m-form: swc2 $12,0xC4(sd) etc. */
      gte_stSXY1m(sd->dvx1);
      gte_stSXY2m(sd->dvx2);
      sVar1 = (sd->head).clipW;
      sVar2 = (sd->head).clipH;
      if (((((((sd->dvx0 <= sVar1) || (sd->dvx1 <= sVar1)) || (sd->dvx2 <= sVar1)) &&
            (((-1 < sd->dvx0 || (-1 < sd->dvx1)) || (-1 < sd->dvx2)))) &&
           (((sd->dvy0 <= sVar2 || (sd->dvy1 <= sVar2)) || (sd->dvy2 <= sVar2)))) &&
          (((-1 < sd->dvy0 || (-1 < sd->dvy1)) || (-1 < sd->dvy2)))) &&
         (((-1 < vt0->z || (-1 < vt1->z)) || (-1 < vt2->z)))) {
        gte_avsz3();
        gte_stOTZm(sd->otz);
        iVar6 = sd->otz + sd->sub_otz;
        sd->otz = iVar6;
        if ((-1 < iVar6) && (iVar6 <= sd->sub_otSize)) {
          /* OT-link, EA DMPSX-analog FIXED-REG TEMPLATE variant A / FULL BLOCK (2026-07-09):
           * prim = sd->PrimPtr; slot = sd->sub_ot + sd->otz; sd->PrimPtr += 0x20;
           * prim->tag = slot->addr24 | (7<<24); slot->addr24 = prim.
           * $t4/$t5/$t6 hardcoded (the expander's temps); prim is the asm OUTPUT. */
          __asm__ volatile(
              "lw	%0,4(%1)
	lw	$t4,60(%1)
	lw	$t5,56(%1)
	addiu	$t6,%0,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4(%1)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,%0,8
	sw	$t6,0(%0)
	swl	$t4,2($t5)"
              : "=&r"(puVar7) : "r"(sd)
              : "$12", "$13", "$14", "memory");
          uVar8 = *(u_int *)&sd->dvx1;
          uVar9 = *(u_int *)&sd->dvx2;
          puVar7[2] = *(u_int *)&sd->dvx0;
          puVar7[4] = uVar8;
          puVar7[6] = uVar9;
          puVar7[1] = sd->color;
          *(u_char *)((int)puVar7 + 7) = 0x24;
          clut  = pmx->clut;                       /* clut first (v0), tpage second (a0) */
          tpage = pmx->tpage;
          *(u_short *)((int)puVar7 + 0xe) = clut;
          *(u_short *)((int)puVar7 + 0x16) = tpage;
          uv1 = *u1;                               /* u1 loads FIRST (a0) */
          uv0 = *u0;                               /* then u0 (a1) */
          uv2 = *u2;                               /* then u2 (v0) */
          *(u_short *)(puVar7 + 3) = uv0;
          *(u_short *)(puVar7 + 5) = uv1;
          *(u_short *)(puVar7 + 7) = uv2;
        }
      }
    }
  }
  return;
}

/* ---- DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache  [DRAWC.CPP:2647-3495] SLD-VERIFIED ---- */
void DrawC_PrimClip(matrixtdef *m,coorddef *t,Transformer_zObj *obj,Transformer_zOverlay *overlay,
               int envmap,Draw_CarCache *sd)

{
  int iVar11;
  u_int facetIdx;
  int Nvertex_p;
  u_char *u2;
  int vt2_00;
  int u2_00;
  u_char *u1;
  int vt1;
  int vt2;

  Nvertex_p = (int)obj->Nvertex;
  if ((*(int *)&sd->ePmx0 == 0) && (*(int *)&sd->ePmx1 == 0)) {
    envmap = envmap & 0xbe;
  }
  if ((envmap & 1U) != 0) {
    /* SYM block-scope rebuild (SEAL rule 8c): this whole envmap-UV loop is its
     * OWN nested SYM block chain (line=18/19/27/31, va 0x800c15c8-0x800c16bc)
     * distinct from psVar8's later, unrelated facet-vertex uses -- give it a
     * fresh block-scoped 'vt' pseudo (shadowing the outer psVar8) instead of
     * reusing the function-scope one, matching the oracle's short-lived reg. */
    short *psVar8 = (short *)Nvertex_p;
gte_SetRotMatrix(&DrawC_gMatA);
gte_SetTransMatrix(&DrawC_gMatA);
    char *envmapUV_dst = &sd->tV[0].v;
    short *vert_yz_iter = (short *)(Nvertex_p + 4);
    int facetCount = (int)obj->numVertex;
    while( true ) {
      facetCount = facetCount - 1;
      if (facetCount == -1) break;
      short matRow_y = vert_yz_iter[-1];
      short matRow_z = *vert_yz_iter;
      (sd->vt0).x = *psVar8;
      (sd->vt0).y = matRow_y;
      (sd->vt0).z = matRow_z;
gte_ldv0((char *)sd + 0xac);
      gte_rt();
gte_stlvnl((char *)sd + 0x9c);
      int absZ_envmap = (sd->tv).vz;
      int tvx = (sd->tv).vx;   /* int load (lw) -- oracle stores its low byte */
      if (absZ_envmap < 0) {
        absZ_envmap = -absZ_envmap;
      }
      vert_yz_iter = vert_yz_iter + 3;
      psVar8 = psVar8 + 3;
      envmapUV_dst[-1] = (char)tvx;
      *envmapUV_dst = (char)absZ_envmap;
      envmapUV_dst = envmapUV_dst + 8;
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
   * wraps a nested {x,y,z}/{t1,t2,t3} loop block chain -- fresh block-scoped
   * locals here (psVar8 shadows the outer/later-reused function-scope one;
   * tV_dst/vertex_p/vertCounter/psVar22/vert_y/vert_z/vy_word/vz_word are
   * ONLY used in this loop, so they move down entirely). */
  {
    short *psVar8 = &sd->tV[0].vt.z;
    int tV_dst = (int)sd->tV;
    int vertex_p = (int)obj->vertex;
    int vertCounter = (int)obj->numVertex;
    short *psVar22 = (short *)(vertex_p + 4);
    while( true ) {
      vertCounter = vertCounter - 1;
      if (vertCounter == -1) break;
      short vert_y = psVar22[-1];
      short vert_z = *psVar22;
      (((Draw_CarVertex *)tV_dst)->vt).x = *(short *)vertex_p;
      psVar8[-1] = vert_y;
      *psVar8 = vert_z;
gte_ldv0((char *)sd + 0xd0);
      gte_rt();
gte_stlvnl((char *)sd + 0x9c);
      psVar22 = psVar22 + 3;
      int vy_word = (sd->tv).vy;
      int vz_word = (sd->tv).vz;
      vertex_p = vertex_p + 6;
      *(short *)tV_dst = (short)(sd->tv).vx;
      psVar8[-1] = (short)vy_word;
      *psVar8 = (short)vz_word;
      psVar8 = psVar8 + 4;
      tV_dst = tV_dst + 8;
    }
  }
gte_SetRotMatrix(&DrawC_gScreenMat);
gte_SetTransMatrix(&DrawC_gScreenMat);
  facetIdx = (u_int)obj->numFacet;
  /* dispatch = real switch(envmap&9), case bodies in oracle VA order
   * (case 0 @0x800C18E0, 1 @0x800C2000, 8 @0x800C25BC, 9 @0x800C2AA0) */
  switch (envmap & 9) {
  case 0: {
      vt1 = (int)&sd->vt3;
      if ((envmap & 0x20U) == 0) {
        /* SYM block line=97 {prim,facet,id0,id1,id2} -- literal repeated SYM
         * names redeclared per case block (wave-9 same-identifier lever);
         * loop rebuilt as while+continue chains per the oracle's slot-filled
         * -1/+1 counter compensation (raw 0x800C18F4..0x800C1CB0). */
        u_int *prim;
        int facet;
        int id0;
        int id1;
        int id2;
        int otzSum;
        iVar11 = facetIdx * 0xc;
        while( true ) {
          facetIdx = facetIdx - 1;
          iVar11 = iVar11 + -0xc;
          if (facetIdx == 0xffffffff) {
            return;
          }
          facet = (int)obj->facet + iVar11;
          id0 = *(u_char *)(facet + 3);
          id1 = *(u_char *)(facet + 4);
          id2 = *(u_char *)(facet + 5);
          if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
          /* SYM 3.8b: id0-2 morph index->address in place (oracle sll aN,aN,3) */
          id0 = id0 * 8 + (int)sd;
          id1 = id1 * 8 + (int)sd;
          id2 = id2 * 8 + (int)sd;
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
            u_short z0 = *(u_short *)(id0 + 0xd4);
            u_short z1 = *(u_short *)(id1 + 0xd4);
            u_short z2 = *(u_short *)(id2 + 0xd4);
            (sd->vt0).z = z0;
            (sd->vt1).z = z1;
            (sd->vt2).z = z2;
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
          otzSum = sd->otz + sd->sub_otz;
          sd->otz = otzSum;
          if (otzSum < 0) continue;
          if (sd->sub_otSize < otzSum) continue;
          DRAWC_OTLINK_FT3(sd, prim);
          {
            long xy2 = *(long *)&sd->dvx2;
            long xy0 = *(long *)&sd->dvx0;
            long xy1 = *(long *)&sd->dvx1;
            prim[6] = xy2;
            prim[2] = xy0;
            prim[4] = xy1;
          }
          {
            u_long color = sd->color;
            u_char code = 0x24;
            if ((*(u_short *)facet & 1) != 0) {
              code = 0x26;
            }
            prim[1] = color;
            *(u_char *)((int)prim + 7) = code;
          }
          if (((envmap & 2U) != 0) && ((*(u_short *)facet & 1) == 0)) {
            /* SYM block line=189 {pmx {u0..v2,u,v,clut,tpage}} */
            Draw_tPixMap *pmx = sd->pmxStart + *(u_char *)(facet + 2);
            u_char u = sd->offsetU0;
            u_char v = sd->offsetV0;
            u_short clut = pmx->clut;
            u_short tpage = pmx->tpage;
            *(u_short *)((int)prim + 0xe) = clut;
            *(u_short *)((int)prim + 0x16) = tpage;
            {
              u_char u0 = *(u_char *)(facet + 6) + u;
              u_char u1 = *(u_char *)(facet + 8) + u;
              u_char u2 = *(u_char *)(facet + 10) + u;
              *(u_char *)(prim + 3) = u0;
              *(u_char *)(prim + 5) = u1;
              *(u_char *)(prim + 7) = u2;
            }
            {
              u_char v0 = *(u_char *)(facet + 7) + v;
              u_char v1 = *(u_char *)(facet + 9) + v;
              u_char v2 = *(u_char *)(facet + 11) + v;
              *(u_char *)((int)prim + 0xd) = v0;
              *(u_char *)((int)prim + 0x15) = v1;
              *(u_char *)((int)prim + 0x1d) = v2;
            }
          }
          else {
            /* SYM block line=194 {pmx {offsetU,offsetV {u0..v2,clut,tpage}}} */
            Draw_tPixMap *pmx = sd->pmxStart + *(u_char *)(facet + 2);
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
                u_char u0 = *(u_char *)(facet + 6) + offsetU;
                u_char u1 = *(u_char *)(facet + 8) + offsetU;
                u_char u2 = *(u_char *)(facet + 10) + offsetU;
                *(u_char *)(prim + 3) = u0;
                *(u_char *)(prim + 5) = u1;
                *(u_char *)(prim + 7) = u2;
              }
              {
                u_char v0 = *(u_char *)(facet + 7) + offsetV;
                u_char v1 = *(u_char *)(facet + 9) + offsetV;
                u_char v2 = *(u_char *)(facet + 11) + offsetV;
                *(u_char *)((int)prim + 0xd) = v0;
                *(u_char *)((int)prim + 0x15) = v1;
                *(u_char *)((int)prim + 0x1d) = v2;
              }
            }
            else {
              /* SYM block line=210 {uv0,uv1,uv2,clut,tpage} */
              u_short clut = pmx->clut;
              u_short tpage = pmx->tpage;
              u_short uv0;
              u_short uv1;
              u_short uv2;
              *(u_short *)((int)prim + 0xe) = clut;
              *(u_short *)((int)prim + 0x16) = tpage;
              uv0 = *(u_short *)(facet + 6);
              uv1 = *(u_short *)(facet + 8);
              uv2 = *(u_short *)(facet + 10);
              *(u_short *)(prim + 3) = uv0;
              *(u_short *)(prim + 5) = uv1;
              *(u_short *)(prim + 7) = uv2;
            }
          }
        }
      }
      vt2 = (int)&sd->vt5;
      u1 = &sd->u3;
      u2_00 = (int)&sd->u5;
      vt2_00 = (int)&sd->vt4;
      u2 = &sd->u4;
      iVar11 = facetIdx * 0xc;
      while( true ) {
        facetIdx = facetIdx - 1;
        iVar11 = iVar11 + -0xc;
        if (facetIdx == 0xffffffff) break;
        {
        /* SYM block line=218 {facet,id0,id1,id2,pmx} -- literal repeated SYM
         * names redeclared per case block (wave-9 same-identifier lever) */
        int facet = (int)obj->facet + iVar11;
        int id0 = *(u_char *)(facet + 3);
        int id1 = *(u_char *)(facet + 4);
        int id2 = *(u_char *)(facet + 5);
        Draw_tPixMap *pmx = sd->pmxStart + *(u_char *)(facet + 2);
        {
          u_short *z = (u_short *)(sd->tV + id0);
          u_short t1 = z[0];
          u_short t2 = z[1];
          u_short t3 = z[2];
          (sd->vt0).x = t1;
          (sd->vt0).y = t2;
          (sd->vt0).z = t3;
        }
        {
          u_short *z = (u_short *)(sd->tV + id1);
          u_short t1 = z[0];
          u_short t2 = z[1];
          u_short t3 = z[2];
          (sd->vt1).x = t1;
          (sd->vt1).y = t2;
          (sd->vt1).z = t3;
        }
        {
          u_short *z = (u_short *)(sd->tV + id2);
          u_short t1 = z[0];
          u_short t2 = z[1];
          u_short t3 = z[2];
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
          u_short uv0 = *(u_short *)(facet + 6);
          u_short uv1 = *(u_short *)(facet + 8);
          u_short uv2 = *(u_short *)(facet + 10);
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
        DrawC_DividePrim(&sd->vt0,(COORD16 *)vt1,(COORD16 *)vt2,(u_short *)&sd->u0,(u_short *)u1,
                   (u_short *)u2_00,pmx,sd);
        DrawC_DividePrim((COORD16 *)vt1,&sd->vt1,(COORD16 *)vt2_00,(u_short *)u1,(u_short *)&sd->u1,
                   (u_short *)u2,pmx,sd);
        DrawC_DividePrim((COORD16 *)vt2,(COORD16 *)vt2_00,&sd->vt2,(u_short *)u2_00,(u_short *)u2,
                   (u_short *)&sd->u2,pmx,sd);
        DrawC_DividePrim((COORD16 *)vt2,(COORD16 *)vt1,(COORD16 *)vt2_00,(u_short *)u2_00,(u_short *)u1,
                   (u_short *)u2,pmx,sd);
        }
      }
    return;
  }
  case 1: {
    /* SYM block line=279 {prim,facet,id0,id1,id2} -- literal repeated SYM
     * names redeclared per case block (wave-9 same-identifier lever);
     * loop rebuilt as while+continue chains per the oracle (0x800C2014..). */
    u_int *prim;
    int facet;
    int id0;
    int id1;
    int id2;
    int otzSum;
    iVar11 = facetIdx * 0xc;
    while( true ) {
      facetIdx = facetIdx - 1;
      iVar11 = iVar11 + -0xc;
      if (facetIdx == 0xffffffff) {
        return;
      }
      facet = (int)obj->facet + iVar11;
      id0 = *(u_char *)(facet + 3);
      id1 = *(u_char *)(facet + 4);
      id2 = *(u_char *)(facet + 5);
      if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
      /* SYM 3.8b: id0-2 morph index->address in place (oracle sll aN,aN,3) */
      id0 = id0 * 8 + (int)sd;
      id1 = id1 * 8 + (int)sd;
      id2 = id2 * 8 + (int)sd;
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
        u_short z0 = *(u_short *)(id0 + 0xd4);
        u_short z1 = *(u_short *)(id1 + 0xd4);
        u_short z2 = *(u_short *)(id2 + 0xd4);
        (sd->vt0).z = z0;
        (sd->vt1).z = z1;
        (sd->vt2).z = z2;
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
      otzSum = sd->otz + sd->sub_otz;
      sd->otz = otzSum;
      if (otzSum < 0) continue;
      if (sd->sub_otSize < otzSum) continue;
      if (((*(u_short *)facet & 0x3f3) != 0) && (*(int *)&sd->ePmx1 != 0)) {
        {
          u_short *z = (u_short *)(Nvertex_p + (u_int)*(u_char *)(facet + 3) * 6);
          u_short t1 = z[0];
          u_short t2 = z[1];
          u_short t3 = z[2];
          (sd->vt0).x = t1;
          (sd->vt0).y = t2;
          (sd->vt0).z = t3;
        }
        {
          u_short *z = (u_short *)(Nvertex_p + (u_int)*(u_char *)(facet + 4) * 6);
          u_short t1 = z[0];
          u_short t2 = z[1];
          u_short t3 = z[2];
          (sd->vt1).x = t1;
          (sd->vt1).y = t2;
          (sd->vt1).z = t3;
        }
        {
          u_short *z = (u_short *)(Nvertex_p + (u_int)*(u_char *)(facet + 5) * 6);
          u_short t1 = z[0];
          u_short t2 = z[1];
          u_short t3 = z[2];
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
          prim[2] = xy0;
          prim[4] = xy1;
          prim[6] = xy2;
        }
        prim[1] = sd->eColor0;
        *(u_char *)((int)prim + 7) = 0x26;
        {
          u_short clut = (sd->ePmx1).clut;
          u_short tpage = (sd->ePmx1).tpage;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
        }
        {
          u_char u = (sd->ePmx1).u0 + 0x40;
          u_char v = (sd->ePmx1).v0 + (char)sd->eAddZ;
          *(u_char *)(prim + 3) = (char)(sd->vt0).y + u;
          *(u_char *)((int)prim + 0xd) = (char)(sd->vt0).z + v;
          *(u_char *)(prim + 5) = (char)(sd->vt1).y + u;
          *(u_char *)((int)prim + 0x15) = (char)(sd->vt1).z + v;
          *(u_char *)(prim + 7) = (char)(sd->vt2).y + u;
          *(u_char *)((int)prim + 0x1d) = (char)(sd->vt2).z + v;
        }
      }
      if (*(int *)&sd->ePmx0 != 0) {
        DRAWC_OTLINK_FT3(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          prim[2] = xy0;
          prim[4] = xy1;
          prim[6] = xy2;
        }
        prim[1] = sd->eColor0;
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
          /* idN are morphed addresses: tV[id].u/v = 0xd6/0xd7(idN) (oracle t9/t8/t3) */
          {
            u_char cu0 = *(u_char *)(id0 + 0xd6);
            u_char cv0 = *(u_char *)(id0 + 0xd7);
            *(u_char *)(prim + 3) = cu0 + u;
            *(u_char *)((int)prim + 0xd) = cv0 + v;
          }
          {
            u_char cu1 = *(u_char *)(id1 + 0xd6);
            u_char cv1 = *(u_char *)(id1 + 0xd7);
            *(u_char *)(prim + 5) = cu1 + u;
            *(u_char *)((int)prim + 0x15) = cv1 + v;
          }
          {
            u_char cu2 = *(u_char *)(id2 + 0xd6);
            u_char cv2 = *(u_char *)(id2 + 0xd7);
            *(u_char *)(prim + 7) = cu2 + u;
            *(u_char *)((int)prim + 0x1d) = cv2 + v;
          }
        }
      }
      DRAWC_OTLINK_FT3(sd, prim);
      {
        long xy0 = *(long *)&sd->dvx0;
        long xy1 = *(long *)&sd->dvx1;
        long xy2 = *(long *)&sd->dvx2;
        prim[2] = xy0;
        prim[4] = xy1;
        prim[6] = xy2;
      }
      prim[1] = sd->color;
      *(u_char *)((int)prim + 7) = 0x24;
      {
        Draw_tPixMap *pmx = sd->pmxStart + *(u_char *)(facet + 2);
        u_short clut = pmx->clut;
        u_short tpage = pmx->tpage;
        u_short uv0;
        u_short uv1;
        u_short uv2;
        *(u_short *)((int)prim + 0xe) = clut;
        *(u_short *)((int)prim + 0x16) = tpage;
        uv0 = *(u_short *)(facet + 6);
        uv1 = *(u_short *)(facet + 8);
        uv2 = *(u_short *)(facet + 10);
        *(u_short *)(prim + 3) = uv0;
        *(u_short *)(prim + 5) = uv1;
        *(u_short *)(prim + 7) = uv2;
      }
    }
  }
  case 8: {
    /* SYM block line=449 {prim,overlayFlag,facetFlag,facet,id0,id1,id2} --
     * literal repeated SYM names redeclared per case (wave-9 lever); loop
     * rebuilt as while+continue chains per the oracle (0x800C25D0..). */
    u_int *prim;
    int overlayFlag;
    int overlayRaw;
    short facetFlag;
    int facet;
    int id0;
    int id1;
    int id2;
    int facet_flag;
    int sd_otz;
    int otzSum;
    iVar11 = facetIdx * 0xc;
    while( true ) {
      facetIdx = facetIdx - 1;
      iVar11 = iVar11 + -0xc;
      if (facetIdx == 0xffffffff) {
        return;
      }
      facet = (int)obj->facet + iVar11;
      id0 = *(u_char *)(facet + 3);
      id1 = *(u_char *)(facet + 4);
      id2 = *(u_char *)(facet + 5);
      if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
      /* SYM 3.8b: id0-2 morph index->address in place (oracle sll aN,aN,3) */
      id0 = id0 * 8 + (int)sd;
      id1 = id1 * 8 + (int)sd;
      id2 = id2 * 8 + (int)sd;
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
        u_short z0 = *(u_short *)(id0 + 0xd4);
        u_short z1 = *(u_short *)(id1 + 0xd4);
        u_short z2 = *(u_short *)(id2 + 0xd4);
        (sd->vt0).z = z0;
        (sd->vt1).z = z1;
        (sd->vt2).z = z2;
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
      overlayRaw = (int)((u_int)DrawC_gOverlay[*(u_char *)(facet + 2)] << 0x10);
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
          int ff = facetFlag & 0xfff;
          facet_flag = ff;
          if ((facetFlag & 0x3f0) != 0) {
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
        otzSum = sd->otz + sd->sub_otz;
        sd->otz = otzSum;
        if (otzSum < 0) continue;
        if (sd->sub_otSize < otzSum) continue;
        facet_flag = *(u_short *)facet & 0xfff;
      }
      if ((overlayFlag & 3) != 0) {
        /* SYM block line=550 {index,which,facetOverlay} -- FT3B overlay variant */
        int index = *(u_char *)(facet + 2);
        int which = (overlayFlag & 3) - 1;
        Transformer_zOverlay *facetOverlay = overlay + index * 3 + which;
        prim = (u_int *)(sd->head).cprim.PrimPtr;
        DRAWC_OTLINK_FT3B(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          prim[2] = xy0;
          prim[4] = xy1;
          prim[6] = xy2;
        }
        {
          u_long color = 0x808080;
          u_char code = 0x24;
          if ((overlayFlag & 0x80) == 0) {
            color = sd->color;
          }
          if ((facet_flag & 1) != 0) {
            code = 0x26;
          }
          prim[1] = color;
          *(u_char *)((int)prim + 7) = code;
        }
        {
          Draw_tPixMap *pmx = sd->pmxStart + (*(u_char *)(facet + 2) + facetOverlay->offset);
          u_char u = facetOverlay->u;
          u_char v = facetOverlay->v;
          u_short clut = pmx->clut;
          u_short tpage = pmx->tpage;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
          {
            u_char u0 = *(u_char *)(facet + 6) + u;
            u_char u1 = *(u_char *)(facet + 8) + u;
            u_char u2 = *(u_char *)(facet + 10) + u;
            *(u_char *)(prim + 3) = u0;
            *(u_char *)(prim + 5) = u1;
            *(u_char *)(prim + 7) = u2;
          }
          {
            u_char v0 = *(u_char *)(facet + 7) + v;
            u_char v1 = *(u_char *)(facet + 9) + v;
            u_char v2 = *(u_char *)(facet + 11) + v;
            *(u_char *)((int)prim + 0xd) = v0;
            *(u_char *)((int)prim + 0x15) = v1;
            *(u_char *)((int)prim + 0x1d) = v2;
          }
        }
      }
      else {
        DRAWC_OTLINK_FT3(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          prim[2] = xy0;
          prim[4] = xy1;
          prim[6] = xy2;
        }
        {
          u_long color = 0x808080;
          u_char code = 0x24;
          if ((overlayFlag & 0x80) == 0) {
            color = sd->color;
          }
          if ((facet_flag & 1) != 0) {
            code = 0x26;
          }
          prim[1] = color;
          *(u_char *)((int)prim + 7) = code;
        }
        {
          Draw_tPixMap *pmx = sd->pmxStart + *(u_char *)(facet + 2);
          u_short clut = pmx->clut;
          u_short tpage = pmx->tpage;
          u_short uv0;
          u_short uv1;
          u_short uv2;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
          uv0 = *(u_short *)(facet + 6);
          uv1 = *(u_short *)(facet + 8);
          uv2 = *(u_short *)(facet + 10);
          *(u_short *)(prim + 3) = uv0;
          *(u_short *)(prim + 5) = uv1;
          *(u_short *)(prim + 7) = uv2;
        }
      }
    }
  }
  case 9: {
    /* SYM block line=609 {prim,overlayFlag,facetFlag,facet,id0,id1,id2} --
     * literal repeated SYM names redeclared per case (wave-9 lever); loop
     * rebuilt as while+continue chains per the oracle (0x800C2AB4..). */
    u_int *prim;
    int overlayFlag;
    int overlayRaw;
    short facetFlag;
    int facet;
    int id0;
    int id1;
    int id2;
    int facet_flag;
    int sd_otz;
    int otzSum;
    iVar11 = facetIdx * 0xc;
    while( true ) {
      facetIdx = facetIdx - 1;
      iVar11 = iVar11 + -0xc;
      if (facetIdx == 0xffffffff) {
        return;
      }
      facet = (int)obj->facet + iVar11;
      id0 = *(u_char *)(facet + 3);
      id1 = *(u_char *)(facet + 4);
      id2 = *(u_char *)(facet + 5);
      if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
      /* SYM 3.8b: id0-2 morph index->address in place (oracle sll aN,aN,3) */
      id0 = id0 * 8 + (int)sd;
      id1 = id1 * 8 + (int)sd;
      id2 = id2 * 8 + (int)sd;
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
        u_short z0 = *(u_short *)(id0 + 0xd4);
        u_short z1 = *(u_short *)(id1 + 0xd4);
        u_short z2 = *(u_short *)(id2 + 0xd4);
        (sd->vt0).z = z0;
        (sd->vt1).z = z1;
        (sd->vt2).z = z2;
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
      overlayRaw = (int)((u_int)DrawC_gOverlay[*(u_char *)(facet + 2)] << 0x10);
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
          int ff = facetFlag & 0xfff;
          facet_flag = ff;
          if ((facetFlag & 0x3f0) != 0) {
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
        otzSum = sd->otz + sd->sub_otz;
        sd->otz = otzSum;
        if (otzSum < 0) continue;
        if (sd->sub_otSize < otzSum) continue;
        facet_flag = *(u_short *)facet & 0xfff;
      }
      if ((envmap & 0x20U) != 0) {
        if ((facet_flag & 1) != 0) continue;
      }
      if (((facet_flag & 0x3f3) != 0) && (*(int *)&sd->ePmx1 != 0)) {
        {
          u_short *z = (u_short *)(Nvertex_p + (u_int)*(u_char *)(facet + 3) * 6);
          u_short t1 = z[0];
          u_short t2 = z[1];
          u_short t3 = z[2];
          (sd->vt0).x = t1;
          (sd->vt0).y = t2;
          (sd->vt0).z = t3;
        }
        {
          u_short *z = (u_short *)(Nvertex_p + (u_int)*(u_char *)(facet + 4) * 6);
          u_short t1 = z[0];
          u_short t2 = z[1];
          u_short t3 = z[2];
          (sd->vt1).x = t1;
          (sd->vt1).y = t2;
          (sd->vt1).z = t3;
        }
        {
          u_short *z = (u_short *)(Nvertex_p + (u_int)*(u_char *)(facet + 5) * 6);
          u_short t1 = z[0];
          u_short t2 = z[1];
          u_short t3 = z[2];
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
          prim[2] = xy0;
          prim[4] = xy1;
          prim[6] = xy2;
        }
        prim[1] = sd->eColor0;
        *(u_char *)((int)prim + 7) = 0x26;
        {
          u_short clut = (sd->ePmx1).clut;
          u_short tpage = (sd->ePmx1).tpage;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
        }
        {
          u_char u = (sd->ePmx1).u0 + 0x40;
          u_char v = (sd->ePmx1).v0 + (char)sd->eAddZ;
          *(u_char *)(prim + 3) = (char)(sd->vt0).y + u;
          *(u_char *)((int)prim + 0xd) = (char)(sd->vt0).z + v;
          *(u_char *)(prim + 5) = (char)(sd->vt1).y + u;
          *(u_char *)((int)prim + 0x15) = (char)(sd->vt1).z + v;
          *(u_char *)(prim + 7) = (char)(sd->vt2).y + u;
          *(u_char *)((int)prim + 0x1d) = (char)(sd->vt2).z + v;
        }
      }
      if (*(int *)&sd->ePmx0 != 0) {
        DRAWC_OTLINK_FT3(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          prim[2] = xy0;
          prim[4] = xy1;
          prim[6] = xy2;
        }
        if ((overlayFlag & 1) != 0) {
          prim[1] = sd->eColor2;
        }
        else if ((facet_flag & 4) != 0) {
          prim[1] = sd->eColor1;
        }
        else {
          prim[1] = sd->eColor0;
        }
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
          /* idN are morphed addresses: tV[id].u/v = 0xd6/0xd7(idN) (oracle t9/t8/t3) */
          {
            u_char cu0 = *(u_char *)(id0 + 0xd6);
            u_char cv0 = *(u_char *)(id0 + 0xd7);
            *(u_char *)(prim + 3) = cu0 + u;
            *(u_char *)((int)prim + 0xd) = cv0 + v;
          }
          {
            u_char cu1 = *(u_char *)(id1 + 0xd6);
            u_char cv1 = *(u_char *)(id1 + 0xd7);
            *(u_char *)(prim + 5) = cu1 + u;
            *(u_char *)((int)prim + 0x15) = cv1 + v;
          }
          {
            u_char cu2 = *(u_char *)(id2 + 0xd6);
            u_char cv2 = *(u_char *)(id2 + 0xd7);
            *(u_char *)(prim + 7) = cu2 + u;
            *(u_char *)((int)prim + 0x1d) = cv2 + v;
          }
        }
      }
      if ((overlayFlag & 3) != 0) {
        /* SYM block {index,which,facetOverlay} -- FT3B overlay variant */
        int index = *(u_char *)(facet + 2);
        int which = (overlayFlag & 3) - 1;
        Transformer_zOverlay *facetOverlay = overlay + index * 3 + which;
        prim = (u_int *)(sd->head).cprim.PrimPtr;
        DRAWC_OTLINK_FT3B(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          prim[2] = xy0;
          prim[4] = xy1;
          prim[6] = xy2;
        }
        {
          u_long color = sd->color;
          u_char code = 0x24;
          if ((facet_flag & 1) != 0) {
            code = 0x26;
          }
          prim[1] = color;
          *(u_char *)((int)prim + 7) = code;
          if ((facet_flag & 1) != 0) {
            *(u_char *)((int)prim + 7) = code | 2;
          }
        }
        {
          Draw_tPixMap *pmx = sd->pmxStart + (*(u_char *)(facet + 2) + facetOverlay->offset);
          u_char u = facetOverlay->u;
          u_char v = facetOverlay->v;
          u_short clut = pmx->clut;
          u_short tpage = pmx->tpage;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
          {
            u_char u0 = *(u_char *)(facet + 6) + u;
            u_char u1 = *(u_char *)(facet + 8) + u;
            u_char u2 = *(u_char *)(facet + 10) + u;
            *(u_char *)(prim + 3) = u0;
            *(u_char *)(prim + 5) = u1;
            *(u_char *)(prim + 7) = u2;
          }
          {
            u_char v0 = *(u_char *)(facet + 7) + v;
            u_char v1 = *(u_char *)(facet + 9) + v;
            u_char v2 = *(u_char *)(facet + 11) + v;
            *(u_char *)((int)prim + 0xd) = v0;
            *(u_char *)((int)prim + 0x15) = v1;
            *(u_char *)((int)prim + 0x1d) = v2;
          }
        }
      }
      else {
        DRAWC_OTLINK_FT3(sd, prim);
        {
          long xy0 = *(long *)&sd->dvx0;
          long xy1 = *(long *)&sd->dvx1;
          long xy2 = *(long *)&sd->dvx2;
          prim[2] = xy0;
          prim[4] = xy1;
          prim[6] = xy2;
        }
        {
          u_long color = sd->color;
          u_char code = 0x24;
          if ((facet_flag & 1) != 0) {
            code = 0x26;
          }
          prim[1] = color;
          *(u_char *)((int)prim + 7) = code;
        }
        {
          Draw_tPixMap *pmx = sd->pmxStart + *(u_char *)(facet + 2);
          u_short clut = pmx->clut;
          u_short tpage = pmx->tpage;
          u_short uv0;
          u_short uv1;
          u_short uv2;
          *(u_short *)((int)prim + 0xe) = clut;
          *(u_short *)((int)prim + 0x16) = tpage;
          uv0 = *(u_short *)(facet + 6);
          uv1 = *(u_short *)(facet + 8);
          uv2 = *(u_short *)(facet + 10);
          *(u_short *)(prim + 3) = uv0;
          *(u_short *)(prim + 5) = uv1;
          *(u_short *)(prim + 7) = uv2;
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
     Every Ghidra iVarN/uVarN/puVarN/psVarN temp is purged (~40 of them); the
     ONE un-named pointer kept is the loop-1 tV byte cursor, which the oracle
     also carries as an anonymous giv ($a2, addiu 215 / stride 8).
     Retail reuses the DYING $s2 (the `t` param) for the DrawC_gOverlay base,
     which is why the frame is 48 with only 7 saved regs. */
  int i;
  COORD16 *Nvertice;

  Nvertice = obj->Nvertex;
  if ((envmap & 1U) != 0) {
    COORD16 *vt;
    char *tVc;   /* anonymous giv in retail too: &sd->tV[n].v, stride 8 */

gte_SetRotMatrix(&DrawC_gMatA);
gte_SetTransMatrix(&DrawC_gMatA);
    i = (u_int)obj->numVertex;   /* SYM: ONE fn-scope `i` (t8) counts ALL 3 loops */
    vt = Nvertice;
    tVc = &sd->tV[0].v;
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
        tVc[-1] = (char)u;
        *tVc = (char)v;
        tVc = tVc + 8;
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
    Draw_CarVertex *tV;

    tV = sd->tV;
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
        (tV->vt).x = t1;
        (tV->vt).y = t2;
        (tV->vt).z = t3;
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
    u_int facetFlag;   /* SYM $t3 = flag & 0xfff (the MASKED value), not the raw field */
    u_short rawFlag;
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
    id1 = id1 + (int)sd;
    id2 = id2 * 8;
    id2 = id2 + (int)sd;
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
    rawFlag = facet->flag;         /* the flag lhu fills the tex lbu's load-delay slot */
    overlayFlag = (int)((u_int)(u_short)DrawC_gOverlay[facet->textureIndex] << 0x10) >> 0x10;
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
        char u;
        u_char v;
        u_char u0, v0;   /* ONE reused pair (retail's $t4/$t5): the v-load fills
                          * the u-load's delay slot; a single temp costs a nop
                          * per vertex, six per-vertex temps recolour the fn */

        u = (sd->ePmx0).u0;
        v = (sd->ePmx0).v0;
        u = u + '@';   /* +0x40 AFTER both base lbu's (oracle order) */
        u0 = *(u_char *)(id0 + 0xD6);
        v0 = *(u_char *)(id0 + 0xD7);
        prim->u0 = u0 + u;
        prim->v0 = v0 + v;
        u0 = *(u_char *)(id1 + 0xD6);
        v0 = *(u_char *)(id1 + 0xD7);
        prim->u1 = u0 + u;
        prim->v1 = v0 + v;
        u0 = *(u_char *)(id2 + 0xD6);
        v0 = *(u_char *)(id2 + 0xD7);
        prim->u2 = u0 + u;
        prim->v2 = v0 + v;
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
  int iVar6;
  int uVar8;

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
    u_int overlayFlag;
    u_long *copyLastPrim;
    {
        {
        {
          i = i - 1;
          if (i == -1) {
            return;
          }
          facet = obj->facet + i;
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
          real_type = ((u_int)type) & 0xffbf;
          id0 = facet->vertexId0;
          id1 = facet->vertexId1;
          id2 = facet->vertexId2;
gte_SetRotMatrix(((char *)sd + 0x14));
gte_SetTransMatrix(((char *)sd + 0x14));
          {
            COORD16 *z; short t1,t2,t3;
            z = vertice + id0;
            t1 = z->x;
            t2 = z->y;
            t3 = z->z;
            (sd->vt0).x = t1;
            (sd->vt0).y = t2;
            (sd->vt0).z = t3;
          }
          {
            COORD16 *z; short t1,t2,t3;
            z = vertice + id1;
            t1 = z->x;
            t2 = z->y;
            t3 = z->z;
            (sd->vt1).x = t1;
            (sd->vt1).y = t2;
            (sd->vt1).z = t3;
          }
          {
            COORD16 *z; short t1,t2,t3;
            z = vertice + id2;
            t1 = z->x;
            t2 = z->y;
            t3 = z->z;
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
        iVar6 = sd->otz + sd->sub_otz;
        sd->otz = iVar6;
        if (iVar6 < 0) continue;
        if (sd->sub_otSize < iVar6) continue;
        }
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
         slot (retail leaves the nop and keeps sll-before-lh) -- a sched1 tie. */
      {
        u_int ov = (u_int)(u_short)DrawC_gOverlay[index];
        ov = ov << 0x10;
        if (facet->flag < 0) {
          overlayFlag = (int)ov >> 0x18;
        }
        else {
          overlayFlag = (int)ov >> 0x10 & 0xff;
        }
      }
      if (((((u_int)type) & 0x40) != 0) && ((overlayFlag & 0x40) == 0)) {
        u_int ov = (u_int)(u_short)DrawC_gOverlay[0x18];
        ov = ov << 0x10;
        if (facet->flag < 0) {
          overlayFlag = (int)ov >> 0x18;
        }
        else {
          overlayFlag = (int)ov >> 0x10 & 0xff;
        }
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
  int iVar1;
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
    iVar1 = (sd->otz >> 1) + 0x28;
    sd->otz = iVar1;
    if ((-1 < iVar1) && (iVar1 <= Draw_gViewOtSize + -3)) {
      u_long *ot;
      {
      u_long lc;      /* MATCH: the colour word needs its OWN temp -- reusing l1 for it
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
      u_long *otp = ot + sd->otz;
      *(u_long *)prim = *(u_long *)prim & 0xff000000 | *otp & 0xffffff;
      *otp = *otp & 0xff000000 | (u_long)prim & 0xffffff;
      }
      lc = sd->color;
      *(u_char *)((char *)prim + 3) = 9;
      *(u_long *)&prim->r0 = lc;
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
  u_int mlo;      /* 0x00FFFFFF addr mask (oracle: $a1) */
  u_int mhi;      /* 0xFF000000 len mask  (oracle: $a2) */
  POLY_FT4 * prim;
  u_long * ot;
  u_short uv2;
  u_short uv3;
  u_short uVar1;
  u_short uVar2;
  u_short uVar3;
  u_short clut;
  u_short tpage;
  int iVar4;
  u_int uVar5;
  u_short uv1;
  u_short uv0;
  u_long *puVar6;
  u_int *puVar7;

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
      iVar4 = (sd->otz >> 3) + 0x28;
      sd->otz = iVar4;
      if (iVar4 < 0) {
        return;
      }
      if (Draw_gViewOtSize + -3 < iVar4) {
        return;
      }
    }
    if ((((-1 < *(short *)(((int)vt0) + 4)) || (-1 < vt1->z)) || (-1 < vt2->z)) || (-1 < vt3->z)) {
      mlo = 0xffffff;                          /* masks FIRST (oracle: a1/a2 hoisted before the loads,
                                                * first lui even sits in the z-chain delay slot) */
      mhi = 0xff000000;
      prim = (POLY_FT4 *)(sd->head).cprim.PrimPtr;
      puVar6 = (sd->head).cprim.LastPrim;
      (sd->head).cprim.PrimPtr = (char *)prim + 0x28;
      /* volatile: the oracle reloads sd->otz fresh here (stored just above) */
      puVar7 = (u_int *)(puVar6 + *(int volatile *)&sd->otz);
      *(u_int *)prim = *(u_int *)prim & mhi | *puVar7 & mlo;
      *puVar7 = *puVar7 & mhi | (u_int)prim & mlo;
      uVar5 = sd->color;
      *(u_char *)((int)prim + 3) = 9;
      ((u_int *)prim)[1] = uVar5;
      *(u_char *)((int)prim + 7) = 0x2e;
      uVar1 = pmx->tpage;
      *(u_short *)((int)prim + 0xe) = pmx->clut;
      *(u_short *)((int)prim + 0x16) = uVar1;
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
  u_char *u2;
  COORD16 *vt2;
  Draw_tPixMap *shadowPmx;

  shadowPmx = gShadowPixmap0;
  if (R3DCar_InMenu != 0) {
    shadowPmx = gMenuPixmap[1];
  }
  ChangeTPage(&shadowPmx->tpage,2);
gte_SetRotMatrix(&DrawC_gScreenMat);
gte_SetTransMatrix(&DrawC_gScreenMat);
  vt2 = &sd->vt8;
  u2 = &sd->offsetU2;
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
  DrawC_DivideShadowPrim(&sd->vt0,&sd->vt4,vt2,&sd->vt7,(u_short *)&sd->u0,(u_short *)&sd->u4,(u_short *)u2,
             (u_short *)&sd->offsetU1,shadowPmx,sd);
  DrawC_DivideShadowPrim(&sd->vt4,&sd->vt1,&sd->vt5,vt2,(u_short *)&sd->u4,(u_short *)&sd->u1,(u_short *)&sd->u5,
             (u_short *)u2,shadowPmx,sd);
  DrawC_DivideShadowPrim(&sd->vt7,vt2,&sd->vt6,&sd->vt3,(u_short *)&sd->offsetU1,(u_short *)u2,
             (u_short *)&sd->offsetU0,(u_short *)&sd->u3,shadowPmx,sd);
  DrawC_DivideShadowPrim(&sd->vt8,&sd->vt5,&sd->vt2,&sd->vt6,(u_short *)u2,(u_short *)&sd->u5,(u_short *)&sd->u2,
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
    DR_MODE *pDVar7;
    u_long *ot;
    pDVar7 = (DR_MODE *)(sd->head).cprim.PrimPtr;
    ot = (sd->head).cprim.LastPrim;
    sd->otz = 0;
    (sd->head).cprim.PrimPtr = (char *)(pDVar7 + 1);
    {
      u_int *puVar8 = (u_int *)(ot + sd->otz);
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
          u_int color = sd->color;
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
    i = gettick();
    j = i / 256;
    hilight[0] = (i - (j << 8)) >> 3;
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
       do-while (no SR either). */
    {
    signed char *hs = &hilight_state[0x1f];
    i = 0x1f;
    do {
      *hs = -1;
      i = i + -1;
      hs = hs + -1;
    } while (-1 < i);
    }
    /* MATCH (w40-a3): INDEX form, not walking pointers -- retail's
       `addu $a1,$a2,$zero` / `addu $a0,$t1,$zero` pair right after the three
       `addiu spN` base materializations is loop.c strength-reduction seeding the
       givs FROM the array bases, which only happens if the source indexes
       hilight[j] / hilight_direction[j] (the SYM names only i and j). */
    j = 0;
    do {
      i = 0;
      do {
        if ((signed char)hilight_state[hilight[j] + i * hilight_direction[j] & 0x1f] < i) {
          hilight_state[hilight[j] + i * hilight_direction[j] & 0x1f] = (char)i;
        }
        i = i + 1;
      } while (i < 5);
      j = j + 1;
    } while (j < 2);
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
      if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) {
        return;
      }
      {
        short t1 = Fe3D_lightsVertex[index * 2].x;
        short t2 = Fe3D_lightsVertex[index * 2].y;
        short t3 = Fe3D_lightsVertex[index * 2].z;
        (sd->vt0).x = t1;
        (sd->vt0).y = t2;
        (sd->vt0).z = t3;
      }
      {
        COORD16 *z = Fe3D_lightsVertex + iPlus;
        short t1 = z->x;
        short t2 = z->y;
        short t3 = z->z;
        (sd->vt1).x = t1;
        (sd->vt1).y = t2;
        (sd->vt1).z = t3;
      }
      {
        short t2 = Fe3D_lightsVertex[index * 2 + 1].y;
        short t3 = Fe3D_lightsVertex[index * 2 + 1].z;
        short t1 = Fe3D_lightsVertex[index * 2 + 1].x;
        (sd->vt2).x = t1;
        (sd->vt2).y = t2;
        (sd->vt2).z = t3;
      }
      {
        COORD16 *z = &Fe3D_lightsVertex[iPlus + 1];
        short t1 = z->x;
        short t2 = z->y;
        short t3 = z->z;
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

/* end of draww.cpp */

/* owning-TU def (extern-declared, never defined; link-harness) */
char SP[64];  /* FIXME size approx */
