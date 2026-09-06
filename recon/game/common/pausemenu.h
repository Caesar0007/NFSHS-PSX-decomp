/* game/common/pausemenu.h — reconstructed from game/common/pausemenu.cpp, game/common/pausemenu.h (60 fns) */
#ifndef _GAME_COMMON_PAUSEMENU_H_
#define _GAME_COMMON_PAUSEMENU_H_
#include "../../nfs4_types.h"

/* P875: native EXT free APIs use source spellings. Constructor/member APIs
 * come from the included class declarations; duplicate encoded non-members
 * conflicted with them. Typed references/calls verify the actual exports. */

void PauseMenu_FullText(char *sMenuText, short x, short flags, short color);   /* :60 */
void PauseMenu_MenuTextPositioned(short index, short selected, short disabled, short x);   /* :87 */
void PauseMenu_MenuText(short index, bool selected, bool disabled);   /* :103 */

/* Header-attributed inline methods are declared on tPMenuItem in nfs4_types.h. */

#endif /* _GAME_COMMON_PAUSEMENU_H_ */
