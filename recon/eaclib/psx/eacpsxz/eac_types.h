#ifndef _EAC_TYPES_H_
#define _EAC_TYPES_H_

typedef unsigned long u_long;
typedef struct { short x, y, w, h; } RECT;

typedef struct {
    int x, y, z;
} TransformResult;

/* local C-lane mirror of nfs4_types.h matrixtdef (pad.c precedent) */
typedef struct matrixtdef { int m[9]; } matrixtdef;

#endif
