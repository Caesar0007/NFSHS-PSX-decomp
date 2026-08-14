"""w60a7 two-anchor variant probe (each variant = [repl_for_anchor, repl_for_anchor2])."""
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


def enc(s, crlf):
    b = s.encode("utf-8")
    return b.replace(b"\n", b"\r\n") if crlf else b


def main():
    tu, fn, cfg_path = sys.argv[1], sys.argv[2], sys.argv[3]
    cfg = json.load(io.open(cfg_path, encoding="utf-8"))
    path = os.path.join(REPO, tu.replace("/", os.sep))
    orig = read_bytes(path)
    crlf = b"\r\n" in orig
    anchors = [enc(cfg["anchor"], crlf), enc(cfg["anchor2"], crlf)]
    for i, a in enumerate(anchors):
        c = orig.count(a)
        if c != 1:
            print("ANCHOR%d count=%d (need 1)" % (i + 1, c))
            return 2
    env = dict(os.environ)
    env["VA_MAX"] = "400"
    try:
        for name, repls in cfg["variants"].items():
            data = orig
            for a, r in zip(anchors, repls):
                data = data.replace(a, enc(r, crlf))
            write_bytes(path, data)
            r = subprocess.run([sys.executable, "tools/verify_asm.py", tu, fn],
                               cwd=REPO, capture_output=True, text=True, env=env)
            out = (r.stdout + r.stderr)
            hit = [l.strip() for l in out.splitlines() if "PASS" in l or "FAIL" in l]
            print("%-32s %s" % (name, hit[0] if hit else out.strip()[:160]))
            sys.stdout.flush()
    finally:
        write_bytes(path, orig)
        assert read_bytes(path) == orig
    return 0


if __name__ == "__main__":
    sys.exit(main())
