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
    int *m = out->m;
    m[0] = c;  m[1] = 0;        m[2] = -s;
    m[3] = 0;  m[4] = 0x10000;  m[5] = 0;
    m[6] = s;  m[7] = 0;        m[8] = c;
}

/* fixedxformx @0x800EABAC : X-axis rotation (fixed angle). */
extern "C" void fixedxformx(matrixtdef *out, int angle)
{
    int s, c;
    fixedsincos(angle, &s, &c);
    int *m = out->m;
    m[0] = 0x10000;  m[1] = 0;   m[2] = 0;
    m[3] = 0;        m[4] = c;   m[5] = s;
    m[6] = 0;        m[7] = -s;  m[8] = c;
}

/* fixedxformy @0x800EAC10 : Y-axis rotation (fixed angle). */
extern "C" void fixedxformy(matrixtdef *out, int angle)
{
    int s, c;
    fixedsincos(angle, &s, &c);
    int *m = out->m;
    m[0] = c;  m[1] = 0;        m[2] = -s;
    m[3] = 0;  m[4] = 0x10000;  m[5] = 0;
    m[6] = s;  m[7] = 0;        m[8] = c;
}

/* fixedxformz @0x800EAC74 : Z-axis rotation (fixed angle). */
extern "C" void fixedxformz(matrixtdef *out, int angle)
{
    int s, c;
    fixedsincos(angle, &s, &c);
    int *m = out->m;
    m[0] = c;   m[1] = s;  m[2] = 0;
    m[3] = -s;  m[4] = c;  m[5] = 0;
    m[6] = 0;   m[7] = 0;  m[8] = 0x10000;
}
