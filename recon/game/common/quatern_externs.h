/* quatern_externs.h -- extern decls for game/common/quatern.cpp (NFS4 quaternion math).
 *   Types (tQuat, coorddef, matrixtdef) live in nfs4_types.h. Only the eaclib 16.16
 *   fixed-point helpers are external.
 */
#ifndef QUATERN_EXTERNS_H
#define QUATERN_EXTERNS_H

/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/fixddiv.h"
#include "eaclib/psx/eacpsxz/fixdmult.h"
#include "eaclib/psx/eacpsxz/fixdsqrt.h"
}
extern "C" {
}

#endif
