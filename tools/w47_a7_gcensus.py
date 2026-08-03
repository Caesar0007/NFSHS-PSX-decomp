#!/usr/bin/env python3
r"""w47_a7_gcensus.py -- per-object -G (small-data threshold) census.  WAVE-47 a7.

THE SIGNATURE
=============
Every object in the retail image was compiled with some `-G n`.  Two INDEPENDENT
consequences survive into the shipped binary; this tool measures both and
intersects them.

  (P) PLACEMENT -- decided by the object that DEFINES the symbol.
      A symbol lands in .sdata/.sbss iff size(sym) <= that object's -G.
      NFS4.MAP pins the region exactly:
          .sdata 0x8013C54C..0x8013DD7B      .sbss 0x8013DD7C..0x8013DEDF
      =>  G >= max{ size(s) : s owned by X, in small data }
          G <  min{ size(s) : s owned by X, in .data/.bss }

  (A) ADDRESSING -- decided by the object that REFERENCES the symbol.  This is
      exactly what tools/build.py's PER_TU_FLAGS["g_value"] controls:
          lw $r,%gp_rel(sym)($gp)  -> R_MIPS_GPREL16   iff size(sym) <= -G
          lui %hi(sym)/lw %lo(sym) -> R_MIPS_HI16/LO16 otherwise
      =>  G >= max{ size(s) : s reached by GPREL16 }
          G <  min{ size(s) : s OWNED BY X, in small data, reached by a
                              HI16 whose partner LO16 rides a MEMOP }

TWO FILTERS THAT ARE LOAD-BEARING (both falsified the naive census first)
------------------------------------------------------------------------
 1. OWNERSHIP.  Methodology 3.12 #6: a reference to ANOTHER object's small
    global is emitted full-addressed anyway (the referencing TU only has an
    `extern` declaration).  Without this filter EVERY object reads MIXED --
    night.obj's Chunk_lightTable/Weather_gType, cario.obj's Texture_palCopy,
    audio.obj's AudioCmn_kAudioOn are all foreign symbols.
 2. MEMOP.  `lui %hi(sym)` + `addiu %lo(sym)` is ADDRESS-OF (`la sym`), which
    cc1 emits for small-data symbols too -- the gp-relative form only ever
    replaces a real LOAD/STORE.  Counting address-of as "full-addressed" made
    every genuinely -G8 object read CONFLICT: force.obj does
        lui a1,%hi(Force_gActAlign); addiu a1,a1,%lo(...); jal PadSetActAlign
    while PLACEMENT proves that same 6-byte array IS in .sdata.

DATA SOURCES
============
  expected/src/**/*.o   retail .text per object, assembled from the splat asm,
                        so its relocation records ARE retail's own choices.
  NFS4.MAP              section bounds.
  nfs4-f-v3.txt (SYM)   TRUE symbol sizes AND per-object ownership.
      * sizes: address gaps in the map are UNUSABLE -- file statics between two
        globals inflate them (CarIO_carPixMap reads 32 by gap, 4 by SYM).
      * ownership: the SYM record stream is grouped by
            `94 Def class FILE type NULL size 0 name <obj>`
        markers, including library members:
            ..\eaclib\psx\eacpsxz.lib(addtimer.obj)
            ..\eaclib\psx\pad.obj
            hud.obj
        519 objects, verified exactly one owner per symbol.

VALIDATION (must hold before any new claim is trusted)
------------------------------------------------------
  hud / cario / force / genericpmx  -> exact 8   (build.py PER_TU_FLAGS)
  device / night                    -> >= 8      (consistent with -G8)
  screencontroller                  -> < 4       (build.py g_value "0")
  sfx                               -> UNDET     (build.py: no %gp_rel at all)

Usage:
  python tools/w47_a7_gcensus.py                    # all -> markdown table
  python tools/w47_a7_gcensus.py --filter eaclib
  python tools/w47_a7_gcensus.py --explain pad      # per-symbol evidence dump
  python tools/w47_a7_gcensus.py --validate         # run the known-object gate
"""
import argparse
import bisect
import collections
import json
import os
import re
import subprocess
import sys
from pathlib import Path

OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"
SYMFILE = r"C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt"
MAPFILE = r"C:/Temp/nfs4-clean/NFS4.MAP"
ROOT = Path(__file__).resolve().parent.parent
# `expected/` is gitignored (a build artifact of the main tree), so a worktree
# has none.  Fall back to the main checkout -- we only ever READ these objects.
EXP = ROOT / "expected" / "src"
if not EXP.is_dir():
    EXP = Path(os.environ.get("NFS4_EXPECTED_SRC",
                              r"C:/Temp/nfs4-decomp/expected/src"))

# --- NFS4.MAP section table (verified 2026-08-03) --------------------------
SDATA = (0x8013C54C, 0x8013DD7C)
SBSS = (0x8013DD7C, 0x8013DEE0)
MAIN_TEXT = (0x8005797C, 0x8010CCD4)
FRONT_TEXT = (0x800128F0, 0x80051260)
DATA = (0x8010CCD4, 0x8013C54C)
BSS = (0x8013DEE0, 0x80148B04)
FRONT_DATA = (0x80051260, 0x80054548)     # front.data + front.bss
RDATA_LOW = 0x8005797C                     # below this: .rdata / front.rdata

SMALL = (".sdata", ".sbss")
BIG = (".data", ".bss", "front.data")      # -G-relevant NON-small data
# NOTE .rdata is deliberately NOT in BIG: const data goes to .rdata whatever
# -G is, so a small .rdata symbol proves nothing.

BASE_SIZE = {"CHAR": 1, "UCHAR": 1, "BOOL": 1, "SHORT": 2, "USHORT": 2,
             "INT": 4, "UINT": 4, "LONG": 4, "ULONG": 4, "FLT": 4,
             "FLOAT": 4, "DBL": 8, "DOUBLE": 8, "ENUM": 4, "VOID": 4}

# instructions that actually TOUCH memory -- only these discriminate -G
MEMOPS = {"lb", "lbu", "lh", "lhu", "lw", "lwl", "lwr", "lwc2", "ll",
          "sb", "sh", "sw", "swl", "swr", "swc2", "sc"}

KNOWN = {          # build.py PER_TU_FLAGS ground truth, for --validate
    "game/psx/hud": ("8", "exact"),
    "game/psx/cario": ("8", "exact"),
    "game/psx/force": ("8", "exact"),
    "game/common/genericpmx": ("8", "exact"),
    "game/psx/device": ("8", "atleast"),
    "game/psx/night": ("8", "atleast"),
    "game/common/cars": ("8", "atleast4"),
    "frontend/common/screencontroller": ("0", "below4"),
    "game/psx/sfx": ("8", "undet"),
}


def in_r(va, r):
    return r[0] <= va < r[1]


def section_of(va):
    if in_r(va, SDATA):
        return ".sdata"
    if in_r(va, SBSS):
        return ".sbss"
    if in_r(va, MAIN_TEXT):
        return ".text"
    if in_r(va, DATA):
        return ".data"
    if in_r(va, BSS):
        return ".bss"
    if in_r(va, FRONT_DATA):
        return "front.data"
    if in_r(va, FRONT_TEXT):
        return "front.text"
    if va < RDATA_LOW:
        return ".rdata"
    return "?"


FILE_RE = re.compile(r"9[46] Def class FILE type NULL size 0 name (\S+)")
DEF_RE = re.compile(
    r"\$([0-9a-f]{8}) 9[46] Def2? class (\w+) type ([A-Z0-9 ]+?) size (\d+)"
    r"(?: dims [\d ]*)?(?: tag \S*)? name (\S+)")


def sym_size(typ, size):
    """MND type chain + `size` field -> object size in bytes.

    PTR   : 4      (the `size` field holds the POINTEE size, not the object's)
    ARY   : size   (the `size` field is TOTAL array bytes: ARY INT size 8 dims 1 2)
    STRUCT: size
    base  : BASE_SIZE (`size 0` means "the base type's own size")
    """
    t = typ.split()
    if not t:
        return None
    if t[0] == "PTR":
        return 4
    if t[0] == "ARY":
        return size or None
    if t[0] == "FCN":
        return None
    if t[0] in ("STRUCT", "UNION"):
        return size or None
    return BASE_SIZE.get(t[0], size or None)


def norm_obj(name):
    """SYM object name -> normalised posix-ish key.

    ..\\eaclib\\psx\\eacpsxz.lib(addtimer.obj) -> eaclib/psx/eacpsxz/addtimer
    ..\\eaclib\\psx\\pad.obj                   -> eaclib/psx/pad
    CarIO.obj                                  -> cario
    """
    n = name.replace("\\", "/").lower()
    m = re.match(r"(.*)\.lib\((.+)\.obj\)$", n)
    if m:
        n = m.group(1) + "/" + m.group(2)
    else:
        n = re.sub(r"\.obj$", "", n)
    parts = [p for p in n.split("/") if p not in ("", ".", "..")]
    return "/".join(parts)


def exp_key(path):
    """expected/src/eaclib/psx/pad.c.o -> eaclib/psx/pad"""
    rel = path.relative_to(EXP).as_posix().lower()
    return re.sub(r"\.(c|cpp|s)?\.o$", "", rel)


def load_sym():
    """-> ({name: (va, size, section, owner_key, class)}, set(owner_key))"""
    out, owners = {}, set()
    cur = None
    for ln in open(SYMFILE, errors="replace"):
        m = FILE_RE.search(ln)
        if m:
            cur = norm_obj(m.group(1))
            owners.add(cur)
            continue
        d = DEF_RE.search(ln)
        if not d or d.group(2) not in ("EXT", "STAT"):
            continue
        va = int(d.group(1), 16)
        sec = section_of(va)
        if sec in (".text", "front.text", "?"):
            continue
        sz = sym_size(d.group(3), int(d.group(4)))
        if not sz:
            continue
        name = d.group(5)
        prev = out.get(name)
        if prev is None or sz > prev[1]:
            out[name] = (va, sz, sec, cur, d.group(2))
    return out, owners


DLABEL_RE = re.compile(r"^\s*dlabel\s+(\S+)")
DVA_RE = re.compile(r"/\*\s*[0-9A-Fa-f]+\s+(8[0-9A-Fa-f]{7})[\s*]")


def load_splat_extents():
    """asm/data/*.s -> {name: (va, size)} using splat's dlabel/enddlabel spans.

    spimdisasm emits every INITIALISED datum as `dlabel N ... enddlabel N` with
    a `/* fileoff VA bytes */` comment per line, so the span between successive
    dlabels is the datum's exact byte extent.  This is the ONLY size source for
    eaclib: library members carry no data Def records in the SYM (verified --
    165 eaclib objects, 2 data symbols with SYM sizes, both in pad.obj).
    ⚠️ A splat label is created wherever a reference POINTS, so an 8-byte array
    touched at both +0 and +4 splits into two 4-byte labels.  That biases the
    census DOWNWARD (false -G4, never a false -G8) -- see LOWCONF below.
    """
    out = {}
    d = ROOT / "asm" / "data"
    if not d.is_dir():
        d = Path(r"C:/Temp/nfs4-decomp/asm/data")
    for f in sorted(d.glob("*.s")):
        seq, cur = [], None
        for ln in f.read_text(errors="replace").splitlines():
            m = DLABEL_RE.match(ln)
            if m:
                cur = m.group(1)
                continue
            if cur:
                v = DVA_RE.search(ln)
                if v:
                    seq.append((int(v.group(1), 16), cur))
                    cur = None
        for i, (va, n) in enumerate(seq):
            end = seq[i + 1][0] if i + 1 < len(seq) else va + 4
            if end > va:
                out.setdefault(n, (va, end - va))
    return out


def load_map():
    lines = Path(MAPFILE).read_text(errors="replace").splitlines()
    st = next(i for i, l in enumerate(lines) if "address order" in l)
    out = {}
    for l in lines[st + 1:]:
        m = re.match(r"^\s*([0-9A-Fa-f]{8})\s+(\S+)\s*$", l)
        if m:
            out.setdefault(m.group(2), int(m.group(1), 16))
    return out


REL_RE = re.compile(r"^\s*([0-9a-f]+):\s+R_MIPS_(\S+)\s+(\S+)")
INSN_RE = re.compile(r"^\s*([0-9a-f]+):\t[0-9a-f ]+\t(\S+)")
OFILE_RE = re.compile(r"^(.+):\s+file format")


def objdump_relocs(paths):
    """-> {objpath: [(reloc_type, symbol, mnemonic_of_owning_insn), ...]}"""
    res = {}
    for i in range(0, len(paths), 40):
        chunk = [str(p) for p in paths[i:i + 40]]
        p = subprocess.run([OBJDUMP, "-d", "-r"] + chunk,
                           capture_output=True, text=True)
        cur, last = None, "?"
        for ln in p.stdout.splitlines():
            fm = OFILE_RE.match(ln)
            if fm:
                cur = Path(fm.group(1).strip().strip("'")).as_posix()
                res.setdefault(cur, [])
                continue
            im = INSN_RE.match(ln)
            if im:
                last = im.group(2)
                continue
            m = REL_RE.match(ln)
            if m and cur is not None:
                res[cur].append((m.group(2), m.group(3), last,
                                 int(m.group(1), 16)))
    return res


def split_form_census(recs):
    """The THIRD signature: ADDRESS-MATERIALISATION FORM (the "sfx tell").

    When a symbol is AT OR UNDER the -G threshold, cc1 emits the single
    assembler macro `la $r,sym`, which GNU-as/aspsx expands to an ADJACENT
    lui/addiu pair -- unschedulable, so nothing can ever land between them.
    When it is ABOVE the threshold, cc1 lowers the address ITSELF into a
    separately schedulable `lui %hi` / `addiu %lo` pair, and then sched/CSE is
    free to move the lui away (into a delay slot, out of a loop, ...).

    Both forms emit HI16+LO16, so the RELOC TYPE cannot tell them apart -- but
    the DISTANCE can.  A NON-ADJACENT pair is hard evidence of the pre-split
    form, hence of `G < size(sym)`.  Adjacency is only weak evidence the other
    way (there may simply have been nothing to schedule).

    This is the signature build.py's sfx.cpp / night.cpp entries were argued
    from, and it is the ONLY one that speaks for a TU which owns no small data
    and makes no gp-relative access at all (sfx.obj, spchrule.obj).

    -> (n_adjacent, n_split, {sym: min_gap_in_insns})
    """
    his = [(off, s) for t, s, mn, off in recs if t == "HI16"]
    los = collections.defaultdict(list)
    for t, s, mn, off in recs:
        if t == "LO16":
            los[s].append(off)
    adj = spl = 0
    gaps = {}
    for off, s in his:
        cand = [o for o in los.get(s, []) if o > off]
        if not cand:
            continue
        d = (min(cand) - off) // 4
        gaps[s] = min(gaps.get(s, 99), d)
        if d == 1:
            adj += 1
        else:
            spl += 1
    return adj, spl, gaps


class Resolver:
    def __init__(self, syms, mp, splat, dense):
        self.syms, self.map, self.splat = syms, mp, splat
        self.byva = sorted((v[0], v[1], k) for k, v in syms.items())
        self.starts = [t[0] for t in self.byva]
        # dense address set -> gap sizing for .sbss/.bss, which have no bytes
        # for splat to lay out and only sparse names in the map
        self.dense = sorted(dense)
        self.lowconf = set()

    def gap_size(self, va):
        i = bisect.bisect_right(self.dense, va)
        return (self.dense[i] - va) if i < len(self.dense) else None

    def resolve(self, name):
        """-> (canon_name, size|None, section, owner_key|None) or None"""
        if name in self.syms:
            va, sz, sec, own, _ = self.syms[name]
            return name, sz, sec, own
        m = re.fullmatch(r"D_([0-9A-Fa-f]{8})", name)
        va = int(m.group(1), 16) if m else self.map.get(name)
        if va is None and name in self.splat:
            va = self.splat[name][0]
        if va is None:
            return None
        i = bisect.bisect_right(self.starts, va) - 1
        if i >= 0:
            s_va, s_sz, s_name = self.byva[i]
            if s_va <= va < s_va + s_sz:          # interior of a SYM object
                _, sz, sec, own, _ = self.syms[s_name]
                return s_name, sz, sec, own
        sec = section_of(va)
        if sec in (".text", "front.text", "?"):
            return None
        if name in self.splat:                    # splat dlabel extent
            return name, self.splat[name][1], sec, None
        g = self.gap_size(va)                     # .sbss/.bss gap sizing
        if g and g <= 64:
            self.lowconf.add(name)
            return name, g, sec, None
        return name, None, sec, None


def decide(lo, hi):
    """lo: proven G >= lo.  hi: proven G < hi (or None).  -> (verdict, kind)"""
    cands = [g for g in (0, 1, 2, 4, 8, 16) if g >= lo and (hi is None or g < hi)]
    if not cands:
        return "CONFLICT", "conflict"
    if lo == 0 and hi is None:
        return "UNDET", "undet"
    if lo == 0:
        return "0..%d" % cands[-1], "upper"
    if hi is None:
        return ">=%d" % cands[0], "lower"
    if len(cands) == 1:
        return str(cands[0]), "exact"
    return "%d..%d" % (cands[0], cands[-1]), "range"


def build(filter_=None):
    syms, owners = load_sym()
    mp = load_map()
    splat = load_splat_extents()
    objs = sorted(EXP.rglob("*.o"))
    rel = objdump_relocs(objs)

    # dense address set: every VA anyone names, so gaps in .sbss/.bss are tight
    dense = set(mp.values()) | {v[0] for v in splat.values()} |             {v[0] for v in syms.values()}
    for recs in rel.values():
        for _t, sname, _mn, _o in recs:
            m = re.fullmatch(r"D_([0-9A-Fa-f]{8})", sname)
            if m:
                dense.add(int(m.group(1), 16))
    R = Resolver(syms, mp, splat, dense)

    # EXCLUSIVE-REFERENCE ownership fallback.  eaclib .lib members have no SYM
    # data records, so `own` is None for every symbol they define.  A data
    # symbol referenced from exactly ONE object is a file-static of that object
    # (or at worst a global only it touches) -- either way the referencing TU
    # is the one that declared it, which is precisely what the -G upper bound
    # needs.  Heuristic, so rows relying on it are marked in `basis`.
    refcnt = collections.defaultdict(set)
    for opath, recs in rel.items():
        for _t, sname, _mn, _o in recs:
            if _t in ("GPREL16", "HI16", "LO16"):
                refcnt[sname].add(opath)
    exclusive = {s: next(iter(o)) for s, o in refcnt.items() if len(o) == 1}

    # ---- (P) placement evidence, keyed by OWNING object --------------------
    P = collections.defaultdict(lambda: dict(small=[], big=[]))
    for name, (va, sz, sec, own, cls) in syms.items():
        if own is None:
            continue
        if sec in SMALL:
            P[own]["small"].append((sz, name))
        elif sec in BIG:
            P[own]["big"].append((sz, name))

    # ---- map SYM owner keys onto expected-object keys by path suffix -------
    ekeys = {exp_key(o): o for o in objs}
    own2exp = {}
    for ok in owners:
        oc = ok.split("/")
        hits = [e for e in ekeys if e.split("/")[-len(oc):] == oc]
        if len(hits) == 1:
            own2exp[ok] = hits[0]
        elif len(hits) > 1:                       # front/stream/spchevnt
            hits.sort(key=len)
            own2exp[ok] = hits[0]

    rows = []
    for ek, opath in sorted(ekeys.items()):
        if filter_ and filter_ not in ek:
            continue
        oks = [k for k, v in own2exp.items() if v == ek]
        p = dict(small=[], big=[])
        for k in oks:
            p["small"] += P[k]["small"]
            p["big"] += P[k]["big"]
        recs = rel.get(opath.as_posix(), [])
        memlo = {s for t, s, mn, _o in recs if t == "LO16" and mn in MEMOPS}
        n_adj, n_spl, gaps = split_form_census(recs)
        gp, hi_own, aof, hi_all = {}, {}, {}, {}
        excl_used, lowc = set(), set()
        for typ, s, mn, _o in recs:
            if typ not in ("GPREL16", "HI16"):
                continue
            r = R.resolve(s)
            if r is None:
                continue
            canon, sz, sec, own = r
            if sz is None:
                continue
            if canon in R.lowconf:
                lowc.add(canon)
            if typ == "GPREL16":
                gp[canon] = (sz, sec, own, mn)
            else:
                hi_all[canon] = (sz, sec, own, mn)
                if s not in memlo:
                    aof[canon] = (sz, sec, own, mn)
                elif sec in SMALL and (
                        (own is not None and own in oks) or
                        (own is None and exclusive.get(s) == opath.as_posix())):
                    hi_own[canon] = (sz, sec, own, mn)
                    if own is None:
                        excl_used.add(canon)

        # smallest symbol materialised in the PRE-SPLIT (non-adjacent) form
        spl_hi = None
        for sname, d in gaps.items():
            if d == 1:
                continue
            r2 = R.resolve(sname)
            if r2 and r2[1] and r2[2] not in (".rdata",):
                spl_hi = r2[1] if spl_hi is None else min(spl_hi, r2[1])

        p_lo = max([s for s, _ in p["small"]], default=0)
        p_hi = min([s for s, _ in p["big"]], default=None)
        a_lo = max([v[0] for v in gp.values()], default=0)
        a_hi = min([v[0] for v in hi_own.values()], default=None)
        lo = max(p_lo, a_lo)
        # NOTE spl_hi (the address-materialisation / "sfx tell" bound) is
        # deliberately NOT folded into the interval.  Reported as a column only:
        # folding it produced 36 unjustifiable `0..2` eaclib rows and broke the
        # --validate gate, because a pre-split pair on a FOREIGN extern says
        # nothing about this object's -G once EA's headers are in play.  It is a
        # LEAD generator (it independently reproduces a8's gate-proven
        # spchrule -> -G0), not a proof.
        his = [h for h in (p_hi, a_hi) if h is not None]
        hi = min(his) if his else None
        v, kind = decide(lo, hi)
        basis = []
        if p_lo and p_lo == lo:
            basis.append("placement")
        if a_lo and a_lo == lo:
            basis.append("gp-rel")
        if hi is not None:
            basis.append("<" + ("placement" if p_hi == hi else
                                "hi/lo-own" if a_hi == hi else "pre-split"))
        if excl_used:
            basis.append("excl-own")
        if lowc:
            basis.append("gapsize")
        rows.append(dict(
            n_adj=n_adj, n_split=n_spl, spl_hi=spl_hi,
            key=ek, sym_objs=",".join(sorted(oks)) or "-", G=v, kind=kind,
            lo=lo, hi=hi, p_small=len(p["small"]), p_big=len(p["big"]),
            n_gp=len(gp), n_hi=len(hi_all), n_hi_own=len(hi_own), n_aof=len(aof),
            basis="+".join(basis) or "-",
            wit_lo=sorted({n for s, n in p["small"] if s == lo} |
                          {n for n, x in gp.items() if x[0] == lo})[:3],
            wit_hi=sorted({n for s, n in p["big"] if s == hi} |
                          {n for n, x in hi_own.items() if x[0] == hi})[:3],
            _P=p, _gp=gp, _hi_own=hi_own, _aof=aof))
    return rows


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--filter")
    ap.add_argument("--explain")
    ap.add_argument("--validate", action="store_true")
    ap.add_argument("--out", default=None)
    ap.add_argument("--json", default=None)
    a = ap.parse_args()

    rows = build(a.explain or a.filter)

    if a.validate:
        bad = 0
        for k, (want, mode) in KNOWN.items():
            r = next((r for r in rows if r["key"] == k), None)
            if r is None:
                print(f"MISS {k}"); bad += 1; continue
            ok = {"exact": r["G"] == want,
                  "atleast": r["lo"] >= int(want),
                  "atleast4": r["lo"] >= 4,
                  "below4": r["hi"] is not None and r["hi"] <= 4,
                  "undet": r["kind"] == "undet"}[mode]
            print(f"{'PASS' if ok else 'FAIL'}  {k:38s} -> -G {r['G']:8s} "
                  f"[{r['lo']},{r['hi']})  expect {want}/{mode}")
            bad += not ok
        print(f"\n{'VALIDATION GREEN' if not bad else f'{bad} FAILURES'}")
        return 0 if not bad else 1

    if a.explain:
        for r in rows:
            print(f"===== {r['key']}   (SYM obj: {r['sym_objs']}) =====")
            print(" OWNED in small data  (G >= size):")
            for s, n in sorted(r["_P"]["small"], reverse=True)[:20]:
                print(f"   {s:6d}  {n}")
            print(" OWNED in .data/.bss  (G <  size):")
            for s, n in sorted(r["_P"]["big"])[:12]:
                print(f"   {s:6d}  {n}")
            print(" GPREL16 accesses     (G >= size):")
            for n, v in sorted(r["_gp"].items(), key=lambda t: -t[1][0])[:20]:
                print(f"   {v[0]:6d}  {n:36s} {v[1]} owner={v[2]} insn={v[3]}")
            print(" HI16 + LO16-on-MEMOP to OWN small-data syms (G < size):")
            for n, v in sorted(r["_hi_own"].items(), key=lambda t: t[1][0])[:12]:
                print(f"   {v[0]:6d}  {n:36s} {v[1]}")
            print(" address-of only (lui+addiu) -- NOT evidence:")
            for n, v in sorted(r["_aof"].items(), key=lambda t: t[1][0])[:10]:
                print(f"   {v[0]:6d}  {n:36s} {v[1]} owner={v[2]}")
            print(f" address-materialisation form: {r['n_adj']} adjacent (la macro"
                  f" / at-or-under -G), {r['n_split']} PRE-SPLIT (above -G)"
                  f"  -> smallest pre-split symbol = {r['spl_hi']}")
            print(f" ==> -G {r['G']}   [{r['lo']},{r['hi']})  basis={r['basis']}")
        return

    for r in rows:
        r.pop("_P"), r.pop("_gp"), r.pop("_hi_own"), r.pop("_aof")
    if a.json:
        Path(a.json).write_text(json.dumps(rows, indent=1), encoding="utf-8",
                                newline="")
    hdr = ("| object | SYM obj | **-G** | G>= | G< | own small | own big | "
           "#gp-rel | #hi/lo mem | #hi/lo own-small | #addr-of | adj(la) | "
           "pre-split | min pre-split sz | witness G>= | witness G< | basis |")
    out = [hdr, "|" + "---|" * 17]
    for r in rows:
        out.append(
            "| `{key}` | `{sym_objs}` | **{G}** | {lo} | {hi} | {p_small} | "
            "{p_big} | {n_gp} | {n_hi} | {n_hi_own} | {n_aof} | {n_adj} | "
            "{n_split} | {spl_hi} | {wl} | {wh} | {basis} |".format(wl=", ".join(r["wit_lo"]),
                               wh=", ".join(r["wit_hi"]), **r))
    txt = "\n".join(out) + "\n"
    if a.out:
        Path(a.out).write_text(txt, encoding="utf-8", newline="")
        print(f"{len(rows)} objects -> {a.out}")
    else:
        print(txt)


if __name__ == "__main__":
    sys.exit(main() or 0)
