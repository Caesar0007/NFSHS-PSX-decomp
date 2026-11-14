/* the minimal common-game surface without the pad records: nfs4_types.h (EA core), coorddef, linedef, SHAPETABLEENTRY */
#ifndef NFS4_GAME_COMMON_MIN_CORE_H
#define NFS4_GAME_COMMON_MIN_CORE_H
#define NFS4_CORE_EA
#include "nfs4_types.h"
#undef NFS4_CORE_EA

#include "shared/coorddef.h"


#ifndef NFS4_HAVE_LIBCOORD
#include "game_common_min_core_d1.h"
#endif

#include "shared/linedef.h"
#if !defined(NFS4_HAVE_LINE) && !defined(NFS4_CORE_LINEDEF_LATE)
#include "game_common_min_core_d2.h"
#endif
#include "shared/SHAPETABLEENTRY.h"
#endif
