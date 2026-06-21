/* game/common/cars_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CARS_EXTERNS_H_
#define _GAME_COMMON_CARS_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

CARDINFO_def *MCRD_getcard(...);
char *TextSys_Word(int id);
extern Draw_tPixMap *gLeafPixmap;      /* 0x8013d218 */
extern GameSetup_tData   GameSetup_gData;
extern Object_tIMassObjInfo *Object_IMassObjInst;
extern Sim_tSimGlobalVar  simGlobal;          /* Sim.obj   (.gameTicks) */
extern Trk_NewSlice  *BWorldSm_slices;
extern Udff_tInfo * Udff_Opena(char *name,char *mem,int abortFlag);
extern camera_info       Camera_gInfo[2];            /* camera.obj */
extern char             GameSetup_gPersonalityNames[15][8];
extern char * PlayerNameMixedCase(int player);
extern char *R3DCar_LicenseShapeFile;
extern char GameSetup_gCarNames[51][5];
extern int                AITune_driveSide;
extern int               gTAddCarWheelDelay;       /* 0x8013d4f0 */
extern int            gNumSlices;
extern int   BWorldSm_FindClosestQuadRez(coorddef *c, BWorldSm_Pos *pos, int rez);
extern int Newton_CalculateRoadPosition(BO_tNewtonObj *newtonObj);
extern int SceneLoaded;
extern int Scene_BuildCustomSceneList(void);
extern int TrgSfx_AddCarExtraCheck(int car,int wheel);
extern long           Camera_gGeomScreen;
extern tfrontEnd         frontEnd;
extern u_int               fastRandom, randSeed, randtemp;   /* fastrand.obj PRNG state */
extern void  Physics_FixEngineRpm(Car_tObj *car);
extern void  Sched_AddFunction(Sched_tSchedule *s, void (*fn)(void *), void *arg, int hz);
extern void *BWorldSm_TunnelFlagSm(BWorldSm_Pos *pos);
extern void Collide_CheckMeForCollisions(BO_tNewtonObj *newObj);
extern void Force_StartUp(void);
extern void Force_Update(Car_tObj *car);
extern void Newton_ApplyTheLawOfGravity(Car_tObj *newtonObj);
extern void Newton_InitBaseNewtonObj(u_int *newtonObj,u_int index,int mass,u_int moInertia,int dimX, int dimY,int dimZ);
extern void Newton_QDUpdateRot32Hz(int newtonObj);
extern void Newton_QDUpdateRot64Hz(int newtonObj);
extern void Newton_QDUpdateVel(int newtonObj);
extern void Newton_SetInitialSlicePositionOrientationEtc(BO_tNewtonObj *n,int slice,coorddef *offset,int direction);
extern void Newton_UpdateRoadInfo(BO_tNewtonObj *n);
extern void Object_ClearCustomObjects(void);
extern void Object_GetIMassObjectDimensions(int objIndex,coorddef *dimensions);
extern void Physics_CalculateDerivedCarSpecs(Car_tObj *carObj);
extern void Physics_InitCarSpecs(Car_tObj *carObj,Udff_tInfo *handle);
extern void Physics_ResetCar(Car_tObj *carObj);
extern void Physics_SimCar(Car_tObj *carObj);
extern void Replay_DoReplay(Car_tObj *carObj);
extern void Sched_DeleteFunction(Sched_tSchedule *, void (*)(void *), void *);
extern void Stats_TrackStats(Car_tObj *carObj);
extern void TrgSfx_AddCarExtraSfx(int car,int wheel,coorddef *skidpt,int type,coorddef *vec,int velY,int ground, int colour);
extern void TrgSfx_AddCarSfx(int car,coorddef *skidpt,int type,coorddef *vec);
extern void TrgSfx_AddCarSplash(int car,int wheel,coorddef *skidpt,int type,coorddef *vec,int delay,int velXZ);
extern void TrgSfx_AddCarWheelSfx(int car,int wheel,coorddef *skidpt,int type,coorddef *vec,int delay);
extern void TrgSfx_AddSkidmark(int car,int wheel,coorddef *skidpt,int end,int intensity,Car_tObj *carObj,int type);
extern void TrgSfx_CrashCar(coorddef *location);
extern void Udff_Close(Udff_tInfo *handle);
int  FECheat_ActivateCheat(char*);  void s_lower(char*);  void s_upper(char*);
int  Force_IsForceOn(Car_tObj *car);
int  Object_GetNumIMassObjects(void);
int AIInit_IsNonStandardCarFile(int index);
int AITune_GetOneWay(void);
void  trap(int code);
void *PlayerNameExist(int);
void AIInit_DeInitAICar(Car_tObj *carObj);
void AIInit_InitAICar(Car_tObj *carObj, Udff_tInfo *handle);
void AIInit_RestartAICar(Car_tObj *carObj);
void AIPhysic_Main(Car_tObj *carObj);
void AIPhysic_ProcessCollision(Car_tObj *carObj);
void Control_AI(Car_tObj *carObj);
void Control_Human(Car_tObj *carObj);
void R3DCar_DeInstantiate3DCar(Car_tObj * carObj);
void R3DCar_Instantiate3DCar(Car_tObj * carObj, int index);

extern char           *Paths_Paths[];   /* 0x80116468 (paths.obj) */
#endif /* _GAME_COMMON_CARS_EXTERNS_H_ */
