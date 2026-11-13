/* Shared frontend/common type surface reconstructed from the exact retail
 * overlap of FEMission.obj, FETracks.obj, and FEInput.obj.  Owner headers add
 * only the records present in their own SYM object graph. */
#ifndef NFS4_FRONTEND_COMMON_FE_CORE_TYPES_H
#define NFS4_FRONTEND_COMMON_FE_CORE_TYPES_H
#include "shared/tpdef_keys.h"   /* typedef-form keys (owner-selected) */
#if !defined(NFS4_FE_CORE_FELINES_LATE) && !defined(NFS4_FE_CORE_FELINES_AT_LEAF)   /* FELINES_LATE: frontend core before the MATRIX core; FELINES_AT_LEAF (owner opt-in, with NFS4_SCREENDISPLAY_FELINES_AFTER_LEAF): felines only at the after-leaf site */
#include "felines_types.h"
#elif defined(NFS4_FE_CORE_AT_LEAF_HDR)   /* FELINES_AT_LEAF owners whose MATRIX core still precedes the frontend core (ScreenController: draw_leaf_types.h) */
#include NFS4_FE_CORE_AT_LEAF_HDR
#endif
#if defined(NFS4_FE_CORE_GS_EARLY) && !defined(NFS4_FE_CORE_FELINES_LATE)   /* retail: GameSetup before tMenuCommandType (feinput femenu fetools ...) */
#include "../../game/common/gamesetup_leaf_types.h"
#endif   /* below: these source spellings are not typedef records in FEMission.obj */
#define byte unsigned char
#define uint unsigned int
struct tMenu;
struct tScreen;

#include "fescreen_virtual_types.h"

#ifndef NFS4_TMENUCOMMANDTYPE_DEFINED
#define NFS4_TMENUCOMMANDTYPE_DEFINED
#include "shared/tMenuCommandType.h"   /* one tMenuCommandType definition (header-truth 8a) */











#endif
#ifdef NFS4_FE_CORE_TMENUCOMMAND_EARLY   /* retail screen objects: tMenuCommand (tMenu* -> SLINK forward copy of tMenu) right after tMenuCommandType */
#include "shared/tMenuCommand.h"
#endif

#include "felist_classes.h"

























typedef struct tMenuItem {
    unsigned int fFlags, fTextDescription;
    short fSelFade;
    int fButtonImage, fNumFrames;
    tMenu *fNewMenu;
    /* real virtuals since 2026-09-19, in retail slot order (vptr after the data members, where `_vf` was) */
    tMenuItem(unsigned int textDescription);
    virtual ~tMenuItem();
    virtual long DebounceKeys();
    virtual void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#ifdef NFS4_FE_CORE_FEMENU_METHODS
    virtual void Draw(bool) = 0;   /* retail slot = __pure_virtual (FEMenu.obj emits this table) */
#else
    virtual void Draw(bool);       /* layout-only on the other owner surfaces, whose derived copies do not all redeclare it */
#endif
    virtual void Draw(int, int, bool);
    virtual void Draw(int, int, int, bool);
#ifdef NFS4_TU_FEMENU   /* FEMenu (tMenuItem key TU): retail in-class virtual bodies at FEMENU.H:274/275, emitted at the TU end (anchor: FESCR2, coordinator-authorized 2026-11-09) */
#line 274 "C:/nfs4/FRONTEND/COMMON/FEMENU.H"
    virtual void TransitionOff() { }
    virtual void TransitionOn() { }
#line 89 "recon/frontend/common/fe_core_types.h"
#else
    virtual void TransitionOff();
    virtual void TransitionOn();
#endif
    virtual bool TransitionIsFinished();
    virtual void UpdateTransition(bool);
#if defined(NFS4_FEMENUDEFS_SURFACE) || defined(NFS4_FE_CORE_TMENU_ALL_INLINES)
    // Inferred getter/setter spellings; no added storage or virtual slots.
    inline unsigned int GetFlags() { return fFlags; }
    inline void SetFlags(unsigned int flags) { fFlags = flags; }
#endif
#if defined(NFS4_FE_CORE_SCREENCARSELECT_METHODS) || defined(NFS4_FE_CORE_TMENU_ALL_INLINES)
    inline void SetTextDescription(unsigned int text) {
        fTextDescription = text;
    }
#endif
#ifdef NFS4_FE_CORE_FEMENU_METHODS
    void UpdateSelFade(bool); NFS4_FE_CORE_FEMENU_METHODS
#endif
#if defined(NFS4_FE_CORE_MENUITEM_SETENABLED) || defined(NFS4_FE_CORE_TMENU_ALL_INLINES)
    inline void Disable() { fFlags |= 1; }
    inline void Enable() { fFlags &= ~1; }
#endif
#if defined(NFS4_FE_CORE_FEDIALOG_ITEM_METHODS) || defined(NFS4_FE_CORE_TMENU_ALL_INLINES)
    /* FEDialog only (tMenuItem's key TU FEMenu never sees these): retail tDialogHelp::CalculateDimensions records
       one receiver-free inline pair at each item flag test (47, 49). IsEnabled = the femenu_externs.h spelling;
       LeftRightFlag is ORIGINAL-NAME-UNRESOLVED. */
#if defined(NFS4_FE_CORE_FEDIALOG_ITEM_METHODS) || !defined(NFS4_FE_CORE_MENUITEM_ISENABLED)   /* TMENU_ALL_INLINES: owner spelling wins */
    inline bool IsEnabled() { return ((fFlags ^ 1) & 1) != 0; }
#endif
    inline unsigned int LeftRightFlag() { return fFlags & 0x400; }
#endif
#ifdef NFS4_FE_CORE_MENUITEM_ISENABLED
    inline bool IsEnabled() { return (fFlags & 1) == 0; }
#ifdef NFS4_FE_CORE_OPTIONS_DRAW_ACCESSORS
    /* ORIGINAL-NAME-UNRESOLVED: inferred bit-test accessor used for the
       retail disabled-item pairs. No storage or virtual slot is added. */
    inline bool IsDisabled() { return (fFlags & 1) != 0; }
#endif
    inline int ButtonImage() { return fButtonImage; }
#endif





NFS4_FEMENU_TMENUITEM_STRIPPED_DECLS } tMenuItem;
NFS4_FEMENU_TMENUITEM_STRIPPED_DEFS /* SOURCE-REVIEW-UNRESOLVED: unused reconstruction helper/type producer; genuine header-interface members avoid the formerly presumed mandatory standalone copy. */
static inline bool tMenuItem_IsDisabled(tMenuItem *item) { return (item->fFlags & 1) != 0; }
typedef tMenuItem *tItemList[16];

struct tMenuItemInteractive : public tMenuItem {
#if defined(NFS4_FE_CORE_FEMENU_METHODS) || defined(NFS4_FE_MENUITEM_INLINES)   /* FESCR: declared virtual dtor keeps derived bodies from re-walking it */
    tMenuItemInteractive(unsigned int);
    ~tMenuItemInteractive();
#endif
};

/* tMenu is defined in fe_core_tmenu.h.  FEMenu's owner surface places it AFTER its three item classes (retail table
 * order); every other surface gets it here. */
#ifndef NFS4_FE_CORE_TMENU_AFTER_ITEMS
#include "fe_core_tmenu.h"
#endif

#ifndef NFS4_FE_CORE_CARS_LATE   /* ScreenDisplay graph: car tail after the screen records */
#include "fe_core_cars.h"
#endif
























































































#if defined(NFS4_FE_CORE_NO_CAR_TYPES) || !defined(NFS4_FE_CORE_CARS_LATE)
#include "../../game/common/gamesetup_leaf_types.h"   /* NFS4_FE_CORE_NO_CAR_TYPES surfaces */
#endif

#endif
