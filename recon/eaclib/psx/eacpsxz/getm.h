#ifndef _GETM_H_
#define _GETM_H_

#include "eac_types.h"

extern int getm(unsigned char *p, int n);   /* @0x800F3024 */
extern unsigned int geti(void *p, char nbits);   /* @0x800F308C */

#endif
