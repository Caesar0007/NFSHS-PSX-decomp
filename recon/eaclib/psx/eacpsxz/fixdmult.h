#ifndef _FIXDMULT_H_
#define _FIXDMULT_H_

#include "eac_types.h"

extern int fixedmult(int a, int b);   /* @0x800E4328 (16.16 multiply) */
extern int rmult(int a, int b);         /* co-equal XDEF at the same address (asm label in fixdmult.c) */

#endif
