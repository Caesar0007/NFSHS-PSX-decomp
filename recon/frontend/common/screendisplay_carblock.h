/* frontend/common/screendisplay_carblock.h -- the car/track/tournament part of screendisplay_types.h (fe_core_cars,
 * fe_tournament_types, the car/track/tournament list iterators, tTournamentManager).  A separate piece only so that
 * NFS4_SCREENDISPLAY_CARS_AFTER_MENUS owners emit it after the tMenuNFS4 / options family (retail type order).
 * Pass logic: the first include emits the car part (and, unless NFS4_SCREENDISPLAY_TRACKS_AFTER_MENUS, the track/
 * tournament part too); with that key the second include (site 2, after the menu family) emits the track part. */
#ifndef NFS4_FRONTEND_COMMON_SCREENDISPLAY_CARBLOCK_H
#define NFS4_FRONTEND_COMMON_SCREENDISPLAY_CARBLOCK_H
#define NFS4_SCREENDISPLAY_CB_CARS 1
#ifdef NFS4_SCREENDISPLAY_TRACKS_AFTER_MENUS
#define NFS4_SCREENDISPLAY_CB_TRACKS 0
#else
#define NFS4_SCREENDISPLAY_CB_TRACKS 1
#endif
#elif defined(NFS4_SCREENDISPLAY_TRACKS_AFTER_MENUS) && !defined(NFS4_FRONTEND_COMMON_SCREENDISPLAY_CARBLOCK_PASS2)
#define NFS4_FRONTEND_COMMON_SCREENDISPLAY_CARBLOCK_PASS2
#undef NFS4_SCREENDISPLAY_CB_CARS
#undef NFS4_SCREENDISPLAY_CB_TRACKS
#define NFS4_SCREENDISPLAY_CB_CARS 0
#define NFS4_SCREENDISPLAY_CB_TRACKS 1
#else
#undef NFS4_SCREENDISPLAY_CB_CARS
#undef NFS4_SCREENDISPLAY_CB_TRACKS
#define NFS4_SCREENDISPLAY_CB_CARS 0
#define NFS4_SCREENDISPLAY_CB_TRACKS 0
#endif
#if NFS4_SCREENDISPLAY_CB_CARS && NFS4_SCREENDISPLAY_CB_TRACKS
#ifdef NFS4_SCREENDISPLAY_TRACKS_BEFORE_CARS   /* sub-key: track/tournament records ahead of the car tail */
#define NFS4_FE_TRACK_NO_PLAYER
#include "fe_tournament_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER
#endif
#endif
#if NFS4_SCREENDISPLAY_CB_CARS
#include "fe_core_cars.h"
#endif
#if NFS4_SCREENDISPLAY_CB_CARS && NFS4_SCREENDISPLAY_CB_TRACKS
#define NFS4_FE_TRACK_NO_PLAYER
#include "fe_tournament_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER
#endif
#if NFS4_SCREENDISPLAY_CB_CARS
struct tCarManager;
#ifndef NFS4_SCREENDISPLAY_CARBLOCK_NO_ITERS   /* else via NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER */
#define NFS4_SCREENDISPLAY_ITERS_CARS
#include "screendisplay_carblock_iters.h"
#undef NFS4_SCREENDISPLAY_ITERS_CARS
#endif
#endif
#if NFS4_SCREENDISPLAY_CB_TRACKS
#if !NFS4_SCREENDISPLAY_CB_CARS
#define NFS4_FE_TRACK_NO_PLAYER
#include "fe_tournament_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER
#endif

typedef struct tTournamentManager {
    char fNumTiers;
    int fTier, fTournament, fCurrentTrack;
    int fNumRacers;
    long fMoney;
    tTournamentDefinition *fDefinition;
    short fTierList[4], fTierFinishPrize[4], fTierFinishPrizeChange[4];
    short fTournamentList[65]; short fTrackList[17];
    char fDirection[16], fMirror[16], fTimeOfDay[16], fWeather[16];
    tCompetitor fCompetitors[6];
    tCarLineup fCarLineup[6];
    signed char fBestPlacement[64];
    char fPrevBestPlacement;
    u_char fFinishPoints[6], fRanking[6];
    tAwardInformation fAwards;
#include "shared/tTournamentManager_inl.h"   /* retail in-class inline bodies (see file) */
#ifdef NFS4_TSCREENCONGRATS_OWNER
    /* Real nonvirtual methods/signatures from the FETourn SYM and owner. */
    short PlayerRanking(short);
    void GetAwardInformation(tAwardInformation &);
    /* ORIGINAL-NAME-UNRESOLVED: same reconstructed CurrentTourney accessor
       used by FETourn; retail's inline pair does not retain its spelling. */
    tTourneyInfo *CurrentTourney() {
        return &fDefinition->fTournaments[fDefinition->fTiers[fTier].fTournOffset + fTournament];
    }
    /* ORIGINAL-NAME-UNRESOLVED: inferred accessor spelling for the racer-count
       field; retail's inline pair does not record the original method name. */
    int NumRacers() { return fNumRacers; }
    /* ORIGINAL-NAME-UNRESOLVED: inferred getter for the previous-placement
       read pairs. Preserve the signed byte value seen in the retail loads. */
    int PreviousPlacement() { return (signed char)fPrevBestPlacement; }
#endif
#ifdef NFS4_SCREENDISPLAY_SCREENCARSELECT_METHODS
    void GetTrackToRace(tTrackInfo &);
#endif
#ifdef NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE
    void CalcTrackFinishDamageBill(bool, long &, long &);
    void GetAwardInformation(tAwardInformation &);
    short TournPointTotal(short *);
    short PlayerRanking(short);
#endif
#ifdef NFS4_FEMENUDEFS_SURFACE
    void StartNewTournament(unsigned char, unsigned char);
    /* Inferred overload/signature/parameter spellings of the known query:
       explicit frontend selection, not the manager's cached selection.
       Retail inline records verify the operation, not its literal name. */
    inline tTourneyInfo *CurrentTourney(unsigned char tier, unsigned char tournament) {
        return &fDefinition->fTournaments[fDefinition->fTiers[tier].fTournOffset + tournament];
    }
    /* Inferred getter spelling; the retail initial money-read inline pair
       retains no method name. No storage or virtual slot is added. */
    inline long GetMoney() { return fMoney; }
    /* Original inline name/signature not uniquely recovered. Mutator spelling
       follows the track-info reconstruction; retail here records LONG amount
       in the parameter scope. No storage or virtual slot is added. */
    inline void SubtractMoney(long amount) {
        (u_long &)fMoney -= (u_long)amount;
    }
    void GetAwardInformation(tAwardInformation &);
    short IsTournamentFinished(); /* retail EXT5c91d6: FCN SHORT */
#endif
#if defined(NFS4_FRONT_SURFACE)
    short AdvanceToNextTrack(); short GetLastTrackRaced();
    void UpdateCarLineup(); void UpdateAwardInformation();
#elif defined(NFS4_SCREENMEMCARD_TROPHYROOM_SURFACE)
    /* (Definition(): now the first body of shared/tTournamentManager_inl.h, INV-B I5b) */
#endif
} tTournamentManager;

#ifndef NFS4_SCREENDISPLAY_CARBLOCK_NO_ITERS   /* else via NFS4_FE_TRACK_HOOK_AFTER_MANAGER */
#define NFS4_SCREENDISPLAY_ITERS_TRACK
#include "screendisplay_carblock_iters.h"
#undef NFS4_SCREENDISPLAY_ITERS_TRACK
#endif

struct tListIteratorTournament : public tListIterator {
    tTournamentManager *fTournamentManager;
#ifdef NFS4_FEMENUDEFS_SURFACE
    tListIteratorTournament(char *, tTournamentManager *);
    ~tListIteratorTournament();
    char Value(tPlayer);
#endif
    short TextValue(tPlayer);
#ifdef NFS4_FEMENUDEFS_SURFACE
    void Increment(tPlayer); void Decrement(tPlayer); bool ValidTournament(char);
#endif
};
#ifdef NFS4_SCREENDISPLAY_SCREEN_AFTER_TOURNAMENT   /* retail FEMenuDefs: tShapeInformation + the tScreen definition right after tListIteratorTournament (earlier: forward copy only) */
#include "shared/tShapeInformation.h"
#include "fescreen.h"
#endif
#endif
