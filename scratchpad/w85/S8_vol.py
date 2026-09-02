#!/usr/bin/env python
"""S8_vol.py <file.c> [--only LINES] -- strip `volatile` from CODE lines of a recon TU
(comment lines untouched), run tools/tugate.py, print the result, then RESTORE the file.
--only 12,34  strips volatile only on those 1-based line numbers.
--keep-mmio   keeps any line mentioning 0x1F80 or a known MMIO base var.
Never leaves the file modified (restores from the in-memory original in a finally:).
"""
import re, subprocess, sys, os

path = sys.argv[1]
only = None
keep_mmio = '--keep-mmio' in sys.argv
if '--only' in sys.argv:
    only = set(int(x) for x in sys.argv[sys.argv.index('--only') + 1].split(','))

orig = open(path, encoding='utf-8', errors='surrogateescape').read()
lines = orig.split('\n')
out = []
touched = []
in_block = False
for i, l in enumerate(lines, 1):
    s = l.strip()
    was_in_block = in_block
    # crude but sufficient block-comment tracker (no strings contain /* here)
    j = 0
    while j < len(l) - 1:
        if not in_block and l[j] == '/' and l[j + 1] == '*':
            in_block = True; j += 2; continue
        if in_block and l[j] == '*' and l[j + 1] == '/':
            in_block = False; j += 2; continue
        if not in_block and l[j] == '/' and l[j + 1] == '/':
            break
        j += 1
    is_comment = was_in_block or s.startswith('/*') or s.startswith('//')
    if ('volatile' in l and not is_comment and '__asm__' not in l
            and (only is None or i in only)
            and not (keep_mmio and '0x1F80' in l.upper())):
        out.append(l.replace('volatile ', '').replace('volatile', ''))
        touched.append(i)
    else:
        out.append(l)
try:
    open(path, 'w', encoding='utf-8', errors='surrogateescape').write('\n'.join(out))
    r = subprocess.run(['python', 'tools/tugate.py', path], capture_output=True, text=True)
    txt = r.stdout + r.stderr
    print('stripped lines:', touched)
    for ln in txt.splitlines():
        if 'PASS' in ln or (ln.strip() and ln.strip()[0].isdigit()) or 'error' in ln.lower():
            print('  ' + ln.strip())
finally:
    open(path, 'w', encoding='utf-8', errors='surrogateescape').write(orig)
