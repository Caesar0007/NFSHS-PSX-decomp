/* front_cs_screens.h -- Front.obj tScreenCarSelectDuel + tScreenPinkSlipsCarSelect, moved verbatim from front_types.h (retail: right after tScreenCarSelectTwoPlayer; front_before_standings.h). */
#ifndef NFS4_FRONTEND_COMMON_FRONT_CS_SCREENS_H
#define NFS4_FRONTEND_COMMON_FRONT_CS_SCREENS_H
#include "front_duel.h"   /* tScreenCarSelectDuel (moved verbatim) */

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
};
#endif
