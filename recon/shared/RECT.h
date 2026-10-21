/* RECT -- the one definition of the PsyQ graphics rectangle, shared by the platform
   type core (nfs4_types.h) and the eaclib library headers (eaclib/psx/eacpsxz/eac_types.h).
   Same pattern as shared/matrixtdef.h: every former copy includes this file at the
   place the copy used to stand, so a translation unit can pull in the game and the
   library headers in either order. */
#ifndef NFS4_SHARED_RECT_H
#define NFS4_SHARED_RECT_H

struct RECT {
    short x, y, w, h;
};
#ifndef __cplusplus
typedef struct RECT RECT;
#endif

#endif
