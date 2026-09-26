/* CARD_FILE_HEADER -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_CARD_FILE_HEADER_H
#define NFS4_SHARED_CARD_FILE_HEADER_H

struct CARD_FILE_HEADER {
    char magic[2];
    char type, numslots;
    char documentname[64];
    char pad[28];
    char clut[32];
    char icon[3][128];
};
#endif
