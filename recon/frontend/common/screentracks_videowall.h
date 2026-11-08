/* screentracks_videowall.h -- ScreenTracks.obj tVideoWall (moved verbatim from screentracks_types.h); retail: right after
   tTVConfig, before tScreenTrackSelect (screentracks_early.h). */
#ifndef NFS4_FRONTEND_COMMON_SCREENTRACKS_VIDEOWALL_H
#define NFS4_FRONTEND_COMMON_SCREENTRACKS_VIDEOWALL_H
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
#endif
