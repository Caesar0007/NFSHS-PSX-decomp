"""sym_obj_census.py -- every object named by the retail SYM (FILE records) classified by what the SYM says it contributes:
  game objects (with debug records): functions, EXT/STAT data definitions -> CODE / DATA-ONLY / DECLARATION-ONLY;
  library modules (name only): whether a recon TU carries that name at all.
For each function-less object it then reports which recon object DEFINES its data symbols (nm over build/recon), so a
data module whose variables live in a *user's* file shows up."""
import glob
import json
import re
import subprocess
from collections import OrderedDict, defaultdict

R = 'C:/Temp/nfs4-decomp/'
SYM = 'C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt'
NM = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm.exe'
objs = OrderedDict()
cur = None
for l in open(SYM, errors='replace'):
    m = re.search(r'Def class FILE type NULL size 0 name (\S+)', l)
    if m:
        n = m.group(1)
        if cur == n:
            cur = None
        else:
            cur = n
            objs.setdefault(n, {'fn': 0, 'data': []})
        continue
    if cur is None:
        continue
    if 'Function start' in l:
        objs[cur]['fn'] += 1
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) 9[46] Def2? class (EXT|STAT) type (\S.*?) size (\d+)(?: dims [^\n]*?)? (?:tag \S* )?name (\S+)$', l.rstrip())
    if m and not m.group(3).startswith('FCN'):
        objs[cur]['data'].append((int(m.group(1), 16), m.group(2), m.group(5), int(m.group(4))))

# who defines what in the recon build
definer = {}
files = sorted(glob.glob(R + 'build/recon/**/*.o', recursive=True))
for i in range(0, len(files), 60):
    batch = [f.replace(chr(92), '/').replace(R, '') for f in files[i:i + 60]]
    out = subprocess.run([NM, '-A'] + batch, capture_output=True, text=True, cwd=R).stdout
    for ln in out.splitlines():
        p = ln.split()
        if len(p) == 3 and p[1] in 'DdBbGgSsRrCc':
            definer.setdefault(p[2], p[0].split(':')[0].replace('build/recon/', ''))
recon_names = defaultdict(list)
for f in files:
    b = f.replace(chr(92), '/').split('/')[-1]
    recon_names[re.sub(r'\.(c|cpp)\.o$', '', b).lower()].append(f.replace(chr(92), '/').replace(R + 'build/recon/', ''))

game = [(n, d) for n, d in objs.items() if '(' not in n]
lib = [n for n in objs if '(' in n]
print('SYM objects: %d game, %d library modules' % (len(game), len(lib)))
print()
print('== GAME objects without functions ==')
for n, d in game:
    if d['fn']:
        continue
    key = n.lower().replace('.obj', '')
    tu = recon_names.get(key, [])
    kind = 'DATA-ONLY' if d['data'] else 'DECLARATION-ONLY'
    print('%-18s %-17s recon TU: %s' % (n, kind, ', '.join(tu) or '-- NONE --'))
    own = defaultdict(list)
    for a, cls, name, size in d['data']:
        own[definer.get(name, '?? undefined in recon')].append('%s@%08x' % (name, a))
    for o, names in own.items():
        flag = '' if tu and o == tu[0] else '   <== NOT in its own TU'
        print('      %-44s %s%s' % (o, ' '.join(names)[:150], flag))
print()
print('== LIBRARY modules with no recon TU of that name ==')
for n in lib:
    mod = re.search(r'\(([^)]+)\)', n).group(1).lower().replace('.obj', '')
    if mod not in recon_names:
        print('   ', n)
