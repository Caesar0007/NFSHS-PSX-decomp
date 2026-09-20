"""songdraw_variants.py -- try a few source spellings of tInsideBoxSongMenu::Draw's loop set-up and report the diff
count of each against retail (the residual is one `li s3,-40` scheduled before instead of after width's sll/sra)."""
import re
import subprocess

R = 'C:/Temp/nfs4-decomp/'
F = R + 'recon/frontend/common/femenuoptions.cpp'
NL = chr(10)
orig = open(F, encoding='utf-8').read()
HEAD = '    j = 0;' + NL + '    fe = &frontEnd;' + NL + '    width = w;' + NL + '    drawY = -0x28;' + NL + '    do {' + NL
assert orig.count(HEAD) == 1
DECL = '  short width;'
assert orig.count(DECL) == 1
variants = {
    'int width=(short)w': (HEAD, HEAD.replace('width = w;', 'width = (short)w;'), 'int width;'),
    'drawY first': (HEAD, '    drawY = -0x28;' + NL + '    j = 0;' + NL + '    fe = &frontEnd;' + NL + '    width = w;' + NL + '    do {' + NL, None),
    'width first': (HEAD, '    width = w;' + NL + '    j = 0;' + NL + '    fe = &frontEnd;' + NL + '    drawY = -0x28;' + NL + '    do {' + NL, None),
    'fe last': (HEAD, '    j = 0;' + NL + '    width = w;' + NL + '    drawY = -0x28;' + NL + '    fe = &frontEnd;' + NL + '    do {' + NL, None),
    'int width first': (HEAD, '    width = (short)w;' + NL + '    j = 0;' + NL + '    fe = &frontEnd;' + NL + '    drawY = -0x28;' + NL + '    do {' + NL, 'int width;'),
}
best = None
for name, (a, b, decl) in variants.items():
    s = orig.replace(a, b)
    if decl:
        s = re.sub(r'  short width;[^\n]*', '  ' + decl, s)
    open(F, 'w', encoding='utf-8', newline='').write(s)
    subprocess.run(['python', 'tools/build.py', '--no-link', '--only', 'recon/frontend/common/femenuoptions.cpp'], capture_output=True, cwd=R)
    out = subprocess.run(['python', 'scratchpad/psyq_pipe/fndiff.py', 'recon/frontend/common/femenuoptions.cpp',
                          'Draw__18tInsideBoxSongMenusssss', '0'], capture_output=True, text=True, cwd=R).stdout
    n = len([l for l in out.splitlines() if l[:1] in '+-' and not l.startswith(('+++', '---'))])
    print('%-22s diff lines %d' % (name, n))
    if n == 0 and best is None:
        best = s
open(F, 'w', encoding='utf-8', newline='').write(best if best else orig)
print('kept:', 'a matching variant' if best else 'original')
