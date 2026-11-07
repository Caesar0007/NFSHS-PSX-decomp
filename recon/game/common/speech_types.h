/* Speech.obj's exact source-visible delta over the shared AudioClc graph. */
#ifndef NFS4_GAME_COMMON_SPEECH_TYPES_H
#define NFS4_GAME_COMMON_SPEECH_TYPES_H
#define NFS4_CORE_SPCH_FIRST   /* retail: SPCHNFSType structs ahead of the core (nfs4_types.h) */
#define NFS4_AUDIOCLC_LATE_SYS   /* retail: sound/kernel/skidmark types after the Speech classes (audioclc_types.h) */
#define NFS4_AUDIOCLC_OMIT_AUDIOCLC_ONLY_TYPES
#define NFS4_AUDIOCLC_OMIT_SCENE_TYPES
#define NFS4_AUDIOCLC_OMIT_FORCE_FOCUS
#define NFS4_AUDIOCLC_OMIT_CAMERA_VIEW
#define NFS4_AUDIOCLC_OMIT_CARLOGIC_OBSERVATIONS
#define NFS4_AUDIOCLC_OMIT_INPUT_DEVICE_CALL
#define NFS4_AUDIOCLC_OMIT_SCHED_SCHEDULE
#include "audioclc_types.h"
#undef NFS4_AUDIOCLC_OMIT_SCHED_SCHEDULE
#undef NFS4_AUDIOCLC_OMIT_INPUT_DEVICE_CALL
#undef NFS4_AUDIOCLC_OMIT_CARLOGIC_OBSERVATIONS
#undef NFS4_AUDIOCLC_OMIT_CAMERA_VIEW
#undef forceFocus_t
#undef NFS4_AUDIOCLC_OMIT_FORCE_FOCUS
#undef NFS4_AUDIOCLC_OMIT_SCENE_TYPES
#undef NFS4_AUDIOCLC_OMIT_AUDIOCLC_ONLY_TYPES
#include "speech_class.h"
#include "shared/AudioMus_tSongEntry.h"
#include "shared/kernpair.h"
typedef kernpair KERN;
#include "shared/SNDSYSCAP.h"
#include "shared/SNDSYSSET.h"
#include "shared/SNDSYSVEC.h"
#include "shared/SNDSAMPLEFORMAT.h"
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#include "shared/Skidmark_Segment.h"
#include "shared/Skidmark_Chunk.h"
struct Speech_tCarDescription { char *game, *full, *make, *model; };
struct Speech_tLocationDescription { char *name; short start, end; };
struct Speech_tCallSignDescription {
    char *AllUnits;
    char *Dispatch[5];
    char *Mobile[15];
};
struct Speech_tMobileVoiceAttr { int voice, pitch; };
typedef long (*ReparmFuncPtr)();
typedef long (*SampleRequestFuncPtr)();
typedef long (*TestSentenceRuleFuncPtr)();
typedef long (*TraceFuncPtr)();
typedef char *(*MemAllocFuncPtr)();
typedef void (*MemFreeFuncPtr)();
typedef void (*SetSentenceRuleFuncPtr)();
#endif
