/* Shared frontend/common type surface reconstructed from the exact retail
 * overlap of FEMission.obj, FETracks.obj, and FEInput.obj.  Owner headers add
 * only the records present in their own SYM object graph. */
#ifndef NFS4_FRONTEND_COMMON_FE_CORE_TYPES_H
#define NFS4_FRONTEND_COMMON_FE_CORE_TYPES_H

#include "felines_types.h"
#include "../../game/common/gamesetup_leaf_types.h"

/* These source spellings are not typedef records in FEMission.obj. */
#define byte unsigned char
#define uint unsigned int

typedef struct __nfs4_vtbl_ptr_t {
    short delta;
    short index;
    int (*pfn)(...);
} __nfs4_vtbl_ptr_t;
#define __vtbl_ptr_type __nfs4_vtbl_ptr_t

#ifndef NFS4_TMENUCOMMANDTYPE_DEFINED
#define NFS4_TMENUCOMMANDTYPE_DEFINED
enum tMenuCommandType {
    kMenu_Command_None = 0,
    kMenu_Command_GoToMenu = 1,
    kMenu_Command_GoToMenuOneWay = 2,
    kMenu_Command_GoToMenuTwoPlayer = 3,
    kMenu_Command_BackupMenu = 4,
    kMenu_Command_StartRace = 5,
    kMenu_Command_Start2PlayerRace = 6,
    kMenu_Command_ReStartRace = 7,
    kMenu_Command_StartReplay = 8,
    kMenu_Command_ClearRecords = 9
};
#endif

#ifndef NFS4_FE_CORE_NO_CAR_TYPES
enum tCarModels {
    cm_MercedesSLK = 0, cm_BMWZ3 = 1, cm_HoldenHSVT = 2,
    cm_FordFalcon = 3, cm_ChevyCamaro = 4, cm_TransAm = 5,
    cm_AstonMartinDB7 = 6, cm_JaguarXKR = 7, cm_BMWM5 = 8,
    cm_ChevyCorvette = 9, cm_Ferrari550 = 10, cm_Porsche911 = 11,
    cm_FerrariF50 = 12, cm_DiabloSV = 13, cm_MercedesCLK = 14,
    cm_McLarenF1 = 15, cm_XPerimentalPorsche = 16,
    cm_XPerimentalF50 = 17, cm_XPerimentalF1 = 18, cm_BonusCar1 = 19,
    cm_BonusCar2 = 20, cm_BonusCar3 = 21, cm_CapriceCop = 22,
    cm_HoldenHSVTCop = 23, cm_BMWM5Cop = 24, cm_CorvetteCop = 25,
    cm_PorscheCop = 26, cm_DiabloCop = 27, cm_Helicopter = 28,
    cm_AudiA4 = 29, cm_BMW530i = 30, cm_Mercedes500SL = 31,
    cm_VolvoWagon = 32, cm_SchoolBus = 33, cm_LandCruiser = 34,
    cm_Miata = 35, cm_ArmyTruck = 36, cm_JeepCommanche = 37,
    cm_OneTonTruck = 38, cm_OneTonTruckDirty = 39, cm_MercedesVan = 40,
    cm_JeepCherokee = 41, cm_Satellite = 42, cm_OldChevyPickup = 43,
    cm_FordF150 = 44, cm_Barracuda = 45, cm_TaxiCab = 46,
    cm_TourBus = 47, cm_LoggingTruck = 48, cm_TransitBus = 49,
    cm_NumCarModels = 50
};

enum tCarNameLength {
    cnl_Medium = 0,
    cnl_Short = 1,
    cnl_Long = 2
};

enum tPersonalities {
    kPersonalityNemesis = 0, kPersonalityBlurrr = 1,
    kPersonalityZippy = 2, kPersonalityJetBoy = 3,
    kPersonalityMenace = 4, kPersonalityCop1 = 5,
    kPersonalityCop2 = 6, kPersonalityCop3 = 7,
    kPersonalityTraffic = 8, kPersonalityNUM = 9
};
#endif

struct tMenu;
struct tScreen;

struct tListIterator {
    short *fSelectionList;
    char *fValue;
    char fMinValue, fMaxValue;
    __vtbl_ptr_type (*_vf)[6];

    tListIterator() {}
    tListIterator(short *selection, char *valPtr);
    ~tListIterator();
#ifdef NFS4_FE_CORE_FEMENU_METHODS
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
#endif
};

struct tListIteratorRange : public tListIterator {
#ifdef NFS4_FE_CORE_FEMENU_METHODS
    tListIteratorRange() {}
    tListIteratorRange(char minValue, char maxValue, char *valPtr);
    ~tListIteratorRange();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
#endif
};

struct tMenuItem {
    unsigned int fFlags, fTextDescription;
    short fSelFade;
    int fButtonImage, fNumFrames;
    tMenu *fNewMenu;
    __vtbl_ptr_type (*_vf)[11];
#ifdef NFS4_FE_CORE_FEMENU_METHODS
    tMenuItem() {}
    tMenuItem(unsigned int textDescription);
    ~tMenuItem();
    long DebounceKeys();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void UpdateTransition(bool);
    bool TransitionIsFinished();
    void UpdateSelFade(bool);
    void Draw(int, int, bool);
    void Draw(int, int, int, bool);
    void TransitionOn();
    void TransitionOff();
    bool IsDisabled() { return (fFlags & 1) != 0; }
#endif
};

typedef tMenuItem *tItemList[16];

struct tMenu {
    unsigned int fFlags;
    short fTitle;
    int fCurrentItem;
    bool fNeverAnyEnabled;
    tItemList fItemList;
    tScreen *fScreen;
    tMenu *fNextMenu, *fChildMenu, *fOptionsMenu;
#ifdef NFS4_FE_CORE_FEMENU_METHODS
    void (*fOnButtonPress)(tMenuCommand &);
#else
    void (*fOnButtonPress)(void *);
#endif
    short VertHelp;
    __vtbl_ptr_type (*_vf)[11];
#ifdef NFS4_FE_CORE_FEMENU_METHODS
    tMenu() {}
    void tMenuConstructor(tMenuItem *firstItem, void *ap);
    tMenu(unsigned int, tScreen *, tMenu *, tMenu *,
          void (*)(tMenuCommand &), short);
    ~tMenu();
    void Initialize();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    short GetNumberEnabledItems();
    void Draw();
    void UpdateTransition();
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    bool IsSubMenu();
    long DebounceKeys();
#endif
};

struct tMenuItemInteractive : public tMenuItem {
#ifdef NFS4_FE_CORE_FEMENU_METHODS
    tMenuItemInteractive() {}
    tMenuItemInteractive(unsigned int);
    ~tMenuItemInteractive();
#endif
};

#ifndef NFS4_FE_CORE_NO_CAR_TYPES
struct tCarInfo {
    signed char fCarID;
    u_char fSimNumber, fCarClass, fABSAvailable, fDefaultColor;
    u_char fCopClass, fDefaultTires, fAvailable;
    char fShapeName[8], fSmallName[8], fQTVRName[8];
    long fPrices[4];
    u_char fStats[4][5];
    u_long fColorList[16];
    u_char fSpeechColors[16];
    u_long fHudColor[2];
    char fDayTachFile[8], fNightTachFile[8];
    char fNumLightColors, fNumDarkColors;
    u_char fCountries;
    char fColorOrder[16];
    u_char fPursuitAvailable, fEnginePatch;
    signed char fSpeechCarID;
    u_char fTractionAvailable, fExoticCar, fUpgrades, fColor;
    u_char fViewable, fCountry, fCarIndex;
    u_char fReserved[3];
};

struct tOwnedCarInfo {
    signed char fCarID;
    u_char fUpgrades, fCarColor, fPad;
};

struct tCarManager {
    u_long fNumCars;
    tCarInfo *fCars;
    tOwnedCarInfo fCarGarage[2][32], fPinkSlipsCars[2][32];
    u_char fAvailableCars[48], fViewableCars[48];
    u_char fPinkSlipsAvailableCars[2][48];
    u_char fPinkSlipsViewableCars[2][48];
    short fCarTextList[49];
};

struct tfrontEnd {
    short randomSeed;
    char currentPlayer, gameMode, raceType, style, skillLevel;
    char catchup, ghostcar, tractionassist, bestline;
    short pinkSlipsWinner[5];
    char timeOfDay[5], weather[5];
    char fog, localSpeech, opponentUpgrades;
    char track[5];
    int recordlaptime;
    char laps;
    char lapind[5], trackdirection[5], trackmirrored[5];
    char traffic[5], situations[5];
    char pinkSlipsTrackIndex, pinkSlipsNumTracks;
    char pinkSlipsWins[2];
    long pinkSlipsCash[2];
    short cheatFlags, cheatFlagsActive, secretFlags, pinkSlipsForfeit;
    char playerCar[2], transmission[2];
    char carColors[2][48], carCountry[2][48];
    char tournament, specialevent, tier;
    char garageCar[2], pinkSlipsCar[2];
    char upgrade, dealerCar, sellerCar, carListType;
    char policeTier, policeMission, congratsCopCar, congratsCopCountry;
    short settingsActive[2];
    char steeringSensitivity[2][48], tireType[2][48];
    char suspension[2][48], carDownforce[2][48], engineTuning[2][48];
    char ABS[2];
    char damage;
    char rampSteer[2], rampGas[2], rampBrake[2];
    char oppCar, oppNumber, measurement;
    char displaySpeed[2], displayTach[2], displayMap[2];
    char displayOpponentID[2], displayTime[2], displayPosition[2];
    char displayLapNumber[2], displayMirror[2];
    char cameraType[2][4], cameraSway[2][4];
    char language, musicVolume, sfxVolume, narrationVolume;
    char engineVolume, ambientVolume, audioMode, song, sensitivity;
    char steeringRange[2], deadSpot[2], ImaxRange[2], IImaxRange[2];
    char J1MAX[2], J1MIN[2], J2MAX[2], J2MIN[2];
    char shockMode[2], shockImpact[2];
    short controlType[2];
    char controlConfig[2];
    char playerNameList[2][8], allUpperCasedPlayerNameList[2][8];
    char licensePlate[2][8];
    char headstart, numBTracksActivated, checkPointType;
    char checkPointDisplay[2], defaultedPlayerName[2];
    bool FEPlayList[40];
    u_long gPinkSlipsNoCheat[2];
    bool GotAPlayList;
    bool AnalogOn[2];
};
#endif

#endif
