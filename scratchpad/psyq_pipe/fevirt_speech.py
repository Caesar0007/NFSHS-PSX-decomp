"""Real C++ virtuals, step 7 (2026-09-20): the SPEECH family -- Speech::Speaker / MobileSpeaker / DispatchSpeaker, the last
hand-made vtables (three 31-slot tables written out at the end of speech.cpp; 30 virtuals, NO destructor slot).
Phase 1 (this script):
  * speech_speaker_virtuals.inc = the 30 virtuals in retail slot order (asm labels keep the nested-class manglings
    `X__Q26Speech7Speaker...` for now; real nesting is the follow-up);
  * every surface's `struct Speaker` (8 headers) includes it where `_vf` was; its own declarations/definitions of those 30
    names and the `VirtualX()` bridges are removed;
  * sources: `VirtualX(` -> `X(` (the bridges WERE the dynamic calls; plain calls stay what they were)."""
import glob
import re

R = 'C:/Temp/nfs4-decomp/recon/game/common/'
NL = chr(10)
SLOTS = [('void', 'Report', 'Car_tObj *cop', 'P8Car_tObj'), ('void', 'Status', '', ''), ('void', 'Deny', '', ''), ('void', 'Grant', '', ''),
         ('void', 'Ready', 'Car_tObj *wing', 'P8Car_tObj'), ('void', 'Engage', 'Car_tObj *perp', 'P8Car_tObj'), ('void', 'Lose', '', ''),
         ('void', 'Accident', 'int slice', 'i'), ('void', 'Catch', 'int ticket', 'i'), ('void', 'RoadBlock', '', ''), ('void', 'SpikeBelt', '', ''),
         ('void', 'Backup', '', ''), ('void', 'ReportBlockade', '', ''), ('void', 'Roger', '', ''), ('void', 'Bullhorn', '', ''), ('void', 'Purge', '', ''),
         ('int', 'Unit', '', ''), ('bool', 'KnownPerp', 'Car_tObj *car', 'P8Car_tObj'), ('void', 'ClearPerp', 'Car_tObj *car', 'P8Car_tObj'),
         ('bool', 'IsSuper', '', ''), ('int', 'StatusCount', '', ''), ('Speaker *', 'StatusSub', '', ''), ('void', 'PurgeStatusSub', '', ''),
         ('int', 'DistToPerp', '', ''), ('Car_tObj *', 'CarObj', '', ''), ('void', 'ReActivate', '', ''), ('Car_tObj *', 'Perp', '', ''),
         ('CarBank *', 'GetCarBank', 'int carIndex', 'i'), ('LocationBank *', 'FindClosestLocationTo', 'int slice', 'i'),
         ('CallSignBank *', 'CallSign', '', '')]
NAMES = [s[1] for s in SLOTS]
inc = ['/* game/common/speech_speaker_virtuals.inc -- Speech::Speaker\'s 30 virtuals in retail SLOT order (table 0x80055DC4; there',
       ' * is no destructor slot).  A member-declaration fragment included by every surface\'s `struct Speaker` where the hand-made',
       ' * `_vf` member was.  The asm labels carry the nested-class manglings until the classes are really nested in Speech. */']
for ret, name, args, mang in SLOTS:
    sp = '' if ret.endswith('*') else ' '
    inc.append('    virtual %s%s%s(%s) asm("%s__Q26Speech7Speaker%s");' % (ret, sp, name, args, name, mang))
open(R + 'speech_speaker_virtuals.inc', 'w', encoding='utf-8', newline='').write(NL.join(inc) + NL)

NAME_RE = re.compile(r'\b(?:Virtual)?(' + '|'.join(NAMES) + r')\s*\(')


def strip_members(body):
    """remove every member declaration/definition whose name is one of the 30 (or its Virtual bridge), at depth 0"""
    out, i, n = '', 0, len(body)
    while True:
        m = NAME_RE.search(body, i)
        if not m:
            out += body[i:]
            return out
        # depth of m.start() relative to the body
        depth = body.count('{', 0, m.start()) - body.count('}', 0, m.start())
        if depth != 0:
            out += body[i:m.end()]
            i = m.end()
            continue
        st = max(body.rfind(';', 0, m.start()), body.rfind('}', 0, m.start()), body.rfind('*/', 0, m.start()) + 1, -1) + 1
        st = max(st, i)
        j = m.end()
        par = 1
        while par:
            par += body[j] == '('
            par -= body[j] == ')'
            j += 1
        k = j
        while body[k] not in ';{':
            k += 1
        if body[k] == '{':
            d = 1
            k += 1
            while d:
                d += body[k] == '{'
                d -= body[k] == '}'
                k += 1
        else:
            k += 1
        out += body[i:st]
        i = k
    return out


for h in sorted(glob.glob(R + '*_types.h')):
    s = open(h, encoding='utf-8').read()
    m = re.search(r'^struct Speaker \{\n', s, re.M)
    if not m:
        continue
    i, depth = m.end(), 1
    while depth:
        depth += s[i] == '{'
        depth -= s[i] == '}'
        i += 1
    body = s[m.end():i - 1]
    if '_vf' not in body:
        print('   no _vf:', h.split('/')[-1].split('\\')[-1])
        continue
    body = strip_members(body)
    body, k = re.subn(r'[ \t]*__vtbl_ptr_type \(\*_vf\)\[31\];[^\n]*\n', '#include "speech_speaker_virtuals.inc"' + NL, body, count=1)
    assert k == 1, h
    pre = '' if re.search(r'^struct CallSignBank\b', s[:m.start()], re.M) else 'struct CallSignBank;' + NL
    pre += '' if re.search(r'^struct LocationBank\b', s[:m.start()], re.M) else 'struct LocationBank;' + NL
    pre += '' if re.search(r'^struct CarBank\b', s[:m.start()], re.M) else 'struct CarBank;' + NL
    s = s[:m.start()] + pre + s[m.start():m.end()] + body + s[i - 1:]
    open(h, 'w', encoding='utf-8', newline='').write(s)
    print('converted', h.replace('\\', '/').split('/')[-1])

for f in glob.glob(R + '*.cpp'):
    s = open(f, encoding='utf-8').read()
    s2, k = re.subn(r'\bVirtual(' + '|'.join(NAMES) + r')\(', r'\1(', s)
    if k:
        open(f, 'w', encoding='utf-8', newline='').write(s2)
        print('%3d bridge calls -> real virtual calls  %s' % (k, f.replace('\\', '/').split('/')[-1]))
