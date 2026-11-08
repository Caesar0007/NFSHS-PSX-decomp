/* tCarLineup -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TCARLINEUP_H
#define NFS4_SHARED_TCARLINEUP_H

#if 0   /* (was FETourn: typedef pair; FETourn now has the tTournamentManager bodies, INV-B I6) */   /* no tTournamentManager body here: the typedef form supplies the 2nd record */
typedef struct tCarLineup {
#else
struct tCarLineup {   /* retail: plain struct; the 2nd/3rd records come from the field block and tTournamentManager::GetCarLineup() */
#endif
    bool isPlayerCar;
    tPersonalities personality;
    char position;
    tCarModels carModel;
    char carColor, carUpgrades;
#if 0
} tCarLineup;
#else
};
#endif
#endif
