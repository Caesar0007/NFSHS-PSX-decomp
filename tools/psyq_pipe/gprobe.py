"""gprobe.py FILE.cpp -- compile a standalone probe with CC1PLPSX -O2 -G4 -g and print, per function, the SN debug
structure cc1 hands ASPSX: hdr line (= the `{` line), then each instruction with its function-relative line (.loc - hdr),
and the .begin/.bend records (values are relative to hdr-1, as SN stores them)."""
import re
import subprocess
import sys
from pathlib import Path

src = Path(sys.argv[1])
cc = 'C:/Temp/psq43/COMPILER/' + ('CC1PLPSX.EXE' if src.suffix == '.cpp' else 'CC1PSX.EXE')
s = src.with_suffix('.s')
r = subprocess.run([cc, '-quiet', '-O2', '-G4', '-g', str(src), '-o', str(s)], capture_output=True, text=True)
if r.returncode:
    print((r.stdout + r.stderr)[-800:]); sys.exit(1)
lines = s.read_text(errors='replace').splitlines()
srcl = src.read_text().splitlines()
fn = None; loc = None; pending = None; ins = []; blocks = []; hdr = None; nore = False


def flush():
    if fn is None:
        return
    print('== %s  hdr(`{`) line %s' % (fn, hdr))
    for t, b in ins:
        print('   %3s  %s' % ('-' if t is None else t - hdr, b[:60]))
    print('   blocks:', ' '.join('%s%d' % (c, n) for c, n in blocks))


for l in lines:
    m = re.match(r'^\t\.loc\t\d+ (\d+)', l)
    if m:
        loc = int(m[1]); pending = loc; continue
    m = re.match(r'^\t\.ent\t(\S+)', l)
    if m:
        flush(); fn = m[1]; ins = []; blocks = []; hdr = loc; nore = False; continue
    if fn is None:
        continue
    if l.startswith('\t.set\tnoreorder'):
        nore = True; continue
    if l.startswith('\t.set\treorder'):
        nore = False; continue
    m = re.match(r'^\t\.(begin|bend)\t\S+\t(\d+)', l)
    if m:
        blocks.append(('{' if m[1] == 'begin' else '}', int(m[2]))); continue
    if re.match(r'^\t\.end\t', l):
        flush(); fn = None; continue
    if l.strip() == '#nop':
        ins.append((loc, 'nop')); continue
    if l.startswith('\t.') or not l.startswith('\t'):
        continue
    body = l.split('#')[0].strip()
    if not body:
        continue
    ins.append((loc, body))
    if not nore and re.match(r'(j|jal|jr|jalr|b|beq|bne|beqz|bnez|blez|bgtz|bltz|bgez)\b', body):
        ins.append((loc, 'nop  <delay>'))
flush()
