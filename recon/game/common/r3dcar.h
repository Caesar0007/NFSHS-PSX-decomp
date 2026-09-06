/* game/common/r3dcar.h — reconstructed from game/common/r3dcar.cpp (27 fns) */
#ifndef _GAME_COMMON_R3DCAR_H_
#define _GAME_COMMON_R3DCAR_H_
#include "r3dcar_types.h"

/* P875: native signatures and defining exports verified by typed-reference
 * probes. Source names let the compiler emit the original C++ linkage. */

void R3DCar_ChangeTrafficColor(Car_tObj *carObj, int newColorIndex);   /* :386 */
void R3DCar_StartUp(void);   /* :424 */
void R3DCar_PostStartUp(void);   /* :466 */
void R3DCar_Restart(void);   /* :495 */
void R3DCar_CleanUp(void);   /* :518 */
Transformer_zScene * R3DCar_ReadInCarData(char *filename, Car_tObj *carObj);   /* :580 */
void R3DCcar_ReadeMapData(void);   /* :886 */
void R3DCcar_ReadTrackShadow(void);   /* :917 */
void R3DCar_CalcCarDimensions(Car_tObj *carObj, Transformer_zScene *scene, int carType);   /* :958 */
void R3DCar_DeInstantiate3DCar(Car_tObj *carObj);   /* :1046 */
void R3DCar_DeInstantiate3DCarMenu(Car_tObj *carObj);   /* :1054 */
void R3DCar_GetFileName(char *infilename, char *filename, char *suffix);   /* :1118 */
char * R3DCar_LoadFileAdr(char *name);   /* :1133 */
void R3DCar_GetCarName(char *filename, int carType, int country);   /* :1145 */
void R3DCar_Instantiate3DCar(Car_tObj *carObj, int index);   /* :1159 */
int R3DCar_Visibilty(Car_tObj *carObj, DRender_tView *Vi);   /* :1405 */
void R3DCar_TurnHeadLightOn(Car_tObj *carObj, int tail);   /* :1516 */
void R3DCar_TurnHeadLightOff(Car_tObj *carObj, int head);   /* :1525 */
void R3DCar_MATRIX3DT_Copy(int *from, int *to);   /* :1538 */
void R3DCar_InsertCarFacet(Car_tObj *carObj, DRender_tView *Vi);   /* :1546 */
void R3DCar_ReadInCarTextureMenu(Car_tObj *carObj, char *bigfile, int reload, int player);   /* :2185 */
void R3DCar_InsertCarFacetMenu(Car_tObj *carObj, DRender_tView *Vi);   /* :2351 */
void R3DCar_InsertCarFacetII(Car_tObj *carObj);   /* :3091 */
void R3DCar_InsertCarFacetMenuII(Car_tObj *carObj, int light);   /* :3273 */
void R3DCar_Showroom(DRender_tView *Vi);   /* :3399 */
void R3DCar_InsertCarFacetZ(Car_tObj *carObj, DRender_tView *Vi);   /* :3411 */
void R3DCar_InsertAllListFacet(DRender_tView *Vi);   /* :3416 */

#endif /* _GAME_COMMON_R3DCAR_H_ */
