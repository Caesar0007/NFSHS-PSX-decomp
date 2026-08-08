/* game/psx/flare.cpp -- RECONSTRUCTED (NFS4 PSX in-race HUD; C++ TU)
 *   62 fns: sprite/poly builders, tachometer, number rasterizer, mini-map + radar,
 *   CD player, wingman interface, render views (hud/tac/map/stats), 3-2-1-GO, BTC/busted.
 *   Reconstructed with full SYM-locals applied (audited).
 */
#include "../../nfs4_types.h"
#include "flare_externs.h"

/* PsyQ gte_ldclmv/gte_stclmv (matrix-COLUMN short vector, stride 6) -- the
 * CarShapedHalo/Halo2 column transforms: lhu 0/6/12 -> IR1-3 and IR1-3 -> sh 0/6/12
 * (oracle @0x800CD0B0.., 3 lhu then 3 mtc2 / 3 mfc2 then 3 sh, scratch $12-$14).
 * Promoted to psx_gte.h (w40 consolidation; was TU-local since w13-a3). */

/* ---- Flare.obj-OWNED globals -- DEFINED here (self-contained; SYM-typed via gen_owned_defs:
   .data = real NFS4.EXE bytes, .bss = zero) ---- */
short        gfSpikePt0[8] = { 3, 3, 0, 0, 1, 1, 2, 2 };   /* @0x8011fde0 */
short        gfSpikePt1[8] = { 1, 2, 2, 3, 3, 0, 0, 1 };   /* @0x8011fdf0 */
short        gfSpikePt2[8] = { 4, 5, 6, 7, 8, 9, 10, 11 };   /* @0x8011fe00 */
short        gfOctPt1[8] = { 4, 5, 6, 7, 8, 9, 10, 11 };   /* @0x8011fe10 */
short        gfOctPt2[8] = { 5, 6, 7, 8, 9, 10, 11, 4 };   /* @0x8011fe20 */
short        gfHexPt1[6] = { 0, 1, 2, 3, 4, 5 };   /* @0x8011fe30 */
short        gfHexPt2[6] = { 1, 2, 3, 4, 5, 0 };   /* @0x8011fe3c */
SVECTOR      Flare_gSpikes[4] = { {0, -45, 0, 0}, {45, 0, 0, 0}, {0, 45, 0, 0}, {-45, 0, 0, 0} };   /* @0x8011fe48 */
SVECTOR      Flare_gOct[8] = { {0, -256, 0, 0}, {180, -180, 0, 0}, {256, 0, 0, 0}, {180, 180, 0, 0}, {0, 256, 0, 0}, {-180, 180, 0, 0}, {-256, 0, 0, 0}, {-180, -180, 0, 0} };   /* @0x8011fe68 */
SVECTOR      Flare_gSmallOct[8] = { {0, -45, 0, 0}, {31, -31, 0, 0}, {45, 0, 0, 0}, {31, 31, 0, 0}, {0, 45, 0, 0}, {-31, 31, 0, 0}, {-45, 0, 0, 0}, {-31, -31, 0, 0} };   /* @0x8011fea8 */
SVECTOR      Flare_gHex[6] = { {-256, 0, 0, 0}, {-128, -221, 0, 0}, {128, -221, 0, 0}, {256, 0, 0, 0}, {128, 221, 0, 0}, {-128, 221, 0, 0} };   /* @0x8011fee8 */
SVECTOR      Flare_gReflectHex[6] = { {256, 0, 0, 0}, {128, 221, 0, 0}, {-128, 221, 0, 0}, {-256, 0, 0, 0}, {-256, -512, 0, 0}, {256, -512, 0, 0} };   /* @0x8011ff18 */
SVECTOR      Flare_gQuad[4] = { {0, -256, 0, 0}, {256, 0, 0, 0}, {0, 256, 0, 0}, {-256, 0, 0, 0} };   /* @0x8011ff48 */
Flare_tInfo  Flare_gType[34] = { {8421504u, 8421504u, 1024, 0}, {3158064u, 8421504u, 0, 3}, {526440u, 394792u, 1, 13}, {8421504u, 3158064u, 0, 13}, {4222912u, 526528u, 0, 13}, {4222912u, 526528u, 0, 13}, {7368816u, 1052696u, 0, 13}, {526464u, 526376u, 0, 13}, {526464u, 526376u, 0, 12}, {557184u, 534568u, 0, 12}, {8390664u, 2623496u, 0, 12}, {3158064u, 8421504u, 0, 3}, {526440u, 394792u, 2, 13}, {8421504u, 3158064u, 1, 13}, {4222912u, 526528u, 1, 13}, {4222912u, 526528u, 1, 13}, {7368816u, 1052696u, 1, 13}, {526464u, 526376u, 1, 13}, {526464u, 526376u, 1, 12}, {557184u, 534568u, 1, 12}, {8390664u, 2623496u, 1, 12}, {526464u, 526376u, 0, 0}, {662658u, 132116u, 675, 136}, {48830u, 17990u, 0, 0}, {12632256u, 0, 770, 4}, {3688552u, 2105376u, 1795, 12}, {6314040u, 1579032u, 3594, 12}, {2123920u, 1581088u, 3594, 12}, {2123920u, 1581088u, 1281, 8}, {6318248u, 2105376u, 734, 8}, {13158600u, 2105376u, 16384, 9}, {2123920u, 1581088u, 1281, 24}, {7572224u, 0, 1024, 12}, {16711680u, 0, 256, 8} };   /* @0x8011ff68 */
SVECTOR      gOv[4] = { {-2, 0, 0, 0}, {2, 0, 0, 0}, {-2, 256, 0, 0}, {2, 256, 0, 0} };   /* @0x80120188 */
SVECTOR      Flare_gLensOct[8] = { {0, -256, 0, 0}, {180, -180, 0, 0}, {-180, -180, 0, 0}, {256, 0, 0, 0}, {-256, 0, 0, 0}, {180, 180, 0, 0}, {-180, 180, 0, 0}, {0, 256, 0, 0} };   /* @0x801201a8 */
FLARE_PIECE_DEF Flare_SunFlarePieces[9] = { {0, 19660, 2585, 1}, {-9830, 65536, 1296, 0}, {-16384, 6553, 200463, 0}, {9830, 26214, 2581, 2}, {29491, 26214, 1312262, 0}, {49152, 19660, 528149, 4}, {55705, 13107, 2036746, 2}, {65536, 6553, 660490, 0}, {75366, 19660, 1052447, 2} };   /* @0x801201e8 */
FLARE_DEF    gFlare_LensFlare;   /* @0x80120278  (bss(zero)) */
CVECTOR      gfrgb = {255u, 255u, 255u, 0};   /* @0x8013d86c */
CVECTOR      gfrgb2 = {64u, 64u, 128u, 0};   /* @0x8013d870 */
int          gscale = 4096;   /* @0x8013d874 */

/* PsyQ libgpu P_TAG head word (addr:24 | len:8) -- the SDK addPrim()/setaddr()/getaddr()
 * macro family over this bitfield.  A bitfield store generates the masked VALUE
 * (& 0xffffff) BEFORE the destination mask (& 0xff000000); the hand-written
 * `dest & 0xff000000 | src & 0xffffff` OR generates HI first.  w44-a2 / §2b.1 */
typedef struct { unsigned addr : 24, len : 8; } Flare_PTag;

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Flare_Tri(long *cp,long *p1,long *p2,int otz);
void Flare_SetMatrix(matrixtdef *m);
void Flare_IdentMatrix(MATRIX *mtx);
void Flare_OctFlare(long *center,int otz);
void Flare_OctFlareSpikes(long *center,int otz);
void Flare_Spikes(long *center,int otz);
void Flare_HexFlare(long *center,int otz);
void Flare_ReflectHexFlare(long *center,int otz);
void Flare_QuadFlare(long *center,int otz);
void Flare_Halo(DRender_tView *Vi,int scale,int type,coorddef *fpt,Draw_FlareCache *sd);
void Flare_2DSpike(long *center,long *end,int otz);
void Flare_2DHalo(int x,int y,int scalex,int scaley,int type);
void Flare_PreCalcHexLightBeam(long *center,int otz);
void Flare_Quad(long *pt,CVECTOR *color,int otz);
void Flare_QuadNotTransparent(long *pt,CVECTOR *color,int otz);
void Flare_QuadRing(long *pt,CVECTOR *color,int otz);
void Flare_TextureQuad(long *pt,CVECTOR *color,char type,int otz);
void Flare_SingleColorTex(DVECTOR *xy,CVECTOR *color,int width,int height,char type,int otz);
void Flare_SingleColorHex(DVECTOR *xy,CVECTOR *color,int width,int height,int otz);
void Flare_SingleColorOct(DVECTOR *xy,CVECTOR *color,int width,int height,int otz);
void Flare_SingleColorOctRing(DVECTOR *xy,CVECTOR *color,int width,int height,int otz);
void Flare_InitLensFlare(void);
void Flare_LensFlare(DVECTOR *screenPos,Draw_FlareCache *sd);
void Flare_Sun(SVECTOR *worldPos,Draw_FlareCache *sd);
void Flare_Moon(SVECTOR *worldPos,Draw_FlareCache *sd);


/* ============================ w41-a8 OT-LINK LEVER PAIR ============================
 * Two source shapes, applied together, that fix the whole `Flare_*` / Sky OT-link family.
 * Landed: Sky_RenderStars 2->PASS, OctFlare/Spikes/HexFlare/ReflectHexFlare 20->14 each,
 * 2DHalo 60->40, Sun 50->28 (a "100%-certified floor" -- REFUTED), Halo2 48->28,
 * CarShapedHalo 59->45, LensFlare 56->48.  Scripted appliers kept at scratch/
 * otlink_lever{,2,3}.py + slot_lever{,2}.py (see the REPORT -- worktrees get pruned).
 *
 * (1) addr24-EARLY (LICM movable ORDER).  loop.c hoists movables in INSN order = the
 *     order each constant is first GENERATED in RTL.  Inside
 *         `A & 0xff000000 | B & 0xffffff`
 *     that is ff000000-then-ffffff, but the oracle's preheader materializes
 *     `lui;ori 0xFFFFFF` BEFORE `lui 0xFF000000`.  Flipping the OR operands DOES reorder
 *     the hoists, but it also flips which subexpression lands in $v1 vs $v0 (measured on
 *     Sky_RenderStars: 8 diffs one statement flipped, 12 both).  The DECOUPLED fix is to
 *     give the SECOND RMW's `(u_int)prim & 0xffffff` its own temp evaluated right after
 *     `prim = Render_gPacketPtr;` (`addr24`, the Flare_Tri `pkt_addr24` idiom):
 *         prim   = Render_gPacketPtr;
 *         addr24 = (u_int)prim & 0xffffff;      <-- generates 0xFFFFFF FIRST
 *         *(u_int *)prim = *(u_int *)prim & 0xff000000 | *slot & 0xffffff;
 *         ...
 *         *slot = pkt24 | (addr24 & 0xffffff);
 *     The 0xFFFFFF def now precedes the 0xFF000000 def AND the first RMW keeps its
 *     prim-mask-first evaluation order.
 * (2) ONE-EXPRESSION SLOT (accumulate into the INDEX, not the base).  Replace
 *         slot = (u_int *)Render_gPalettePtr; slot = (u_int *)((int)slot + otz * 4);
 *     with the Hrz_TextureQuad/Sky_RenderStars form
 *         pal = Render_gPalettePtr;  slot = (u_int *)(otz * 4 + (int)pal);
 *     so the shift result itself is the addu DEST (oracle `sll a1,s3,2 ; lui v0 ; lw v0 ;
 *     addu a1,a1,v0`).  The `pal` temp is REQUIRED -- inlining Render_gPalettePtr into the
 *     expression costs an insn (HexFlare 29 diffs / 116 insns).
 * Applying (1)+(2) took Flare_HexFlare's ALPHA-RENAMED structural residual to 0/117 (the
 * remaining 14 gate diffs are a single $t0<->$t1 allocno swap between `i` and 0xFFFFFF).
 * NEGATIVE: (1) alone REGRESSES Flare_PreCalcHexLightBeam (16->18, no loop -> no LICM) and
 * shifts Hrz_BuildSky's preheader one slot too early (390->388 gate but a structurally
 * WORSE preheader) -- gate every site, do not apply blind.
 * =================================================================================
*
 * ===== w42-a6: THE TWO-MASK $t1<->$t2 ROTATION IS THE allocno_compare IDENTITY DELTA =====
 * Flare_Sun 28, Flare_Halo2 28, Flare_2DHalo 24-of-40, CarShapedHalo ~10-of-19, LensFlare
 * ~8-of-48 (+ Font_TextXY ~12-of-22 and Weather_DoWeather ~12-of-60 in the sibling TUs) are
 * ALL one repeated 7-diff unit: `lui 0xFFFFFF` / `lui 0xFF000000` are emitted in the SAME
 * ORDER as the oracle but land in the OPPOSITE registers.  QUANTIFIED on Flare_Sun (site 1):
 *   0xFFFFFF     birth insn 85, last use 115  -> live 30
 *   0xFF000000   birth insn 92, last use 116  -> live 24
 * Both quantities have identical ref counts, so the pick is purely the live-length tie-break:
 * OUR cc1 gives the earlier hard reg to the SHORTER-lived quantity (0xFF000000 -> $t1);
 * retail gives it to the LONGER-lived one (0xFFFFFF -> $t1).  That is exactly the
 * "allocno_compare live-length weighting" true-identity residue recorded in the catalog
 * (w32-w33 §G, 7 clean cases) -- not a source shape.  MEASURED NEGATIVE this wave (all on
 * Flare_2DHalo block 1, gate 40 baseline): drop the addr24 temp (46), addr24 AFTER the first
 * RMW (40), swap the first RMW's OR operands (40), pkt24 computed first (63, -1 insn).
 * A source flip would need 0xFFFFFF's live range SHORTER than 0xFF000000's, i.e. its `lui`
 * born AFTER the other one -- but every spelling that does that also moves the emission
 * order away from the oracle.  => permuter / toolchain-identity class, do NOT re-grind by
 * hand.  (The Flare_HexFlare family's 14-diff residual is the SAME tie with `i` as the
 * rival: mask 5 refs/50 live = .200 vs i 7 refs/54 live = .2593; the flip needs mask refs
 * >= 7 (a 3rd in-loop use, which does not exist) or i's live > 70.)
 * =========================================================================================
 */

/* ---- Flare_Tri__FPlN20i  [FLARE.CPP:75-89] SLD-VERIFIED ---- */
void Flare_Tri(long *cp,long *p1,long *p2,int otz)

{
  int pkt_addr24;
  u_char *prim;

  otz = otz * 4 + (int)Render_gPalettePtr;
  prim = Render_gPacketPtr;
  *(u_int *)prim = *(u_int *)prim & 0xff000000 | *(u_int *)otz & 0xffffff;
  pkt_addr24 = *(u_int *)otz & 0xff000000;
  Render_gPacketPtr = prim + 0x1c;
  *(u_int *)otz = pkt_addr24 | (u_int)prim & 0xffffff;
  *(u_int *)(prim + 4) = 0x32000000;
  *(u_int *)(prim + 0xc) = *(u_int *)&gfrgb;
  *(u_int *)(prim + 0x14) = 0;
  prim[3] = 6;
  *(long *)(prim + 8) = *p2;
  *(long *)(prim + 0x10) = *cp;
  *(long *)(prim + 0x18) = *p1;
  return;
}

/* ---- Flare_SetMatrix__FP10matrixtdef  [FLARE.CPP:184-192] SLD-VERIFIED ---- */
void Flare_SetMatrix(matrixtdef *m)
{
  MATRIX mpsx;
  int *mm = (int *)m;

  /* MATCH: SYM shows r0/r1/r2 re-declared in THREE separate nested block
   * scopes (one per row) rather than one function-scope decl -- each block's
   * {int r0,r1,r2;} is a FRESH pseudo (§A block-scope rule). */
  {
    int r0, r1, r2;
    r0 = mm[0] >> 4; r1 = mm[3] >> 4; r2 = mm[6] >> 4;
    mpsx.m[0][0] = (short)r0; mpsx.m[0][1] = (short)r1; mpsx.m[0][2] = (short)r2;
  }
  {
    int r0, r1, r2;
    r0 = mm[1] >> 4; r1 = mm[4] >> 4; r2 = mm[7] >> 4;
    mpsx.m[1][0] = (short)r0; mpsx.m[1][1] = (short)r1; mpsx.m[1][2] = (short)r2;
  }
  {
    int r0, r1, r2;
    r0 = mm[2] >> 4; r1 = mm[5] >> 4; r2 = mm[8] >> 4;
    mpsx.m[2][0] = (short)r0; mpsx.m[2][1] = (short)r1; mpsx.m[2][2] = (short)r2;
  }
  gte_SetRotMatrix(&mpsx);
  gte_ldtr0();
}

/* ---- Flare_IdentMatrix__FP6MATRIX  [FLARE.CPP:196-202] SLD-VERIFIED ---- */
void Flare_IdentMatrix(MATRIX *mtx)

{
  *(int *)((char *)mtx + 0) = 0x1000;
  *(int *)((char *)mtx + 4) = 0;
  *(int *)((char *)mtx + 8) = 0x1000;
  *(int *)((char *)mtx + 0xc) = 0;
  *(int *)((char *)mtx + 0x10) = 0x1000;
  return;
}

/* ---- Flare_OctFlare__FPli  [FLARE.CPP:208-241] SLD-VERIFIED ---- */
void Flare_OctFlare(long *center,int otz)

{
  int i;
  long rgb1;
  long flare_dvxy [13];

  /* MATCH: SYM locals = flare_dvxy[13] + i(t1) + rgb1(t4, pre-loop gfrgb cache)
   * + block-scope prim(a0); walkers = givs from gfOctPt1[i]/gfOctPt2[i]. */
  rgb1 = *(long *)&gfrgb;
gte_ldv0(&Flare_gOct);
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x10));
gte_ldv0(((char *)&Flare_gOct + 0x8));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x14));
gte_ldv0(((char *)&Flare_gOct + 0x10));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x18));
gte_ldv0(((char *)&Flare_gOct + 0x18));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x1c));
gte_ldv0(((char *)&Flare_gOct + 0x20));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x20));
gte_ldv0(((char *)&Flare_gOct + 0x28));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x24));
gte_ldv0(((char *)&Flare_gOct + 0x30));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x28));
gte_ldv0(((char *)&Flare_gOct + 0x38));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x2c));
  i = 8;
  while( true ) {
    i = i - 1;
    if (i == -1) break;
    {
      u_char *prim;
      u_int *slot;
      u_char *pal;
      u_int pkt24;
      u_int addr24;
      prim = Render_gPacketPtr;
      addr24 = (u_int)prim & 0xffffff;
      pal = Render_gPalettePtr;
      slot = (u_int *)(otz * 4 + (int)pal);
      *(u_int *)prim = *(u_int *)prim & 0xff000000 | *slot & 0xffffff;
      pkt24 = *slot & 0xff000000;
      Render_gPacketPtr = prim + 0x1c;
      *slot = pkt24 | (addr24 & 0xffffff);
      *(u_int *)(prim + 4) = 0x32000000;
      *(long *)(prim + 0xc) = rgb1;
      *(u_int *)(prim + 0x14) = 0;
      prim[3] = 6;
      *(long *)(prim + 8) = flare_dvxy[gfOctPt2[i]];
      *(long *)(prim + 0x10) = *center;
      *(long *)(prim + 0x18) = flare_dvxy[gfOctPt1[i]];
    }
  }
  return;
}

/* ---- Flare_OctFlareSpikes__FPli  [FLARE.CPP:247-316] SLD-VERIFIED ---- */
void Flare_OctFlareSpikes(long *center,int otz)

{
  int i;
  long rgb1;
  long rgb2;
  long cent;
  int id0;
  int id1;
  int id2;
  long flare_dvxy [13];

  /* MATCH: SYM locals = flare_dvxy[13], i(t3), rgb1(s2)/rgb2(s1) pre-loop caches,
   * cent(t8), id0(a3)/id1(t1)/id2(a2) in-place reused across both prims;
   * SpikePt0/1/2[i] -> givs, OctPt1/2[i] stay indexed (giv budget).
   * ---- w45-a9 SEAL 4 -> PASS 225/225: the LICM PREHEADER ORDER IS THE SOURCE
   * STATEMENT ORDER of the OT-link block (loop.c hoists movables in RTL-generation
   * order).  Retail's preheader = pktaddr(t2) | palette-addr(s0) | otz*4(t9) |
   * 0xFFFFFF(t0) | 0xFF000000(t7).  Two edits, each moving ONE movable's birth:
   *   (1) `pal = Render_gPalettePtr;` as its OWN statement before `slot = otz*4 + pal`
   *       (the one-expression form generated `sll` BEFORE the `lui 0x1F80`);
   *   (2) `addr24_0 = prim & 0xffffff;` moved AFTER the slot statement (it was the
   *       w41 addr24-EARLY spelling, which put 0xFFFFFF ahead of the palette base).
   * addr24 still precedes the first RMW, so 0xFFFFFF is still born before 0xFF000000
   * (the w41 lever's actual requirement).  GENERAL RULE for this family: order the
   * OT-link statements = order you want the preheader constants; addr24 goes between
   * the slot computation and the first RMW, not at the top of the block. */
gte_ldv0(&Flare_gSpikes);

  gte_rtps();

gte_swc2(0xe,&flare_dvxy);

gte_ldv0(((char *)&Flare_gSpikes + 0x8));

  gte_rtps();

gte_swc2(0xe,((char *)&flare_dvxy + 0x4));

gte_ldv0(((char *)&Flare_gSpikes + 0x10));

  gte_rtps();

gte_swc2(0xe,((char *)&flare_dvxy + 0x8));

gte_ldv0(((char *)&Flare_gSpikes + 0x18));

  gte_rtps();

gte_swc2(0xe,((char *)&flare_dvxy + 0xc));

gte_ldv0(&Flare_gOct);

  gte_rtps();

gte_swc2(0xe,((char *)&flare_dvxy + 0x10));

gte_ldv0(((char *)&Flare_gOct + 0x8));

  gte_rtps();

gte_swc2(0xe,((char *)&flare_dvxy + 0x14));

gte_ldv0(((char *)&Flare_gOct + 0x10));

  gte_rtps();

gte_swc2(0xe,((char *)&flare_dvxy + 0x18));

gte_ldv0(((char *)&Flare_gOct + 0x18));

  gte_rtps();

gte_swc2(0xe,((char *)&flare_dvxy + 0x1c));

gte_ldv0(((char *)&Flare_gOct + 0x20));

  gte_rtps();

gte_swc2(0xe,((char *)&flare_dvxy + 0x20));

gte_ldv0(((char *)&Flare_gOct + 0x28));

  gte_rtps();

gte_swc2(0xe,((char *)&flare_dvxy + 0x24));

gte_ldv0(((char *)&Flare_gOct + 0x30));

  gte_rtps();

gte_swc2(0xe,((char *)&flare_dvxy + 0x28));

gte_ldv0(((char *)&Flare_gOct + 0x38));

  gte_rtps();

gte_swc2(0xe,((char *)&flare_dvxy + 0x2c));
  rgb1 = *(long *)&gfrgb;
  rgb2 = *(long *)&gfrgb2;
  cent = *center;
  i = 8;
  while( true ) {
    i = i - 1;
    if (i == -1) break;
    id0 = gfSpikePt0[i];
    id1 = gfSpikePt1[i];
    id2 = gfSpikePt2[i];
    {
      u_char *prim;
      u_int *slot;
      u_int pkt24;
      u_int addr24_0;
      u_char *pal;
      prim = Render_gPacketPtr;
      pal = Render_gPalettePtr;
      slot = (u_int *)(otz * 4 + (int)pal);
      addr24_0 = (u_int)prim & 0xffffff;
      *(u_int *)prim = *(u_int *)prim & 0xff000000 | *slot & 0xffffff;
      pkt24 = *slot & 0xff000000;
      Render_gPacketPtr = prim + 0x24;
      *slot = pkt24 | (addr24_0 & 0xffffff);
      *(u_int *)(prim + 4) = 0x3a000000;
      prim[3] = 8;
      *(long *)(prim + 0xc) = rgb2;
      *(u_int *)(prim + 0x14) = 0;
      *(u_int *)(prim + 0x1c) = 0;
      *(long *)(prim + 8) = flare_dvxy[id0];
      *(long *)(prim + 0x10) = cent;
      *(long *)(prim + 0x18) = flare_dvxy[id2];
      *(long *)(prim + 0x20) = flare_dvxy[id1];
    }
    id0 = gfOctPt1[i];
    id1 = gfOctPt2[i];
    {
      u_char *prim;
      u_int *slot;
      u_int pkt24;
      u_int addr24_1;
      prim = Render_gPacketPtr;
      addr24_1 = (u_int)prim & 0xffffff;
      slot = (u_int *)(otz * 4 + (int)Render_gPalettePtr);
      *(u_int *)prim = *(u_int *)prim & 0xff000000 | *slot & 0xffffff;
      pkt24 = *slot & 0xff000000;
      Render_gPacketPtr = prim + 0x1c;
      *slot = pkt24 | (addr24_1 & 0xffffff);
      *(u_int *)(prim + 4) = 0x32000000;
      prim[3] = 6;
      *(long *)(prim + 0xc) = rgb1;
      *(u_int *)(prim + 0x14) = 0;
      *(long *)(prim + 8) = flare_dvxy[id0];
      *(long *)(prim + 0x10) = cent;
      *(long *)(prim + 0x18) = flare_dvxy[id1];
    }
  }
  return;
}

/* ---- Flare_Spikes__FPli  [FLARE.CPP:323-363] SLD-VERIFIED ---- */
void Flare_Spikes(long *center,int otz)

{
  int i;
  long flare_dvxy [13];

  /* MATCH: SYM locals = flare_dvxy[13] + i(t2) + block-scope prim(a0, POLY_G4*);
   * walkers = givs from gfSpikePt0/1/2[i]; per-iter gfrgb2 reload. */
gte_ldv0(&Flare_gSpikes);
  gte_rtps();
gte_swc2(0xe,&flare_dvxy);
gte_ldv0(((char *)&Flare_gSpikes + 0x8));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x4));
gte_ldv0(((char *)&Flare_gSpikes + 0x10));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x8));
gte_ldv0(((char *)&Flare_gSpikes + 0x18));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0xc));
gte_ldv0(&Flare_gOct);
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x10));
gte_ldv0(((char *)&Flare_gOct + 0x8));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x14));
gte_ldv0(((char *)&Flare_gOct + 0x10));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x18));
gte_ldv0(((char *)&Flare_gOct + 0x18));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x1c));
gte_ldv0(((char *)&Flare_gOct + 0x20));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x20));
gte_ldv0(((char *)&Flare_gOct + 0x28));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x24));
gte_ldv0(((char *)&Flare_gOct + 0x30));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x28));
gte_ldv0(((char *)&Flare_gOct + 0x38));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x2c));
  i = 8;
  while( true ) {
    i = i - 1;
    if (i == -1) break;
    {
      u_char *prim;
      u_int *slot;
      u_char *pal;
      u_int pkt24;
      u_int addr24;
      u_int rgb;

      prim = Render_gPacketPtr;
      addr24 = (u_int)prim & 0xffffff;
      pal = Render_gPalettePtr;
      slot = (u_int *)(otz * 4 + (int)pal);
      *(u_int *)prim = *(u_int *)prim & 0xff000000 | *slot & 0xffffff;
      pkt24 = *slot & 0xff000000;
      Render_gPacketPtr = prim + 0x24;
      *slot = pkt24 | (addr24 & 0xffffff);
      *(u_int *)(prim + 4) = 0x3a000000;
      rgb = *(u_int *)&gfrgb2;
      *(u_int *)(prim + 0x14) = 0;
      *(u_int *)(prim + 0x1c) = 0;
      prim[3] = 8;
      *(u_int *)(prim + 0xc) = rgb;
      *(long *)(prim + 8) = flare_dvxy[gfSpikePt0[i]];
      *(long *)(prim + 0x10) = *center;
      *(long *)(prim + 0x18) = flare_dvxy[gfSpikePt1[i]];
      *(long *)(prim + 0x20) = flare_dvxy[gfSpikePt2[i]];
    }
  }
  return;
}

/* ---- SMALL-FLARE FAMILY residual (w38-a10) -- Flare_OctFlare / Flare_OctFlareSpikes /
 * Flare_Spikes / Flare_HexFlare / Flare_ReflectHexFlare, 20-22 diffs each, ALL COUNT-EXACT.
 * ONE shared mechanism, two visible halves:
 *  (a) the two LICM-hoisted OT-link mask constants are emitted in the opposite ORDER --
 *      oracle `lui 0xFFFFFF` BEFORE `lui 0xFF000000`, ours after (the first body use of
 *      0xFF000000 creates its pseudo first);
 *  (b) consequently the 0xFFFFFF mask and the loop counter `i` swap $t0/$t1 (SYM/oracle:
 *      mask $t0, i $t1) -- an allocno tie broken by pseudo NUMBER, and the mask's pseudo
 *      is created later in ours.
 * LEVERS TRIED (all measured with verify_asm, all rejected):
 *   - one-expression `otz*4 + (int)Render_gPalettePtr` slot address: collapses one
 *     instruction (116 vs oracle 117) -> WORSE (29). These functions genuinely need the
 *     two-statement `pal` then `+ otz*4` chain (unlike Sky_RenderStars/Hrz_TextureQuad).
 *   - `slot = (u_int*)(otz*4); slot = (u_int*)((int)slot + (int)pal);` (accumulate into the
 *     index): 29, also one instruction short.
 *   - `slot = pal; slot = (u_int*)(otz*4 + (int)slot);` (shift-first operand order): 20, no
 *     change -- gcc canonicalizes the addu operands.
 *   - swapping the OR operands of the first RMW statement: 26; of the second: 24;
 *     rewriting the second as `*slot = *slot & 0xff000000 | pkt24`: 30.
 *   - moving `i = 6;` up among the six unrolled gte blocks DOES dial the allocno priority
 *     (20 -> 10 with the init before the 3rd block) but is REFUTED BY THE SYM SLD: the
 *     `addiu $t1,$zero,6` at 0x800CC774 is source line 383, its own statement AFTER all six
 *     gte statements (lines 374-379), i.e. exactly where the recon has it. Not adopted.
 * Classified as the constant-hoist-order / allocno-tie floor (catalog sec.A + the PrimStop
 * 0xffffff/0xff000000 tie family). Prototype re-checked vs raw oracle: (long *center, int otz),
 * void return (no $v0 at the single epilogue).
 * w39-a8 RE-CERTIFICATION with the NOW-WIRED per-TU C++ flags (compile_cpp honours
 * no_split_addresses / no_schedule_insns / no_schedule_insns2 / no_strength_reduce since
 * cb24f4ab, so every earlier "flag didn't help" note on a C++ TU measured a no-op).
 * Whole-TU receipts, flare.cpp, baseline 15 PASS / 458 total diffs:
 *   no_split_addresses  10 PASS / 1387    no_schedule_insns    4 PASS / 2086
 *   no_schedule_insns2   2 PASS /  845    no_strength_reduce  15 PASS /  889
 * ALL FOUR are strictly worse -- flare.obj is a stock -O2 -G4 object.  Floor stands. */
/* ---- Flare_HexFlare__FPli  [FLARE.CPP:370-400] SLD-VERIFIED ---- */
void Flare_HexFlare(long *center,int otz)

{
  int i;
  long flare_dvxy [7];

gte_ldv0(&Flare_gHex);
  gte_rtps();
gte_swc2(0xe,&flare_dvxy);
gte_ldv0(((char *)&Flare_gHex + 0x8));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x4));
gte_ldv0(((char *)&Flare_gHex + 0x10));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x8));
gte_ldv0(((char *)&Flare_gHex + 0x18));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0xc));
gte_ldv0(((char *)&Flare_gHex + 0x20));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x10));
gte_ldv0(((char *)&Flare_gHex + 0x28));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x14));
  /* MATCH: SYM locals = flare_dvxy[7] + i(t1) + block-scope prim(a0) only --
   * walkers = strength-reduction givs from gfHexPt1[i]/gfHexPt2[i] index form;
   * exit-in-the-middle down count keeps top-test + j back-edge. */
  i = 6;
  while( true ) {
    i = i - 1;
    if (i == -1) break;
    {
      u_char *prim;
      u_int *slot;
      u_int pkt24;
      u_int addr24;
      u_int rgb;
      u_char *pal;

      prim = Render_gPacketPtr;
      addr24 = (u_int)prim & 0xffffff;
      pal = Render_gPalettePtr;
      slot = (u_int *)(otz * 4 + (int)pal);
      *(u_int *)prim = *(u_int *)prim & 0xff000000 | *slot & 0xffffff;
      pkt24 = *slot & 0xff000000;
      Render_gPacketPtr = prim + 0x1c;
      *slot = pkt24 | (addr24 & 0xffffff);
      *(u_int *)(prim + 4) = 0x32000000;
      rgb = *(u_int *)&gfrgb;
      *(u_int *)(prim + 0x14) = 0;
      prim[3] = 6;
      *(u_int *)(prim + 0xc) = rgb;
      *(long *)(prim + 8) = flare_dvxy[gfHexPt2[i]];
      *(long *)(prim + 0x10) = *center;
      *(long *)(prim + 0x18) = flare_dvxy[gfHexPt1[i]];
    }
  }
  return;
}

/* ---- Flare_ReflectHexFlare__FPli  [FLARE.CPP:407-437] SLD-VERIFIED ---- */
void Flare_ReflectHexFlare(long *center,int otz)

{
  int i;
  long flare_dvxy [7];

gte_ldv0(&Flare_gReflectHex);
  gte_rtps();
gte_swc2(0xe,&flare_dvxy);
gte_ldv0(((char *)&Flare_gReflectHex + 0x8));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x4));
gte_ldv0(((char *)&Flare_gReflectHex + 0x10));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x8));
gte_ldv0(((char *)&Flare_gReflectHex + 0x18));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0xc));
gte_ldv0(((char *)&Flare_gReflectHex + 0x20));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x10));
gte_ldv0(((char *)&Flare_gReflectHex + 0x28));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x14));
  /* MATCH: SYM locals = flare_dvxy[7] + i(t1) + block-scope prim(a0) only --
   * walkers = strength-reduction givs from gfHexPt1[i]/gfHexPt2[i] index form;
   * exit-in-the-middle down count keeps top-test + j back-edge. */
  i = 6;
  while( true ) {
    i = i - 1;
    if (i == -1) break;
    {
      u_char *prim;
      u_int *slot;
      u_char *pal;
      u_int pkt24;
      u_int addr24;
      u_int rgb;

      prim = Render_gPacketPtr;
      addr24 = (u_int)prim & 0xffffff;
      pal = Render_gPalettePtr;
      slot = (u_int *)(otz * 4 + (int)pal);
      *(u_int *)prim = *(u_int *)prim & 0xff000000 | *slot & 0xffffff;
      pkt24 = *slot & 0xff000000;
      Render_gPacketPtr = prim + 0x1c;
      *slot = pkt24 | (addr24 & 0xffffff);
      *(u_int *)(prim + 4) = 0x32000000;
      rgb = *(u_int *)&gfrgb;
      *(u_int *)(prim + 0x14) = 0;
      prim[3] = 6;
      *(u_int *)(prim + 0xc) = rgb;
      *(long *)(prim + 8) = flare_dvxy[gfHexPt2[i]];
      *(long *)(prim + 0x10) = *center;
      *(long *)(prim + 0x18) = flare_dvxy[gfHexPt1[i]];
    }
  }
  return;
}

/* ---- Flare_QuadFlare__FPli  [FLARE.CPP:443-456] SLD-VERIFIED ---- */
void Flare_QuadFlare(long *center,int otz)

{
  long pt [2];
  long save1;

gte_ldv0(&Flare_gQuad);
  gte_rtps();
gte_swc2(0xe,&save1);
gte_ldv0(((char *)&Flare_gQuad + 0x8));
  gte_rtps();
gte_swc2(0xe,&pt[1]);
  Flare_Tri(center,&save1,&pt[1],otz);
gte_ldv0(((char *)&Flare_gQuad + 0x10));
  gte_rtps();
gte_swc2(0xe,&pt[0]);
  Flare_Tri(center,&pt[1],&pt[0],otz);
gte_ldv0(((char *)&Flare_gQuad + 0x18));
  gte_rtps();
gte_swc2(0xe,&pt[1]);
  Flare_Tri(center,&pt[0],&pt[1],otz);
  Flare_Tri(center,&pt[1],&save1,otz);
  return;
}

/* ---- Flare_CarShapedHalo__FiP7COORD16N21siP15Draw_FlareCache  [FLARE.CPP:591-842] SLD-VERIFIED
 * w13-a3 FULL SYM rule-8 rewrite: every local = a SYM-named var in its SYM block scope,
 * blocks in oracle VA order, align-1 movstrsi struct-assigns kept (gfrgb = color[N], save).
 * SYM reg map: type=s7 ptCenter=t1 pt1=t5 pt2=t6 otz=fp sd=v0(guard only) flag=AUTO short;
 *   angleZ=s6 angleOuter=s5 sizeOuter=s2 scale=s3 flags=s4 ptEdge=a2 result=v0 difx=s0
 *   dify=s1 z=v1 aprim=a0.  Return: SYM FCN VOID (no $v0 setup at any exit).
 * MATCH: scale/flags REUSED (flags = gType index before the field loads; scale = shifted
 * gscale after `scale = gscale << scale`); branch A (reflect) keeps the STALE pre-(flags&1)
 * scale value while branch B reloads gscale into z -- faithful to the original. */
void Flare_CarShapedHalo(int type,COORD16 *ptCenter,COORD16 *pt1,COORD16 *pt2,short flag,int otz,
                  Draw_FlareCache *sd)

{
  VECTOR diff;                  /* @sp+0x18 */
  long angleZ;                  /* s6 */
  long angleOuter;              /* s5 */
  long sizeOuter;               /* s2 */
  CVECTOR color [2];            /* @sp+0x28 */
  DVECTOR sp;                   /* @sp+0x30 */
  int scale;                    /* s3 */
  int flags;                    /* s4 */
  COORD16 *ptEdge;              /* a2 */
  COORD16 vec1;                 /* @sp+0x38 */
  COORD16 vec2;                 /* @sp+0x40 */
  COORD16 crossprod;            /* @sp+0x48 */

  if (sd->head.cprim.PrimPtr < sd->head.cprim.MPrimPtr + -0x400) {
    vec1.x = pt1->x - ptCenter->x;
    vec1.y = pt1->y - ptCenter->y;
    vec1.z = pt1->z - ptCenter->z;
    vec2.x = pt2->x - ptCenter->x;
    vec2.y = pt2->y - ptCenter->y;
    vec2.z = pt2->z - ptCenter->z;
    crossprod.x = vec2.y * vec1.z - vec2.z * vec1.y;
    crossprod.y = vec2.z * vec1.x - vec2.x * vec1.z;
    crossprod.z = vec2.x * vec1.y - vec2.y * vec1.x;
    ptEdge = pt1;
    if (-1 < (int)((u_int)flag << 0x10)) {
      ptEdge = pt2;
    }
    {
      int i;                    /* gType index temp (a0; anonymous -- no SYM record) */
      u_long c;                 /* serial copy temp (v0; anti-dependence keeps the two
                                   color word-copies lw/nop/sw serial like the oracle) */
      /* MATCH (w42-a6): ONE `type & 0x7f` computed into `i` first, then the +1/+0xb per
       * arm.  Writing the mask in BOTH arms costs `type` one extra REG_N_REFS (6 vs 5)
       * even though cse merges the two andi's into one insn -- and 6 refs put `type`'s
       * allocno_compare priority (2*6/400 = .0300) just ABOVE angleZ's (1*3/107 = .0280),
       * which is the whole $s6<->$s7 rotation.  With 5 refs (2*5/400 = .0250) angleZ wins
       * $s6 and `type` takes $s7 exactly as the SYM says.  45 -> 25. */
      int j = type & 0x7fU;   /* MATCH: SEPARATE temp for the masked value -- oracle keeps
                               * it in $v1 and both arms do `addiu a0,v1,K`; reusing `i`
                               * in place emits `andi a0,..;addiu a0,a0,K` (25 -> 19). */
      if (R3DCar_InMenu != 0) {
        i = j + 1;
      }
      else {
        i = j + 0xb;
      }
      if ((type & 0x100U) != 0) {
        ptCenter->y = -DrawC_gReflectOffset - ptCenter->y;
      }
gte_ldv0(ptCenter);
      gte_rtps();
      c = Flare_gType[i].chalo;
      *(u_long *)&color[0] = c;
      c = Flare_gType[i].cbeam;
      *(u_long *)&color[1] = c;
      /* MATCH (w45-a9 SEAL 3 -> PASS 630/630): sched2 was hoisting `lw s3,8(v1)` (the
       * `scale` field load) up into the LOAD-DELAY slot of `lw v0,0(v1)`, where retail
       * leaves a `nop` and issues the scale/flags pair adjacently AFTER the `andi
       * v0,s7,128`.  s3's use is far down the block, so its scheduler priority (longest
       * path to block end) is the highest in the ready list and it always wins that slot.
       * The zero-insn USE fence (§2b.5) is a sched fixpoint: the two gType field loads
       * that follow it in source order can no longer migrate above it.  Emits nothing;
       * the andi still hoists above them (it is after the fence too), = retail. */
      __asm__ volatile("" : : "r"(c));
      scale = Flare_gType[i].scale;
      flags = Flare_gType[i].flags;
    }
    if ((type & 0x80U) != 0) {
      color[0].r = color[0].r >> 1;
      color[0].g = color[0].g >> 1;
      color[0].b = color[0].b >> 1;
      color[1].r = color[1].r >> 1;
      color[1].g = color[1].g >> 1;
      color[1].b = color[1].b >> 1;
    }
gte_stlvnl(&diff);
    if ((diff.vx <= diff.vz) && (-diff.vx <= diff.vz) && (!(diff.vz < 0x80))) {
gte_stsxy(&sp);
      angleZ = 0;
      if ((flags & 8U) != 0) {
        long result;
        result = sp.vx + sp.vy;
        angleZ = result * 4;
      }
      if ((flags & 4U) != 0) {
        VECTOR diff2;           /* @sp+0x50 */
        DVECTOR sp2;            /* @sp+0x60 */
        long difx;              /* s0 */
        long dify;              /* s1 */
gte_ldv0(ptEdge);
        gte_rtps();
gte_stlvnl(&diff2);
gte_stsxy(&sp2);
        dify = sp2.vy - sp.vy;
        difx = sp2.vx - sp.vx;
        angleOuter = fixedatan(dify,difx) >> 4;
        sizeOuter = isqrt(difx * difx + dify * dify) * diff.vz;
      }
      else {
        /* else-LOCAL zero-init: reorg hoists `angleOuter = 0` into the beqz
         * delay slot (harmless on the taken path), and same-BB cse turns
         * `sizeOuter = angleOuter` into the oracle's addu s2,s5,zero copy. */
        angleOuter = 0;
        sizeOuter = angleOuter;
      }
      gfrgb = color[0];
      gfrgb2 = color[1];
      if (-1 < (int)((u_int)(u_short)flag << 0x10)) {
        gscale = (vec1.x * vec1.x + vec1.y * vec1.y + vec1.z * vec1.z) >> 1;
      }
      else {
        gscale = (vec2.x * vec2.x + vec2.y * vec2.y + vec2.z * vec2.z) >> 1;
      }
      /* MATCH: gscale is the SHIFT DESTINATION and `scale` re-reads it (not
         `scale = gscale<<scale; gscale = scale;`) -- the re-read is the second
         evaluation cse turns into the oracle's `sllv v0,v0,s3 ; addu s3,v0,zero`
         copy; the scale-first form coalesces it into an in-place `sllv s3,v0,s3`. */
      gscale = gscale << scale;
      scale = gscale;
      if ((flags & 1U) != 0) {
        VECTOR tvec1;           /* @sp+0x50 */
        VECTOR tvec2;           /* @sp+0x68 */
        long result;            /* v1 (the -600 clamp temp) */
        gte_ldtr0();
gte_ldv0(&crossprod);
        gte_rtps();
gte_stlvnl(&tvec1);
        VectorNormal((VECTOR *)&tvec1,(VECTOR *)&tvec2);
        if ((flags & 2U) != 0) {
          tvec2.vz = (tvec2.vz + -0xf33) * 0x14;
        }
        result = tvec2.vz + -0x258;
        if (result < 0) {
          result = 0;
        }
        tvec2.vz = result;
        gscale = gscale * result >> 0xb;
      }
      if ((type & 0x100U) != 0) {
        CVECTOR save;           /* @sp+0x50 */
        MATRIX scalemat;        /* @sp+0x78 */
        MATRIX mtx;             /* @sp+0x98 */
        save = gfrgb;
        *(int *)&scalemat.m[0][0] = scale + (sizeOuter >> 7);
        *(int *)&scalemat.m[1][1] = scale + (sizeOuter >> 7);
        *(int *)&scalemat.m[2][2] = 0;
        *(int *)&scalemat.m[0][2] = 0;
        *(int *)&scalemat.m[2][0] = 0;
        gfrgb.r = gfrgb.r >> 1;
        gfrgb.g = gfrgb.g >> 1;
        gfrgb.b = gfrgb.b >> 1;
        Flare_IdentMatrix(&mtx);
gte_SetTransVector(&diff);
        RotMatrixZ(0x800,&mtx);
gte_SetRotMatrix(&mtx);
gte_ldclmv(&scalemat);
        gte_rtir();
gte_stclmv(&mtx);
gte_ldclmv(((char *)&scalemat + 0x2));
        gte_rtir();
gte_stclmv(((char *)&mtx + 0x2));
gte_ldclmv(((char *)&scalemat + 0x4));
        gte_rtir();
gte_stclmv(((char *)&mtx + 0x4));
gte_SetRotMatrix(&mtx);
        Flare_ReflectHexFlare((long *)&sp,otz);
        gfrgb = save;
      }
      else {
        MATRIX mtx;             /* @sp+0x50 */
        MATRIX mtx2;            /* @sp+0x70 */
        MATRIX scalemat;        /* @sp+0x90 */
        int z;                  /* v1 */
        z = gscale;
        *(int *)&scalemat.m[2][2] = 0;
        *(int *)&scalemat.m[0][2] = 0;
        *(int *)&scalemat.m[2][0] = 0;
        *(int *)&scalemat.m[0][0] = z + (sizeOuter >> 5);
        *(int *)&scalemat.m[1][1] = z;
        Flare_IdentMatrix(&mtx);
        Flare_IdentMatrix(&mtx2);
gte_SetTransVector(&diff);
        RotMatrixZ(angleZ,&mtx);
        RotMatrixZ(angleOuter,&mtx2);
gte_SetRotMatrix(&mtx2);
gte_ldclmv(&scalemat);
        gte_rtir();
gte_stclmv(&scalemat);
gte_ldclmv(((char *)&scalemat + 0x2));
        gte_rtir();
gte_stclmv(((char *)&scalemat + 0x2));
gte_ldclmv(((char *)&scalemat + 0x4));
        gte_rtir();
gte_stclmv(((char *)&scalemat + 0x4));
gte_SetRotMatrix(&scalemat);
gte_ldclmv(&mtx);
        gte_rtir();
gte_stclmv(&mtx);
gte_ldclmv(((char *)&mtx + 0x2));
        gte_rtir();
gte_stclmv(((char *)&mtx + 0x2));
gte_ldclmv(((char *)&mtx + 0x4));
        gte_rtir();
gte_stclmv(((char *)&mtx + 0x4));
gte_SetRotMatrix(&mtx);
        if (diff.vz < 0xc80) {
          Flare_OctFlareSpikes((long *)&sp,otz);
        }
        else if (diff.vz < 0x1b80) {
          Flare_HexFlare((long *)&sp,otz);
          Flare_PreCalcHexLightBeam((long *)&sp,otz);
        }
        else {
          Flare_QuadFlare((long *)&sp,otz);
        }
      }
      {
        DR_MODE *aprim;         /* a0 */
        u_int *slot;            /* a2 (anonymous -- no SYM record) */
        u_int pkt24;
        u_int addr24_0;
        aprim = (DR_MODE *)Render_gPacketPtr;
        addr24_0 = (u_int)aprim & 0xffffff;
        slot = (u_int *)(otz * 4 + (int)Render_gPalettePtr);
        *(u_int *)aprim = *(u_int *)aprim & 0xff000000 | *slot & 0xffffff;
        pkt24 = *slot & 0xff000000;
        Render_gPacketPtr = (u_char *)aprim + 0xc;
        *slot = pkt24 | (addr24_0 & 0xffffff);
        {
          /* MATCH: the AND must land in its OWN variable -- gcc-2.8's fold()
             rewrites `(flags & 0x40) != 0` (any spelling: Yoda, >0, !!, explicit
             shift) into `(flags >> 6) & 1`; only a VAR_DECL operand keeps the
             oracle's `andi a2,s4,0x40 ; sltu a2,zero,a2`. */
          u_int dtd = flags & 0x40U;
          SetDrawMode(aprim,0,(u_int)(dtd != 0),0x120,(RECT *)0x0);
        }
      }
    }
  }
  return;
}

/* PsyQ gte_stszotz (SZ3>>2 depth-sort key) -- oracle Halo2 @0x800CD6E4:
 * mfc2 $12,$19; nop; sra $12,2; sw.  Promoted to psx_gte.h (w40 consolidation). */

/* ---- Flare_Halo2__FP13DRender_tViewiiP8coorddefT3P15Draw_FlareCache  [FLARE.CPP:845-1094] SLD-VERIFIED
 * w13-a3 FULL SYM rule-8 rewrite (see CarShapedHalo notes; same recipe).
 * SYM reg map: Vi=a0 scale=s0 type=s2 fpt=a3 fpt2=a2(from stack) flare_type=s1
 *   flags=s3 angleZ=s5 angleOuter=s2(reuses type) sizeOuter=t0 z=s4 otz=AUTO@0xC0
 *   t=v0 tx=t1 ty=a0 tz=t0 dx=v1 dy=a1 dz=a3 r=a0 result=v0 difx=s0 dify=s1 aprim=a0.
 * &diff CSE'd into s6 by gcc (2 cross-call uses). Return: SYM FCN VOID.
 * sd param unused (not in SYM, present in the mangling). */
void Flare_Halo2(DRender_tView *Vi,int scale,int type,coorddef *fpt,coorddef *fpt2,
              Draw_FlareCache *sd)

{
  VECTOR diff;                  /* @sp+0x18 */
  SVECTOR sdiff;                /* @sp+0x28 */
  SVECTOR sdiff2;               /* @sp+0x30 */
  long angleZ;                  /* s5 */
  long angleOuter;              /* s2 */
  long sizeOuter;               /* t0 */
  CVECTOR color [2];            /* @sp+0x38 */
  DVECTOR sp;                   /* @sp+0x40 */
  int flare_type;               /* s1 */
  int flags;                    /* s3 */
  int otz;                      /* AUTO @sp+0xC0 (address taken -> late slot) */
  int z;                        /* s4 */
  VECTOR diff2;                 /* @sp+0x48 */
  DVECTOR sp2;                  /* @sp+0x58 */

  flare_type = type & 0xff;
  flags = Flare_gType[flare_type].flags;
  angleZ = 0;
  if (fpt2 == (coorddef *)0x0) {
    flags = flags & -6;
  }
  {
    coorddef *t;                /* v0 */
    int tx;                     /* t1 */
    int ty;                     /* a0 */
    int tz;                     /* t0 */
    int dx;                     /* v1 */
    int dy;                     /* a1 */
    int dz;                     /* a3 */
    t = (coorddef *)&Vi->cview;
    tx = t->x;
    ty = t->y;
    tz = t->z;
    dx = fpt->x;
    dy = fpt->y;
    dz = fpt->z;
    dx = dx - tx;
    dy = dy - ty;
    dz = dz - tz;
    sdiff.vx = (short)(dx >> 10);
    sdiff.vy = (short)(dy >> 10);
    sdiff.vz = (short)(dz >> 10);
    if ((flags & 5U) != 0) {
      dx = fpt2->x;
      dy = fpt2->y;
      dz = fpt2->z;
      dx = dx - tx;
      dy = dy - ty;
      dz = dz - tz;
      sdiff2.vx = (short)(dx >> 10);
      sdiff2.vy = (short)(dy >> 10);
      sdiff2.vz = (short)(dz >> 10);
    }
  }
  if ((flags & 0x10U) != 0) {
    if (((simGlobal.gameTicks >> 6) & 1U) != 0) {
      return;
    }
  }
  else if ((flags & 0x20U) != 0) {
    if (((simGlobal.gameTicks + 0x1b >> 5) & 1U) != 0) {
      return;
    }
  }
  Flare_SetMatrix(&gWorldMat);
gte_ldv0(&sdiff);
  gte_rtps();
  {
    u_long c;                   /* serial copy temp (v0) -- see CarShapedHalo */
    c = Flare_gType[flare_type].chalo;
    *(u_long *)&color[0] = c;
    c = Flare_gType[flare_type].cbeam;
    *(u_long *)&color[1] = c;
  }
  if (scale == -1) {
    scale = Flare_gType[flare_type].scale;
  }
gte_stlvnl(&diff);
  if ((diff.vx <= diff.vz) && (-diff.vx <= diff.vz) && (!(diff.vz < 0x80))) {
gte_stsxy(&sp);
gte_stszotz(&otz);
    otz = otz >> 1;
    if (otz < 0) {
      return;
    }
    if (Draw_gViewOtSize + -3 < otz) {
      return;
    }
    if ((flags & 0x80U) != 0) {
      int r;                    /* a0 */
      r = (u_int)random() % 0x14;
      scale = scale + r * 4;
      color[0].r = color[0].r + r;
      color[0].g = color[0].g + r;
      color[0].b = color[0].b + r;
      color[1].r = color[1].r + r;
      color[1].g = color[1].g + r;
      color[1].b = color[1].b + r;
    }
    if ((flags & 8U) != 0) {
      long result;              /* v0 */
      result = sp.vx + sp.vy;
      angleZ = result * 4;
    }
    gfrgb = color[0];
    gfrgb2 = color[1];
    gscale = scale;
    if ((flags & 0x40U) != 0) {
      DR_MODE *aprim;           /* a0 */
      u_int *slot;              /* t0 */
      u_int pkt24;
      u_int addr24_0;
      aprim = (DR_MODE *)Render_gPacketPtr;
      addr24_0 = (u_int)aprim & 0xffffff;
      slot = (u_int *)(otz * 4 + (int)Render_gPalettePtr);
      *(u_int *)aprim = *(u_int *)aprim & 0xff000000 | *slot & 0xffffff;
      pkt24 = *slot & 0xff000000;
      Render_gPacketPtr = (u_char *)aprim + 0xc;
      *slot = pkt24 | (addr24_0 & 0xffffff);
      SetDrawMode(aprim,0,0,0x120,(RECT *)0x0);
    }
    z = diff.vz;
    if ((flags & 5U) != 0) {
gte_ldv0(&sdiff2);
      gte_rtps();
gte_stlvnl(&diff2);
gte_stsxy(&sp2);
    }
    if ((flags & 4U) != 0) {
      {
        long difx;              /* s0 (reuses scale) */
        long dify;              /* s1 (reuses flare_type) */
        dify = sp2.vy - sp.vy;
        difx = sp2.vx - sp.vx;
        angleOuter = fixedatan(dify,difx) >> 4;
        sizeOuter = isqrt(difx * difx + dify * dify) * diff.vz;
      }
      {
        MATRIX mtx;             /* @sp+0x60 */
        MATRIX mtx2;            /* @sp+0x80 */
        MATRIX scalemat;        /* @sp+0xA0 */
        *(int *)&scalemat.m[2][2] = 0;
        *(int *)&scalemat.m[0][2] = 0;
        *(int *)&scalemat.m[2][0] = 0;
        *(int *)&scalemat.m[1][1] = gscale;
        *(int *)&scalemat.m[0][0] = gscale + (sizeOuter >> 4);
        Flare_IdentMatrix(&mtx);
        Flare_IdentMatrix(&mtx2);
gte_SetTransVector(&diff);
        RotMatrixZ(angleZ,&mtx);
        RotMatrixZ(angleOuter,&mtx2);
gte_SetRotMatrix(&mtx2);
gte_ldclmv(&scalemat);
        gte_rtir();
gte_stclmv(&scalemat);
gte_ldclmv(((char *)&scalemat + 0x2));
        gte_rtir();
gte_stclmv(((char *)&scalemat + 0x2));
gte_ldclmv(((char *)&scalemat + 0x4));
        gte_rtir();
gte_stclmv(((char *)&scalemat + 0x4));
gte_SetRotMatrix(&scalemat);
gte_ldclmv(&mtx);
        gte_rtir();
gte_stclmv(&mtx);
gte_ldclmv(((char *)&mtx + 0x2));
        gte_rtir();
gte_stclmv(((char *)&mtx + 0x2));
gte_ldclmv(((char *)&mtx + 0x4));
        gte_rtir();
gte_stclmv(((char *)&mtx + 0x4));
gte_SetRotMatrix(&mtx);
      }
    }
    else {
      if ((flags & 1U) != 0) {
        VECTOR tvec;            /* @sp+0x60 */
        VECTOR tvec2;           /* @sp+0x70 */
        long result;            /* v1 (the -600 clamp temp) */
        tvec.vx = diff.vx - diff2.vx;
        tvec.vy = diff.vy - diff2.vy;
        tvec.vz = diff.vz - diff2.vz;
        VectorNormal((VECTOR *)&tvec,(VECTOR *)&tvec2);
        if ((flags & 2U) != 0) {
          tvec2.vz = (tvec2.vz + -0xf33) * 0x14;
        }
        result = tvec2.vz + -0x258;
        if (result < 0) {
          result = 0;
        }
        tvec2.vz = result;
        if (result == 0) {
          return;
        }
        gscale = gscale * result >> 0xb;
        if (type == 0x1e) {
          z = z / 4;
        }
      }
      {
        MATRIX mtx;             /* @sp+0x60 */
        MATRIX scalemat;        /* @sp+0x80 */
        *(int *)&scalemat.m[2][2] = 0;
        *(int *)&scalemat.m[0][2] = 0;
        *(int *)&scalemat.m[2][0] = 0;
        *(int *)&scalemat.m[0][0] = gscale;
        *(int *)&scalemat.m[1][1] = gscale;
        Flare_IdentMatrix(&mtx);
gte_SetTransVector(&diff);
        RotMatrixZ(angleZ,&mtx);
gte_SetRotMatrix(&mtx);
gte_ldclmv(&scalemat);
        gte_rtir();
gte_stclmv(&mtx);
gte_ldclmv(((char *)&scalemat + 0x2));
        gte_rtir();
gte_stclmv(((char *)&mtx + 0x2));
gte_ldclmv(((char *)&scalemat + 0x4));
        gte_rtir();
gte_stclmv(((char *)&mtx + 0x4));
gte_SetRotMatrix(&mtx);
      }
    }
    if (z < 0xc80) {
      Flare_OctFlareSpikes((long *)&sp,otz);
    }
    else if (z < 0x1b80) {
      Flare_HexFlare((long *)&sp,otz);
      Flare_PreCalcHexLightBeam((long *)&sp,otz);
    }
    else {
      Flare_QuadFlare((long *)&sp,otz);
    }
    {
      DR_MODE *aprim;           /* a0 */
      u_int *slot;              /* t0 */
      u_int pkt24;
      u_int addr24_1;
      aprim = (DR_MODE *)Render_gPacketPtr;
      addr24_1 = (u_int)aprim & 0xffffff;
      slot = (u_int *)(otz * 4 + (int)Render_gPalettePtr);
      *(u_int *)aprim = *(u_int *)aprim & 0xff000000 | *slot & 0xffffff;
      pkt24 = *slot & 0xff000000;
      Render_gPacketPtr = (u_char *)aprim + 0xc;
      *slot = pkt24 | (addr24_1 & 0xffffff);
      {
        /* MATCH: see Flare_CarShapedHalo -- the AND needs its own VAR_DECL to
           stop gcc's fold() turning the test into `(flags >> 6) & 1`. */
        u_int dtd = flags & 0x40U;
        SetDrawMode(aprim,0,(u_int)(dtd != 0),0x120,(RECT *)0x0);
      }
    }
  }
  return;
}

/* ---- Flare_Halo__FP13DRender_tViewiiP8coorddefP15Draw_FlareCache  [FLARE.CPP:1097-1098] SLD-VERIFIED ---- */
void Flare_Halo(DRender_tView *Vi,int scale,int type,coorddef *fpt,Draw_FlareCache *sd)

{
  Flare_Halo2(Vi,scale,type,fpt,(coorddef *)0x0,sd);
  return;
}

/* ---- Flare_2DSpike__FPlT0i  [FLARE.CPP:1105-1120] SLD-VERIFIED ----
 * NEAR-MISS 2 diffs (43/43, down from 7): MATCH: split-temp `rgb = gfrgb2word` read BEFORE the
 * packet-bump store, consumed after (store must sink below the bump: may-alias order is
 * preserved, so only a load/store SPLIT spans it). SYM has no rgb local (compiler-temp stand-in).
 * Residual 2 = position of the `lw v1,0(gp)` across the bump addiu/sw pair -- a list-scheduler
 * ready-tie (ours schedules the bump first); not source-reachable, permuter class. */
/* ---- Flare_2DSpike__FPlT0i -- w41-a8 FLOOR (2 diffs, count exact 43/43) ----
 * The ONLY residual is the sched1 ISSUE POSITION of `rgb = *(u_int *)&gfrgb2;`
 * (`lw v1,0(gp)`): the oracle issues it BEFORE the packet-cursor bump
 * (`addiu v0,a0,20 ; sw v0,0(t0)`), ours after.  Source position is IRRELEVANT here --
 * measured 3 spellings: statement moved one earlier (before the OT-slot store) = 4 diffs,
 * moved one later (after the bump) = 2, and `*(volatile u_int *)&gfrgb2` = 2.  A sched1
 * ready-list tie, not source-reachable.  (STRONG per the floor bar: prototype is void/void
 * per SYM, count exact, 3 alternate forms measured, named mechanism.)
 * ---- w45-a9: THE "NOT SOURCE-REACHABLE" VERDICT IS REFUTED -- PASS 43/43. ----
 * The floor above was correct about the MECHANISM (a sched1 issue-position tie) and wrong
 * about reachability: the ZERO-INSN USE FENCE (§2b.5) pins the issue position directly.
 * `__asm__ volatile("" : : "r"(rgb));` immediately after the read is a scheduling fixpoint,
 * so the `lw v1,0(gp)` must issue BEFORE it while the packet-cursor bump (which follows the
 * fence in source order) must issue AFTER -- exactly retail's 26/27/28.  Emits nothing.
 * GENERALIZATION: any "the oracle issues load X one slot earlier than sched1 does" residual
 * where source POSITION has already been swept is a USE-FENCE target, not a floor.  The
 * PTag-bitfield spellings were also measured here (§2b.1): value-side bitfield READ = 6,
 * plain word READ = 6 (both re-color the bump to $v1) -- this fn wants the hand-masked OR. */
void Flare_2DSpike(long *center,long *end,int otz)

{
  long saved [2];
  u_char *prim;
  u_int rgb;

  saved[0] = *center;
  saved[1] = *end;
  otz = otz * 4 + (int)Render_gPalettePtr;
  prim = Render_gPacketPtr;
  *(u_int *)prim = *(u_int *)prim & 0xff000000 | *(u_int *)otz & 0xffffff;
  *(u_int *)otz = *(u_int *)otz & 0xff000000 | (u_int)prim & 0xffffff;
  rgb = *(u_int *)&gfrgb2;
  __asm__ volatile("" : : "r"(rgb));
  Render_gPacketPtr = prim + 0x14;
  prim[3] = 4;
  *(u_int *)(prim + 0xc) = 0;
  *(u_int *)(prim + 4) = rgb;
  prim[7] = 0x52;
  *(long *)(prim + 8) = saved[0];
  *(long *)(prim + 0x10) = saved[1];
  return;
}

/* ---- Flare_2DHalo__Fiiiii  [FLARE.CPP:1125-1211] SLD-VERIFIED ---- */
void Flare_2DHalo(int x,int y,int scalex,int scaley,int type)

{
  /* MATCH: SYM rule-8 shape (block 0x800cdf70): pt(s3)=&pt2, otz(s4)=0 (cse zero
   * source for the first SetDrawMode's 0,0 args + a3 of all 16 Tri/Spike calls),
   * sd(t0)=scratchpad cache base — guard reads sd->head.cprim.{PrimPtr,MPrimPtr}
   * as displacements off the shared lui 0x1F80 base; no ts9/ts10 short temps
   * (x/y live in s5/s6); gfrgb = word copy (CVECTOR struct-assign emits align-1
   * movstrsi lwl/lwr — oracle has plain lw/sw 0(gp)); loop = index form arr[i]
   * (walkers are compiler givs, SYM has only i) with plain /0x10000 signed
   * division (bgez/addu 0xFFFF/sra guards regenerate; 0xFFFF hoists to a2 by
   * loop.c); packet allocs per the proven TU idiom: aprim = PacketPtr FIRST,
   * two-set slot (+ otz*4 in the tail block only).
   * ---- w45-a9 RECEIPT BAR: 12 -> 6 (count-exact 247/247).  TWO landed levers:
   *   (1) the serial `c` copy temp for the two Flare_gType color word-copies (ONE REUSED
   *       temp; two temps = 10, direct-second-store = 10 -- both re-measured in the
   *       post-fence basin, so these are STRONG falsifications, not stale notes);
   *   (2) the dual-param USE fence (see the fence's own comment) -- fixed the s1 REGPARM
   *       copy sinking into the guard branch's delay slot.
   * TWO RESIDUALS LEFT, 2 diffs each:
   *   (A) `sw s3,92(sp)` issues at ours[12] vs retail[9] (retail's prologue save order is
   *       s5,s6,s0,s1,s3,ra,s4,s2; ours s5,s6,s0,s1,ra,s4,s3,s2 around the `lui t0`).
   *       MEASURED NEGATIVE at THIS baseline: moving the `sd =` assignment below the pt2
   *       stores (6, no move); swapping the `pt`/`pt2` declaration order (6, no move).
   *       NEW NAMED ANGLE: s3 is `pt`, defined ONLY in the fall-through block (`addiu
   *       s3,sp,24` -- the very insn retail puts in the delay slot).  Its save placement
   *       is the same reorg/thread interaction the fence just fixed for s1, so give `pt`
   *       an ENTRY-BLOCK birth (`pt = &pt2;` hoisted above the guard) and name `pt` as a
   *       third fence operand.  Exact analogue of the s1 fix; untried.
   *   (B) the SECOND color copy lands in $v1 (ours) where retail reuses the now-dead
   *       gType base register $v0 (`lw v0,4(v0)`).  ONE `c` pseudo spans the base's death
   *       so $v0 is unavailable to it; two pseudos would allow it but cost the serial
   *       schedule (10).  NEW NAMED ANGLE: keep ONE `c` but kill the BASE instead -- take
   *       the element address into a pointer local and re-assign it for the second read
   *       (`p = &Flare_gType[flare_type]; c = p->chalo; ...; p = p; c = p->cbeam;` /
   *       `*(u_long *)((char *)p + 4)`), so the base pseudo dies at the second load and
   *       local-alloc can hand $v0 to the reborn range (dead-base-reuse, catalog §F row
   *       115).  Or re-run the two-temp spelling AFTER (A) lands (lever-order
   *       dependence, §2b.4 -- (1) and (2) already proved order-dependence here).
   * ---- w46-a8: BOTH w45 ANGLES EXECUTED AND FALSIFIED (6 stays, count-exact 247/247).
   *   (A) `pt` ENTRY-BLOCK BIRTH: hoisting `pt = &pt2;` above the guard measures 8 with the
   *       fence unchanged AND 8 with `pt` added as a third fence operand -- the hoist itself
   *       costs 2 diffs, so the s1-fix analogue does NOT transfer to s3.  The `sw s3,92(sp)`
   *       save position is unmoved in both.
   *   (B) KILL-THE-BASE: all three pointer-local spellings for the second gType colour read
   *       are much worse -- `p = &Flare_gType[ft]; c = p->chalo; p = p; c = *(u_long*)((char*)p+4);`
   *       20, `p = (Flare_tInfo*)((char*)p+4); c = *(u_long*)p;` 22, plain `c = p->cbeam;` 20.
   *       Combining (A)+(B) is worse still (22/24).  The single-`c`-pseudo-spans-the-base
   *       diagnosis stands; the cure does not.
   *   Also measured NEUTRAL here (the w46 Font_SwitchFont seal lever): a MEM_IN_STRUCT_P
   *   struct view on the gfrgb / gfrgb2 word stores -- 6 in all three combinations.
   *   NEW NAMED ANGLE: residual (A) is a sched2 STORE-PLACEMENT drain (a prologue `sw` that
   *   retail issues 3 slots earlier), i.e. exactly the class the trackspec.cpp SetDefault
   *   seal cracked with a fence WALK.  The existing dual-param fence is a fixpoint AFTER the
   *   pt2 stores; walk a SECOND zero-insn fence through the entry block one statement at a
   *   time (before `sd =`, between the two pt2 stores, after the guard) -- position is the
   *   dial and this fn has never had more than one fence position tested.
   *   ---- w49-a4: THE SECOND-FENCE WALK IS NOW RUN (three positions, all count-exact
   *   247/247): before `sd =` 8 (worse) . between the two pt2 stores 6 (no move) .
   *   after `sd =` / before the pt2 stores 6 (no move).  So a second zero-insn fence does
   *   NOT move the `sw s3,92(sp)` prologue save -- residual (A) survives the w46 note's
   *   own recommendation.  Both residuals unchanged; the untried instrument is still the
   *   -dl/-dg qty table for this entry block.
   *   ---- w50-A3: FOUR MORE FALSIFICATIONS, all count-exact 247/247 unless noted.
   *   Residual (B), the colour-copy register: two temps 10 . two temps + a USE fence
   *   between them 20 . one temp + a USE fence between the two copies 20.  (The w45
   *   "two temps = 10" receipt therefore REPRODUCES in this basin -- it is not stale --
   *   and adding a fence makes it strictly worse, so the serial-schedule/register trade
   *   is real and the ONE-temp form stays.)
   *   Residual (A), the `sw s3,92(sp)` save: naming x and y as extra operands of the
   *   existing dual-param fence 6 (no move) . a USE fence on `sd` right after its
   *   assignment 6 (no move) . a USE fence on `sd` as the FIRST statement inside the
   *   guard 7 @248 (costs an insn) . hoisting `pt = &pt2;` above the guard AND naming
   *   `pt` in the entry fence 8.  ⇒ every entry-block fence position and operand set has
   *   now been swept; the save's position is not fence-reachable.  The -dl/-dg qty table
   *   remains the only untried instrument, exactly as the w49 note says. */
  DVECTOR pt2;
  DVECTOR *pt;
  int otz;
  Draw_FlareCache *sd;

  sd = (Draw_FlareCache *)&Render_gPalettePtr;
  pt2.vx = (short)x;
  pt2.vy = (short)y;
  /* MATCH (w45-a9, 8 -> 6): retail copies ALL FOUR REGPARMs into their callee-saved
   * homes in the prologue (`addu s1,a3,zero` @8) and fills the guard branch's delay slot
   * from the FALL-THROUGH thread (`addiu s3,sp,24`).  scaley/scalex are first used only
   * inside the loop, so reorg sank the s1 copy into that delay slot instead.  A zero-insn
   * USE fence naming BOTH scale params (§2b.5) gives them an entry-block use, so the
   * copies stay put and the slot is filled from the thread = retail.  ⚠️ fencing ONLY
   * scaley (or fencing at the very top of the fn) instead ROTATES s0/s1 (22 diffs) --
   * both params must be named, and after the pt2 stores. */
  __asm__ volatile("" : : "r"(scalex), "r"(scaley));
  if (sd->head.cprim.PrimPtr < sd->head.cprim.MPrimPtr + -0x1000) {
    int flare_type;
    u_long c;

    pt = &pt2;
    otz = 0;
    flare_type = type & 0xffU;
    c = Flare_gType[flare_type].chalo;
    *(u_long *)&gfrgb = c;
    c = Flare_gType[flare_type].cbeam;
    *(u_long *)&gfrgb2 = c;
    {
      DR_MODE *aprim;
      u_int *slot;
      u_int pkt24;
      u_int addr24_0;
      aprim = (DR_MODE *)Render_gPacketPtr;
      addr24_0 = (u_int)aprim & 0xffffff;
      slot = (u_int *)Render_gPalettePtr;
      *(u_int *)aprim = *(u_int *)aprim & 0xff000000 | *slot & 0xffffff;
      pkt24 = *slot & 0xff000000;
      Render_gPacketPtr = (u_char *)aprim + 0xc;
      *slot = pkt24 | (addr24_0 & 0xffffff);
      SetDrawMode(aprim,0,0,0x120,(RECT *)0x0);
    }
    {
      DVECTOR npt [2];
      DVECTOR save1;
      DVECTOR octring [8];
      int i;

      for (i = 0; i < 8; i++) {
        octring[i].vx = (short)(Flare_gOct[i].vx * scalex / 0x10000);
        octring[i].vy = (short)(Flare_gOct[i].vy * scaley / 0x10000);
      }
      save1.vx = octring[0].vx + x;
      save1.vy = octring[0].vy + y;
      npt[1].vx = octring[1].vx + x;
      npt[1].vy = octring[1].vy + y;
      Flare_Tri((long *)pt,(long *)&save1,(long *)&npt[1],otz);
      Flare_2DSpike((long *)pt,(long *)&npt[1],otz);
      npt[0].vx = octring[2].vx + x;
      npt[0].vy = octring[2].vy + y;
      Flare_Tri((long *)pt,(long *)&npt[1],(long *)npt,otz);
      Flare_2DSpike((long *)pt,(long *)npt,otz);
      npt[1].vx = octring[3].vx + x;
      npt[1].vy = octring[3].vy + y;
      Flare_Tri((long *)pt,(long *)npt,(long *)&npt[1],otz);
      Flare_2DSpike((long *)pt,(long *)&npt[1],otz);
      npt[0].vx = octring[4].vx + x;
      npt[0].vy = octring[4].vy + y;
      Flare_Tri((long *)pt,(long *)&npt[1],(long *)npt,otz);
      Flare_2DSpike((long *)pt,(long *)npt,otz);
      npt[1].vx = octring[5].vx + x;
      npt[1].vy = octring[5].vy + y;
      Flare_Tri((long *)pt,(long *)npt,(long *)&npt[1],otz);
      Flare_2DSpike((long *)pt,(long *)&npt[1],otz);
      npt[0].vx = octring[6].vx + x;
      npt[0].vy = octring[6].vy + y;
      Flare_Tri((long *)pt,(long *)&npt[1],(long *)npt,otz);
      Flare_2DSpike((long *)pt,(long *)npt,otz);
      npt[1].vx = octring[7].vx + x;
      npt[1].vy = octring[7].vy + y;
      Flare_Tri((long *)pt,(long *)npt,(long *)&npt[1],otz);
      Flare_2DSpike((long *)pt,(long *)&npt[1],otz);
      Flare_Tri((long *)pt,(long *)&npt[1],(long *)&save1,otz);
      Flare_2DSpike((long *)pt,(long *)&save1,otz);
    }
    {
      DR_MODE *aprim;
      u_int *slot;
      u_char *pal;
      u_int pkt24;
      u_int addr24_1;

      aprim = (DR_MODE *)Render_gPacketPtr;
      addr24_1 = (u_int)aprim & 0xffffff;
      pal = Render_gPalettePtr;
      slot = (u_int *)(otz * 4 + (int)pal);
      *(u_int *)aprim = *(u_int *)aprim & 0xff000000 | *slot & 0xffffff;
      pkt24 = *slot & 0xff000000;
      Render_gPacketPtr = (u_char *)aprim + 0xc;
      *slot = pkt24 | (addr24_1 & 0xffffff);
      SetDrawMode(aprim,0,1,0x120,(RECT *)0x0);
    }
  }
  return;
}

/* ---- Flare_PreCalcHexLightBeam__FPli  [FLARE.CPP:1229-1252] SLD-VERIFIED ---- */
void Flare_PreCalcHexLightBeam(long *center,int otz)

{
  long pt [2];
  long i;

  /* MATCH: SYM locals = pt[2] AUTO + i REG(t0) LONG + block-scope prim LINE_G2*(a0).
   * pt[0]=*center saved to STACK once, body reloads it (swc2 memory clobber);
   * top-test + j back-edge loop (exit-in-the-middle prevents rotation);
   * gte_stsxy pointer form materializes &pt[1] each iteration (PsyQ inline_c shape).
   * ---- w45-a9 SEAL 16 -> PASS 53/53, the SAME two-part edit as Flare_OctFlareSpikes ----
   * The 16 diffs were TWO coupled residuals, both fixed by the OT-link statement order:
   *  (a) preheader movable order: retail = pktaddr(t1) | palette-base(t4) | otz*4(t3) |
   *      0xFFFFFF(a3) | 0xFF000000(t2).  Splitting `pal = Render_gPalettePtr;` out of the
   *      slot expression puts the `lui 0x1F80` ahead of the `sll`, and giving the
   *      prim-address mask its own `addr24` temp BEFORE the first RMW generates 0xFFFFFF
   *      ahead of 0xFF000000 (the RMW's left operand generates the HI mask first).
   *  (b) the i/mask $a3<->$t0 rotation: `*slot = pkt24 | (addr24 & 0xffffff)` re-masks an
   *      already-masked value -- ZERO INSNS, but it lifts the 0xFFFFFF pseudo from 3 refs
   *      to 4, crossing the floor_log2 step (1 -> 2) in allocno_compare, so the mask now
   *      out-prioritises the counter and takes $a3 (the lower hard reg in MIPS' numeric
   *      handout) while `i` drops to $t0, exactly as the SYM says.  (w44 ref-step family.)
   * NOTE this refutes the w41 note "(1) alone REGRESSES PreCalcHexLightBeam (16->18, no
   * loop -> no LICM)": there IS a preheader here, and (1) only works together with the
   * addr24 temp placed AFTER the slot statement. */
  i = 0;
  pt[0] = *center;
  while (true) {
    if (i >= 8) break;
    {
      LINE_G2 *prim;
      u_int *slot;
      u_int rgb;
      u_int pkt24;
      u_char *pal;
      u_int addr24;

gte_ldv0(&Flare_gOct[i]);
      prim = (LINE_G2 *)Render_gPacketPtr;
      pal = Render_gPalettePtr;
      slot = (u_int *)(otz * 4 + (int)pal);
      addr24 = (u_int)prim & 0xffffff;
      *(u_int *)prim = *(u_int *)prim & 0xff000000 | *slot & 0xffffff;
      pkt24 = *slot & 0xff000000;
      Render_gPacketPtr = (u_char *)prim + 0x14;
      *slot = pkt24 | (addr24 & 0xffffff);
      gte_rtps_b();
      rgb = *(u_int *)&gfrgb2;
      *((u_char *)prim + 3) = 4;
      *(u_int *)((u_char *)prim + 0xc) = 0;
      *(u_int *)((u_char *)prim + 4) = rgb;
      *((u_char *)prim + 7) = 0x52;
      gte_stsxy(&pt[1]);
      *(long *)((u_char *)prim + 8) = pt[0];
      *(long *)((u_char *)prim + 0x10) = pt[1];
    }
    i = i + 1;
  }
  return;
}

/* ---- Flare_Quad__FPlP7CVECTORi  [FLARE.CPP:1305-1315] SLD-VERIFIED ---- */
void Flare_Quad(long *pt,CVECTOR *color,int otz)

{
  int color_word;
  int pkt_addr24;
  u_char *prim;

  otz = otz * 4 + (int)Render_gPalettePtr;
  prim = Render_gPacketPtr;
  *(u_int *)prim = *(u_int *)prim & 0xff000000 | *(u_int *)otz & 0xffffff;
  pkt_addr24 = *(u_int *)otz & 0xff000000;
  Render_gPacketPtr = prim + 0x18;
  *(u_int *)otz = pkt_addr24 | (u_int)prim & 0xffffff;
  color_word = *(int *)color;
  prim[3] = 5;
  *(int *)(prim + 4) = color_word;
  prim[7] = 0x2a;
  *(long *)(prim + 8) = *pt;
  *(long *)(prim + 0xc) = pt[1];
  *(long *)(prim + 0x10) = pt[2];
  *(long *)(prim + 0x14) = pt[3];
  return;
}

/* ---- Flare_QuadNotTransparent__FPlP7CVECTORi  [FLARE.CPP:1319-1331] SLD-VERIFIED ---- */
void Flare_QuadNotTransparent(long *pt,CVECTOR *color,int otz)

{
  int color_word;
  int pkt_addr24;
  u_char *prim;

  otz = otz * 4 + (int)Render_gPalettePtr;
  prim = Render_gPacketPtr;
  *(u_int *)prim = *(u_int *)prim & 0xff000000 | *(u_int *)otz & 0xffffff;
  pkt_addr24 = *(u_int *)otz & 0xff000000;
  Render_gPacketPtr = prim + 0x18;
  *(u_int *)otz = pkt_addr24 | (u_int)prim & 0xffffff;
  color_word = *(int *)color;
  prim[3] = 5;
  *(int *)(prim + 4) = color_word;
  prim[7] = 0x28;
  *(long *)(prim + 8) = *pt;
  *(long *)(prim + 0xc) = pt[1];
  *(long *)(prim + 0x10) = pt[2];
  *(long *)(prim + 0x14) = pt[3];
  return;
}

/* ---- Flare_QuadRing__FPlP7CVECTORi  [FLARE.CPP:1335-1352] SLD-VERIFIED ---- */
void Flare_QuadRing(long *pt,CVECTOR *color,int otz)

{
  int innerColor;
  int outerColor;
  void *prev_pkt_slot;
  u_char *prim;

  otz = otz * 4 + (int)Render_gPalettePtr;
  prim = Render_gPacketPtr;
  *(u_int *)prim = *(u_int *)prim & 0xff000000 | *(u_int *)otz & 0xffffff;
  *(u_int *)otz = *(u_int *)otz & 0xff000000 | (u_int)prim & 0xffffff;
  innerColor = *(int *)color;
  prev_pkt_slot = prim + 0xc;
  Render_gPacketPtr = prim + 0x24;
  *(u_int *)prev_pkt_slot = 0;
  *(int *)(prim + 4) = innerColor;
  outerColor = *(int *)color;
  prim[3] = 8;
  *(u_int *)(prim + 0x1c) = 0;
  prim[7] = 0x3a;
  *(int *)(prim + 0x14) = outerColor;
  *(long *)(prim + 8) = *pt;
  *(long *)(prim + 0x10) = pt[1];
  *(long *)(prim + 0x18) = pt[2];
  *(long *)(prim + 0x20) = pt[3];
  return;
}

/* ---- Flare_TextureQuad__FPlP7CVECTORci  [FLARE.CPP:1368-1382] SLD-VERIFIED ---- */
void Flare_TextureQuad(long *pt,CVECTOR *color,char type,int otz)

{
  Draw_tPixMap *shape_p;
  int pkt_addr24_b;
  int color_word;
  u_int uVar1;
  u_int uVar2;
  int pkt_addr24;
  u_char *prim;

  otz = otz * 4 + (int)Render_gPalettePtr;
  prim = Render_gPacketPtr;
  *(u_int *)prim = *(u_int *)prim & 0xff000000 | *(u_int *)otz & 0xffffff;
  pkt_addr24 = *(u_int *)otz & 0xff000000;
  Render_gPacketPtr = prim + 0x28;
  *(u_int *)otz = pkt_addr24 | (u_int)prim & 0xffffff;
  color_word = *(int *)color;
  prim[3] = 9;
  *(int *)(prim + 4) = color_word;
  prim[7] = 0x2e;
  *(long *)(prim + 8) = *pt;
  *(long *)(prim + 0x10) = pt[1];
  *(long *)(prim + 0x18) = pt[2];
  *(long *)(prim + 0x20) = pt[3];
  shape_p = gFlarePixmap[(u_char)type];
  uVar1 = *(u_int *)((char *)shape_p + 4);
  uVar2 = *(u_int *)((char *)shape_p + 8);
  pkt_addr24_b = *(int *)((char *)shape_p + 0xc);
  *(u_int *)(prim + 0xc) = *(u_int *)shape_p;
  *(u_int *)(prim + 0x14) = uVar1;
  *(u_int *)(prim + 0x1c) = uVar2;
  *(int *)(prim + 0x24) = pkt_addr24_b;
  return;
}

/* ---- Flare_SingleColorTex__FP7DVECTORP7CVECTORiici  [FLARE.CPP:1386-1401] SLD-VERIFIED ---- */
void Flare_SingleColorTex(DVECTOR *xy,CVECTOR *color,int width,int height,char type,int otz)

{
  short sVar1;
  short sVar2;
  DVECTOR pt [4];
  
  sVar1 = (short)width;
  pt[0].vx = xy->vx - sVar1;
  sVar2 = (short)height;
  pt[0].vy = xy->vy + sVar2;
  pt[1].vx = xy->vx + sVar1;
  pt[1].vy = xy->vy + sVar2;
  pt[2].vx = xy->vx - sVar1;
  pt[2].vy = xy->vy - sVar2;
  pt[3].vx = xy->vx + sVar1;
  pt[3].vy = xy->vy - sVar2;
  Flare_TextureQuad((long *)pt,color,type,otz);
  return;
}

/* ---- Flare_SingleColorHex__FP7DVECTORP7CVECTORiii  [FLARE.CPP:1405-1427] SLD-VERIFIED ---- */
void Flare_SingleColorHex(DVECTOR *xy,CVECTOR *color,int width,int height,int otz)

{
  DVECTOR pt [6];

  /* MATCH: SYM shows NO locals besides pt -- the divides are INLINE expressions,
   * CSE'd by gcc (width/4 -> fresh temp t1, height/2 mutates a3 in place). */
  pt[0].vx = xy->vx - width / 4;
  pt[0].vy = xy->vy + height / 2;
  pt[1].vx = xy->vx + width / 4;
  pt[1].vy = xy->vy + height / 2;
  pt[2].vx = xy->vx - width / 2;
  pt[2].vy = xy->vy;
  pt[3].vx = xy->vx + width / 2;
  pt[3].vy = xy->vy;
  pt[4].vx = xy->vx - width / 4;
  pt[4].vy = xy->vy - height / 2;
  pt[5].vx = xy->vx + width / 4;
  pt[5].vy = xy->vy - height / 2;
  Flare_Quad((long *)pt,color,otz);
  Flare_Quad((long *)(pt + 2),color,otz);
  return;
}

/* ---- Flare_SingleColorOct__FP7DVECTORP7CVECTORiii  [FLARE.CPP:1443-1456] SLD-VERIFIED ---- */
void Flare_SingleColorOct(DVECTOR *xy,CVECTOR *color,int width,int height,int otz)

{
  int iVar1;
  SVECTOR *pSVar2;
  DVECTOR *pDVar3;
  int i;
  int iVar4;
  DVECTOR pt [8];
  
  iVar4 = 0;
  pDVar3 = pt;
  pSVar2 = Flare_gLensOct;
  do {
    iVar1 = width * pSVar2->vx;
    if (iVar1 < 0) {
      iVar1 = iVar1 + 0xff;
    }
    pDVar3->vx = xy->vx + (short)(iVar1 >> 8);
    iVar1 = height * pSVar2->vy;
    if (iVar1 < 0) {
      iVar1 = iVar1 + 0xff;
    }
    pSVar2 = pSVar2 + 1;
    iVar4 = iVar4 + 1;
    pDVar3->vy = xy->vy + (short)(iVar1 >> 8);
    pDVar3 = pDVar3 + 1;
  } while (iVar4 < 8);
  Flare_Quad((long *)pt,color,otz);
  Flare_Quad((long *)(pt + 2),color,otz);
  Flare_Quad((long *)(pt + 4),color,otz);
  return;
}

/* ---- Flare_SingleColorOctRing__FP7DVECTORP7CVECTORiii  [FLARE.CPP:1460-1488] SLD-VERIFIED ---- */
void Flare_SingleColorOctRing(DVECTOR *xy,CVECTOR *color,int width,int height,int otz)

{
  char i2;
  int i;
  char index;
  int height2;
  int width2;
  DVECTOR pt [18];

  /* MATCH: SYM locals exactly (i / width2 / height2 / index CHAR / i2 CHAR) --
   * index = i*2 computed at loop-body TOP (back-edge delay slot), divides inline /256. */
  width2 = width - 5;
  height2 = height - 5;
  i = 0;
  do {
    index = (char)(i * 2);
    i2 = (char)(i % 8);
    pt[index].vx = xy->vx + (short)(width * Flare_gOct[i2].vx / 256);
    pt[index].vy = xy->vy + (short)(height * Flare_gOct[i2].vy / 256);
    pt[index + 1].vx = xy->vx + (short)(width2 * Flare_gOct[i2].vx / 256);
    pt[index + 1].vy = xy->vy + (short)(height2 * Flare_gOct[i2].vy / 256);
    i = i + 1;
  } while (i < 9);
  Flare_QuadRing((long *)pt,color,otz);
  Flare_QuadRing((long *)(pt + 2),color,otz);
  Flare_QuadRing((long *)(pt + 4),color,otz);
  Flare_QuadRing((long *)(pt + 6),color,otz);
  Flare_QuadRing((long *)(pt + 8),color,otz);
  Flare_QuadRing((long *)(pt + 10),color,otz);
  Flare_QuadRing((long *)(pt + 0xc),color,otz);
  Flare_QuadRing((long *)(pt + 0xe),color,otz);
  return;
}

/* ---- Flare_InitLensFlare__Fv  [FLARE.CPP:1568-1571] SLD-VERIFIED ---- */
void Flare_InitLensFlare(void)

{
  gFlare_LensFlare.size = 0x50;
  gFlare_LensFlare.piece = Flare_SunFlarePieces;
  gFlare_LensFlare.isDrawn[1] = '\0';
  gFlare_LensFlare.isDrawn[0] = '\0';
  return;
}

/* ---- Flare_LensFlare__FP7DVECTORP15Draw_FlareCache  [FLARE.CPP:1578-1738] SLD-VERIFIED ----
 * FAR-MISS 303 diffs (ours 414 / oracle 409). w38-a10 DIAGNOSIS (no code change yet; the
 * SYM block @404e96 is the recipe for the next pass):
 *  - `screenPos` is SYM class ARG, i.e. it lives in the incoming stack slot: the oracle
 *    does `sw $a0,184($sp)` in the prologue and RELOADS it (`lw $t7,184($sp)`) just to
 *    take vx/vy. Ours parks it in $fp for the whole function.
 *  - SYM REG map that the body must reproduce: width $6, height $7, i $16, sx $30(fp),
 *    sy $23(s7), piece $8(t0) [FLARE_PIECE_DEF*], angleZ $17(s1), flareVis $21(s5),
 *    result $3 (block at line 13), aprim $4 (block at line 159); AUTO: dx -0x40,
 *    dy -0x3c, pxy -0xa0, angleZ2 -0x38, pt[4] -0x98, col -0x88 (line-14 block),
 *    scalemat -0x80 / mtx -0x60 (line-78 block), a SECOND `col` -0x98 (line-134 block).
 *    So the oracle's $fp/$s7 are sx/sy (two named INT locals read from screenPos), NOT the
 *    pointer -- our recon has no `width`/`height` locals at all and carries eight invented
 *    temps (piece_color/piece_idx/pieceCount/piece_iter_a/ti7/piece_y/piece_x/tu1/p/tp3)
 *    that the SYM does not have.
 *  => this is a rule-8 SYM-driven rewrite (name the SYM locals into the dataflow, add the
 *    line-13/14/78/134/159 block scopes), not a coloring grind. */
void Flare_LensFlare(DVECTOR *screenPos,Draw_FlareCache *sd)

{
  /* MATCH: SYM rule-8 rewrite (SYM block @404e96, fsize 184, mask $c0ff0000).
   * SYM locals, EXACTLY: fn-scope dx/dy(AUTO -0x40/-0x3c) pxy(AUTO -0xa0)
   * width($7=a3) height($6=a2) i($16) sx($30=fp) sy($23=s7) piece($8=t0)
   * angleZ($17=s1) angleZ2(AUTO -0x38) flareVis(REG $21, type CHAR);
   * block@line14 { pt[4](-0x98) col(-0x88) }; block@line78 { scalemat(-0x80)
   * mtx(-0x60) }; block@line134 { col(-0x98, REUSES pt's slot) };
   * block@line159 { aprim($4) }.  `screenPos` is SYM class ARG -- retail runs
   * out of callee-saved regs (all 10 in mask) and spills it to its incoming
   * slot 184($sp), reloading it for sx/sy and for the two Flare_Spikes calls.
   * Fixes vs the old iVarN body (all raw-oracle evidence, BF36C-BF1CC):
   *  - width/height: ONE compute `size*piece->size/0x10000` + a copy
   *    (`addu a2,a3,zero` in the guard's delay slot); calls take (height,width).
   *  - gte_ldsv/gte_stsv (stride 2, SVECTOR) were WRONG -- oracle uses lhu/sh at
   *    0/6/12 = PsyQ gte_ldclmv/gte_stclmv (MATRIX COLUMN, row stride 6).
   *  - scalemat IS built here (5 word stores 0/8/0x10/4/0xc = flareVis*128,
   *    flareVis*64, 0, 0, 0) and its m[0][0..1] is REWRITTEN to flareVis*64
   *    before the 2nd spike pass -- the old body fed an UNINITIALIZED scalemat
   *    to gte_SetRotMatrix twice (correctness bug).
   *  - Flare_SingleColorHex took `(DVECTOR*)piece` -- oracle passes &pxy
   *    (`addiu a0,$sp,0x18`) like every other arm (correctness bug).
   *  - the 25-entry visibility scan walks gFlare_LensFlare.screenData[0]
   *    (base+0x10, stride 2) with the SAME `i` the piece loop reuses; flareVis
   *    is a CHAR (oracle `andi s6,s5,0xff` once, then reused for *128/*64 and
   *    the /25 colour scale).
   *  - Render_gPacketPtr / Render_gPalettePtr are read in the TAIL only; the old
   *    `while (p = ..., tp3 = ..., idx < 9)` comma-hoist has no oracle basis. */
  /* RESIDUAL 56 (ours 407 / oracle 409), w39-a8.  TWO clusters, both measured:
   *  (a) HEAD: the oracle loads screenPos->vx/vy into $v0/$v1 and COPIES them to
   *      $fp/$s7 (`addu $fp,$v0,zero` / `addu $s7,$v1,zero`, the 2 missing insns);
   *      that extra pair lets its scheduler hold sx-2 in $a3 across the whole pt[]
   *      build and sink the pt[0]/pt[2].vx stores to the end.  Ours loads straight
   *      into the home regs and therefore serializes the four value chains through
   *      $v0.  Probed: all 24 group orderings of the four chained pt assignments
   *      (56 is the minimum; the oracle's STORE order costs 76 because it flips
   *      which of sx/sy is defined first, and with it the $fp/$s7 split), reading
   *      pos[0].vx/vy back from screenPos instead of sx/sy (84), (int) casts (56),
   *      moving sx/sy into the pt block (56).
   *  (b) TAIL: the 3-cycle rotation of the pkt-ptr address / 0xFFFFFF / 0xFF000000
   *      constant registers -- the shared flare.cpp allocator tie, see the note on
   *      Flare_Sun.  Structure and count are otherwise exact.
   * Per-TU flag probe (w39, now that compile_cpp honours the keys): flare.cpp is
   * NOT a no_split_addresses / no_schedule_insns / no_schedule_insns2 /
   * no_strength_reduce object -- whole-TU baseline 15 PASS / 458 diffs vs
   * 10/1387, 4/2086, 2/845, 15/889.
   * ---- w45-a9: cluster (a)'s TWO MISSING INSNS ARE NOW SOURCE-REACHABLE (not landed --
   * it costs 2 gate diffs, so it was reverted under verify-or-revert; ADOPT IT FIRST next
   * time, it is the structurally correct base).  THE SPELLING:
   *     { int vx0 = screenPos->vx;  int vy0 = screenPos->vy;
   *       __asm__ volatile("" : : "r"(vx0), "r"(vy0));      // §2b.5 zero-insn USE fence
   *       sx = vx0;  sy = vy0; }
   * -> COUNT BECOMES EXACT 409/409 (from 407) at 36 diffs (baseline 34).  The fence stops
   * reload from folding the two `lh`s straight into the $fp/$s7 homes, so retail's
   * `lh <tmp>,0(base); addu $fp,<tmp>,$zero` copy pair materializes -- that pair IS the
   * documented 2-insn gap and it is what lets retail's scheduler hold sx-2 across the pt[]
   * build.  What is left after it: (i) the reload BASE -- retail spills screenPos and reads
   * `lh v0,0($t7)` off the 184(sp) reload, ours still reads through the live `$a0`; (ii) the
   * two temps land in $v1/$a2, retail's in $v0/$v1.  NEXT STEPS from that base: force the
   * ARG-slot reload (screenPos is SYM class ARG) by taking `DVECTOR *sp2 = screenPos;` only
   * INSIDE this block after a call, or by fencing `screenPos` itself so its pseudo must be
   * reloaded; then re-run the 24 pt-group orderings from the (a) probe list -- they were all
   * measured on the 407-insn base and are stale in this basin (§2b.4 lever-order).
   * FALSIFIED this wave: fencing `sx`/`sy` AFTER the assignments (36 @407 -- no copy pair,
   * just a nop shuffle).  Cluster (b) (the 0xFFFFFF/0xFF000000/pkt-addr 3-cycle) is the SAME
   * tie that Flare_PreCalcHexLightBeam SEALED this wave -- apply that recipe verbatim to the
   * tail OT-link block here: `pal = Render_gPalettePtr;` split out, `addr24` temp AFTER the
   * slot statement and BEFORE the first RMW, and the zero-insn re-mask `pkt24 | (addr24 &
   * 0xffffff)` for the +1 ref-step.  MEASURED THIS WAVE: applying just the statement-order
   * half of that recipe (addr24 moved below the two slot statements) at all 7 OT sites in
   * this fn is DIFF-NEUTRAL (34, 0 TU regressions) -- so here the mask order is NOT the
   * dial; the `pal` split + the ref-step re-mask are the untried halves.
   * ---- w46-a8: THE COUNT-EXACT-409 FENCED BASIN WAS BUILT AND FULLY SWEPT.  It does not
   * beat the kept 34 @407, so it is again NOT landed (verify-or-revert), but the follow-up
   * list the w45 note left is now CLOSED and must not be re-run:
   *   - the fenced split-temp base reproduces exactly as written: 36 diffs, count-exact
   *     409/409.
   *   - FORCING THE ARG-SLOT RELOAD (the w45 "next step") does NOTHING: fencing `screenPos`
   *     itself before the block, naming `screenPos` as a third operand of the same fence, a
   *     `DVECTOR *sp2 = screenPos;` local inside the block, and that local defined after a
   *     fence on screenPos -- ALL exactly 36 @409.  Swapping the two temps' declaration
   *     order (vy0 first) is also 36.  ⇒ retail's `lw $t7,184(sp)` ARG reload is not
   *     reachable by any source handle on the pointer; it is a spill decision.
   *   - ALL 24 pt-group orderings RE-RUN IN THIS BASIN (the w45 note flagged the old list
   *     stale): the current order is joint-best at 36 (perms 0,1,2,12,14,15 = 36; the rest
   *     42/50/52/56).  The basin-stale hypothesis is therefore falsified -- the ordering
   *     ranking is the SAME in both basins.
   *   ⇒ from the fenced base the residual 36 is: (i) the ARG spill above, and (ii) the two
   *   head temps landing in $v1/$a2 vs retail's $v0/$v1.  NEW NAMED ANGLE: (ii) is a
   *   local-alloc QTY pick (both temps are born and die inside the entry block) -- per §A0
   *   compute their QTY_CMP_PRI from a `-dl` dump of THIS basin and use the ref/live dials,
   *   which is the one instrument never applied to this function.  The untried tail halves
   *   (`pal = Render_gPalettePtr;` split out at the 7 OT sites) remain open and are
   *   independent of the head cluster.
   * ---- w50-A3: 34 @407 -> 30 @409 COUNT-EXACT, and the fenced basin IS NOW LANDED
   * (the w45 note's own recommendation, which w45/w46 both left un-adopted because the
   * bare fenced base gates 36).  TWO edits:
   *  (1) the w45 fenced split-temp head (vx0/vy0 + zero-insn USE fence) -- retail's two
   *      `addu fp,v0,zero` / `addu s7,v1,zero` copies materialize, count 407 -> 409;
   *  (2) NEW: THE `col` CONSTANT MOVED TO ITS USE SITE (`*(u_long*)&col = 0xffffff;`
   *      written just before the Flare_QuadNotTransparent call instead of at the top of
   *      the block): 36 -> 30.  Lengthening the 0xFFFFFF constant's live range DEMOTES
   *      its qty out of $v0 into retail's $a3, and $a3 is then reused for `sx-2` exactly
   *      like retail (`sw a3,48(sp); addiu a3,fp,-2; sh a3,32(sp)`).
   * RE-SWEPT IN THE NEW BASIN (current, not stale): all 24 pt-group orderings (the kept
   * 0,1,2,3 is joint-best at 30; retail's STORE order 1,2,3,0 = 44), four DISTINCT
   * per-group temps (30, no change), `col` named in a local (36), a fence on the col
   * word after the stores (47 @410).
   * RESIDUAL 30 = ONE head cluster: retail RELOADS screenPos from its ARG home
   * (`lw t7,184(sp); lh v0,0(t7)`) because its scheduler issues the two call-arg address
   * setups (`addiu a0,sp,32` / `addiu a1,sp,48`) BEFORE the two `lh`s, so $a0 is already
   * clobbered and reload cannot inherit it; ours issues the `lh`s first and reads straight
   * through the live $a0.  => the dial is NOT a handle on the pointer (w46 closed that
   * list) -- it is WHERE the two arg-address materializations issue.  NEW NAMED ANGLE:
   * give the two call-arg addresses real pointer locals defined at the TOP of the pt block
   * (`DVECTOR *pp = pt; CVECTOR *cp = &col;`) and pass those, so their addiu's are born
   * before the reads; a bare `"r"(pt)` fence operand does NOT compile under cc1plus 2.8
   * ("inconsistent operand constraints") -- use the locals. */
  int dx;
  int dy;
  DVECTOR pxy;
  int width;
  int height;
  int i;
  int sx;
  int sy;
  FLARE_PIECE_DEF *piece;
  long angleZ;
  long angleZ2;
  char flareVis;
  int otz;

  otz = 0;
  if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr + -0x400) {
    { int vx0 = screenPos->vx;  int vy0 = screenPos->vy;
      __asm__ volatile("" : : "r"(vx0), "r"(vy0));
      sx = vx0;  sy = vy0; }
    {
      DVECTOR pt [4];
      CVECTOR col;

      /* MATCH: group order sx-2, sy-2, sx+3, sy+3 (compute order in the oracle)
       * with each chain written HI = LO = v (stores ascending).  Moving the
       * sx-2 group last (= the oracle's STORE order) costs 14 diffs: it flips
       * which of sx/sy is defined first and therefore the fp/s7 split. */
      pt[2].vx = pt[0].vx = (short)(sx + -2);
      pt[1].vy = pt[0].vy = (short)(sy + -2);
      pt[3].vx = pt[1].vx = (short)(sx + 3);
      pt[3].vy = pt[2].vy = (short)(sy + 3);
      *(u_long *)&col = 0xffffff;
      Flare_QuadNotTransparent((long *)pt,&col,Draw_gViewOtSize + -2);
    }
    angleZ = (sx + sy) * 8;
    angleZ2 = (sx + sy) * 6;
    dx = 0x140 - sx;
    dy = 0xf0 - sy;
    flareVis = '\0';
    gFlare_LensFlare.oldpos[0].vx = gFlare_LensFlare.pos[0].vx;
    gFlare_LensFlare.oldpos[0].vy = gFlare_LensFlare.pos[0].vy;
    gFlare_LensFlare.pos[0].vx = (short)sx;
    gFlare_LensFlare.pos[0].vy = (short)sy;
    gFlare_LensFlare.isDrawn[0] = '\x01';
    for (i = 0; i < 0x19; i = i + 1) {
      if ((gFlare_LensFlare.screenData[0][0][i] & 0x7fff) == 0x7fff) {
        flareVis = flareVis + 1;
      }
    }
    if (flareVis != '\0') {
      MATRIX scalemat;
      MATRIX mtx;

      *(int *)((char *)&scalemat + 0) = flareVis * 0x80;
      *(int *)((char *)&scalemat + 8) = flareVis * 0x40;
      *(int *)((char *)&scalemat + 0x10) = 0;
      *(int *)((char *)&scalemat + 4) = 0;
      *(int *)((char *)&scalemat + 0xc) = 0;
      *(u_long *)&gfrgb2 = *(u_long *)&TrackSpec_gSpec.skyspec.sunBeamColor;
      Flare_IdentMatrix(&mtx);
      RotMatrixZ(angleZ,&mtx);
gte_SetRotMatrix(&scalemat);
gte_ldclmv(&mtx);
      gte_rtir();
gte_stclmv(&mtx);
gte_ldclmv(((char *)&mtx + 0x2));
      gte_rtir();
gte_stclmv(((char *)&mtx + 0x2));
gte_ldclmv(((char *)&mtx + 0x4));
      gte_rtir();
gte_stclmv(((char *)&mtx + 0x4));
gte_SetRotMatrix(&mtx);
      Flare_Spikes((long *)screenPos,0);
      *(int *)((char *)&scalemat + 0) = flareVis * 0x40;
      Flare_IdentMatrix(&mtx);
      RotMatrixZ(angleZ2,&mtx);
gte_SetRotMatrix(&scalemat);
gte_ldclmv(&mtx);
      gte_rtir();
gte_stclmv(&mtx);
gte_ldclmv(((char *)&mtx + 0x2));
      gte_rtir();
gte_stclmv(((char *)&mtx + 0x2));
gte_ldclmv(((char *)&mtx + 0x4));
      gte_rtir();
gte_stclmv(((char *)&mtx + 0x4));
gte_SetRotMatrix(&mtx);
      Flare_Spikes((long *)screenPos,0);
      i = 0;
      *(u_long *)&(gFlare_LensFlare.piece)->color =
           *(u_long *)&TrackSpec_gSpec.skyspec.sunHaloColor;
      while (i < 9) {
        piece = gFlare_LensFlare.piece + i;
        pxy.vx = (short)(((0x10000 - piece->distance) * sx + piece->distance * dx) / 0x10000);
        pxy.vy = (short)(((0x10000 - piece->distance) * sy + piece->distance * dy) / 0x10000);
        width = gFlare_LensFlare.size * piece->size / 0x10000;
        height = width;
        if (3 < width) {
          CVECTOR col;

          col.r = piece->color.r * flareVis / 0x19;
          col.g = piece->color.g * flareVis / 0x19;
          col.b = piece->color.b * flareVis / 0x19;
          switch(piece->type) {
          case 0:
          case 1:
            Flare_SingleColorTex(&pxy,&col,height,width,piece->type,0);
            break;
          case 2:
            Flare_SingleColorHex(&pxy,&col,height,width,0);
            break;
          case 3:
            Flare_SingleColorOct(&pxy,&col,height,width,0);
            break;
          case 4:
            Flare_SingleColorOctRing(&pxy,&col,height,width,0);
            break;
          }
        }
        i = i + 1;
      }
      {
        DR_MODE *aprim;
        u_int *slot;
        u_int pkt24;
        u_int addr24_0;

        aprim = (DR_MODE *)Render_gPacketPtr;

        addr24_0 = (u_int)aprim & 0xffffff;
        slot = (u_int *)(otz * 4);
        slot = (u_int *)((int)slot + (int)Render_gPalettePtr);
        *(u_int *)aprim = *(u_int *)aprim & 0xff000000 | *slot & 0xffffff;
        pkt24 = *slot & 0xff000000;
        Render_gPacketPtr = (u_char *)aprim + 0xc;
        *slot = pkt24 | (addr24_0 & 0xffffff);
        SetDrawMode(aprim,0,otz,0x120,(RECT *)0x0);
      }
    }
  }
  return;
}

/* ---- Flare_Sun__FP7SVECTORP15Draw_FlareCache  [FLARE.CPP:1742-1818] SLD-VERIFIED ----
 * NEAR-MISS 50, COUNT-EXACT 187/187.  ALL 50 diffs are one 3-CYCLE REGISTER ROTATION of
 * the three block-local constants in the two AddPrim/SetDrawMode tails:
 *     ours  pktPtrAddr(0x1F800004)=$t2  0xFFFFFF=$t3  0xFF000000=$t1
 *     oracle             "        =$t3          =$t1            =$t2
 * Instruction stream, schedule, def positions and use positions are IDENTICAL -- only the
 * local-alloc quantity ORDER differs, i.e. the documented 0xffffff/0xff000000 constant-reg
 * tie (catalog wave-12 a7: both mask pseudos are block-LOCAL, so local-alloc decides, and
 * no zero-cost source lever changes the qty priority).  The SAME rotation is the whole
 * residual of Flare_2DHalo (68), most of Flare_LensFlare's tail, Flare_CarShapedHalo and
 * Flare_Halo2's tails, and Sky_RenderStars (2, LICM-hoist ORDER variant of the same tie).
 * w40-a8 QUANTIFICATION of that floor across the halo family (tool: scratch/quant_a8.py --
 * aligns ours vs oracle, then searches register permutations that make an aligned pair
 * equal, reporting how many pairs remain OUTSIDE):
 *     Flare_Sun          50 diffs = 25 pairs, 25/25 explained by {t1->t2,t2->t3,t3->t1}
 *                        -> 0 OUTSIDE.  100%% floor, count exact.  Do not grind.
 *     Flare_Halo2        48 diffs = 24 pairs, 24/24 explained -> 0 OUTSIDE (after the
 *                        w40 batched-load fix below).  100%% floor, count exact.
 *     Flare_2DHalo       60 diffs = 24 pairs, 21 explained, 3 OUTSIDE (+12 count-only):
 *                        a v0<->t0 swap between the otz*4 shift and the palette-base load
 *                        in the SECOND tail block, plus prologue save-order.
 *     Flare_CarShapedHalo 59 diffs = 27 pairs, only 6 explained by a t0<->t1 2-cycle;
 *                        21 OUTSIDE = an s6<->s7 swap (type param vs the zero-init
 *                        angleZ; the SYM says angleZ=$s6, so the ORACLE is right and our
 *                        build gives angleZ $s7) + a v0/v1 pick on `andi ...,127`.
 *                        THIS ONE IS NOT THE FLOOR -- it is the biggest remaining lead
 *                        in flare.cpp: demote `type` / promote `angleZ` in allocno order.
 * w39-a8 probes, ALL byte-neutral or worse: Hrz_SetDitheringPrim's exact spelling (slot
 * first, unmasked `tag = *slot` then `(tag & 0xff000000)|(...)`) = 50; unmasked pkt24 with
 * the original statement order = 50; swapping the first RMW's OR operands = 56.  Also NOT
 * a per-TU flag object (see the Flare_LensFlare banner for the four flag receipts). */
void Flare_Sun(SVECTOR *worldPos,Draw_FlareCache *sd)

{
  int pshift;
  int vertRezBy2;
  int dvz;
  int otz;
  VECTOR diff;
  CVECTOR color;
  DVECTOR posOnScreen;

  /* MATCH: SYM locals = diff/color/posOnScreen AUTO + pshift(a2) + vertRezBy2/dvz(v1,
   * same reg reuse) + otz(s0) + block-scope aprim/scalemat. Restored vs old recon:
   * the diff.vx/vy/vz translation recompute + Camera_gGeomScreen clamp (was MISSING --
   * correctness bug: garbage GTE translation), scalemat 0x400-diag init (was fed
   * UNINITIALIZED to gte_SetRotMatrix), gfrgb = color struct-assign (lwl/lwr). */
  pshift = 0x78;
  if (GameSetup_gData.commMode == 1) {
    pshift = 0x3c;
  }
  if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr + -0x400) {
gte_ldv0(worldPos);
    gte_rtps();
gte_stlvnl(&diff);
    if ((diff.vx <= diff.vz) && (-diff.vx <= diff.vz)) {
      *(u_int *)&color = 0x808080;
      gte_stsxy(&posOnScreen);
      vertRezBy2 = 0x78;
      posOnScreen.vy = (short)((diff.vy >> 2) + pshift);
      if (GameSetup_gData.commMode == 1) {
        vertRezBy2 = 0x3c;
      }
      diff.vy = (posOnScreen.vy - vertRezBy2) * 4;
      dvz = Camera_gGeomScreen * 4;
      diff.vx = (posOnScreen.vx - 0xa0) * 4;
      if (dvz > 0xb50) {
        dvz = 0xb50;
      }
      diff.vz = dvz;
      gte_SetTransVector(&diff);
      if (((posOnScreen.vx < 0x13d) && (GameSetup_gData.commMode != 1)) &&
         ((TrackSpec_gSpec.skyspec.flags & 0x100U) == 0)) {
        Flare_LensFlare(&posOnScreen,sd);
      }
      gfrgb = color;
      otz = Draw_gViewOtSize - 2;
      {
        DR_MODE *aprim;
        u_int *slot;
        u_int pkt24;
        u_int addr24_0;

        aprim = (DR_MODE *)Render_gPacketPtr;

        addr24_0 = (u_int)aprim & 0xffffff;
        slot = (u_int *)(otz * 4);
        slot = (u_int *)((int)slot + (int)Render_gPalettePtr);
        *(u_int *)aprim = *(u_int *)aprim & 0xff000000 | *slot & 0xffffff;
        pkt24 = *slot & 0xff000000;
        Render_gPacketPtr = (u_char *)aprim + 0xc;
        *slot = pkt24 | (addr24_0 & 0xffffff);
        SetDrawMode(aprim,0,0,0x120,(RECT *)0x0);
      }
      {
        MATRIX scalemat;

        *(int *)((char *)&scalemat + 0) = 0x400;
        *(int *)((char *)&scalemat + 8) = 0x400;
        *(int *)((char *)&scalemat + 0x10) = 0;
        *(int *)((char *)&scalemat + 4) = 0;
        *(int *)((char *)&scalemat + 0xc) = 0;
gte_SetRotMatrix(&scalemat);
      }
      if ((TrackSpec_gSpec.skyspec.flags & 0x100U) != 0) {
        Flare_SingleColorTex(&posOnScreen,&TrackSpec_gSpec.skyspec.sunHaloColor,0x10,0x10,'\0',otz);
      }
      else {
        Flare_OctFlare((long *)&posOnScreen,otz);
      }
      {
        DR_MODE *aprim;
        u_int *slot;
        u_int pkt24;
        u_int addr24_1;

        aprim = (DR_MODE *)Render_gPacketPtr;

        addr24_1 = (u_int)aprim & 0xffffff;
        slot = (u_int *)(otz * 4);
        slot = (u_int *)((int)slot + (int)Render_gPalettePtr);
        *(u_int *)aprim = *(u_int *)aprim & 0xff000000 | *slot & 0xffffff;
        pkt24 = *slot & 0xff000000;
        Render_gPacketPtr = (u_char *)aprim + 0xc;
        *slot = pkt24 | (addr24_1 & 0xffffff);
        SetDrawMode(aprim,0,0,0x120,(RECT *)0x0);
      }
    }
  }
  return;
}

/* ---- Flare_Moon__FP7SVECTORP15Draw_FlareCache  [FLARE.CPP:1822-1864] SLD-VERIFIED ---- */
void Flare_Moon(SVECTOR *worldPos,Draw_FlareCache *sd)

{
  DVECTOR *xy;
  int pshift;
  VECTOR diff;
  CVECTOR color;
  DVECTOR posOnScreen;

  pshift = 0x78;
  if (GameSetup_gData.commMode == 1) {
    pshift = 0x3c;
  }
gte_ldv0(worldPos);
  gte_rtps();
  *(u_int *)&color = 0x808080;
gte_stlvnl(&diff);
  xy = &posOnScreen;
gte_swc2(0xe,&posOnScreen);
  posOnScreen.vy = (short)(diff.vy >> 2) + (short)pshift;
  if ((diff.vx <= diff.vz) && (-diff.vx <= diff.vz)) {
    Flare_SingleColorTex(xy,&color,0x10,0x10,'\0',Draw_gViewOtSize + -2);
  }
  return;
}

/* end of flare.cpp */
