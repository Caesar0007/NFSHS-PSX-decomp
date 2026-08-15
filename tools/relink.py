#!/usr/bin/env python3
"""relink.py -- THE STANDING LINK GATE (W65-A7 promotion of the W62-A18 spec).

`ld -r` a whole lane into one relocatable object.  ld itself is the ground
truth for multiple definitions; `nm -u` on the merged object is the ground
truth for the unresolved set.  Everything the byte gates are blind to at link
time is checked here:

  DUP        multiple definitions.  Split into the KNOWN SHRINKING blob class
             (one side is a build/asm/** splat blob -- the region-cut lane is
             eating these) and REAL duplicates (both sides are lane TUs).
             REAL dup must be 0.
  PHANTOM    hidden phantoms (feedback_verify_gate_hidden_phantom): an
             unresolved EXACT name whose VA *is* defined in the lane under a
             DIFFERENT spelling.  A VA-keyed "resolved" check would call this
             frontier; it is a link bug.  Must be 0.
  UNRESOLVED reloc-referenced undefined names -- the tracked frontier.  A
             symtab-only undefined (no relocation anywhere) is benign noise
             and is NOT counted (the src lane's 3486 __maspsx_include_asm_hack_*
             entries are exactly this).

Anti-vacuity (both banked gate defects are defeated by construction):
  * every nm/objdump invocation is BATCHED (never one glob past ARG_MAX); an
    empty object list is a hard exit, never a silent pass;
  * every comparison is on the EXACT mangled name -- VAs are used only to
    FIND a hidden phantom, never to declare a symbol resolved;
  * the excluded build subtrees are counted and printed, never assumed.

usage:
    python tools/relink.py [--lane recon|src|both] [--json OUT.json] [-v]
exit code: 0 = gate green, 1 = PHANTOM or REAL dup present, 2 = harness error.
"""
import argparse
import json
import re
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]      # tools/ -> repo root
MIPS = Path(r"C:/Tools/mips-ps1/mips/bin")
LD = str(MIPS / "mipsel-none-elf-ld.exe")
NM = str(MIPS / "mipsel-none-elf-nm.exe")
OBJDUMP = str(MIPS / "mipsel-none-elf-objdump.exe")
OUTDIR = ROOT / "build" / "relink"

# build subtrees that are NOT part of any link (printed, never silently skipped)
EXCLUDED = ("diffsrc", "scratch", "scratchpad", "pbuild", "relink")
LANES = {"recon": ("recon", "asm"), "src": ("src", "asm")}
PLACEHOLDER = re.compile(r"(?:func|D|DAT|lbl|jtbl)_([0-9A-Fa-f]{8})$")


def batched(seq, n):
    for i in range(0, len(seq), n):
        yield seq[i:i + n]


def lane_objects(lane):
    objs = []
    for sub in LANES[lane]:
        objs += sorted(o for o in (ROOT / "build" / sub).rglob("*.o")
                       if not set(EXCLUDED) & set(o.parts))
    return objs


def excluded_census():
    out = {}
    for name in EXCLUDED:
        d = ROOT / "build" / name
        out[name] = len(list(d.rglob("*.o"))) if d.is_dir() else 0
    return out


def symbol_vas():
    """name -> VA from configs/symbol_addrs.txt; names with >1 VA are dropped
    (per-TU static copies would otherwise mis-attribute a VA)."""
    vas, dup = {}, set()
    p = ROOT / "configs" / "symbol_addrs.txt"
    for ln in p.open(encoding="utf-8", errors="replace"):
        m = re.match(r"(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);", ln)
        if m:
            n, v = m.group(1), int(m.group(2), 16)
            if n in vas and vas[n] != v:
                dup.add(n)
            vas.setdefault(n, v)
    for n in dup:
        del vas[n]
    return vas, dup


def va_of(name, vas):
    if name in vas:
        return vas[name]
    m = PLACEHOLDER.match(name)
    return int(m.group(1), 16) if m else None


def nm_defined(objs):
    """exact defined global names across the lane (batched nm -g --defined-only)"""
    names = set()
    per_obj = defaultdict(set)
    cur = None
    for b in batched(objs, 40):
        r = subprocess.run([NM, "-g", "--defined-only"] +
                           [str(p.relative_to(ROOT).as_posix()) for p in b],
                           capture_output=True, text=True, cwd=ROOT)
        for ln in r.stdout.splitlines():
            ln = ln.rstrip()
            if not ln:
                continue
            if ln.endswith(":") and "/" in ln:
                cur = ln[:-1]
                continue
            parts = ln.split()
            if len(parts) >= 3 and len(parts[1]) == 1:
                names.add(parts[2])
                if cur:
                    per_obj[cur].add(parts[2])
            elif len(parts) == 2 and len(parts[0]) == 1:
                names.add(parts[1])
                if cur:
                    per_obj[cur].add(parts[1])
    return names, per_obj


def reloc_referenced(objs):
    """every symbol name an actual R_MIPS_* relocation references (batched)."""
    refs = set()
    for b in batched(objs, 30):
        r = subprocess.run([OBJDUMP, "-r"] +
                           [str(p.relative_to(ROOT).as_posix()) for p in b],
                           capture_output=True, text=True, cwd=ROOT)
        for ln in r.stdout.splitlines():
            m = re.match(r"^[0-9a-f]{8}\s+(R_MIPS_\S+)\s+(\S+)", ln)
            if m:
                refs.add(m.group(2).split("+")[0].split("-")[0])
    return refs


DUPRE = re.compile(r"multiple definition of [`'](.+?)'; (\S+?):")
# ld prints the ADDING object on its own `ld: <obj>: in function` line and the
# already-defining object inside the `; <obj>: first defined here` clause.  The
# head form (`ld: <obj>:(.sec+0x..): multiple definition`) also exists -- but the
# `ld` prefix is REQUIRED in that pattern, otherwise it matches the *second*
# object on the two-line form and both sides read as the same file.
INFN = re.compile(r"ld(?:\.exe)?: (\S+\.o): in function")
DUPHEAD = re.compile(r"ld(?:\.exe)?: (\S+\.o):\(")


def text_census(objs):
    """how many of these objects carry a NON-EMPTY .text (batched objdump -h).
    NB: parse the SIZE.  `\\s+(?!00000000)` looks right and is WRONG -- the
    greedy \\s+ backtracks one space and the lookahead trivially succeeds
    (measured: it reported 461/461 non-empty on a tree of empty shells)."""
    n = 0
    for b in batched(objs, 30):
        r = subprocess.run([OBJDUMP, "-h"] +
                           [str(p.relative_to(ROOT).as_posix()) for p in b],
                           capture_output=True, text=True, cwd=ROOT)
        for ln in r.stdout.splitlines():
            m = re.match(r"^\s*\d+\s+\.text\s+([0-9a-f]{8})\s", ln)
            if m and int(m.group(1), 16):
                n += 1
    return n


def run_lane(lane, verbose=False):
    objs = lane_objects(lane)
    if not objs:
        print(f"[{lane}] NO OBJECTS -- refusing a vacuous gate", file=sys.stderr)
        raise SystemExit(2)
    # 🔴 SKIP-ASM VACUITY GUARD (W62-A18 hazard, fired again in W65-A7):
    # `build.py --skip-asm` makes INCLUDE_ASM a no-op, so every build/src/*.o
    # is a ~950-byte EMPTY SHELL.  The src lane then reports 0 duplicates and
    # ~1000 phantom undefined `.L<VA>` labels -- a completely false green/red.
    if lane == "src":
        ne = text_census([o for o in objs if "src" in o.parts])
        tot = sum(1 for o in objs if "src" in o.parts)
        if ne * 2 < tot:
            print(f"[src] REFUSING: only {ne}/{tot} src objects carry .text -- "
                  f"this tree was built with --skip-asm; rebuild asm-inclusive "
                  f"(`python tools/build.py --no-link`) before trusting any "
                  f"src-lane link number", file=sys.stderr)
            raise SystemExit(2)
    OUTDIR.mkdir(parents=True, exist_ok=True)
    rsp = OUTDIR / f"{lane}.rsp"
    merged = OUTDIR / f"{lane}_all.o"

    def do_link(extra):
        # 🔴 a STALE merged object from an earlier pass reads as a perfectly
        # plausible symbol table (measured: a partial `ld -r` output made 25
        # resolved symbols look like hidden phantoms).  Always start from none.
        if merged.exists():
            merged.unlink()
        rsp.write_text("\n".join('"' + o.relative_to(ROOT).as_posix() + '"'
                                 for o in objs))
        return subprocess.run(
            [LD, "-r"] + extra +
            ["-o", str(merged.relative_to(ROOT).as_posix()),
             "@" + str(rsp.relative_to(ROOT).as_posix())],
            capture_output=True, text=True, cwd=ROOT)

    r = do_link([])
    # build/** churns under peer agents: an object can vanish between the glob
    # and the link.  Re-glob once and retry before believing any number.
    if "cannot find" in r.stderr:
        objs = lane_objects(lane)
        r = do_link([])
        if "cannot find" in r.stderr:
            print(f"[{lane}] objects keep vanishing mid-link (peer build churn)"
                  f" -- re-run", file=sys.stderr)
            raise SystemExit(2)
    err = r.stderr.replace("\r\n", "\n")
    (OUTDIR / f"{lane}_ld_r.err").write_text(err)

    # ---- multiple definitions, with the OWNING object of each side --------
    dups, cur = [], None
    for ln in err.split("\n"):
        m = INFN.search(ln)
        if m:
            cur = m.group(1)
        m = DUPRE.search(ln)
        if m:
            head = DUPHEAD.search(ln)
            dups.append({"sym": m.group(1),
                         "a": (head.group(1) if head else cur) or "?",
                         "b": m.group(2)})

    def is_blob(p):
        p = (p or "").replace("\\", "/")
        return "build/asm/" in p or p.startswith("asm/")

    dup_blob = [d for d in dups if is_blob(d["a"]) or is_blob(d["b"])]
    dup_real = [d for d in dups if d not in dup_blob]

    # ---- unresolved: nm -u on the merged object, reloc-filtered ----------
    # 🔴 ANTI-VACUITY: when duplicates make `ld -r` fail there is NO merged
    # object, and a naive `nm -u` on a missing file reports ZERO unresolved --
    # a vacuous green.  Re-link permissively for the symbol view.
    if r.returncode or not merged.exists():
        r2 = do_link(["--allow-multiple-definition"])
        (OUTDIR / f"{lane}_ld_r_multdefok.err").write_text(
            r2.stderr.replace("\r\n", "\n"))
        if r2.returncode or not merged.exists():
            print(f"[{lane}] no merged object even with "
                  f"--allow-multiple-definition (rc={r2.returncode}) -- "
                  f"refusing a vacuous count:\n{r2.stderr[:400]}",
                  file=sys.stderr)
            raise SystemExit(2)
    undef = set()
    u = subprocess.run([NM, "-u", str(merged.relative_to(ROOT).as_posix())],
                       capture_output=True, text=True, cwd=ROOT)
    for ln in u.stdout.splitlines():
        if ln.strip():
            undef.add(ln.split()[-1])
    refs = reloc_referenced(objs)
    unres = sorted(undef & refs)
    benign = sorted(undef - refs)

    # ---- hidden phantoms -------------------------------------------------
    vas, multiva = symbol_vas()
    defined, _ = nm_defined(objs)
    va_to_names = defaultdict(set)
    for n in defined:
        v = va_of(n, vas)
        if v is not None:
            va_to_names[v].add(n)
    phantoms = []
    for n in unres:
        v = va_of(n, vas)
        if v is not None and va_to_names.get(v):
            phantoms.append({"sym": n, "va": f"{v:#010x}",
                             "defined_as": sorted(va_to_names[v])})

    res = {
        "lane": lane, "objects": len(objs), "ld_r_rc": r.returncode,
        "dup_total": len(dups), "dup_blob": len(dup_blob),
        "dup_real": len(dup_real),
        "unresolved_reloc": len(unres), "unresolved_benign": len(benign),
        "phantoms": len(phantoms),
        "multi_va_names_excluded": len(multiva),
        "excluded_subtrees": excluded_census(),
        "dup_real_rows": dup_real, "phantom_rows": phantoms,
        "unresolved_names": unres,
    }
    print(f"== lane {lane}: {len(objs)} objects "
          f"(excluded: {res['excluded_subtrees']})")
    print(f"   ld -r rc={r.returncode}")
    print(f"   DUP total={len(dups)}  blob-class={len(dup_blob)}  "
          f"REAL={len(dup_real)}          [REAL must be 0]")
    print(f"   HIDDEN PHANTOMS={len(phantoms)}                          "
          f"[must be 0]")
    print(f"   UNRESOLVED (reloc-referenced)={len(unres)}  "
          f"(symtab-only, benign={len(benign)})")
    for d in dup_real[:20]:
        print(f"     REAL DUP  {d['sym']}  {d['a']}  <->  {d['b']}")
    for p in phantoms[:20]:
        print(f"     PHANTOM   {p['sym']}  @{p['va']}  "
              f"defined as {', '.join(p['defined_as'])}")
    if verbose:
        for n in unres:
            print(f"     unresolved  {n}")
    return res


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--lane", default="both", choices=["recon", "src", "both"])
    ap.add_argument("--json")
    ap.add_argument("-v", "--verbose", action="store_true")
    a = ap.parse_args()
    lanes = ["recon", "src"] if a.lane == "both" else [a.lane]
    out = [run_lane(l, a.verbose) for l in lanes]
    if a.json:
        Path(a.json).write_text(json.dumps(out, indent=1))
    bad = sum(r["phantoms"] + r["dup_real"] for r in out)
    print("GATE: " + ("GREEN" if not bad else f"RED ({bad} blocking rows)"))
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
