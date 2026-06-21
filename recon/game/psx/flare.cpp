/* game/psx/flare.cpp -- RECONSTRUCTED (NFS4 PSX in-race HUD; C++ TU)
 *   62 fns: sprite/poly builders, tachometer, number rasterizer, mini-map + radar,
 *   CD player, wingman interface, render views (hud/tac/map/stats), 3-2-1-GO, BTC/busted.
 *   Reconstructed with full SYM-locals applied (audited).
 */
#include "../../nfs4_types.h"
#include "flare_externs.h"

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
  u_int *prev_pkt_slot;
  int pkt_addr24;
  u_char *prim;
  CVECTOR flareColor;
  
  prim = Render_gPacketPtr;
  prev_pkt_slot = (u_int *)(Render_gPalettePtr + otz * 4);
  *(u_int *)Render_gPacketPtr = *(u_int *)Render_gPacketPtr & 0xff000000 | *prev_pkt_slot & 0xffffff;
  pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0x1c;
  *prev_pkt_slot = *prev_pkt_slot & 0xff000000 | pkt_addr24;
  *(u_int *)(prim + 4) = 0x32000000;
  flareColor = gfrgb;
  *(u_int *)(prim + 0x14) = 0;
  prim[3] = 6;
  *(CVECTOR *)(prim + 0xc) = flareColor;
  *(long *)(prim + 8) = *p2;
  *(long *)(prim + 0x10) = *cp;
  *(long *)(prim + 0x18) = *p1;
  return;
}

/* ---- Flare_SetMatrix__FP10matrixtdef  [FLARE.CPP:184-192] SLD-VERIFIED ---- */
void Flare_SetMatrix(matrixtdef *m)
{
  int r0, r1, r2;
  MATRIX mpsx;
  int *mm = (int *)m;

  mpsx.m[0][0] = (short)(mm[0] >> 4);
  mpsx.m[0][1] = (short)(mm[1] >> 4);
  mpsx.m[0][2] = (short)(mm[2] >> 4);
  mpsx.m[1][0] = (short)(mm[3] >> 4);
  mpsx.m[1][1] = (short)(mm[4] >> 4);
  mpsx.m[1][2] = (short)(mm[5] >> 4);
  mpsx.m[2][0] = (short)(mm[6] >> 4);
  mpsx.m[2][1] = (short)(mm[7] >> 4);
  mpsx.m[2][2] = (short)(mm[8] >> 4);
  gte_SetRotMatrix(&mpsx);
  gte_ldtr(0,0,0);
}

/* ---- Flare_IdentMatrix__FP6MATRIX  [FLARE.CPP:196-202] SLD-VERIFIED ---- */
void Flare_IdentMatrix(MATRIX *mtx)

{
  *(short *)((int)(mtx->m + 0) + 0) = 0x1000;
  *(short *)((int)(mtx->m + 0) + 2) = 0;
  *(u_int *)(mtx->m[0] + 2) = 0;
  *(short *)((int)(mtx->m + 1) + 2) = 0x1000;
  *(short *)((int)(mtx->m + 1) + 4) = 0;
  *(short *)((int)(mtx->m + 2) + 0) = 0;
  *(short *)((int)(mtx->m + 2) + 2) = 0;
  *(u_int *)(mtx->m[2] + 2) = 0x1000;
  return;
}

/* ---- Flare_OctFlare__FPli  [FLARE.CPP:208-241] SLD-VERIFIED ---- */
void Flare_OctFlare(long *center,int otz)

{
  int pkt_addr24;
  int prev_pkt_slot;
  int gfHexPt1_iter;
  int gfOctPt2_iter;
  int i;
  int vert_idx;
  long rgb1;
  int CVar6;
  long flare_dvxy [13];
  u_char *prim;
  
  CVar6 = (*(int *)&gfrgb);
gte_lwc2(0,*(int *)(&Flare_gOct));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x4)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x10));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x8)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0xc)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x14));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x10)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x14)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x18));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x18)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x1c)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x1c));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x20)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x24)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x20));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x28)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x2c)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x24));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x30)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x34)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x28));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x38)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x3c)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x2c));
  vert_idx = 8;
  gfOctPt2_iter = (int)gfOctPt2;
  gfHexPt1_iter = (int)gfHexPt1;
  while( true ) {
    prim = Render_gPacketPtr;
    gfOctPt2_iter = gfOctPt2_iter + -2;
    vert_idx = vert_idx + -1;
    gfHexPt1_iter = gfHexPt1_iter + -2;
    if (vert_idx == -1) break;
    prev_pkt_slot = otz * 4 + (int)Render_gPalettePtr;
    *(u_int *)Render_gPacketPtr =
         *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)prev_pkt_slot & 0xffffff;
    pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x1c;
    *(u_int *)prev_pkt_slot = *(u_int *)prev_pkt_slot & 0xff000000 | pkt_addr24;
    *(u_int *)(prim + 4) = 0x32000000;
    *(int *)(prim + 0xc) = CVar6;
    *(u_int *)(prim + 0x14) = 0;
    prim[3] = 6;
    *(long *)(prim + 8) = flare_dvxy[*(short *)gfHexPt1_iter];
    *(long *)(prim + 0x10) = *center;
    *(long *)(prim + 0x18) = flare_dvxy[*(short *)gfOctPt2_iter];
  }
  return;
}

/* ---- Flare_OctFlareSpikes__FPli  [FLARE.CPP:247-316] SLD-VERIFIED ---- */
void Flare_OctFlareSpikes(long *center,int otz)

{
  int pkt_addr24_b;
  int pkt_addr24_c;
  int pkt_addr24_d;
  int pkt_addr24;
  u_int *puVar1;
  int id2;
  int id0;
  int id1;
  int i;
  int vert_idx;
  int gfHexPt1_iter;
  int gfOctPt2_iter;
  int gfHexPt2_iter;
  long rgb2;
  long rgb1;
  long cent;
  int center_word;
  long flare_dvxy [13];
  short ts2;
  short ts3;
  u_char *tp5;
  CVECTOR CVar6;
  short ts1;
  u_char *prim;
  CVECTOR CVar7;
  short ts4;
  short ts5;
  
gte_lwc2(0,*(int *)(&Flare_gSpikes));
  gte_lwc2(1,*(int *)(((char *)&Flare_gSpikes + 0x4)));
  gte_rtps();
gte_swc2(0xe,&flare_dvxy);
gte_lwc2(0,*(int *)(((char *)&Flare_gSpikes + 0x8)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gSpikes + 0xc)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x4));
gte_lwc2(0,*(int *)(((char *)&Flare_gSpikes + 0x10)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gSpikes + 0x14)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x8));
gte_lwc2(0,*(int *)(((char *)&Flare_gSpikes + 0x18)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gSpikes + 0x1c)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0xc));
gte_lwc2(0,*(int *)(&Flare_gOct));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x4)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x10));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x8)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0xc)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x14));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x10)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x14)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x18));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x18)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x1c)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x1c));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x20)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x24)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x20));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x28)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x2c)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x24));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x30)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x34)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x28));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x38)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x3c)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x2c));
  CVar7 = gfrgb2;
  CVar6 = gfrgb;
  vert_idx = 8;
  gfHexPt2_iter = (int)gfOctPt1;
  gfOctPt2_iter = (int)gfSpikePt2;
  gfHexPt1_iter = (int)gfSpikePt1;
  center_word = *center;
  while( true ) {
    prim = Render_gPacketPtr;
    gfHexPt2_iter = gfHexPt2_iter + -2;
    gfOctPt2_iter = gfOctPt2_iter + -2;
    vert_idx = vert_idx + -1;
    gfHexPt1_iter = gfHexPt1_iter + -2;
    if (vert_idx == -1) break;
    ts1 = *(short *)gfHexPt1_iter;
    ts2 = *(short *)gfOctPt2_iter;
    ts3 = *(short *)gfHexPt2_iter;
    puVar1 = (u_int *)(Render_gPalettePtr + otz * 4);
    *(u_int *)Render_gPacketPtr = *(u_int *)Render_gPacketPtr & 0xff000000 | *puVar1 & 0xffffff;
    pkt_addr24_b = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x24;
    *puVar1 = *puVar1 & 0xff000000 | pkt_addr24_b;
    *(u_int *)(prim + 4) = 0x3a000000;
    prim[3] = 8;
    *(CVECTOR *)(prim + 0xc) = CVar7;
    *(u_int *)(prim + 0x14) = 0;
    *(u_int *)(prim + 0x1c) = 0;
    pkt_addr24_c = flare_dvxy[ts1];
    *(int *)(prim + 0x10) = center_word;
    *(int *)(prim + 8) = pkt_addr24_c;
    *(long *)(prim + 0x18) = flare_dvxy[ts3];
    *(long *)(prim + 0x20) = flare_dvxy[ts2];
    tp5 = Render_gPacketPtr;
    ts4 = gfOctPt1[vert_idx];
    ts5 = gfOctPt2[vert_idx];
    puVar1 = (u_int *)(Render_gPalettePtr + otz * 4);
    *(u_int *)Render_gPacketPtr = *(u_int *)Render_gPacketPtr & 0xff000000 | *puVar1 & 0xffffff;
    pkt_addr24_d = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x1c;
    *puVar1 = *puVar1 & 0xff000000 | pkt_addr24_d;
    *(u_int *)(tp5 + 4) = 0x32000000;
    tp5[3] = 6;
    *(CVECTOR *)(tp5 + 0xc) = CVar6;
    *(u_int *)(tp5 + 0x14) = 0;
    pkt_addr24 = flare_dvxy[ts4];
    *(int *)(tp5 + 0x10) = center_word;
    *(int *)(tp5 + 8) = pkt_addr24;
    *(long *)(tp5 + 0x18) = flare_dvxy[ts5];
  }
  return;
}

/* ---- Flare_Spikes__FPli  [FLARE.CPP:323-363] SLD-VERIFIED ---- */
void Flare_Spikes(long *center,int otz)

{
  int pkt_addr24;
  int cur_pkt;
  int gfHexPt1_iter;
  int gfOctPt2_iter;
  int gfHexPt2_iter;
  int i;
  int vert_idx;
  long flare_dvxy [13];
  CVECTOR spikeColor;
  u_char *prim;
  
gte_lwc2(0,*(int *)(&Flare_gSpikes));
  gte_lwc2(1,*(int *)(((char *)&Flare_gSpikes + 0x4)));
  gte_rtps();
gte_swc2(0xe,&flare_dvxy);
gte_lwc2(0,*(int *)(((char *)&Flare_gSpikes + 0x8)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gSpikes + 0xc)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x4));
gte_lwc2(0,*(int *)(((char *)&Flare_gSpikes + 0x10)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gSpikes + 0x14)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x8));
gte_lwc2(0,*(int *)(((char *)&Flare_gSpikes + 0x18)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gSpikes + 0x1c)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0xc));
gte_lwc2(0,*(int *)(&Flare_gOct));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x4)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x10));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x8)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0xc)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x14));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x10)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x14)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x18));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x18)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x1c)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x1c));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x20)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x24)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x20));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x28)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x2c)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x24));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x30)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x34)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x28));
gte_lwc2(0,*(int *)(((char *)&Flare_gOct + 0x38)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x3c)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x2c));
  vert_idx = 8;
  gfHexPt2_iter = (int)gfSpikePt2;
  gfOctPt2_iter = (int)gfOctPt1;
  gfHexPt1_iter = (int)gfSpikePt1;
  while( true ) {
    prim = Render_gPacketPtr;
    gfHexPt2_iter = gfHexPt2_iter + -2;
    gfOctPt2_iter = gfOctPt2_iter + -2;
    vert_idx = vert_idx + -1;
    gfHexPt1_iter = gfHexPt1_iter + -2;
    if (vert_idx == -1) break;
    cur_pkt = otz * 4 + (int)Render_gPalettePtr;
    *(u_int *)Render_gPacketPtr =
         *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)cur_pkt & 0xffffff;
    pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x24;
    *(u_int *)cur_pkt = *(u_int *)cur_pkt & 0xff000000 | pkt_addr24;
    *(u_int *)(prim + 4) = 0x3a000000;
    spikeColor = gfrgb2;
    *(u_int *)(prim + 0x14) = 0;
    *(u_int *)(prim + 0x1c) = 0;
    prim[3] = 8;
    *(CVECTOR *)(prim + 0xc) = spikeColor;
    *(long *)(prim + 8) = flare_dvxy[*(short *)gfHexPt1_iter];
    *(long *)(prim + 0x10) = *center;
    *(long *)(prim + 0x18) = flare_dvxy[*(short *)gfOctPt2_iter];
    *(long *)(prim + 0x20) = flare_dvxy[*(short *)gfHexPt2_iter];
  }
  return;
}

/* ---- Flare_HexFlare__FPli  [FLARE.CPP:370-400] SLD-VERIFIED ---- */
void Flare_HexFlare(long *center,int otz)

{
  int pkt_addr24;
  void *prev_pkt_slot;
  int pSVar4;
  int gfHexPt2_iter;
  int i;
  int vert_idx;
  long flare_dvxy [7];
  u_char *prim;
  CVECTOR CVar1;
  
gte_lwc2(0,*(int *)(&Flare_gHex));
  gte_lwc2(1,*(int *)(((char *)&Flare_gHex + 0x4)));
  gte_rtps();
gte_swc2(0xe,&flare_dvxy);
gte_lwc2(0,*(int *)(((char *)&Flare_gHex + 0x8)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gHex + 0xc)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x4));
gte_lwc2(0,*(int *)(((char *)&Flare_gHex + 0x10)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gHex + 0x14)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x8));
gte_lwc2(0,*(int *)(((char *)&Flare_gHex + 0x18)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gHex + 0x1c)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0xc));
gte_lwc2(0,*(int *)(((char *)&Flare_gHex + 0x20)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gHex + 0x24)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x10));
gte_lwc2(0,*(int *)(((char *)&Flare_gHex + 0x28)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gHex + 0x2c)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x14));
  vert_idx = 6;
  gfHexPt2_iter = (int)gfHexPt2;
  pSVar4 = (int)Flare_gSpikes;
  while( true ) {
    prim = Render_gPacketPtr;
    gfHexPt2_iter = gfHexPt2_iter + -2;
    vert_idx = vert_idx + -1;
    pSVar4 = pSVar4 + -2;
    if (vert_idx == -1) break;
    prev_pkt_slot = Render_gPalettePtr + otz * 4;
    *(u_int *)Render_gPacketPtr =
         *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)prev_pkt_slot & 0xffffff;
    pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x1c;
    *(u_int *)prev_pkt_slot = *(u_int *)prev_pkt_slot & 0xff000000 | pkt_addr24;
    *(u_int *)(prim + 4) = 0x32000000;
    CVar1 = gfrgb;
    *(u_int *)(prim + 0x14) = 0;
    prim[3] = 6;
    *(CVECTOR *)(prim + 0xc) = CVar1;
    *(long *)(prim + 8) = flare_dvxy[*(short *)pSVar4];
    *(long *)(prim + 0x10) = *center;
    *(long *)(prim + 0x18) = flare_dvxy[*(short *)gfHexPt2_iter];
  }
  return;
}

/* ---- Flare_ReflectHexFlare__FPli  [FLARE.CPP:407-437] SLD-VERIFIED ---- */
void Flare_ReflectHexFlare(long *center,int otz)

{
  int pkt_addr24;
  void *prev_pkt_slot;
  int pSVar4;
  int gfHexPt2_iter;
  int i;
  int vert_idx;
  long flare_dvxy [7];
  CVECTOR CVar1;
  u_char *prim;
  
gte_lwc2(0,*(int *)(&Flare_gReflectHex));
  gte_lwc2(1,*(int *)(((char *)&Flare_gReflectHex + 0x4)));
  gte_rtps();
gte_swc2(0xe,&flare_dvxy);
gte_lwc2(0,*(int *)(((char *)&Flare_gReflectHex + 0x8)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gReflectHex + 0xc)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x4));
gte_lwc2(0,*(int *)(((char *)&Flare_gReflectHex + 0x10)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gReflectHex + 0x14)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x8));
gte_lwc2(0,*(int *)(((char *)&Flare_gReflectHex + 0x18)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gReflectHex + 0x1c)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0xc));
gte_lwc2(0,*(int *)(((char *)&Flare_gReflectHex + 0x20)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gReflectHex + 0x24)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x10));
gte_lwc2(0,*(int *)(((char *)&Flare_gReflectHex + 0x28)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gReflectHex + 0x2c)));
  gte_rtps();
gte_swc2(0xe,((char *)&flare_dvxy + 0x14));
  vert_idx = 6;
  gfHexPt2_iter = (int)gfHexPt2;
  pSVar4 = (int)Flare_gSpikes;
  while( true ) {
    prim = Render_gPacketPtr;
    gfHexPt2_iter = gfHexPt2_iter + -2;
    vert_idx = vert_idx + -1;
    pSVar4 = pSVar4 + -2;
    if (vert_idx == -1) break;
    prev_pkt_slot = Render_gPalettePtr + otz * 4;
    *(u_int *)Render_gPacketPtr =
         *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)prev_pkt_slot & 0xffffff;
    pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x1c;
    *(u_int *)prev_pkt_slot = *(u_int *)prev_pkt_slot & 0xff000000 | pkt_addr24;
    *(u_int *)(prim + 4) = 0x32000000;
    CVar1 = gfrgb;
    *(u_int *)(prim + 0x14) = 0;
    prim[3] = 6;
    *(CVECTOR *)(prim + 0xc) = CVar1;
    *(long *)(prim + 8) = flare_dvxy[*(short *)pSVar4];
    *(long *)(prim + 0x10) = *center;
    *(long *)(prim + 0x18) = flare_dvxy[*(short *)gfHexPt2_iter];
  }
  return;
}

/* ---- Flare_QuadFlare__FPli  [FLARE.CPP:443-456] SLD-VERIFIED ---- */
void Flare_QuadFlare(long *center,int otz)

{
  long *cp;
  long *p2;
  long pt [4];
  long save1;
  
  cp = center;
gte_lwc2(0,*(int *)(&Flare_gQuad));
  gte_lwc2(1,*(int *)(((char *)&Flare_gQuad + 0x4)));
  gte_rtps();
gte_swc2(0xe,&save1);
gte_lwc2(0,*(int *)(((char *)&Flare_gQuad + 0x8)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gQuad + 0xc)));
  gte_rtps();
  p2 = pt + 1;
gte_swc2(0xe,((char *)&pt + 0x4));
  Flare_Tri(cp,&save1,p2,otz);
gte_lwc2(0,*(int *)(((char *)&Flare_gQuad + 0x10)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gQuad + 0x14)));
  gte_rtps();
gte_swc2(0xe,&pt);
  Flare_Tri(center,p2,pt,otz);
gte_lwc2(0,*(int *)(((char *)&Flare_gQuad + 0x18)));
  gte_lwc2(1,*(int *)(((char *)&Flare_gQuad + 0x1c)));
  gte_rtps();
gte_swc2(0xe,((char *)&pt + 0x4));
  Flare_Tri(center,pt,p2,otz);
  Flare_Tri(center,p2,&save1,otz);
  return;
}

/* ---- Flare_CarShapedHalo__FiP7COORD16N21siP15Draw_FlareCache  [FLARE.CPP:591-842] SLD-VERIFIED ---- */
short * Flare_CarShapedHalo(int type,COORD16 *ptCenter,COORD16 *pt1,COORD16 *pt2,short flag,int otz,
                  Draw_FlareCache *sd)

{
  VECTOR diff2;
  DVECTOR sp2;
  VECTOR tvec1;
  short sVar1;
  short sVar2;
  short sVar3;
  short sVar4;
  short sVar5;
  short sVar6;
  short sVar7;
  short sVar8;
  short sVar9;
  short sVar10;
  bool bVar11;
  short sVar12;
  long result;
  int CVar3;
  int CVar4;
  DVECTOR *pDVar13;
  int ti13;
  int pkt_addr24;
  int iVar14;
  int haloShape_p;
  int z;
  int iVar12_alt;
  int iVar6_emit;
  int tu14;
  DR_MODE *aprim;
  VECTOR *v0;
  int haloColor;
  COORD16 *ptEdge;
  int primPtr;
  long difx;
  int diff_x;
  MATRIX *mtx;
  long dify;
  int diff_y;
  long sizeOuter;
  int innerRadius;
  int scale;
  int scaledFactor;
  int flags;
  int flagsMasked;
  long angleOuter;
  int outerRadius;
  long angleZ;
  int haloRadius;
  int lerp_q16;
  int loc_d8;
  VECTOR diff;
  CVECTOR color [2];
  DVECTOR sp;
  COORD16 vec1;
  COORD16 vec2;
  COORD16 crossprod;
  u_char auStack_98 [32];
  CVECTOR save;
  MATRIX mtx2;
  VECTOR tvec2;
  MATRIX scalemat;
  short loc_30;
  int loc_28;
  int loc_24;
  int loc_20;
  int loc_1c;
  int loc_18;
  int loc_14;
  int loc_10;
  int loc_c;
  int loc_8;
  int loc_4;
  int pbVar1;
  u_char tu2;
  u_char *p;
  CVECTOR CVar5;
  u_char bVar1;
  u_char bVar2;
  u_char bVar3;
  u_int tu1;
  
  sVar12 = flag;
  u_int _flag = (u_int)(u_short)flag;
  pDVar13 = (DVECTOR *)0x0;
  if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr + -0x400) {
    sVar1 = pt1->x;
    sVar2 = ptCenter->x;
    sVar3 = pt1->y;
    sVar4 = ptCenter->y;
    sVar5 = pt1->z;
    sVar6 = ptCenter->z;
    haloColor = (u_int)(u_short)pt2->x - (u_int)(u_short)ptCenter->x;
    sVar7 = pt2->y;
    sVar8 = ptCenter->y;
    sVar9 = pt2->z;
    sVar10 = ptCenter->z;
    if (-1 < (int)(_flag << 0x10)) {
      pt1 = pt2;
    }
    if (R3DCar_InMenu == 0) {
      ti13 = (type & 0x7fU) + 0xb;
    }
    else {
      ti13 = (type & 0x7fU) + 1;
    }
    if ((type & 0x100U) != 0) {
      ptCenter->y = -ptCenter->y - DrawC_gReflectOffset;
    }
gte_lwc2(0,*(int *)(ptCenter));
    gte_lwc2(1,*(int *)(((char *)ptCenter + 0x4)));
    gte_rtps();
    CVar3 = Flare_gType[ti13].chalo;
    CVar4 = Flare_gType[ti13].cbeam;
    scaledFactor = Flare_gType[ti13].scale;
    flagsMasked = Flare_gType[ti13].flags;
    color[0] = (*(CVECTOR *)&(CVar3));
    color[1] = (*(CVECTOR *)&(CVar4));
    if ((type & 0x80U) != 0) {
      bVar1 = (u_char)CVar3;
      bVar2 = (u_char)((u_int)CVar3 >> 8);
      bVar1 = bVar1 >> 1;
      bVar3 = (u_char)((u_int)CVar3 >> 0x10);
      bVar2 = bVar2 >> 1;
      color[1].r = (u_char)CVar4;
      bVar3 = bVar3 >> 1;
      color[0].cd = (u_char)((u_int)CVar3 >> 0x18);
      color[1].g = (u_char)((u_int)CVar4 >> 8);
      color[1].b = (u_char)((u_int)CVar4 >> 0x10);
      color[1].g = color[1].g >> 1;
      color[1].r = color[1].r >> 1;
      color[1].cd = (u_char)((u_int)CVar4 >> 0x18);
      color[1].b = color[1].b >> 1;
    }
gte_swc2(0x19,&diff);
    gte_swc2(0x1a,((char *)&diff + 0x4));
    gte_swc2(0x1b,((char *)&diff + 0x8));
    pDVar13 = (DVECTOR *)-diff.vx;
    if (((diff.vx <= diff.vz) &&
        (bVar11 = (int)pDVar13 <= diff.vz, pDVar13 = (DVECTOR *)(u_int)(diff.vz < 0x80), bVar11)) &&
       (bVar11 = pDVar13 == (DVECTOR *)0x0, pDVar13 = &sp, bVar11)) {
gte_swc2(0xe,&sp);
      haloRadius = 0;
      if ((flagsMasked & 8U) != 0) {
        haloRadius = ((int)sp.vx + (int)sp.vy) * 4;
      }
      outerRadius = 0;
      if ((flagsMasked & 4U) == 0) {
        innerRadius = 0;
      }
      else {
gte_lwc2(0,*(int *)(pt2));
        gte_lwc2(1,*(int *)(((char *)pt2 + 0x4)));
        gte_rtps();
gte_swc2(0x19,&diff2);
        gte_swc2(0x1a,((char *)&diff2 + 0x4));
        gte_swc2(0x1b,((char *)&diff2 + 0x8));
gte_swc2(0xe,&sp2);
        diff_y = (int)(short)(*(u_short *)((u_char *)&(auStack_98) + 18)) - (int)sp.vy;
        diff_x = (int)(short)(*(u_short *)((u_char *)&(auStack_98) + 16)) - (int)sp.vx;
        ti13 = fixedatan(diff_y,diff_x);
        outerRadius = ti13 >> 4;
        pkt_addr24 = isqrt(diff_x * diff_x + diff_y * diff_y);
        innerRadius = pkt_addr24 * diff.vz;
      }
      gfrgb = color[0];
      gfrgb2 = color[1];
      if ((int)((u_int)(u_short)sVar12 << 0x10) < 0) {
        ti13 = (int)(short)haloColor * (int)(short)haloColor;
        iVar14 = (int)(short)(sVar7 - sVar8);
        iVar12_alt = iVar14 * iVar14;
        iVar14 = (int)(short)(sVar9 - sVar10);
        lerp_q16 = iVar14 * iVar14;
      }
      else {
        ti13 = (int)(short)(sVar1 - sVar2);
        ti13 = ti13 * ti13;
        iVar14 = (int)(short)(sVar3 - sVar4);
        iVar12_alt = iVar14 * iVar14;
        iVar14 = (int)(short)(sVar5 - sVar6);
        lerp_q16 = iVar14 * iVar14;
      }
      haloShape_p = (ti13 + iVar12_alt + lerp_q16 >> 1) << (scaledFactor & 0x1fU);
      gscale = haloShape_p;
      if ((flagsMasked & 1U) != 0) {
        gte_ldtr(0,0,0);
gte_lwc2(0,*(int *)(&crossprod));
        gte_lwc2(1,*(int *)(((char *)&crossprod + 0x4)));
        gte_rtps();
        v0 = (VECTOR *)&tvec1;
gte_swc2(0x19,&tvec1);
        gte_swc2(0x1a,((char *)&tvec1 + 0x4));
        gte_swc2(0x1b,((char *)&tvec1 + 0x8));
        VectorNormal(v0,&tvec2);
        if ((flagsMasked & 2U) != 0) {
          tvec2.vz = (tvec2.vz + -0xf33) * 0x14;
        }
        iVar6_emit = tvec2.vz + -600;
        if (iVar6_emit < 0) {
          iVar6_emit = 0;
        }
        tvec2.vz = iVar6_emit;
        gscale = gscale * iVar6_emit >> 0xb;
      }
      CVar5 = gfrgb;
      mtx = (MATRIX *)(scalemat.m[1] + 1);
      if ((type & 0x100U) == 0) {
        scalemat.m[2][2] = 0;
        (*(u_short *)((u_char *)&(scalemat) + 18)) = 0;
        scalemat.m[0][2] = 0;
        scalemat.m[1][0] = 0;
        scalemat.m[2][0] = 0;
        scalemat.m[2][1] = 0;
        (*(int *)&(scalemat.m[0])) = gscale + (innerRadius >> 5);
        scalemat.m[1][1] = (u_short)gscale;
        scalemat.m[1][2] = (*(u_short *)((u_char *)&(gscale) + 2));
        Flare_IdentMatrix((MATRIX *)auStack_98);
        Flare_IdentMatrix(&mtx2);
gte_SetTransMatrix(&diff);
        RotMatrixZ(haloRadius,(MATRIX *)auStack_98);
        RotMatrixZ(outerRadius,&mtx2);
gte_SetRotMatrix(&mtx);
gte_ldsv(&scalemat);
        gte_rtir();
gte_stsv(&mtx);
gte_ldsv(((char *)&scalemat + 0x2));
        gte_rtir();
gte_stsv(((char *)&mtx + 0x2));
gte_ldsv(((char *)&scalemat + 0x4));
        gte_rtir();
gte_stsv(((char *)&mtx + 0x4));
gte_SetRotMatrix(&mtx);
gte_ldsv(&scalemat);
        gte_rtir();
gte_stsv(&scalemat);
gte_ldsv(((char *)&scalemat + 0x2));
        gte_rtir();
gte_stsv(((char *)&scalemat + 0x2));
gte_ldsv(((char *)&scalemat + 0x4));
        gte_rtir();
gte_stsv(((char *)&scalemat + 0x4));
gte_SetRotMatrix(&mtx2);
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
      else {
        tu2 = gfrgb.r;
        ti13 = haloShape_p + (innerRadius >> 7);
        pbVar1 = (int)&save + 3;
        tu1 = pbVar1 & 3;
        *(u_int *)(pbVar1 - tu1) =
             *(u_int *)(pbVar1 - tu1) & -1 << (tu1 + 1) * 8 | (*(int *)&gfrgb) >> (3 - tu1) * 8;
        save.r = gfrgb.r;
        save.g = gfrgb.g;
        save.b = gfrgb.b;
        save.cd = gfrgb.cd;
        mtx2.t[1] = 0;
        mtx2.m[2][0] = 0;
        mtx2.m[2][1] = 0;
        mtx2.t[0] = 0;
        gfrgb.g = gfrgb.g >> 1;
        gfrgb.r = tu2 >> 1;
        gfrgb.cd = CVar5.cd;
        gfrgb.b = gfrgb.b >> 1;
        (*(int *)((u_char *)&(mtx2.m[1]) + 2)) = ti13;
        (*(int *)((u_char *)&(mtx2) + 16)) = ti13;
        Flare_IdentMatrix(mtx);
gte_SetTransMatrix(&diff);
        RotMatrixZ(0x800,mtx);
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
        Flare_ReflectHexFlare((long *)&sp,otz);
        gfrgb.r = save.r;
        gfrgb.g = save.g;
        gfrgb.b = save.b;
        gfrgb.cd = save.cd;
      }
      p = Render_gPacketPtr;
      primPtr = otz * 4 + (int)Render_gPalettePtr;
      *(u_int *)Render_gPacketPtr =
           *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)primPtr & 0xffffff;
      tu14 = (u_int)Render_gPacketPtr & 0xffffff;
      pDVar13 = (DVECTOR *)(*(u_int *)primPtr & 0xff000000 | tu14);
      Render_gPacketPtr = Render_gPacketPtr + 0xc;
      *(DVECTOR **)primPtr = pDVar13;
      SetDrawMode((DR_MODE *)p,0,(u_int)((flagsMasked & 0x40U) != 0),0x120,(RECT *)0x0);
    }
  }
  return &pDVar13->vx;
}

/* ---- Flare_Halo2__FP13DRender_tViewiiP8coorddefT3P15Draw_FlareCache  [FLARE.CPP:845-1094] SLD-VERIFIED ---- */
int Flare_Halo2(DRender_tView *Vi,int scale,int type,coorddef *fpt,coorddef *fpt2,
              Draw_FlareCache *arg5)

{
  u_char u0_byte;
  long result;
  int pkt_addr24;
  int CVar3;
  int CVar4;
  u_char u1_byte;
  DVECTOR *pDVar1;
  int tpage_word;
  int angleOuter;
  u_char v0_byte;
  int dx;
  int otz_00;
  u_int color_pack;
  int iVar2;
  DR_MODE *aprim;
  int dy;
  int dz;
  int tz;
  int ty;
  int primPtr;
  int tp7;
  int tx;
  int difx;
  long dify;
  int flare_type;
  int y;
  int flags;
  int halfHeight;
  int z;
  long angleZ;
  long r;
  int loc_e0;
  VECTOR diff;
  SVECTOR sdiff;
  VECTOR tvec;
  VECTOR tvec2;
  SVECTOR sdiff2;
  CVECTOR color [2];
  DVECTOR sp;
  VECTOR diff2;
  DVECTOR sp2;
  MATRIX mtx;
  MATRIX mtx2;
  MATRIX scalemat;
  int otz;
  int loc_28;
  int loc_24;
  int loc_20;
  int loc_1c;
  int loc_18;
  int loc_14;
  int loc_10;
  int loc_c;
  int loc_8;
  u_char tc1;
  u_char *p;
  u_char *tp2;
  
  flare_type = type & 0xff;
  halfHeight = Flare_gType[flare_type].flags;
  r = 0;
  if (fpt2 == (coorddef *)0x0) {
    halfHeight = halfHeight & 0xfffffffa;
  }
  {
    coorddef *t;
    t = (coorddef *)((char *)Vi + 8);
    tx = *(int *)t;
    ty = *(int *)((char *)t + 4);
    tz = *(int *)((char *)t + 8);
    dx = *(int *)fpt - tx;
    dy = *(int *)((char *)fpt + 4) - ty;
    dz = *(int *)((char *)fpt + 8) - tz;
    sdiff.vx = (short)(dx >> 10);
    sdiff.vy = (short)(dy >> 10);
    sdiff.vz = (short)(dz >> 10);
    if ((halfHeight & 5U) != 0) {
      dx = *(int *)fpt2 - tx;
      dy = *(int *)((char *)fpt2 + 4) - ty;
      dz = *(int *)((char *)fpt2 + 8) - tz;
      sdiff2.vx = (short)(dx >> 10);
      sdiff2.vy = (short)(dy >> 10);
      sdiff2.vz = (short)(dz >> 10);
    }
  }
  if ((halfHeight & 0x10U) == 0) {
    if ((halfHeight & 0x20U) == 0) goto FlareHalo2_rtpsEmit;
    pkt_addr24 = simGlobal.gameTicks + 0x1b >> 5;
  }
  else {
    pkt_addr24 = simGlobal.gameTicks >> 6;
  }
  if ((pkt_addr24 & 1U) != 0) {
    return pkt_addr24 & 1U;
  }
FlareHalo2_rtpsEmit:
  Flare_SetMatrix(&gWorldMat);
gte_lwc2(0,*(int *)(&sdiff));
  gte_lwc2(1,*(int *)(((char *)&sdiff + 0x4)));
  gte_rtps();
  CVar3 = Flare_gType[flare_type].chalo;
  CVar4 = Flare_gType[flare_type].cbeam;
  if (scale == -1) {
    scale = Flare_gType[flare_type].scale;
  }
gte_swc2(0x19,&diff);
  gte_swc2(0x1a,((char *)&diff + 0x4));
  gte_swc2(0x1b,((char *)&diff + 0x8));
  pDVar1 = (DVECTOR *)-diff.vx;
  if (((diff.vx <= diff.vz) &&
      (pDVar1 = (DVECTOR *)(u_int)(diff.vz < 0x80), (int)-diff.vx <= diff.vz)) &&
     (pDVar1 = &sp, (DVECTOR *)(u_int)(diff.vz < 0x80) == (DVECTOR *)0x0)) {
gte_swc2(0xe,&sp);
gte_stsz(&otz);
    otz_00 = otz >> 1;
    pDVar1 = (DVECTOR *)otz;
    if ((-1 < otz_00) && (pDVar1 = (DVECTOR *)(halfHeight & 0x80), otz_00 <= Draw_gViewOtSize + -3))
    {
      color[0] = (*(CVECTOR *)&(CVar3));
      color[1] = (*(CVECTOR *)&(CVar4));
      if (pDVar1 != (DVECTOR *)0x0) {
        tpage_word = random();
        scale = scale + ((u_int)tpage_word % 0x14) * 4;
        color[0].r = (u_char)CVar3;
        color[0].g = (u_char)((u_int)CVar3 >> 8);
        tc1 = (u_char)((u_int)tpage_word % 0x14);
        u0_byte = color[0].r + tc1;
        color[0].b = (u_char)((u_int)CVar3 >> 0x10);
        v0_byte = color[0].g + tc1;
        color[0].g = v0_byte;
        color[0].r = u0_byte;
        color[1].r = (u_char)CVar4;
        u1_byte = color[0].b + tc1;
        color[0].cd = (u_char)((u_int)CVar3 >> 0x18);
        color[0].b = u1_byte;
        color[1].g = (u_char)((u_int)CVar4 >> 8);
        color[1].b = (u_char)((u_int)CVar4 >> 0x10);
        color[1].g = color[1].g + tc1;
        color[1].r = color[1].r + tc1;
        color[1].cd = (u_char)((u_int)CVar4 >> 0x18);
        color[1].b = color[1].b + tc1;
      }
      tp2 = Render_gPacketPtr;
      if ((halfHeight & 8U) != 0) {
        r = ((int)sp.vx + (int)sp.vy) * 4;
      }
      gfrgb = color[0];
      gfrgb2 = color[1];
      gscale = scale;
      if ((halfHeight & 0x40U) != 0) {
        primPtr = otz_00 * 4 + (int)Render_gPalettePtr;
        *(u_int *)Render_gPacketPtr =
             *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)primPtr & 0xffffff;
        color_pack = (u_int)Render_gPacketPtr & 0xffffff;
        Render_gPacketPtr = Render_gPacketPtr + 0xc;
        *(u_int *)primPtr = *(u_int *)primPtr & 0xff000000 | color_pack;
        SetDrawMode((DR_MODE *)tp2,0,0,0x120,(RECT *)0x0);
      }
      if ((halfHeight & 5U) != 0) {
gte_lwc2(0,*(int *)(&sdiff2));
        gte_lwc2(1,*(int *)(((char *)&sdiff2 + 0x4)));
        gte_rtps();
gte_swc2(0x19,&diff2);
        gte_swc2(0x1a,((char *)&diff2 + 0x4));
        gte_swc2(0x1b,((char *)&diff2 + 0x8));
gte_swc2(0xe,&sp2);
      }
      if ((halfHeight & 4U) == 0) {
        if ((halfHeight & 1U) != 0) {
          tvec.vx = diff.vx - diff2.vx;
          tvec.vy = diff.vy - diff2.vy;
          tvec.vz = diff.vz - diff2.vz;
          VectorNormal(&tvec,&tvec2);
          if ((halfHeight & 2U) != 0) {
            tvec2.vz = (tvec2.vz + -0xf33) * 0x14;
          }
          iVar2 = tvec2.vz + -600;
          if (iVar2 < 0) {
            iVar2 = 0;
          }
          if (iVar2 == 0) {
            return tvec2.vz;
          }
          gscale = gscale * iVar2 >> 0xb;
          tvec2.vz = iVar2;
          if (type == 0x1e) {
            if (diff.vz < 0) {
              diff.vz = diff.vz + 3;
            }
            diff.vz = diff.vz >> 2;
          }
        }
        mtx2.m[2][2] = 0;
        (*(u_short *)((u_char *)&(mtx2) + 18)) = 0;
        mtx2.m[0][2] = 0;
        mtx2.m[1][0] = 0;
        mtx2.m[2][0] = 0;
        mtx2.m[2][1] = 0;
        mtx2.m[0][0] = (u_short)gscale;
        mtx2.m[0][1] = (*(u_short *)((u_char *)&(gscale) + 2));
        mtx2.m[1][1] = (u_short)gscale;
        mtx2.m[1][2] = (*(u_short *)((u_char *)&(gscale) + 2));
        Flare_IdentMatrix(&mtx);
gte_SetTransMatrix(&diff);
        RotMatrixZ(r,&mtx);
gte_SetRotMatrix(&mtx2);
gte_ldsv(&scalemat);
        gte_rtir();
gte_stsv(&scalemat);
gte_ldsv(((char *)&scalemat + 0x2));
        gte_rtir();
gte_stsv(((char *)&scalemat + 0x2));
gte_ldsv(((char *)&scalemat + 0x4));
        gte_rtir();
gte_stsv(((char *)&scalemat + 0x4));
gte_SetRotMatrix(&scalemat);
      }
      else {
        y = (int)sp2.vy - (int)sp.vy;
        difx = (int)sp2.vx - (int)sp.vx;
        angleOuter = fixedatan(y,difx);
        int sizeOuter = isqrt(difx * difx + y * y);
        Flare_IdentMatrix(&mtx);
        Flare_IdentMatrix(&mtx2);
gte_SetTransMatrix(&diff);
        RotMatrixZ(r,&mtx);
        RotMatrixZ(angleOuter >> 4,&mtx2);
gte_SetRotMatrix(&mtx);
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
gte_ldsv(&scalemat);
        gte_rtir();
gte_stsv(&mtx);
gte_ldsv(((char *)&scalemat + 0x2));
        gte_rtir();
gte_stsv(((char *)&mtx + 0x2));
gte_ldsv(((char *)&scalemat + 0x4));
        gte_rtir();
gte_stsv(((char *)&mtx + 0x4));
gte_SetRotMatrix(&mtx);
      }
      if (diff.vz < 0xc80) {
        Flare_OctFlareSpikes((long *)&sp,otz_00);
      }
      else if (diff.vz < 0x1b80) {
        Flare_HexFlare((long *)&sp,otz_00);
        Flare_PreCalcHexLightBeam((long *)&sp,otz_00);
      }
      else {
        Flare_QuadFlare((long *)&sp,otz_00);
      }
      p = Render_gPacketPtr;
      tp7 = otz_00 * 4 + (int)Render_gPalettePtr;
      *(u_int *)Render_gPacketPtr = *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)tp7 & 0xffffff
      ;
      pDVar1 = (DVECTOR *)(*(u_int *)tp7 & 0xff000000 | (u_int)Render_gPacketPtr & 0xffffff);
      Render_gPacketPtr = Render_gPacketPtr + 0xc;
      *(DVECTOR **)tp7 = pDVar1;
      SetDrawMode((DR_MODE *)p,0,(u_int)((halfHeight & 0x40U) != 0),0x120,(RECT *)0x0);
    }
  }
  return (int)pDVar1;
}

/* ---- Flare_Halo__FP13DRender_tViewiiP8coorddefP15Draw_FlareCache  [FLARE.CPP:1097-1098] SLD-VERIFIED ---- */
void Flare_Halo(DRender_tView *Vi,int scale,int type,coorddef *fpt,Draw_FlareCache *sd)

{
  Flare_Halo2(Vi,scale,type,fpt,(coorddef *)0x0,sd);
  return;
}

/* ---- Flare_2DSpike__FPlT0i  [FLARE.CPP:1105-1120] SLD-VERIFIED ---- */
void Flare_2DSpike(long *center,long *end,int otz)

{
  int tl2;
  int tl3;
  u_int *prev_pkt_slot;
  long pt [2];
  u_char *prim;
  void *tp1;
  CVECTOR CVar1;
  
  prim = Render_gPacketPtr;
  tl2 = *center;
  tl3 = *end;
  prev_pkt_slot = (u_int *)(Render_gPalettePtr + otz * 4);
  *(u_int *)Render_gPacketPtr = *(u_int *)Render_gPacketPtr & 0xff000000 | *prev_pkt_slot & 0xffffff;
  *prev_pkt_slot = *prev_pkt_slot & 0xff000000 | (u_int)Render_gPacketPtr & 0xffffff;
  CVar1 = gfrgb2;
  tp1 = Render_gPacketPtr + 3;
  Render_gPacketPtr = Render_gPacketPtr + 0x14;
  *(u_char *)tp1 = 4;
  *(u_int *)(prim + 0xc) = 0;
  *(CVECTOR *)(prim + 4) = CVar1;
  prim[7] = 0x52;
  *(int *)(prim + 8) = tl2;
  *(int *)(prim + 0x10) = tl3;
  return;
}

/* ---- Flare_2DHalo__Fiiiii  [FLARE.CPP:1125-1211] SLD-VERIFIED ---- */
void Flare_2DHalo(int x,int y,int scalex,int scaley,int type)

{
  int flare_type;
  int drawResult;
  int haloShape_p;
  int pkt_addr24;
  int spritePrim_p;
  short ts9;
  int pkt_addr24_b;
  DR_MODE *aprim;
  DVECTOR *pDVar1;
  int i;
  int iVar2;
  Draw_FlareCache *sd;
  DVECTOR *pt;
  int otz;
  short ts10;
  int loc_60;
  DVECTOR pt2;
  DVECTOR npt [2];
  DVECTOR save1;
  DVECTOR octring [8];
  u_char *p;
  u_char *tp3;
  u_char *tp2;
  u_char *tp1;
  
  tp2 = Render_gPacketPtr;
  tp1 = Render_gPalettePtr;
  ts9 = (short)x;
  ts10 = (short)y;
  if (Render_gPacketPtr < Render_gPacketEnd + -0x1000) {
    gfrgb = (*(CVECTOR *)&(Flare_gType[type & 0xffU].chalo));
    gfrgb2 = (*(CVECTOR *)&(Flare_gType[type & 0xffU].cbeam));
    *(u_int *)Render_gPacketPtr =
         *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0xc;
    *(u_int *)tp1 = *(u_int *)tp1 & 0xff000000 | pkt_addr24;
    pt2.vx = ts9;
    pt2.vy = ts10;
    SetDrawMode((DR_MODE *)tp2,0,0,0x120,(RECT *)0x0);
    iVar2 = 0;
    pDVar1 = octring;
    spritePrim_p = (int)Flare_gOct;
    do {
      drawResult = *(short *)spritePrim_p * scalex;
      if (drawResult < 0) {
        drawResult = drawResult + 0xffff;
      }
      pDVar1->vx = (short)((u_int)drawResult >> 0x10);
      haloShape_p = *(short *)(spritePrim_p + 2) * scaley;
      if (haloShape_p < 0) {
        haloShape_p = haloShape_p + 0xffff;
      }
      pDVar1->vy = (short)((u_int)haloShape_p >> 0x10);
      pDVar1 = pDVar1 + 1;
      iVar2 = iVar2 + 1;
      spritePrim_p = spritePrim_p + 8;
    } while (iVar2 < 8);
    pDVar1 = npt + 1;
    save1.vx = octring[0].vx + ts9;
    save1.vy = octring[0].vy + ts10;
    npt[1].vx = octring[1].vx + ts9;
    npt[1].vy = octring[1].vy + ts10;
    Flare_Tri((long *)&pt2,(long *)&save1,(long *)pDVar1,0);
    Flare_2DSpike((long *)&pt2,(long *)pDVar1,0);
    npt[0].vx = octring[2].vx + ts9;
    npt[0].vy = octring[2].vy + ts10;
    Flare_Tri((long *)&pt2,(long *)pDVar1,(long *)npt,0);
    Flare_2DSpike((long *)&pt2,(long *)npt,0);
    npt[1].vx = octring[3].vx + ts9;
    npt[1].vy = octring[3].vy + ts10;
    Flare_Tri((long *)&pt2,(long *)npt,(long *)pDVar1,0);
    Flare_2DSpike((long *)&pt2,(long *)pDVar1,0);
    npt[0].vx = octring[4].vx + ts9;
    npt[0].vy = octring[4].vy + ts10;
    Flare_Tri((long *)&pt2,(long *)pDVar1,(long *)npt,0);
    Flare_2DSpike((long *)&pt2,(long *)npt,0);
    npt[1].vx = octring[5].vx + ts9;
    npt[1].vy = octring[5].vy + ts10;
    Flare_Tri((long *)&pt2,(long *)npt,(long *)pDVar1,0);
    Flare_2DSpike((long *)&pt2,(long *)pDVar1,0);
    npt[0].vx = octring[6].vx + ts9;
    npt[0].vy = octring[6].vy + ts10;
    Flare_Tri((long *)&pt2,(long *)pDVar1,(long *)npt,0);
    Flare_2DSpike((long *)&pt2,(long *)npt,0);
    npt[1].vx = octring[7].vx + ts9;
    npt[1].vy = octring[7].vy + ts10;
    Flare_Tri((long *)&pt2,(long *)npt,(long *)pDVar1,0);
    Flare_2DSpike((long *)&pt2,(long *)pDVar1,0);
    Flare_Tri((long *)&pt2,(long *)pDVar1,(long *)&save1,0);
    Flare_2DSpike((long *)&pt2,(long *)&save1,0);
    p = Render_gPacketPtr;
    tp3 = Render_gPalettePtr;
    *(u_int *)Render_gPacketPtr =
         *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    pkt_addr24_b = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0xc;
    *(u_int *)tp3 = *(u_int *)tp3 & 0xff000000 | pkt_addr24_b;
    SetDrawMode((DR_MODE *)p,0,1,0x120,(RECT *)0x0);
  }
  return;
}

/* ---- Flare_PreCalcHexLightBeam__FPli  [FLARE.CPP:1229-1252] SLD-VERIFIED ---- */
void Flare_PreCalcHexLightBeam(long *center,int otz)

{
  CVECTOR CVar1;
  u_int uVar2;
  u_int uVar3;
  u_int *prim;
  u_int *puVar5;
  u_int uVar6;
  long i;
  int iVar7;
  void *ppuVar8;
  u_int uVar8;
  int iVar9;
  void *ppuVar11;
  long pt [2];
  
  ppuVar8 = &Render_gPacketPtr;
  ppuVar11 = &Render_gPalettePtr;
  iVar9 = otz << 2;
  uVar6 = 0xffffff;
  uVar8 = 0xff000000;
  uVar2 = *center;
  for (iVar7 = 0; iVar7 < 8; iVar7 = iVar7 + 1) {
gte_lwc2(0,*(int *)(&Flare_gOct));
    gte_lwc2(1,*(int *)(((char *)&Flare_gOct + 0x4)));
    prim = *(u_int **)ppuVar8;
    puVar5 = (u_int *)(iVar9 + *(int *)ppuVar11);
    *prim = *prim & uVar8 | *puVar5 & uVar6;
    uVar3 = *puVar5;
    *(u_int **)ppuVar8 = prim + 5;
    *puVar5 = uVar3 & uVar8 | (u_int)prim & uVar6;
    CVar1 = gfrgb2;
    gte_rtps_b();
    *(u_char *)((int)prim + 3) = 4;
    prim[3] = 0;
    *(CVECTOR *)(prim + 1) = CVar1;
    *(u_char *)((int)prim + 7) = 0x52;
gte_swc2(0xe,((char *)&pt + 0x4));
    prim[2] = uVar2;
    prim[4] = pt[1];
  }
  return;
}

/* ---- Flare_Quad__FPlP7CVECTORi  [FLARE.CPP:1305-1315] SLD-VERIFIED ---- */
void Flare_Quad(long *pt,CVECTOR *color,int otz)

{
  int color_word;
  u_int *puVar1;
  int pkt_addr24;
  u_char *prim;
  
  prim = Render_gPacketPtr;
  puVar1 = (u_int *)(Render_gPalettePtr + otz * 4);
  *(u_int *)Render_gPacketPtr = *(u_int *)Render_gPacketPtr & 0xff000000 | *puVar1 & 0xffffff;
  pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0x18;
  *puVar1 = *puVar1 & 0xff000000 | pkt_addr24;
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
  u_int *puVar1;
  int pkt_addr24;
  u_char *prim;
  
  prim = Render_gPacketPtr;
  puVar1 = (u_int *)(Render_gPalettePtr + otz * 4);
  *(u_int *)Render_gPacketPtr = *(u_int *)Render_gPacketPtr & 0xff000000 | *puVar1 & 0xffffff;
  pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0x18;
  *puVar1 = *puVar1 & 0xff000000 | pkt_addr24;
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
  u_int *puVar1;
  void *prev_pkt_slot;
  u_char *prim;
  
  prim = Render_gPacketPtr;
  puVar1 = (u_int *)(Render_gPalettePtr + otz * 4);
  *(u_int *)Render_gPacketPtr = *(u_int *)Render_gPacketPtr & 0xff000000 | *puVar1 & 0xffffff;
  *puVar1 = *puVar1 & 0xff000000 | (u_int)Render_gPacketPtr & 0xffffff;
  innerColor = *(int *)color;
  prev_pkt_slot = Render_gPacketPtr + 0xc;
  Render_gPacketPtr = Render_gPacketPtr + 0x24;
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
  u_long l3;
  int shape_p;
  int pkt_addr24_b;
  u_long l0;
  int color_word;
  u_long l1;
  u_int uVar1;
  u_long l2;
  u_int uVar2;
  u_int *puVar3;
  int pkt_addr24;
  u_char *prim;
  
  prim = Render_gPacketPtr;
  puVar3 = (u_int *)(Render_gPalettePtr + otz * 4);
  *(u_int *)Render_gPacketPtr = *(u_int *)Render_gPacketPtr & 0xff000000 | *puVar3 & 0xffffff;
  pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0x28;
  *puVar3 = *puVar3 & 0xff000000 | pkt_addr24;
  color_word = *(int *)color;
  prim[3] = 9;
  *(int *)(prim + 4) = color_word;
  prim[7] = 0x2e;
  *(long *)(prim + 8) = *pt;
  *(long *)(prim + 0x10) = pt[1];
  *(long *)(prim + 0x18) = pt[2];
  *(long *)(prim + 0x20) = pt[3];
  shape_p = (int)&gFlarePixmap[(u_char)type];
  uVar1 = *(u_int *)(shape_p + 4);
  uVar2 = *(u_int *)(shape_p + 8);
  pkt_addr24_b = *(int *)(shape_p + 0xc);
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
  short sVar1;
  short sVar2;
  short sVar3;
  int iVar4;
  DVECTOR pt [6];
  
  iVar4 = width;
  if (width < 0) {
    iVar4 = width + 3;
  }
  sVar1 = (short)(iVar4 >> 2);
  pt[0].vx = xy->vx - sVar1;
  sVar2 = (short)(height / 2);
  pt[0].vy = xy->vy + sVar2;
  pt[1].vx = xy->vx + sVar1;
  pt[1].vy = xy->vy + sVar2;
  sVar3 = (short)(width / 2);
  pt[2].vx = xy->vx - sVar3;
  pt[2].vy = xy->vy;
  pt[3].vx = xy->vx + sVar3;
  pt[3].vy = xy->vy;
  pt[4].vx = xy->vx - sVar1;
  pt[4].vy = xy->vy - sVar2;
  pt[5].vx = xy->vx + sVar1;
  pt[5].vy = xy->vy - sVar2;
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
    pDVar3->vx = xy->vx + (short)((u_int)iVar1 >> 8);
    iVar1 = height * pSVar2->vy;
    if (iVar1 < 0) {
      iVar1 = iVar1 + 0xff;
    }
    pSVar2 = pSVar2 + 1;
    iVar4 = iVar4 + 1;
    pDVar3->vy = xy->vy + (short)((u_int)iVar1 >> 8);
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
  int iVar1;
  u_int uVar2;
  int i;
  char index;
  u_int uVar3;
  int height2;
  int width2;
  DVECTOR pt [18];
  
  i = 0;
  uVar3 = 0;
  do {
    iVar1 = i;
    if (i < 0) {
      iVar1 = i + 7;
    }
    uVar2 = i + (iVar1 >> 3) * -8 & 0xff;
    iVar1 = width * Flare_gOct[uVar2].vx;
    uVar3 = uVar3 & 0xff;
    if (iVar1 < 0) {
      iVar1 = iVar1 + 0xff;
    }
    pt[uVar3].vx = xy->vx + (short)((u_int)iVar1 >> 8);
    iVar1 = height * Flare_gOct[uVar2].vy;
    if (iVar1 < 0) {
      iVar1 = iVar1 + 0xff;
    }
    pt[uVar3].vy = xy->vy + (short)((u_int)iVar1 >> 8);
    iVar1 = (width + -5) * (int)Flare_gOct[uVar2].vx;
    if (iVar1 < 0) {
      iVar1 = iVar1 + 0xff;
    }
    pt[uVar3 + 1].vx = xy->vx + (short)((u_int)iVar1 >> 8);
    iVar1 = (height + -5) * (int)Flare_gOct[uVar2].vy;
    if (iVar1 < 0) {
      iVar1 = iVar1 + 0xff;
    }
    i = i + 1;
    pt[uVar3 + 1].vy = xy->vy + (short)((u_int)iVar1 >> 8);
    uVar3 = i * 2;
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
  int screen_y_pos;
  int piece_y;
  int piece_x;
  long result;
  int screen_x_pos;
  int piece_iter_a;
  u_int tu1;
  DR_MODE *aprim;
  int width;
  int height;
  int ti7;
  FLARE_PIECE_DEF *piece;
  int piece_iter_b;
  int i;
  int pieceCount;
  int piece_idx;
  long angleZ;
  char flareVis;
  int flareVis_long;
  int piece_color;
  int sy;
  int sx;
  int loc_a8;
  int loc_a4;
  DVECTOR pxy;
  DVECTOR pt [4];
  CVECTOR col;
  MATRIX scalemat;
  MATRIX mtx;
  int dx;
  int dy;
  long angleZ2;
  int loc_28;
  int loc_24;
  int loc_20;
  int tF1;
  short ts1;
  short ts2;
  u_char *p;
  u_char *tp3;
  
  if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr + -0x400) {
    pieceCount = 0;
    ts1 = screenPos->vx;
    screen_y_pos = (int)ts1;
    ts2 = screenPos->vy;
    screen_x_pos = (int)ts2;
    col.r = 0xff;
    col.g = 0xff;
    col.b = 0xff;
    col.cd = '\0';
    pt[0].vx = ts1 + -2;
    pt[0].vy = ts2 + -2;
    pt[1].vx = ts1 + 3;
    pt[2].vy = ts2 + 3;
    pt[1].vy = pt[0].vy;
    pt[2].vx = pt[0].vx;
    pt[3].vx = pt[1].vx;
    pt[3].vy = pt[2].vy;
    Flare_QuadNotTransparent((long *)pt,&col,Draw_gViewOtSize + -2);
    flareVis_long = 0;
    piece_iter_a = (int)&gFlare_LensFlare;
    gFlare_LensFlare.isDrawn[0] = '\x01';
    gFlare_LensFlare.oldpos[0].vx = gFlare_LensFlare.pos[0].vx;
    gFlare_LensFlare.oldpos[0].vy = gFlare_LensFlare.pos[0].vy;
    do {
      if ((*(u_short *)(piece_iter_a + 0x10) & 0x7fff) == 0x7fff) {
        flareVis_long = flareVis_long + 1;
      }
      pieceCount = pieceCount + 1;
      piece_iter_a = piece_iter_a + 2;
    } while (pieceCount < 0x19);
    piece_color = flareVis_long & 0xff;
    gFlare_LensFlare.pos[0].vx = ts1;
    gFlare_LensFlare.pos[0].vy = ts2;
    if (piece_color != 0) {
      gfrgb2 = TrackSpec_gSpec.skyspec.sunBeamColor;
      Flare_IdentMatrix(&mtx);
      RotMatrixZ((screen_y_pos + screen_x_pos) * 8,&mtx);
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
      RotMatrixZ((screen_y_pos + screen_x_pos) * 6,&mtx);
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
        piece_iter_b = (int)(gFlare_LensFlare.piece + piece_idx);
        piece_y = (0x10000 - *(int *)piece_iter_b) * screen_y_pos +
                  *(int *)piece_iter_b * (0x140 - screen_y_pos);
        if (piece_y < 0) {
          piece_y = piece_y + 0xffff;
        }
        pxy.vx = (short)((u_int)piece_y >> 0x10);
        piece_x = (0x10000 - *(int *)piece_iter_b) * screen_x_pos +
                  *(int *)piece_iter_b * (0xf0 - screen_x_pos);
        if (piece_x < 0) {
          piece_x = piece_x + 0xffff;
        }
        pxy.vy = (short)((u_int)piece_x >> 0x10);
        ti7 = gFlare_LensFlare.size * *(int *)(piece_iter_b + 4);
        if (ti7 < 0) {
          ti7 = ti7 + 0xffff;
        }
        ti7 = ti7 >> 0x10;
        if (ti7 < 4) goto switchD_800cf0c0_default;
        pt[0].vx = CONCAT11((char)(((u_int)*(u_char *)(piece_iter_b + 9) * piece_color) / 0x19),
                            (char)(((u_int)*(u_char *)(piece_iter_b + 8) * piece_color) / 0x19));
        pt[0].vy = CONCAT11(((u_char *)&(pt[0].vy))[1],
                            (char)(((u_int)*(u_char *)(piece_iter_b + 10) * piece_color) / 0x19));
        switch(*(u_char *)(piece_iter_b + 0xc)) {
        case 0:
        case 1:
          Flare_SingleColorTex(&pxy,(CVECTOR *)pt,ti7,ti7,*(char *)(piece_iter_b + 0xc),0);
          piece_idx = piece_idx + 1;
          break;
        case 2:
          Flare_SingleColorHex((DVECTOR *)piece_iter_b,(CVECTOR *)pt,ti7,ti7,0);
          piece_idx = piece_idx + 1;
          break;
        case 3:
          Flare_SingleColorOct(&pxy,(CVECTOR *)pt,ti7,ti7,0);
          piece_idx = piece_idx + 1;
          break;
        case 4:
          Flare_SingleColorOctRing(&pxy,(CVECTOR *)pt,ti7,ti7,0);
        default:
switchD_800cf0c0_default:
          piece_idx = piece_idx + 1;
        }
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
  u_char *puVar1;
  int dvz;
  int pkt_addr24_a;
  int pkt_addr24_b;
  DR_MODE *aprim;
  DVECTOR *screenPos;
  short vertRezBy2;
  int pshift;
  int screenX;
  int shape_p;
  int screenY;
  int cur_pkt_a;
  int cur_pkt_b;
  int vis_test;
  int otz;
  int otz_00;
  VECTOR diff;
  CVECTOR color;
  DVECTOR posOnScreen;
  MATRIX scalemat;
  void *tp1;
  void *p;
  
  shape_p = (int)&GameSetup_gData;
  vis_test = 1;
  (*(u_short *)&(pshift)) = 0x78;
  vertRezBy2 = (short)pshift;
  if (GameSetup_gData.commMode == 1) {
    vertRezBy2 = 0x3c;
  }
  if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr + -0x400) {
gte_lwc2(0,*(int *)(worldPos));
    gte_lwc2(1,*(int *)(((char *)worldPos + 0x4)));
    gte_rtps();
gte_swc2(0x19,&diff);
    gte_swc2(0x1a,((char *)&diff + 0x4));
    gte_swc2(0x1b,((char *)&diff + 0x8));
    if ((diff.vx <= diff.vz) && (-diff.vx <= diff.vz)) {
      screenPos = &posOnScreen;
gte_swc2(0xe,&posOnScreen);
      screenY = *(int *)(shape_p + 0xc);
      posOnScreen.vy = (short)(diff.vy >> 2) + vertRezBy2;
      screenX = (int)posOnScreen.vx;
gte_SetTransMatrix(&diff);
      if ((screenX < 0x13d) &&
         ((screenY != vis_test && ((TrackSpec_gSpec.skyspec.flags & 0x100U) == 0)))) {
        Flare_LensFlare(screenPos,sd);
      }
      puVar1 = Render_gPacketPtr;
      gfrgb.r = 0x80;
      gfrgb.g = 0x80;
      gfrgb.b = 0x80;
      gfrgb.cd = '\0';
      otz_00 = Draw_gViewOtSize + -2;
      cur_pkt_a = otz_00 * 4 + (int)Render_gPalettePtr;
      *(u_int *)Render_gPacketPtr =
           *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)cur_pkt_a & 0xffffff;
      pkt_addr24_a = (u_int)Render_gPacketPtr & 0xffffff;
      Render_gPacketPtr = Render_gPacketPtr + 0xc;
      *(u_int *)cur_pkt_a = *(u_int *)cur_pkt_a & 0xff000000 | pkt_addr24_a;
      SetDrawMode((DR_MODE *)puVar1,0,0,0x120,(RECT *)0x0);
gte_SetRotMatrix(&scalemat);
      if ((TrackSpec_gSpec.skyspec.flags & 0x100U) == 0) {
        Flare_OctFlare((long *)&posOnScreen,otz_00);
      }
      else {
        Flare_SingleColorTex(&posOnScreen,&TrackSpec_gSpec.skyspec.sunHaloColor,0x10,0x10,'\0',otz_00);
      }
      puVar1 = Render_gPacketPtr;
      cur_pkt_b = otz_00 * 4 + (int)Render_gPalettePtr;
      *(u_int *)Render_gPacketPtr =
           *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)cur_pkt_b & 0xffffff;
      pkt_addr24_b = (u_int)Render_gPacketPtr & 0xffffff;
      Render_gPacketPtr = Render_gPacketPtr + 0xc;
      *(u_int *)cur_pkt_b = *(u_int *)cur_pkt_b & 0xff000000 | pkt_addr24_b;
      SetDrawMode((DR_MODE *)puVar1,0,0,0x120,(RECT *)0x0);
    }
  }
  return;
}

/* ---- Flare_Moon__FP7SVECTORP15Draw_FlareCache  [FLARE.CPP:1822-1864] SLD-VERIFIED ---- */
void Flare_Moon(SVECTOR *worldPos,Draw_FlareCache *sd)

{
  char i2;
  int dvz;
  DVECTOR *xy;
  int pshift;
  int dz;
  char index;
  int height2;
  int width2;
  int difx;
  int flare_type;
  int sizeOuter;
  int flags;
  char flareVis;
  int angleZ;
  int sy;
  int cent;
  SVECTOR sdiff;
  SVECTOR sdiff2;
  DVECTOR sp;
  DVECTOR pxy;
  CVECTOR save;
  CVECTOR col;
  MATRIX mtx2;
  DVECTOR npt [2];
  VECTOR diff;
  CVECTOR color;
  DVECTOR posOnScreen;
  
  (*(u_short *)&(pshift)) = 0x78;
  if (GameSetup_gData.commMode == 1) {
    (*(u_short *)&(pshift)) = 0x3c;
  }
gte_lwc2(0,*(int *)(worldPos));
  gte_lwc2(1,*(int *)(((char *)worldPos + 0x4)));
  gte_rtps();
  color.r = 0x80;
  color.g = 0x80;
  color.b = 0x80;
  color.cd = '\0';
gte_swc2(0x19,&diff);
  gte_swc2(0x1a,((char *)&diff + 0x4));
  gte_swc2(0x1b,((char *)&diff + 0x8));
  xy = &posOnScreen;
gte_swc2(0xe,&posOnScreen);
  posOnScreen.vy = (short)(diff.vy >> 2) + (short)pshift;
  if ((diff.vx <= diff.vz) && (-diff.vx <= diff.vz)) {
    Flare_SingleColorTex(xy,&color,0x10,0x10,'\0',Draw_gViewOtSize + -2);
  }
  return;
}

/* end of flare.cpp */
