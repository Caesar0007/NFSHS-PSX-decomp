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
    inline bool IsFilter(int filter) LINK_STRIPPED;
    inline int CarListFilter() LINK_STRIPPED;
};
/* In-class inline members (retail FECars.obj: TPDEF tListIteratorCar x4 at the class = declaration + 3 bodies, as in every
   FEMenuDefs-surface includer, screendisplay_carblock_iters.h).  SetFilter is retail-real (screendisplay copy); IsFilter /
   CarListFilter = INFERRED body: retail FECars.obj TPDEF tListIteratorCar x4 run evidence (FESCR2).  FECars emits the key
   function, so the unreferenced standalone copies land in .text.strip (LINK_STRIPPED, linkers/link_stripped.json). */
inline void tListIteratorCar::SetFilter(int filter) { fCarListFilter = filter; }
inline bool tListIteratorCar::IsFilter(int filter) { return fCarListFilter == filter; }
inline int tListIteratorCar::CarListFilter() { return fCarListFilter; }

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
