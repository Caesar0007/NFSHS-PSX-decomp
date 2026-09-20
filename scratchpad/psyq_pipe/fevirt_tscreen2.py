"""fevirt_tscreen.py phase 2b: hand conversions fevirt_sites.py cannot parse (dialogs, memcard, controller, congrats).
All of them were carriers IMITATING what a real virtual call / constructor does:
  fedialog         slot 11 Draw(), slot 10 CalculateDimensions()
  fememcard        `tDialogYesNoMem MyDialog;` + manual `_vf` poke  ->  the implicit ctor now stores the derived table
  screencontroller vtable store smuggled through fShaker's mem-initializer -> g++ stores the vptr before member ctors anyway
  screencongrats   slot 10 CalculatePrizes(), 11 DrawCongratsMessage(), 12 GetCar(tCarInfo&)"""
import re

R = 'C:/Temp/nfs4-decomp/recon/frontend/common/'
NL = chr(10)


def rd(f):
    return open(R + f, encoding='utf-8').read()


def wr(f, s):
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


def resub(s, pat, rep, cnt=1):
    s2, n = re.subn(pat, rep, s, flags=re.S)
    assert n == cnt, (pat[:70], n)
    return s2


s = rd('fedialog.cpp')
s = resub(s, r'\(\*\(\*\(\(DialogVisibilityList\[i\]->_vf\) \+ 1\)\)\[1\]\.pfn\)\s*\(\(char \*\)DialogVisibilityList\[i\] \+\s*\(\*\(\(DialogVisibilityList\[i\]->_vf\) \+ 1\)\)\[1\]\.delta\);',
          'DialogVisibilityList[i]->Draw();')
s = resub(s, r'\(\*\(this->_vf\)\[1\]\[0\]\.pfn\)\(\(int\)this \+ \(this->_vf\)\[1\]\[0\]\.delta\);', 'this->CalculateDimensions();')
wr('fedialog.cpp', s)

s = rd('fememcard.cpp')
s = resub(s, r'  __vtbl_ptr_type \(\*dialogVtable\)\[10\] =\s*\(__vtbl_ptr_type \(\*\)\[10\]\)tDialogYesNoMem_vtable;\n', '')
s = resub(s, r'  dialog->_vf = dialogVtable;\n',
          '  /* (2026-09-20) tDialogYesNoMem is a real polymorphic class: its implicit ctor stores the derived table after the' + NL +
          '     tDialogYesNo ctor returns -- the store the old manual `_vf` poke imitated. */' + NL)
wr('fememcard.cpp', s)

s = rd('screencontroller.cpp')
s = resub(s, r'tScreenControllerConfig::tScreenControllerConfig\(\)\n  : fShaker\(\(this->_vf = \(__vtbl_ptr_type \(\*\)\[10\]\)tScreenControllerConfig_vtable,\s*this->fShaker\)\)\n',
          'tScreenControllerConfig::tScreenControllerConfig()' + NL)
wr('screencontroller.cpp', s)

s = rd('screencongrats.cpp')
s = resub(s, r'  vtbl = this->_vf;\n  carRotate \+= 3;\n  \(\*vtbl\[1\]\[1\]\.pfn\)\s*\(\(char \*\)\(\(int\)this->fPermShapes\.fFilename \+ \(vtbl\[1\]\[1\]\.delta \+ -0x14\)\)\);',
          '  carRotate += 3;' + NL + '  this->DrawCongratsMessage();')
s = resub(s, r'  vtbl = this->_vf;\n  \(\*vtbl\[1\]\[0\]\.pfn\)\(\(char \*\)this \+ vtbl\[1\]\[0\]\.delta\);\n  vtbl = this->_vf;\n  this->fGotCar = \(\*\(bool \(\*\)\(\.\.\.\)\)vtbl\[1\]\[2\]\.pfn\)\s*\(\(char \*\)this \+ vtbl\[1\]\[2\]\.delta,\s*&this->fCarInfo\);',
          '  this->CalculatePrizes();' + NL + '  this->fGotCar = this->GetCar(this->fCarInfo);')
s = resub(s, r'\(\*\(\*this->_vf\)\[12\]\.pfn\)\s*/\*.*?\*/\s*\(\(char \*\)\(\(int\)this->fPermShapes\.fFilename \+\s*\(\(\*this->_vf\)\[12\]\.delta \+ -0x14\)\),&carinfo\);',
          'this->GetCar(carinfo);')
s = re.sub(r'^  __vtbl_ptr_type \(\*vtbl\) \[10\];\n', '', s, flags=re.M)
wr('screencongrats.cpp', s)
