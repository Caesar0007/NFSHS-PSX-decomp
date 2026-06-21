/* game/common/ailife.h — reconstructed from game/common/ailife.cpp (20 fns) */
#ifndef _GAME_COMMON_AILIFE_H_
#define _GAME_COMMON_AILIFE_H_
#include "../../nfs4_types.h"

int AILife_EvaluateLife__FP8Car_tObj(Car_tObj *carObj);   /* :51 */
void AILife_RCSetSpeeds__FP8Car_tObj(Car_tObj *carObj);   /* :82 */
void AILife_RCPickSliceAndDirection__FP8Car_tObj(Car_tObj *carObj);   /* :94 */
void AILife_RCPickDesiredLatPosition__FP8Car_tObj(Car_tObj *carObj);   /* :182 */
void AILife_PlaceCarAtLocation__FP8Car_tObjiiiii(Car_tObj *carObj, int slice, int desiredLatPos, int direction, int currentSpeed, int rotation1024);   /* :258 */
void AILife_SetInitialSlicePositionOrientationEtc__FP8Car_tObj(Car_tObj *carObj);   /* :269 */
void AILife_PlaceCarAtLocation__FP8Car_tObji(Car_tObj *carObj, int rotation1024);   /* :279 */
void AILife_ReencarnateTraffic__FP8Car_tObj(Car_tObj *carObj);   /* :342 */
void AILife_ReencarnateTrafficByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef(Car_tObj *carObj, int slice, int travelDirection, coorddef *pos, matrixtdef *ori);   /* :396 */
void AILife_ReencarnateCopBySlice__FP8Car_tObjiiii(Car_tObj *carObj, int slice, int travelDirection, int roadSide, int moving);   /* :478 */
void AILife_ReencarnateCopByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef(Car_tObj *carObj, int slice, int travelDirection, coorddef *pos, matrixtdef *ori);   /* :529 */
void AILife_ReencarnateCopByLatPosAndRotation__FP8Car_tObjiiii(Car_tObj *carObj, int slice, int travelDirection, int latPos, int rotation1024);   /* :572 */
int AILife_IsCoordInThisLiveArea__FP8coorddefP8Car_tObj(coorddef *tPos, Car_tObj *racer);   /* :627 */
void * AILife_IsTrafficCarInAnyLiveArea__FP8Car_tObj(Car_tObj *traffic);   /* :654 */
int AILife_IsCoordInThisVisibleArea__FP8coorddefP8Car_tObj(coorddef *tPos, Car_tObj *racer);   /* :673 */
void * AILife_IsCarInAnyVisibleArea__FP8Car_tObj(Car_tObj *carObj);   /* :697 */
void * AILife_IsSliceInAnyVisibleArea__Fi(int slice);   /* :706 */
void * AILife_IsSliceCloseToAnyCopCar__Fi(int slice);   /* :728 */
void * AILife_IsPositionInAnyVisibleArea__FP8coorddef(coorddef *pos);   /* :747 */
void AILife_Debug__FPce(char *format);   /* :764 */

#endif /* _GAME_COMMON_AILIFE_H_ */
