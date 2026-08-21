/* frontend/psx/mdec_externs.h - reconstructed extern decls (libpress/libgpu + eaclib)
 * referenced by MDEC.CPP. NOT an original header; added for standalone C++ compile. */
#ifndef _FRONTEND_PSX_MDEC_EXTERNS_H_
#define _FRONTEND_PSX_MDEC_EXTERNS_H_
#include "mdec_types.h"

extern int timerhz;
/* MATCH: unsized asm-label view of `ticks` -- a bare scalar extern compiles to the
   unschedulable `lw $r,sym` assembler macro (no %hi pseudo, so no CSE); the array
   view restores cc1's own %hi/%lo split so the base survives in a callee-saved reg
   across the poll loop (oracle $s2). */
extern int ticks_v[] asm("ticks");
#define ticks (ticks_v[0])

extern "C" {
/* PsyQ libpress (MDEC) */
void DecDCTReset(int mode);
void DecDCToutCallback(void (*cb)(void));
void DecDCTvlc(u_long *bs, u_long *buf);
void DecDCTin(u_long *buf, long mode);
void DecDCTout(u_long *buf, long size);
/* PsyQ libgpu */
/* eaclib */
}
#endif
