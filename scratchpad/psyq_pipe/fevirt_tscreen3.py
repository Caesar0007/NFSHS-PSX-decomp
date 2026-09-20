"""fevirt_tscreen.py phase 2c: screencarselect.cpp's extended-slot carriers.
  `vtbl = this->_vf; (*vtbl[1][K].pfn)(RECEIVER-with-vtbl[1][K].delta [, args])`   and
  `(*(*(this->_vf + 1))[K].pfn)(RECEIVER-with-...delta [, args])`
are slot 10+K of the car-select family: 10 DrawVideoWall, 11 InitializeVideoWall, 12 UpdateVideoWall, 13 GetCar,
14 AllocateAsyncBuffer, 15 FreeAsyncBuffer, 16/17 class-specific (reported, not rewritten)."""
import re
import sys

R = 'C:/Temp/nfs4-decomp/recon/frontend/common/'
F = sys.argv[1] if len(sys.argv) > 1 else 'screencarselect.cpp'
NAMES = {0: 'DrawVideoWall', 1: 'InitializeVideoWall', 2: 'UpdateVideoWall', 3: 'GetCar', 4: 'AllocateAsyncBuffer', 5: 'FreeAsyncBuffer'}
s = open(R + F, encoding='utf-8').read()
HEAD = re.compile(r'\(\*\s*(?:\([^()]*\(\*\)\s*\([^()]*\)\)\s*)?(?:vtbl\[1\]\[(\d+)\]|\(\*\(this->_vf \+ 1\)\)\[(\d+)\])\.pfn\)\s*\(')


def split_args(t):
    out, depth, cur = [], 0, ''
    for c in t:
        if c == ',' and depth == 0:
            out.append(cur)
            cur = ''
            continue
        depth += c in '([{'
        depth -= c in ')]}'
        cur += c
    out.append(cur)
    return [a.strip() for a in out]


res, pos, done = '', 0, 0
for m in HEAD.finditer(s):
    if m.start() < pos:
        continue
    k = int(m.group(1) or m.group(2))
    i, depth = m.end(), 1
    while depth:
        depth += s[i] == '('
        depth -= s[i] == ')'
        i += 1
    args = split_args(s[m.end():i - 1])
    if k not in NAMES or '.delta' not in args[0]:
        print('NOT REWRITTEN (slot %d) at offset %d: %s' % (10 + k, m.start(), s[m.start():i][:100].replace(chr(10), ' ')))
        continue
    rest = [a[1:].strip() if re.match(r'^&\s*\w+$', a) else a for a in args[1:]]
    res += s[pos:m.start()] + 'this->%s(%s)' % (NAMES[k], ','.join(rest))
    pos = i
    done += 1
res += s[pos:]
res, n1 = re.subn(r'^[ \t]*vtbl = this->_vf;\n', '', res, flags=re.M)
res, n2 = re.subn(r'^[ \t]*__vtbl_ptr_type \(\*\s*vtbl\)\s*\[\d+\];[^\n]*\n', '', res, flags=re.M)
open(R + F, 'w', encoding='utf-8', newline='').write(res)
print('%s: %d sites, %d vtbl loads, %d vtbl decls removed' % (F, done, n1, n2))
