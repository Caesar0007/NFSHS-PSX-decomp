/* mdec.obj-owned records layered on the reduced frontend/PSX platform types. */
#ifndef NFS4_FRONTEND_PSX_MDEC_TYPES_H
#define NFS4_FRONTEND_PSX_MDEC_TYPES_H

#include "ea_psx_types.h"

struct MDECSTRUCT {
    int    id, width, height, bpp;
    struct RECT framerect, striprect;
    int    striprectsize;
    u_long *stripbuf, *vlcbuf;
};
#ifndef __cplusplus
typedef struct MDECSTRUCT MDECSTRUCT;
#endif

typedef u_short DECDCTTAB[34816];

#endif
