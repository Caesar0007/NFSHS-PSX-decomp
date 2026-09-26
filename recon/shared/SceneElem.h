/* SceneElem -- the one definition of this type, shared by 12 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_SCENEELEM_H
#define NFS4_SHARED_SCENEELEM_H

struct SceneElem {
    int type, size, committed, visible;
    coorddef cp;
    int height;
    matrixtdef orient;
    int subType, subTypeIndex, scalar1, scalar2, scalar3, scalar4;
};
#endif
