#!/usr/bin/env python3
"""W65-A5  gen_ld.py -- generate `linkers/nfs4_recon.ld` and link it for real.

Successor of scratchpad/w64a19/gen_ld.py.  Three changes, all forced:

  1. the `.ldfrag` files are named per BLOB STEM now (W64-A18's fixed-name
     clobber fix), so the W64-A19 script's `nfs4_recon.{data,sdata}.ldfrag`
     inputs DO NOT EXIST -- it reads the three real ones instead;
  2. `objdata.json` is read from THIS scratchpad (a stale objdata costs ~1%,
     catalog 15E) -- run scratchpad/w65a5/scan.py immediately before;
  3. THE .L LOCALIZE CUT: the jump-table pieces of the two splat rodata blobs
     (`<stem>_jNN.rodata.s.o`) are the SPLAT lane's copies of tables the recon
     TUs emit themselves (byte-proven, scratchpad/w65a5/jtbl_own.txt).  They
     are excluded from the recon link ENTIRELY -- both from the object list
     and from the script -- and the surviving `_rNN` residual pieces are each
     placed at their OWN retail VA so removing a piece shifts nothing.

Usage:
    python scratchpad/w65a5/gen_ld.py            # write the script
    python scratchpad/w65a5/gen_ld.py --link     # ...and link it for real
    python scratchpad/w65a5/gen_ld.py --link --no-cut   # control: keep _jNN
"""
import json
import re
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = ROOT / "scratchpad" / "w66a3"
LD = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-ld.exe"
OBJDATA = HERE / "objdata.json"
TEXT_START = 0x800128F0
DATA_START = 0x8010CCD4
SDATA_START = 0x8013C54C
OVERLAY_START = 0x80010000
FRONT_RODATA_STEM = "rdata_80010000"

VA_RE = re.compile(r"/\*\s*([0-9A-Fa-f]+)\s+([0-9A-Fa-f]{8})\s")
CUT = "--no-cut" not in sys.argv

# ---------------------------------------------------------------- retail VAs
vas, dup = {}, set()
for ln in open(ROOT / "configs" / "symbol_addrs.txt", errors="replace"):
    m = re.match(r"(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);\s*//\s*type:func", ln)
    if m:
        n, v = m.group(1), int(m.group(2), 16)
        if n in vas and vas[n] != v:
            dup.add(n)
        vas.setdefault(n, v)
for n in dup:
    del vas[n]

objdata = json.load(open(OBJDATA))

# ------------------------------------------------------------- the text spine
rows, nobase = [], []
for o, d in objdata.items():
    tsz = d.get("secs", {}).get(".text", 0)
    if not tsz:
        continue
    bases = defaultdict(int)
    for s in d["syms"]:
        if s["sec"] != ".text":
            continue
        va = vas.get(s["name"])
        if va is None:
            m = re.match(r"(?:func|D|lbl)_([0-9A-Fa-f]{8})$", s["name"])
            if m:
                va = int(m.group(1), 16)
        if va is not None:
            bases[va - s["off"]] += 1
    if bases:
        rows.append((max(bases.items(), key=lambda kv: kv[1])[0], tsz, o))
    else:
        nobase.append((tsz, o))
rows.sort()

placed, dropped, cur = [], [], 0
for base, sz, o in rows:
    if base < cur:
        dropped.append((base, sz, o))
        continue
    placed.append((base, sz, o))
    cur = base + sz
front = [r for r in placed if r[0] < TEXT_START]
main = [r for r in placed if r[0] >= TEXT_START]

# -------------------------------------------------- the front rodata pieces
def piece_va(p):
    for ln in p.read_text(errors="replace").splitlines():
        m = VA_RE.search(ln)
        if m:
            return int(m.group(2), 16)
    raise AssertionError(f"{p.name}: no VA comment -- cannot place it")


dataroot = ROOT / "asm" / "data"
pieces = sorted(dataroot.glob(f"{FRONT_RODATA_STEM}_[rj][0-9][0-9].rodata.s"))
whole = dataroot / f"{FRONT_RODATA_STEM}.rodata.s"
front_ro = []
if pieces:
    assert not whole.exists(), \
        "both the whole blob and its pieces exist -- refusing an ambiguous link"
    for p in pieces:
        front_ro.append((piece_va(p), p.name,
                         re.search(r"_(j)\d\d\.", p.name) is not None))
    front_ro.sort()
    assert front_ro[0][0] == OVERLAY_START, \
        f"first front-rodata piece is at {front_ro[0][0]:#x}, not the blob base"
else:
    assert whole.exists(), f"no {FRONT_RODATA_STEM} blob or pieces in asm/data"
    front_ro.append((OVERLAY_START, whole.name, False))
njtbl_front = sum(1 for _, _, j in front_ro if j)

# every `_jNN` object of EITHER blob is dropped from the recon link
jtbl_objs = set()
if CUT:
    for p in sorted(dataroot.glob("*_j[0-9][0-9].*.s")):
        jtbl_objs.add(f"build/asm/data/{p.name}.o")

# -------------------------------------------------------------- data fragments
def frag(p):
    out = []
    for L in (ROOT / p).read_text().splitlines():
        s = L.strip()
        if s and not s.startswith("/*") and not s.startswith("*"):
            out.append("        " + s)
    return out


sdata_lines = frag("linkers/nfs4_recon.sdata_8013C54C.ldfrag")
data_lines = frag("linkers/nfs4_recon.data_8010CCD4.ldfrag")
# NOTE: linkers/nfs4_recon.front_data.ldfrag is deliberately NOT read here.
# The front_data run (0x800515b8..0x80052b38) was cut AFTER the recon script
# was first generated and has never had a placed region in it; its pieces and
# their owning recon TUs still fall into the trailing `.data_rest` catch-all,
# exactly as at HEAD.  Placing it is a separate, separately-measured landing --
# see the continuation cursor.  Reading it here would change .data addresses in
# the SAME commit as the .L cut and make probe_link movement unattributable.
assert sdata_lines and data_lines, "empty .ldfrag -- refusing a vacuous script"

in_frag = set()
for L in sdata_lines + data_lines:
    m = re.search(r"(build/\S+?\.o)\(", L)
    if m:
        in_frag.add(m.group(1))

extra_data, extra_sdata = [], []
for o, d in sorted(objdata.items()):
    if not o.startswith("build/recon"):
        continue
    if d.get("secs", {}).get(".data", 0) and o not in in_frag:
        extra_data.append(f"        {o}(.data);")
    if d.get("secs", {}).get(".sdata", 0) and o not in in_frag:
        extra_sdata.append(f"        {o}(.sdata);")

# ----------------------------------------------------------------- emit the ld
L = []
A = L.append
A("/* linkers/nfs4_recon.ld -- W65-A5, GENERATED by scratchpad/w65a5/gen_ld.py.")
A(" * The RECON-lane counterpart of linkers/nfs4.ld: the ~500 reconstructed")
A(" * objects replace build/src/{front,main}.c.o, each .text placed at its")
A(" * implied retail base (W62-A19 spine), .data/.sdata ordered by the three")
A(" * per-blob-STEM .ldfrag files, everything else swept into trailing")
A(" * catch-alls.")
A(" *")
A(" * .L LOCALIZE CUT (W65-A5): the splat blobs' `_jNN` jump-table pieces are")
A(" * DUPLICATES of tables the recon TUs emit into their own .rodata")
A(" * (scratchpad/w65a5/jtbl_own.txt: 48 byte-proven, 6 owned by containment")
A(" * with a near-miss owner).  They are NOT linked here -- their `.L<VA>`")
A(" * operands are src-lane local labels that no recon object defines.  Each")
A(" * surviving residual piece is placed at its own retail VA, so dropping a")
A(" * piece shifts nothing.")
A(" * DO NOT EDIT BY HAND -- rerun scratchpad/w65a5/gen_ld.py. */")
A("SECTIONS")
A("{")
A("    __romPos = 0;")
A(f"    _gp = {SDATA_START:#x};")
A("    PROVIDE(ticksA = ticks);")
A("    header_ROM_START = __romPos;")
A("    .header : AT(header_ROM_START) SUBALIGN(16)")
A("    {")
A("        build/asm/header.s.o(.data);")
A("    }")
A("    __romPos += SIZEOF(.header);")
A("")
A(f"    .rodata_front {OVERLAY_START:#x} : SUBALIGN(4)")
A("    {")
for va, name, isj in front_ro:
    if isj and CUT:
        A(f"        /* {va:#010x} {name} -- JUMP TABLE, recon TU owns it */")
        continue
    A(f"        . = {va - OVERLAY_START:#x};")
    A(f"        build/asm/data/{name}.o(.rodata);")
A("    }")
A("")
for i, (base, sz, o) in enumerate(front):
    A(f"    .tf{i:04d} {base:#x} : SUBALIGN(4) {{ {o}(.text); }}")
A("")
for i, (base, sz, o) in enumerate(main):
    A(f"    .t{i:04d} {base:#x} : SUBALIGN(4) {{ {o}(.text); }}")
A("")
A(f"    .data {DATA_START:#x} : SUBALIGN(4)")
A("    {")
L.extend(data_lines)
L.extend(extra_data)
A("    }")
A("")
A(f"    .sdata {SDATA_START:#x} : SUBALIGN(4)")
A("    {")
L.extend(sdata_lines)
L.extend(extra_sdata)
A("    }")
A("")
A("    .rodata_rest : SUBALIGN(4) { *(.rodata); *(.rodata.*); }")
A("    .sbss  : SUBALIGN(4) { *(.sbss); }")
# W66-A3: stream.c / streamhelp.c now emit their DISJOINT retail .bss runs as
# separate nobits sections (.bss.st_<VA> / .bss.ds_<VA>) so a script can place
# each at its own base.  The catch-all is widened so an UNPLACED build links
# exactly as before.
A("    .bss   : SUBALIGN(4) { *(.bss); *(.bss.*); *(COMMON); }")
A("    .data_rest : SUBALIGN(4) { *(.data); *(.sdata); *(.text); }")
A("    /DISCARD/ : { *(.pdr); *(.reginfo); *(.MIPS.abiflags);"
  " *(.gnu.attributes); *(.comment); *(.mdebug*); }")
A("}")
(ROOT / "linkers" / "nfs4_recon.ld").write_text("\n".join(L) + "\n")

rep = [f"cut enabled                  : {CUT}",
       f"objects with text            : {len(rows)}",
       f"  placed (front overlay)     : {len(front)}",
       f"  placed (resident .text)    : {len(main)}",
       f"  DROPPED (interleaved)      : {len(dropped)}",
       f"objects with text but NO base: {len(nobase)}",
       f"front rodata pieces          : {len(front_ro)} "
       f"({njtbl_front} jump-table, excluded={CUT})",
       f"_jNN objects excluded        : {len(jtbl_objs)}",
       f".data  fragment lines        : {len(data_lines)} (+{len(extra_data)}"
       f" appended; front_data NOT placed -- see the cursor)",
       f".sdata fragment lines        : {len(sdata_lines)} (+{len(extra_sdata)})",
       ""]
rep.append("== DROPPED (would move the location counter backwards) ==")
for b, s, o in dropped:
    rep.append(f"  {b:#010x} {s:6d} {o}")
rep.append("")
rep.append("== TEXT BUT NO IMPLIED BASE ==")
for s, o in nobase:
    rep.append(f"  {s:6d} {o}")
(HERE / "genld_report.txt").write_text("\n".join(rep) + "\n")
print("\n".join(rep[:11]))
print("-> linkers/nfs4_recon.ld, scratchpad/w65a5/genld_report.txt")

# ----------------------------------------------------------------------- link
if "--link" in sys.argv:
    objs = sorted(objdata) + [str(p.relative_to(ROOT)).replace("\\", "/")
                              for p in sorted((ROOT / "build/asm").rglob("*.o"))]
    objs = [o for o in dict.fromkeys(objs) if o not in jtbl_objs]
    assert objs, "empty object list -- vacuous link refused"
    rsp = HERE / "recon_link.rsp"
    rsp.write_text("\n".join('"%s"' % o for o in objs))
    tag = "" if CUT else "_nocut"
    for label, extra in (("strict", []),
                         ("multdef-ok", ["--allow-multiple-definition"])):
        cmd = [LD, "-T", str(ROOT / "linkers/nfs4_recon.ld")]
        for auto in ("undefined_syms_auto.txt", "undefined_funcs_auto.txt"):
            p = ROOT / "linkers" / auto
            if p.exists():
                cmd += ["-T", str(p)]
        cmd += extra + ["--no-check-sections", "--noinhibit-exec",
                        "-Map", str(HERE / f"recon_{label}{tag}.map"),
                        "-o", str(HERE / f"recon_{label}{tag}.elf"),
                        "@" + str(rsp)]
        r = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True)
        errs = [e for e in r.stderr.splitlines() if e.strip()]
        und = sorted(set(re.findall(
            r"undefined reference to [`']([^'\"]+)'", r.stderr)))
        dotl = [u for u in und if u.startswith(".L")]
        mult = [e for e in errs if "multiple definition" in e]
        trunc = [e for e in errs if "relocation truncated" in e]
        (HERE / f"recon_{label}{tag}.err").write_text(r.stderr)
        print(f"[{label}{tag}] rc={r.returncode} stderr={len(errs)} "
              f"undefined-names={len(und)} (.L={len(dotl)}) "
              f"multiple-def={len(mult)} reloc-truncated={len(trunc)}")
        (HERE / f"recon_{label}{tag}_undef.txt").write_text("\n".join(und) + "\n")
