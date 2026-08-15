#!/usr/bin/env python3
"""probe_link.py -- THE STANDING LAYOUT PROBE (W65-A7 promotion of W62-A19;
W67-A6 implied-base DATA treatment).

Places every recon object's `.text` at its IMPLIED RETAIL BASE (base = retail
VA - our section offset, taken as the mode over that object's text symbols),
links the lane for real with GNU ld, flattens the placed regions and byte-
compares them against `rom/nfs4-f.exe`.  The percentage is the honest
"how much of the retail image does the recon lane already reproduce IN PLACE"
number -- strictly stronger than a per-function byte gate, because it also
prices intra-object layout.

W67-A6 (the w66-a6 §3.2 spec + the w66-a4 §7 control-leg correction): DATA is
no longer swept into one dummy `.other 0x80300000` catch-all.  That catch-all
was pushing the score DOWN as the data-materialization belt succeeded -- every
datum migrated out of `linkers/undefined_syms_auto.txt` (where it carried its
true retail VA) into a real object definition started resolving `%hi/%lo`
into the dummy region (worked exhibit: `sndgs`, and with it 40 sndpsxz TUs'
byte-exactness).  Now:

  * each object's `.data/.sdata/.sbss/.bss` section gets its own IMPLIED
    RETAIL BASE (mode over that section's symbols, data-symbol VAs from
    configs/symbol_addrs.txt + D_/DAT_ placeholder names) and is placed
    there -- NOBITS sections contribute no image bytes but their symbols
    then resolve to retail addresses, which is what fixes the consumers;
  * each recon TU's `.rodata` is placed from
    linkers/nfs4_recon.rodata_placement.json (the canonical rodownmap
    anchor map gen_ld uses -- compiler jump tables carry no global symbol,
    so votes cannot anchor rodata);
  * every data section that got NO base is placed at its own SCRATCH base
    (0x80400000+, cumulative) instead of a shared catch-all, so an A/B
    against `--no-data` keeps `.other` byte-stable and every delta stays
    attributable (the w66-a4 first-naive-A/B lesson);
  * placed INITIALIZED data regions inside the ROM image are byte-compared
    and reported as a separate `data bytes` metric (text metrics unchanged).

`--no-data` reproduces the legacy behaviour exactly (the control leg).

🔴 THE STALE-OBJDATA HAZARD (catalog 15E): the object census is re-scanned by
default on every run.  A cached `objdata.json` from before a peer landing has
been measured to cost ~1% of the score.  `--reuse-objdata` is available for
back-to-back A/B runs only, and always prints the cache's age.

usage:
    python tools/probe_link.py [--no-data] [--reuse-objdata] [--min-pct P]
                               [--json OUT]
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
PLACEMENT = ROOT / "linkers" / "nfs4_recon.rodata_placement.json"
FBASE = 0x8000F800          # file offset 0 of rom/nfs4-f.exe maps to this VA
TEXT_START = 0x800128F0     # first placed .text VA (the spine's low water mark)
VA_LO, VA_HI = 0x80010000, 0x80200000   # plausible retail VA band
SCRATCH = 0x80400000        # un-anchored data sections go here, cumulatively
EXCLUDED = ("diffsrc", "scratch", "scratchpad", "pbuild", "relink", "probe_link")
DATA_SECS = (".data", ".sdata", ".sbss", ".bss")
INIT_SECS = {".rodata", ".data", ".sdata"}      # sections with image bytes

HDRRE = re.compile(r"^(\S+):\s+file format")
SYMRE = re.compile(r"^([0-9a-f]{8})\s(.{7})\s+(\S+)\s+([0-9a-f]{8})\s(.*)$")
SECRE = re.compile(r"^\s*\d+\s+(\S+)\s+([0-9a-f]{8})\s+")
PLACEHOLDER = re.compile(r"(?:func|D|DAT|lbl|jtbl)_([0-9A-Fa-f]{8})$")


def batched(seq, n):
    for i in range(0, len(seq), n):
        yield seq[i:i + n]


def recon_objects():
    return sorted(o for o in (ROOT / "build" / "recon").rglob("*.o")
                  if not set(EXCLUDED) & set(o.parts))


def scan(objs):
    """symbols (ALL sections) + section sizes for every recon object."""
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
                if not sec.startswith(".") or " d " in flags or " df " in flags:
                    continue
                data[cur]["syms"].append({"off": int(val, 16), "sec": sec,
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
    """(func VAs for the text spine, ALL VAs for data anchoring); names with
    more than one VA are dropped from both maps."""
    fvas, avas, dup = {}, {}, set()
    for ln in (ROOT / "configs" / "symbol_addrs.txt").open(
            encoding="utf-8", errors="replace"):
        m = re.match(r"(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);(.*)", ln)
        if m:
            n, v = m.group(1), int(m.group(2), 16)
            if (n in avas and avas[n] != v):
                dup.add(n)
            avas.setdefault(n, v)
            if "type:func" in m.group(3):
                fvas.setdefault(n, v)
    for n in dup:
        avas.pop(n, None)
        fvas.pop(n, None)
    return fvas, avas, dup


def implied_base(syms, sec, vas):
    bases = defaultdict(int)
    for s in syms:
        if s["sec"] != sec:
            continue
        va = vas.get(s["name"])
        if va is None:
            m = PLACEHOLDER.match(s["name"])
            if m:
                va = int(m.group(1), 16)
        if va is not None:
            b = va - s["off"]
            if VA_LO <= b < VA_HI:
                bases[b] += 1
    if not bases:
        return None, 0
    b, n = max(bases.items(), key=lambda kv: kv[1])
    return b, n


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--no-data", action="store_true",
                    help="legacy behaviour: sweep all data into .other (control leg)")
    ap.add_argument("--reuse-objdata", action="store_true")
    ap.add_argument("--min-pct", type=float)
    ap.add_argument("--json")
    a = ap.parse_args()

    OUTDIR.mkdir(parents=True, exist_ok=True)
    objs = recon_objects()
    if not objs:
        sys.exit("no build/recon objects -- refusing a vacuous probe")
    cache = OUTDIR / "objdata2.json"        # v2 format (all-section symbols)
    if a.reuse_objdata and cache.exists():
        age = time.time() - cache.stat().st_mtime
        print(f"[scan] REUSING cached objdata2.json, age {age/60:.1f} min "
              f"-- stale cache costs ~1% (catalog 15E)")
        objdata = json.load(cache.open())
    else:
        objdata = scan(objs)
        cache.write_text(json.dumps(objdata, indent=0))
    print(f"[scan] objects={len(objs)} scanned={len(objdata)}")

    fvas, avas, multiva = symbol_vas()

    # ------------------------------------------------------- the text spine
    rows = []
    nobase = 0
    for o, d in objdata.items():
        tsz = d.get("secs", {}).get(".text", 0)
        if not tsz:
            continue
        base, votes = implied_base(d["syms"], ".text", fvas)
        if base is not None:
            rows.append((base, tsz, o))
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

    # -------------------------------------- the W67-A6 data placement legs
    dplaced, dscratch = [], []              # (base, sz, obj, sec)
    if not a.no_data:
        cand = []
        # leg 1: the canonical .rodata anchor map (jump tables have no
        # global symbol, so votes can never anchor rodata)
        ro_mapped = set()
        if PLACEMENT.exists():
            for r in json.load(PLACEMENT.open()):
                o = r["obj"]
                if o in objdata and objdata[o].get("secs", {}).get(".rodata", 0):
                    cand.append((r["base"],
                                 objdata[o]["secs"][".rodata"], o, ".rodata",
                                 10 ** 6))          # map anchors outrank votes
                    ro_mapped.add(o)
        # leg 2: implied bases for .data/.sdata/.sbss/.bss by symbol votes
        for o, d in objdata.items():
            for sec in DATA_SECS:
                sz = d.get("secs", {}).get(sec, 0)
                if not sz:
                    continue
                base, votes = implied_base(d["syms"], sec, avas)
                if base is not None:
                    cand.append((base, sz, o, sec, votes))
        # overlap pruning: trust (map >> votes), then address order
        text_iv = [(b, b + s) for b, s, _ in placed]

        def hits_text(b, e):
            from bisect import bisect_right
            i = bisect_right(text_iv, (b, 1 << 62))
            if i and text_iv[i - 1][1] > b:
                return True
            return i < len(text_iv) and text_iv[i][0] < e

        cand.sort(key=lambda x: (-x[4], x[0]))
        taken = []                          # accepted [base, end) intervals

        def overlaps(b, e):
            return any(not (e <= tb or te <= b) for tb, te in taken)

        rejected = []
        for base, sz, o, sec, votes in cand:
            if hits_text(base, base + sz) or overlaps(base, base + sz):
                rejected.append((base, sz, o, sec))
                continue
            taken.append((base, base + sz))
            dplaced.append((base, sz, o, sec))
        dplaced.sort()
        # leg 3: the scratch-base control leg -- every remaining data section
        # gets its OWN section at a non-retail base (never a shared catch-all)
        placed_keys = {(o, sec) for _, _, o, sec in dplaced}
        nxt = SCRATCH
        for o, d in sorted(objdata.items()):
            for sec in (".rodata",) + DATA_SECS:
                sz = d.get("secs", {}).get(sec, 0)
                if not sz or (o, sec) in placed_keys:
                    continue
                dscratch.append((nxt, sz, o, sec))
                nxt = (nxt + sz + 15) & ~15
        print(f"[data] placed={len(dplaced)} (rodata-map={len(ro_mapped)}, "
              f"vote-rejected-overlap={len(rejected)})  "
              f"scratch-based={len(dscratch)}")

    # --------------------------------------------------------- the script
    lines = ["SECTIONS", "{"]
    for i, (base, sz, o) in enumerate(placed):
        lines.append(f"    .t{i:04d} {base:#x} : SUBALIGN(4) {{ {o}(.text) }}")
    for i, (base, sz, o, sec) in enumerate(dplaced):
        lines.append(f"    .d{i:04d} {base:#x} : SUBALIGN(4) {{ {o}({sec}) }}")
    for i, (base, sz, o, sec) in enumerate(dscratch):
        lines.append(f"    .x{i:04d} {base:#x} : SUBALIGN(4) {{ {o}({sec}) }}")
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

    rom = (ROOT / "rom" / "nfs4-f.exe").read_bytes()
    rom_end = FBASE + len(rom)

    binf = OUTDIR / "probe.bin"
    sects = [f"--only-section=.t{i:04d}" for i in range(len(placed))]
    subprocess.run([OBJCOPY, "-O", "binary", *sects, str(elf), str(binf)],
                   check=True)
    img = binf.read_bytes()
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
    print(f"[cmp] .text bytes compared={totb}  identical={okb}  ({pct:.2f}%)")
    print(f"[cmp] objects byte-IDENTICAL to retail: {exact}/{len(placed)}")

    # ------------------------- the separate DATA byte metric (W67-A6)
    dtotb = dokb = dexact = dcmp = 0
    if dplaced:
        droms = [(i, base, sz, o, sec) for i, (base, sz, o, sec)
                 in enumerate(dplaced)
                 if sec in INIT_SECS and base + sz <= rom_end]
        if droms:
            dbin = OUTDIR / "probe_data.bin"
            dsects = [f"--only-section=.d{i:04d}" for i, *_ in droms]
            subprocess.run([OBJCOPY, "-O", "binary", *dsects, str(elf),
                            str(dbin)], check=True)
            dimg = dbin.read_bytes()
            dbase = min(b for _, b, *_ in droms)
            for i, base, sz, o, sec in droms:
                ours = dimg[base - dbase:base - dbase + sz]
                theirs = rom[base - FBASE:base - FBASE + sz]
                n = sum(1 for x, y in zip(ours, theirs) if x == y)
                dtotb += sz
                dokb += n
                dcmp += 1
                if n == sz:
                    dexact += 1
            print(f"[cmp] DATA bytes compared={dtotb}  identical={dokb}  "
                  f"({100.0 * dokb / dtotb:.2f}%)  exact sections: "
                  f"{dexact}/{dcmp}  (placed data sections: {len(dplaced)}, "
                  f"NOBITS/beyond-image not byte-compared)")

    with (OUTDIR / "link_probe.txt").open("w") as f:
        f.write(f"placed={len(placed)} dropped={len(dropped)} bytes={totb} "
                f"identical={okb} ({pct:.2f}%) exact_objs={exact} "
                f"data_placed={len(dplaced)} data_bytes={dtotb} "
                f"data_identical={dokb}\n")
        for d, s, o in sorted(per, key=lambda x: -x[0]):
            f.write(f"{d:7d}/{s:7d} differing  {o}\n")
    if a.json:
        Path(a.json).write_text(json.dumps(
            {"placed": len(placed), "dropped": len(dropped), "no_base": nobase,
             "bytes": totb, "identical": okb, "pct": round(pct, 4),
             "exact_objs": exact, "ld_stderr_lines": len(errs),
             "data_placed": len(dplaced), "data_scratch": len(dscratch),
             "data_bytes": dtotb, "data_identical": dokb,
             "data_exact_sections": dexact, "no_data": a.no_data}, indent=1))
    if a.min_pct is not None and pct < a.min_pct:
        print(f"BELOW FLOOR: {pct:.2f}% < {a.min_pct}%")
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
