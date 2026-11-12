/* frontend/common/cls_tScreenBeTheCopCongrats.h -- class tScreenBeTheCopCongrats, one definition for every includer (header-truth 4u; the owner's text from screencongrats_types.h). */
#ifndef NFS4_FRONTEND_COMMON_CLS_TSCREENBETHECOPCONGRATS_H
#define NFS4_FRONTEND_COMMON_CLS_TSCREENBETHECOPCONGRATS_H
struct tScreenBeTheCopCongrats : public tScreenCongrats {
    /* overrides (retail vtable), declared on every owner surface */
    void CalculatePrizes();
    void DrawCongratsMessage();
    bool GetCar(tCarInfo &);
    /* implicit ctor (retail declares none: no body block in SYM) */
#line 151 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.H"
};
#line 13 "recon/frontend/common/cls_tScreenBeTheCopCongrats.h"
#endif
