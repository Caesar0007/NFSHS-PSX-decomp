"""fevirt_tscreen.py phase 3c: HOIST the override declarations.  Many owner surfaces declare a class's overrides only
inside owner-specific `#ifdef` blocks (or with a redundant asm label), so off that surface the class is abstract or looks
all-inline.  For every screen/dialog class, every override that the retail vtable proves (hand tables on `main`) is now
declared ONCE, unconditionally, at the top of the class body on every surface; the gated / asm-labelled duplicates go."""
import glob
import re
import subprocess

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
exec(open(R + 'scratchpad/psyq_pipe/fevirt_tscreen7.py', encoding='utf-8').read().split('over = {}')[0].split('import subprocess')[1])  # SIG
over = {}
for g in subprocess.run(['git', 'ls-tree', '--name-only', 'main', 'recon/game/common/'], capture_output=True, text=True, cwd=R).stdout.split():
    if not re.search(r'vtables_(tscreen|tdialog)', g):
        continue
    t = subprocess.run(['git', 'show', 'main:' + g], capture_output=True, text=True, cwd=R).stdout
    for m in re.finditer(r'^__vtbl_ptr_type (\w+)_vtable\[\d+\] = \{(.*?)^\};', t, re.M | re.S):
        cls = m.group(1)
        for meth, n, rest in re.findall(r'@0x[0-9a-f]+  (\w+?)__(\d+)(\w+)', m.group(2)):
            if rest[:int(n)] == cls and meth in SIG and meth not in over.setdefault(cls, []):
                over[cls].append(meth)
INTRODUCED = {'tDialogBase': ('CalculateDimensions', 'Draw'), 'tScreenCarSelect': ('DrawVideoWall', 'InitializeVideoWall', 'UpdateVideoWall', 'GetCar', 'AllocateAsyncBuffer', 'FreeAsyncBuffer'),
              'tScreenCarSelectTwoPlayer': ('TurnOffVideoWall', 'SetDialog'), 'tScreenCarSelectDuel': ('DrawOpponentVideoWall',),
              'tScreenCongrats': ('CalculatePrizes', 'DrawCongratsMessage', 'GetCar')}
tot = 0
for h in sorted(glob.glob(R + 'recon/frontend/common/*_types.h')):
    t = open(h, encoding='utf-8').read()
    o = t
    for cls, meths in over.items():
        if cls == 'tScreen':
            continue
        m = re.search(r'^struct ' + cls + r'\b[^{;]*\{\n', t, re.M)
        if not m:
            continue
        i, depth = m.end(), 1
        while depth:
            depth += t[i] == '{'
            depth -= t[i] == '}'
            i += 1
        body = t[m.end():i]
        block = []
        for meth in meths:
            if meth in INTRODUCED.get(cls, ()):
                continue            # declared `virtual`, in slot order, by the introducing block
            args = r'\(\s*\)' if meth == 'Draw' else r'\([^;{}]*?\)'
            body, k = re.subn(r'^[ \t]*(?:virtual )?(?:void|bool) ' + meth + args + r'(?:\s*(?:__asm__|asm)\("[^"]*"\))?;[^\n]*\n', '', body, flags=re.M)
            block.append('    ' + SIG[meth] + NL)
        if block:
            tot += len(block)
            t = t[:m.end()] + '    /* overrides (retail vtable), declared on every owner surface */' + NL + ''.join(block) + body + t[i:]
    if t != o:
        open(h, 'w', encoding='utf-8', newline='').write(t)
print('override declarations hoisted:', tot)
