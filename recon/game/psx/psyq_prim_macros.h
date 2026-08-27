/* Canonical PsyQ LIBGPU.H ordering-table primitive tag and access macros.
 * P_TAG is an SDK macro carrier: retail game objects retain the primitive
 * structures used as variables, but not this cast-only typedef in their SYM
 * type graphs. */
#ifndef NFS4_GAME_PSX_PSYQ_PRIM_MACROS_H
#define NFS4_GAME_PSX_PSYQ_PRIM_MACROS_H

typedef struct {
    unsigned addr : 24;
    unsigned len : 8;
    u_char r0, g0, b0, code;
} P_TAG;

#define setaddr(p, _addr) (((P_TAG *)(p))->addr = (u_long)(_addr))
#define getaddr(p)       ((u_long)(((P_TAG *)(p))->addr))
#define addPrim(ot, p)   (setaddr((p), getaddr(ot)), setaddr((ot), (p)))

#endif
