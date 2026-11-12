/* tTournamentManager_inl.h -- in-class inline members of tTournamentManager, included INSIDE each struct copy.
 * Evidence (retail SYM, every frontend object): the class is recorded `TM TM [field types]` (C-style typedef form)
 * followed by 14 inline-body re-emissions: TM, TM+tTourneyInfo, TM+tTourneyInfo, TM+tTierInfo, TM, TM, TM,
 * TM+tCarLineup, TM+tCompetitor, TM x5.  Only bodies the reconstruction already has (from retail inlined code) are
 * listed here: the two tTourneyInfo accessors and five builtin-field accessors.  A member is skipped where the
 * struct copy already defines or declares it.  Gap vs retail: the tTierInfo, tCarLineup and tCompetitor bodies and
 * four more builtin-only bodies (no source evidence for their names or bodies). */
#if 1   /* every frontend TU incl. FETourn (INV-B I6; retail FETourn.obj opens with the same 16-TPDEF class-body run) */
    /* EVIDENCE: retail ScreenTrophyInfo/ScreenTrophyRoom (DrawBackground x2, GetShapeInfo, Initialize) record an inline-call block
       pair at every fDefinition read; retail's FIRST tTournamentManager body: its this + tTournamentDefinition* records merge into
       the field block (no separate TM+tTournamentDefinition body record, merge law).  Descriptive name (inlined everywhere). */
    tTournamentDefinition *Definition() { return fDefinition; }
#ifndef NFS4_TSCREENCONGRATS_OWNER   /* retail order: a builtin-only body first (it emits the field block on its own), then the tTourneyInfo bodies */
    int NumRacers() { return fNumRacers; }
#endif
#if !defined(NFS4_TSCREENCONGRATS_OWNER) && !defined(NFS4_FRONTEND_COMMON_SCREENTRACKINFO_TYPES_H)
    tTourneyInfo *CurrentTourney() {
        return &fDefinition->fTournaments[fDefinition->fTiers[fTier].fTournOffset + fTournament];
    }
#endif
#ifndef NFS4_FEMENUDEFS_SURFACE
#ifndef NFS4_FRONTEND_COMMON_SCREENTROPHYROOM_TYPES_H   /* ScreenTrophyRoom: its own TourneyInTier/TourneyInTierSelf inlines (screentrophyroom.cpp) already record this tTourneyInfo */
    tTourneyInfo *CurrentTourney(unsigned char tier, unsigned char tournament) {
        return &fDefinition->fTournaments[fDefinition->fTiers[tier].fTournOffset + tournament];
    }
#endif
#endif






#ifndef NFS4_FEMENUDEFS_SURFACE
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






#ifndef NFS4_TSCREENCONGRATS_OWNER
    int PreviousPlacement() { return (signed char)fPrevBestPlacement; }
#endif




#endif
