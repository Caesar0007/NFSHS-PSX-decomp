/* frontend/psx/mdec_externs.h - reconstructed extern decls (libpress/libgpu + eaclib)
 * referenced by MDEC.CPP. NOT an original header; added for standalone C++ compile. */
#ifndef _FRONTEND_PSX_MDEC_EXTERNS_H_
#define _FRONTEND_PSX_MDEC_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

extern int timerhz;
extern int ticks;

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
