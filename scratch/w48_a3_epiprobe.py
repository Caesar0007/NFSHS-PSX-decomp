"""w48-a3 EPILOGUE-ONLY un-fill probe.

PROOF-OF-CONCEPT for the "epilogue swap" class.  The w25 per-fn splice takes the
WHOLE function from the -fno-delayed-branch build, which also loses dbr's body
delay-slot fills.  This probe instead post-processes the NORMAL (delayed-branch
ON) cc1 output and un-fills ONLY the function's RETURN delay slot, i.e. rewrites

        .set noreorder ; .set nomacro
        j   $31
        <FILLER>
        .set macro ; .set reorder
into
        <FILLER>
        j   $31

which is exactly what cc1 emits for that tail with -fno-delayed-branch.
Patches tools/build.py in place (additive hook after _apply_fn_splice) and always
restores it in a finally block.

Usage: python scratch/w48_a3_epiprobe.py <recon/tu.c> <fnA,fnB,...> <gate list>
"""
import subprocess, sys, re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BUILD = ROOT / "tools" / "build.py"
MARK = "def _apply_fn_splice(rel_posix: str, s_file: Path, i_file: Path,"

HOOK = '''
W48A3_EPI = set()

_W48A3_RE = re.compile(
    r"\\t\\.set\\tnoreorder\\n\\t\\.set\\tnomacro\\n\\tj\\t\\$31\\n(\\t[^\\n]*\\n)"
    r"\\t\\.set\\tmacro\\n\\t\\.set\\treorder\\n")


def _w48a3_unfill(s_file):
    if not W48A3_EPI:
        return
    txt = s_file.read_text(errors="replace")
    for name in W48A3_EPI:
        m = re.search(r"^\\t\\.ent\\t%s\\b[^\\n]*\\n" % re.escape(name), txt, re.M)
        if not m:
            continue
        m2 = re.search(r"^\\t\\.end\\t%s[ \\t]*$" % re.escape(name), txt[m.end():], re.M)
        end = m.end() + (m2.start() if m2 else 0)
        region = txt[m.start():end]
        new = _W48A3_RE.sub(lambda mm: mm.group(1) + "\\tj\\t$31\\n", region)
        if new != region:
            txt = txt[:m.start()] + new + txt[end:]
    s_file.write_text(txt)


'''


def main():
    rel, names, gate = sys.argv[1], sys.argv[2], sys.argv[3]
    orig = BUILD.read_bytes()
    try:
        t = orig.decode("utf-8")
        assert t.count(MARK) == 1
        t = t.replace(MARK, HOOK + MARK)
        # call the hook at the end of _apply_fn_splice's two call sites
        t = t.replace("    _apply_fn_splice(rel.as_posix(), s_file, i_file, CC1, cc1_flags)",
                      "    _apply_fn_splice(rel.as_posix(), s_file, i_file, CC1, cc1_flags)\n    _w48a3_unfill(s_file)")
        t = t.replace("    _apply_fn_splice(rel.as_posix(), s_file, i_file, CC1PL, cc1pl_flags)",
                      "    _apply_fn_splice(rel.as_posix(), s_file, i_file, CC1PL, cc1pl_flags)\n    _w48a3_unfill(s_file)")
        t = t.replace("W48A3_EPI = set()",
                      "W48A3_EPI = set(%r)" % [x for x in names.split(",") if x])
        if len(sys.argv) > 4:   # optional: override PER_FN_NO_DELAYED_BRANCH for this TU
            m2 = "def per_fn_no_delayed_branch(src: Path) -> set:"
            t = t.replace(m2, "PER_FN_NO_DELAYED_BRANCH[%r] = set(%r)\n\n\n" % (
                rel, [x for x in sys.argv[4].split(",") if x]) + m2)
        BUILD.write_bytes(t.encode("utf-8"))
        r = subprocess.run([sys.executable, "tools/verify_asm.py", rel, gate],
                           cwd=ROOT, capture_output=True, text=True, timeout=1200)
        for ln in (r.stdout + r.stderr).splitlines():
            if "PASS" in ln or "FAIL" in ln or "ORACLE" in ln or "OBJECT" in ln or "Error" in ln:
                print(ln)
    finally:
        BUILD.write_bytes(orig)
        assert BUILD.read_bytes() == orig


main()
