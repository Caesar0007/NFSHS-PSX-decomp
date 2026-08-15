#!/usr/bin/env python3
"""undefcall_audit.py -- THE THIRD CALL-AUDIT CLASS (w66-a3 named gap, W67-A6).

A call to an UNDEFINED callee is invisible to BOTH standing byte gates:
  * `verify_asm` is reloc-name lenient (a jal to a never-defined name still
    normalizes to `jal T`);
  * `calltarget_audit` needs BOTH names to carry VAs -- a callee with no VA
    (because nobody defines it) never produces a row.
Both w66-a3 shape defects (`__20tDialogMessageString` out-of-line ctor call,
`tScreen_ProcessInput__FP...` flattened-method mangling) were wrong call
targets in gate-PASSing, board-100 functions; the real link was the only
witness.  This tool makes that witness a standing per-SITE audit:

    for every lane object, every `R_MIPS_26` relocation (jal/j) in `.text`
    whose target symbol is NOT defined by any object of the lane is a
    CALL-TO-UNDEFINED site, attributed to its enclosing function.

Classes reported:
  UNDEF     the callee is defined nowhere in the lane and has no script-
            provided absolute -- a real link bug.  Exit-code-blocking.
  PROVIDED  the callee is undefined in the lane but carries a hard VA in
            linkers/undefined_{syms,funcs}_auto.txt -- the call links, but
            only through a script absolute (the stale_absolutes class);
            reported, not blocking.

Anti-vacuity (the banked gate-defect classes, defeated by construction):
  * nm/objdump are BATCHED (never one glob past ARG_MAX); an empty object
    list or an empty defined-set is a hard exit, never a silent pass;
  * the total number of R_MIPS_26 records scanned is printed and a
    tree-wide run that scanned fewer than 1000 refuses to report clean;
  * `--selftest` assembles a synthetic object carrying one call to a
    never-defined name through the audit's own code path and asserts it is
    flagged (the known-POSITIVE leg), so "0 sites" can never be vacuous.

The defined set reuses tools/relink.py's own machinery (`lane_objects`,
`nm_defined`, `batched` -- 12H anti-drift: imported, not re-implemented), so
"undefined" here means exactly what the relink gate means by it.

usage:
    python tools/undefcall_audit.py [--lane recon|src] [--json OUT] [--selftest]
    python tools/undefcall_audit.py --obj build/recon/game/common/sim.cpp.o
exit code: 0 = no UNDEF site (and selftest, if requested, passed);
           1 = UNDEF sites present; 2 = harness/vacuity error.
"""
import argparse
import importlib.util
import json
import re
import subprocess
import sys
import tempfile
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]      # tools/ -> repo root (16F!)
MIPS = Path(r"C:/Tools/mips-ps1/mips/bin")
OBJDUMP = str(MIPS / "mipsel-none-elf-objdump.exe")
AS = str(MIPS / "mipsel-none-elf-as.exe")

_spec = importlib.util.spec_from_file_location("nfs4relink", ROOT / "tools" / "relink.py")
relink = importlib.util.module_from_spec(_spec)
sys.modules["nfs4relink"] = relink
_spec.loader.exec_module(relink)

HDRRE = re.compile(r"^(\S+):\s+file format")
RELSEC = re.compile(r"^RELOCATION RECORDS FOR \[(\S+)\]:")
RELROW = re.compile(r"^([0-9a-f]{8})\s+(R_MIPS_\S+)\s+(\S+)")
SYMROW = re.compile(r"^([0-9a-f]{8})\s(.{7})\s+(\S+)\s+([0-9a-f]{8})\s+(.*)$")
CALL_RELOCS = ("R_MIPS_26",)


def provided_absolutes():
    """name -> VA from the two linker auto scripts (hard assignments)."""
    out = {}
    for auto in ("undefined_syms_auto.txt", "undefined_funcs_auto.txt"):
        p = ROOT / "linkers" / auto
        if not p.exists():
            continue
        for ln in p.read_text(errors="replace").splitlines():
            m = re.match(r"\s*(\S+?)\s*=\s*(0x[0-9A-Fa-f]+)\s*;", ln)
            if m:
                out[m.group(1)] = int(m.group(2), 16)
    return out


def _relpaths(b):
    out = []
    for p in b:
        p = Path(p)
        try:
            out.append(str(p.relative_to(ROOT).as_posix()))
        except ValueError:              # selftest temp object outside ROOT
            out.append(str(p))
    return out


def scan_calls(objs):
    """[(obj, sect, off, target)] for every CALL reloc, + total scanned."""
    sites, total = [], 0
    cur = sect = None
    for b in relink.batched(objs, 30):
        rel = _relpaths(b)
        r = subprocess.run([OBJDUMP, "-r"] + rel, capture_output=True,
                           text=True, cwd=ROOT)
        if not r.stdout.strip():
            sys.exit(f"objdump -r produced no output for a {len(rel)}-object "
                     f"batch -- refusing a vacuous scan")
        for ln in r.stdout.splitlines():
            m = HDRRE.match(ln)
            if m:
                cur, sect = m.group(1).replace("\\", "/"), None
                continue
            m = RELSEC.match(ln)
            if m:
                sect = m.group(1)
                continue
            m = RELROW.match(ln)
            if m and sect and sect.startswith(".text"):
                off, kind, tgt = int(m.group(1), 16), m.group(2), m.group(3)
                if kind in CALL_RELOCS:
                    total += 1
                    sites.append((cur, sect, off, tgt.split("+")[0].split("-")[0]))
    return sites, total


def text_symbols(objs):
    """obj -> sorted [(off, fnname)] of its named .text symbols (for site
    attribution).  Local $L / .L labels never appear in the symtab; splat
    debug rows are filtered like probe_link does."""
    out = defaultdict(list)
    cur = None
    for b in relink.batched(objs, 30):
        rel = _relpaths(b)
        r = subprocess.run([OBJDUMP, "-t"] + rel, capture_output=True,
                           text=True, cwd=ROOT)
        for ln in r.stdout.splitlines():
            m = HDRRE.match(ln)
            if m:
                cur = m.group(1).replace("\\", "/")
                continue
            m = SYMROW.match(ln)
            if m and cur:
                val, flags, sec, _sz, name = m.groups()
                name = name.split()[-1] if name.split() else ""
                if sec == ".text" and name and " df " not in flags:
                    out[cur].append((int(val, 16), name))
    for o in out:
        out[o].sort()
    return out


def enclosing_fn(symlist, off):
    fn = "?"
    for so, name in symlist:
        if so <= off:
            fn = name
        else:
            break
    return fn


def audit(objs, defined, provided):
    sites, total = scan_calls(objs)
    tsyms = text_symbols(objs)
    rows = []
    for obj, sect, off, tgt in sites:
        if tgt in defined or tgt.startswith("."):
            continue                    # defined, or a section-relative call
        cls = "PROVIDED" if tgt in provided else "UNDEF"
        rows.append({"class": cls, "obj": obj, "sect": sect, "off": off,
                     "fn": enclosing_fn(tsyms.get(obj, []), off),
                     "callee": tgt,
                     "va": f"{provided[tgt]:#010x}" if tgt in provided else None})
    return rows, total


def selftest(defined, provided):
    """assemble one synthetic call to a never-defined name and prove the
    audit's own code path flags it (the known-POSITIVE anti-vacuity leg)."""
    name = "w67a6_selftest_never_defined_callee"
    assert name not in defined and name not in provided
    src = (".text\n.globl w67a6_selftest_caller\nw67a6_selftest_caller:\n"
           f"\tjal\t{name}\n\tnop\n\tjr\t$31\n\tnop\n")
    with tempfile.TemporaryDirectory() as td:
        s = Path(td) / "t.s"
        o = Path(td) / "t.o"
        s.write_text(src)
        r = subprocess.run([AS, "-march=r3000", "-mabi=32", "-EL",
                            "-o", str(o), str(s)],
                           capture_output=True, text=True)
        if r.returncode or not o.exists():
            sys.exit(f"selftest: as failed:\n{r.stderr[:400]}")
        rows, total = audit([o], defined, provided)
    hit = [x for x in rows if x["callee"] == name and x["class"] == "UNDEF"
           and x["fn"] == "w67a6_selftest_caller"]
    assert total >= 1 and len(hit) == 1, \
        f"SELFTEST FAILED: synthetic undefined call not flagged (rows={rows})"
    print(f"[selftest] synthetic undefined call flagged: "
          f"{hit[0]['fn']} -> {hit[0]['callee']}  OK")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--lane", default="recon", choices=["recon", "src"])
    ap.add_argument("--obj", action="append",
                    help="audit only these objects (defined set still lane-wide)")
    ap.add_argument("--json")
    ap.add_argument("--selftest", action="store_true")
    a = ap.parse_args()

    objs = relink.lane_objects(a.lane)
    if not objs:
        sys.exit(f"no {a.lane}-lane objects -- refusing a vacuous audit")
    defined, _ = relink.nm_defined(objs)
    if not defined:
        sys.exit("empty lane-wide defined set -- refusing a vacuous audit")
    provided = provided_absolutes()
    print(f"[{a.lane}] objects={len(objs)}  defined names={len(defined)}  "
          f"script-provided absolutes={len(provided)}")

    if a.selftest:
        selftest(defined, provided)

    targets = [ROOT / o for o in a.obj] if a.obj else objs
    rows, total = audit(targets, defined, provided)
    print(f"[scan] R_MIPS_26 call relocs scanned: {total} "
          f"over {len(targets)} object(s)")
    if not a.obj and total < 1000:
        sys.exit(f"only {total} call relocs in a tree-wide scan -- "
                 f"refusing a vacuous clean")
    undef = [x for x in rows if x["class"] == "UNDEF"]
    prov = [x for x in rows if x["class"] == "PROVIDED"]
    print(f"CALLS-TO-UNDEFINED: UNDEF={len(undef)}  [must be 0]   "
          f"PROVIDED(script-absolute)={len(prov)}")
    for x in undef:
        print(f"  UNDEF     {x['obj']}  {x['fn']}+{x['off']:#x}  "
              f"-> {x['callee']}")
    for x in prov[:40]:
        print(f"  PROVIDED  {x['obj']}  {x['fn']}+{x['off']:#x}  "
              f"-> {x['callee']} @{x['va']}")
    if a.json:
        Path(a.json).write_text(json.dumps(
            {"lane": a.lane, "objects": len(targets), "call_relocs": total,
             "undef": len(undef), "provided": len(prov), "rows": rows},
            indent=1))
    return 1 if undef else 0


if __name__ == "__main__":
    sys.exit(main())
