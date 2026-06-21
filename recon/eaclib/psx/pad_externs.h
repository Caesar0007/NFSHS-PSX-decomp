/* eaclib/psx/pad_externs.h - reconstructed extern decls (libpad + eaclib prototypes)
 * referenced by PAD.C. NOT an original source header; added so the reconstructed
 * translation unit compiles standalone as C++. Signatures inferred from call sites
 * and PsyQ 4.3 libpad. All C-linkage. */
#ifndef _EACLIB_PSX_PAD_EXTERNS_H_
#define _EACLIB_PSX_PAD_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

#ifdef __cplusplus
extern "C" {
#endif

/* --- PsyQ libpad (direct mode) --- */
void PadInitDirect(unsigned char *pad1, unsigned char *pad2);
void PadStopCom(void);

/* --- eaclib (EACPSXZ) --- */
    /* EAC_timerproc = void(*)(void) */

#ifdef __cplusplus
}
#endif

#endif /* _EACLIB_PSX_PAD_EXTERNS_H_ */
