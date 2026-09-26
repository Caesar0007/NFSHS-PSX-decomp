/* charactertbl -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_CHARACTERTBL_H
#define NFS4_SHARED_CHARACTERTBL_H

struct charactertbl {
    unsigned char index[2];
    unsigned char width, height;
    unsigned char u[2], v[2];
    char advance, xoffset, yoffset;
};
#endif
