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

#include "shared/TCB.h"
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
#include "shared/POLY_G3.h"



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
#include "shared/Draw_SubdivStruct.h"
struct Track_tArtresource {
    int id; char *shapeFile; int shapeCount; Draw_tPixMap *pPmx;
    int pmxCount, basePmxCount;
};
struct Track_tMaterial { char flag, mipmap_offset; short pmxIndex; };
#include "shared/Skidmark_Segment.h"


struct Skidmark_Chunk { coorddef cp; short n, slice; Skidmark_Segment seg[24]; };

typedef enum forceFocus_t {
    FOCUS_NORMAL = 0, FOCUS_AI = 1, FOCUS_COPANDAI = 2
} forceFocus_t;

#ifndef NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES
struct FLARE_PIECE_DEF { int distance, size; CVECTOR color; char type; };
#endif
#include "shared/Sched_tSchedule.h"




#include "shared/Draw_tVertex.h"
#include "shared/DRender_tView.h"
#include "shared/Draw_CarCache.h"























#ifndef NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES
#include "shared/DrawC_tEnvMap.h"
#endif

#endif
