/* sim.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_COMMON_SIM_TYPES_H
#define NFS4_GAME_COMMON_SIM_TYPES_H

#define NFS4_AIH_HIERARCHY_OMIT_SIM_FOREIGN_TYPES
#include "aih_hierarchy_types.h"
#undef NFS4_AIH_HIERARCHY_OMIT_SIM_FOREIGN_TYPES

#define gScratchLastWord (*(int *)0x1F8003FC)

#ifndef NFS4_SIM_OMIT_OBJECT_FOREIGN_TYPES
typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

#include "shared/AudioMus_tSongEntry.h"




#endif

#include "shared/BW_tContext.h"






#include "shared/DIRENTRY.h"







#include "shared/Draw_SubdivStruct.h"

#include "shared/EXEC.h"




#include "shared/POLY_GT4.h"







#ifndef NFS4_SIM_OMIT_OBJECT_FOREIGN_TYPES
#include "shared/Sim_tSimGlobalVar.h"




#include "shared/Sim_tSimSystemVar.h"



#endif

#include "shared/Skidmark_Segment.h"





#include "shared/Skidmark_Chunk.h"





#include "shared/TCB.h"

#include "shared/Track_tArtresource.h"






#include "shared/Track_tMaterial.h"

#ifndef NFS4_SIM_OMIT_OBJECT_FOREIGN_TYPES
#include "shared/GameSetup_tData.h"















#include "shared/tReplayInterface.h"



#include "shared/Clock_tGameClock.h"
#endif

typedef int CarLogic_tObservations[1][3];
#ifndef NFS4_SIM_OMIT_OBJECT_FOREIGN_TYPES
typedef int Input_tDeviceCall();
#endif

#define RaceType_HotPursuit 1
#define RaceType_Id5 5

#endif
