"""Blob ownership step 21 (2026-09-20) -- libgpu SYS.obj's last unowned literal, "LoadImage2" @0x80056EEC.
Checked against the claim "0x800EDE00..0x800EE2DC holds ~6 dead debug functions": NOT true for nfs4-f.exe -- that range
is the body of ONE function, PutDispEnv (0x800EDDE4, a single prologue, a single `jr ra` at 0x800EE2D4), already
reconstructed byte-exact.  Retail SYS.obj has NO code for SetGraphDebug / DrawSyncCallback / ClearImage2 / ClearOTag /
DrawOTagEnv / LoadImage2; what it has is their STRINGS, which CC1PSX leaves behind for unused `static inline` functions
(SYS.c already models five of them that way).  "LoadImage2" follows the "GPU timeout" literal, so its inline is defined
after that function in sys.c 1.140."""
import json

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
f = R + 'recon/syslib/psx/libgpu/SYS.c'
s = open(f, encoding='utf-8').read()
a = '/* @0x800EFC70 : reconfigure the GPU display registers for the current video mode. */' + NL
assert s.count(a) == 1 and 'LoadImage2' not in s
s = s.replace(a,
              '/* Retail SYS.obj has NO LoadImage2 code, only its "LoadImage2" literal (0x80056EEC), right after the "GPU timeout"' + NL +
              ' * string: the same leftover of an UNUSED static inline as ClearImage2 above -- defined at this point of sys.c 1.140. */' + NL +
              'static __inline__ int LoadImage2(void *rect, u_long *data)' + NL + '{' + NL +
              '    _image("LoadImage2", rect);                  /* @0x80056eec (string only) */' + NL +
              '    return GEnv_drv->que_push(GEnv_drv->dws, (u_long *)rect, 8, (int)data);' + NL + '}' + NL + NL + a)
open(f, 'w', encoding='utf-8', newline='').write(s)

p = R + 'linkers/nfs4_recon.rodata_extra.json'
rows = json.load(open(p))
n = 0
for r in rows:
    if r['obj'].endswith('syslib/psx/libgpu/SYS.c.o') and r.get('section') == '.rodata':
        r['end'] = 0x80056EF7
        r['size'] = r['end'] - r['base']
        n += 1
assert n == 1
json.dump(rows, open(p, 'w'), indent=1)
print('ok')
