/* frontend/common/fecars_carlist.h -- FECars.obj owner records emitted through the fe_core_cars.h hook NFS4_FE_CORE_CARS_HOOK_AFTER_OWNED (retail order). */
#ifndef NFS4_FRONTEND_COMMON_FECARS_CARLIST_H
#define NFS4_FRONTEND_COMMON_FECARS_CARLIST_H
typedef enum tCarListType {
    clt_Stock = 1, clt_GarageCar = 2, clt_Cop = 4, clt_Pursuit = 8,
    clt_Traffic = 16, clt_PinkSlips = 32, clt_Tournament = 64,
    clt_Dealer = 128
} tCarListType;
#endif
