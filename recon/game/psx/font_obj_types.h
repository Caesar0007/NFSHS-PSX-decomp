/* font.obj's exact source-visible type surface, reconstructed from the retail
 * SYM.  Keep this owner-local: the old nfs4_types.h include leaked hundreds of
 * unrelated game declarations into FONT.CPP's full-debug stream. */
#ifndef NFS4_GAME_PSX_FONT_OBJ_TYPES_H
#define NFS4_GAME_PSX_FONT_OBJ_TYPES_H

#include "shared/kernpair.h"




typedef struct kernpair kernpair;
typedef struct kernpair KERN;

#include "shared/charactertbl.h"





typedef struct charactertbl charactertbl;
typedef struct charactertbl FONTFILECHAR;
/* font.obj repeats this semantic through a second owner-visible header. */
typedef struct charactertbl charactertbl;

/* PsyQ SYS/TYPES.H, LIBGTE.H, and LIBGPU.H declarations retained by font.obj. */
#define NFS4_CORE_FULL   /* retail font.obj: MATRIX first, SPRT + DR_MODE right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_SPRT
#include "nfs4_types.h"
#undef NFS4_CORE_FULL

#include "shared/MATRIX.h"



typedef struct MATRIX MATRIX;
typedef struct VECTOR VECTOR;
typedef struct SVECTOR SVECTOR;
typedef struct CVECTOR CVECTOR;
typedef struct DVECTOR DVECTOR;
typedef struct RVECTOR RVECTOR;
typedef struct CRVECTOR3 CRVECTOR3;
typedef struct CRVECTOR4 CRVECTOR4;
typedef struct RECT RECT;
typedef struct DR_ENV DR_ENV;
typedef struct DRAWENV DRAWENV;
typedef struct DISPENV DISPENV;

#include "shared/SPRT.h"







typedef struct SPRT SPRT;

#include "shared/DR_MODE.h"



typedef struct DR_MODE DR_MODE;
typedef struct shapetbl shapetbl;

#include "shared/coorddef.h"


typedef struct coorddef coorddef;
typedef struct coorddef LIBCOORD;

#include "shared/matrixtdef.h"


typedef struct matrixtdef matrixtdef;
typedef struct matrixtdef MATRIX3DT;
typedef struct cdstreamstruct cdstreamstruct;

#include "shared/linedef.h"


typedef struct linedef linedef;
typedef struct linedef LINE;

#include "shared/SHAPETABLEENTRY.h"



typedef struct SHAPETABLEENTRY SHAPETABLEENTRY;

#include "shared/PCOORD16.h"




#include "shared/COORD16.h"




#include "shared/PAD_PSX.h"



typedef struct PAD_PSX PAD_PSX;

#include "shared/PAD_NEGCON.h"






typedef struct PAD_NEGCON PAD_NEGCON;

#include "shared/PAD_ANALOG.h"



typedef struct PAD_ANALOG PAD_ANALOG;

#include "shared/PAD_MOUSE.h"




typedef struct PAD_MOUSE PAD_MOUSE;

#include "shared/PAD_COMMON.h"








typedef struct PAD_COMMON PAD_COMMON;

/* The include graph emits this otherwise-unreferenced two-byte state cell. */
struct {
    char bActive, time;
};

#include "shared/Draw_tPixMap.h"











#include "shared/DRender_tCalcView.h"







#include "shared/Draw_SVertex.h"







#include "shared/Draw_PrimStruct.h"





#include "shared/Draw_tCacheHeader.h"






#include "shared/Draw_CarVertex.h"





struct cluttbl {
    unsigned int type : 8;
    int next : 24;
    short width, height, centerx, centery, shapex, shapey;
    short data[16];
};
typedef struct cluttbl cluttbl;

typedef void *va_list;
typedef int INTFN();
typedef void MVI;
typedef int EACHOOKCALLBACKFUNC();
typedef int arg_t;
typedef int boolean;
typedef int fixed88;
typedef int fixed824;
typedef int fixed248;

typedef void (*fontblit)(int, int, void *, int, int, charactertbl *, int);
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif
