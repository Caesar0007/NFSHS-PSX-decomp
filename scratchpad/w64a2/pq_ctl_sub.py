"""w63-a2: psyqproof CONTROL run -- measure the pre-edit (HEAD) draww.cpp in the
production lane, then restore the working copy.  Byte-mode, finally-restore."""
import os, subprocess, sys
ROOT = r"C:/Temp/nfs4-decomp"
REL = "recon/game/psx/draww.cpp"
FN = "DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss"
path = os.path.join(ROOT, REL)
cur = open(path, "rb").read()
head = subprocess.run(["git", "show", "HEAD:" + REL], cwd=ROOT,
                      capture_output=True).stdout
assert len(head) > 100000, len(head)
# git show returns the LF blob under autocrlf; match the working file's regime
if cur.count(b"\r\n") > cur.count(b"\n") // 2 and b"\r\n" not in head:
    head = head.replace(b"\n", b"\r\n")
try:
    tmp = path + ".pqtmp"
    open(tmp, "wb").write(head)
    assert os.path.getsize(tmp) > 100000
    os.replace(tmp, path)
    r = subprocess.run([sys.executable, "tools/psyqproof.py", REL, FN],
                       cwd=ROOT, capture_output=True, text=True)
    print("CONTROL(HEAD):", [l for l in r.stdout.splitlines() if "REAL=" in l])
finally:
    tmp = path + ".pqtmp"
    open(tmp, "wb").write(cur)
    os.replace(tmp, path)
    assert open(path, "rb").read() == cur
    print("(restored)")
