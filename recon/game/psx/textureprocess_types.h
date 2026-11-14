/* TextureProcess.obj's exact source-visible type surface reconstructed from
 * the retail SYM.  The completed GameSetup_tData and CTrackSpec records belong
 * to other objects; textureprocess only emits their component/header types. */
#if !defined(NFS4_GAME_PSX_TEXTUREPROCESS_TYPES_H) && !defined(NFS4_COLOR_IN_HOOK)
#define NFS4_GAME_PSX_TEXTUREPROCESS_TYPES_H
/* retail TextureProcess.obj: the C*Spec block right after the draw leaf (before Group), forceFocus_t right after
 * BO_tNewtonObj (second pass through color_types.h's NFS4_COLOR_HOOK_AFTER_BO). */
#define NFS4_CORE_CCOORD16
#include "../common/draw_leaf_types.h"
#undef NFS4_CORE_CCOORD16
#include "shared/CHorizonSpec.h"
#include "shared/CSkySpec.h"
#include "shared/CNightSpec.h"
#include "shared/CWeatherSpec.h"
#include "shared/CFogSpec.h"
#include "shared/CDepthCueSpec.h"
#include "shared/CWorldColor.h"
#define NFS4_GAME_COMMON_COLOR_TYPES_H   /* this object lists the parts of the common type graph itself (retail record order) */
#include "../common/color_p0_draw.h"
#include "../common/color_p1_pregroup.h"
#include "../common/color_p2_group_trk.h"
#include "../common/color_p3_trkobj.h"
#include "../common/color_p4_save.h"
#include "../common/color_p5_bwsm.h"
#include "../common/color_p6_bo.h"
#define NFS4_COLOR_IN_HOOK
#include "../psx/textureprocess_types.h"   /* this header again: its NFS4_COLOR_IN_HOOK branch */
#undef NFS4_COLOR_IN_HOOK
#include "../common/color_p7_sched.h"
#include "../common/color_p8_car.h"
#include "../common/color_p9_tail.h"





#include "shared/kernpair.h"




typedef kernpair KERN;
typedef int (*getcode)();
typedef void (*adjustchar)();
typedef void (*fontblit)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();

typedef struct CSVECTOR { int r, g, b; } CSVECTOR;
struct TP_ZPaletteSystem { int numdepthclut; };
typedef TP_ZPaletteSystem TP_tZPaletteSystem;
typedef struct FogKey {
    short distance, slice;
    FogKey *next, *prev;
} FogKey;

#elif defined(NFS4_COLOR_IN_HOOK) && !defined(NFS4_TEXTUREPROCESS_HOOK_DONE)
#define NFS4_TEXTUREPROCESS_HOOK_DONE
#include "shared/forceFocus_t.h"




#endif
