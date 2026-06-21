/* eaclib/psx/eacpsxz/trnspos.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\trnspos.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col10)
 *   1 fn @0x800E4358 (172 bytes): `transpose` -- 3x3 (matrixtdef = int m[9], 36 B) transpose.
 *   C-linkage symbol in the binary (SYM lists plain `transpose`) -> extern "C".
 *
 *   dst = src^T. Two paths (mirrors the MIPS branch at 0x800E4358 `if(src!=dst)`):
 *     - src == dst : in-place; swap the 3 off-diagonal pairs (diagonal m[0]/m[4]/m[8] untouched)
 *                    [1]<->[3], [2]<->[6], [5]<->[7]                       @0x800E4358
 *     - src != dst : out-of-place full transpose copy dst[i*3+j] = src[j*3+i]  @0x800E4398
 *   Decoded verbatim from disasm-v3 (m[] index = byte-offset/4). Behavior-faithful; @VA breadcrumb.
 *   Callers resolve to the plain `transpose` symbol via the central extern "C" lib/libfns.h.
 */
#include "../../../nfs4_types.h"

extern "C" void transpose(matrixtdef *src, matrixtdef *dst)   /* @0x800E4358 */
{
    int *s = src->m;
    int *d = dst->m;
    if (src == dst) {                       /* @0x800E4358 in-place */
        int t;
        t = d[1]; d[1] = d[3]; d[3] = t;    /* off 4 <-> 12 */
        t = d[2]; d[2] = d[6]; d[6] = t;    /* off 8 <-> 24 */
        t = d[5]; d[5] = d[7]; d[7] = t;    /* off 20 <-> 28 */
    } else {                                /* @0x800E4398 out-of-place: dst = src^T */
        d[0] = s[0]; d[1] = s[3]; d[2] = s[6];
        d[3] = s[1]; d[4] = s[4]; d[5] = s[7];
        d[6] = s[2]; d[7] = s[5]; d[8] = s[8];
    }
}
