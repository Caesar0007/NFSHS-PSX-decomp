/* fecheats_dialogs.h -- the dialog/screen block and the tFEApplication layout of FECheats' type surface (moved
 * verbatim from fecheats_types.h).  fecheats_types.h includes it in place; FEMemcard (NFS4_FECHEATS_DIALOGS_LATE)
 * includes it after its memcard records, where retail FEMemcard.obj has tActiveLine/tShapeInformation/dialogs. */
#ifndef NFS4_FRONTEND_COMMON_FECHEATS_DIALOGS_H
#define NFS4_FRONTEND_COMMON_FECHEATS_DIALOGS_H

#include "shared/tActiveLine.h"
#include "shared/tShapeInformation.h"
#include "fescreen_virtual_types.h"
struct tMenu;
#include "fescreen.h"
#include "fedialog.h"

/* FECheats needs this foreign class's MemCardDialog offset.  Its exact layout
 * is pair-locked by the canonical audit because the linked owner attributes
 * the class definition to FEApp.obj instead of repeating it here. */
struct tFEApplication {
    unsigned int fCurrentMusic;
    tMenu *fCurrentMenu[2];
    tScreen *fCurrentScreen[2];
    tMenu *fTransitionToMenu[2];
    tScreen *fTransitionToScreen[2];
    tMenu *fParentMenu[2];
    tDialogMessageString messagePopup;
    tMenu *backList[2][16];
    int backDepth[2];
    tInputKeyType fLastKeyPressed[2];
    short fYOffset;
    tDialogHelp helpPopup;
    char fPlayer, fInputPlayer;
    bool waitingForOtherPlayer[2];
    tDialogMessageStringWithTimeout MemCardDialog;
    tDialogNoInputMessage NoInputMemCardDialog;
    bool gotName[2], needName[2];
    int speechToPlay[2]; void Redraw(); void UpdateMusic();
};

#endif
