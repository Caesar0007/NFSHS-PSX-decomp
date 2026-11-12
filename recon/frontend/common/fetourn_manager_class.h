/* frontend/common/fetourn_manager_class.h -- class tTournamentManager (FETOURN.H), one definition for every includer
 * (header-truth 4l; moved from fetourn_types.h, the owner).  Members are defined in fetourn.cpp. */
#ifndef NFS4_FRONTEND_COMMON_FETOURN_MANAGER_CLASS_H
#define NFS4_FRONTEND_COMMON_FETOURN_MANAGER_CLASS_H
struct tSaveTournament; struct tTrackInfo; struct tCarInfo; struct tAwardInformation;
#include "fetourn_trophysize.h"
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
#endif
