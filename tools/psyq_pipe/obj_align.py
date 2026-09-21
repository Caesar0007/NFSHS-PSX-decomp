"""obj_align.py OBJ [OBJ...] -- the section records of SN LNK objects: name, ALIGNMENT byte and size.
PSYLINK aligns every object's contribution to a section to that section's alignment, so an object whose .text is declared
with alignment 16 costs up to 12 pad bytes after a small function -- bytes no source line accounts for."""
import struct
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import psyq_extract as X  # noqa: E402  (parser only; its main() is not run)


def sections(blob):
    """(index -> (name, align)) by a raw walk over the 0x10 records, sizes from the full parse"""
    o = None
    for alt, pad in ((False, False), (True, False), (True, True)):
        try:
            o = X.parse_obj(blob, alt_debug=alt, pad_even=pad)
            break
        except X.Desync:
            continue
    out = {}
    p = 4
    # re-walk only to pick the align byte of each 0x10 record: find them by their decoded names
    for sect, name in (o['sections'] if o else {}).items():
        key = struct.pack('<H', sect)
        i = 4
        while True:
            i = blob.find(b'\x10' + key, i)
            if i < 0:
                break
            nm_len = blob[i + 6]
            if blob[i + 7:i + 7 + nm_len] == name.encode():
                out[sect] = (name, blob[i + 5], len(o['code'].get(sect, b'')))
                break
            i += 1
    return out


for a in sys.argv[1:]:
    blob = open(a, 'rb').read()
    print(Path(a).name.ljust(44), '  '.join('%s align=%d size=0x%x' % v for k, v in sorted(sections(blob).items()) if v[2]))
