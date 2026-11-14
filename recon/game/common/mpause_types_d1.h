/* mpause_types_d1 -- moved verbatim out of mpause_types.h so that header holds only its include list. */
#ifndef NFS4_MPAUSE_TYPES_D1_H
#define NFS4_MPAUSE_TYPES_D1_H
struct tPMenu;
struct tPMenuCommand { tPMenuCommandType type; tPMenu *nextMenu; };

typedef struct tPListIterator {
    short *fSelectionList;
    int *fValue;
    /* real virtuals since 2026-09-19 (vptr after the data members, where `_vf` was) */
    tPListIterator(short *, int *);
    virtual ~tPListIterator();
    virtual char Value(tPlayer);
    virtual short TextValue(tPlayer);
    virtual void Increment(tPlayer);
    virtual void Decrement(tPlayer);
} tPListIterator;
struct tPListIteratorIndexed : public tPListIterator {
    char *fIndex;
    tPListIteratorIndexed(short *, int *, char *);
    ~tPListIteratorIndexed();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
};

struct tPMenuItem {
    unsigned int fFlags, fTextDescription;
    tPMenuItem(unsigned int);
    virtual ~tPMenuItem();
    virtual tPMenu *NextMenu();
    virtual bool Debounce();
    virtual void ProcessInput(tInputKeyType &, tPMenuCommand &);
    virtual bool IsNavigable() = 0;
    virtual void Draw(bool) = 0;
    bool IsEnabled();
    bool IsDisabled();
    void Enable() LINK_STRIPPED; /* inferred member spelling, also used by sibling tMenuItem */
    void Disable() LINK_STRIPPED; /* inferred member spelling, also used by sibling tMenuItem */
    unsigned int TextDescription() LINK_STRIPPED; /* inferred getter: retail nests this item receiver in the menu getter */
    void SetTextDescription(unsigned int) LINK_STRIPPED; /* sibling tMenuItem uses this setter spelling */
};
#endif
