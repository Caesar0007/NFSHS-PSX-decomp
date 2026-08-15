#include "../../lib/libfns.h"
/* texture_externs.h -- externs for texture.cpp (GAME/PSX texture/palette/CLUT/PMX loading) */
#ifndef TEXTURE_EXTERNS_H
#define TEXTURE_EXTERNS_H

/* ---- globals ---- */
/* NOTE: the 15 Texture.obj-OWNED globals (gMenuPixmap..gNbFreePal8) are now DEFINED in texture.cpp
 *       (self-contained); they are NOT externed here (this TU owns them). Only cross-TU data below. */
extern char           *Paths_Paths[50];         /* 0x80116468  (paths.obj) */

/* ---- external subsystems (eaclib + game + shape/vram lib + PsyQ libgpu) ---- */
extern long  unpack(void *src, void *dst);
extern long  unpacksize(void *src);
           /* PsyQ libgpu */
                       /* PsyQ libgpu */
     /* PsyQ libgpu */
               /* shape lib */
                        /* shape lib */
                   /* shape lib */
extern char *Platform_GetDCTBuffer(int n, char *name);
extern void  Texture_GetClutId(int id, int *xclut, int *yclut);  /* fwd (intra-module) */
extern void  TextureProcess_Init(void);                    /* sibling TextureProcess.obj */
extern int   TextureProcess_TransColorCheck(char *data, int numentry);
extern int   TextureProcess_DepthColorCluts(char *data, int numentry);

#endif /* TEXTURE_EXTERNS_H */
