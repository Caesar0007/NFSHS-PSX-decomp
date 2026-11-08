/* tTournamentManager_inl.h -- in-class inline members of tTournamentManager, included INSIDE each struct copy.
 * Evidence (retail SYM, every frontend object): the class is recorded `TM TM [field types]` (C-style typedef form)
 * followed by 14 inline-body re-emissions: TM, TM+tTourneyInfo, TM+tTourneyInfo, TM+tTierInfo, TM, TM, TM,
 * TM+tCarLineup, TM+tCompetitor, TM x5.  Only bodies the reconstruction already has (from retail inlined code) are
 * listed here: the two tTourneyInfo accessors and five builtin-field accessors.  A member is skipped where the
 * struct copy already defines or declares it.  Gap vs retail: the tTierInfo, tCarLineup and tCompetitor bodies and
 * four more builtin-only bodies (no source evidence for their names or bodies). */
#if !defined(NFS4_FRONTEND_COMMON_FETOURN_TYPES_H) && !defined(NFS4_FRONTEND_COMMON_SCREENTROPHYINFO_TYPES_H) && !defined(NFS4_SCREENMEMCARD_TROPHYROOM_SURFACE)   /* measured: bodies over-emit field types here (FETourn: tCompetitor; trophy*: their non-retail Definition() + field block = tTournamentDefinition x2; Front: its own code already records the extra tTourneyInfo) */
#ifndef NFS4_TSCREENCONGRATS_OWNER   /* retail order: a builtin-only body first (it emits the field block on its own), then the tTourneyInfo bodies */
    int NumRacers() { return fNumRacers; }
    int PreviousPlacement() { return (signed char)fPrevBestPlacement; }
#endif
#if !defined(NFS4_TSCREENCONGRATS_OWNER) && !defined(NFS4_FRONTEND_COMMON_SCREENTRACKINFO_TYPES_H) && !defined(NFS4_FRONTEND_COMMON_FETOURN_TYPES_H)
    tTourneyInfo *CurrentTourney() {
        return &fDefinition->fTournaments[fDefinition->fTiers[fTier].fTournOffset + fTournament];
    }
#endif
#ifndef NFS4_FEMENUDEFS_SURFACE
#ifndef NFS4_SCREENTOURNSELECT_OWNER_KEYS   /* ScreenTournSelect: its own TourneyInTier(tier, tournament) inline already records this tTourneyInfo */
    tTourneyInfo *CurrentTourney(unsigned char tier, unsigned char tournament) {
        return &fDefinition->fTournaments[fDefinition->fTiers[tier].fTournOffset + tournament];
    }
#endif
    long GetMoney() { return fMoney; }
#if !defined(NFS4_FRONTEND_COMMON_SCREENTRACKINFO_TYPES_H)
    void SubtractMoney(long amount) { (u_long &)fMoney -= (u_long)amount; }
#endif
#endif
#if !defined(NFS4_FRONTEND_COMMON_SCREENTRACKINFO_TYPES_H)
    int CurrentTrack() { return fCurrentTrack; }
#endif
    /* EVIDENCE: retail Front_InitOpponentCars (FRONT.CPP) records TWO empty inline-call block pairs at relative line 89
       (right after UpdateCarLineup()); the reconstruction had only NumRacers().  The second is this accessor behind
       front.cpp's `carLineup = ...` read; retail records one TM+tCarLineup body in every frontend object.
       Inlined everywhere (no VA, no Ghidra function): descriptive name. */
    tCarLineup *GetCarLineup() { return fCarLineup; }
#endif
