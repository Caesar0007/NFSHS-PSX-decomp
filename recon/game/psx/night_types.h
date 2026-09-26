/* night.obj's exact source-visible type surface reconstructed from SYM.
 * Its shared game graph is the already-exact color.obj surface; the records
 * below are precisely the named delta retained by the standalone night owner. */
#ifndef NFS4_GAME_PSX_NIGHT_TYPES_H
#define NFS4_GAME_PSX_NIGHT_TYPES_H

#include "../common/color_types.h"

#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

/* Canonical gmesetup.obj aggregate used by this translation unit. */
#include "shared/GameSetup_tData.h"
















#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"



#include "shared/POLY_GT4.h"






#include "shared/DRender_tView.h"
#include "shared/Draw_SubdivStruct.h"
#include "shared/Track_tArtresource.h"



#include "shared/Track_tMaterial.h"
#include "shared/Skidmark_Segment.h"


#include "shared/Skidmark_Chunk.h"

typedef enum forceFocus_t {
    FOCUS_NORMAL = 0, FOCUS_AI = 1, FOCUS_COPANDAI = 2
} forceFocus_t;

#include "shared/CHorizonSpec.h"




#include "shared/CSkySpec.h"






#include "shared/CNightSpec.h"
#include "shared/CWeatherSpec.h"
#include "shared/CFogSpec.h"
#include "shared/CDepthCueSpec.h"
#include "shared/CWorldColor.h"



#include "shared/CTrackSpec.h"











#include "shared/camera_info.h"





























#include "shared/Sched_tSchedule.h"




#include "shared/Sim_tSimGlobalVar.h"




#ifndef NFS4_NIGHT_OMIT_PRIVATE_TYPES
struct tCompRGB { char r, g, b; };
struct tNightInitCache { tCompRGB table[257]; };
#endif

typedef u_char Night_tLightingTable[256][16];
typedef u_char Night_tWeatherLightingTable[256];
typedef u_char Night_tCopLightingTable[256][8];

#endif
