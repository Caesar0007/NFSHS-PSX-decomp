/* frontend/common/cls_tScreenTournamentTrophy.h -- class tScreenTournamentTrophy, one definition for every includer (header-truth 4u; the owner's text from screencongrats_types.h). */
#ifndef NFS4_FRONTEND_COMMON_CLS_TSCREENTOURNAMENTTROPHY_H
#define NFS4_FRONTEND_COMMON_CLS_TSCREENTOURNAMENTTROPHY_H
struct tScreenTournamentTrophy : public tScreenCongrats {
    /* overrides (retail vtable), declared on every owner surface */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void CalculatePrizes();
    void DrawCongratsMessage();
    bool GetCar(tCarInfo &);
    short fShapeCount;
    char fDoUpdate;

    /* implicit ctor (retail declares none: no body block in SYM) */
#line 126 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.H"
};
#line 17 "recon/frontend/common/cls_tScreenTournamentTrophy.h"
#endif
