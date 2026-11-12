/* AIPhysic_BrakeInfo -- AIPHYSIC.H, one definition for every includer (header-truth 4m).  All five inline bodies are
   expanded in matched code (retail records this/speed/sIndex, this/distance and currentSpeed/futureSpeed scopes); the
   member names are descriptive, the SYM keeps no name for inlined members. */
#ifndef NFS4_SHARED_AIPHYSIC_BRAKEINFO_H
#define NFS4_SHARED_AIPHYSIC_BRAKEINFO_H
struct AIPhysic_BrakeInfo {
    u_char brakeTable_[128];
    int deceleration_;
    inline void SetBrakeDistance(int speed, int distance) {
        int sIndex = speed / 0x10000;
        if (sIndex < 0)
            sIndex = -sIndex;
        if (!(sIndex < 0x80))
            sIndex = 0x80;
        brakeTable_[sIndex] = (u_char)(distance / 0x20000);
    }
    AIPhysic_BrakeInfo(int deceleration)
    {
        int invDeceleration;

        deceleration_ = deceleration;
        invDeceleration = fixeddiv(0x10000, deceleration);
        for (int brakeTableLoop = 0; brakeTableLoop < 0x80; brakeTableLoop++) {
            int brakeDistanceMeters =
                fixedmult(fixedmult(brakeTableLoop << 0x10, invDeceleration), brakeTableLoop << 0x10) / 2;
            SetBrakeDistance(brakeTableLoop << 0x10, brakeDistanceMeters);
        }
    }
    inline int Deceleration() { return deceleration_; }
    int GetBrakeDistance(int speed)
    {
        int sIndex = speed / 0x10000;
        if (sIndex < 0) {
            sIndex = -sIndex;
        }
        if (!(sIndex < 0x80)) {
            sIndex = 0x80;
        }
        return (u_int)brakeTable_[sIndex] * 0x20000;
    }
    /* Retail inline records list futureSpeed before currentSpeed. */
    int GetNeededDistance(int futureSpeed,int currentSpeed)
    {
        return GetBrakeDistance(currentSpeed) - GetBrakeDistance(futureSpeed);
    }
};
#endif
