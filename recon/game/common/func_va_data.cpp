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

/* @0x8010DC74  0x6C bytes  bss(zero) — fully loaded at runtime from trafcfg.dat
 * by AIInit_LoadPhysicsConfig (100%); read across the AI physics module. */
AIPhysic_Config_t AIPhysicConfig;

/* @0x8013C5EC  4 bytes  bss(zero) — heap handle, new'd in AI_TrafficStartUp and
 * freed/cleared by AI_TrafficCleanUp (100%). */
AITrigger_TriggerManager *triggerManagerTraffic;
