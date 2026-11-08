/* Owner-specific type surface for FETourn.obj. */
#ifndef NFS4_FRONTEND_COMMON_FETOURN_TYPES_H
#define NFS4_FRONTEND_COMMON_FETOURN_TYPES_H
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail FETourn: tCarClassType right after tOwnedCarInfo */
#ifndef NFS4_FE_COLOR_LATE   /* The retail owner contains color.obj's complete 71-record graph. */
#include "../../game/common/color_types.h"
#endif
#define NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup right after tPersonalities */
#define NFS4_FE_CORE_CARS_HOOK_MANAGER "fetourn_carmanager.h"   /* FETourn spells its own tCarManager (moved verbatim), at the retail place */
#define NFS4_FE_TRACK_HOOK_AFTER_MANAGER "fetourn_trophysize.h"   /* retail: tTrophySize right after tTrackManager */
#include "fe_core_types.h"
/* FETourn's real tCarManager follows below */

/* FETourn retains tListIteratorIndexed's layout but not the foreign tPlayer
 * enum or its method declarations. */
#define NFS4_FE_TRACK_NO_PLAYER
#include "fe_tournament_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER

/* Source spellings/constants that do not create retail type records. */
#define byte unsigned char
#define uchar unsigned char
#define uint unsigned int
/* (2026-09-19) the `#define tPlayer int` spelling is gone: with real virtuals the overrides below must have the SAME
 * parameter type as tListIterator's virtuals, or they overload instead of overriding (retail's vtable has the overrides). */
#define NULL 0
#define Tourn_StartMoney 20000
#define Tourn_RacersCount 6
#define Tourn_TRN_HeaderSize 0x6
#define Tourn_TRN_EntriesStart 0x7
#define cheat_FinishedTournament 25







#include "shared/tSaveTournament.h"
/* The linked FETourn SYM retains this public array typedef while attributing
 * the already-defined element tag body to its earlier owner. */
#include "shared/tRecordBuffer.h"


typedef tRecordBuffer tSaveRecords[187];





















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

    void Initialize();
    void LoadDescription();
    void ReleaseDescription();
    void UpdateTrackList(short tier, short tournament);
    short *GetTrackList(short tier, short tournament);
    void GetTrackToRace(tTrackInfo &track);
    void StartNewTournament(unsigned char tier, unsigned char tournament);
    short IsTournamentFinished();
    void UpdateTournFinishMoney();
    void UpdateTrackFinishMoney();
    void CalcTrackFinishDamageBill(bool recalculate, long &bill, long &bonus);
    void UpdateTrackFinishPoints();
    short AdvanceToNextTrack();
    short GetLastTrackRaced();
    void SaveTournament(tSaveTournament &save);
    void LoadTournament(tSaveTournament &load);
    short GetNumCompetitors();
    /* (CurrentTourney(): in-class body in shared/tTournamentManager_inl.h, INV-B I6) */
    void UpdateCarLineup();
    long GetTrackFinishPrize(short position);
    long GetTournamentFinishPrize(short position);
    void GetAwardInformation(tAwardInformation &info);
    void UpdateAwardInformation();
    short TournPointTotal(short *points);
    short PlayerRanking(short position);
    void CalcTierFinishPrize();
    void GetTrophyName(tTourneyInfo *tourn, tTrophySize size,
                       char *buffer, int place);
    bool ValidCar(tCarInfo &carInfo);
} tTournamentManager;

struct tListIteratorTournament : public tListIterator {
    tTournamentManager *fTournamentManager;

    tListIteratorTournament(char *valPtr, tTournamentManager *tournManager);
    ~tListIteratorTournament();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
    bool ValidTournament(char tourn);
};

#endif
