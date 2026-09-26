/* anim.obj's exact source-visible type surface. */
#ifndef NFS4_GAME_COMMON_ANIM_TYPES_H
#define NFS4_GAME_COMMON_ANIM_TYPES_H

#include "draw_leaf_types.h"
#include "schedule_types.h"

struct POLY_GT4 {
    u_long tag;
    u_char r0, g0, b0, code; short x0, y0; u_char u0, v0; u_short clut;
    u_char r1, g1, b1, p1; short x1, y1; u_char u1, v1; u_short tpage;
    u_char r2, g2, b2, p2; short x2, y2; u_char u2, v2; u_short pad2;
    u_char r3, g3, b3, p3; short x3, y3; u_char u3, v3; u_short pad3;
};

struct CCOORD16 { short x, y, z, light; };

#include "shared/tQuat.h"
typedef struct tQuat Quatern_quat;

struct Group {
    int m_num_elements;
    inline void *GetData() { return this + 1; }
    inline int GetNumElements() { return m_num_elements; }
};

#include "shared/Draw_SubdivStruct.h"

#include "shared/Trk_AnimateInst.h"





#include "shared/Trk_AnimateBoomInst.h"







#include "shared/Trk_Quad.h"
struct Trk_NewStrip { u_char topVert, botVert; char quadCount, size; };
#include "shared/Trk_NewSimQuad.h"
struct RelCoord16 { short x, z; };

struct Track_tArtresource {
    int id;
    char *shapeFile;
    int shapeCount;
    Draw_tPixMap *pPmx;
    int pmxCount, basePmxCount;
};

struct Track_tMaterial { char flag, mipmap_offset; short pmxIndex; };

#include "shared/tSaveSurface.h"




struct Anim_tFrame {
    long x, y, z;
    short qx, qy, qz, qw;
};

struct AnimScript {
    int baseTicks, baseFrame, flags, numParts;
    Trk_AnimateInst **inst;

    AnimScript(int num);
    AnimScript(int num, int numParts);
    AnimScript(Group *instanceGroup, int type, int boomIndex, int numParts);
    /* Inline in the original class: its expansion is the exact retail delete
       sequence in Anim_Restart and Anim_FreeHandle; no out-of-line dtor exists. */
    ~AnimScript() { delete [] inst; }
    void SetAnimAttrib(int flags);
    void GetAnimFrameInfo(int *frame, int *numFrames);
    int GetTimedAnimPosRot(coorddef *pt, matrixtdef *mat);
    int GetTimedAnimPosRot(int index, coorddef *pt, matrixtdef *mat);
    int GetStatus();
};

#include "shared/TCB.h"
struct EXEC {
    u_long pc0, gp0, t_addr, t_size, d_addr, d_size, b_addr, b_size;
    u_long s_addr, s_size, sp, fp, gp, ret, base;
};
struct DIRENTRY {
    char name[20]; long attr, size; DIRENTRY *next; long head; char system[4];
};

#include "shared/Skidmark_Segment.h"





struct Skidmark_Chunk {
    coorddef cp;
    short n, slice;
    Skidmark_Segment seg[24];
};

typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;
typedef short (*tPA32)[32];

#endif
