# NFS4-PSX Matching Decomp — Agent Working Guide

Self-contained onboarding for any agent joining the campaign. Read this fully,
then the three reference documents below, before touching a single function.

**Repo:** `C:\Temp\nfs4-decomp` · **Board:** 3075/3496 fns byte-matched (88.0%),
see `MATCH_PROGRESS.txt` (percentages go stale — never trust a row, re-gate).
**Goal:** byte-exact recompilation of NFS4 High Stakes PSX (`nfs4-f.exe`) from
reconstructed C/C++, function by function, with zero hand-asm pins.

---

## 1. MANDATORY READS (in this order, in full)

1. `C:\Users\Vyacheslav\.claude\projects\C--Temp-claud\memory\reference_mips_isa_asm.md`
   — the MIPS-I/R3000 ISA + GAS reference (delay slots, %hi/%lo signed pair,
   signed-divide codegen, what is NOT on R3000).
2. `C:\Users\Vyacheslav\.claude\projects\C--Temp-claud\memory\reference_psx_cpp_reconstruction_methodology.md`
   — the living methodology (seal criteria, source-authority hierarchy, §3.x
   technique library, §5 permuter discipline).
3. **THE LEVERS CATALOG** —
   `C:\Users\Vyacheslav\.claude\projects\C--Temp-claud\memory\reference_asm_pattern_catalog.md`
   — SYMPTOM-FIRST index: "I see THIS diff → try lever Y". The tail carries the
   newest law blocks (04U–04Z compiler-identity laws, 05A–05J, 06A–06F,
   07A–07F). **This is the single highest-leverage document in the project.**
   The memory dir is READ-ONLY for agents; report catalog candidates in your
   final report, the orchestrator harvests them.

---

## 2. THE GATE (sole authority)

```bash
python tools/verify_asm.py <recon-file> <SymbolName>
```

- Run from repo root. Gate **`recon/`** paths ONLY — the `src/**/*.c` stubs
  are `INCLUDE_ASM` scaffolding and gate VACUOUSLY (oracle vs itself).
- **Diff polarity: `-` = OURS, `+` = ORACLE.** (Misreading this has burned
  multiple agents.)
- Re-gate every baseline yourself before working a fn. `MATCH_PROGRESS.txt`
  and briefing numbers are stale in both directions, always.
- **Stale-object hazard:** if a *shared header* changed since the last build,
  the first gate may reuse a stale `.o`. Rebuild and gate twice before
  trusting a baseline.
- `verify_asm` is blind to intra-fn branch *targets* (normalized) and to
  unlinkable call targets (reloc-name leniency). For the latter run the
  **nm phantom check**: undefined symbols in your TU's `.o` that are not in
  `configs/symbol_addrs.txt` (especially `...__Fe` variadic manglings from
  `(...)`-typed extern decls) are real link bugs your gate will never show.

Per-diff source attribution: `python tools/diffsrc.py` (and see §4.1 SLD).

---

## 3. COMPILER IDENTITY MAP (settled laws — do not re-litigate)

| cluster | compiler | route |
|---|---|---|
| game/frontend C++ (`.cpp`) | CC1PLPSX (gcc 2.8.0) | maspsx + GNU as |
| eaclib (`.c`) | gcc 2.8.0 (proven bit-identical) | maspsx + GNU as |
| — exception: `eacpsxz/nsync.c` | gcc **2.8.1** | `cc1_ver` lane |
| syslib (most) | gcc **2.7.2** (PsyQ 4.0 CC1PSX ≡ FSF 2.7.2) | `cc1_272` lane: macro cc1 + direct GNU-as reorder, NO maspsx |
| syslib per-TU rungs | 2.6.3 / 2.7.2-970404 / 2.8.0 / 2.8.1 / 2.91.66 / 2.95.2 | `cc1_alt` lane (272 recipe, swapped binary) |
| `libgpu/SYS.c` | 2.8.1 + `-mno-split-addresses` (frame-size proven) | `cc1_alt` |
| libmath | Sony PREBUILT vendor object (no source ever existed) | per-TU rungs, all measured |

- Per-TU wiring lives in `tools/build.py` `PER_TU_FLAGS` — **orchestrator-owned;
  never edit `tools/*.py`**. Recommend wirings with whole-TU evidence.
- Ladder probe (dev box): `NFS4_FORCE_CC1_ALT=<ver> python tools/verify_asm.py …`
  Rungs live in `C:\Temp\windows-gcc-psx\gcc-<ver>-psx\cc1.exe`.
- **04Z LAW: rung tables are BASIN-RELATIVE.** Re-ladder after every structural
  landing; never wire a rung off a pre-lever table. (Confirmed 8+ times; after
  one wave 3 of 5 wired rungs were wrong.)
- The C++ lane has **no version axis** (no cc1plus ladder exists on disk).

---

## 4. PROVEN INSTRUMENTS (use in this order)

### 4.1 THE SLD — Law 05A: "the SLD IS the statement order"
The SYM's per-instruction source-line tags, grouped by line number, ARE
retail's statement list *and statement extent*. This sealed functions that had
resisted five waves of blind position search. Group the oracle's insns by SLD
line FIRST on every SYM-covered fn. Caveat: the SLD *identifies* the statement;
it does not always *enforce* it — pick the enforcement device afterwards.
Helpers exist in session scratchpads (`sldmap.py`, `sldview.py`, `w54a6_sld.py`
variants) — trivially re-derivable from `tools/diffsrc.py`.

### 4.2 THE SYM 8c BLOCK — Law 06A: "the local list is the allocation budget"
Trusted SYM: `C:\Temp\claud\dumpsym_clean\dumpsym_src\nfs4-f-v3.txt`.
Every fn's `8c Function start` block gives named locals + their `REG $N`/`AUTO`
homes + `fsize` + `mask`. A Ghidra-invented local the SYM does not list costs a
callee-saved register + frame bytes; the `mask` word alone tells you retail's
saved-reg count. Whole-fn "rule-8 rewrites" from the SYM local set have been
the single most productive instrument on game/frontend code (straight-to-PASS
from 100+ diffs, repeatedly). A `symblk.py` dumper (mangled name → 8c block)
exists in scratchpads; promote-worthy.

### 4.3 allocsim + reqdelta — the priced register dial
```bash
python tools/allocsim.py …    # replicate global_alloc's handout from .greg
python tools/reqdelta.py --want "p<NN>=<reg>" …
```
**The recipe (proven transferable, both lanes):**
1. `allocsim` must report an exact MATCH for the fn — that validates the model.
2. `reqdelta --want <retail handout>` prices the minimal dial (refs N→M or
   live N→M across a `floor_log2` step).
3. Buy refs with a read-only fence `__asm__("" : : "r"(x)[, "r"(x)])` placed
   **after the value's last real use** (before it costs a nop). Each operand =
   +1 ref ×loop_depth (out-of-loop +1, in-loop +2). An under-dialed fence
   is NOT inert — it regresses exactly as the model predicts.
**Limits:** both tools model *global* allocnos only. Local-alloc QTY handouts
and sched1-driven liveness are outside the model (see §4.6).

### 4.4 The fence toolkit (catalog 06B/07B — read the full rows)
Zero-insn devices, all pin-free:
- **read-only fence** `("" : : "r"(x))` = +refs (DEMOTE others / promote x);
- **identity fence** `("" : "=r"(x) : "0"(x))` = cse-opaque launder / PROMOTE;
- **void-tail fence** `("" : : "i"(0))` = scheduling barrier (implicitly
  volatile), the standard cure for "sched2 hoisted my store into a load slot";
- **volatile-on-the-TEST-read** = forces a fresh re-read AND shortens live
  range (cse never records a volatile MEM);
- **parm-spill pin** = void fence BEFORE the first statement keeps
  assign_parms' stores in the prologue group.
**Placement is a separate dial from choice** (same fence: decl = +3 diffs,
before-consumer = PASS). **Flavour matters** (`__volatile__` = barrier, plain =
schedulable — A/B both). **Boundary:** any asm stops reorg's backward
delay-slot scan — a top-of-fn fence and a prologue-store slot fill are
mutually exclusive. A mechanical fence-position sweeper exists
(`w55a9_fencesweep.py` in scratchpad) — one run replaces days of hand probing.

### 4.5 build.py per-fn mechanisms (orchestrator wires; you SPEC)
`PER_FN_NO_DELAYED_BRANCH` (dual-compile splice), `PER_FN_FORCE_ADDR`,
`PER_FN_NO_THREAD_JUMPS`, `PER_FN_RA_SINK`, `PER_FN_PROLOGUE_UNSINK`,
`PER_FN_EPILOGUE_UNFILL` (+ `_272`, + `_ALT28`), `PER_FN_FLAG_SPLICE_272`
(per-fn extra cc1 flag), `PER_FN_CC1_VER_SPLICE_272` (per-fn cc1 binary),
`PER_FN_TEXT_MOVES` (generic line relocation: take/after/slot/drop_nop —
called from ALL lanes). If your residual is a pure line relocation or a
per-fn flag/version effect, write the exact spec (regexes, measured result)
in your report; probe with a scratchpad COPY of build.py, never the original.

### 4.6 qtytrace — THE MISSING INSTRUMENT (to be built; highest leverage)
The **06E gap**: gcc-2.8's `local-alloc.c` QTY handouts and sched1-driven
liveness windows are invisible to allocsim/reqdelta. This single gap now
blocks 10+ near-miss fns across five independent scopes (drv.c's 8×3 residual
— sched1 hoists a format-string set so $a0 is live across the chain qtys;
Weather_DoWeather; R3DCar MenuII; the non-propagated reg-reg copy class ×4;
SubmitRequest's copy-preference override). **Plan:** instrument a cc1 build
(print `qty_birth/qty_death`, `reg_qty`, `qty_phys_reg` + `QTY_CMP_PRI` inputs,
and sched1 ready-list picks) → `tools/qtytrace.py` renders the handout and
answers "which source change moves value V to register R at the QTY layer".
Until it exists, DE-PRIORITIZE residuals classified as local-alloc swaps —
they are receipted, not floors, and spelling sweeps there are wasted budget.

### 4.7 Reference corpora (the triangle + twin)
- **Rage Racer** `C:\Temp\rage-racer-decomp` — 100% byte-exact PSX corpus.
  `src/main/PAL/lib/libcd`, `libgpu` = matched Sony-lib C (the proven lever
  goldmine: port the SHAPES, drop their register-asm pins — we are pin-free).
  Block ORDER does not always transfer; inner idioms do.
- **psyz** `C:\Temp\psyz\decomp\src` — matched PSY-Q 4.0 C under gcc 2.7.2
  (libgpu/sys.c near-complete; libcd partial; libmath stubbed).
- **windows-gcc-psx** `C:\Temp\windows-gcc-psx` — the compiler ladder itself.
- **PC twin** `C:\Temp\nfs4-clean\nfs4-pc.c` + map
  `C:\Temp\nfs4-clean\pcmap\CONSOLIDATED.txt` — floatized logic oracle for
  mapped game/common fns (branch structure and constants only, never codegen).

---

## 5. HARD RULES

1. **NO register-asm pins** (`register … asm("$N")`) — fence dials replace them.
   A hard-reg *clobber* fence is pin-adjacent and needs user sign-off.
2. **NO FLOORS.** Every fn ends PASS or a NEW named angle with receipts.
   Falsified levers are receipted in-source with their diff counts so nobody
   re-fights them. Read a fn's existing receipts BEFORE working it.
3. **Zero PASS→FAIL.** Re-gate your whole TU (and TU-mates for wiring changes)
   after every landing.
4. Avoid `volatile` and `do{}while` by default — a measured win with falsified
   alternatives receipted may override (several catalog laws are exactly this).
5. **Never** edit: `tools/*.py`, shared maspsx, the memory dir, or the user's
   live session files (`recon/frontend/common/fedialog_externs.h`,
   `femenudefs.cpp`, `femenuextended_externs.h`, `screenusername_externs.h`,
   `recon/nfs4_types.h`, `scratch_*.diff`). Needed changes there → report the
   exact diff.
6. **No git commits / stash / checkout outside your scope.** The orchestrator
   re-gates and commits. Keep per-file backups in your scratchpad after every
   landing (a mid-wave `git stash` incident once wiped four agents' work).
7. Keep `/* @0xVA */` breadcrumbs and in-source `MATCH:` receipt blocks.
8. Think like a 1998 programmer (EA for game/frontend/eaclib, Sony/SN for
   syslib). "Natural 1998 source" rewrites beat dialing, repeatedly.

## 6. HAZARDS (all have fired; all cost real time)

- **Heredoc backslash collapse**: bash heredocs (even quoted) collapse `\\`,
  planting raw control bytes / NULs that compile and gate silently. Use the
  Write/Edit tools or numerically-built bytes for ANY escape-bearing content.
  After scripted edits: scan for control bytes, check CRLF/LF unchanged.
- **`pathlib.write_text` truncation** (encoding error → 0-byte file) and CRLF
  conversion: byte-mode temp + size-grew assert + `os.replace`, ASCII-only.
- **Comment receipts** containing `*/` or `/256*/256` close the host comment.
- **Fn-region slicing by forward declaration** truncates the file — anchor on
  `sig + CRLF CRLF {`, assert header count preserved.
- **build.py concurrency**: a half-written table hard-fails every gate
  tree-wide. `ast.parse` it before relying on gate output; probe on copies.
- **Mixed line endings per file** — probe harnesses must try both anchors.

## 7. CURRENT BEST TARGETS (post-W55, re-gate before starting)

1. Build the **qtytrace lane** (§4.6) — unblocks 10+ receipted near-misses.
2. **Phantom-signature sweep**: `(...)`-typed decls in ~24 externs headers emit
   wrong `__Fe` manglings at every call site (real link bugs, gate-invisible;
   `nm`-check finds them; correct typed forms often already exist in sibling
   headers). Two headers are user files — report, don't touch.
3. Remaining heavies, all SYM-structured coloring grinds now: physics
   DoBarrierCheck 214 / CalculateCarAcceleration 217, aih_cop trio, audiocmn
   SoundCar 169 / SFX 134 / Reset 126, PrimClip 552, kCtrlSkidmark 303,
   BuildNumbers 208, username DrawBackground 255, screens far set.
4. Near-seal belt: dozens of 2–10-diff fns with named angles in-source.
5. USER-blocked: `$4`-clobber policy; `nfs4_types.h` signed-char fields +
   `fNumRacers` as int + `AIHigh_BasicCop` dtor.

## 8. REPORT FORMAT (end of your run)

Per-fn ledger (re-gated baseline → final, lever + receipt), falsification list
with basins, catalog-row candidates, exact orchestrator actions (wiring specs
with whole-TU evidence), files touched, backup locations, hazards encountered.
Numbers you did not re-gate yourself do not go in the ledger.
