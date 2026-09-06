/* game/common/stats.h — reconstructed from game/common/stats.cpp (7 fns) */
#ifndef _GAME_COMMON_STATS_H_
#define _GAME_COMMON_STATS_H_
#include "../../nfs4_types.h"

/* P875: native source names/signatures; C++ supplies linkage mangling.
 * File-private functions stay in the implementation; class members remain
 * exposed by the included types without duplicate free declarations. */

void Stats_DoPlayerGlue(void);   /* :52 */
void Stats_ClearPosition(void);   /* :112 */
int Stats_GetPosition(Car_tObj *carObj);   /* :126 */
int Stats_GetNumOpponents(void);   /* :145 */
void Stats_TrackStats(Car_tObj *carObj);   /* :161 */
void Stats_ExtrapolateOpponentTimes(int type);   /* :278 */
void Stats_TrackEndGame(void);   /* :470 */

#endif /* _GAME_COMMON_STATS_H_ */
