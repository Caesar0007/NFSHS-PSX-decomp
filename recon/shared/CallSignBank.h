/* CallSignBank -- the one definition of this type, shared by 6 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_CALLSIGNBANK_H
#define NFS4_SHARED_CALLSIGNBANK_H

struct CallSignBank { int fAllUnits, fDispatch; int fMobile[15]; };
#endif
