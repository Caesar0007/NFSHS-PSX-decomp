/* P875 member APIs: compile-only pointers and constructor/destructor calls. */
#include "C:/Temp/nfs4-decomp/recon/game/common/pausemenu.h"
tPListIterator *p875_common2_member_pausemenu_0(short *selection,int *valPtr) { return new tPListIterator(selection,valPtr); }
void p875_common2_member_pausemenu_1(tPListIterator *self) { self->~tPListIterator(); }
char (tPListIterator::*p875_common2_member_pausemenu_2)(tPlayer) = (char (tPListIterator::*)(tPlayer))&tPListIterator::Value;
short (tPListIterator::*p875_common2_member_pausemenu_3)(tPlayer) = (short (tPListIterator::*)(tPlayer))&tPListIterator::TextValue;
void (tPListIterator::*p875_common2_member_pausemenu_4)(tPlayer) = (void (tPListIterator::*)(tPlayer))&tPListIterator::Increment;
void (tPListIterator::*p875_common2_member_pausemenu_5)(tPlayer) = (void (tPListIterator::*)(tPlayer))&tPListIterator::Decrement;
tPListIteratorIndexed *p875_common2_member_pausemenu_6(short *selection,int *valPtr,char *index) { return new tPListIteratorIndexed(selection,valPtr,index); }
void p875_common2_member_pausemenu_7(tPListIteratorIndexed *self) { self->~tPListIteratorIndexed(); }
char (tPListIteratorIndexed::*p875_common2_member_pausemenu_8)(tPlayer) = (char (tPListIteratorIndexed::*)(tPlayer))&tPListIteratorIndexed::Value;
short (tPListIteratorIndexed::*p875_common2_member_pausemenu_9)(tPlayer) = (short (tPListIteratorIndexed::*)(tPlayer))&tPListIteratorIndexed::TextValue;
void (tPListIteratorIndexed::*p875_common2_member_pausemenu_10)(tPlayer) = (void (tPListIteratorIndexed::*)(tPlayer))&tPListIteratorIndexed::Increment;
void (tPListIteratorIndexed::*p875_common2_member_pausemenu_11)(tPlayer) = (void (tPListIteratorIndexed::*)(tPlayer))&tPListIteratorIndexed::Decrement;
tPMenuItem *p875_common2_member_pausemenu_12(u_int textDescription) { return new tPMenuItem(textDescription); }
void p875_common2_member_pausemenu_13(tPMenuItem *self) { self->~tPMenuItem(); }
tPMenu * (tPMenuItem::*p875_common2_member_pausemenu_14)(void) = (tPMenu * (tPMenuItem::*)(void))&tPMenuItem::NextMenu;
bool (tPMenuItem::*p875_common2_member_pausemenu_15)(void) = (bool (tPMenuItem::*)(void))&tPMenuItem::Debounce;
void (tPMenuItem::*p875_common2_member_pausemenu_16)(tInputKeyType &,tPMenuCommand &) = (void (tPMenuItem::*)(tInputKeyType &,tPMenuCommand &))&tPMenuItem::ProcessInput;
tPMenuItemNonInteractiveText *p875_common2_member_pausemenu_17(u_int textDescription) { return new tPMenuItemNonInteractiveText(textDescription); }
void p875_common2_member_pausemenu_18(tPMenuItemNonInteractiveText *self) { self->~tPMenuItemNonInteractiveText(); }
void (tPMenuItemNonInteractiveText::*p875_common2_member_pausemenu_19)(bool) = (void (tPMenuItemNonInteractiveText::*)(bool))&tPMenuItemNonInteractiveText::Draw;
bool (tPMenuItemNonInteractiveText::*p875_common2_member_pausemenu_20)(void) = (bool (tPMenuItemNonInteractiveText::*)(void))&tPMenuItemNonInteractiveText::IsNavigable;
tPMenuItemInteractive *p875_common2_member_pausemenu_21(u_int textDescription) { return new tPMenuItemInteractive(textDescription); }
void p875_common2_member_pausemenu_22(tPMenuItemInteractive *self) { self->~tPMenuItemInteractive(); }
bool (tPMenuItemInteractive::*p875_common2_member_pausemenu_23)(void) = (bool (tPMenuItemInteractive::*)(void))&tPMenuItemInteractive::IsNavigable;
void (tPMenuItemInteractive::*p875_common2_member_pausemenu_24)(bool) = (void (tPMenuItemInteractive::*)(bool))&tPMenuItemInteractive::Draw;
tPMenuItemLeftRightChoice *p875_common2_member_pausemenu_25(u_int textDescription,tPListIterator *dataPtr) { return new tPMenuItemLeftRightChoice(textDescription,dataPtr); }
void p875_common2_member_pausemenu_26(tPMenuItemLeftRightChoice *self) { self->~tPMenuItemLeftRightChoice(); }
void (tPMenuItemLeftRightChoice::*p875_common2_member_pausemenu_27)(tInputKeyType &,tPMenuCommand &) = (void (tPMenuItemLeftRightChoice::*)(tInputKeyType &,tPMenuCommand &))&tPMenuItemLeftRightChoice::ProcessInput;
void (tPMenuItemLeftRightChoice::*p875_common2_member_pausemenu_28)(bool) = (void (tPMenuItemLeftRightChoice::*)(bool))&tPMenuItemLeftRightChoice::Draw;
tPMenuItemLeftRightSlider *p875_common2_member_pausemenu_29(u_int textDescription,int *dataPtr,char maxVal) { return new tPMenuItemLeftRightSlider(textDescription,dataPtr,maxVal); }
void p875_common2_member_pausemenu_30(tPMenuItemLeftRightSlider *self) { self->~tPMenuItemLeftRightSlider(); }
bool (tPMenuItemLeftRightSlider::*p875_common2_member_pausemenu_31)(void) = (bool (tPMenuItemLeftRightSlider::*)(void))&tPMenuItemLeftRightSlider::Debounce;
void (tPMenuItemLeftRightSlider::*p875_common2_member_pausemenu_32)(tInputKeyType &,tPMenuCommand &) = (void (tPMenuItemLeftRightSlider::*)(tInputKeyType &,tPMenuCommand &))&tPMenuItemLeftRightSlider::ProcessInput;
void (tPMenuItemLeftRightSlider::*p875_common2_member_pausemenu_33)(bool) = (void (tPMenuItemLeftRightSlider::*)(bool))&tPMenuItemLeftRightSlider::Draw;
tPMenuItemLeftRightSliderIndexed *p875_common2_member_pausemenu_34(u_int textDescription,int *dataPtr,char maxVal, char *index) { return new tPMenuItemLeftRightSliderIndexed(textDescription,dataPtr,maxVal,index); }
void p875_common2_member_pausemenu_35(tPMenuItemLeftRightSliderIndexed *self) { self->~tPMenuItemLeftRightSliderIndexed(); }
void (tPMenuItemLeftRightSliderIndexed::*p875_common2_member_pausemenu_36)(tInputKeyType &,tPMenuCommand &) = (void (tPMenuItemLeftRightSliderIndexed::*)(tInputKeyType &,tPMenuCommand &))&tPMenuItemLeftRightSliderIndexed::ProcessInput;
void (tPMenuItemLeftRightSliderIndexed::*p875_common2_member_pausemenu_37)(bool) = (void (tPMenuItemLeftRightSliderIndexed::*)(bool))&tPMenuItemLeftRightSliderIndexed::Draw;
tPMenuItemGoToMenuButton *p875_common2_member_pausemenu_38(u_int textDescription,tPMenu *newMenu, void (*OnButtonPress)(tPMenuCommand&)) { return new tPMenuItemGoToMenuButton(textDescription,newMenu,OnButtonPress); }
void p875_common2_member_pausemenu_39(tPMenuItemGoToMenuButton *self) { self->~tPMenuItemGoToMenuButton(); }
tPMenu * (tPMenuItemGoToMenuButton::*p875_common2_member_pausemenu_40)(void) = (tPMenu * (tPMenuItemGoToMenuButton::*)(void))&tPMenuItemGoToMenuButton::NextMenu;
void (tPMenuItemGoToMenuButton::*p875_common2_member_pausemenu_41)(tInputKeyType &,tPMenuCommand &) = (void (tPMenuItemGoToMenuButton::*)(tInputKeyType &,tPMenuCommand &))&tPMenuItemGoToMenuButton::ProcessInput;
tPMenuItemCommandButton *p875_common2_member_pausemenu_42(u_int textDescription,tPMenuCommandType command) { return new tPMenuItemCommandButton(textDescription,command); }
void p875_common2_member_pausemenu_43(tPMenuItemCommandButton *self) { self->~tPMenuItemCommandButton(); }
void (tPMenuItemCommandButton::*p875_common2_member_pausemenu_44)(tInputKeyType &,tPMenuCommand &) = (void (tPMenuItemCommandButton::*)(tInputKeyType &,tPMenuCommand &))&tPMenuItemCommandButton::ProcessInput;
void (tPMenu::*p875_common2_member_pausemenu_45)(tPMenuItem *,void *) = (void (tPMenu::*)(tPMenuItem *,void *))&tPMenu::tPMenuConstructor;
tPMenu *p875_common2_member_pausemenu_46(tPMenuItem *firstItem, ...) { return new tPMenu(firstItem); }
void p875_common2_member_pausemenu_47(tPMenu *self) { self->~tPMenu(); }
void (tPMenu::*p875_common2_member_pausemenu_48)(void) = (void (tPMenu::*)(void))&tPMenu::Initialize;
bool (tPMenu::*p875_common2_member_pausemenu_49)(void) = (bool (tPMenu::*)(void))&tPMenu::Debounce;
void (tPMenu::*p875_common2_member_pausemenu_50)(void) = (void (tPMenu::*)(void))&tPMenu::CheckForDisabled;
void (tPMenu::*p875_common2_member_pausemenu_51)(tInputKeyType &,tPMenuCommand &) = (void (tPMenu::*)(tInputKeyType &,tPMenuCommand &))&tPMenu::ProcessInput;
void (tPMenu::*p875_common2_member_pausemenu_52)(void) = (void (tPMenu::*)(void))&tPMenu::Draw;
int (tPMenu::*p875_common2_member_pausemenu_53)(void) = (int (tPMenu::*)(void))&tPMenu::NumEnabledItems;
int (tPMenu::*p875_common2_member_pausemenu_54)(int) = (int (tPMenu::*)(int))&tPMenu::ItemEnabledNum;
