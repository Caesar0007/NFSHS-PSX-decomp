/* game/common/mathnfs.h — reconstructed from game/common/mathnfs.cpp (10 fns) */
#ifndef _GAME_COMMON_MATHNFS_H_
#define _GAME_COMMON_MATHNFS_H_
#include "../../nfs4_types.h"

/* P875: source names/signatures checked against native EXT records and
 * defining exports; compile-only typed references verify the C++ linkage. */

int Math_DistXZ(coorddef *a, coorddef *b);   /* :26 */
int Math_Dist3D(coorddef *a, coorddef *b);   /* :42 */
int Math_BetterDist(int a, int b);   /* :57 */
void Math_ResolveRotatedVector(int x, int y, int angle, int *newx, int *newy);   /* :96 */
int Math_VectorLength(coorddef *v);   /* :132 */
int Math_VectorLength2(coorddef *v);   /* :207 */
void Math_NormalizeVector(coorddef *v);   /* :298 */
void Math_NormalizeShortVector(coorddef *v);   /* :371 */
void Math_QDNormalizeVector(coorddef *v);   /* :396 */
void Math_fasttransmult(matrixtdef *m1, matrixtdef *m2, matrixtdef *mr);   /* :533 */

#endif /* _GAME_COMMON_MATHNFS_H_ */
