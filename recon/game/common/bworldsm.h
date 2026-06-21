/* game/common/bworldsm.h — reconstructed from game/common/bworldsm.cpp (28 fns) */
#ifndef _GAME_COMMON_BWORLDSM_H_
#define _GAME_COMMON_BWORLDSM_H_
#include "../../nfs4_types.h"

int BWorldSm_Init__FP5Group(Group *simGroup);   /* :84 */
void BWorldSm_Restart__Fv(void);   /* :101 */
void BWorldSm_DeInit__Fv(void);   /* :113 */
void FindAbsClosestSliceCrude__FP8coorddefP12BWorldSm_Pos(coorddef *pt, BWorldSm_Pos *slicePos);   /* :123 */
int BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos(coorddef *pt, BWorldSm_Pos *slicePos);   /* :152 */
void RawFindClosestSlice__FP8coorddefP12BWorldSm_Pos(coorddef *pt, BWorldSm_Pos *slicePos);   /* :179 */
void BWorldSm_SetSlice__FiP12BWorldSm_Pos(int slice, BWorldSm_Pos *slicePos);   /* :261 */
void GetStmQuadPts__FP12BWorldSm_PosP8coorddef(BWorldSm_Pos *slicePos, coorddef *cp);   /* :323 */
void SetStrip__FP12BWorldSm_Pos(BWorldSm_Pos *slicePos);   /* :379 */
void GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16(BWorldSm_Pos *slicePos, CCOORD16 *vertices);   /* :415 */
void BWorld_SetSimSlice__FP12BWorldSm_Pos(BWorldSm_Pos *slicePos);   /* :470 */
void BworldSm_UpdateSimQuad__FP12BWorldSm_Pos(BWorldSm_Pos *slicePos);   /* :495 */
int BworldSm_IsSimQuadValid__FP12BWorldSm_Pos(BWorldSm_Pos *slicePos);   /* :516 */
int RawFindClosestQuad__FP8coorddefP12BWorldSm_Pos(coorddef *pt, BWorldSm_Pos *slicePos);   /* :537 */
int FindClosestQuad__FP8coorddefP12BWorldSm_Pos(coorddef *pt, BWorldSm_Pos *slicePos);   /* :1058 */
int BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi(coorddef *pt, BWorldSm_Pos *slicePos, int hiRezFlag);   /* :1139 */
int BWorldSm_FindClosestQuadMaxIterations__FP8coorddefP12BWorldSm_Posi(coorddef *pt, BWorldSm_Pos *slicePos, int maxIterations);   /* :1199 */
int PointDirection__FP8coorddefN20(coorddef *p1, coorddef *p2, coorddef *p3);   /* :1212 */
int BWorldSm_FindEdgeOff__FP8coorddefP12BWorldSm_PosT1Pi(coorddef *pt, BWorldSm_Pos *slicePos1, BWorldSm_Pos *slicePos2, int *heightDiff);   /* :1217 */
int BWorldSm_QuadLight__FP12BWorldSm_Pos(BWorldSm_Pos *slicePos);   /* :1261 */
BOOL BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos(BWorldSm_Pos *slicePos);   /* :1301 */
void NormalCache_AddEntry__FP12BWorldSm_Pos(BWorldSm_Pos *slicePos);   /* :1341 */
BOOL NormalCache_FindEntry__FP12BWorldSm_Pos(BWorldSm_Pos *slicePos);   /* :1372 */
void NormalCache_Init__Fv(void);   /* :1411 */
void Check_Rot__FP12BWorldSm_Pos(BWorldSm_Pos *slicePos);   /* :1427 */
void * BWorldSm_UNormal__FP12BWorldSm_Pos(BWorldSm_Pos *slicePos);   /* :1499 */
void * BWorldSm_UForward__FP12BWorldSm_Pos(BWorldSm_Pos *slicePos);   /* :1506 */
int BWorldSm_FindClosestTriangleRez__FP8coorddefP12BWorldSm_Posi(coorddef *pt, BWorldSm_Pos *slicePos, int hiRezFlag);   /* :1517 */

#endif /* _GAME_COMMON_BWORLDSM_H_ */
