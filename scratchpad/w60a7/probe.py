"""w60a7 generic single-TU variant probe.

Usage:  python probe.py <tu-rel-path> <fn> <variants.json>
variants.json = {"anchor": "<exact substring present once>", "variants": {"name": "<replacement>"}}
Restores the file in a finally block.  Byte-mode IO, CRLF preserved.
"""
import io, json, os, subprocess, sys, tempfile

REPO = r"C:\Temp\nfs4-decomp"


def read_bytes(p):
    with open(p, "rb") as f:
        return f.read()


def write_bytes(p, data):
    assert len(data) > 0
    fd, tmp = tempfile.mkstemp(dir=os.path.dirname(p), suffix=".tmp")
    with os.fdopen(fd, "wb") as f:
        f.write(data)
    os.replace(tmp, p)


def gate(tu, fn):
    env = dict(os.environ)
    env["VA_MAX"] = "400"
    r = subprocess.run([sys.executable, "tools/verify_asm.py", tu, fn],
                       cwd=REPO, capture_output=True, text=True, env=env)
    out = r.stdout + r.stderr
    for line in out.splitlines():
        if fn in line and ("PASS" in line or "FAIL" in line or "NO ORACLE" in line or "NOT IN" in line):
            return line.strip(), out
    return "??? " + out.strip()[:200], out


def main():
    tu, fn, cfg_path = sys.argv[1], sys.argv[2], sys.argv[3]
    cfg = json.load(io.open(cfg_path, encoding="utf-8"))
    path = os.path.join(REPO, tu.replace("/", os.sep))
    orig = read_bytes(path)
    anchor = cfg["anchor"].encode("utf-8")
    crlf = b"\r\n" in orig
    if crlf:
        anchor = anchor.replace(b"\n", b"\r\n")
    n = orig.count(anchor)
    if n != 1:
        print("ANCHOR count = %d (need 1)" % n)
        return 2
    try:
        for name, repl in cfg["variants"].items():
            rb = repl.encode("utf-8")
            if crlf:
                rb = rb.replace(b"\n", b"\r\n")
            write_bytes(path, orig.replace(anchor, rb))
            line, _ = gate(tu, fn)
            print("%-40s %s" % (name, line))
            sys.stdout.flush()
    finally:
        write_bytes(path, orig)
        assert read_bytes(path) == orig
    return 0


if __name__ == "__main__":
    sys.exit(main())
