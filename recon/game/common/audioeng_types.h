/* audioeng.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_AUDIOENG_TYPES_H
#define NFS4_GAME_COMMON_AUDIOENG_TYPES_H

#include "color_types.h"

#include "shared/SndBnk_t.h"

/* Canonical gmesetup.obj aggregate used by this translation unit. */
#include "shared/GameSetup_tData.h"
















#include "shared/POLY_GT4.h"






#include "shared/Draw_SubdivStruct.h"
#include "shared/Track_tArtresource.h"






#include "shared/Track_tMaterial.h"

#include "shared/Sched_tSchedule.h"




#include "shared/SNDSYSCAP.h"





#include "shared/SNDSYSSET.h"






#include "shared/SNDSYSVEC.h"
#include "shared/SNDSAMPLEFORMAT.h"
#include "shared/SNDPLAYOPTS.h"






#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"







#include "shared/Skidmark_Segment.h"





#include "shared/Skidmark_Chunk.h"





struct AudioEng_tEvent {
    char use, patnum, pad1, pad2;
    short delta, max;
    int attackdelta, decaydelta;
};
struct AudioEng_tTable { char xlate[512]; };
struct AudioEng_tDef {
    int id;
    char ver, resolved, startevent, controllerpercent;
    short lowrandomtargetlevel, lowrandomtargetrange;
    int lowrandomattacktime, lowrandomattackrange;
    short highrandomtargetlevel, highrandomtargetrange;
    int highrandomattacktime, highrandomattackrange;
    char patchnum[8];
    AudioEng_tEvent event[16];
    AudioEng_tTable *pvoltable[8], *pbendtable[8];
};
struct AudioEng_tChanAttr {
    short min, max;
    char *xlate;
    char patchnum;
};
struct AudioEng_tAdjustments {
    u_char inCarBoost, inCarExhaust, outCarExhaust, fwdEngBoost;
    u_char rwdExhBoost, outCarBoost, pitchScale, timbreScale;
};
struct AudioEng_tVoiceAttr {
    char vol;
    u_short pitch, azim;
    int handle;
};
struct AudioEng_tState {
    u_short vol, dop, azi, sep, esp;
    u_char exh, gas;
};
struct AudioEng_t {
    AudioEng_tAdjustments adjust;
    int tick;
    int vol[16];
    int azi, sep, dop;
    char bhandle, pad;
    AudioEng_tState queue[16];
    char setpos, plypos;
    AudioEng_tChanAttr chan[16];
    AudioEng_tVoiceAttr left[16], right[16];
    char delay[16];
    char *tables;
};

#endif
