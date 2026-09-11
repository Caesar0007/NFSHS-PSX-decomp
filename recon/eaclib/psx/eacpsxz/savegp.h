#ifndef _SAVEGP_H_
#define _SAVEGP_H_

#include "eac_types.h"

extern void initgp(void);   /* @0x800EB080 */
extern void savegp(unsigned int *out) ;   /* @0x800EB090 */
extern void restoregp(unsigned int gp);   /* @0x800EB0A4 */

#endif
