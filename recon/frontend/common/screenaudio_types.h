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

struct AudioMus_tSongEntry {
    char *filename, *title, *artist, *label, *date, *notes;
    int length, index;
    char strbuf[32];
};

struct AudioMus_tSongList {
    int numsongs, currentsong;
    AudioMus_tSongEntry song[0];
};

struct SNDSYSCAP {
    u_short outputratemin, outputratemax;
    u_char outputchannelsmin, outputchannelsmax;
    u_char inputvoicesmax, input3dvoicesmax, eax, voicemanager;
    char pad[2];
};

struct SNDSYSSET {
    u_short maxbanks, outputrate;
    u_char outputchannels, inputvoices, useeax, use3dacceleration, use3dmixing;
    char pad;
    u_short emulationsubtype;
    u_short spkrcfg3d[4][4];
};

struct SNDSYSVEC {
    int (*issurfacelocked)(void);
};

struct SNDSYSOPTS {
    SNDSYSCAP cap;
    SNDSYSSET set;
    SNDSYSVEC vec;
};

struct SNDSAMPLEFORMAT {
    u_short samplerate;
    u_char channels, samplerep;
};

struct SndBnk_t {
    int bnkID;
    char *phdr, *pdata;
};

struct SPEECHINFO {
    char name[4];
    int multiplay, nHandle, nSoundHandle;
    char areLoading, soundIsPlaying, playNextOne;
    char *pBankHeader, *sSpeechData, *lastSpeechData;
    int vivHandle;
};

struct tDrawShapeExtended;

struct tScreenAudio : public tScreen {
    short fShapeCount;
    char prevAudioMode;
    short audioTest;
    int audioTestHandle;
    short fPrevSelectedSong;
    char fCurrentAudioMode;
    short fSelectedSong;
    AudioMus_tSongList *songlist;

    void PlaySound();
    void DrawForeground();
    void DrawBackground();
    void GetShapeInfo(short &, short &, char **, char **);
    tScreenAudio();
    void Initialize();
    void Cleanup();
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
