"""Apply ONE variant from a variant file and LEAVE it applied (for sbs inspection).
usage: python scratchpad/w63a1/apply.py <variantfile.py> <variant-name-substring>
       python scratchpad/w63a1/apply.py --restore <tu> <backup>
"""
import importlib.util
import os
import sys

ROOT = r"C:/Temp/nfs4-decomp"


def main():
    spec = importlib.util.spec_from_file_location("variants", sys.argv[1])
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    want = sys.argv[2]
    tu = os.path.join(ROOT, mod.TU)
    with open(tu, "rb") as f:
        orig = f.read()
    bak = os.path.join(ROOT, "scratchpad/w63a1", os.path.basename(mod.TU) + ".applybak")
    if not os.path.exists(bak):
        with open(bak, "wb") as f:
            f.write(orig)
    crlf = orig.count(b"\r\n") > orig.count(b"\n") // 2
    for name, edits in mod.VARIANTS:
        if want not in name:
            continue
        cur = orig
        for old, new, cnt in edits:
            o = old.encode()
            n = new.encode()
            if crlf:
                o = o.replace(b"\n", b"\r\n")
                n = n.replace(b"\n", b"\r\n")
            got = cur.count(o)
            assert got == cnt, "anchor %r expected %d got %d" % (old[:50], cnt, got)
            cur = cur.replace(o, n)
        tmp = tu + ".tmp"
        with open(tmp, "wb") as f:
            f.write(cur)
        assert os.path.getsize(tmp) > 0
        os.replace(tmp, tu)
        print("applied:", name, "(backup at %s)" % bak)
        return
    print("no variant matching", want)


main()
