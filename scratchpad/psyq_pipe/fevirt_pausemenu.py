"""Real C++ virtuals, step 4 (2026-09-19): the in-race pause-menu family (pausemenu.cpp owns all 11 classes; mpause.cpp
is a user).  Replaces vtables_tpausemenu_g4_tPMenu.cpp and the manual `_vf` stores/dispatch/facades.
Retail evidence:
  * tables 0x8005611C.. = tPMenu, CommandButton, GoToMenuButton, SliderIndexed, Slider, LeftRightChoice, Interactive,
    NonInteractiveText, tPMenuItem, tPListIteratorIndexed, tPListIterator = reverse of mpause_types.h's declaration order;
  * slots: iterator [dtor, Value, TextValue, Increment, Decrement]; item [dtor, NextMenu, Debounce, ProcessInput,
    IsNavigable (pure), Draw (pure)]; menu [dtor, Initialize, ProcessInput, Draw];
  * every class has an out-of-line user destructor after its constructor (key function), no default constructors;
  * the four trailing functions (IsNavigable x2, IsEnabled, IsDisabled) stay ordinary out-of-line definitions at the end
    of pausemenu.cpp: that is already retail's order.
Inline MEMBER facades (VirtualNextMenu, IsEnabledAndNavigable, ...) would get out-of-line copies once the class has a
key function in the TU, so they become non-member `static inline` helpers (which get none)."""
import os
import re

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
G = 'recon/game/common/'


def rd(f):
    return open(R + f, encoding='utf-8').read()


def wr(f, s):
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


def sub1(s, a, b, cnt=1):
    assert s.count(a) == cnt, (a[:60], s.count(a))
    return s.replace(a, b)


h = rd(G + 'mpause_types.h')
# --- iterators
h = sub1(h, '    __vtbl_ptr_type (*_vf)[6];' + NL + '    tPListIterator() {}' + NL + '    tPListIterator(short *, int *);' + NL +
         '    ~tPListIterator();' + NL + '#ifdef NFS4_MPAUSE_PAUSEMENU_METHODS' + NL + '    char Value(tPlayer);' + NL +
         '    short TextValue(tPlayer);' + NL + '    void Increment(tPlayer);' + NL + '    void Decrement(tPlayer);' + NL + '#endif' + NL,
         '    /* real virtuals since 2026-09-19 (vptr after the data members, where `_vf` was) */' + NL +
         '    tPListIterator(short *, int *);' + NL + '    virtual ~tPListIterator();' + NL + '    virtual char Value(tPlayer);' + NL +
         '    virtual short TextValue(tPlayer);' + NL + '    virtual void Increment(tPlayer);' + NL + '    virtual void Decrement(tPlayer);' + NL)
h = sub1(h, '    ~tPListIteratorIndexed();' + NL + '#ifdef NFS4_MPAUSE_PAUSEMENU_METHODS' + NL + '    char Value(tPlayer);' + NL +
         '    short TextValue(tPlayer);' + NL + '    void Increment(tPlayer);' + NL + '    void Decrement(tPlayer);' + NL + '#endif' + NL,
         '    ~tPListIteratorIndexed();' + NL + '    char Value(tPlayer);' + NL + '    short TextValue(tPlayer);' + NL +
         '    void Increment(tPlayer);' + NL + '    void Decrement(tPlayer);' + NL)
# --- tPMenuItem
a = h.index('struct tPMenuItem {')
b = h.index('struct tPMenuItemNonInteractiveText')
h = (h[:a] + '''struct tPMenuItem {
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
};
/* SYM-INLINE-FACADE: tPMenu::Initialize's SLD records the inlined tPMenuItem `this` but no named condition result; retail
   materializes the two compound predicates as int 0/1 values.  NON-member helpers: an inline MEMBER of a class whose
   key function is in the TU would get an out-of-line copy. */
static inline int tPMenuItem_IsEnabledAndNavigable(tPMenuItem *item) {
    int result = false;
    if (((item->fFlags ^ 1) & 1) != 0) {
        result = item->IsNavigable() != 0;
    }
    return result;
}
static inline int tPMenuItem_IsDisabledOrNotNavigable(tPMenuItem *item) {
    int result = false;
    if (((item->fFlags & 1) != 0) || (item->IsNavigable() == 0)) {
        result = true;
    }
    return result;
}
''' + h[b:])
# --- tPMenu
h = sub1(h, '    __vtbl_ptr_type (*_vf)[5];' + NL + '    tPMenu() {}' + NL + '    tPMenu(tPMenuItem *, ...);' + NL + '    ~tPMenu();' + NL +
         '    void tPMenuConstructor(tPMenuItem *, void *);' + NL + '    void Initialize();' + NL,
         '    tPMenu(tPMenuItem *, ...);' + NL + '    virtual ~tPMenu();' + NL + '    void tPMenuConstructor(tPMenuItem *, void *);' + NL +
         '    virtual void Initialize();' + NL)
h = sub1(h, '    void ProcessInput(tInputKeyType &, tPMenuCommand &);' + NL + '    void Draw();' + NL + '    int NumEnabledItems();',
         '    virtual void ProcessInput(tInputKeyType &, tPMenuCommand &);' + NL + '    virtual void Draw();' + NL + '    int NumEnabledItems();')
a = h.index('    inline void VirtualInitialize() {')
b = h.index('};', a)
h = h[:a] + h[b:]
wr(G + 'mpause_types.h', h)

s = rd(G + 'pausemenu.cpp')
s, n = re.subn(r'^[ \t]*this->_vf =\s*\(__vtbl_ptr_type \(\*\) ?\[\d+\]\)\s*tP\w+_vtable;\n', '', s, flags=re.M)
print('vptr stores removed:', n)
s, n = re.subn(r'\(\*\(\*this->_vf\)\[2\]\.pfn\)\(\(int\)&this->fSelectionList \+\s*\(int\)\(\*this->_vf\)\[2\]\.delta,0xffffffff\)',
               'this->Value((tPlayer)-1)', s)
assert n == 2, n
for slot, meth in ((5, 'Decrement'), (4, 'Increment')):
    s, n = re.subn(r'\(\*\(\*this->fData->_vf\)\[%d\]\.pfn\)\s*\(\(int\)&this->fData->fSelectionList \+ \(int\)\(\*this->fData->_vf\)\[%d\]\.delta,\s*0xffffffff\);' % (slot, slot),
                   'this->fData->%s((tPlayer)-1);' % meth, s)
    assert n == 1, meth
s, n = re.subn(r'\(\*\(\*this->fData->_vf\)\[3\]\.pfn\)\s*\(\(int\)&this->fData->fSelectionList \+\s*\(int\)\(\*this->fData->_vf\)\[3\]\.delta,0xffffffff\)',
               'this->fData->TextValue((tPlayer)-1)', s)
assert n == 1, n
s, n = re.subn(r'return \(\*\(bool \(\*\)\(\.\.\.\)\)\(\*this->fItemList\[this->fCurrentItem\]->_vf\)\[3\]\.pfn\)\s*\(\(int\)&this->fItemList\[this->fCurrentItem\]->fFlags \+\s*\(int\)\(\*this->fItemList\[this->fCurrentItem\]->_vf\)\[3\]\.delta\);',
               'return this->fItemList[this->fCurrentItem]->Debounce();', s)
assert n == 1, n
s = s.replace('->VirtualNextMenu()', '->NextMenu()').replace('->VirtualIsNavigable()', '->IsNavigable()')
s = s.replace('->VirtualProcessInput(', '->ProcessInput(')
s, n = re.subn(r'(this->fItemList\[this->fCurrentItem\])->(IsEnabledAndNavigable|IsDisabledOrNotNavigable)\(\)', r'tPMenuItem_\2(\1)', s)
assert n == 2, n
wr(G + 'pausemenu.cpp', s)

m = rd(G + 'mpause.cpp')
m = sub1(m, '  __vtbl_ptr_type *vf = *menu->_vf;' + NL + '  int delta = vf[2].delta;' + NL +
         '  void (*pfn)(...) = (void (*)(...))vf[2].pfn;' + NL + '  (*pfn)((int)menu + delta);' + NL, '  menu->Initialize();' + NL)
m = m.replace('->VirtualProcessInput(', '->ProcessInput(')
wr(G + 'mpause.cpp', m)
for f in ('pausemenu_externs.h', 'mpause_externs.h'):
    x = rd(G + f)
    x2 = re.sub(r'^extern __vtbl_ptr_type tP\w*_vtable\[\d*\][^;]*;[^\n]*\n', '', x, flags=re.M)
    if x2 != x:
        wr(G + f, x2)
os.remove(R + G + 'vtables_tpausemenu_g4_tPMenu.cpp')
