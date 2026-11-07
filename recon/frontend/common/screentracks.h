/* frontend/common/screentracks.h -- retail SCREENTRACKS.H: the one definition of tScreenTrackSelect.  Layout and the defining
 * .CPP are the retail SYM's; the including surface provides tScreen (fescreen.h) and the types the declarations name. */
#ifndef _FE_SCREENS_SCREENTRACKS_H_
#define _FE_SCREENS_SCREENTRACKS_H_
#ifdef NFS4_SCREENTRACKS_OWNER   /* ScreenTracks.obj emits standalone copies of these inline members; SLINK /strip removed them (P6 Route C 2026-11-07) */
#include "../../link_stripped.h"
#define NFS4_SCREENTRACKS_STRIP LINK_STRIPPED
#else
#define NFS4_SCREENTRACKS_STRIP
#endif
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
    /* implicit ctor (retail declares none: no body block in SYM) */
    void SetBrightness(short);
    inline void SetBrightnessTransition(short bright, short current,
                                        u_long start) NFS4_SCREENTRACKS_STRIP;
    void UpdateBrightness(tTrackInformation &);
    void UpdateVideoWall(tTrackInformation &);
    void DrawVideoWall();
#line 89 "C:/nfs4/FRONTEND/COMMON/SCREENTRACKS.H"
};
#line 35 "recon/frontend/common/screentracks.h"
inline void tScreenTrackSelect::SetBrightnessTransition(short bright, short current, u_long start) {
    fDestBrightness = bright; fStartBrightness = current; fStartTicks = start; }
#endif
