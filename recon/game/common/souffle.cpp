/* game/psx/souffle.cpp -- RECONSTRUCTED (NFS4 PSX wind/dust particle effect; C++ TU)
 *   10 fns: Get/Move AngleWind, GetGustWind, Souffle_Add/DoSouffle/CircleClip/InsertFacet,
 *   Init/Restart/Kill TrackSouffle. GTE-free. Full SYM-locals applied.
 */
#include "souffle_types.h"
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
  (is->motion).x = random() & 0x3ff;
  (is->motion).z = random() & 0x3ff;
  (is->motion).y = (random() & 0x3ff) + 0x7ff;
  return;
}

/* ---- GetAngleWind__FP17Souffle_tISouffle  [SOUFFLE.CPP:53-57] SLD-VERIFIED ---- */
void GetAngleWind(Souffle_tISouffle *is)

{
  is->angle = random();
  is->aspeed = (random() & 0x7f) - 0x3f;
  return;
}

/* ---- MoveAngleWind__FP17Souffle_tISouffle  [SOUFFLE.CPP:61-66] SLD-VERIFIED ---- */
void MoveAngleWind(Souffle_tISouffle *is)

{
  is->angle = is->angle + is->aspeed;
  if (is->aspeed < -8) {
    is->aspeed = is->aspeed + 1;
    return;
  }
  if (8 < is->aspeed) {
    is->aspeed = is->aspeed + -1;
  }
  return;
}

/* ---- Souffle_Add__FP8coorddefiT0iii  [SOUFFLE.CPP:76-165] SLD-VERIFIED ---- */
Souffle_tISouffle *
Souffle_Add(coorddef *soufflept,int type,coorddef *vec,int velVX,int ground,int colour)

{
  int i;
  /* SYM-CODEGEN-CARRIER: limit -- the named 60 keeps retail's register
     compare.  A literal emits one fewer instruction (`slti`) and produces
     17 word diffs instead of the oracle's `li` plus `slt` sequence. */
  int limit;
  int maxc;
  int inserti;
  Souffle_tISouffle *is;
  coorddef vempty;

  inserti = 0;
  if (gCISouffle == 0x3c) {
    i = 1;
    limit = 0x3c;
    maxc = gISouffle[0].cycle;
    while (i < limit) {
      if (gISouffle[i].cycle < maxc) {
        inserti = i;
        maxc = gISouffle[i].cycle;
      }
      i++;
    }
  }
  else {
    inserti = gCISouffle;
    gCISouffle = gCISouffle + 1;
  }

  is = gISouffle + inserti;
  is->source = *soufflept;
  is->cycle = 0;
  is->type = type;
  is->id = inserti;
  is->ground = ground;
  is->colour = colour;

  if (vec == (coorddef *)0x0) {
    vec = &vempty;
    vempty.x = 0;
    vempty.y = 0;
    vempty.z = 0;
  }

  switch (type) {
  case 1:
  case 2:
  case 3:
  case 6:
    GetGustWind(is);
    is->wind = 1;
    GetAngleWind(is);
    break;

  case 4:
  case 8:
  case 10:
  case 12:
    is->rndpixmap = velVX;
    /* fall through */
  case 7:
  case 9:
  case 11:
  case 13:
  case 14:
  case 0x101:
    is->motion.x = vec->x >> 5;
    is->motion.y = vec->y >> 6;
    is->motion.z = vec->z >> 5;
    is->wind = 0;
    GetAngleWind(is);
    break;
  }

  Sfx_Add(is);
  return is;
}

/* ---- Souffle_DoSouffle__Fv  [SOUFFLE.CPP:176-295] SLD-VERIFIED ---- */
void Souffle_DoSouffle(void)

{
  int iVar2;
  int i;
  coorddef w;
  
  if (0 < SOUFFLE_GAME_TICKS - gTMoveSouffle) {
    gTMoveSouffle = SOUFFLE_GAME_TICKS;
    if (gCISouffle != 0) {
      gWindDir = gWindDir + 2;
      iVar2 = fastintcos(gWindDir);
      w.x = fixedmult(iVar2,0xccc);
      iVar2 = fastintsin(gWindDir);
      w.z = fixedmult(iVar2,0xccc);
      w.y = 0;
    }
    for (i = 0; i < gCISouffle; i++) {
      Souffle_tISouffle *is = gISouffle + i;
      coorddef motion = is->motion;
      if (is->wind != '\0') {
        motion.x = motion.x + w.x;
        motion.y = motion.y + w.y;
        motion.z = motion.z + w.z;
      }
      if (Replay_ReplayMode == 2) {
        int speed = 2 - SOUFFLE_REPLAY_SPEED;
        if (0 < speed) {
          motion.x = motion.x >> speed;
          motion.y = motion.y >> speed;
          motion.z = motion.z >> speed;
        }
        if (speed < 0) {
          motion.x = motion.x << 1;
          motion.y = motion.y << 1;
          motion.z = motion.z << 1;
        }
      }
      (is->source).x = (is->source).x + motion.x;
      (is->source).y = (is->source).y + motion.y;
      (is->source).z = (is->source).z + motion.z;
      {
        int dampingSpeed = (is->motion).x;
        if (dampingSpeed < 0) {
          (is->motion).x = dampingSpeed + 0xa3d;
          if (0 < dampingSpeed + 0xa3d) {
            (is->motion).x = 0;
          }
        }
        else if ((0 < dampingSpeed) && ((is->motion).x = dampingSpeed + -0xa3d, dampingSpeed + -0xa3d < 0)) {
          (is->motion).x = 0;
        }
      }
      {
        int dampingSpeed = (is->motion).z;
        if (dampingSpeed < 0) {
          (is->motion).z = dampingSpeed + 0xa3d;
          if (0 < dampingSpeed + 0xa3d) {
            (is->motion).z = 0;
          }
        }
        else if ((0 < dampingSpeed) && ((is->motion).z = dampingSpeed + -0xa3d, dampingSpeed + -0xa3d < 0)) {
          (is->motion).z = 0;
        }
      }
      if (is->type == '\r') {
        coorddef extramotion = is->extramotion;
        int wave = fastintsin(is->angle);
        if (Replay_ReplayMode == 2) {
          int speed = 2 - SOUFFLE_REPLAY_SPEED;
          if (0 < speed) {
            extramotion.x = extramotion.x >> speed;
            extramotion.y = extramotion.y >> speed;
            extramotion.z = extramotion.z >> speed;
          }
          if (speed < 0) {
            extramotion.x = extramotion.x << 1;
            extramotion.y = extramotion.y << 1;
            extramotion.z = extramotion.z << 1;
          }
        }
        (is->source).x = (is->source).x + (extramotion.x * wave >> 0x11);
        (is->source).z = (is->source).z + (extramotion.z * wave >> 0x11);
        {
          int dampingSpeed = (is->extramotion).x;
          if (dampingSpeed < 0) {
            (is->extramotion).x = dampingSpeed + 0x147;
            if (0 < dampingSpeed + 0x147) {
              (is->extramotion).x = 0;
            }
          }
          else if ((0 < dampingSpeed) && ((is->extramotion).x = dampingSpeed + -0x147, dampingSpeed + -0x147 < 0)) {
            (is->extramotion).x = 0;
          }
        }
        {
          int dampingSpeed = (is->extramotion).z;
          if (dampingSpeed < 0) {
            (is->extramotion).z = dampingSpeed + 0x147;
            if (0 < dampingSpeed + 0x147) {
              (is->extramotion).z = 0;
            }
          }
          else if ((0 < dampingSpeed) && ((is->extramotion).z = dampingSpeed + -0x147, dampingSpeed + -0x147 < 0)) {
            (is->extramotion).z = 0;
          }
        }
        if ((is->source).y <= is->ground) {
          is->type = '\0';
        }
        else {
          (is->motion).y = (is->motion).y + -0x147;
        }
      }
      MoveAngleWind(is);
      if (--is->cycle == '\0') {
        is->type = '\0';
      }
    }
    for (i = 0; i < gCISouffle; i++) {
      if (gISouffle[i].type == '\0') {
        gISouffle[i] = gISouffle[gCISouffle - 1];
        i--;
        gCISouffle--;
      }
    }
  }
  return;
}

/* ---- Souffle_CircleClip__FP8coorddefT0i  [SOUFFLE.CPP:308-316] SLD-VERIFIED ---- */
int Souffle_CircleClip(coorddef *pt1,coorddef *pt2,int r)

{
  int dist;
  int dz;
  int dx;

  dx = pt1->x - pt2->x;
  if (dx < 1) {
    dx = pt2->x - pt1->x;
  }
  dz = pt1->z - pt2->z;
  if (dz < 1) {
    dz = pt2->z - pt1->z;
  }
  if (dz < dx) {
    dist = dx + (dz >> 2);
  }
  else {
    dist = dz + (dx >> 2);
  }
  return (u_int)(dist < r);
}

/* ---- Souffle_InsertFacet__FP13DRender_tView  [SOUFFLE.CPP:320-348] SLD-VERIFIED ---- */
void Souffle_InsertFacet(DRender_tView *Vi)

{
  int inCircle;
  int z;
  int iVar1;
  Souffle_tISouffle *is;
  Souffle_tISouffle *is_2;
  int off;
  int i;
  int i_2;
  coorddef *translation;
  
  i_2 = 0;
  translation = &(Vi->cview).translation;
  off = i_2;
  do {
    if (gCISouffle <= i_2) {
      return;
    }
    is_2 = (Souffle_tISouffle *)(&gISouffle->type + off);
    inCircle = Souffle_CircleClip(&is_2->source,translation,0x320000);
    if (inCircle != 0) {
      if (is_2->type != '\n') {
        Sfx_Transform(&is_2->source,&is_2->trans,translation);
        iVar1 = __builtin_abs((int)(is_2->trans).vx);
        z = (int)(is_2->trans).vz;
        if ((z < iVar1) || (is_2->type == '\0')) goto SouffleInsert_iterAdvance;
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
  gTMoveSouffle = SOUFFLE_GAME_TICKS;
  gISouffle = reservememadr("souffle",0xff0,0);
  return;
}

/* ---- Souffle_RestartTrackSouffle__Fv  [SOUFFLE.CPP:373-382] SLD-VERIFIED ---- */
void Souffle_RestartTrackSouffle(void)

{
  gWindDir = 0;
  gCISouffle = 0;
  gTMoveSouffle = SOUFFLE_GAME_TICKS;
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
