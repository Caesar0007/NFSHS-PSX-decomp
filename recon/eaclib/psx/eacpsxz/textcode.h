#ifndef _TEXTCODE_H_
#define _TEXTCODE_H_

#include "eac_types.h"

extern int decodeansi(unsigned char **cursor);   /* @0x801069AC */
extern unsigned int remapshiftjiscode(unsigned int c);      /* @0x801069C4 */
extern int decodeshiftjis(unsigned char **cursor);          /* @0x801069EC */
/* The co-equal XDEFs decodeshiftjis2/3 that used to sit here were invented (retired
 * 2026-09-18): the SYM records real co-equal names when they exist -- nullfunc has 21 on
 * 0x800F6114 -- and 0x801069EC carries exactly one.  setfont matches 100/100 with the single
 * name; what keeps retail's three decoder arms unmerged is its own per-arm store (textset.c). */

#endif
