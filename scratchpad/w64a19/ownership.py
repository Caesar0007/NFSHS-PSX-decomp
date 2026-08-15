import json
import subprocess
import pathlib

mine = json.loads(pathlib.Path('scratchpad/w64a19/myfiles.json').read_text())
solo, shared = [], []
for f in mine:
    d = subprocess.run(['git', 'diff', 'HEAD', '--', f],
                       capture_output=True, text=True).stdout
    adds = [l for l in d.splitlines() if l.startswith('+') and not l.startswith('+++')]
    dels = [l for l in d.splitlines() if l.startswith('-') and not l.startswith('---')]
    foreign = [l for l in adds if 'w64-a19' not in l and ' asm("' not in l
               and l[1:].strip() not in ('', '*/') and not l[1:].lstrip().startswith('*')]
    foreign += [l for l in dels if 'externs for cross-module helpers' not in l
                and not l[1:].lstrip().startswith(('void AIWorld_CalculateLaneInfo',
                                                   'int  AIPhysics_UseCoolPhysics',
                                                   'void AISpeeds_MaintainLeaderBoard',
                                                   'void DrawW_DoObjectAnimations',
                                                   '(int (*)(...))(void (tBlank',
                                                   '{0, 0, (int (*)(...))'))
                and l[1:].strip() != '']
    (solo if not foreign else shared).append((f, len(foreign)))
print('SOLO (safe to stage):', len(solo))
for f, _ in solo:
    print('  ', f)
print('SHARED with a peer (do NOT stage blindly):', len(shared))
for f, n in shared:
    print('  ', f, n)
json.dump({'solo': [f for f, _ in solo], 'shared': [f for f, _ in shared]},
          open('scratchpad/w64a19/ownership.json', 'w'), indent=1)
