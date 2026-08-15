"""Apply ONE variant from a variants json (by name) and print gate + side_by_side, then restore."""
import json, os, subprocess, sys
ROOT = r"C:\Temp\nfs4-decomp"

turel, vfile, name, fn = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
tu = os.path.join(ROOT, turel.replace("/", os.sep))
base = open(tu, "rb").read()
v = [x for x in json.load(open(vfile, encoding="utf-8")) if x["name"].startswith(name)][0]
cur = base
for old, new in v["edits"]:
    ob = old.encode("utf-8")
    assert cur.count(ob) == 1, (cur.count(ob), old[:60])
    cur = cur.replace(ob, new.encode("utf-8"), 1)
try:
    open(tu + ".tmp", "wb").write(cur)
    os.replace(tu + ".tmp", tu)
    p = subprocess.run([sys.executable, "tools/side_by_side.py", turel, fn],
                       cwd=ROOT, capture_output=True, text=True, timeout=1800)
    open(os.path.join(ROOT, "scratchpad", "w64a6", "sbs_out.txt"), "w").write(p.stdout + p.stderr)
    print(p.stdout[-6000:])
    print(p.stderr[-2000:])
finally:
    open(tu, "wb").write(base)
    print("restored", os.path.getsize(tu))
