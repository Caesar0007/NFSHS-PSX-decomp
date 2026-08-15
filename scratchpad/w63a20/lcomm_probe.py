#!/usr/bin/env python3
"""W63-A20 PROBE for the w62-a18 maspsx `.lcomm` guard (SYMBOL_LEDGER 1.2).

The shared maspsx (`C:/Temp/maspsx-master`, mirrored at `tools/maspsx`) is
agent-off-limits, so this probe runs BOTH assemblers side by side on the SAME
cc1 `.s` files that `tools/build.py` already produced under `build/`, using the
exact maspsx argv build.py uses (compile_c / compile_cpp, ~line 2110 / 2176):

    python <maspsx.py> --aspsx-version=2.77 --expand-div --run-assembler
           --gnu-as-path=<as> <AS_ARCH> -G<tu> -I include -I . -o <obj>
    (stdin = the .s text; C++ TUs get build.py's `_._` -> `___` rename first)

Nothing under build/, tools/, recon/ or the shared maspsx is written: both
objects go to a private temp dir.

It reports, per TU and tree-wide:
  * global .bss symbols before vs after the guard (`nm -g`, 'B');
  * whether every SECTION's CONTENT is byte-identical between the two objects
    (the load-bearing claim: the guard is symbol-BINDING only, so no gate
    result can move);
  * the gSwapFileName rows specifically.

usage: python lcomm_probe.py [--all]      (default: the 6 gSwapFileName TUs)
"""
import re
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
sys.path.insert(0, str(ROOT / "tools"))
import importlib.util
_s = importlib.util.spec_from_file_location("nfs4build", ROOT / "tools" / "build.py")
bp = importlib.util.module_from_spec(_s)
sys.modules["nfs4build"] = bp
_s.loader.exec_module(bp)                      # build.py is __main__-guarded

STOCK = Path(r"C:/Temp/maspsx-master/maspsx.py")
GUARD = ROOT / "scratchpad" / "w63a20" / "maspsx_lcomm" / "maspsx.py"
NM = Path(bp.MIPS) / "mipsel-none-elf-nm.exe"
OBJDUMP = Path(bp.MIPS) / "mipsel-none-elf-objdump.exe"

GSWAP_TUS = [
    "recon/frontend/common/screencarselect.cpp",
    "recon/frontend/common/screenpinkslips.cpp",
    "recon/frontend/common/screentournselect.cpp",
    "recon/frontend/common/screentracks.cpp",
    "recon/frontend/common/screentrackinfo.cpp",
    "recon/frontend/common/screentrophyroom.cpp",
]


def run_maspsx(maspsx, s_text, g, is_cpp, obj):
    cmd = [sys.executable, str(maspsx), f"--aspsx-version={bp.ASPSX_VERSION}",
           "--expand-div", "--run-assembler", f"--gnu-as-path={bp.AS}",
           *[str(a) for a in bp.AS_ARCH], f"-G{g}",
           "-I", str(bp.RECON if is_cpp else ROOT / "include"), "-I", str(ROOT),
           "-o", str(obj)]
    r = subprocess.run(cmd, input=s_text, capture_output=True, text=True, cwd=ROOT)
    return r


OBJCOPY = Path(bp.MIPS) / "mipsel-none-elf-objcopy.exe"


def sections(obj):
    """-> {name: (size, content-bytes)} for every section, via objcopy
    --dump-section (exact bytes; an objdump -s text compare embeds the object's
    FILE NAME in its header line and reports a false difference)."""
    out = {}
    r = subprocess.run([str(OBJDUMP), "-h", str(obj)], capture_output=True, text=True)
    for name, size in re.findall(r"^\s+\d+\s+(\S+)\s+([0-9a-f]{8})", r.stdout, re.M):
        if int(size, 16) == 0 or name in (".pdr",):     # .pdr = debug-only
            out[name] = (int(size, 16), b"")
            continue
        dst = obj.with_suffix(".sec")
        rr = subprocess.run([str(OBJCOPY), f"--dump-section={name}={dst}", str(obj)],
                            capture_output=True, text=True)
        out[name] = (int(size, 16), dst.read_bytes() if dst.exists() else b"")
        if dst.exists():
            dst.unlink()
    return out


def nm_syms(obj):
    r = subprocess.run([str(NM), str(obj)], capture_output=True, text=True)
    syms = {}
    for ln in r.stdout.splitlines():
        m = re.match(r"^([0-9a-f]*)\s+(\S)\s+(\S+)$", ln.strip())
        if m:
            syms[m.group(3)] = m.group(2)
    return syms


def main():
    tus = GSWAP_TUS
    if "--all" in sys.argv:
        tus = sorted(p.relative_to(ROOT).as_posix()[:-2]
                     for p in (ROOT / "build" / "recon").rglob("*.s")
                     if p.name.endswith((".c.s", ".cpp.s")))
        tus = [t.replace("build/", "", 1) for t in tus]
    elif "--census" in sys.argv:
        tus = [l.strip() for l in open(ROOT / "scratchpad/w63a20/lcomm_census.out")
               if l.strip().startswith("recon/")]
    tot_before = tot_after = 0
    content_moves = []
    print("%-46s %6s %6s  %s" % ("TU", "globB", "->globB", "gSwapFileName"))
    for rel in tus:
        s_path = ROOT / "build" / (rel + ".s")
        if not s_path.exists():
            print("%-46s   (no build/<tu>.s -- build the TU first)" % rel[6:])
            continue
        is_cpp = rel.endswith(".cpp")
        g = str(bp.per_tu_flags(ROOT / rel).get("g_value", bp.G_VALUE))
        s_text = s_path.read_text()
        if is_cpp:
            s_text = s_text.replace("_._", "___")
        with tempfile.TemporaryDirectory() as td:
            oa, ob = Path(td) / "a.o", Path(td) / "b.o"
            ra = run_maspsx(STOCK, s_text, g, is_cpp, oa)
            rb = run_maspsx(GUARD, s_text, g, is_cpp, ob)
            if ra.returncode or rb.returncode or not oa.exists() or not ob.exists():
                print("%-46s  MASPSX FAIL %s" % (rel[6:], (ra.stderr + rb.stderr)[:120]))
                continue
            sa, sb = nm_syms(oa), nm_syms(ob)
            ca, cb = sections(oa), sections(ob)
            ga = sum(1 for v in sa.values() if v == "B")
            gb = sum(1 for v in sb.values() if v == "B")
            tot_before += ga
            tot_after += gb
            if ca != cb:
                content_moves.append(rel)
            note = ""
            if "gSwapFileName" in sa:
                note = "%s -> %s" % (sa["gSwapFileName"], sb.get("gSwapFileName", "-"))
            print("%-46s %6d %6d  %s%s" % (rel[6:], ga, gb, note,
                                           "   *** CONTENT MOVED ***" if ca != cb else ""))
    print("\nTOTAL global .bss symbols (nm 'B'): %d -> %d  (delta %d)"
          % (tot_before, tot_after, tot_after - tot_before))
    print("TUs whose SECTION CONTENT changed: %d %s"
          % (len(content_moves), content_moves or "(none -- binding-only, no gate can move)"))


main()
