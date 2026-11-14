/* mpause_types_d8 -- moved verbatim out of mpause_types.h so that header holds only its include list. */
#ifndef NFS4_MPAUSE_TYPES_D8_H
#define NFS4_MPAUSE_TYPES_D8_H
typedef kernpair KERN;
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();
/* The inline receiver pairs at NumEnabledItems' two count reads establish a getter on tPMenu. Its spelling is inferred; the interface definition retains the debug scopes without an extra standalone body.  (no #pragma: user ruling 2026-11-07) */
inline int tPMenu::NumItems() { return fNumItems; }
inline int tPMenu::CurrentItem() { return fCurrentItem; }
inline void tPMenu::SetHighlight(bool highlight) { fHighlight = highlight; }
inline unsigned int tPMenuItem::TextDescription() { return fTextDescription; }
inline void tPMenuItem::SetTextDescription(unsigned int text) { fTextDescription = text; }
/* Enable/Disable are header inlines: retail records their scopes at the caller's line in
   MPause_ControllerLogic / MPause_StartPauseMenu (a same-.cpp inline clamps them to line 1). */
extern bool ChangedEnabling;   /* PauseMenu.obj */
inline void tPMenuItem::Enable()
{
  if (this->IsDisabled()) {
    ChangedEnabling = 1;
    this->fFlags &= ~1U;
  }
}
inline void tPMenuItem::Disable()
{
  if (this->IsEnabled()) {
    ChangedEnabling = 1;
    this->fFlags |= 1;
  }
}
inline void tPMenuItemCommandButton::SetCommand(tPMenuCommandType command) { fCommand = command; }
inline void tPMenuItemCommandButton::SetConfirmation(bool confirmation) {
    if (!confirmation) {
        fCommand = (tPMenuCommandType)(fCommand & ~kMPause_CommandConfirmationFlag);
    } else {
        fCommand = (tPMenuCommandType)(fCommand | kMPause_CommandConfirmationFlag);
    }
}
inline unsigned int tPMenu::CurrentItemText() { return fItemList[fCurrentItem]->TextDescription(); }
inline void tPMenu::SetCurrentItem(int item) { fCurrentItem = item; }
#endif
