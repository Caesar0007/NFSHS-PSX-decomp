#ifndef NFS4_FRONTEND_COMMON_SCREENAUDIO_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENAUDIO_TYPES_H   /* Owner-specific type surface for ScreenAudio.obj. */
#define NFS4_FE_COLOR_LATE   /* retail type order: frontend graph before color.obj's graph */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail core place (color_types.h does the same) */
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail: tCarClassType right after tOwnedCarInfo (fe_core_cars.h) */
#define NFS4_DRAW_LEAF_CORE_ONLY   /* retail ScreenAudio: frontend menu core before PCOORD16/pads/Draw_* */
#include "../../game/common/draw_leaf_types.h"
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */

/* ScreenAudio retains the deep car/physics graph plus the common frontend graph used by ScreenTrackInfo, */
#ifndef NFS4_FE_COLOR_LATE   /* but none of that owner's input/screen/video records. */
#include "../../game/common/color_types.h"
#endif
#define NFS4_SCREENTRACKINFO_AUDIO_SURFACE
#include "screentrackinfo_types.h"
#undef NFS4_SCREENTRACKINFO_AUDIO_SURFACE

/* These source spellings are not completed enum tags in ScreenAudio.obj. */
#define tMenuTextState int
#define textState_Unselected 0
#define textState_Selected 1
#define textState_Hilighted 2
#define tMenuTextType int
#define textType_ScreenInfo 4
/* Retail tMenuTextType enumerator; retain the owner surface's existing form. */
#define textType_Options 6

#include "shared/AudioMus_tSongEntry.h"
#include "shared/AudioMus_tSongList.h"

struct tDrawShapeExtended;

#include "screenaudio.h"

#include "../../game/common/color_types.h"   /* NFS4_FE_COLOR_LATE: color.obj graph after the frontend graph */
#include "shared/SNDSYSCAP.h"
#include "shared/SNDSYSSET.h"
#include "shared/SNDSYSVEC.h"
#include "shared/SNDSYSOPTS.h"
#include "shared/SNDSAMPLEFORMAT.h"
#include "shared/SndBnk_t.h"
#include "shared/SPEECHINFO.h"

/* FEMenuDefs.obj owns the complete aggregate.  ScreenAudio reads this exact
 * contiguous member slice only. */
struct ScreenAudio_GlobalMenuDefsCodegenView {
    char _beforeItemMusicVolume[0x25cc];
    tMenuItemLeftRightAudioSlider itemMusicVolume;
    tMenuItemLeftRightAudioSlider itemSoundEffectsVolume;
    tMenuItemLeftRightAudioSlider itemEngineVolume;
    tMenuItemLeftRightAudioSlider itemSpeechVolume;
    tMenuItemLeftRightAudioSlider itemAmbientVolume;
    tMenuItemDisplayLeftRightChoice itemAudioMode;
    tMenuItemSlidingActivated itemSlidingPlayList;
    tInsideBoxSongMenu menuPlayListMenu;
    tOptionsMenu menuAudio;
};
#define tGlobalMenuDefs ScreenAudio_GlobalMenuDefsCodegenView

#endif
