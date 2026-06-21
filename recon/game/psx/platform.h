/* game/psx/platform.h — reconstructed from game/psx/platform.cpp (8 fns) */
#ifndef _GAME_PSX_PLATFORM_H_
#define _GAME_PSX_PLATFORM_H_
#include "../../nfs4_types.h"

void Platform_InitMemory__Fv(void);   /* :125 */
char * Platform_ReserveMemory__FiPc(int size, char *string);   /* :139 */
char * Platform_TempReserveMemory__FiPc(int size, char *string);   /* :161 */
void Platform_SysStartUp__Fv(void);   /* :207 */
void Platform_DebuggerPollHost__Fv(void);   /* :326 */
void nfs2eacinit__Fv(void);   /* :369 */
void Platform_ResetDCTBuffer__Fv(void);   /* :439 */
char * Platform_GetDCTBuffer__FiPc(int size, char *string);   /* :444 */

#endif /* _GAME_PSX_PLATFORM_H_ */
