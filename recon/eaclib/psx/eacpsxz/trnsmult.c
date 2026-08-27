/* Reconstructed from nfs4-f.exe: 3x3 fixed-point matrix multiply C = A * B.
 * The stack result makes the operation safe when out aliases either input. */
extern int fixedmult(int a, int b);                    /* eacpsxz @0x800E4328 */
extern void blockmove(void *src, void *dst, int n);    /* eacpsxz @0x800E62DC */

/* PASS 81/81. Function-scope row carriers remain live across fixedmult calls,
 * reproducing retail allocation with the source-accurate three-pointer ABI. */
extern void transmult(int *a, int *b, int *out) /* @0x80105F40 */
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

#if 0
/* Reserve: also PASS 81/81, but less source-accurate. It relies on ABI-compatible
 * by-value pointer aggregates and an argument-home reload identity. */
typedef union transmult_pointer_cell {
    int *pointer;
    unsigned int word;
} transmult_pointer_cell;

typedef struct transmult_pointer_args {
    int *right;
    int *out;
} transmult_pointer_args;

extern int *transmult(transmult_pointer_cell left, transmult_pointer_args args)
{
    register int *aw = left.pointer;
    int temp[9];
    int *pa[2];
    register int i, j;
    register int i2, i1;
    register int j2, j1;
    register int acc;
    register int *bw;
    register int *base;

    i = 0;
    i2 = 8;
    i1 = 4;
    for (; i < 9; i += 3) {
        j = 0;
        j2 = 24;
        j1 = 12;
        {
            base = ((transmult_pointer_cell *)((char *)&args - 4))->pointer;
            base = (int *)((char *)base + i1);
            pa[0] = base;
            bw = args.right;
            {
                unsigned int x = left.word;
                unsigned int y = (unsigned int)((transmult_pointer_cell *)
                                                  ((char *)&args - 4))->pointer;

                base = (int *)(x ^ (x ^ y));
            }
            base = (int *)((char *)base + i2);
            pa[1] = base;
        }
        for (; j < 3; j++) {
            int av;
            int bv;

            acc = fixedmult(aw[i], *bw);
            bw++;
            base = pa[0];
            av = *base;
            base = args.right;
            bv = *(int *)((char *)base + j1);
            acc += fixedmult(av, bv);
            base = pa[1];
            av = *base;
            base = args.right;
            bv = *(int *)((char *)base + j2);
            acc += fixedmult(av, bv);
            temp[i + j] = acc;
            j1 += 4;
            j2 += 4;
        }
        i2 += 12;
        i1 += 12;
    }
    blockmove(temp, args.out, 0x24);
}
#endif
