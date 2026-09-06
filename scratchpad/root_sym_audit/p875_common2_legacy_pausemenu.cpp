/* P875 follow-up typed API references; compile-only, never a game input. */
#include "p875_common2_original_pausemenu.h"
void (*p875_common2_pausemenu_0)(char *sMenuText, short x, short flags, short color) = &PauseMenu_FullText__FPcsss;
void (*p875_common2_pausemenu_1)(short index, short selected, short disabled, short x) = &PauseMenu_MenuTextPositioned__Fssss;
void (*p875_common2_pausemenu_2)(short index, BOOL selected, BOOL disabled) = &PauseMenu_MenuText__FsbT1;
