#ifndef COMMON_H
#define COMMON_H

/*
 * Master include for every src/*.c translation unit (splat emits
 * `#include "common.h"` at the top of each generated C file).
 *
 * As decompilation progresses this will grow to pull in the real game
 * headers (structs, globals, PsyQ SDK decls). For now it provides the
 * type aliases and the INCLUDE_ASM machinery so the asm-only build links.
 */

#include "decomp/types.h"
#include "decomp/include_asm.h"

#endif /* COMMON_H */
