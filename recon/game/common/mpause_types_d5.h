/* mpause_types_d5 -- moved verbatim out of mpause_types.h so that header holds only its include list. */
#ifndef NFS4_MPAUSE_TYPES_D5_H
#define NFS4_MPAUSE_TYPES_D5_H
struct tPMenu {
    int fCurrentItem;
    bool fHighlight;
    tPMenuItem *fItemList[16];
    tPMenu *fNextMenu;
    int fNumItems;
    tPMenu(tPMenuItem *, ...);
    virtual ~tPMenu();
    void tPMenuConstructor(tPMenuItem *, void *);
    virtual void Initialize();
    bool Debounce();
    void CheckForDisabled();
    virtual void ProcessInput(tInputKeyType &, tPMenuCommand &);
    virtual void Draw();
    int CurrentItem() LINK_STRIPPED; /* inferred accessor: retail records this at the current-item reads */
    unsigned int CurrentItemText() LINK_STRIPPED; /* inferred getter for the selected item's description */
    void SetCurrentItem(int) LINK_STRIPPED; /* inferred setter: retail records the confirmation-menu receiver */
    void SetHighlight(bool) LINK_STRIPPED; /* inferred setter: retail records this in both highlight arms */
    int NumItems() LINK_STRIPPED; /* inferred inline count getter: retail records this at both count reads */
    int NumEnabledItems();
    int ItemEnabledNum(int);
};
#endif
