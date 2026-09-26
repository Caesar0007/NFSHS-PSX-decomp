/* hud.obj's exact source-visible type surface reconstructed from SYM.
 * psxcontroller.obj is an exact 86-record subset; the records below are
 * precisely the 17-name delta retained by the standalone HUD owner. */
#ifndef NFS4_GAME_PSX_HUD_TYPES_H
#define NFS4_GAME_PSX_HUD_TYPES_H

#include "psxcontroller_types.h"

#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

typedef int CarLogic_tObservations[1][3];

#include "shared/Sched_tSchedule.h"




#include "shared/Sim_tSimGlobalVar.h"




#include "shared/Sim_tSimSystemVar.h"




#include "shared/tReplayInterface.h"




#include "shared/DRender_tView.h"




typedef enum AIDataRecord_RecordMethod_t {
    NORMAL_M = 0, RECORD_M = 1, TEST_M = 2
} AIDataRecord_RecordMethod_t;

struct AIDataRecord_t {
    int numElements_, bSize_;
    char name_[64];
    char *dataBuffer_, *preAllocatedBuffer_;
    AIDataRecord_RecordMethod_t recordMethod_;
    virtual ~AIDataRecord_t();   /* aidatarecord.cpp owns the family; slots: dtor, Setup */
    virtual void Setup();
};
struct AIDataRecord_AccTable_t : public AIDataRecord_t { int scale_; };
struct AIDataRecord_CurveSpeedTable_t : public AIDataRecord_t {};

#include "shared/AudioMus_tSongEntry.h"




#include "shared/AudioMus_tCurrentSong.h"




/* Canonical dashHUD.obj aggregate retained by the retail SYM. */
#include "shared/dashhud_info.h"









/* Canonical overlays.obj BTC record retained by the retail SYM. */
#include "shared/tBTCPerpInfo.h"





typedef enum forceFocus_t {
    FOCUS_NORMAL = 0, FOCUS_AI = 1, FOCUS_COPANDAI = 2
} forceFocus_t;

#include "shared/camera_info.h"





























#include "shared/FLARE_PIECE_DEF.h"

struct POLY_F3 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0,x1,y1,x2,y2;
};
#include "shared/POLY_F4.h"


#include "shared/POLY_FT4.h"




#include "shared/POLY_G4.h"




#include "shared/POLY_GT4.h"





#include "shared/SPRT.h"




#include "shared/HudPmx_tShape.h"
struct tSmallCoordXY { short x, y; };

#endif
