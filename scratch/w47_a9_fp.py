#!/usr/bin/env python
"""w47-a9 -- NEAR-ORACLE FLAG FINGERPRINTING harness.

MODE A (toolchain identity):  compile ONE .i with
   * the REAL PsyQ compiler (CC1PSX / CC1PLPSX)   = the reference
   * the rebuilt near-oracle cc1 (C:/Temp/nfs4-instr-cc1) = the candidate
and report, function by function, whether the candidate reproduces the
reference's instruction stream EXACTLY.  A candidate flag set that raises the
identical-function count is evidence about the true toolchain identity.

MODE A' (self-fingerprint):   both sides are the REAL compiler, run under two
different flag sets.  The count of functions whose stream is UNCHANGED tells
you how many functions a flag can even touch (its "blast radius"), which is the
prerequisite for any per-module flag claim.

Usage
-----
  python scratch/w47_a9_fp.py <recon/rel/path.c|.cpp>
         [--ref-exe psyq|elf|ecoff|ecoffpp] [--ref-flags "..."]
         [--cand-exe ...]                   [--cand-flags "..."]
         [--quiet]

Flags strings are shell-split; the DEFAULT ref flags are exactly build.py's
(C lane: -quiet -O2 -G4 -g1 -mgpOPT -fgnu-linker ; C++ lane: -quiet -O2 -G4).

Gotchas already paid for (w45 receipts sec.7):
  * cc1 names its dump files after the INPUT path -> every probe gets its OWN
    copy of the .i in its own directory.
  * TMPDIR/TMP/TEMP must be a WINDOWS path with a TRAILING BACKSLASH or cc1
    writes empty files / dies with "\\/ctaNNNNN: No such file or directory".
  * read/write text with newline='' and encoding='utf-8'.
"""
import os
import re
import shlex
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCRATCH = ROOT / "scratch" / "w47_a9"
INSTR = Path("C:/Temp/nfs4-instr-cc1")
PSQ = Path("C:/Temp/psq43/COMPILER")
MIPS = Path("C:/Tools/mips-ps1/mips/bin")
CPP = str(MIPS / "mipsel-none-elf-cpp.exe")

EXES = {
    "psyq":     str(PSQ / "CC1PSX.EXE"),
    "psyqpp":   str(PSQ / "CC1PLPSX.EXE"),
    "elf":      str(INSTR / "cc1-elf.exe"),
    "ecoff":    str(INSTR / "cc1-ecoff.exe"),
    "ecoffpp":  str(INSTR / "cc1plus-ecoff.exe"),
}

# build.py, verbatim
CPP_FLAGS_C = ["-nostdinc", "-undef", "-D__GNUC__=2", "-D__OPTIMIZE__",
               "-Dmips", "-D__mips__", "-D__psx__", "-DPSX",
               "-I" + str(ROOT / "include"), "-I" + str(ROOT / "recon")]
CPP_FLAGS_CPP = ["-x", "c", "-D__cplusplus=1", "-nostdinc", "-undef",
                 "-Dmips", "-D__mips__", "-D__psx__",
                 "-I" + str(ROOT / "recon")]
REF_FLAGS_C = ["-quiet", "-O2", "-G4", "-g1", "-mgpOPT", "-fgnu-linker"]
REF_FLAGS_CPP = ["-quiet", "-O2", "-G4"]
# w46-a10: the flags that turn the rebuilt cc1 into a 19/20 near-oracle
NEAR_C = ["-quiet", "-O2", "-G4", "-mgas", "-msplit-addresses", "-funsigned-char"]
NEAR_CPP = NEAR_C + ["-fno-exceptions", "-fno-rtti"]

TMP = str(SCRATCH / "tmp") + "\\"


def preprocess(src: Path, out_i: Path):
    out_i.parent.mkdir(parents=True, exist_ok=True)
    flags = CPP_FLAGS_C if src.suffix == ".c" else CPP_FLAGS_CPP
    r = subprocess.run([CPP, *flags, str(src), "-o", str(out_i)],
                       capture_output=True, text=True)
    if r.returncode:
        sys.exit("[cpp] " + r.stderr[:2000])
    return out_i


def compile_s(exe_key: str, flags, i_src: Path, tag: str):
    """Copy the .i into a private dir (dump-file clobber!) and compile it."""
    d = SCRATCH / "run" / tag
    d.mkdir(parents=True, exist_ok=True)
    Path(TMP).mkdir(parents=True, exist_ok=True)
    priv = d / i_src.name
    priv.write_text(i_src.read_text(encoding="utf-8", errors="replace",
                                    newline=""),
                    encoding="utf-8", newline="")
    s = d / (i_src.stem + ".s")
    env = dict(os.environ, TMPDIR=TMP, TMP=TMP, TEMP=TMP)
    r = subprocess.run([EXES[exe_key], *flags, str(priv), "-o", str(s)],
                       capture_output=True, text=True, env=env)
    err = (r.stdout + r.stderr).strip()
    if r.returncode or not s.exists():
        return None, err
    return s, err


# ---------------------------------------------------------------- comparison
DROP = re.compile(r'^\s*\.(ent|end|def|val|scl|type|tag|size|dim|endef|file|'
                  r'loc|frame|mask|fmask|set|align|globl|text|data|rdata|'
                  r'sdata|sbss|bss|comm|lcomm|section|previous|cpload|'
                  r'cprestore|ident|stab\w*|word|byte|half|space|ascii|'
                  r'asciiz|gpword|nan|module|option|abicalls|extern)\b')
# debug LINE-NUMBER markers emitted only under -g<N> (`LM12:` / `$LM12:`).
# They are not code; the reference build uses -g1, the probes usually do not.
LMLAB = re.compile(r'^\s*\$?LM?\d+:\s*$')


def fns(path: Path):
    """Split a cc1 .s into {symbol: [instruction strings]}.

    Uses .ent/.end when present (both our cc1 and CC1PSX emit them at -g1 /
    by default on mips); falls back to label..(jr $31 tail) scanning if not.
    """
    txt = path.read_text(encoding="utf-8", errors="replace", newline="")
    out, cur, name = {}, None, None
    saw_ent = False
    for line in txt.splitlines():
        m = re.match(r'^\s*\.ent\s+(\S+)', line)
        if m:
            saw_ent = True
            name, cur = m.group(1), []
            continue
        if re.match(r'^\s*\.end\b', line):
            if name is not None:
                out[name] = cur
            name, cur = None, None
            continue
        if cur is None:
            continue
        s = line.split('#')[0].rstrip()
        if not s.strip() or DROP.match(s) or LMLAB.match(s):
            continue
        cur.append(s.strip())
    if not saw_ent:
        # no .ent -> segment on `name:` labels that are followed by code
        cur, name = None, None
        for line in txt.splitlines():
            m = re.match(r'^([A-Za-z_$][\w.$]*):\s*$', line)
            if m and not m.group(1).startswith('$'):
                if name is not None:
                    out[name] = cur
                name, cur = m.group(1), []
                continue
            if cur is None:
                continue
            s = line.split('#')[0].rstrip()
            if not s.strip() or DROP.match(s):
                continue
            cur.append(s.strip())
        if name is not None:
            out[name] = cur
    return out


def norm(body):
    lab, n, out = {}, [0], []

    def sub(m):
        k = m.group(0)
        if k not in lab:
            n[0] += 1
            lab[k] = 'L%d' % n[0]
        return lab[k]

    for l in body:
        l = re.sub(r'\$L\w+', sub, l)
        l = re.sub(r'\s+', ' ', l).strip()
        out.append(l)
    return out


def compare(ref_s: Path, cand_s: Path):
    R = {k: norm(v) for k, v in fns(ref_s).items()}
    C = {k: norm(v) for k, v in fns(cand_s).items()}
    rows, same = [], 0
    for k in sorted(R):
        b = C.get(k)
        if b is None:
            rows.append((k, 'MISSING', len(R[k])))
        elif b == R[k]:
            rows.append((k, 'SAME', 0))
            same += 1
        else:
            n = sum(1 for a, c in zip(R[k], b + [''] * len(R[k])) if a != c)
            n += abs(len(R[k]) - len(b))
            rows.append((k, 'd%d' % n, n))
    return rows, same, len(R)


def main():
    args = sys.argv[1:]
    if not args:
        sys.exit(__doc__)
    src = ROOT / args[0]
    opt = {}
    i = 1
    while i < len(args):
        if args[i].startswith('--'):
            k = args[i][2:]
            if k == 'quiet':
                opt['quiet'] = True
                i += 1
                continue
            opt[k] = args[i + 1]
            i += 2
        else:
            i += 1
    cxx = src.suffix != '.c'
    ref_exe = opt.get('ref-exe', 'psyqpp' if cxx else 'psyq')
    cand_exe = opt.get('cand-exe', 'ecoffpp' if cxx else 'elf')
    ref_flags = shlex.split(opt['ref-flags']) if 'ref-flags' in opt else \
        (REF_FLAGS_CPP if cxx else REF_FLAGS_C)
    cand_flags = shlex.split(opt['cand-flags']) if 'cand-flags' in opt else \
        (NEAR_CPP if cxx else NEAR_C)

    i_file = preprocess(src, SCRATCH / "i" / (src.stem + src.suffix + ".i"))
    rs, rerr = compile_s(ref_exe, ref_flags, i_file, 'ref')
    cs, cerr = compile_s(cand_exe, cand_flags, i_file, 'cand')
    if rs is None:
        sys.exit('[ref %s FAILED] %s' % (ref_exe, rerr[:1500]))
    if cs is None:
        sys.exit('[cand %s FAILED] %s' % (cand_exe, cerr[:1500]))
    rows, same, tot = compare(rs, cs)
    if not opt.get('quiet'):
        print('%-46s %s' % ('function', 'cand'))
        for k, v, _ in rows:
            print('%-46s %s' % (k[:46], v))
        print()
    print('%s : ref=%s[%s]  cand=%s[%s]  IDENTICAL %d / %d'
          % (src.name, ref_exe, ' '.join(ref_flags),
             cand_exe, ' '.join(cand_flags), same, tot))


if __name__ == '__main__':
    main()
