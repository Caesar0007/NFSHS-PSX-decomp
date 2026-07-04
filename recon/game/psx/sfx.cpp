/* game/psx/sfx.cpp -- RECONSTRUCTED (NFS4 PSX "souffle" smoke/dust/spark FX renderer; C++ TU)
 *   7 fns: Sfx_Transform (GTE world->cam), Sfx_BuildSmokeFacet/ThickenXZ/BuildFastDisolveFacet
 *   (billboard/ribbon facet builders), Sfx_AdditivePrim (GTE additive POLY_FT4 emit),
 *   Sfx_BuildSouffleFacet (per-type render dispatch), Sfx_Add (per-type init).
 */
#include "../../nfs4_types.h"
#include "sfx_externs.h"


/* ---- Sfx_Transform__FP8coorddefP7SVECTORT0  [SFX.CPP:40-75] SLD-VERIFIED ---- */
void Sfx_Transform(coorddef *worldpt,SVECTOR *campt,coorddef *t)

{
  SVECTOR pt;
  VECTOR campt32;
  MATRIX ident;

  TrsProj_SetPsxMatrix(&gWorldMat,(coorddef *)0x0);
  pt.vx = (short)((worldpt->x - t->x) >> 10);
  pt.vy = (short)((worldpt->y - t->y) >> 10);
  pt.vz = (short)((worldpt->z - t->z) >> 10);
  gte_ldv0(&pt);
  gte_mvmva(1,0,0,0,0);
  gte_stlvnl(&campt32);
  campt->vx = (short)campt32.vx;
  campt->vy = (short)campt32.vy;
  campt->vz = (short)campt32.vz;
  ident.m[0][0] = 0x1000; ident.m[1][1] = 0x1000; ident.m[2][2] = 0x1000;
  ident.m[1][0] = 0; ident.m[2][0] = 0;
  ident.m[0][1] = 0; ident.m[2][1] = 0;
  ident.m[0][2] = 0; ident.m[1][2] = 0;
  ident.t[0] = 0; ident.t[1] = 0; ident.t[2] = 0;
  gte_SetRotMatrix(&ident);
  gte_SetTransMatrix(&ident);
  return;
}

/* ---- Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap  [SFX.CPP:106-114] SLD-VERIFIED ---- */
/* NEAR-MISS 3 diffs (114/115): oracle has `nop; lui v1,%hi(gSMokePixmap)` (nop in bnez delay
 * slot, lui after). Ours hoists lui v1 into the delay slot instead. Instruction scheduling
 * floor (bnez delay slot filled differently by gcc-2.8.0 -O2). ACCEPT. */
void Sfx_BuildSmokeFacet(Souffle_tISouffle *is,sfxsouffle *dSouffle,Draw_tPixMap *cpixmap)

{
  int radius;
  int cosa;
  int sina;
  int iclut;

  radius = (0x1f - (u_char)is->cycle) * 4 + 0x26;
  cosa = fixedmult(fastintcos(is->angle),radius);
  sina = fixedmult(fastintsin(is->angle),radius);
  dSouffle->v0.vx = is->trans.vx - (short)sina;
  dSouffle->v0.vy = is->trans.vy + (short)cosa;
  dSouffle->v0.vz = is->trans.vz;
  dSouffle->v1.vx = is->trans.vx + (short)cosa;
  dSouffle->v1.vy = is->trans.vy + (short)sina;
  dSouffle->v1.vz = is->trans.vz;
  dSouffle->v2.vx = is->trans.vx + (short)sina;
  dSouffle->v2.vy = is->trans.vy - (short)cosa;
  dSouffle->v2.vz = is->trans.vz;
  dSouffle->v3.vx = is->trans.vx - (short)cosa;
  dSouffle->v3.vy = is->trans.vy - (short)sina;
  dSouffle->v3.vz = is->trans.vz;
  iclut = (int)(0x1f - (u_char)is->cycle) >> 1;
  if (iclut >= 0x10) {
    iclut = 0xf;
  }
  dSouffle->pmx = *gSMokePixmap[is->rndpixmap];
  dSouffle->pmx.clut = cpixmap->clut + (short)iclut;
  return;
}

/* ---- Sfx_ThickenXZ__FP7SVECTORP8coorddefN21  [SFX.CPP:163-191] SLD-VERIFIED ---- */
void Sfx_ThickenXZ(SVECTOR *d,coorddef *pt1,coorddef *pt2,coorddef *cp)

{
  int angle;
  int pxp;
  int pzp;

  angle = intatan(pt2->x - pt1->x,pt2->z - pt1->z);
  pxp = fixedmult(0xe666,-fastintcos(angle)) >> 1;
  pzp = fixedmult(0xe666,fastintsin(angle)) >> 1;
  d[1].vx = (short)((pt1->x + pxp) - cp->x >> 10);
  d[1].vy = (short)(pt1->y - cp->y >> 10);
  d[1].vz = (short)((pt1->z + pzp) - cp->z >> 10);
  d[2].vx = (short)((pt1->x - pxp) - cp->x >> 10);
  d[2].vy = (short)(pt1->y - cp->y >> 10);
  d[2].vz = (short)((pt1->z - pzp) - cp->z >> 10);
  d->vx = (short)((pt2->x + pxp) - cp->x >> 10);
  d->vy = (short)(pt2->y - cp->y >> 10);
  d->vz = (short)((pt2->z + pzp) - cp->z >> 10);
  d[3].vx = (short)((pt2->x - pxp) - cp->x >> 10);
  d[3].vy = (short)(pt2->y - cp->y >> 10);
  d[3].vz = (short)((pt2->z - pzp) - cp->z >> 10);
  return;
}

/* ---- Sfx_BuildFastDisolveFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMapT2  [SFX.CPP:290-295] SLD-VERIFIED ---- */
void Sfx_BuildFastDisolveFacet(Souffle_tISouffle *is,sfxsouffle *dSouffle,Draw_tPixMap *t,Draw_tPixMap *c)

{
  int iclut;

  iclut = 8 - (u_char)is->cycle;
  if (iclut >= 0x10) {
    iclut = 0xf;
  }
  dSouffle->pmx = *t;
  dSouffle->pmx.clut = c->clut + (short)iclut;
  return;
}

/* ---- Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache  [SFX.CPP:306-363] SLD-VERIFIED ----
 * This TU's original obj (SFX.CPP) reaches Render_gPacketPtr/Render_gPalettePtr via their FIXED
 * scratchpad storage address (0x1F800004 / 0x1F800000) rather than the linked symbol -- oracle
 * shows literal `lui;lw 0x1F800004`/`0x1F800000` loads, not a %hi/%lo(Render_gPacketPtr) reloc.
 * Access via the centralized fixed-address lvalue macros Render_gPacketPtr/Render_gPalettePtr
 * (nfs4_types.h, sec.3.6b) -- same storage as render.cpp's owned global, byte-identical
 * semantics -- to reproduce that codegen.
 * NEAR-MISS 38 diffs (126/126 insns -- pure register-coloring, no structural/instruction-count
 * gap). SYM lists 4 REG-class ULONG temps `l0,l1,l2,l3` for this fn; tried naming the 4-word
 * pixmap-copy scratch as `l0..l3` per that SYM (with the final packet-tag mask reusing the same
 * `l0` slot once its earlier live range ends), but that REGRESSED the pixmap-copy block's
 * register pick (38->52 diffs) -- gcc-2.8.0 colors a single `u_long l0,l1,l2,l3;` declaration
 * differently from 4 independently-named scratch locals even though the VALUES are identical.
 * Kept the byte-match-proven names (v0f..v3f) for that block; the SYM's l0-3 naming is cosmetic
 * here, not load-bearing. Oracle allocates t0=&Render_gPacketPtr / a1=0xFFFFFF-mask /
 * a2=Render_gPalettePtr-value / a3=0xFF000000-mask for the final tag-store+increment block and
 * reloads Render_gPacketPtr's value fresh into $s0 right before reusing it (`lw s0,0(t0)`)
 * instead of trusting `prim`'s call-spanning copy; tried re-fetching into `prim`, a separate
 * `pkt`/`u_int*` local, an address-of-macro cast, and both OR-operand orderings -- all either
 * reproduce this exact 38-diff coloring or regress (extra instrs from a second independent
 * macro-deref CSE-blocked by pointer-type punning). ACCEPT as a gcc-2.8.0 pure-coloring floor
 * (matches §3.12 recognition: insn count exact, diffs are uniform register renames only). */
void Sfx_AdditivePrim(Draw_tPixMap *pmx,SVECTOR *pt,int mode,int offset,Sfx_tCache *sd)

{
  POLY_FT4 *prim;
  u_long l0;
  u_long v0f,v1f,v2f,v3f;
  u_short tpage;

  if (sd->head.cprim.PrimPtr < sd->head.cprim.MPrimPtr) {
    gte_ldv0(pt);
    gte_rtps();
    prim = (POLY_FT4 *)Render_gPacketPtr;
    gte_stsxy(&prim->x0);
    gte_ldv3(pt + 1,pt + 2,pt + 3);
    gte_rtpt();
    if ((mode & 2U) != 0) {
      *(int *)&prim->r0 = 0x2e5898b8;
    }
    else if (GameSetup_gData.Time == 0) {
      *(int *)&prim->r0 = 0x2e181818;
    }
    else {
      *(int *)&prim->r0 = 0x2e080808;
    }
    gte_stsxy3(&prim->x1,&prim->x3,&prim->x2);
    gte_avsz4();
    gte_stOTZ(&sd->otz);   /* oracle stores OTZ ($7) here, not SZ3 ($19) */
    sd->otz = (sd->otz >> 1) + offset;
    if ((-1 < sd->otz) && (sd->otz <= Draw_gViewOtSize + -3)) {
      *((char *)prim + 3) = 9;   /* OT tag length (9 words) -- NOT prim->code */
      v0f = *(u_int *)&pmx->u0;
      v1f = *(u_int *)&pmx->u1;
      v2f = *(u_int *)&pmx->u2;
      v3f = *(u_int *)&pmx->u3;
      *(u_int *)&prim->u0 = v0f;
      *(u_int *)&prim->u1 = v1f;
      *(u_int *)&prim->u2 = v2f;
      *(u_int *)&prim->u3 = v3f;
      tpage = pmx->tpage;
      if ((mode & 1U) != 0) {
        ChangeTPage(&tpage,2);
      }
      else {
        ChangeTPage(&tpage,1);
      }
      prim->tpage = tpage;
      prim->tag = prim->tag & 0xff000000 |
                  *(u_int *)(Render_gPalettePtr + sd->otz * 4) & 0xffffff;
      l0 = (u_int)Render_gPacketPtr & 0xffffff;
      Render_gPacketPtr = Render_gPacketPtr + 0x28;
      *(u_int *)(Render_gPalettePtr + sd->otz * 4) =
           *(u_int *)(Render_gPalettePtr + sd->otz * 4) & 0xff000000 | l0;
    }
  }
  return;
}

/* ---- Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle  [SFX.CPP:367-525] ----
 * HAND-WRITTEN ASSEMBLY (oracle .s line 4 tags this "Handwritten function"; 938 insns @0x800DD790,
 * 0xEA8 bytes). Confirmed NOT compiler output: the switch dispatch is a raw computed `jr` through
 * a hand-placed jump table `jtbl_8005699C` (14 entries, one per is->type case 1..14); several
 * cases share code via straight `j` jumps between non-adjacent blocks (not a shape any C
 * `switch`/`case`/`goto` emits); multiple case bodies keep DIFFERENT locals in the SAME physical
 * registers across non-overlapping live ranges (the per-case register reuse the task brief calls
 * out); two `swc2` stores are individually flagged "handwritten instruction" in the oracle. No C
 * source reconstruction reproduces this register-scoping byte-for-byte -- confirmed: a
 * semantically-faithful C rewrite (this file's prior body, kept below as the host fallback)
 * compiles clean but diffs ~1264 lines against the 938-insn oracle, and a sibling handwritten fn
 * in this same codebase (DrawC_ShadowPrim, drawc.cpp) still FAILs 103 diffs after a careful
 * C-reconstruction attempt. Transcribed VERBATIM as a file-scope __asm__ (byte-identical to the
 * original SFX.CPP's inline hand-asm for this function), including its own hand-placed jump
 * table `jtbl_8005699C` (materialized here in .rodata since it belongs exclusively to this
 * function -- confirmed by scanning every other oracle .s in the tree for this VA: zero other
 * references). A portable C++ fallback (the prior semantic reconstruction, functionally
 * equivalent, not expected to byte-match anything since it's compiler output standing in for
 * hand-asm on a platform that never runs it) keeps the x86 host build compiling. maspsx notes:
 * operands are DECIMAL (maspsx int()-parses displacements/immediates base-10) except the 2
 * large-constant materializations the oracle itself renders as a parenthesized shift/mask
 * expression (0x1F800004 shifted/masked for the lui/ori halves) -- kept verbatim, GAS evaluates
 * them natively; double `.set noreorder` (tab form turns maspsx is_reorder OFF, space form passes
 * through to gnu-as); `.set noat` for the manual $at at one materialization site. The `jal`
 * targets are this TU's other Sfx_* functions (already-correct mangled C++ names, resolved by the
 * linker like any other call) plus already-declared externs (ChangeTPage, Math_NormalizeVector,
 * TrsProj_SetPsxMatrix, fixedmult) and eaclib's intcos/intsin (distinct, lower-level routines from
 * this file's fastintcos/fastintsin -- verified present + extern "C" in
 * eaclib/psx/eacpsxz/sinfunc.cpp, so the raw jal intcos / jal intsin link correctly). */
#if defined(__mips__)
__asm__(
    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as (keeps as from reordering)   */
    "\t.globl Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle\n"
    "Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle:\n"
    "\taddiu	$sp,$sp,-224\n"
    "\tsw	$s0,200($sp)\n"
    "\taddu	$s0,$a0,$zero\n"
    "\tsw	$s2,208($sp)\n"
    "\taddu	$s2,$a1,$zero\n"
    "\tsw	$ra,216($sp)\n"
    "\tsw	$s3,212($sp)\n"
    "\tsw	$s1,204($sp)\n"
    "\tlbu	$v0,0($s2)\n"
    "\tnop\n"
    "\taddiu	$v1,$v0,-1\n"
    "\tsltiu	$v0,$v1,14\n"
    "\tbeqz	$v0,.L800DE61C\n"
    "\tlui	$s3,(0x1F800000 >> 16)\n"
    "\tlui	$v0,%hi(jtbl_8005699C)\n"
    "\taddiu	$v0,$v0,%lo(jtbl_8005699C)\n"
    "\tsll	$v1,$v1,2\n"
    "\taddu	$v1,$v1,$v0\n"
    "\tlw	$v0,0($v1)\n"
    "\tnop\n"
    "\tjr	$v0\n"
    "\tnop\n"
    ".L800DD7E8:\n"
    "\taddu	$a0,$s2,$zero\n"
    "\tlui	$a2,%hi(gSMokePalette)\n"
    "\tlw	$a2,%lo(gSMokePalette)($a2)\n"
    "\tjal	Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap\n"
    "\taddiu	$a1,$sp,24\n"
    "\tj	.L800DE114\n"
    "\taddiu	$a0,$sp,24\n"
    ".L800DD804:\n"
    "\taddu	$a0,$s2,$zero\n"
    "\tlui	$a2,%hi(gSMokePalette)\n"
    "\tlw	$a2,%lo(gSMokePalette)($a2)\n"
    "\tjal	Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap\n"
    "\taddiu	$a1,$sp,24\n"
    "\tlbu	$v0,3($s2)\n"
    "\tnop\n"
    "\tsltiu	$v0,$v0,18\n"
    "\tbeqz	$v0,.L800DD830\n"
    "\taddiu	$v0,$zero,1\n"
    "\tsb	$v0,0($s2)\n"
    ".L800DD830:\n"
    "\tsw	$s3,16($sp)\n"
    "\taddiu	$a0,$sp,24\n"
    "\taddiu	$a1,$sp,40\n"
    "\taddu	$a2,$zero,$zero\n"
    "\tjal	Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache\n"
    "\taddiu	$a3,$zero,15\n"
    "\tj	.L800DE61C\n"
    "\tnop\n"
    ".L800DD850:\n"
    "\taddu	$a0,$s2,$zero\n"
    "\tlui	$a2,%hi(gSMokePalette)\n"
    "\tlw	$a2,%lo(gSMokePalette)($a2)\n"
    "\tjal	Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap\n"
    "\taddiu	$a1,$sp,24\n"
    "\taddiu	$a0,$sp,24\n"
    "\taddiu	$a1,$sp,40\n"
    "\tj	.L800DE11C\n"
    "\taddiu	$a2,$zero,1\n"
    ".L800DD874:\n"
    "\tlw	$t2,24($s2)\n"
    "\tlw	$t3,28($s2)\n"
    "\tlw	$t4,32($s2)\n"
    "\tsw	$t2,72($sp)\n"
    "\tsw	$t3,76($sp)\n"
    "\tsw	$t4,80($sp)\n"
    "\tjal	Math_NormalizeVector__FP8coorddef\n"
    "\taddiu	$a0,$sp,72\n"
    "\taddiu	$a0,$sp,72\n"
    "\tlw	$v0,72($sp)\n"
    "\tlw	$v1,12($s2)\n"
    "\tsll	$v0,$v0,2\n"
    "\tsubu	$v1,$v1,$v0\n"
    "\tlw	$v0,76($sp)\n"
    "\taddiu	$a1,$sp,88\n"
    "\tsw	$v1,72($sp)\n"
    "\tlw	$v1,16($s2)\n"
    "\tsll	$v0,$v0,2\n"
    "\tsubu	$v1,$v1,$v0\n"
    "\tlw	$v0,80($sp)\n"
    "\taddiu	$a2,$s0,8\n"
    "\tsw	$v1,76($sp)\n"
    "\tlw	$v1,20($s2)\n"
    "\tsll	$v0,$v0,2\n"
    "\tsubu	$v1,$v1,$v0\n"
    "\tjal	Sfx_Transform__FP8coorddefP7SVECTORT0\n"
    "\tsw	$v1,80($sp)\n"
    "\tlh	$v0,92($sp)\n"
    "\tnop\n"
    "\tslti	$v0,$v0,64\n"
    "\tbeqz	$v0,.L800DD8FC\n"
    "\taddiu	$s0,$sp,24\n"
    "\tj	.L800DD9F8\n"
    "\taddiu	$v1,$zero,1\n"
    ".L800DD8FC:\n"
    "\tlh	$a0,88($sp)\n"
    "\tlh	$v1,48($s2)\n"
    "\tnop\n"
    "\tsubu	$v0,$a0,$v1\n"
    "\tblez	$v0,.L800DD924\n"
    "\tslti	$v0,$v0,32\n"
    "\tbeqz	$v0,.L800DD958\n"
    "\tnop\n"
    "\tj	.L800DD934\n"
    "\tnop\n"
    ".L800DD924:\n"
    "\tsubu	$v0,$v1,$a0\n"
    "\tslti	$v0,$v0,32\n"
    "\tbeqz	$v0,.L800DD958\n"
    "\tnop\n"
    ".L800DD934:\n"
    "\tlh	$v1,88($sp)\n"
    "\tlh	$v0,48($s2)\n"
    "\tnop\n"
    "\tslt	$v0,$v0,$v1\n"
    "\tlhu	$v1,48($s2)\n"
    "\tbnez	$v0,.L800DD954\n"
    "\taddiu	$v0,$v1,32\n"
    "\taddiu	$v0,$v1,-32\n"
    ".L800DD954:\n"
    "\tsh	$v0,88($sp)\n"
    ".L800DD958:\n"
    "\tlhu	$v0,48($s2)\n"
    "\tnop\n"
    "\tsh	$v0,16($s0)\n"
    "\tlhu	$v0,50($s2)\n"
    "\tnop\n"
    "\taddiu	$v0,$v0,32\n"
    "\tsh	$v0,18($s0)\n"
    "\tlhu	$v0,52($s2)\n"
    "\tnop\n"
    "\tsh	$v0,20($s0)\n"
    "\tlhu	$v0,48($s2)\n"
    "\tnop\n"
    "\tsh	$v0,40($s0)\n"
    "\tlhu	$v0,50($s2)\n"
    "\tnop\n"
    "\taddiu	$v0,$v0,-32\n"
    "\tsh	$v0,42($s0)\n"
    "\tlhu	$v0,52($s2)\n"
    "\tnop\n"
    "\tsh	$v0,44($s0)\n"
    "\tlhu	$v0,88($sp)\n"
    "\tnop\n"
    "\tsh	$v0,24($s0)\n"
    "\tlhu	$v0,90($sp)\n"
    "\tnop\n"
    "\taddiu	$v0,$v0,32\n"
    "\tsh	$v0,26($s0)\n"
    "\tlhu	$v0,92($sp)\n"
    "\tnop\n"
    "\tsh	$v0,28($s0)\n"
    "\tlhu	$v0,88($sp)\n"
    "\tnop\n"
    "\tsh	$v0,32($s0)\n"
    "\tlhu	$v0,90($sp)\n"
    "\tnop\n"
    "\taddiu	$v0,$v0,-32\n"
    "\tsh	$v0,34($s0)\n"
    "\tlhu	$v0,92($sp)\n"
    "\taddu	$v1,$zero,$zero\n"
    "\tsh	$v0,36($s0)\n"
    ".L800DD9F8:\n"
    "\tbnez	$v1,.L800DE61C\n"
    "\taddiu	$a0,$sp,24\n"
    "\taddiu	$a1,$sp,40\n"
    "\taddiu	$a2,$zero,2\n"
    "\tlui	$v1,%hi(gSparkHPixmap)\n"
    "\taddiu	$v1,$v1,%lo(gSparkHPixmap)\n"
    "\tlbu	$a3,3($s2)\n"
    "\taddiu	$v0,$zero,6\n"
    "\tsubu	$v0,$v0,$a3\n"
    "\tsllv	$v0,$v0,$a2\n"
    "\taddu	$v0,$v0,$v1\n"
    "\tlw	$v0,0($v0)\n"
    "\tnop\n"
    "\tlwl	$t2,3($v0)\n"
    "\tlwr	$t2,0($v0)\n"
    "\tlwl	$t3,7($v0)\n"
    "\tlwr	$t3,4($v0)\n"
    "\tlwl	$t4,11($v0)\n"
    "\tlwr	$t4,8($v0)\n"
    "\tlwl	$t5,15($v0)\n"
    "\tlwr	$t5,12($v0)\n"
    "\tswl	$t2,27($sp)\n"
    "\tswr	$t2,24($sp)\n"
    "\tswl	$t3,31($sp)\n"
    "\tswr	$t3,28($sp)\n"
    "\tswl	$t4,35($sp)\n"
    "\tswr	$t4,32($sp)\n"
    "\tswl	$t5,39($sp)\n"
    "\tswr	$t5,36($sp)\n"
    "\tj	.L800DE120\n"
    "\taddiu	$a3,$zero,40\n"
    ".L800DDA74:\n"
    "\tlui	$v0,(0x2E181010 >> 16)\n"
    "\tori	$v0,$v0,(0x2E181010 & 0xFFFF)\n"
    "\tsw	$v0,72($sp)\n"
    "\tlwl	$t2,75($sp)\n"
    "\tlwr	$t2,72($sp)\n"
    "\tnop\n"
    "\tswl	$t2,111($sp)\n"
    "\tswr	$t2,108($sp)\n"
    "\tlw	$t2,24($s2)\n"
    "\tlw	$t3,28($s2)\n"
    "\tlw	$t4,32($s2)\n"
    "\tsw	$t2,152($sp)\n"
    "\tsw	$t3,156($sp)\n"
    "\tsw	$t4,160($sp)\n"
    "\tjal	Math_NormalizeVector__FP8coorddef\n"
    "\taddiu	$a0,$sp,152\n"
    "\tlw	$t2,12($s2)\n"
    "\tlw	$t3,16($s2)\n"
    "\tlw	$t4,20($s2)\n"
    "\tsw	$t2,164($sp)\n"
    "\tsw	$t3,168($sp)\n"
    "\tsw	$t4,172($sp)\n"
    "\tlh	$v1,58($s2)\n"
    "\tlw	$v0,152($sp)\n"
    "\tnop\n"
    "\tmult	$v0,$v1\n"
    "\tmflo	$t6\n"
    "\tlw	$v0,156($sp)\n"
    "\tnop\n"
    "\tmult	$v0,$v1\n"
    "\taddiu	$s1,$sp,120\n"
    "\taddu	$a0,$s1,$zero\n"
    "\tmflo	$t1\n"
    "\tlw	$v0,160($sp)\n"
    "\taddiu	$a1,$sp,152\n"
    "\tmult	$v0,$v1\n"
    "\taddiu	$a2,$sp,164\n"
    "\taddiu	$a3,$s0,8\n"
    "\tlw	$v0,164($sp)\n"
    "\tsra	$v1,$t6,4\n"
    "\tsubu	$v0,$v0,$v1\n"
    "\tsw	$v0,152($sp)\n"
    "\tlw	$v0,168($sp)\n"
    "\tsra	$v1,$t1,4\n"
    "\tsubu	$v0,$v0,$v1\n"
    "\tsw	$v0,156($sp)\n"
    "\tlw	$v0,172($sp)\n"
    "\tmflo	$t0\n"
    "\tsra	$v1,$t0,4\n"
    "\tsubu	$v0,$v0,$v1\n"
    "\tjal	Sfx_ThickenXZ__FP7SVECTORP8coorddefN21\n"
    "\tsw	$v0,160($sp)\n"
    "\tlui	$a0,%hi(gWorldMat)\n"
    "\taddiu	$a0,$a0,%lo(gWorldMat)\n"
    "\tjal	TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef\n"
    "\taddu	$a1,$zero,$zero\n"
    "\tlw	$v0,4($s3)\n"
    "\tlw	$v1,8($s3)\n"
    "\tnop\n"
    "\tsltu	$v0,$v0,$v1\n"
    "\tbeqz	$v0,.L800DE61C\n"
    "\taddiu	$v0,$sp,128\n"
    "\tlwc2	$0,0($v0)\n"
    "\tlwc2	$1,4($v0)\n"
    "\tnop\n"
    "\tnop\n"
    "\t.word 0x4A180001\n"   /* rtps */
    "\taddiu	$v0,$sp,176\n"
    "\tlui	$s0,(0x1F800004 >> 16)\n"
    "\tlw	$s0,4($s0)\n"
    "\tswc2	$25,0($v0)\n"
    "\tswc2	$26,4($v0)\n"   /* handwritten instruction */
    "\tswc2	$27,8($v0)\n"   /* handwritten instruction */
    "\tlw	$v0,184($sp)\n"
    "\tnop\n"
    "\tslti	$v0,$v0,32\n"
    "\tbnez	$v0,.L800DE61C\n"
    "\taddiu	$v0,$s0,16\n"
    "\tswc2	$14,0($v0)\n"
    "\taddiu	$v1,$sp,136\n"
    "\taddiu	$v0,$sp,144\n"
    "\tlwc2	$0,0($s1)\n"
    "\tlwc2	$1,4($s1)\n"
    "\tlwc2	$2,0($v1)\n"
    "\tlwc2	$3,4($v1)\n"
    "\tlwc2	$4,0($v0)\n"
    "\tlwc2	$5,4($v0)\n"
    "\tnop\n"
    "\tnop\n"
    "\t.word 0x4A280030\n"   /* rtpt */
    "\taddiu	$a0,$s0,8\n"
    "\tlw	$v0,108($sp)\n"
    "\taddiu	$v1,$s0,32\n"
    "\tsw	$v0,4($s0)\n"
    "\taddiu	$v0,$s0,24\n"
    "\tswc2	$12,0($a0)\n"
    "\tswc2	$13,0($v1)\n"
    "\tswc2	$14,0($v0)\n"
    "\tnop\n"
    "\tnop\n"
    "\t.word 0x4B68002E\n"   /* avsz4 */
    "\taddiu	$v0,$s3,20\n"
    "\tswc2	$7,0($v0)\n"
    "\tlw	$v0,20($s3)\n"
    "\tnop\n"
    "\tsra	$v0,$v0,1\n"
    "\taddiu	$v1,$v0,50\n"
    "\tbltz	$v1,.L800DE61C\n"
    "\tsw	$v1,20($s3)\n"
    "\tlui	$v0,%hi(Draw_gViewOtSize)\n"
    "\tlw	$v0,%lo(Draw_gViewOtSize)($v0)\n"
    "\tnop\n"
    "\taddiu	$v0,$v0,-3\n"
    "\tslt	$v0,$v0,$v1\n"
    "\tbnez	$v0,.L800DE61C\n"
    "\taddiu	$v0,$zero,9\n"
    "\tlui	$v1,%hi(gSparkHPixmap)\n"
    "\taddiu	$v1,$v1,%lo(gSparkHPixmap)\n"
    "\tsb	$v0,3($s0)\n"
    "\tlbu	$a0,3($s2)\n"
    "\taddiu	$v0,$zero,6\n"
    "\tsubu	$v0,$v0,$a0\n"
    "\tsll	$v0,$v0,2\n"
    "\taddu	$v0,$v0,$v1\n"
    "\tlw	$v0,0($v0)\n"
    "\tnop\n"
    "\tlw	$v1,0($v0)\n"
    "\tlw	$a1,4($v0)\n"
    "\tlw	$a2,8($v0)\n"
    "\tlw	$a3,12($v0)\n"
    "\taddiu	$a0,$sp,192\n"
    "\tsw	$v1,12($s0)\n"
    "\tsw	$a1,20($s0)\n"
    "\tsw	$a2,28($s0)\n"
    "\tsw	$a3,36($s0)\n"
    "\tlhu	$v0,6($v0)\n"
    "\taddiu	$a1,$zero,1\n"
    "\tjal	ChangeTPage__FPUsi\n"
    "\tsh	$v0,192($sp)\n"
    "\tlui	$a1,(0xFFFFFF >> 16)\n"
    "\tori	$a1,$a1,(0xFFFFFF & 0xFFFF)\n"
    "\tlhu	$v0,192($sp)\n"
    "\tlui	$a2,(0x1F800000 >> 16)\n"
    "\tlw	$a2,0($a2)\n"
    "\tlui	$a3,(0xFF000000 >> 16)\n"
    "\tsh	$v0,22($s0)\n"
    "\tlw	$v0,20($s3)\n"
    "\tlui	$s0,(0x1F800004 >> 16)\n"
    "\tlw	$s0,4($s0)\n"
    "\tsll	$v0,$v0,2\n"
    "\taddu	$v0,$v0,$a2\n"
    "\tlw	$v1,0($s0)\n"
    "\tlw	$v0,0($v0)\n"
    "\tand	$v1,$v1,$a3\n"
    "\tand	$v0,$v0,$a1\n"
    "\tor	$v1,$v1,$v0\n"
    "\tsw	$v1,0($s0)\n"
    "\tlw	$a0,20($s3)\n"
    "\taddiu	$v1,$s0,40\n"
    "\tsll	$a0,$a0,2\n"
    "\taddu	$a0,$a0,$a2\n"
    "\tlw	$v0,0($a0)\n"
    "\tlui	$at,(0x1F800004 >> 16)\n"
    "\tsw	$v1,4($at)\n"
    "\tj	.L800DE610\n"
    "\tand	$a1,$s0,$a1\n"
    ".L800DDD0C:\n"
    "\taddiu	$s0,$zero,136\n"
    "\tlbu	$v0,3($s2)\n"
    "\tlw	$a0,8($s2)\n"
    "\tjal	intcos\n"
    "\tsubu	$s0,$s0,$v0\n"
    "\taddu	$a0,$v0,$zero\n"
    "\tjal	fixedmult\n"
    "\taddu	$a1,$s0,$zero\n"
    "\tlw	$a0,8($s2)\n"
    "\tjal	intsin\n"
    "\taddu	$s1,$v0,$zero\n"
    "\taddu	$a0,$v0,$zero\n"
    "\tjal	fixedmult\n"
    "\taddu	$a1,$s0,$zero\n"
    "\tlhu	$v1,48($s2)\n"
    "\taddiu	$s0,$sp,24\n"
    "\tsubu	$v1,$v1,$v0\n"
    "\tsh	$v1,16($s0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$s1\n"
    "\tsh	$v1,18($s0)\n"
    "\tlhu	$v1,52($s2)\n"
    "\tnop\n"
    "\tsh	$v1,20($s0)\n"
    "\tlhu	$v1,48($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$s1\n"
    "\tsh	$v1,24($s0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$v0\n"
    "\tsh	$v1,26($s0)\n"
    "\tlhu	$v1,52($s2)\n"
    "\tnop\n"
    "\tsh	$v1,28($s0)\n"
    "\tlhu	$v1,48($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$v0\n"
    "\tsh	$v1,32($s0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tnop\n"
    "\tsubu	$v1,$v1,$s1\n"
    "\tsh	$v1,34($s0)\n"
    "\tlhu	$v1,52($s2)\n"
    "\tnop\n"
    "\tsh	$v1,36($s0)\n"
    "\tlhu	$v1,48($s2)\n"
    "\tnop\n"
    "\tsubu	$v1,$v1,$s1\n"
    "\tsh	$v1,40($s0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tlui	$a3,%hi(gDirtPalette)\n"
    "\tlw	$a3,%lo(gDirtPalette)($a3)\n"
    "\tj	.L800DE0E0\n"
    "\tsubu	$v1,$v1,$v0\n"
    ".L800DDDEC:\n"
    "\taddiu	$s0,$zero,8\n"
    "\tlbu	$v0,3($s2)\n"
    "\tlw	$a0,8($s2)\n"
    "\tsubu	$s0,$s0,$v0\n"
    "\tsll	$s0,$s0,2\n"
    "\tjal	intcos\n"
    "\taddiu	$s0,$s0,25\n"
    "\taddu	$a0,$v0,$zero\n"
    "\tjal	fixedmult\n"
    "\taddu	$a1,$s0,$zero\n"
    "\tlw	$a0,8($s2)\n"
    "\tjal	intsin\n"
    "\taddu	$s1,$v0,$zero\n"
    "\taddu	$a0,$v0,$zero\n"
    "\tjal	fixedmult\n"
    "\taddu	$a1,$s0,$zero\n"
    "\tlhu	$v1,48($s2)\n"
    "\taddiu	$s0,$sp,24\n"
    "\tsubu	$v1,$v1,$v0\n"
    "\tsh	$v1,16($s0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$s1\n"
    "\tsh	$v1,18($s0)\n"
    "\tlhu	$v1,52($s2)\n"
    "\tnop\n"
    "\tsh	$v1,20($s0)\n"
    "\tlhu	$v1,48($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$s1\n"
    "\tsh	$v1,24($s0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$v0\n"
    "\tsh	$v1,26($s0)\n"
    "\tlhu	$v1,52($s2)\n"
    "\tnop\n"
    "\tsh	$v1,28($s0)\n"
    "\tlhu	$v1,48($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$v0\n"
    "\tsh	$v1,32($s0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tnop\n"
    "\tsubu	$v1,$v1,$s1\n"
    "\tsh	$v1,34($s0)\n"
    "\tlhu	$v1,52($s2)\n"
    "\tnop\n"
    "\tsh	$v1,36($s0)\n"
    "\tlhu	$v1,48($s2)\n"
    "\tnop\n"
    "\tsubu	$v1,$v1,$s1\n"
    "\tsh	$v1,40($s0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tlui	$a3,%hi(gGrassPalette)\n"
    "\tlw	$a3,%lo(gGrassPalette)($a3)\n"
    "\tsubu	$v1,$v1,$v0\n"
    "\tsh	$v1,42($s0)\n"
    "\tlhu	$v0,52($s2)\n"
    "\taddu	$a0,$s2,$zero\n"
    "\tsh	$v0,44($s0)\n"
    "\tlw	$v0,56($a0)\n"
    "\tlui	$v1,%hi(gGravelPixmap)\n"
    "\taddiu	$v1,$v1,%lo(gGravelPixmap)\n"
    "\tj	.L800DE100\n"
    "\tsll	$v0,$v0,2\n"
    ".L800DDEF4:\n"
    "\taddiu	$s0,$zero,8\n"
    "\tlbu	$v0,3($s2)\n"
    "\tlw	$a0,8($s2)\n"
    "\tsubu	$s0,$s0,$v0\n"
    "\tsll	$s0,$s0,2\n"
    "\tjal	intcos\n"
    "\taddiu	$s0,$s0,25\n"
    "\taddu	$a0,$v0,$zero\n"
    "\tjal	fixedmult\n"
    "\taddu	$a1,$s0,$zero\n"
    "\tlw	$a0,8($s2)\n"
    "\tjal	intsin\n"
    "\taddu	$s1,$v0,$zero\n"
    "\taddu	$a0,$v0,$zero\n"
    "\tjal	fixedmult\n"
    "\taddu	$a1,$s0,$zero\n"
    "\tlhu	$v1,48($s2)\n"
    "\taddiu	$s0,$sp,24\n"
    "\tsubu	$v1,$v1,$v0\n"
    "\tsh	$v1,16($s0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$s1\n"
    "\tsh	$v1,18($s0)\n"
    "\tlhu	$v1,52($s2)\n"
    "\tnop\n"
    "\tsh	$v1,20($s0)\n"
    "\tlhu	$v1,48($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$s1\n"
    "\tsh	$v1,24($s0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$v0\n"
    "\tsh	$v1,26($s0)\n"
    "\tlhu	$v1,52($s2)\n"
    "\tnop\n"
    "\tsh	$v1,28($s0)\n"
    "\tlhu	$v1,48($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$v0\n"
    "\tsh	$v1,32($s0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tnop\n"
    "\tsubu	$v1,$v1,$s1\n"
    "\tsh	$v1,34($s0)\n"
    "\tlhu	$v1,52($s2)\n"
    "\tnop\n"
    "\tsh	$v1,36($s0)\n"
    "\tlhu	$v1,48($s2)\n"
    "\tnop\n"
    "\tsubu	$v1,$v1,$s1\n"
    "\tsh	$v1,40($s0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tlui	$a3,%hi(gSnowPalette)\n"
    "\tlw	$a3,%lo(gSnowPalette)($a3)\n"
    "\tsubu	$v1,$v1,$v0\n"
    "\tsh	$v1,42($s0)\n"
    "\tlhu	$v0,52($s2)\n"
    "\taddu	$a0,$s2,$zero\n"
    "\tsh	$v0,44($s0)\n"
    "\tlw	$v0,56($a0)\n"
    "\tlui	$v1,%hi(gGravelPixmap)\n"
    "\taddiu	$v1,$v1,%lo(gGravelPixmap)\n"
    "\tj	.L800DE100\n"
    "\tsll	$v0,$v0,2\n"
    ".L800DDFFC:\n"
    "\taddiu	$s0,$zero,8\n"
    "\tlbu	$v0,3($s2)\n"
    "\tlw	$a0,8($s2)\n"
    "\tsubu	$s0,$s0,$v0\n"
    "\tsll	$s0,$s0,2\n"
    "\tjal	intcos\n"
    "\taddiu	$s0,$s0,12\n"
    "\taddu	$a0,$v0,$zero\n"
    "\tjal	fixedmult\n"
    "\taddu	$a1,$s0,$zero\n"
    "\tlw	$a0,8($s2)\n"
    "\tjal	intsin\n"
    "\taddu	$s1,$v0,$zero\n"
    "\taddu	$a0,$v0,$zero\n"
    "\tjal	fixedmult\n"
    "\taddu	$a1,$s0,$zero\n"
    "\tlhu	$v1,48($s2)\n"
    "\taddiu	$s0,$sp,24\n"
    "\tsubu	$v1,$v1,$v0\n"
    "\tsh	$v1,16($s0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$s1\n"
    "\tsh	$v1,18($s0)\n"
    "\tlhu	$v1,52($s2)\n"
    "\tnop\n"
    "\tsh	$v1,20($s0)\n"
    "\tlhu	$v1,48($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$s1\n"
    "\tsh	$v1,24($s0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$v0\n"
    "\tsh	$v1,26($s0)\n"
    "\tlhu	$v1,52($s2)\n"
    "\tnop\n"
    "\tsh	$v1,28($s0)\n"
    "\tlhu	$v1,48($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$v0\n"
    "\tsh	$v1,32($s0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tnop\n"
    "\tsubu	$v1,$v1,$s1\n"
    "\tsh	$v1,34($s0)\n"
    "\tlhu	$v1,52($s2)\n"
    "\tnop\n"
    "\tsh	$v1,36($s0)\n"
    "\tlhu	$v1,48($s2)\n"
    "\tnop\n"
    "\tsubu	$v1,$v1,$s1\n"
    "\tsh	$v1,40($s0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tlui	$a3,%hi(gSnowPalette)\n"
    "\tlw	$a3,%lo(gSnowPalette)($a3)\n"
    "\tsubu	$v1,$v1,$v0\n"
    ".L800DE0E0:\n"
    "\tsh	$v1,42($s0)\n"
    "\tlhu	$v0,52($s2)\n"
    "\taddu	$a0,$s2,$zero\n"
    "\tsh	$v0,44($s0)\n"
    "\tlw	$v0,56($a0)\n"
    "\tlui	$v1,%hi(gSMokePixmap)\n"
    "\taddiu	$v1,$v1,%lo(gSMokePixmap)\n"
    "\tsll	$v0,$v0,2\n"
    ".L800DE100:\n"
    "\taddu	$v0,$v0,$v1\n"
    "\tlw	$a2,0($v0)\n"
    "\tjal	Sfx_BuildFastDisolveFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMapT2\n"
    "\taddu	$a1,$s0,$zero\n"
    "\taddu	$a0,$s0,$zero\n"
    ".L800DE114:\n"
    "\taddiu	$a1,$sp,40\n"
    "\taddu	$a2,$zero,$zero\n"
    ".L800DE11C:\n"
    "\taddiu	$a3,$zero,15\n"
    ".L800DE120:\n"
    "\tjal	Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache\n"
    "\tsw	$s3,16($sp)\n"
    "\tj	.L800DE61C\n"
    "\tnop\n"
    ".L800DE130:\n"
    "\tlui	$v0,(0x2E301818 >> 16)\n"
    "\tori	$v0,$v0,(0x2E301818 & 0xFFFF)\n"
    "\tsw	$v0,80($sp)\n"
    "\tlwl	$t2,83($sp)\n"
    "\tlwr	$t2,80($sp)\n"
    "\tnop\n"
    "\tswl	$t2,103($sp)\n"
    "\tswr	$t2,100($sp)\n"
    "\tlw	$t2,24($s2)\n"
    "\tlw	$t3,28($s2)\n"
    "\tlw	$t4,32($s2)\n"
    "\tsw	$t2,144($sp)\n"
    "\tsw	$t3,148($sp)\n"
    "\tsw	$t4,152($sp)\n"
    "\tjal	Math_NormalizeVector__FP8coorddef\n"
    "\taddiu	$a0,$sp,144\n"
    "\tlw	$t2,12($s2)\n"
    "\tlw	$t3,16($s2)\n"
    "\tlw	$t4,20($s2)\n"
    "\tsw	$t2,156($sp)\n"
    "\tsw	$t3,160($sp)\n"
    "\tsw	$t4,164($sp)\n"
    "\tlh	$v1,58($s2)\n"
    "\tlw	$v0,144($sp)\n"
    "\tnop\n"
    "\tmult	$v0,$v1\n"
    "\tmflo	$t6\n"
    "\tlw	$v0,148($sp)\n"
    "\tnop\n"
    "\tmult	$v0,$v1\n"
    "\taddiu	$s1,$sp,112\n"
    "\taddu	$a0,$s1,$zero\n"
    "\tmflo	$t1\n"
    "\tlw	$v0,152($sp)\n"
    "\taddiu	$a1,$sp,144\n"
    "\tmult	$v0,$v1\n"
    "\taddiu	$a2,$sp,156\n"
    "\taddiu	$a3,$s0,8\n"
    "\tlw	$v0,156($sp)\n"
    "\tsra	$v1,$t6,4\n"
    "\tsubu	$v0,$v0,$v1\n"
    "\tsw	$v0,144($sp)\n"
    "\tlw	$v0,160($sp)\n"
    "\tsra	$v1,$t1,4\n"
    "\tsubu	$v0,$v0,$v1\n"
    "\tsw	$v0,148($sp)\n"
    "\tlw	$v0,164($sp)\n"
    "\tmflo	$t0\n"
    "\tsra	$v1,$t0,4\n"
    "\tsubu	$v0,$v0,$v1\n"
    "\tjal	Sfx_ThickenXZ__FP7SVECTORP8coorddefN21\n"
    "\tsw	$v0,152($sp)\n"
    "\tlui	$a0,%hi(gWorldMat)\n"
    "\taddiu	$a0,$a0,%lo(gWorldMat)\n"
    "\tjal	TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef\n"
    "\taddu	$a1,$zero,$zero\n"
    "\tlw	$v0,4($s3)\n"
    "\tlw	$v1,8($s3)\n"
    "\tnop\n"
    "\tsltu	$v0,$v0,$v1\n"
    "\tbeqz	$v0,.L800DE61C\n"
    "\taddiu	$v0,$sp,120\n"
    "\tlwc2	$0,0($v0)\n"
    "\tlwc2	$1,4($v0)\n"
    "\tnop\n"
    "\tnop\n"
    "\t.word 0x4A180001\n"   /* rtps */
    "\taddiu	$v0,$sp,168\n"
    "\tlui	$s0,(0x1F800004 >> 16)\n"
    "\tlw	$s0,4($s0)\n"
    "\tswc2	$25,0($v0)\n"
    "\tswc2	$26,4($v0)\n"   /* handwritten instruction */
    "\tswc2	$27,8($v0)\n"   /* handwritten instruction */
    "\tlw	$v0,176($sp)\n"
    "\tnop\n"
    "\tslti	$v0,$v0,32\n"
    "\tbnez	$v0,.L800DE61C\n"
    "\taddiu	$v0,$s0,16\n"
    "\tswc2	$14,0($v0)\n"
    "\taddiu	$v1,$sp,128\n"
    "\taddiu	$v0,$sp,136\n"
    "\tlwc2	$0,0($s1)\n"
    "\tlwc2	$1,4($s1)\n"
    "\tlwc2	$2,0($v1)\n"
    "\tlwc2	$3,4($v1)\n"
    "\tlwc2	$4,0($v0)\n"
    "\tlwc2	$5,4($v0)\n"
    "\tnop\n"
    "\tnop\n"
    "\t.word 0x4A280030\n"   /* rtpt */
    "\taddiu	$a0,$s0,8\n"
    "\tlw	$v0,100($sp)\n"
    "\taddiu	$v1,$s0,32\n"
    "\tsw	$v0,4($s0)\n"
    "\taddiu	$v0,$s0,24\n"
    "\tswc2	$12,0($a0)\n"
    "\tswc2	$13,0($v1)\n"
    "\tswc2	$14,0($v0)\n"
    "\tnop\n"
    "\tnop\n"
    "\t.word 0x4B68002E\n"   /* avsz4 */
    "\taddiu	$v0,$s3,20\n"
    "\tswc2	$7,0($v0)\n"
    "\tlw	$v0,20($s3)\n"
    "\tnop\n"
    "\tsra	$v0,$v0,1\n"
    "\taddiu	$v1,$v0,50\n"
    "\tbltz	$v1,.L800DE61C\n"
    "\tsw	$v1,20($s3)\n"
    "\tlui	$v0,%hi(Draw_gViewOtSize)\n"
    "\tlw	$v0,%lo(Draw_gViewOtSize)($v0)\n"
    "\tnop\n"
    "\taddiu	$v0,$v0,-3\n"
    "\tslt	$v0,$v0,$v1\n"
    "\tbnez	$v0,.L800DE61C\n"
    "\taddiu	$v0,$zero,9\n"
    "\tlui	$v1,%hi(gSparkHPixmap)\n"
    "\taddiu	$v1,$v1,%lo(gSparkHPixmap)\n"
    "\tsb	$v0,3($s0)\n"
    "\tlbu	$a0,3($s2)\n"
    "\taddiu	$v0,$zero,6\n"
    "\tsubu	$v0,$v0,$a0\n"
    "\tsll	$v0,$v0,2\n"
    "\taddu	$v0,$v0,$v1\n"
    "\tlw	$v0,0($v0)\n"
    "\tnop\n"
    "\tlw	$v1,0($v0)\n"
    "\tlw	$a1,4($v0)\n"
    "\tlw	$a2,8($v0)\n"
    "\tlw	$a3,12($v0)\n"
    "\taddiu	$a0,$sp,194\n"
    "\tsw	$v1,12($s0)\n"
    "\tsw	$a1,20($s0)\n"
    "\tsw	$a2,28($s0)\n"
    "\tsw	$a3,36($s0)\n"
    "\tlhu	$v0,6($v0)\n"
    "\taddiu	$a1,$zero,2\n"
    "\tjal	ChangeTPage__FPUsi\n"
    "\tsh	$v0,194($sp)\n"
    "\tlui	$a1,(0xFFFFFF >> 16)\n"
    "\tori	$a1,$a1,(0xFFFFFF & 0xFFFF)\n"
    "\tlhu	$v0,194($sp)\n"
    "\tlui	$a2,(0x1F800000 >> 16)\n"
    "\tlw	$a2,0($a2)\n"
    "\tlui	$a3,(0xFF000000 >> 16)\n"
    "\tsh	$v0,22($s0)\n"
    "\tlw	$v0,20($s3)\n"
    "\tlui	$s0,(0x1F800004 >> 16)\n"
    "\tlw	$s0,4($s0)\n"
    "\tsll	$v0,$v0,2\n"
    "\taddu	$v0,$v0,$a2\n"
    "\tlw	$v1,0($s0)\n"
    "\tlw	$v0,0($v0)\n"
    "\tand	$v1,$v1,$a3\n"
    "\tand	$v0,$v0,$a1\n"
    "\tor	$v1,$v1,$v0\n"
    "\tsw	$v1,0($s0)\n"
    "\tlw	$a0,20($s3)\n"
    "\taddiu	$v1,$s0,40\n"
    "\tsll	$a0,$a0,2\n"
    "\taddu	$a0,$a0,$a2\n"
    "\tlw	$v0,0($a0)\n"
    "\tlui	$at,(0x1F800004 >> 16)\n"
    "\tsw	$v1,4($at)\n"
    "\tj	.L800DE610\n"
    "\tand	$a1,$s0,$a1\n"
    ".L800DE3C8:\n"
    "\tlw	$a0,8($s2)\n"
    "\tjal	intcos\n"
    "\tnop\n"
    "\taddu	$a0,$v0,$zero\n"
    "\tjal	fixedmult\n"
    "\taddiu	$a1,$zero,6\n"
    "\tlw	$a0,8($s2)\n"
    "\tjal	intsin\n"
    "\taddu	$s0,$v0,$zero\n"
    "\taddu	$a0,$v0,$zero\n"
    "\tjal	fixedmult\n"
    "\taddiu	$a1,$zero,6\n"
    "\tlhu	$v1,48($s2)\n"
    "\taddiu	$a0,$sp,24\n"
    "\tsubu	$v1,$v1,$v0\n"
    "\tsh	$v1,16($a0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$s0\n"
    "\tsh	$v1,18($a0)\n"
    "\tlhu	$v1,52($s2)\n"
    "\tnop\n"
    "\tsh	$v1,20($a0)\n"
    "\tlhu	$v1,48($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$s0\n"
    "\tsh	$v1,24($a0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$v0\n"
    "\tsh	$v1,26($a0)\n"
    "\tlhu	$v1,52($s2)\n"
    "\tnop\n"
    "\tsh	$v1,28($a0)\n"
    "\tlhu	$v1,48($s2)\n"
    "\tnop\n"
    "\taddu	$v1,$v1,$v0\n"
    "\tsh	$v1,32($a0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tnop\n"
    "\tsubu	$v1,$v1,$s0\n"
    "\tsh	$v1,34($a0)\n"
    "\tlhu	$v1,52($s2)\n"
    "\tnop\n"
    "\tsh	$v1,36($a0)\n"
    "\tlhu	$v1,48($s2)\n"
    "\tnop\n"
    "\tsubu	$v1,$v1,$s0\n"
    "\tsh	$v1,40($a0)\n"
    "\tlhu	$v1,50($s2)\n"
    "\tnop\n"
    "\tsubu	$v1,$v1,$v0\n"
    "\tsh	$v1,42($a0)\n"
    "\tlhu	$v0,52($s2)\n"
    "\tnop\n"
    "\tsh	$v0,44($a0)\n"
    "\tlw	$v0,4($s3)\n"
    "\tlw	$v1,8($s3)\n"
    "\tnop\n"
    "\tsltu	$v0,$v0,$v1\n"
    "\tbeqz	$v0,.L800DE61C\n"
    "\taddiu	$a0,$sp,40\n"
    "\tlwc2	$0,0($a0)\n"
    "\tlwc2	$1,4($a0)\n"
    "\tnop\n"
    "\tnop\n"
    "\t.word 0x4A180001\n"   /* rtps */
    "\tlui	$t1,(0x1F800004 >> 16)\n"
    "\tori	$t1,$t1,(0x1F800004 & 0xFFFF)\n"
    "\tlw	$t0,0($t1)\n"
    "\tnop\n"
    "\taddiu	$v0,$t0,8\n"
    "\tswc2	$14,0($v0)\n"
    "\taddiu	$a0,$sp,48\n"
    "\taddiu	$v1,$sp,56\n"
    "\taddiu	$v0,$sp,64\n"
    "\tlwc2	$0,0($a0)\n"
    "\tlwc2	$1,4($a0)\n"
    "\tlwc2	$2,0($v1)\n"
    "\tlwc2	$3,4($v1)\n"
    "\tlwc2	$4,0($v0)\n"
    "\tlwc2	$5,4($v0)\n"
    "\tnop\n"
    "\tnop\n"
    "\t.word 0x4A280030\n"   /* rtpt */
    "\tlui	$v1,(0x2C000000 >> 16)\n"
    "\tlw	$v0,64($s2)\n"
    "\taddiu	$a0,$t0,16\n"
    "\tor	$v0,$v0,$v1\n"
    "\taddiu	$v1,$t0,32\n"
    "\tsw	$v0,4($t0)\n"
    "\taddiu	$v0,$t0,24\n"
    "\tswc2	$12,0($a0)\n"
    "\tswc2	$13,0($v1)\n"
    "\tswc2	$14,0($v0)\n"
    "\tnop\n"
    "\tnop\n"
    "\t.word 0x4B68002E\n"   /* avsz4 */
    "\taddiu	$v0,$s3,20\n"
    "\tswc2	$7,0($v0)\n"
    "\tlw	$v0,20($s3)\n"
    "\tnop\n"
    "\tsra	$v0,$v0,1\n"
    "\taddiu	$v1,$v0,15\n"
    "\tbltz	$v1,.L800DE61C\n"
    "\tsw	$v1,20($s3)\n"
    "\tlui	$v0,%hi(Draw_gViewOtSize)\n"
    "\tlw	$v0,%lo(Draw_gViewOtSize)($v0)\n"
    "\tnop\n"
    "\taddiu	$v0,$v0,-3\n"
    "\tslt	$v0,$v0,$v1\n"
    "\tbnez	$v0,.L800DE61C\n"
    "\taddiu	$v0,$zero,9\n"
    "\tlui	$a1,(0xFFFFFF >> 16)\n"
    "\tsb	$v0,3($t0)\n"
    "\tlui	$v0,%hi(gLeafPixmap)\n"
    "\tlw	$v0,%lo(gLeafPixmap)($v0)\n"
    "\tori	$a1,$a1,(0xFFFFFF & 0xFFFF)\n"
    "\tlw	$v1,0($v0)\n"
    "\tlw	$a0,4($v0)\n"
    "\tlw	$a2,8($v0)\n"
    "\tlw	$v0,12($v0)\n"
    "\tlui	$a3,(0xFF000000 >> 16)\n"
    "\tsw	$v1,12($t0)\n"
    "\tsw	$a0,20($t0)\n"
    "\tsw	$a2,28($t0)\n"
    "\tsw	$v0,36($t0)\n"
    "\tlw	$t0,0($t1)\n"
    "\tlw	$v0,20($s3)\n"
    "\tlui	$a2,(0x1F800000 >> 16)\n"
    "\tlw	$a2,0($a2)\n"
    "\tsll	$v0,$v0,2\n"
    "\taddu	$v0,$v0,$a2\n"
    "\tlw	$v1,0($t0)\n"
    "\tlw	$v0,0($v0)\n"
    "\tand	$v1,$v1,$a3\n"
    "\tand	$v0,$v0,$a1\n"
    "\tor	$v1,$v1,$v0\n"
    "\tsw	$v1,0($t0)\n"
    "\tlw	$a0,20($s3)\n"
    "\taddiu	$v1,$t0,40\n"
    "\tsll	$a0,$a0,2\n"
    "\taddu	$a0,$a0,$a2\n"
    "\tlw	$v0,0($a0)\n"
    "\tand	$a1,$t0,$a1\n"
    "\tsw	$v1,0($t1)\n"
    ".L800DE610:\n"
    "\tand	$v0,$v0,$a3\n"
    "\tor	$v0,$v0,$a1\n"
    "\tsw	$v0,0($a0)\n"
    ".L800DE61C:\n"
    "\tlw	$ra,216($sp)\n"
    "\tlw	$s3,212($sp)\n"
    "\tlw	$s2,208($sp)\n"
    "\tlw	$s1,204($sp)\n"
    "\tlw	$s0,200($sp)\n"
    "\tjr	$ra\n"
    "\taddiu	$sp,$sp,224\n"
    "\t.section .rodata, \"a\"\n"
    "\t.align 2\n"
    "\t.globl jtbl_8005699C\n"
    "jtbl_8005699C:\n"
    "\t.word .L800DD7E8\n"
    "\t.word .L800DD804\n"
    "\t.word .L800DD850\n"
    "\t.word .L800DD874\n"
    "\t.word .L800DE61C\n"
    "\t.word .L800DDD0C\n"
    "\t.word .L800DDDEC\n"
    "\t.word .L800DE130\n"
    "\t.word .L800DDEF4\n"
    "\t.word .L800DDA74\n"
    "\t.word .L800DDFFC\n"
    "\t.word .L800DE61C\n"
    "\t.word .L800DE3C8\n"
    "\t.word .L800DE3C8\n"
    "\t.previous\n"     /* switch back to .text -- the code+data live in ONE assembler pass, but the
                            surrounding C++ TU keeps emitting into .text after this __asm__ block ends */
    "\t.set pop\n"
);
#else
/* Portable host fallback (non-MIPS builds): functionally-equivalent C reconstruction of the
   above hand-written assembly (semantics verified against the oracle instruction-by-instruction
   during the transcription pass; not expected to byte-match anything since it's compiler output
   standing in for hand-asm on a platform that never runs it). */
void Sfx_BuildSouffleFacet(DRender_tView *Vi,Souffle_tISouffle *is)

{
  sfxsouffle dSouffle;
  Sfx_tCache *sd;
  POLY_FT4 *prim;
  Draw_tPixMap *pmx;
  SVECTOR ribbon[4];
  SVECTOR ptrans;
  VECTOR proj;
  coorddef wpos;
  coorddef src;
  u_short tpage;
  int radius;
  int cosa;
  int sina;
  int otz;
  int colorcode;

  sd = (Sfx_tCache *)0x1f800000;   /* oracle: literal scratchpad address, not %hi/%lo(Sfx_gCache) */
  switch((u_char)is->type) {
  case 1:
    Sfx_BuildSmokeFacet(is,&dSouffle,gSMokePalette);
    Sfx_AdditivePrim(&dSouffle.pmx,&dSouffle.v0,0,0xf,sd);
    break;
  case 2:
    Sfx_BuildSmokeFacet(is,&dSouffle,gSMokePalette);
    if ((u_char)is->cycle < 0x12) {
      is->type = 1;
    }
    Sfx_AdditivePrim(&dSouffle.pmx,&dSouffle.v0,0,0xf,sd);
    break;
  case 3:
    Sfx_BuildSmokeFacet(is,&dSouffle,gSMokePalette);
    Sfx_AdditivePrim(&dSouffle.pmx,&dSouffle.v0,1,0xf,sd);
    break;
  case 4:
    wpos.x = is->motion.x; wpos.y = is->motion.y; wpos.z = is->motion.z;
    Math_NormalizeVector(&wpos);
    wpos.x = is->source.x + wpos.x * -4;
    wpos.y = is->source.y + wpos.y * -4;
    wpos.z = is->source.z + wpos.z * -4;
    Sfx_Transform(&wpos,&ptrans,&Vi->cview.translation);
    if (ptrans.vz < 0x40) {
      break;
    }
    radius = ptrans.vx - is->trans.vx;
    if (radius < 1) radius = is->trans.vx - ptrans.vx;
    if (radius < 0x20) {
      ptrans.vx = (ptrans.vx <= is->trans.vx) ? is->trans.vx + -0x20 : is->trans.vx + 0x20;
    }
    dSouffle.v0.vx = is->trans.vx;  dSouffle.v0.vy = is->trans.vy + 0x20;  dSouffle.v0.vz = is->trans.vz;
    dSouffle.v3.vx = is->trans.vx;  dSouffle.v3.vy = is->trans.vy + -0x20; dSouffle.v3.vz = is->trans.vz;
    dSouffle.v1.vx = ptrans.vx;     dSouffle.v1.vy = ptrans.vy + 0x20;     dSouffle.v1.vz = ptrans.vz;
    dSouffle.v2.vx = ptrans.vx;     dSouffle.v2.vy = ptrans.vy + -0x20;    dSouffle.v2.vz = ptrans.vz;
    dSouffle.pmx = *gSparkHPixmap[6 - (u_char)is->cycle];
    Sfx_AdditivePrim(&dSouffle.pmx,&dSouffle.v0,2,0x28,sd);
    break;
  case 6:
    radius = 0x88 - (u_char)is->cycle;
    cosa = fixedmult(fastintcos(is->angle),radius);
    sina = fixedmult(fastintsin(is->angle),radius);
    goto SfxSouffle_billboard;
  case 7:
    radius = (8 - (u_char)is->cycle) * 4 + 0x19;
    cosa = fixedmult(fastintcos(is->angle),radius);
    sina = fixedmult(fastintsin(is->angle),radius);
    dSouffle.v0.vx = is->trans.vx - (short)sina;  dSouffle.v0.vy = is->trans.vy + (short)cosa;  dSouffle.v0.vz = is->trans.vz;
    dSouffle.v1.vx = is->trans.vx + (short)cosa;  dSouffle.v1.vy = is->trans.vy + (short)sina;  dSouffle.v1.vz = is->trans.vz;
    dSouffle.v2.vx = is->trans.vx + (short)sina;  dSouffle.v2.vy = is->trans.vy - (short)cosa;  dSouffle.v2.vz = is->trans.vz;
    dSouffle.v3.vx = is->trans.vx - (short)cosa;  dSouffle.v3.vy = is->trans.vy - (short)sina;  dSouffle.v3.vz = is->trans.vz;
    Sfx_BuildFastDisolveFacet(is,&dSouffle,gGravelPixmap[is->rndpixmap],gGrassPalette);
    Sfx_AdditivePrim(&dSouffle.pmx,&dSouffle.v0,0,0xf,sd);
    break;
  case 9:
    radius = (8 - (u_char)is->cycle) * 4 + 0x19;
    cosa = fixedmult(fastintcos(is->angle),radius);
    sina = fixedmult(fastintsin(is->angle),radius);
    dSouffle.v0.vx = is->trans.vx - (short)sina;  dSouffle.v0.vy = is->trans.vy + (short)cosa;  dSouffle.v0.vz = is->trans.vz;
    dSouffle.v1.vx = is->trans.vx + (short)cosa;  dSouffle.v1.vy = is->trans.vy + (short)sina;  dSouffle.v1.vz = is->trans.vz;
    dSouffle.v2.vx = is->trans.vx + (short)sina;  dSouffle.v2.vy = is->trans.vy - (short)cosa;  dSouffle.v2.vz = is->trans.vz;
    dSouffle.v3.vx = is->trans.vx - (short)cosa;  dSouffle.v3.vy = is->trans.vy - (short)sina;  dSouffle.v3.vz = is->trans.vz;
    Sfx_BuildFastDisolveFacet(is,&dSouffle,gGravelPixmap[is->rndpixmap],gSnowPalette);
    Sfx_AdditivePrim(&dSouffle.pmx,&dSouffle.v0,0,0xf,sd);
    break;
  case 11:
    radius = (8 - (u_char)is->cycle) * 4 + 0xc;
    cosa = fixedmult(fastintcos(is->angle),radius);
    sina = fixedmult(fastintsin(is->angle),radius);
SfxSouffle_billboard:
    dSouffle.v0.vx = is->trans.vx - (short)sina;  dSouffle.v0.vy = is->trans.vy + (short)cosa;  dSouffle.v0.vz = is->trans.vz;
    dSouffle.v1.vx = is->trans.vx + (short)cosa;  dSouffle.v1.vy = is->trans.vy + (short)sina;  dSouffle.v1.vz = is->trans.vz;
    dSouffle.v2.vx = is->trans.vx + (short)sina;  dSouffle.v2.vy = is->trans.vy - (short)cosa;  dSouffle.v2.vz = is->trans.vz;
    dSouffle.v3.vx = is->trans.vx - (short)cosa;  dSouffle.v3.vy = is->trans.vy - (short)sina;  dSouffle.v3.vz = is->trans.vz;
    Sfx_BuildFastDisolveFacet(is,&dSouffle,gSMokePixmap[is->rndpixmap],
                              (is->type == 6) ? gDirtPalette : gSnowPalette);
    Sfx_AdditivePrim(&dSouffle.pmx,&dSouffle.v0,0,0xf,sd);
    break;
  case 8:
  case 10:
    wpos.x = is->motion.x; wpos.y = is->motion.y; wpos.z = is->motion.z;
    Math_NormalizeVector(&wpos);
    src.x = is->source.x; src.y = is->source.y; src.z = is->source.z;
    radius = *(short *)((char *)is + 0x3a);   /* push-back scale */
    wpos.x = src.x - (wpos.x * radius >> 4);
    wpos.y = src.y - (wpos.y * radius >> 4);
    wpos.z = src.z - (wpos.z * radius >> 4);
    Sfx_ThickenXZ(ribbon,&wpos,&src,&Vi->cview.translation);
    colorcode = (is->type == 8) ? 0x2e301818 : 0x2e181010;
    otz = 0x32;
    pmx = gSparkHPixmap[6 - (u_char)is->cycle];
    TrsProj_SetPsxMatrix(&gWorldMat,(coorddef *)0x0);
    if (sd->head.cprim.PrimPtr < sd->head.cprim.MPrimPtr) {
      gte_ldv0(&ribbon[1]);
      gte_rtps();
      prim = (POLY_FT4 *)sd->head.cprim.PrimPtr;
      gte_stlvnl(&proj);
      if (proj.vz >= 0x20) {
        gte_stsxy(&prim->x1);
        gte_ldv3(&ribbon[0],&ribbon[2],&ribbon[3]);
        gte_rtpt();
        *(int *)&prim->r0 = colorcode;
        gte_stsxy3(&prim->x0,&prim->x3,&prim->x2);
        gte_avsz4();
        gte_stOTZ(&sd->otz);   /* oracle stores OTZ ($7) here, not SZ3 ($19) */
        sd->otz = (sd->otz >> 1) + otz;
        if ((sd->otz >= 0) && (sd->otz <= Draw_gViewOtSize + -3)) {
          *((char *)prim + 3) = 9;   /* OT tag length (9 words) -- NOT prim->code */
          *(u_int *)&prim->u0 = *(u_int *)&pmx->u0;
          *(u_int *)&prim->u1 = *(u_int *)&pmx->u1;
          *(u_int *)&prim->u2 = *(u_int *)&pmx->u2;
          *(u_int *)&prim->u3 = *(u_int *)&pmx->u3;
          tpage = pmx->tpage;
          ChangeTPage(&tpage,(is->type == 8) ? 2 : 1);
          prim->tpage = tpage;
          prim->tag = prim->tag & 0xff000000 | *(u_int *)(sd->head.cprim.LastPrim + sd->otz) & 0xffffff;
          colorcode = (int)sd->head.cprim.PrimPtr & 0xffffff;
          sd->head.cprim.PrimPtr = (char *)((char *)sd->head.cprim.PrimPtr + 0x28);
          ((u_int *)sd->head.cprim.LastPrim)[sd->otz] =
               ((u_int *)sd->head.cprim.LastPrim)[sd->otz] & 0xff000000 | colorcode;
        }
      }
    }
    break;
  case 13:
  case 14:
    cosa = fixedmult(fastintcos(is->angle),6);
    sina = fixedmult(fastintsin(is->angle),6);
    dSouffle.v0.vx = is->trans.vx - (short)sina;  dSouffle.v0.vy = is->trans.vy + (short)cosa;  dSouffle.v0.vz = is->trans.vz;
    dSouffle.v1.vx = is->trans.vx + (short)cosa;  dSouffle.v1.vy = is->trans.vy + (short)sina;  dSouffle.v1.vz = is->trans.vz;
    dSouffle.v2.vx = is->trans.vx + (short)sina;  dSouffle.v2.vy = is->trans.vy - (short)cosa;  dSouffle.v2.vz = is->trans.vz;
    dSouffle.v3.vx = is->trans.vx - (short)cosa;  dSouffle.v3.vy = is->trans.vy - (short)sina;  dSouffle.v3.vz = is->trans.vz;
    if (sd->head.cprim.PrimPtr < sd->head.cprim.MPrimPtr) {
      gte_ldv0(&dSouffle.v0);
      gte_rtps();
      prim = (POLY_FT4 *)sd->head.cprim.PrimPtr;
      gte_stsxy(&prim->x0);
      gte_ldv3(&dSouffle.v1,&dSouffle.v2,&dSouffle.v3);
      gte_rtpt();
      *(int *)&prim->r0 = is->colour | 0x2c000000;
      gte_stsxy3(&prim->x1,&prim->x3,&prim->x2);
      gte_avsz4();
      gte_stOTZ(&sd->otz);   /* oracle stores OTZ ($7) here, not SZ3 ($19) */
      sd->otz = (sd->otz >> 1) + 0xf;
      if ((sd->otz >= 0) && (sd->otz <= Draw_gViewOtSize + -3)) {
        *((char *)prim + 3) = 9;   /* OT tag length (9 words) -- NOT prim->code */
        *(u_int *)&prim->u0 = *(u_int *)&gLeafPixmap->u0;
        *(u_int *)&prim->u1 = *(u_int *)&gLeafPixmap->u1;
        *(u_int *)&prim->u2 = *(u_int *)&gLeafPixmap->u2;
        *(u_int *)&prim->u3 = *(u_int *)&gLeafPixmap->u3;
        prim->tag = prim->tag & 0xff000000 | *(u_int *)(sd->head.cprim.LastPrim + sd->otz) & 0xffffff;
        colorcode = (int)sd->head.cprim.PrimPtr & 0xffffff;
        sd->head.cprim.PrimPtr = (char *)((char *)sd->head.cprim.PrimPtr + 0x28);
        ((u_int *)sd->head.cprim.LastPrim)[sd->otz] =
             ((u_int *)sd->head.cprim.LastPrim)[sd->otz] & 0xff000000 | colorcode;
      }
    }
    break;
  }
  return;
}
#endif

/* ---- Sfx_Add__FP17Souffle_tISouffle  [SFX.CPP:534-577] SLD-VERIFIED ---- */
void Sfx_Add(Souffle_tISouffle *is)

{
  char cycle;

  switch((u_char)is->type) {
  case 1:
  case 2:
  case 3:
    cycle = 0x1f;
    goto SfxAdd_setRandom;
  case 6:
  case 7:
  case 9:
    cycle = 8;
SfxAdd_setRandom:
    is->cycle = cycle;
    is->rndpixmap = random() & 1;
    return;
  case 11:
    is->rndpixmap = random() & 1;
    is->cycle = 2;
    return;
  case 4:
  case 8:
  case 10:
    is->cycle = 6;
    return;
  case 13:
    is->cycle = 0x40;
    is->extramotion.y = 0;
    is->extramotion.x = -is->motion.z;
    is->extramotion.z = is->motion.x;
  }
  return;
}

/* end of sfx.cpp */

/* owning-TU def (extern-declared, never defined; link-harness) */
Sfx_tCache Sfx_gCache;
