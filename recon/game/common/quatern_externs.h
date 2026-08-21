/* quatern_externs.h -- extern decls for game/common/quatern.cpp (NFS4 quaternion math).
 *   Types (tQuat, coorddef, matrixtdef) live in nfs4_types.h. Only the eaclib 16.16
 *   fixed-point helpers are external.
 */
#ifndef QUATERN_EXTERNS_H
#define QUATERN_EXTERNS_H

extern "C" {
int fixeddiv(int numerator, int denominator);
int fixedmult(int a, int b);
int fixedsqrt(int value);
}

#endif
