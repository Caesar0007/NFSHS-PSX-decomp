/* frontend/common/screendisplay.h -- retail SCREENDISPLAY.H: the one definition of tScreenDisplay.  Layout and the defining
 * .CPP are the retail SYM's; the including surface provides tScreen (fescreen.h) and the types
 * the declarations name. */
#ifndef _FE_SCREENS_SCREENDISPLAY_H_
#define _FE_SCREENS_SCREENDISPLAY_H_

struct tScreenDisplay : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    tScreenDisplay();
};

/* Member functions are declared on the owner-specific tScreenDisplay type. */

#endif
