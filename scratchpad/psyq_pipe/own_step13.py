"""Blob ownership step 13 (2026-09-19) -- two more objects read their OWN literals through dump labels:
  aidatarecord.cpp  .rodata 0x800553AC..0x8005542C  "SimpleMem", the seven record file-name formats and the
        unreferenced "%sTr%02d%c.ctk" that closes the run (a compiled-out record kind)
  textsys.cpp       .rodata 0x800565E4..0x80056638  "SimpleMem" + the six "text.xxx" names of langFileName[]; retail has
        the tag FIRST, so the pointer table is defined after the first function (a file-scope initializer ahead of every
        function would put its strings first)"""
import json
import re

R = 'C:/Temp/nfs4-decomp/'


def rd(f):
    return open(R + f, encoding='utf-8').read()


def wr(f, s):
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


# ---------------------------------------------------------------- aidatarecord
FMT = {'D_800553B8': '%s%s.acc', 'D_800553C4': '%sTr%02d.qbe', 'D_800553D4': '%sTr%02d.bes', 'D_800553E4': '%sTr%02d.qcr',
       'D_800553F4': '%sTr%02d.crv', 'D_80055404': '%s%s.qcs', 'D_80055410': '%s%s.csp'}
s = rd('recon/game/common/aidatarecord.cpp')
for lab, lit in FMT.items():
    assert len(re.findall(r'\b' + lab + r'\b', s)) == 1, lab
    s = re.sub(r'\b' + lab + r'\b', '"' + lit + '"', s)
# SimpleMem head: top of the function that holds the first format
i = s.index('"%s%s.acc"')
brace = s.rfind('\n{\n', 0, i)
assert brace > 0
s = (s[:brace + 3] + '  /* retail aidatarecord.obj .rodata opens with the unreferenced "SimpleMem" tag (0x800553AC) */\n'
     '  if (0) sprintf((char *)0,"SimpleMem");\n' + s[brace + 3:])
# the dead .ctk format right after the .csp use
m = re.search(r'\n([ \t]*)sprintf\(this->name_,"%s%s\.csp"[^;]*;\n', s)
assert m
s = (s[:m.end()] + m.group(1) + '/* retail keeps an UNREFERENCED "%sTr%02d%c.ctk" (0x8005541C) after ".csp": a compiled-out record kind */\n'
     + m.group(1) + 'if (0) sprintf((char *)0,"%sTr%02d%c.ctk");\n' + s[m.end():])
wr('recon/game/common/aidatarecord.cpp', s)
h = rd('recon/game/common/aidatarecord_externs.h')
h, n = re.subn(r'^extern char\s+D_800553(?:B8|C4|D4|E4|F4)\[\];[^\n]*\n|^extern char\s+D_8005540(?:4)\[\];[^\n]*\n|^extern char\s+D_80055410\[\];[^\n]*\n', '', h, flags=re.M)
assert n == 7, n
wr('recon/game/common/aidatarecord_externs.h', h)

# ---------------------------------------------------------------- textsys
s = rd('recon/game/common/textsys.cpp')
old = re.search(r'extern char D_800565F0\[\];\n(?:extern char D_8005[0-9A-F]+\[\];\n){5}char \*langFileName\[6\] = \{\n[^}]*\};\n', s)
assert old, 'langFileName block'
s = s.replace(old.group(0), 'extern char *langFileName[6];   /* defined after the first function (see below) */\n')
sig = 'void TextSys_LoadWordsGeneric(int language,char *path)\n'
assert s.count(sig) == 1
i = s.index(sig)
j = s.index('{', i) + 1
s = (s[:j] + '\n  /* retail Textsys.obj .rodata opens with the unreferenced "SimpleMem" tag (0x800565E4) */\n'
     '  if (0) sprintf((char *)0,"SimpleMem");\n' + s[j:])
# end of that function = first "\n}\n" after it
k = s.index('\n}\n', j) + 3
s = (s[:k] + '\n/* Textsys.obj: the language file names (.rodata 0x800565F0..) and their pointer table (.data).  Defined HERE, after\n'
     '   the first function, because retail emits the "SimpleMem" tag ahead of these strings. */\n'
     'char *langFileName[6] = {\n  "text.eng", "text.ger", "text.fre",\n  "text.spa", "text.ita", "text.swe"\n};\n' + s[k:])
if not re.search(r'\bsprintf\b', s.replace('if (0) sprintf', '')):
    incs = [m.end() for m in re.finditer(r'^#include[^\n]*\n', s, re.M)]
    s = s[:incs[-1]] + 'extern "C" int sprintf(char *, const char *, ...);\n' + s[incs[-1]:]
wr('recon/game/common/textsys.cpp', s)

p = R + 'linkers/nfs4_recon.rodata_placement.json'
rows = json.load(open(p))
rows = [r for r in rows if not (r['obj'].endswith('game/common/aidatarecord.cpp.o') or r['obj'].endswith('game/common/textsys.cpp.o'))]
rows.append({'obj': 'build/recon/game/common/aidatarecord.cpp.o', 'base': 0x800553AC, 'end': 0x8005542C, 'size': 0x80, 'ok': False, 'regions': []})
rows.append({'obj': 'build/recon/game/common/textsys.cpp.o', 'base': 0x800565E4, 'end': 0x80056638, 'size': 0x54, 'ok': False, 'regions': []})
json.dump(rows, open(p, 'w'), indent=1)
