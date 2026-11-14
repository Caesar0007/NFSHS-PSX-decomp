/* copspeak.obj's exact source-visible delta over the shared AudioCmn graph. */
#if !defined(NFS4_GAME_COMMON_COPSPEAK_TYPES_H)   /* first pass */
#define NFS4_GAME_COMMON_COPSPEAK_TYPES_H
#ifndef NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES   /* the standalone owner only */
#define NFS4_AUDIOCLC_LATE_KERNEL   /* retail: TCB..Skidmark right after tfrontEnd (audiocmn_types.h) */
#define NFS4_AUDIOCLC_KERNPAIR_LATE   /* retail: kernpair after tTexture_ShapeInfo (audiocmn_types.h) */
#define NFS4_COPSPEAK_KERNPAIR_AFTER_TEX
#define NFS4_AFTER_CAR_COPSPEAK   /* this object's own types come right after Car_tObj (audioclc_types.h lists the common graph) */
#endif
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
#endif
#if defined(NFS4_COLOR_IN_HOOK2) && !defined(NFS4_COPSPEAK_EARLY_DONE)   /* second pass (owner), from color_types.h */
#define NFS4_COPSPEAK_EARLY_DONE
#include "shared/CopSpeak_tRequest.h"
#include "shared/BW_tContext.h"
#include "shared/AudioMus_tSongEntry.h"
#include "shared/SNDSYSCAP.h"
#include "shared/SNDSYSSET.h"
#include "shared/SNDSYSVEC.h"
#include "shared/SNDPLAYOPTS.h"
#include "shared/SNDSTREAMSTATUS.h"
#include "shared/SNDSAMPLEFORMAT.h"
#endif
#if !defined(NFS4_COLOR_IN_HOOK2) && !defined(NFS4_COPSPEAK_TAIL_DONE)   /* first pass, after audiocmn_types.h */
#define NFS4_COPSPEAK_TAIL_DONE
#include "shared/SndBnk_t.h"
#if !defined(NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES) || \
    defined(NFS4_COPSPEAK_KEEP_BW_CONTEXT)
#include "shared/BW_tContext.h"
#endif
#ifndef NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES
#include "shared/SNDSTREAMSTATUS.h"
#endif
extern "C" {
}
#include "speech_class.h"   /* NFS3.CPP constructs Speech and its undefined Speaker */
#ifndef NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES   /* retail: the bank types after the Speech classes */
struct CopSpeak_tFileIndex { long offset; long size; };
struct CopSpeak_tBankHeader { int id; u_char ver; };
struct CopSpeak_tBank {
    int FileHandle, FileOpen;
    CopSpeak_tFileIndex *Index;
    int Count;
};
#endif

#endif
