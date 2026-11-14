/* common type graph, part 2 of 10 (cut from color_types.h at its order hooks) */
#ifndef NFS4_GAME_COMMON_COLOR_P2_GROUP_TRK_H
#define NFS4_GAME_COMMON_COLOR_P2_GROUP_TRK_H
#include "shared/Group.h"   /* one Group definition (header-truth 4n) */










#ifdef NFS4_COLOR_TRK_OBJ   /* retail: track object types right after Group (owner first header) */
#include "shared/Trk_ObjectDef.h"
#include "shared/Trk_CollideBoomInst.h"
#endif
#if defined(NFS4_COLOR_TRK_OBJ) || defined(NFS4_COLOR_TRK_ANIM)
#include "shared/Trk_AnimateInst.h"
#endif
#include "shared/Trk_Quad.h"
#include "shared/Trk_NewStrip.h"
#include "shared/Trk_NewSimQuad.h"
#include "shared/Trk_NewSimSlice.h"
#endif
