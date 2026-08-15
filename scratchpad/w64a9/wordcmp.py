"""wordcmp.py OBJ FN ORACLE.s -- byte compare our object's fn words vs the oracle,
classifying a differing word as RELOC only when objdump -dr shows a relocation on
that exact line (the w48/w62 anti-vacuity rule).  Prints REAL=<n>."""
import re, subprocess, sys
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
obj, fn, ora_path = sys.argv[1], sys.argv[2], sys.argv[3]

out = subprocess.run([OBJD, '-dr', '-z', obj], capture_output=True, text=True).stdout
cur = None
ours = []          # (word, has_reloc)
lines = out.splitlines()
for i, L in enumerate(lines):
    m = re.match(r'[0-9a-f]+ <(\S+)>:', L)
    if m:
        cur = m.group(1)
        continue
    m = re.match(r'\s+([0-9a-f]+):\s+([0-9a-f]{8})\s', L)
    if m and cur == fn:
        nxt = lines[i + 1] if i + 1 < len(lines) else ''
        ours.append((m.group(2), 'R_MIPS' in nxt))

ora = []
for L in open(ora_path):
    m = re.search(r'/\* \w+ \w+ ([0-9A-F]{8}) \*/', L)
    if m:
        w = m.group(1)
        ora.append(''.join(reversed([w[i:i + 2] for i in range(0, 8, 2)])).lower())

print(f'{fn}: ours {len(ours)} words, oracle {len(ora)}')
real = []
for i, ((a, rel), b) in enumerate(zip(ours, ora)):
    if a != b and not rel:
        real.append((i, a, b))
print(f'  differing-with-reloc (expected, unlinked): '
      f'{sum(1 for (a, r), b in zip(ours, ora) if a != b and r)}')
print(f'  REAL={len(real)}')
for i, a, b in real[:10]:
    print(f'    word {i}: ours {a} vs retail {b}')
