/* game/psx/trsproj.cpp -- RECONSTRUCTED (NFS4 PSX transform + projection; C++ TU)
 *   11 free fns TrsProj_*: GTE projection setup (SetProjection/SetMenuProjection), camera matrix
 *   load (SetPsxMatrix/SetPsxTrans), and point/vertex transform (TransPt/TransPtN16/
 *   TransformProjectVertex). GTE COP2 ops via PsyQ libgte macros (trsproj_externs.h).
 */
#include "../../nfs4_types.h"
#include "trsproj_externs.h"

/* ---- TrsProj.obj-OWNED global -- DEFINED here (self-contained). .data init = 10 (0x0a)
   read from NFS4.EXE @file_off 0x12e39c; SetPrecision resets it to 10. ---- */
int               TrsProj_precision = 10;   /* @0x8013db9c */

/* fwd decl: SetPsxMatrix calls SetPsxTrans, which is defined further down (VA order) */
void TrsProj_SetPsxTrans(coorddef *t);


/* ---- TrsProj_SetTransPrecision__Fi  [TRSPROJ.CPP:29-30] SLD-VERIFIED ---- */
void TrsProj_SetTransPrecision(int val)

{
  TrsProj_precision = val;
  return;
}

/* ---- TrsProj_ResetTransPrecision__Fv  [TRSPROJ.CPP:41-42] SLD-VERIFIED ---- */
void TrsProj_ResetTransPrecision(void)

{
  TrsProj_precision = 10;
  return;
}

/* ---- TrsProj_SetProjection__Fiiii  [TRSPROJ.CPP:52-63] SLD-VERIFIED ---- */
void TrsProj_SetProjection(int cx,int cy,int w,int h)

{
  
  SetGeomScreen(Camera_gGeomScreen);
  gte_SetGeomOffset(cx + w / 2,cy + h / 2);
  return;
}

/* ---- TrsProj_SetMenuProjection__Fiiii  [TRSPROJ.CPP:67-72] SLD-VERIFIED ---- */
void TrsProj_SetMenuProjection(int cx,int cy,int w,int h)
{
  gte_ctc2(0x200,0x1a);
  gte_ctc2((cx + w / 2) << 0x10,0x18);
  gte_ctc2((cy + h / 2) << 0x10,0x19);
}

/* ---- TrsProj_SetViewTrsProjEnviro__FP13DRender_tView  [TRSPROJ.CPP:76-100] SLD-VERIFIED ---- */
void TrsProj_SetViewTrsProjEnviro(DRender_tView *Vi)

{
  if (GameSetup_gData.commMode == 1) {
    TrsProj_SetProjection(0,0,0x140,0x78);
  }
  else {
    TrsProj_SetProjection(0,0,0x140,0xf0);
  }
  return;
}

/* ---- TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef  [TRSPROJ.CPP:137-151] SLD-VERIFIED ---- */
void TrsProj_SetPsxMatrix(matrixtdef *m,coorddef *t)
{
  int r0;
  int r1;
  int r2;
  MATRIX mpsx;

  mpsx.m[0][0] = (short)((int)m->m[0] >> 4);
  mpsx.m[0][1] = (short)((int)m->m[3] >> 4);
  mpsx.m[0][2] = (short)((int)m->m[6] >> 4);
  mpsx.m[1][0] = (short)((int)m->m[1] >> 4);
  mpsx.m[1][1] = (short)((int)m->m[4] >> 4);
  mpsx.m[1][2] = (short)((int)m->m[7] >> 4);
  mpsx.m[2][0] = (short)((int)m->m[2] >> 4);
  mpsx.m[2][1] = (short)((int)m->m[5] >> 4);
  mpsx.m[2][2] = (short)((int)m->m[8] >> 4);
  gte_SetRotMatrix(&mpsx);
  if (t != (coorddef *)0x0) {
    TrsProj_SetPsxTrans(t);
    return;
  }
  mpsx.t[2] = 0;
  mpsx.t[1] = 0;
  mpsx.t[0] = 0;
  gte_SetTransMatrix(&mpsx);
}

/* ---- TrsProj_SetPsxTrans__FP8coorddef  [TRSPROJ.CPP:157-164] SLD-VERIFIED ---- */
void TrsProj_SetPsxTrans(coorddef *t)
{
  MATRIX mpsx;

  mpsx.t[0] = (int)t->x >> 0xa;
  mpsx.t[1] = (int)t->y >> 0xa;
  mpsx.t[2] = (int)t->z >> 0xa;
  gte_SetTransMatrix(&mpsx);
}

/* ---- TrsProj_SetPsxTransZero__Fv  [TRSPROJ.CPP:168-171] SLD-VERIFIED ---- */
void TrsProj_SetPsxTransZero(void)
{
  MATRIX mpsx;

  mpsx.t[2] = 0;
  mpsx.t[1] = 0;
  mpsx.t[0] = 0;
  gte_SetTransMatrix(&mpsx);
}

/* ---- TrsProj_TransPt__FP8coorddefT0  [TRSPROJ.CPP:177-192] SLD-VERIFIED ---- */
void TrsProj_TransPt(coorddef *s,coorddef *d)
{
  SVECTOR pt;
  VECTOR tv;

  pt.vx = (short)((int)s->x >> 0xa);
  pt.vy = (short)((int)s->y >> 0xa);
  pt.vz = (short)((int)s->z >> 0xa);
  gte_ldv0(&pt);
  gte_mvmva();
  gte_stlvnl(&tv);
  d->x = tv.vx << 0xa;
  d->y = tv.vy << 0xa;
  d->z = tv.vz << 0xa;
}

/* ---- TrsProj_TransPtN16__FP10RelCoord16P8coorddefi  [TRSPROJ.CPP:224-243] SLD-VERIFIED ---- */
void TrsProj_TransPtN16(RelCoord16 *s,coorddef *d,int n)
{
  SVECTOR pt;
  VECTOR tv;
  int i;

  if (n != 0) {
    i = n + -1;
    do {
      pt.vy = 0;
      pt.vx = s->x;
      pt.vz = s->z;
      gte_ldv0(&pt);
      gte_mvmva();
      gte_stlvnl(&tv);
      s = s + 1;
      d->x = tv.vx;
      d->y = tv.vy;
      i = i + -1;
      d->z = tv.vz;
      d = d + 1;
    } while (i != -1);
  }
}

/* ---- TrsProj_TransformProjectVertex__FP10matrixtdefP8coorddefiT1P12Draw_tVertex  [TRSPROJ.CPP:250-264] SLD-VERIFIED ---- */
void TrsProj_TransformProjectVertex(matrixtdef *m,coorddef *t,int n,coorddef *s,Draw_tVertex *v)
{
  coorddef tmp;
  int i;

  i = 0;
  if (0 < n) {
    do {
      transform(&s->x,m->m,&tmp.x);
      s = s + 1;
      v->sv.x = (short)((tmp.x + t->x) >> 10);
      i = i + 1;
      v->sv.y = (short)((tmp.y + t->y) >> 10);
      v->sv.p = 10;
      v->sv.z = (short)((tmp.z + t->z) >> 10);
      v = v + 1;
    } while (i < n);
  }
}

/* end of trsproj.cpp */
