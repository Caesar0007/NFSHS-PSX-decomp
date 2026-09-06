/* game/psx/cario.h — reconstructed from game/psx/cario.cpp (11 fns) */
#ifndef _GAME_PSX_CARIO_H_
#define _GAME_PSX_CARIO_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

void CarIO_StartUp(void);   /* SYM 39b732 @0x800bbf10 */
void CarIO_CleanUp(void);   /* SYM 39b751 @0x800bbf7c */
void CarIO_ReStart(void);   /* SYM 39b770 @0x800bbfa4 */
void CarIO_CopyFromShape(short * source,short * dest,int w,int h,int x,int y);   /* SYM 39b78f @0x800bbff0 */
void CarIO_CopyToShape(short * source,short * dest,int mirror);   /* SYM 39b7bb @0x800bc1b4 */
void CarIO_CreateLicense(char * text,int carType,int player);   /* SYM 39b7e2 @0x800bc25c */
void CarIO_CleanUpLicense(int player);   /* SYM 39b80a @0x800bc5f0 */
void CarIO_LicenseCheck(int reload,int * license_vx,int * license_vy,Car_tObj * carObj,int plate);   /* SYM 39b830 @0x800bc668 */
void CarIO_ReadInCarTextureData(char * shpfile,Car_tObj * carObj,int reload,int player);   /* SYM 39b863 @0x800bc704 */
void CarIO_UpdateCarTextureData(char * shpfile,Car_tObj * carObj,int player);   /* SYM 39b89c @0x800bceb0 */
void CarIO_ReleaseCarCluts(Car_tObj * carObj);   /* SYM 39b8d4 @0x800bd358 */

#endif /* _GAME_PSX_CARIO_H_ */
