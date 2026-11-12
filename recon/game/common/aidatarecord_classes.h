/* game/common/aidatarecord_classes.h -- the AIDATARECORD.H record-class family, one definition for every includer
 * (header-truth 4i; moved verbatim from aidatarecord_types.h, the owner, blank lines included).  Members are defined
 * in aidatarecord.cpp. */
#ifndef NFS4_GAME_COMMON_AIDATARECORD_CLASSES_H
#define NFS4_GAME_COMMON_AIDATARECORD_CLASSES_H
#ifdef NFS4_GAME_COMMON_AIDATARECORD_TYPES_H   /* AIDATARECORD.obj (key object) emits standalone copies of the inline members; the retail link removed them */
#define NFS4_AIDATARECORD_STRIP LINK_STRIPPED
#else
#define NFS4_AIDATARECORD_STRIP
#endif
enum AIDataRecord_WhichRecord_t {
    NORECORD_R = 0,
    RACER_SPEED_R = 1,
    TRAFFIC_SPEED_R = 2,
    ACCELERATION_R = 3,
    REMOVED_R = 4,
    BEST_LINE_R = 5,
    TRACK_CURVE_R = 6,
    CURVESPEED_TABLE_R = 7,
    CAR_TRACKING_R = 8
};
enum AIDataRecord_RecordMethod_t {
    NORMAL_M = 0,
    RECORD_M = 1,
    TEST_M = 2
};
/* Real virtuals since 2026-09-19.  Declaration ORDER is retail evidence: g++ 2.8 emits the vtables at finish_file in
 * reverse declaration order and retail has CarTracking, CurveSpeedTable, TrackCurve, BestLine, AccTable, base.
 * The vptr follows the data members (old g++ ABI), where the hand-written `_vf` member used to be.
 * The derived classes declare NO destructor: retail's are the compiler-synthesized ones (no vptr store). */
typedef struct AIDataRecord_t {
    int numElements_, bSize_;
    char name_[64];
    char *dataBuffer_, *preAllocatedBuffer_;
    AIDataRecord_RecordMethod_t recordMethod_;
    /* Inferred accessor spellings: retail inline receiver pairs establish
       these operations, but do not preserve their original identifiers. */
    inline AIDataRecord_RecordMethod_t RecordMethod() NFS4_AIDATARECORD_STRIP;   /* AIDATARECORD.obj's standalone copies: SLINK /strip removed them (P6 Route C 2026-11-07) */
    inline char *Name() NFS4_AIDATARECORD_STRIP;
    inline char *DataBuffer() NFS4_AIDATARECORD_STRIP;
    inline char *PreAllocatedBuffer() NFS4_AIDATARECORD_STRIP;
    inline int BufferSize() NFS4_AIDATARECORD_STRIP;
    inline int NumElements() NFS4_AIDATARECORD_STRIP;
    inline void SetDataBuffer(char *buffer) NFS4_AIDATARECORD_STRIP;
    AIDataRecord_t(AIDataRecord_WhichRecord_t which, char *name);
    virtual ~AIDataRecord_t();
    int AddRecordToCollection();
    int RemoveRecordFromCollection();
    static void StartUp1();
    static void StartUp2();
    static void CleanUp1();
    static void CleanUp2();
    virtual void Setup();
    int Load();
    int SaveAndPurge();
} AIDataRecord_t;
inline AIDataRecord_RecordMethod_t AIDataRecord_t::RecordMethod() { return recordMethod_; }
inline char *AIDataRecord_t::Name() { return name_; }
inline char *AIDataRecord_t::DataBuffer() { return dataBuffer_; }
inline char *AIDataRecord_t::PreAllocatedBuffer() { return preAllocatedBuffer_; }
inline int AIDataRecord_t::BufferSize() { return bSize_; }
inline int AIDataRecord_t::NumElements() { return numElements_; }
inline void AIDataRecord_t::SetDataBuffer(char *buffer) { dataBuffer_ = buffer; }


















































struct AIDataRecord_AccTable_t : public AIDataRecord_t {
    int scale_;
    AIDataRecord_AccTable_t(char *name, int n, AIDataRecord_WhichRecord_t which);
    int Get(int i);
    void Setup();
};






































typedef struct AIDataRecord_BestLine_t : public AIDataRecord_t {
    AIDataRecord_BestLine_t(AIDataRecord_WhichRecord_t which); inline int Get(int slice) NFS4_AIDATARECORD_STRIP;   /* retail AI.obj inlines it: this/slice and buffer/latPos pair */
} AIDataRecord_BestLine_t;
inline int AIDataRecord_BestLine_t::Get(int slice) { int latPos; char *buffer; buffer = dataBuffer_; latPos = (int)(signed char)buffer[slice]; return latPos << 0xe; }








struct AIDataRecord_TrackCurve_t : public AIDataRecord_t {
    AIDataRecord_TrackCurve_t(AIDataRecord_WhichRecord_t which);
    int Get(int i);
};














struct AIDataRecord_CurveSpeedTable_t : public AIDataRecord_t {
    AIDataRecord_CurveSpeedTable_t(char *name, AIDataRecord_WhichRecord_t which);
    int Get(int i);
    void Upgrade(int i);
};












struct AIDataRecord_CarTracking_t : public AIDataRecord_t {
    /* Get inline in the class (SYM: AIDATARECORD.H:191, kind 6 LOCAL, vtable unlabelled = no key method); plain `struct`
     * (retail has 2 class-level TPDEFs = class name + the inline member, typedef form gave 3).  LANE2 2026-11-07. */
#line 190 "C:/nfs4/GAME/COMMON/AIDATARECORD.H"
    virtual int Get(int slice)
{

  return 0;
}

    AIDataRecord_CarTracking_t(AIDataRecord_WhichRecord_t which, char carLetter) NFS4_AIDATARECORD_STRIP;


};
#line 220 "recon/game/common/aidatarecord_classes.h"
#endif
