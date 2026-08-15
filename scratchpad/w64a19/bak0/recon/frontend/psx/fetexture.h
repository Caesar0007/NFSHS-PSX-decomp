/* frontend/psx/fetexture.h - reconstructed declarations for FETEXTURE.CPP (C++ TU) */
#ifndef _FRONTEND_PSX_FETEXTURE_H_
#define _FRONTEND_PSX_FETEXTURE_H_
#include "../../nfs4_types.h"   /* tTexture_ShapeInfo, shapetbl */

/* FETEXTURE.CPP is a C++ source (cfront-mangled in SYM) -> normal C++ linkage. */
void FETexture_LoadPmxAtOffset(char *f, int index, tTexture_ShapeInfo *dest, int yoffset, int xoffset);
void FETexture_LoadPmx(char *f, int index, tTexture_ShapeInfo *dest);

#endif /* _FRONTEND_PSX_FETEXTURE_H_ */
