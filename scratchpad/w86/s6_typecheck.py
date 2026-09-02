"""Type-fidelity pass: for every SYM local whose NAME is also a parsed C local in
the same function, flag high-signal type disagreements (pointer-ness, and the
integer width/signedness family).  Report-only."""
import re, os, glob, importlib.util

sp = importlib.util.spec_from_file_location('sa', 'scratchpad/w86/s6_symaudit.py')
M = importlib.util.module_from_spec(sp)
sp.loader.exec_module(M)
syms = M.load()
by_base = {}
for mn, i in syms.items():
    by_base.setdefault(M.demangle_base(mn), []).append((mn, i))

SCALAR = {
    'INT': {'int', 'u_int', 'unsigned', 'signed', 'stateType_t', 'bool'},
    'UINT': {'u_int', 'unsigned', 'int'},
    'SHORT': {'short', 'u_short'},
    'USHORT': {'u_short', 'short', 'unsigned'},
    'CHAR': {'char', 'u_char', 'signed'},
    'UCHAR': {'u_char', 'char', 'unsigned'},
    'LONG': {'long', 'int', 'u_long'},
    'ULONG': {'u_long', 'long', 'u_int', 'int'},
}

files = (sorted(glob.glob('recon/game/common/*.cpp')) + sorted(glob.glob('recon/game/common/*.c'))
         + sorted(glob.glob('recon/game/psx/*.cpp')) + sorted(glob.glob('recon/game/psx/*.c')))
nchk = 0
bad = []
for path in files:
    for cname, ln, body, params in M.fn_bodies(path):
        base = cname.split('::')[-1]
        cls = cname.split('::')[0] if '::' in cname else None
        cands = by_base.get(base) or []
        if cls is not None:
            pat = re.compile(r'^%s__%d%s(?:$|[A-Za-z_])' % (re.escape(base), len(cls), re.escape(cls)))
            cands = [c for c in cands if pat.match(c[0])]
        else:
            cands = [c for c in cands if re.match(r'^%s__F' % re.escape(base), c[0])] or cands
        if len(cands) != 1:
            continue
        mn, info = cands[0]
        cl = {x['name']: x for x in M.c_locals(body)}
        for s in info['locals']:
            c = cl.get(s['name'])
            if not c:
                continue
            nchk += 1
            st = s['type']
            ct = c['type'] + c['arr']
            sptr = st.startswith('PTR') or ' PTR' in st.split('tag')[0]
            cptr = '*' in ct
            sary = st.startswith('ARY')
            cary = '[' in ct
            if sptr and not cptr and not cary:
                bad.append((path, cname, s['name'], st, c['text'], 'SYM ptr, C non-ptr'))
            elif cptr and not sptr and not sary:
                bad.append((path, cname, s['name'], st, c['text'], 'C ptr, SYM non-ptr'))
            elif sary and not (cary or cptr):
                bad.append((path, cname, s['name'], st, c['text'], 'SYM array, C scalar'))
            else:
                head = st.split()[0]
                if head in SCALAR:
                    ctypes = set(re.findall(r'[A-Za-z_]\w*', c['type']))
                    if ctypes and not (ctypes & SCALAR[head]) and not sptr:
                        bad.append((path, cname, s['name'], st, c['text'], 'scalar family'))
print('name-matched locals type-checked: %d   flagged: %d' % (nchk, len(bad)))
for p, f, n, st, ct, why in bad:
    print('  %-26s %-34s %-18s SYM[%s] C[%s]  <%s>' %
          (os.path.basename(p), f, n, st, ct, why))
