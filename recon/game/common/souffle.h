/* game/common/souffle.h — reconstructed from game/common/souffle.cpp (10 fns) */
#ifndef _GAME_COMMON_SOUFFLE_H_
#define _GAME_COMMON_SOUFFLE_H_
#include "../../nfs4_types.h"

/* P875: native source names/signatures; C++ supplies linkage mangling.
 * File-private functions stay in the implementation; class members remain
 * exposed by the included types without duplicate free declarations. */

void GetGustWind(Souffle_tISouffle *is);   /* :44 */
void GetAngleWind(Souffle_tISouffle *is);   /* :53 */
void MoveAngleWind(Souffle_tISouffle *is);   /* :61 */
Souffle_tISouffle * Souffle_Add(coorddef *soufflept,int type,coorddef *vec,int velVX,int ground,int colour);   /* :76 */
void Souffle_DoSouffle(void);   /* :176 */
int Souffle_CircleClip(coorddef *pt1,coorddef *pt2,int r);   /* :308 */
void Souffle_InsertFacet(DRender_tView *Vi);   /* :320 */
void Souffle_InitTrackSouffle(void);   /* :359 */
void Souffle_RestartTrackSouffle(void);   /* :373 */
void Souffle_KillTrackSouffle(void);   /* :386 */

#endif /* _GAME_COMMON_SOUFFLE_H_ */
