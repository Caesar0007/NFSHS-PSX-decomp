"""Real C++ virtuals, step 6 (2026-09-20): the tScreen + tDialog hierarchy (36 classes, the last 22 hand vtable files).
Phase 1: every owner-surface copy of the ROOT `struct tScreen` swaps its `_vf` member for one shared fragment,
fescreen_virtuals.inc, that declares the virtuals in retail slot order:
    [1] GetShapeInfo(short&,short&,char**,char**) [2] DrawBackground [3] DrawForeground [4] ~tScreen [5] PreLoad
    [6] Initialize [7] Cleanup [8] TransitionIsFinished [9] ProcessInput(tPlayer,tInputKeyType&,tMenuCommand&)
(tDialogBase adds [10] CalculateDimensions = 0, [11] Draw).  The copies' own re-declarations of those members are removed,
vptr stores / extern tables / default ctors / extern-C dtor devices of the family go, the 22 hand vtable files go.
Non-front-end copies (game/common/nfs3_types.h, nfs4_types.h, frontend/psx/mmeffect_types.h) keep the POD `_vf` layout."""
import glob
import os
import re
import subprocess

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
FE = 'recon/frontend/common/'

names = set()
files = []
for g in subprocess.run(['git', 'ls-tree', '--name-only', 'HEAD', 'recon/game/common/'], capture_output=True, text=True, cwd=R).stdout.split():
    if re.search(r'vtables_(tscreen|tdialog)', g):
        files.append(g)
        t = subprocess.run(['git', 'show', 'HEAD:' + g], capture_output=True, text=True, cwd=R).stdout
        names |= set(re.findall(r'^__vtbl_ptr_type (\w+)_vtable\[', t, re.M))
print(len(files), 'vtable files,', len(names), 'classes')

open(R + FE + 'fescreen_virtuals.inc', 'w', encoding='utf-8', newline='').write(
    '/* frontend/common/fescreen_virtuals.inc -- tScreen\'s VIRTUALS, in retail slot order (real virtuals since 2026-09-20).' + NL +
    ' * A member-declaration fragment: every owner-surface copy of `struct tScreen` includes it where the hand-written' + NL +
    ' * `_vf` member used to be (the vptr follows the data members), so all copies agree on the vtable layout while keeping' + NL +
    ' * their own non-virtual member sets.  Surfaces without tInputKeyType / tMenuCommand define' + NL +
    ' * NFS4_TSCREEN_LAYOUT_ONLY_PROCESSINPUT and get a same-slot placeholder they can neither define nor call. */' + NL +
    '    virtual void GetShapeInfo(short &numPermShapes, short &numSwapShapes, char **permFileName, char **swapFileName);' + NL +
    '    virtual void DrawBackground();' + NL + '    virtual void DrawForeground();' + NL + '    virtual ~tScreen();' + NL +
    '    virtual void PreLoad();' + NL + '    virtual void Initialize();' + NL + '    virtual void Cleanup();' + NL +
    '    virtual bool TransitionIsFinished();' + NL +
    '#ifndef NFS4_TSCREEN_LAYOUT_ONLY_PROCESSINPUT' + NL +
    '    virtual void ProcessInput(tPlayer fromPlayer, tInputKeyType &keyval, tMenuCommand &command);' + NL + '#else' + NL +
    '    virtual void ProcessInput(int, void *, void *);' + NL + '#endif' + NL)

REDUNDANT = [r'~tScreen\(\);', r'void PreLoad\(\);', r'void Initialize\(\);', r'void Cleanup\(\);', r'bool TransitionIsFinished\(\);',
             r'void DrawForeground\(\);', r'void DrawBackground\(\);', r'void GetShapeInfo\([^;]*;', r'void ProcessInput\([^;]*;']
for h in sorted(glob.glob(R + 'recon/frontend/common/*.h')):
    s = open(h, encoding='utf-8').read()
    m = re.search(r'^struct tScreen \{', s, re.M)
    if not m:
        continue
    i, depth = m.end(), 1
    while depth:
        depth += s[i] == '{'
        depth -= s[i] == '}'
        i += 1
    body = s[m.end():i]
    if '_vf' not in body:
        print('   no _vf in', os.path.basename(h))
        continue
    body = re.sub(r'[ \t]*__vtbl_ptr_type \(\*_vf\)\[10\];[^\n]*\n', '#include "fescreen_virtuals.inc"' + NL, body, count=1)
    for p in REDUNDANT:
        body = re.sub(r'^[ \t]*' + p + r'[^\n]*\n', '', body, flags=re.M | re.S)
    body = re.sub(r'^[ \t]*tScreen\(\) \{\}[^\n]*\n', '    tScreen();' + NL, body, flags=re.M)
    open(h, 'w', encoding='utf-8', newline='').write(s[:m.end()] + body + s[i:])
    print('root converted:', os.path.basename(h))

pat = re.compile(r'^[ \t]*(?:\*\(void \*\*\)&\(?(?:this->)?_vf\)?|(?:this->)?_vf)\s*=\s*\([^;]*?\)\s*&?(\w+)_vtable;[^\n]*\n', re.M)
dev = re.compile(r'^(?:extern "C" )?void ___\d+(\w+)\(void \*thisp\) \{ ___\d+\w+\(thisp\); \}[^\n]*\n', re.M)
for f in glob.glob(R + 'recon/frontend/**/*.cpp', recursive=True) + glob.glob(R + 'recon/game/**/*.cpp', recursive=True):
    s = open(f, encoding='utf-8').read()
    cnt = [0, 0]

    def rep(m):
        if m.group(1) in names:
            cnt[0] += 1
            return ''
        return m.group(0)

    def rep2(m):
        if m.group(1) in names:
            cnt[1] += 1
            return ''
        return m.group(0)
    s2 = dev.sub(rep2, pat.sub(rep, s))
    if s2 != s:
        open(f, 'w', encoding='utf-8', newline='').write(s2)
        print('%3d vptr stores, %2d dtor devices removed  %s' % (cnt[0], cnt[1], f.replace(R, '').replace('\\', '/')))
for f in glob.glob(R + 'recon/frontend/**/*.h', recursive=True):
    s = open(f, encoding='utf-8').read()
    s2 = re.sub(r'^[ \t]*extern __vtbl_ptr_type (\w+)_vtable\[\d*\];[^\n]*\n', lambda m: '' if m.group(1) in names else m.group(0), s, flags=re.M)
    s2 = re.sub(r'^[ \t]*(\w+)\(\) \{\}[^\n]*\n', lambda m: '' if (m.group(1) in names and m.group(1) != 'tScreen') else m.group(0), s2, flags=re.M)
    if s2 != s:
        open(f, 'w', encoding='utf-8', newline='').write(s2)
for g in files:
    os.remove(R + g)
