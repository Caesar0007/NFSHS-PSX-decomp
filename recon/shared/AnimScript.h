/* AnimScript -- the ANIM.H class, one definition for every includer (header-truth 4g).  Members are defined in anim.cpp.
   The inline destructor is retail-real: its expansion is the exact delete sequence in Anim_Restart / Anim_FreeHandle and
   the object-animation deleting destructors, and it is the body behind retail's `AnimScript AnimScript Trk_AnimateInst`
   record run in every including object. */
#ifndef NFS4_SHARED_ANIMSCRIPT_H
#define NFS4_SHARED_ANIMSCRIPT_H
struct Group;
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
#endif
