/* audiocmn.obj's exact source-visible delta over the shared AudioClc graph. */
#ifndef NFS4_GAME_COMMON_AUDIOCMN_TYPES_H
#define NFS4_GAME_COMMON_AUDIOCMN_TYPES_H

#define NFS4_AUDIOCLC_OMIT_S_TYPE_ALIAS
#define NFS4_AUDIOCLC_OMIT_AUDIOCLC_ONLY_TYPES
#ifndef NFS4_AUDIOCMN_KEEP_INPUT_DEVICE_CALL
#define NFS4_AUDIOCLC_OMIT_INPUT_DEVICE_CALL
#define NFS4_AUDIOCMN_DEFINED_OMIT_INPUT_DEVICE_CALL
#endif
#define NFS4_SINGLE_IMPLICIT_ENUM_TYPEDEF
#include "audioclc_types.h"
#undef NFS4_SINGLE_IMPLICIT_ENUM_TYPEDEF
#ifdef NFS4_AUDIOCMN_DEFINED_OMIT_INPUT_DEVICE_CALL
#undef NFS4_AUDIOCMN_DEFINED_OMIT_INPUT_DEVICE_CALL
#undef NFS4_AUDIOCLC_OMIT_INPUT_DEVICE_CALL
#endif
#undef NFS4_AUDIOCLC_OMIT_AUDIOCLC_ONLY_TYPES
#undef NFS4_AUDIOCLC_OMIT_S_TYPE_ALIAS

#ifndef NFS4_AUDIOCMN_OMIT_OWNER_ONLY_TYPES
typedef enum s_type {
    kAsphalt = 0, kCarBody = 1, kTires = 2, kGravel = 3, kWall = 4,
    kSign = 5, kBush = 6, kBlowOut = 7, kBackFire = 8, kHorn = 9,
    kGearShift = 10, kSnow = 11, kGrass = 12, kWoodWall = 13,
    kGrassWall = 14, kWallSpark = 15, kWetAsphalt = 16,
    kRaceTireOnAsphalt = 17, kRainTireOnAsphalt = 18
} s_type;
#endif

#ifndef NFS4_AUDIOCMN_OMIT_SND_PLAY_OPTS
#include "shared/SNDPLAYOPTS.h"





#endif

#ifndef NFS4_AUDIOCMN_OMIT_OWNER_ONLY_TYPES
#include "shared/SndBnk_t.h"
struct Channels_t { int Partial, SFXnum; };
#endif
#ifndef NFS4_AUDIOCMN_OMIT_AUDIO_MUS_ENTRY
#include "shared/AudioMus_tSongEntry.h"




#endif

#ifndef NFS4_AUDIOCMN_OMIT_COPSPEAK_REQUEST
struct CopSpeak_tRequest {
    Car_tObj *car;
    int buffer, offset, size, filehandle, ophandle, phrase;
    char player, sfx;
    /* P879: retail bank accesses/invalid sentinel are signed. Native CHAR
       encodes both char spellings; this restores the access contract, not
       an unprovable original keyword/flag choice. Layout stays byte +30. */
    signed char bank;
    char noise;
};
#endif

#ifndef NFS4_AUDIOCMN_OMIT_OWNER_ONLY_TYPES
struct AudioCmn_tReTrig {
    int count, pan;
    short delay, nextd;
    int patch;
    char bend, amp;
    coorddef pos;
};

struct AudioCmn_tAsyncSfxSlot {
    int bank, patch, handle, ticks, addr;
    char *header;
};
#endif

#include "shared/Sim_tSimGlobalVar.h"



#include "shared/tReplayInterface.h"



#include "shared/tTexture_ShapeInfo.h"










enum tMenuCommandType {
    kMenu_Command_None = 0, kMenu_Command_GoToMenu = 1,
    kMenu_Command_GoToMenuOneWay = 2, kMenu_Command_GoToMenuTwoPlayer = 3,
    kMenu_Command_BackupMenu = 4, kMenu_Command_StartRace = 5,
    kMenu_Command_Start2PlayerRace = 6, kMenu_Command_ReStartRace = 7,
    kMenu_Command_StartReplay = 8, kMenu_Command_ClearRecords = 9
};

struct tMenuCommand;
struct tMenu;
struct tScreen;

struct tListIterator {
    short *fSelectionList;
    char *fValue;
    char fMinValue, fMaxValue;
    virtual ~tListIterator();   /* layout-only surface: polymorphic root, never dispatched here (FE owns the interface) */
};
struct tListIteratorRange : public tListIterator {};

struct tMenuItem {
    unsigned int fFlags, fTextDescription;
    short fSelFade;
    int fButtonImage, fNumFrames;
    tMenu *fNewMenu;
    virtual ~tMenuItem();   /* layout-only surface: polymorphic root, never dispatched here (FE owns the interface) */
};
typedef tMenuItem *tItemList[16];

struct tMenu {
    unsigned int fFlags;
    short fTitle;
    int fCurrentItem;
    bool fNeverAnyEnabled;
    tMenuItem *fItemList[16];
    tScreen *fScreen;
    tMenu *fNextMenu, *fChildMenu, *fOptionsMenu;
    void (*fOnButtonPress)(tMenuCommand&);
    short VertHelp;
    virtual ~tMenu();   /* layout-only surface: polymorphic root, never dispatched here (FE owns the interface) */
};
struct tMenuItemInteractive : public tMenuItem {};

enum tCarModels {
    cm_MercedesSLK = 0, cm_BMWZ3 = 1, cm_HoldenHSVT = 2,
    cm_FordFalcon = 3, cm_ChevyCamaro = 4, cm_TransAm = 5,
    cm_AstonMartinDB7 = 6, cm_JaguarXKR = 7, cm_BMWM5 = 8,
    cm_ChevyCorvette = 9, cm_Ferrari550 = 10, cm_Porsche911 = 11,
    cm_FerrariF50 = 12, cm_DiabloSV = 13, cm_MercedesCLK = 14,
    cm_McLarenF1 = 15, cm_XPerimentalPorsche = 16,
    cm_XPerimentalF50 = 17, cm_XPerimentalF1 = 18,
    cm_BonusCar1 = 19, cm_BonusCar2 = 20, cm_BonusCar3 = 21,
    cm_CapriceCop = 22, cm_HoldenHSVTCop = 23, cm_BMWM5Cop = 24,
    cm_CorvetteCop = 25, cm_PorscheCop = 26, cm_DiabloCop = 27,
    cm_Helicopter = 28, cm_AudiA4 = 29, cm_BMW530i = 30,
    cm_Mercedes500SL = 31, cm_VolvoWagon = 32, cm_SchoolBus = 33,
    cm_LandCruiser = 34, cm_Miata = 35, cm_ArmyTruck = 36,
    cm_JeepCommanche = 37, cm_OneTonTruck = 38,
    cm_OneTonTruckDirty = 39, cm_MercedesVan = 40,
    cm_JeepCherokee = 41, cm_Satellite = 42, cm_OldChevyPickup = 43,
    cm_FordF150 = 44, cm_Barracuda = 45, cm_TaxiCab = 46,
    cm_TourBus = 47, cm_LoggingTruck = 48, cm_TransitBus = 49,
    cm_NumCarModels = 50
};

enum tCarNameLength {
    cnl_Medium = 0, cnl_Short = 1, cnl_Long = 2
};

enum tPersonalities {
    kPersonalityNemesis = 0, kPersonalityBlurrr = 1,
    kPersonalityZippy = 2, kPersonalityJetBoy = 3,
    kPersonalityMenace = 4, kPersonalityCop1 = 5,
    kPersonalityCop2 = 6, kPersonalityCop3 = 7,
    kPersonalityTraffic = 8, kPersonalityNUM = 9
};

#include "shared/tCarInfo.h"




















#include "shared/tOwnedCarInfo.h"

struct tCarManager {
    u_long fNumCars;
    tCarInfo *fCars;
    tOwnedCarInfo fCarGarage[2][32], fPinkSlipsCars[2][32];
    u_char fAvailableCars[48], fViewableCars[48];
    u_char fPinkSlipsAvailableCars[2][48], fPinkSlipsViewableCars[2][48];
    short fCarTextList[49];
#ifdef NFS4_AUDIOCMN_DECLARE_CAR_MANAGER_METHODS
    void Initialize();
    void LoadDescription();
    void ReleaseDescription();
    void SetClassViewable(tCarClassType carClass, bool viewFlag);
#endif
};

#include "shared/tfrontEnd.h"





































/* Header typedef rows retained by audiocmn.obj. The record-buffer body is a
 * compiler carrier for the public array typedef; the linked owner attributes
 * that completed tag elsewhere. */
#ifndef NFS4_AUDIOCMN_OMIT_SAVE_RECORDS
#include "shared/tRecordBuffer.h"



typedef tRecordBuffer tSaveRecords[187];
#endif

typedef long (*SampleRequestFuncPtr)();
typedef long (*TestSentenceRuleFuncPtr)();
typedef void (*SetSentenceRuleFuncPtr)();
typedef char *(*MemAllocFuncPtr)();
typedef void (*MemFreeFuncPtr)();
typedef long (*ReparmFuncPtr)();
typedef long (*TraceFuncPtr)();

#endif
