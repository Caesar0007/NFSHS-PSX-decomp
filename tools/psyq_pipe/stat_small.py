"""stat_small.py -- SYM `STAT` debug records whose value is a small number (an object-relative offset, not an address):
does retail carry a `name.NN` label for the static, and where does OUR link put it?"""
import re
import subprocess

SYM = 'C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt'
NM = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm.exe'
ELF = 'C:/Temp/nfs4-decomp/build/gen_ld/recon_multdef-ok.elf'
small, labels = {}, {}
for l in open(SYM, errors='replace'):
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) 9[46] Def2? class STAT .* name (\S+)$', l)
    if m and int(m.group(1), 16) < 0x10000:
        small.setdefault(m.group(2), set()).add(int(m.group(1), 16))
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) ([26]) (\S+)$', l)
    if m:
        labels.setdefault(re.sub(r'\.\d+$', '', m.group(3)), []).append((int(m.group(1), 16), m.group(3)))
ours = {}
for ln in subprocess.run([NM, '-n', ELF], capture_output=True, text=True).stdout.splitlines():
    p = ln.split()
    if len(p) == 3:
        ours.setdefault(re.sub(r'\.\d+$', '', p[2]), []).append((int(p[0], 16), p[2]))
print('%d small-value STAT names' % len(small))
for n in sorted(small):
    r = labels.get(n, [])
    o = ours.get(n, [])
    flag = '' if r else '   <-- NO retail label'
    print('  %-26s stat %-14s retail %-40s ours %s%s' % (n, ','.join('$%x' % v for v in sorted(small[n])), ' '.join('%08x' % a for a, _ in r)[:40],
                                                   ' '.join('%08x' % a for a, _ in o)[:40], flag))
