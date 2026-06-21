/* trgsfx_externs.h -- externs for game/common/trgsfx.cpp (NFS4 trigger-SFX gating: skid trails,
   souffle puffs, crash debris -- the throttled front-end that feeds Souffle/Skidmark systems) */
#ifndef _GAME_COMMON_TRGSFX_EXTERNS_H_
#define _GAME_COMMON_TRGSFX_EXTERNS_H_

#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ---- module globals (per-car[8] x per-wheel[4] last-emit timestamps + skid state) ---- */
extern int               gTEnviroEffect[8];        /* 0x8011e1b0 */
extern int               gTAddCarSfx[8];           /* 0x8011e1d0 */
extern int               gTAddCarWheelSfx[8][4];   /* 0x8011e1f0 */
extern int               gTAddCarExtraSfx[8][4];   /* 0x8011e270 */
extern tSkid             gPrevSkidSm[8][4];        /* 0x8011e2f0  previous skid anchor per wheel */
extern int               gStatusSm[8][4];          /* 0x8011e670  0=idle,1=active,2=stretching */
extern Skidmark_Segment *gSaveSeg[8][4];           /* 0x8011e6f0  saved stretch segment */
extern int               gSaveChunk[8][4];         /* 0x8011e770  saved stretch chunk */
extern int               gTAddCarWheelDelay;       /* 0x8013d4f0 */
extern int               gTAddCSmoke;              /* 0x8013d4f4 */

/* ---- game globals ---- */
extern Sim_tSimGlobalVar simGlobal;                /* 0x8011e0ac */
extern GameSetup_tData   GameSetup_gData;          /* 0x801131ec */

/* ---- helpers (souffle/skidmark/eaclib) ---- */
extern Souffle_tISouffle *Souffle_Add(coorddef *emitterpt, int type, coorddef *vec, int velXZ, int ground, int colour);
extern void  Skidmark_Add(tSkid *prevskid, coorddef *skidpt, CVECTOR *color, int tireWidth, int type, int slice);
extern void  Skidmark_AddStretch(Skidmark_Segment **save, int *savechunk, tSkid *prevskid, coorddef *skidpt, CVECTOR *color, int tireWidth, int type, int slice);
extern void  Skidmark_Stretch(Skidmark_Segment *save, int savechunk, tSkid *prevskid, coorddef *skidpt, CVECTOR *color, int tireWidth, int type);
extern void  Skidmark_EndStretch(Skidmark_Segment *save, int savechunk, tSkid *prevskid, coorddef *skidpt, CVECTOR *color, int tireWidth, int type);

/* ---- this module (forward decls for intra-TU calls) ---- */
extern void TrgSfx_InitTrgSfx(void);
extern void TrgSfx_KillTrgSfx(void);

#endif
