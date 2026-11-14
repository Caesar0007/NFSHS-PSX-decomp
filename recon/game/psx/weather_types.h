#ifndef NFS4_GAME_PSX_WEATHER_TYPES_H
#define NFS4_GAME_PSX_WEATHER_TYPES_H   /* Weather.obj's exact source-visible type surface reconstructed from SYM. */
#define NFS4_PRIM_POLY_F4   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_POLY_FT4   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_LINE_G2   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail place (after COORD16, before the pads) */
#define NFS4_CORE_KERNEL_PADS_FIRST   /* retail: kernel/pad types ahead of the core (nfs4_types.h) */
#include "../common/draw_leaf_types.h"
#include "../common/gamesetup_leaf_types.h"
/* Canonical GameSetup_gData aggregate used by this translation unit. */
/* GameSetup_tData: not in retail weather.obj (GameSetup_gData is read through its word view) */













#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"







#include "shared/CCOORD16.h"

#include "shared/DRender_tView.h"












#include "shared/Group.h"   /* one Group definition (header-truth 4n) */




#include "shared/Trk_Quad.h"
#include "shared/Trk_NewStrip.h"
#include "shared/Trk_NewSimQuad.h"
#include "shared/Trk_NewSimSlice.h"
#include "shared/RelCoord16.h"
#include "shared/tSaveSurface.h"
#include "shared/BWorldSm_Pos.h"










struct BO_tNewtonObj;
#include "shared/BO_tNewtonCollisionInfo.h"









#include "shared/BO_tNewtonObj.h"
#include "shared/forceFocus_t.h"




typedef void (*Sched_tFunctionPt)(void *);
#include "shared/Sched_tFunctionSchedule.h"
#include "shared/Sched_tSchedule.h"




















#include "shared/CHorizonSpec.h"




#include "shared/CSkySpec.h"












#include "shared/CNightSpec.h"
#include "shared/CWeatherSpec.h"
#include "shared/CFogSpec.h"
#include "shared/CDepthCueSpec.h"
#include "shared/CWorldColor.h"
#include "shared/kernpair.h"
enum Weather_tState {
    Weather_kSnow = 0,
    Weather_kRain = 1
};
typedef struct Weather_tSys {
    int num[2];
    SVECTOR velocity;
    long hdist;
    short znear, zfar, length, bottom, top, height, width;
} Weather_tSys;
struct Weather_tSplatInfo { DVECTOR pos; int startTick; };
#include "shared/CTrackSpec.h"















#include "shared/Sim_tSimGlobalVar.h"




#include "shared/POLY_F4.h"




#include "shared/POLY_FT4.h"















#include "shared/LINE_G2.h"
























#include "shared/camera_info.h"


































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
