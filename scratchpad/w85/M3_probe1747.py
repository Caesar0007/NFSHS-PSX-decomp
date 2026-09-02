"""M3_probe1747.py — 2-D scan for the menuCarUpgrades (call 135) tie-break.

Indicator, independent of instruction count and of the frame: in the JPN oracle
`addiu a0,tX,7988` (a0 = this + 0x1F34 = &menuCarUpgrades) is the instruction
IMMEDIATELY before its `jal` (delta 1); in our builds it is emitted 9 insns
earlier (delta 9) and the `%hi(screenCarSelect)` scratch is t1 instead of v0.

Also reports the frame size, so the FEApp-hoist state (632 = hoisted) is visible.

usage: python M3_probe1747.py <cfg9> [cfg9 ...]
"""
import re, sys
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/w85')
import M3_score as S


def probe(stream):
    idx = [i for i, (t, k) in enumerate(stream) if re.match(r'^addiu a0,\w+,7988$', t)]
    if not idx:
        return ('no-site', None, None)
    i = idx[0]
    j = next((j for j in range(i, len(stream)) if stream[j][0].startswith('jal')), None)
    frame = None
    m = re.match(r'^addiu sp,sp,(-\d+)$', stream[0][0])
    if m:
        frame = -int(m.group(1))
    return (j - i if j else None, stream[i][0], frame)


if __name__ == '__main__':
    for cfg in sys.argv[1:]:
        st = S.build(cfg)
        d, txt, fr = probe(st)
        n, ln, err, bad = (None, len(st), '', [])
        if len(st) == len(S.ORACLE):
            n, ln, err, bad = S.score(cfg) if False else (None, len(st), '', [])
        print('%s  insns=%d frame=%s  a0->jal delta=%s (%s)' % (cfg, len(st), fr, d, txt), flush=True)
