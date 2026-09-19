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

struct tListIterator {
    short *fSelectionList;
    char *fValue;
    char fMinValue, fMaxValue;

    tListIterator(short *selection, char *valPtr);
    virtual ~tListIterator();
    virtual char Value(tPlayer);
    virtual short TextValue(tPlayer);
    virtual void Increment(tPlayer);
    virtual void Decrement(tPlayer);
};

struct tListIteratorIndexed : public tListIterator {
    char *fIndex;
    tListIteratorIndexed(short *selection, char *valPtr, char *index);
    ~tListIteratorIndexed();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
};

struct tListIteratorDoubleIndexed : public tListIterator {
    char *fIndex1;
    int index1multiplier;
    char *fIndex2;
    ~tListIteratorDoubleIndexed();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
};

struct tListIteratorMultiPlayer : public tListIterator {
    ~tListIteratorMultiPlayer();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
};

struct tListIteratorRange : public tListIterator {
    tListIteratorRange(char minValue, char maxValue, char *valPtr);
    ~tListIteratorRange();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
};

struct tListIteratorRangeIndexed : public tListIteratorRange {
    char *fIndex;
    tListIteratorRangeIndexed(char minValue, char maxValue, char *valPtr, char *index);
    ~tListIteratorRangeIndexed();
    char Value(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
};

#endif
