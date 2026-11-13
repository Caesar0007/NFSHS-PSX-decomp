/* shared/fe_menu_game_surface.h -- the frontend menu roots as the GAME objects see them (audiocmn, gmesetup,
 * pausemenu and their includers).  Retail records these classes in every game object with the full vtables
 * (tListIterator 6 slots, tMenuItem 11, tMenu 11), but none of those objects defines tPlayer, tInputKeyType,
 * tScreen or tMenuCommand.  The virtual lists therefore spell the two enums `int` here (the idiom of
 * frontend/common/felist_classes.h); the SYM records only the slot counts.  Nothing here is dispatched from game code. */
#ifndef NFS4_SHARED_FE_MENU_GAME_SURFACE_H
#define NFS4_SHARED_FE_MENU_GAME_SURFACE_H
#ifndef NFS4_FE_SURFACE_NO_TMENU_INLINES   /* every includer (game owners + MMEffect since FESCR2): the tMenu/tMenuItem inline set of FRONTORD set 23 (retail TPDEF tMenu/tMenuItem 16) */
#define NFS4_FE_SURFACE_TMENU_INLINES
#endif
#include "shared/fe_menu_game_tmenucommand.h"   /* retail: tMenuCommand (tMenu forward copy) before tListIterator; opt-out NFS4_FE_SURFACE_NO_TMENUCOMMAND */
#include "frontend/common/fe_player_types.h"
#include "frontend/common/fe_input_enums.h"   /* the real tPlayer / tInputKeyType enums (were `#define ... int`; header-truth 4-C.3) */

#include "frontend/common/felist_classes.h"   /* the one tListIterator family (header-truth 8a); no game-side copies */














#ifdef NFS4_FE_SURFACE_HOOK   /* an owner's own type right after tListIterator (nfs3.obj: tListIteratorIndexed) */
#include NFS4_FE_SURFACE_HOOK
#endif

#ifndef NFS4_FE_CORE_TMENU_ALL_INLINES
#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* the one tMenu / tMenuItem inline-member set */
#endif
#define NFS4_FE_CORE_CARS_LATE      /* game objects carry the car types at their own place */
#define NFS4_FE_CORE_FELINES_LATE   /* likewise the MATRIX core */
#include "frontend/common/fe_core_types.h"   /* the one tMenuItem / tMenuItemInteractive / tMenu (header-truth 8a); no game-side copies */
#undef NFS4_FE_CORE_CARS_LATE
#undef NFS4_FE_CORE_FELINES_LATE




























































#ifdef NFS4_FE_SURFACE_HOOK   /* an owner's own types right after tMenuItemInteractive (nfs3.obj: tScreen) */
#include NFS4_FE_SURFACE_HOOK
#endif


#endif
