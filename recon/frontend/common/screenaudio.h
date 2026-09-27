/* frontend/common/screenaudio.h -- retail SCREENAUDIO.H: the one definition of tScreenAudio.  Layout and the defining
 * .CPP are the retail SYM's; the including surface provides tScreen (fescreen.h) and the types
 * the declarations name. */
#ifndef _FE_SCREENS_SCREENAUDIO_H_
#define _FE_SCREENS_SCREENAUDIO_H_

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

/* member fns declared in nfs4_types.h (tScreenAudio) */

#endif
