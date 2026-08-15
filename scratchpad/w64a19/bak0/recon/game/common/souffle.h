/* game/common/souffle.h — reconstructed from game/common/souffle.cpp (10 fns) */
#ifndef _GAME_COMMON_SOUFFLE_H_
#define _GAME_COMMON_SOUFFLE_H_
#include "../../nfs4_types.h"

void GetGustWind__FP17Souffle_tISouffle(Souffle_tISouffle *is);   /* :44 */
void GetAngleWind__FP17Souffle_tISouffle(Souffle_tISouffle *is);   /* :53 */
void MoveAngleWind__FP17Souffle_tISouffle(Souffle_tISouffle *is);   /* :61 */
void * Souffle_Add__FP8coorddefiT0iii(coorddef *soufflept, int type, coorddef *vec, int velVX, int ground, int colour);   /* :76 */
void Souffle_DoSouffle__Fv(void);   /* :176 */
int Souffle_CircleClip__FP8coorddefT0i(coorddef *pt1, coorddef *pt2, int r);   /* :308 */
void Souffle_InsertFacet__FP13DRender_tView(DRender_tView *Vi);   /* :320 */
void Souffle_InitTrackSouffle__Fv(void);   /* :359 */
void Souffle_RestartTrackSouffle__Fv(void);   /* :373 */
void Souffle_KillTrackSouffle__Fv(void);   /* :386 */

#endif /* _GAME_COMMON_SOUFFLE_H_ */
