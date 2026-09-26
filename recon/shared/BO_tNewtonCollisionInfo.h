/* BO_tNewtonCollisionInfo -- the one definition of this type, shared by 5 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_BO_TNEWTONCOLLISIONINFO_H
#define NFS4_SHARED_BO_TNEWTONCOLLISIONINFO_H

struct BO_tNewtonCollisionInfo {
    int collided, impulse;
    BO_tNewtonObj *otherObj;
    int sfxType, disableCollisionTimer;
    coorddef collisionPoint;
    int lastCollision;
    BO_tNewtonObj *lastOtherObj;
    int lastImpulse, lastTime;
};
#endif
