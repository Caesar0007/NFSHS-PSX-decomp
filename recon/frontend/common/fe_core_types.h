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

























#include "../../link_stripped.h"   /* LINK_STRIPPED for the key-object switches below */
/* Screen classes with an inline member: their key objects (marker defined at the top of the .cpp) strip the copy. */
#ifdef NFS4_KEY_OBJECT_SCREENMEMCARD
#define TSCREENMEMCARD_KEY_STRIP LINK_STRIPPED
#else
#define TSCREENMEMCARD_KEY_STRIP
#endif
#ifdef NFS4_KEY_OBJECT_SCREENPOST
#define TSCREENTOURNSTANDINGS_KEY_STRIP LINK_STRIPPED
#else
#define TSCREENTOURNSTANDINGS_KEY_STRIP
#endif
#ifdef NFS4_KEY_OBJECT_SCREENUSERNAME
#define TSCREENUSERNAME_KEY_STRIP LINK_STRIPPED
#else
#define TSCREENUSERNAME_KEY_STRIP
#endif
#ifdef NFS4_KEY_OBJECT_SCREENCONTROLLER
#define TSCREENCONTROLLERCONFIG_KEY_STRIP LINK_STRIPPED
#else
#define TSCREENCONTROLLERCONFIG_KEY_STRIP
#endif
/* FEMenuOptions is the key object of the derived menu-item classes in femenuoptions.h: same rule. */
#ifdef NFS4_TU_FEMENUOPTIONS
#define FEMENUOPTIONS_KEY_STRIP LINK_STRIPPED
#else
#define FEMENUOPTIONS_KEY_STRIP
#endif
/* tMenuItem's key object (FEMenu) emits a standalone copy of every inline member; SLINK /strip removes them
   (linkers/link_stripped.json). Everywhere else the attribute is empty. */
#ifdef NFS4_TU_FEMENU
#define TMENUITEM_KEY_STRIP LINK_STRIPPED
#else
#define TMENUITEM_KEY_STRIP
#endif
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
    virtual void Draw(bool) = 0;   /* retail slot = __pure_virtual (FEMenu.obj emits this table) */
    virtual void Draw(int, int, bool);
    virtual void Draw(int, int, int, bool);
#line 274 "C:/nfs4/FRONTEND/COMMON/FEMENU.H"
    virtual void TransitionOff() { }
    virtual void TransitionOn() { }
#line 91 "recon/frontend/common/fe_core_types.h"
    virtual bool TransitionIsFinished();
    virtual void UpdateTransition(bool);
    void UpdateSelFade(bool);
    /* Inline members: one set for every includer, defined right after the class. Names other than IsEnabled and
       NewMenu are inferred spellings (retail records the bodies, not their names). */
    inline bool IsEnabled() TMENUITEM_KEY_STRIP;
    inline tMenu *NewMenu() TMENUITEM_KEY_STRIP;
    inline unsigned int GetFlags() TMENUITEM_KEY_STRIP;
    inline void SetFlags(unsigned int flags) TMENUITEM_KEY_STRIP;
    inline void SetTextDescription(unsigned int text) TMENUITEM_KEY_STRIP;
    inline void Disable() TMENUITEM_KEY_STRIP;
    inline void Enable() TMENUITEM_KEY_STRIP;
    inline unsigned int LeftRightFlag() TMENUITEM_KEY_STRIP;
    inline bool IsActive() TMENUITEM_KEY_STRIP;      /* ORIGINAL-NAME-UNRESOLVED: second enabled test, `(fFlags & 1) == 0` */
    inline bool IsDisabled() TMENUITEM_KEY_STRIP;    /* ORIGINAL-NAME-UNRESOLVED */
    inline int ButtonImage() TMENUITEM_KEY_STRIP;
} tMenuItem;
inline bool tMenuItem::IsEnabled() { return ((fFlags ^ 1) & 1) != 0; }
inline tMenu *tMenuItem::NewMenu() { return fNewMenu; }
inline unsigned int tMenuItem::GetFlags() { return fFlags; }
inline void tMenuItem::SetFlags(unsigned int flags) { fFlags = flags; }
inline void tMenuItem::SetTextDescription(unsigned int text) { fTextDescription = text; }
inline void tMenuItem::Disable() { fFlags |= 1; }
inline void tMenuItem::Enable() { fFlags &= ~1; }
inline unsigned int tMenuItem::LeftRightFlag() { return fFlags & 0x400; }
inline bool tMenuItem::IsActive() { return (fFlags & 1) == 0; }
inline bool tMenuItem::IsDisabled() { return (fFlags & 1) != 0; }
inline int tMenuItem::ButtonImage() { return fButtonImage; }
static inline bool tMenuItem_IsDisabled(tMenuItem *item) { return (item->fFlags & 1) != 0; }
typedef tMenuItem *tItemList[16];

struct tMenuItemInteractive : public tMenuItem {
    /* declared for every includer */
    tMenuItemInteractive(unsigned int);
    ~tMenuItemInteractive();

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
