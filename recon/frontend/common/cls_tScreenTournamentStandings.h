/* frontend/common/cls_tScreenTournamentStandings.h -- class tScreenTournamentStandings, one definition for every includer (header-truth 4v; the owner's text from screentournselect_types.h). */
#ifndef NFS4_FRONTEND_COMMON_CLS_TSCREENTOURNAMENTSTANDINGS_H
#define NFS4_FRONTEND_COMMON_CLS_TSCREENTOURNAMENTSTANDINGS_H
struct tScreenTournamentStandings : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void Initialize();
    void Cleanup();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    long moneyFinal, moneyAwarded, moneyDamage, moneyBonus;
    int starttick;
    bool gotmoney, gotbonus, gotbilled, fDrawMoney;
    bool fCountedDown, fStartCountdownNOW;
    int fCountSpeed;
#ifndef NFS4_KEY_OBJECT_SCREENPOST
    inline void SetDrawMoney() { fDrawMoney = 1; }   /* called from femenudefs.cpp (retail inline pair) */
#endif
    tScreenTournamentStandings();
#line 64 "C:/nfs4/FRONTEND/COMMON/SCREENPOST.H"
};
#line 23 "recon/frontend/common/cls_tScreenTournamentStandings.h"
#endif
