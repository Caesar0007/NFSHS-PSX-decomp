"""Acceptance check: the linked .text ordering of build/src objects in the
full src-lane link (.map) must equal the generator's implied-base order
(spine_all.txt), with the strict probe_link spine (spine_placed.txt) as a
subsequence.  Also re-derives per-object linked ADDRESS monotonicity."""
import re
from pathlib import Path

HERE = Path(__file__).resolve().parent

def spine(fname):
    out = []
    for ln in (HERE / fname).read_text().splitlines():
        b, s, o = ln.split()
        out.append(o.replace("\\", "/"))
    return out

map_order = []
in_text = False
pat = re.compile(r"^\s\.text\s+(0x[0-9a-f]+)\s+(0x[0-9a-f]+)\s+(\S+\.o)$")
for ln in (HERE / "w67a5_spine.map").read_text(errors="replace").splitlines():
    m = pat.match(ln)
    if m:
        addr, size, obj = m.groups()
        obj = obj.replace("\\", "/")
        if obj.startswith("build/src/") and int(size, 16):
            map_order.append((int(addr, 16), obj))

addrs = [a for a, _ in map_order]
print("map .text src objects:", len(map_order),
      "address-monotone:", addrs == sorted(addrs))
mo = [o for _, o in map_order]

allsp = spine("spine_all.txt")
placed = spine("spine_placed.txt")
# front/main are pinned first and are empty -> absent from map (size 0)
print("spine_all len:", len(allsp), " placed len:", len(placed))
print("map == spine_all order:", mo == allsp)
if mo != allsp:
    for i, (x, y) in enumerate(zip(mo, allsp)):
        if x != y:
            print("first divergence at", i, x, "vs", y)
            break

def is_subseq(sub, seq):
    it = iter(seq)
    return all(s in it for s in sub)

print("placed spine is a subsequence of map order:", is_subseq(placed, mo))
