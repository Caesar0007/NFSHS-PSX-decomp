/* frontend/common/cls_tScreenTournamentCongrats.h -- class tScreenTournamentCongrats, one definition for every includer (header-truth 4u; the owner's text from screencongrats_types.h). */
#ifndef NFS4_FRONTEND_COMMON_CLS_TSCREENTOURNAMENTCONGRATS_H
#define NFS4_FRONTEND_COMMON_CLS_TSCREENTOURNAMENTCONGRATS_H
struct tScreenTournamentCongrats : public tScreenCongrats {
    /* overrides (retail vtable), declared on every owner surface */
    void CalculatePrizes();
    void DrawCongratsMessage();
    bool GetCar(tCarInfo &);
    /* implicit ctor (retail declares none: no body block in SYM) */
#line 161 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.H"
};
#line 13 "recon/frontend/common/cls_tScreenTournamentCongrats.h"
#endif
