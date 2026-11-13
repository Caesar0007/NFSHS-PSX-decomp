/* frontend/common/cls_tScreenControllerConfig.h -- class tScreenControllerConfig, one definition for every includer (header-truth 4u; the owner's text from screencontroller.h). */
#ifndef NFS4_FRONTEND_COMMON_CLS_TSCREENCONTROLLERCONFIG_H
#define NFS4_FRONTEND_COMMON_CLS_TSCREENCONTROLLERCONFIG_H
struct tScreenControllerConfig : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void DrawForeground();
    void Initialize();
    void Cleanup();
    Force_tGlobal fShaker;
    char fPrevConfig, fTextConfig, fTextController, fPrevController;
    short fFade[2], fFadeController[2];
    int fStartTick;
    short fGotTick, fAnim, fAnimFrame, fAnimStart, fAnimStop, fAnimStep;
    short fAnimController, fSwap, fAnimFade, fAnimFadeStart, fAnimFadeStop;
    short fAnimFadeFrame, fAnimFadeController, CurrentlyLoadedArt, negconChoice;
    bool fTransitionedIn, fTransitioningIn, fTransitioningOut;
    short fArrowFade, fArrowFadeDir, fTextTypeOn;
    bool fFadeTextOut;
    short mult;
    tDialogYesNo negconPopUp;
    int fTimeOutStartTick;
    bool SuperFastFadeOut, fPlayedInSound;
    short fShakingItem;
    bool fResetShakeTimeOut;
    char fCurrentController;
    int player;


    inline void ResetShakeTimeOut() TSCREENCONTROLLERCONFIG_KEY_STRIP;   /* key object: standalone copy goes to .text.strip (fe_core_types.h) */

    void ClearActuators();
    void SetActuators(int);
    void TurnOffShakers();
    void ShakeIt();
    short AnimKeyPoints(bool, bool);
    void CheckConfigs();
    void SwapInController();
    void SetCurrentController(bool);
    int CalcAnimFrame(int);
    void ActualDrawController(int, int, int, int, int);
    void DrawController();
    void HorzVertLine(short *, bool);
    void DrawArrow(short *);
    int GetHelpText();
    tScreenControllerConfig();
#line 177 "C:/nfs4/FRONTEND/COMMON/SCREENCONTROLLER.H"
}; inline void tScreenControllerConfig::ResetShakeTimeOut() { fResetShakeTimeOut = 1; }
#line 51 "recon/frontend/common/cls_tScreenControllerConfig.h"
#endif
