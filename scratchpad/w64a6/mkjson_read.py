import json

p = r'C:\Temp\nfs4-decomp\recon\syslib\psx\libcd\cdread.c'
src = open(p, encoding='ascii', errors='replace').read()
lines = src.split('\n')


def anchor(n):
    """(old, new) that deletes line n, using as much preceding context as needed
    to make the anchor unique in the file."""
    for back in range(0, 8):
        old = '\n'.join(lines[n - 1 - back: n]) + '\n'
        new = '\n'.join(lines[n - 1 - back: n - 1]) + ('\n' if back else '')
        if src.count(old) == 1:
            return old, new
    raise SystemExit("no unique anchor for line %d" % n)


RI = [187, 204, 208, 219]
RQ = [363, 379, 384, 390, 395, 413, 415]

V = []
for n in RI:
    o, w = anchor(n)
    V.append({"name": "RI drop L%d" % n, "edits": [[o, w]], "fns": ["_read_int"]})
V.append({"name": "RI drop ALL", "edits": [list(anchor(n)) for n in RI], "fns": ["_read_int"]})
for n in RQ:
    o, w = anchor(n)
    V.append({"name": "RQ drop L%d" % n, "edits": [[o, w]], "fns": ["_read_issue"]})

json.dump(V, open(r"C:\Temp\nfs4-decomp\scratchpad\w64a6\v_read.json", "w", encoding="utf-8"), indent=1)
for v in V:
    print(v["name"], "| anchor lines:", v["edits"][0][0].count('\n'))
