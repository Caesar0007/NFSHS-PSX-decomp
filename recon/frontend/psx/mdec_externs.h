/* frontend/psx/mdec_externs.h - reconstructed extern decls (libpress/libgpu + eaclib)
 * referenced by MDEC.CPP. NOT an original header; added for standalone C++ compile. */
#ifndef _FRONTEND_PSX_MDEC_EXTERNS_H_
#define _FRONTEND_PSX_MDEC_EXTERNS_H_
#include "mdec_types.h"

/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/eac_mem.h"
#include "eaclib/psx/eacpsxz/systask.h"
#include "eaclib/psx/eacpsxz/vars.h"
}
/* `ticks` = eacpsxz/vars.h's own `extern volatile int ticks` (the former unsized
   asm-label view `ticks_v[]` was removed 2026-11-07). */





extern "C" {
/* PsyQ libpress (MDEC) */
void DecDCTReset(int mode);
int DecDCToutCallback(void (*func)());
int DecDCTvlc(unsigned long *bs, unsigned long *buf);
void DecDCTin(unsigned long *buf, int mode);
void DecDCTout(unsigned long *buf, int size);
/* PsyQ libgpu */
/* eaclib */
}
/* Prototypes for callees this TU used to call undeclared: CC1PLPSX 2.8.0 accepts the implicit `int f(...)` but wraps
   every such call statement in nested debug scopes retail's SYM does not have (tools/psyq_pipe/implicit_sweep.py). */
extern "C" int DrawSync(int mode);
extern "C" int LoadImage(RECT *rect, u_long *p);

/* retail's SYM records an inline-call pair at every tick read in this TU: the tick counter is read
   through an inline getter, not directly */
static inline int FE_Ticks(void) { return ticks; }

#endif
