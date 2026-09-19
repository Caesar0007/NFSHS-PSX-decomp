"""fevirt_tmenu.py phase 2b: the hand-crafted dispatch carriers fevirt_sites.py cannot parse, and the four virtuals
introduced BELOW the roots (slot 11/12): tMenuNFS4::DrawItem(int), tInsideBoxMenu::Draw(sssss),
tMenuItemSlidingMenu::UpdatefOpenHeight(bool), tInsideBoxSongMenu::DrawOneSong(ssssss)."""
import re

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
FE = 'recon/frontend/common/'


def rd(f):
    return open(R + f, encoding='utf-8').read()


def wr(f, s):
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


def resub(s, pat, rep, cnt=1):
    s2, n = re.subn(pat, rep, s, flags=re.S)
    assert n == cnt, (pat[:60], n)
    return s2


for f in ('femenuextended_types.h', 'screendisplay_types.h', 'screentrackinfo_types.h'):
    s = rd(FE + f)
    s2 = re.sub(r'^(\s*)(void DrawItem\(int\);|void UpdatefOpenHeight\(bool\);|void DrawOneSong\(short, short, short, short, short, short\);|'
                r'void Draw\(short, short, short, short, short\);)', r'\1virtual \2', s, flags=re.M)
    if s2 != s:
        wr(FE + f, s2)

s = rd(FE + 'femenuextended.cpp')
s = resub(s, r'\(\*\(\(__vtbl_ptr_type \*\)this->_vf\)\[11\]\.pfn\)\s*\(\(int\)this \+ \(\(__vtbl_ptr_type \*\)this->_vf\)\[11\]\.delta,\(int\)i\);',
          'this->DrawItem((int)i);')
wr(FE + 'femenuextended.cpp', s)

s = rd(FE + 'femenuoptions.cpp')
s = resub(s, r'entry = &\(\*item->_vf\)\[10\];\s*adjusted = \(char \*\)item \+ \(int\)entry->delta;\s*\(\*entry->pfn\)\(adjusted,',
          'item->UpdateTransition(')
s = resub(s, r'entry = &\(\*this->fItemList\[i\]->_vf\)\[5\];\s*adjusted = \(char \*\)this->fItemList\[i\] \+ \(int\)entry->delta;\s*\(\*entry->pfn\)\(adjusted,0,0,',
          'this->fItemList[i]->Draw(0,0,')
s = resub(s, r'entry10 = &\(\*this->fItemList\[i\]->_vf\)\[10\];\s*\(\*entry10->pfn\)\(\(char \*\)this->fItemList\[i\] \+ \(int\)entry10->delta,',
          'this->fItemList[i]->UpdateTransition(')
s = resub(s, r'entry6 = &\(\*this->fItemList\[i\]->_vf\)\[6\];\s*\(\*entry6->pfn\)\s*\(\(char \*\)this->fItemList\[i\] \+ \(int\)entry6->delta,x,',
          'this->fItemList[i]->Draw(x,')
s = resub(s, r'\(\*\*\(int \(\*\*\)\(\.\.\.\)\)\(\(int\)this->_vf \+ 0x5c\)\)\s*\(\(int\)&this->fFlags \+ \(int\)\*\(short \*\)\(\(int\)this->_vf \+ 0x58\),\s*selected\);',
          'this->UpdatefOpenHeight(selected);')
s = resub(s, r'\(\*\*\(int \(\*\*\)\(\.\.\.\)\)\(\(int\)this->currMenu->_vf \+ 0x5c\)\)\s*\(\(\(int\)this->currMenu->fItemList \+ -0x10\) \+ \*\(short \*\)\(\(int\)this->currMenu->_vf \+ 0x58\),',
          'this->currMenu->Draw(')
s = resub(s, r'\(\*\(\*\(this->_vf \+ 1\)\)\[1\]\.pfn\)\s*\(\(int\)this \+ \(\*\(this->_vf \+ 1\)\)\[1\]\.delta,', 'this->DrawOneSong(')
wr(FE + 'femenuoptions.cpp', s)

s = rd(FE + 'feapp.cpp')
s = resub(s, r'      __vtbl_ptr_type \(\*vtbl\)\[11\] = menu->_vf;\n', '')
s = resub(s, r'\(\*\(\*vtbl\)\[2\]\.pfn\)\(\(char \*\)menu \+ \(\*vtbl\)\[2\]\.delta\);', 'menu->Initialize();')
wr(FE + 'feapp.cpp', s)

s = rd(FE + 'femenu.cpp')
s, n = re.subn(r'\bthis->IsDisabled\(\)', 'tMenuItem_IsDisabled(this)', s)
print('IsDisabled uses:', n)
wr(FE + 'femenu.cpp', s)
