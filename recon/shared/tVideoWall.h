/* tVideoWall -- FEVIDEOWALL.H, one definition for every includer (header-truth 4t). Members are defined in fevideowall.cpp. */
#ifndef NFS4_SHARED_TVIDEOWALL_H
#define NFS4_SHARED_TVIDEOWALL_H
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
    bool fUpdated;

    /* ORIGINAL-NAME-UNRESOLVED: inferred getter spelling for retail's
     * receiver-free inline pair at the transition-direction read. */
    short TransitionDirection() { return fTransitionDirection; }

    void Initialize(tTVConfig *, tTexture_ShapeInfo *, short, short, short *, short);
    void UpdateImages();
    void SetAvailableText(short, short, short);
    void SetAvailableIcon(short, short, short, short, tTexture_ShapeInfo *);
    void SetOffset(short, short);
    void SetAvailable(short);
    void SetValid(short);
    void UpdateTransition();
    void Draw();
    void TurnOff();
    void TurnOffInstant();
    void TurnOn();
};
#endif
