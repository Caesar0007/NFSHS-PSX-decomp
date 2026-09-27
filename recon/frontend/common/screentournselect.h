/* frontend/common/screentournselect.h -- retail SCREENTOURNSELECT.H: the one definition of tScreenTournSelect.  Layout and the defining
 * .CPP are the retail SYM's; the including surface provides tScreen (fescreen.h) and the types
 * the declarations name. */
#ifndef _FE_SCREENS_SCREENTOURNSELECT_H_
#define _FE_SCREENS_SCREENTOURNSELECT_H_

struct tScreenTournSelect : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void DrawForeground();
    void Initialize();
    void Cleanup();
    int hVideo, fFrame;
    tTVConfig tvConfigs[8];
    tTVConfig trophyTV[4];
    short fPreviousMovie, fCurrentMovie;
    u_long fStartTicks, fTVTicks;
    short fTransitionDirection;
    char fPreviousTrophy;
    bool fTVsInitialized;
    int PreCalculatedTournamentY, fPrevi;
    tScreenTournSelect();
    ~tScreenTournSelect();
    void UpdateVideoWall(tTourneyInfo *);
    void DrawVideoWall();
};


#endif
