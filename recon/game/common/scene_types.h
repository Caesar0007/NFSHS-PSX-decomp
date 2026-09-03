/* scene.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_SCENE_TYPES_H
#define NFS4_GAME_COMMON_SCENE_TYPES_H

#include "color_types.h"

struct Trk_ObjectDef { short id; u_char vertexCount, quadCount; };

struct Trk_CollideBoomInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad;
    int x, y, z;
    short qx, qy, qz, qw, sx, sy, sz;
    u_char simIndex, boomIndex;
};

struct Trk_AnimateInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad, count, interval;
};

struct Trk_SimObject {
    int point[3];
    short radius, serialNum;
    u_char topCRAP, bottomCRAP, instIndex, type;
};

struct AnimScript {
    int baseTicks, baseFrame, flags, numParts;
    Trk_AnimateInst **inst;
    AnimScript(int num);
    AnimScript(int num, int numParts);
    AnimScript(Group *instanceGroup, int type, int boomIndex, int numParts);
    ~AnimScript() { delete [] inst; }
    void SetAnimAttrib(int flags);
    void GetAnimFrameInfo(int *frame, int *numFrames);
    int GetTimedAnimPosRot(coorddef *pt, matrixtdef *mat);
    int GetTimedAnimPosRot(int index, coorddef *pt, matrixtdef *mat);
    int GetStatus();
};

struct SceneElem {
    int type, size, committed, visible;
    coorddef cp;
    int height;
    matrixtdef orient;
    int subType, subTypeIndex, scalar1, scalar2, scalar3, scalar4;
};

struct SceneSortedElem { int slice_; SceneElem *se; };
struct CSceneList { int id_, numElements_, slice_, versionNumber_; };
struct AnimDef { int type, numPieces, objDefIndex, baseAnim, animIndex; };

struct ObjectAnim {
    __vtbl_ptr_type (*_vf)[3];
    ~ObjectAnim();
};

struct DRender_tView;
struct Draw_DCache;
struct ObjectFinishedMultiAnim {
    ObjectAnim _base_ObjectAnim;
    int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset);
};

struct ObjectFinishedSignAnim {
    ObjectAnim _base_ObjectAnim;
    matrixtdef finalMatrix;
    Trk_ObjectDef *objDef;
    Trk_CollideBoomInst *objCollideInstance;
    int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset);
};

struct kernpair {
    u_short previouscode, code;
    char kernvalue;
    char pad[3];
};
typedef kernpair KERN;

typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif
