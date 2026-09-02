import sys, os, re, glob, importlib.util
sp = importlib.util.spec_from_file_location('sa', 'scratchpad/w86/s6_symaudit.py')
M = importlib.util.module_from_spec(sp)
sp.loader.exec_module(M)
syms = M.load()
by_base = {}
for mn, i in syms.items():
    by_base.setdefault(M.demangle_base(mn), []).append((mn, i))
bad = 0
tot = 0
rows = []
files = (sorted(glob.glob('recon/game/common/*.cpp')) + sorted(glob.glob('recon/game/common/*.c'))
         + sorted(glob.glob('recon/game/psx/*.cpp')) + sorted(glob.glob('recon/game/psx/*.c')))
for path in files:
    stem = os.path.basename(path).rsplit('.', 1)[0].lower()
    for cname, ln, body, params in M.fn_bodies(path):
        base = cname.split('::')[-1]
        cands = by_base.get(base) or []
        if len(cands) != 1:
            continue
        tot += 1
        mn, info = cands[0]
        f = os.path.basename(info['file'].replace('\\', '/')).rsplit('.', 1)[0].lower()
        if f != stem:
            bad += 1
            rows.append((path, cname, mn, info['file']))
print("matched=%d  SYM-file MISMATCH=%d" % (tot, bad))
for r in rows:
    print("  %-40s %-34s %s" % (r[0], r[1], r[3]))
