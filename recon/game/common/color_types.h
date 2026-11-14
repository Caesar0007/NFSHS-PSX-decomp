#ifndef NFS4_GAME_COMMON_COLOR_TYPES_H   /* color.obj's exact source-visible type surface reconstructed from SYM. */
#define NFS4_GAME_COMMON_COLOR_TYPES_H
/* The parts of the common type graph in their default sequence. The `#include NFS4_COLOR_HOOK_*` lines are the
   remaining order hooks: an object that defines one gets its own types at that point. They are being replaced
   by objects that list the parts themselves (docs/HEADER_TRUTH_PLAN.md, phase 9). */
#include "color_p0_draw.h"
#include "color_p1_pregroup.h"
#include "color_p2_group_trk.h"
#include "color_p3_trkobj.h"
#include "color_p4_save.h"
#ifdef NFS4_COLOR_HOOK_AFTER_SAVE   /* retail skidmark.obj: the owner's TCB/EXEC/DIRENTRY/Skidmark block right after tSaveSurface */
#define NFS4_COLOR_IN_HOOK3
#include NFS4_COLOR_HOOK_AFTER_SAVE
#undef NFS4_COLOR_IN_HOOK3
#endif
#include "color_p5_bwsm.h"
#include "color_p6_bo.h"
#ifdef NFS4_COLOR_HOOK_AFTER_BO   /* retail object/bworld: the owner's anim/object types right after the BO types (owner second pass) */
#define NFS4_COLOR_IN_HOOK
#include NFS4_COLOR_HOOK_AFTER_BO
#undef NFS4_COLOR_IN_HOOK
#endif
#include "color_p7_sched.h"
#include "color_p8_car.h"
#ifdef NFS4_COLOR_HOOK_AFTER_CAR   /* retail hud: the owner's types right after Car_tObj (owner second pass) */
#define NFS4_COLOR_IN_HOOK2
#include NFS4_COLOR_HOOK_AFTER_CAR
#undef NFS4_COLOR_IN_HOOK2
#endif
#include "color_p9_tail.h"
#endif
