"""symfn_cmp.py OURS.txt FUNCTION -- one function's debug records (dumpsym text) from OUR PSYLINK SYM next to the retail SYM:
frame (fsize / mask / maskoffs), and every local with its storage (REG number / AUTO offset), in declaration order, with
block nesting.  Addresses are shown relative to the function start so the two links compare directly."""
import re
import sys

RETAIL = 'C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt'


def grab(path, fn):
    L = open(path, errors='replace').read().splitlines()
    k = next(i for i, l in enumerate(L) if l.strip() == 'name = ' + fn)
    hdr = {}
    for l in L[k - 8:k]:
        m = re.match(r'\s+(\w+) = (\S+)', l)
        if m:
            hdr[m.group(1)] = m.group(2)
    start = None
    for l in L[k - 12:k]:
        m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) 8c', l)
        if m:
            start = int(m.group(1), 16)
    out, depth = [], 0
    for l in L[k + 1:]:
        m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) ([0-9a-f]{2}) (.*)$', l)
        if not m:
            continue
        a, t, rest = int(m.group(1), 16), m.group(2), m.group(3)
        if t == '8e':
            break
        if t == '90':
            out.append('%s{ +%03x %s' % ('  ' * depth, a - start, rest.split('line =')[-1].strip())); depth += 1
        elif t == '92':
            depth -= 1; out.append('%s} +%03x %s' % ('  ' * depth, a - start, rest.split('line =')[-1].strip()))
        elif t in ('94', '96'):
            m2 = re.search(r'class (\w+) type (.*?) size \d+.* name (\S+)$', rest)
            if m2:
                v = a if a < 0x80000000 else a - (1 << 32)
                where = ('$%d' % a) if m2.group(1) in ('REG', 'REGPARM') else ('sp%+d' % v if m2.group(1) in ('AUTO', 'ARG') else '%08x' % a)
                out.append('%s%-8s %-10s %s' % ('  ' * depth, m2.group(1), where, m2.group(3)))
    return hdr, out


ours, fn = sys.argv[1], sys.argv[2]
ho, o = grab(ours, fn)
hr, r = grab(RETAIL, fn)
print('%-46s | %s' % ('OURS', 'RETAIL'))
for k in ('fsize', 'mask', 'maskoffs', 'line'):
    print('%-46s | %s' % ('%s = %s' % (k, ho.get(k)), '%s = %s' % (k, hr.get(k))))
for i in range(max(len(o), len(r))):
    a = o[i] if i < len(o) else ''
    b = r[i] if i < len(r) else ''
    print('%-46s | %s' % (a[:46], b))
