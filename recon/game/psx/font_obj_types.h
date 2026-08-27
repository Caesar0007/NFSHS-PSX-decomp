/* font.obj's exact source-visible type surface, reconstructed from the retail
 * SYM.  Keep this owner-local: the old nfs4_types.h include leaked hundreds of
 * unrelated game declarations into FONT.CPP's full-debug stream. */
#ifndef NFS4_GAME_PSX_FONT_OBJ_TYPES_H
#define NFS4_GAME_PSX_FONT_OBJ_TYPES_H

struct kernpair {
    unsigned short previouscode, code;
    char kernvalue;
    char pad[3];
};
typedef struct kernpair kernpair;
typedef struct kernpair KERN;

struct charactertbl {
    unsigned char index[2];
    unsigned char width, height;
    unsigned char u[2], v[2];
    char advance, xoffset, yoffset;
};
typedef struct charactertbl charactertbl;
typedef struct charactertbl FONTFILECHAR;
/* font.obj repeats this semantic through a second owner-visible header. */
typedef struct charactertbl charactertbl;

/* PsyQ SYS/TYPES.H, LIBGTE.H, and LIBGPU.H declarations retained by font.obj. */
#include "../../frontend/psx/ea_psx_types.h"

struct MATRIX {
    short m[3][3];
    long t[3];
};
typedef struct MATRIX MATRIX;
typedef struct VECTOR VECTOR;
typedef struct SVECTOR SVECTOR;
typedef struct CVECTOR CVECTOR;
typedef struct DVECTOR DVECTOR;
typedef struct RVECTOR RVECTOR;
typedef struct CRVECTOR3 CRVECTOR3;
typedef struct CRVECTOR4 CRVECTOR4;
typedef struct RECT RECT;
typedef struct DR_ENV DR_ENV;
typedef struct DRAWENV DRAWENV;
typedef struct DISPENV DISPENV;

struct SPRT {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char u0, v0;
    u_short clut;
    short w, h;
};
typedef struct SPRT SPRT;

struct DR_MODE {
    u_long tag;
    u_long code[2];
};
typedef struct DR_MODE DR_MODE;
typedef struct shapetbl shapetbl;

struct coorddef {
    int x, y, z;
};
typedef struct coorddef coorddef;
typedef struct coorddef LIBCOORD;

struct matrixtdef {
    int m[9];
};
typedef struct matrixtdef matrixtdef;
typedef struct matrixtdef MATRIX3DT;
typedef struct cdstreamstruct cdstreamstruct;

struct linedef {
    int start, end, colour, thickness;
};
typedef struct linedef linedef;
typedef struct linedef LINE;

struct SHAPETABLEENTRY {
    char id[4];
    long offset;
};
typedef struct SHAPETABLEENTRY SHAPETABLEENTRY;

struct PCOORD16 {
    short x, y, z, p;
};
typedef struct PCOORD16 PCOORD16;

struct COORD16 {
    short x, y, z;
};
typedef struct COORD16 COORD16;

struct PAD_PSX {
    u_short state;
    u_short unused[2];
};
typedef struct PAD_PSX PAD_PSX;

struct PAD_NEGCON {
    u_char state : 4;
    u_char start : 4;
    u_char buttonAB : 4;
    u_char rightshift : 4;
    u_char twist, buttonI, buttonII, leftshift;
};
typedef struct PAD_NEGCON PAD_NEGCON;

struct PAD_ANALOG {
    u_short state;
    u_char rightx, righty, leftx, lefty;
};
typedef struct PAD_ANALOG PAD_ANALOG;

struct PAD_MOUSE {
    u_char unused, state;
    char horizontalvalue, verticalvalue;
    u_char unused2[2];
};
typedef struct PAD_MOUSE PAD_MOUSE;

struct PAD_COMMON {
    u_char nopad, ID;
    union {
        PAD_PSX standard;
        PAD_NEGCON negcon;
        PAD_MOUSE mouse;
        PAD_ANALOG analog;
    } data;
};
typedef struct PAD_COMMON PAD_COMMON;

/* The include graph emits this otherwise-unreferenced two-byte state cell. */
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
typedef struct Draw_tPixMap Draw_tPixMap;

struct DRender_tCalcView {
    coorddef translation;
    matrixtdef mrotation;
    coorddef translationInv;
    matrixtdef mrotationInv, mrotationInvRaw;
};
typedef struct DRender_tCalcView DRender_tCalcView;

struct Draw_SVertex {
    short vx, vy, vz;
    u_char u, v;
    short dvx, dvy;
    u_char r, g, b, a;
};
typedef struct Draw_SVertex Draw_SVertex;

struct Draw_PrimStruct {
    u_long *LastPrim;
    char *PrimPtr, *MPrimPtr;
};
typedef struct Draw_PrimStruct Draw_PrimStruct;

struct Draw_tCacheHeader {
    Draw_PrimStruct cprim;
    int mirror;
    short clipW, clipH;
};
typedef struct Draw_tCacheHeader Draw_tCacheHeader;

struct Draw_CarVertex {
    COORD16 vt;
    char u, v;
};
typedef struct Draw_CarVertex Draw_CarVertex;

struct cluttbl {
    unsigned int type : 8;
    int next : 24;
    short width, height, centerx, centery, shapex, shapey;
    short data[16];
};
typedef struct cluttbl cluttbl;

typedef void *va_list;
typedef int INTFN();
typedef void MVI;
typedef int EACHOOKCALLBACKFUNC();
typedef int arg_t;
typedef int boolean;
typedef int fixed88;
typedef int fixed824;
typedef int fixed248;

typedef void (*fontblit)(int, int, void *, int, int, charactertbl *, int);
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif
