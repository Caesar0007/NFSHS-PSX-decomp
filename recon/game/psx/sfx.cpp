/* game/psx/sfx.cpp -- RECONSTRUCTED (NFS4 PSX "souffle" smoke/dust/spark FX renderer; C++ TU)
 *   7 fns: Sfx_Transform (GTE world->cam), Sfx_BuildSmokeFacet/ThickenXZ/BuildFastDisolveFacet
 *   (billboard/ribbon facet builders), Sfx_AdditivePrim (GTE additive POLY_FT4 emit),
 *   Sfx_BuildSouffleFacet (per-type render dispatch), Sfx_Add (per-type init).
 */
#include "../../nfs4_types.h"
#include "sfx_externs.h"

/* MATCH (w49-a4): PsyQ P_TAG-style OT word -- a 24-bit BITFIELD store IS the oracle's
 * `lw; and 0xff000000; and val,0xffffff; or; sw` (libgpu setaddr()), and the redundant
 * `& 0xffffff` on the VALUE side is the zero-insn ref inflator (cse folds the AND, flow.c
 * still counts the ref).  Same type/idiom as drawc.cpp's DrawC_tTag.  See Sfx_AdditivePrim. */
typedef struct { u_long addr : 24; u_long len : 8; } Sfx_tTag;


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
 * SpotPrims / SubdividFacet 0xffffff-pair family.
 * FLOOR RE-PROBED w39-a9 with the NOW-WIRED per-TU C++ flags (w38 discovered compile_cpp
 * had silently ignored them, so every earlier "flag didn't help" note measured a no-op).
 * Receipts, whole-TU probe: g_value=8 38 (adopted for OTHER reasons, see build.py) ·
 * no_split_addresses 38 · no_strength_reduce 38 · no_schedule_insns 47 (+9) ·
 * no_schedule_insns2 43 (+5).  Also re-tried the wave-14 "repeated literal -> named
 * fn-scope local" lever (`u_int m24 = 0xffffff;` feeding both `&` sites): NO CHANGE, gcc
 * copy-propagates the constant back.  Prototype re-checked vs the raw oracle: 5 REGPARM
 * args ($a0 pmx, $a1 pt, $a2 mode, $a3 offset, 0x10($sp) sd -- the 5th IS read), VOID
 * return ($v0 incoherent at the single exit).  STRONG FLOOR (count-exact 126/126,
 * >=6 source shapes + 5 build-flag configurations).  The historical note follows:) ROOT CAUSE ISOLATED this session: the 5
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
 * instrs from a second independent macro-deref CSE-blocked by pointer-type punning).
 * w41-a9 RE-CONFIRMED under the upgraded FLOOR BAR: the `prim = (POLY_FT4 *)Render_gPacketPtr;`
 * re-read that took Sfx_BuildSouffleFacet's identical OT-link tail from 168 -> 116 AND made its
 * instruction count exact does NOT transfer here -- 38 -> 42 both with and without keeping the
 * `l0` mask temp, at an unchanged count-exact 126/126.  This fn's tail is already count-exact,
 * so the residual is purely the 0xFFFFFF / 0xFF000000 / packet-cursor constant-register tie
 * (the PrimStop / SpotPrims / SubdividFacet family; w12-a7 proved no zero-cost source lever
 * exists for it -- flipping the ref count needs an EMITTED instruction). STRONG FLOOR. */
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
      /* MATCH (w49-a4, 38 -> 26, count-exact 126/126): P_TAG bitfield store at THIS site
         ONLY.  Measured at this basin: site-1 bitfield 26 . site-2 bitfield 36 . BOTH 36 .
         both-without-the-value-remask 36 . site-1 with the value read as a bitfield too 26
         (tie, kept the plain masked read) . site-1 with NO value remask 44 . site-1 plus
         a redundant `l0 & 0xffffff` on the site-2 value 38.  So the dial is ASYMMETRIC --
         exactly the w44 "P_TAG two-setting REF dial ... the two siblings need OPPOSITE
         settings" row.  This retires the STRONG-FLOOR claim in the header comment (the
         cited PrimStop/SpotPrims family was itself cracked by this same lever in w44). */
      /* MATCH (w50-A3): retail RE-READS the packet cursor into `prim` ($s0) HERE --
         `lw s0,0(t0)` -- and then uses that ONE pointer for all three jobs (tag RMW,
         cursor bump, addr24), exactly like this TU's Sfx_BuildRibbonFacet tail.  The
         w41 note recorded the re-read as "38 -> 42, does not transfer here"; that was
         the PRE-P_TAG basin.  In the w49 P_TAG basin the re-read gates the SAME 26 but
         is STRUCTURALLY EXACT: side_by_side shows ZERO position diffs (the old form had
         two: the `lui t0` pair and the tag load), i.e. every one of the 26 is now a pure
         REGISTER name.  The `u_int *ot2` pointer local for the second OT access is
         required with it (without it the site-2 address folds and costs +16).
         RESIDUAL 26 = the four-constant rotation, now QUANTIFIED as a clean +1 SHIFT of
         every constant along the numeric scan:
             ours   cursor-addr $a3 . 0xffffff $a1 . palette $a0 . 0xff000000 $a2
             retail cursor-addr $t0 . 0xffffff $a1 . palette $a2 . 0xff000000 $a3
         plus the 2nd otz chain ours $v0 / retail $a0.  RELATIVE order is identical in
         both -- retail simply has ONE MORE simultaneously-live pseudo in this block
         (7 regs v0,v1,a0,a1,a2,a3,t0 vs our 6), which pushes every constant one slot
         later.  ⇒ the dial is NOT a constant-spelling one: MINT ONE MORE live short
         pseudo in the tail (retail keeps the palette base ALIVE across both OT accesses
         -- `addu a0,a0,a2` computes into a fresh reg -- while ours mutates the palette
         base in place at the second access, `addu a0,a0,v0`, killing it one pseudo early).
         FALSIFIED at this basin (all count-exact 126/126): distinct otz temps at one or
         both sites (42/42), split-RMW with the cursor store between the OT read and the
         OT write in 3 orderings (26), a `pal` pointer local (26), the zero-insn
         `l0 & 0xffffff` re-mask (26), P_TAG bitfield at site 2 as well (26), a
         do{}while(0) depth wrapper (31 @127), index-first addu operand order at site 2
         or both (42), a use fence on l0 (46 @128) or on prim (32).
 * ---- w51-a10 (2026-08-09): 26 STAYS, count-exact 126/126.  The named "mint a 7th
 * live pseudo / keep the palette base alive across both OT accesses" angle is
 * FALSIFIED in five spellings: a `pal` byte-pointer local feeding BOTH accesses
 * plus per-access `ot1`/`ot2` locals 26 . `pal` + `ot2` only 26 . `ot1` only 26 .
 * a `u_int *pal` INDEX form `pal[sd->otz]` at both accesses 42 . `pal` + a zero-insn
 * USE fence on it between the two accesses 46 @128 (+2 insns).  cc1 folds every
 * pointer local back onto the single CSE'd scratchpad read, so the base still dies
 * at the second addu and the 6-vs-7 live-pseudo count is unchanged.  The remaining
 * route is a 7th pseudo carrying a DIFFERENT value (not a re-spelling of the palette
 * base), or the find_free_reg window trace. */
      prim = (POLY_FT4 *)Render_gPacketPtr;
      ((Sfx_tTag *)&prim->tag)->addr =
                  *(u_int *)(Render_gPalettePtr + sd->otz * 4) & 0xffffff;
      l0 = (u_int)prim & 0xffffff;
      Render_gPacketPtr = (u_char *)prim + 0x28;
      { u_int *ot2 = (u_int *)(Render_gPalettePtr + sd->otz * 4);
      *ot2 = *ot2 & 0xff000000 | l0; }
    }
  }
  return;
}

/* case-4 spark ribbon: SYM block (Vi,is,dSouffle) + (ptrans,invertedm) = an inlined
 * static helper returning the skip flag (oracle `.L800DD9F8: bnez $v1,<ret>` with the
 * two arms setting $v1 = 1 / 0). ---- */
static inline int Sfx_BuildSparkFacet(DRender_tView *Vi,Souffle_tISouffle *is,sfxsouffle *dSouffle)
{
  coorddef invertedm;
  SVECTOR ptrans;
  int dx;

  invertedm = is->motion;
  Math_NormalizeVector(&invertedm);
  invertedm.x = is->source.x - (invertedm.x << 2);
  invertedm.y = is->source.y - (invertedm.y << 2);
  invertedm.z = is->source.z - (invertedm.z << 2);
  Sfx_Transform(&invertedm,&ptrans,&Vi->cview.translation);
  if (ptrans.vz < 0x40) {
    return 1;
  }
  dx = ptrans.vx - is->trans.vx;
  /* oracle `blez v0,.L800DD924` => the dx>0 arm is the FALL-THROUGH, so the
     positive test must be written first. */
  if ((0 < dx) ? (dx < 0x20) : (is->trans.vx - ptrans.vx < 0x20)) {
    /* the clamped endpoint is measured from is->trans.vx, NOT from ptrans.vx --
       oracle `lhu $v1,0x30($s2)` feeds both `addiu $v0,$v1,0x20` and
       `addiu $v0,$v1,-0x20` before `sh $v0,0x58($sp)`. */
    ptrans.vx = (is->trans.vx < ptrans.vx) ? is->trans.vx + 0x20 : is->trans.vx + -0x20;
  }
  dSouffle->v0.vx = is->trans.vx;
  dSouffle->v0.vy = is->trans.vy + 0x20;
  dSouffle->v0.vz = is->trans.vz;
  dSouffle->v3.vx = is->trans.vx;
  dSouffle->v3.vy = is->trans.vy + -0x20;
  dSouffle->v3.vz = is->trans.vz;
  dSouffle->v1.vx = ptrans.vx;
  dSouffle->v1.vy = ptrans.vy + 0x20;
  dSouffle->v1.vz = ptrans.vz;
  dSouffle->v2.vx = ptrans.vx;
  dSouffle->v2.vy = ptrans.vy + -0x20;
  dSouffle->v2.vz = ptrans.vz;
  return 0;
}

/* ---- inlined ribbon-facet helper (SFX.CPP, static).  SYM proves both the case-10 and the
 * case-8 bodies are INLINED FUNCTION instances: their block records carry (Vi,is,color,sd)
 * as block-scope REG/AUTO "locals" = the inlined callee's PARAMETERS, and the caller copies
 * a switch-scope CVECTOR into the callee's own parm slot with a 4-byte align-1 movstrsi
 * (`sw v0,0x48(sp); lwl/lwr 0x48; swl/swr 0x6C` for case 10 -- 0x50 -> 0x64 for case 8,
 * i.e. `color` and `gcolor` respectively).
 *
 * 🏆 w41-a9 CORRECTION (340 -> 168, and the whole 224-byte frame now byte-exact):
 * it is ONE helper with FIVE parameters, not two 4-parameter twins.  The proof is the
 * SYM's inline stack-slot arithmetic -- read the two instances' slot bases off
 * `fsize=224` + the AUTO offsets:
 *      case 10 (line 46): color 108  dest 120  pt 152  check 176  tpage 192
 *      case  8 (line 89): color 100  dest 112  pt 144  check 168  tpage 194
 * Each instance is one contiguous inline frame; `dest` starts exactly 20 bytes above the
 * frame base and `color` exactly 12 bytes above it (base 92 / 100).  20 bytes = a FIVE-word
 * incoming-arg block and 12 = the FOURTH arg slot, so the callee's signature is
 * (a0,a1,a2,color@a3,a4) -- five parameters with `color` FOURTH.  A 4-parameter helper gives
 * a 16-byte block (measured: dest lands at base+16, colour at base+8) and is 8/4 bytes off
 * on EVERY slot from `color` upward, which is what the whole ~170-line frame-offset half of
 * the residual was.  The missing 3rd parameter is the ChangeTPage mode (1 for case 10, 2 for
 * case 8): gcc-2.8 constant-propagates it through the inline expansion, so it leaves no
 * instruction and no SYM record -- which is exactly why the SYM's surviving parameter list
 * reads (Vi,is,color,sd) with `color` apparently third.  Putting `mode` third keeps the SYM's
 * RELATIVE order (Vi,is,...,color,sd) intact.  MEASURED (slot-map ours-vs-oracle, all 130
 * sp-relative operands): 4 parms -> 83 mismatched slots; +mode as arg 3 -> 6; the same five
 * parms with `color` third -> 6; with `color` fourth -> 0.
 * Also load-bearing and measured together (each ALONE regresses -- land as one change):
 *   - `dest` is declared BEFORE `pt` (retail dest 120 < pt 152; the SYM lists AUTOs in
 *     REVERSE declaration order, cf. the spark helper's ptrans/invertedm pair below);
 *   - the spark helper declares `invertedm` BEFORE `ptrans` (retail 72 / 88);
 *   - the switch-scope `CVECTOR color, gcolor;` is declared just before `case 10:`,
 *     not at the top of the switch body (see the note at that declaration). ---- */
static inline void Sfx_BuildRibbonFacet(DRender_tView *Vi,Souffle_tISouffle *is,int mode,
                                        CVECTOR color,Sfx_tCache *sd)
{
  int scale;
  SVECTOR dest[4];
  coorddef pt[2];
  SVECTOR *dp;

  pt[0] = is->motion;
  Math_NormalizeVector(&pt[0]);
  pt[1] = is->source;
  scale = *(short *)((char *)is + 0x3a);   /* push-back scale */
  pt[0].x = pt[1].x - (pt[0].x * scale >> 4);
  pt[0].y = pt[1].y - (pt[0].y * scale >> 4);
  pt[0].z = pt[1].z - (pt[0].z * scale >> 4);
  dp = &dest[0];
  Sfx_ThickenXZ(dp,&pt[0],&pt[1],&Vi->cview.translation);
  TrsProj_SetPsxMatrix(&gWorldMat,(coorddef *)0x0);
  if (sd->head.cprim.PrimPtr < sd->head.cprim.MPrimPtr) {
    VECTOR check;
    POLY_FT4 *prim;

    gte_ldv0(&dest[1]);
    gte_rtps();
    prim = (POLY_FT4 *)Render_gPacketPtr;
    gte_stlvnl(&check);
    if (check.vz >= 0x20) {
      gte_stsxy(&prim->x1);
      gte_ldv3(dp,&dest[2],&dest[3]);
      gte_rtpt();
      *(u_long *)&prim->r0 = *(u_long *)&color;
      gte_stsxy3(&prim->x0,&prim->x3,&prim->x2);
      gte_avsz4();
      gte_stOTZ(&sd->otz);   /* oracle stores OTZ ($7) here, not SZ3 ($19) */
      sd->otz = (sd->otz >> 1) + 0x32;
      if ((sd->otz >= 0) && (sd->otz <= Draw_gViewOtSize + -3)) {
        u_long l3,l2,l1,l0;
        Draw_tPixMap *pmx;

        *((char *)prim + 3) = 9;   /* OT tag length (9 words) -- NOT prim->code */
        pmx = gSparkHPixmap[6 - (u_char)is->cycle];
        l0 = *(u_int *)&pmx->u0;
        l1 = *(u_int *)&pmx->u1;
        l2 = *(u_int *)&pmx->u2;
        l3 = *(u_int *)&pmx->u3;
        *(u_int *)&prim->u0 = l0;
        *(u_int *)&prim->u1 = l1;
        *(u_int *)&prim->u2 = l2;
        *(u_int *)&prim->u3 = l3;
        {
          u_short tpage;
          tpage = pmx->tpage;
          ChangeTPage(&tpage,mode);
          prim->tpage = tpage;
        }
        /* MATCH (w41-a9, 168 -> 116 and the insn count exact 938/938): the OT link
           RE-READS the packet cursor into `prim` and then uses THAT one pointer for all
           three jobs -- the tag read-modify-write, the cursor bump, and the OT word.
           Oracle: `lui $s0,0x1F80; lw $s0,4($s0)` (the reload lands in the SYM's
           prim=$s0), then `lw/and/or/sw 0($s0)`, `addiu $v1,$s0,0x28`, `and $a1,$s0,
           0xFFFFFF`.  Keeping the ORIGINAL `prim` live instead and taking the cursor
           from a fresh `Render_gPacketPtr` read costs a second base register AND leaves
           the `and`/`or` pair un-cross-jumped in this arm (+2 `and` +2 `or` on the
           opcode census, i.e. the whole 942-vs-938 overage). */
        prim = (POLY_FT4 *)Render_gPacketPtr;
        prim->tag = prim->tag & 0xff000000 |
                    *(u_int *)(Render_gPalettePtr + sd->otz * 4) & 0xffffff;
        Render_gPacketPtr = (u_char *)prim + 0x28;
        *(u_int *)(Render_gPalettePtr + sd->otz * 4) =
             *(u_int *)(Render_gPalettePtr + sd->otz * 4) & 0xff000000 |
             (u_int)prim & 0xffffff;
      }
    }
  }
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
 * the spelling is byte-identical (verify_asm is reloc-name lenient).
 *
 * ============================ w41-a9 STATUS ============================
 * GATE 116 diffs (ours 938 / oracle 938) -- was 340 at wave start, 399 before w40.
 * INSTRUCTION COUNT IS NOW EXACT (938 == 938) as well as the frame.
 * FRAME + EVERY STACK SLOT IS NOW BYTE-EXACT (fsize 224 == SYM; slot map ours-vs-oracle
 * 130/130 sp-relative operands identical, was 47/130).
 *
 * 🏆 THE FRAME/INTERLEAVE PROBLEM IS SOLVED (see the helper's header comment for the
 * derivation).  It was NOT an assign_stack_temp ordering quirk: the case-8 and case-10
 * inline instances are offset by 8 because the helper takes FIVE parameters (20-byte
 * incoming-arg block) with `color` FOURTH, and because gcc-2.8 lays an inline instance
 * out as one contiguous frame whose base moves with the caller's free-slot state.
 * Landed as ONE change (each part alone REGRESSES -- receipts in mismatched-slot counts
 * out of 130): 4-parm twins 83 -> +5th `mode` parm 6 -> `color` moved to 4th 0.
 * Companion decl-order fixes, same commit: spark helper `invertedm` before `ptrans`
 * (retail 72/88), ribbon helper `dest` before `pt` (retail 120/152), switch-scope
 * `CVECTOR color,gcolor` declared just before `case 10:` (their slots 72/80 REUSE case
 * 4's freed inline frame, which is only possible if cc1plus reached the decls after
 * expanding case 4).  The old note "swapping pt/dest REGRESSES hard (1095) -- the order
 * is right" was a verify_asm LCS ARTIFACT: with the sp displacements blinded the diff is
 * 170 for every ordering, and the slot-map metric is what discriminates.  Likewise the
 * old "two separate helpers, not one" reading was wrong.
 * The rejected `int deadfrm[2];` scaffolding diagnostic is superseded -- do not reuse it.
 *
 * EARLIER (w40) findings, still valid:
 *  - saved-reg mask is EXACTLY the SYM's $800F0000 = s0,s1,s2,s3,ra.  The pre-inline build
 *    spilled a 6th (s4) because cse unified the two `&wpos` rtxes into one pseudo live
 *    across Math_NormalizeVector; inside an inlined callee the address is rematerialised
 *    per use, exactly like retail's two `addiu $a0,$sp,0x48`.
 *  - Vi lands in $s0 (SYM $10); s0 is then freed for &dSouffle in case 4 and the packet
 *    pointer in case 10, as in the oracle.
 *  - EARLY BASE-POINTER HOIST for the ribbon array: `SVECTOR *dp = &dest[0];` reproduces
 *    retail's callee-saved $s1 base held across Sfx_ThickenXZ + TrsProj_SetPsxMatrix and
 *    reused as gte_ldv3's first operand (376 -> 340).  The bare array-name argument lets
 *    cse drop the pseudo and rematerialise instead.
 *  - the OT-link packet-link temp goes through `l0` (SYM $3), not a recycled `scale`.
 *
 * REMAINING (168 lines; the sp-displacement half is gone, this is the register half):
 *  (1) the 0xFFFFFF / 0xFF000000 / &Render_gPacketPtr / Render_gPalettePtr four-constant
 *      register rotation in the case-10/8/13-14 OT-link tails -- the SAME allocator tie
 *      documented as a STRONG FLOOR on Sfx_AdditivePrim above (and as the PrimStop /
 *      SpotPrims / SubdividFacet family in the catalog).
 *  (2) case 10/8: `scale` lands in $a3 where the SYM says $3(v1), and the first product
 *      in $v1 where retail uses $t6.
 *  (3) SOLVED: the 942-vs-938 overage was the OT-link `prim` re-read (see the MATCH
 *      note at that statement).  Count is now exact.
 * MEASURED NEGATIVES on the remaining 116 (do NOT re-try): moving the palette-word load
 * before the cursor store (statement swap 118 @920 insns), hoisting it into a named
 * `l0`/`l1` temp (151/143 @921), a block-local `u_int *ot` pointer (102 @918), the
 * `((u_int*)Render_gPalettePtr)[sd->otz]` index form (86 @918) and the OR-operand Yoda
 * flip (116 @918) -- EVERY one of them lets cse fold the two palette loads into one and
 * comes out 18-20 instructions SHORT.  A lower LCS count on a body that is 20 insns short
 * is the classic fuzzy-alignment trap; the count-exact form below is the right structure.
 * w42-a5 (all NEUTRAL or WORSE -- do NOT re-try, receipts):
 *  - posdiff (alpha-rename by first-use) says the first-use register order is
 *    IDENTICAL to retail (s0 a0 s2 a1 s3 s1 v0 v1 a2 a3 t2 t3 t4 t5 t6 t1 t0) with
 *    a 56-line structural residual, i.e. the 116 is NOT a rotation -- it is ONE
 *    instruction placed differently, repeated at the three OT-link tails: retail
 *    issues the OT-word LOAD (`lw v0,0(a0)`) BEFORE the packet-cursor STORE
 *    (`sw v1,4(at)`); ours emits the store first.
 *  - ALIAS LEVER TESTED AND REJECTED.  Hypothesis: gcc-2.8 alias.c
 *    `fixed_scalar_and_varying_struct_p` lets a FIXED-address scalar (the cursor
 *    cell at 0x1F800004) and a VARYING-address STRUCT not conflict, so giving the
 *    OT word a struct view (`typedef struct {u_int link;} T; ((T*)(pal+otz*4))->link`)
 *    should free the scheduler to hoist the load.  Measured: on the case-13/14 site
 *    alone = EXACTLY 116/938 (no effect at all); applied inside the inlined ribbon
 *    helper (cases 8+10) = 86 diffs but 918 insns, because it makes the two inline
 *    instances' OT tails identical enough for gcc to CROSS-JUMP-MERGE them (a whole
 *    25-insn tail disappears) -- 20 insns SHORT, the classic fuzzy-alignment trap.
 *  - `prim = (POLY_FT4*)Render_gPacketPtr;` re-read at the case-13/14 site (the form
 *    that WON inside the ribbon helper) = 150 @942 (+4) -- the `link` local is right
 *    there; do not port the helper's shape.
 *  - an explicit `u_char *pk = Render_gPacketPtr;` read hoisted above the tag RMW
 *    (to reproduce retail's early `lw t0,0(t1)`) = 116/938, gcc coalesces it away.
 * ===== w44-a9 THREE-TAIL VERDICT (the briefed w43 SPLIT-RMW lever, applied and measured) =
 * The residual really is ONE instruction placement repeated at the three OT tails: retail
 * emits `lw a0,20(s3); addiu v1,s0,40; sll a0,a0,2; addu a0,a0,a2; lw v0,0(a0)` and ONLY
 * THEN `sw v1,4(at)` (the packet-cursor store); ours stores the cursor first and computes
 * the OT address + load after.  Because the cursor store is a store to a LITERAL address
 * and the OT read goes through an unknown pointer, gcc can never hoist the load over the
 * store -- so the order has to come from the SOURCE.
 * APPLIED the w43 split-RMW verbatim (`otv = *(u_int*)(pal+otz*4) & 0xff000000 | link;`
 * as its own statement, cursor bump BETWEEN value and store, then `*(...) = otv;`):
 *   - inside the inlined ribbon helper (cases 8+10) : 119 diffs @ 921 insns (17 SHORT)
 *   - at the case-13/14 tail alone                 : 119 diffs @ 921 insns (17 SHORT)
 *   - same + Yoda OR operands at that tail         : 119 diffs @ 921 (canonicalized, no-op)
 * 🔑 MECHANISM OF THE COST (this is the new, named finding): the split DOES move the load
 * above the store, but it also makes that arm's tail RTL-identical to the shared merge
 * block, so gcc's CROSS-JUMP pass swallows a whole ~17-insn tail.  The cost is NOT the
 * split -- it is cross-jump depth.  Every historical falsification in the list above
 * (statement swap 118@920, named l0/l1 temp 151/143@921, block-local `u_int *ot` 102@918,
 * index form 86@918, struct view 86@918) lands on the SAME 918-921 band, i.e. they are all
 * the same cross-jump collapse, not five independent failures.
 * ALSO measured w44-a9 at the case-13/14 tail: `prim = (POLY_FT4*)Render_gPacketPtr;`
 * re-read + `link`/bump off `prim` = 150 @942 (+4); the link/bump off `prim` WITHOUT the
 * re-read = 149 @941 (+3).  Both keep the wrong load/store order too.
 * 🆕 NEW ANGLE (untried): stop fighting the placement and attack the CROSS-JUMP DEPTH
 * first (catalog w41 "Skidmark_Add 98->14 refuting a $s4<->$s5 tie floor": cross-jump depth
 * is controlled by which VARIABLE each arm's tail uses).  Give each of the three tails a
 * DISTINCT link/OT variable identity (a per-arm named local for the link word, and the
 * per-arm `mode`/offset constant participating in the tail) so the arms stay un-merged,
 * THEN apply the split-RMW.  If the arms cannot be de-merged, the second angle is the
 * inverse: accept the merge and re-derive the whole tail from the MERGED oracle block
 * (the oracle's `j T` targets .L800DE0E0/.L800DE100/.L800DE114/.L800DE11C/.L800DE120 -- map
 * which of OUR arms should reach which merge entry, rather than assuming a 1:1 tail set).
 * NOTE cases 1/2/3, 6, 7, 9, 11 byte-match; preserve them verbatim.
 * ===== w49-a4: the P_TAG BITFIELD form of the two OT stores was run at both tails and
 * lands squarely on the SAME cross-jump collapse band the w44 note describes -- record it
 * so the lever is not re-run as if it were new:
 *   ribbon tag-store bitfield (R1) 106 @940 . ribbon OT-word bitfield (R2) 86 @918 .
 *   case-13/14 tag-store (S1) 112 @940 . case-13/14 OT-word (S2) 111 @919 .
 *   R1+R2 86 @918 . S1+S2 111 @919 . R2+S2 81 @919 . R1+S1 100 @940 . all four 81 @919.
 * Every OT-word conversion lands in the 918-921 band = the ~17-20-insn cross-jump swallow
 * (identical to the "struct view = 86@918" row above); the LCS improvement is the fuzzy-
 * alignment trap, not a real gain.  The tag-store conversions are +2 insns each and do not
 * merge -- they are the honest half, but they cost diffs on their own.  CONCLUSION UNCHANGED:
 * the de-merge (distinct per-arm link/OT variable identity) has to come FIRST; the P_TAG
 * rewrite is then the natural spelling for the split-RMW step.  (The same lever DID pay on
 * this TU's Sfx_AdditivePrim, 38 -> 26 -- there the tail is single-instance so nothing merges.)
 * ===== w50-A3: THE ZERO-INSN FENCE DOES *NOT* DE-MERGE THESE TAILS (the w44/w46 "fence as
 * cross-jump DE-MERGER" job, applied here and falsified -- this closes the cheapest of the
 * two named angles).  Measured at the case-13/14 tail, all against the 116 @938 baseline:
 *   - AdditivePrim's now-sealed shape ported verbatim (re-read `prim` from the cursor +
 *     P_TAG bitfield tag store + a `u_int *ot2` pointer local): 134 @918 -- the documented
 *     ~20-insn cross-jump swallow, unchanged;
 *   - the same + a trailing zero-insn `__asm__("" : : "r"(link))` INSIDE that tail: still
 *     134 @918 (the trailing asm does not differentiate the tails for cross_jump);
 *   - the same + a LEADING fence on `prim`: 137 @919 (costs an insn, still merges);
 *   - the tail LEFT UNCHANGED and only a trailing fence added: 116 @918 -- i.e. the fence
 *     ALONE already triggers the collapse.  That last row is the real finding: the merge is
 *     NOT caused by the OT-word rewrite at all, it is latent, and ANY perturbation of this
 *     tail's RTL releases it.  ⇒ per the w44 law (post-reload cross_jump compares RENUMBERED
 *     regs) the de-merge has to come from the ALLOCATION side, not from source-level tail
 *     differentiation: the arms merge because their pseudos get the SAME hard regs.  The
 *     remaining angle is therefore the w44 "rotation before tail-shape" ordering -- fix the
 *     register assignment of one arm first (AdditivePrim's receipt above quantifies exactly
 *     which permutation retail wants for this same tail shape), THEN re-try the split-RMW.
 *     The "accept the merge and re-derive from the MERGED oracle block" angle is untouched.
 * ===================================================================================== */
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
    if (Sfx_BuildSparkFacet(Vi,is,&dSouffle) == 0) {
      dSouffle.pmx = *gSparkHPixmap[6 - (u_char)is->cycle];
      Sfx_AdditivePrim(&dSouffle.pmx,&dSouffle.v0,2,0x28,sd);
    }
    break;
    /* SYM slot map: the two switch-scope CVECTORs sit at sp+72/sp+80 -- the SAME
       bytes case 4's inlined `invertedm` occupies.  Their temp slots can only be
       the RE-USE of case 4's freed inline frame, i.e. cc1plus reached these decls
       AFTER expanding case 4 => in the original they are declared HERE (C++ allows
       a declaration mid-block), not at the top of the switch body. */
    CVECTOR color, gcolor;
  case 10:
    *(u_long *)&color = 0x2e181010;
    Sfx_BuildRibbonFacet(Vi,is,1,color,sd);
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
    *(u_long *)&gcolor = 0x2e301818;
    Sfx_BuildRibbonFacet(Vi,is,2,gcolor,sd);
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
