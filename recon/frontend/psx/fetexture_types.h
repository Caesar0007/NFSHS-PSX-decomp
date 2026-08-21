/* fetexture.obj's exact source-visible type graph, reconstructed from the
 * retail SYM.  Keep this owner-local: including nfs4_types.h exposes hundreds
 * of unrelated game declarations that were not present in FETEXTURE.CPP. */
#ifndef NFS4_FRONTEND_PSX_FETEXTURE_TYPES_H
#define NFS4_FRONTEND_PSX_FETEXTURE_TYPES_H

#include "ea_psx_types.h"

struct MATRIX {
    short m[3][3];
    long  t[3];
};

struct DR_MODE {
    u_long tag;
    u_long code[2];
};

struct coorddef {
    int x, y, z;
};
typedef struct coorddef LIBCOORD;

struct matrixtdef {
    int m[9];
};
typedef struct matrixtdef MATRIX3DT;

struct linedef {
    int start, end, colour, thickness;
};
typedef struct linedef LINE;

struct SHAPETABLEENTRY {
    char id[4];
    long offset;
};

struct PCOORD16 {
    short x, y, z, p;
};

struct COORD16 {
    short x, y, z;
};

struct PAD_PSX {
    u_short state;
    u_short unused[2];
};

struct PAD_NEGCON {
    u_char state : 4;
    u_char start : 4;
    u_char buttonAB : 4;
    u_char rightshift : 4;
    u_char twist, buttonI, buttonII, leftshift;
};

struct PAD_ANALOG {
    u_short state;
    u_char rightx, righty, leftx, lefty;
};

struct PAD_MOUSE {
    u_char unused, state;
    char horizontalvalue, verticalvalue;
    u_char unused2[2];
};

struct PAD_COMMON {
    u_char nopad, ID;
    union {
        PAD_PSX standard;
        PAD_NEGCON negcon;
        PAD_MOUSE mouse;
        PAD_ANALOG analog;
    } data;
};

/* The original include graph emits this otherwise-unreferenced anonymous
 * two-byte state cell into fetexture.obj's debug stream. */
struct {
    char bActive, time;
};

struct Draw_tPixMap {
    u_char u0, v0;
    u_short clut;
    u_char u1, v1;
    u_short tpage;
    u_char u2, v2;
    u_short pad2;
    u_char u3, v3;
    u_short flag;
};

struct DRender_tCalcView {
    coorddef translation;
    matrixtdef mrotation;
    coorddef translationInv;
    matrixtdef mrotationInv, mrotationInvRaw;
};

struct Draw_SVertex {
    short vx, vy, vz;
    u_char u, v;
    short dvx, dvy;
    u_char r, g, b, a;
};

struct Draw_PrimStruct {
    u_long *LastPrim;
    char *PrimPtr, *MPrimPtr;
};

struct Draw_tCacheHeader {
    Draw_PrimStruct cprim;
    int mirror;
    short clipW, clipH;
};

struct Draw_CarVertex {
    COORD16 vt;
    char u, v;
};

struct tTexture_ShapeInfo {
    shapetbl *shpptr;
    long clutID;
    char depth;
    u_long type : 8;
    long next : 24;
    short width, height;
    short centerx, centery, shapex, shapey;
    u_short tpage, clut;
};

typedef void *va_list;
typedef int INTFN();
typedef void MVI;
typedef int EACHOOKCALLBACKFUNC();
typedef int arg_t;
typedef int boolean;
typedef int fixed88;
typedef int fixed824;
typedef int fixed248;

#endif
