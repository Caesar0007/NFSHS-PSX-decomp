/* MCRDFILEINFO_def -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_MCRDFILEINFO_DEF_H
#define NFS4_SHARED_MCRDFILEINFO_DEF_H

struct MCRDFILEINFO_def {
    int cardnum;
    char name[24];
    char *title;
    int size, offset;
    unsigned int flags;
    MCRDFILEHEADER_def header;
    void *pData;
    shapetbl *icon[3];
};
#endif
