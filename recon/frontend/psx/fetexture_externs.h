/* frontend/psx/fetexture_externs.h - reconstructed extern decls for FETEXTURE.CPP.
 * NOT an original header; added for standalone C++ compile. */
#ifndef _FRONTEND_PSX_FETEXTURE_EXTERNS_H_
#define _FRONTEND_PSX_FETEXTURE_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"
extern "C" {
     /* shape-table entry for index */
int   unpacksize(void *src);                 /* decompressed size */
void  unpack(void *src, void *dst);          /* shpsubs decompressor */
void  Texture_GetClutId(unsigned int bpp, int *xclut, int *yclut);
   /* upload to VRAM */
}
#endif
