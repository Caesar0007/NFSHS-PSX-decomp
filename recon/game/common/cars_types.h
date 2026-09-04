/* cars.obj's exact source-visible delta over the shared CopSpeak graph. */
#ifndef NFS4_GAME_COMMON_CARS_TYPES_H
#define NFS4_GAME_COMMON_CARS_TYPES_H

#define NFS4_AUDIOCLC_OMIT_SOUND_API_TYPES
#define NFS4_AUDIOCMN_OMIT_SND_PLAY_OPTS
#define NFS4_AUDIOCMN_OMIT_AUDIO_MUS_ENTRY
#define NFS4_AUDIOCMN_OMIT_COPSPEAK_REQUEST
#define NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES
#define NFS4_COPSPEAK_KEEP_CAMERA_VIEW
#define NFS4_COPSPEAK_KEEP_FORCE_FOCUS
#define NFS4_COLOR_OMIT_UDFF_HANDLE
#include "copspeak_types.h"
#undef NFS4_COLOR_OMIT_UDFF_HANDLE
#undef NFS4_COPSPEAK_KEEP_FORCE_FOCUS
#undef NFS4_COPSPEAK_KEEP_CAMERA_VIEW
#undef NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES
#undef NFS4_AUDIOCMN_OMIT_COPSPEAK_REQUEST
#undef NFS4_AUDIOCMN_OMIT_AUDIO_MUS_ENTRY
#undef NFS4_AUDIOCMN_OMIT_SND_PLAY_OPTS
#undef NFS4_AUDIOCLC_OMIT_SOUND_API_TYPES

typedef enum AIDataRecord_RecordMethod_t {
    NORMAL_M = 0,
    RECORD_M = 1,
    TEST_M = 2
} AIDataRecord_RecordMethod_t;

typedef int CarLogic_tObservations[1][3];

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

struct Trk_NewSlice {
    int center[3];
    char normal[3], forward[3], right[3];
    u_char acousticType;
    short pavedProfile, leftDrive, rightDrive;
    u_char chunkIndex, laneCount, avgPavedWidthLf, avgPavedWidthRt;
};

struct AIDataRecord_t {
    int numElements_, bSize_;
    char name_[64];
    char *dataBuffer_, *preAllocatedBuffer_;
    AIDataRecord_RecordMethod_t recordMethod_;
    __vtbl_ptr_type (*_vf)[3];
};

struct AIDataRecord_AccTable_t : public AIDataRecord_t { int scale_; };
struct AIDataRecord_CurveSpeedTable_t : public AIDataRecord_t {};

struct AIPhysic_BrakeInfo {
    u_char brakeTable_[128];
    int deceleration_;
};

struct AIPhysic_ModelConfig_t {
    int dlpos_to_dlvel, max_dlvel, dlvel_to_clacc, max_clacc;
    int dangle_to_dav, max_dav, dav_to_aa, max_aa;
    int vel_limit_range, lat_vel_limit_factor, ang_vel_limit_factor;
};

struct AnimScript {
    int baseTicks, baseFrame, flags, numParts;
    Trk_AnimateInst **inst;
};

struct SceneElem {
    int type, size, committed, visible;
    coorddef cp;
    int height;
    matrixtdef orient;
    int subType, subTypeIndex, scalar1, scalar2, scalar3, scalar4;
};

struct SceneSortedElem { int slice_; SceneElem *se; };
struct AnimDef { int type, numPieces, objDefIndex, baseAnim, animIndex; };

struct ObjectAnim { __vtbl_ptr_type (*_vf)[3]; };
struct ObjectFinishedMultiAnim { ObjectAnim _base_ObjectAnim; };
struct ObjectFinishedSignAnim {
    ObjectAnim _base_ObjectAnim;
    matrixtdef finalMatrix;
    Trk_ObjectDef *objDef;
    Trk_CollideBoomInst *objCollideInstance;
};

struct Object_tIMassObjInfo {
    Trk_AnimateInst *animInst;
    coorddef dimension, lastPos;
    int lastTick;
};

struct Udff_tInfo {
    Udff_tAccessType type;
    int handle;
    char *memPtr;
};
typedef Udff_tInfo *Udff_tHandle;

#endif
