/* Canonical PsyQ LIBGPU.H ordering-table primitive tag and access macros.
 * The tag is `struct _P_TAG` (user ruling 2026-11-07): retail records no P_TAG
 * type in any object and PSYLINK drops '_'-named type records; P_TAG stays a
 * record-free macro spelling of it for the existing casts. */
#ifndef NFS4_GAME_PSX_PSYQ_PRIM_MACROS_H
#define NFS4_GAME_PSX_PSYQ_PRIM_MACROS_H

struct _P_TAG {
    unsigned addr : 24;
    unsigned len : 8;
    u_char r0, g0, b0, code;
};
#define P_TAG struct _P_TAG
#define setaddr(p,_addr) (((struct _P_TAG *)(p))->addr = (u_long)(_addr))
#define getaddr(p)       ((u_long)(((struct _P_TAG *)(p))->addr))
#define addPrim(ot, p)   (setaddr((p), getaddr(ot)), setaddr((ot), (p)))
/* PsyQ 4.3 LIBGPU.H: prepend a primitive chain, first p0 through last p1.
 * Kept as a macro so both tag stores belong to the call-site SLD statement. */
#define addPrims(ot, p0, p1) (setaddr((p1), getaddr(ot)), setaddr((ot), (p0)))

#endif
