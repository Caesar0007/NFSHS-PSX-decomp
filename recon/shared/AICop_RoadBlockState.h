/* AICop_RoadBlockState -- one definition (header-truth 7a) */
#ifndef NFS4_SHARED_AICOP_ROADBLOCKSTATE_H
#define NFS4_SHARED_AICOP_ROADBLOCKSTATE_H
enum AICop_RoadBlockState {
    kAICop_RoadBlockState_None = 0,
    kAICop_RoadBlockState_WaitingForPerp = 1,
    kAICop_RoadBlockState_PerpPassed = 2
};
#endif
