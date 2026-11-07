/* tOldMenu/tItemButton (moved verbatim from fecntl_types.h; FECntl.obj emits them right after the pads via its draw_leaf hook). */
#ifndef NFS4_FRONTEND_COMMON_FECNTL_MENUS_H
#define NFS4_FRONTEND_COMMON_FECNTL_MENUS_H
struct tOldMenu;

struct tItemButton {
    short type, text;
    tOldMenu *nextMenu;
    char *value;
    short *selection;
    char defaultvalue;
    u_char flags, cases;
};

struct tOldMenu {
    char *artFileName, *backgrName;
    short driver, current, flags, helpvariant;
    tItemButton *item[16];
};
#endif
