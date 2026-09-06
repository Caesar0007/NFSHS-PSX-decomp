/* game/common/bworldsm.h — reconstructed from game/common/bworldsm.cpp (28 fns) */
#ifndef _GAME_COMMON_BWORLDSM_H_
#define _GAME_COMMON_BWORLDSM_H_
#include "bworldSm_types.h"

/* P875: native signatures and defining exports verified by typed-reference
 * probes. Source names let the compiler emit the original C++ linkage. */

int BWorldSm_Init(Group *simGroup);   /* :84 */
void BWorldSm_Restart(void);   /* :101 */
void BWorldSm_DeInit(void);   /* :113 */
void FindAbsClosestSliceCrude(coorddef *pt, BWorldSm_Pos *slicePos);   /* :123 */
int BWorldSm_FindClosestSlice(coorddef *pt, BWorldSm_Pos *slicePos);   /* :152 */
void RawFindClosestSlice(coorddef *pt, BWorldSm_Pos *slicePos);   /* :179 */
void BWorldSm_SetSlice(int slice, BWorldSm_Pos *slicePos);   /* :261 */
void GetStmQuadPts(BWorldSm_Pos *slicePos, coorddef *cp);   /* :323 */
void SetStrip(BWorldSm_Pos *slicePos);   /* :379 */
void GetFirstStmQuadPts(BWorldSm_Pos *slicePos, CCOORD16 *vertices);   /* :415 */
void BWorld_SetSimSlice(BWorldSm_Pos *slicePos);   /* :470 */
void BworldSm_UpdateSimQuad(BWorldSm_Pos *slicePos);   /* :495 */
int BworldSm_IsSimQuadValid(BWorldSm_Pos *slicePos);   /* :516 */
int RawFindClosestQuad(coorddef *pt, BWorldSm_Pos *slicePos);   /* :537 */
int FindClosestQuad(coorddef *pt, BWorldSm_Pos *slicePos);   /* :1058 */
int BWorldSm_FindClosestQuadRez(coorddef *pt, BWorldSm_Pos *slicePos, int hiRezFlag);   /* :1139 */
int BWorldSm_FindClosestQuadMaxIterations(coorddef *pt, BWorldSm_Pos *slicePos, int maxIterations);   /* :1199 */
int PointDirection(coorddef *p1, coorddef *p2, coorddef *p3);   /* :1212 */
int BWorldSm_FindEdgeOff(coorddef *pt, BWorldSm_Pos *slicePos1, BWorldSm_Pos *slicePos2, int *heightDiff);   /* :1217 */
int BWorldSm_QuadLight(BWorldSm_Pos *slicePos);   /* :1261 */
bool BWorldSm_TunnelFlagSm(BWorldSm_Pos *slicePos);   /* :1301 */
void NormalCache_AddEntry(BWorldSm_Pos *slicePos);   /* :1341 */
bool NormalCache_FindEntry(BWorldSm_Pos *slicePos);   /* :1372 */
void NormalCache_Init(void);   /* :1411 */
void Check_Rot(BWorldSm_Pos *slicePos);   /* :1427 */
coorddef * BWorldSm_UNormal(BWorldSm_Pos *slicePos);   /* :1499 */
coorddef * BWorldSm_UForward(BWorldSm_Pos *slicePos);   /* :1506 */
int BWorldSm_FindClosestTriangleRez(coorddef *pt, BWorldSm_Pos *slicePos, int hiRezFlag);   /* :1517 */

#endif /* _GAME_COMMON_BWORLDSM_H_ */
