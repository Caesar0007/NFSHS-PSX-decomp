#!/usr/bin/env python3
"""D2_census.py FILE...  -- comment-masked census of __asm__ / volatile device sites."""
import re, sys
from pathlib import Path

def mask_comments(t):
    out = []
    i = 0
    n = len(t)
    while i < n:
        if t.startswith('/*', i):
            j = t.find('*/', i + 2)
            j = n if j < 0 else j + 2
            out.append(re.sub(r'[^\n]', ' ', t[i:j]))
            i = j
        elif t.startswith('//', i):
            j = t.find('\n', i)
            j = n if j < 0 else j
            out.append(' ' * (j - i))
            i = j
        else:
            out.append(t[i])
            i += 1
    return ''.join(out)

for f in sys.argv[1:]:
    p = Path(f)
    src = p.read_text(encoding='utf-8', errors='surrogateescape')
    m = mask_comments(src)
    lines = m.split('\n')
    raw = src.split('\n')
    print(f'===== {f}')
    for idx, ln in enumerate(lines, 1):
        if re.search(r'__asm__|\basm\b|volatile', ln):
            print(f'{idx:6d}: {raw[idx-1].strip()[:150]}')
