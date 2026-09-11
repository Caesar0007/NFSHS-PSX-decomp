#ifndef _TEXTCODE_H_
#define _TEXTCODE_H_

#include "eac_types.h"

extern int decodeansi(unsigned char **cursor);   /* @0x801069AC */
extern unsigned int remapshiftjiscode(unsigned int c);      /* @0x801069C4 */
extern int decodeshiftjis(unsigned char **cursor);          /* @0x801069EC */
/* Co-equal XDEFs at the same address, emitted as GNU-as symbol assignments in textcode.c.
 * setfont NEEDS the three distinct names: our cc1 cross-jumps identical hard-reg la-blocks,
 * so one symbol would merge retail's three unmerged decoder-selection arms (see textset.c). */
extern int decodeshiftjis2(unsigned char **cursor);         /* = decodeshiftjis */
extern int decodeshiftjis3(unsigned char **cursor);         /* = decodeshiftjis */

#endif
