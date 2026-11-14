/* mpause_types_d7 -- moved verbatim out of mpause_types.h so that header holds only its include list. */
#ifndef NFS4_MPAUSE_TYPES_D7_H
#define NFS4_MPAUSE_TYPES_D7_H
struct tPauseMenuDefs {
    tPauseMenuDefs();
    ~tPauseMenuDefs();
    tPMenuItemNonInteractiveText itemGamePaused; tPMenuItemCommandButton itemContinue, itemRestart; tPMenuItemGoToMenuButton itemOptions; tPMenuItemCommandButton itemQuitRace, itemForfeitRace;
    tPMenu menuPause; tPMenuItemNonInteractiveText itemOptionsTitle; tPMenuItemGoToMenuButton itemAudioSettings, itemControllerSettings; tPMenu menuOptions;
    tPMenuItemNonInteractiveText itemAudioSettingsTitle; tPListIterator iteratorAudioMode;
    tPMenuItemLeftRightChoice itemAudioSettingsAudioMode; tPMenuItemLeftRightSlider itemAudioSettingsMusicVolume, itemAudioSettingsFXVolume;
    tPMenuItemLeftRightSlider itemAudioSettingsSpeechVolume, itemAudioSettingsEngineVolume; tPMenuItemLeftRightSlider itemAudioSettingsAmbientVolume;
    tPMenu menuAudioSettings; tPListIteratorIndexed iteratorConfig;
    tPMenuItemNonInteractiveText itemControllerSettingsTitle;
    tPMenuItemLeftRightChoice itemControllerConfig;
    tPMenuItemLeftRightSliderIndexed itemControllerShockMode, itemControllerShockImpact;
    tPMenu menuControllerConfig;
    tPMenuItemNonInteractiveText itemConfirmTitle, itemConfirmAreYouSure;
    tPMenuItemCommandButton itemConfirmNo, itemConfirmYes;
    tPMenu menuConfirmYesNo;
};
#endif
