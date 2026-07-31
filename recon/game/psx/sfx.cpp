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
 * NEAR-MISS 38 diffs, COUNT-EXACT 126/126 (re-measured w38-a5 2026-07-31; the 53-diff /
 * 121-insn claim below is STALE -- psx_gte.h has since gained the PsyQ pointer-form
 * `gte_st*(p)` macros with the "r" constraint, which closed the 5-insn structural gap.
 * What is LEFT is the 0xFFFFFF / 0xFF000000 / &Render_gPacketPtr / Render_gPalettePtr
 * four-constant register ROTATION in the OT-link tail (ours t0=0xFFFFFF a1=palette
 * a2=&packetptr a3=0xFF000000; retail t0=&packetptr a1=0xFFFFFF a2=palette
 * a3=0xFF000000) -- the same allocator tie the catalog tracks as the PrimStop /
 * SpotPrims / SubdividFacet 0xffffff-pair family.  The historical note follows:) ROOT CAUSE ISOLATED this session: the 5
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
 * REWRITTEN 2026-07-31 (w38-a5) against the raw oracle CFG.  The prior in-file claim of
 * "74 diffs (864/938)" was STALE -- the gate measured 1346 at wave start.  Structure taken
 * from the oracle + jtbl_8005699C (asm/data/rdata_80054548.rodata.s:3578):
 *   idx (type-1) -> block:  1->.L800DD7E8  2->.L800DD804  3->.L800DD850  4->.L800DD874
 *   5->ret  6->.L800DDD0C  7->.L800DDDEC  8->.L800DE130  9->.L800DDEF4  10->.L800DDA74
 *   11->.L800DDFFC  12->ret  13/14->.L800DE3C8
 * => PHYSICAL case-body order (= C source order; wave-10 "case bodies emit in source order"):
 *   1, 2, 3, 4, 10, 6, 7, 9, 11, 8, 13/14.
 * Oracle facts driving the shape:
 *  (a) `ds` -- the vertex stores in cases 4/6/7/9/11/13/14 go through a REGISTER BASE holding
 *      &dSouffle (`addiu $s0,$sp,0x18` / `addiu $a0,$sp,0x18`, then `sh $v1,0x10($s0)` ...),
 *      NOT sp-relative displacements.  That is a real pointer local; it also defeats gcc's
 *      alias analysis so case-4 RE-LOADS ptrans.vx/vy/vz per vertex (the plain
 *      `dSouffle.v1.vx = ptrans.vx` form CSEs those loads and comes out ~6 insns short).
 *  (b) case 4 uses a SKIP FLAG, not `break`: the vz<0x40 arm does `j .L800DD9F8; li v1,1`,
 *      the normal arm ends `addu v1,zero,zero`, and .L800DD9F8 is `bnez v1,<ret>`.
 *  (c) NO source-level shared-tail gotos: every case spells its own Sfx_AdditivePrim /
 *      Sfx_BuildFastDisolveFacet call and gcc's CROSS-JUMP pass merges what it can
 *      (.L800DE0E0/.L800DE100/.L800DE114/.L800DE11C/.L800DE120 are merge entry points; case
 *      2's call is deliberately NOT merged because its arg schedule differs).  Source funnel
 *      labels/`goto`s force the WRONG merge set (catalog wave-11 "let gcc cross-jump" row).
 *  (d) cases 8/10/13/14 reach the packet cursor + OT through the SCRATCHPAD LITERALS
 *      Render_gPacketPtr (0x1F800004) / Render_gPalettePtr (0x1F800000) -- the same storage
 *      as sd->head.cprim.PrimPtr / .LastPrim (sd == 0x1F800000), but the oracle
 *      re-materializes the literal address (`lui 0x1F80; lw 4(..)`); only the
 *      PrimPtr<MPrimPtr guard and sd->otz go through the `sd` base.  Same idiom as
 *      Sfx_AdditivePrim in this TU.
 *  (e) cases 8/10 build the prim colour in an align-1 4-byte struct copied from a word temp
 *      (`sw v0,0x48(sp); lwl/lwr 0x48(sp); swl/swr 0x6C(sp)`) = an 8-insn movstrsi(size 4,
 *      align 1); a plain `int colorcode` is 8 insns short there.
 *  (f) `wpos = is->motion;` / `src = is->source;` are STRUCT ASSIGNMENTS (movstrsi -> the
 *      oracle's parallel `lw t2/t3/t4; sw t2/t3/t4`), not three scalar field copies.
 * eaclib `intcos`/`fastintcos` (same for sin) are CO-EQUAL LINKER XDEFs at one address, so
 * the spelling is byte-identical (verify_asm is reloc-name lenient). */
void Sfx_BuildSouffleFacet(DRender_tView *Vi,Souffle_tISouffle *is)

{
  sfxsouffle dSouffle;
  Sfx_tCache *sd;

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
    {
      coorddef wpos;
      SVECTOR ptrans;
      sfxsouffle *ds;
      int dx;
      int skip;

      wpos = is->motion;
      Math_NormalizeVector(&wpos);
      wpos.x = is->source.x - (wpos.x << 2);
      wpos.y = is->source.y - (wpos.y << 2);
      wpos.z = is->source.z - (wpos.z << 2);
      Sfx_Transform(&wpos,&ptrans,&Vi->cview.translation);
      ds = &dSouffle;
      if (ptrans.vz < 0x40) {
        skip = 1;
      }
      else {
        dx = ptrans.vx - is->trans.vx;
        /* oracle `blez v0,.L800DD924` => the dx>0 arm is the FALL-THROUGH, so the
           positive test must be written first. */
        if ((0 < dx) ? (dx < 0x20) : (is->trans.vx - ptrans.vx < 0x20)) {
          /* BUG FIX (w38-a5): the clamped endpoint is measured from is->trans.vx, NOT
             from ptrans.vx -- oracle `lhu $v1,0x30($s2)` (is->trans.vx) feeds both
             `addiu $v0,$v1,0x20` and `addiu $v0,$v1,-0x20` before `sh $v0,0x58($sp)`.
             The old form re-based on ptrans.vx, so the 32-unit minimum separation was
             not enforced (spark ribbon could stay degenerate). */
          ptrans.vx = (is->trans.vx < ptrans.vx) ? is->trans.vx + 0x20 : is->trans.vx + -0x20;
        }
        ds->v0.vx = is->trans.vx;
        ds->v0.vy = is->trans.vy + 0x20;
        ds->v0.vz = is->trans.vz;
        ds->v3.vx = is->trans.vx;
        ds->v3.vy = is->trans.vy + -0x20;
        ds->v3.vz = is->trans.vz;
        ds->v1.vx = ptrans.vx;
        ds->v1.vy = ptrans.vy + 0x20;
        ds->v1.vz = ptrans.vz;
        ds->v2.vx = ptrans.vx;
        ds->v2.vy = ptrans.vy + -0x20;
        ds->v2.vz = ptrans.vz;
        skip = 0;
      }
      if (skip == 0) {
        dSouffle.pmx = *gSparkHPixmap[6 - (u_char)is->cycle];
        Sfx_AdditivePrim(&dSouffle.pmx,&dSouffle.v0,2,0x28,sd);
      }
    }
    break;
  case 10:
    {
      SVECTOR ribbon[4];
      VECTOR proj;
      coorddef wpos;
      coorddef src;
      CVECTOR colour;
      POLY_FT4 *prim;
      Draw_tPixMap *pmx;
      u_short tpage;
      u_long ccode;
      u_int p0f,p1f,p2f,p3f;
      int scale;

      ccode = 0x2e181010;
      colour = *(CVECTOR *)&ccode;
      wpos = is->motion;
      Math_NormalizeVector(&wpos);
      src = is->source;
      scale = *(short *)((char *)is + 0x3a);   /* push-back scale */
      wpos.x = src.x - (wpos.x * scale >> 4);
      wpos.y = src.y - (wpos.y * scale >> 4);
      wpos.z = src.z - (wpos.z * scale >> 4);
      Sfx_ThickenXZ(ribbon,&wpos,&src,&Vi->cview.translation);
      TrsProj_SetPsxMatrix(&gWorldMat,(coorddef *)0x0);
      if (sd->head.cprim.PrimPtr < sd->head.cprim.MPrimPtr) {
        gte_ldv0(&ribbon[1]);
        gte_rtps();
        prim = (POLY_FT4 *)Render_gPacketPtr;
        gte_stlvnl(&proj);
        if (proj.vz >= 0x20) {
          gte_stsxy(&prim->x1);
          gte_ldv3(&ribbon[0],&ribbon[2],&ribbon[3]);
          gte_rtpt();
          *(u_long *)&prim->r0 = *(u_long *)&colour;
          gte_stsxy3(&prim->x0,&prim->x3,&prim->x2);
          gte_avsz4();
          gte_stOTZ(&sd->otz);   /* oracle stores OTZ ($7) here, not SZ3 ($19) */
          sd->otz = (sd->otz >> 1) + 0x32;
          if ((sd->otz >= 0) && (sd->otz <= Draw_gViewOtSize + -3)) {
            *((char *)prim + 3) = 9;   /* OT tag length (9 words) -- NOT prim->code */
            pmx = gSparkHPixmap[6 - (u_char)is->cycle];
            /* 4 named temps: oracle loads all four pixmap words into DISTINCT regs
               (lw v1/a1/a2/a3) then stores all four -- the loads fill each other's
               load-delay slots.  Per-field copies serialize through one reg (+4 nops). */
            p0f = *(u_int *)&pmx->u0;
            p1f = *(u_int *)&pmx->u1;
            p2f = *(u_int *)&pmx->u2;
            p3f = *(u_int *)&pmx->u3;
            *(u_int *)&prim->u0 = p0f;
            *(u_int *)&prim->u1 = p1f;
            *(u_int *)&prim->u2 = p2f;
            *(u_int *)&prim->u3 = p3f;
            tpage = pmx->tpage;
            ChangeTPage(&tpage,1);
            prim->tpage = tpage;
            prim->tag = prim->tag & 0xff000000 |
                        *(u_int *)(Render_gPalettePtr + sd->otz * 4) & 0xffffff;
            scale = (u_int)Render_gPacketPtr & 0xffffff;
            Render_gPacketPtr = Render_gPacketPtr + 0x28;
            *(u_int *)(Render_gPalettePtr + sd->otz * 4) =
                 *(u_int *)(Render_gPalettePtr + sd->otz * 4) & 0xff000000 | scale;
          }
        }
      }
    }
    break;
  case 6:
    {
      int radius;
      int cosa;
      int sina;
      sfxsouffle *ds;

      radius = 0x88 - (u_char)is->cycle;
      cosa = fixedmult(fastintcos(is->angle),radius);
      sina = fixedmult(fastintsin(is->angle),radius);
      ds = &dSouffle;
      ds->v0.vx = is->trans.vx - (short)sina;
      ds->v0.vy = is->trans.vy + (short)cosa;
      ds->v0.vz = is->trans.vz;
      ds->v1.vx = is->trans.vx + (short)cosa;
      ds->v1.vy = is->trans.vy + (short)sina;
      ds->v1.vz = is->trans.vz;
      ds->v2.vx = is->trans.vx + (short)sina;
      ds->v2.vy = is->trans.vy - (short)cosa;
      ds->v2.vz = is->trans.vz;
      ds->v3.vx = is->trans.vx - (short)cosa;
      ds->v3.vy = is->trans.vy - (short)sina;
      ds->v3.vz = is->trans.vz;
      Sfx_BuildFastDisolveFacet(is,ds,gSMokePixmap[is->rndpixmap],gDirtPalette);
      Sfx_AdditivePrim(&ds->pmx,&dSouffle.v0,0,0xf,sd);
    }
    break;
  case 7:
    {
      int radius;
      int cosa;
      int sina;
      sfxsouffle *ds;

      radius = (8 - (u_char)is->cycle) * 4 + 0x19;
      cosa = fixedmult(fastintcos(is->angle),radius);
      sina = fixedmult(fastintsin(is->angle),radius);
      ds = &dSouffle;
      ds->v0.vx = is->trans.vx - (short)sina;
      ds->v0.vy = is->trans.vy + (short)cosa;
      ds->v0.vz = is->trans.vz;
      ds->v1.vx = is->trans.vx + (short)cosa;
      ds->v1.vy = is->trans.vy + (short)sina;
      ds->v1.vz = is->trans.vz;
      ds->v2.vx = is->trans.vx + (short)sina;
      ds->v2.vy = is->trans.vy - (short)cosa;
      ds->v2.vz = is->trans.vz;
      ds->v3.vx = is->trans.vx - (short)cosa;
      ds->v3.vy = is->trans.vy - (short)sina;
      ds->v3.vz = is->trans.vz;
      Sfx_BuildFastDisolveFacet(is,ds,gGravelPixmap[is->rndpixmap],gGrassPalette);
      Sfx_AdditivePrim(&ds->pmx,&dSouffle.v0,0,0xf,sd);
    }
    break;
  case 9:
    {
      int radius;
      int cosa;
      int sina;
      sfxsouffle *ds;

      radius = (8 - (u_char)is->cycle) * 4 + 0x19;
      cosa = fixedmult(fastintcos(is->angle),radius);
      sina = fixedmult(fastintsin(is->angle),radius);
      ds = &dSouffle;
      ds->v0.vx = is->trans.vx - (short)sina;
      ds->v0.vy = is->trans.vy + (short)cosa;
      ds->v0.vz = is->trans.vz;
      ds->v1.vx = is->trans.vx + (short)cosa;
      ds->v1.vy = is->trans.vy + (short)sina;
      ds->v1.vz = is->trans.vz;
      ds->v2.vx = is->trans.vx + (short)sina;
      ds->v2.vy = is->trans.vy - (short)cosa;
      ds->v2.vz = is->trans.vz;
      ds->v3.vx = is->trans.vx - (short)cosa;
      ds->v3.vy = is->trans.vy - (short)sina;
      ds->v3.vz = is->trans.vz;
      Sfx_BuildFastDisolveFacet(is,ds,gGravelPixmap[is->rndpixmap],gSnowPalette);
      Sfx_AdditivePrim(&ds->pmx,&dSouffle.v0,0,0xf,sd);
    }
    break;
  case 11:
    {
      int radius;
      int cosa;
      int sina;
      sfxsouffle *ds;

      radius = (8 - (u_char)is->cycle) * 4 + 0xc;
      cosa = fixedmult(fastintcos(is->angle),radius);
      sina = fixedmult(fastintsin(is->angle),radius);
      ds = &dSouffle;
      ds->v0.vx = is->trans.vx - (short)sina;
      ds->v0.vy = is->trans.vy + (short)cosa;
      ds->v0.vz = is->trans.vz;
      ds->v1.vx = is->trans.vx + (short)cosa;
      ds->v1.vy = is->trans.vy + (short)sina;
      ds->v1.vz = is->trans.vz;
      ds->v2.vx = is->trans.vx + (short)sina;
      ds->v2.vy = is->trans.vy - (short)cosa;
      ds->v2.vz = is->trans.vz;
      ds->v3.vx = is->trans.vx - (short)cosa;
      ds->v3.vy = is->trans.vy - (short)sina;
      ds->v3.vz = is->trans.vz;
      Sfx_BuildFastDisolveFacet(is,ds,gSMokePixmap[is->rndpixmap],gSnowPalette);
      Sfx_AdditivePrim(&ds->pmx,&dSouffle.v0,0,0xf,sd);
    }
    break;
  case 8:
    {
      SVECTOR ribbon[4];
      VECTOR proj;
      coorddef wpos;
      coorddef src;
      CVECTOR colour;
      POLY_FT4 *prim;
      Draw_tPixMap *pmx;
      u_short tpage;
      u_long ccode;
      u_int p0f,p1f,p2f,p3f;
      int scale;

      ccode = 0x2e301818;
      colour = *(CVECTOR *)&ccode;
      wpos = is->motion;
      Math_NormalizeVector(&wpos);
      src = is->source;
      scale = *(short *)((char *)is + 0x3a);   /* push-back scale */
      wpos.x = src.x - (wpos.x * scale >> 4);
      wpos.y = src.y - (wpos.y * scale >> 4);
      wpos.z = src.z - (wpos.z * scale >> 4);
      Sfx_ThickenXZ(ribbon,&wpos,&src,&Vi->cview.translation);
      TrsProj_SetPsxMatrix(&gWorldMat,(coorddef *)0x0);
      if (sd->head.cprim.PrimPtr < sd->head.cprim.MPrimPtr) {
        gte_ldv0(&ribbon[1]);
        gte_rtps();
        prim = (POLY_FT4 *)Render_gPacketPtr;
        gte_stlvnl(&proj);
        if (proj.vz >= 0x20) {
          gte_stsxy(&prim->x1);
          gte_ldv3(&ribbon[0],&ribbon[2],&ribbon[3]);
          gte_rtpt();
          *(u_long *)&prim->r0 = *(u_long *)&colour;
          gte_stsxy3(&prim->x0,&prim->x3,&prim->x2);
          gte_avsz4();
          gte_stOTZ(&sd->otz);   /* oracle stores OTZ ($7) here, not SZ3 ($19) */
          sd->otz = (sd->otz >> 1) + 0x32;
          if ((sd->otz >= 0) && (sd->otz <= Draw_gViewOtSize + -3)) {
            *((char *)prim + 3) = 9;   /* OT tag length (9 words) -- NOT prim->code */
            pmx = gSparkHPixmap[6 - (u_char)is->cycle];
            /* 4 named temps: oracle loads all four pixmap words into DISTINCT regs
               (lw v1/a1/a2/a3) then stores all four -- the loads fill each other's
               load-delay slots.  Per-field copies serialize through one reg (+4 nops). */
            p0f = *(u_int *)&pmx->u0;
            p1f = *(u_int *)&pmx->u1;
            p2f = *(u_int *)&pmx->u2;
            p3f = *(u_int *)&pmx->u3;
            *(u_int *)&prim->u0 = p0f;
            *(u_int *)&prim->u1 = p1f;
            *(u_int *)&prim->u2 = p2f;
            *(u_int *)&prim->u3 = p3f;
            tpage = pmx->tpage;
            ChangeTPage(&tpage,2);
            prim->tpage = tpage;
            prim->tag = prim->tag & 0xff000000 |
                        *(u_int *)(Render_gPalettePtr + sd->otz * 4) & 0xffffff;
            scale = (u_int)Render_gPacketPtr & 0xffffff;
            Render_gPacketPtr = Render_gPacketPtr + 0x28;
            *(u_int *)(Render_gPalettePtr + sd->otz * 4) =
                 *(u_int *)(Render_gPalettePtr + sd->otz * 4) & 0xff000000 | scale;
          }
        }
      }
    }
    break;
  case 13:
  case 14:
    {
      int cosa;
      int sina;
      sfxsouffle *ds;
      POLY_FT4 *prim;
      u_int p0f,p1f,p2f,p3f;
      int link;

      cosa = fixedmult(fastintcos(is->angle),6);
      sina = fixedmult(fastintsin(is->angle),6);
      ds = &dSouffle;
      ds->v0.vx = is->trans.vx - (short)sina;
      ds->v0.vy = is->trans.vy + (short)cosa;
      ds->v0.vz = is->trans.vz;
      ds->v1.vx = is->trans.vx + (short)cosa;
      ds->v1.vy = is->trans.vy + (short)sina;
      ds->v1.vz = is->trans.vz;
      ds->v2.vx = is->trans.vx + (short)sina;
      ds->v2.vy = is->trans.vy - (short)cosa;
      ds->v2.vz = is->trans.vz;
      ds->v3.vx = is->trans.vx - (short)cosa;
      ds->v3.vy = is->trans.vy - (short)sina;
      ds->v3.vz = is->trans.vz;
      if (sd->head.cprim.PrimPtr < sd->head.cprim.MPrimPtr) {
        gte_ldv0(&dSouffle.v0);
        gte_rtps();
        prim = (POLY_FT4 *)Render_gPacketPtr;
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
          p0f = *(u_int *)&gLeafPixmap->u0;
          p1f = *(u_int *)&gLeafPixmap->u1;
          p2f = *(u_int *)&gLeafPixmap->u2;
          p3f = *(u_int *)&gLeafPixmap->u3;
          *(u_int *)&prim->u0 = p0f;
          *(u_int *)&prim->u1 = p1f;
          *(u_int *)&prim->u2 = p2f;
          *(u_int *)&prim->u3 = p3f;
          prim->tag = prim->tag & 0xff000000 |
                      *(u_int *)(Render_gPalettePtr + sd->otz * 4) & 0xffffff;
          link = (u_int)Render_gPacketPtr & 0xffffff;
          Render_gPacketPtr = Render_gPacketPtr + 0x28;
          *(u_int *)(Render_gPalettePtr + sd->otz * 4) =
               *(u_int *)(Render_gPalettePtr + sd->otz * 4) & 0xff000000 | link;
        }
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
