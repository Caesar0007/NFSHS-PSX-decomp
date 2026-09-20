"""fevirt_speech.py phase 2c: the cached-table carriers in speech.cpp.
    VAR = RECV->_vf;   ...   (*(*VAR)[K].pfn)(<receiver + (*VAR)[K].delta> [, args])
is a virtual call on RECV.  Each call is rewritten to RECV->Name(args) using the most recent `VAR = RECV->_vf;` before
it; those assignments and the now-unused table locals are removed.  MOBILE_SPEAKER_COORD(self, slot, off) spelled the
same thing for two slots (0x19 = CarObj, 0x1b = Perp) and becomes a plain member call."""
import re

R = 'C:/Temp/nfs4-decomp/recon/game/common/'
NAMES = ['', 'Report', 'Status', 'Deny', 'Grant', 'Ready', 'Engage', 'Lose', 'Accident', 'Catch', 'RoadBlock', 'SpikeBelt', 'Backup',
         'ReportBlockade', 'Roger', 'Bullhorn', 'Purge', 'Unit', 'KnownPerp', 'ClearPerp', 'IsSuper', 'StatusCount', 'StatusSub',
         'PurgeStatusSub', 'DistToPerp', 'CarObj', 'ReActivate', 'Perp', 'GetCarBank', 'FindClosestLocationTo', 'CallSign']
s = open(R + 'speech.cpp', encoding='utf-8').read()
ASSIGN = re.compile(r'^[ \t]*(\w+) = ([\w>\-\.\[\]]+?)->_vf;\n', re.M)
CALL = re.compile(r'\(\*\s*(?:\([^()]*\(\*\)\s*\([^()]*\)\)\s*)?\(\*(\w+)\)\[(0[xX][0-9a-fA-F]+|\d+)\]\.pfn\)\s*\(')


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


assigns = [(m.start(), m.group(1), m.group(2)) for m in ASSIGN.finditer(s)]
res, pos, done = '', 0, 0
for m in CALL.finditer(s):
    if m.start() < pos:
        continue
    var, k = m.group(1), int(m.group(2), 0)
    prior = [a for a in assigns if a[0] < m.start() and a[1] == var]
    if not prior or k >= len(NAMES):
        continue
    recv = prior[-1][2]
    i, depth = m.end(), 1
    while depth:
        depth += s[i] == '('
        depth -= s[i] == ')'
        i += 1
    args = split_args(s[m.end():i - 1])
    rest = [a[1:].strip() if re.match(r'^&\s*\w+$', a) else a for a in args[1:]]
    res += s[pos:m.start()] + '%s->%s(%s)' % (recv, NAMES[k], ','.join(rest))
    pos = i
    done += 1
s = res + s[pos:]
s, n1 = ASSIGN.subn('', s)
s, n2 = re.subn(r'^[ \t]*__vtbl_ptr_type \(\*\s*\w+\)\s*\[31\];[^\n]*\n', '', s, flags=re.M)
a = s.index('#define MOBILE_SPEAKER_COORD(self, slot, offset) \\')
b = s.index('\n\n', a)
s = (s[:a] + '/* a coordinate of the car a virtual accessor returns (CarObj / Perp) */\n'
     '#define MOBILE_SPEAKER_COORD(self, getter, offset) \\\n  (*(int *)((int)self->getter() + (offset)))' + s[b:])
s, n3 = re.subn(r'MOBILE_SPEAKER_COORD\((\w+), 0x19,', r'MOBILE_SPEAKER_COORD(\1, CarObj,', s)
s, n4 = re.subn(r'MOBILE_SPEAKER_COORD\((\w+), 0x1b,', r'MOBILE_SPEAKER_COORD(\1, Perp,', s)
open(R + 'speech.cpp', 'w', encoding='utf-8', newline='').write(s)
print('calls', done, 'assigns removed', n1, 'table locals removed', n2, 'macro uses', n3 + n4)
