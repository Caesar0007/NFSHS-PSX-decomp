/* gmesetup.obj source-visible types; full supplied type-copy/order audit remains open. */
#if !defined(NFS4_GAME_COMMON_GMESETUP_TYPES_H) && !defined(NFS4_PADS_IN_HOOK)
#define NFS4_GAME_COMMON_GMESETUP_TYPES_H
#ifndef NFS4_GMESETUP_OMIT_OWNER_RECORDS   /* retail gmesetup.obj: GameSetup records, FEI_tList, Transformer_* right after PAD_COMMON */
#define NFS4_PADS_HOOK_AFTER "gmesetup_types.h"
#endif

#include "color_types.h"

#ifndef NFS4_GMESETUP_OMIT_OWNER_RECORDS
#include "shared/FEI_tList.h"

#include "shared/Input_tDeviceList.h"





#include "shared/GameSetup_tData.h"















#endif

#ifdef NFS4_GMESETUP_HOOK_BEFORE_FE   /* an includer's own types between Car_tObj and the frontend block (r3dcar.obj) */
#define NFS4_GMESETUP_IN_FE_HOOK
#include NFS4_GMESETUP_HOOK_BEFORE_FE
#undef NFS4_GMESETUP_IN_FE_HOOK
#endif
#include "shared/tTexture_ShapeInfo.h"
#include "shared/kernpair.h"










#include "shared/tMenuCommandType.h"   /* one tMenuCommandType definition (header-truth 8a) */












struct tMenuCommand;
struct tMenu;
struct tScreen;

#include "shared/fe_menu_game_surface.h"
































#include "shared/tCarModels.h"























#include "shared/tCarInfo.h"




















#include "shared/tOwnedCarInfo.h"
#include "shared/tCarNameLength.h"




#include "../../frontend/common/fecars_manager.h"   /* class tCarManager: no private copy (header-truth 4k) */













#include "shared/tPersonalities.h"







#include "shared/tfrontEnd.h"















































typedef kernpair KERN;

/* Some object owners retain the shared GameSetup graph but not this callback
 * typedef.  Narrow owner headers may suppress only this row while keeping the
 * remaining canonical surface unchanged. */
#ifndef NFS4_GMESETUP_OMIT_INPUT_DEVICE_CALL
typedef int Input_tDeviceCall();
#endif
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#elif defined(NFS4_PADS_IN_HOOK) && !defined(NFS4_GMESETUP_PADS_DONE)
#define NFS4_GMESETUP_PADS_DONE
#include "gamesetup_leaf_types.h"
#include "shared/GameSetup_tData.h"
#include "shared/FEI_tList.h"
#include "shared/Transformer_z.h"
#endif
