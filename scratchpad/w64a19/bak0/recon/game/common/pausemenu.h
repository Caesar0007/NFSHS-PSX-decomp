/* game/common/pausemenu.h — reconstructed from game/common/pausemenu.cpp, game/common/pausemenu.h (60 fns) */
#ifndef _GAME_COMMON_PAUSEMENU_H_
#define _GAME_COMMON_PAUSEMENU_H_
#include "../../nfs4_types.h"

void PauseMenu_FullText__FPcsss(char *sMenuText, short x, short flags, short color);   /* :60 */
void PauseMenu_MenuTextPositioned__Fssss(short index, short selected, short disabled, short x);   /* :87 */
void PauseMenu_MenuText__FsbT1(short index, BOOL selected, BOOL disabled);   /* :103 */
void * __14tPListIteratorPsPi(tPListIterator *self, short *selection, int *valPtr);   /* :123 */
void ___14tPListIterator(tPListIterator *self, int __in_chrg);   /* :129 */
char Value__14tPListIterator7tPlayer(tPListIterator *self, int arg1);   /* :134 */
short TextValue__14tPListIterator7tPlayer(tPListIterator *self, int arg1);   /* :139 */
void Increment__14tPListIterator7tPlayer(tPListIterator *self, int arg1);   /* :144 */
void Decrement__14tPListIterator7tPlayer(tPListIterator *self, int arg1);   /* :154 */
void * __21tPListIteratorIndexedPsPiPc(tPListIteratorIndexed *self, short *selection, int *valPtr, char *index);   /* :197 */
void ___21tPListIteratorIndexed(tPListIteratorIndexed *self, int __in_chrg);   /* :203 */
char Value__21tPListIteratorIndexed7tPlayer(tPListIteratorIndexed *self, int arg1);   /* :207 */
short TextValue__21tPListIteratorIndexed7tPlayer(tPListIteratorIndexed *self, int arg1);   /* :212 */
void Increment__21tPListIteratorIndexed7tPlayer(tPListIteratorIndexed *self, int arg1);   /* :219 */
void Decrement__21tPListIteratorIndexed7tPlayer(tPListIteratorIndexed *self, int arg1);   /* :229 */
void * __10tPMenuItemUi(tPMenuItem *self, unsigned int textDescription);   /* :246 */
void ___10tPMenuItem(tPMenuItem *self, int __in_chrg);   /* :252 */
void * NextMenu__10tPMenuItem(tPMenuItem *self);   /* :256 */
BOOL Debounce__10tPMenuItem(tPMenuItem *self);   /* :261 */
void ProcessInput__10tPMenuItemR13tInputKeyTypeR13tPMenuCommand(tPMenuItem *self, int *key_input, tPMenuCommand *menu_cmd);   /* :266 */
void * __28tPMenuItemNonInteractiveTextUi(tPMenuItemNonInteractiveText *self, unsigned int textDescription);   /* :273 */
void ___28tPMenuItemNonInteractiveText(tPMenuItemNonInteractiveText *self, int __in_chrg);   /* :278 */
void Draw__28tPMenuItemNonInteractiveTextb(tPMenuItemNonInteractiveText *self, BOOL selected);   /* :283 */
BOOL IsNavigable__28tPMenuItemNonInteractiveText(tPMenuItemNonInteractiveText *self);   /* :288 */
void * __21tPMenuItemInteractiveUi(tPMenuItemInteractive *self, unsigned int textDescription);   /* :297 */
void ___21tPMenuItemInteractive(tPMenuItemInteractive *self, int __in_chrg);   /* :302 */
BOOL IsNavigable__21tPMenuItemInteractive(tPMenuItemInteractive *self);   /* :306 */
void Draw__21tPMenuItemInteractiveb(tPMenuItemInteractive *self, BOOL selected);   /* :311 */
void * __25tPMenuItemLeftRightChoiceUiP14tPListIterator(tPMenuItemLeftRightChoice *self, unsigned int textDescription, tPListIterator *dataPtr);   /* :319 */
void ___25tPMenuItemLeftRightChoice(tPMenuItemLeftRightChoice *self, int __in_chrg);   /* :325 */
void ProcessInput__25tPMenuItemLeftRightChoiceR13tInputKeyTypeR13tPMenuCommand(tPMenuItemLeftRightChoice *self, int *keyval, tPMenuCommand *menu_cmd);   /* :329 */
void Draw__25tPMenuItemLeftRightChoiceb(tPMenuItemLeftRightChoice *self, BOOL selected);   /* :346 */
void * __25tPMenuItemLeftRightSliderUiPic(tPMenuItemLeftRightSlider *self, unsigned int textDescription, int *dataPtr, char maxVal);   /* :441 */
void ___25tPMenuItemLeftRightSlider(tPMenuItemLeftRightSlider *self, int __in_chrg);   /* :449 */
BOOL Debounce__25tPMenuItemLeftRightSlider(tPMenuItemLeftRightSlider *self);   /* :453 */
void ProcessInput__25tPMenuItemLeftRightSliderR13tInputKeyTypeR13tPMenuCommand(tPMenuItemLeftRightSlider *self, int *keyval, tPMenuCommand *menu_command);   /* :458 */
void Draw__25tPMenuItemLeftRightSliderb(tPMenuItemLeftRightSlider *self, BOOL selected);   /* :498 */
void * __32tPMenuItemLeftRightSliderIndexedUiPicPc(tPMenuItemLeftRightSliderIndexed *self, unsigned int textDescription, int *dataPtr, char maxVal, char *index);   /* :541 */
void ___32tPMenuItemLeftRightSliderIndexed(tPMenuItemLeftRightSliderIndexed *self, int __in_chrg);   /* :547 */
void ProcessInput__32tPMenuItemLeftRightSliderIndexedR13tInputKeyTypeR13tPMenuCommand(tPMenuItemLeftRightSliderIndexed *self, int *keyval, tPMenuCommand *command);   /* :553 */
void Draw__32tPMenuItemLeftRightSliderIndexedb(tPMenuItemLeftRightSliderIndexed *self, BOOL selected);   /* :561 */
void * __24tPMenuItemGoToMenuButtonUiP6tPMenuPFR13tPMenuCommand_v(tPMenuItemGoToMenuButton *self, unsigned int textDescription, tPMenu *newMenu, void *OnButtonPress);   /* :573 */
void ___24tPMenuItemGoToMenuButton(tPMenuItemGoToMenuButton *self, int __in_chrg);   /* :580 */
void * NextMenu__24tPMenuItemGoToMenuButton(tPMenuItemGoToMenuButton *self);   /* :584 */
void ProcessInput__24tPMenuItemGoToMenuButtonR13tInputKeyTypeR13tPMenuCommand(tPMenuItemGoToMenuButton *self, int *keyval, tPMenuCommand *command);   /* :589 */
void * __23tPMenuItemCommandButtonUi17tPMenuCommandType(tPMenuItemCommandButton *self, unsigned int textDescription, int command);   /* :613 */
void ___23tPMenuItemCommandButton(tPMenuItemCommandButton *self, int __in_chrg);   /* :619 */
void ProcessInput__23tPMenuItemCommandButtonR13tInputKeyTypeR13tPMenuCommand(tPMenuItemCommandButton *self, int *keyval, tPMenuCommand *command);   /* :623 */
void tPMenuConstructor__6tPMenuP10tPMenuItemPv(tPMenu *self, tPMenuItem *firstItem, void *ap);   /* :640 */
void * __6tPMenuP10tPMenuIteme(tPMenu *self, tPMenuItem *firstItem);   /* :669 */
void ___6tPMenu(tPMenu *self, int __in_chrg);   /* :679 */
void Initialize__6tPMenu(tPMenu *self);   /* :683 */
BOOL Debounce__6tPMenu(tPMenu *self);   /* :698 */
void CheckForDisabled__6tPMenu(tPMenu *self);   /* :703 */
void ProcessInput__6tPMenuR13tInputKeyTypeR13tPMenuCommand(tPMenu *self, int *keyval, tPMenuCommand *command);   /* :718 */
void Draw__6tPMenu(tPMenu *self);   /* :783 */
int NumEnabledItems__6tPMenu(tPMenu *self);   /* :805 */
int ItemEnabledNum__6tPMenui(tPMenu *self, int num);   /* :818 */

/* ---- header-defined (inline / class) functions ---- */
BOOL IsDisabled__10tPMenuItem(tPMenuItem *self);   /* :115 */
BOOL IsEnabled__10tPMenuItem(tPMenuItem *self);   /* :116 */

#endif /* _GAME_COMMON_PAUSEMENU_H_ */
