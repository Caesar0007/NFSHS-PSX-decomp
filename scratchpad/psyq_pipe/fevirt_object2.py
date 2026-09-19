"""SUPERSEDED NOTE: the "empty literal" below was WRONG and has been removed from object.cpp -- the 4 zero bytes at
0x80056084 are alignment: g++ 2.8 emits every vtable with `.align 3` (section-relative).
fevirt_object.py follow-up: object.obj's read-only data 0x80056048..0x80056100 --
  "SimpleMem" tag (0x80056048; object.cpp could not take it in the automated batch because the TU did not compile),
  three reservememadr names, ONE unexplained empty literal (4 zero bytes @0x80056084, referenced by nothing), five vtables."""
import json

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
f = R + 'recon/game/common/object.cpp'
s = open(f, encoding='utf-8').read()
a = 'void Object_InitCustomObjects(void)' + NL + NL + '{' + NL
assert s.count(a) == 1
s = s.replace(a, a + '  if (0) sprintf((char *)0,"SimpleMem");   /* retail: this object\'s .rodata opens with the unreferenced "SimpleMem" tag */' + NL)
b = '  script->SetAnimAttrib(2);' + NL + '  this->finishedAnim = finishedAnim;' + NL + '}' + NL
assert s.count(b) == 1
s = s.replace(b, '  script->SetAnimAttrib(2);' + NL + '  this->finishedAnim = finishedAnim;' + NL +
              '  /* OPEN ITEM (byte carrier): retail has an unreferenced EMPTY string literal (4 zero bytes @0x80056084) between' + NL +
              '   * "IMObj info" and the vtables, i.e. expanded somewhere after Object_InitIMassObjectInfo.  Which statement' + NL +
              '   * carried it is unknown; a compiled-out call here reproduces the bytes without touching the code. */' + NL +
              '  if (0) sprintf((char *)0,"");' + NL + '}' + NL)
if 'int sprintf' not in s and 'sprintf(' not in s.replace('if (0) sprintf', ''):
    i = s.index('#include')
    j = s.index(NL, s.rindex('#include')) + 1
    s = s[:j] + 'extern "C" int sprintf(char *, const char *, ...);' + NL + s[j:]
open(f, 'w', encoding='utf-8', newline='').write(s)

p = R + 'linkers/nfs4_recon.rodata_placement.json'
rows = json.load(open(p))
for r in rows:
    if r['obj'].endswith('game/common/object.cpp.o'):
        r['base'], r['end'] = 0x80056048, 0x80056100
        r['size'] = r['end'] - r['base']
json.dump(rows, open(p, 'w'), indent=1)
print('ok')
