/* Speech.obj's exact source-visible delta over the shared AudioClc graph. */
#ifndef NFS4_GAME_COMMON_SPEECH_TYPES_H
#define NFS4_GAME_COMMON_SPEECH_TYPES_H

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

typedef struct __nfs4_vtbl_ptr_t {
    short delta, index;
    int (*pfn)(...);
} __nfs4_vtbl_ptr_t;
#define __vtbl_ptr_type __nfs4_vtbl_ptr_t

struct AudioMus_tSongEntry {
    char *filename, *title, *artist, *label, *date, *notes;
    int length, index;
    char strbuf[32];
};

#include "speech_class.h"



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
