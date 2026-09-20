"""symtree_parse.py -- the dumpsym-text parser shared by the SYM comparison tools (same code as symtree_cmp.py)."""
import json
import re
import sys
from collections import Counter
from pathlib import Path

RETAIL = 'C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt'
REC = re.compile(r'^[0-9a-f]+: \$([0-9a-f]{8}) ([0-9a-f]{2}) (.*)$')
DEF = re.compile(r'class (\w+) type (.*?) size (\d+)(?: dims .*?)?(?: tag (\S*))? name (\S+)$')


def parse(path):
    fns, cur, hdr_mode = {}, None, False
    for l in open(path, errors='replace'):
        l = l.rstrip('\n')
        m = REC.match(l)
        if not m:
            if cur is not None and hdr_mode:
                h = re.match(r'\s+(\w+) = (.*)$', l)
                if h:
                    cur['hdr'][h.group(1)] = h.group(2).strip()
                    if h.group(1) == 'name':
                        hdr_mode = False
                        nm = cur['hdr']['name']
                        if nm.startswith('___'):      # the lane spells cfront destructors EA's way (___X); retail's SYM says _._X
                            nm = '_._' + nm[3:]
                        fns.setdefault(nm, cur)
            continue
        a, t, rest = int(m.group(1), 16), m.group(2), m.group(3)
        if t == '8c':
            cur = {'start': a, 'hdr': {}, 'locals': [], 'blocks': [], 'depth': 0, 'end_line': None}
            hdr_mode = True
        elif cur is None:
            continue
        elif t == '8e':
            k = re.search(r'line (\d+)', rest)
            cur['end_line'] = int(k.group(1)) if k else None
            cur = None
        elif t == '90':
            cur['blocks'].append(('{', cur['depth'], a - cur['start'])); cur['depth'] += 1
        elif t == '92':
            cur['depth'] -= 1; cur['blocks'].append(('}', cur['depth'], a - cur['start']))
        elif t in ('94', '96'):
            d = DEF.search(rest)
            if d and d.group(1) in ('REG', 'REGPARM', 'AUTO', 'ARG', 'STAT'):
                v = a if a < 0x80000000 else a - (1 << 32)
                home = d.group(1) + (':$%d' % a if d.group(1) in ('REG', 'REGPARM') else ':sp%+d' % v if d.group(1) in ('AUTO', 'ARG') else '')
                # anonymous tags are numbered per TU (`._148`): the number counts every unnamed type seen before, not comparable
                ty = re.sub(r'\._\d+', '._N', (d.group(2) + ' ' + (d.group(4) or '')).strip())
                cur['locals'].append((d.group(5), home, ty, cur['depth']))
    return fns


