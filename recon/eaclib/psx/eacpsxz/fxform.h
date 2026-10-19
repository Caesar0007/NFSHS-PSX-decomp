#ifndef _FXFORM_H_
#define _FXFORM_H_

#include "eac_types.h"


/* fixedxform{x,y,z} @0x800EABAC..0x800EAC74 -- build a fixed-point rotation matrix.
 * `out` points at the 9-int matrix (call sites pass `mat.m`, the m[9] member). */
extern int fixedxformx(int *out, int angle);   /* 0x800EABAC */
extern int fixedxformy(int *out, int angle);   /* 0x800EAC10 */
extern int fixedxformz(int *out, int angle);   /* 0x800EAC74 */


#endif
