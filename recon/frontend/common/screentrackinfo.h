/* frontend/common/screentrackinfo.h -- retail SCREENTRACKINFO.H: the one definition of tScreenTrackInfo.  Layout and the defining
 * .CPP are the retail SYM's; the including surface provides tScreen (fescreen.h) and the types
 * the declarations name. */
#ifndef _FE_SCREENS_SCREENTRACKINFO_H_
#define _FE_SCREENS_SCREENTRACKINFO_H_

struct tScreenTrackInfo : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void Initialize();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    tTrackInfo fTrack;
    tTVConfig tvConfigs[10];
    tVideoWall fVideoWall;
    tScreenTrackInfo();
};

/* Member functions are declared on the owner-specific tScreenTrackInfo type. */

#endif
