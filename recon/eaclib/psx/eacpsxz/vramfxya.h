#ifndef _VRAMFXYA_H_
#define _VRAMFXYA_H_

#include "eac_types.h"

extern unsigned int checkrect(RECT *rectp);                         /* @0x800F6934 */
extern int vramimage(RECT *rect, u_long *data);                  /* @0x800F6960 */
extern void vramfxya(unsigned int *c, int imgX, int imgY,
                         int clutX, int clutY);                       /* @0x800F69A8 */

#endif
