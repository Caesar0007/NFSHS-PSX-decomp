"""Real C++ virtuals, step 3 (2026-09-19): the tListIterator hierarchy (10 classes; owners femenu.cpp, fecars.cpp,
fetracks.cpp, fetourn.cpp).  Replaces vtables_tlist*.cpp (4 files) and the manual `_vf` stores/dispatch on iterators.
Retail evidence:
  * femenu.obj tables 0x800112D8.. = RangeIndexed, Range, MultiPlayer, DoubleIndexed, Indexed, base (reverse declaration
    order) => declared base, Indexed, DoubleIndexed, MultiPlayer, Range, RangeIndexed -- so the family gets ONE shared
    header in that order (felist_classes.h) instead of base+Range in fe_core_types.h and the rest per TU;
  * slots [1] dtor [2] Value [3] TextValue [4] Increment [5] Decrement;
  * every class has an OUT-OF-LINE destructor right after its constructor (= its key function) and there is NO
    default-constructor symbol => the `X() {}` default ctors go (as inline members of key-function classes they would
    get out-of-line copies).
Phase 1 of the script = headers + vptr stores; dispatch sites are then fixed from the compiler's error list."""
import os
import re

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
FE = 'recon/frontend/common/'


def rd(f):
    return open(R + f, encoding='utf-8').read()


def wr(f, s):
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


def cut_struct(s, name):
    """remove `struct name ... { ... };` (brace matched); returns (new_s, removed_text or None)"""
    m = re.search(r'^struct ' + name + r'\b[^;{]*\{', s, re.M)
    if not m:
        return s, None
    i = m.end()
    depth = 1
    while depth:
        c = s[i]
        depth += c == '{'
        depth -= c == '}'
        i += 1
    assert s[i] == ';', name
    i += 1
    if s[i:i + 1] == NL:
        i += 1
    return s[:m.start()] + s[i:], s[m.start():i]


HDR = '''/* frontend/common/felist_classes.h -- the tListIterator family that FEMenu.obj owns, with REAL virtuals (2026-09-19).
 * Declaration ORDER is retail evidence (g++ 2.8 emits vtables in reverse declaration order; FEMenu.obj has RangeIndexed,
 * Range, MultiPlayer, DoubleIndexed, Indexed, base).  Slots: dtor, Value, TextValue, Increment, Decrement.  Every class
 * keys on its out-of-line destructor; none has a default constructor (retail has no such symbol).
 * The vptr follows the base's data members (+0xC), where the hand-written `_vf` member used to be. */
#ifndef NFS4_FRONTEND_COMMON_FELIST_CLASSES_H
#define NFS4_FRONTEND_COMMON_FELIST_CLASSES_H

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
'''
wr(FE + 'felist_classes.h', HDR)

OWNED = ['tListIterator', 'tListIteratorRange', 'tListIteratorIndexed', 'tListIteratorDoubleIndexed',
         'tListIteratorMultiPlayer', 'tListIteratorRangeIndexed']
for f in sorted(os.listdir(R + FE)):
    if not f.endswith('.h') or f == 'felist_classes.h':
        continue
    s = rd(FE + f)
    o = s
    first = None
    for n in OWNED:
        s, got = cut_struct(s, n)
        if got and first is None:
            first = o.index(got)
    if s != o and f == 'fe_core_types.h':
        k = s.index('struct tMenuItem {')
        s = s[:k] + '#include "felist_classes.h"' + NL + NL + s[k:]
    # derived classes owned elsewhere: no default ctors (the base has none any more)
    s = re.sub(r'^[ \t]*tListIterator(?:Car|CarColor|Track|Tournament)\(\) \{\}[^\n]*\n', '', s, flags=re.M)
    if s != o:
        wr(FE + f, s)

# vptr stores in the constructors/destructors
for f in ('femenu.cpp', 'fecars.cpp', 'fetracks.cpp', 'fetourn.cpp'):
    s = rd(FE + f)
    s, n = re.subn(r'^[ \t]*(?:\*\(void \*\*\)&\(this->_vf\)|this->_vf) = \([^;]*\)tListIterator\w*_vtable;\n', '', s, flags=re.M)
    print(f, n, 'vptr stores removed')
    wr(FE + f, s)
for f in ('femenu_externs.h', 'fecars_externs.h', 'fetracks_externs.h', 'fetourn_externs.h'):
    s = rd(FE + f)
    s2 = re.sub(r'^extern __vtbl_ptr_type tListIterator\w*_vtable\[\][^;]*;[^\n]*\n', '', s, flags=re.M)
    if s2 != s:
        wr(FE + f, s2)
for f in ('vtables_tlist.cpp', 'vtables_tlist_g1_tListIteratorTrack.cpp', 'vtables_tlist_g2_tListIteratorRangeIndexed.cpp',
          'vtables_tlist_g3_tListIteratorTournament.cpp'):
    os.remove(R + 'recon/game/common/' + f)
