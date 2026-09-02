/* textureprocess_externs.h -- externs for textureprocess.cpp (GAME/PSX color-clut + fog + world-color) */
#ifndef TEXTUREPROCESS_EXTERNS_H
#define TEXTUREPROCESS_EXTERNS_H

#include "textureprocess_types.h"

/* ---- globals (SYM Globals.jsonl) ---- */
/* Foreign-owner storage views.  The retail object does not emit the completed
 * GameSetup_tData/CTrackSpec tags, so keep only the int-addressable ABI here. */
extern int                GameSetup_gData[];     /* 0x801131ec */
extern int                TrackSpec_gSpec[];     /* 0x8012327c */
extern char              *Paths_Paths[50];       /* 0x80116468 */
/* W65-A8 ORDER IS LOAD-BEARING: a TU-owned tentative definition is emitted in
 * the order its identifier is FIRST DECLARED -- which is HERE, not at the
 * definition in textureprocess.cpp.  This whole run is retail's .sdata
 * 0x8013db74..0x8013db8c, in retail VA order.  Do NOT re-sort. */
extern int                gZDepth;               /* 0x8013db74 */
extern TP_ZPaletteSystem TP_gZPaletteSystem;    /* 0x8013db78 */
extern int                Fog_gNumKeys;          /* 0x8013db7c */
/* Retail SYM records one two-element pointer array.  textureprocess.obj's
   proven -G8 identity keeps the complete 8-byte object small-data eligible
   while retaining ordinary runtime indexing. */
extern FogKey            *Fog_gCurrentKey[2];    /* 0x8013db80 */
extern FogKey            *Fog_gHeadKey;          /* 0x8013db88 */
extern BWorldSm_Pos      *fogslicePos;           /* 0x8013db8c */
extern FogKey             Fog_gBuf[32];          /* 0x8012307c */
extern int                openkeys[32];          /* 0x801231fc */
extern int                gNumSlices;            /* 0x8013c7c8 */
extern short              gClutDepth[256][16];   /* 0x8012107c */
extern int                gCView[];              /* 0x80116f7c */
extern int                Chunk_numLight;        /* 0x8013d4ec */
extern CVECTOR           *Chunk_lightTable;      /* 0x8013c818 */

/* ---- external subsystems (eaclib + game + PsyQ) ---- */
extern void  Texture_GetClutId(int id, int *cx, int *cy);
            /* PsyQ libgpu */
                             /* PsyQ libgpu */
extern void  BWorldSm_SetSlice(int slice, BWorldSm_Pos *pos);
extern int   BWorldSm_FindClosestQuadRez(coorddef *c, BWorldSm_Pos *pos, int rez);

extern "C" {
long  DrawSync(long mode);
int   LoadImage(RECT *rect, u_long *data);
int   fixedmult(int a, int b);
int   sprintf(char *buffer, const char *format, ...);
void *loadfileadr(char *name, int flags);
int   purgememadr(void *ptr);
void *reservememadr(const char *name, int size, int memory_class);
void *memset(void *dst, int value, size_t size);
}

#endif /* TEXTUREPROCESS_EXTERNS_H */
