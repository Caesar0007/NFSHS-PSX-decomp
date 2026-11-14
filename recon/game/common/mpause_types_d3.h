/* mpause_types_d3 -- moved verbatim out of mpause_types.h so that header holds only its include list. */
#ifndef NFS4_MPAUSE_TYPES_D3_H
#define NFS4_MPAUSE_TYPES_D3_H
struct tPMenuItemNonInteractiveText : public tPMenuItem {
    tPMenuItemNonInteractiveText(unsigned int);
    ~tPMenuItemNonInteractiveText();
    void Draw(bool);
    bool IsNavigable();
};
struct tPMenuItemInteractive : public tPMenuItem {
    tPMenuItemInteractive(unsigned int);
    ~tPMenuItemInteractive();
    void Draw(bool);
    bool IsNavigable();
};
struct tPMenuItemLeftRightChoice : public tPMenuItemInteractive {
    tPListIterator *fData;
    tPMenuItemLeftRightChoice(unsigned int, tPListIterator *);
    ~tPMenuItemLeftRightChoice();
    void ProcessInput(tInputKeyType &, tPMenuCommand &);
    void Draw(bool);
};
struct tPMenuItemLeftRightSlider : public tPMenuItemInteractive {
    int *fData;
    char fMaxVal;
    tPMenuItemLeftRightSlider(unsigned int, int *, char);
    ~tPMenuItemLeftRightSlider();
    bool Debounce();
    void ProcessInput(tInputKeyType &, tPMenuCommand &);
    void Draw(bool);
};
struct tPMenuItemLeftRightSliderIndexed : public tPMenuItemLeftRightSlider {
    char *fIndex;
    tPMenuItemLeftRightSliderIndexed(unsigned int, int *, char, char *);
    ~tPMenuItemLeftRightSliderIndexed();
    void ProcessInput(tInputKeyType &, tPMenuCommand &);
    void Draw(bool);
};
struct tPMenuItemGoToMenuButton : public tPMenuItemInteractive {
    tPMenu *fNewMenu;
    void (*fOnButtonPress)(tPMenuCommand &);
    tPMenuItemGoToMenuButton(unsigned int, tPMenu *, void (*)(tPMenuCommand &));
    ~tPMenuItemGoToMenuButton();
    tPMenu *NextMenu();
    void ProcessInput(tInputKeyType &, tPMenuCommand &);
};
typedef struct tPMenuItemCommandButton : public tPMenuItemInteractive {
    tPMenuCommandType fCommand;
    void SetCommand(tPMenuCommandType) LINK_STRIPPED; /* inferred setter for the confirmation command */
    void SetConfirmation(bool) LINK_STRIPPED; /* inferred: kMPause_CommandConfirmationFlag controls the confirmation path */
    tPMenuItemCommandButton(unsigned int, tPMenuCommandType);
    ~tPMenuItemCommandButton();
    void ProcessInput(tInputKeyType &, tPMenuCommand &);
} tPMenuItemCommandButton;
typedef tPMenuItem *tPItemList[16];
#endif
