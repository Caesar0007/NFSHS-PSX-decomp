"""fevirt_tmenu.py phase 2c: structural leftovers of the menu-family conversion.
  * inline constructors in screendisplay_types.h / screentrackinfo_types.h still stored hand tables;
  * tInsideBoxControllerLeftRightSlider was still COMPOSITION (`_base_tInsideBoxLeftRightSlider`) -> real inheritance;
  * two hand calls passed no arguments (the incoming a1..a3 were still live) = ProcessInput(fromPlayer,keyval,command);
  * tInsideBoxSongMenu's ctor placement-new'ed its tMenu base: retail calls the tMenu ctor directly and stores ONLY the
    SongMenu table, i.e. tInsideBoxMenu has an inline non-variadic ctor that SongMenu's init list uses;
  * femenuextended.cpp's extern-"C" destructor devices collide with the compiler's own destructors now."""
import re

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
FE = 'recon/frontend/common/'


def rd(f):
    return open(R + f, encoding='utf-8').read()


def wr(f, s):
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


def resub(s, pat, rep, cnt=1, flags=re.S):
    s2, n = re.subn(pat, rep, s, flags=flags)
    assert n == cnt, (pat[:70], n)
    return s2


for f in ('screendisplay_types.h', 'screentrackinfo_types.h'):
    s = rd(FE + f)
    s, n1 = re.subn(r'^[ \t]*extern __vtbl_ptr_type \w+_vtable\[\];\n', '', s, flags=re.M)
    s, n2 = re.subn(r'^[ \t]*(?:_base_tInsideBoxLeftRightSlider\.)?_vf\s*=\s*\(__typeof__\([^;]*?\)\)&\w+_vtable;\n', '', s, flags=re.M)
    s = s.replace('struct tInsideBoxControllerLeftRightSlider {' + NL + '    tInsideBoxLeftRightSlider _base_tInsideBoxLeftRightSlider;' + NL,
                  'struct tInsideBoxControllerLeftRightSlider : public tInsideBoxLeftRightSlider {' + NL)
    s = s.replace('        : _base_tInsideBoxLeftRightSlider(t, d) {', '        : tInsideBoxLeftRightSlider(t, d) {')
    print(f, 'externs', n1, 'stores', n2)
    wr(FE + f, s)

s = rd(FE + 'screendisplay_types.h')
a = ('    tInsideBoxMenu(unsigned int, tScreen *, tMenu *, tMenu *,' + NL +
     '                   void (*)(tMenuCommand &), short, tMenuItem *, ...);' + NL)
assert s.count(a) == 1
s = s.replace(a, a +
              '    /* non-variadic form for derived classes (tInsideBoxSongMenu): retail\'s SongMenu ctor calls the tMenu ctor' + NL +
              '     * directly and stores only its own table, i.e. this one is inline */' + NL +
              '    tInsideBoxMenu(unsigned int f, tScreen *s, tMenu *n, tMenu *o, void (*fn)(tMenuCommand &), short t)' + NL +
              '        : tMenu(f, s, n, o, fn, t) {}' + NL)
wr(FE + 'screendisplay_types.h', s)

s = rd(FE + 'femenuoptions.cpp')
s = resub(s, r'this->fItemList\[0\]->ProcessInput\(\);', 'this->fItemList[0]->ProcessInput(fromPlayer,keyval,command);')
s = resub(s, r'this->currMenu->ProcessInput\(\);', 'this->currMenu->ProcessInput(fromPlayer,keyval,command);')
s = resub(s, r'(tInsideBoxSongMenu::tInsideBoxSongMenu\([^{]*?\.\.\.\))\n\{\n(\s*int j;\n)\s*\n?\s*new \(\(tMenu \*\)this\) tMenu\(flags,screenHandler,nextMenu,optionsMenu,OnButtonPress,title\);\n',
          r'\1' + NL + '  : tInsideBoxMenu(flags,screenHandler,nextMenu,optionsMenu,OnButtonPress,title)' + NL + '{' + NL + r'\2')
s = s.replace('this->_base_tInsideBoxLeftRightSlider.fData', 'this->fData')
wr(FE + 'femenuoptions.cpp', s)

s = rd(FE + 'fedialog.cpp')
s = s.replace('->ProcessInputVirtual(', '->ProcessInput(')
wr(FE + 'fedialog.cpp', s)

s = rd(FE + 'femenuextended.cpp')
s, n = re.subn(r'^extern "C" void ___\d+tMenuItemOptions\w+\(void \*thisp\) \{ ___24tMenuItemLeftRightChoice\(thisp\); \}\n', '', s, flags=re.M)
print('dtor devices removed:', n)
wr(FE + 'femenuextended.cpp', s)
