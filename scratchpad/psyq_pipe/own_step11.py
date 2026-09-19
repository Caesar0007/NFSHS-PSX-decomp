"""Blob ownership step 11 (2026-09-19) -- owners from the RACE runtime trace (tools/duckstation, checkpoint race_start):
  eacpsxz fixdsqrt.c  .data 0x801234EC..0x801235F4  fixedsqrt's tables: 32 scale values ending at D_8012356C (the routine
        walks them BACKWARD from that label) + 34 offset values after it.  gprefs.py could not see the users because the
        handwritten routine indexes through a computed base; the trace shows fixedsqrt (called from Math_Normalize*,
        Newton_InitBaseNewtonObj) as the only code touching the block.
  spchpsxz spchrand.c .data 0x801235F4..0x8012360C  seedX[6], the speech library's own PRNG state (same seed as random.c)"""
import json
import sys

sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/psyq_pipe')
from gen_cdata import initializer  # noqa: E402

R = 'C:/Temp/nfs4-decomp/'


def edit(f, pairs):
    s = open(R + f, encoding='utf-8').read()
    for a, b in pairs:
        assert s.count(a) == 1, (f, a[:70], s.count(a))
        s = s.replace(a, b)
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


def row(rows, obj, base, size):
    rows[:] = [r for r in rows if not (r['obj'] == obj and r['section'] == '.data')]
    rows.append({'obj': obj, 'section': '.data', 'base': base, 'end': base + size, 'size': size, 'ok': True,
                 'unresolved': 0, 'words': size // 4, 'q': 0})


scale, ns = initializer(0x801234EC, 0x8012356C - 0x801234EC, 'u32')
offs, no = initializer(0x8012356C, 0x801235F4 - 0x8012356C, 'u32')
edit('recon/eaclib/psx/eacpsxz/fixdsqrt.c', [
    ('extern int D_8012356C;   /* @0x8012356C : base of the fixdsqrt scale/offset tables (data blob owns it) */\n',
     '/* D_8012356C (@0x8012356C, the base between the scale and offset tables) is DEFINED after the handwritten block. */\n'),
    ('    "\\t.set at\\n"\n    "\\t.set reorder\\n"\n);\n#else\n',
     '    "\\t.set at\\n"\n    "\\t.set reorder\\n"\n);\n'
     '/* fixdsqrt.obj .data 0x801234EC..0x801235F4, owned here since 2026-09-19 (runtime trace from a race: fixedsqrt is\n'
     ' * the only code touching it).  The routine takes D_8012356C as its base and walks the scale table backward from\n'
     ' * it, so the two arrays must stay adjacent and in this order. */\n'
     'unsigned int fixdsqrt_scale[%d] = ' % ns + scale + ';\n'
     'unsigned int D_8012356C[%d] = ' % no + offs + ';\n'
     '#else\n'),
])
edit('recon/eaclib/psx/spchpsxz/spchrand.c', [
    ('#define DAT_801235f8  seedX[1]\n',
     '/* spchrand.obj .data 0x801235F4, owned here since 2026-09-19 (same initial state as eacpsxz random.c\'s seed) */\n'
     'unsigned int seedX[6] = {\n'
     '    0xF22D0E56u, 0x883126E9u, 0xC624DD2Fu, 0x0702C49Cu, 0x9E353F7Du, 0x6FDF3B64u\n'
     '};\n'
     '#define DAT_801235f8  seedX[1]\n'),
])

p = R + 'linkers/nfs4_recon.data_extra.json'
rows = json.load(open(p))
row(rows, 'build/recon/eaclib/psx/eacpsxz/fixdsqrt.c.o', 0x801234EC, 0x801235F4 - 0x801234EC)
row(rows, 'build/recon/eaclib/psx/spchpsxz/spchrand.c.o', 0x801235F4, 0x18)
json.dump(rows, open(p, 'w'), indent=1)
