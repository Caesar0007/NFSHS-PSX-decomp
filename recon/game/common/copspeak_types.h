/* copspeak.obj's exact source-visible delta over the shared AudioCmn graph. */
#ifndef NFS4_GAME_COMMON_COPSPEAK_TYPES_H
#define NFS4_GAME_COMMON_COPSPEAK_TYPES_H

#define NFS4_AUDIOCLC_OMIT_SCENE_TYPES
#ifndef NFS4_COPSPEAK_KEEP_FORCE_FOCUS
#define NFS4_AUDIOCLC_OMIT_FORCE_FOCUS
#define NFS4_COPSPEAK_DEFINED_OMIT_FORCE_FOCUS
#endif
#ifndef NFS4_COPSPEAK_KEEP_CAMERA_VIEW
#define NFS4_AUDIOCLC_OMIT_CAMERA_VIEW
#define NFS4_COPSPEAK_DEFINED_OMIT_CAMERA_VIEW
#endif
#define NFS4_AUDIOCLC_OMIT_CARLOGIC_OBSERVATIONS
#define NFS4_AUDIOCMN_OMIT_OWNER_ONLY_TYPES
#ifndef NFS4_COPSPEAK_KEEP_SAVE_RECORDS
#define NFS4_AUDIOCMN_OMIT_SAVE_RECORDS
#define NFS4_COPSPEAK_DEFINED_OMIT_SAVE_RECORDS
#endif
#include "audiocmn_types.h"
#ifdef NFS4_COPSPEAK_DEFINED_OMIT_SAVE_RECORDS
#undef NFS4_COPSPEAK_DEFINED_OMIT_SAVE_RECORDS
#undef NFS4_AUDIOCMN_OMIT_SAVE_RECORDS
#endif
#ifdef NFS4_COPSPEAK_DEFINED_OMIT_FORCE_FOCUS
#undef NFS4_COPSPEAK_DEFINED_OMIT_FORCE_FOCUS
#undef forceFocus_t
#undef NFS4_AUDIOCLC_OMIT_FORCE_FOCUS
#endif
#undef NFS4_AUDIOCMN_OMIT_OWNER_ONLY_TYPES
#undef NFS4_AUDIOCLC_OMIT_CARLOGIC_OBSERVATIONS
#ifdef NFS4_COPSPEAK_DEFINED_OMIT_CAMERA_VIEW
#undef NFS4_COPSPEAK_DEFINED_OMIT_CAMERA_VIEW
#undef NFS4_AUDIOCLC_OMIT_CAMERA_VIEW
#endif
#undef NFS4_AUDIOCLC_OMIT_SCENE_TYPES

#include "shared/SndBnk_t.h"

#if !defined(NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES) || \
    defined(NFS4_COPSPEAK_KEEP_BW_CONTEXT)
#include "shared/BW_tContext.h"





#endif

#ifndef NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES
#include "shared/SNDSTREAMSTATUS.h"



struct CopSpeak_tFileIndex { long offset, size; };
struct CopSpeak_tBankHeader { int id; u_char ver; };
struct CopSpeak_tBank {
    int FileHandle, FileOpen;
    CopSpeak_tFileIndex *Index;
    int Count;
};
#endif



extern "C" {
}

#include "speech_class.h"   /* NFS3.CPP constructs Speech and its undefined Speaker */

#endif
