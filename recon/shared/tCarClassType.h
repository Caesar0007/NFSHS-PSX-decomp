/* tCarClassType -- same text as fe_tournament_types.h / fecheats_types.h; included by fe_core_cars.h right after
 * tOwnedCarInfo under NFS4_FE_CORE_CARS_CLASSTYPE (retail FEMemcard, ScreenAudio, ScreenTrackInfo order). */
#ifndef NFS4_TCARCLASSTYPE_DEFINED
#define NFS4_TCARCLASSTYPE_DEFINED
enum tCarClassType {
    cct_Roadster = 0, cct_PonyCar = 1, cct_SaloonCar = 2,
    cct_SportsCar = 3, cct_SuperCar = 4, cct_GTRCar = 5,
    cct_BonusCar = 6, cct_CopCar = 7, cct_TrafficCar = 8,
    cct_Helicopter = 9, cct_OpenClass = 10, cct_NumCarClasses = 11
};
#endif
