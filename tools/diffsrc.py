#!/usr/bin/env python3
"""diffsrc.py CPP FUNC — attribute each verify_asm diff to the SOURCE STATEMENT that
generated it.

For every non-matching instruction block it prints (a) our instructions with the
recon source file:line (and the statement text) that emitted them, via a -g stabs
twin-compile, and (b) the oracle instructions with the RETAIL source line from the
trusted SYM's SLD records — recovering the original statement boundaries. Ends with
a per-statement hotspot summary ("what part of code generates the diffs").

Gate fidelity: the diff itself is computed by verify_asm's OWN code (its source is
exec'd, not reimplemented), on the object built by the NORMAL pipeline. The -g twin
is only consulted for line attribution, and only after a self-check that its
normalized instruction sequence is identical to the gate object's (gcc guarantees
-g does not change code; the check enforces it — on mismatch, attribution falls
back to fuzzy alignment and says so).

Env: DIFFSRC_SYM overrides the SLD source (default nfs4-f-v3.txt path below).
"""
import os, re, sys, subprocess, difflib
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SYM_TXT = Path(os.environ.get(
    "DIFFSRC_SYM", r"C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt"))

if len(sys.argv) != 3 or ',' in sys.argv[2]:
    sys.exit("usage: diffsrc.py <recon/....cpp|.c> <MANGLED_FUNC>   (one function)")
cpp_rel, func = sys.argv[1], sys.argv[2]

# ---- 1. run verify_asm's prologue verbatim: compiles the TU, builds norm_ins/ours/
# oracle over the gate object. Truncate its source before the top-level report loop.
_va_src = (ROOT / "tools" / "verify_asm.py").read_text()
_va_src = _va_src[:_va_src.index("allpass=True")]
ns = {"__name__": "verify_asm_embedded", "__file__": str(ROOT / "tools" / "verify_asm.py")}
_argv = sys.argv
sys.argv = ["verify_asm.py", cpp_rel, func]
exec(compile(_va_src, "verify_asm.py", "exec"), ns)
sys.argv = _argv
bld = ns["bld"]

o = ns["ours"](func)
e = ns["oracle"](func)
if e is None:
    sys.exit(f"{func}: NO ORACLE")
if not o:
    sys.exit(f"{func}: NOT IN OBJECT")

# ---- 2. -g twin compile: mirror build.py's pipeline with -g, outputs redirected.
def _per_tu_cc1_adds(tu_flags):
    return [flag for key, flag in (
        ("no_delayed_branch", "-fno-delayed-branch"),
        ("no_split_addresses", "-mno-split-addresses"),
        ("no_schedule_insns", "-fno-schedule-insns"),
        ("no_schedule_insns2", "-fno-schedule-insns2"),
        ("no_strength_reduce", "-fno-strength-reduce"),
        ("no_builtin", "-fno-builtin")) if tu_flags.get(key)]

def _uniquify_dbg_labels(s_file: Path):
    """cc1 -g numbers its LM/LBB/LBE debug labels from 1 per COMPILE, and
    build.py's _apply_fn_splice splices per-function recompiles into the same
    .s -> duplicate label definitions ('symbol LM252 already defined'). Line
    info rides on the .loc directives, not these labels, so renaming the
    2nd+ definition of any duplicate is safe."""
    lines = s_file.read_text().splitlines(keepends=True)
    seen, dup = set(), 0
    for i, ln in enumerate(lines):
        m = re.match(r'^(L(?:M|BB|BE)\d+):\s*$', ln)
        if not m:
            continue
        if m.group(1) in seen:
            dup += 1
            lines[i] = f"{m.group(1)}_dsp{dup}:\n"
        else:
            seen.add(m.group(1))
    if dup:
        s_file.write_text("".join(lines))

def compile_debug_twin(src: Path) -> Path:
    """build.py's pipeline for this TU with -g inserted, outputs under
    build/diffsrc/. Mirrors compile_c / compile_cpp / the cc1_272 lane; any
    mirror drift is caught by the o_g==o self-check below (falls to fuzzy)."""
    rel = src.relative_to(ROOT)
    tu_flags = bld.per_tu_flags(src)
    tu_g = str(tu_flags.get("g_value", bld.G_VALUE))
    obj = bld.BUILD / "diffsrc" / (str(rel) + ".g.o")
    obj.parent.mkdir(parents=True, exist_ok=True)
    i_file, s_file = obj.with_suffix(".i"), obj.with_suffix(".s")
    is_c = src.suffix == ".c"
    if is_c:
        r = bld.run([bld.CPP, *bld.CPP_FLAGS, src, "-o", i_file])
    else:
        r = bld.run([bld.CPP, "-x", "c", "-D__cplusplus=1", "-nostdinc", "-undef",
                     "-Dmips", "-D__mips__", "-D__psx__",
                     f"-I{bld.RECON}", src, "-o", i_file])
    if r.returncode:
        sys.exit(f"[diffsrc cpp] {rel}\n{r.stderr}")

    if is_c and tu_flags.get("cc1_272") and getattr(bld, "CC1_272", None):
        # 2.7.2 lane: cc1_272 -> move->addu rewrite -> direct GNU as (no maspsx)
        flags = ["-quiet", "-O2", "-g", f"-G{tu_g}", "-mgas"]
        r = bld.run([bld.CC1_272, *flags, i_file, "-o", s_file])
        if r.returncode:
            sys.exit(f"[diffsrc cc1-272 -g] {rel}\n{r.stdout}{r.stderr}")
        txt = bld._MOVE_RE.sub(lambda m: "\taddu\t%s,%s,$0" % (m.group(2), m.group(3)),
                               s_file.read_text())
        s_file.write_text(txt)
        r = bld.run([bld.AS, *bld.AS_ARCH, f"-G{tu_g}", "-I", ROOT / "include",
                     "-I", ROOT, "-o", obj, s_file])
        if r.returncode or not obj.exists():
            sys.exit(f"[diffsrc as-272 -g] {rel}\n{r.stderr}")
        return obj

    if is_c:
        cc1 = bld.CC1
        flags = [f"-G{tu_g}" if f == f"-G{bld.G_VALUE}" else f for f in bld.CC1_FLAGS]
        flags += ["-g"] + _per_tu_cc1_adds(tu_flags)
        maspsx_inc = ["-I", ROOT / "include", "-I", ROOT]
    else:
        cc1 = bld.CC1PL
        flags = ["-quiet", "-O2", "-g", f"-G{tu_g}"] + _per_tu_cc1_adds(tu_flags)
        maspsx_inc = ["-I", bld.RECON]
    r = bld.run([cc1, *flags, i_file, "-o", s_file])
    if r.returncode:
        sys.exit(f"[diffsrc cc1 -g] {rel}\n{r.stdout}{r.stderr}")
    bld._apply_fn_splice(rel.as_posix(), s_file, i_file, cc1, flags)
    _uniquify_dbg_labels(s_file)
    maspsx_cmd = [bld.PY, bld.MASPSX, f"--aspsx-version={bld.ASPSX_VERSION}",
                  "--expand-div", "--run-assembler", f"--gnu-as-path={bld.AS}",
                  *bld.AS_ARCH, f"-G{tu_g}", *maspsx_inc, "-o", obj]
    if bld.JTBL_AT_FUSION or tu_flags.get("jtbl_at_fusion"):
        maspsx_cmd.append("--jtbl-at-fusion")
    s_text = s_file.read_text()
    if not is_c:
        s_text = s_text.replace("_._", "___")
    r = subprocess.run([str(c) for c in maspsx_cmd], input=s_text,
                       capture_output=True, text=True, cwd=ROOT)
    if r.returncode or not obj.exists():
        sys.exit(f"[diffsrc maspsx -g] {rel}\n{r.stdout}{r.stderr}")
    return obj

obj_g = compile_debug_twin(ROOT / cpp_rel)

# ---- 3. per-instruction source lines from the -g object. objdump -l interleaves
# `path:NNN` markers. A stabs build also emits interior line-marker labels (LM<n>,
# LBB<n>/LBE<n>) that objdump renders as block headers, so verify_asm's ours()
# (which ends the function at ANY new label) cannot be reused here — this extractor
# mirrors its instruction handling (cop2 word-matching, LO16/GPREL16 addend zeroing,
# norm_ins) but skips over stabs-local labels.
dis_g = subprocess.run([ns["OBJD"], "-d", "-r", "-z", "-l", str(obj_g)],
                       capture_output=True, text=True).stdout
_gsymtab = subprocess.run([ns["OBJD"], "-t", str(obj_g)], capture_output=True, text=True).stdout
_gn2a = {}
for _ln in _gsymtab.splitlines():
    if '*UND*' in _ln or '*ABS*' in _ln:
        continue
    _t = _ln.split()
    if len(_t) >= 2 and re.match(r'^[0-9a-f]{8}$', _t[0]):
        _gn2a[_t[-1]] = _t[0]

_STABS_LOCAL = re.compile(r'^(LM|LBB|LBE|Ltext|LFE|LFB)\d*$')

def extract_g(fn):
    """(normalized insn list, insn idx -> source line) from the -g object."""
    addr = _gn2a.get(fn)
    lines, inb = [], False
    for ln in dis_g.splitlines():
        m = re.match(r'^([0-9a-f]{8}) <(.+)>:', ln)
        if m:
            if not inb:
                inb = (m.group(2) == fn or (addr and m.group(1) == addr))
                continue
            if _STABS_LOCAL.match(m.group(2)):
                continue                      # stabs line/block marker, still inside fn
            break                             # a real next function
        if inb:
            lines.append(ln)
    seq, idx2line, cur = [], {}, None
    norm_ins = ns["norm_ins"]
    for i, ln in enumerate(lines):
        lm = re.match(r'^(.*):(\d+)$', ln.strip())
        if lm and ('/' in lm.group(1) or '\\' in lm.group(1)
                   or lm.group(1).endswith(('.c', '.cpp', '.h'))):
            cur = int(lm.group(2))
            continue
        mm = re.match(r'^\s*[0-9a-f]+:\t([0-9a-f]+)\s*\t(.*)', ln)
        if not mm:
            continue
        word, insn = mm.group(1), mm.group(2)
        if re.match(r'c(?:op)?2\b', insn):
            idx2line[len(seq)] = cur
            seq.append('cop2 ' + word)
            continue
        nxt = lines[i + 1] if i + 1 < len(lines) else ''
        if 'R_MIPS_LO16' in nxt or 'R_MIPS_GPREL16' in nxt:
            insn = re.sub(r',\s*-?(?:0x)?[0-9a-fA-F]+\(', ',0(', insn)
            insn = re.sub(r',\s*-?(?:0x)?[0-9a-fA-F]+$', ',0', insn)
        idx2line[len(seq)] = cur
        seq.append(norm_ins(insn))
    return seq, idx2line

o_g, idx2line_g = extract_g(func)

# self-check: -g must not have changed code
exact = (o_g == o)
if exact:
    idx2line = idx2line_g
else:
    # transfer lines via alignment; flag every fuzzy index
    idx2line = {}
    smx = difflib.SequenceMatcher(a=o, b=o_g, autojunk=False)
    for tag, i0, i1, j0, j1 in smx.get_opcodes():
        if tag == 'equal':
            for k in range(i1 - i0):
                idx2line[i0 + k] = idx2line_g.get(j0 + k)
    print(f"!! -g twin DIVERGES from gate object ({len(o_g)} vs {len(o)} insns) — "
          f"attribution is fuzzy-aligned; unmapped insns shown as line ?")

# ---- 4. oracle insn VAs (mirror oracle()'s keep-logic) -> retail SLD lines.
def oracle_vas(fn):
    p = ns["_find_oracle_path"](fn)
    vas = []
    for ln in p.read_text().splitlines():
        cm = re.match(r'\s*/\*\s*\w+\s+([0-9A-Fa-f]{8})\s+[0-9A-Fa-f]{8}\s*\*/', ln)
        va = int(cm.group(1), 16) if cm else None
        s = re.sub(r'/\*.*?\*/', '', ln).strip()
        if s.startswith('endlabel'):
            break
        mw = re.match(r'\.word\s+0x([0-9a-fA-F]+)\b', s)
        if mw and (int(mw.group(1), 16) >> 26) == 0x12:
            vas.append(va); continue
        if not s or s.startswith(('.', 'glabel', 'nonmatching', 'dlabel', 'jlabel', 'alabel')) or s.endswith(':'):
            continue
        vas.append(va)
    return vas

def sld_map(lo, hi):
    """addr -> retail source line, from dumpsym SLD records inside [lo,hi]."""
    if not SYM_TXT.exists():
        return {}
    out = {}
    pat = re.compile(r'\$([0-9a-f]{8})\s+\S+\s+(?:Inc SLD linenum.*\(to (\d+)\)|'
                     r'Set SLD linenum to (\d+))')
    with SYM_TXT.open(encoding='utf-8', errors='replace') as f:
        for ln in f:
            m = pat.search(ln)
            if not m:
                continue
            va = int(m.group(1), 16)
            if lo <= va <= hi:
                out[va] = int(m.group(2) or m.group(3))   # last record at addr wins
    return out

vas = oracle_vas(func)
real_vas = [v for v in vas if v is not None]
sld = sld_map(min(real_vas), max(real_vas)) if real_vas else {}
sld_keys = sorted(sld)

def sld_line(va):
    if va is None or not sld_keys:
        return None
    import bisect
    i = bisect.bisect_right(sld_keys, va) - 1
    return sld[sld_keys[i]] if i >= 0 else None

# ---- 5. report
src_lines = (ROOT / cpp_rel).read_text(encoding='utf-8', errors='replace').splitlines()
def src_text(n):
    return src_lines[n - 1].strip()[:90] if n and 0 < n <= len(src_lines) else ""

sm = difflib.SequenceMatcher(a=o, b=e, autojunk=False)
opcodes = sm.get_opcodes()
ndiff = sum((i1 - i0) + (j1 - j0) for t, i0, i1, j0, j1 in opcodes if t != 'equal')
print(f"{func}: {ndiff} diff insns across "
      f"{sum(1 for t, *_ in opcodes if t != 'equal')} blocks "
      f"(ours {len(o)} / oracle {len(e)}; -g twin {'EXACT' if exact else 'FUZZY'})\n")

from collections import Counter
hot = Counter()
blk = 0
for tag, i0, i1, j0, j1 in opcodes:
    if tag == 'equal':
        continue
    blk += 1
    print(f"-- block {blk} [{tag}]  ours[{i0}:{i1}]  oracle[{j0}:{j1}] --")
    for k in range(i0, i1):
        ln = idx2line.get(k)
        hot[ln] += 1
        print(f"  ours   {k:3d}  {o[k]:<34} <- :{ln or '?':<5} {src_text(ln)}")
    for k in range(j0, j1):
        rl = sld_line(vas[k] if k < len(vas) else None)
        va = vas[k] if k < len(vas) else None
        print(f"  oracle {k:3d}  {e[k]:<34} [{'%08x' % va if va else '??'}"
              f"{(' SLD:%d' % rl) if rl else ''}]")
    print()

print("SOURCE-STATEMENT HOTSPOTS (our diff insns per line):")
for ln, cnt in hot.most_common():
    print(f"  {cnt:3d}  :{ln or '?':<6} {src_text(ln)}")
