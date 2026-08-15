import json
import pathlib

bak = pathlib.Path('scratchpad/w64a19/bak0/recon')
cur = pathlib.Path('recon')
touched = []
for f in bak.rglob('*'):
    if not f.is_file():
        continue
    rel = f.relative_to(bak)
    c = cur / rel
    if not c.exists():
        print('DELETED', rel)
        continue
    if f.read_bytes() != c.read_bytes():
        touched.append(rel.as_posix())
print(len(touched), 'files differ vs bak0')
json.dump(touched, open('scratchpad/w64a19/touched.json', 'w'), indent=1)
for t in touched:
    print(' ', t)
