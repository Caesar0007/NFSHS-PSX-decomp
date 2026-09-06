/* game/psx/night.h — reconstructed from game/psx/night.cpp (19 fns) */
#ifndef _GAME_PSX_NIGHT_H_
#define _GAME_PSX_NIGHT_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

int Night_FindClosestColor(CVECTOR colorMatch,int * bestIndex);   /* SYM 43b827 @0x800db318 */
void Night_CreateNightTableElement(int colorIndex,long colorH,int bright,u_char * colorval);   /* SYM 43b859 @0x800db3e0 */
void Night_CreateNightTable(int colorIndex,long colorH,int bright,u_char (* tbl)[256][16]);   /* SYM 43b88d @0x800db5a4 */
void Night_GenerateNextLightningEvent(void);   /* SYM 43b8c3 @0x800db5cc */
void Night_PauseLightningEffect(int player);   /* SYM 43b8f5 @0x800db640 */
void Night_DoLightningEffect(DRender_tView * Vi);   /* SYM 43b921 @0x800db6c4 */
void Night_SetCopColor(GameSetup_tCarData * carinfo);   /* SYM 43b959 @0x800db848 */
void Night_InitPlayerHeadLightColor(int player);   /* SYM 43b990 @0x800db8dc */
void Night_SetPlayerHeadLightColor(int player,int colorIndex,int bright);   /* SYM 43b9c0 @0x800db938 */
void Night_InitCopLightColors(void);   /* SYM 43b9f1 @0x800db974 */
void Night_SetCopLightColors(int colorIndex,int brighten);   /* SYM 43ba1b @0x800db9d0 */
void Night_InitWeatherTables(void);   /* SYM 43ba45 @0x800dba50 */
void Night_SetWeatherColors(int colorIndex);   /* SYM 43ba6e @0x800dbad4 */
void Night_GenerateAllLightTables(void);   /* SYM 43ba96 @0x800dbb50 */
void Night_InitNightDriving(void);   /* SYM 43bac4 @0x800dbde4 */
void Night_KillNightDriving(void);   /* SYM 43baec @0x800dbf80 */
void Night_RestartNightDriving(void);   /* SYM 43bb14 @0x800dc020 */
void Night_SetEnviroment(DRender_tView * Vi);   /* SYM 43bb3f @0x800dc0a8 */
void Night_AdditiveNightCalc(VECTOR * v,CVECTOR * color);   /* SYM 43bb73 @0x800dc1b8 */

#endif /* _GAME_PSX_NIGHT_H_ */
