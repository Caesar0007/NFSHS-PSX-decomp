/* trigger_t -- the one definition of this type, shared by 6 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TRIGGER_T_H
#define NFS4_SHARED_TRIGGER_T_H

typedef union trigger_t {
    trigger_anyTrigger_t any;
    trigger_simple_t simple;
    trigger_roadblock_t roadblock;
    trigger_offroad_t offroad;
    trigger_trafficAccident_t trafficAccident;
    trigger_trafficPath_t trafficPath;
} trigger_t;
#if !defined(NFS4_GAME_COMMON_AITRIGER_TYPES_H) && !defined(NFS4_GAME_COMMON_AIH_PLAY_TYPES_H)   /* aitriger/aih_play: their AITrigger_TriggerManager member bodies give this run */
/* INFERRED bodies: retail aicop, aidebug, aih_*, aihigh, aiinit, aistate, object, sim .obj TPDEF run right after the trigger_t
   definition = trigger_t + field walk (anyTrigger simple roadblock offroad coorddef matrixtdef trafficAccident trafficPath
   pathPosition) then trigger_t trigger_t, with no AITrigger_TriggerManager record (the aitriger.obj run without the
   manager receiver).  Never called. */
#ifndef NFS4_GAME_COMMON_AIH_TRAF_TYPES_H
inline trigger_t *AITrigger_NoTrigger() { return (trigger_t *)0; }
#else
/* aih_traf: the run's first body is the type-5 dispatch helper that HighExecute__14AIHigh_Traffic inlines (retail
   aih_traf.obj run `t + walk t t`; the symtree records its formal `trigger` as PTR UNION trigger_t there). */
static inline int TriggerType(trigger_t *trigger) { return trigger->any.type; }
#endif
inline void AITrigger_SwapTriggerPair(trigger_t *a, trigger_t *b) { }
#endif
#endif
