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
#define NFS4_TYPES_H   /* this object lists the root type graph itself (retail record order) */
#include "nfs4_core_0_kernel.h"
#include "nfs4_core_1_gpu.h"
#include "nfs4_core_2_shape.h"
#include "game/psx/font_before_cd.h"   /* own types at this point */
#include "nfs4_core_3_cd.h"
#include "nfs4_core_4_tail.h"
#include "nfs4_types.h"
#undef NFS4_CORE_FULL

#include "shared/MATRIX.h"



/* MATRIX: typedef-name already declared (anonymous PsyQ form) */
/* VECTOR: typedef-name already declared (anonymous PsyQ form) */
/* SVECTOR: typedef-name already declared (anonymous PsyQ form) */
/* CVECTOR: typedef-name already declared (anonymous PsyQ form) */
/* DVECTOR: typedef-name already declared (anonymous PsyQ form) */
/* RVECTOR: typedef-name already declared (anonymous PsyQ form) */
/* CRVECTOR3: typedef-name already declared (anonymous PsyQ form) */
/* CRVECTOR4: typedef-name already declared (anonymous PsyQ form) */
/* RECT: typedef-name already declared (anonymous PsyQ form) */
/* DR_ENV: typedef-name already declared (anonymous PsyQ form) */
/* DRAWENV: typedef-name already declared (anonymous PsyQ form) */
/* DISPENV: typedef-name already declared (anonymous PsyQ form) */

#include "shared/SPRT.h"







/* SPRT: typedef-name already declared (anonymous PsyQ form) */

#include "shared/DR_MODE.h"



/* DR_MODE: typedef-name already declared (anonymous PsyQ form) */
typedef struct shapetbl shapetbl;

#include "shared/coorddef.h"


/* (no C re-typedef of coorddef: in C++ it records a 2nd TPDEF coorddef; retail font.obj has one) */
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
