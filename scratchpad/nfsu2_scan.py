import re
import sys

d = open(sys.argv[1], 'rb').read()
strs = re.findall(rb'[\x20-\x7e]{6,}', d)
keys = [b'Physics_', b'AIHigh', b'AIState', b'Newton_', b'Sim_', b'Stats_',
        b'tTournament', b'tCarManager', b'tScreen', b'Front_', b'AudioCmn',
        b'Speech_', b'Collide_', b'R3DCar', b'Render_', b'MCRD_', b'FEApp',
        b'carsim', b'nfs4', b'hometown', b'.cpp', b'.c\x00', b'src\\', b'src/',
        b'GameSetup', b'tPlayer', b'AILife', b'bworld', b'coorddef']
hits = {}
for s in strs:
    for k in keys:
        if k in s:
            hits.setdefault(k, []).append(s[:110])
for k, v in sorted(hits.items()):
    print(f"== {k.decode(errors='replace')} ({len(v)}) ==")
    seen = set()
    for s in v:
        if s not in seen:
            seen.add(s)
            print("  ", s.decode(errors='replace'))
        if len(seen) >= 8:
            break
print("total strings:", len(strs))
