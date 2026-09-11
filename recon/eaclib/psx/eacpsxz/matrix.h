#ifndef _MATRIX_H_
#define _MATRIX_H_

#include "eac_types.h"

/* 36-byte matrix as a STRUCT: the oracle's 4-word/iter copy loops (+1-word tail, end-ptr
 * compare vs base+0x20) are gcc's movstrsi block-move expansion of STRUCT ASSIGNMENTS --
 * per-element copy loops do NOT emit this shape. */
typedef struct { int m[9]; } mtx;

extern const int identitymatrix[9];

extern int *addmatrix(int *m1, int *m2, int *out);   /* @0x800F01FC */
extern int *submatrix(int *m1, int *m2, int *out);   /* @0x800F0234 */
extern int *scalematrix(int *m, int scalar, int *out);   /* @0x800F026C */
extern int reorthogonalize(int *M);   /* @0x800F02E4 */

#endif
