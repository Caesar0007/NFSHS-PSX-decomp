/* root type graph, part 2 of 5 (cut from nfs4_types.h at its order hooks) */
#ifndef NFS4_CORE_2_SHAPE_H
#define NFS4_CORE_2_SHAPE_H
#ifdef NFS4_CORE_FULL   /* (continued) */
#ifdef NFS4_PRIM_DR_AREA
#include "shared/DR_AREA.h"
#endif
#endif

#include "nfs4_core_2_shape_d3.h"
#ifdef NFS4_CORE_EA
#include "shared/coorddef.h"
#include "nfs4_core_2_shape_d4.h"
#define NFS4_HAVE_LIBCOORD
#if defined(NFS4_CORE_FULL) || defined(NFS4_CORE_MATRIXT)   /* NFS4_CORE_MATRIXT: retail MathNfs/quatern: matrixtdef right after coorddef */
#include "shared/matrixtdef.h"
#include "nfs4_core_2_shape_d5.h"
#define NFS4_HAVE_MATRIX3DT
#endif
#endif
#endif
