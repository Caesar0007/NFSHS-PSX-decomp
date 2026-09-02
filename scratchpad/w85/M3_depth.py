"""M3_depth.py — depth-aware device search on the v2 (dropped-arg) JPN source.

Each of the TU's nine statement-expression sites can be OFF (0) or nested to
depth d (1..3): depth d = `({ ({ ... ; }); })` nested d times.  Depth 1 adds 5
RTL chain objects, each extra level ~4 more, so the ladder gives a FINER dial
than the 5-object on/off subset sweep.

usage:  python M3_depth.py one   <9 digits>       gate one config
        python M3_depth.py bump  <9 digits>       config + every single-site depth change
        python M3_depth.py list  <cfg> [cfg...]
"""
import sys, json
sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/w85')
import M3_lib as L

EXTRA = [('&itemTwoPlayerHotPursuit, &itemTwoPlayerPinkSlips, 0)',
          '&itemTwoPlayerHotPursuit, 0)', 1),
         ('&itemControllerShockImpact, &itemControllerDeadSpot1, &itemControllerDeadSpot2, 0)',
          '&itemControllerShockImpact, 0)', 1)]


def inner(on):
    """the `X` inside the site's `({ X; })`"""
    i = on.index('({ ')
    j = on.rindex('; })')
    return on[:i], on[i + 3:j], on[j + 4:]


def src(cfg):
    """cfg = string of 9 digits 0..3"""
    s = open(L.ROOT + L.BASE, encoding='utf-8', errors='replace').read()
    for i, (n, on, off) in enumerate(L.SITES):
        d = int(cfg[i])
        if s.count(on) != 1:
            raise SystemExit('site %s not unique' % n)
        if d == 0:
            s = s.replace(on, off, 1)
        elif d > 1:
            pre, mid, post = inner(on)
            new = pre + ('({ ' * d) + mid + ('; })' * d) + post
            s = s.replace(on, new, 1)
    for old, new, cnt in EXTRA:
        if s.count(old) != cnt:
            raise SystemExit('extra pattern miscount %r' % old[:50])
        s = s.replace(old, new)
    return s


def gate(cfg, path='scratchpad/w85/M3_depth_work.cpp'):
    L.write(src(cfg), path)
    return L.gate(path)[:3]


if __name__ == '__main__':
    cmd = sys.argv[1]
    if cmd == 'one':
        print(sys.argv[2], gate(sys.argv[2]))
    elif cmd == 'list':
        for c in sys.argv[2:]:
            print(c, gate(c), flush=True)
    elif cmd == 'bump':
        base = sys.argv[2]
        res = [(gate(base), base)]
        print(base, res[0][0], flush=True)
        for i in range(9):
            for d in range(4):
                if d == int(base[i]):
                    continue
                c = base[:i] + str(d) + base[i + 1:]
                r = gate(c)
                res.append((r, c))
                print(c, r, flush=True)
        res.sort(key=lambda x: (x[0][0] if x[0][0] is not None else 9e9))
        print('BEST', res[:6])
