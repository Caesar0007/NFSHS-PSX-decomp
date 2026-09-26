/* AudioTrk private type projection over the shared color graph; original
 * foreign-header visibility is not established by the surviving type stream. */
#ifndef NFS4_GAME_COMMON_AUDIOTRK_TYPES_H
#define NFS4_GAME_COMMON_AUDIOTRK_TYPES_H

#include "color_types.h"

/* Canonical gmesetup.obj aggregate used by this translation unit. */
#include "shared/GameSetup_tData.h"
















#include "shared/POLY_GT4.h"






#include "shared/Draw_SubdivStruct.h"
#include "shared/Track_tArtresource.h"






#include "shared/Track_tMaterial.h"

#include "shared/SNDSYSCAP.h"





#include "shared/SNDSYSSET.h"






#include "shared/SNDSYSVEC.h"
#include "shared/SNDSAMPLEFORMAT.h"

#include "shared/Sched_tSchedule.h"




/* Canonical sim.obj aggregate from the retail SYM type graph. */
#include "shared/Sim_tSimGlobalVar.h"




#include "shared/Trk_AnimateInst.h"





#include "shared/SceneElem.h"






#include "shared/SceneSortedElem.h"

struct AudioElem {
    coorddef cp;
    u_short nextDelay;
    char patchID, fadeIn;
    short range;
    char minDelay, randomDelay, type;
    signed char chan;
    char minRepeat, randomRepeat;
};
#include "shared/CAudioList.h"

#include "shared/FLARE_PIECE_DEF.h"

#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"






#include "shared/Skidmark_Segment.h"





#include "shared/Skidmark_Chunk.h"





struct AudioTrk_tAmbientChannel {
    AudioElem *se;
    int handle, slice;
    short patch, repeat;
};
struct AudioTrk_tGlobals { AudioTrk_tAmbientChannel chan[16]; };

#endif
