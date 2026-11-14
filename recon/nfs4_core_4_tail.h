/* root type graph, part 4 of 5 (cut from nfs4_types.h at its order hooks) */
#ifndef NFS4_CORE_4_TAIL_H
#define NFS4_CORE_4_TAIL_H
#ifndef NFS4_PSYQ_DDV_TYPES   /* (continued) */
#ifdef NFS4_CORE_EA   /* nfs2mem: kernpair right after the CD stream; movie: the kernel types, then kernpair, there. */
#ifdef NFS4_CORE_KERNEL_KERN_AFTER_CD
#include "frontend/psx/movie_cd_early.h"   /* movie.obj (the only owner of this key): CdlLOC/CdlFILE first */
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#endif
#if defined(NFS4_CORE_KERN_AFTER_CD) || defined(NFS4_CORE_KERNEL_KERN_AFTER_CD)
#include "shared/kernpair.h"
#endif
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
typedef struct linedef LINE;
#define NFS4_HAVE_LINE
#include "shared/SHAPETABLEENTRY.h"
#endif
#ifdef NFS4_CORE_AFTER_SHAPETABLE   /* retail PSXFront: eacelement CdlLOC kernpair charactertbl */
#include "shared/core_after_shapetable.h"
#endif
#if defined(NFS4_CORE_FULL) && !defined(NFS4_DRAW_LEAF_CORE_ONLY)   /* CORE_ONLY: draw_leaf_types.h phase 2 emits these */
#include "shared/PCOORD16.h"
#include "shared/COORD16.h"
#ifdef NFS4_CORE_CCOORD16
#include "shared/CCOORD16.h"
#endif
#endif
#endif
#endif /* NFS4_PSYQ_DDV_TYPES */

/* The retail objects preserve two PsyQ header variants: frontend C++ TUs use
 * u_char, while game/PSX unpack.obj records u_long.  An owner may select the
 * latter without leaking it into already-exact neighbors. */
#ifndef NFS4_PSYQ_DDV_TYPES
#ifndef NFS4_EAC_OLD_TYPES
#ifdef NFS4_PSYQ_WCHAR_TYPE
typedef NFS4_PSYQ_WCHAR_TYPE wchar_t;
#else
typedef u_char wchar_t;
#endif
#else
typedef unsigned char *MEMBLOCK;
#endif

typedef void (*VOIDFN)();
#ifndef NFS4_EAC_OLD_TYPES
typedef int FILEOP;
typedef void FILE_CALLBACK();
typedef int FILE_ATOM();
typedef void THREADPROC();
typedef void THREAD2PROC();
typedef int SYSTEMTASK();
typedef int THREAD;
#endif
#endif /* NFS4_PSYQ_DDV_TYPES */

#endif
