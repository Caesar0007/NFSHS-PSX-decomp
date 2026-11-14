/* PauseMenu.obj's exact source-visible type surface reconstructed from SYM. */
#if !defined(NFS4_GAME_COMMON_PAUSEMENU_TYPES_H)
#define NFS4_GAME_COMMON_PAUSEMENU_TYPES_H
#define NFS4_MPAUSE_PAUSEMENU_ORDER   /* retail pausemenu.obj: kernpair tTexture frontend after tInputKeyType (mpause_types.h second pass) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_MPAUSE_OMIT_PAUSEMENU_FOREIGN_TYPES
#define NFS4_MPAUSE_OMIT_INPUT_DEVICE_CALL
#include "mpause_types.h"
#undef NFS4_MPAUSE_OMIT_INPUT_DEVICE_CALL
#undef NFS4_MPAUSE_OMIT_PAUSEMENU_FOREIGN_TYPES

#define Render_gPacketPtr (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

#include "shared/POLY_GT4.h"





















































/* Canonical hudpmx.obj aggregate used by this translation unit. */
#include "shared/HudPmx_tShape.h"




#elif defined(NFS4_MPAUSE_IN_PAUSEMENU) && !defined(NFS4_PAUSEMENU_FE_DONE)
#define NFS4_PAUSEMENU_FE_DONE
#include "shared/kernpair.h"
#include "shared/tTexture_ShapeInfo.h"










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
#endif
