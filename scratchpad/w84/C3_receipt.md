# W84-C3 — `MemCardFormat` (syslib/psx/libmcrd/LIBMCRD, FAIL 1)

**Status: FAIL 1 (36/35), unchanged — no source edit landed. Zero regressions
(whole TU re-gated, 24/26 PASS as before). The wired cell is re-proven optimal
by two INDEPENDENT new instruments, and the standing "acquisition predicate"
open item is REFUTED: the vendor compiler whose object the retail bytes ARE
does not reproduce retail either.**

Gate (authoritative, lane-aliased copy):

```
python scratchpad/w84/C3_verify.py scratchpad/w84/C3_LIBMCRD.c MemCardFormat
python scratchpad/w84/C3_verify.py scratchpad/w84/C3_LIBMCRD.c "$(cat scratchpad/w84/C3_fns.txt)"
```

Harness (catalog 30F-1 respected). `C3_verify.py` = verbatim copy of
`tools/verify_asm.py` + additions only:
* `ROOT` one level deeper; `sys.path.insert(0, ROOT/'tools')` (build.py's bare
  `import fix_symsizes`);
* **lane aliasing** — every module-level dict holding the key
  `recon/syslib/psx/libmcrd/LIBMCRD.c` gets a COPY of its value under
  `scratchpad/w84/C3_LIBMCRD.c`. `C3_VERBOSE=1` reports the three tables that
  really carry this TU: `PER_TU_FLAGS` (`cc1_272`), `PER_FN_NO_DELAYED_BRANCH`,
  `PER_FN_FLAG_SPLICE_272`;
* probe knobs, all env-gated and off by default: `C3_SKIP_TABLES` (drop a table
  from the aliasing = the other basin), `C3_TU_EXTRA` (extra PER_TU flag keys,
  merged into the ALIASED copy only), `C3_ALT_MAP` (register a retail VENDOR
  `CC1PSX.EXE` as a `cc1_alt` rung).
* **BASE CELL REPRODUCES THE LIVE NUMBER** — `FAIL 1 (ours 36 / oracle 35)` —
  checked before any other cell was read.

`scratchpad/w84/C3_LIBMCRD.c` is **byte-identical to the user-live
`recon/syslib/psx/libmcrd/LIBMCRD.c`** (`diff -q` clean). The user-live file was
never opened for writing. Probe variant lives in a separate file
(`C3_probe_globalbuf.c`).

---

## 0. Diff characterisation (the exact defect)

Sole diff row: `-nop`. Ours is ONE instruction long; every other word is in
place — all four `jal`s, the `$at` store-macro split, the whole coloring, the
epilogue.

```
oracle 800FBFF4  bnez  $v0, .L800FC048     ours 1548  bnez v0,15a0
oracle 800FBFF8   addiu $v0,$zero,0x1 <slot>  ours 154c  nop        <slot>
                                            ours 1550  li   v0,1
```

Catalog discriminator ladder: **not** redundant-move (§A), **not** return-setup
(§F/30A0 (b)), **not** the saved-reg trio (#16), **not** a dropped arg (#18).
It is a pure **delay-slot-fill** row: retail's `bnez` slot carries the constant
materialisation for `1 << chan` that our stream emits as the first instruction
of the fall-through.

### The two-basin exclusion, restated as a 2-column fingerprint

The function has exactly two slots that decide it. Reading them straight off the
object is far sharper than a diff count, and makes the exclusion visible in one
line per cell (**new reusable instrument**, `scratchpad/w84/C3_matrix.sh`):

| | oracle | dbr OFF (wired) | dbr ON |
|---|---|---|---|
| `bnez` slot | `addiu v0,zero,1` | `nop` ✗ | `li v0,1` ✓ |
| `MemCardMakeDevname` slot | `sw v1,%lo(sym)($at)` | `sw v1,…($at)` ✓ | `addiu a1,sp,16` ✗ |
| gate | — | **FAIL 1 @36/35** | FAIL 4 @35/35 |

---

## 1. Angles — every angle x its number

| # | angle | result |
|---|---|---|
| 0 | baseline, wired lane (`cc1_272` + per-fn `-fno-delayed-branch`) | **FAIL 1 (36/35)** |
| 1 | dbr-ON basin (drop the flag splice) | FAIL 4 (35/35) — count-exact, the arg/store order swap |
| 2 | **rung x dbr x split-address matrix, 32 cells** (`C3_matrix.sh`) | **no cell beats 1; no cell has BOTH slots right** — see §2 |
| 3 | flag axis on both basins: `no_schedule_insns` | 18 (on) / 15 (off) |
| 4 | `no_schedule_insns2` | 6 (on) / 7 (off) |
| 5 | `no_strength_reduce` | 4 (on) / **1** (off) — inert |
| 6 | `no_rerun_cse_after_loop` | 4 (on) / **1** (off) — inert |
| 7 | `no_builtin` | 4 (on) / **1** (off) — inert |
| 8 | `force_addr` | 22 (on) / 23 (off) |
| 9 | `g_value=4` / `g_value=8` | BUILD-ERROR on the 272 lane (known: `g>=4` crashes CC1PSX 2.7.2) |
| 10 | **vendor `CC1PSX.EXE` binaries** off the ladder, routed through the direct-GNU-as recipe: PsyQ 4.3 (`psq43/COMPILER`), PsyQ 4.5 (`psq45/BIN/WIN`) | see §3 — **both behave exactly like the 2.8 ladder rungs; neither reproduces retail** |
| 11 | source probe: file-scope buffer (make the arg materialisation ineligible) | 37 (on) / 38 (off) — gcc CSEs `&buf` into `$s0` and the arg becomes a 1-word `move a1,s0`, which is stolen just the same. FALSIFIED. |
| 12 | **real ASPSX 2.77 slot probe** (`C3_slotprobe*.s`, `psq43/PSSN/ASPSX.EXE`) | see §4 — **ASPSX does NO reordering whatsoever** |
| 13 | whole-TU lane flip to 2.8.0 / 2.8.1 / 2.8.1-sn + `no_split_addresses` | catastrophic for the TU (4-5 PASS vs 24) — the TU is definitively 2.7.2; the `MemCardFormat` tie in §2 is per-fn only |

Whole-TU re-gate, wired lane (**no regressions**): 24/26 PASS;
`MemCardFormat` FAIL 1 (36/35); `MemCardGetDirentry` FAIL 6 (152/152).

---

## 2. NEW: the residual is COMPILER-VERSION-INVARIANT (32-cell matrix)

`sh scratchpad/w84/C3_matrix.sh` — 8 compilers x {dbr ON, dbr OFF} x
{split-addresses default, `-mno-split-addresses`}:

* **dbr OFF ⇒ `bnez` slot is `nop` in ALL 16 cells.**
* **dbr ON ⇒ the `jal` slot is the arg (`addiu a1,sp,16`) or the split store
  (`sw v0,32(a2)`) in ALL 16 cells — never the `$at` macro half.**
* The pair (retail `li v0,1` + `sw …($at)`) occurs in **zero** cells.

New numbers not previously on file:

| rung | dbr OFF + `-mno-split-addresses` |
|---|---|
| 2.7.2 (wired) | **FAIL 1 (36/35)** |
| 2.8.0 | **FAIL 1 (36/35)** |
| 2.8.1 | **FAIL 1 (36/35)** |
| 2.8.1-sn (Sony PsyQ 4.4/4.5 retail CC1PSX) | **FAIL 1 (36/35)** |
| PsyQ 4.3 vendor CC1PSX | **FAIL 1 (36/35)** |
| PsyQ 4.5 vendor CC1PSX (WIN) | **FAIL 1 (36/35)** |

Six independent retail compilers spanning 2.7.2–2.8.1, including **two Sony
vendor binaries**, land on the identical residual with the identical single
`-nop` row. 2.6.0/2.6.3 land at 13. ⇒ the residual is owned solely by the
delayed-branch/assembler trade, not by any compiler-version choice — and the
reconstruction source is exact (29F-3's "8 @35/35 without split-addresses" was
the dbr-**ON** measurement; on dbr-OFF the same configuration TIES the wired
lane).

## 3. NEW: the acquisition predicate is REFUTED on the vendor compiler

30A0-11/12 left the door open for an unobtained retail cc1 whose reorg refuses
to steal an outgoing-argument insn into a call's delay slot. Tested directly on
**PsyQ 4.3's own `COMPILER/CC1PSX.EXE`** — the SDK whose `LIBMCRD` object the
retail bytes ARE (28A0-6) — routed through the same direct-GNU-as recipe:

```
psq43  nosplit dbr=on   FAIL 8 (35/35)   bnez=li v0,1   jal=addiu a1,sp,16
psq43  nosplit dbr=off  FAIL 1 (36/35)   bnez=nop       jal=sw v1,%lo($at)
```

**The vendor compiler steals the arg exactly like every ladder rung.** So the
missing piece is NOT a compiler we have failed to acquire from that family.

## 4. NEW: real ASPSX 2.77 does NO reordering — 28A0-5 confirmed, and it CLOSES the assembler leg

A standalone slot probe (`C3_slotprobe.s` → CRLF → `psq43/PSSN/ASPSX.EXE -q`)
carrying the same five shapes, decoded straight out of the SN `.OBJ`:

```
lui v1 / addiu v1        <- `la` macro NOT split
lw v0,0(v1) / nop        <- load delay: nop, not a swap
bne v0,0,L  / nop        <- branch slot NOT filled (the following `li v0,1` stays put)
addiu a1,sp,16
lui at / sw v1,%lo(at)   <- store macro NOT split across the jal
jal / nop                <- call slot NOT filled (the preceding `move a0,v0` NOT swapped down)
```

⇒ ASPSX inserts hazard nops and nothing else. **Retail's `sw $v1,%lo(sym)($at)`
in the call's delay slot therefore cannot have come from the assembler**, and
retail's `li $v0,1` in the branch slot cannot have come from an assembler either
(placing it there needs liveness at the branch target). Both slots come from ONE
compiler, in ONE pass.

## 5. Mechanism, re-derived from the compiler source (not inferred from bytes)

`C:/Temp/gcc-2.8.1-src/extracted/reorg.c`, `fill_simple_delay_slots` backward
scan (lines 3076–3126) — read directly, quoted here because it fixes the escape
condition exactly:

```c
mark_set_resources (insn, &set, 0, 0);          /* include_delayed_effects = 0 */
mark_referenced_resources (insn, &needed, 0);   /* => the CALL's arg USEs are NOT in `needed` */
for (trial = prev_nonnote_insn (insn); ! stop_search_p (trial, 1); ...)
    if (! insn_references_resource_p (trial, &set, 1)
        && ! insn_sets_resource_p (trial, &set, 1)
        && ! insn_sets_resource_p (trial, &needed, 1))
      { trial = try_split (...); if (eligible_for_delay (...)) { take it } }
    mark_set_resources (trial, &set, 0, 1);
    mark_referenced_resources (trial, &needed, 1);
```

`stop_search_p` stops only at 0 / CODE_LABEL / JUMP_INSN / BARRIER / SEQUENCE /
`asm`; a REFUSED trial merely accumulates and the scan continues. In
`MemCardFormat` the only insn between `addiu $a1,$sp,16` and the `jal` is the
`sw $v1,_mc_present` **macro** (length 2 ⇒ `eligible_for_delay` false), which
touches neither `$a1` nor `$sp`. So the arg is always the second trial and is
always taken.

**⇒ THE ESCAPE REQUIREMENT (named, falsifiable, complete).** To leave the call
slot empty — the only thing that lets the assembler split the store macro into
it while cc1 still fills the `bnez` — one of these must hold at reorg time:

1. an insn between the arg setup and the `jal` that **reads or writes `$a1`** —
   byte-excluded: the only candidate is the store, and retail stores `$v1`;
2. a **CODE_LABEL / JUMP_INSN / BARRIER / SEQUENCE / asm** between them —
   `asm` is banned by the wave; every surviving label vehicle costs ≥ 2
   instructions (30A0-1, and W81-A5's V2 measured the residual TRIPLING), and
   this basin is count-EXACT at 35, so any added word loses by construction;
3. an arg materialisation that is **≥ 2 words or a load** (`eligible_for_delay`
   wants `length == 1 && hazard == none`) — byte-excluded: retail's is a 1-word
   `addiu $a1,$sp,0x10`. Measured attempt: angle 11 (37/38 diffs).

## 6. What this leaves — the NEW named angle for a future wave

Given §3 (the vendor compiler steals) and §4 (the assembler reorders nothing),
retail's two slots can only be explained by a cc1 that materialises an absolute
store as **two length-1 RTL insns through the FIXED assembler temp** —
`lui $at,%hi(S)` + `sw reg,%lo(S)($at)`. Then reorg's FIRST backward trial is
the 1-word `sw`, which it takes into the call slot (leaving `lui $at` in place,
arg untouched before it), while `fill_eager_delay_slots` independently fills the
`bnez` from the fall-through. That single hypothesis reproduces retail's ENTIRE
instruction stream, including why `jal format` gets its arg in the slot two
lines later.

Name it the **`$at`-SPLIT-ADDRESS IDENTITY**. Properties that make it cheap to
rule on:

* **One-compile acceptance test for ANY candidate binary** (no gate, no wiring):
  compile the TU and `grep '\blui\t\$1,' ` / `%hi` in the cc1 `.s`. Present ⇒
  candidate; absent ⇒ rejected. Every rung on the ladder and both vendor
  binaries are rejected by this test today — `-msplit-addresses` on 2.8 uses an
  ALLOCATED pseudo (`lui a2` / `sw v0,32(a2)`, measured), never `$1`.
* It is **not** `-msplit-addresses` (measured: 25 @34/35 on 2.8.0/2.8.1/psq43,
  wrong base register), **not** `-mno-split-addresses` (macro form, measured: 8
  @35/35 dbr-ON, 1 @36/35 dbr-OFF), and **not** any `-G` setting.
* It predicts the OTHER open libmcrd/libcd `%lo`-in-slot residuals in the same
  cluster, so a single acquisition/flag find would pay across the class rather
  than for this one row.

**Do NOT delete the `PER_FN_FLAG_SPLICE_272` `-fno-delayed-branch` row for
`MemCardFormat`.** Removing it costs 1 → 4 (measured this wave), and the wired
cell remains the optimum of a now 44-cell priced space (32 rung/dbr/split cells
+ 12 flag cells) plus the two vendor-compiler cells and the real-ASPSX probe.

## 7. Files left behind (all under `scratchpad/w84/`, nothing else touched)

| file | role |
|---|---|
| `C3_LIBMCRD.c` | candidate — **byte-identical to the user-live TU** (no edit landed) |
| `C3_verify.py` | lane-aliased gate copy (+ 3 env probe knobs) |
| `C3_matrix.sh` | the 32-cell rung x dbr x split fingerprint matrix |
| `C3_fns.txt` | the 26 LIBMCRD symbols, for the no-regression re-gate |
| `C3_probe_globalbuf.c` | angle 11 probe (file-scope buffer) |
| `C3_slotprobe.s`, `C3_slotprobe_crlf.s`, `C3_slotprobe.obj` | the real-ASPSX 2.77 reorder probe (§4) |
| `C3_wired.s` | the wired-lane cc1 `.s` for `MemCardFormat` (evidence for §5) |

No git operations, no `tools/*.py` edits, no memory edits, no `volatile`, no
`__asm__`, no post-compile instruction moves, retail compilers only.
