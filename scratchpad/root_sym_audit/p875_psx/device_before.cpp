/* Frozen original recon/game/psx/device.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
int Device_VerifyType__Fi(int port);   /* :51 */
int Device_Fail__Fi(int port);   /* :72 */
void Device_Update__Fv(void);   /* :109 */
void Device_StartUp__Fv(void);   /* :169 */
void Device_SetHardCodedKeys__Fv(void);   /* :195 */
int Device_PSXPad__FUl(u_long param);   /* :244 */
BOOL Device_ReadPad__FiUl(int port, u_long param);   /* :261 */
int Device_PSXPadMulti__FUl(u_long param);   /* :306 */
int Device_Analog__FUl(u_long param);   /* :352 */
int Device_Null__FUl(u_long param);   /* :393 */
int (*p875_probe_0)(int port) = &Device_VerifyType__Fi;
int (*p875_probe_1)(int port) = &Device_Fail__Fi;
void (*p875_probe_2)(void) = &Device_Update__Fv;
void (*p875_probe_3)(void) = &Device_StartUp__Fv;
void (*p875_probe_4)(void) = &Device_SetHardCodedKeys__Fv;
int (*p875_probe_5)(u_long param) = &Device_PSXPad__FUl;
BOOL (*p875_probe_6)(int port, u_long param) = &Device_ReadPad__FiUl;
int (*p875_probe_7)(u_long param) = &Device_PSXPadMulti__FUl;
int (*p875_probe_8)(u_long param) = &Device_Analog__FUl;
int (*p875_probe_9)(u_long param) = &Device_Null__FUl;
