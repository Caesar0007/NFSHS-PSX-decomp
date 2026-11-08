/* tCarLineup -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TCARLINEUP_H
#define NFS4_SHARED_TCARLINEUP_H

#if defined(NFS4_FRONTEND_COMMON_FETOURN_TYPES_H) || defined(NFS4_FRONTEND_COMMON_SCREENTROPHYINFO_TYPES_H) || defined(NFS4_SCREENMEMCARD_TROPHYROOM_SURFACE)   /* no tTournamentManager body here: the typedef form supplies the 2nd record */
typedef struct tCarLineup {
#else
struct tCarLineup {   /* retail: plain struct; the 2nd/3rd records come from the field block and tTournamentManager::GetCarLineup() */
#endif
    bool isPlayerCar;
    tPersonalities personality;
    char position;
    tCarModels carModel;
    char carColor, carUpgrades;
#if defined(NFS4_FRONTEND_COMMON_FETOURN_TYPES_H) || defined(NFS4_FRONTEND_COMMON_SCREENTROPHYINFO_TYPES_H) || defined(NFS4_SCREENMEMCARD_TROPHYROOM_SURFACE)
} tCarLineup;
#else
};
#endif
#endif
