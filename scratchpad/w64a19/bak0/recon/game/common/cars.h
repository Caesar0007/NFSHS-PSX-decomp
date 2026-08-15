/* game/common/cars.h — reconstructed from game/common/cars.cpp (33 fns) */
#ifndef _GAME_COMMON_CARS_H_
#define _GAME_COMMON_CARS_H_
#include "../../nfs4_types.h"

void Cars_DoGravityEffectsOnAcc__FP8Car_tObji(Car_tObj *carObj, int arcade);   /* :374 */
void Cars_GetDashData__FP8Car_tObjPiN21(Car_tObj *carObj, int *rpm, int *gear, int *speed);   /* :422 */
void Cars_QDUpdateVelGlue__FP8Car_tObj(Car_tObj *carObj);   /* :430 */
void Cars_InitDashData__FP8Car_tObjPiT1(Car_tObj *carObj, int *redline, int *topspeed);   /* :473 */
void Cars_SetAudioCalls__FP8Car_tObjiiiiii(Car_tObj *carObj, int type, int chan, int s1, int s2, int force, int pan);   /* :479 */
void Cars_ResetCarCounters__Fv(void);   /* :492 */
void Cars_InitStats__FP8Car_tObj(Car_tObj *carObj);   /* :505 */
void Cars_InitializeCarTablesFlagsAndCounters__FP8Car_tObj(Car_tObj *carObj);   /* :538 */
void Cars_ResetVariablesAfterACollision__FP8Car_tObj(Car_tObj *carObj);   /* :678 */
void Cars_ResetCollidedCars__FP8Car_tObjii(Car_tObj *carObj, int forceReset, int forceParkAtSide);   /* :713 */
void Cars_SetCarUpForHiRezSim__FP8Car_tObj(Car_tObj *carObj);   /* :837 */
void Cars_DoExtraCarCollisionProcessing__FP8Car_tObj(Car_tObj *carObj);   /* :856 */
void Cars_AddCarSfx__FP8Car_tObjiP8coorddefiii(Car_tObj *carObj, int wheel, coorddef *skidpt, int roadSurface, int surfaceType, int drawSkid);   /* :1159 */
void Car_TireSkiddingStuff__FP8Car_tObj(Car_tObj *carObj);   /* :1259 */
void Cars_FindTotalSlice__FP8Car_tObj(Car_tObj *carObj);   /* :1552 */
void Car_DoSkiddingStuff__FP8Car_tObj(Car_tObj *carObj);   /* :1575 */
void Car_DoPostCollisionStuff__FP8Car_tObj(Car_tObj *carObj);   /* :1653 */
void Cars_CalculateStartingGridOffset__FP8Car_tObjPiP8coorddef(Car_tObj *carObj, int *slice, coorddef *offset);   /* :1741 */
void Cars_IniCarObjects__FP8Car_tObji(Car_tObj *carObj, int index);   /* :1794 */
void Cars_InitCar__FP8Car_tObji(Car_tObj *carObj, int index);   /* :2031 */
void Cars_DeInitCar__FP8Car_tObj(Car_tObj *carObj);   /* :2232 */
void Cars_Restart__Fv(void);   /* :2246 */
void Cars_Initialize__FPci(char *mem, int size);   /* :2351 */
void Cars_StartUp__Fv(void);   /* :2363 */
void Cars_CleanUp__Fv(void);   /* :2514 */
void Cars_FindCurrentLap__FP8Car_tObj(Car_tObj *carObj);   /* :2590 */
int Cars_CalculateRoadSpan__FP8Car_tObj(Car_tObj *carObj);   /* :2624 */
int Cars_CalculateRoadPosition__FP8Car_tObj(Car_tObj *carObj);   /* :2682 */
int Cars_CalcVelDownRoad__FP8Car_tObj(Car_tObj *carObj);   /* :2687 */
void Cars_Randomize__Fv(void);   /* :2698 */
void Cars_ManageBureaucracy__Fv(void);   /* :2712 */
void Cars_CheckForAccidentScenes__Fv(void);   /* :2776 */
void Cars_SortCars__Fv(void);   /* :2815 */

#endif /* _GAME_COMMON_CARS_H_ */
