/* front_tournamenttrophy.h -- Front.obj tScreenTournamentTrophy, moved verbatim from front_types.h (owner hook
 * NFS4_SCREENCONGRATS_HOOK_TT: retail right after tScreenCongrats, before tScreenPinkSlipCongrats). */
#ifndef NFS4_FRONTEND_COMMON_FRONT_TOURNAMENTTROPHY_H
#define NFS4_FRONTEND_COMMON_FRONT_TOURNAMENTTROPHY_H
struct tScreenTournamentTrophy : public tScreenCongrats {
    /* overrides (retail vtable), declared on every owner surface */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void CalculatePrizes();
    void DrawCongratsMessage();
    bool GetCar(tCarInfo &);
    short fShapeCount;
    char fDoUpdate;
    /* implicit ctor (retail declares none: no body block in SYM) */
};
#endif
