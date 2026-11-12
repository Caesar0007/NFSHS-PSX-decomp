/* audedit.obj's exact source-visible delta over the shared color graph. */
#if !defined(NFS4_GAME_COMMON_AUDEDIT_TYPES_H)   /* first pass */
#define NFS4_GAME_COMMON_AUDEDIT_TYPES_H
#define NFS4_COLOR_TRK_OBJ   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_HOOK_AFTER_BO "audedit_types.h"   /* retail: anim/scene/object types right after the BO types (second pass below) */
#include "color_types.h"
#endif
#if defined(NFS4_COLOR_IN_HOOK) && !defined(NFS4_AUDEDIT_EARLY_DONE)   /* second pass, from color_types.h */
#define NFS4_AUDEDIT_EARLY_DONE
#include "shared/Trk_ObjectDef.h"

#include "shared/Trk_CollideBoomInst.h"








#include "shared/Trk_AnimateInst.h"





#include "shared/Trk_SimObject.h"





#include "shared/AnimScript.h"   /* one AnimScript definition (header-truth 4g) */














#include "shared/SceneElem.h"







#include "shared/SceneSortedElem.h"
#include "shared/AnimDef.h"

struct DRender_tView;
struct Draw_DCache;
struct ObjectAnim {
    ObjectAnim() {}
    virtual ~ObjectAnim() {}
    virtual int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset) = 0;
};
struct DRender_tView;
struct Draw_DCache;
typedef struct ObjectFinishedMultiAnim : public ObjectAnim { ObjectFinishedMultiAnim() {}
    int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset);
} ObjectFinishedMultiAnim;

typedef struct ObjectFinishedSignAnim : public ObjectAnim { ObjectFinishedSignAnim() {}
    matrixtdef finalMatrix;
    Trk_ObjectDef *objDef;
    Trk_CollideBoomInst *objCollideInstance;
    int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset);
} ObjectFinishedSignAnim;

#include "shared/CAudioList.h"
#endif
#if !defined(NFS4_COLOR_IN_HOOK) && !defined(NFS4_AUDEDIT_TAIL_DONE)   /* first pass tail */
#define NFS4_AUDEDIT_TAIL_DONE
#include "shared/kernpair.h"


typedef kernpair KERN;

typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif
