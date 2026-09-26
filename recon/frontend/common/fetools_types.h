/* Owner-specific type surface for Fetools.obj. */
#ifndef NFS4_FRONTEND_COMMON_FETOOLS_TYPES_H
#define NFS4_FRONTEND_COMMON_FETOOLS_TYPES_H

/* Fecntl.obj's complete 88-record graph is a strict subset. */
#define NFS4_FECNTL_NO_RECORD_CARRIER
#include "fecntl_types.h"
#undef NFS4_FECNTL_NO_RECORD_CARRIER

#include "shared/TCB.h"





struct EXEC {
    u_long pc0, gp0, t_addr, t_size, d_addr, d_size, b_addr, b_size;
    u_long s_addr, s_size, sp, fp, gp, ret, base;
};

struct DIRENTRY {
    char name[20];
    long attr, size;
    DIRENTRY *next;
    long head;
    char system[4];
};

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

#include "shared/tShapeInformation.h"








#include "fescreen_virtual_types.h"
struct tScreen {
    tShapeInformation fPermShapes, fSwapShapes;
    int fTransitionTicks;
    bool fTransitionOff;
    int fInternalScreenFadeVal;
    short fScreenFadeVal;
#include "fescreen_virtuals.inc"
};

#include "shared/tActiveLine.h"





#include "shared/tDrawShapeExtended.h"





#endif
