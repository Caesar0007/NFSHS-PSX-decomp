#ifndef _XFORM_H_
#define _XFORM_H_

#include "eac_types.h"

extern void xformy(matrixtdef *out, int angle);   /* 0x800E5AC4 */
extern void fixedxformx(matrixtdef *out, int angle); /* 0x800EABAC */
extern void fixedxformy(matrixtdef *out, int angle);   /* 0x800EAC10 */
extern void fixedxformz(matrixtdef *out, int angle);   /* 0x800EAC74 */

#endif
