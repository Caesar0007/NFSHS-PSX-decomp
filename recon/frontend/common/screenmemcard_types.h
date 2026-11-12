/* Owner-specific type surface for ScreenMemcard.obj. */
#if !defined(NFS4_FRONTEND_COMMON_SCREENMEMCARD_TYPES_H) || defined(NFS4_SCREENMEMCARD_IN_CLASS_PASS)   /* 2nd entry: the tScreenMemcard class pass (screenmemcard_owner_early.h) */
#define NFS4_FRONTEND_COMMON_SCREENMEMCARD_TYPES_H
#ifndef NFS4_SCREENMEMCARD_IN_CLASS_PASS
#ifndef NFS4_FE_COLOR_LATE   /* The retail owner retains the complete color physics graph and the shared */
#include "../../game/common/color_types.h"   /* ScreenDisplay frontend graph, but not ScreenDisplay's owner class/view. */
#endif
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
#include "shared/POLY_FT4.h"
#endif

#if !defined(NFS4_SCREENMEMCARD_FEAPP_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_TRACKRECORDS_SURFACE)
#if !defined(NFS4_SCREENMEMCARD_MCRD_EXTERNAL) && !defined(NFS4_SCREENMEMCARD_FEDIALOG_ORDER)   /* owner places these itself (screencarselect; FEDialog: after DIRENTRY) */
#include "mcrd_productloc.h"   /* moved verbatim (ScreenMemcard emits it inside its owner_early block) */
#endif
#ifdef NFS4_SCREENMEMCARD_FEDIALOG_ORDER   /* retail FEDialog: tRecordBuffer after the screen graph, before TCB */
#include "mcrd_recordbuffer.h"
#endif


#if !defined(NFS4_SCREENMEMCARD_MCRD_EXTERNAL) && !defined(NFS4_SCREENMEMCARD_MANAGERTASK_EXTERNAL) && !defined(NFS4_SCREENMEMCARD_FEDIALOG_ORDER)   /* owner places it itself (screencarselect) */
#include "mcrd_managertask.h"
#endif



#include "shared/TCB.h"
#include "shared/EXEC.h"
#ifndef NFS4_SCREENMEMCARD_MCRD_EXTERNAL   /* owner places these itself (screencarselect) */
#include "shared/DIRENTRY.h"
#endif
#ifdef NFS4_SCREENMEMCARD_FEDIALOG_ORDER   /* retail FEDialog: PRODUCTLOC, MANAGERTASK right after DIRENTRY */
#include "mcrd_productloc.h"
#include "mcrd_managertask.h"
#endif
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
#if !defined(NFS4_SCREENMEMCARD_MCRD_EXTERNAL) && !defined(NFS4_SCREENMEMCARD_RECBUF_EXTERNAL)   /* owner places it itself (screencarselect) */
#include "mcrd_recordbuffer.h"
#endif


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
    !defined(NFS4_SCREENMEMCARD_TROPHYROOM_SURFACE) && !defined(NFS4_FE3D_TYPES_DONE)
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
#include "fedialog.h"
#include "fedialog.h"
#include "fedialog.h"
#endif
#endif
#if !defined(NFS4_SCREENMEMCARD_FEDIALOG_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_FEAPP_SURFACE) && (defined(NFS4_SCREENMEMCARD_IN_CLASS_PASS) || !defined(NFS4_SCREENMEMCARD_CLASS_DONE))
#include "cls_tScreenMemcard.h"   /* class tScreenMemcard (one definition) */
#define NFS4_SCREENMEMCARD_CLASS_DONE



































#endif
#ifndef NFS4_SCREENMEMCARD_IN_CLASS_PASS
#if !defined(NFS4_SCREENMEMCARD_FEDIALOG_SURFACE) && \
    !defined(NFS4_SCREENMEMCARD_FEAPP_SURFACE)
/* These completed foreign tags are absent from ScreenMemcard.obj.  The owner
 * uses only the priced fields below. */
#include "feapp_class.h"   /* the real tFEApplication (no codegen view; header-truth 4-B.3) */





#include "femenudefs_globalmenudefs.h"   /* the real tGlobalMenuDefs (no codegen view; header-truth 4-B.2) */





struct ScreenMemcard_PrimTagCodegenCarrier {
    u_int addr : 24;
    u_int len : 8;
};
#define tMemcardPrimTag ScreenMemcard_PrimTagCodegenCarrier
#endif

#endif
#endif
