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

#include "shared/TCB.h"





#include "shared/EXEC.h"




#include "shared/DIRENTRY.h"







#include "shared/AudioMus_tSongEntry.h"





#include "shared/tRecordBuffer.h"



typedef tRecordBuffer tSaveRecords[187];

#include "shared/tSaveCarInfo.h"




#include "shared/tSaveTrackInfo.h"



#include "shared/tSaveTournament.h"







typedef COORD16 FE3d_zVertex;
typedef CVECTOR FE3d_zColor;
typedef SVECTOR FE3d_zNormal;

#include "shared/FE3d_zUV.h"



#include "shared/FE3d_zFacet.h"






#include "shared/FE3d_zObj.h"








struct tDialogYesNoMem : public tDialogYesNo {
    /* overrides (retail vtable), declared on every owner surface */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
};

#include "shared/CARDINFO_def.h"




#include "shared/MCRDFILEHEADER_def.h"








#include "shared/MCRDFILEINFO_def.h"










#include "shared/MCRDFILE_def.h"








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
typedef void (*MemCB)(long cmds, long rslt); /* PsyQ 4.3 <libmcrd.h> */

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
