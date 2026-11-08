#ifndef NFS4_GAME_COMMON_AIH_BASICPERP_TYPES_H
#define NFS4_GAME_COMMON_AIH_BASICPERP_TYPES_H   /* aih_basicperp.obj's exact owner delta over the shared AI hierarchy. */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */

/* Retail inlines these members here; other key-function TUs must not emit out-of-line copies merely because they include the shared hierarchy. */
#define NFS4_AISTATE_NONE_KEEP   /* key: keep AIState_None bodies (Car_tObj count) */
#define NFS4_AIH_BASICPERP_INLINE_SCOPE
#define NFS4_AIHIGH_PLAYER_PLAIN   /* aihigh.h: AIHigh_Player stays a plain struct here (retail TPDEF count) */
#define NFS4_AIHIGH_COP_AFTER_BASICCOP   /* aihigh.h: AIHigh_Cop right after AIHigh_BasicCop (retail AIHIGH.H order 414/448/471) */
#include "aih_hierarchy_types.h"
#undef NFS4_AIH_BASICPERP_INLINE_SCOPE

enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
};

#include "shared/BW_tContext.h"






#define NFS4_AIHIGH_TYPE_PART 1
#include "aihigh.h"
#undef NFS4_AIHIGH_TYPE_PART

#include "shared/SPCHNFSType_POSITION.h"
#include "shared/SPCHNFSType_DISTANCE.h"
#include "shared/SPCHNFSType_COLOUR.h"
#include "shared/SPCHNFSType_ACCIDENT.h"
#include "shared/SPCHNFSType_AMBULANCE.h"
#include "shared/SPCHNFSType_PURS_UPDT.h"
#include "shared/SPCHNFSType_ARREST.h"
#include "shared/SPCHNFSType_vs_RDBLK_SSTRP.h"
#include "shared/SPCHNFSType_PERP_NAME.h"
#include "shared/SPCHNFSType_CONFIRM.h"
#include "shared/SPCHNFSType_SPIKE_BELT_SIDE.h"
#include "shared/SPCHNFSType_REVINTRO.h"

#include "shared/CarBank.h"
#include "shared/LocationBank.h"
#include "shared/CallSignBank.h"

/* Speech's nested banks are retained although its outer definition is not. */
struct { CarBank Mobile[9], Dispatch[9]; };
struct { LocationBank Mobile[16], Dispatch[16]; };
struct { CallSignBank Mobile, Dispatch; };

/* Speech, as this surface needs it: the nested polymorphic Speaker and the two static finders */
struct Speech {
    struct Speaker {
        SPCHNFSType_POSITION fPosition;
        SPCHNFSType_DISTANCE fDistance;
        SPCHNFSType_COLOUR fColour;
        SPCHNFSType_ACCIDENT fAccident;
        SPCHNFSType_AMBULANCE fAmbulance;
        SPCHNFSType_vs_RDBLK_SSTRP fBlockade;
        SPCHNFSType_REVINTRO fReverse;
        SPCHNFSType_CONFIRM fConfirm;
        SPCHNFSType_PERP_NAME fPerpName;
        SPCHNFSType_SPIKE_BELT_SIDE fSpikeSide;
        SPCHNFSType_PURS_UPDT fUpdate;
        SPCHNFSType_ARREST fArrest;
        int fCar, fLocation, fFrom, fTo, fWing;
        bool fHavePerp;
        Speaker *fSub;
#include "speech_speaker_virtuals.inc"
    };
    static Speaker *Dispatch();
    static Speaker *Mobile(Car_tObj *carObj);
};

/* Canonical foreign aggregates used by this translation unit. */
/* GameSetup_tData: not in retail aih_basicperp.obj (GameSetup_gData is read through its word view) */















#include "shared/Sim_tSimGlobalVar.h"



#include "shared/Trk_NewSlice.h"







#define RaceType_HotPursuit 1
#define RaceType_Id5 5

typedef int CarLogic_tObservations[1][3];
typedef long (*ReparmFuncPtr)();
typedef long (*SampleRequestFuncPtr)();
typedef long (*TestSentenceRuleFuncPtr)();
typedef long (*TraceFuncPtr)();
typedef char *(*MemAllocFuncPtr)();
typedef void (*MemFreeFuncPtr)();
typedef void (*SetSentenceRuleFuncPtr)();

#endif
