/* root type graph, part 0 of 5 (cut from nfs4_types.h at its order hooks) */
#ifndef NFS4_CORE_0_KERNEL_H
#define NFS4_CORE_0_KERNEL_H
/* PsyQ SYS/TYPES.H.  The SYM retains physadr's tag and referent size while
 * filtering the private `_physadr` tag block itself. */
#include "nfs4_core_0_kernel_d1.h"
#include "shared/u_long.h"
#include "nfs4_core_0_kernel_d2.h"
#ifdef NFS4_CORE_FEMISSION_FIRST   /* retail FEMission.obj: mission records ahead of the core */
#include "frontend/common/femission_first.h"
#endif
/* The SDK's complete referent in every owner: retail records physadr at
 * size 4 everywhere.  Its `_physadr` tag records are not in the SYM because
 * PSYLINK drops '_'-prefixed type records (an incomplete-tag variant for
 * three frontend owners was removed 2026-11-07: it gave physadr size 0). */
#include "nfs4_core_0_kernel_d3.h"
#if defined(NFS4_CORE_SPCH_FIRST) || defined(NFS4_CORE_SND_FIRST)   /* speech.obj / audiocmn.obj first-header structs ahead of the core (shared/spchnfs_first.h) */
#include "shared/spchnfs_first.h"
#endif

#include "nfs4_core_0_kernel_d4.h"

/* Retail declaration order (round 11 TYPEONLY): a TU whose first include is the common-game graph
 * (game_common_min_types.h: NFS4_CORE_EA) or the draw-leaf graph (draw_leaf_types.h: NFS4_CORE_FULL) sees the
 * EA/PsyQ leaf types at their place in the original headers -- MATRIX before VECTOR, DR_MODE after DISPENV,
 * coorddef/matrixtdef before the CD stream, linedef/SHAPETABLEENTRY/PCOORD16/COORD16 after it.  The units are
 * include-guarded, so including them here only moves them earlier; the NFS4_HAVE_* flags keep each companion
 * typedef single. */
/* Objects whose first header is the kernel and/or controller-pad graph (retail SYM: TCB EXEC DIRENTRY and/or PAD_PSX..PAD_COMMON ahead of MATRIX/VECTOR), one macro defined by the owner's first header: NFS4_CORE_KERNEL_FIRST, NFS4_CORE_PADS_FIRST, NFS4_CORE_KERNEL_PADS_FIRST, NFS4_CORE_PADS_KERNEL_FIRST. */
#if defined(NFS4_CORE_KERNEL_FIRST) || defined(NFS4_CORE_KERNEL_PADS_FIRST)
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#endif
#if defined(NFS4_CORE_PADS_FIRST) || defined(NFS4_CORE_KERNEL_PADS_FIRST) || defined(NFS4_CORE_PADS_KERNEL_FIRST)
#include "shared/PAD_PSX.h"
#include "shared/PAD_NEGCON.h"
#include "shared/PAD_ANALOG.h"
#include "shared/PAD_MOUSE.h"
#include "shared/PAD_COMMON.h"
#endif
#endif
