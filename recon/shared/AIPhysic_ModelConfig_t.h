/* AIPhysic_ModelConfig_t -- the one definition of this type, shared by 9 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_AIPHYSIC_MODELCONFIG_T_H
#define NFS4_SHARED_AIPHYSIC_MODELCONFIG_T_H

struct AIPhysic_ModelConfig_t {
    int dlpos_to_dlvel, max_dlvel, dlvel_to_clacc, max_clacc;
    int dangle_to_dav, max_dav, dav_to_aa, max_aa;
    int vel_limit_range, lat_vel_limit_factor, ang_vel_limit_factor;
};
#endif
