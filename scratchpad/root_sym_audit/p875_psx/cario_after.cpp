#include "C:/Temp/nfs4-decomp/recon/game/psx/cario.h"
void (*p875_probe_0)(void) = &CarIO_StartUp;
void (*p875_probe_1)(void) = &CarIO_CleanUp;
void (*p875_probe_2)(void) = &CarIO_ReStart;
void (*p875_probe_3)(short * source,short * dest,int w,int h,int x,int y) = &CarIO_CopyFromShape;
void (*p875_probe_4)(short * source,short * dest,int mirror) = &CarIO_CopyToShape;
void (*p875_probe_5)(char * text,int carType,int player) = &CarIO_CreateLicense;
void (*p875_probe_6)(int player) = &CarIO_CleanUpLicense;
void (*p875_probe_7)(int reload,int * license_vx,int * license_vy,Car_tObj * carObj,int plate) = &CarIO_LicenseCheck;
void (*p875_probe_8)(char * shpfile,Car_tObj * carObj,int reload,int player) = &CarIO_ReadInCarTextureData;
void (*p875_probe_9)(char * shpfile,Car_tObj * carObj,int player) = &CarIO_UpdateCarTextureData;
void (*p875_probe_10)(Car_tObj * carObj) = &CarIO_ReleaseCarCluts;
