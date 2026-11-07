#ifndef NFS4_FRONTEND_COMMON_SCREENTRACKS_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENTRACKS_TYPES_H   /* Owner-specific type surface for ScreenTracks.obj. */
#define NFS4_SCREENTRACKS_OWNER   /* screentracks.h: this object owns tScreenTrackSelect (inline copies LINK_STRIPPED) */
#define NFS4_CORE_PADS_EARLY   /* retail: controller pads before linedef (nfs4_types.h) */
#define NFS4_SCREENPINKSLIPS_TRACKS_SURFACE
#include "screenpinkslips_types.h"
#undef NFS4_SCREENPINKSLIPS_TRACKS_SURFACE

#define textState_Unselected 0
#define textType_TrackRecords 11

#include "shared/POLY_FT4.h"

typedef enum VIDEOSTATE {
    VIDEOSTATE_IDLE = 0,
    VIDEOSTATE_SPOOLING = 1,
    VIDEOSTATE_READY = 2,
    VIDEOSTATE_PLAYING = 3
} VIDEOSTATE;

struct tVideoWall {
    tTVConfig *fTVs;
    short fFirstTVShape, fNumTVs;
    tTexture_ShapeInfo *fTVShapes;
    short *tvOrder;
    u_long fTVTicks;
    short fTransitionDirection, fFlipAxis, fOffsetX, fOffsetY;
    short fAvailableTextID, fAvailable, fAvailableBright, fValid;
    short fAvailableX, fAvailableY;
    tTexture_ShapeInfo *fIconShapes;
    short fIcon, fIconFrames, fIconX, fIconY;
    bool fUpdated; inline short GetTransitionDirection() { return fTransitionDirection; } void Initialize(tTVConfig *, tTexture_ShapeInfo *, short, short, short *, short); void UpdateImages(); void SetAvailableText(short, short, short); void SetAvailableIcon(short, short, short, short, tTexture_ShapeInfo *); void SetAvailable(short); void UpdateTransition(); void Draw(); void TurnOff(); void TurnOffInstant(); void TurnOn();
};

#include "screentracks.h"

/* tGlobalMenuDefs is recorded only in FEMenuDefs.obj; ScreenTracks reaches its members
   (iteratorTrack @0xc88, itemTraffic @0xf4c, itemLocalSpeech @0xf70) through the
   member types its own object records, so the class stays incomplete here. */
struct tGlobalMenuDefs;




#endif
