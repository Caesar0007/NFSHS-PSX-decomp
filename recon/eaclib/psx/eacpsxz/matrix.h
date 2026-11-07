#ifndef _MATRIX_H_
#define _MATRIX_H_

#include "eac_types.h"

/* internals -> matrix_private.h (library sources only; no retail game object records them) */




extern int identitymatrix[9];

extern int *addmatrix(int *m1, int *m2, int *out);   /* @0x800F01FC */
extern int *submatrix(int *m1, int *m2, int *out);   /* @0x800F0234 */
extern int *scalematrix(int *m, int scalar, int *out);   /* @0x800F026C */
extern int reorthogonalize(int *M);   /* @0x800F02E4 */

#endif
