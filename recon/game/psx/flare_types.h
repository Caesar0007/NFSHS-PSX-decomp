/* flare.obj's exact source-visible type surface reconstructed from SYM.
 * Its shared game graph is the already-exact color.obj surface; the records
 * below are precisely the named delta retained by the standalone flare owner. */
#ifndef NFS4_GAME_PSX_FLARE_TYPES_H
#define NFS4_GAME_PSX_FLARE_TYPES_H

#include "../common/color_types.h"

#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

/* Canonical gmesetup.obj aggregate retained by flare.obj. */
#include "shared/GameSetup_tData.h"
















#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"



#include "shared/POLY_F4.h"



#include "shared/POLY_FT4.h"




#include "shared/POLY_G3.h"



#include "shared/POLY_G4.h"




#include "shared/LINE_G2.h"




#include "shared/DRender_tView.h"
#include "shared/Draw_FlareCache.h"
#include "shared/Sched_tSchedule.h"



#include "shared/Sim_tSimGlobalVar.h"




typedef enum forceFocus_t {
    FOCUS_NORMAL = 0, FOCUS_AI = 1, FOCUS_COPANDAI = 2
} forceFocus_t;

#include "shared/FLARE_PIECE_DEF.h"
#include "shared/FLARE_DEF.h"






struct Flare_tInfo { u_long chalo,cbeam; int scale,flags; };

#include "shared/CHorizonSpec.h"




#include "shared/CSkySpec.h"






#include "shared/CNightSpec.h"
#include "shared/CWeatherSpec.h"
#include "shared/CFogSpec.h"
#include "shared/CDepthCueSpec.h"
#include "shared/CWorldColor.h"


#include "shared/CTrackSpec.h"











#endif
