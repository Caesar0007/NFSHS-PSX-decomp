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
extern TP_tZPaletteSystem TP_gZPaletteSystem;    /* 0x8013db78 */
extern int                Fog_gNumKeys;          /* 0x8013db7c */
/* PER-ELEMENT SPLIT (w39-a10): retail's .sdata carries these as TWO separate
   4-byte dlabels (Fog_gCurrentKey @0x8013db80, D_8013DB84 @0x8013db84), and
   Fog_InitFogTriggers stores to them through per-element %gp_rel relocations --
   only possible if each element is its OWN <=G4 object.  Fog_Update indexes the
   pair at runtime, so it uses the unsized asm-label ARRAY VIEW over the same
   storage (catalog E: dual-model per-element gp-rel).  */
extern FogKey            *Fog_gCurrentKey;       /* 0x8013db80  element [0] */
extern FogKey            *D_8013DB84;            /* 0x8013db84  element [1] */
extern FogKey            *Fog_gCurrentKeyArr[] asm("Fog_gCurrentKey");
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
