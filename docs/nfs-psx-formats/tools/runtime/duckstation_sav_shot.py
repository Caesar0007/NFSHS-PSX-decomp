"""Extract the screenshot embedded in DuckStation save states (.sav) as 3x PNG files.

  duckstation_sav_shot.py <outdir> <file.sav>...
"""
import sys, struct, glob, os
from compression import zstd
from PIL import Image
out = sys.argv[1]; os.makedirs(out, exist_ok=True)
for fn in sys.argv[2:]:
    d = open(fn, 'rb').read()
    comp, w, h, csz, off = struct.unpack_from('<5I', d, 0xB4)
    dcomp, dcsz, dusz, doff = struct.unpack_from('<4I', d, 0xC8)
    raw = zstd.decompress(d[off:off+csz]) if comp == 2 else d[off:off+csz]
    print(os.path.basename(fn), 'shot', w, h, len(raw), 'bytes/px', len(raw)/(w*h))
    img = Image.frombytes('RGBA', (w, h), raw) if len(raw) == w*h*4 else Image.frombytes('RGB', (w, h), raw[:w*h*3])
    img = img.convert('RGB').resize((w*3, h*3), Image.NEAREST)
    img.save(os.path.join(out, os.path.basename(fn).replace('.sav', '.png')))
