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
    inline void SetDrawMoney() TSCREENTOURNSTANDINGS_KEY_STRIP;   /* key object: standalone copy goes to .text.strip (fe_core_types.h) */


    tScreenTournamentStandings();
#line 64 "C:/nfs4/FRONTEND/COMMON/SCREENPOST.H"
}; inline void tScreenTournamentStandings::SetDrawMoney() { fDrawMoney = 1; }
#line 23 "recon/frontend/common/cls_tScreenTournamentStandings.h"
#endif
