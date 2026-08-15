/* game/common/stats.h — reconstructed from game/common/stats.cpp (7 fns) */
#ifndef _GAME_COMMON_STATS_H_
#define _GAME_COMMON_STATS_H_
#include "../../nfs4_types.h"

void Stats_DoPlayerGlue__Fv(void);   /* :52 */
void Stats_ClearPosition__Fv(void);   /* :112 */
int Stats_GetPosition__FP8Car_tObj(Car_tObj *carObj);   /* :126 */
int Stats_GetNumOpponents__Fv(void);   /* :145 */
void Stats_TrackStats__FP8Car_tObj(Car_tObj *carObj);   /* :161 */
void Stats_ExtrapolateOpponentTimes__Fi(int type);   /* :278 */
void Stats_TrackEndGame__Fv(void);   /* :470 */

#endif /* _GAME_COMMON_STATS_H_ */
