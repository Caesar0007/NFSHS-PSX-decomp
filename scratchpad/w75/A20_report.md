# W75-A20 — INSTRUMENTS BELT (report)

Belt: build the named `[reload_pick]` instrument · sweep the reload_cse donor-clobber tell
tree-wide · promote `posmis` to `tools/`.
Repo `C:\Temp\nfs4-decomp`. **No git commit/push. `tools/build.py`'s uncommitted foreign edit
never touched. No memory file edited.**

STEP 0 done: `reference_mips_isa_asm.md` (full), `reference_psx_cpp_reconstruction_methodology.md`
(full, 1018 lines), catalog tail §18–§23 (20B family, 21A/22B device laws, 23A compiler-source
laws, 23B CELL pricing, 23D instruments/process).

---

## HEADLINE

| task | outcome |
|---|---|
| 1. `[reload_pick]` instrument | **BUILT + VALIDATED.** Wired into `apply_traces.py` (both copies), `cc1-ecoff` rebuilt and proven **codegen-neutral** (4 TUs byte-identical vs the pre-patch instrumented cc1). Lab fidelity **43/44 vs the ladder gcc-2.8.1** on SYS.c. The ±1 scratch-rotation class is now **fully explained + cited**. |
| 2. reload_cse donor-clobber sweep | **ALL 53 sub-100% fns scanned. Exactly ONE genuine instance** (`_read_issue`), 4 cures probed, **none a strict improvement → nothing kept.** New law: why the zero-insn cure is unreachable at a call-argument site, and that laundering the argument *does* cure the rewrite but costs an insn. |
| 3. `tools/posmis.py` | **CREATED**, mirrors verify_asm's CLI, *imports* its normalizer (no fork). Smoke-tested on PASS / count-exact-FAIL / count-inexact / NO-ORACLE. |

**Zero PASS→FAIL anywhere.** No recon source file was left modified (every probe restored and
byte-verified); the only repo artifacts are the new `tools/posmis.py`, `scratchpad/w75/*`, and the
instrumentation copy `scratch/instr/apply_traces.py`.

---

## TASK 1 — the `[reload_pick]` instrument

### What was built

`allocate_reload_reg` (gcc-2.8.1 `reload1.c:5031`) now emits two lines per reload allocation,
gated on its **own** env var `GCC_TRACE_RELOAD_PICK` (so it does not flood existing
`GCC_TRACE_ALLOC` runs; set both to get the `===== FUNCTION x =====` markers that segment it).

Patch = `patch_reload_pick()` in `C:\Temp\nfs4-instr-cc1\apply_traces.py` (mirrored byte-for-byte,
CRLF-preserved, into the repo-local `C:\Temp\nfs4-decomp\scratch\instr\apply_traces.py`).
It is idempotent (marker `nfs4_reload_pick`) and requires `patch_reload1()` first.
Source tree patched: `C:\Temp\nfs4-decomp\scratch\gccsrc\gcc-2.8.1\reload1.c`
(pre-patch copy kept at `scratchpad/w75/A20_reload1_before.c.bak`).
Also applied to the second tree `C:\Temp\gccsrc\gcc-2.8.1` (build_cc1.sh resolves `$HERE/..`, so the
copy in `C:\Temp\nfs4-instr-cc1` drives *that* tree — see GOTCHA below).

### Build

```sh
cd C:/Temp/nfs4-decomp/scratch/instr && unset TMPDIR TMP TEMP && sh build_cc1.sh ecoff
```
→ `C:\Temp\nfs4-decomp\scratch\gccbuild-ecoff\cc1.exe` (1 994 978 B, 2026-08-23 15:50).
Protected copy: `scratchpad/w75/a20/cc1-ecoff-reloadpick.exe`.

🔴 **GOTCHAS PAID FOR (encode these):**
1. `build_cc1.sh` derives `SCRATCH=$(dirname $0)/..`, so running the copy in
   `C:\Temp\nfs4-instr-cc1` builds `C:\Temp\gccsrc` → `C:\Temp\gccbuild-ecoff`, **not** the repo
   tree. Run the **repo-local** `scratch/instr/build_cc1.sh` to touch `scratch/gccbuild-ecoff`.
2. **Do NOT set the run-time `TMPDIR` (Windows path + trailing backslash) for the BUILD** — the
   host MinGW toolchain then dies `Cannot create temporary file in ...\=\`. Unset it to build,
   set it to run.
3. cc1 does **not** strip C comments (that is cpp's job): a hand-written probe `.c` with a `/* */`
   header gets `parse error before '/'`. Feed it a `.i`.

### Codegen neutrality (mandatory before trusting a rebuilt lab)

New binary vs the previous instrumented ecoff cc1 (`C:/Temp/gccbuild-ecoff/cc1.exe`, pre-patch),
same flags, byte-compare of the `.s`:

| TU | result |
|---|---|
| `SYS.c.i` (`-O2 -G0 -mgas -mno-split-addresses`) | **IDENTICAL** |
| `FONT.c.i`, `COR_01.c.i`, `FOG_01.c.i` (`-O2 -G0 -mgas`) | **IDENTICAL** (incl. reproducing the same post-alloc segfault point) |

### Lab fidelity (per-function AND per-basin, as the rules demand)

`SYS.c` is wired `cc1_alt: "2.8.1"` + `no_split_addresses` → the lane compiler is the ladder
`C:/Temp/windows-gcc-psx/gcc-2.8.1-psx/cc1.exe`. Instrumented vs ladder, per function
(`scratch/instr/cmp_fns.py`): **43 / 44 IDENTICAL** (only `ResetGraph` differs, and that fn carries
a per-fn `-fno-schedule-insns2` flag-splice in build.py, so a plain run is expected to diverge).

⇒ for SYS.c the trace is a **receipt**, not a hint.

### Validation on two already-SEALED functions

| fn | gate | trace | emitted asm |
|---|---|---|---|
| `_dws` | **PASS (143 insns)** | pool `[$6,$64,$66]`, 3 picks: cursor −1→1 (`$64`), 1→2 (`$66`), 2→0 (`$6`) | `mflo $6` / `addu $3,$6,1` — the class-1 reload landed in `$6` exactly as traced |
| `_drs` | **PASS (160 insns)** | identical shape (insn 97/99), same cursor walk | same |
| `PutDispEnv` | **PASS (318 insns)** | two identical 3-pick groups at insn 445/447 and 460/461, cursor −1→1→2→0 then 0→1→2→0 | — |

(`$64`/`$65`/`$66` are the MIPS `hi`/`lo`/`hilo` hard regs — a divide's HI/LO reload; class 3/5/6
are the HI/LO/HILO reg classes, class 1 = GP_REGS.)

### Trace grammar

```
[reload_pick]  r=<reload#> insn=<uid> class=<reg_class#> mode=<machine_mode#> nregs=<N>
               opnum=<operand#> when=<reload_when_needed#> noerror=<0|1> force_group=<0|1>
               n_spills=<pool size> last_spill_reg=<incoming cursor> start=<first index tried>
               order: <i>:$<reg><flags> ...
[reload_pick]  r=<reload#> WON i=<index> $<reg> pass=<0|1> (cursor <old> -> <new>)
```
per-candidate `<flags>` (each letter present ⇒ true):

| flag | meaning | source |
|---|---|---|
| `c` | in `reg_class_contents[reload_reg_class[r]]` | reload1.c:5095 |
| `f` | `reload_reg_free_p(...)` at this opnum/when | reload1.c:5093 |
| `u` | in `reload_reg_used_at_all` (pass-0 eligible) | reload1.c:5101 |
| `h` | in `reload_reg_used_for_inherit` (pass-0 **veto**) | reload1.c:5103 |

`pass=0` = the *reuse* pass (only `c f u` and **not** `h`); `pass=1` = any free class member.
Absent `order:` entries are regs not in the spill pool at all.

### Usage recipe

```sh
cd C:/Temp/nfs4-decomp
cp build/recon/<path>/<TU>.c.i scratchpad/<mine>/tu.i          # NEVER share the .i: cc1 names its
                                                               # dump files after the input path
export TMPDIR='C:\Temp\nfs4-decomp\scratchpad\<mine>\tmp\'      # Windows path, TRAILING BACKSLASH
export TMP="$TMPDIR" TEMP="$TMPDIR"; mkdir -p scratchpad/<mine>/tmp
GCC_TRACE_ALLOC=1 GCC_TRACE_RELOAD_PICK=1 \
  scratch/gccbuild-ecoff/cc1.exe -quiet -O2 -G<g> -mgas [-mno-split-addresses] \
  scratchpad/<mine>/tu.i -o scratchpad/<mine>/tu.s 2> scratchpad/<mine>/trace.txt
# attribute picks to functions (local_alloc runs before reload for each fn):
grep -E "===== FUNCTION|reload_pick" trace.txt \
  | awk '/FUNCTION/{f=$3} /reload_pick/{print f" | "substr($0,20)}'
```
* a post-alloc **segfault (rc=33) does NOT invalidate the traces** — the `.s` was already written.
* the flags must be the TU's REAL lane flags (`tools/build.py` `PER_TU_FLAGS` + `_compile_c_272`
  for the `cc1_272`/`cc1_alt` lanes: `-quiet -O2 -G<g_value|0> -mgas [-mno-split-addresses]`).
* pair it with the existing `[reload-order]` line, which prints `hard_reg_n_uses` +
  `regs_explicitly_used` per reg — that is the input to the pool ORDER.

### 🏆 WHAT THE ±1 SCRATCH-ROTATION CLASS ACTUALLY KEYS ON (new law, all cited)

`allocate_reload_reg` is a **round-robin cursor over the spill pool**, not a cost model:

1. **`last_spill_reg` is a PER-FUNCTION cursor.** Initialised `-1` once per function in `reload()`
   (**reload1.c:823**, inside `reload()` @ reload1.c:537), read as the start point
   (**reload1.c:5083** `i = last_spill_reg;`), stepped `i = (i + 1) % n_spills` (**reload1.c:5088**),
   and written to the winning index on every SUCCESSFUL allocation (**reload1.c:5185**
   `last_spill_reg = i;`). ⇒ **adding or removing exactly one earlier reload in the same function
   rotates every later scratch by one position in `spill_regs[]`.** That IS the ±1 class.
   *Measured*: `MemCardGetDirentry` pool `[$8,$9,$10,$11]`, cursor walks 0→1→2→3→0→1→2→3…;
   `_dws` walks −1→1→2→0.
2. **The rotation is over the CLASS-ELIGIBLE, FREE subset**, not the raw pool. The scan skips a
   candidate unless `reload_reg_free_p` (5093) ∧ `reg_class_contents[class]` (5095) ∧
   `HARD_REGNO_MODE_OK` (5096). ⇒ **when the reload's class has only ONE pool member the pick is
   deterministic and NO ±1 rotation is possible.** *Measured*: libgpu/libgte/libetc syslib TUs
   (`FntFlush` n_spills=1; `csincos`/`_dws`/`_drs` GP-class pool = one reg) are structurally immune;
   the ±1 class needs a **multi-member class pool** (libmcrd's `$8..$11`).
3. **Two passes, and the tell for "why not the obvious reg".** Pass 0 accepts only a pool reg that
   is already `reload_reg_used_at_all` **and not** `reload_reg_used_for_inherit` (reload1.c:5100-5104
   — "reuse first, but never steal an inherited reload"); pass 1 accepts any free one. A `pass=1`
   with `u`-flagged candidates in the order line means those were *used but not free* for this insn.
4. **The pool composition/order is the other half of the dial** — `order_regs_for_reload` fills
   `potential_reload_regs` from `hard_reg_n_uses` (least-used first; the existing `[reload-order]`
   trace prints it), and **any hard reg named in an `asm` goes into `bad_spill_regs` function-wide**
   (the 20B mutual-exclusion certificate) — i.e. a 20B clobber of `$N` does not merely deny `$N`, it
   **removes `$N` from the pool and re-seats every later pick**. Matches §23D-3's "zero-insn i(0)
   clobber = a reload-POOL PROBER (membership + one-step rotation)": the trace now shows *both*
   effects directly instead of inferring them.

### `MemCardGetDirentry` (unit syslib/psx/libmcrd, VA 0x800FB888) — the requested run

Baseline gate `FAIL 23 diffs (ours 153 / oracle 152)`.

🔴 **LAB-FIDELITY VERDICT FIRST (this is the honest part): the instrument is NOT a receipt here.**
`LIBMCRD.c` is wired `{"cc1_272": True}` → its lane compiler is **PsyQ 4.0 `CC1PSX.EXE` (gcc-2.7.2)**,
not 2.8.1. Measured instrumented-2.8.1 vs the lane compiler on the same `.i`, per function:
**IDENTICAL 1 / 26**; `MemCardGetDirentry` itself `d98`. ⇒ **no number from this trace may be quoted
as a byte receipt for any `cc1_272` / `cc1_alt 2.7.2` TU.** (Of the 53 sub-100% fns, **10 sit on
reload_cse-free 2.7.2 lanes** — see task 2 — and the same caveat applies to all of them.)

What the trace *does* give (2.8.1 lab, structural):
```
[reload-order] FUNCTION MemCardGetDirentry large=153 r2=217/e1 r3=22/e0 r4=157/e1 r5=154/e1
               r6=154/e1 r7=154/e1 r8=0/e0 r9=0/e0 r10=0/e0 r11=0/e0 r12=0/e0 ...
[reload_pick]  ... n_spills=4 last_spill_reg=-1 start=0 order: 0:$8cf 1:$9cf 2:$10cf 3:$11cf
[reload_pick]  r=0 WON i=0 $8  pass=1 (cursor -1 -> 0)      insn=97
[reload_pick]  r=0 WON i=1 $9  pass=1 (cursor  0 -> 1)      insn=212
[reload_pick]  r=0 WON i=2 $10 pass=1 (cursor  1 -> 2) \
[reload_pick]  r=1 WON i=3 $11 pass=1 (cursor  2 -> 3)  |  insn=317, four call args,
[reload_pick]  r=2 WON i=0 $8  pass=1 (cursor  3 -> 0)  |  a full wrap of the pool
[reload_pick]  r=3 WON i=1 $9  pass=1 (cursor  0 -> 1) /
```
i.e. `$8..$15` are the **zero-use** regs, so `order_regs_for_reload` ranks them first and the GP
spill pool is exactly `[$8,$9,$10,$11]` = `$t0..$t3`, walked round-robin.

🔑 **DIAGNOSIS FOR WHOEVER OWNS THIS FN — it is NOT a rotation, it is a DEMOTE (§22B-8).**
The oracle's diff sites use **`$t0`** — `li t0,2` / `sw t0,0(s3)` / `lw t0,92(sp)` / `beqz t0` —
i.e. `spill_regs[0]`, a **reload** register: retail SPILLED that pseudo and reload rematerialised it
in `$t0`. Ours holds the same value in `$v0`/`$v1`, i.e. **we never spilled it** (and our frame is
64 B larger: `sw a3,156(sp)` vs `sw a3,92(sp)`). The named angle is therefore
**DEMOTE-out-of-allocation** (give the pseudo a long-live low-priority form so it keeps `REG_EQUIV`
and reload remats at the use), **not** a scratch-rotation dial. The other diffs
(`addu v0,s3,zero` extra insn, `lui at,0` = the 2.7.2 assembler `$at` macro form) are the
`cc1_272`-lane address-macro family, not reload at all.

---

## TASK 2 — reload_cse_regs DONOR-CLOBBER sweep (tree-wide)

### The mechanism, re-derived from source (every claim cited)

* `toplev.c:3500-3501` — `if (optimize > 0) reload_cse_regs (insns);` — **unconditional at -O2, no
  `-f` switch**, runs after reload and before jump2/reorg.
* `reload1.c:8178 reload_cse_simplify_set` — for any `(set (reg HARD) SRC)` with
  `side_effects_p(src)==0` **and `true_regnum(src) < 0`** (i.e. SRC is *not already a register*:
  CONST_INT / CONST / SYMBOL_REF / PLUS / MEM-with-cost≥2), it scans `i = 0 .. FIRST_PSEUDO_REGISTER`
  (**ascending — the LOWEST regno wins**, reload1.c:8202) for a hard reg whose recorded value is
  `rtx_equal` to SRC and rewrites the set as a plain **register copy**. On MIPS that renders as
  `addu rD,rS,zero` (never `addiu`).
* Invalidation (= the cure surface): **`reload1.c:7900-7907`** forget *everything* at a `CODE_LABEL`;
  **`reload1.c:7929-7933`** forget every `call_used_regs[i]` at a `CALL_INSN`; **`reload1.c:8006-8011`**
  `note_stores (x, reload_cse_invalidate_rtx)` for every non-SET element of a PARALLEL — **this is
  what an empty `__asm__` with a hard-reg clobber hits** (the `_dws`/`_drs` cure).
* Version fingerprint (catalog 23A-2): present in 970404 / 2.8.0 / 2.8.1, **absent** in
  2.6.x / 2.7.2 / 2.91 / 2.95.

### Scope

All **53** sub-100% rows of `MATCH_PROGRESS.txt` (the whole FAIL set: the board carries 3490 fns,
3437 at 100%). Lane census — **the tell is impossible on a reload_cse-free lane**:

| lane | sub-100% fns | reload_cse? |
|---|---|---|
| default 2.8.0 (CC1PSX + maspsx) | 41 | yes |
| `cc1_alt 2.8.1` (`_gpu_que_drain`) | 1 | yes |
| `cc1_alt 2.7.2-970404` (`__adddf3`) | 1 | yes |
| `cc1_272` 2.7.2 (`_intrhand`, `_set_intr_callback`, `_st_dma`, 3× MemCard*, `CD_cw`, `func_80106878`) | 8 | **no** |
| `cc1_alt 2.7.2` (`__divdf3`, `_pad_getbyte`) | 2 | **no** |

### Method

`scratchpad/w75/a20/dump_streams.py` compiles each TU **once** (importing `tools/verify_asm.py`
in-process, so the streams use the gate's own normalizer) and pickles every FAIL fn's
`(ours, oracle)` streams → `streams.pkl`; all analysis is then offline.
Alignment: **positional** when count-exact (the posmis alignment; LCS is noise there per 21E(3)),
`SequenceMatcher` otherwise. `scratchpad/w75/a20/cse_sweep{,2}.py` do the scanning.
50/53 in one pass; the 3 `LIBMCRD` fns rescanned separately (the TU was being edited by the
concurrent human session mid-run — see PROCESS NOTES).

### Result — 103 ours-side `addu rD,rS,zero` mismatch rows examined

| verdict | count |
|---|---|
| forward tell (ours copy / oracle `li`\|`lui`, **same dest**) | **0** |
| reverse tell (ours `li`\|`lui` / oracle copy, same dest) | **0** |
| genuine reload_cse instance found by widening to *any* non-register oracle source | **1** |

**⇒ the `li`/`lui`-flavoured tell named in 23A-2 is EXHAUSTED tree-wide.** W74's `_dws`/`_drs`
seals took the last two.

The one genuine instance is the **`const_int 0` flavour**, which the catalog's regex misses:

> **`_read_issue` @0x80108BF4 (`recon/syslib/psx/libcd/cdread.c`, default 2.8.0 lane), 3 diffs,
> ours 121 / oracle 122.** At `CdControl(9, 0, 0)` (line 673, `CdlPause`):
> ```
> 49  li a0,9
> 50  addu a1,zero,zero          <- donor: (set a1 (const_int 0)) recorded
> 51  jal T
> 52  OURS: addu a2,a1,zero   |  ORACLE: addu a2,zero,zero      (a2 is the jal delay slot)
> ```
> `$zero` is never *set*, so `reg_values[0]` is empty and the ascending scan's first hit is `$a1`
> (regno 5) → `(set a2 (const_int 0))` becomes `a2 = a1`. This is the same class the TU's own W62-A6
> receipt calls "the cse-substituted live `$a1` zero" — **that name is wrong; it is `reload_cse_regs`**,
> exactly as the `_dws` block comment corrected the "3.25-3b no-copy-prop" name.

### Cures probed (`scratchpad/w75/a20/probe_readissue.py`, edits→gate→**always restore**)

Whole-TU gate each time (`_read_sync`, `_read_int`, `_read_data_int`, `_read_issue`, `CdRead`,
`CdReadSync`); baseline `_read_issue` **3 diffs (121/122)**, everything else PASS.

| variant | `_read_issue` | siblings | verdict |
|---|---|---|---|
| `base` | 3 (121/122) | all PASS | — |
| **v1** the proven zero-insn cure, `__asm__("" : : : "$5")` before the call statement | **3 (121/122)** | all PASS | **INERT** |
| **v2** third arg via an identity-laundered zero | 8 (**122/122**, count-exact) | all PASS | worse |
| **v3** second (donor) arg via a laundered zero | 7 (121/122) | all PASS | worse |
| **v4** both nulls from one laundered pseudo | 9 (121/122) | all PASS | worse |

**KEPT: nothing.** Zero PASS→FAIL; `cdread.c` byte-restored and verified after every probe.

### 🏆 NEW LAWS (task 2)

1. **THE ZERO-INSN DONOR CLOBBER CANNOT REACH A CALL-ARGUMENT SITE.** The cure requires a CLOBBER
   insn *between the donor's set and the constant's set in final post-reload ORDER*
   (reload1.c:8006-8011). When donor and consumer are **two consecutive argument-register loads of
   one call**, C has no statement position between them: `expand_call` computes every argument into
   temporaries first and only then emits the `a0,a1,a2,…` loads, so a statement-level `__asm__`
   — and equally an asm inside an argument expression — always lands *before all of them*, where it
   is re-recorded away by the donor's own set. **v1 measured INERT, as predicted.** This bounds
   23A-2's cure: it works for a *statement-separated* donor/consumer pair (`_dws`/`_drs`: the guard
   mask vs `readyMask = 0x04000000;`) and **not** inside one call's arg block.
2. **BUT THE REWRITE *IS* CURABLE FROM THE ARGUMENT — AT ONE INSN.** Laundering the argument makes
   the set's source a REGISTER, so `reload_cse_simplify_set` bails at its
   `true_regnum (src) >= 0` guard (**reload1.c:8193**) — v2 genuinely mints retail's
   `addu a2,zero,zero` (visible in the v2 stream) and even makes the fn **count-exact 122/122**.
   The launder's own `addu` is the price (§23B-2 "an identity launder is not free"), and here it
   lands badly: posmis on the v2 basin is large (an unbroken one-position tail shift from index ~70 to the epilogue), i.e.
   **count-exactness bought at the cost of the schedule** — a textbook case for pricing the CELL,
   not the axis. The remaining un-probed shape is a launder whose insn is *needed anyway*
   (a value already register-resident for another reason).
3. **SWEEP-SCOPING LAW:** before hunting a reload_cse tell in a TU, read its lane out of
   `PER_TU_FLAGS`. `cc1_272` and any `cc1_alt` 2.6.x/2.7.2/2.91/2.95 rung has **no
   `reload_cse_regs` at all** — 10 of the 53 sub-100% fns, where the class is impossible by
   construction rather than merely absent.

### Falsified / not-the-tell (named, so nobody re-runs them)

* `__15tGlobalMenuDefs` `addu a3,s0,zero` vs `lui a3,0` / `addiu a3,a3,0` — **not the tell**:
  a 1238-diff, count-inexact far-miss where LCS alignment is meaningless; the oracle side is a
  `%hi/%lo` *address* pair, not a recorded constant.
* `DrawC_PrimClip` `addu t2,a3,zero` vs `li t2,-1` — **LCS artifact**. Reported by the
  SequenceMatcher pass; the positional (posmis) alignment shows those two lines are *not* at the
  same index. `DrawC_PrimClip` is count-exact 1877/1877 and its real residual is a
  `t1↔t8` + `{t2,t3,t8}→{t3,t2,t1}` register permutation plus two `beqz`/`move` schedule swaps.
* `HighExecute__18AIHigh_BTC_Wingman` (4 diffs, count-exact 675/675) — ours
  `addu a2,v0,zero` vs oracle `addiu a2,sp,72` / `addiu a2,sp,56` at two sites. **NOT reload_cse**:
  the donor `$v0` is the return value of the `jal` immediately before, and a `CALL_INSN` invalidates
  every `call_used_regs` entry (reload1.c:7929-7933), so `reg_values[$v0]` is empty there.
  🟢 **NEW NAMED ANGLE for aih_btccop's owner — "ctor-return-vs-address remat":** the preceding call
  takes `a0 = sp+72` and its return is being reused as the same address; retail **rematerialises
  `&buf`**. Spell the second call's argument as the address of the local again (or hold the address
  in a named local across the call, §3.12 #16) instead of reusing the call's result. Two sites, one
  shape, 4 diffs → a cheap seal candidate.

---

## TASK 3 — `tools/posmis.py`

Created `C:\Temp\nfs4-decomp\tools\posmis.py` (CRLF, matching the other tools).

* **Same CLI as `verify_asm.py`**: `python tools/posmis.py TU FUNC[,FUNC...] [-v]`; C++ fns take the
  GCC-mangled symbol, `extern "C"` fns the plain name.
* **Imports the normalizer instead of forking it.** `verify_asm.py` is a flat script whose work
  happens at import (compile → objdump → print the gate → `sys.exit`), so posmis execs it as a
  module with the argv it expects, captures the gate text, swallows the `SystemExit`, then calls its
  `ours()` / `oracle()`. One compile, both metrics, and the normalizer can never rot out of sync.
  It also replicates verify_asm's w59-a9 dead-`%hi` artifact fix so the two agree on what a
  difference is.
* Reports per fn: `count-exact N/N  posmis=K   gate: <verify_asm's line>`, or
  `COUNT-INEXACT ours A / oracle B (delta ±d) -- posmis N/A`. `-v` lists every differing position.
  Exit 0 iff every requested fn is count-exact with `posmis == 0`.
* **Why**: on a count-exact stream verify_asm's LCS count is non-monotone (21E(3)); posmis is
  monotone (one fixed position = −1) and `posmis == 0 ⟺ PASS`.
* Smoke tests: `SYS.c _dws,_drs` → `count-exact 143/143 PASS`, `160/160 PASS`;
  `drawc.cpp DrawC_PrimClip -v` → `count-exact 1877/1877 posmis=…` with the register-permutation
  residual listed position by position (that listing is what identified the DrawC LCS artifact
  above); `LIBMCRD.c MemCardGetDirentry` → `COUNT-INEXACT ours 153 / oracle 152 (delta +1)`;
  a bogus name → `NO ORACLE`.

---

## PROCESS NOTES (for the orchestrator)

* **Shared working copy is live.** During this belt `drawc.cpp` went `DrawC_Prim` FAIL→PASS and
  `LIBMCRD.c` `MemCardDeleteFile` FAIL→PASS under me, and `LIBMCRD.c` / `draww.cpp` each failed to
  compile once mid-sweep (a file being rewritten under the read). Any tree-wide sweep needs a retry
  path for transient compile failures — `dump_streams.py` reports them by name instead of dying.
* **`tools/build.py`'s uncommitted foreign edit is untouched** (never opened for writing).
* Nothing staged, nothing committed, no memory file edited.
* New/changed files: `tools/posmis.py` (new) · `scratch/instr/apply_traces.py` (+`patch_reload_pick`)
  · `C:\Temp\nfs4-instr-cc1\apply_traces.py` (same) · `scratch/gccsrc/gcc-2.8.1/reload1.c` and
  `C:\Temp\gccsrc\gcc-2.8.1\reload1.c` (instrumented) · `scratch/gccbuild-ecoff/cc1.exe` (rebuilt,
  codegen-neutral) · `scratchpad/w75/a20/*` (traces, sweeps, probes, protected cc1 copy).
* ⚠️ **Un-scripted instrumentation in the tree:** the source tree also carries a hand-added
  `[reload-order]` trace (`hard_reg_n_uses` / `regs_explicitly_used` per reg, at the end of
  `order_regs_for_reload`) that is **not** in `apply_traces.py` — a from-scratch rebuild after
  deleting `scratch/gccsrc` would silently lose it. Worth folding into `apply_traces.py` next time
  someone touches the lab.
