/* frontend/psx/movie_externs.h - reconstructed extern decls (libcd/libpress/libgpu/libetc
 * + eaclib) referenced by MOVIE.CPP. NOT an original header; added for standalone C++ compile. */
#ifndef _FRONTEND_PSX_MOVIE_EXTERNS_H_
#define _FRONTEND_PSX_MOVIE_EXTERNS_H_
#include "movie_types.h"

extern int gMasterMusicLevel;            /* game audio global */

extern "C" {
extern int StCdIntrFlag;                 /* PsyQ libcd interrupt flag */
int ClearImage(RECT *rect, u_char r, u_char g, u_char b);
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
long DrawSync(long mode);
u_long * FntFlush(int id);   /* match real PsyQ libgpu.h proto (int, not long) */
int LoadImage(RECT *rect, u_long *data);
u_short PAD_state(int padID);
void PAD_update(void);
void Platform_ResetDCTBuffer(void) asm("Platform_ResetDCTBuffer__Fv");
DISPENV *PutDispEnv(DISPENV *env);
DRAWENV *PutDrawEnv(DRAWENV *env);
int purgememadr(void *ptr);
void *reservememadr(const char *name, int size, int memory_class);
void ResetCallback(void);
DISPENV *SetDefDispEnv(DISPENV *env, int x, int y, int w, int h);
DRAWENV *SetDefDrawEnv(DRAWENV *env, int x, int y, int w, int h);
void SetDispMask(int mask);
void settrans(int on);
int SNDcdvol(int vol);
int sprintf(char *dst, const char *format, ...);
void StCdInterrupt(void);
void StClearRing(void);
u_long StFreeRing(u_long * base);
u_long StGetNext(u_long * addr, u_long * header);
void StSetRing(u_long * ring_addr, u_long ring_size);
void StSetStream(u_long mode, u_long start_frame, u_long end_frame, void * func1, void * func2);
void StUnSetRing(void);
int Triangle();   /* sig unknown */
void trap(int code);
int VSync(int mode);
}
#endif
