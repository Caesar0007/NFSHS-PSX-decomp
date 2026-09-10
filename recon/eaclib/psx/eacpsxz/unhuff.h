#ifndef _UNHUFF_H_
#define _UNHUFF_H_

#include "eac_types.h"

extern char          *memcpyl(char *dst, char *src, int n);                          /* @0x800F51C0 */
extern unsigned int   memcpyb(unsigned char *dst, unsigned char *src, int n);        /* @0x800F5234 */
extern unsigned char *refcpy(unsigned char *dst, unsigned int dist, int len);        /* @0x800F5254 */

#endif
