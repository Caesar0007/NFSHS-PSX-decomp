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
 * TU-local (w13-a3): psx_gte.h only carries the 0/2/4 SVECTOR forms. */
#if defined(__mips__)
#define gte_ldclmv(p) __asm__ volatile (                                       \
    "lhu $12, 0(%0)\n\tlhu $13, 6(%0)\n\tlhu $14, 12(%0)\n\t"                   \
    "mtc2 $12, $9\n\tmtc2 $13, $10\n\tmtc2 $14, $11"                           \
    : : "r"(p) : "$12", "$13", "$14")
#define gte_stclmv(p) __asm__ volatile (                                       \
    "mfc2 $12, $9\n\tmfc2 $13, $10\n\tmfc2 $14, $11\n\t"                        \
    "sh $12, 0(%0)\n\tsh $13, 6(%0)\n\tsh $14, 12(%0)"                         \
    : : "r"(p) : "$12", "$13", "$14", "memory")
#else
#define gte_ldclmv(p)  ((void)(p))
#define gte_stclmv(p)  ((void)(p))
#endif

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
      u_int pkt24;

      prim = Render_gPacketPtr;
      slot = (u_int *)Render_gPalettePtr;
      slot = (u_int *)((int)slot + otz * 4);
      *(u_int *)prim = *(u_int *)prim & 0xff000000 | *slot & 0xffffff;
      pkt24 = *slot & 0xff000000;
      Render_gPacketPtr = prim + 0x1c;
      *slot = pkt24 | (u_int)prim & 0xffffff;
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
   * SpikePt0/1/2[i] -> givs, OctPt1/2[i] stay indexed (giv budget). */
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

      prim = Render_gPacketPtr;
      slot = (u_int *)(otz * 4 + (int)Render_gPalettePtr);
      *(u_int *)prim = *(u_int *)prim & 0xff000000 | *slot & 0xffffff;
      pkt24 = *slot & 0xff000000;
      Render_gPacketPtr = prim + 0x24;
      *slot = pkt24 | (u_int)prim & 0xffffff;
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

      prim = Render_gPacketPtr;
      slot = (u_int *)(otz * 4 + (int)Render_gPalettePtr);
      *(u_int *)prim = *(u_int *)prim & 0xff000000 | *slot & 0xffffff;
      pkt24 = *slot & 0xff000000;
      Render_gPacketPtr = prim + 0x1c;
      *slot = pkt24 | (u_int)prim & 0xffffff;
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
      u_int pkt24;
      u_int rgb;

      prim = Render_gPacketPtr;
      slot = (u_int *)Render_gPalettePtr;
      slot = (u_int *)((int)slot + otz * 4);
      *(u_int *)prim = *(u_int *)prim & 0xff000000 | *slot & 0xffffff;
      pkt24 = *slot & 0xff000000;
      Render_gPacketPtr = prim + 0x24;
      *slot = pkt24 | (u_int)prim & 0xffffff;
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
      u_int rgb;

      prim = Render_gPacketPtr;
      slot = (u_int *)Render_gPalettePtr;
      slot = (u_int *)((int)slot + otz * 4);
      *(u_int *)prim = *(u_int *)prim & 0xff000000 | *slot & 0xffffff;
      pkt24 = *slot & 0xff000000;
      Render_gPacketPtr = prim + 0x1c;
      *slot = pkt24 | (u_int)prim & 0xffffff;
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
      u_int pkt24;
      u_int rgb;

      prim = Render_gPacketPtr;
      slot = (u_int *)Render_gPalettePtr;
      slot = (u_int *)((int)slot + otz * 4);
      *(u_int *)prim = *(u_int *)prim & 0xff000000 | *slot & 0xffffff;
      pkt24 = *slot & 0xff000000;
      Render_gPacketPtr = prim + 0x1c;
      *slot = pkt24 | (u_int)prim & 0xffffff;
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
      if (R3DCar_InMenu != 0) {
        i = (type & 0x7fU) + 1;
      }
      else {
        i = (type & 0x7fU) + 0xb;
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
      scale = gscale << scale;
      gscale = scale;
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
        aprim = (DR_MODE *)Render_gPacketPtr;
        slot = (u_int *)(otz * 4 + (int)Render_gPalettePtr);
        *(u_int *)aprim = *(u_int *)aprim & 0xff000000 | *slot & 0xffffff;
        Render_gPacketPtr = (u_char *)aprim + 0xc;
        *slot = *slot & 0xff000000 | (u_int)aprim & 0xffffff;
        SetDrawMode(aprim,0,(u_int)((flags & 0x40U) != 0),0x120,(RECT *)0x0);
      }
    }
  }
  return;
}

/* PsyQ gte_stszotz (SZ3>>2 depth-sort key) -- oracle Halo2 @0x800CD6E4:
 * mfc2 $12,$19; nop; sra $12,2; sw.  TU-local (w13-a3). */
#if defined(__mips__)
#define gte_stszotz(p) __asm__ volatile (                                      \
    "mfc2 $12, $19\n\tnop\n\tsra $12, $12, 2\n\tsw $12, 0(%0)"                  \
    : : "r"(p) : "$12", "memory")
#else
#define gte_stszotz(p) ((void)(p))
#endif

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
    dx = fpt->x - tx;
    ty = t->y;
    dy = fpt->y - ty;
    tz = t->z;
    dz = fpt->z - tz;
    sdiff.vx = (short)(dx >> 10);
    sdiff.vy = (short)(dy >> 10);
    sdiff.vz = (short)(dz >> 10);
    if ((flags & 5U) != 0) {
      dx = fpt2->x - tx;
      dy = fpt2->y - ty;
      dz = fpt2->z - tz;
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
      aprim = (DR_MODE *)Render_gPacketPtr;
      slot = (u_int *)(otz * 4 + (int)Render_gPalettePtr);
      *(u_int *)aprim = *(u_int *)aprim & 0xff000000 | *slot & 0xffffff;
      Render_gPacketPtr = (u_char *)aprim + 0xc;
      *slot = *slot & 0xff000000 | (u_int)aprim & 0xffffff;
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
      aprim = (DR_MODE *)Render_gPacketPtr;
      slot = (u_int *)(otz * 4 + (int)Render_gPalettePtr);
      *(u_int *)aprim = *(u_int *)aprim & 0xff000000 | *slot & 0xffffff;
      Render_gPacketPtr = (u_char *)aprim + 0xc;
      *slot = *slot & 0xff000000 | (u_int)aprim & 0xffffff;
      SetDrawMode(aprim,0,(u_int)((flags & 0x40U) != 0),0x120,(RECT *)0x0);
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
   * two-set slot (+ otz*4 in the tail block only). */
  DVECTOR pt2;
  DVECTOR *pt;
  int otz;
  Draw_FlareCache *sd;

  sd = (Draw_FlareCache *)&Render_gPalettePtr;
  pt2.vx = (short)x;
  pt2.vy = (short)y;
  if (sd->head.cprim.PrimPtr < sd->head.cprim.MPrimPtr + -0x1000) {
    int flare_type;

    pt = &pt2;
    otz = 0;
    flare_type = type & 0xffU;
    *(u_long *)&gfrgb = Flare_gType[flare_type].chalo;
    *(u_long *)&gfrgb2 = Flare_gType[flare_type].cbeam;
    {
      DR_MODE *aprim;
      u_int *slot;

      aprim = (DR_MODE *)Render_gPacketPtr;
      slot = (u_int *)Render_gPalettePtr;
      *(u_int *)aprim = *(u_int *)aprim & 0xff000000 | *slot & 0xffffff;
      Render_gPacketPtr = (u_char *)aprim + 0xc;
      *slot = *slot & 0xff000000 | (u_int)aprim & 0xffffff;
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

      aprim = (DR_MODE *)Render_gPacketPtr;
      slot = (u_int *)Render_gPalettePtr;
      slot = (u_int *)((int)slot + otz * 4);
      *(u_int *)aprim = *(u_int *)aprim & 0xff000000 | *slot & 0xffffff;
      Render_gPacketPtr = (u_char *)aprim + 0xc;
      *slot = *slot & 0xff000000 | (u_int)aprim & 0xffffff;
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
   * gte_stsxy pointer form materializes &pt[1] each iteration (PsyQ inline_c shape). */
  i = 0;
  pt[0] = *center;
  while (true) {
    if (i >= 8) break;
    {
      LINE_G2 *prim;
      u_int *slot;
      u_int rgb;
      u_int pkt24;

gte_ldv0(&Flare_gOct[i]);
      prim = (LINE_G2 *)Render_gPacketPtr;
      slot = (u_int *)(otz * 4 + (int)Render_gPalettePtr);
      *(u_int *)prim = *(u_int *)prim & 0xff000000 | *slot & 0xffffff;
      pkt24 = *slot & 0xff000000;
      Render_gPacketPtr = (u_char *)prim + 0x14;
      *slot = pkt24 | (u_int)prim & 0xffffff;
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

/* ---- Flare_LensFlare__FP7DVECTORP15Draw_FlareCache  [FLARE.CPP:1578-1738] SLD-VERIFIED ---- */
void Flare_LensFlare(DVECTOR *screenPos,Draw_FlareCache *sd)

{
  /* MATCH: SYM rule-8 (block 0x800ceb6c). CONCAT11/switchD Ghidra-isms REMOVED
   * and re-derived from raw (BF820-BF89C): piece color is a SEPARATE inner
   * `col` CVECTOR (oracle sp20, distinct from pxy sp18) whose r/g/b bytes are
   * SIGNED col.field = piece->color.field * piece_color / 25 -- oracle emits
   * `mult; mfhi; sra 3` with NO sign-fix because gcc proves the product >=0
   * (u_char * masked-int); the prior `(u_int)`-cast form was an unsigned-divide
   * CORRECTNESS/codegen bug. dx/dy(0x140-sx,0xf0-sy) + angleZ/angleZ2((sx+sy)*8,
   * *6) precomputed post-quad AUTO spills; col(white)= one word store 0x00ffffff;
   * switch case-4 falls through to default (both reach the shared piece_idx++,
   * = the oracle jtbl_80056894 shared tail). */
  int sx;
  int sy;
  int dx;
  int dy;
  long angleZ;
  long angleZ2;
  int flareVis;
  int piece_color;
  int piece_idx;
  int pieceCount;
  int piece_iter_a;
  int ti7;
  int piece_y;
  int piece_x;
  u_int tu1;
  DR_MODE *aprim;
  DVECTOR pxy;
  DVECTOR pt [4];
  CVECTOR col;
  MATRIX scalemat;
  MATRIX mtx;
  u_char *p;
  u_char *tp3;

  if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr + -0x400) {
    sx = screenPos->vx;
    sy = screenPos->vy;
    *(u_long *)&col = 0xffffff;
    pt[0].vx = (short)(sx + -2);
    pt[0].vy = (short)(sy + -2);
    pt[1].vx = (short)(sx + 3);
    pt[2].vy = (short)(sy + 3);
    pt[1].vy = pt[0].vy;
    pt[2].vx = pt[0].vx;
    pt[3].vx = pt[1].vx;
    pt[3].vy = pt[2].vy;
    Flare_QuadNotTransparent((long *)pt,&col,Draw_gViewOtSize + -2);
    angleZ = (sx + sy) * 8;
    angleZ2 = (sx + sy) * 6;
    dx = 0x140 - sx;
    dy = 0xf0 - sy;
    flareVis = 0;
    piece_iter_a = (int)&gFlare_LensFlare;
    gFlare_LensFlare.isDrawn[0] = '\x01';
    gFlare_LensFlare.oldpos[0].vx = gFlare_LensFlare.pos[0].vx;
    gFlare_LensFlare.oldpos[0].vy = gFlare_LensFlare.pos[0].vy;
    pieceCount = 0;
    do {
      if ((*(u_short *)(piece_iter_a + 0x10) & 0x7fff) == 0x7fff) {
        flareVis = flareVis + 1;
      }
      pieceCount = pieceCount + 1;
      piece_iter_a = piece_iter_a + 2;
    } while (pieceCount < 0x19);
    piece_color = flareVis & 0xff;
    gFlare_LensFlare.pos[0].vx = (short)sx;
    gFlare_LensFlare.pos[0].vy = (short)sy;
    if (piece_color != 0) {
      gfrgb2 = TrackSpec_gSpec.skyspec.sunBeamColor;
      Flare_IdentMatrix(&mtx);
      RotMatrixZ(angleZ,&mtx);
gte_SetRotMatrix(&scalemat);
gte_ldsv(&mtx);
      gte_rtir();
gte_stsv(&mtx);
gte_ldsv(((char *)&mtx + 0x2));
      gte_rtir();
gte_stsv(((char *)&mtx + 0x2));
gte_ldsv(((char *)&mtx + 0x4));
      gte_rtir();
gte_stsv(((char *)&mtx + 0x4));
gte_SetRotMatrix(&mtx);
      Flare_Spikes((long *)screenPos,0);
      Flare_IdentMatrix(&mtx);
      RotMatrixZ(angleZ2,&mtx);
gte_SetRotMatrix(&scalemat);
gte_ldsv(&mtx);
      gte_rtir();
gte_stsv(&mtx);
gte_ldsv(((char *)&mtx + 0x2));
      gte_rtir();
gte_stsv(((char *)&mtx + 0x2));
gte_ldsv(((char *)&mtx + 0x4));
      gte_rtir();
gte_stsv(((char *)&mtx + 0x4));
gte_SetRotMatrix(&mtx);
      Flare_Spikes((long *)screenPos,0);
      piece_idx = 0;
      (gFlare_LensFlare.piece)->color = TrackSpec_gSpec.skyspec.sunHaloColor;
      while (p = Render_gPacketPtr, tp3 = Render_gPalettePtr, piece_idx < 9) {
        FLARE_PIECE_DEF *piece;

        piece = gFlare_LensFlare.piece + piece_idx;
        piece_y = (0x10000 - piece->distance) * sx + piece->distance * dx;
        pxy.vx = (short)(piece_y / 0x10000);
        piece_x = (0x10000 - piece->distance) * sy + piece->distance * dy;
        pxy.vy = (short)(piece_x / 0x10000);
        ti7 = gFlare_LensFlare.size * piece->size / 0x10000;
        if (3 < ti7) {
          col.r = piece->color.r * piece_color / 0x19;
          col.g = piece->color.g * piece_color / 0x19;
          col.b = piece->color.b * piece_color / 0x19;
          switch(piece->type) {
          case 0:
          case 1:
            Flare_SingleColorTex(&pxy,&col,ti7,ti7,piece->type,0);
            break;
          case 2:
            Flare_SingleColorHex((DVECTOR *)piece,&col,ti7,ti7,0);
            break;
          case 3:
            Flare_SingleColorOct(&pxy,&col,ti7,ti7,0);
            break;
          case 4:
            Flare_SingleColorOctRing(&pxy,&col,ti7,ti7,0);
            /* fall through to default -> shared piece_idx++ */
          default:
            ;
          }
        }
        piece_idx = piece_idx + 1;
      }
      *(u_int *)Render_gPacketPtr =
           *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      tu1 = (u_int)Render_gPacketPtr & 0xffffff;
      Render_gPacketPtr = Render_gPacketPtr + 0xc;
      *(u_int *)tp3 = *(u_int *)tp3 & 0xff000000 | tu1;
      SetDrawMode((DR_MODE *)p,0,0,0x120,(RECT *)0x0);
    }
  }
  return;
}

/* ---- Flare_Sun__FP7SVECTORP15Draw_FlareCache  [FLARE.CPP:1742-1818] SLD-VERIFIED ---- */
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

        aprim = (DR_MODE *)Render_gPacketPtr;
        slot = (u_int *)(otz * 4);
        slot = (u_int *)((int)slot + (int)Render_gPalettePtr);
        *(u_int *)aprim = *(u_int *)aprim & 0xff000000 | *slot & 0xffffff;
        pkt24 = *slot & 0xff000000;
        Render_gPacketPtr = (u_char *)aprim + 0xc;
        *slot = pkt24 | (u_int)aprim & 0xffffff;
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

        aprim = (DR_MODE *)Render_gPacketPtr;
        slot = (u_int *)(otz * 4);
        slot = (u_int *)((int)slot + (int)Render_gPalettePtr);
        *(u_int *)aprim = *(u_int *)aprim & 0xff000000 | *slot & 0xffffff;
        pkt24 = *slot & 0xff000000;
        Render_gPacketPtr = (u_char *)aprim + 0xc;
        *slot = pkt24 | (u_int)aprim & 0xffffff;
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
