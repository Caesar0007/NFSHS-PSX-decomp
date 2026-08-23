# W76-A19 — asinfunc/sdmemman tail belt + board hygiene v2

Repo `C:\Temp\nfs4-decomp`, 2026-08-23.  Step-0 reads done in full (MIPS ISA ref,
methodology, catalog §§20–24, W76 BRIEF, W75 A19 report + honest board).  Memory dir
read-only, nothing committed/staged.  All probes ran on UNTRACKED temp sibling TUs built
from `git show HEAD:` snapshots (fleet rule), deleted after every run — the two real TUs
were touched ONLY for receipt comment blocks, each gated twice after.  **Zero PASS→FAIL
anywhere.**

## HEADLINE
| target | baseline | final | verdict |
|---|---|---|---|
| `intarcsin` (eaclib/psx/eacpsxz/asinfunc) | FAIL 2 @48/48 | FAIL 2 @48/48 | no landing; W75's "third reference" angle FALSIFIED + the newly-permitted PIN ROUTE fully mapped and falsified (best 6) — floor receipt now carries a complete falsification field incl. pins |
| `iSNDpsxmalloc` (eaclib/psx/sndpsxz/sdmemman) | FAIL 12 @127/127 | FAIL 12 @127/127 | no landing; cluster (iii) now STRUCTURALLY BOUNDED (conflict, not tie-break); filler-as-input + per-fn no-split falsified |
| BOARD HYGIENE (task 3) | 44 sub-100 rows | **34 open / 10 PASS, all 10 accounted** | 9 wordcmp'd = ALL WORD-EXACT; 8 W75 staleness rows confirmed resolved; `_gpu_que_drain` reclassified genuinely open; NO new gate blind spots |

PIN-SEALED items: **none** (pins were probed per policy order but none reached a seal —
every pin variant ≥ 6 diffs, so no pin landed).

---

## 1. intarcsin — 2 @48/48, no landing; two families closed (receipt written into the TU)

Baseline re-gated 2 @48/48 twice.  Probes: `scratchpad/w76/a19/asin_probe_w76.py` +
`asin_pin*_out.txt` (12 pin variants inline).

**(a) W75's named angle ("third reference / multi-block la") FALSIFIED.**  The per-block-
assignment device — fn-scope `base` assigned in BOTH the coarse arm and the steep else arm,
giving the la `reg_qty<0` by NON-locality (catalog 24E-5's route, avoiding the W71 const-prop
trap by using the coarse arm's VARIABLE-index read) — refuses the combine_regs tie exactly as
predicted, **but the named base becomes a global allocno and rotates the whole handout**:
idx a1→v1, sign a2→a1, MULT-hi temp a3→a2.  Measured 22–25 @47/48 across all five forms
(two-subscript / pt-qt+fence / +depth-2 / no-fence / mixed).  The refusal and the rotation
are the same event: any NAMED la variable is a user var, user vars are excluded from local
qtys, and one extra allocno re-sorts global.c's handout for this function.

**(b) The PIN ROUTE (newly permitted) does NOT reach it — mandatory order satisfied first:**
receipt angle run (a), catalog ladder exhausted W16→W75, sibling corpus grepped (SH
`sfx.c` Pow2Neg interpolation = different shape/no copy; NFS3 raw + NFS4-B m2c corpus add
nothing), zero-insn families all previously receipted.  12 pin variants measured:
* `pt asm("v1")` + `qt asm("v0")` + identity fence (flat p2 / scoped p4) = **6 @48/48** —
  reproduces the fence-basin residual exactly: the la temp TIES TO THE PINNED ADDU DEST
  (qty_phys_sugg to hard $3).  Pins fix where a tie lands; they do not refuse one.
* cse DELETES a hard-reg-to-hard-reg copy between two pinned user vars (p19a, 47 insns) —
  even under pins the copy needs the identity fence.
* Every live-extension that stops the la dying at the addu costs the seal: named bs +
  read-only fence after the addu = **else-arm byte-exact** but the bs allocno rotates
  sign/idx as in (a) (p8/p9, 22); merging the hold into the qt fence also rotates frac
  (p16, 24); anonymous `"r"(asintbl)` input re-materializes the la (p17, 8 @50 — cse will
  not substitute the live la pseudo into an asm operand; re-confirms W75's fence-basin
  measurement in the pin basin).
* 🔴 **NEW LAW (5 receipts: p3/p6/p7/p19a/p19b):** an explicit `asm("v0")` register var
  whose live range OVERLAPS idx's (unavoidable for any v0-pinned la — la and idx are
  simultaneously live between the lui and the addu) rotates the global handout exactly as
  in (a); a v0 pin born AFTER idx's death (p2/p4's qt) is rotation-free.  ⇒ pin-route
  floor = 6.
* Per-fn `-mno-split-addresses` (PER_FN_NO_SPLIT_ADDRESSES lane, orchestrator's resume
  item): **36 @46/48** — falsified ($at-macro/gp forms appear).

**2-diff baseline KEPT (2 < 6).**  NEXT (named, one instrumented run): read the `-dg`/greg
dump of the p19b form and find why an explicitly-used v0 overlapping idx displaces idx from
a1 — a preferencing artifact would have a compensating ref-step dial on idx or sign, and
p19b + that dial = the seal; no dial ⇒ the floor receipt is complete INCLUDING the pin route.

## 2. iSNDpsxmalloc — 12 @127/127, no landing; cluster (iii) structurally bounded (receipt in TU)

Baseline re-gated 12 @127/127 twice.  Probes: `scratchpad/w76/a19/snd_probe_w76.py`,
`snd_run1.txt`, `s4_full.txt`.

* **FILLER-AS-INPUT falsified** (catalog 24D-4's cure aimed at W75's stop_search_p
  diagnosis): `__asm__("" : "=r"(pv) : "0"(pv), "r"(off))` so the stolen `sll` schedules
  above the asm — measured IDENTICAL to the plain launder (s4/s5+depth-3/s6 all **30 @125**).
  The uncapped diff shows the launder basin is 2 insns short AND ~5-reg recolored (la in
  $a1, tail restructured) — much farther from retail than the 12-diff baseline.
* **Per-fn `-mno-split-addresses`**: **32 @125** — falsified in this basin (the old TU-wide
  63@120 receipt was basin-stale; verdict unchanged).
* 🔴 **STRUCTURAL BOUND on (iii), new:** verify_asm normalizes the folded limit read
  (`lhu v1,%lo(D_80147E34)(v1)`) to retail's `lhu v1,0(v1)` — that line is NOT in the diff.
  The remaining 6 diff-lines exist because the fold keeps the %hi pseudo LIVE past the
  addiu (its 2nd use is the folded lhu), so the lo_sum output can never take %hi's register
  — retail's self-temp `addiu v1,v1,%lo` is unreachable **by conflict, not by tie-break**.
  Full match ⇒ kill the fold; every zero-insn route is now receipted dead (volatile views,
  launder anywhere in-block, launder hoisted pre-loop, alias/two-symbol splits (+1 lui,
  count breaks), size ladder, no-split).  Documented floor receipt; the next genuinely-new
  instrument is a cse-side trace (why fold_rtx prices re-materialization under the
  reg-copy) on the instrumented cc1.
* (ii) unchanged from the W74 reading (combine_regs tie, no later use available).

## 3. BOARD HYGIENE — honest board v2 (`scratchpad/w76/a19_honest_board_v2.md`)

* The board WAS regenerated at the W75 wave commit (52cd5920, 16:52) — the 8 W75 staleness
  rows are **all gone**, as predicted.  Six of them were wordcmp'd anyway post-commit:
  MemCardDeleteFile / __adddf3 / CD_cw / Hud_BuildMapMarkers / DrawW_BuildObjectFacets /
  DrawC_Prim — **all word-exact (0 differing)**.
* Current board: 44 sub-100 rows, all re-gated (`honest_scan_v2_raw.txt`): **34 genuinely
  open, 10 gate-PASS.**  All 10 accounted:
  - 9 wordcmp'd (Hud_Init skipped per orchestrator — explained in w76/A4_report.md):
    **ALL WORD-EXACT.  Zero new gate blind spots; zero source-side byte gaps to fix.**
  - `HighExecute__18AIHigh_BTC_Wingman` (99.82) needed normalization: the EXPECTED object
    materializes `.L8005E390`/`.L8005E448` as symbols splitting the fn + R_MIPS_PC16 on the
    branch into them; 675/675 insns, 0 word-differing.  The 0.18% deficit is the W52
    interior-alabel/fix_symsizes artifact on the EXPECTED side — a board-tool item, not a
    recon item.
* `_gpu_que_drain` (97.17) reclassified: now genuinely FAIL 6 — this is W75's
  policy-withdrawn row-reachable PASS.  `sprintf` re-entered at 99.38 (peer landings moved
  it; FAIL 25).
* `intarcsin`/`iSNDpsxmalloc` rows re-confirmed FAIL 2/12 (this belt's receipts).

## 4. Tool findings / left-behind (all untracked, `scratchpad/w76/a19/`)

* `objdiff_fn.py` (W75 promotion candidate) has 3 gaps found by use: (1) branch TEXT
  compared with objdump absolute addresses → false diffs when fn offsets differ (words
  identical); (2) stops at the next symbol → truncates fns split by materialized `.L`
  labels in expected objects; (3) R_MIPS_PC16 needs low-16 zeroing on BOTH sides.  The
  corrected comparer (word-only, `.L`-following, PC16-normalizing) is inline in this
  belt's bash transcripts; fold into the tool before promoting.
* Probe harnesses: `asin_probe_w76.py` (multi-block family), `snd_probe_w76.py`
  (filler-as-input family), pin sweeps `asin_pin*_out.txt`, full diffs `p8_full.txt`,
  `s4_full.txt`, snapshots `asinfunc_head.c`/`sdmemman_head.c`, scans
  `honest_scan_v2_raw.txt`, `wordcmp_v2.txt`.
* No build.py edits this belt (the user's uncommitted edits were left untouched; verified
  by never opening it for write).  No temp sibling TU remains in recon/** (checked after
  every run).

## 5. Falsified-angle index (do NOT re-run)
* intarcsin: multi-block/per-block base (5 forms) · pin pt/qt (flat+scoped) · pin la
  (3 scopes) · bs+fence hold (2 positions) · merged-fence hold · anonymous `"r"(asintbl)`
  input · bs-reuse-as-copy-target (±fence) · per-fn -mno-split-addresses.
* iSNDpsxmalloc: launder+filler-as-input (±depth-3) · per-fn -mno-split-addresses ·
  (inherited: volatile views, depth ladders, void fences, launder placements, alias sizes).
