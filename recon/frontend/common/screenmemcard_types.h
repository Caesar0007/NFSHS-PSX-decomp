/* Owner-specific type surface for ScreenMemcard.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENMEMCARD_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENMEMCARD_TYPES_H

/* The retail owner retains the complete color physics graph and the shared
 * ScreenDisplay frontend graph, but not ScreenDisplay's owner class/view. */
#include "../../game/common/color_types.h"
#define NFS4_SCREENDISPLAY_NO_OWNER_RECORDS
#define NFS4_SCREENDISPLAY_SCREENMEMCARD_METHODS
#include "screendisplay_types.h"
#undef NFS4_SCREENDISPLAY_SCREENMEMCARD_METHODS
#undef NFS4_SCREENDISPLAY_NO_OWNER_RECORDS

/* ScreenMemcard retains the input-key enum without the foreign player enum.
 * ScreenTrackRecords.obj retains neither input enum. */
#ifndef NFS4_SCREENMEMCARD_TRACKRECORDS_SURFACE
#define NFS4_FE_INPUT_NO_PLAYER
#include "fe_input_enums.h"
#undef NFS4_FE_INPUT_NO_PLAYER
#endif

#define MIN(a,b) (((a) > (b)) ? (b) : (a))
#define MAX(a,b) (((a) > (b)) ? (a) : (b))

/* Scratchpad render cursors are address macros, not object globals. */
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

#if !defined(NFS4_SCREENMEMCARD_FEDIALOG_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_FEAPP_SURFACE)
struct POLY_FT4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char u0, v0;
    u_short clut;
    short x1, y1;
    u_char u1, v1;
    u_short tpage;
    short x2, y2;
    u_char u2, v2;
    u_short pad1;
    short x3, y3;
    u_char u3, v3;
    u_short pad2;
};
#endif

#if !defined(NFS4_SCREENMEMCARD_FEAPP_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_TRACKRECORDS_SURFACE)
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

#include "shared/TCB.h"





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
#endif

#if !defined(NFS4_SCREENMEMCARD_FEDIALOG_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_TOURNSELECT_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_CONTROLLER_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_TRACKRECORDS_SURFACE)
#include "shared/AudioMus_tSongEntry.h"




#endif

#if !defined(NFS4_SCREENMEMCARD_TOURNSELECT_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_CONTROLLER_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_TROPHYROOM_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_TRACKRECORDS_SURFACE)
#include "shared/tRecordBuffer.h"



typedef tRecordBuffer tSaveRecords[187];
#if !defined(NFS4_SCREENMEMCARD_FEDIALOG_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_FEAPP_SURFACE)
typedef char tMemIcon[15][3][192];
#endif

#include "shared/tSaveCarInfo.h"




#include "shared/tSaveTrackInfo.h"



#include "shared/tSaveTournament.h"






#endif

#if !defined(NFS4_SCREENMEMCARD_FEDIALOG_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_TOURNSELECT_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_TROPHYROOM_SURFACE)
typedef COORD16 FE3d_zVertex;
typedef CVECTOR FE3d_zColor;
typedef SVECTOR FE3d_zNormal;

#include "shared/FE3d_zUV.h"



#include "shared/FE3d_zFacet.h"






#include "shared/FE3d_zObj.h"







#endif

#if !defined(NFS4_SCREENMEMCARD_FEAPP_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_TRACKRECORDS_SURFACE)
#include "shared/CARDINFO_def.h"




#include "shared/MCRDFILEHEADER_def.h"








#include "shared/MCRDFILEINFO_def.h"









#endif

#if !defined(NFS4_SCREENMEMCARD_FEDIALOG_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_FEAPP_SURFACE)
#include "shared/MCRDFILE_def.h"







#endif

#ifndef NFS4_SCREENMEMCARD_FEAPP_SURFACE
typedef CARDINFO_def CARDINFO;
typedef MCRDFILEHEADER_def MCRDFILEHEADER;
typedef MCRDFILEINFO_def MCRDFILEINFO;
#endif
#if !defined(NFS4_SCREENMEMCARD_FEDIALOG_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_FEAPP_SURFACE)
typedef MCRDFILE_def MCRDFILE;
#endif

#if !defined(NFS4_SCREENMEMCARD_FEDIALOG_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_PINKSLIPS_SURFACE)
#include "shared/tDrawShapeExtended.h"




#endif

#if !defined(NFS4_SCREENMEMCARD_TROPHYROOM_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_TRACKRECORDS_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_SCREENPOST_SURFACE)
#include "fedialog_class_help.h"

#include "fedialog_timeout_class.h"   /* own header: scopes the interface/implementation pragmas to this class */
#include "fedialog_class_noinput.h"
#endif

#if !defined(NFS4_SCREENMEMCARD_FEDIALOG_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_FEAPP_SURFACE)
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

    void DrawIcon(shapetbl *, int, int, int, int, short);
    void LoadIcon(int);
    void DrawVerticalLine(short, short, short, short);
    void DrawHorizontalLine(short, short, short, short);
    void PlaceIcons(int, int);
    void DrawMemCardStuff(short);
    void SetEnablings();
    tScreenMemcard();
    void ReleaseIcons();
};
#endif

#if !defined(NFS4_SCREENMEMCARD_FEDIALOG_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_FEAPP_SURFACE)
/* These completed foreign tags are absent from ScreenMemcard.obj.  The owner
 * uses only the priced fields below. */
struct ScreenMemcard_FEApplicationCodegenView {
    char _beforeInputPlayer[557];
    char fInputPlayer;
};
#define tFEApplication ScreenMemcard_FEApplicationCodegenView

struct ScreenMemcard_GlobalMenuDefsCodegenView {
    char _beforeItemSaveGame[0x3054];
    tMemoryCardMenuItem itemSaveGame, itemLoadGame;
};
#define tGlobalMenuDefs ScreenMemcard_GlobalMenuDefsCodegenView

struct ScreenMemcard_PrimTagCodegenCarrier {
    u_int addr : 24;
    u_int len : 8;
};
#define tMemcardPrimTag ScreenMemcard_PrimTagCodegenCarrier
#endif

#endif
