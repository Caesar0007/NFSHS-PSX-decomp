/* game/common/aiperson_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + aiperson.cpp defs + the asm oracle. */
#ifndef _GAME_COMMON_AIPERSON_EXTERNS_H_
#define _GAME_COMMON_AIPERSON_EXTERNS_H_
extern "C" int fixedmult(int a, int b);
extern "C" int sprintf(char *buffer, const char *format, ...);
extern "C" char *strcpy(char *destination, const char *source);

/* arrays (technique #1: indexed globals so gcc computes a separate base reg) */
extern Car_tObj         *Cars_gList[];
extern Car_tObj         *Cars_gHumanRaceCarList[];
extern GameSetup_tData GameSetup_gData; /* SYM 2874b5: STRUCT, 2600 bytes */
extern char              GameSetup_gPersonalityNames[15][8]; /* SYM 2874e4: 120 bytes */

extern int               Cars_gNumCars;
extern int               Cars_gNumCopCars;
extern int               Cars_gNumHumanRaceCars;
extern int               Cars_gNumAIRaceCars;

extern Udff_tInfo *Udff_Opena(char *name, char *mem, int abortFlag);
extern void        Udff_Close(Udff_tInfo *handle);
extern int         Udff_GetInt(Udff_tInfo *handle);
extern void        Udff_GetBuffer(Udff_tInfo *handle, char *mem, int size);

extern void AIScript_Assign(AIScript_t *aiscriptt, AIScript_tReactionDetails (*arg2)[7]);

/* Native path table; the Startup format strings are ordinary retail literals. */
extern char *Paths_Paths[];  /* @0x80116468; [2] = path prefix at +8 */

/* ---- aiperson.obj-owned globals (defined in aiperson.cpp, per SYM) ---- */
extern int          AIPerson_blockMaxDistance[4];        /* @0x8010d5cc */
extern int          AIPerson_blockMinDistance[4];        /* @0x8010d5dc */
extern int          AIPerson_oncomingLookAhead[4];       /* @0x8010d5ec */
extern int          AIPerson_laneSwerve[4][4];           /* @0x8010d5fc */
extern int          AIPerson_swerveChangeProb[4];        /* @0x8010d63c */
extern int          AIPerson_brakeMultiplier[4];         /* @0x8010d64c */
extern int          AIPerson_attackActivationHits[4];    /* @0x8010d65c */
extern int          AIPerson_attackTimes[4];             /* @0x8010d66c */
extern int          AIPerson_fishtailAngles[4];          /* @0x8010d67c */
extern int          AIPerson_gripLossProbPerSecond[4];   /* @0x8010d68c */
extern int          AIPerson_gripLossMinFactor[4];       /* @0x8010d69c */
extern int          AIPerson_gripLossRecoveryPerTick[4]; /* @0x8010d6ac */
extern int          AIPerson_minimumWipeOutTicks[5];     /* @0x8010d6bc */
extern int          AIPerson_randomWipeOutTicks[5];      /* @0x8010d6d0 */
extern u_int        AIPerson_rearEndProbMask[4];         /* @0x8010d6e4 */
extern u_int        AIPerson_smackProbMask[4];           /* @0x8010d6f4 */
extern int          AIPerson_bestLineAbilities[4];       /* @0x8010d704 */
extern int          AIPerson_glueTable[21];              /* @0x8010d714 (bss) */
extern AIPerson_t   AIPerson_PersonalityData[9];         /* @0x8010d768 (bss) */
extern AIScript_tReactionDetails AIPerson_ScriptData[9][7]; /* @0x8010da5c (bss) */

#endif /* _GAME_COMMON_AIPERSON_EXTERNS_H_ */
