/* frontend/psx/mdec.h - reconstructed declarations for MDEC.CPP (PSX MDEC decode) */
#ifndef _FRONTEND_PSX_MDEC_H_
#define _FRONTEND_PSX_MDEC_H_
#include "mdec_types.h"

/* MDEC.CPP mixes linkage: initmdec/restoremdec/mdec/mdecdone are UNMANGLED in the SYM
 * (extern "C"); mdecreset/MDECCompleteHandler are cfront-mangled (normal C++). */
#ifdef __cplusplus
extern "C" {
#endif
int  initmdec(int width, int height, int bpp, int memtype);  /* :92  EXT FCN INT  */
void restoremdec(int handle);                                /* :180 EXT FCN VOID */
void mdec(int handle, char *src, int x, int y);              /* :295 EXT FCN VOID */
int  mdecdone(int handle);                                   /* :381 EXT FCN INT  */
#ifdef __cplusplus
}
#endif

void mdecreset(void);            /* :239 EXT FCN VOID (C++ linkage) */
void MDECCompleteHandler(void);  /* :388 EXT FCN VOID (C++ linkage, DecDCT out-callback) */

/* ---- mdec.obj data globals ---- */
/* gMDECinfo (0x80052b28) and g_mdecdrawsyncfailed (0x80052b30) are DEFINED in mdec.cpp: the struct is an anonymous
 * 8-byte STRTAG with no typedef in the retail SYM, so it cannot be redeclared from a header. */

#endif /* _FRONTEND_PSX_MDEC_H_ */
