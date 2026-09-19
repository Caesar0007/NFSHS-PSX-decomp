"""Blob ownership step 15 (2026-09-19) -- the head of the FRONT overlay's read-only data, 0x80010000..0x80010078.
Three objects read their own literals as `bigBuf + offset` (bigBuf = the overlay load address 0x80010000) or through dump
labels.  They are ordinary literals:
  minfront.cpp  0x80010000  "SimpleMem", "FE Data Stream" (the name handed to reservememadr)
  fe3dmenu.cpp  0x80010020  "SimpleMem", CameraLookAt's up-vector {0,0x10000,0} (local brace initializer)
  feapp.cpp     0x80010038  "SimpleMem", "%ld", "%d/%d", "zmenu*", "garage*", "showcase*", "victory*", then its jump table"""
import json
import re

R = 'C:/Temp/nfs4-decomp/'
TAG = '  if (0) sprintf((char *)0,"SimpleMem");   /* retail: this object\'s .rodata opens with the unreferenced "SimpleMem" tag */\n'


def edit(f, pairs, need_sprintf=False):
    s = open(R + f, encoding='utf-8').read()
    for a, b in pairs:
        assert s.count(a) == 1, (f, a[:70], s.count(a))
        s = s.replace(a, b)
    if need_sprintf and not re.search(r'\bsprintf\s*\(', s.replace('if (0) sprintf', '')) and 'int sprintf' not in s:
        incs = [m.end() for m in re.finditer(r'^#include[^\n]*\n', s, re.M)]
        s = s[:incs[-1]] + 'extern "C" int sprintf(char *, const char *, ...);\n' + s[incs[-1]:]
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


edit('recon/game/common/minfront.cpp', [
    ('  int *stream;\n  \n  stream = reservememadr((char *)(bigBuf + 0xc),0x2000,0x10);\n',
     '  int *stream;\n\n' + TAG +
     '  stream = reservememadr("FE Data Stream",0x2000,0x10);   /* literal @0x8001000C */\n'),
], True)
edit('recon/game/psx/fe3dmenu.cpp', [
    ('  coorddef upVec;\n  \n  upVec = *(coorddef*)((char*)bigBuf + 44);\n',
     '  coorddef upVec = { 0, 0x10000, 0 };   /* local aggregate initializer: its constant is retail .rodata 0x8001002C */\n\n'),
], True)
# the tag must precede the vector: first non-leaf function of fe3dmenu is Fe3D_InitShowroom
s = open(R + 'recon/game/psx/fe3dmenu.cpp', encoding='utf-8').read()
m = re.search(r'\n[^\n]*Fe3D_InitShowroom\s*\(void\)\s*\n\s*\{\n', s)
assert m and len(re.findall(r'\n[^\n]*Fe3D_InitShowroom\s*\(void\)\s*\n\s*\{\n', s)) == 1
s = s[:m.end()] + TAG + s[m.end():]
open(R + 'recon/game/psx/fe3dmenu.cpp', 'w', encoding='utf-8', newline='').write(s)

edit('recon/frontend/common/feapp.cpp', [
    ('  /* MATCH: retail keeps these adjacent format strings as distinct symbols.  Expressing both as\n'
     '     bigBuf offsets lets GCC common their base into a long-lived saved register (152 diffs). */\n'
     '  sprintf(buffer,D_80010044,largestunused());\n',
     '  sprintf(buffer,"%ld",largestunused());   /* literal @0x80010044 */\n'),
    ('  sprintf(buffer,D_80010048,AudioMus_Buffered(),AudioMus_Threshold());\n',
     '  sprintf(buffer,"%d/%d",AudioMus_Buffered(),AudioMus_Threshold());   /* literal @0x80010048 */\n'),
    ('AudioMus_PlaySong((char *)(bigBuf + 0x50));', 'AudioMus_PlaySong("zmenu*");'),
    ('AudioMus_PlaySong((char *)(bigBuf + 0x58));', 'AudioMus_PlaySong("garage*");'),
    ('AudioMus_PlaySong((char *)(bigBuf + 0x60));', 'AudioMus_PlaySong("showcase*");'),
    ('AudioMus_PlaySong((char *)(bigBuf + 0x6c));', 'AudioMus_PlaySong("victory*");'),
])
s = open(R + 'recon/frontend/common/feapp.cpp', encoding='utf-8').read()
pat = r'\ntFEApplication::tFEApplication\s*\([^)]*\)[^{]*\{\n'
ms = re.findall(pat, s)
assert len(ms) == 1, len(ms)
m = re.search(pat, s)
s = s[:m.end()] + TAG + s[m.end():]
open(R + 'recon/frontend/common/feapp.cpp', 'w', encoding='utf-8', newline='').write(s)
h = open(R + 'recon/frontend/common/feapp_externs.h', encoding='utf-8').read()
h, n = re.subn(r'^extern char\s+D_8001004[48]\[\];[^\n]*\n', '', h, flags=re.M)
assert n == 2
open(R + 'recon/frontend/common/feapp_externs.h', 'w', encoding='utf-8', newline='').write(h)

p = R + 'linkers/nfs4_recon.rodata_placement.json'
rows = json.load(open(p))
NEW = {'game/common/minfront': (0x80010000, 0x8001001B), 'game/psx/fe3dmenu': (0x80010020, 0x80010038),
       'frontend/common/feapp': (0x80010038, 0x80010098)}
rows = [r for r in rows if not any(r['obj'].endswith(k + '.cpp.o') for k in NEW)]
for k, (b, e) in NEW.items():
    rows.append({'obj': 'build/recon/%s.cpp.o' % k, 'base': b, 'end': e, 'size': e - b, 'ok': False, 'regions': []})
json.dump(rows, open(p, 'w'), indent=1)
