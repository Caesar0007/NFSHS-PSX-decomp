#ifndef NFS4_GAME_PSX_TRSPROJ_TYPES_H
#define NFS4_GAME_PSX_TRSPROJ_TYPES_H   /* TrsProj.obj's exact source-visible type surface reconstructed from SYM. */
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail place (after COORD16, before the pads) */
#define NFS4_DRAW_LEAF_HOOK_AFTER_PIXMAP "shared/Draw_tVertex.h"   /* retail trsproj.obj: Draw_tVertex right after Draw_tPixMap */
#include "../common/draw_leaf_types.h"

/* Canonical gmesetup.obj aggregate used by this translation unit. */
/* GameSetup_tData: not in retail trsproj.obj (GameSetup_gData is read through its word view) */
















#include "shared/CCOORD16.h"
#include "shared/Draw_tVertex.h"

#include "shared/DRender_tView.h"




#include "shared/Trk_Quad.h"
#include "shared/Trk_NewStrip.h"
#include "shared/Trk_NewSimQuad.h"
#include "shared/Trk_NewSimSlice.h"

#include "shared/RelCoord16.h"
#include "../common/gamesetup_leaf_types.h"   /* retail: GameSetup records right after RelCoord16 */

struct Group {
    int m_num_elements;
    inline void *GetData() { return this + 1; }
    inline int GetNumElements() { return m_num_elements; }
};

#include "shared/tSaveSurface.h"

#include "shared/BWorldSm_Pos.h"













struct BO_tNewtonObj;
#include "shared/BO_tNewtonCollisionInfo.h"









#include "shared/BO_tNewtonObj.h"




























typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;
typedef short (*tPA32)[32];

#endif
