"""fevirt_speech.py phase 2d: the last three hand sites in speech.cpp.
  DispatchSpeaker::Report: the hand call passed no 2nd argument (a1 still held `perp`) -> this->KnownPerp(perp)
  MobileSpeaker::Engage:   entry-pointer carriers on `Sub` -> Sub->KnownPerp(this->Perp()), Sub->Report(carObj)"""
import re

F = 'C:/Temp/nfs4-decomp/recon/game/common/speech.cpp'
s = open(F, encoding='utf-8').read()


def resub(pat, rep):
    global s
    s2, k = re.subn(pat, rep, s, flags=re.S)
    assert k == 1, (pat[:60], k)
    s = s2


resub(r'if \(this->KnownPerp\(\) != 0\) \{', 'if (this->KnownPerp(perp) != 0) {')
resub(r'  __vtbl_ptr_type \*knownEntry = &\(\*Sub->_vf\)\[18\];\n  int knownThis = \(int\)Sub \+ knownEntry->delta;\n', '')
resub(r'\(\*knownEntry->pfn\)\(knownThis,\s*this->Perp\(\)\);', 'Sub->KnownPerp(this->Perp());')
resub(r'  __vtbl_ptr_type \*reportEntry =\s*&\(\*Sub->_vf\)\[1\];\n  int reportThis = \(int\)Sub \+ reportEntry->delta;\n', '')
resub(r'\(\*reportEntry->pfn\)\(reportThis,carObj\);', 'Sub->Report(carObj);')
open(F, 'w', encoding='utf-8', newline='').write(s)
print('ok')
