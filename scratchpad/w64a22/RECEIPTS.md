# W64-A22 RECEIPTS — CONTRADICTION ADJUDICATOR + TOOL SURGEON

**The deliverable is [ADJUDICATION.md](ADJUDICATION.md)** — four verdicts, each by
experiment on our own toolchain, each with the gcc source citation. This file is the
index + the discipline log.

## Files

| file | what |
|---|---|
| `ADJUDICATION.md` | **the verdicts** (13A scope, W46 param-copy, net-zero pair, LoM formula) + proposed catalog edits |
| `declab.py` | shared lab: source generator + 5-lane compile/dump driver (`cpp`, `c272`, `c280`, `c281`, `c272b`) |
| `run_declab.py` | probe 1a — pseudo NUMBERING vs declaration order (distinct priorities) |
| `declab2.py` | probe 1b — equal refs, single block |
| `declab3.py` | probe 1c — multi-block global allocnos, staggered lives |
| `declab4.py` | probe 1d — **multi-block EXACT TIE** (`W64A22_FLAT=1 python … 4 1`) ⇒ the decl dial fires |
| `declab5.py` | probe 1e — **single-block EXACT TIE**, decl axis vs first-use axis swept independently |
| `declab6.py` | probe 1f — memory locals: BLKmode vs address-taken frame-slot order |
| `parmlab.py` | Mission A/2 — 13-variant prologue param-copy lab across 5 binaries |
| `netzero.py` | Mission A/3 — 12-variant net-zero-pair probe on a COPY of bworldSm.cpp |
| `lab/` | the sealed-TU COPY used by `netzero.py` (shim headers forward to `recon/`) |
| `bak/` | pre-edit `.bak` of the three tools |

Raw compiler outputs: `%TEMP%\w64a22_declab\<lane>_<probe>_<variant>\{lab.i,lab.s,lab.i.lreg,lab.i.greg}`.

## Discipline log

* **The sealed TU `recon/game/common/bworldSm.cpp` was never written to.** The net-zero
  probe ran against `scratchpad/w64a22/lab/game/common/bworldSm.cpp`, a byte copy whose two
  `#include`s are forwarded by one-line shims; it gates identically (`PASS (34 insns)`).
* Source files touched: **none** in `recon/`. Tools touched: exactly the three assigned
  (`tools/alpha.py`, `tools/fast.py`, `tools/qty272.py`), each with a `.bak`, `ast.parse`
  clean, and a post-edit known-good run.
* Every lab result was produced on **five compiler binaries**, including tenchu's
  (`gcc-2.8.1-psx`) and LoM's (`gcc-2.7.2-970404-psx`) own lanes, so a "their compiler is
  different" objection is pre-empted for each verdict.
* `netzero.py` `01_pair_removed` was re-gated **twice**, plus a restore-gate.
* Hazards encountered: (1) an early `sha()` over the raw `.s` counted the `.file` directive
  (absolute temp path) as a diff — every "CODE-DIFFERS" in the final harnesses strips it;
  (2) mixed decl/statement C89 errors silently produced an EMPTY `f` on the C lanes and read
  as "(none) copies" — the final `parmlab.py` asserts `.end` is present before reporting;
  (3) **peer sweep**: my staged tool commit was absorbed by `2ab433f4` (w64a18) between
  `git add` and `git commit`.

## One-line verdicts

1. **13A SCOPE** — pseudo number **IS** declaration order (tenchu/W41's mechanism is wrong);
   the decl dial is **inert for local-alloc qtys even at a tie** and **decisive for global
   allocnos at an exact tie**. Narrow 13A, do not delete it.
2. **W46 PARAM-COPY** — tenchu's fence-free local-copy cure is **falsified on all five
   binaries incl. their own 2.8.1** (copy-propagated). With an **identity launder** it works,
   **2.8.0-only**. The register (not just the position) moves only under an **asymmetric ref
   dial** (fence the *losing* formal); a multi-operand fence's operand ORDER is not a dial.
3. **NET-ZERO PAIR** — **inert at HEAD**: `BworldSm_UpdateSimQuad` PASSes 34/34 with the pair
   deleted. Re-classify as DIAGNOSTIC; orchestrator should delete lines 377-379.
4. **LoM FORMULA** — `floor_log2(refs)*refs*SIZE/live` (`global.c:594-616`,
   `local-alloc.c:1726-1728`); MIPS has **no** `REG_ALLOC_ORDER` (`global.c:992-998` `#else`
   arm = ascending numeric scan). 15B confirmed; LoM's formula and REG_ALLOC_ORDER claim
   both rejected. Axis closed.
