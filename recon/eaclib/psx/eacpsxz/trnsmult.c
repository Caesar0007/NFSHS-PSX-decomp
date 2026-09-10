/* Reconstructed from nfs4-f.exe: 3x3 fixed-point matrix multiply C = A * B.
 * The stack result makes the operation safe when out aliases either input. */
#include "../eaclib_types.h"
#include "eac_types.h"
#include "trnsmult.h"
#include "fixdmult.h"
#include "blkmov.h"

/* PASS 81/81. Function-scope row carriers remain live across fixedmult calls,
 * reproducing retail allocation with the source-accurate three-pointer ABI. */
void transmult(int *a, int *b, int *out) /* @0x80105F40 */
{
    int temp[9];
    int i, i1, i2;

    for (i = 0, i2 = 2 * sizeof(int), i1 = sizeof(int); i < 9; i2 += 3 * sizeof(int), i1 += 3 * sizeof(int), i += 3) {
        int *c0, *c1;
        int j, j1, j2;

        c0 = (int *)((char *)a + i1);
        c1 = (int *)((char *)a + i2);

        for (j = 0, j2 = 6 * sizeof(int), j1 = 3 * sizeof(int); j < 3; j2 += sizeof(int), j1 += sizeof(int), j++) {
            int acc;

            acc = fixedmult(a[i], b[j]);
            acc += fixedmult(*c0, *(int *)((char *)b + j1));
            acc += fixedmult(*c1, *(int *)((char *)b + j2));
            temp[i + j] = acc;
        }
    }

    blockmove(temp, out, 9 * sizeof(int));
}
