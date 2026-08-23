/* Skidmark.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_SKIDMARK_TYPES_H
#define NFS4_GAME_PSX_SKIDMARK_TYPES_H

#include "../common/color_types.h"

struct POLY_GT4 {
    u_long tag;
    u_char r0, g0, b0, code; short x0, y0; u_char u0, v0; u_short clut;
    u_char r1, g1, b1, p1; short x1, y1; u_char u1, v1; u_short tpage;
    u_char r2, g2, b2, p2; short x2, y2; u_char u2, v2; u_short pad2;
    u_char r3, g3, b3, p3; short x3, y3; u_char u3, v3; u_short pad3;
};

struct DRender_tView {
    int id, player;
    DRender_tCalcView cview;
};

struct Draw_SubdivStruct { Draw_SVertex v[15]; };

struct Track_tArtresource {
    int id;
    char *shapeFile;
    int shapeCount;
    Draw_tPixMap *pPmx;
    int pmxCount, basePmxCount;
};

struct Track_tMaterial { char flag, mipmap_offset; short pmxIndex; };

struct TCB { long status, mode; u_long reg[40]; long system[6]; };
struct EXEC {
    u_long pc0, gp0, t_addr, t_size, d_addr, d_size, b_addr, b_size;
    u_long s_addr, s_size, sp, fp, gp, ret, base;
};
struct DIRENTRY {
    char name[20];
    long attr, size;
    DIRENTRY *next;
    long head;
    char system[4];
};

struct Skidmark_Segment {
    SVECTOR svx[2];
    CVECTOR rgb;
    int type;
    Skidmark_Segment *next;
};

struct tSkid {
    coorddef pt;
    CVECTOR clr;
    int type;
    Skidmark_Segment *nseg;
    int chunk;
};

struct Skidmark_Chunk {
    coorddef cp;
    short n, slice;
    Skidmark_Segment seg[24];
};

struct Draw_tCtrlSkidmark {
    matrixtdef m;
    coorddef t;
    int count;
    Skidmark_Chunk *smp;
};

#endif
