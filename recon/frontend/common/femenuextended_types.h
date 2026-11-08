/* Owner-specific type surface for FEMenuExtended.obj. */
#ifndef NFS4_FRONTEND_COMMON_FEMENUEXTENDED_TYPES_H
#define NFS4_FRONTEND_COMMON_FEMENUEXTENDED_TYPES_H
#define NFS4_TU_FEMENUEXTENDED   /* owner identity (shared/tpdef_keys.h) */
#define NFS4_FE_CORE_FELINES_LATE   /* retail FEMenuExtended: frontend core before the MATRIX core */
#include "fe_player_types.h"
#include "fe_input_enums.h"
#define NFS4_TMENUCOMMANDTYPE_DEFINED
enum tMenuCommandType {
    kMenu_Command_None = 0,
    kMenu_Command_GoToMenu = 1,
    kMenu_Command_GoToMenuOneWay = 2,
    kMenu_Command_GoToMenuTwoPlayer = 3,
    kMenu_Command_BackupMenu = 4,
    kMenu_Command_StartRace = 5,
    kMenu_Command_Start2PlayerRace = 6,
    kMenu_Command_ReStartRace = 7,
    kMenu_Command_StartReplay = 8,
    kMenu_Command_ClearRecords = 9
};

struct tMenu;
#include "shared/tMenuCommand.h"
#define NFS4_FE_CORE_CARS_LATE   /* retail FEMenuExtended: car tail after the color graph + tMenuNFS4 family */
#define NFS4_FE_CORE_FEMENU_METHODS
#define NFS4_FE_LIST_NO_INDEXED   /* FEMenuExtended.obj: tListIterator + Range only */
#define NFS4_FE_CORE_MENUITEM_ISENABLED   /* tMenuItem::IsEnabled() -- retail's tMenuItem `this` pair in the Draw bodies */
#include "fe_core_types.h"
#undef NFS4_FE_CORE_FEMENU_METHODS
#include "../../link_stripped.h"   /* LINK_STRIPPED ctor copies below (FESCR2).  color_types.h (retail: the complete physics/AI/car graph) is included after the tMenuNFS4 family below. */
#define NFS4_PRIM_DR_AREA   /* retail: DR_AREA right after DR_MODE (nfs4_types.h NFS4_PRIM_*) */
struct tMenuItemLeftRightChoice : public tMenuItemInteractive {
    tListIterator *fData;

    tMenuItemLeftRightChoice(unsigned int, tListIterator *);
    ~tMenuItemLeftRightChoice();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void Draw(bool);
};

struct tMenuItemGoToMenuButton : public tMenuItemInteractive {
    void (*fOnButtonPress)(tMenuCommand &);

    tMenuItemGoToMenuButton(unsigned int, tMenu *,
                            void (*)(tMenuCommand &));
    ~tMenuItemGoToMenuButton();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
};
#include "shared/tActiveLine.h"   /* retail FEMenuExtended: tActiveLine right after the item classes (FRONTORD3) */

#include "felines_types.h"
#include "../../game/psx/psyq_prim_macros.h"
#include "shared/DR_AREA.h"

#include "shared/tDrawShapeExtended.h"

NFS4_TD_tMenuItemGoToMenuNFS4Button struct tMenuItemGoToMenuNFS4Button : public tMenuItemGoToMenuButton {
    int fOrdinalPos;
    short fOffset, fTransitionVal, fTransitionSpeed, fEnabledTransitionVal;

    tMenuItemGoToMenuNFS4Button(unsigned int, tMenu *,
                                void (*)(tMenuCommand &), int, int);
    ~tMenuItemGoToMenuNFS4Button();
    void Draw(int, int, bool);
    void TransitionOn();
    void TransitionOff();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
#line 46 "C:/nfs4/FRONTEND/COMMON/FEMENUEXTENDED.H"
    void Draw(bool) {}   /* in-class inline: see femenuextended.cpp tail */
#line 70 "recon/frontend/common/femenuextended_types.h"
} NFS4_TDN_tMenuItemGoToMenuNFS4Button;

struct tMenuItemNFS4LeftRightChoice : public tMenuItemLeftRightChoice {
    short fOffset, fTransitionVal, fTransitionSpeed, fEnabledTransitionVal;

    tMenuItemNFS4LeftRightChoice(unsigned int, tListIterator *, int, int);
    ~tMenuItemNFS4LeftRightChoice();
    void Draw(int, int, bool);
    void TransitionOn();
    void TransitionOff();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
};

struct tMenuItemOptionsLeftRightChoice : public tMenuItemLeftRightChoice {
    void Draw(int, int, bool);
    tMenuItemOptionsLeftRightChoice(unsigned int t, tListIterator *d) LINK_STRIPPED;   /* retail in-class ctor (screendisplay_types.h); FEMenuExtended = key TU -> standalone copy in .text.strip (FESCR2) */
#line 99 "C:/nfs4/FRONTEND/COMMON/FEMENUEXTENDED.H"
};
inline tMenuItemOptionsLeftRightChoice::tMenuItemOptionsLeftRightChoice(unsigned int t, tListIterator *d) : tMenuItemLeftRightChoice(t, d) {}   /* retail FEMenuExtended.obj: TPDEF x3 at the class (FESCR2) */
#line 87 "recon/frontend/common/femenuextended_types.h"

struct tMenuItemOptionsTwoItemChoice : public tMenuItemLeftRightChoice {
    short fOnOffFade;

    void TransitionOn();
    void Draw(int, int, bool);
    tMenuItemOptionsTwoItemChoice(unsigned int t, tListIterator *d) LINK_STRIPPED;   /* retail in-class ctor (screendisplay_types.h); FEMenuExtended = key TU -> standalone copy in .text.strip (FESCR2) */
#line 110 "C:/nfs4/FRONTEND/COMMON/FEMENUEXTENDED.H"
};
inline tMenuItemOptionsTwoItemChoice::tMenuItemOptionsTwoItemChoice(unsigned int t, tListIterator *d) : tMenuItemLeftRightChoice(t, d) { fOnOffFade = 0x80; }   /* retail FEMenuExtended.obj: TPDEF x3 at the class (FESCR2) */
#line 94 "recon/frontend/common/femenuextended_types.h"

struct tMenuNFS4 : public tMenu {
    bool fInItemTransition, fInMenuTransition;
    short fTransitionVal;
    signed char fTransitionDirection;
    char fLastItem, fNumItems;

    tMenuNFS4(unsigned int, tScreen *, tMenu *, tMenu *,
              void (*)(tMenuCommand &), short, tMenuItem *, ...);
    tMenuNFS4(unsigned int, tScreen *, tMenu *, tMenu *,
              void (*)(tMenuCommand &), short);
    ~tMenuNFS4();
    void Initialize();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition();
    virtual void DrawItem(int);
    void Draw();
};

NFS4_TD_tMenuNFS4TwoPlayer struct tMenuNFS4TwoPlayer : public tMenuNFS4 {
    tMenuNFS4TwoPlayer(unsigned int, tScreen *, tMenu *, tMenu *,
                       void (*)(tMenuCommand &), short, tMenuItem *, ...);
    ~tMenuNFS4TwoPlayer();
    virtual void DrawItem(int);
} NFS4_TDN_tMenuNFS4TwoPlayer;

struct tMenuNFS4Bottom : public tMenuNFS4 {
    tMenuNFS4Bottom(unsigned int, tScreen *, tMenu *, tMenu *,
                    void (*)(tMenuCommand &), short, tMenuItem *, ...);
    ~tMenuNFS4Bottom();
    void Draw();
};

NFS4_TD_tMenuBlank struct tMenuBlank : public tMenuNFS4 {
    tMenuBlank(unsigned int, tScreen *, tMenu *, tMenu *,
               void (*)(tMenuCommand &), short);
    ~tMenuBlank();
    void Draw();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void Initialize();
    long DebounceKeys();
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition();
} NFS4_TDN_tMenuBlank;

struct tMenuOptions : public tMenuNFS4 {
    u_long fMenuEnterTicks;
    short fPlayer;
    tMenuOptions(unsigned int, tScreen *, tMenu *, tMenu *,
                 void (*)(tMenuCommand &), short, short, tMenuItem *, ...);
    ~tMenuOptions();
    void Draw();
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    bool IsSubMenu();
};
#ifndef NFS4_FE_COLOR_LATE   /* retail FEMenuExtended: color.obj graph after tMenuOptions */
#include "../../game/common/color_types.h"
#endif
#include "fe_core_cars.h"
#include "shared/tShapeInformation.h"
#include "fescreen_virtual_types.h"
#include "fescreen.h"
#include "shared/tActiveLine.h"
#include "fedialog.h"
struct tFEApplication {
    unsigned int fCurrentMusic;
    tMenu *fCurrentMenu[2];
    tScreen *fCurrentScreen[2];
    tMenu *fTransitionToMenu[2];
    tScreen *fTransitionToScreen[2];
    tMenu *fParentMenu[2];
    tDialogMessageString messagePopup;
    tMenu *backList[2][16];
    int backDepth[2];
    tInputKeyType fLastKeyPressed[2];
    short fYOffset;
    tDialogHelp helpPopup;
    char fPlayer, fInputPlayer;
    bool waitingForOtherPlayer[2];
    tDialogMessageStringWithTimeout MemCardDialog;
    tDialogNoInputMessage NoInputMemCardDialog;
    bool gotName[2], needName[2];
    int speechToPlay[2];

    tPlayer Player() { return (tPlayer)(unsigned char)fPlayer; } NFS4_FEAPP_INF6
};

/* The linked owner retains this public array typedef while attributing the
 * already-seen element tag body elsewhere. */
#include "shared/tRecordBuffer.h"


typedef tRecordBuffer tSaveRecords[187];

/* These foreign enum tags are not retained by FEMenuExtended.obj.  Exact
 * linkage aliases in the extern header preserve their ABI spellings. */
#define tMenuTextState int
#define tMenuTextType int
#define textState_Unselected 0
#define textState_Selected 1
#define textState_Hilighted 2
#define textType_FlybyHelp 1
#define textType_Options 6
#define textType_PopUpTitle 9

#define MIN(a,b) (((a) > (b)) ? (b) : (a))
#define MAX(a,b) (((a) > (b)) ? (a) : (b))

#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

struct tGlobalMenuDefs;
struct charactertbl;

#endif
