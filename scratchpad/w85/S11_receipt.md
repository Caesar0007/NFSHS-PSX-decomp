# W85-S11 receipt — device audit + clearing (frontend/psx + syslib libapi/libcard/libc/libgte/libpress)

Gate command for every number below (whole-TU, authoritative):

```
python tools/tugate.py <file>
python tools/verify_asm.py <file> <fn[,fn...]>    # focused single-fn read
```

## BASELINE (measured first, before touching anything)

| file | gate | `__asm__` lines | `volatile` lines |
|---|---|---|---|
| `recon/frontend/psx/movie.cpp` | **17/17 PASS** | 41 | 1 |
| `recon/frontend/psx/psxfront.cpp` | **25/25 PASS** | 10 | 13 |
| `recon/frontend/psx/memcard.c` | **21/21 PASS** | 2 | 3 |
| `recon/frontend/psx/video.cpp` | **9/9 PASS** | 1 | 0 |
| `recon/syslib/psx/2mbyte/2mbyte.c` | **4/4 PASS** | 5 | 0 |
| `recon/syslib/psx/libapi/FIRST.c` | **2/2 PASS** | 5 | 1 |
| `recon/syslib/psx/libapi/A36.c` | **1/1 PASS** | 1 | 1 |
| `recon/syslib/psx/libapi/A37.c` | **1/1 PASS** | 1 | 1 |
| `recon/syslib/psx/libapi/A39.c` | **1/1 PASS** | 2 | 0 |
| `recon/syslib/psx/libcard/PATCH.c` | **4/4 PASS** | 6 | 0 |
| `recon/syslib/psx/libcard/END.c` | **1/1 PASS** | 3 | 0 |
| `recon/syslib/psx/libcard/A74.c` | **2/2 PASS** | 2 | 0 |
| `recon/syslib/psx/libc/SPRINTF.c` | **1/1 PASS** | 4 | 1 |
| `recon/syslib/psx/libc/BSEARCH.c` | **1/1 PASS** | 1 | 0 |
| `recon/syslib/psx/libc/MEMMOVE.c` | **1/1 PASS** | 2 | 0 |
| `recon/syslib/psx/libgte/MSC02.c` | **4/4 PASS** | 6 | 0 |
| `recon/syslib/psx/libgte/PATCHGTE.c` | **2/2 PASS** | 5 | 0 |
| `recon/syslib/psx/libpress/LIBPRESS.c` | **12/12 PASS** | 0 | 18 |
| `recon/lib/bios_thunk.h` | (header, no fns) | 2 | 0 |

**109 functions, all PASS at baseline.** The IRON RULE therefore binds every
edit: any removal that cannot be re-cracked source-only is RESTORED verbatim
and receipted as KEEP-with-reason.

(sections appended per file, incrementally)

---

## 1. `recon/frontend/psx/movie.cpp` — 17/17 PASS before, **17/17 PASS after** (unchanged)

### Device census (the "41 flagged lines")

There is **no inline `__asm__` in this TU at all** and **no register pin**. All 41
`asm(` hits are **declaration asm-LABELS** (symbol spelling), in three groups:

| group | count | class | verdict |
|---|---|---|---|
| `static T x_d asm("x") __attribute__((section(".bss")))` — file-static storage forced out of `.sbss` | 20 | storage-shape (catalog §I-addendum / §E) | KEEP |
| `extern T x_v[] asm("x")` — UNSIZED-ARRAY VIEW onto the same symbol (§3.12 #5 / §3.15-CORRECTION) | 20 | storage-shape | KEEP (falsified below) |
| `static void strInit(...) asm("strInit__FP6CdlLOCiPFe_vT2")` | 1 | symbol NAME spelling (cfront mangling of a typedef'd callback param) | KEEP |

None of these emit or move an instruction; they are declaration shape, which the
oracle dictates (methodology §3.12 #5/#6, IDT Ch9's own "omit the size / give the
correct size, never a dummy 1" rule). They are outside the wave's CLEAR list.

### FALSIFIED ANGLE — collapse the dual `_d` + `_v[]` view into one sized array

Probe on `width` (the only view with an explicit non-`[0]` use, `wp = width_v;`):
replace the pair with `static int width_probe[1] __attribute__((section(".bss")));`
and use `width_probe[0]` / `width_probe`.

* result: **16/17 PASS — `strNext__FP6DECENV` regressed 0 → 11 diffs.**

The sized `[1]` folds back to the scalar address materialization exactly as the
methodology's §3.15-CORRECTION warns, even with the explicit `.bss` section
attribute (so this is not a small-data/gp question — it is the completeness of
the array type). RESTORED verbatim; the unsized view stays.

### `volatile u_long cnt;` in `strSync__FP6DECENVi` — **KEEP (semantic, oracle-proven)**

This is the only `volatile` in the TU and it is a *stack local*, so on paper it
looks like plain state. It is not: the oracle proves the re-read.

Oracle loop body (`strSync__FP6DECENVi.s` @8004D610):
```
lw    $v0, 0x0($sp)      ; read cnt
nop
addiu $v0, $v0, -0x1
sw    $v0, 0x0($sp)      ; write cnt
lw    $v0, 0x0($sp)      ; RE-READ the slot it just wrote  <-- volatile tell
nop
bnez  $v0, .L8004D670
```

Measured alternatives:

| form | gate |
|---|---|
| `volatile u_long cnt;` (as shipped) | **PASS (44/44)** |
| plain `u_long cnt;` | FAIL 31 diffs (ours 37 / oracle 44) — counter goes to a register, no frame at all |
| addressable non-volatile (`u_long cnt; u_long *cntp = &cnt;`, all accesses `*cntp`) | FAIL 21 diffs (ours **43** / oracle 44) — memory achieved, but the second `lw` is still missing (+ an `&cnt`-in-`$a1` coloring cascade) |

The address-taken form reaches memory yet is exactly one instruction short: the
store→reload pair is reproducible **only** by `volatile`. Per the GUIDE's
in-doubt rule ("if it breaks and the oracle shows real re-reads it is semantic")
this is a KEEP: the retail source declared the spin counter `volatile`.

RESTORED verbatim; file re-gated **17/17 PASS**.

---

## 2. `recon/frontend/psx/psxfront.cpp` — 25/25 PASS before, **25/25 PASS after**; **net −1 device**

### Device census (real devices only; most `volatile` grep hits are falsified-angle comments)

| line | device | class | verdict |
|---|---|---|---|
| 29 (macro `PSXFRONT_INIT_V`) | `__asm__ volatile("" : : "r"(vraw));` | output-less availability fence (CLEAR list) | **REMOVED — inert** |
| 955 | `__asm__("" : : "m"(*(short *)(prim + 8)));` | zero-byte memory INPUT = store-store ordering fence | KEEP (re-crack falsified, below) |
| 67 | `asm("AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended")` | function symbol NAME spelling | KEEP |
| 73 | `static char rendering3DEnvInit__[8] asm("rendering3DEnvironmentInitialized")` | storage shape + name (`>G4` → `.bss`/absolute) | KEEP |

No register pins, no `&&label` devices, no plain-state `volatile` in this TU.

### CLEARED — the `PSXFRONT_INIT_V` availability fence

`__asm__ volatile("" : : "r"(vraw));` was a W61-A18 **ref-step dial** (a zero-insn
extra reference to `vraw`/`v` intended to raise `v` above the colour pointer in
`allocno_compare`). Measured in the current basin:

* with the fence: `DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii` PASS (245 insns)
* **without the fence: PASS (245 insns)** — byte-identical, whole TU **25/25 PASS**

⇒ **INERT**; deleted, and the stale in-source note replaced with a
"do not reintroduce" record.

### KEPT — the x0 memory-ordering fence at the `flags & 4` arm (`DrawGouraudShape`)

Removal regresses to **FAIL 3 diffs (ours 244 / oracle 245)**:

```
  ours                 oracle
  lhu  t8,16(sp)       lhu  t8,16(sp)
  sh   s7,10(s0)  <--  nop            <-- retail leaves the reload's delay cycle empty
  addu v0,t8,t2        addu v0,t8,t2
  ...                  ...
  sh   v0,8(s0)        sh   v0,8(s0)
                       sh   s7,10(s0) <-- y0 belongs immediately AFTER x0
```

Root cause: `*(short*)(prim+8)` and `*(short*)(prim+10)` are constant offsets off
one pseudo, so gcc-2.8's `memrefs_conflict_p` proves them disjoint,
`output_dependence` is false, and the post-reload scheduler is free to hoist the
y0 `sh` into the exposed delay cycle of the `lhu t8,16(sp)` **spill reload**.

Source-only re-crack attempts, each gated:

| angle | result |
|---|---|
| (a) separate pointer local `short *py10 = (short *)(prim + 10);` used for the y0 store | **3 diffs — exactly 0 change**; cse folds it straight back to the same base+const |
| (b) write the y0 store BEFORE the x0 store | **2 diffs, count-EXACT 245/245** — the retail `nop` reappears, but y0 now lands 6 slots too early (above the reload) |
| (c) write the y0 store AFTER the x1 (`prim+0x14`) store | **2 diffs, count-EXACT 245/245** — y0 now lands 2 slots too late (below `lhu v0,16(s4)`/`addu a0,s1,a1`) |

(b) and (c) bracket the retail slot from both sides without hitting it — the
schedule position is a single memory-dependence fact, and no C spelling of two
constant offsets off one pointer can express it. RESTORED verbatim, with the
measurements written into the source comment. File re-gated **25/25 PASS**.

---

## 3. `recon/frontend/psx/memcard.c` — 21/21 PASS → **21/21 PASS**; **no devices**

A comment-stripped scan finds **zero** `__asm__`, `asm(`, `volatile`, or
`&&label` in live code. All four raw grep hits are falsified-angle history notes
inside block comments (lines 833, 1003, 1039, 1534 — e.g. a note that an
`__asm__ volatile("" : : "r"(cmd));` USE fence "sat here from 2026-08-02", i.e. a
device that has already been removed). Nothing to do.

## 4. `recon/frontend/psx/video.cpp` — 9/9 PASS → **9/9 PASS**

One device: `extern int ticks_a[] asm("ticks");` — an unsized-array VIEW of a
global (storage shape, methodology §3.12 #5). Declaration shape, emits no
instruction. KEEP. No inline asm, no pins, no `volatile`.

## 5. `recon/syslib/psx/2mbyte/2mbyte.c` — 4/4 PASS → **4/4 PASS**

Four file-scope `__asm__` blocks = the **SN Systems crt0** (`__main`,
`__SN_ENTRY_POINT`/`stup2`, `stup1`, `stup0` plus its inline `_stacktab` `.word`
island). Genuine hand-written assembly: it assigns `$sp`/`$gp`/`$fp` directly,
spills `$ra` to a fixed low-RAM cell because no stack exists yet, and embeds a
data table inside the `stup0` symbol. Not expressible in C at all — the
sanctioned hand-transcription class. KEEP (all 4).

## 6. `recon/syslib/psx/libapi/` — FIRST.c 2/2, A36/A37/A39 1/1 each → unchanged

| file | device | verdict |
|---|---|---|
| A36.c | `__asm__ __volatile__("addiu $a0,$zero,0x1\n\tsyscall 0" : : : "$4")` = BIOS `SYSCALL(1)` EnterCriticalSection | KEEP (BIOS, sanctioned) |
| A37.c | same, `SYSCALL(2)` ExitCriticalSection | KEEP (BIOS, sanctioned) |
| A39.c | file-scope `__asm__` `SetSp` — a frameless register thunk whose `$sp` write lives in the `jr $ra` delay slot | KEEP (no C form exists) |
| FIRST.c | `static char D_80148A84_storage[40] __asm__("D_80148A84")` | KEEP (storage/name) |
| FIRST.c | `__asm__(".local _first_patch\n_first_patch = func_80109F5C")` | KEEP — the sanctioned co-equal-symbol mechanism (catalog §G row 127: gcc-2.8.0 silently ignores `__attribute__((alias))`) |
| FIRST.c | `__asm__("" : : "r"(state));` inside `_first_patch`'s zero-trip guard | KEEP (measured below) |
| FIRST.c | `({ __asm__("" : : "i"(0)); strcmp(...); })` void fence in the name test | KEEP (measured below) |

### `_first_patch` fences — measured

| configuration | gate |
|---|---|
| both fences (as shipped) | **PASS 64/64** |
| both removed | FAIL **20** |
| only the void (slot-blocker) fence removed | FAIL **1** |
| NEW probe: branch-polarity inversion of the scan test (`e->dt_string == 0 \|\| strcmp(...) != 0`, arms swapped), no void fence | FAIL **10** — worse |

The `state` fence is a **+1-reference allocno-priority dial** (it restores retail's
`$s2=state` / `$s3=saved` roles that the late `saved` assignment otherwise
inverts); the void fence is a **delay-slot-theft blocker** (`reorg.c`
`stop_search_p` returns 1 at any asm) that stops our reorg stealing the
`lui $5,%hi(_first_devname)` half of the `strcmp` arg setup into the `beqz $a0`
slot retail leaves empty. Neither is expressible in C: every source-level
reference costs a real instruction (re-proved on BSEARCH in §8). RESTORED verbatim.

## 7. `recon/syslib/psx/libcard/` — PATCH.c 4/4, END.c 1/1, A74.c 2/2 → unchanged

All file-scope `__asm__`: `_patch_card`/`_patch_card2` plus the copied BIOS
**patch templates** (methodology §3.9 / §3.9b class 2), `_ExitCard` (hand-assembled
CARD.S — saves `$ra` to a fixed scratch word, inlines the BIOS `B0:0x56` fetch via
`jalr $t2`), `InitCARD2` (a BIOS tail-call **plus** an unreachable tail that is
real data: the first words `_copy_memcard_patch` copies into kernel RAM), and the
`.local` / `.section .bss` / `.space` owner-section declarations. All sanctioned.
KEEP.

## 8. `recon/syslib/psx/libc/` — SPRINTF.c 1/1, BSEARCH.c 1/1, MEMMOVE.c 1/1 → unchanged

`MEMMOVE.c`: no live device (both grep hits are comments).

### `bsearch` tail fence `__asm__("" : : "r"(lo), "r"(key), "r"(stride));` — KEEP

| configuration | gate |
|---|---|
| as shipped | **PASS 48/48** |
| fence removed | FAIL **28** (count-exact 48/48) — pure callee-saved coloring: `{key,base}` and `{n,lo}` both transpose |
| fence removed + `stride` declared before `lo` | FAIL **28** — exactly 0 change |
| fence replaced by a real tail reference (`if (lo == 0xFFFFFFFFu) return (void*)key + stride;`) | FAIL **29 @ ours 53 / oracle 48** — a source reference costs 5 instructions |

The fence buys three **zero-instruction references** at the function tail, raising
`lo`/`key`/`stride` in `allocno_compare`. C has no zero-instruction reference:
anything gcc keeps costs code, and anything free is folded away at the tree level
(`lo & 0`, `lo - lo`, `lo * 0`). RESTORED verbatim.

### `sprintf` template-copy fence `__asm__("" : : "r"(tsrc) : "$2","$3","$4");` — KEEP

| configuration | gate |
|---|---|
| as shipped | **PASS 545/545** |
| fence removed | FAIL **20** (count-exact 545/545) |

The whole residual is one register rotation around the 12-byte template copy:

```
  ours (no fence)                oracle
  lui   v0,0                     lui   a1,0
  addiu v0,v0,0                  addiu a1,a1,0
  lw    v1,0(v0)                 lw    v0,0(a1)
  lw    a0,4(v0)                 lw    v1,4(a1)
  lw    v0,8(v0)  <- reuses      lw    a0,8(a1)
                     the dead
                     address reg
  li    a3,35                    sw    v0,528(sp) ...
  sw    v1,528(sp) ...           li    v1,35
```

Retail keeps the source ADDRESS live past the third load (so it cannot be reused,
and `$v1` is free afterwards for `li 35`); ours lets it die at the third load. The
clobber list is the only thing that denies `$2/$3/$4` to the address pseudo, and
the exact set is already documented in-source as measured (`"$2"` 44,
`"$2","$3"` 40, `"$2".."$5"` 38, `"$2","$3","$4"` 28 — 20 in the current basin).
Extending the address's live range from C costs an instruction. RESTORED verbatim.

## 9. `recon/syslib/psx/libgte/` — MSC02.c 4/4, PATCHGTE.c 2/2 → unchanged

* **MSC02.c** (`VectorNormal` / `VectorNormalS` / `VectorNormalSS` + the shared
  `_VectorNormalSS_kernel`): genuine hand-assembly, and provable as such
  independently of the (noisy, catalog §I) "Handwritten function" annotation — it
  uses the **trapping non-`u` `add`/`sub`/`addi` forms that no C compiler ever
  emits** (IDT Ch9), `.set noat`, GTE `SQR`/`GPF` as raw `.word`s, a private
  `$t0-$t2` argument convention, and `$ra` parked in `$a3` with no frame. Also
  squarely inside the GUIDE's sanctioned cop2/GTE class. KEEP.
* **PATCHGTE.c** (`_patch_gte`): the GTE-hardware-bug runtime patch — spills `$ra`
  to a fixed global, calls BIOS `B0:0x56` via a raw `jalr $t2`, and
  **self-modifies** the kernel exception prologue. Sanctioned patch-template /
  BIOS class. KEEP.

## 10. `recon/syslib/psx/libpress/LIBPRESS.c` — 12/12 PASS → **12/12 PASS**; **net −1 device**

| device | class | verdict |
|---|---|---|
| 9 x `static volatile u_long *X_ptr` (D0/D1 MADR/BCR/CHCR, MDEC0, MDEC1, DPCR) | MMIO pointer cells (HW 0x1F8010xx / 0x1F8018xx) | KEEP (sanctioned MMIO) |
| `volatile u_long *p = D0_CHCR_ptr;` / `= D1_CHCR_ptr;` in `_MDEC_in_dma` / `_MDEC_out_dma` | MMIO lvalue alias | KEEP (sanctioned MMIO) |
| `volatile int n = 0x100000;` in `MDEC_in_sync` and `MDEC_out_sync` | timeout spin counter | KEEP — **oracle-proven** |
| `volatile u_long *inBuffer = (volatile u_long *)_mdec_iqtab;` in `MDEC_rest` | plain const RAM table, NOT MMIO | **REMOVED — inert** |

### CLEARED — `inBuffer`'s `volatile`

`_mdec_iqtab` is a `static const u_long[33]` quantisation table in `.rodata`, not
a device register, so the qualifier was a pure codegen crutch. Replaced with
`const u_long *inBuffer = _mdec_iqtab;`:

* before: TU **12/12 PASS** · after: TU **12/12 PASS** (`MDEC_rest` PASS 60/60)

Inert, so deleted, with a "do not reintroduce" note recorded in-source.

### KEPT — the two `volatile int n` spin counters

Removing `volatile` from both: **10/12 PASS — `MDEC_in_sync` and `MDEC_out_sync`
each regress 0 -> 30 diffs.** The oracle proves the re-read
(`MDEC_in_sync.s` @800F8D34):

```
lw    $v0, 0x10($sp)      ; read n
nop
addiu $v0, $v0, -0x1
sw    $v0, 0x10($sp)      ; write n
lw    $v0, 0x10($sp)      ; RE-READ the slot just written  <-- volatile tell
nop
bne   $v0, $a0, .L800F8D68
```

Same signature as `movie.cpp`'s `strSync` counter: the retail source declared
these timeout counters `volatile`. Semantic. KEEP.

---

# SUMMARY

**Gate: 109/109 PASS before, 109/109 PASS after. Zero regressions, zero devices added.**

## Devices removed (net -2)

| file | device | evidence |
|---|---|---|
| `recon/frontend/psx/psxfront.cpp` | `__asm__ volatile("" : : "r"(vraw));` availability fence in `PSXFRONT_INIT_V` | INERT — `DrawGouraudShape` PASS 245/245 with and without; TU 25/25 either way |
| `recon/syslib/psx/libpress/LIBPRESS.c` | `volatile` on `inBuffer` (pointer to the const `_mdec_iqtab` table, non-MMIO) | INERT — `MDEC_rest` PASS 60/60 without it; TU 12/12 |

## Devices kept, each with a measured reason

| file | device | removal cost | why it is irreducible |
|---|---|---|---|
| `movie.cpp` | `volatile u_long cnt` (strSync) | 31 diffs (43/44 with an address-taken local) | oracle has `sw 0(sp)` -> `lw 0(sp)`; only `volatile` emits the re-read |
| `LIBPRESS.c` | `volatile int n` x2 | 30 each | same store->reload proof in the oracle |
| `LIBPRESS.c` | 9 MMIO pointer cells + 2 CHCR aliases | — | device addresses (sanctioned) |
| `psxfront.cpp` | `__asm__("" : : "m"(*(short*)(prim+8)))` | 3 | the only source-expressible store-store ordering constraint; two independent reshapes reach count-exact 245/245 but bracket the retail slot (too early / too late) |
| `FIRST.c` | `__asm__("" : : "r"(state))` | 20 | zero-instruction allocno-priority reference |
| `FIRST.c` | `({ __asm__("" : : "i"(0)); ... })` | 1 | reorg delay-slot-theft blocker; polarity inversion measured 10 |
| `BSEARCH.c` | tail 3-operand fence | 28 | zero-instruction references; a real reference costs 5 insns (29 @53) |
| `SPRINTF.c` | `"$2","$3","$4"` clobber fence | 20 | denies the address pseudo the regs retail's longer live range denies it |
| `2mbyte.c` | 4 crt0 blocks | — | hand-written SN crt0 (`$sp`/`$gp`/`$fp` assignment + inline data island) |
| `libcard/{PATCH,END,A74}.c` | 6 + 3 + 2 blocks | — | BIOS patch templates (§3.9b class 2) + hand-assembled CARD.S |
| `libapi/{A36,A37,A39}.c` | 3 blocks | — | BIOS `syscall` stubs + a frameless `$sp` register thunk |
| `libgte/{MSC02,PATCHGTE}.c` | 5 + 1 blocks | — | GTE/cop2 + trapping `add`/`sub` hand-asm + self-modifying BIOS patch |
| `movie.cpp` / `video.cpp` / `psxfront.cpp` | 43 declaration `asm("name")` labels | 11 diffs when collapsed (probe) | storage shape (unsized-array views, `.bss` section forcing) and symbol spelling — no instruction emitted |

## Falsified angles (with numbers, so nobody re-spends them)

1. `movie.cpp` — collapse the dual `_d` scalar + `_v[]` unsized view into one
   `static T x[1] __attribute__((section(".bss")))`: **16/17, `strNext` 0 -> 11**.
   The sized `[1]` folds back to the scalar address materialization even with an
   explicit `.bss` attribute (methodology §3.15-CORRECTION, confirmed on a new site).
2. `movie.cpp` — address-taken non-volatile spin counter: reaches memory but is
   **exactly one instruction short** (43/44); the store->reload is volatile-only.
3. `psxfront.cpp` — pointer local for the `prim+10` store: **exactly 0 change**
   (cse refolds it to the same base+const).
4. `psxfront.cpp` — y0 store written before x0: **2 diffs, count-EXACT**, y0 lands
   6 slots too early. Written after the x1 store: **2 diffs, count-EXACT**, y0
   lands 2 slots too late.
5. `FIRST.c` — branch-polarity inversion of the `_first_patch` scan test: **10**
   (vs 1 with only the void fence dropped).
6. `BSEARCH.c` — `stride` declared before `lo`: **0 change** (28). A real tail
   reference instead of the fence: **29 @ 53 insns**.

## Notes for the orchestrator

* Nothing in this set is a `register T x asm("$N")` pin — **the assigned files
  contain zero register pins** — and nothing is a `&&label` device.
* Compiler-lane wiring untouched. For the record, the `tools/build.py` entries
  that cover this set are per-TU / per-function **compiler version and flag
  selections**, not post-compile instruction moves: `PER_TU_FLAGS` for
  `psxfront.cpp` (`g_value 0`), `MEMMOVE.c` (`cc1_alt 2.7.2-970404`),
  `BSEARCH.c` (`cc1_272` + `no_schedule_insns`), `SPRINTF.c` (`cc1_alt 2.8.0`),
  `LIBPRESS.c` (`cc1_272`); `PER_FN_NO_DELAYED_BRANCH` for
  `LIBPRESS.c {DecDCTout, MDEC_status}` and `FIRST.c {firstfile}`.
* `BSEARCH.c`'s header still describes a `PER_FN_TEXT_MOVES` schedule-relocation
  row — **that table no longer exists in `tools/build.py`**, and `bsearch` PASSes
  48/48 without it. The stale sentence is all that is left of it (left in place:
  editing `tools/*.py` and rewriting unrelated history is out of this wave's remit).
* No git operations; no edits to `tools/*.py`, boards, CI, or the memory dir.
