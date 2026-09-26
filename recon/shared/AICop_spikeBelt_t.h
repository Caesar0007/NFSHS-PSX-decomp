/* AICop_spikeBelt_t -- the one definition of this type, shared by 4 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_AICOP_SPIKEBELT_T_H
#define NFS4_SHARED_AICOP_SPIKEBELT_T_H

struct AICop_spikeBelt_t {
    int active_, slice_, leftLatPos_, rightLatPos_, freshenTime_;
};
#endif
