/* mathnfs_externs.h -- cross-TU decls for game/common/mathnfs.cpp (NFS4 fixed-point/vector math lib).
 *   Types (coorddef, matrixtdef) live in nfs4_types.h. mathnfs is a leaf math TU: only eaclib
 *   fixed-point primitives are external; all Math_* are intra-TU (forward-declared in the .cpp). */
#ifndef MATHNFS_EXTERNS_H
#define MATHNFS_EXTERNS_H

/* ---- eaclib EACPSXZ fixed-point primitives ---- */
extern "C" {
int fixedcos(int angle);
int fixeddiv(int numerator, int denominator);
int fixedmult(int a, int b);
int fixedsin(int angle);
int fixedsqrt(int value);
int rinverse(int value);
}

#endif /* MATHNFS_EXTERNS_H */
