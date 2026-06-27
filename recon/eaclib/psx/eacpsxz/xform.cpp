/* eaclib/psx/eacpsxz/xform.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\xform.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col10)
 *   4 fns (non-contiguous text): xformy@0x800E5AC4, fixedxformx@0x800EABAC,
 *   fixedxformy@0x800EAC10, fixedxformz@0x800EAC74. Single-axis rotation-matrix builders.
 *   FULL reconstruction of the actual code (disasm-v3 MIPS); NOT stubs/thunks. C-linkage XDEFs.
 *
 *   Each writes a 3x3 (matrixtdef = int m[9], 16.16 fixed) rotation about one axis.  The angle
 *   is resolved to (sin,cos) by intsincos (integer-degree table, xformy) or fixedsincos (fixed
 *   angle, the fixed* family).  Layouts decoded verbatim from the per-element stores:
 *     X:  [ 1  0  0 ; 0  c  s ; 0 -s  c ]
 *     Y:  [ c  0 -s ; 0  1  0 ; s  0  c ]
 *     Z:  [ c  s  0 ;-s  c  0 ; 0  0  1 ]
 */
#include "../../../nfs4_types.h"

extern "C" void intsincos  (int angle, int *psin, int *pcos);   /* @0x800EADBC (integer angle) */
extern "C" void fixedsincos(int angle, int *psin, int *pcos);   /* @0x800F3670 (fixed angle)   */

/* xformy @0x800E5AC4 : Y-axis rotation (integer angle). */
extern "C" void xformy(matrixtdef *out, int angle)
{
    int s, c;
    intsincos(angle, &s, &c);
    /* index out->m[] directly (NOT via an `int *m=out->m` hoist): the hoist makes
     * gcc-2.8.0 reload `c` from the stack for the 2nd use; direct indexing keeps
     * c/s live in registers across both stores, matching the oracle (lever #1). */
    out->m[0] = c;  out->m[1] = 0;        out->m[2] = -s;
    out->m[3] = 0;  out->m[4] = 0x10000;  out->m[5] = 0;
    out->m[6] = s;  out->m[7] = 0;        out->m[8] = c;
}

/* fixedxformx @0x800EABAC : X-axis rotation (fixed angle). */
extern "C" void fixedxformx(matrixtdef *out, int angle)
{
    int s, c;
    fixedsincos(angle, &s, &c);
    /* direct out->m[] index (no `int *m` hoist) -- keeps c/s register-live (lever #1) */
    out->m[0] = 0x10000;  out->m[1] = 0;   out->m[2] = 0;
    out->m[3] = 0;        out->m[4] = c;   out->m[5] = s;
    out->m[6] = 0;        out->m[7] = -s;  out->m[8] = c;
}

/* fixedxformy @0x800EAC10 : Y-axis rotation (fixed angle). */
extern "C" void fixedxformy(matrixtdef *out, int angle)
{
    int s, c;
    fixedsincos(angle, &s, &c);
    /* direct out->m[] index (no `int *m` hoist) -- keeps c/s register-live (lever #1) */
    out->m[0] = c;  out->m[1] = 0;        out->m[2] = -s;
    out->m[3] = 0;  out->m[4] = 0x10000;  out->m[5] = 0;
    out->m[6] = s;  out->m[7] = 0;        out->m[8] = c;
}

/* fixedxformz @0x800EAC74 : Z-axis rotation (fixed angle). */
extern "C" void fixedxformz(matrixtdef *out, int angle)
{
    int s, c;
    fixedsincos(angle, &s, &c);
    /* direct out->m[] index (no `int *m` hoist) -- keeps c/s register-live (lever #1) */
    out->m[0] = c;   out->m[1] = s;  out->m[2] = 0;
    out->m[3] = -s;  out->m[4] = c;  out->m[5] = 0;
    out->m[6] = 0;   out->m[7] = 0;  out->m[8] = 0x10000;
}
