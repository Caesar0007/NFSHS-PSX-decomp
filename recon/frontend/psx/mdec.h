/* frontend/psx/mdec.h - reconstructed declarations for MDEC.CPP (PSX MDEC decode) */
#ifndef _FRONTEND_PSX_MDEC_H_
#define _FRONTEND_PSX_MDEC_H_
#include "../../nfs4_types.h"   /* MDECSTRUCT(44B), tMdecHandle(8B), DECDCTTAB - mdec.obj-owned */

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
extern tMdecHandle gMDECinfo;            /* 0x80052b28  {numhandles, hDecode} */
extern int         g_mdecdrawsyncfailed[]; /* 0x80052b30 */

#endif /* _FRONTEND_PSX_MDEC_H_ */
