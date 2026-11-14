/* scene.obj's exact source-visible delta over the shared color graph. */
#if !defined(NFS4_GAME_COMMON_SCENE_TYPES_H)   /* first pass */
#define NFS4_GAME_COMMON_SCENE_TYPES_H
#define NFS4_COLOR_TRK_OBJ   /* retail type order (game/common/color_types.h) */
#define NFS4_GAME_COMMON_COLOR_TYPES_H   /* this object lists the parts of the common type graph itself (retail record order) */
#include "color_p0_draw.h"
#include "color_p1_pregroup.h"
#include "color_p2_group_trk.h"
#include "color_p3_trkobj.h"
#include "color_p4_save.h"
#include "color_p5_bwsm.h"
#include "color_p6_bo.h"
#define NFS4_COLOR_IN_HOOK
#include "scene_types.h"   /* this header again: its NFS4_COLOR_IN_HOOK branch */
#undef NFS4_COLOR_IN_HOOK
#include "color_p7_sched.h"
#include "color_p8_car.h"
#include "color_p9_tail.h"
#endif
#if defined(NFS4_COLOR_IN_HOOK) && !defined(NFS4_SCENE_EARLY_DONE)   /* second pass, from color_types.h */
#include "shared/Trk_CollideBoomInst.h"
#define NFS4_SCENE_EARLY_DONE
#include "shared/Trk_ObjectDef.h"






#include "shared/Trk_AnimateInst.h"





#include "shared/Trk_SimObject.h"





#include "shared/AnimScript.h"   /* one AnimScript definition (header-truth 4g) */













#include "shared/SceneElem.h"







#include "shared/SceneSortedElem.h"
typedef struct CSceneList { int id_, numElements_, slice_, versionNumber_; void *Elements(); } CSceneList;   /* INV-A3: untyped return -- retail records CSceneList x3 and no SceneElem field walk here */
/* The element array follows the 16-byte list header. Retail SYM records a code-less inline scope
   pair ({8 {8 }8 }8, no records) where Scene_BuildCustomSceneList takes it; accessor spelling inferred. */
inline void *CSceneList::Elements() { return (void *)(this + 1); }
#include "shared/AnimDef.h"

struct DRender_tView;
struct Draw_DCache;
#include "object_anim_classes.h"   /* the OBJECT.H animation class family: no private copies (header-truth 4h) */
















#endif
#if !defined(NFS4_COLOR_IN_HOOK) && !defined(NFS4_SCENE_TAIL_DONE)   /* first pass tail */
#define NFS4_SCENE_TAIL_DONE
#include "shared/kernpair.h"


typedef kernpair KERN;

typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif
