# W75-A19 — syslib/eaclib tail belt + the board-accounting task

Repo `C:\Temp\nfs4-decomp`, 2026-08-23. Memory dir read-only, nothing committed/staged.
Step-0 reads done in full (MIPS ISA ref, methodology, catalog tail §W48→W66, BRIEF).

## HEADLINE

| target | baseline | final | verdict |
|---|---|---|---|
| `_pad_getbyte` (syslib/psx/libpad/PADPORTD) | **PASS 47/47** (board stale) | PASS 47/47 **+ word-exact** | 🟢 board blind spot found + FIXED (99.89% → will read 100%) |
| `intarcsin` (eaclib/psx/eacpsxz/asinfunc) | FAIL 2 @48/48 | FAIL 2 @48/48 | no landing; **the 5-wave named angle was RUN** and the residual is re-stated |
| `iSNDpsxmalloc` (eaclib/psx/sndpsxz/sdmemman) | FAIL 12 @127/127 | FAIL 12 @127/127 | no landing; **cluster (iii) re-diagnosed from the object**, 2 standing readings corrected |
| `firstfile` (syslib/psx/libapi/FIRST) — ACCOUNTING | PASS 103/103, board 94.17% | PASS 103/103 **+ word-exact** | 🟢 root cause found + FIXED |

**Zero PASS→FAIL anywhere.** Every TU touched gated twice. Two build.py landings, both
tool-side, neither weakens the gate.

---

## 1. THE ACCOUNTING TASK — answered, and it was NOT an accounting bug

**Question asked:** does `update_match_progress` build base objects through a different path?
does objdiff fuzzy-match penalise something representational?
**Answer: no, and no.** `tools/update_match_progress.py` runs `tools/build.py` then
`objdiff-cli report generate` over `objdiff.json`, whose `base_path` for every unit is the
same `build/recon/**.o` that `tools/verify_asm.py` produces via `build.compile_c` /
`compile_cpp`. RAW40, TEXT_MOVES, epilogue-unfill etc. apply to both **by construction**
(re-confirms W64-16A/A21). Control: the *other* RAW40-spliced function `_padInitDirSeq`
reads **100.00%** on the board.

So both sub-100 gate-PASS rows were **real byte differences the GATE is blind to**:

### 1a. `firstfile` 94.17% — `move` assembled as `or`, not `addu` (catalog 04M's named gap)
```
ours    00809025  move s2,a0      = or   rd,rs,$0   (0x25)
retail  00809021  move s2,a0      = addu rd,rs,$0   (0x21)      x10 words
```
maspsx rewrites `move` → `addu rD,rS,$zero` on every normal-lane object
(`tools/maspsx/maspsx/__init__.py::expand_move`), and `_compile_c_272` does the same
textually via `_MOVE_RE` — but `compile_c`'s **raw40 branch feeds the PsyQ-4.0 cc1's raw
text straight to GNU as**, which spells the `move` pseudo as `or`.
The gate cannot see it: verify_asm normalizes `move r,r2` ↔ `addu r,r2,zero` in *both*
directions, and objdump prints the `or` encoding as `move` too — the two streams are
textually identical.
**FIX (tools/build.py, raw40 branch):** apply the existing `_MOVE_RE` rewrite to the spliced
region, i.e. exactly the pass maspsx and the 272 lane already run — this is catalog 04M's
literal "pipeline needs a move→addu pass" item, finally wired.
**Receipts:** objdump word-compare `firstfile` 10 differing → **0**; `firstfile` PASS 103/103
and `_first_patch` PASS 64/64; TU 2/2 PASS **twice**; PADSEQD (the other raw40 TU) 5/5 PASS,
`_padInitDirSeq` 0 differing (unaffected — it contains no `move`).

### 1b. `_pad_getbyte` 99.89% — one `j` word (the class-d branch blind spot)
Ours: the `M` arm's `j` targets the **default** arm's copy of the shared `lbu $2,0($2)` tail.
Retail: it targets **case 0's** copy. Both copies exist in both objects and both continue to
the same `jr $ra`; verify_asm normalizes every branch target to `T`, so the gate reads PASS.
**Why no source form reaches it (new):** case 0 carries the W71-A15 read-only fence *between*
its `lbu` and its `return` — the device that won 5 → PASS. An `__asm__` with no outputs is
implicitly volatile, and `find_cross_jump` (jump.c:2632-35) refuses a volatile `ASM_OPERANDS`,
so `M` can *never* merge onto case 0's copy and takes the default's instead. Measured:
giving the DEFAULT arm the same read-only fence blocks that merge too (3 diffs @50 insns,
i.e. +3 insns) rather than redirecting it; a void `"i"(0)` fence there is inert (PASS, still
1 word off).
**FIX:** one `PER_FN_BRANCH_RETARGET` row (W66-18A mechanism — plants a fresh label at case
0's `lbu`, re-points only the `M` arm's `j`, **removes nothing**, so it is not the
`drop_after` HeliCam class).
**Receipts:** word-compare 1 differing → **0**; `_pad_getbyte` PASS 47/47; TU 8/8 PASS
**twice**; `tools/brdist.py` on the TU = 8 fns, **0 branch-offset divergence** (the 17C
pairing requirement).

### 1c. The honest open list → `scratchpad/w75/a19_honest_board.md`
All 53 sub-100% board rows gated with verify_asm (`scratchpad/w75/a19/honest_scan.py`).
**10 gate PASS, 43 genuinely open.** Of the 10: `firstfile` + `_pad_getbyte` were the two
blind spots above (both now word-exact); the other 8 are **board staleness** — peers land
seals continuously and `MATCH_PROGRESS.txt` only moves when `update_match_progress.py` is
re-run. ⚠️ On the first pass 6 `game/psx/draww` rows could not be gated at all: a concurrent
session had `recon/game/psx/draww.cpp` mid-edit (`parse error at end of input`). The table
is from the re-run.

---

## 2. `intarcsin` — no landing; the angle 5 waves named was RUN, and it re-states the residual

Baseline re-gated **2 @48/48** (`-addu v0,a1,v0` / `+addu v0,v1,zero`, one line).

**The `-dl` receipt (fence basin, dump kept at `scratchpad/w75/a19/fb.lreg`):**
```
;; Register 99 in 3.   ;; Register 100 in 3.   ;; Register 101 in 3.
;; Register 102 in 2.  ;; Register 103 in 2.   ;; Register 105 in 2.
```
The `la` (r99 lo_sum / r100 high) and the SUM (r101) are **one local qty on $v1**; retail
wants la→$v0, sum→$v1. They are one qty because the la **dies at the add** and
`combine_regs` ties an output to a dying input.

🔑 **NEW LAW-LEVEL READING — the two basins are complementary, and the copy IS the la's
second use:**
* 2-diff basin: the source subscripts the table twice ⇒ the la is used twice, never dies at
  the first add, is never tied ⇒ it *already* has retail's $v0 and the sum retail's $v1.
  Only the COPY is missing.
* fence basin: the identity launder mints retail's copy, but the copy **replaces** the second
  subscript ⇒ the la now has exactly one use, dies at the add, gets tied ⇒ wrong colour.

⇒ The W50/W61/W71 reading "the fence basin's residual is a serving-order / self-temp
question" is **corrected**: it is a `combine_regs` tie *created by the fence itself*.

**Falsified this wave** (the zero-insn LATER-USE family — the ingredient W71-A15 named as the
one this site cannot supply, now swept properly; harnesses `asin_probe{,2,3}.py`):
`"m"(*pt)` after the loads 21@47 · `"m"(*qt)` 21@47 · `"m"` between 25@47 · both 21@47 ·
`"m"` on the plain two-subscript form 18@48 · `"r"(pt)` after 21@47 · `"r"(qt)` after 21@47 ·
named `base` + `"r"(base)` after 25@47 · + `"m"(*base)` after 25@47 · launder on a re-spelled
second address 24@48, +depth-2 6@48, launder on `pt` 28@48 · fence basin: `"r"(base)` after
30@48, `"m"(*base)` after 30@48, `"r"(base)` before 22@48, two-operand 38@48,
**`"r"(asintbl)` after the loads 9 @49** (the fence COSTS an insn — cse does *not* substitute
the live la pseudo into an asm `"r"` operand naming the array), same mid-block 26@50,
`"m"(asintbl[0])` after 30@48 (zero-insn but rotates `idx` $a1→$v1 whole-fn).
⇒ an `'m'`/`'r'` operand extends a live range but does **not** give a pseudo the SECOND DEATH
`local-alloc.c:1866` requires; it just collapses back to the 47-insn one-address form.

**NEW NEXT ANGLE (narrower than any prior one):** stop hunting a *later use* for the la —
hunt a **third reference** to the table base that is neither the copy nor a second subscript,
i.e. an RTL where the copy exists AND the la is multi-**BLOCK** (`reg_qty < 0` is satisfied by
non-locality as well as by a second death). The only multi-block candidate is the
`idx == 0x1FF` arm, whose plain form const-props (W71) — so the device must keep that arm's
`asintbl[0x1FF]` in a register without changing its emitted code.
Receipt written into `recon/eaclib/psx/eacpsxz/asinfunc.c`; TU re-gated 1/2 PASS, intarcsin 2.

---

## 3. `iSNDpsxmalloc` — no landing; cluster (iii) re-diagnosed, two standing readings corrected

Baseline re-gated **12 @127/127**, two clusters unchanged in size.

🔑 **(iii) IS NOT A SELF-TEMP TIE-BREAK AND NOT A SERVING-ORDER RACE — ours carries an EXTRA
ADDRESS PSEUDO.**
```
ours    sll a2,s0,2 | lui v1,%hi | addiu v0,v1,%lo | addu a2,a2,v0
        ... lhu v1,%lo(D_80147E34)(v1)   <- LIMIT read = DIRECT absolute load
retail  sll v0,s0,2 | lui v1,%hi | addiu v1,v1,%lo | addu a2,v0,v1
        ... lhu v1,0(v1)                 <- LIMIT read goes THROUGH pv, no reloc
```
`pv[0]` is a CONSTANT address (cse knows `pv == &D_80147E34`), so gcc folds it into a `%lo`
displacement off the **shared `%hi`**. That gives the `%hi` pseudo TWO uses, so it cannot tie
to the `lo_sum` (no self-temp) and **three** address pseudos are live at the add — which is
what pushes `off` out of $v0 into $a2. Retail's `%hi` has ONE use, ties, and only two are
live. ⇒ the lever is "stop the constant-address fold on the LIMIT read", not "dial `off`'s
serving order" (W72 already proved that runs the wrong way) and not "attack the self-temp"
(the self-temp is the consequence, not the cause).

**The launder REACHES it structurally — and its 2-insn price is not what W71 recorded.**
`__asm__("" : "=r"(pv) : "0"(pv))` makes pv opaque, the fold disappears, and the block takes
retail's exact SHAPE: `lui a1 / addiu a1,a1,0 / addu v0,a1,v0 / lhu v1,0(v0) / lhu v0,2(v0) /
… / lhu v0,0(a1)` — one la pseudo, limit read at displacement 0. It gates 30 @125. The
missing 2 are **not** the cross_jump merge of the `addiu $a0/$a1,$sp` pair the W71 receipt
blames: the side-by-side shows the loop-bottom `bnez` losing its delay-slot fill (ours `nop`,
retail `sll v0,s0,2`) and scan_done carrying ONE `sll` where retail carries TWO. That is
13B / `reorg.c:685-712` `stop_search_p` returning 1 at ANY asm — the launder stands between
the branch and the filler. A fence can BLOCK slot theft, never supply it.

**Falsified (all in the 12-diff basin; harnesses `snd_probe{,2,3,4}.py`):**
* volatile route to the fold: `*(volatile unsigned short *)pv` 12 (inert) · `((volatile …)pv)[0]`
  12 · volatile + index-first sum 12 · limit-read-first volatile 28@129, plain 27@128 ·
  limit via `prev - off` 33@126. **Reason: the fold is address LEGITIMIZATION of a constant
  address, not a cse/combine rewrite, so `MEM_VOLATILE_P` is never consulted.**
* launder + `do{}while(0)` depth ladder 0/1/2/3/4/5 on the pv def = **30 @125 at EVERY rung**
  (the launder saturates the ref dial; per 04Z the kept depth-3 is inert once it is present).
* launder + void fence `"i"(0)`: block head 30@125, mid 30@125, before the limit read 31@126,
  block tail 30 @**129** (overshoots by 4) · void fence alone, no launder 24@127 · launder
  before vs after the wrapper both 30@125 · launder after the sum 30@125, immediately before
  the limit read 29@126, +depth-3 33@126 · launder on a second alias 33@126 · on the limit
  alias only 33@126.

**NEW NEXT ANGLE:** (iii) needs a zero-insn way to make `pv` non-constant that does **not sit
between the loop-bottom branch and scan_done's first insn** — either an opaque def placed
OUTSIDE the block (pv hoisted above the scan loop so reorg's scan range is clean), or a
PER_FN mechanism (TEXT_MOVES) that restores the stolen `sll` after the launder lands.
(ii) is unchanged from the W74 reading. Receipt written into
`recon/eaclib/psx/sndpsxz/sdmemman.c`; TU re-gated 2/3 PASS, iSNDpsxmalloc 12.

---

## 4. build.py rows added (both probe-verified, both preserve the foreign edits)

`tools/build.py` already carried peer edits at pickup (W75-A16's INTR 2.6.3 `cc1_ver` row,
W75-A14's SPRINTF slot-row removal, and the earlier psxcontroller row removal). **All
preserved** — verified by re-reading the file immediately before each edit and by inspecting
`git diff tools/build.py` afterwards. `ast.parse` clean after every write.

1. **raw40 `move`→`addu` pass** (in `compile_c`'s raw40 branch, right after
   `_uniquify_local_labels`): `fr = _MOVE_RE.sub(lambda m: "\taddu\t%s,%s,$0" % …, fr)`.
   Not a new mechanism — it is the same rewrite maspsx and `_compile_c_272` already apply;
   the raw40 branch was the one path that skipped it.
2. **`PER_FN_BRANCH_RETARGET` row** for `recon/syslib/psx/libpad/PADPORTD.c::_pad_getbyte`
   (anchors label-agnostic `$L\d+`, both lookahead-pinned, match counts asserted ==1 by the
   mechanism itself; brdist-paired as 17C requires).

## 5. Tools / scratch left behind (all untracked, under `scratchpad/w75/a19/`)

`honest_scan.py` (board-row gate sweep) · `objdiff_fn.py` (address-agnostic, reloc-field-zeroing
word diff of one function ours-vs-expected — the cheap detector for the gate's branch-word and
`or`-vs-`addu` blind spots; **promotion candidate**) · `brprobe.py` (in-memory
`PER_FN_BRANCH_RETARGET` probe that loads verify_asm's SOURCE and swaps only the build-module
load — the 12H anti-drift pattern; **promotion candidate**) · `asin_probe{,2,3}.py`,
`asin_dl.py`, `fb.lreg` · `snd_probe{,2,3,4}.py`, `snd_sbs_*.txt` · `pad_probe.py` ·
`brdist_padportd.txt` · per-file `.bak` backups (all three sources verified restored
byte-identical after probing).
