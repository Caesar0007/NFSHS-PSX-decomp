"""w48-a6 report-only per-TU flag screen (PATCH build.py PER_TU_FLAGS, gate whole TU, RESTORE)."""
import sys, io, re, subprocess, os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BUILD = os.path.join(ROOT, "tools", "build.py")
ANCHOR = "PER_TU_FLAGS = {\n"

TUS = [
    ("recon/syslib/psx/libcd/iso9660.c",
     "CdSearchFile,CD_newmedia,_cd_find_path,CD_cachefile,cd_read,_cd_cmp_name"),
]
FLAGS = [
    ("baseline", None),
    ("no_split_addresses", '{"no_split_addresses": True}'),
    ("nosplit+G0", '{"no_split_addresses": True, "g_value": "0"}'),
]


def gate(path, fns):
    r = subprocess.run([sys.executable, "tools/verify_asm.py", path, fns],
                       capture_output=True, text=True, cwd=ROOT, timeout=1800)
    out = r.stdout + r.stderr
    res = {}
    for m in re.finditer(r'^\s+(\S+): (PASS|FAIL (\d+) diffs|NO ORACLE|NOT IN OBJECT)', out, re.M):
        res[m.group(1)] = 0 if m.group(2) == 'PASS' else (int(m.group(3)) if m.group(3) else None)
    return res


def main():
    with io.open(BUILD, 'r', newline='') as f:
        orig = f.read()
    nl = '\r\n' if orig.count('\r\n') > 5 else '\n'
    a = ANCHOR.replace('\n', nl)
    assert orig.count(a) == 1
    try:
        for path, fns in TUS:
            print("\n### " + path)
            cols = []
            for name, spec in FLAGS:
                if spec is None:
                    io.open(BUILD, 'w', newline='').write(orig)
                else:
                    io.open(BUILD, 'w', newline='').write(
                        orig.replace(a, a + '    "%s": %s,%s' % (path, spec, nl)))
                cols.append((name, gate(path, fns)))
            keys = sorted({k for _, c in cols for k in c})
            print("%-22s %s" % ("fn", " ".join("%-19s" % n for n, _ in cols)))
            for k in keys:
                print("%-22s %s" % (k, " ".join("%-19s" % str(c.get(k)) for _, c in cols)))
    finally:
        io.open(BUILD, 'w', newline='').write(orig)
        print("\nbuild.py restored (%d bytes)" % len(orig))


main()
