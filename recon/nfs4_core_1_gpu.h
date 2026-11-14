/* root type graph, part 1 of 5 (cut from nfs4_types.h at its order hooks) */
#ifndef NFS4_CORE_1_GPU_H
#define NFS4_CORE_1_GPU_H
#ifdef NFS4_CORE_FULL
#include "shared/MATRIX.h"
#endif
#include "nfs4_core_1_gpu_d1.h"




#include "shared/RECT.h"

#include "nfs4_core_1_gpu_d2.h"




/* NFS4_PSYQ_DDV_TYPES: the graphics-primitive subset seen by Ddvfont.obj (retail SYM block: VECTOR..DR_ENV and
 * SYS/TYPES only -- no DRAWENV/DISPENV/shapetbl, no CD stream, no wchar_t/VOIDFN/file/thread typedefs). */
#include "nfs4_core_1_gpu_d3.h"



#ifdef NFS4_CORE_FULL
/* retail: the owner's libgpu.h primitives right after DISPENV, in libgpu.h order (NFS4_PRIM_* from the owner's first header) */
#ifdef NFS4_PRIM_POLY_F4
#include "shared/POLY_F4.h"
#endif
#ifdef NFS4_PRIM_POLY_FT4
#include "shared/POLY_FT4.h"
#endif
#ifdef NFS4_PRIM_POLY_G4
#include "shared/POLY_G4.h"
#endif
#ifdef NFS4_CORE_POLY_GT4   /* headers that include shared/POLY_GT4.h: retail emits POLY_GT4 right after DISPENV in every object that records it */
#include "shared/POLY_GT4.h"
#endif
#include "shared/DR_MODE.h"
#endif   /* (block continues in the next part) */
#endif
