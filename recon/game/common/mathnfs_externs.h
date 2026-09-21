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
/* fixdinv.obj exports ONE function under two names, fixedinverse and rinverse (both 0x800ED3EC).  Retail MathNfs.obj asked for
 * `fixedinverse`: only that name sorts in front of fixedcos in ASPSX's reference records, and retail pulls fixdinv.obj BEFORE
 * fixdsin.obj (tools/psyq_pipe/slink_pullsolve.py --target=fixdinv). */
int fixedinverse(int value);
}

#endif /* MATHNFS_EXTERNS_H */
