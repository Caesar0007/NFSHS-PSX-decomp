/* DrawW.obj's exact source-visible type surface reconstructed from SYM.
 * color.obj is an exact 71-record subset; the declarations below are the
 * complete DrawW owner delta, including the independent SDK typedef lane. */
#if !defined(NFS4_GAME_PSX_DRAWW_TYPES_H)   /* first pass */
#define NFS4_GAME_PSX_DRAWW_TYPES_H
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES   /* the standalone owner only */
#define NFS4_CORE_KERNEL_PADS_FIRST   /* retail: kernel/pad types ahead of the core (nfs4_types.h) */
#define NFS4_COLOR_GS_AFTER_SAVE   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_TRK_OBJ   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_TRK_SIMPLE   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_HOOK_AFTER_BO "../psx/draww_types.h"   /* retail: forceFocus_t right after the BO types (second pass below) */
#define NFS4_PRIM_POLY_GT3   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_DR_TWIN   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#endif
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#include "../common/color_types.h"
#endif
#if (defined(NFS4_COLOR_IN_HOOK) || defined(NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES)) && !defined(NFS4_DRAWW_EARLY_DONE)   /* second pass (owner) / in place (bworld) */
#define NFS4_DRAWW_EARLY_DONE
typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;
#endif
#if !defined(NFS4_COLOR_IN_HOOK) && !defined(NFS4_DRAWW_TAIL_DONE)   /* first pass, after color_types.h */
#define NFS4_DRAWW_TAIL_DONE
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)
#define gScratchLastWord   (*(int *)0x1F8003FC)
#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
enum AIDataRecord_RecordMethod_t {
    NORMAL_M = 0,
    RECORD_M = 1,
    TEST_M = 2
};
typedef struct AIDataRecord_t {
    int numElements_, bSize_;
    char name_[64];
    char *dataBuffer_, *preAllocatedBuffer_;
    AIDataRecord_RecordMethod_t recordMethod_;
    virtual ~AIDataRecord_t();   /* aidatarecord.cpp owns the family; slots: dtor, Setup */
    virtual void Setup();
} AIDataRecord_t;
struct AIDataRecord_AccTable_t : public AIDataRecord_t { int scale_; };
struct AIDataRecord_CurveSpeedTable_t : public AIDataRecord_t {};
#endif
#include "shared/Trk_ObjectDef.h"
#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
#include "shared/Trk_SimpleInst.h"
#endif
#include "shared/Trk_CollideBoomInst.h"



#include "shared/Trk_AnimateInst.h"




#include "shared/Trk_SimObject.h"





#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
/* Canonical bworldSm.obj aggregate (SYM: Trk_NewSlice, size 32). */
#include "shared/Trk_NewSlice.h"






#endif

#include "shared/BW_tContext.h"






struct AnimScript {
    int baseTicks, baseFrame, flags, numParts;
    Trk_AnimateInst **inst;
};
#include "shared/SceneElem.h"






#include "shared/SceneSortedElem.h"
#include "shared/AnimDef.h"

struct DRender_tView;
struct Draw_DCache;
/* object.cpp's polymorphic family, as this surface needs it: virtual dtor [slot 1], pure Draw [slot 2] */
struct ObjectAnim {
    virtual ~ObjectAnim();
    virtual int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset) = 0;
};
struct ObjectFinishedMultiAnim : public ObjectAnim { int Draw(DRender_tView *, Draw_DCache *, int); };
struct ObjectFinishedSignAnim : public ObjectAnim {
    int Draw(DRender_tView *, Draw_DCache *, int);
    matrixtdef finalMatrix;
    Trk_ObjectDef *objDef;
    Trk_CollideBoomInst *objCollideInstance;
};

#include "shared/DRender_tView.h"
#include "shared/Draw_DCache.h"







struct Chunk {
    RelCoord16 boundPts[4], chunkboundPts[4];
    u_char quadCounts[6], pad[2];
    Trk_Quad *renderQuads[4];
    Group *stripBuf, *lorezstripBuf, *objInstanceBuf, *objSpecialInstanceBuf;
    Group *simSliceBuf, *simQuadBuf, *simObjBuf, *sfxBuf, *lineBuf;
    Group *objVertexBuf, *objQuadBuf, *objQuadInstanceBuf;
    short firstSimSliceInd, chunkInd;
    Group *vertexBuf;
};
#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES   /* bworld_types.h declares it right after the BO types */
struct tBuildEntry { short chunkInd; char geomRez, enableBits; };
#endif
#include "shared/CHorizonSpec.h"



#include "shared/CSkySpec.h"











#include "shared/CNightSpec.h"
#include "shared/CWeatherSpec.h"
#include "shared/CFogSpec.h"
#include "shared/CDepthCueSpec.h"
#include "shared/CWorldColor.h"





#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
/* Canonical gmesetup.obj aggregate (SYM: GameSetup_tData, size 2600). */
#ifdef NFS4_GAME_COMMON_BWORLD_TYPES_H   /* bworld keeps the struct; draww.obj records none */
#include "shared/GameSetup_tData.h"
#endif
















/* Canonical trackspec.obj aggregate (SYM: CTrackSpec, size 264). */
#include "shared/CTrackSpec.h"











/* Canonical camera.obj aggregate (SYM: camera_info, size 272). */
#include "shared/camera_info.h"




























#endif

#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"







#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
/* POLY_GT3: declared by nfs4_types.h right after DISPENV (NFS4_PRIM_POLY_GT3, retail libgpu.h order) */





#endif
#include "shared/POLY_GT4.h"






#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
/* DR_TWIN: declared by nfs4_types.h right after DISPENV (NFS4_PRIM_DR_TWIN, retail libgpu.h order) */
#endif

#include "shared/Draw_SubdivStruct.h"
#include "shared/Track_tArtresource.h"






#include "shared/Track_tMaterial.h"
#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
typedef struct Trk_Line { u_char firstPoint, slice, type, quadIndex; } Trk_Line;

#include "shared/Draw_tGiveShelbyMoreCache.h"

























#endif

#include "shared/Skidmark_Segment.h"





#include "shared/Skidmark_Chunk.h"




#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
#include "shared/Draw_tCtrlSkidmark.h"






struct ChunkObjectInfo {
    Trk_SimObject *simObjs;
    Group *objInstanceBuf;
    int doFrustumClip, zClipSq, offset;
    short *visList;
};
#endif

#include "shared/FLARE_PIECE_DEF.h"
#include "shared/Sched_tSchedule.h"



#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
/* Canonical sim.obj aggregate (SYM: Sim_tSimGlobalVar, size 24). */
#include "shared/Sim_tSimGlobalVar.h"



#include "shared/tBoundingSphere.h"
#include "shared/tQuat.h"
#include "shared/kernpair.h"




typedef kernpair KERN;
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();
typedef tQuat Quatern_quat;
#endif
typedef u_char Night_tLightingTable[256][16];
typedef u_char Night_tWeatherLightingTable[256];
typedef u_char Night_tCopLightingTable[256][8];

#endif
