# W84-R02 receipt — regional variant JPN, `__15tGlobalMenuDefs`

Row (`scratchpad/w84/R02_rows.tsv`, 1 row):

| function | class | region | region_va | words | unit | candidate |
|---|---|---|---|---|---|---|
| `__15tGlobalMenuDefs` | CHANGED | JPN | 8002E14C | 3197 | frontend/common/femenudefs | `regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp` |

Gate command (used for every number in this receipt):

```
python regiondiff/tools/verify_region.py JPN \
  regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp \
  __15tGlobalMenuDefs --lane-as=recon/frontend/common/femenudefs.cpp
```

## STATUS

**FAIL 2196 diffs (ours 3207 / oracle 3197)** — down from **3746** on the unedited
seed (-41%), instruction count 3207 vs the oracle's 3197 (was 3207 seed → 3212 after
a partly-wrong first patch → **3207** after the patch was completed correctly).
`li`/immediate multiset is now **exactly equal to the oracle's**. Not REGION-PASS.
Candidate left in this best-gated state.

Progress log (every number from the gate above):

| state | diffs | ours insns | frame |
|---|---|---|---|
| unedited seed (base TU verbatim) | 3746 | 3207 | 640 |
| + 176 regional constant replacements | 2853 | 3212 | 640 |
| …best of the 512-subset device sweep | 2205 | 3212 | 616 |
| + 8 CSE-hidden constants found and fixed | 3322 | **3207** | 640 |
| …best of the re-run device sweep (**landed**) | **2196** | **3207** | 616 |

## MEASURE FIRST — unedited seed

Seed = verbatim copy of `recon/frontend/common/femenudefs.cpp` → `FAIL 3746 diffs
(ours 3207 / oracle 3197)`.

Context that changes the whole framing of this row: **the base function PASSes in the
main project** — `python tools/verify_asm.py recon/frontend/common/femenudefs.cpp
__15tGlobalMenuDefs` → `PASS (3207 insns)`. (The TU's own in-file receipt trail stops
at "1138 / 932" and is STALE — a later wave sealed it. Do not trust that comment
block's headline numbers.) So the seed's 3746 is 100% regional delta, not our residual,
and REGION-PASS is reachable in principle.

## THE REGIONAL DELTA — fully characterised (the row's main product)

Three oracles normalised through one shared normaliser (`scratchpad/w84/R02_norm.py`)
and compared **oracle-to-oracle**, so our own codegen never enters the analysis:
base `asm/nonmatchings/front/__15tGlobalMenuDefs.s` (3207), `oracles/NFS4-R-USA/…`
(3207), `oracles/NFS4-R-JPN/…` (3197).

### 1. Structure is IDENTICAL in all three — nothing added, removed or reordered

* `jal` count 254 == 254 == 254, and the **canonicalised callee sequence** (each
  distinct target mapped to a first-appearance index) is identical across
  base/USA/JPN, 27 distinct callees → the 254 sub-object constructions are the same
  members in the same order.
* **`tGlobalMenuDefs` has the SAME LAYOUT in every region.** A register-provenance
  trace (`R02_this.py` / `R02_map.py`: tracks which register currently holds
  `lw rX,<framespill>(sp)` = `this`) extracts 260 `addiu rD,this,K` sites per stream;
  the **260-long offset sequence is byte-identical** in base, USA and JPN (247 distinct
  offsets, same order). ⚠️ A naive difflib pass over the raw streams suggests a
  532/952-byte layout shift — that is mis-alignment noise on `%lo` globals. FALSIFIED;
  do not re-derive it.

### 2. USA regional == JPN regional at the SOURCE level

`li`/`addiu rD,zero,K` value sequences (489 sites in every stream): BASE→USA is 130
hunks (essentially all `+1`); **USA→JPN is 2 hunks, and both are one `4100` moving one
slot in the schedule — no constant differs between USA and JPN.** So the JPN regional
source delta IS the USA regional source delta, and the residual USA↔JPN difference
(-10 insns, frame 640→632, `addu` -1 / `lw` -5 / `sw` -4, localised in ~6 short hunks)
is a pure allocator/scheduler difference between two retail builds of the same source.
That is the part this row cannot spell (see "the wall" below).

### 3. The source delta = "every text/string ID +1", plus exactly 2 flag words

Per-call constant extraction (`R02_calls.py`: split each stream into the 255 blocks
delimited by the 254 `jal`s — the call sequence is identical, so block *i* is the same
construction in every region) gives **175 calls whose constant multiset differs**
between base and JPN. Every one is `+1` on that member's **text/string ID** argument,
except:

| member | base | JPN | note |
|---|---|---|---|
| `menuTrophyInfo` | `0x4000` | `0x4010` | menu FLAGS word (+0x10), not a text id |
| `menuGoToCarDealer` | `0x1200` | `0x2200` | menu FLAGS word (+0x1000) |

Interpretation: the retail (later) text table gained **one string at or below id 90**,
so every id from 90 up shifts by one. Positions/heights (10, 30, 40, 46, 58, 0xf0 …),
`-1` sentinels, and the flag words (0x1000/0x1004/0x1010/0x1014/0x1020/0x1400/0x1600/
0x1a00/0x2240/0x4000/0x8000) are unchanged apart from the two rows above.
`menuShowroom` keeps `0x4000` — only `menuTrophyInfo` of the two 0x4000 sites moves.

Call→source mapping was mechanical, not by eye: `R02_map.py` re-runs the provenance
trace with each `jal`'s delay-slot instruction hoisted above it and records `a0`'s
this-offset at every call; that offset is matched against the `/* +0xNNN */` breadcrumb
on each of the 249 initializer-list entries. 155 of 175 rows resolve by offset; the
other 20 (menus whose `a0` comes from a spill slot) resolve by a forward-ordered
literal-multiset match. Result: **176 replacements over 175 lines, 0 ambiguous, 0
unresolved, monotone in source order** (`scratchpad/w84/R02_plan.json`).

### 4. 🔴 THE TRAP THAT COST 5 INSTRUCTIONS — CSE-SHARED CONSTANTS ARE INVISIBLE TO A PER-CALL AUDIT

A per-`jal` constant audit can only see constants that are **materialised inside that
call's block**. When two initializer entries pass the *same* text id and land in the
same cse window, gcc materialises **one** `li` and the second call block contains
none — so the audit reports only ONE site and the patch changes only ONE of the two
source literals. The result compiles, keeps the same `jal` sequence, and is silently
wrong: the two entries now disagree, the constant can no longer be shared, and the
build emits an **extra `li` per broken pair** (+5 instructions here, 3207→3212).

Detection and repair (reusable):
1. Recover the **per-class text-id ARGUMENT INDEX** from the sites the audit did find —
   here arg 0 for every `tMenuItem*`/`tBlank*`/`tInsideBox*`/`tMemoryCardMenuItem`/
   `tUserNameMenuItem` class, and arg **5** for `tMenuNFS4` / `tMenuNFS4TwoPlayer` /
   `tMenuOptions` / `tOptionsMenu` (arg 0 of those is the FLAGS word).
2. Re-scan **every** initializer entry of a class with a known text-id index and flag
   the ones the patch left untouched.
3. Confirm nothing is missed in classes the audit never touched — here
   `tInsideBoxMenu` / `tInsideBoxSongMenu` / `tMenuNFS4Bottom` / all `tListIterator*`
   carry `0` or `-1` in that slot, i.e. no text id. Clean.

The 8 CSE-hidden literals this found (all landed):

| member | arg | base | JPN | shared with |
|---|---|---|---|---|
| `menuTestDriveTrackSelect` | 5 | `200` | `201` | `menuSingleTrackSelect` |
| `menuPostCarGarage` | 5 | `0x8f` | `0x90` | `menuCarGarage` |
| `menuCarOptionsPlayerOne` | 5 | `0xbb` | `0xbc` | `menuCarOptions` |
| `menuCarOptionsPlayerTwo` | 5 | `0xbb` | `0xbc` | `menuCarOptions` |
| `menuPinkSlipCarOptionsPlayerOne` | 5 | `0xbb` | `0xbc` | `menuCarOptions` |
| `menuPinkSlipCarOptionsPlayerTwo` | 5 | `0xbb` | `0xbc` | `menuCarOptions` |
| `menuTournamentStandings` | 5 | `0x2f4` | `0x2f5` | `menuPinkSlipStandings` |
| `menuTournamentFinished` | 5 | `0x2f4` | `0x2f5` | `menuPinkSlipStandings` |

**PROOF THE ARGUMENT SET IS NOW COMPLETE:** after these 8, the full `li` value
multiset of our object is **identical to the JPN oracle's** (every value, every count;
`143/144/145/186/187/200/201/756/757/16384/16400/4608/8704 …` all match). Total landed
source change vs the base TU: **183 literal replacements** (176 + 8, one line carrying
two) — and nothing else but the device subset below.

**⚠️ THE SAME BUG IS ALMOST CERTAINLY LIVE IN THE USA ROW** (`MANIFEST.tsv:174`,
`regiondiff/recon/NFS4-R-USA/frontend/common/femenudefs.cpp`, 3207 words): USA and JPN
share this exact constant delta, so any per-call-derived patch there needs the same
8 fixes. The finished value map is in `scratchpad/w84/R02_plan.json` + the table above.

## THE REMAINING 2196 — what it is, and the wall

With the `li` multiset exact, the whole residual is register/spill allocation. Mnemonic
multiset delta ours vs JPN oracle: `addu +8, lui +6, addiu +2, lw -4, sw -2` = **+10
instructions**, and the frame is 616 (ours) vs 632 (oracle). This is verbatim the shape
the base function's own receipts name:

* `lui +6` = the **`%hi(FEApp)` HOIST**: retail parks `%hi(FEApp)` in `$s0` across the
  last six `tListIteratorRangeIndexed` ctors and re-does only `lw v0,%lo(FEApp)($s0)`;
  we emit a fresh `lui` at each site.
* `addu +8 / lw -4 / sw -2` = the same fact seen from the other side: holding `$s0`
  DENIES it to the member-address pseudos, which forces retail to **spill** them where
  we copy. Those are exactly the missing frame slots (616 = 640 − 24 = six 4-byte
  spills short of the base frame).

In the base project this was landed **source-only** by the W79 "CSE boundary" device:
depth-1 GNU statement expressions `({ &X; })` on selected initializer arguments, each
adding 4 `NOTE_INSN_BLOCK` notes + 1 cse-deleted copy = 5 RTL chain objects and ZERO
machine instructions, which shifts gcc-2.8.1's per-basic-block 1001-chain-object
hash-table flush (`cse.c:8620-8645`) and therefore which iterators get the `$s0` anchor.

**Everything below was measured this wave on the corrected (183-literal) source.**

* **512-subset sweep of the TU's nine existing device sites** (`R02_probe.py sweep`,
  0.8 s/gate): best `001110011` = {speech, mto_dir, mto_mir, dlap, dsplit} → **2196**.
  Five distinct masks tie at 2196. Insn counts span only 3206-3209; frames only
  **616 (511 masks) and 640 (1 mask, the base's own all-nine config, 3322)**.
* **Generic device placement**, a harness that can wrap the first *address* argument of
  any of 237 initializer entries at any depth (`R02_dev.py`): note that a statement
  expression around an **integer constant is folded away with zero chain objects** —
  only address expressions carry the device. ~1600 configurations measured across three
  scans (`R02_scan1/scan2`, consecutive runs of k=1…12 devices at every 3rd/4th entry,
  seeded from the device-free, the 2196 and the frame-640 baselines):
  * **frame 632 NEVER occurs.** Observed frames are quantised to 520 / 608 / 616 / 640.
  * insn counts never reach 3197 (3206-3209, plus a degenerate 3113/frame-520 basin).
  * best generic result 2668-2778, i.e. **worse than the nine in-place sites**.
* **Greedy add-one search** from the 2196 config over all 237 entries: every single
  added device is inert or worse → 2196 is a strict local optimum (singles are inert,
  matching the base's W76 finding).
* **Depth local search** (each of the 9 sites × depth 0/1/2/3, 6 rounds to fixpoint):
  no improvement on 2196.
* Newline normalisation (the harness rewrites the file LF-only; the base TU carries
  3528 CRLF + 35 lone CR) is **codegen-neutral**: the normalise-only file gates
  3746/3207, byte-identical to the raw `cp` seed. Checked explicitly, not assumed.

**Basin note for the next wave.** The two basins are not ordered the same way under
every metric — LCS on the raw streams vs sp-blind vs sp+register-blind:

| config | gate | frame | raw | sp-blind | sp+reg-blind |
|---|---|---|---|---|---|
| `001110011` (**landed**) | 2196 | 616 | 2698 | 2020 | 1110 |
| all-nine (the base TU's own device set) | 3322 | 640 | 3678 | 3016 | **1032** |

i.e. the frame-640 basin is *structurally* the closer of the two (1032 vs 1110) and is
penalised on the gate by the uniform spill renumbering. The instruction was to leave
the best-gated state, so `001110011` is what is on disk; a wave that attacks the
`$s0`/FEApp anchor directly should probably re-seed from the all-nine config instead.

**The honest wall.** USA and JPN are the same source (proved in §2) compiled to
different allocations by two retail builds: USA/base frame 640 at 3207 insns, JPN frame
632 at 3197. We can reproduce **640** (base device set) and **616**, never 632, and no
placement or depth of the sanctioned zero-instruction device reaches 3197. Under this
wave's rules (no `volatile`, no `__asm__` outside cop0/gte, no post-compile moves, no
tool edits) the remaining lever is the same one the base function needed and that the
W72/W74 receipts solved with now-banned `"m"(FEApp)` fences: make gcc give `$s0` to the
FEApp high anchor for **some but not all** of the trailing controller iterators. A
finer chain-object dial than 5-objects-per-device (or a non-barrier ref-count dial on
the `&FEApp->fInputPlayer` arguments that does not promote a full pointer pseudo) is
the named next angle.

## RULES COMPLIANCE

* Only `regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp` was written (plus
  `scratchpad/w84/**` tooling/receipts). No base-tree file, no `tools/*.py`, no
  `regiondiff/tools/*.py`, no `MANIFEST.tsv`, no `*_PROGRESS.txt`, no memory file was
  modified. `update_region_progress.py` was NOT run. No git operations.
* The candidate adds **no** `volatile`, `__asm__`, register pin or post-compile move.
  The only non-literal edit is which of the TU's nine pre-existing GNU
  statement-expression sites are enabled — the same source-level device the base TU
  already carries and documents (W76-A1/W79).
* The base tree was left clean (no stray gate temp copies; the pre-existing `cta*` /
  `-G0` artifacts in the repo root date from Aug 14-31 and are not from this session).

## FILES

| path | what |
|---|---|
| `regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp` | **the candidate**, best-gated state (2196) |
| `scratchpad/w84/R02_best.cpp` | copy of the landed candidate |
| `scratchpad/w84/R02_pure.cpp` / `R02_full.cpp` | same constants, all devices off / all on |
| `scratchpad/w84/R02_norm.py` | shared oracle normaliser (base `.s` and regional `.s` dialects) |
| `scratchpad/w84/R02_this.py`, `R02_map.py` | this-register provenance trace → member-offset sequence, call→source-entry map |
| `scratchpad/w84/R02_calls.py` | per-`jal` block splitter + constant extractor |
| `scratchpad/w84/R02_plan.json`, `R02_map.json` | the 176 mechanical replacements + their per-call evidence |
| `scratchpad/w84/R02_streams.py` | dumps OUR normalised instruction stream (compiles through the real `build.py` lanes) |
| `scratchpad/w84/R02_probe.py` | 9-site subset sweep harness (`sweep` / `one`), reports (diffs, insns, frame) |
| `scratchpad/w84/R02_dev.py`, `R02_scan1/2.py`, `R02_greedy.py`, `R02_depth.py` | generic device placement, landscape scans, greedy + depth searches |
| `scratchpad/w84/R02_seed_diff.txt`, `R02_d1.txt`, `R02_usa_vs_jpn*.txt`, `R02_sweep.json`, `R02_scan*.json` | raw measurements |
