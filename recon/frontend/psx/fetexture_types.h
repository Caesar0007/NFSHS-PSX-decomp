/* fetexture.obj's exact source-visible type graph, reconstructed from the
 * retail SYM.  Keep this owner-local: including nfs4_types.h exposes hundreds
 * of unrelated game declarations that were not present in FETEXTURE.CPP. */
#ifndef NFS4_FRONTEND_PSX_FETEXTURE_TYPES_H
#define NFS4_FRONTEND_PSX_FETEXTURE_TYPES_H

#include "nfs4_types.h"

#include "shared/MATRIX.h"




#include "shared/DR_MODE.h"




#include "shared/coorddef.h"


typedef struct coorddef LIBCOORD;

#include "shared/matrixtdef.h"


typedef struct matrixtdef MATRIX3DT;

#include "shared/linedef.h"


typedef struct linedef LINE;

#include "shared/SHAPETABLEENTRY.h"




#include "shared/PCOORD16.h"



#include "shared/COORD16.h"



#include "shared/PAD_PSX.h"




#include "shared/PAD_NEGCON.h"







#include "shared/PAD_ANALOG.h"




#include "shared/PAD_MOUSE.h"





#include "shared/PAD_COMMON.h"









/* The original include graph emits this otherwise-unreferenced anonymous
 * two-byte state cell into fetexture.obj's debug stream. */
struct {
    char bActive, time;
};

#include "shared/Draw_tPixMap.h"










#include "shared/DRender_tCalcView.h"






#include "shared/Draw_SVertex.h"






#include "shared/Draw_PrimStruct.h"




#include "shared/Draw_tCacheHeader.h"





#include "shared/Draw_CarVertex.h"




#include "shared/tTexture_ShapeInfo.h"










typedef void *va_list;
typedef int INTFN();
typedef void MVI;
typedef int EACHOOKCALLBACKFUNC();
typedef int arg_t;
typedef int boolean;
typedef int fixed88;
typedef int fixed824;
typedef int fixed248;

#endif
