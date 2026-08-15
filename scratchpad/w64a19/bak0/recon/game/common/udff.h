/* game/common/udff.h — reconstructed from game/common/udff.cpp (4 fns) */
#ifndef _GAME_COMMON_UDFF_H_
#define _GAME_COMMON_UDFF_H_
#include "../../nfs4_types.h"

void * Udff_Opena__FPcT0i(char *name, char *mem, int abortFlag);   /* :21 */
void Udff_Close__FP10Udff_tInfo(Udff_tInfo *handle);   /* :84 */
int Udff_GetInt__FP10Udff_tInfo(Udff_tInfo *handle);   /* :105 */
void Udff_GetBuffer__FP10Udff_tInfoPci(Udff_tInfo *handle, char *mem, int size);   /* :203 */

#endif /* _GAME_COMMON_UDFF_H_ */
