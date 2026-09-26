/* copGame_t -- the one definition of this type, shared by 4 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_COPGAME_T_H
#define NFS4_SHARED_COPGAME_T_H

struct copGame_t {
    int numLevels;
    copLevel_t *levels;
};
#endif
