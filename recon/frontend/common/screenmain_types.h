#define NFS4_SCREENDISPLAY_DIALOGS_EARLY   /* retail: dialogs before the car/track graph (screendisplay_types.h) */
#if !defined(NFS4_FRONTEND_COMMON_SCREENMAIN_TYPES_H) || defined(NFS4_SCREENDISPLAY_IN_HOOK_AFTER_COLOR)
#ifndef NFS4_SCREENDISPLAY_IN_HOOK_AFTER_COLOR   /* else: the screendisplay_types.h after-color (= after-dialogs) hook pass (screenmain_early.h, tFEApplication) */
#define NFS4_FRONTEND_COMMON_SCREENMAIN_TYPES_H   /* Owner-specific type surface for ScreenMain.obj. */
#define NFS4_FE_CORE_FELINES_LATE   /* retail ScreenMain: frontend core before the MATRIX core (fe_core_types.h) */
#define NFS4_SCREENDISPLAY_TRACKS_AFTER_MENUS   /* retail: track/tournament graph after the menu family (screendisplay_carblock.h) */
#define NFS4_SCREENDISPLAY_HOOK_AFTER_COLOR "screenmain_types.h"   /* retail ScreenMain: TV .. tScreenMain, tFEApplication right after the dialogs */
#include "screenmain_keys.h"   /* ScreenMain core/screen keys (per-TU unit) */
/* ScreenMain retains tInputKeyType but not the foreign tPlayer tag. */
#define NFS4_FE_INPUT_NO_PLAYER
#include "fe_input_enums.h"
#undef NFS4_FE_INPUT_NO_PLAYER
/* Reuse ScreenDisplay's exact shared frontend graph without its owner class
 * or foreign-global compiler view. */
#define NFS4_SCREENDISPLAY_NO_OWNER_RECORDS
#include "screendisplay_types.h"
#undef NFS4_SCREENDISPLAY_NO_OWNER_RECORDS
/* Source spellings whose tags are not retained by ScreenMain.obj. */
/* (2026-09-20) real tPlayer enum: overrides of the root virtuals need the root's parameter types */
#include "fe_player_types.h"
struct tMenuCommand;
#define uchar unsigned char
#define RaceType_SingleRace 0
#define RaceType_PinkSlips 6
typedef long STREAMHANDLE;
typedef long STREAMREQUESTID;
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)
#include "shared/POLY_G4.h"
#include "shared/tDrawShapeExtended.h"
#include "fedialog.h"
#endif
#ifdef NFS4_SCREENDISPLAY_IN_HOOK_AFTER_COLOR
#include "screenmain_early.h"
#include "feapp_class.h"   /* class tFEApplication: no private copy (header-truth 4j) */






















#else
#include "shared/tCreditManager.h"   /* one tCreditManager definition (header-truth 4t) */








struct tVertex {
    short x, y;
};


#include "screenmain.h"

/* ScreenMain reads three fields from the foreign FEMenuDefs aggregate. */
#include "femenudefs_globalmenudefs.h"   /* the real tGlobalMenuDefs (no codegen view; header-truth 4-B.2) */









#endif
#endif
