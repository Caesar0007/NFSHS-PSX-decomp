import re
import struct
import sys

d = open(sys.argv[1], 'rb').read()

# 1) PDB / debug directory
pe = struct.unpack_from('<I', d, 0x3c)[0]
ddoff = pe + 24 + 144  # PE32 optional header debug entry (index 6)
rva, size = struct.unpack_from('<II', d, ddoff + 6 * 8)
print(f"debug dir rva={rva:#x} size={size:#x}")
i = d.find(b'RSDS')
if i < 0:
    i = d.find(b'NB10')
if i >= 0:
    print("PDB ref:", d[i:i+120])
else:
    print("no PDB reference found")

# 2) known NFS4-PSX identifiers inside expression-like strings
strs = re.findall(rb'[\x20-\x7e]{4,}', d)
ids = [b'GameSetup', b'tournament', b'frontEnd', b'Car_tObj', b'chase',
       b'slice', b'perp', b'fTournament', b'carsim', b'Physics', b'newton',
       b'collide', b'AIHigh', b'aidata', b'DataRecord', b'gRealFrames',
       b'lapsCompleted', b'numCars', b'carIndex', b'trackNumber']
seen = set()
for s in strs:
    t = s.decode(errors='replace')
    if any(k.decode().lower() in t.lower() for k in ids) and t not in seen:
        seen.add(t)
        print("ID:", t[:120])
        if len(seen) > 45:
            break

# 3) strings physically near the Game\Common path strings (assert clusters)
for name in (b'CARS.cpp', b'STATS.cpp', b'Track.cpp', b'PATHS.cpp',
             b'aidatarecord.cpp'):
    i = d.find(name)
    if i < 0:
        continue
    lo = max(0, i - 700)
    chunk = d[lo:i + 100]
    near = [x.decode(errors='replace') for x in
            re.findall(rb'[\x20-\x7e]{5,}', chunk)]
    print(f"\n== near {name.decode()} ==")
    for n in near[-14:]:
        print("  ", n[:110])
