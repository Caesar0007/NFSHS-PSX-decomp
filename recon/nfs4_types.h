/* nfs4_types.h -- the shared platform type core.  Retail's SYM records exactly these types in (nearly) every
 * object, in this order: the PsyQ graphics/geometry structs, EA's shape and CD-stream structs, then SYS/TYPES.H
 * and EA's file/thread typedefs (tools/psyq_pipe/tagset_cmp.py --core lists them).  cc1 -g records every struct a
 * translation unit defines, used or not, so ONLY the retail-universal core belongs here; game types stay in their
 * module headers (the old mega nfs4_types.h leaked hundreds of them into every object and was removed). */
#ifndef NFS4_TYPES_H
#define NFS4_TYPES_H
/* The root type graph in five plain parts. The `#include NFS4_CORE_HOOK_*` lines are the remaining order hooks
   (docs/HEADER_TRUTH_PLAN.md, phase 9). */
#include "nfs4_core_0_kernel.h"
#include "nfs4_core_1_gpu.h"
#include "nfs4_core_2_shape.h"
#include "nfs4_core_3_cd.h"
#ifdef NFS4_CORE_HOOK_AFTER_CD   /* a TU's own types right after the CD stream (audiotrk.obj: SND* + scheduler) */
#include NFS4_CORE_HOOK_AFTER_CD
#endif
#include "nfs4_core_4_tail.h"
#endif
