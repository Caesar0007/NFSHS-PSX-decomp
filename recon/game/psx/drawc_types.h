/* DrawC.obj's exact source-visible type surface reconstructed from SYM.
 * psxcontroller.obj is an exact 86-record subset; the records below are
 * precisely the 19-name delta retained by the standalone DrawC owner. */
#ifndef NFS4_GAME_PSX_DRAWC_TYPES_H
#define NFS4_GAME_PSX_DRAWC_TYPES_H

#define NFS4_GMESETUP_OMIT_INPUT_DEVICE_CALL
#include "psxcontroller_types.h"
#undef NFS4_GMESETUP_OMIT_INPUT_DEVICE_CALL

#define Render_gPacketPtr  (*(u_char **)0x1F800004)

typedef int CarLogic_tObservations[1][3];
typedef u_char Night_tLightingTable[256][16];
typedef u_char Night_tWeatherLightingTable[256];
typedef u_char Night_tCopLightingTable[256][8];

struct TCB { long status, mode; u_long reg[40]; long system[6]; };
struct EXEC {
    u_long pc0, gp0, t_addr, t_size, d_addr, d_size, b_addr, b_size;
    u_long s_addr, s_size, sp, fp, gp, ret, base;
};
struct DIRENTRY {
    char name[20]; long attr, size; DIRENTRY *next; long head; char system[4];
};

#ifndef NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES
struct POLY_FT3 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char u0,v0; u_short clut;
    short x1,y1; u_char u1,v1; u_short tpage; short x2,y2; u_char u2,v2;
    u_short pad1;
};
struct POLY_FT4 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char u0,v0; u_short clut;
    short x1,y1; u_char u1,v1; u_short tpage; short x2,y2; u_char u2,v2;
    u_short pad1; short x3,y3; u_char u3,v3; u_short pad2;
};
struct POLY_G3 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char r1,g1,b1,pad1;
    short x1,y1; u_char r2,g2,b2,pad2; short x2,y2;
};
#endif
struct POLY_GT4 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char u0,v0; u_short clut;
    u_char r1,g1,b1,p1; short x1,y1; u_char u1,v1; u_short tpage;
    u_char r2,g2,b2,p2; short x2,y2; u_char u2,v2; u_short pad2;
    u_char r3,g3,b3,p3; short x3,y3; u_char u3,v3; u_short pad3;
};

#ifndef NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES
struct BW_tContext {
    int client; BWorldSm_Pos slicePos;
    int currentChunk, chunkFarZClipSq, polyFarZClipSq, lowDetailDistSq;
    int lineFarZClipSq;
};
#endif
struct Draw_SubdivStruct { Draw_SVertex v[15]; };
struct Track_tArtresource {
    int id; char *shapeFile; int shapeCount; Draw_tPixMap *pPmx;
    int pmxCount, basePmxCount;
};
struct Track_tMaterial { char flag, mipmap_offset; short pmxIndex; };
struct Skidmark_Segment {
    SVECTOR svx[2]; CVECTOR rgb; int type; Skidmark_Segment *next;
};
struct Skidmark_Chunk { coorddef cp; short n, slice; Skidmark_Segment seg[24]; };

typedef enum forceFocus_t {
    FOCUS_NORMAL = 0, FOCUS_AI = 1, FOCUS_COPANDAI = 2
} forceFocus_t;

#ifndef NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES
struct FLARE_PIECE_DEF { int distance, size; CVECTOR color; char type; };
#endif
struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

struct Draw_tVertex { PCOORD16 sv; };
struct DRender_tView { int id, player; DRender_tCalcView cview; };
struct Draw_CarCache {
    Draw_tCacheHeader head;
    MATRIX matB;
    int pad;
    u_long *sub_ot;
    int otz, sub_otz, bfct;
    DR_MODE drawModeOn, drawModeOff;
    Draw_tPixMap *pmxStart;
    Draw_tPixMap ePmx0, ePmx1;
    int eAddZ, sub_otSize;
    long color, eColor0, eColor1, eColor2;
    VECTOR tv;
    COORD16 vt0; u_char u0, v0;
    COORD16 vt1; u_char u1, v1;
    COORD16 vt2; u_char u2, v2;
    short dvx0, dvy0, dvx1, dvy1, dvx2, dvy2;
    Draw_CarVertex tV[96];
    COORD16 vt3; u_char u3, v3;
    COORD16 vt4; u_char u4, v4;
    COORD16 vt5; u_char u5, v5;
    COORD16 vt6; u_char offsetU0, offsetV0;
    COORD16 vt7; u_char offsetU1, offsetV1;
    COORD16 vt8; u_char offsetU2, offsetV2;
};
#ifndef NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES
struct DrawC_tEnvMap { short slice, tex, extra; };
#endif

#endif
