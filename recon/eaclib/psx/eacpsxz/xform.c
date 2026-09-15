/* eaclib/psx/eacpsxz/xform.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\xform.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col10)
 *   1 fn: xformy@0x800E5AC4 (fixedxformx/y/z @0x800EABAC.. are fxform.obj -> fxform.c).
 *   FULL reconstruction of the actual code (disasm-v3 MIPS); NOT stubs/thunks. C-linkage XDEFs.
 *
 *   Each writes a 3x3 (matrixtdef = int m[9], 16.16 fixed) rotation about one axis.  The angle
 *   is resolved to (sin,cos) by intsincos (integer-degree table, xformy) or fixedsincos (fixed
 *   angle, the fixed* family).  Layouts decoded verbatim from the per-element stores:
 *     X:  [ 1  0  0 ; 0  c  s ; 0 -s  c ]
 *     Y:  [ c  0 -s ; 0  1  0 ; s  0  c ]
 *     Z:  [ c  s  0 ;-s  c  0 ; 0  0  1 ]
 */
#include "../eaclib_types.h"
#include "eac_types.h"
#include "xform.h"
#include "isincos.h"
#include "fsincos.h"

// FIXME

/* xformy @0x800E5AC4 : Y-axis rotation (integer angle). */
void xformy(matrixtdef *out, int angle)
{
    int s;
    int c;

    intsincos(angle, &s, &c);
    /* index out->m[] directly (NOT via an `int *m=out->m` hoist): the hoist makes
     * gcc-2.8.0 reload `c` from the stack for the 2nd use; direct indexing keeps
     * c/s live in registers across both stores, matching the oracle (lever #1). */
    out->m[0] = c;  out->m[1] = 0;        out->m[2] = -s;
    out->m[3] = 0;  out->m[4] = 0x10000;  out->m[5] = 0;
    out->m[6] = s;  out->m[7] = 0;        out->m[8] = c;
}

/* fixedxformx/y/z (0x800EABAC..0x800EACD8) belong to fxform.obj -> fxform.c;
 * xform.obj owns only xformy. */
