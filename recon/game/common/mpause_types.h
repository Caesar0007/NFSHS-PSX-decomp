#ifndef NFS4_GAME_COMMON_MPAUSE_TYPES_H
#define NFS4_GAME_COMMON_MPAUSE_TYPES_H   /* mpause.obj's exact source-visible delta over the shared color graph. */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_MPAUSE_SND_LATE   /* retail: kernpair, AudioMus, SND* right before tPauseMenuDefs */
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#include "draw_leaf_core.h"
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H   /* this object lists the draw leaf itself (retail record order) */
#include "draw_leaf_a_pads.h"
#undef NFS4_CORE_CCOORD16
#include "draw_leaf_b_pixmap.h"
#include "draw_leaf_c_cache.h"
#include "draw_leaf_d_carvertex.h"
#include "shared/tPMenuCommandType.h"
#include "link_stripped.h"   /* SLINK /strip removed the standalone copies of the inlines below (no #pragma) */
#include "color_types.h"
#include "shared/SndBnk_t.h"
#define RaceType_Tournament 2
#define RaceType_PinkSlips 6

#include "shared/tPMenuCommandType.h"









#define NFS4_FE_INPUT_NO_PLAYER
#include "frontend/common/fe_input_enums.h"   /* one tInputKeyType definition (header-truth 4-C.3) */
#undef NFS4_FE_INPUT_NO_PLAYER















/* Canonical gmesetup.obj aggregate used by the pause-menu source. */
/* GameSetup_tData: not in retail mpause/pausemenu.obj (GameSetup_gData is read through word views) */











/* unconditional since 2026-09-19: the iterator VIRTUALS take a tPlayer, so every TU that sees the classes needs it */
#include "frontend/common/fe_player_types.h"   /* one tPlayer definition (header-truth 4-C.3) */





#if !defined(NFS4_MPAUSE_OMIT_PAUSEMENU_FOREIGN_TYPES) && !defined(NFS4_MPAUSE_SND_LATE)   /* mpause.obj: SND* after kernpair/AudioMus (tPauseMenuDefs block) */
#include "shared/SNDSYSCAP.h"





#include "shared/SNDSYSSET.h"






#include "shared/SNDSYSVEC.h"
#include "shared/SNDSAMPLEFORMAT.h"
#endif
#if !defined(NFS4_MPAUSE_PAUSEMENU_ORDER) && !defined(NFS4_MPAUSE_SND_LATE)   /* pausemenu.obj: AudioMus after the pause classes; mpause.obj: before tPauseMenuDefs (below) */
#include "shared/AudioMus_tSongEntry.h"
#endif



#include "mpause_types_d1.h"
#if defined(NFS4_TU_MPAUSE)   /* owner object: retail records the C-style `typedef struct tPMenuItem {..} tPMenuItem;` form (TPDEF twice) */
#include "mpause_types_d2.h"
#endif
#include "mpause_types_d3.h"
#include "mpause_types_d4.h"
#include "mpause_types_d5.h"
#if defined(NFS4_TU_PAUSEMENU)   /* owner object: retail records the C-style `typedef struct tPMenu {..} tPMenu;` form (TPDEF twice) */
#include "mpause_types_d6.h"
#endif
#ifndef NFS4_MPAUSE_OMIT_PAUSEMENU_FOREIGN_TYPES
#ifdef NFS4_MPAUSE_SND_LATE   /* retail mpause.obj: kernpair, AudioMus, SND* right before tPauseMenuDefs */
#include "shared/kernpair.h"
#include "shared/AudioMus_tSongEntry.h"
#include "shared/SNDSYSCAP.h"
#include "shared/SNDSYSSET.h"
#include "shared/SNDSYSVEC.h"
#include "shared/SNDSAMPLEFORMAT.h"
#endif
#include "mpause_types_d7.h"
#elif defined(NFS4_MPAUSE_PAUSEMENU_ORDER)
#include "shared/AudioMus_tSongEntry.h"
#endif
#include "shared/kernpair.h"
#include "mpause_types_d8.h"

#endif
