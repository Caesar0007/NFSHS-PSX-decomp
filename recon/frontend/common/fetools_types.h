/* Owner-specific type surface for Fetools.obj. */
#ifndef NFS4_FRONTEND_COMMON_FETOOLS_TYPES_H
#define NFS4_FRONTEND_COMMON_FETOOLS_TYPES_H

/* Fecntl.obj's complete 88-record graph is a strict subset. */
#define NFS4_FECNTL_MENUS_LATE   /* retail FETools: tOldMenu/tItemButton at the end of the graph */
#define NFS4_FECNTL_NO_RECORD_CARRIER
#include "fecntl_types.h"
#undef NFS4_FECNTL_NO_RECORD_CARRIER

#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"

/* These four classes are Fetools-owned header surface.  PSXFront shares the
 * remainder of this graph, but its linked SYM has no completed body for any
 * of them.  Keep Fetools' default surface unchanged while allowing that exact
 * shared graph to be composed without importing foreign definitions. */
#ifndef NFS4_FETOOLS_OMIT_MENU_CLASSES
struct tMenuItemLeftRightChoice : public tMenuItemInteractive {
    tListIterator *fData;
};

struct tMenuItemGoToMenuButton : public tMenuItemInteractive {
    void (*fOnButtonPress)(void *);
};
#ifdef NFS4_FE_CORE_TMENU_AFTER_ITEMS   /* tMenu right after this owner's tMenuItemGoToMenuButton */
#include "fe_core_tmenu.h"
#endif

#include "shared/tActiveLine.h"   /* retail FETools: tActiveLine right before tMenuItemNFS4LeftRightChoice */
struct tMenuItemNFS4LeftRightChoice : public tMenuItemLeftRightChoice {
    short fOffset, fTransitionVal, fTransitionSpeed, fEnabledTransitionVal;
};

struct tMenuNFS4 : public tMenu {
    bool fInItemTransition, fInMenuTransition;
    short fTransitionVal;
    signed char fTransitionDirection;
    char fLastItem, fNumItems;
};
#endif

#ifndef NFS4_PSXFRONT_SCREEN_LATE   /* PSXFront: tShapeInformation + tScreen after Car_tObj (psxfront_screen_late.h) */
#include "shared/tShapeInformation.h"
#endif
#include "fescreen_virtual_types.h"
struct tMenu;
#ifndef NFS4_PSXFRONT_SCREEN_LATE
#include "fescreen.h"
#endif
#ifndef NFS4_PSXFRONT_SCREEN_LATE
#include "shared/tActiveLine.h"
#endif
#include "shared/tDrawShapeExtended.h"
#ifdef NFS4_FE_CORE_CARS_LATE
#include "fe_core_cars.h"
#endif
#include "fecntl_menus.h"   /* retail: tOldMenu, tItemButton last */
#endif
