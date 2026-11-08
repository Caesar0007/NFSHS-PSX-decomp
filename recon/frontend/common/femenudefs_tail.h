/* femenudefs_tail.h -- moved from femenudefs_types.h (FEMenuDefs/Front owner surface): FE3d, Force_tGlobal, AudioMus,
 * MCRDFILE, tScreenMemcard, tScreenUserName (front retail order; mission records: femenudefs_mission.h).  FEMenuDefs includes it right after the
 * tournament standings (NFS4_SCREENCARSELECT_HOOK_AFTER_STANDINGS); femenudefs_types.h includes it in place (no-op then). */
#ifndef NFS4_FRONTEND_COMMON_FEMENUDEFS_TAIL_H
#define NFS4_FRONTEND_COMMON_FEMENUDEFS_TAIL_H


typedef COORD16 FE3d_zVertex;
typedef CVECTOR FE3d_zColor;
typedef SVECTOR FE3d_zNormal;

#include "shared/FE3d_zUV.h"
#include "shared/FE3d_zFacet.h"
#include "shared/FE3d_zObj.h"
#include "shared/Force_tGlobal.h"
#include "shared/AudioMus_tSongEntry.h"
#include "shared/AudioMus_tSongList.h"


#include "shared/MCRDFILE_def.h"


typedef MCRDFILE_def MCRDFILE;

typedef short tArrowLocation[6];
typedef short tTextLocation[5];


struct tScreenMemcard : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void DrawForeground();
    void Initialize();
    void Cleanup();
    int theNFS4icon, card;
    CARDINFO_def *pCI;
    char fMemTitle[15][32];
    char goticon[15];
    u_char numicon[15], numblock[15];
    MCRDFILE_def fMemFile[15];
    u_short fMemIconClutId[15];
    short fFadeIcon[15];
    bool fReadyToGetNewIcons, fInitedMemCard;
    char fMemCardMessage[40];
    int fMemCardMessageTextSys, message;
    short memcardanimframe, count, cursorPosition;
    int checkingstart;
    bool fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons;
    int fScreenFadeReadyTick;
    short player;
    bool fGetNewIcons;
#ifdef NFS4_FRONT_SURFACE
    tScreenMemcard();
#endif
    inline void SetMessage(int newMessage) { message = newMessage; }
};

struct tScreenUserName : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void Initialize();
    tOptionsMenu *callingMenu;
    short fTextFade;
    bool fInTransition;
    char fRowList[10][9];
#ifdef NFS4_FRONT_SURFACE
    /* implicit ctor (retail declares none: no body block in SYM) */
#endif
    inline void SetCallingMenu(tOptionsMenu *m) { callingMenu = m; }
};
#endif
