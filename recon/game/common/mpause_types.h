/* mpause.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_MPAUSE_TYPES_H
#define NFS4_GAME_COMMON_MPAUSE_TYPES_H

#include "color_types.h"

#include "shared/SndBnk_t.h"

#define RaceType_Tournament 2
#define RaceType_PinkSlips 6

typedef enum tPMenuCommandType {
    kMPause_NoEvent = 0,
    kMPause_Continue = 1,
    kMPause_Restart = 2,
    kMPause_QuitToGameSetup = 3,
    kMPause_QuitToRaceSummary = 4,
    kMPause_ForfeitToRaceSummary = 5,
    kMPause_GoToMenu = 6,
    kMPause_BackupMenu = 7,
    kMPause_CommandConfirmationFlag = 256
} tPMenuCommandType;

typedef enum tInputKeyType {
    kInput_KeyType_NoKey = 0,
    kInput_KeyType_AlreadyProcessed = 1,
    kInput_KeyType_Cross = 2,
    kInput_KeyType_Circle = 4,
    kInput_KeyType_Square = 8,
    kInput_KeyType_Triangle = 16,
    kInput_KeyType_L1 = 32,
    kInput_KeyType_L2 = 64,
    kInput_KeyType_R1 = 128,
    kInput_KeyType_R2 = 256,
    kInput_KeyType_Up = 512,
    kInput_KeyType_Down = 1024,
    kInput_KeyType_Left = 2048,
    kInput_KeyType_Right = 4096,
    kInput_KeyType_Start = 8192,
    kInput_KeyType_Select = 16384
} tInputKeyType;

/* Canonical gmesetup.obj aggregate used by the pause-menu source. */
#include "shared/GameSetup_tData.h"
















/* unconditional since 2026-09-19: the iterator VIRTUALS take a tPlayer, so every TU that sees the classes needs it */
typedef enum tPlayer {
    kPlayerBoth = -1,
    kPlayerOne = 0,
    kPlayerTwo = 1
} tPlayer;

#ifndef NFS4_MPAUSE_OMIT_PAUSEMENU_FOREIGN_TYPES
#include "shared/SNDSYSCAP.h"





#include "shared/SNDSYSSET.h"






#include "shared/SNDSYSVEC.h"
#include "shared/SNDSAMPLEFORMAT.h"
#endif
#include "shared/AudioMus_tSongEntry.h"





struct tPMenu;
struct tPMenuCommand { tPMenuCommandType type; tPMenu *nextMenu; };

struct tPListIterator {
    short *fSelectionList;
    int *fValue;
    /* real virtuals since 2026-09-19 (vptr after the data members, where `_vf` was) */
    tPListIterator(short *, int *);
    virtual ~tPListIterator();
    virtual char Value(tPlayer);
    virtual short TextValue(tPlayer);
    virtual void Increment(tPlayer);
    virtual void Decrement(tPlayer);
};
struct tPListIteratorIndexed : public tPListIterator {
    char *fIndex;
    tPListIteratorIndexed(short *, int *, char *);
    ~tPListIteratorIndexed();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
};

struct tPMenuItem {
    unsigned int fFlags, fTextDescription;
    tPMenuItem(unsigned int);
    virtual ~tPMenuItem();
    virtual tPMenu *NextMenu();
    virtual bool Debounce();
    virtual void ProcessInput(tInputKeyType &, tPMenuCommand &);
    virtual bool IsNavigable() = 0;
    virtual void Draw(bool) = 0;
    bool IsEnabled();
    bool IsDisabled();
    void Enable(); /* inferred member spelling, also used by sibling tMenuItem */
    void Disable(); /* inferred member spelling, also used by sibling tMenuItem */
    unsigned int TextDescription(); /* inferred getter: retail nests this item receiver in the menu getter */
    void SetTextDescription(unsigned int); /* sibling tMenuItem uses this setter spelling */
};
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
struct tPMenuItemCommandButton : public tPMenuItemInteractive {
    tPMenuCommandType fCommand;
    void SetCommand(tPMenuCommandType); /* inferred setter for the confirmation command */
    void SetConfirmation(bool); /* inferred: kMPause_CommandConfirmationFlag controls the confirmation path */
    tPMenuItemCommandButton(unsigned int, tPMenuCommandType);
    ~tPMenuItemCommandButton();
    void ProcessInput(tInputKeyType &, tPMenuCommand &);
};

typedef tPMenuItem *tPItemList[16];
#ifndef NFS4_MPAUSE_OMIT_INPUT_DEVICE_CALL
typedef int Input_tDeviceCall();
#endif

struct tPMenu {
    int fCurrentItem;
    bool fHighlight;
    tPMenuItem *fItemList[16];
    tPMenu *fNextMenu;
    int fNumItems;
    tPMenu(tPMenuItem *, ...);
    virtual ~tPMenu();
    void tPMenuConstructor(tPMenuItem *, void *);
    virtual void Initialize();
    bool Debounce();
    void CheckForDisabled();
    virtual void ProcessInput(tInputKeyType &, tPMenuCommand &);
    virtual void Draw();
    int CurrentItem(); /* inferred accessor: retail records this at the current-item reads */
    unsigned int CurrentItemText(); /* inferred getter for the selected item's description */
    void SetCurrentItem(int); /* inferred setter: retail records the confirmation-menu receiver */
    void SetHighlight(bool); /* inferred setter: retail records this in both highlight arms */
    int NumItems(); /* inferred inline count getter: retail records this at both count reads */
    int NumEnabledItems();
    int ItemEnabledNum(int);
};

#ifndef NFS4_MPAUSE_OMIT_PAUSEMENU_FOREIGN_TYPES
struct tPauseMenuDefs {
    tPauseMenuDefs();
    ~tPauseMenuDefs();
    tPMenuItemNonInteractiveText itemGamePaused;
    tPMenuItemCommandButton itemContinue, itemRestart;
    tPMenuItemGoToMenuButton itemOptions;
    tPMenuItemCommandButton itemQuitRace, itemForfeitRace;
    tPMenu menuPause;
    tPMenuItemNonInteractiveText itemOptionsTitle;
    tPMenuItemGoToMenuButton itemAudioSettings, itemControllerSettings;
    tPMenu menuOptions;
    tPMenuItemNonInteractiveText itemAudioSettingsTitle;
    tPListIterator iteratorAudioMode;
    tPMenuItemLeftRightChoice itemAudioSettingsAudioMode;
    tPMenuItemLeftRightSlider itemAudioSettingsMusicVolume, itemAudioSettingsFXVolume;
    tPMenuItemLeftRightSlider itemAudioSettingsSpeechVolume, itemAudioSettingsEngineVolume;
    tPMenuItemLeftRightSlider itemAudioSettingsAmbientVolume;
    tPMenu menuAudioSettings;
    tPListIteratorIndexed iteratorConfig;
    tPMenuItemNonInteractiveText itemControllerSettingsTitle;
    tPMenuItemLeftRightChoice itemControllerConfig;
    tPMenuItemLeftRightSliderIndexed itemControllerShockMode, itemControllerShockImpact;
    tPMenu menuControllerConfig;
    tPMenuItemNonInteractiveText itemConfirmTitle, itemConfirmAreYouSure;
    tPMenuItemCommandButton itemConfirmNo, itemConfirmYes;
    tPMenu menuConfirmYesNo;
};
#endif

#include "shared/kernpair.h"
typedef kernpair KERN;
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

/* The inline receiver pairs at NumEnabledItems' two count reads establish
   a getter on tPMenu. Its spelling is inferred; the interface definition
   retains the debug scopes without an extra standalone body. */
#pragma interface
inline int tPMenu::NumItems() { return fNumItems; }
inline int tPMenu::CurrentItem() { return fCurrentItem; }
inline void tPMenu::SetHighlight(bool highlight) { fHighlight = highlight; }
inline unsigned int tPMenuItem::TextDescription() { return fTextDescription; }
inline void tPMenuItem::SetTextDescription(unsigned int text) { fTextDescription = text; }
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
