/* the minimal common-game surface without the pad records: nfs4_types.h (EA core), coorddef, linedef, SHAPETABLEENTRY */
#ifndef NFS4_GAME_COMMON_MIN_CORE_H
#define NFS4_GAME_COMMON_MIN_CORE_H
#define NFS4_CORE_EA
#include "nfs4_types.h"
#undef NFS4_CORE_EA

#include "shared/coorddef.h"


#ifndef NFS4_HAVE_LIBCOORD
typedef struct coorddef LIBCOORD;
#endif

#ifndef NFS4_CORE_LINEDEF_LATE   /* else: the owner emits linedef, LINE, SHAPETABLEENTRY later (nfs4_types.h key; FEMenuDefs) */
#include "shared/linedef.h"
#endif
#if !defined(NFS4_HAVE_LINE) && !defined(NFS4_CORE_LINEDEF_LATE)
typedef struct linedef LINE;
#endif
#ifndef NFS4_CORE_LINEDEF_LATE
#include "shared/SHAPETABLEENTRY.h"
#endif
#endif
