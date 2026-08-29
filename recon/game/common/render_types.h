/* render.obj's exact source-visible extension of the shared night graph. */
#ifndef NFS4_GAME_COMMON_RENDER_TYPES_H
#define NFS4_GAME_COMMON_RENDER_TYPES_H

#define NFS4_NIGHT_OMIT_PRIVATE_TYPES
#include "../psx/night_types.h"
#undef NFS4_NIGHT_OMIT_PRIVATE_TYPES

#define gScratchLastWord (*(int *)0x1F8003FC)

struct BW_tContext {
    int client;
    BWorldSm_Pos slicePos;
    int currentChunk, chunkFarZClipSq, polyFarZClipSq;
    int lowDetailDistSq, lineFarZClipSq;
};

struct SceneElem {
    int type, size, committed, visible;
    coorddef cp;
    int height;
    matrixtdef orient;
    int subType, subTypeIndex, scalar1, scalar2, scalar3, scalar4;
};

struct SceneSortedElem { int slice_; SceneElem *se; };

struct FLARE_PIECE_DEF { int distance, size; CVECTOR color; char type; };

struct kernpair {
    u_short previouscode, code;
    char kernvalue;
    char pad[3];
};

struct AudioMus_tSongEntry {
    char *filename, *title, *artist, *label, *date, *notes;
    int length, index;
    char strbuf[32];
};

struct tTexture_ShapeInfo {
    shapetbl *shpptr;
    long clutID;
    char depth;
    u_long type : 8;
    long next : 24;
    signed short width, height;
    short centerx, centery, shapex, shapey;
    u_short tpage, clut;
};

struct POLY_F4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0, x1, y1, x2, y2, x3, y3;
};

struct POLY_FT4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char u0, v0;
    u_short clut;
    short x1, y1;
    u_char u1, v1;
    u_short tpage;
    short x2, y2;
    u_char u2, v2;
    u_short pad1;
    short x3, y3;
    u_char u3, v3;
    u_short pad2;
};

struct DR_STP { u_long tag; u_long code[2]; };

/* Foreign completed tags absent from render.obj's linked type graph. */
struct Render_DFlipCodegenView { DISPENV disp; char *server; };

struct Render_FlareCodegenView {
    DVECTOR pos[2], oldpos[2];
    u_short screenData[2][5][5];
    int size;
    FLARE_PIECE_DEF *piece;
    char isDrawn[2];
};

typedef int Input_tDeviceCall();
typedef kernpair KERN;
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif
