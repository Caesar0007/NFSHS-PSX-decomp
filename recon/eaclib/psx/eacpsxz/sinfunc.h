#ifndef _SINFUNC_H_
#define _SINFUNC_H_

#include "eac_types.h"

extern int intsin(int a);   /* @0x800F18E8 */
extern int intcos(int a);   /* @0x800F18E4 : a += 90deg, fall into sin */
extern int fastintcos(int a);           /* co-equal XDEF at the same address (asm label in sinfunc.c) */
extern int fastintsin(int a);           /* co-equal XDEF at the same address (asm label in sinfunc.c) */

#endif
