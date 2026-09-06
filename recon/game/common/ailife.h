/* game/common/ailife.h — reconstructed from game/common/ailife.cpp (20 fns) */
#ifndef _GAME_COMMON_AILIFE_H_
#define _GAME_COMMON_AILIFE_H_
#include "../../nfs4_types.h"

/* P875: verified source-level free names/signatures; the C++ compiler supplies
   native GCC-v2 linkage names. File-local STAT helpers stay in their .cpp. */

int AILife_EvaluateLife(Car_tObj *carObj);   /* :51 */
void AILife_RCSetSpeeds(Car_tObj *carObj);   /* :82 */
void AILife_RCPickSliceAndDirection(Car_tObj *carObj);   /* :94 */
void AILife_RCPickDesiredLatPosition(Car_tObj *carObj);   /* :182 */
void AILife_PlaceCarAtLocation(Car_tObj *carObj, int slice, int desiredLatPos, int direction, int currentSpeed, int rotation1024);   /* :258 */
void AILife_SetInitialSlicePositionOrientationEtc(Car_tObj *carObj);   /* :269 */
void AILife_PlaceCarAtLocation(Car_tObj *carObj, int rotation1024);   /* :279 */
void AILife_ReencarnateTraffic(Car_tObj *carObj);   /* :342 */
void AILife_ReencarnateTrafficByPosition(Car_tObj *carObj, int slice, int travelDirection, coorddef *pos, matrixtdef *ori);   /* :396 */
void AILife_ReencarnateCopBySlice(Car_tObj *carObj, int slice, int travelDirection, int roadSide, int moving);   /* :478 */
void AILife_ReencarnateCopByPosition(Car_tObj *carObj, int slice, int travelDirection, coorddef *pos, matrixtdef *ori);   /* :529 */
void AILife_ReencarnateCopByLatPosAndRotation(Car_tObj *carObj, int slice, int travelDirection, int latPos, int rotation1024);   /* :572 */
int AILife_IsCoordInThisLiveArea(coorddef *tPos, Car_tObj *racer);   /* :627 */
Car_tObj * AILife_IsTrafficCarInAnyLiveArea(Car_tObj *traffic);   /* :654 */
int AILife_IsCoordInThisVisibleArea(coorddef *tPos, Car_tObj *racer);   /* :673 */
Car_tObj * AILife_IsCarInAnyVisibleArea(Car_tObj *carObj);   /* :697 */
Car_tObj * AILife_IsSliceInAnyVisibleArea(int slice);   /* :706 */
Car_tObj * AILife_IsSliceCloseToAnyCopCar(int slice);   /* :728 */
Car_tObj * AILife_IsPositionInAnyVisibleArea(coorddef *pos);   /* :747 */
void AILife_Debug(char *format, ...);   /* :764 */

#endif /* _GAME_COMMON_AILIFE_H_ */
