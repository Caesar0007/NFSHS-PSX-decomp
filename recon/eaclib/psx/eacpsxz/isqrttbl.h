#ifndef _ISQRTTBL_H_
#define _ISQRTTBL_H_

#include "eac_types.h"

/* ONE u8[256] estimate ramp @0x8013BE10: isqrttbl[i] = round(16*sqrt(i+1)) (0x10..0xff, monotonic,
 * byte-exact from image; model verified 255/255 within +-2). The oracle brackets sqrt with TWO byte
 * loads off the SAME base: `lbu 0(base+i)` = isqrttbl[i] and `lbu -1(base+i)` = isqrttbl[i-1] (every
 * reachable index is >=1). The old recon mis-declared this as `u16 isqrttbl` (scaled the index by 2 —
 * out-of-bounds garbage reads) + a phantom never-defined scalar `DAT_8013be0f` (= base-1 view; the
 * 0x81 byte at 0x8013BE0F belongs to the PREVIOUS symbol). */
extern unsigned char isqrttbl[];     /* @0x8013BE10 */

#endif
