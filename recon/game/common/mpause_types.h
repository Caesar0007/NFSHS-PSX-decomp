/* mpause.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_MPAUSE_TYPES_H
#define NFS4_GAME_COMMON_MPAUSE_TYPES_H

#include "color_types.h"

#define RaceType_Tournament 2
#define RaceType_PinkSlips 6

typedef struct __nfs4_vtbl_ptr_t {
    short delta, index;
    int (*pfn)(...);
} __nfs4_vtbl_ptr_t;
#define __vtbl_ptr_type __nfs4_vtbl_ptr_t

typedef enum tPMenuCommandType {
    kMPause_NoEvent = 0,
    kMPause_Continue = 1,
    kMPause_Restart = 2,
    kMPause_QuitToGameSetup = 3,
    kMPause_QuitToRaceSummary = 4,
    kMPause_ForfeitToRaceSummary = 5,
    kMPause_GoToMenu = 6,
    kMPause_BackupMenu = 7,
    kMPause_CommandConfirmationFlag = 256
} tPMenuCommandType;

typedef enum tInputKeyType {
    kInput_KeyType_NoKey = 0,
    kInput_KeyType_AlreadyProcessed = 1,
    kInput_KeyType_Cross = 2,
    kInput_KeyType_Circle = 4,
    kInput_KeyType_Square = 8,
    kInput_KeyType_Triangle = 16,
    kInput_KeyType_L1 = 32,
    kInput_KeyType_L2 = 64,
    kInput_KeyType_R1 = 128,
    kInput_KeyType_R2 = 256,
    kInput_KeyType_Up = 512,
    kInput_KeyType_Down = 1024,
    kInput_KeyType_Left = 2048,
    kInput_KeyType_Right = 4096,
    kInput_KeyType_Start = 8192,
    kInput_KeyType_Select = 16384
} tInputKeyType;

/* Canonical gmesetup.obj aggregate used by the pause-menu source. */
struct GameSetup_tData {
    int raceType, numLaps, skill, commMode, tournamentMultiplier, cops;
    int trafficDensity, localCar, catchupLogic, replayMode, instantReplay;
    int mirrorTrack, reverseTrack, measurement, sgge, track, trackSegment, song;
    int Weather, Fog, Damage, Time, randSeed, easter;
    GameSetup_tControllerData controllerData;
    int pinkSlipsForfeit, checkpointType;
    int checkpointHUD[2];
    int dispatchSpeech, reverseCallSpeech, languageSpeech;
    int SceneNumber, SceneStartLap, SceneEndLap;
    GameSetup_tUserSetting userSetting;
    int numPerps, stageOffset, perpArrests, finalPerpArrests;
    GameSetup_tPerpData perpInfo[10];
    int numCars, numPlayerRaceCars, numOpponentRaceCars, opponentCarType;
    GameSetup_tCarData carInfo[9];
};

#ifdef NFS4_MPAUSE_PAUSEMENU_METHODS
typedef enum tPlayer {
    kPlayerBoth = -1,
    kPlayerOne = 0,
    kPlayerTwo = 1
} tPlayer;
#endif

#ifndef NFS4_MPAUSE_OMIT_PAUSEMENU_FOREIGN_TYPES
struct SNDSYSCAP {
    u_short outputratemin, outputratemax;
    u_char outputchannelsmin, outputchannelsmax, inputvoicesmax;
    u_char input3dvoicesmax, eax, voicemanager;
    char pad[2];
};
struct SNDSYSSET {
    u_short maxbanks, outputrate;
    u_char outputchannels, inputvoices, useeax, use3dacceleration, use3dmixing;
    char pad;
    u_short emulationsubtype;
    u_short spkrcfg3d[4][4];
};
struct SNDSYSVEC { int (*issurfacelocked)(void); };
struct SNDSAMPLEFORMAT { u_short samplerate; u_char channels, samplerep; };
#endif
struct AudioMus_tSongEntry {
    char *filename, *title, *artist, *label, *date, *notes;
    int length, index;
    char strbuf[32];
};

struct tPMenu;
struct tPMenuCommand { tPMenuCommandType type; tPMenu *nextMenu; };

struct tPListIterator {
    short *fSelectionList;
    int *fValue;
    __vtbl_ptr_type (*_vf)[6];
    tPListIterator() {}
    tPListIterator(short *, int *);
    ~tPListIterator();
#ifdef NFS4_MPAUSE_PAUSEMENU_METHODS
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
#endif
};
struct tPListIteratorIndexed : public tPListIterator {
    char *fIndex;
    tPListIteratorIndexed(short *, int *, char *);
    ~tPListIteratorIndexed();
#ifdef NFS4_MPAUSE_PAUSEMENU_METHODS
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
#endif
};

struct tPMenuItem {
    unsigned int fFlags, fTextDescription;
    __vtbl_ptr_type (*_vf)[7];
    tPMenuItem(unsigned int);
    ~tPMenuItem();
    tPMenu *NextMenu();
    bool Debounce();
    void ProcessInput(tInputKeyType &, tPMenuCommand &);
    bool IsEnabled();
    bool IsDisabled();
    inline tPMenu *VirtualNextMenu() {
        return (tPMenu *)(*(*_vf)[2].pfn)((int)&fFlags + (*_vf)[2].delta);
    }
    inline void VirtualProcessInput(tInputKeyType &key,
                                    tPMenuCommand &command) {
        (*(*_vf)[4].pfn)((int)&fFlags + (*_vf)[4].delta, &key, &command);
    }
    inline int VirtualIsNavigable() {
        return (*(*_vf)[5].pfn)((int)&fFlags + (*_vf)[5].delta);
    }
    /* SYM-INLINE-FACADE: Initialize's SLD records the inlined tPMenuItem
       `this` but no named condition result.  Retail materializes the two
       compound predicates as int 0/1 values in a0 and s0.  These facades
       preserve that proven inline boundary; SYM cannot recover whether EA
       spelled them as helpers, macros, or repeated expressions. */
    inline int IsEnabledAndNavigable() {
        int result = false;
        if (((fFlags ^ 1) & 1) != 0) {
            result = VirtualIsNavigable() != 0;
        }
        return result;
    }
    inline int IsDisabledOrNotNavigable() {
        int result = false;
        if (((fFlags & 1) != 0) || (VirtualIsNavigable() == 0)) {
            result = true;
        }
        return result;
    }
    inline void Draw(bool selected) {
        (*(*_vf)[6].pfn)((int)&fFlags + (*_vf)[6].delta, selected);
    }
};
struct tPMenuItemNonInteractiveText : public tPMenuItem {
    tPMenuItemNonInteractiveText(unsigned int);
    ~tPMenuItemNonInteractiveText();
    void Draw(bool);
    bool IsNavigable();
};
struct tPMenuItemInteractive : public tPMenuItem {
    tPMenuItemInteractive(unsigned int);
    ~tPMenuItemInteractive();
    void Draw(bool);
    bool IsNavigable();
};
struct tPMenuItemLeftRightChoice : public tPMenuItemInteractive {
    tPListIterator *fData;
    tPMenuItemLeftRightChoice(unsigned int, tPListIterator *);
    ~tPMenuItemLeftRightChoice();
    void ProcessInput(tInputKeyType &, tPMenuCommand &);
    void Draw(bool);
};
struct tPMenuItemLeftRightSlider : public tPMenuItemInteractive {
    int *fData;
    char fMaxVal;
    tPMenuItemLeftRightSlider(unsigned int, int *, char);
    ~tPMenuItemLeftRightSlider();
    bool Debounce();
    void ProcessInput(tInputKeyType &, tPMenuCommand &);
    void Draw(bool);
};
struct tPMenuItemLeftRightSliderIndexed : public tPMenuItemLeftRightSlider {
    char *fIndex;
    tPMenuItemLeftRightSliderIndexed(unsigned int, int *, char, char *);
    ~tPMenuItemLeftRightSliderIndexed();
    void ProcessInput(tInputKeyType &, tPMenuCommand &);
    void Draw(bool);
};
struct tPMenuItemGoToMenuButton : public tPMenuItemInteractive {
    tPMenu *fNewMenu;
    void (*fOnButtonPress)(tPMenuCommand &);
    tPMenuItemGoToMenuButton(unsigned int, tPMenu *, void (*)(tPMenuCommand &));
    ~tPMenuItemGoToMenuButton();
    tPMenu *NextMenu();
    void ProcessInput(tInputKeyType &, tPMenuCommand &);
};
struct tPMenuItemCommandButton : public tPMenuItemInteractive {
    tPMenuCommandType fCommand;
    tPMenuItemCommandButton(unsigned int, tPMenuCommandType);
    ~tPMenuItemCommandButton();
    void ProcessInput(tInputKeyType &, tPMenuCommand &);
};

typedef tPMenuItem *tPItemList[16];
#ifndef NFS4_MPAUSE_OMIT_INPUT_DEVICE_CALL
typedef int Input_tDeviceCall();
#endif

struct tPMenu {
    int fCurrentItem;
    bool fHighlight;
    tPMenuItem *fItemList[16];
    tPMenu *fNextMenu;
    int fNumItems;
    __vtbl_ptr_type (*_vf)[5];
    tPMenu() {}
    tPMenu(tPMenuItem *, ...);
    ~tPMenu();
    void tPMenuConstructor(tPMenuItem *, void *);
    void Initialize();
    bool Debounce();
    void CheckForDisabled();
    void ProcessInput(tInputKeyType &, tPMenuCommand &);
    void Draw();
    int NumEnabledItems();
    int ItemEnabledNum(int);
    inline void VirtualInitialize() {
        (*(*_vf)[2].pfn)((int)this + (*_vf)[2].delta);
    }
    inline void VirtualProcessInput(tInputKeyType &key, tPMenuCommand &command) {
        (*(*_vf)[3].pfn)((int)this + (*_vf)[3].delta, &key, &command);
    }
};

#ifndef NFS4_MPAUSE_OMIT_PAUSEMENU_FOREIGN_TYPES
struct tPauseMenuDefs {
    tPauseMenuDefs();
    ~tPauseMenuDefs();
    tPMenuItemNonInteractiveText itemGamePaused;
    tPMenuItemCommandButton itemContinue, itemRestart;
    tPMenuItemGoToMenuButton itemOptions;
    tPMenuItemCommandButton itemQuitRace, itemForfeitRace;
    tPMenu menuPause;
    tPMenuItemNonInteractiveText itemOptionsTitle;
    tPMenuItemGoToMenuButton itemAudioSettings, itemControllerSettings;
    tPMenu menuOptions;
    tPMenuItemNonInteractiveText itemAudioSettingsTitle;
    tPListIterator iteratorAudioMode;
    tPMenuItemLeftRightChoice itemAudioSettingsAudioMode;
    tPMenuItemLeftRightSlider itemAudioSettingsMusicVolume, itemAudioSettingsFXVolume;
    tPMenuItemLeftRightSlider itemAudioSettingsSpeechVolume, itemAudioSettingsEngineVolume;
    tPMenuItemLeftRightSlider itemAudioSettingsAmbientVolume;
    tPMenu menuAudioSettings;
    tPListIteratorIndexed iteratorConfig;
    tPMenuItemNonInteractiveText itemControllerSettingsTitle;
    tPMenuItemLeftRightChoice itemControllerConfig;
    tPMenuItemLeftRightSliderIndexed itemControllerShockMode, itemControllerShockImpact;
    tPMenu menuControllerConfig;
    tPMenuItemNonInteractiveText itemConfirmTitle, itemConfirmAreYouSure;
    tPMenuItemCommandButton itemConfirmNo, itemConfirmYes;
    tPMenu menuConfirmYesNo;
};
#endif

struct kernpair { u_short previouscode, code; char kernvalue; char pad[3]; };
typedef kernpair KERN;
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif
