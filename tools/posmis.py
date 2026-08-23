#!/usr/bin/env python3
"""posmis.py TU FUNC[,FUNC...] [-v] -- POSITIONAL-MISMATCH metric for count-exact
functions.  Same CLI as tools/verify_asm.py, same normalizer (imported, not copied).

WHY THIS EXISTS (catalog 21E(3) / 23D(4))
  verify_asm's headline number is an LCS (difflib.unified_diff) edit count.  On a
  function whose stream length ALREADY equals the oracle's, that number is NOISE:
  a single register recolour deep in the body can re-align the LCS and swing the
  count by many lines in EITHER direction, so "diffs went 21 -> 27" says nothing
  about whether the edit moved you toward or away from the bytes.  When the two
  streams are the SAME LENGTH the honest structural metric is simply

      posmis = #{ i : ours[i] != oracle[i] }

  i.e. compare index-by-index, no alignment heuristics.  posmis is MONOTONE
  (every position you fix lowers it by exactly one) and posmis == 0 <=> PASS.
  It is only meaningful on count-exact streams; when the counts differ the tool
  says so and falls back to reporting |len(ours) - len(oracle)| + the LCS count,
  which is what verify_asm already prints.

USAGE
    python tools/posmis.py recon/game/psx/hrzsku.cpp Hrz_SetPsxMatrix
    python tools/posmis.py recon/syslib/psx/libgpu/SYS.c _dws,_drs
    python tools/posmis.py recon/game/psx/hud.cpp Hud_BuildNumbers0 -v

  FUNC spelling is verify_asm's: C++ functions need the GCC-MANGLED symbol (as in
  the board / asm/nonmatchings/**), extern-"C" functions the plain name.
  -v (or --verbose) additionally lists every mismatching position as
      <idx>  OURS:<insn>   ORACLE:<insn>

  The TU is COMPILED by this tool (verify_asm's own build.py pipeline runs at
  import), so the numbers always reflect the working tree as it stands.  Exit
  status: 0 iff every requested function is count-exact with posmis == 0.

IMPLEMENTATION NOTE
  tools/verify_asm.py is a flat script -- its ours()/oracle()/norm_ins() are
  module-level and its work happens at import time (compile + disassemble +
  print the gate lines) before a final sys.exit.  Rather than fork the
  normalizer (which would rot the moment verify_asm gains a leniency rule), we
  exec it as a module with the argv it expects, capture its gate output,
  swallow its SystemExit, and then call its ours()/oracle() directly.  One
  compile, one disassembly, two metrics.
"""
import contextlib
import importlib.util
import io
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
VERIFY = ROOT / 'tools' / 'verify_asm.py'


def load_verify(tu, funcs_arg):
    """Run tools/verify_asm.py in-process and return (module, gate_text)."""
    saved = sys.argv
    sys.argv = [str(VERIFY), tu, funcs_arg]
    buf = io.StringIO()
    spec = importlib.util.spec_from_file_location('verify_asm_posmis', VERIFY)
    mod = importlib.util.module_from_spec(spec)
    try:
        with contextlib.redirect_stdout(buf):
            spec.loader.exec_module(mod)
    except SystemExit:
        pass                      # verify_asm always exits; the gate text is what we want
    finally:
        sys.argv = saved
    return mod, buf.getvalue()


def dead_hi_fix(o, e):
    """Replicate verify_asm's w59-a9 dead-%hi artifact fix so posmis and the gate
    agree on what counts as a difference: an unpaired `lui rX,%hi(...)` has no
    %lo partner, so spimdisasm prints the oracle's bare constant while our
    R_MIPS_HI16 reloc normalizes to 0.  Positionally-aligned, byte-identical
    after link.  Count-equal streams only (same guard verify_asm uses)."""
    import re
    if len(o) != len(e):
        return e
    e = list(e)
    for i in range(len(o)):
        mo = re.match(r'lui (\w+),0$', o[i])
        me = re.match(r'lui (\w+),\d+$', e[i])
        if mo and me and mo.group(1) == me.group(1):
            e[i] = o[i]
    return e


def main():
    args = [a for a in sys.argv[1:] if not a.startswith('-')]
    verbose = any(a in ('-v', '--verbose') for a in sys.argv[1:])
    if len(args) < 2:
        print(__doc__.strip().splitlines()[0])
        print("usage: python tools/posmis.py TU FUNC[,FUNC...] [-v]")
        return 2
    tu, funcs_arg = args[0], args[1]

    mod, gate = load_verify(tu, funcs_arg)
    gate_line = {}
    for ln in gate.splitlines():
        s = ln.strip()
        if ':' in s and (' PASS' in s or ' FAIL' in s or 'NO ORACLE' in s
                         or 'NOT IN OBJECT' in s):
            gate_line[s.split(':', 1)[0].strip()] = s.split(':', 1)[1].strip()

    ok = True
    for fn in funcs_arg.split(','):
        o = mod.ours(fn)
        e = mod.oracle(fn)
        g = gate_line.get(fn, '?')
        if e is None:
            print(f"  {fn}: NO ORACLE"); ok = False; continue
        if not o:
            print(f"  {fn}: NOT IN OBJECT"); ok = False; continue
        e = dead_hi_fix(o, e)
        if len(o) != len(e):
            ok = False
            print(f"  {fn}: COUNT-INEXACT ours {len(o)} / oracle {len(e)} "
                  f"(delta {len(o) - len(e):+d}) -- posmis N/A; gate: {g}")
            continue
        mis = [i for i in range(len(o)) if o[i] != e[i]]
        verdict = 'PASS' if not mis else f"posmis={len(mis)}"
        print(f"  {fn}: count-exact {len(o)}/{len(e)}  {verdict}   gate: {g}")
        if mis:
            ok = False
        if verbose:
            for i in mis:
                print(f"      {i:4d}  OURS:{o[i]:<30} ORACLE:{e[i]}")
    return 0 if ok else 1


sys.exit(main())
