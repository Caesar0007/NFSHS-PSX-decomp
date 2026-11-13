#if !defined(NFS4_FRONTEND_COMMON_FEDIALOG_TYPES_H) || defined(NFS4_FEDIALOG_IN_FEAPP_HOOK)   /* 2nd entry: the tFEApplication hook pass (fedialog_feapp_hook.h) */
#define NFS4_FRONTEND_COMMON_FEDIALOG_TYPES_H   /* Owner-specific type surface for FEDialog.obj. */
#ifndef NFS4_FEDIALOG_IN_FEAPP_HOOK
#if !defined(NFS4_FEMENUDEFS_SURFACE) && !defined(NFS4_SCREENDISPLAY_DIALOGS_EARLY)   /* FEDialog.obj (first header); not FEMenuDefs.obj (retail: car graph before dialogs there) */
#define NFS4_SCREENDISPLAY_DIALOGS_EARLY   /* retail: dialogs before the car/track graph (screendisplay_types.h) */
#define NFS4_SCREENDISPLAY_DIALOGS_NO_DSE   /* no tDrawShapeExtended in this graph */
#define NFS4_FE_COLOR_LATE   /* retail FEDialog: color.obj graph after the dialogs, before the car graph */
#define NFS4_SCREENDISPLAY_COLOR_BEFORE_CARS   /* color site in screendisplay_types.h */
#define NFS4_SCREENDISPLAY_TRACKS_AFTER_MENUS   /* retail: track/tournament graph after the menu family (screendisplay_carblock.h) */
#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* census: retail records every tMenu/tMenuItem inline member (fe_core_tmenu.h) */
#define NFS4_SCREENDISPLAY_CARBLOCK_NO_ITERS   /* retail: list iterators right after tCarManager / tTrackManager */
#define NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_FE_TRACK_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#include "fedialog_keys.h"   /* core/car keys + the options hook (retail FEDialog order) */
#include "felines_types.h"
#endif


#include "fe_input_enums.h"
#ifndef NFS4_TMENUCOMMANDTYPE_DEFINED
#define NFS4_TMENUCOMMANDTYPE_DEFINED
#include "shared/tMenuCommandType.h"   /* one tMenuCommandType definition (header-truth 8a) */











#endif
struct tMenu;
#ifdef NFS4_FEDIALOG_SCREENCARSELECT_SURFACE
struct tMenuCommand;
#else
#include "shared/tMenuCommand.h"
#endif
#define NFS4_FE_CORE_FEDIALOG_METHODS
#define NFS4_SCREENDISPLAY_FEDIALOG_METHODS
#define NFS4_SCREENMEMCARD_FEDIALOG_SURFACE
#define NFS4_SCREENMEMCARD_FEDIALOG_ORDER   /* retail FEDialog memcard order (screenmemcard_types.h) */
#include "screenmemcard_types.h"
#undef NFS4_SCREENMEMCARD_FEDIALOG_ORDER
#undef NFS4_SCREENMEMCARD_FEDIALOG_SURFACE
#undef NFS4_SCREENDISPLAY_FEDIALOG_METHODS
#undef NFS4_FE_CORE_FEDIALOG_METHODS
#ifndef NFS4_FEDIALOG_SCREENCARSELECT_SURFACE
#include "fedialog.h"
#ifdef NFS4_FEDIALOG_DIRECT
#line 161 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
static inline void _fedialog_dtor_base(tDialogBase *p) { p->~tDialogBase(); }
#line 212 "C:/nfs4/FRONTEND/COMMON/FEDIALOG.H"
static inline void _fedialog_dtor_msg(tDialogMessageString *p) { p->~tDialogMessageString(); }
#line 53 "recon/frontend/common/fedialog_types.h"
#endif
#endif
#endif
#if !defined(NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE) && (defined(NFS4_FEDIALOG_IN_FEAPP_HOOK) || !defined(NFS4_FEDIALOG_FEAPP_DONE))
#include "feapp_class.h"   /* class tFEApplication: no private copy (header-truth 4j) */



























#define NFS4_FEDIALOG_FEAPP_DONE
#endif
#ifndef NFS4_FEDIALOG_IN_FEAPP_HOOK

struct tGlobalMenuDefs;
struct tDrawShapeExtended;
struct charactertbl;

/* FEDialog uses these enum values as literals, but its retail owner emits no
 * completed tMenuTextType/tMenuTextState records. */
#include "shared/tMenuTextType.h"   /* the real enum (was constant macros; header-truth 4-C.2) */
#include "shared/tMenuTextState.h"   /* the real enum (was constant macros; header-truth 4-C.2) */


#endif
#endif
