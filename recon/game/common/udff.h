/* game/common/udff.h — reconstructed from game/common/udff.cpp (4 fns) */
#ifndef _GAME_COMMON_UDFF_H_
#define _GAME_COMMON_UDFF_H_
#include "../../nfs4_types.h"

/* P875: source names/signatures checked against native EXT records and
 * defining exports; compile-only typed references verify the C++ linkage. */

Udff_tInfo * Udff_Opena(char *name, char *mem, int abortFlag);   /* :21 */
void Udff_Close(Udff_tInfo *handle);   /* :84 */
int Udff_GetInt(Udff_tInfo *handle);   /* :105 */
void Udff_GetBuffer(Udff_tInfo *handle, char *mem, int size);   /* :203 */

#endif /* _GAME_COMMON_UDFF_H_ */
