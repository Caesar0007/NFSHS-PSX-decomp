"""Apply ONE variant, run a command (default side_by_side), restore."""
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


def main():
    tu, fn, cfg_path, vname = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
    tool = sys.argv[5] if len(sys.argv) > 5 else "tools/side_by_side.py"
    cfg = json.load(io.open(cfg_path, encoding="utf-8"))
    path = os.path.join(REPO, tu.replace("/", os.sep))
    orig = read_bytes(path)
    crlf = b"\r\n" in orig
    anchor = cfg["anchor"].encode("utf-8")
    if crlf:
        anchor = anchor.replace(b"\n", b"\r\n")
    assert orig.count(anchor) == 1
    rb = cfg["variants"][vname].encode("utf-8")
    if crlf:
        rb = rb.replace(b"\n", b"\r\n")
    try:
        write_bytes(path, orig.replace(anchor, rb))
        env = dict(os.environ)
        env["VA_MAX"] = "400"
        r = subprocess.run([sys.executable, tool, tu, fn], cwd=REPO,
                           capture_output=True, text=True, env=env)
        print(r.stdout + r.stderr)
    finally:
        write_bytes(path, orig)
        assert read_bytes(path) == orig


if __name__ == "__main__":
    main()
