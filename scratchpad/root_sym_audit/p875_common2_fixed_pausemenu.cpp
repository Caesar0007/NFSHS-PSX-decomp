/* P875 follow-up typed API references; compile-only, never a game input. */
#include "C:/Temp/nfs4-decomp/recon/game/common/pausemenu.h"
void (*p875_common2_pausemenu_0)(char *sMenuText,short x,short flags,short color) = &PauseMenu_FullText;
void (*p875_common2_pausemenu_1)(short index,short selected,short disabled,short x) = &PauseMenu_MenuTextPositioned;
void (*p875_common2_pausemenu_2)(short index,bool selected,bool disabled) = &PauseMenu_MenuText;
