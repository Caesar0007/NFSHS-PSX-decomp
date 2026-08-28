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
#endif

#if !defined(NFS4_SCREENMEMCARD_FEDIALOG_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_TOURNSELECT_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_CONTROLLER_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_TRACKRECORDS_SURFACE)
struct AudioMus_tSongEntry {
    char *filename, *title, *artist, *label, *date, *notes;
    int length, index;
    char strbuf[32];
};
#endif

#if !defined(NFS4_SCREENMEMCARD_TOURNSELECT_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_CONTROLLER_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_TROPHYROOM_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_TRACKRECORDS_SURFACE)
struct tRecordBuffer {
    char sName[8];
    int nCar, nTime, nBestLap;
};
typedef tRecordBuffer tSaveRecords[187];
#if !defined(NFS4_SCREENMEMCARD_FEDIALOG_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_FEAPP_SURFACE)
typedef char tMemIcon[15][3][192];
#endif

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
#endif

#if !defined(NFS4_SCREENMEMCARD_FEDIALOG_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_TOURNSELECT_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_TROPHYROOM_SURFACE)
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
#endif

#if !defined(NFS4_SCREENMEMCARD_FEAPP_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_TRACKRECORDS_SURFACE)
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
#endif

#if !defined(NFS4_SCREENMEMCARD_FEDIALOG_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_FEAPP_SURFACE)
struct MCRDFILE_def {
    char *name, *title;
    int size, offset;
    unsigned int flags;
    void *pData;
    shapetbl *icon[3];
    u_char *numicons, *numblocks;
};
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
struct tDrawShapeExtended {
    short flip_axis;
    int tint[4];
    tTexture_ShapeInfo *custom_shapes;
};
#endif

#if !defined(NFS4_SCREENMEMCARD_TROPHYROOM_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_TRACKRECORDS_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_SCREENPOST_SURFACE)
struct tDialogHelp : public tDialogBase {
    short variant;
    char *text[7];
    int cont[7];
    short numItems, helpcontrollers, lefttext;
#ifdef NFS4_SCREENMEMCARD_FEDIALOG_SURFACE
    void AddItem(short, short);
    void CalculateDimensions();
    inline void CalculateDimensionsVirtual() {
        __vtbl_ptr_type (*vf)[10] = _vf;
        (*vf[1][0].pfn)((char *)this + vf[1][0].delta);
    }
    void Draw();
#endif
#ifdef NFS4_SCREENMEMCARD_FEAPP_METHODS
    tDialogHelp();
#endif
};

struct tDialogMessageStringWithTimeout : public tDialogMessageString {
#ifdef NFS4_SCREENMEMCARD_FEAPP_METHODS
    tDialogMessageStringWithTimeout();
#endif
};
struct tDialogNoInputMessage : public tDialogMessageString {
#ifdef NFS4_SCREENMEMCARD_FEDIALOG_SURFACE
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#endif
#ifdef NFS4_SCREENMEMCARD_FEAPP_METHODS
    tDialogNoInputMessage();
#endif
};
#endif

#if !defined(NFS4_SCREENMEMCARD_FEDIALOG_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_FEAPP_SURFACE)
struct tScreenMemcard : public tScreen {
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

    void GetShapeInfo(short &, short &, char **, char **);
    void DrawIcon(shapetbl *, int, int, int, int, short);
    void LoadIcon(int);
    void DrawVerticalLine(short, short, short, short);
    void DrawHorizontalLine(short, short, short, short);
    void PlaceIcons(int, int);
    void DrawMemCardStuff(short);
    void SetEnablings();
    void DrawBackground();
    void DrawForeground();
    tScreenMemcard();
    void ReleaseIcons();
    void Initialize();
    void Cleanup();
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
