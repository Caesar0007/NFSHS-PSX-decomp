"""w60a7 multi-replacement variant probe.

cfg = {"variants": {"name": [[old, new, expected_count], ...]}}
expected_count optional (default 1; use 0 for "replace all occurrences, any count").
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


def main():
    tu, fn, cfg_path = sys.argv[1], sys.argv[2], sys.argv[3]
    cfg = json.load(io.open(cfg_path, encoding="utf-8"))
    path = os.path.join(REPO, tu.replace("/", os.sep))
    orig = read_bytes(path)
    crlf = b"\r\n" in orig

    def enc(s):
        b = s.encode("utf-8")
        return b.replace(b"\n", b"\r\n") if crlf else b

    env = dict(os.environ)
    env["VA_MAX"] = "400"
    try:
        for name, reps in cfg["variants"].items():
            data = orig
            bad = None
            for rep in reps:
                old, new = enc(rep[0]), enc(rep[1])
                want = rep[2] if len(rep) > 2 else 1
                got = data.count(old)
                if want and got != want:
                    bad = "REP MISS (%d != %d): %.60r" % (got, want, rep[0][:60])
                    break
                if got == 0:
                    bad = "REP ZERO: %.60r" % rep[0][:60]
                    break
                data = data.replace(old, new)
            if bad:
                print("%-38s %s" % (name, bad))
                continue
            write_bytes(path, data)
            r = subprocess.run([sys.executable, "tools/verify_asm.py", tu, fn],
                               cwd=REPO, capture_output=True, text=True, env=env)
            out = (r.stdout + r.stderr)
            hit = [l.strip() for l in out.splitlines() if "PASS" in l or "FAIL" in l]
            print("%-38s %s" % (name, hit[0] if hit else out.strip()[:200]))
            sys.stdout.flush()
    finally:
        write_bytes(path, orig)
        assert read_bytes(path) == orig
    return 0


if __name__ == "__main__":
    sys.exit(main())
