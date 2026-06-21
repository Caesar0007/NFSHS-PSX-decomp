/* game/psx/cario.h — reconstructed from game/psx/cario.cpp (11 fns) */
#ifndef _GAME_PSX_CARIO_H_
#define _GAME_PSX_CARIO_H_
#include "../../nfs4_types.h"

void CarIO_StartUp__Fv(void);   /* :208 */
void CarIO_CleanUp__Fv(void);   /* :233 */
void CarIO_ReStart__Fv(void);   /* :244 */
void CarIO_CopyFromShape__FPsT0iiii(short *source, short *dest, int w, int h, int x, int y);   /* :258 */
void CarIO_CopyToShape__FPsT0i(short *source, short *dest, int mirror);   /* :347 */
void CarIO_CreateLicense__FPcii(char *text, int carType, int player);   /* :379 */
void CarIO_CleanUpLicense__Fi(int player);   /* :486 */
void CarIO_LicenseCheck__FiPiT1P8Car_tObji(int reload, int *license_vx, int *license_vy, Car_tObj *carObj, int plate);   /* :497 */
void CarIO_ReadInCarTextureData__FPcP8Car_tObjii(char *shpfile, Car_tObj *carObj, int reload, int player);   /* :515 */
void CarIO_UpdateCarTextureData__FPcP8Car_tObji(char *shpfile, Car_tObj *carObj, int player);   /* :718 */
void CarIO_ReleaseCarCluts__FP8Car_tObj(Car_tObj *carObj);   /* :856 */

#endif /* _GAME_PSX_CARIO_H_ */
