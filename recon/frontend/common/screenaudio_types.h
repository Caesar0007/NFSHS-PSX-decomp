/* Owner-specific type surface for ScreenAudio.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENAUDIO_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENAUDIO_TYPES_H

/* ScreenAudio retains the deep car/physics graph plus the common frontend
 * graph used by ScreenTrackInfo, but none of that owner's input/screen/video
 * records. */
#include "../../game/common/color_types.h"
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

#include "shared/AudioMus_tSongEntry.h"





#include "shared/AudioMus_tSongList.h"




#include "shared/SNDSYSCAP.h"






#include "shared/SNDSYSSET.h"







#include "shared/SNDSYSVEC.h"



#include "shared/SNDSYSOPTS.h"





#include "shared/SNDSAMPLEFORMAT.h"




#include "shared/SndBnk_t.h"




#include "shared/SPEECHINFO.h"







struct tDrawShapeExtended;

struct tScreenAudio : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void DrawForeground();
    void Initialize();
    void Cleanup();
    short fShapeCount;
    char prevAudioMode;
    short audioTest;
    int audioTestHandle;
    short fPrevSelectedSong;
    char fCurrentAudioMode;
    short fSelectedSong;
    AudioMus_tSongList *songlist;

    void PlaySound();
    tScreenAudio();
};

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
