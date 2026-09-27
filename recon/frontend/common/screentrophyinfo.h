/* frontend/common/screentrophyinfo.h -- retail SCREENTROPHYINFO.H: the one definition of tScreenTrophyInfo.  Layout and the defining
 * .CPP are the retail SYM's; the including surface provides tScreen (fescreen.h) and the types
 * the declarations name. */
#ifndef _FE_SCREENS_SCREENTROPHYINFO_H_
#define _FE_SCREENS_SCREENTROPHYINFO_H_

struct tScreenTrophyInfo : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    int BannerCol;
    tScreenTrophyInfo();
};


#endif
