"""fevirt_tmenu.py phase 2d: remove the extern-"C" destructor DEVICES of menu-family classes
(`void ___<n><Class>(void *thisp) { ___<m><Base>(thisp); }`): with real virtual destructors the compiler emits the
synthesized `___<n><Class>` itself and the two definitions collide."""
import glob
import re
import subprocess

R = 'C:/Temp/nfs4-decomp/'
names = set()
for g in subprocess.run(['git', 'ls-tree', '--name-only', 'HEAD', 'recon/game/common/'], capture_output=True, text=True, cwd=R).stdout.split():
    if 'vtables_tmenu' in g or 'vtables_tpausemenu' in g:
        t = subprocess.run(['git', 'show', 'HEAD:' + g], capture_output=True, text=True, cwd=R).stdout
        names |= set(re.findall(r'^__vtbl_ptr_type (\w+)_vtable\[', t, re.M))
pat = re.compile(r'^(?:extern "C" )?void ___\d+(\w+)\(void \*thisp\) \{ ___\d+\w+\(thisp\); \}[^\n]*\n', re.M)
for f in glob.glob(R + 'recon/frontend/**/*.cpp', recursive=True):
    s = open(f, encoding='utf-8').read()
    n = [0]

    def rep(m):
        if m.group(1) in names:
            n[0] += 1
            return ''
        return m.group(0)
    s2 = pat.sub(rep, s)
    if n[0]:
        open(f, 'w', encoding='utf-8', newline='').write(s2)
        print(n[0], 'devices removed', f.replace(R, ''))
