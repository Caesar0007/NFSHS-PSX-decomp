/* frontend/common/felist_classes.h -- the tListIterator family that FEMenu.obj owns, with REAL virtuals (2026-09-19).
 * Declaration ORDER is retail evidence (g++ 2.8 emits vtables in reverse declaration order; FEMenu.obj has RangeIndexed,
 * Range, MultiPlayer, DoubleIndexed, Indexed, base).  Slots: dtor, Value, TextValue, Increment, Decrement.  Every class
 * keys on its out-of-line destructor; none has a default constructor (retail has no such symbol).
 * The vptr follows the base's data members (+0xC), where the hand-written `_vf` member used to be. */
#ifndef NFS4_FRONTEND_COMMON_FELIST_CLASSES_H
#define NFS4_FRONTEND_COMMON_FELIST_CLASSES_H

/* tPlayer: the virtual signatures need it in every TU.  Owner surfaces whose SYM type graph does not retain the enum
 * spell it `#define tPlayer int` before including this file; the vtable layout is the same either way. */
#ifndef tPlayer
#include "fe_player_types.h"
#endif

typedef struct tListIterator {
    short *fSelectionList;
    char *fValue;
    char fMinValue, fMaxValue;

    tListIterator(short *selection, char *valPtr);
    virtual ~tListIterator();
    virtual char Value(tPlayer);
    virtual short TextValue(tPlayer);
    virtual void Increment(tPlayer);
    virtual void Decrement(tPlayer);
#if defined(NFS4_FE_LIST_OWNER) || defined(NFS4_FE_LIST_RANGE_INLINE)
#include "../../link_stripped.h"   /* SLINK /strip removed the standalone copies: build/tmp/v/strip_proof_20261107.md */
#define NFS4_FE_LIST_STRIP LINK_STRIPPED
#else
#define NFS4_FE_LIST_STRIP
#endif
    inline int MinValue() NFS4_FE_LIST_STRIP; inline int MaxValue() NFS4_FE_LIST_STRIP; inline int Range() NFS4_FE_LIST_STRIP;
    inline short Selection(int i) NFS4_FE_LIST_STRIP;


} tListIterator;
inline int tListIterator::MinValue() { return (unsigned char)fMinValue; }
inline int tListIterator::MaxValue() { return (unsigned char)fMaxValue; }
inline int tListIterator::Range() { return (unsigned char)fMaxValue - (unsigned char)fMinValue; }
inline short tListIterator::Selection(int i) { return fSelectionList[i]; }
#undef NFS4_FE_LIST_STRIP
/* The four inline accessors exist in every object: retail records tListIterator 6 times wherever it is declared
 * (2 for the typedef'd class + 1 per inline member definition); FEMenu/FEMenuOptions/FEMenuExtended keep their `this`
 * pairs.  FEMenu.obj defines the virtuals, so it emits standalone copies, which /strip removed. */

/* Per-object class sets (retail SYM): base + Range everywhere; Indexed + RangeIndexed in the screen/menu-definition
 * objects (the default here); Indexed alone where the TU header defines NFS4_FE_LIST_NO_RANGE_INDEXED; neither under
 * NFS4_FE_LIST_NO_INDEXED; DoubleIndexed and MultiPlayer only in FEMenu.obj (NFS4_FE_LIST_OWNER). */
#ifndef NFS4_FE_LIST_NO_INDEXED
struct tListIteratorIndexed : public tListIterator {
    char *fIndex;
    tListIteratorIndexed(short *selection, char *valPtr, char *index);
    ~tListIteratorIndexed();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
};

#endif

#ifdef NFS4_FE_LIST_OWNER
struct tListIteratorDoubleIndexed : public tListIterator {
    char *fIndex1;
    int index1multiplier;
    char *fIndex2;
    tListIteratorDoubleIndexed(short *selection, char *valPtr, char *index1, int multiplier, char *index2) LINK_STRIPPED;   /* gap-evidenced ctor: see femenu.cpp */
    ~tListIteratorDoubleIndexed();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
};

struct tListIteratorMultiPlayer : public tListIterator {
    tListIteratorMultiPlayer(short *selection, char *valPtr) LINK_STRIPPED;   /* gap-evidenced ctor: see femenu.cpp */
    ~tListIteratorMultiPlayer();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
};

#endif

struct tListIteratorRange : public tListIterator {
    tListIteratorRange(char minValue, char maxValue, char *valPtr);
    ~tListIteratorRange();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
};

#if !defined(NFS4_FE_LIST_NO_INDEXED) && !defined(NFS4_FE_LIST_NO_RANGE_INDEXED)
struct tListIteratorRangeIndexed : public tListIteratorRange {
    char *fIndex;
    tListIteratorRangeIndexed(char minValue, char maxValue, char *valPtr, char *index);
    ~tListIteratorRangeIndexed();
    char Value(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
};

#endif

#endif
