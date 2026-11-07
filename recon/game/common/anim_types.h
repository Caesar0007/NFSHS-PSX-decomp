#ifndef NFS4_GAME_COMMON_ANIM_TYPES_H
#define NFS4_GAME_COMMON_ANIM_TYPES_H   /* anim.obj's exact source-visible type surface. */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail place (after COORD16, before the pads) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#include "draw_leaf_types.h"
#include "schedule_types.h"
#include "shared/POLY_GT4.h"







#include "shared/CCOORD16.h"

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
#include "shared/Trk_NewStrip.h"
#include "shared/Trk_NewSimQuad.h"
#include "shared/RelCoord16.h"

#include "shared/Track_tArtresource.h"







#include "shared/Track_tMaterial.h"

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
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"



#include "shared/Skidmark_Segment.h"





#include "shared/Skidmark_Chunk.h"





typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;
typedef short (*tPA32)[32];

#endif
