"""fevirt_tscreen.py phase 5: "SimpleMem" heads proven by vtable alignment.
g++ aligns every vtable to 8 SECTION-relative, so an object's tables only land on retail's addresses if its .rodata
starts where retail's does.  For screencontroller / screentrackrecords / screentrophyinfo that start is 12 bytes before
their first string -- the unowned "SimpleMem" tag (0x80012040 / 0x80011FC8 / 0x80011E78) is theirs.
Their first literal-bearing function is a LEAF (or the literal is file-scope data), where the `if (0) sprintf` carrier would
cost a frame; the faithful model is the real one anyway: an UNUSED inline whose literal the compiler emits at its
definition point while dropping the body (what a header inline naming the SimpleMem class leaves behind)."""
import re

R = 'C:/Temp/nfs4-decomp/recon/frontend/common/'
NL = chr(10)
for f in ('screencontroller.cpp', 'screentrackrecords.cpp', 'screentrophyinfo.cpp'):
    s = open(R + f, encoding='utf-8').read()
    assert 'SimpleMem' not in s, f
    incs = [m.end() for m in re.finditer(r'^#include[^\n]*\n', s, re.M)]
    i = incs[-1]
    s = (s[:i] + NL + '/* retail: this object\'s .rodata opens with the unreferenced "SimpleMem" tag (its vtables\' 8-byte alignment proves the' + NL +
         ' * section starts there).  An unused inline leaves exactly that behind: the literal is emitted, the body is not. */' + NL +
         'static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }' + NL + s[i:])
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)
