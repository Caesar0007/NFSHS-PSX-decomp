/* MCRDFILEHEADER_def -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_MCRDFILEHEADER_DEF_H
#define NFS4_SHARED_MCRDFILEHEADER_DEF_H

struct MCRDFILEHEADER_def {
    u_char magicnumber[2];
    u_char type, nslots;
    u_short title[32];
    u_char unused[28];
    u_char iconclut[32];
    u_char icon1[128], icon2[128], icon3[128];
};
#endif
