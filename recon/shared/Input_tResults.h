/* Input_tResults -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_INPUT_TRESULTS_H
#define NFS4_SHARED_INPUT_TRESULTS_H

struct Input_tResults {
    char steering;
    u_char gas, brake, flags;
};
#endif
