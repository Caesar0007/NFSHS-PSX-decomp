#ifndef _SNDPSXZ_SPLAY_H_
#define _SNDPSXZ_SPLAY_H_

#include "../../../shared/SNDPLAYOPTS.h"

extern int SNDplay(SNDPLAYOPTS *info); /* @0x800E7A30 */
extern int cSNDplay(SNDPLAYOPTS *info, int recurse); /* @0x800E7A68 ; a1 always 0 at every call */

#endif /* _SNDPSXZ_SPLAY_H_ */
