/* The retail inline-body SLD places this declaration in FEMENUEXTENDED.H.
 * Part selection is reconstruction-only include scaffolding; it preserves
 * declaration order while using the recorded physical source owner. */
#ifndef NFS4_FEMENUEXTENDED_TYPE_PART
#include "femenuextended_types.h"
#include "femenuextended_externs.h"
#elif NFS4_FEMENUEXTENDED_TYPE_PART == 1
struct tBlankMenuItemNFS4LeftRightChoice : public tMenuItemNFS4LeftRightChoice {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tBlankMenuItemNFS4LeftRightChoice(unsigned int t, tListIterator *d, int ff, int nf)
        : tMenuItemNFS4LeftRightChoice(t, d, ff, nf) {}
    void Draw(int, int, bool) {}
    bool TransitionIsFinished() { return true; }
#endif
};
#else
#error Unknown FEMENUEXTENDED.H type part
#endif
