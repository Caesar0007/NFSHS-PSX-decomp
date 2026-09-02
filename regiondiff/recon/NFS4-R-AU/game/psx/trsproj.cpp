/* game/psx/trsproj.cpp -- RECONSTRUCTED (NFS4 PSX transform + projection; C++ TU)
 *   11 free fns TrsProj_*: GTE projection setup (SetProjection/SetMenuProjection), camera matrix
 *   load (SetPsxMatrix/SetPsxTrans), and point/vertex transform (TransPt/TransPtN16/
 *   TransformProjectVertex). GTE COP2 ops via PsyQ libgte macros (trsproj_externs.h).
 */
#include "trsproj_types.h"
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
  gte_SetGeomOffset(cx + w / 2,cy + h / 2);
}

/* ---- TrsProj_SetViewTrsProjEnviro__FP13DRender_tView  [TRSPROJ.CPP:76-100] SLD-VERIFIED ---- */
void TrsProj_SetViewTrsProjEnviro(DRender_tView *Vi)

{
  /* REGIONAL (R-AU/FR-DE/UK-ES-IT/UK-SW = the PAL builds): the projection
   * viewport HEIGHT is the PAL 256-line frame, not the NTSC 240-line one --
   * 0x78/0xf0 (120/240) in the base become 0x80/0x100 (128/256).  The width
   * argument 0x140 (320) is unchanged.  AUDIT_LO16 insn 10: 24070078 ->
   * 24070080, insn 14: 240700f0 -> 24070100. */
  if (TrsProj_GameSetupWords[3] == 1) {
    TrsProj_SetProjection(0,0,0x140,0x80);
  }
  else {
    TrsProj_SetProjection(0,0,0x140,0x100);
  }
  return;
}

/* ---- TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef  [TRSPROJ.CPP:137-151] SLD-VERIFIED ---- */
#define TRSPROJ_SET_MATRIX_ROW(row, i0, i1, i2) \
{ \
  int r0 = (int)m->m[i0] >> 4; \
  int r1 = (int)m->m[i1] >> 4; \
  int r2 = (int)m->m[i2] >> 4; \
  mpsx.m[row][0] = (short)r0; \
  mpsx.m[row][1] = (short)r1; \
  mpsx.m[row][2] = (short)r2; \
}

void TrsProj_SetPsxMatrix(matrixtdef *m,coorddef *t)
{
  MATRIX mpsx;

  /* SYM-MACRO-LOCALS: r0, r1, r2 = TRSPROJ_SET_MATRIX_ROW x3
   * Retail records three nested line-1 blocks, each with INT r0/r1/r2.
   * The expansion shape is authoritative; the descriptive macro name is not
   * recoverable from this SYM. */
  TRSPROJ_SET_MATRIX_ROW(0, 0, 3, 6);
  TRSPROJ_SET_MATRIX_ROW(1, 1, 4, 7);
  TRSPROJ_SET_MATRIX_ROW(2, 2, 5, 8);
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

#undef TRSPROJ_SET_MATRIX_ROW

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
  gte_mvmva(1,0,0,0,0);
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

  for (n = n - 1; n != -1; n = n - 1) {
    pt.vx = s->x;
    pt.vy = 0;
    pt.vz = s->z;
    gte_ldv0(&pt);
    gte_mvmva(1,0,0,0,0);
    gte_stlvnl(&tv);
    s = s + 1;
    d->x = tv.vx;
    d->y = tv.vy;
    d->z = tv.vz;
    d = d + 1;
  }
}

/* ---- TrsProj_TransformProjectVertex__FP10matrixtdefP8coorddefiT1P12Draw_tVertex  [TRSPROJ.CPP:250-264] SLD-VERIFIED ----
 * PASS 56/56 insns, 0 diffs (verify_asm). Prior 18-diff residual was a pure $s1<->$s2 coalescing
 * swap (v<->i; SYM-confirmed: v=class REG value 0x12=$s2, i=class REG value 0x11=$s1, both
 * REGPARM/REG values matching the oracle 1:1 -- m/t/n/s REGPARM 0x17/0x14/0x15/0x13=$s7/$s4/$s5/$s3
 * all confirmed too). Cracked via §3.12 lever #15 LOOP-SHAPE: the `do{...}while(i<n)` guarded by
 * an outer `if(0<n)` (with `i=i+1` mid-body, between the x-store and y-store) does NOT reproduce
 * the oracle's coloring; a plain `for(i=0;i<n;i=i+1){...}` with the increment at its natural
 * for-loop position does. (decl-order swap and Yoda-vs-normal compare form alone are no-ops, as
 * previously found -- it's the do/if-guard-vs-for loop SHAPE that was the actual lever.) */
void TrsProj_TransformProjectVertex(matrixtdef *m,coorddef *t,int n,coorddef *s,Draw_tVertex *v)
{
  coorddef tmp;
  int i;

  for (i = 0; i < n; i = i + 1) {
    transform(&s->x,m->m,&tmp.x);
    s = s + 1;
    v->sv.x = (short)((tmp.x + t->x) >> 10);
    v->sv.y = (short)((tmp.y + t->y) >> 10);
    v->sv.z = (short)((tmp.z + t->z) >> 10);
    v->sv.p = 10;
    v = v + 1;
  }
}

/* end of trsproj.cpp */
