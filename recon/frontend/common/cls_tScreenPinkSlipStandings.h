/* frontend/common/cls_tScreenPinkSlipStandings.h -- class tScreenPinkSlipStandings, one definition for every includer (header-truth 4u; the owner's text from screentournselect_types.h). */
#ifndef NFS4_FRONTEND_COMMON_CLS_TSCREENPINKSLIPSTANDINGS_H
#define NFS4_FRONTEND_COMMON_CLS_TSCREENPINKSLIPSTANDINGS_H
struct tScreenPinkSlipStandings : public tScreenTournamentStandings3item {
    /* overrides (retail vtable), declared on every owner surface */
    void DrawBackground();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    /* implicit ctor (retail declares none: no body block in SYM) */
#line 82 "C:/nfs4/FRONTEND/COMMON/SCREENPOST.H"
};
#endif
