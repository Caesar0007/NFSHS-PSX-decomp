/* root type graph, part 2 of 5 (cut from nfs4_types.h at its order hooks) */
#ifndef NFS4_CORE_2_SHAPE_H
#define NFS4_CORE_2_SHAPE_H
#ifndef NFS4_PSYQ_DDV_TYPES   /* (continued) */
#ifdef NFS4_CORE_FULL   /* (continued) */
#ifdef NFS4_PRIM_DR_TWIN
typedef struct { u_long tag, code[2]; } DR_TWIN;
#endif
#ifdef NFS4_PRIM_DR_STP
typedef struct { u_long tag; u_long code[2]; } DR_STP;
#endif
#ifdef NFS4_PRIM_DR_AREA
#include "shared/DR_AREA.h"
#endif
#ifdef NFS4_PRIM_DR_OFFSET
#include "shared/DR_OFFSET.h"
#endif
#endif

struct shapetbl {
    unsigned int type : 8;
    int          next : 24;
    short        width, height, centerx, centery;
    int          shapex : 12;
    unsigned int reserved : 1;
    unsigned int twiddled : 1;
    unsigned int transposed : 1;
    unsigned int rotated : 1;
    int          shapey : 12;
    unsigned int mipmaps : 4;
    char         data;
};
typedef struct shapetbl SHAPE;
#ifdef NFS4_CORE_EA
#include "shared/coorddef.h"
typedef struct coorddef LIBCOORD;
#define NFS4_HAVE_LIBCOORD
#if defined(NFS4_CORE_FULL) || defined(NFS4_CORE_MATRIXT)   /* NFS4_CORE_MATRIXT: retail MathNfs/quatern: matrixtdef right after coorddef */
#include "shared/matrixtdef.h"
typedef struct matrixtdef MATRIX3DT;
#define NFS4_HAVE_MATRIX3DT
#endif
#endif
#endif   /* (block continues in the next part) */
#endif
