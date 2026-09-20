"""fevirt_speech.py phase 2b: repair three parentheses my `_base_Speaker` rewrite ate, and convert the hand carriers the
site rewriter cannot parse (they spell a virtual call through a cached table / entry pointer)."""
import re

R = 'C:/Temp/nfs4-decomp/recon/game/common/'
NL = chr(10)
s = open(R + 'speech.cpp', encoding='utf-8').read()
s, n = re.subn(r'\(Speaker \*\)this \{', '(Speaker *)this) {', s)
print('parens repaired:', n)


def resub(pat, rep, cnt=1):
    global s
    s2, k = re.subn(pat, rep, s, flags=re.S)
    assert k == cnt, (pat[:60], k)
    s = s2


resub(r'\(dist = \(int\)\(\*this->fSub->_vf\)\[0x1b\]\.delta,\s*\(\*\(\*this->fSub->_vf\)\[0x1b\]\.pfn\)\s*\(\(int\)&\(this->fSub->fPosition\)\.flags \+ dist\) == 0\)',
      '(this->fSub->Perp() == 0)')
resub(r'    __vtbl_ptr_type \(\*perpVf\)\[31\] = this->fSub->_vf;\n    int perpDistance = \(\*\(\*perpVf\)\[0x18\]\.pfn\)\s*\(\(int\)&\(this->fSub->fPosition\)\.flags \+ \(int\)\(\*perpVf\)\[0x18\]\.delta\);',
      '    int perpDistance = this->fSub->DistToPerp();')
resub(r'        __vtbl_ptr_type \*engageEntry =\s*&\(\*this->fSub->_vf\)\[6\];\n\s*int engageThis =\s*\(int\)this->fSub \+ engageEntry->delta;\n\s*\(\*engageEntry->pfn\)\(engageThis,\s*this->fSub->Perp\(\)\);',
      '        this->fSub->Engage(this->fSub->Perp());')
open(R + 'speech.cpp', 'w', encoding='utf-8', newline='').write(s)
print('ok')
