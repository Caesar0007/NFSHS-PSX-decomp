#ifndef _BLKFILL_H_
#define _BLKFILL_H_

#include "eac_types.h"

extern void blockfill(void *dst, int n, unsigned char val);   /* @0x800F17A4 */
extern void blockclear(void *dst, int n);   /* @0x800F17A0 */

#endif
