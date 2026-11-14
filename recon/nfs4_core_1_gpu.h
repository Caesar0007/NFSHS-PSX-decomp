/* root type graph, part 1 of 5 (cut from nfs4_types.h at its order hooks) */
#ifndef NFS4_CORE_1_GPU_H
#define NFS4_CORE_1_GPU_H
#ifdef NFS4_CORE_PADS_KERNEL_FIRST
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#endif
#ifdef NFS4_CORE_FULL
#include "shared/MATRIX.h"
#endif
#include "nfs4_core_1_gpu_d1.h"




#include "shared/RECT.h"

#include "nfs4_core_1_gpu_d2.h"




/* NFS4_PSYQ_DDV_TYPES: the graphics-primitive subset seen by Ddvfont.obj (retail SYM block: VECTOR..DR_ENV and
 * SYS/TYPES only -- no DRAWENV/DISPENV/shapetbl, no CD stream, no wchar_t/VOIDFN/file/thread typedefs). */
#ifndef NFS4_PSYQ_DDV_TYPES
#include "nfs4_core_1_gpu_d3.h"



#ifdef NFS4_CORE_FULL
/* retail: the owner's libgpu.h primitives right after DISPENV, in libgpu.h order (NFS4_PRIM_* from the owner's first header) */
#ifdef NFS4_PRIM_POLY_F3
#include "nfs4_core_1_gpu_d4.h"
#endif
#ifdef NFS4_PRIM_POLY_F4
#include "shared/POLY_F4.h"
#endif
#ifdef NFS4_PRIM_POLY_FT3
#include "nfs4_core_1_gpu_d5.h"
#endif
#ifdef NFS4_PRIM_POLY_FT4
#include "shared/POLY_FT4.h"
#endif
#ifdef NFS4_PRIM_POLY_G3
#include "shared/POLY_G3.h"
#endif
#ifdef NFS4_PRIM_POLY_G4
#include "shared/POLY_G4.h"
#endif
#ifdef NFS4_PRIM_POLY_GT3
#include "nfs4_core_1_gpu_d6.h"
#endif
#ifdef NFS4_CORE_POLY_GT4   /* headers that include shared/POLY_GT4.h: retail emits POLY_GT4 right after DISPENV in every object that records it */
#include "shared/POLY_GT4.h"
#endif
#ifdef NFS4_PRIM_LINE_G2
#include "shared/LINE_G2.h"
#endif
#ifdef NFS4_PRIM_SPRT
#include "shared/SPRT.h"
#endif
#ifdef NFS4_PRIM_TILE_1
#include "nfs4_core_1_gpu_d7.h"
#endif
#include "shared/DR_MODE.h"
#endif   /* (block continues in the next part) */
#endif   /* (block continues in the next part) */
#endif
