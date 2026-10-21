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

typedef struct matrixtdef matrixtdef;   /* C alias -- shared/matrixtdef.h owns the tag */

/* trnsfrm.obj's private 3-vector result (transform writes it back through an
 * int* out-param of the same size). */
typedef struct {
    int x, y, z;
} TransformResult;

#endif
