/* Owner-specific type surface for FEMemcard.obj. */
#ifndef NFS4_FRONTEND_COMMON_FEMEMCARD_TYPES_H
#define NFS4_FRONTEND_COMMON_FEMEMCARD_TYPES_H

/* Reuse FECheats' exact shared graph without its two cheat records or its
 * filtered foreign tRecordBuffer carrier.  FEMemcard retains tRecordBuffer
 * as a genuine owner record below. */
#define NFS4_FECHEATS_NO_CHEAT_RECORDS
#define NFS4_FECHEATS_NO_RECORD_BUFFER
#define NFS4_FECHEATS_FEMEMCARD_METHODS
#include "fecheats_types.h"
#undef NFS4_FECHEATS_FEMEMCARD_METHODS
#undef NFS4_FECHEATS_NO_RECORD_BUFFER
#undef NFS4_FECHEATS_NO_CHEAT_RECORDS

#define RaceType_SingleRace 0
#define RaceType_PinkSlips 6

typedef enum PRODUCTLOC {
    N_AMERICA = 0,
    JAPAN = 1,
    EUROPE = 2
} PRODUCTLOC;

typedef enum MANAGERTASK {
    NONE = 0,
    LOAD_CARD = 1,
    WRITE_FILE = 2,
    LOAD_FILE = 3,
    DELETE_FILE = 4
} MANAGERTASK;

typedef enum PinkSlipsErrorCode {
    PinkSlipsNoError = 0,
    PinkSlipsError_NotOriginalCard = 1,
    PinkSlipsError_LoadFailed = 2,
    PinkSlipsError_SaveFailed = 3,
    PinkSlipsError_CardNotFound = 4,
    PinkSlipsError_NotFormatted = 5,
    PinkSlipsError_CardFull = 6,
    numPinkSlipsErrors = 7
} PinkSlipsErrorCode;

struct TCB {
    long status, mode;
    u_long reg[40];
    long system[6];
};

struct EXEC {
    u_long pc0, gp0, t_addr, t_size, d_addr, d_size, b_addr, b_size;
    u_long s_addr, s_size, sp, fp, gp, ret, base;
};

struct DIRENTRY {
    char name[20];
    long attr, size;
    DIRENTRY *next;
    long head;
    char system[4];
};

struct AudioMus_tSongEntry {
    char *filename, *title, *artist, *label, *date, *notes;
    int length, index;
    char strbuf[32];
};

struct tRecordBuffer {
    char sName[8];
    int nCar, nTime, nBestLap;
};
typedef tRecordBuffer tSaveRecords[187];

struct tSaveCarInfo {
    tOwnedCarInfo fSaveInfo[32];
    u_char fSaveAvailable[48], fSaveViewable[48];
};

struct tSaveTrackInfo {
    u_char fTrackActivated[16];
};

struct tSaveTournament {
    long fSaveMoney;
    u_char fSaveTier, fSaveTournament, fSaveTrack, fSaveNumRacers;
    tCompetitor fSaveCompetitors[6];
    u_char fSaveBestPlacement[64];
    short fSaveTierFinishPrize[4];
};

typedef COORD16 FE3d_zVertex;
typedef CVECTOR FE3d_zColor;
typedef SVECTOR FE3d_zNormal;

struct FE3d_zUV {
    u_char u, v;
};

struct FE3d_zFacet {
    u_short vertexId0, vertexId1, vertexId2, uvId0, uvId1, uvId2;
    SVECTOR normal[3];
    CVECTOR color;
    u_char flag, pad1, pad2, pad3;
};

struct FE3d_zObj {
    int numVertex, numUV, numFacet;
    u_char textureId, textureWidth, textureHeight, pad1;
    COORD16 *vertex;
    FE3d_zUV *uv;
    COORD16 *Nvertex;
    FE3d_zFacet *facet;
};

struct tDialogYesNoMem : public tDialogYesNo {};

struct CARDINFO_def {
    int status, lasterror, numfiles, freeblocks;
    DIRENTRY dir[15];
};

struct MCRDFILEHEADER_def {
    u_char magicnumber[2];
    u_char type, nslots;
    u_short title[32];
    u_char unused[28];
    u_char iconclut[32];
    u_char icon1[128], icon2[128], icon3[128];
};

struct MCRDFILEINFO_def {
    int cardnum;
    char name[24];
    char *title;
    int size, offset;
    unsigned int flags;
    MCRDFILEHEADER_def header;
    void *pData;
    shapetbl *icon[3];
};

struct MCRDFILE_def {
    char *name, *title;
    int size, offset;
    unsigned int flags;
    void *pData;
    shapetbl *icon[3];
    u_char *numicons, *numblocks;
};

struct tMemCardData {
    u_long fSize, bonus;
    tfrontEnd frontEnd;
    tSaveCarInfo carInfo;
    tSaveTrackInfo trackInfo;
    tSaveTournament tournament;
    tRecordBuffer records[187];
    u_long pinkSlipsNoCheat, frontEndCRC, carInfoCRC, trackInfoCRC;
    u_long tournamentCRC, recordsCRC;
};

struct MCRDOPTS_def {
    PRODUCTLOC productLocation;
    char *productCode;
    int bMoveIconsToVram;
    RECT VramIconArea;
    int (*ConfirmFormatProc)(void), (*ConfirmOverwriteProc)(void);
    void (*LoadingDataProc)(void), (*SavingDataProc)(void);
};

/* Public spellings retained by FEMemCard.obj in addition to the definition
 * tags above.  These aliases are part of the original memcard interface, not
 * duplicate reconstruction records. */
typedef CARDINFO_def CARDINFO;
typedef MCRDFILEHEADER_def MCRDFILEHEADER;
typedef MCRDFILEINFO_def MCRDFILEINFO;
typedef MCRDFILE_def MCRDFILE;
typedef MCRDOPTS_def MCRDOPTS;
typedef void (*MemCB)(void);

/* Foreign objects are exposed only through the fields this owner accesses. */
struct FEMemcard_PadCodegenView {
    int initialized;
    PAD_COMMON buf[8];
    char stateBytes[16];
};
#define tPadModuleState FEMemcard_PadCodegenView

struct FEMemcard_MemCardInfoCodegenView {
    char _beforeReady[0x34];
    int bReady;
};
#define fMemCardInfo_def FEMemcard_MemCardInfoCodegenView

struct FEMemcard_ScreenMemcardCodegenView {
    char _beforeGetNewIcons[0x5a0];
    bool fGetNewIcons;
};
#define tScreenMemcard FEMemcard_ScreenMemcardCodegenView

#endif
