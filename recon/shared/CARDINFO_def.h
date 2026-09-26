/* CARDINFO_def -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_CARDINFO_DEF_H
#define NFS4_SHARED_CARDINFO_DEF_H

struct CARDINFO_def {
    int status, lasterror, numfiles, freeblocks;
    DIRENTRY dir[15];
};
#endif
