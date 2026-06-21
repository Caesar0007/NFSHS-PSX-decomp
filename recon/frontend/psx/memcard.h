/* frontend/psx/memcard.h - reconstructed declarations for MEMCARD.C (PSX memory card I/O) */
#ifndef _FRONTEND_PSX_MEMCARD_H_
#define _FRONTEND_PSX_MEMCARD_H_
#include "../../nfs4_types.h"   /* fMemCardInfo_def, MCRDOPTS_def, MCRDFILE_def, ... */

/* MEMCARD.C is a C source: all exported symbols UNMANGLED -> extern "C" so they match
 * the SYM. (iMCRD_timersub/ascii2sjis/sjis2ascii are SYM class STAT -> file-local in .cpp.) */
#ifdef __cplusplus
extern "C" {
#endif
void MCRD_init(int fMultitap);
int  iMCRD_InitCard(int card);
void MCRD_restore(void);
void MCRD_getopts(MCRDOPTS_def *pOPT);
void MCRD_setopts(MCRDOPTS_def *pOPT);
void MCRD_loadfile(int card, MCRDFILE_def *pFILE, int bNameHasProductCode);
int  iMCRD_DoFileLoad(int card);
int  MCRD_savefile(int card, MCRDFILE_def *pFILE);
int  iMCRD_DoFileWrite(int card);
int  iMCRD_DoFileDelete(int card);
int  MCRD_handlecardevents(int card);
int  MCRD_fileexists(int card, char *name);
int  garyMemCardGrabBlocks(int card, int filenum);
int  iMCRD_LoadCard(int card);
int  iMCRD_FormatCard(int card);
int  iMCRD_HandleError(int func, int opResult, int card);
int  iMCRD_DefaultCBProc1(void);
#ifdef __cplusplus
}
#endif

/* ---- memcard.obj data global ---- */
extern fMemCardInfo_def gMemCardInfo;    /* 0x80052d68  (6108 B) */

#endif /* _FRONTEND_PSX_MEMCARD_H_ */