/* frontend/psx/video_externs.h - reconstructed extern decls (globals + lib prototypes)
 * referenced by VIDEO.CPP. NOT an original source header; added so the reconstructed
 * translation unit compiles standalone as C++. Signatures inferred from call sites. */
#ifndef _FRONTEND_PSX_VIDEO_EXTERNS_H_
#define _FRONTEND_PSX_VIDEO_EXTERNS_H_
#include "video_types.h"

/* --- globals --- */
extern char *Paths_Paths[];
extern int   CF_DVLC[];   /* unsized array (3.12#5): address-of via base materialization */
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/eac_mem.h"
#include "eaclib/psx/eacpsxz/eac_math.h"
#include "eaclib/psx/eacpsxz/eac_file.h"
#include "eaclib/psx/eacpsxz/systask.h"
#include "eaclib/psx/eacpsxz/vars.h"
}

/* --- eaclib / platform / mdec / stream prototypes --- */
extern "C" {
void  Platform_ResetDCTBuffer(void) asm("Platform_ResetDCTBuffer__Fv");
int   initmdec(int, int, int, int);   /* SYM: FCN INT (returns mdec handle) - was wrongly void* */
void  restoremdec(int);
void  mdec(int, char *, int, int);
int   mdecdone(int);
void  mdecreset(void) asm("mdecreset__Fv");
}
/* Prototypes for callees this TU used to call undeclared: CC1PLPSX 2.8.0 accepts the implicit `int f(...)` but wraps
   every such call statement in nested debug scopes retail's SYM does not have (tools/psyq_pipe/implicit_sweep.py). */
extern "C" int sprintf(char *out, const char *format, ...);

#endif
