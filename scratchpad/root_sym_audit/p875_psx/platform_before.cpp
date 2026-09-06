/* Frozen original recon/game/psx/platform.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
void Platform_InitMemory__Fv(void);   /* :125 */
char * Platform_ReserveMemory__FiPc(int size, char *string);   /* :139 */
char * Platform_TempReserveMemory__FiPc(int size, char *string);   /* :161 */
void Platform_SysStartUp__Fv(void);   /* :207 */
void Platform_DebuggerPollHost__Fv(void);   /* :326 */
void nfs2eacinit__Fv(void);   /* :369 */
void Platform_ResetDCTBuffer__Fv(void);   /* :439 */
char * Platform_GetDCTBuffer__FiPc(int size, char *string);   /* :444 */
void (*p875_probe_0)(void) = &Platform_InitMemory__Fv;
char * (*p875_probe_1)(int size, char *string) = &Platform_ReserveMemory__FiPc;
char * (*p875_probe_2)(int size, char *string) = &Platform_TempReserveMemory__FiPc;
void (*p875_probe_3)(void) = &Platform_SysStartUp__Fv;
void (*p875_probe_4)(void) = &Platform_DebuggerPollHost__Fv;
void (*p875_probe_5)(void) = &nfs2eacinit__Fv;
void (*p875_probe_6)(void) = &Platform_ResetDCTBuffer__Fv;
char * (*p875_probe_7)(int size, char *string) = &Platform_GetDCTBuffer__FiPc;
