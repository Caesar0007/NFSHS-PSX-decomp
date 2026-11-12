/* frontend/common/felist_tournament_iter.h -- tListIteratorTournament (FETOURN.H), one definition (header-truth 4s). */
#ifndef NFS4_FRONTEND_COMMON_FELIST_TOURNAMENT_ITER_H
#define NFS4_FRONTEND_COMMON_FELIST_TOURNAMENT_ITER_H
struct tListIteratorTournament : public tListIterator {
    tTournamentManager *fTournamentManager;
    tListIteratorTournament(char *, tTournamentManager *);
    ~tListIteratorTournament();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer); void Decrement(tPlayer); bool ValidTournament(char);
};
#endif
