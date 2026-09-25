/* frontend/psx/video_externs.h - reconstructed extern decls (globals + lib prototypes)
 * referenced by VIDEO.CPP. NOT an original source header; added so the reconstructed
 * translation unit compiles standalone as C++. Signatures inferred from call sites. */
#ifndef _FRONTEND_PSX_VIDEO_EXTERNS_H_
#define _FRONTEND_PSX_VIDEO_EXTERNS_H_
#include "video_types.h"

/* --- globals --- */
extern char *Paths_Paths[];
extern int   CF_DVLC[];   /* unsized array (3.12#5): address-of via base materialization */
extern int   screenbpp;
extern int   timerhz;
extern int   ticks;

/* --- eaclib / platform / mdec / stream prototypes --- */
extern "C" {
void  Platform_ResetDCTBuffer(void) asm("Platform_ResetDCTBuffer__Fv");
int   initmdec(int, int, int, int);   /* SYM: FCN INT (returns mdec handle) - was wrongly void* */
void  restoremdec(int);
void  mdec(int, char *, int, int);
int   mdecdone(int);
void  mdecreset(void) asm("mdecreset__Fv");
void *STREAM_create(int, int, int, void *, int);
void  STREAM_setfilter(long, int, int, int, int);
long  STREAM_queuefile(long, char *, int, int);
int   STREAM_bufferusage(long);
int   STREAM_state(long);
int   STREAM_isendofstream(long);
struct STREAMCHUNKHDR *STREAM_get(long);
void  STREAM_release(long, struct STREAMCHUNKHDR *);
void  STREAM_kill(long);
void  STREAM_destroy(long);
}
/* Prototypes for callees this TU used to call undeclared: CC1PLPSX 2.8.0 accepts the implicit `int f(...)` but wraps
   every such call statement in nested debug scopes retail's SYM does not have (tools/psyq_pipe/implicit_sweep.py). */
extern "C" unsigned int asyncloadfileat(char *name, char *destination);
extern "C" void blockclear(void *dst, int n);
extern "C" int fixeddiv(int a, int b);
extern "C" int fixedmult(int a, int b);
extern "C" int getasyncreadstatus(unsigned int handle);
extern "C" int purgememadr(void *ptr);
extern "C" void *reservememadr(const char *name, int size, int memory_class);
extern "C" int sprintf(char *out, const char *format, ...);
extern "C" int systemtask(int);

#endif
