#include "../../lib/libfns.h"
/* textureprocess_externs.h -- externs for textureprocess.cpp (GAME/PSX color-clut + fog + world-color) */
#ifndef TEXTUREPROCESS_EXTERNS_H
#define TEXTUREPROCESS_EXTERNS_H

/* ---- globals (SYM Globals.jsonl) ---- */
extern GameSetup_tData    GameSetup_gData;       /* 0x801131ec */
extern CTrackSpec         TrackSpec_gSpec;       /* 0x8012327c */
extern char              *Paths_Paths[50];       /* 0x80116468 */
extern BWorldSm_Pos      *fogslicePos;           /* 0x8013db8c */
extern TP_ZPaletteSystem  TP_gZPaletteSystem;    /* 0x8013db78 */
extern int                Fog_gNumKeys;          /* 0x8013db7c */
extern FogKey            *Fog_gHeadKey;          /* 0x8013db88 */
extern FogKey            *Fog_gCurrentKey[2];    /* 0x8013db80 */
extern FogKey             Fog_gBuf[32];          /* 0x8012307c */
extern int                openkeys[32];          /* 0x801231fc */
extern int                gZDepth;               /* 0x8013db74 */
extern int                gNumSlices;            /* 0x8013c7c8 */
extern short              gClutDepth[256][16];   /* 0x8012107c */
extern DRender_tView      gCView;                /* 0x80116f7c */
extern int                Chunk_numLight;        /* 0x8013d4ec */
extern CVECTOR           *Chunk_lightTable;      /* 0x8013c818 */

/* ---- external subsystems (eaclib + game + PsyQ) ---- */
extern void  Texture_GetClutId(int id, int *cx, int *cy);
            /* PsyQ libgpu */
                             /* PsyQ libgpu */
extern void  BWorldSm_SetSlice(int slice, BWorldSm_Pos *pos);
extern int   BWorldSm_FindClosestQuadRez(coorddef *c, BWorldSm_Pos *pos, int rez);

#endif /* TEXTUREPROCESS_EXTERNS_H */
