/* DrawC.obj's exact source-visible type surface reconstructed from SYM.
 * psxcontroller.obj is an exact 86-record subset; the records below are
 * precisely the 19-name delta retained by the standalone DrawC owner. */
#ifndef NFS4_GAME_PSX_DRAWC_TYPES_H
#define NFS4_GAME_PSX_DRAWC_TYPES_H

#define NFS4_GMESETUP_OMIT_INPUT_DEVICE_CALL
#include "psxcontroller_types.h"
#undef NFS4_GMESETUP_OMIT_INPUT_DEVICE_CALL

#define Render_gPacketPtr  (*(u_char **)0x1F800004)

typedef int CarLogic_tObservations[1][3];
typedef u_char Night_tLightingTable[256][16];
typedef u_char Night_tWeatherLightingTable[256];
typedef u_char Night_tCopLightingTable[256][8];

#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"



#ifndef NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES
struct POLY_FT3 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char u0,v0; u_short clut;
    short x1,y1; u_char u1,v1; u_short tpage; short x2,y2; u_char u2,v2;
    u_short pad1;
};
#include "shared/POLY_FT4.h"




#include "shared/POLY_G3.h"



#endif
#include "shared/POLY_GT4.h"






#ifndef NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES
#include "shared/BW_tContext.h"




#endif
#include "shared/Draw_SubdivStruct.h"
#include "shared/Track_tArtresource.h"



#include "shared/Track_tMaterial.h"
#include "shared/Skidmark_Segment.h"


#include "shared/Skidmark_Chunk.h"

typedef enum forceFocus_t {
    FOCUS_NORMAL = 0, FOCUS_AI = 1, FOCUS_COPANDAI = 2
} forceFocus_t;

#ifndef NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES
#include "shared/FLARE_PIECE_DEF.h"
#endif
#include "shared/Sched_tSchedule.h"




#include "shared/Draw_tVertex.h"
#include "shared/DRender_tView.h"
#include "shared/Draw_CarCache.h"























#ifndef NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES
#include "shared/DrawC_tEnvMap.h"
#endif

#endif
