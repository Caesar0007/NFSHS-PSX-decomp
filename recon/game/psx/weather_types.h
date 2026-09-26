/* Weather.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_WEATHER_TYPES_H
#define NFS4_GAME_PSX_WEATHER_TYPES_H

#include "../common/gamesetup_leaf_types.h"
#include "../common/draw_leaf_types.h"

/* Canonical GameSetup_gData aggregate used by this translation unit. */
#include "shared/GameSetup_tData.h"
















#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"







#include "shared/CCOORD16.h"

#include "shared/DRender_tView.h"




#include "shared/Trk_Quad.h"
#include "shared/Trk_NewStrip.h"
#include "shared/Trk_NewSimQuad.h"
#include "shared/Trk_NewSimSlice.h"


#include "shared/RelCoord16.h"

struct Group {
    int m_num_elements;
    inline void *GetData() { return this + 1; }
    inline int GetNumElements() { return m_num_elements; }
};

#include "shared/tSaveSurface.h"

#include "shared/BWorldSm_Pos.h"













struct BO_tNewtonObj;
#include "shared/BO_tNewtonCollisionInfo.h"









#include "shared/BO_tNewtonObj.h"




























#include "shared/CHorizonSpec.h"




#include "shared/CSkySpec.h"












#include "shared/CNightSpec.h"
#include "shared/CWeatherSpec.h"
#include "shared/CFogSpec.h"
#include "shared/CDepthCueSpec.h"
#include "shared/CWorldColor.h"





#include "shared/CTrackSpec.h"











typedef void (*Sched_tFunctionPt)(void *);
#include "shared/Sched_tFunctionSchedule.h"




#include "shared/Sched_tSchedule.h"




#include "shared/Sim_tSimGlobalVar.h"




#include "shared/POLY_F4.h"




#include "shared/POLY_FT4.h"















#include "shared/LINE_G2.h"







struct Weather_tSys {
    int num[2];
    SVECTOR velocity;
    long hdist;
    short znear, zfar, length, bottom, top, height, width;
};
struct Weather_tSplatInfo { DVECTOR pos; int startTick; };
typedef enum Weather_tState {
    Weather_kSnow = 0,
    Weather_kRain = 1
} Weather_tState;
typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

#include "shared/camera_info.h"





























#include "shared/kernpair.h"




typedef kernpair KERN;

typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;
typedef short (*tPA32)[32];
typedef int Input_tDeviceCall();
typedef void (*adjustchar)();
typedef void (*fontblit)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef int (*getcode)();

#endif
