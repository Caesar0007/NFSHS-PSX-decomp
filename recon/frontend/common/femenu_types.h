/* Owner-specific type surface for FEMenu.obj. */
#ifndef NFS4_FRONTEND_COMMON_FEMENU_TYPES_H
#define NFS4_FRONTEND_COMMON_FEMENU_TYPES_H

#include "../../game/common/color_types.h"
#include "fe_input_enums.h"

struct tMenu;

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

#include "shared/tMenuCommand.h"

#define NFS4_FE_CORE_FEMENU_METHODS
#define NFS4_FE_CORE_TMENU_AFTER_ITEMS   /* tMenu comes after the item classes below */
#include "fe_core_types.h"
#undef NFS4_FE_CORE_FEMENU_METHODS

#include "shared/POLY_F4.h"

struct tMenuItemLeftRightChoice : public tMenuItemInteractive {
    tListIterator *fData;
    tMenuItemLeftRightChoice(unsigned int, tListIterator *);
    ~tMenuItemLeftRightChoice();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void Draw(bool);
};

struct tMenuItemLeftRightSlider : public tMenuItemInteractive {
    tListIterator *fData;
    short fX, fY, fWidth, fHeight;
    tMenuItemLeftRightSlider(unsigned int, tListIterator *);
    ~tMenuItemLeftRightSlider();
    long DebounceKeys();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void Draw(bool);
    void SetDimensions(short, short, short, short);
};

struct tMenuItemGoToMenuButton : public tMenuItemInteractive {
    void (*fOnButtonPress)(tMenuCommand &);
    tMenuItemGoToMenuButton(unsigned int, tMenu *,
                            void (*)(tMenuCommand &));
    ~tMenuItemGoToMenuButton();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
};

#define NFS4_FE_CORE_FEMENU_METHODS
#include "fe_core_tmenu.h"   /* retail order: ..., tMenuItemGoToMenuButton, tMenu */
#undef NFS4_FE_CORE_FEMENU_METHODS

/* retail FEMenu.obj order: tMenu, then tScreen and the dialog family (tMenu::fScreen sees tScreen incomplete) */
#include "shared/tShapeInformation.h"

#include "fescreen_virtual_types.h"
#include "fescreen.h"
#include "shared/tActiveLine.h"
#include "fedialog.h"

struct tFEApplication;

/* FEMenu uses these enum values only as cross-TU arguments.  Its linked SYM
 * does not retain either foreign enum tag, so source-spelling macros plus the
 * exact linkage alias in femenu_externs.h preserve the call ABI without
 * inventing local type records. */
#define tMenuTextState int
#define tMenuTextType int
#define textType_Options 6

#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

/* Canonical PsyQ 4.3 LIBGPU primitive tag and macro expansion. */
typedef struct {
    unsigned addr : 24;
    unsigned len : 8;
    u_char r0, g0, b0, code;
} P_TAG;
#define getaddr(p) ((u_long)(((P_TAG *)(p))->addr))
#define setaddr(p, value) (((P_TAG *)(p))->addr = (u_long)(value))
#define addPrim(ot, p) setaddr((p), getaddr(ot)), setaddr((ot), (p))

#endif
