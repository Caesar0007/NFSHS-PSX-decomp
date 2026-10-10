/* recon/mod/game/common/music_arena.cpp -- ROUTE D: the race music arena at the end of bigBuf.
 *
 *   Retail reserves two primitive buffers from the bigBuf bump arena (Platform_ReserveMemory,
 *   AllocatePrimitivesBuffer in draw.cpp) and leaves 680 B.  The route D draw.cpp override caps
 *   those buffers; the platform.cpp override calls TrackMod_InitMusicArena at the end of
 *   Platform_InitMemory, so the first TRACKMOD_MUSIC_ARENA bytes of the fresh arena become an EA
 *   memory class of their own (creatememclass, class id TRACKMOD_MUSIC_CLASS) and the capped
 *   primitive buffers follow.  The route D audiomus.cpp override then
 *   allocates the race music (globals 344 B, stream ring 0x6000 + overhead 5,404 B, big-file
 *   header 2,704 B -- 33,100 B measured 2026-10-10) through that class, so it leaves the EA heap.
 *   purgememadr finds the class from the block header, so the retail cleanup works unchanged.
 *
 *   The class exists only while a race module is up: Platform_InitMemory runs in
 *   Nfs2_GameModuleStartUp, AudioMus_SysStartUp in Nfs2_StartUp (before the first render frame
 *   reserves the primitive buffers); the
 *   override drops the class after AudioMus_SysCleanUp (Audio_DeInitDriver, last step of
 *   Nfs2_CleanUpGameModule), before front.bin is loaded back over bigBuf.  Outside a race
 *   TrackMod_musicClass is 0 and the front end's music stays on the heap as in retail.
 */

#define TRACKMOD_MUSIC_CLASS 2        /* memclass[2]; retail uses 0 (RAM) and 1 (a cached copy of 0) */
#define TRACKMOD_MUSIC_ARENA 0x9000   /* 36,864 B: 33,100 B of music blocks + class/guard overhead */

extern "C" int creatememclass(int id, char *name, char *membuf, int bufsize, int granularity, int alignment,
                              int infosize, int lowguard, int reserved9, int highguard, int usemutex, int field3c);
extern "C" void MEM_defaultevent(void);        /* eaclib meminit.c: the default class's event handler */
char *Platform_ReserveMemory(int size, char *string);   /* game/psx/platform.cpp (C++ linkage) */

extern "C" int TrackMod_musicClass;            /* 0 = use the EA heap; else the class id to allocate from */
extern "C" char *TrackMod_musicArena;
extern "C" int TrackMod_musicArenaSize;        /* usable bytes creatememclass reported */
extern "C" int TrackMod_musicArenaFail;        /* Platform_ReserveMemory refused (arena full) */
int TrackMod_musicClass;
char *TrackMod_musicArena;
int TrackMod_musicArenaSize;
int TrackMod_musicArenaFail;

/* Called by the platform.cpp override at the end of Platform_InitMemory (fresh bigBuf arena). */
extern "C" void TrackMod_InitMusicArena(void)
{
    char *buf;
    TrackMod_musicClass = 0;
    TrackMod_musicArena = 0;
    TrackMod_musicArenaSize = 0;
    buf = Platform_ReserveMemory(TRACKMOD_MUSIC_ARENA, "music");
    if (buf == 0) {
        TrackMod_musicArenaFail++;
        return;
    }
    /* same shape as the default class (meminit.c initmemadr): granularity 8, alignment 0x20, no guards */
    TrackMod_musicArenaSize = creatememclass(TRACKMOD_MUSIC_CLASS, "music", buf, TRACKMOD_MUSIC_ARENA,
                                             8, 0x20, 0, 0, 0, 0, 0, (int)MEM_defaultevent);
    TrackMod_musicArena = buf;
    TrackMod_musicClass = TRACKMOD_MUSIC_CLASS;
}

/* Called by the audiomus.cpp override after AudioMus_SysCleanUp purged the music blocks. */
extern "C" void TrackMod_KillMusicArena(void)
{
    TrackMod_musicClass = 0;
    TrackMod_musicArena = 0;
    TrackMod_musicArenaSize = 0;
}

/* The class to allocate a music block from: the arena class while a race module is up, else the heap. */
extern "C" int TrackMod_MusicClass(void)
{
    return TrackMod_musicClass;
}
