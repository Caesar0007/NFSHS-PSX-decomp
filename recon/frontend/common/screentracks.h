/* frontend/common/screentracks.h -- retail SCREENTRACKS.H: the one definition of tScreenTrackSelect.  Layout and the defining
 * .CPP are the retail SYM's; the including surface provides tScreen (fescreen.h) and the types
 * the declarations name. */
#ifndef _FE_SCREENS_SCREENTRACKS_H_
#define _FE_SCREENS_SCREENTRACKS_H_

struct tScreenTrackSelect : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void Initialize();
    void Cleanup();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    int hVideo, fFrame;
    short fPreviousTrack, fMovieTrack, fBrightness;
    short fDestBrightness, fStartBrightness;
    u_long fStartTicks;
    bool fTicksSet;
    tTVConfig tvConfigs[10];
    tVideoWall fVideoWall;
    bool fTVsInitialized;
    u_long fVideoTicks;
    tScreenTrackSelect();
    void SetBrightness(short);
    inline void SetBrightnessTransition(short bright, short current,
                                        u_long start) {
        fDestBrightness = bright;
        fStartBrightness = current;
        fStartTicks = start;
    }
    void UpdateBrightness(tTrackInformation &);
    void UpdateVideoWall(tTrackInformation &);
    void DrawVideoWall();
};


#endif
