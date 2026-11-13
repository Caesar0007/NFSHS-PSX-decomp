#if !defined(_FE_SCREENS_SCREENCONTROLLER_H_) || defined(NFS4_SCREENDISPLAY_IN_HOOK_AFTER_COLOR)
#ifndef NFS4_SCREENDISPLAY_IN_HOOK_AFTER_COLOR   /* else: the screendisplay_types.h after-color hook pass (Force_tGlobal + tScreenControllerConfig only) */
#define _FE_SCREENS_SCREENCONTROLLER_H_   /* Canonical SCREENCONTROLLER.H type surface recovered from retail SYM. Actual definitions live here; foreign codegen views below remain unsealed. No compiler source-location directives or new declarations are introduced. */
#ifndef _FE_SCREENS_FEMENUOPTIONS_H_   /* ScreenController.obj only (FeMenuOptions reuses this graph) */
#include "screencontroller_keys.h"








#endif
#include "fe_player_types.h"   /* ScreenController retains tInputKeyType but not the foreign tPlayer enum. FeMenuOptions reuses this graph and retains both input enums. (2026-09-20) real tPlayer enum: overrides of the root virtuals need the root's parameter types */
#define uchar unsigned char
struct tMenuCommand;
#define NFS4_FE_INPUT_NO_PLAYER
#include "fe_input_enums.h"
#undef NFS4_FE_INPUT_NO_PLAYER
#define NFS4_SCREENMEMCARD_FEAPP_SURFACE   /* ScreenMemcard supplies the exact shared frontend graph.  Exclude its memory-card, saved-game, and song records while retaining FE3d. */
#define NFS4_SCREENMEMCARD_CONTROLLER_SURFACE
#define NFS4_SCREENDISPLAY_FEDIALOG_METHODS
#include "screenmemcard_types.h"
#undef NFS4_SCREENDISPLAY_FEDIALOG_METHODS
#undef NFS4_SCREENMEMCARD_CONTROLLER_SURFACE
#undef NFS4_SCREENMEMCARD_FEAPP_SURFACE
typedef short tArrowLocation[6];
typedef short tTextLocation[5];
#endif
#ifndef NFS4_SCREENCONTROLLER_CONFIG_DONE
#include "shared/Force_tGlobal.h"
#include "cls_tScreenControllerConfig.h"   /* class tScreenControllerConfig (one definition) */














































#define NFS4_SCREENCONTROLLER_CONFIG_DONE
#endif
#ifndef NFS4_SCREENDISPLAY_IN_HOOK_AFTER_COLOR
#include "shared/FLARE_PIECE_DEF.h"   /* retail: FLARE_PIECE_DEF after tScreenControllerConfig */
/* Remaining foreign singleton views need owning-SYM source restoration. */
#include "feapp_class.h"   /* the real tFEApplication (no codegen view; header-truth 4-B.3) */





#include "femenudefs_globalmenudefs.h"   /* the real tGlobalMenuDefs (no codegen view; header-truth 4-B.2) */























#endif
#endif
