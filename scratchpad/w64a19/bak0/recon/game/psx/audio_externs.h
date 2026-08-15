#include "../../lib/libfns.h"
/* audio_externs.h -- extern decls for game/psx/audio.cpp (NFS4 PSX sound driver). */
#ifndef AUDIO_EXTERNS_H
#define AUDIO_EXTERNS_H

/* ---- libc ---- */

/* ---- harvested ---- */
extern SndBnk_t gSndBnk[7];
extern int  gMasterFENarrationLevel, gStereoMode, Audio_direct3davail;

/* ---- SYM Globals + free fns ---- */
extern void AudioClc_SndError(int);
extern void AudioCmn_InitReverb(void);
extern void AudioMus_SysCleanUp(void);
extern void AudioMus_SysStartUp(int, int, char *);

/* ---- SNDSYS / SND-bank audio lib (sigs from call sites) ---- */
          /* disasm 0xABC9C: no $a0 set -> void */
/* ---- Audio.obj globals (SYM c_type absent; inferred) ---- */
extern int   AudioCmn_kAudioOn;
extern int   AudioCmn_kAudioStreamingOn;
extern void *Audio_gHeap;                   /* reservememadr/purgememadr/SNDSYS_init heap */

#endif
