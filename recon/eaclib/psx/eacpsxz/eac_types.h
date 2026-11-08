/* eac_types.h -- EACPSXZ's view of the platform types.
 *
 * The library was compiled against the same PsyQ/SDK types as the game, so the
 * one definition of each lives in shared/ (nfs4_types.h includes the same files):
 * a translation unit may pull in the game headers and the eaclib headers in
 * either order and always ends up with a single definition.
 */
#ifndef _EAC_TYPES_H_
#define _EAC_TYPES_H_

#include "../../../shared/u_long.h"
#include "../../../shared/RECT.h"
#include "../../../shared/matrixtdef.h"

#if !defined(__cplusplus) || defined(NFS4_EAC_MATRIXTDEF_CXX_ALIAS)   /* C alias; in C++ the tag already names the type and a re-typedef records a 2nd TPDEF (kept only where the TU defines the key) */
typedef struct matrixtdef matrixtdef;   /* C alias -- shared/matrixtdef.h owns the tag */
#endif

/* internals -> trnsfrm_private.h (library sources only; no retail game object records them) */



#endif
