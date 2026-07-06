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
 * NEAR-MISS 53 diffs (121/126 insns -- 5-insn STRUCTURAL gap, re-measured 2026-07-06; the
 * in-file "38, pure coloring" note above was STALE). ROOT CAUSE ISOLATED this session: the 5
 * missing insns are the `addiu vN,base,OFF` address-materializations the oracle emits before
 * EVERY `gte_stsxy`/`gte_stsxy3` GTE store (`prim->x0/x1/x3/x2`) -- ours folds the field offset
 * straight into the `swc2` displacement (`swc2 14,8(s0)`) instead. Compared against the REAL
 * PsyQ 4.3 macro (`C:\Temp\psq43\PSX43\psx\include\inline_c.h:900-912`): `gte_stsxy`/`gte_stsxy3`
 * take a **`"r"` register constraint** with the displacement HARD-CODED to 0 in the asm string
 * (`"swc2 $14, 0( %0 )" :: "r"(r0)`) -- this FORCES the address into a register every call, no
 * exceptions. This project's shared `psx_gte.h` macro instead uses an **`"=m"` memory operand**
 * (`"swc2 $14, %0" : "=m"(*(int*)(p))`), which lets gcc pick ANY legal addressing mode including
 * folding the offset into the displacement -- exactly the divergence seen here. Confirmed NOT a
 * call-site-fixable near-miss: tried (a) `(char*)prim+N` cast, (b) computing the address into a
 * dedicated local pointer variable first, (c) a local raw `__asm__("swc2 $14,N(%0)"::"r"(prim))`
 * bypass -- ALL three reproduce the identical 53-diff fold (gcc constant-propagates through any
 * local/expression regardless of shape). A raw-asm form with a HARD-CODED scratch register name
 * (`addiu $2,%0,8; swc2 $14,0($2)`) does perturb the count (53->51) but is the register-pin
 * anti-pattern (§3.13) and caused COLLATERAL regressions elsewhere in the function (a new diff
 * appeared on `gte_stOTZ`) -- reverted. The clean fix is a macro-level constraint change
 * (`"=m"`->`"r"`) in the SHARED `recon/lib/psx_gte.h`, out of scope for a sfx.cpp-only edit.
 * ACCEPT as a genuine cross-file near-miss (matches §3.12's base+offset-fusion family, but here
 * it's a real register-vs-memory-operand codegen gap, not a verify-tool artifact). SYM lists 4
 * REG-class ULONG temps `l0,l1,l2,l3` for this fn; tried naming the 4-word pixmap-copy scratch as
 * `l0..l3` per that SYM (with the final packet-tag mask reusing the same `l0` slot once its
 * earlier live range ends), but that REGRESSED the pixmap-copy block's register pick (->66 diffs)
 * -- gcc-2.8.0 colors a single `u_long l0,l1,l2,l3;` declaration differently from 4 independently-
 * named scratch locals even though the VALUES are identical. Kept the byte-match-proven names
 * (v0f..v3f) for that block; the SYM's l0-3 naming is cosmetic here, not load-bearing. Oracle
 * allocates t0=&Render_gPacketPtr / a1=0xFFFFFF-mask / a2=Render_gPalettePtr-value /
 * a3=0xFF000000-mask for the final tag-store+increment block and reloads Render_gPacketPtr's value
 * fresh into $s0 right before reusing it (`lw s0,0(t0)`) instead of trusting `prim`'s call-spanning
 * copy; tried re-fetching into `prim`, a separate `pkt`/`u_int*` local, an address-of-macro cast,
 * and both OR-operand orderings -- all either reproduce this exact coloring or regress (extra
 * instrs from a second independent macro-deref CSE-blocked by pointer-type punning). */
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
 * NEAR-MISS 74 diffs (864/938 insns), was previously mis-classified + transcribed as a file-scope
 * __asm__ blob. 🔴 CORRECTED 2026-07-06 (GTE-heavy near-miss sweep): that classification was WRONG
 * -- verified against BOTH independent sources: (1) Ghidra (nfs4-f.exe.c @0x800DD790) decompiles a
 * completely ordinary `switch(is->type)` C++ member function -- normal locals, normal calls to this
 * TU's own Sfx_BuildSmokeFacet/Sfx_Transform/Sfx_BuildFastDisolveFacet/Sfx_ThickenXZ/Sfx_AdditivePrim
 * plus eaclib intcos/intsin/fixedmult/Math_NormalizeVector, TrsProj_SetPsxMatrix, ChangeTPage --
 * exactly the shape a dense `switch` on a 1..14 range compiles to (range-check `addiu v1,v0,-1;
 * sltiu v0,v1,14; beqz .Lret` + a computed `jr` through a jump table). (2) the oracle .s line 4 reads
 * plain `nonmatching <name>, 0xEA8` -- there is NO "Handwritten function" tag anywhere in this file;
 * that claim in the prior comment was false. The two `swc2 $26/$27 "handwritten instruction"`
 * annotations are NOT a whole-function marker -- grep confirms the SAME per-instruction annotation
 * appears in 94 other oracle .s files across this tree (DrawC_*, DrawW_*, DrawObject*, the DCT
 * decoder, ...), all of them ordinary compiled functions that use COP2 (GTE) instructions via
 * inline-asm macros (e.g. drawc.cpp's DrawC_ShadowPrim, cited by the prior comment as a "sibling
 * handwritten fn", itself calls plain `__asm__ volatile("mfc2 ...")` and carries the identical tag)
 * -- splat/spimdisasm just can't auto-name a COP2 opcode/reg into a macro mnemonic and flags it
 * per-instruction; it is NOT evidence of a hand-written function body. The jump table
 * `jtbl_8005699C` is simply what gcc-2.8.0 emits for a dense switch (14 case values, no gaps wide
 * enough to prefer an if-chain) -- materialized in .rodata by the compiler itself, not hand-placed.
 * eaclib `intcos`/`fastintcos` (same for sin) are CO-EQUAL LINKER XDEFs at the identical address
 * (see eacpsxz/sinfunc.cpp) -- calling either name is byte-identical, not a bug.
 * Reconstructed as real C (promoted from this file's previous "host fallback"); cracked from a
 * 249-insn gap to 74 this session via 3 structural fixes vs the oracle CFG: (a) type8 and type10
 * are TWO SEPARATE, independently-compiled case bodies (own jump-table slots .L800DDA74/.L800DE130,
 * textually near-identical but never one jumps into the other) -- was wrongly `case 8: case 10:`
 * shared, split into 2 full duplicates; (b) type6 must be a FULLY DUPLICATED case body, not a `goto`
 * into type11's shared billboard label -- a `goto` there invites gcc-2.8.0 to tail-merge the common
 * radius/cos/sin prologue with type7/9/11's near-identical one, which the oracle's compile never
 * does (confirmed by call-count: fixedmult/intcos/intsin now match the oracle's 10/5/5 exactly,
 * up from 8/4/4); (c) case4's post-normalize scale is `source - (motion<<2)` (oracle: `sll v0,v0,2;
 * subu`), not `source + motion*-4`. HELD residual (74 insns, concentrated in case 4's early-exit
 * dead-store scheduling + a large block whose fine-grained content hasn't been fully isolated from
 * the SequenceMatcher's alignment loss after case4) -- NOT chased further this pass; call-SITE
 * counts for every helper (Sfx_BuildSmokeFacet=3, Math_NormalizeVector=3, TrsProj_SetPsxMatrix=2,
 * Sfx_ThickenXZ=2, Sfx_AdditivePrim=2, ChangeTPage=2, Sfx_Transform=1, Sfx_BuildFastDisolveFacet=1,
 * fixedmult=10, intcos/intsin=5/5) all match the oracle exactly, so the residual is register
 * coloring/scheduling + possibly one more content nit in case 4 or the cases-6/7/9/11 tail, not a
 * missing/duplicated call. GTE ops use this file's own gte_* macros (psx_gte.h, §3.6b "=m" fold)
 * exactly like every other Sfx_* function in this TU. */
void Sfx_BuildSouffleFacet(DRender_tView *Vi,Souffle_tISouffle *is)

{
  sfxsouffle dSouffle;
  Sfx_tCache *sd;
  POLY_FT4 *prim;
  Draw_tPixMap *pmx;
  Draw_tPixMap *pal;
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
  int mode;

  sd = (Sfx_tCache *)0x1f800000;   /* oracle: literal scratchpad address, not %hi/%lo(Sfx_gCache) */
  switch((u_char)is->type) {
  case 1:
    Sfx_BuildSmokeFacet(is,&dSouffle,gSMokePalette);
    goto SfxSouffle_tailA_mode0;
  case 2:
    /* oracle: type2 has its OWN, SEPARATE Sfx_AdditivePrim call site -- does NOT join the
       shared tail below (confirmed: .L800DD804 falls to .L800DD830's own jal, then
       `j .L800DE61C` directly, never touching .L800DE114/11C/120). */
    Sfx_BuildSmokeFacet(is,&dSouffle,gSMokePalette);
    if ((u_char)is->cycle < 0x12) {
      is->type = 1;
    }
    Sfx_AdditivePrim(&dSouffle.pmx,&dSouffle.v0,0,0xf,sd);
    break;
  case 3:
    Sfx_BuildSmokeFacet(is,&dSouffle,gSMokePalette);
    goto SfxSouffle_tailA_mode1;
  case 4:
    wpos.x = is->motion.x; wpos.y = is->motion.y; wpos.z = is->motion.z;
    Math_NormalizeVector(&wpos);
    wpos.x = is->source.x - (wpos.x << 2);
    wpos.y = is->source.y - (wpos.y << 2);
    wpos.z = is->source.z - (wpos.z << 2);
    Sfx_Transform(&wpos,&ptrans,&Vi->cview.translation);
    if (ptrans.vz < 0x40) {
      break;
    }
    radius = ptrans.vx - is->trans.vx;
    if ((radius <= 0) ? (is->trans.vx - ptrans.vx < 0x20) : (radius < 0x20)) {
      ptrans.vx = (is->trans.vx < ptrans.vx) ? ptrans.vx + -0x20 : ptrans.vx + 0x20;
    }
    dSouffle.v0.vx = is->trans.vx;  dSouffle.v0.vy = is->trans.vy + 0x20;  dSouffle.v0.vz = is->trans.vz;
    dSouffle.v3.vx = is->trans.vx;  dSouffle.v3.vy = is->trans.vy + -0x20; dSouffle.v3.vz = is->trans.vz;
    dSouffle.v1.vx = ptrans.vx;     dSouffle.v1.vy = ptrans.vy + 0x20;     dSouffle.v1.vz = ptrans.vz;
    dSouffle.v2.vx = ptrans.vx;     dSouffle.v2.vy = ptrans.vy + -0x20;    dSouffle.v2.vz = ptrans.vz;
    dSouffle.pmx = *gSparkHPixmap[6 - (u_char)is->cycle];
    Sfx_AdditivePrim(&dSouffle.pmx,&dSouffle.v0,2,0x28,sd);
    break;
  case 6:
    /* oracle: type6 (.L800DDD0C) is its OWN independent block that falls through into the
       SAME shared color-setup body as type11 (.L800DE0E0) -- but gcc did NOT tail-merge type6's
       radius/cos/sin prologue with type7/9/11's near-identical one (they remain fully separate
       instruction streams in the oracle); a `goto` into a shared label here invites gcc-2.8.0 to
       tail-merge the common prologue, which the oracle never does -- so type6 is fully duplicated
       instead of jumping into type11's body. */
    radius = 0x88 - (u_char)is->cycle;
    cosa = fixedmult(fastintcos(is->angle),radius);
    sina = fixedmult(fastintsin(is->angle),radius);
    dSouffle.v0.vx = is->trans.vx - (short)sina;  dSouffle.v0.vy = is->trans.vy + (short)cosa;  dSouffle.v0.vz = is->trans.vz;
    dSouffle.v1.vx = is->trans.vx + (short)cosa;  dSouffle.v1.vy = is->trans.vy + (short)sina;  dSouffle.v1.vz = is->trans.vz;
    dSouffle.v2.vx = is->trans.vx + (short)sina;  dSouffle.v2.vy = is->trans.vy - (short)cosa;  dSouffle.v2.vz = is->trans.vz;
    dSouffle.v3.vx = is->trans.vx - (short)cosa;  dSouffle.v3.vy = is->trans.vy - (short)sina;  dSouffle.v3.vz = is->trans.vz;
    pmx = gSMokePixmap[is->rndpixmap];
    pal = gDirtPalette;
    goto SfxSouffle_tailFD;
  case 7:
    radius = (8 - (u_char)is->cycle) * 4 + 0x19;
    cosa = fixedmult(fastintcos(is->angle),radius);
    sina = fixedmult(fastintsin(is->angle),radius);
    dSouffle.v0.vx = is->trans.vx - (short)sina;  dSouffle.v0.vy = is->trans.vy + (short)cosa;  dSouffle.v0.vz = is->trans.vz;
    dSouffle.v1.vx = is->trans.vx + (short)cosa;  dSouffle.v1.vy = is->trans.vy + (short)sina;  dSouffle.v1.vz = is->trans.vz;
    dSouffle.v2.vx = is->trans.vx + (short)sina;  dSouffle.v2.vy = is->trans.vy - (short)cosa;  dSouffle.v2.vz = is->trans.vz;
    dSouffle.v3.vx = is->trans.vx - (short)cosa;  dSouffle.v3.vy = is->trans.vy - (short)sina;  dSouffle.v3.vz = is->trans.vz;
    pmx = gGravelPixmap[is->rndpixmap];
    goto SfxSouffle_tailFD_grass;
  case 9:
    radius = (8 - (u_char)is->cycle) * 4 + 0x19;
    cosa = fixedmult(fastintcos(is->angle),radius);
    sina = fixedmult(fastintsin(is->angle),radius);
    dSouffle.v0.vx = is->trans.vx - (short)sina;  dSouffle.v0.vy = is->trans.vy + (short)cosa;  dSouffle.v0.vz = is->trans.vz;
    dSouffle.v1.vx = is->trans.vx + (short)cosa;  dSouffle.v1.vy = is->trans.vy + (short)sina;  dSouffle.v1.vz = is->trans.vz;
    dSouffle.v2.vx = is->trans.vx + (short)sina;  dSouffle.v2.vy = is->trans.vy - (short)cosa;  dSouffle.v2.vz = is->trans.vz;
    dSouffle.v3.vx = is->trans.vx - (short)cosa;  dSouffle.v3.vy = is->trans.vy - (short)sina;  dSouffle.v3.vz = is->trans.vz;
    pmx = gGravelPixmap[is->rndpixmap];
    pal = gSnowPalette;
    goto SfxSouffle_tailFD;
  case 11:
    radius = (8 - (u_char)is->cycle) * 4 + 0xc;
    cosa = fixedmult(fastintcos(is->angle),radius);
    sina = fixedmult(fastintsin(is->angle),radius);
    dSouffle.v0.vx = is->trans.vx - (short)sina;  dSouffle.v0.vy = is->trans.vy + (short)cosa;  dSouffle.v0.vz = is->trans.vz;
    dSouffle.v1.vx = is->trans.vx + (short)cosa;  dSouffle.v1.vy = is->trans.vy + (short)sina;  dSouffle.v1.vz = is->trans.vz;
    dSouffle.v2.vx = is->trans.vx + (short)sina;  dSouffle.v2.vy = is->trans.vy - (short)cosa;  dSouffle.v2.vz = is->trans.vz;
    dSouffle.v3.vx = is->trans.vx - (short)cosa;  dSouffle.v3.vy = is->trans.vy - (short)sina;  dSouffle.v3.vz = is->trans.vz;
    pmx = gSMokePixmap[is->rndpixmap];
    pal = gSnowPalette;
SfxSouffle_tailFD:
    Sfx_BuildFastDisolveFacet(is,&dSouffle,pmx,pal);
    goto SfxSouffle_tailA_mode0;
SfxSouffle_tailFD_grass:
    Sfx_BuildFastDisolveFacet(is,&dSouffle,pmx,gGrassPalette);
    goto SfxSouffle_tailA_mode0;
SfxSouffle_tailA_mode1:
    mode = 1;
    goto SfxSouffle_tailA;
SfxSouffle_tailA_mode0:
    mode = 0;
SfxSouffle_tailA:
    Sfx_AdditivePrim(&dSouffle.pmx,&dSouffle.v0,mode,0xf,sd);
    break;
  case 10:
    /* oracle: type8 and type10 are TWO SEPARATE, independently-compiled case bodies (own jump-
       table slots .L800DDA74 / .L800DE130) -- textually near-identical but NOT a case-fallthrough
       or shared tail (confirmed: neither block jumps into the other; each has its own copy of the
       full Math_NormalizeVector->Sfx_ThickenXZ->TrsProj_SetPsxMatrix->GTE sequence, at different
       stack offsets). Duplicated verbatim per-case to match. */
    wpos.x = is->motion.x; wpos.y = is->motion.y; wpos.z = is->motion.z;
    Math_NormalizeVector(&wpos);
    src.x = is->source.x; src.y = is->source.y; src.z = is->source.z;
    radius = *(short *)((char *)is + 0x3a);   /* push-back scale */
    wpos.x = src.x - (wpos.x * radius >> 4);
    wpos.y = src.y - (wpos.y * radius >> 4);
    wpos.z = src.z - (wpos.z * radius >> 4);
    Sfx_ThickenXZ(ribbon,&wpos,&src,&Vi->cview.translation);
    colorcode = 0x2e181010;
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
          ChangeTPage(&tpage,1);
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
  case 8:
    wpos.x = is->motion.x; wpos.y = is->motion.y; wpos.z = is->motion.z;
    Math_NormalizeVector(&wpos);
    src.x = is->source.x; src.y = is->source.y; src.z = is->source.z;
    radius = *(short *)((char *)is + 0x3a);   /* push-back scale */
    wpos.x = src.x - (wpos.x * radius >> 4);
    wpos.y = src.y - (wpos.y * radius >> 4);
    wpos.z = src.z - (wpos.z * radius >> 4);
    Sfx_ThickenXZ(ribbon,&wpos,&src,&Vi->cview.translation);
    colorcode = 0x2e301818;
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
          ChangeTPage(&tpage,2);
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
