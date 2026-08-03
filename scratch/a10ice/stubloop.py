"""Iteratively stub whichever function the instrumented cc1plus ICEs on, until
the whole TU compiles.  Prints the stub list.  Usage:
    python stubloop.py <in.i> <out.i> <cc1plus> "<flags>"  [maxrounds]
The ICE'ing function is read from cc1plus's own "In function `X':" line."""
import io, os, re, subprocess, sys

src, dst, cc, flags = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4].split()
maxr = int(sys.argv[5]) if len(sys.argv) > 5 else 8

cur = io.open(src, encoding='utf-8', newline='').read().split('\n')
stubbed = []


def stub(L, name):
    s = None
    for i, l in enumerate(L):
        if re.search(r'\b' + re.escape(name) + r'\s*\(', l) and not l.rstrip().endswith(';') \
           and re.match(r'^[A-Za-z_].*', l) and '=' not in l.split('(')[0]:
            # a definition line starts at column 0 and is not a call
            s = i
            break
    if s is None:
        return L, False
    o = None
    for i in range(s, min(s + 12, len(L))):
        if L[i].strip() == '{':
            o = i
            break
    if o is None:
        return L, False
    d = 0
    c = None
    for i in range(o, len(L)):
        d += L[i].count('{') - L[i].count('}')
        if d == 0:
            c = i
            break
    if c is None:
        return L, False
    return L[:o + 1] + ['}'] + L[c + 1:], True


for rnd in range(maxr):
    io.open(dst, 'w', encoding='utf-8', newline='').write('\n'.join(cur))
    p = subprocess.run([cc] + flags + [dst, '-o', dst[:-2] + '.s'],
                       capture_output=True, text=True, errors='replace')
    err = p.stdout + p.stderr
    if 'Internal compiler error' not in err:
        print('CLEAN after', rnd, 'stubs:', stubbed)
        break
    fns = re.findall(r"In function `(?:[\w\s:*&]*?\s)?(\w+)\(", err)
    if not fns:
        print('ICE but no function name; stop'); break
    bad = fns[-1]
    if bad in stubbed:
        print('re-ICE on already-stubbed', bad, '- stop'); break
    cur, ok = stub(cur, bad)
    if not ok:
        print('could not locate', bad, '- stop'); break
    stubbed.append(bad)
    print('round', rnd, 'stubbed', bad)
else:
    print('maxrounds reached; stubbed', stubbed)
print('STUBBED:', stubbed)
