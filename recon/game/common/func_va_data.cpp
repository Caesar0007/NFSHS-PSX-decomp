/* func_va_data.cpp — data materialization pass.
 *
 * Real-byte definitions for the absolute-VA data referenced by aiinit functions
 * that have reached a 100% byte-match. Migrating this data into the project (per
 * the reconstruction methodology: resolve every absolute VA -> real bytes in
 * the tree) makes those functions self-contained rather than depending on
 * external/absolute symbols. Bytes are authoritative per the asm oracle
 * C:\Temp\symdump-disasm\disasm-v4.txt; runtime-loaded configs are bss(zero).
 *
 * Each datum is tagged with its VA, size, and the 100%-matched function(s) that
 * reference it.
 */
#include "../../nfs4_types.h"
#include "aiinit_externs.h"

/* ===== aiperson.obj-owned data (referenced by aiperson fns at 100%) ===== */
/* @0x8010d5cc..0x8010d714  initialized .data — values per the asm oracle. */
int          AIPerson_blockMaxDistance[4]        = { 2293760, 3276800, 5242880, 7864320 };
int          AIPerson_blockMinDistance[4]        = { 2293760, 1310720, 655360, 0 };
int          AIPerson_oncomingLookAhead[4]       = { 5898240, 10485760, 13762560, 16384000 };
int          AIPerson_laneSwerve[4][4]           = { {0,0,0,0}, {-65536,-32768,0,65536}, {-131072,0,65536,131072}, {-196608,-98304,98304,196608} };
int          AIPerson_swerveChangeProb[4]        = { 400, 100, 40, 10 };
int          AIPerson_brakeMultiplier[4]         = { 55705, 65536, 78643, 88473 };
int          AIPerson_attackActivationHits[4]    = { 10000, 15, 40, 40 };
int          AIPerson_attackTimes[4]             = { 0, 96, 320, 1280 };
int          AIPerson_fishtailAngles[4]          = { 35, 40, 45, 50 };
int          AIPerson_gripLossProbPerSecond[4]   = { 32768, 32768, 32768, 0 };
int          AIPerson_gripLossMinFactor[4]       = { 19660, 26214, 32768, 64880 };
int          AIPerson_gripLossRecoveryPerTick[4] = { 71, 61, 40, 65536 };
int          AIPerson_minimumWipeOutTicks[5]     = { 65536, 4096, 2048, 1024, 1024 };
int          AIPerson_randomWipeOutTicks[5]      = { 65535, 8191, 4095, 2047, 2047 };
u_int        AIPerson_rearEndProbMask[4]         = { 65535u, 768u, 1792u, 512u };
u_int        AIPerson_smackProbMask[4]           = { 65535u, 768u, 1792u, 1536u };
int          AIPerson_bestLineAbilities[4]       = { 19660, 32768, 52428, 65536 };
/* bss(zero) — runtime-loaded from .bin files / set by AIPerson_Set*. */
int          AIPerson_glueTable[21];                       /* @0x8010d714 */
AIPerson_t   AIPerson_PersonalityData[9];                  /* @0x8010d768 */
AIScript_tReactionDetails AIPerson_ScriptData[9][7];       /* @0x8010da5c */

/* @0x8010DC74  0x6C bytes  bss(zero) — fully loaded at runtime from trafcfg.dat
 * by AIInit_LoadPhysicsConfig (100%); read across the AI physics module. */
AIPhysic_Config_t AIPhysicConfig;

/* @0x8013C5EC  4 bytes  bss(zero) — heap handle, new'd in AI_TrafficStartUp and
 * freed/cleared by AI_TrafficCleanUp (100%). */
AITrigger_TriggerManager *triggerManagerTraffic;

/* @0x8010CCF0  72 bytes  bss(zero) — AI lane/blocking runtime state; cleared by
 * AIInit_Reset2 (100%), read across the AI module. */
AI_tInfo AI_Info;

/* @0x8010DDA4  16 bytes  bss(zero) — race leaderboard; initialized by AIInit_Reset2
 * (100%) to the lead human/AI racers, maintained by the AISpeeds module. */
AISpeeds_tLeaderBoard leaderBoard;
