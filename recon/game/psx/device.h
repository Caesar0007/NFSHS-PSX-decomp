/* game/psx/device.h — reconstructed from game/psx/device.cpp (10 fns) */
#ifndef _GAME_PSX_DEVICE_H_
#define _GAME_PSX_DEVICE_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

int Device_VerifyType(int port);   /* SYM 3a9947 @0x800bd3c0 */
int Device_Fail(int port);   /* SYM 3a996a @0x800bd468 */
void Device_Update(void);   /* SYM 3a9987 @0x800bd4d8 */
void Device_StartUp(void);   /* SYM 3a99a6 @0x800bd5b8 */
void Device_SetHardCodedKeys(void);   /* SYM 3a99c6 @0x800bd5e0 */
int Device_PSXPad(u_long param);   /* SYM 3a99ef @0x800bd644 */
bool Device_ReadPad(int port,u_long param);   /* SYM 3a9a0f @0x800bd6ac */
int Device_PSXPadMulti(u_long param);   /* SYM 3a9a31 @0x800bd8dc */
int Device_Analog(u_long param);   /* SYM 3a9a56 @0x800bd9b8 */
int Device_Null(u_long param);   /* SYM 3a9a76 @0x800bdab8 */

#endif /* _GAME_PSX_DEVICE_H_ */
