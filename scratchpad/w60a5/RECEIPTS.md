# W60-A5 receipts — syslib libmath + libc

Gate = `python tools/verify_asm.py` / `python tools/tugate.py` (sole authority).
Diff polarity: `-` = ours, `+` = oracle.
All numbers below are re-gated by me (briefing %s were stale in both directions:
FIXDFSI "89.29%" = 6 diffs, SPRINTF "98.00%" = 60 diffs, DIVDF3 "93.72%" = 27).

## Re-gated baselines (2026-08-14, after `build.py --skip-asm`)

| TU | fn | baseline |
|---|---|---|
| libmath/MULDF3.c | `__muldf3` | 12 |
| libmath/MULDF3.c | `_mul_mant_d` | 14 |
| libmath/DIVSF3.c | `__divsf3` | 38 |
| libmath/DIVDF3.c | `__divdf3` | 27 (`_div_mant_d` PASS) |
| libmath/MULSF3.c | `__mulsf3` | 8 |
| libmath/FIXDFSI.c | `__fixdfsi` | 6 |
| libc/SPRINTF.c | `sprintf` | 60 |
| libc/BSEARCH.c | `bsearch` | 4 |
| libc/QSORT.c | both | PASS 2/2 |
| libmath/ADDDF3.c | `__adddf3` | 67 — **SKIPPED-USER-LIVE** (dirty) |
| libmath/TRUDFSF2.c | — | **SKIPPED-USER-LIVE** (dirty) |

Whole-belt sweep: libmath 12/18 TUs fully PASS, libc 24/27.

---

## PRIORITY 1 — default-lane `PER_FN_CC1_VER_SPLICE` (WIRED + VALIDATED)

**What it is.** The default-lane twin of `PER_FN_CC1_VER_SPLICE_272`, spec'd at
commit `a661dd36`. `tools/build.py`:

* table `PER_FN_CC1_VER_SPLICE = {rel_posix: {ladder_ver: {fn names}}}`
* `_apply_cc1_ver_splice(rel_posix, s_file, i_file, cc1_flags)` — recompiles the
  SAME preprocessed `.i` with a `windows-gcc-psx` ladder rung, extracts each
  named fn's `.ent … .end` region (`_extract_fn_region`), uniquifies its `$L<N>`
  labels (`_uniquify_local_labels`, shared `_SPLICE_COUNTER`), and substitutes
  it into the normal `.s` in place. The whole `.s` then goes through the normal
  maspsx route.
* called from `compile_c` immediately **before** `_apply_fn_splice` (so a fn
  listed in both tables would end up with the flag-splice region — documented,
  don't do it).
* missing rung ⇒ `_warn_alt_fallback` + skip (CI without the ladder still builds).

Distinctions (all three now exist): per-TU `cc1_ver` = whole TU, same maspsx
route · per-TU `cc1_alt` = whole TU **and** the 272 recipe (direct GNU as,
reorder mode) · `PER_FN_CC1_VER_SPLICE` = one fn, same maspsx route.

**Mechanism validation (MULDF3.c, whole-TU gate per rung).** Splicing the rung
that equals the TU's own cc1 (`2.8.1`) reproduces the un-spliced build exactly
(14/12), and every other rung moves ONLY the named fn (`__muldf3` held at 12
under all eight rungs) ⇒ faithful and surgical. 2.7.2 rung accepts the default
lane's flag set (`-quiet -O2 -G4 -g1 -mgpOPT -fgnu-linker`) and emits ordinary
`.set noreorder` / `#nop` cc1 output that maspsx consumes normally.

**Adoption verdict: the spec's MULDF3 win is FALSIFIED (04Z, Nth confirmation).**
`_mul_mant_d` whole-TU ladder through the mechanism:

| rung | _mul_mant_d | __muldf3 |
|---|---|---|
| default (2.8.1) | **14** | 12 |
| 2.8.0 | 14 | 12 |
| 2.8.1 (explicit splice) | 14 | 12 |
| 2.7.2 | 19 | 12 |
| 2.7.2-970404 | 21 | 12 |
| 2.6.3 | 21 | 12 |
| 2.6.0 | 21 | 12 |
| 2.95.2 | 80 | 12 |
| 2.91.66 | 86 | 12 |

The a661dd36 spec ("_mul_mant_d wants 2.7.2") was read off the pre-landing
basin — the same commit's own 05E volatile-view + named-temp landing took
_mul_mant_d 18→14 and moved the table. No rung wins ⇒ table shipped EMPTY with
the measured ladder recorded in-source; MULDF3 stays a pure default-lane TU.

Probe driver: `scratchpad/w60a5/ladder_probe.py` (atomic temp + `os.replace`
rewrite of the rung string, `finally`-restore; build.py concurrency-safe window).

