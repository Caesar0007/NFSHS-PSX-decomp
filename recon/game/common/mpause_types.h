#ifndef NFS4_GAME_COMMON_MPAUSE_TYPES_H
#define NFS4_GAME_COMMON_MPAUSE_TYPES_H   /* mpause.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_MPAUSE_OMIT_PAUSEMENU_FOREIGN_TYPES   /* mpause.obj itself, not pausemenu.obj */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_MPAUSE_SND_LATE   /* retail: kernpair, AudioMus, SND* right before tPauseMenuDefs */
#endif
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#include "draw_leaf_core.h"
#if !defined(NFS4_DRAW_LEAF_CORE_ONLY) && !defined(NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H)   /* this object lists the draw leaf itself (retail record order) */
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H
#include "draw_leaf_a_pads.h"
#undef NFS4_CORE_CCOORD16
#include "draw_leaf_b_pixmap.h"
#include "draw_leaf_c_cache.h"
#include "draw_leaf_d_carvertex.h"
#ifndef NFS4_MPAUSE_OMIT_PAUSEMENU_FOREIGN_TYPES   /* mpause.obj itself: tPMenuCommandType right after Draw_CarVertex */
#include "shared/tPMenuCommandType.h"
#endif
#endif
#include "link_stripped.h"   /* SLINK /strip removed the standalone copies of the inlines below (no #pragma) */
#include "color_types.h"
#include "shared/SndBnk_t.h"
#define RaceType_Tournament 2
#define RaceType_PinkSlips 6

#ifndef NFS4_MPAUSE_PAUSEMENU_ORDER   /* pausemenu.obj: after its frontend block (second pass below) */
#include "shared/tPMenuCommandType.h"
#endif









#define NFS4_FE_INPUT_NO_PLAYER
#include "frontend/common/fe_input_enums.h"   /* one tInputKeyType definition (header-truth 4-C.3) */
#undef NFS4_FE_INPUT_NO_PLAYER















#ifdef NFS4_MPAUSE_PAUSEMENU_ORDER   /* pausemenu.obj second pass: kernpair/tTexture/frontend block, then tPMenuCommandType */
#define NFS4_MPAUSE_IN_PAUSEMENU
#include "pausemenu_types.h"
#undef NFS4_MPAUSE_IN_PAUSEMENU
#include "shared/tPMenuCommandType.h"
#endif
/* Canonical gmesetup.obj aggregate used by the pause-menu source. */
/* GameSetup_tData: not in retail mpause/pausemenu.obj (GameSetup_gData is read through word views) */











/* unconditional since 2026-09-19: the iterator VIRTUALS take a tPlayer, so every TU that sees the classes needs it */
#include "frontend/common/fe_player_types.h"   /* one tPlayer definition (header-truth 4-C.3) */





#if !defined(NFS4_MPAUSE_OMIT_PAUSEMENU_FOREIGN_TYPES) && !defined(NFS4_MPAUSE_SND_LATE)   /* mpause.obj: SND* after kernpair/AudioMus (tPauseMenuDefs block) */
#include "shared/SNDSYSCAP.h"





#include "shared/SNDSYSSET.h"






#include "shared/SNDSYSVEC.h"
#include "shared/SNDSAMPLEFORMAT.h"
#endif
#if !defined(NFS4_MPAUSE_PAUSEMENU_ORDER) && !defined(NFS4_MPAUSE_SND_LATE)   /* pausemenu.obj: AudioMus after the pause classes; mpause.obj: before tPauseMenuDefs (below) */
#include "shared/AudioMus_tSongEntry.h"
#endif



struct tPMenu;
struct tPMenuCommand { tPMenuCommandType type; tPMenu *nextMenu; };

typedef struct tPListIterator {
    short *fSelectionList;
    int *fValue;
    /* real virtuals since 2026-09-19 (vptr after the data members, where `_vf` was) */
    tPListIterator(short *, int *);
    virtual ~tPListIterator();
    virtual char Value(tPlayer);
    virtual short TextValue(tPlayer);
    virtual void Increment(tPlayer);
    virtual void Decrement(tPlayer);
} tPListIterator;
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
    void Enable() LINK_STRIPPED; /* inferred member spelling, also used by sibling tMenuItem */
    void Disable() LINK_STRIPPED; /* inferred member spelling, also used by sibling tMenuItem */
    unsigned int TextDescription() LINK_STRIPPED; /* inferred getter: retail nests this item receiver in the menu getter */
    void SetTextDescription(unsigned int) LINK_STRIPPED; /* sibling tMenuItem uses this setter spelling */
};
#if defined(NFS4_TU_MPAUSE)   /* owner object: retail records the C-style `typedef struct tPMenuItem {..} tPMenuItem;` form (TPDEF twice) */
typedef struct tPMenuItem tPMenuItem;
#endif
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
    int CurrentItem() LINK_STRIPPED; /* inferred accessor: retail records this at the current-item reads */
    unsigned int CurrentItemText() LINK_STRIPPED; /* inferred getter for the selected item's description */
    void SetCurrentItem(int) LINK_STRIPPED; /* inferred setter: retail records the confirmation-menu receiver */
    void SetHighlight(bool) LINK_STRIPPED; /* inferred setter: retail records this in both highlight arms */
    int NumItems() LINK_STRIPPED; /* inferred inline count getter: retail records this at both count reads */
    int NumEnabledItems();
    int ItemEnabledNum(int);
};
#if defined(NFS4_TU_PAUSEMENU)   /* owner object: retail records the C-style `typedef struct tPMenu {..} tPMenu;` form (TPDEF twice) */
typedef struct tPMenu tPMenu;
#endif
#ifndef NFS4_MPAUSE_OMIT_PAUSEMENU_FOREIGN_TYPES
#ifdef NFS4_MPAUSE_SND_LATE   /* retail mpause.obj: kernpair, AudioMus, SND* right before tPauseMenuDefs */
#include "shared/kernpair.h"
#include "shared/AudioMus_tSongEntry.h"
#include "shared/SNDSYSCAP.h"
#include "shared/SNDSYSSET.h"
#include "shared/SNDSYSVEC.h"
#include "shared/SNDSAMPLEFORMAT.h"
#endif
struct tPauseMenuDefs {
    tPauseMenuDefs();
    ~tPauseMenuDefs();
    tPMenuItemNonInteractiveText itemGamePaused; tPMenuItemCommandButton itemContinue, itemRestart; tPMenuItemGoToMenuButton itemOptions; tPMenuItemCommandButton itemQuitRace, itemForfeitRace;
    tPMenu menuPause; tPMenuItemNonInteractiveText itemOptionsTitle; tPMenuItemGoToMenuButton itemAudioSettings, itemControllerSettings; tPMenu menuOptions;
    tPMenuItemNonInteractiveText itemAudioSettingsTitle; tPListIterator iteratorAudioMode;
    tPMenuItemLeftRightChoice itemAudioSettingsAudioMode; tPMenuItemLeftRightSlider itemAudioSettingsMusicVolume, itemAudioSettingsFXVolume;
    tPMenuItemLeftRightSlider itemAudioSettingsSpeechVolume, itemAudioSettingsEngineVolume; tPMenuItemLeftRightSlider itemAudioSettingsAmbientVolume;
    tPMenu menuAudioSettings; tPListIteratorIndexed iteratorConfig;
    tPMenuItemNonInteractiveText itemControllerSettingsTitle;
    tPMenuItemLeftRightChoice itemControllerConfig;
    tPMenuItemLeftRightSliderIndexed itemControllerShockMode, itemControllerShockImpact;
    tPMenu menuControllerConfig;
    tPMenuItemNonInteractiveText itemConfirmTitle, itemConfirmAreYouSure;
    tPMenuItemCommandButton itemConfirmNo, itemConfirmYes;
    tPMenu menuConfirmYesNo;
};
#elif defined(NFS4_MPAUSE_PAUSEMENU_ORDER)
#include "shared/AudioMus_tSongEntry.h"
#endif
#include "shared/kernpair.h"
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
