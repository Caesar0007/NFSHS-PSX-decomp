/* game/common/mathnfs.h — reconstructed from game/common/mathnfs.cpp (10 fns) */
#ifndef _GAME_COMMON_MATHNFS_H_
#define _GAME_COMMON_MATHNFS_H_
#include "../../nfs4_types.h"

int Math_DistXZ__FP8coorddefT0(coorddef *a, coorddef *b);   /* :26 */
int Math_Dist3D__FP8coorddefT0(coorddef *a, coorddef *b);   /* :42 */
int Math_BetterDist__Fii(int a, int b);   /* :57 */
void Math_ResolveRotatedVector__FiiiPiT3(int x, int y, int angle, int *newx, int *newy);   /* :96 */
int Math_VectorLength__FP8coorddef(coorddef *v);   /* :132 */
int Math_VectorLength2__FP8coorddef(coorddef *v);   /* :207 */
void Math_NormalizeVector__FP8coorddef(coorddef *v);   /* :298 */
void Math_NormalizeShortVector__FP8coorddef(coorddef *v);   /* :371 */
void Math_QDNormalizeVector__FP8coorddef(coorddef *v);   /* :396 */
void Math_fasttransmult__FP10matrixtdefN20(matrixtdef *m1, matrixtdef *m2, matrixtdef *mr);   /* :533 */

#endif /* _GAME_COMMON_MATHNFS_H_ */
