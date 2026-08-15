#!/usr/bin/env python3
"""probe_link.py -- THE STANDING LAYOUT PROBE (W65-A7 promotion of W62-A19).

Places every recon object's `.text` at its IMPLIED RETAIL BASE (base = retail
VA - our section offset, taken as the mode over that object's text symbols),
links the lane for real with GNU ld, flattens the placed regions and byte-
compares them against `rom/nfs4-f.exe`.  The percentage is the honest
"how much of the retail image does the recon lane already reproduce IN PLACE"
number -- strictly stronger than a per-function byte gate, because it also
prices intra-object layout.

🔴 THE STALE-OBJDATA HAZARD (catalog 15E): the object census is re-scanned by
default on every run.  A cached `objdata.json` from before a peer landing has
been measured to cost ~1% of the score.  `--reuse-objdata` is available for
back-to-back A/B runs only, and always prints the cache's age.

usage:
    python tools/probe_link.py [--reuse-objdata] [--min-pct P] [--json OUT]
exit code: 0 = ran and (if --min-pct given) met the floor; 1 = below the
floor; 2 = harness/vacuity error.
"""
import argparse
import json
import re
import subprocess
import sys
import time
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]      # tools/ -> repo root
MIPS = Path(r"C:/Tools/mips-ps1/mips/bin")
LD = str(MIPS / "mipsel-none-elf-ld.exe")
OBJCOPY = str(MIPS / "mipsel-none-elf-objcopy.exe")
OBJDUMP = str(MIPS / "mipsel-none-elf-objdump.exe")
OUTDIR = ROOT / "build" / "probe_link"
FBASE = 0x8000F800          # file offset 0 of rom/nfs4-f.exe maps to this VA
TEXT_START = 0x800128F0     # first placed .text VA (the spine's low water mark)
EXCLUDED = ("diffsrc", "scratch", "scratchpad", "pbuild", "relink", "probe_link")

HDRRE = re.compile(r"^(\S+):\s+file format")
SYMRE = re.compile(r"^([0-9a-f]{8})\s(.{7})\s+(\S+)\s+([0-9a-f]{8})\s(.*)$")
SECRE = re.compile(r"^\s*\d+\s+(\S+)\s+([0-9a-f]{8})\s+")
PLACEHOLDER = re.compile(r"(?:func|D|lbl)_([0-9A-Fa-f]{8})$")


def batched(seq, n):
    for i in range(0, len(seq), n):
        yield seq[i:i + n]


def recon_objects():
    return sorted(o for o in (ROOT / "build" / "recon").rglob("*.o")
                  if not set(EXCLUDED) & set(o.parts))


def scan(objs):
    """symbols + section sizes for every recon object (batched objdump)."""
    data = {}
    cur = None
    for b in batched(objs, 40):
        rel = [p.relative_to(ROOT).as_posix() for p in b]
        r = subprocess.run([OBJDUMP, "-t"] + rel, capture_output=True,
                           text=True, cwd=ROOT)
        for ln in r.stdout.splitlines():
            m = HDRRE.match(ln)
            if m:
                cur = m.group(1).replace("\\", "/")
                data.setdefault(cur, {"syms": [], "secs": {}})
                continue
            m = SYMRE.match(ln)
            if m and cur:
                val, flags, sec, size, name = m.groups()
                if sec != ".text" or " d " in flags or " df " in flags:
                    continue
                data[cur]["syms"].append({"off": int(val, 16),
                                          "name": name.strip()})
    cur = None
    for b in batched(objs, 40):
        rel = [p.relative_to(ROOT).as_posix() for p in b]
        r = subprocess.run([OBJDUMP, "-h"] + rel, capture_output=True,
                           text=True, cwd=ROOT)
        for ln in r.stdout.splitlines():
            m = HDRRE.match(ln)
            if m:
                cur = m.group(1).replace("\\", "/")
                data.setdefault(cur, {"syms": [], "secs": {}})
                continue
            m = SECRE.match(ln)
            if m and cur:
                data[cur]["secs"][m.group(1)] = int(m.group(2), 16)
    return data


def symbol_vas():
    vas, dup = {}, set()
    for ln in (ROOT / "configs" / "symbol_addrs.txt").open(
            encoding="utf-8", errors="replace"):
        m = re.match(r"(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);\s*//\s*type:func", ln)
        if m:
            n, v = m.group(1), int(m.group(2), 16)
            if n in vas and vas[n] != v:
                dup.add(n)
            vas.setdefault(n, v)
    for n in dup:
        del vas[n]
    return vas, dup


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--reuse-objdata", action="store_true")
    ap.add_argument("--min-pct", type=float)
    ap.add_argument("--json")
    a = ap.parse_args()

    OUTDIR.mkdir(parents=True, exist_ok=True)
    objs = recon_objects()
    if not objs:
        sys.exit("no build/recon objects -- refusing a vacuous probe")
    cache = OUTDIR / "objdata.json"
    if a.reuse_objdata and cache.exists():
        age = time.time() - cache.stat().st_mtime
        print(f"[scan] REUSING cached objdata.json, age {age/60:.1f} min "
              f"-- stale cache costs ~1% (catalog 15E)")
        objdata = json.load(cache.open())
    else:
        objdata = scan(objs)
        cache.write_text(json.dumps(objdata, indent=0))
    print(f"[scan] objects={len(objs)} scanned={len(objdata)}")

    vas, multiva = symbol_vas()
    rows = []
    nobase = 0
    for o, d in objdata.items():
        tsz = d.get("secs", {}).get(".text", 0)
        if not tsz:
            continue
        bases = defaultdict(int)
        for s in d["syms"]:
            va = vas.get(s["name"])
            if va is None:
                m = PLACEHOLDER.match(s["name"])
                if m:
                    va = int(m.group(1), 16)
            if va is not None:
                bases[va - s["off"]] += 1
        if bases:
            rows.append((max(bases.items(), key=lambda kv: kv[1])[0], tsz, o))
        else:
            nobase += 1
    rows.sort()
    if not rows:
        sys.exit("no object got an implied base -- refusing a vacuous probe")

    placed, dropped, cur = [], [], 0
    for base, sz, o in rows:
        if base < cur:
            dropped.append((base, sz, o))
            continue
        placed.append((base, sz, o))
        cur = base + sz
    print(f"[spine] with .text={len(rows)}  placed={len(placed)}  "
          f"dropped(interleaved)={len(dropped)}  no-base={nobase}  "
          f"(multi-VA names excluded: {len(multiva)})")

    lines = ["SECTIONS", "{"]
    for i, (base, sz, o) in enumerate(placed):
        lines.append(f"    .t{i:04d} {base:#x} : SUBALIGN(4) {{ {o}(.text) }}")
    lines += ["    .other 0x80300000 : { *(.data) *(.sdata) *(.rodata) "
              "*(.bss) *(.sbss) *(COMMON) }",
              "    /DISCARD/ : { *(.pdr) *(.reginfo) *(.MIPS.abiflags) "
              "*(.gnu.attributes) *(.comment) }", "}"]
    script = OUTDIR / "probe.ld"
    script.write_text("\n".join(lines) + "\n")

    elf = OUTDIR / "probe.elf"
    if elf.exists():
        elf.unlink()
    cmd = [LD]
    for auto in ("undefined_syms_auto.txt", "undefined_funcs_auto.txt"):
        p = ROOT / "linkers" / auto
        if p.exists():
            cmd += ["-T", str(p.relative_to(ROOT).as_posix())]
    cmd += ["-T", str(script.relative_to(ROOT).as_posix()),
            "--unresolved-symbols=ignore-all", "--allow-multiple-definition",
            "--no-check-sections", "--noinhibit-exec",
            "-Map", str((OUTDIR / "probe.map").relative_to(ROOT).as_posix()),
            "-o", str(elf.relative_to(ROOT).as_posix())]
    r = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True)
    errs = [l for l in r.stderr.replace("\r\n", "\n").split("\n") if l.strip()]
    print(f"[ld] rc={r.returncode}  stderr lines={len(errs)}")
    for e in errs[:5]:
        print("   ", e)
    if not elf.exists():
        print("no ELF produced -- refusing a vacuous score", file=sys.stderr)
        return 2

    binf = OUTDIR / "probe.bin"
    sects = [f"--only-section=.t{i:04d}" for i in range(len(placed))]
    subprocess.run([OBJCOPY, "-O", "binary", *sects, str(elf), str(binf)],
                   check=True)
    img = binf.read_bytes()
    rom = (ROOT / "rom" / "nfs4-f.exe").read_bytes()
    print(f"[img] linked .text image {len(img)} bytes "
          f"({TEXT_START:#x}..{TEXT_START + len(img):#x})")

    totb = okb = 0
    per = []
    for base, sz, o in placed:
        off = base - TEXT_START
        ours = img[off:off + sz]
        theirs = rom[base - FBASE:base - FBASE + sz]
        n = sum(1 for x, y in zip(ours, theirs) if x == y)
        totb += sz
        okb += n
        per.append((sz - n, sz, o))
    if not totb:
        print("zero bytes compared -- refusing a vacuous score", file=sys.stderr)
        return 2
    pct = 100.0 * okb / totb
    exact = sum(1 for d, s, o in per if d == 0)
    print(f"[cmp] bytes compared={totb}  identical={okb}  ({pct:.2f}%)")
    print(f"[cmp] objects byte-IDENTICAL to retail: {exact}/{len(placed)}")

    with (OUTDIR / "link_probe.txt").open("w") as f:
        f.write(f"placed={len(placed)} dropped={len(dropped)} bytes={totb} "
                f"identical={okb} ({pct:.2f}%) exact_objs={exact}\n")
        for d, s, o in sorted(per, key=lambda x: -x[0]):
            f.write(f"{d:7d}/{s:7d} differing  {o}\n")
    if a.json:
        Path(a.json).write_text(json.dumps(
            {"placed": len(placed), "dropped": len(dropped), "no_base": nobase,
             "bytes": totb, "identical": okb, "pct": round(pct, 4),
             "exact_objs": exact, "ld_stderr_lines": len(errs)}, indent=1))
    if a.min_pct is not None and pct < a.min_pct:
        print(f"BELOW FLOOR: {pct:.2f}% < {a.min_pct}%")
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
