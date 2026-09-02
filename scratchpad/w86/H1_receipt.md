# W86-H1 receipt — JPN regional `__15tGlobalMenuDefs` (femenudefs) — **SEALED**

Row: `MANIFEST.tsv:175` CHANGED / JPN / `frontend/common/femenudefs` /
candidate `regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp`.

```
python regiondiff/tools/verify_region.py JPN \
  regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp \
  __15tGlobalMenuDefs --lane-as=recon/frontend/common/femenudefs.cpp
  __15tGlobalMenuDefs: REGION-PASS (3197 insns) [NFS4-R-JPN]

python regiondiff/tools/verify_data.py JPN \
  regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp \
  SelectListOffOn,SelectListTrackDirection --lane-as=recon/frontend/common/femenudefs.cpp
  SelectListOffOn:          DATA-PASS (8 bytes) [NFS4-R-JPN]
  SelectListTrackDirection: DATA-PASS (8 bytes) [NFS4-R-JPN]
```

**W84 2196 → W85-M3 965 → W86-H1 0 (REGION-PASS, count-exact 3197/3197).**
The two sealed DATA rows on the same candidate re-gate green (re-run after the
code edit AND again after a concurrent base-TU write by another W86 agent).

---

## 1. HEADLINE — W85-M3's wall was a ONE-DIAL MODEL, and the model was wrong

M3 landed the row at 965 and characterised the residual precisely:

* **R1** — `menuSingleCarSelect` (+0x1250, stream index ~1074). Retail SPILLS the
  `&menuCarOptions` address; we park it in `fp` (`addiu fp,rX,8408`).
  Matched retail **iff the cse chain-object prefix `P` ≥ 22**.
* **R2** — `menuCarUpgrades` (+0x1F34, index ~1747). Retail emits the ctor's
  `addiu a0,this,7988` immediately before its `jal` (delta 1); ours 9 insns early.
  Matched retail **iff `P` ∈ [17,21]**.

Both sit after every site, the site device is additive, so M3 concluded no
configuration reaches both, and falsified that with five searches plus a
recurrence probe to P = 89. **All of that measurement is correct.** What was
wrong is the implicit premise that R1 and R2 are two thresholds on the *same*
scalar dial. They are not:

* R2 is a **cse hash-table flush phase** decision → driven by the chain-object
  count (the W76-A1 `({ ... })` dial, 4 notes + 1 deleted copy = 5 objects/site).
* R1 is an **allocno** decision (does the pseudo holding `&menuCarOptions` win a
  hard register, or get spilled) → driven by **REF COUNTS**, which the object
  dial only moves as a side effect.

Catalog **33A-1's pure-C REF INFLATOR** — unavailable when M3 ran — dials the
second axis directly, at zero bytes. With it the two windows overlap.

## 2. The landed edit (one line, pure C++)

At the `itemLocalSpeech` device site, unchanged in depth (the TU's config stays
`001111133`):

```c
- , itemLocalSpeech(0xd3, ({ &iteratorLocalSpeech; }))
+ , itemLocalSpeech(0xd3, ({ tListIterator *localSpeechIterator = &iteratorLocalSpeech;
+                            tListIterator *localSpeechIteratorRef = localSpeechIterator;
+                            (void)localSpeechIteratorRef;
+                            localSpeechIterator; }))
```

(landed on one line, with a loud in-file comment). A copy of an existing local,
plus a bare `(void)` reference to it, survives `fold()` as real RTL, is counted
by flow as a ref, and is deleted before assembly at **0 bytes**. No new site, no
new depth, no `volatile`, no `__asm__`, no pin, no post-compile move.

## 3. Measurements (index-aligned reloc-masked score, `H1_score.py`; gate confirms)

Baseline scan of the TU's own nine sites, suffix fixed `133`, reading the two
tie-break INDICATORS directly (R2 = `addiu a0,rX,7988` → `jal` distance, retail
1; R1 = presence of `addiu fp,rX,8408`, retail absent/spilled):

| prefix P | insns | frame | R2 delta | R1 | score |
|---|---|---|---|---|---|
| 0 | 3197 | 608 | 9 | fp | 1951 |
| 5 / 9 / 10 / 13 / 14 / 15 | 3198-3199 | 608 | 9 | fp | — |
| **18 / 19 / 20** | 3196 | **632** | **1** | fp | — |
| **22 … 36** | 3197 | **632** | 9 | **spilled** | 714 |
| 37 … 40 | 3198-3199 | 608 | 9 | spilled | — |

⇒ R2's window is exactly {18,19,20}; R1 flips between 20 and 22; the FEApp hoist
(frame 632) holds across both. **P = 21 was never testable**: the site costs are
`4d+1` ∈ {5,9,13} and 5a+9b+13c = 21 has no solution — the one value where the
windows could meet was outside the reachable set for the whole W84/W85 history.

Fine-device hunt at the garage carrier (`H1_fine.py`), config `001111133`:

| candidate | insns | frame | R2 | R1 | score |
|---|---|---|---|---|---|
| (none, W85 landed) | 3196 | 632 | 1 | fp | gate 965 |
| `copy1` = dead copy + `(void)` ref | **3197** | **632** | **1** | **spilled** | **25** |
| `copy2` / `copy3` (2 or 3 copies) | 3197 | 632 | 9 | spilled | 739 |
| `dead1` dead reassignment | 3196 | 632 | 1 | fp | inert |
| `inf1` `p = p | p` inflator | 3196 | 632 | 1 | fp | inert |
| `void1` repeated `(void)p` | 3196 | 632 | 1 | fp | inert |

`copy1` already satisfied BOTH tie-breaks; its 25 residual was one 27-insn hunk
around the garage carrier itself — the local price of spelling it there.

Relocating the same shape (`H1_place.py`), config `001111133`:

| site | insns | frame | R2 | R1 | score | gate |
|---|---|---|---|---|---|---|
| `itemLocalSpeech` (**landed**) | 3197 | 632 | 1 | spilled | **0** | **REGION-PASS** |
| `menuTrackOptions` arg 2 (`itemTrackDirection`) | 3197 | 632 | 1 | spilled | **0** | **REGION-PASS** |
| `menuTrackOptions` arg 3 (`itemTrackMirrored`) | 3197 | 632 | 1 | spilled | **0** | **REGION-PASS** |
| `itemDisplayPosition` (after both divergences) | 3196 | 632 | 1 | fp | inert | 965 |
| garage carrier | 3197 | 632 | 1 | spilled | 25 | — |

**Both halves of the shape are required** (each measured, each returns the whole
function to FAIL 965 / 3196 insns):

| spelling | cost |
|---|---|
| `({ T *p = E; T *q = p; (void)q; p; })` | **the device** |
| `({ T *p = E; T *q = p; q; })` (copy is the RESULT) | inert |
| `({ T *p = E; T *q = p; p; })` (no `(void)` ref) | inert |
| `({ T *p = E; T *q = E; (void)p; (void)q; p; })` (no copy) | inert |
| `({ T *p = E; p; })` (named local only) | inert |

## 4. Proof that this is a SECOND dial, not "+1 chain object"

If the inflator were merely one more chain rtx, then `P=19 with it` would behave
as `P=20 without it`. It does not:

| config | device | eff. chain P | R2 | R1 | score |
|---|---|---|---|---|---|
| `001111133` (P=20) | no | 20 | 1 | **fp** | gate 965 |
| `000112133` (P=19) | yes | 20 | 1 | **spilled** | **0** |
| `001111133` (P=20) | yes | 21 | 1 | spilled | **0** |
| `000111133` (P=15) | yes | 16 | 1 | fp | — |
| `000113133` (P=23) | yes | 24 | **9** | spilled | 714 |

R2's window moves with the object count as before; **R1's threshold drops from
22 to 19** when the ref is present. That is a ref-count effect on the allocno,
not an object-count effect — the two divergences ride different dials, which is
exactly why no configuration of one dial could reach both.

## 5. What this retires

* M3's "the `delta = 1` window does not recur up to P = 89, so no placement can
  satisfy both" — TRUE as stated *for the object dial alone*, and now moot.
* M3's named next angles 1 (a 1-4 object device kind) and 2 (a negative shift
  between +0x1250 and +0x1F34) are **not needed**; angle 3 (shorten the
  `&menuCarOptions` live range at R1) is superseded — the ref inflator moves the
  same allocno decision from a site 60 members earlier, at zero bytes.
* The 435-diff "bounded residual at stream indices 1000-1899" is gone entirely.

## 6. Rules compliance

* Files written: `regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp`
  (the candidate — **edited in place**, its W85 source edits, its nine-site
  config and its sealed `SelectListOffOn` / `SelectListTrackDirection` DATA
  initializers all preserved) and `scratchpad/w86/H1_*`.
* **No** base-tree file (`recon/**`, `src/**`, `asm/**`, `configs/**`), no
  `tools/*.py`, no `regiondiff/tools/*.py`, no MANIFEST / PROGRESS board, no
  memory file. No git. `update_region_progress.py` NOT run.
* No new device site, no new device kind, no `volatile`, no `__asm__`, no
  `register … asm("$N")` pin, no post-compile move. The added construct is
  ordinary C++ (two pointer locals and a `(void)` cast) inside a statement
  expression the TU already carried.
* Gate harness compiles from a PID-named temp copy beside the base TU and
  unlinks it in a `finally`; no stray copies remain (checked — only
  `femenudefs.{cpp,h}`, `femenudefs_externs.h`, `femenudefs_types.h`).
* Both gates re-run after a concurrent write to the base TU by another W86
  agent: still REGION-PASS / DATA-PASS ×2.

## 7. Files

| path | what |
|---|---|
| `regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp` | **the candidate, SEALED at REGION-PASS 3197/3197** |
| `scratchpad/w86/H1_lib.py` | build+gate harness; reads the CURRENT candidate as its base (so the DATA edits are never regenerated away), site/depth encode+decode |
| `scratchpad/w86/H1_score.py` | index-aligned reloc-masked scorer + the R1 / R2 / frame indicators |
| `scratchpad/w86/H1_scan.py` | prefix-sum scan reading the indicators (produced the §3 window table) |
| `scratchpad/w86/H1_fine.py` | the fine-device candidate set (found `copy1`) |
| `scratchpad/w86/H1_place.py` | per-site pricing of the shape (found the score-0 placements) |

## 8. Catalog-worthy rows (for the wave harvest)

1. **33A-1's REF INFLATOR is a SECOND DIAL, not a cheaper unit of the object
   dial.** When two divergences in one function demand incompatible values of a
   chain-object count, check whether one of them is an ALLOCNO decision
   (spill-vs-register, reload scratch) rather than a cse-phase decision: the
   inflator moves the allocno threshold (here 22 → 19) while leaving the cse
   window fixed, decoupling them. A "no configuration satisfies both" proof on
   one dial is not an impossibility proof.
2. **The exact working shape is narrow.** `({ T *p = E; T *q = p; (void)q; p; })`
   — the copy must be DEAD (result = the original) and must carry a bare `(void)`
   reference. Making the copy the result, dropping the `(void)`, or initialising
   both locals from the same address expression are ALL inert. Two copies
   overshoot (score 739).
3. **Price the site.** The identical shape scored 0 at three prefix sites, 25 at
   the garage carrier (it perturbs that carrier's own 27-insn window), and is
   inert at a site after the divergences.
4. **Check the reachable set before trusting a window analysis.** The site costs
   `4d+1` cannot express 21, so the one prefix value where both windows met was
   never sampled by the 512-subset sweep, the prefix scan, the 2-D scan, the
   125-config structured search, or the recurrence probe. When a search reports
   two disjoint windows, list which values in the gap were actually TESTED.
