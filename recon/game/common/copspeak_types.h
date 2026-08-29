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

struct Copspeak_SndBnkCodegenView { int bnkID; char *phdr, *pdata; };
#define SndBnk_t Copspeak_SndBnkCodegenView

#if !defined(NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES) || \
    defined(NFS4_COPSPEAK_KEEP_BW_CONTEXT)
struct BW_tContext {
    int client;
    BWorldSm_Pos slicePos;
    int currentChunk, chunkFarZClipSq, polyFarZClipSq;
    int lowDetailDistSq, lineFarZClipSq;
};
#endif

#ifndef NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES
struct SNDSTREAMSTATUS {
    int outstandingrequests, currentrequest, timebuffered;
};

struct CopSpeak_tFileIndex { long offset, size; };
struct CopSpeak_tBankHeader { int id; u_char ver; };
struct CopSpeak_tBank {
    int FileHandle, FileOpen;
    CopSpeak_tFileIndex *Index;
    int Count;
};
#endif

struct SPCHNFSType_POSITION { u_long flags; };
struct SPCHNFSType_DISTANCE { u_long flags; };
struct SPCHNFSType_COLOUR { u_long flags; };
struct SPCHNFSType_ACCIDENT { u_long flags; };
struct SPCHNFSType_AMBULANCE { u_long flags; };
struct SPCHNFSType_PURS_UPDT { u_long flags; };
struct SPCHNFSType_ARREST { u_long flags; };
struct SPCHNFSType_vs_RDBLK_SSTRP { u_long flags; };
struct SPCHNFSType_PERP_NAME { u_long flags; };
struct SPCHNFSType_CONFIRM { u_long flags; };
struct SPCHNFSType_SPIKE_BELT_SIDE { u_long flags; };
struct SPCHNFSType_REVINTRO { u_long flags; };

struct CarBank { int fFull, fMake, fModel; };
struct LocationBank { int fStartSlice, fEndSlice, fBankId; char *fName; };
struct CallSignBank { int fAllUnits, fDispatch; int fMobile[15]; };

struct Speaker {
    SPCHNFSType_POSITION fPosition;
    SPCHNFSType_DISTANCE fDistance;
    SPCHNFSType_COLOUR fColour;
    SPCHNFSType_ACCIDENT fAccident;
    SPCHNFSType_AMBULANCE fAmbulance;
    SPCHNFSType_vs_RDBLK_SSTRP fBlockade;
    SPCHNFSType_REVINTRO fReverse;
    SPCHNFSType_CONFIRM fConfirm;
    SPCHNFSType_PERP_NAME fPerpName;
    SPCHNFSType_SPIKE_BELT_SIDE fSpikeSide;
    SPCHNFSType_PURS_UPDT fUpdate;
    SPCHNFSType_ARREST fArrest;
    int fCar, fLocation, fFrom, fTo, fWing;
    bool fHavePerp;
    Speaker *fSub;
    __vtbl_ptr_type (*_vf)[31];
};

/* Speech's completed outer class is absent from copspeak.obj, but its three
 * anonymous bank aggregates are retained by this owner's SYM graph. */
struct Copspeak_SpeechAnonCodegenView {
    struct { CarBank Mobile[9], Dispatch[9]; } fCarBank;
    struct { LocationBank Mobile[16], Dispatch[16]; } fLocationBank;
    struct { CallSignBank Mobile, Dispatch; } fCallSignBank;
};

#endif
