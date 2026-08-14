# W60-A5 RESUME (2026-08-14) — the 06E funnel class SOLVED, +2 seals

(Continuation of `RECEIPTS.md`; kept as a separate file only because a heredoc
append tripped the shell — same wave, same agent.)

Re-baselined after the HEAD move; every number below re-gated by me, with
`${PIPESTATUS[0]}` checked on every gate (the pipe-swallows-the-exit-code rule
learned in the first half).

## Ledger (resume half)

| TU / fn | before | after | lever |
|---|---|---|---|
| libmath/MULSF3 `__mulsf3` | 8 | **PASS 80/80** | funnel into `a1` + err arm via the named 3rd partial product |
| libmath/DIVSF3 `__divsf3` | 14 | **PASS 81/81** | funnel into `a1` + err arm via dead `v9` + default-first & void fence |
| libc/SPRINTF `sprintf` | 60 | **56** | rage-racer idiom: flag constants after the zero-trip guard |
| libmath/MULDF3 | 12 / 14 | 12 / 14 | 8-rung ladder re-measured, no rung wins (+ a stale figure corrected) |

Belt state: **libmath 15/18 TUs fully PASS, libc 25/27**, 0 PASS→FAIL.
A5 wave total: **+3 PASS** (bsearch, `__mulsf3`, `__divsf3`), **−63 diffs**,
3 intra-TU order inversions cleared, 1 build.py mechanism.

## (1) The 06E "non-propagated reg-reg copy" class — SOLVED, and it was never an instrument gap

I did not need the qtytrace / instrumented-cc1 lane: **FLTSISF (already PASS) had
recorded the cure and nobody had transferred it.** Its W55-A4 note says the fix
must "reuse an EXISTING pseudo whose register is the target" and that "any fresh
result pseudo re-colors the head and snaps back". Generalised, the law has TWO
application points and both are needed:

**LAW (catalog candidate) — THE DEAD-PSEUDO STAGING LAW.**
When retail carries a value through a register you cannot reach, do not add a
variable: find the *existing* variable whose register that is (read it off the
oracle's earlier uses) and assign into it.

* at the **funnel** (the fn's single result): retail's result register is the
  FIRST PARAMETER's own register in both fns — `$t0` in `__mulsf3`
  (`addu $t0,$a0,$zero` in the head, rebuilt in place by `or $t0,$v1,$a0`) and
  `$a2` in `__divsf3`. Assign the result into the `a1` variable.
* at **each arm's staging point** (retail's extra `addu dest,$a0,$zero`): the
  staging register belongs to a value that is DEAD by then — `__divsf3`'s
  quotient `v9` (`addu $a0,$zero,$zero` at the loop head, `and $a0,$a0,$v0` at
  the mask); `__mulsf3`'s third partial product `(a2 & 0xFF) * ha`.
* **COUPLING:** when that staging value is ANONYMOUS in our source (mulsf3), the
  fix is a coupled landing — naming it ALONE regresses (9); naming it AND using
  it as the carrier PASSes. Land the pair or neither.

Full candidate sweeps (each whole-TU gated):

* `__mulsf3` funnel: a1 5 | prod 9 | exp 9 | sign 23 | a2 41
* `__mulsf3` err carrier: **p3 PASS** | a2 6 | prod 6 | exp 12 | e 14 | hb 52 |
  ha 60 | eb 76 | ea 78; the OTHER partial (p2) 22; void-tail fence 5;
  default-then-override 5
* `__divsf3` funnel: a1 8 | v9 10 | a2 12 | v3 12 | v4 26; the old v13 funnel 14
* `__divsf3` err carrier: **v9 3** | v3 9 | v2 9 | a2 9 | n 67
* `__divsf3` degenerate arm (3 → 0): retail materializes the DEFAULT constant
  before the sign test and leaves the `beqz` slot EMPTY. default-then-override
  alone is inert (3, measured in two basins); the **zero-insn VOID-TAIL FENCE
  between the default and the test** is what bounds reorg's backward scan (06B)
  and reproduces retail's `nop`. Placements: between default and test **0** |
  before the test 3 | inside arm A 3 | before return B 7.

The class had three members and is now **3/3 PASS** (FLTSISF, MULSF3, DIVSF3).
Route for anyone hitting it again: read the oracle for WHICH existing pseudo owns
the register; do not reach for the allocator instruments first.

## (2) SPRINTF 60 → 56 — the rage-racer idiom oracle

`C:\Temp\rage-racer-decomp\src\main\PAL\lib\libc\sprintf.c` (a 100%-matched
PSY-Q libc sprintf) assigns the flag-character constants AFTER the early-exit
test:

    c = *format; length = 0;
    if (c == 0) goto finished;
    minus = '-'; plus = '+';

That is exactly retail's prologue — `beqz` with `written = 0` in its delay slot,
then the four `li` constants — while our function-scope
`register int flagZero = '0';` initializer emitted its `li s3,48` FIRST, ahead of
the three LICM-hoisted literals. Splitting decl from init and assigning behind an
explicit guard puts it in the preheader with them. **60 → 56.**

Measured: guard + flagZero-after **56** | RR's full head/tail (guard +
`do { ... } while (++f, (ch = *f) != 0)`) 56 (the do/while half is gate-neutral,
so only the guard was taken) | RR head alone 60. RR's OTHER placement —
`zeroFlag = '0';` inside the loop body per conversion — is **re-falsified in this
basin**: 186 as a statement, 187 folded into the compare (the standing receipt
had 303 in the 174-diff basin: same verdict, new basin, 04Z).

Checked and NOT a difference: RR declares its template
`extern LibcFormatSpec g_LibcDefaultFormat;` — a plain scalar struct extern, same
as ours — so the remaining self-temp-vs-separate-temp `%hi` class on the 3-word
template copy is not a declaration-shape question there either.
Remaining 56 = that `%hi` self-temp class (the in-source note's
`-mno-split-addresses` = 49 @546/545, +1 insn, an orchestrator call) plus the
format-pointer base-reuse cluster (4 spellings already measured identical).

**Corpus survey for the rest of the belt** (all read-only, nothing edited):
`parasite-eve-2-decomp/lib/libmath/*.o` ships Sony's soft-float as **prebuilt
objects, no C** — independent third-party confirmation of the W52-A4
"libmath = Sony vendor object" identity; no repo in `C:\Temp\ps1-decomp-refs`
carries matched `__mulsf3`/`__divdf3`-class C.
`tenchu-decomp/src/main.exe/AdtVsprintf.c` is a caller-side vsprintf shim, but
its matching note — "a shared result local survives both calls, adds a fifth
saved register" — is the same funnel law seen from another project.

## (3) MULDF3 rung ladder — re-measured, no wiring

Re-ran all 8 rungs through my splice after the `_cc1_flags_for_rung` landing (a
no-op for this TU — it carries no `-mno-split-addresses`):

    default 14 | 2.8.1-splice 14 | 2.7.2 19 |
    2.6.0 / 2.6.3 / 2.7.2-970404 / 2.8.0 21 | 2.95.2 80 | 2.91.66 86

with `__muldf3` invariant at 12 across every rung. **Correction landed:** my
first-pass note had 2.8.0 as 14; it is 21. Only the 2.8.1 rung (= the TU's own
cc1) reproduces the default — precisely the mechanism's identity check, so the
correction strengthens it. No rung beats 14, so the entry stays commented out.

`__muldf3`'s residual is the 11B arg-emission order at 5 call sites (retail loads
`a3` before `a1`/`a2`). Falsified: making the `w0` arg a bare pseudo via a named
temp 16 | that plus the same at the `bm` site 18 | reusing `ah` 111 | `al` 72 |
`e` 85. The bare-pseudo reading of 11B does not reach it here.

## Notes for the fleet

* `tools/tugate.py` **crashes** (`AttributeError: module 'va' has no attribute
  '_name2addr'`) when the TU fails to compile — a probe harness must read the
  exit code, not the text. Mine does; the earlier `&&`-through-a-pipe incident is
  exactly this failure mode.
* `build.py --skip-asm` currently reports
  `SKIP recon\game\common\aistate.cpp: recon/nfs4_types.h:4569: parse error at
  null character` — a **raw NUL byte in the shared, user-live header** (the
  heredoc hazard firing in a file I must not touch). Not mine; flagging it.
* `scratchpad/w60a5/vprobe_all.py` added: the replace-ALL sibling of `vprobe.py`,
  with an expected-occurrence-count assert, for multi-site call rewrites.
