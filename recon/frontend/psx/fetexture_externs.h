/* frontend/psx/fetexture_externs.h - reconstructed extern decls for FETEXTURE.CPP.
 * NOT an original header; added for standalone C++ compile. */
#ifndef _FRONTEND_PSX_FETEXTURE_EXTERNS_H_
#define _FRONTEND_PSX_FETEXTURE_EXTERNS_H_
#include "fetexture_types.h"
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/eac_mem.h"
#include "eaclib/psx/eacpsxz/eac_shape.h"
}
extern "C" {
int unpacksize(void *src);
void unpack(void *src, void *dst);
unsigned short GetClut(int x, int y);
}
/* game/psx/texture.cpp: C++ linkage (retail Texture_GetClutId__FiPiT1) */
void Texture_GetClutId(int bpp, int *xclut, int *yclut);
#endif
