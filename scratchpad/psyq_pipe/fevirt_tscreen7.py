"""fevirt_tscreen.py phase 3: every owner-surface copy of a screen/dialog class must DECLARE the virtuals that class
overrides -- otherwise the class looks all-inline on that surface and the TU emits a private vtable copy (+ synthesized
destructor) that retail does not have (front.obj, feapp.obj, fememcard.obj did).
The authoritative override list per class = the retail vtable itself (the hand tables on `main`): slot symbol
`Method__<len><Class>...` names the class that implements the slot."""
import glob
import re
import subprocess

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
SIG = {
    'GetShapeInfo': 'void GetShapeInfo(short &, short &, char **, char **);', 'DrawBackground': 'void DrawBackground();',
    'DrawForeground': 'void DrawForeground();', 'PreLoad': 'void PreLoad();', 'Initialize': 'void Initialize();',
    'Cleanup': 'void Cleanup();', 'TransitionIsFinished': 'bool TransitionIsFinished();',
    'ProcessInput': 'void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);', 'CalculateDimensions': 'void CalculateDimensions();',
    'Draw': 'void Draw();', 'CalculatePrizes': 'void CalculatePrizes();', 'DrawCongratsMessage': 'void DrawCongratsMessage();',
    'GetCar': 'bool GetCar(tCarInfo &);', 'DrawVideoWall': 'void DrawVideoWall(short);', 'InitializeVideoWall': 'void InitializeVideoWall();',
    'UpdateVideoWall': 'void UpdateVideoWall(tCarInfo &);', 'AllocateAsyncBuffer': 'void AllocateAsyncBuffer();',
    'FreeAsyncBuffer': 'void FreeAsyncBuffer();', 'TurnOffVideoWall': 'void TurnOffVideoWall();', 'SetDialog': 'void SetDialog();',
    'DrawOpponentVideoWall': 'void DrawOpponentVideoWall(short);',
}
over = {}
for g in subprocess.run(['git', 'ls-tree', '--name-only', 'main', 'recon/game/common/'], capture_output=True, text=True, cwd=R).stdout.split():
    if not re.search(r'vtables_(tscreen|tdialog)', g):
        continue
    t = subprocess.run(['git', 'show', 'main:' + g], capture_output=True, text=True, cwd=R).stdout
    for m in re.finditer(r'^__vtbl_ptr_type (\w+)_vtable\[\d+\] = \{(.*?)^\};', t, re.M | re.S):
        cls = m.group(1)
        for sym in re.findall(r'@0x[0-9a-f]+  (\w+?)__(\d+)(\w+)', m.group(2)):
            meth, n, rest = sym[0], int(sym[1]), sym[2]
            if rest[:n] == cls and meth in SIG:
                over.setdefault(cls, [])
                if meth not in over[cls]:
                    over[cls].append(meth)
print(len(over), 'classes with overrides')
tot = 0
for h in sorted(glob.glob(R + 'recon/frontend/common/*_types.h')):
    t = open(h, encoding='utf-8').read()
    o = t
    for cls, meths in over.items():
        if cls == 'tScreen':
            continue
        for m in list(re.finditer(r'^struct ' + cls + r'\b[^{;]*\{', t, re.M)):
            pass
        m = re.search(r'^struct ' + cls + r'\b[^{;]*\{', t, re.M)
        if not m:
            continue
        i, depth = m.end(), 1
        while depth:
            depth += t[i] == '{'
            depth -= t[i] == '}'
            i += 1
        body = t[m.end():i - 1]
        add = []
        for meth in meths:
            pat = r'\bDraw\(\s*\)' if meth == 'Draw' else r'\b' + meth + r'\s*\('
            if not re.search(pat, body):
                add.append('    ' + SIG[meth] + '   /* declared on every surface: see fevirt_tscreen7.py */' + NL)
        if add:
            tot += len(add)
            if not body.endswith(NL):
                body += NL
            t = t[:m.end()] + body + ''.join(add) + t[i - 1:]
    if t != o:
        open(h, 'w', encoding='utf-8', newline='').write(t)
        print('ok', h.replace('\\', '/').split('/')[-1])
print('declarations added:', tot)
