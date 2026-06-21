/* game/psx/trackspec.h — reconstructed from game/psx/trackspec.cpp (5 fns) */
#ifndef _GAME_PSX_TRACKSPEC_H_
#define _GAME_PSX_TRACKSPEC_H_
#include "../../nfs4_types.h"

void TrackSpec_SetDefault__FP10CTrackSpec(CTrackSpec *spec);   /* :44 */
void TrackSpec_SetUp__Fv(void);   /* :119 */
void read__FPPcPvi(char **handle, void *buf, int bytes);   /* :127 */
void TrackSpec_Read__Fi(int spec_num);   /* :145 */
void TrackSpec_Load__Fii(int weather, int night);   /* :205 */

#endif /* _GAME_PSX_TRACKSPEC_H_ */
