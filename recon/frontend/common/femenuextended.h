#define NFS4_FE_CORE_CARS_INDEX_INT   /* inferred tCarManager body #2 without a tCarInfo parameter (fe_core_cars.h) */
/* Retail inline-body SLD places this declaration in FEMENUEXTENDED.H; part selection = include scaffolding. */
#ifndef NFS4_FEMENUEXTENDED_TYPE_PART
#define NFS4_CORE_PADS_EARLY   /* retail: controller pads before linedef (nfs4_types.h) */
#define NFS4_CORE_CCOORD16   /* retail femenuextended: CCOORD16 right after COORD16 */
#include "femenuextended_types.h"
#include "femenuextended_externs.h"
#elif NFS4_FEMENUEXTENDED_TYPE_PART == 1
struct tBlankMenuItemNFS4LeftRightChoice : public tMenuItemNFS4LeftRightChoice {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tBlankMenuItemNFS4LeftRightChoice(unsigned int t, tListIterator *d, int ff, int nf)
        : tMenuItemNFS4LeftRightChoice(t, d, ff, nf) {}
#line 80 "C:/nfs4/FRONTEND/COMMON/FEMENUEXTENDED.H"
    void Draw(int, int, bool) {}
    bool TransitionIsFinished() { return true; }
#endif
};
#line 16 "recon/frontend/common/femenuextended.h"
#else
#error Unknown FEMENUEXTENDED.H type part
#endif
