/* Frozen original recon/game/psx/cario.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
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
void (*p875_probe_0)(void) = &CarIO_StartUp__Fv;
void (*p875_probe_1)(void) = &CarIO_CleanUp__Fv;
void (*p875_probe_2)(void) = &CarIO_ReStart__Fv;
void (*p875_probe_3)(short *source, short *dest, int w, int h, int x, int y) = &CarIO_CopyFromShape__FPsT0iiii;
void (*p875_probe_4)(short *source, short *dest, int mirror) = &CarIO_CopyToShape__FPsT0i;
void (*p875_probe_5)(char *text, int carType, int player) = &CarIO_CreateLicense__FPcii;
void (*p875_probe_6)(int player) = &CarIO_CleanUpLicense__Fi;
void (*p875_probe_7)(int reload, int *license_vx, int *license_vy, Car_tObj *carObj, int plate) = &CarIO_LicenseCheck__FiPiT1P8Car_tObji;
void (*p875_probe_8)(char *shpfile, Car_tObj *carObj, int reload, int player) = &CarIO_ReadInCarTextureData__FPcP8Car_tObjii;
void (*p875_probe_9)(char *shpfile, Car_tObj *carObj, int player) = &CarIO_UpdateCarTextureData__FPcP8Car_tObji;
void (*p875_probe_10)(Car_tObj *carObj) = &CarIO_ReleaseCarCluts__FP8Car_tObj;
