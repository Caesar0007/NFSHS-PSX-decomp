/* game/psx/overlays.h — reconstructed from game/psx/overlays.cpp (5 fns) */
#ifndef _GAME_PSX_OVERLAYS_H_
#define _GAME_PSX_OVERLAYS_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

void OptionsBarThing(int x,int y,int w,int h);   /* SYM 42de4c @0x800d9968 */
void RaceSummary(void);   /* SYM 42de70 @0x800d9a48 */
void RaceStatistics(void);   /* SYM 42de8d @0x800d9fbc */
void Hud_BTCStats(short player,bool postgame);   /* SYM 42dead @0x800da728 */
void Hud_RenderStatsView(void);   /* SYM 42decc @0x800dae8c */

#endif /* _GAME_PSX_OVERLAYS_H_ */
