/* root type graph, part 4 of 5 (cut from nfs4_types.h at its order hooks) */
#ifndef NFS4_CORE_4_TAIL_H
#define NFS4_CORE_4_TAIL_H
#ifdef NFS4_CORE_EA   /* nfs2mem: kernpair right after the CD stream; movie: the kernel types, then kernpair, there. */
#ifdef NFS4_CORE_LINEDEF_LATE   /* owner emits pads, linedef, LINE, SHAPETABLEENTRY later itself (FEMenuDefs: frontend/common/femenudefs_core_late.h after tScreen) */
#else
#ifdef NFS4_CORE_PADS_EARLY
/* frontend family (fecars felines fefades fecolor femission fetracks fecheats fememcard femenudefs femenuextended femenuoptions screenpinkslips screentracks): retail emits the controller pads after the CD stream, before linedef. */
#include "shared/PAD_PSX.h"
#include "shared/PAD_NEGCON.h"
#include "shared/PAD_ANALOG.h"
#include "shared/PAD_MOUSE.h"
#include "shared/PAD_COMMON.h"
#endif
#include "shared/linedef.h"
#include "nfs4_core_4_tail_d1.h"
#define NFS4_HAVE_LINE
#include "shared/SHAPETABLEENTRY.h"
#endif
#if defined(NFS4_CORE_FULL) && !defined(NFS4_DRAW_LEAF_CORE_ONLY)   /* CORE_ONLY: draw_leaf_types.h phase 2 emits these */
#include "shared/PCOORD16.h"
#include "shared/COORD16.h"
#ifdef NFS4_CORE_CCOORD16
#include "shared/CCOORD16.h"
#endif
#endif
#endif

/* The retail objects preserve two PsyQ header variants: frontend C++ TUs use
 * u_char, while game/PSX unpack.obj records u_long.  An owner may select the
 * latter without leaking it into already-exact neighbors. */
#ifndef NFS4_EAC_OLD_TYPES
#ifdef NFS4_PSYQ_WCHAR_TYPE
#include "nfs4_core_4_tail_d2.h"
#else
#include "nfs4_core_4_tail_d3.h"
#endif
#else
#include "nfs4_core_4_tail_d4.h"
#endif

#include "nfs4_core_4_tail_d5.h"
#ifndef NFS4_EAC_OLD_TYPES
#include "nfs4_core_4_tail_d6.h"
#endif

#endif
