/* front_standings_screen.h -- Front.obj tScreenPinkSlipStandings, moved verbatim from front_types.h (retail: right after tScreenTournamentStandings3item). */
#ifndef NFS4_FRONTEND_COMMON_FRONT_STANDINGS_SCREEN_H
#define NFS4_FRONTEND_COMMON_FRONT_STANDINGS_SCREEN_H
struct tScreenPinkSlipStandings : public tScreenTournamentStandings3item {
    /* overrides (retail vtable), declared on every owner surface */
    void DrawBackground();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    /* implicit ctor (retail declares none: no body block in SYM) */
};
#endif
