/* eaclib/psx/eacpsxz/matrix.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\matrix.obj (EACPSXZ.LIB).  4 fns: addmatrix@0x800F01FC,
 *   submatrix@0x800F0234, scalematrix@0x800F026C, reorthogonalize@0x800F02E4.
 *   FULL reconstruction (disasm-v3 MIPS); NOT stubs.  3x3 matrices = 9 ints (16.16), row-major.
 *
 *   add/sub = element-wise; scalematrix = element-wise fixedmult by a scalar.  reorthogonalize
 *   does 4 iterations of a *weak* per-frame drift cleaner: A = M^T M - I ; acc = I + c1 A + c2 A^2 +
 *   c3 A^3 ; M = M * acc (matmul = transmult/trnsmult.obj).  The coefficient table @0x80123810 holds
 *   c[k] = (1/4)(-1)^k C(2k,k)/4^k = the (1/4)(I+A)^(-1/2) binomial weights {0.25,-0.125,0.09375,
 *   -0.078125,...}; the asm starts acc=I and uses only c[1..3] (skips c[0]) -> a quarter-strength
 *   (M^TM)^(-1/2) correction, ~3x orthonormality-error reduction/call on small drift.  Not a one-shot
 *   orthonormalizer; meant to be called every frame on matrices that only drift slightly.
 *   HOST-VERIFIED (_test_matrix.cpp): trnsmult exact + alias-safe; reorthogonalize 3.3x cleanup, det->1.
 */
extern int  fixedmult(int a, int b);                         /* eacpsxz @0x800E4328 */
extern void transpose(int *src, int *dst);                  /* eacpsxz @0x800E4358 (trnspos) */
extern int *transmult(int *a, int *b, int *out);            /* eacpsxz @0x80105F40 (trnsmult.obj) C=A*B */
#define multiplymatrix transmult                                /* reorthogonalize's matmul callee */
/* @0x801237EC (16.16 identity, shared rodata; byte-exact from NFS4.EXE). matrix.obj is the owner;
 * other TUs (e.g. trnsmult, reorthogonalize callers) reference it extern. */
extern const int identitymatrix[9] = { 65536,0,0, 0,65536,0, 0,0,65536 };

extern int *addmatrix(int *m1, int *m2, int *out)   /* @0x800F01FC */
{
    int i;
    for (i = 0; i < 9; i++) out[i] = m1[i] + m2[i];
    return out;
}

extern int *submatrix(int *m1, int *m2, int *out)   /* @0x800F0234 */
{
    int i;
    for (i = 0; i < 9; i++) out[i] = m1[i] - m2[i];
    return out;
}

extern int *scalematrix(int *m, int scalar, int *out)   /* @0x800F026C */
{
    int i;
    for (i = 0; i < 9; i++) out[i] = fixedmult(m[i], scalar);
    return out;
}

/* 36-byte matrix as a STRUCT: the oracle's 4-word/iter copy loops (+1-word tail, end-ptr
 * compare vs base+0x20) are gcc's movstrsi block-move expansion of STRUCT ASSIGNMENTS --
 * per-element copy loops do NOT emit this shape. */
typedef struct { int m[9]; } mtx;

static const int coef[4] = { 16384, -8192, 6144, -5120 };   /* @0x80123810 (coef[0] unused) */

extern int reorthogonalize(int *M)   /* @0x800F02E4 */
{
    /* MATCH (197->7; residual = ONE scheduling divergence at the S=mt copy-tail/scalematrix-call boundary -- ours interleaves the coef load into the tail's load-delay, oracle leaves the nop -- same unscheduled-oracle class as trnsmult): FIVE stack buffers only, decl order = stack order (mtm@sp+0x10,
     * mt@0x38, A@0x60, S@0x88, acc@0xB0); tmp REUSES mt, tmp2 REUSES mtm, mcopy REUSES mt;
     * struct-assigns for every 9-word copy; coef accessed by INDEX coef[k] (the giv reduces
     * to s0=coef+4 walking +4 -- a pointer variable stays un-reduced); NO explicit return
     * ($v0 after the last transmult is incidental -- oracle writes no v0). */
    mtx mtm, mt, A, S, acc;
    register int it, k;
    for (it = 0; it < 4; it++) {
        transpose(M, mt.m);                            /* mt  = M^T            */
        multiplymatrix(mt.m, M, mtm.m);                /* mtm = M^T M          */
        submatrix(mtm.m, (int *)identitymatrix, A.m);  /* A   = M^T M - I      */
        S = *(mtx *)identitymatrix;
        acc = *(mtx *)identitymatrix;
        for (k = 1; k < 4; k++) {
            multiplymatrix(S.m, A.m, mt.m);            /* mt(tmp) = S * A      */
            S = mt;
            scalematrix(S.m, coef[k], mtm.m);          /* mtm(tmp2) = coef[k] * S^k */
            addmatrix(acc.m, mtm.m, acc.m);            /* acc += tmp2          */
        }
        mt = *(mtx *)M;                                /* mcopy reuses mt      */
        multiplymatrix(mt.m, acc.m, M);                /* M = M * series       */
    }
}
