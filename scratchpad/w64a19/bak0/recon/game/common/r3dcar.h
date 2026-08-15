/* game/common/r3dcar.h — reconstructed from game/common/r3dcar.cpp (27 fns) */
#ifndef _GAME_COMMON_R3DCAR_H_
#define _GAME_COMMON_R3DCAR_H_
#include "../../nfs4_types.h"

void R3DCar_ChangeTrafficColor__FP8Car_tObji(Car_tObj *carObj, int newColorIndex);   /* :386 */
void R3DCar_StartUp__Fv(void);   /* :424 */
void R3DCar_PostStartUp__Fv(void);   /* :466 */
void R3DCar_Restart__Fv(void);   /* :495 */
void R3DCar_CleanUp__Fv(void);   /* :518 */
void * R3DCar_ReadInCarData__FPcP8Car_tObj(char *filename, Car_tObj *carObj);   /* :580 */
void R3DCcar_ReadeMapData__Fv(void);   /* :886 */
void R3DCcar_ReadTrackShadow__Fv(void);   /* :917 */
void R3DCar_CalcCarDimensions__FP8Car_tObjP18Transformer_zScenei(Car_tObj *carObj, Transformer_zScene *scene, int carType);   /* :958 */
void R3DCar_DeInstantiate3DCar__FP8Car_tObj(Car_tObj *carObj);   /* :1046 */
void R3DCar_DeInstantiate3DCarMenu__FP8Car_tObj(Car_tObj *carObj);   /* :1054 */
void R3DCar_GetFileName__FPcN20(char *infilename, char *filename, char *suffix);   /* :1118 */
char * R3DCar_LoadFileAdr__FPc(char *name);   /* :1133 */
void R3DCar_GetCarName__FPcii(char *filename, int carType, int country);   /* :1145 */
void R3DCar_Instantiate3DCar__FP8Car_tObji(Car_tObj *carObj, int index);   /* :1159 */
int R3DCar_Visibilty__FP8Car_tObjP13DRender_tView(Car_tObj *carObj, DRender_tView *Vi);   /* :1405 */
void R3DCar_TurnHeadLightOn__FP8Car_tObji(Car_tObj *carObj, int tail);   /* :1516 */
void R3DCar_TurnHeadLightOff__FP8Car_tObji(Car_tObj *carObj, int head);   /* :1525 */
void R3DCar_MATRIX3DT_Copy__FPiT0(int *from, int *to);   /* :1538 */
void R3DCar_InsertCarFacet__FP8Car_tObjP13DRender_tView(Car_tObj *carObj, DRender_tView *Vi);   /* :1546 */
void R3DCar_ReadInCarTextureMenu__FP8Car_tObjPcii(Car_tObj *carObj, char *bigfile, int reload, int player);   /* :2185 */
void R3DCar_InsertCarFacetMenu__FP8Car_tObjP13DRender_tView(Car_tObj *carObj, DRender_tView *Vi);   /* :2351 */
void R3DCar_InsertCarFacetII__FP8Car_tObj(Car_tObj *carObj);   /* :3091 */
void R3DCar_InsertCarFacetMenuII__FP8Car_tObji(Car_tObj *carObj, int light);   /* :3273 */
void R3DCar_Showroom__FP13DRender_tView(DRender_tView *Vi);   /* :3399 */
void R3DCar_InsertCarFacetZ__FP8Car_tObjP13DRender_tView(Car_tObj *carObj, DRender_tView *Vi);   /* :3411 */
void R3DCar_InsertAllListFacet__FP13DRender_tView(DRender_tView *Vi);   /* :3416 */

#endif /* _GAME_COMMON_R3DCAR_H_ */
