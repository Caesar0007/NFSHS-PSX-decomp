/* common type graph, part 3 of 10 (cut from color_types.h at its order hooks) */
#ifndef NFS4_GAME_COMMON_COLOR_P3_TRKOBJ_H
#define NFS4_GAME_COMMON_COLOR_P3_TRKOBJ_H
#ifdef NFS4_COLOR_TRK_OBJ
#ifdef NFS4_COLOR_TRK_SFX
#include "shared/Trk_SFX.h"
#endif
#ifdef NFS4_COLOR_TRK_LINE   /* retail draww: Trk_Line between Trk_NewSimSlice and Trk_SimObject (moved from draww_types.h) */
typedef struct Trk_Line { u_char firstPoint, slice, type, quadIndex; } Trk_Line;
#endif
#include "shared/Trk_SimObject.h"
#endif
#include "shared/RelCoord16.h"
#endif
