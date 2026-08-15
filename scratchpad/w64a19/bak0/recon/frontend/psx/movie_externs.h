/* frontend/psx/movie_externs.h - reconstructed extern decls (libcd/libpress/libgpu/libetc
 * + eaclib) referenced by MOVIE.CPP. NOT an original header; added for standalone C++ compile. */
#ifndef _FRONTEND_PSX_MOVIE_EXTERNS_H_
#define _FRONTEND_PSX_MOVIE_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

typedef void fn_void(void);              /* SYM PTR FCN VOID -> fn_void* = void(*)(void) */
typedef long long          longlong;     /* Ghidra 64-bit helper types */
typedef unsigned long long ulonglong;

extern int gMasterMusicLevel;            /* game audio global */

extern "C" {
extern int StCdIntrFlag;                 /* PsyQ libcd interrupt flag */
int CD_Restart(int startSector);
int CdControl(u_char com, u_char * param, u_char * result);
int CdControlB(u_char com, u_char * param, u_char * result);
void * CdDataCallback(void * func);
int CdRead2(int mode);
void * CdReadyCallback(void * func);
void * CdSearchFile(void * fp, char * name);
void DecDCTReset(long mode);
void DecDCTin(u_long * runlevel, long mode);
long DecDCTinSync(long mode);
void DecDCTout(u_long * cell, long size);
long DecDCToutCallback(void * func);
int DecDCTvlc(u_long * bs, u_long * buf);
int DecDCTvlcSize(int size);
u_long * FntFlush(int id);   /* match real PsyQ libgpu.h proto (int, not long) */
void Platform_ResetDCTBuffer(void);
int SNDcdvol(int vol);
void StCdInterrupt(void);
void StClearRing(void);
u_long StFreeRing(u_long * base);
u_long StGetNext(u_long * addr, u_long * header);
void StSetRing(u_long * ring_addr, u_long ring_size);
void StSetStream(u_long mode, u_long start_frame, u_long end_frame, void * func1, void * func2);
void StUnSetRing(void);
int Triangle();   /* sig unknown */
void trap(int code);
}
#endif