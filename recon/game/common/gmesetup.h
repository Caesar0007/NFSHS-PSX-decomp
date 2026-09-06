/* game/common/gmesetup.h — reconstructed from game/common/gmesetup.cpp (2 fns) */
#ifndef _GAME_COMMON_GMESETUP_H_
#define _GAME_COMMON_GMESETUP_H_
#include "../../nfs4_types.h"

/* P875: native source names/signatures; C++ supplies linkage mangling.
 * File-private functions stay in the implementation; class members remain
 * exposed by the included types without duplicate free declarations. */

void GameSetup_StartUp(int *FrontEndDataStream);   /* :155 */
void GameSetup_CleanUp(void);   /* :369 */

#endif /* _GAME_COMMON_GMESETUP_H_ */
