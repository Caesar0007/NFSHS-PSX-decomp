/* game/psx/platform.h — reconstructed from game/psx/platform.cpp (8 fns) */
#ifndef _GAME_PSX_PLATFORM_H_
#define _GAME_PSX_PLATFORM_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

void Platform_InitMemory(void);   /* SYM 447bc1 @0x800dc2b8 */
char * Platform_ReserveMemory(int size,char * string);   /* SYM 447be6 @0x800dc2e8 */
char * Platform_TempReserveMemory(int size,char * string);   /* SYM 447c10 @0x800dc334 */
void Platform_SysStartUp(void);   /* SYM 447c3e @0x800dc378 */
void Platform_DebuggerPollHost(void);   /* SYM 447c63 @0x800dc450 */
void nfs2eacinit(void);   /* SYM 447c8e @0x800dc458 */
void Platform_ResetDCTBuffer(void);   /* SYM 447cab @0x800dc4a0 */
char * Platform_GetDCTBuffer(int size,char * string);   /* SYM 447cd4 @0x800dc4b4 */

#endif /* _GAME_PSX_PLATFORM_H_ */
