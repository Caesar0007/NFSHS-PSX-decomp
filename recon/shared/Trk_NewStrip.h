/* Trk_NewStrip -- the one definition of this type, shared by 6 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TRK_NEWSTRIP_H
#define NFS4_SHARED_TRK_NEWSTRIP_H

struct Trk_NewStrip { u_char topVert, botVert; char quadCount, size; };
#endif
