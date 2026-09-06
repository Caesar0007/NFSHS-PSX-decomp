/* game/common/cars.h — reconstructed from game/common/cars.cpp (33 fns) */
#ifndef _GAME_COMMON_CARS_H_
#define _GAME_COMMON_CARS_H_
#include "../../nfs4_types.h"

/* P875: native signatures and defining exports verified by typed-reference
 * probes. Source names let the compiler emit the original C++ linkage. */

void Cars_DoGravityEffectsOnAcc(Car_tObj *carObj, int arcade);   /* :374 */
void Cars_GetDashData(Car_tObj *carObj, int *rpm, int *gear, int *speed);   /* :422 */
void Cars_QDUpdateVelGlue(Car_tObj *carObj);   /* :430 */
void Cars_InitDashData(Car_tObj *carObj, int *redline, int *topspeed);   /* :473 */
void Cars_SetAudioCalls(Car_tObj *carObj, int type, int chan, int s1, int s2, int force, int pan);   /* :479 */
void Cars_ResetCarCounters(void);   /* :492 */
void Cars_InitStats(Car_tObj *carObj);   /* :505 */
void Cars_InitializeCarTablesFlagsAndCounters(Car_tObj *carObj);   /* :538 */
void Cars_ResetVariablesAfterACollision(Car_tObj *carObj);   /* :678 */
void Cars_ResetCollidedCars(Car_tObj *carObj, int forceReset, int forceParkAtSide);   /* :713 */
void Cars_SetCarUpForHiRezSim(Car_tObj *carObj);   /* :837 */
void Cars_DoExtraCarCollisionProcessing(Car_tObj *carObj);   /* :856 */
void Cars_AddCarSfx(Car_tObj *carObj, int wheel, coorddef *skidpt, int roadSurface, int surfaceType, int drawSkid);   /* :1159 */
void Car_TireSkiddingStuff(Car_tObj *carObj);   /* :1259 */
void Cars_FindTotalSlice(Car_tObj *carObj);   /* :1552 */
void Car_DoSkiddingStuff(Car_tObj *carObj);   /* :1575 */
void Car_DoPostCollisionStuff(Car_tObj *carObj);   /* :1653 */
void Cars_CalculateStartingGridOffset(Car_tObj *carObj, int *slice, coorddef *offset);   /* :1741 */
void Cars_IniCarObjects(Car_tObj *carObj, int index);   /* :1794 */
void Cars_InitCar(Car_tObj *carObj, int index);   /* :2031 */
void Cars_DeInitCar(Car_tObj *carObj);   /* :2232 */
void Cars_Restart(void);   /* :2246 */
void Cars_Initialize(char *mem, int size);   /* :2351 */
void Cars_StartUp(void);   /* :2363 */
void Cars_CleanUp(void);   /* :2514 */
void Cars_FindCurrentLap(Car_tObj *carObj);   /* :2590 */
int Cars_CalculateRoadSpan(Car_tObj *carObj);   /* :2624 */
int Cars_CalculateRoadPosition(Car_tObj *carObj);   /* :2682 */
int Cars_CalcVelDownRoad(Car_tObj *carObj);   /* :2687 */
void Cars_Randomize(void);   /* :2698 */
void Cars_ManageBureaucracy(void);   /* :2712 */
void Cars_CheckForAccidentScenes(void);   /* :2776 */
void Cars_SortCars(void);   /* :2815 */

#endif /* _GAME_COMMON_CARS_H_ */
