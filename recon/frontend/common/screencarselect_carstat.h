/* screencarselect_carstat.h -- enum tCarStatType (moved verbatim from screencarselect_types.h).  ScreenCarSelect.obj records it
 * right after tCarNameLength, before tCarManager: fe_core_cars.h owner hook NFS4_FE_CORE_CARS_HOOK_BEFORE_MANAGER. */
#ifndef NFS4_FRONTEND_COMMON_SCREENCARSELECT_CARSTAT_H
#define NFS4_FRONTEND_COMMON_SCREENCARSELECT_CARSTAT_H
enum tCarStatType {
    cst_Acceleration = 0,
    cst_Brake = 1,
    cst_Speed = 2,
    cst_Handling = 3,
    cst_Overall = 4
};
#endif
