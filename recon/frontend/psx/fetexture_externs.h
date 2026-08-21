/* frontend/psx/fetexture_externs.h - reconstructed extern decls for FETEXTURE.CPP.
 * NOT an original header; added for standalone C++ compile. */
#ifndef _FRONTEND_PSX_FETEXTURE_EXTERNS_H_
#define _FRONTEND_PSX_FETEXTURE_EXTERNS_H_
#include "fetexture_types.h"
extern "C" {
void *shapepointer(void *file, int index);
int unpacksize(void *src);
void unpack(void *src, void *dst);
void *reservememadr(const char *name, int size, int memory_class);
void blockmove(void *src, void *dst, int size);
int purgememadr(void *ptr);
void vramfxya(shapetbl *shape, int x, int y, int xclut, int yclut);
int shapedepth(shapetbl *shape);
u_short GetClut(int x, int y);
void Texture_GetClutId(unsigned int bpp, int *xclut, int *yclut)
    asm("Texture_GetClutId__FiPiT1");
}
#endif
