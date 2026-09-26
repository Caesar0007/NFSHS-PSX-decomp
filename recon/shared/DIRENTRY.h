/* DIRENTRY -- the one definition of this type, shared by 30 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_DIRENTRY_H
#define NFS4_SHARED_DIRENTRY_H

struct DIRENTRY {
    char name[20];
    long attr, size;
    DIRENTRY *next;
    long head;
    char system[4];
};
#endif
