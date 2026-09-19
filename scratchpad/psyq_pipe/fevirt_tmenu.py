"""Real C++ virtuals, step 5 (2026-09-19): the front-end MENU family (tMenuItem x28, tMenu x9).
Phase 1 (this script): the ROOT classes in fe_core_types.h become polymorphic, every vptr store of the family goes, the
12 hand vtable files go.  The per-owner duplicate declarations of DERIVED classes stay (they never had `_vf`).
Phase 2: fevirt_sites.py rewrites the dispatch sites the compiler rejects (per-type slot maps).
Slots (retail tables):  item  ~, DebounceKeys, ProcessInput, Draw(bool)=0, Draw(int,int,bool), Draw(int,int,int,bool),
TransitionOff, TransitionOn, TransitionIsFinished, UpdateTransition(bool);   menu  ~, Initialize, ProcessInput,
DebounceKeys, TransitionOff, TransitionOn, TransitionIsFinished, IsSubMenu, Draw, UpdateTransition.
Owner surfaces that do not retain tInputKeyType / tMenuCommand get a layout-only placeholder signature for ProcessInput
(same slot; such a TU can neither define nor call it)."""
import glob
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


def sub1(s, a, b):
    assert s.count(a) == 1, (a[:70], s.count(a))
    return s.replace(a, b)


files = sorted(glob.glob(R + 'recon/game/common/vtables_tmenu*.cpp') + glob.glob(R + 'recon/game/common/vtables_tpausemenu*.cpp'))
names = set()
for f in files:
    names |= set(re.findall(r'^__vtbl_ptr_type (\w+)_vtable\[', open(f, encoding='utf-8').read(), re.M))
print(len(files), 'vtable files,', len(names), 'classes')

h = rd(FE + 'fe_core_types.h')
SIG = ('#if defined(NFS4_FE_CORE_FEMENU_METHODS) || defined(NFS4_FE_CORE_FEDIALOG_METHODS)' + NL +
       '    virtual void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);' + NL + '#else' + NL +
       '    virtual void ProcessInput(int, void *, void *);   /* layout-only: this owner surface has no tInputKeyType/tMenuCommand */' + NL +
       '#endif' + NL)
# ---- tMenuItem
h = sub1(h, '    tMenu *fNewMenu;' + NL + '    __vtbl_ptr_type (*_vf)[11];' + NL,
         '    tMenu *fNewMenu;' + NL +
         '    /* real virtuals since 2026-09-19, in retail slot order (vptr after the data members, where `_vf` was) */' + NL +
         '    tMenuItem(unsigned int textDescription);' + NL + '    virtual ~tMenuItem();' + NL + '    virtual long DebounceKeys();' + NL + SIG +
         '    virtual void Draw(bool) = 0;' + NL + '    virtual void Draw(int, int, bool);' + NL + '    virtual void Draw(int, int, int, bool);' + NL +
         '    virtual void TransitionOff();' + NL + '    virtual void TransitionOn();' + NL + '    virtual bool TransitionIsFinished();' + NL +
         '    virtual void UpdateTransition(bool);' + NL)
h = sub1(h, '    tMenuItem() {}' + NL + '    tMenuItem(unsigned int textDescription);' + NL + '    ~tMenuItem();' + NL + '    long DebounceKeys();' + NL +
         '    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);' + NL + '    void UpdateTransition(bool);' + NL +
         '    bool TransitionIsFinished();' + NL + '    void UpdateSelFade(bool);' + NL + '    void Draw(int, int, bool);' + NL +
         '    void Draw(int, int, int, bool);' + NL + '    void TransitionOn();' + NL + '    void TransitionOff();' + NL +
         '    bool IsDisabled() { return (fFlags & 1) != 0; }' + NL,
         '    void UpdateSelFade(bool);' + NL)
h = sub1(h, 'typedef tMenuItem *tItemList[16];' + NL,
         '/* non-member: an inline MEMBER of a class whose key function is in the TU (FEMenu) would get an out-of-line copy */' + NL +
         'static inline bool tMenuItem_IsDisabled(tMenuItem *item) { return (item->fFlags & 1) != 0; }' + NL + NL +
         'typedef tMenuItem *tItemList[16];' + NL)
# ---- tMenu
h = sub1(h, '    short VertHelp;' + NL + '    __vtbl_ptr_type (*_vf)[11];' + NL,
         '    short VertHelp;' + NL + '    virtual ~tMenu();' + NL + '    virtual void Initialize();' + NL + SIG +
         '    virtual long DebounceKeys();' + NL + '    virtual void TransitionOff();' + NL + '    virtual void TransitionOn();' + NL +
         '    virtual bool TransitionIsFinished();' + NL + '    virtual bool IsSubMenu();' + NL + '    virtual void Draw();' + NL +
         '    virtual void UpdateTransition();' + NL)
a = h.index('    inline void ProcessInputVirtual(tPlayer player, tInputKeyType &key,')
b = h.index('#endif', a)
h = h[:a] + h[b:]
h = sub1(h, '    tMenu() {}' + NL + '    void tMenuConstructor(tMenuItem *firstItem, void *ap);', '    void tMenuConstructor(tMenuItem *firstItem, void *ap);')
h = sub1(h, '    ~tMenu();' + NL + '    void Initialize();' + NL + '    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);' + NL +
         '    short GetNumberEnabledItems();' + NL + '    void Draw();' + NL + '    void UpdateTransition();' + NL + '    void TransitionOff();' + NL +
         '    void TransitionOn();' + NL + '    bool TransitionIsFinished();' + NL + '    bool IsSubMenu();' + NL + '    long DebounceKeys();' + NL,
         '    short GetNumberEnabledItems();' + NL)
h = sub1(h, '    tMenuItemInteractive() {}' + NL, '')
wr(FE + 'fe_core_types.h', h)

# ---- vptr stores + extern declarations of the hand tables, everywhere in the front end / game
pat = re.compile(r'^[ \t]*(?:\*\(void \*\*\)&\(?(?:this->)?_vf\)?|(?:this->)?_vf)\s*=\s*\([^;]*?\)\s*(\w+)_vtable;[^\n]*\n', re.M)
for f in glob.glob(R + 'recon/frontend/**/*.cpp', recursive=True) + glob.glob(R + 'recon/game/**/*.cpp', recursive=True):
    s = open(f, encoding='utf-8').read()
    n = [0]

    def rep(m):
        if m.group(1) in names:
            n[0] += 1
            return ''
        return m.group(0)
    s2 = pat.sub(rep, s)
    if n[0]:
        open(f, 'w', encoding='utf-8', newline='').write(s2)
        print('%3d vptr stores removed  %s' % (n[0], f.replace(R, '')))
for f in glob.glob(R + 'recon/frontend/**/*.h', recursive=True) + glob.glob(R + 'recon/game/**/*.h', recursive=True):
    s = open(f, encoding='utf-8').read()
    s2 = re.sub(r'^extern __vtbl_ptr_type (\w+)_vtable\[\d*\];[^\n]*\n', lambda m: '' if m.group(1) in names else m.group(0), s, flags=re.M)
    if s2 != s:
        open(f, 'w', encoding='utf-8', newline='').write(s2)
        print('externs removed', f.replace(R, ''))
for f in files:
    os.remove(f)
