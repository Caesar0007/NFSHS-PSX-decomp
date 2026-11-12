/* frontend/common/cls_tScreenPinkSlipsCarSelect.h -- class tScreenPinkSlipsCarSelect, one definition for every includer (header-truth 4u; the owner's text from screencarselect_types.h). */
#ifndef NFS4_FRONTEND_COMMON_CLS_TSCREENPINKSLIPSCARSELECT_H
#define NFS4_FRONTEND_COMMON_CLS_TSCREENPINKSLIPSCARSELECT_H
struct tScreenPinkSlipsCarSelect : public tScreenCarSelectTwoPlayer {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void DrawForeground();
    void Initialize();
    void Cleanup();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    bool GetCar(tCarInfo &);
    void SetDialog();
    int waitfordialog;
    CARDINFO_def *pCI;
    int fStartCheckTick;
    bool fCardFailed, fExitingScreen;

    /* implicit ctor (retail declares none: no body block in SYM) */
    void DoMemCardStuff();
#line 348 "C:/nfs4/FRONTEND/COMMON/SCREENCARSELECT.H"
};
#line 24 "recon/frontend/common/cls_tScreenPinkSlipsCarSelect.h"
#endif
