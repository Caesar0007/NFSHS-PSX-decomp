/* game/psx/souffle.cpp -- RECONSTRUCTED (NFS4 PSX wind/dust particle effect; C++ TU)
 *   10 fns: Get/Move AngleWind, GetGustWind, Souffle_Add/DoSouffle/CircleClip/InsertFacet,
 *   Init/Restart/Kill TrackSouffle. GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "souffle_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
Souffle_tISouffle *gISouffle;
int gCISouffle;
int gTMoveSouffle;
int gWindDir;

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void GetGustWind(Souffle_tISouffle *is);
void GetAngleWind(Souffle_tISouffle *is);
void MoveAngleWind(Souffle_tISouffle *is);
void Souffle_DoSouffle(void);
int Souffle_CircleClip(coorddef *pt1,coorddef *pt2,int r);
void Souffle_InsertFacet(DRender_tView *Vi);
void Souffle_InitTrackSouffle(void);
void Souffle_RestartTrackSouffle(void);
void Souffle_KillTrackSouffle(void);


/* ---- GetGustWind__FP17Souffle_tISouffle  [SOUFFLE.CPP:44-49] SLD-VERIFIED ---- */
void GetGustWind(Souffle_tISouffle *is)

{
  u_int uVar1;
  
  uVar1 = random();
  (is->motion).x = uVar1 & 0x3ff;
  uVar1 = random();
  (is->motion).z = uVar1 & 0x3ff;
  uVar1 = random();
  (is->motion).y = (uVar1 & 0x3ff) + 0x7ff;
  return;
}

/* ---- GetAngleWind__FP17Souffle_tISouffle  [SOUFFLE.CPP:53-57] SLD-VERIFIED ---- */
void GetAngleWind(Souffle_tISouffle *is)

{
  int iVar1;
  u_int uVar2;
  
  iVar1 = random();
  is->angle = iVar1;
  uVar2 = random();
  is->aspeed = (uVar2 & 0x7f) - 0x3f;
  return;
}

/* ---- MoveAngleWind__FP17Souffle_tISouffle  [SOUFFLE.CPP:61-66] SLD-VERIFIED ---- */
void MoveAngleWind(Souffle_tISouffle *is)

{
  int iVar1;

  iVar1 = is->aspeed;
  is->angle = is->angle + iVar1;
  if (iVar1 < -8) {
    is->aspeed = iVar1 + 1;
    return;
  }
  if (8 < iVar1) {
    is->aspeed = iVar1 + -1;
  }
  return;
}

/* ---- Souffle_Add__FP8coorddefiT0iii  [SOUFFLE.CPP:76-165] SLD-VERIFIED ---- */
Souffle_tISouffle *
Souffle_Add(coorddef *soufflept,int type,coorddef *vec,int velVX,int ground,int colour)

{
  int i;
  int iVar1;
  u_char bVar2;
  int maxc;
  int inserti;
  int iVar3;
  int iVar4;
  Souffle_tISouffle *is;
  Souffle_tISouffle *pSVar5;
  coorddef vempty;
  
  iVar3 = 0;
  if (gCISouffle == 0x3c) {
    iVar1 = 1;
    bVar2 = gISouffle->cycle;
    pSVar5 = gISouffle;
    do {
      if ((u_char)pSVar5[1].cycle < bVar2) {
        iVar3 = iVar1;
        bVar2 = pSVar5[1].cycle;
      }
      iVar1 = iVar1 + 1;
      pSVar5 = pSVar5 + 1;
    } while (iVar1 < 0x3c);
  }
  else {
    iVar3 = gCISouffle;
    gCISouffle = gCISouffle + 1;
  }
  pSVar5 = gISouffle + iVar3;
  iVar1 = soufflept->y;
  iVar4 = soufflept->z;
  (pSVar5->source).x = soufflept->x;
  (pSVar5->source).y = iVar1;
  (pSVar5->source).z = iVar4;
  pSVar5->cycle = '\0';
  pSVar5->type = (char)type;
  pSVar5->id = (char)iVar3;
  pSVar5->ground = ground;
  pSVar5->colour = colour;
  if (vec == (coorddef *)0x0) {
    vec = &vempty;
    vempty.x = 0;
    vempty.y = 0;
    vempty.z = 0;
  }
  if (type == 9) goto Souffle_setMotion;
  if (type < 10) {
    if (type == 4) {
Souffle_setRndPixmap:
      pSVar5->rndpixmap = velVX;
      goto Souffle_setMotion;
    }
    if (type < 5) {
      if (type < 1) goto Souffle_emitAndReturn;
    }
    else {
      if (type == 7) goto Souffle_setMotion;
      if (7 < type) goto Souffle_setRndPixmap;
      if (type != 6) goto Souffle_emitAndReturn;
    }
    GetGustWind(pSVar5);
    pSVar5->wind = '\x01';
  }
  else {
    if (type == 0xc) goto Souffle_setRndPixmap;
    if (type < 0xd) {
      if (type == 10) goto Souffle_setRndPixmap;
      if (type != 0xb) goto Souffle_emitAndReturn;
    }
    else if ((0xe < type) && (type != 0x101)) goto Souffle_emitAndReturn;
Souffle_setMotion:
    (pSVar5->motion).x = vec->x >> 5;
    (pSVar5->motion).y = vec->y >> 6;
    iVar3 = vec->z;
    pSVar5->wind = '\0';
    (pSVar5->motion).z = iVar3 >> 5;
  }
  GetAngleWind(pSVar5);
Souffle_emitAndReturn:
  Sfx_Add(pSVar5);
  return pSVar5;
}

/* ---- Souffle_DoSouffle__Fv  [SOUFFLE.CPP:176-295] SLD-VERIFIED ---- */
void Souffle_DoSouffle(void)

{
  char cVar1;
  int iVar2;
  Souffle_tISouffle *pSVar3;
  int speed;
  u_int uVar4;
  int iVar5;
  int iVar6;
  int wave;
  int *piVar7;
  int iVar8;
  Souffle_tISouffle *is;
  Souffle_tISouffle *pSVar9;
  int i;
  int iVar10;
  coorddef w;
  coorddef motion;
  coorddef extramotion;
  
  if (0 < simGlobal.gameTicks - gTMoveSouffle) {
    gTMoveSouffle = simGlobal.gameTicks;
    iVar10 = 0;
    if (gCISouffle != 0) {
      gWindDir = gWindDir + 2;
      iVar2 = fastintcos(gWindDir);
      w.x = fixedmult(iVar2,0xccc);
      iVar2 = fastintsin(gWindDir);
      w.z = fixedmult(iVar2,0xccc);
      w.y = 0;
    }
    iVar2 = 0;
    for (; iVar10 < gCISouffle; iVar10 = iVar10 + 1) {
      pSVar9 = (Souffle_tISouffle *)(&gISouffle->type + iVar2);
      motion.x = (pSVar9->motion).x;
      motion.y = (pSVar9->motion).y;
      motion.z = (pSVar9->motion).z;
      if (pSVar9->wind != '\0') {
        motion.x = motion.x + w.x;
        motion.y = motion.y + w.y;
        motion.z = motion.z + w.z;
      }
      if (Replay_ReplayMode == 2) {
        uVar4 = 2 - Replay_ReplayInterface.speed;
        if (0 < (int)uVar4) {
          motion.x = motion.x >> (uVar4 & 0x1f);
          motion.z = motion.z >> (uVar4 & 0x1f);
          motion.y = motion.y >> (uVar4 & 0x1f);
        }
        if ((int)uVar4 < 0) {
          motion.x = motion.x << 1;
          motion.z = motion.z << 1;
          motion.y = motion.y << 1;
        }
      }
      (pSVar9->source).x = (pSVar9->source).x + motion.x;
      (pSVar9->source).y = (pSVar9->source).y + motion.y;
      iVar5 = (pSVar9->motion).x;
      (pSVar9->source).z = (pSVar9->source).z + motion.z;
      if (iVar5 < 0) {
        (pSVar9->motion).x = iVar5 + 0xa3d;
        if (0 < iVar5 + 0xa3d) {
          (pSVar9->motion).x = 0;
        }
      }
      else if ((0 < iVar5) && ((pSVar9->motion).x = iVar5 + -0xa3d, iVar5 + -0xa3d < 0)) {
        (pSVar9->motion).x = 0;
      }
      iVar5 = (pSVar9->motion).z;
      if (iVar5 < 0) {
        (pSVar9->motion).z = iVar5 + 0xa3d;
        if (0 < iVar5 + 0xa3d) {
          (pSVar9->motion).z = 0;
        }
      }
      else if ((0 < iVar5) && ((pSVar9->motion).z = iVar5 + -0xa3d, iVar5 + -0xa3d < 0)) {
        (pSVar9->motion).z = 0;
      }
      if (pSVar9->type == '\r') {
        extramotion.x = (pSVar9->extramotion).x;
        extramotion.z = (pSVar9->extramotion).z;
        iVar5 = fastintsin(pSVar9->angle);
        if (Replay_ReplayMode == 2) {
          uVar4 = 2 - Replay_ReplayInterface.speed;
          if (0 < (int)uVar4) {
            extramotion.x = extramotion.x >> (uVar4 & 0x1f);
            extramotion.z = extramotion.z >> (uVar4 & 0x1f);
          }
          if ((int)uVar4 < 0) {
            extramotion.x = extramotion.x << 1;
            extramotion.z = extramotion.z << 1;
          }
        }
        (pSVar9->source).x = (pSVar9->source).x + (extramotion.x * iVar5 >> 0x11);
        iVar6 = (pSVar9->extramotion).x;
        (pSVar9->source).z = (pSVar9->source).z + (extramotion.z * iVar5 >> 0x11);
        if (iVar6 < 0) {
          (pSVar9->extramotion).x = iVar6 + 0x147;
          if (0 < iVar6 + 0x147) {
            (pSVar9->extramotion).x = 0;
          }
        }
        else if ((0 < iVar6) && ((pSVar9->extramotion).x = iVar6 + -0x147, iVar6 + -0x147 < 0)) {
          (pSVar9->extramotion).x = 0;
        }
        iVar5 = (pSVar9->extramotion).z;
        if (iVar5 < 0) {
          (pSVar9->extramotion).z = iVar5 + 0x147;
          if (0 < iVar5 + 0x147) {
            (pSVar9->extramotion).z = 0;
          }
        }
        else if ((0 < iVar5) && ((pSVar9->extramotion).z = iVar5 + -0x147, iVar5 + -0x147 < 0)) {
          (pSVar9->extramotion).z = 0;
        }
        if (pSVar9->ground < (pSVar9->source).y) {
          (pSVar9->motion).y = (pSVar9->motion).y + -0x147;
        }
        else {
          pSVar9->type = '\0';
        }
      }
      MoveAngleWind(pSVar9);
      cVar1 = pSVar9->cycle + -1;
      pSVar9->cycle = cVar1;
      if (cVar1 == '\0') {
        pSVar9->type = '\0';
      }
      iVar2 = iVar2 + 0x44;
    }
    iVar10 = 0;
    if (0 < gCISouffle) {
      iVar2 = 0;
      do {
        piVar7 = (int *)(&gISouffle->type + iVar2);
        if ((char)*piVar7 == '\0') {
          pSVar3 = gISouffle + gCISouffle + -1;
          pSVar9 = gISouffle + gCISouffle + -1;
          do {
            iVar6 = pSVar3->aspeed;
            iVar8 = pSVar3->angle;
            iVar5 = (pSVar3->source).x;
            *piVar7 = *(int *)pSVar3;
            piVar7[1] = iVar6;
            piVar7[2] = iVar8;
            ((coorddef *)(piVar7 + 3))->x = iVar5;
            pSVar3 = (Souffle_tISouffle *)&(pSVar3->source).y;
            piVar7 = piVar7 + 4;
          } while (pSVar3 != (Souffle_tISouffle *)&pSVar9->colour);
          iVar2 = iVar2 + -0x44;
          iVar10 = iVar10 + -1;
          *piVar7 = *(int *)pSVar3;
          gCISouffle = gCISouffle + -1;
        }
        iVar10 = iVar10 + 1;
        iVar2 = iVar2 + 0x44;
      } while (iVar10 < gCISouffle);
    }
  }
  return;
}

/* ---- Souffle_CircleClip__FP8coorddefT0i  [SOUFFLE.CPP:308-316] SLD-VERIFIED ---- */
int Souffle_CircleClip(coorddef *pt1,coorddef *pt2,int r)

{
  int dist;
  int dz;
  int iVar1;
  int iVar2;
  int dx;
  
  dz = pt1->x;
  iVar2 = dz - pt2->x;
  if (iVar2 < 1) {
    iVar2 = pt2->x - dz;
  }
  iVar1 = pt1->z - pt2->z;
  if (iVar1 < 1) {
    iVar1 = pt2->z - pt1->z;
  }
  if (iVar1 < iVar2) {
    iVar2 = iVar2 + (iVar1 >> 2);
  }
  else {
    iVar2 = iVar1 + (iVar2 >> 2);
  }
  return (u_int)(iVar2 < r);
}

/* ---- Souffle_InsertFacet__FP13DRender_tView  [SOUFFLE.CPP:320-348] SLD-VERIFIED ---- */
void Souffle_InsertFacet(DRender_tView *Vi)

{
  int inCircle;
  int iVar1;
  Souffle_tISouffle *is;
  Souffle_tISouffle *is_2;
  int off;
  int i;
  int i_2;
  
  i_2 = 0;
  off = 0;
  do {
    if (gCISouffle <= i_2) {
      return;
    }
    is_2 = (Souffle_tISouffle *)(&gISouffle->type + off);
    inCircle = Souffle_CircleClip(&is_2->source,&(Vi->cview).translation,0x320000);
    if (inCircle != 0) {
      if (is_2->type != '\n') {
        Sfx_Transform(&is_2->source,&is_2->trans,&(Vi->cview).translation);
        iVar1 = (int)(is_2->trans).vx;
        if (iVar1 < 0) {
          iVar1 = -iVar1;
        }
        if (((is_2->trans).vz < iVar1) || (is_2->type == '\0')) goto SouffleInsert_iterAdvance;
      }
      Sfx_BuildSouffleFacet(Vi,is_2);
    }
SouffleInsert_iterAdvance:
    off = off + 0x44;
    i_2 = i_2 + 1;
  } while( true );
}

/* ---- Souffle_InitTrackSouffle__Fv  [SOUFFLE.CPP:359-367] SLD-VERIFIED ---- */
void Souffle_InitTrackSouffle(void)

{
  gWindDir = 0;
  gCISouffle = 0;
  gTMoveSouffle = simGlobal.gameTicks;
  gISouffle = reservememadr("souffle",0xff0,0);
  return;
}

/* ---- Souffle_RestartTrackSouffle__Fv  [SOUFFLE.CPP:373-382] SLD-VERIFIED ---- */
void Souffle_RestartTrackSouffle(void)

{
  gWindDir = 0;
  gCISouffle = 0;
  gTMoveSouffle = simGlobal.gameTicks;
  return;
}

/* ---- Souffle_KillTrackSouffle__Fv  [SOUFFLE.CPP:386-388] SLD-VERIFIED ---- */
void Souffle_KillTrackSouffle(void)

{
  if (gISouffle != (Souffle_tISouffle *)0x0) {
    purgememadr(gISouffle);
  }
  gISouffle = (Souffle_tISouffle *)0x0;
  return;
}

/* end of souffle.cpp */
