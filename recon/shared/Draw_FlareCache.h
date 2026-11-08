/* Draw_FlareCache -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_DRAW_FLARECACHE_H
#define NFS4_SHARED_DRAW_FLARECACHE_H

struct Draw_FlareCache { Draw_tCacheHeader head; };
#ifdef NFS4_TU_FLARE   /* owner object: retail records the C-style `typedef struct Draw_FlareCache {..} Draw_FlareCache;` form (TPDEF twice) */
typedef struct Draw_FlareCache Draw_FlareCache;
#endif
#endif
