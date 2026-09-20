#!/usr/bin/env python3
"""link_stripped_check.py -- gate for the LINK_STRIPPED model (recon/link_stripped.h, linkers/link_stripped.json).

Retail's final link removed unreferenced functions.  Every function we tag LINK_STRIPPED must be
  * listed in linkers/link_stripped.json with its evidence,
  * really sit in its object's `.text.strip` section (and nothing unlisted may sit there),
  * have NO retail address (configs/symbol_addrs.txt) -- otherwise retail kept it,
  * when an SDK reference is named (`sdk`: "LIB/function"), be byte-identical (or, while OPEN, within its `open_diff` ratchet) to the PsyQ 4.3 function blob with the
    relocated instruction fields masked (HI16/LO16 -> low 16 bits, R_MIPS_26 -> low 26 bits).
Exit status 1 on any violation."""
import json
import re
import struct
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BIN = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-'
SDK = Path('C:/Temp/nfs4-clean/psyq43/extracted')
rows = json.load(open(ROOT / 'linkers' / 'link_stripped.json'))['functions']
retail = set()
for ln in open(ROOT / 'configs' / 'symbol_addrs.txt', errors='replace'):
    m = re.match(r'(\S+?)\s*=\s*0x', ln)
    if m:
        retail.add(m.group(1))
bad = 0
by_obj = {}
for r in rows:
    by_obj.setdefault(r['object'], []).append(r)
for obj, lst in sorted(by_obj.items()):
    o = ROOT / obj
    if not o.is_file():
        print('MISSING OBJECT', obj); bad += 1; continue
    syms = {}
    for ln in subprocess.run([BIN + 'objdump.exe', '-t', str(o)], capture_output=True, text=True).stdout.splitlines():
        p = ln.split()
        if len(p) >= 6 and p[-3] == '.text.strip' and 'F' in p[1:4]:
            syms[p[-1]] = (int(p[0], 16), int(p[-2], 16))
    tmp = ROOT / 'build' / 'tmp' / 'strip_sec.bin'
    tmp.parent.mkdir(parents=True, exist_ok=True)
    subprocess.run([BIN + 'objcopy.exe', '-O', 'binary', '-j', '.text.strip', str(o), str(tmp)], capture_output=True)
    sec = tmp.read_bytes() if tmp.exists() else b''
    rel = {}
    for ln in subprocess.run([BIN + 'objdump.exe', '-r', '-j', '.text.strip', str(o)], capture_output=True, text=True).stdout.splitlines():
        m = re.match(r'^([0-9a-f]{8})\s+(R_MIPS_\w+)', ln)
        if m:
            rel[int(m.group(1), 16)] = m.group(2)
    listed = {r['function'] for r in lst}
    for extra in sorted(set(syms) - listed):
        print('UNLISTED function in .text.strip: %s (%s)' % (extra, obj)); bad += 1
    for r in lst:
        fn = r['function']
        if fn not in syms:
            print('NOT in .text.strip: %s (%s)' % (fn, obj)); bad += 1; continue
        if fn in retail:
            print('HAS A RETAIL ADDRESS (retail kept it): %s' % fn); bad += 1
        off, size = syms[fn]
        verdict = 'no SDK reference'
        if r.get('sdk'):
            lib, name = r['sdk'].split('/')
            blob = (SDK / lib / 'functions' / (name + '.bin')).read_bytes()
            ours = sec[off:off + size]
            diff = 0 if len(blob) == len(ours) else 1
            for i in range(0, min(len(blob), len(ours)), 4):
                a, b = struct.unpack_from('<I', ours, i)[0], struct.unpack_from('<I', blob, i)[0]
                kind = rel.get(off + i, '')
                mask = 0xFC000000 if kind == 'R_MIPS_26' else 0xFFFF0000 if kind in ('R_MIPS_HI16', 'R_MIPS_LO16') else 0xFFFFFFFF
                if (a & mask) != (b & mask):
                    diff += 1
            allowed = r.get('open_diff', 0)      # an OPEN function: ratchet, never a verdict (it must not get worse)
            verdict = 'SDK %s: %s (%d B)' % (r['sdk'], 'BYTE-EXACT' if diff == 0 else '%d DIFFERING WORDS%s' % (
                diff, ' -- OPEN, ratchet %d' % allowed if allowed else ''), len(blob))
            bad += diff > allowed
            if diff == 0 and allowed:
                print('  (drop open_diff for %s: it is exact now)' % fn)
        print('  %-28s %-14s %s' % (obj.split('/')[-1], fn, verdict))
print('link-stripped functions: %d listed, %d violation(s)' % (len(rows), bad))
sys.exit(1 if bad else 0)
