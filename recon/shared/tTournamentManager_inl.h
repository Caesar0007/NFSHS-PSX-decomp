/* tTournamentManager_inl.h -- in-class inline members of tTournamentManager (included inside the one class definition,
 * frontend/common/fetourn_manager_class.h).  Every body here is called from matched code (retail inline-call pairs);
 * names are descriptive (inlined everywhere, no retail symbol).  Same bodies for every includer (header-truth 4l).
 * Retail records 14 in-class bodies; the ones not listed here are unknown (docs/HEADER_TRUTH_PLAN.md, open mismatches).
 */



    /* EVIDENCE: retail ScreenTrophyInfo/ScreenTrophyRoom (DrawBackground x2, GetShapeInfo, Initialize) record an inline-call block
       pair at every fDefinition read; retail's FIRST tTournamentManager body: its this + tTournamentDefinition* records merge into
       the field block (no separate TM+tTournamentDefinition body record, merge law).  Descriptive name (inlined everywhere). */
    tTournamentDefinition *Definition() { return fDefinition; }

    int NumRacers() { return fNumRacers; }


    tTourneyInfo *CurrentTourney() {
        return &fDefinition->fTournaments[fDefinition->fTiers[fTier].fTournOffset + fTournament];
    }



    tTourneyInfo *CurrentTourney(unsigned char tier, unsigned char tournament) {
        return &fDefinition->fTournaments[fDefinition->fTiers[tier].fTournOffset + tournament];
    }









    long GetMoney() { return fMoney; }

    void SubtractMoney(long amount) { (u_long &)fMoney -= (u_long)amount; }
    /* EVIDENCE: retail Front_Menu (FRONT.CPP 961) records an inline block whose parameter record is `extraMoney` (LONG, $2)
       with one empty inner block. The parameter name is retail's; the member name is descriptive. */
    void AddMoney(long extraMoney) { fMoney += extraMoney; }



    int CurrentTrack() { return fCurrentTrack; }

    /* EVIDENCE: retail Front_InitOpponentCars (FRONT.CPP) records TWO empty inline-call block pairs at relative line 89
       (right after UpdateCarLineup()); the reconstruction had only NumRacers().  The second is this accessor behind
       front.cpp's `carLineup = ...` read; retail records one TM+tCarLineup body in every frontend object.
       Inlined everywhere (no VA, no Ghidra function): descriptive name. */
    tCarLineup *GetCarLineup() { return fCarLineup; }







    int PreviousPlacement() { return (signed char)fPrevBestPlacement; }






