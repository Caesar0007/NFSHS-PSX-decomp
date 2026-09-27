/* frontend/common/screenmain.h -- retail SCREENMAIN.H: the one definition of tScreenMain.  Layout and the defining
 * .CPP are the retail SYM's; the including surface provides tScreen (fescreen.h) and the types
 * the declarations name. */
#ifndef NFS4_FRONTEND_COMMON_SCREENMAIN_H
#define NFS4_FRONTEND_COMMON_SCREENMAIN_H

struct tScreenMain : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void PreLoad();
    void Initialize();
    void Cleanup();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    int hVideo, fFrame;
    u_long fStartTicks, fAnimTicks;
    short fAnimLocation;
    tScreenMainState fState;
    tTVConfig tvConfigs[16];
    tScreenMainState tvStates[16];
    tVideoTransition tvTransitions[16];
    bool fTVsInitialized;
    char fTransitionDirection;
    bool fAnimationUploaded;
    short fPreviousAnim, fWarningFade, fPreviousMovie, fCurrentMovie;
    bool bVideoAborted;
    u_long fMovieTicks;
    tShapeInformation fVideoShapes[2];
    int fCurrentSlot, fCurrentBG[2], fNumTVsInTransition;
    void SwapBackground(int);
    bool DoneLoadingBackground();
    void SetState(tScreenMainState);
    void InitDynamicImages();
    void DrawDropShadow();
    void DrawVideoLines();
    tScreenMain();
};


#endif
