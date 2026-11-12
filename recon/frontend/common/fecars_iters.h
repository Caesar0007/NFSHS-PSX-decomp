/* frontend/common/fecars_iters.h -- FECars.obj owner records emitted through the fe_core_cars.h hook NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER (retail order). */
#ifndef NFS4_FRONTEND_COMMON_FECARS_ITERS_H
#define NFS4_FRONTEND_COMMON_FECARS_ITERS_H
#include "../../link_stripped.h"
struct tListIteratorCar : public tListIterator {
    int fCarListFilter;
    tCarManager *fCarManager;
    tCarNameLength fNameLength;

    tListIteratorCar(char *valPtr, tCarManager *carManager);
    ~tListIteratorCar();
    char Value(tPlayer atIndex);
    short TextValue(tPlayer atIndex);
    void AdjustPosition(tPlayer atIndex, short direction);
    void Increment(tPlayer atIndex);
    void Decrement(tPlayer atIndex);
    bool ValidCar(tPlayer atIndex, char carNumber);
    inline void SetFilter(int filter) LINK_STRIPPED;


};
/* SetFilter: called from matched code (screendisplay copy); FECars emits the key function, so its unreferenced
   standalone copy lands in .text.strip (LINK_STRIPPED, linkers/link_stripped.json). */


inline void tListIteratorCar::SetFilter(int filter) { fCarListFilter = filter; }



struct tListIteratorCarColor : public tListIterator {
    char *fPlayer, *fPlayerCar;
    int fIndexSize;
    tCarManager *fCarManager;

    tListIteratorCarColor(char *value, char *player, char *playerCar,
                          int indexSize, tCarManager *carManager);
    ~tListIteratorCarColor();
    char Value(tPlayer atIndex);
    short TextValue(tPlayer atIndex);
    void Increment(tPlayer atIndex);
    void Decrement(tPlayer atIndex);
};
#endif
