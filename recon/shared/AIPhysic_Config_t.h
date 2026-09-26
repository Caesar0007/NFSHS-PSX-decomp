/* AIPhysic_Config_t -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_AIPHYSIC_CONFIG_T_H
#define NFS4_SHARED_AIPHYSIC_CONFIG_T_H

struct AIPhysic_Config_t {
    int latvelcalc_lookahead, min_lookahead, max_lookahead, look_ahead_factor;
    int skid_value;
    AIPhysic_ModelConfig_t ICModel, OOCModel;
};
#endif
