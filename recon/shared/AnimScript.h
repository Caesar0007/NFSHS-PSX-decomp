/* AnimScript -- bworld.obj's copy, moved verbatim from game/common/bworld_types.h (retail bworld places it right after
   Sched_tSchedule, before Transformer_zUV: color_types.h NFS4_COLOR_HOOK_AFTER_SCHED). */
#ifndef NFS4_SHARED_ANIMSCRIPT_H
#define NFS4_SHARED_ANIMSCRIPT_H

typedef struct AnimScript {   /* retail: C-style typedef (two TPDEF AnimScript) */
    int baseTicks, baseFrame, flags, numParts;
    Trk_AnimateInst **inst;
} AnimScript; inline void AnimScript_FreeInst(Trk_AnimateInst **inst) { delete [] inst; } /* INFERRED body: retail bworld.obj TPDEF run AnimScript AnimScript Trk_AnimateInst (the AnimScript dtor delete [] inst, without the receiver); never called */
#endif
