/* game/common/pausemenu.h — reconstructed from game/common/pausemenu.cpp, game/common/pausemenu.h (60 fns) */
#ifndef _GAME_COMMON_PAUSEMENU_H_
#define _GAME_COMMON_PAUSEMENU_H_

/* P875: native EXT free APIs use source spellings. Constructor/member APIs
 * come from the included class declarations; duplicate encoded non-members
 * conflicted with them. Typed references/calls verify the actual exports. */

void PauseMenu_FullText(char *sMenuText, short x, short flags, short color);   /* :60 */
void PauseMenu_MenuTextPositioned(short index, short selected, short disabled, short x);   /* :87 */
void PauseMenu_MenuText(short index, bool selected, bool disabled);   /* :103 */

/* The including owner supplies tPMenuItem's declaration. Retail PAUSEMENU.H
 * lines115/116 contain these adjacent definitions in this order; both the
 * expanded uses and compiler-deferred standalone copies belong to this file.
 * No class storage, virtual slot, qualifier or source object is added. */
inline bool tPMenuItem::IsDisabled() { return this->fFlags & 1; }
inline bool tPMenuItem::IsEnabled() { return (this->fFlags ^ 1) & 1; }

#endif /* _GAME_COMMON_PAUSEMENU_H_ */
