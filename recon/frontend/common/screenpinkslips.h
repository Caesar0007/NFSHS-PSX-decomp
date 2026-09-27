/* frontend/common/screenpinkslips.h -- retail SCREENPINKSLIPS.H: the one definition of tScreenPinkSlips.  Layout and the defining
 * .CPP are the retail SYM's; the including surface provides tScreen (fescreen.h) and the types
 * the declarations name. */
#ifndef NFS4_FRONTEND_COMMON_SCREENPINKSLIPS_H
#define NFS4_FRONTEND_COMMON_SCREENPINKSLIPS_H

struct tScreenPinkSlips : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void Initialize();
    void Cleanup();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    tMenu *fMenu;
    int hVideo, fFrame;
    short fPreviousTrack, fBrightness, fDestBrightness, fStartBrightness;
    u_long fStartTicks, fTVTicks;
    char fTransitionDirection;
    tTVConfig fTrackTVs[8];
    tTVConfig fImageTVs[4];
    bool fTVsInitialized;
    tScreenPinkSlips();
    void UpdateVideoWall(tTrackInformation &);
    void DrawVideoWall();
};


#endif
