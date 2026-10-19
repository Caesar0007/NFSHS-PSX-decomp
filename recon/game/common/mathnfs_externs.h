/* mathnfs_externs.h -- cross-TU decls for game/common/mathnfs.cpp (NFS4 fixed-point/vector math lib).
 *   Types (coorddef, matrixtdef) live in nfs4_types.h. mathnfs is a leaf math TU: only eaclib
 *   fixed-point primitives are external; all Math_* are intra-TU (forward-declared in the .cpp). */
#ifndef MATHNFS_EXTERNS_H
#define MATHNFS_EXTERNS_H

/* ---- eaclib EACPSXZ fixed-point primitives ---- */
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/fixddiv.h"
#include "eaclib/psx/eacpsxz/fixdinv.h"
#include "eaclib/psx/eacpsxz/fixdmult.h"
#include "eaclib/psx/eacpsxz/fixdsin.h"
#include "eaclib/psx/eacpsxz/fixdsqrt.h"
}
extern "C" {
/* fixdinv.obj exports ONE function under two names, fixedinverse and rinverse (both 0x800ED3EC).  Retail MathNfs.obj asked for
 * `fixedinverse`: only that name sorts in front of fixedcos in ASPSX's reference records, and retail pulls fixdinv.obj BEFORE
 * fixdsin.obj (tools/psyq_pipe/slink_pullsolve.py --target=fixdinv). */
}

#endif /* MATHNFS_EXTERNS_H */
