/* screendisplay_menuitems.h -- the three tMenuItemInteractive subclasses of the screen surface, moved verbatim from
 * screendisplay_types.h (lines 9-38 there).  An owner may include it right after the frontend core (retail: right after
 * tMenuItemInteractive); screendisplay_types.h then finds it already done. */
#ifndef NFS4_FRONTEND_COMMON_SCREENDISPLAY_MENUITEMS_H
#define NFS4_FRONTEND_COMMON_SCREENDISPLAY_MENUITEMS_H



struct tMenuItemLeftRightChoice : public tMenuItemInteractive {
    tListIterator *fData;
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    tMenuItemLeftRightChoice(unsigned int, tListIterator *);
    ~tMenuItemLeftRightChoice();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void Draw(bool);
#endif
};
struct tMenuItemLeftRightSlider : public tMenuItemInteractive {
    tListIterator *fData;
    short fX, fY, fWidth, fHeight;
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    tMenuItemLeftRightSlider(unsigned int, tListIterator *);
    ~tMenuItemLeftRightSlider();
    long DebounceKeys();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void Draw(bool);
    void SetDimensions(short, short, short, short);
#endif
};
struct tMenuItemGoToMenuButton : public tMenuItemInteractive {
    void (*fOnButtonPress)(void *);
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    tMenuItemGoToMenuButton(unsigned int, tMenu *,
                            void (*)(tMenuCommand &));
    ~tMenuItemGoToMenuButton();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#endif
};
#endif
