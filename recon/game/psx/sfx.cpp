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
  ident.m[0][0] = 0x1000; ident.m[0][1] = 0; ident.m[0][2] = 0;
  ident.m[1][0] = 0; ident.m[1][1] = 0x1000; ident.m[1][2] = 0;
  ident.m[2][0] = 0; ident.m[2][1] = 0; ident.m[2][2] = 0x1000;
  ident.t[0] = 0; ident.t[1] = 0; ident.t[2] = 0;
  gte_SetRotMatrix(&ident);
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
  cosa = fixedmult(intcos(is->angle),radius);
  sina = fixedmult(intsin(is->angle),radius);
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
  pxp = fixedmult(0xe666,-intcos(angle)) >> 1;
  pzp = fixedmult(0xe666,intsin(angle)) >> 1;
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

/* ---- Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache  [SFX.CPP:306-363] SLD-VERIFIED ---- */
void Sfx_AdditivePrim(Draw_tPixMap *pmx,SVECTOR *pt,int mode,int offset,Sfx_tCache *sd)

{
  POLY_FT4 *prim;
  u_long l0;
  u_long l1;
  u_long l2;
  u_long l3;
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
    gte_stsz(&sd->otz);
    sd->otz = (sd->otz >> 1) + offset;
    if ((-1 < sd->otz) && (sd->otz <= Draw_gViewOtSize + -3)) {
      prim->code = 9;
      l1 = *(u_int *)&pmx->u1;
      l2 = *(u_int *)&pmx->u2;
      l3 = *(u_int *)&pmx->u3;
      *(u_int *)&prim->u0 = *(u_int *)&pmx->u0;
      *(u_int *)&prim->u1 = l1;
      *(u_int *)&prim->u2 = l2;
      *(u_int *)&prim->u3 = l3;
      tpage = pmx->tpage;
      ChangeTPage(&tpage,(mode & 1U) == 0 ? 1 : 2);
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

/* ---- Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle  [SFX.CPP:367-525] SLD-VERIFIED ---- */
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

  sd = &Sfx_gCache;
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
    cosa = fixedmult(intcos(is->angle),radius);
    sina = fixedmult(intsin(is->angle),radius);
    goto SfxSouffle_billboard;
  case 7:
    radius = (8 - (u_char)is->cycle) * 4 + 0x19;
    cosa = fixedmult(intcos(is->angle),radius);
    sina = fixedmult(intsin(is->angle),radius);
    dSouffle.v0.vx = is->trans.vx - (short)sina;  dSouffle.v0.vy = is->trans.vy + (short)cosa;  dSouffle.v0.vz = is->trans.vz;
    dSouffle.v1.vx = is->trans.vx + (short)cosa;  dSouffle.v1.vy = is->trans.vy + (short)sina;  dSouffle.v1.vz = is->trans.vz;
    dSouffle.v2.vx = is->trans.vx + (short)sina;  dSouffle.v2.vy = is->trans.vy - (short)cosa;  dSouffle.v2.vz = is->trans.vz;
    dSouffle.v3.vx = is->trans.vx - (short)cosa;  dSouffle.v3.vy = is->trans.vy - (short)sina;  dSouffle.v3.vz = is->trans.vz;
    Sfx_BuildFastDisolveFacet(is,&dSouffle,gGravelPixmap[is->rndpixmap],gGrassPalette);
    Sfx_AdditivePrim(&dSouffle.pmx,&dSouffle.v0,0,0xf,sd);
    break;
  case 9:
    radius = (8 - (u_char)is->cycle) * 4 + 0x19;
    cosa = fixedmult(intcos(is->angle),radius);
    sina = fixedmult(intsin(is->angle),radius);
    dSouffle.v0.vx = is->trans.vx - (short)sina;  dSouffle.v0.vy = is->trans.vy + (short)cosa;  dSouffle.v0.vz = is->trans.vz;
    dSouffle.v1.vx = is->trans.vx + (short)cosa;  dSouffle.v1.vy = is->trans.vy + (short)sina;  dSouffle.v1.vz = is->trans.vz;
    dSouffle.v2.vx = is->trans.vx + (short)sina;  dSouffle.v2.vy = is->trans.vy - (short)cosa;  dSouffle.v2.vz = is->trans.vz;
    dSouffle.v3.vx = is->trans.vx - (short)cosa;  dSouffle.v3.vy = is->trans.vy - (short)sina;  dSouffle.v3.vz = is->trans.vz;
    Sfx_BuildFastDisolveFacet(is,&dSouffle,gGravelPixmap[is->rndpixmap],gSnowPalette);
    Sfx_AdditivePrim(&dSouffle.pmx,&dSouffle.v0,0,0xf,sd);
    break;
  case 11:
    radius = (8 - (u_char)is->cycle) * 4 + 0xc;
    cosa = fixedmult(intcos(is->angle),radius);
    sina = fixedmult(intsin(is->angle),radius);
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
        gte_stsz(&sd->otz);
        sd->otz = (sd->otz >> 1) + otz;
        if ((sd->otz >= 0) && (sd->otz <= Draw_gViewOtSize + -3)) {
          prim->code = 9;
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
    cosa = fixedmult(intcos(is->angle),6);
    sina = fixedmult(intsin(is->angle),6);
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
      gte_stsz(&sd->otz);
      sd->otz = (sd->otz >> 1) + 0xf;
      if ((sd->otz >= 0) && (sd->otz <= Draw_gViewOtSize + -3)) {
        prim->code = 9;
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
