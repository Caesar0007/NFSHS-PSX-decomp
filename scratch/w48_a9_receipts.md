# w48-a9 — SYSLIB FLAG / IDENTITY AXIS receipts

Agent a9, wave 48. Worktree `C:/Temp/nfs4-wt48-a9`, branch `w48-a9`, base `a12f7b8b`.
Gate = `scratch/w47_a9_verify.py` (= `tools/verify_asm.py` + env flag hooks: same normalizer,
same maspsx, same GNU as ⇒ every number below IS a gate number) and, for the three landings,
the **hookless** `tools/verify_asm.py` with the flags actually wired into `tools/build.py`.
`tools/build.py` was patched in THIS WORKTREE ONLY for the wired re-gate and **reverted**
(`git status --porcelain` empty; final tree = base + `scratch/` receipts and tools).

---

## 0. HEADLINE

| # | Result |
|---|---|
| **H1** | 🏆 **`-mno-split-addresses` is syslib's flag identity — the ONLY net-positive lever in a 64-TU × 8-config sweep.** Cluster totals vs BASE: **−480 diffs, 3 FAIL→PASS, ZERO PASS regressions.** Every other config is a net loss with regressions. |
| **H2** | 🔴 **The methodology §3.25-3b hypothesis "syslib is the `-fno-delayed-branch` class" is FALSIFIED AT WHOLE-TU GRANULARITY** — cluster **+3333 diffs, 55 PASS regressions, −100 count-exact fns**. Not one syslib TU wants it. Per-FUNCTION it is near-closed too: of 293 gated fns, 28 improve on diffs but **27 of those 28 LOSE insn-count exactness** (naked nops). **Exactly one function improves on both**: `_clr_card_event`. |
| **H3** | 🔴 **`-G` is CLOSED for syslib.** ZERO `%gp_rel` in the ENTIRE syslib oracle (64 objects, 300+ functions — census `scratch/w48_a9/gpcensus.txt`), yet `-G0` costs **+2726 diffs / 23 regressions** and `-G8` is inert (**+41 / 0 / 0**). Reason: 11 syslib TUs already emulate `-G0` **per symbol** with `__attribute__((section(".bss")))`, so a whole-TU `-G0` only strips gp-rel from symbols that legitimately keep it. **DECLARATION SHAPE MASKS -G, again** (catalog w47 §C) — this time via a section attribute. |
| **H4** | 🔴 **`-O1` and both scheduler switches are dead for syslib**: `-O1` +3441/33 regr, `-fno-schedule-insns` +1310/16, `-fno-schedule-insns2` +723/31. The "Sony's -O2 prior is weak" premise is answered: **retail syslib is -O2 with schedulers ON.** |
| **H5** | **STRUCTURAL (oracle-side) corroboration for H1**: `$at` is the *assembler's* address-macro scratch and cc1 never allocates it, so `$at` in a retail body ⇒ the compiler emitted a MACRO ⇒ split-addresses OFF. Syslib is DENSE in `$at` (31 of 64 objects; drv 50 sites, BIOS 84, LIBMCRD 66, SYS 56, stcdint 88) vs the SPLIT-addresses control corpus (smemman 0, spchrule 0, memcard 0, hud 1 fn, cario 2 fns). Census `scratch/w48_a9/atcensus.txt`. |
| **H6** | 🆕 **NEW NAMED CLASS FOR a10 (60 oracle sites): "ASSEMBLER-MACRO SPLIT ACROSS A DELAY SLOT"** — `lui $at,%hi(S)` … `<jal/j/branch/jr>` … `<store> %lo(S)($at)`. This is NOT 04C's falsified "backward-fill an existing insn": both halves come from ONE macro statement, so it is a macro-EXPANSION placement question the 04C runs did not test. Census `scratch/w48_a9/macrosplit.txt`. **I did not conclude — a10's lane owns it.** |
| **H7** | **Mode-A: 263/281 syslib gated fns (93.6 %) are lab-IDENTICAL** ⇒ their residuals are **provably not SN-compiler-specific** and every stock-gcc instrument applies. The 18-fn divergent set is listed in §5 — and its enrichment is **1.03× in the size-matched band (n=18 vs 63)**, i.e. **NOT a law; declined** (same honesty call as w47-a9 §2d, weaker here). |
| **H8** | 🔴 **FLOOR-HYGIENE: the briefing's named `funcEvSp*` `.lcomm`/`-G0` floor class is STALE — `funcEvSpIOE` is already PASS (5 insns) at BASE.** Re-gate first, always. |

---

## 1. THE LADDER — 64 syslib TUs × 8 configs (512 whole-TU gate runs)

`scratch/w48_a9/ladderALL.{txt,json}`; per-TU report via `scratch/w48_a9_report.py`.
`conv` = FAIL→PASS, `regr` = PASS→FAIL, `dCNT` = change in the number of functions whose
instruction count EQUALS the oracle's (the second half of the w47 IDENTITY BAR).

| config | dDIFF | conv | regr | dCNT | verdict |
|---|---|---|---|---|---|
| **`-mno-split-addresses`** | **−480** | **3** | **0** | −3 | 🏆 the only net-positive lever |
| `-G8` | +41 | 0 | 0 | −1 | inert (G4 ≡ G8 for syslib, as for eaclib) |
| `-fno-schedule-insns2` | +723 | 0 | 31 | −33 | FALSIFIED |
| `-fno-schedule-insns` | +1310 | 0 | 16 | −15 | FALSIFIED |
| `-G0` | +2726 | 1 | 23 | +0 | FALSIFIED |
| `-fno-delayed-branch` | +3333 | 0 | 55 | −100 | FALSIFIED (see §3) |
| `-O1` | +3441 | 0 | 33 | −41 | FALSIFIED |

Option list taken verbatim from `scratch/w47_a10_receipts.md` §1 (no re-derivation);
`-funsigned-char`, `-mgpopt`, `-fno-defer-pop`, `-mgas`, `-msplit-addresses` are proven
NO-OPs and were not swept; `-mrnames` is the w47-a8 maspsx-corruption trap and was not swept.

---

## 2. `-mno-split-addresses` — the per-TU table (REPRODUCED 2×)

Round 1 = `ladderALL.json`, round 2 = `repro2.json` (independent process, same base tree).
**All 20 changed TUs reproduced EXACTLY** (`repro` column, `scratch/w48_a9/nosplit_table.txt`).
The build is deterministic, so 2× reproduction is a *consistency* check, not a noise estimate —
stated as such.

| TU | BASE P/D/CNTEX (of N) | nosplit P/D/CNTEX | dDIFF | conv | regr | repro |
|---|---|---|---|---|---|---|
| **libgpu/SYS** | 13/1957/22 (44) | **14/1743/22** | **−214** | **MoveImage** | 0 | OK |
| libmcrd/LIBMCRD | 2/1385/8 (26) | 2/1329/**5** | −56 | 0 | 0 | OK |
| **libpad/PADMAIN** | 1/667/3 (11) | **2/614/3** | **−53** | **_padSetVsyncParam** | 0 | OK |
| libetc/INTR | 7/237/8 (13) | 7/186/**10** | −51 | 0 | 0 | OK |
| libmcrd/USERFUNC | 1/59/1 (4) | 1/14/**2** | −45 | 0 | 0 | OK |
| libgpu/FONT | 0/364/0 (2) | 0/330/0 | −34 | 0 | 0 | OK |
| libmcrd/BIOS | 13/48/15 (17) | 13/**20**/15 | −28 | 0 | 0 | OK |
| libapi/FIRST | 0/100/2 (2) | 0/78/**1** | −22 | 0 | 0 | OK |
| libpad/PADCMD | 9/450/10 (19) | 9/430/10 | −20 | 0 | 0 | OK |
| **libpad/PADENTRY** | 5/72/6 (8) | **6/52/6** | **−20** | **PadInfoAct** | 0 | OK |
| libcd/iso9660 | 1/356/2 (6) | 1/339/**3** | −17 | 0 | 0 | OK |
| libc/SPRINTF | 0/174/0 (1) | 0/159/0 | −15 | 0 | 0 | OK |
| libapi/COUNTER | 0/17/1 (3) | 0/10/1 | −7 | 0 | 0 | OK |
| libetc/INTR_VB | 0/11/0 | 0/5/0 | −6 | 0 | 0 | OK |
| libpress/LIBPRESS | 5/82/11 (12) | 5/76/**9** | −6 | 0 | 0 | OK |
| libcd/toc | 0/93/1 (2) | 0/89/1 | −4 | 0 | 0 | OK |
| libgte/COR_01 | 0/76/0 (1) | 0/72/0 | −4 | 0 | 0 | OK |
| libpad/PADPORTD | 2/360/4 (8) | 2/358/4 | −2 | 0 | 0 | OK |
| libcd/event | 0/64/4 (5) | 0/63/4 | −1 | 0 | 0 | OK |
| libetc/VSYNC | 0/53/1 (2) | 0/52/**0** | −1 | 0 | 0 | OK |
| *WORSE (do not wire)* | drv +62 · cdread +30 · INTR_DMA +9 · cdread2 +6 · cdcont +5 · FGO_01 +4 · stcdint +3 · MCXMAIN +2 · FGO_06 +2 · TYPE +2 · VMODE +1 |

⇒ the flag is a **PER-OBJECT identity, not a class rule** — it helps 20 objects, hurts 11,
is inert on 33. That is exactly the §3.25 per-object-toolchain-identity shape.

### 2b. `-G` is BLIND inside the nosplit basin (confirms w47-a8-A5)
`repro2.json` `nosplitG0` / `nosplitG8` vs `nosplit`: cluster −601 / −606 / −606. Per TU the
ladder is flat to within 1–8 diffs everywhere. Any future syslib `-G` census MUST state the
split-addresses state it was taken under.

### 2c. Lever-order (basin-relative) check
In the nosplit basin the two falsified schedulers stay falsified:
`nosplit + -fno-delayed-branch` = **+1486 diffs / 44 regressions**;
`nosplit + -fno-schedule-insns2` = −107 diffs but **25 regressions**. Neither is rescued.

### 2d. Mechanism note — `jtbl_at_fusion` becomes REDUNDANT under nosplit
PADENTRY carries `{"jtbl_at_fusion": True}` for `PadInfoAct`. Gated with
`no_split_addresses` and the `jtbl_at_fusion` key **removed**: identical result
(6 PASS, 52 diffs, `PadInfoAct` PASS @53 insns). The maspsx `--jtbl-at-fusion` hack was
emulating exactly what `-mno-split-addresses` makes cc1 do natively. Same question is open
for the other 4 `jtbl_at_fusion` syslib TUs (drv, FONT, LIBMCRD, SPRINTF) — not tested.

---

## 3. THE `-fno-delayed-branch` CLASS MAP (charter item 2)

**Whole-TU: the class is EMPTY.** +3333 diffs, 55 PASS regressions, −100 count-exact fns
across 64 TUs. The only TU-level "improvements" are −1..−3 diff noise (CARDINIT, DSCB,
INTR_VB, FGO_01, FGO_06, FOG_01), all of them *adding* instructions.

**Per FUNCTION** (`scratch/w48_a9/nodelay_map.txt`, 293 gated fns): **28 improve, 211 worsen,
54 inert** — and the improvements are almost all MIRAGES: 27 of the 28 move the instruction
count AWAY from the oracle (the w25-a1 "naked nop" signature, now quantified cluster-wide,
e.g. `_que_ref` 6 diffs @EXACT → 5 diffs @10/9; `SetFogNear` 4 @EXACT → 3 @26/25;
`_install_drain_cb` 10 @EXACT → 7 @11/10). **Under the IDENTITY BAR a diff cut that breaks
count-exactness is not a win.**

### 3a. The ONE genuine per-fn candidate: `_clr_card_event` (libmcrd/BIOS — a1's scope)
```
BASE                 5 diffs, ours 65 / oracle 66
-fno-delayed-branch  2 diffs, ours 66 / oracle 66   <- COUNT-EXACT
```
The residual is **one instruction, position only**: our build hoists `lw ra,16(sp)` ~25 insns
early into a load-delay gap; retail restores `$ra` immediately before `addiu sp,sp,24`.
`tools/build.py`'s existing comment rejected this fn as "improved but not PASS" — under the
identity bar it is the cluster's only real Tier-2→exact-count conversion.
**Not a flag problem**: `+ -fno-schedule-insns2` → 4 diffs, `+ -fno-schedule-insns` → 2,
`+ -mno-split-addresses` → 2. It is a **sched-issue-POSITION** residual ⇒ the w45/w47
USE FENCE (catalog: "the fence is a sched-issue-position fixpoint") is the instrument.
Handed to a1; not landed (a1 owns BIOS.c).

### 3b. The splice wiring (described, NOT modified — charter item 2)
`tools/build.py` already contains the w25-a1 per-FUNCTION dual-compile splice:
* `PER_FN_NO_DELAYED_BRANCH: {root-relative src path -> set of .ent/.end label names}`
  (line ~380), currently 11 syslib TUs + eaclib/pad.c.
* `_apply_fn_splice(rel, s_file, i_file, cc1_bin, cc1_flags)` (line ~590) re-runs cc1 on the
  SAME `.i` with `-fno-delayed-branch` appended → `<obj>.nodb.s`, then for each named label
  `_extract_fn_region` pulls the `.ent NAME … .end NAME` block, `_uniquify_local_labels`
  renames every `$L<n>` DEFINED inside it to `$L<tag>_<n>` (gcc renumbers per compile run and
  the two runs collide), and the region is substituted into the normal `.s` **before maspsx
  ever sees it**. Called from `compile_c` immediately after cc1 and from `compile_cpp`.
* Consequence for measurement: a whole-TU `-fno-delayed-branch` probe number for a function
  already in the splice set is UNCHANGED (both builds are the flag build) — so the §3 map is
  a clean read of the *un-spliced* population.
* ⚠️ splice caveat already in-tree: a function containing a `casesi` jump table has `$L<n>`
  references living OUTSIDE `.ent/.end` (in `.rdata`) which are deliberately not renamed.

---

## 4. WHY `-G0` FAILS WHILE THE ORACLE HAS NO `%gp_rel` (H3, the mechanism)

`scratch/w48_a9/gpcensus.txt`: **0 `%gp_rel` in all 64 syslib objects.** Control corpus proves
the census discriminates: hud 29/62 fns / 271 sites, cario 7/11 / 50, cars 11/33 / 59.
By the w47-a7 frontend rule that reads as a `-G0` class. **The gate says otherwise (+2726/23).**

Root cause: **11 syslib recon TUs already emulate `-G0` PER SYMBOL** —
`__attribute__((section(".bss")))` on file statics (SYS 20 sites, BIOS 17, LIBPRESS 9, VLC 3,
FERR 3, streamhelp 3, MCXMAIN 2, stcdint 2, USERFUNC 1, DSCB 1, stream 1). Those symbols are
already out of `.sdata`, so whole-TU `-G0` adds nothing there and only removes gp-rel from
*other* symbols that the recon still wants small. This is the catalog's
**"DECLARATION SHAPE MASKS -G"** law with a new mask (a section attribute rather than an
unsized array). **Rule to carry forward: before crediting or debiting `-G` on a syslib TU,
check its section attributes AND its split-addresses state (§2b) — both blind the census.**

---

## 5. MODE-A FINGERPRINTING (charter item 3)

Instrument: `scratch/w47_a9_fp.py` / `w47_a9_modea.py` (near-oracle `C:/Temp/nfs4-instr-cc1/cc1-elf.exe`,
flags `-O2 -G4 -mgas -msplit-addresses -funsigned-char`) vs the real `CC1PSX.EXE` on the same `.i`.
Raw: `scratch/w48_a9/modea.txt`, `modea2.txt`.

**Coverage 60 of 64 modules / 281 gated fns; 263 (93.6 %) lab-IDENTICAL.**

### 5a. Method boundaries paid for this wave
* **11 TUs the stock lab cc1 REFUSES**: `__attribute__((section(...)))` → *"section attributes
  are not supported for this target"* (both the elf and ecoff lab builds; CC1PSX accepts it).
  Worked around with **Mode A′** (`scratch/w48_a9_modea2.py`): strip the attribute from the
  preprocessed input given to BOTH compilers. Apples-to-apples for the *compiler-divergence*
  question; it does NOT speak to those statics' retail addressing form. All A′ numbers labelled.
  Result: SYS 43/44, BIOS 17/17, LIBPRESS 12/12, USERFUNC 4/4, MCXMAIN 5/5, stcdint 3/3,
  stream 3/3, streamhelp 6/6, DSCB 2/2, FERR 1/1.
* **3 TUs SEGFAULT the lab cc1** (SPRINTF, FONT, PADPORTD) — a rebuilt-cc1 defect, not a
  finding. Those TUs have no Mode-A verdict.

### 5b. The SN-DIVERGENT set (18 fns) — a cheap flag, NOT a verdict
| fn | module | gate diffs | ours/oracle |
|---|---|---|---|
| CdControl / CdControlB / CdControlF | libcd/cdcont | 62 / 69 / 67 | 77/79 · 80/83 · 74/77 |
| CD_datasync / CD_ready | libcd/drv | 61 / 131 | 89/90 · 175/178 |
| CD_cachefile / CdSearchFile | libcd/iso9660 | 99 / 92 | 162/167 · 166/182 |
| CdGetToc2 | libcd/toc | 87 | 134/137 |
| `_gpu_que_drain` (A′) | libgpu/SYS | 85 | 127/152 |
| `__adddf3` `__divdf3` `__extendsfdf2` `__floatsidf` `__muldf3` | libmath | 377 · 305 · 69 · 50 · 326 | — |
| MemCardCreateFile / DeleteFile / GetDirentry | libmcrd/LIBMCRD | 104 / 96 / 180 | — |
| `_padInitSioMode` | libpad/PADMAIN | 227 | 192/205 |

**HONEST STATISTICS — the enrichment is NOT significant and I decline the law.**
Syslib's base fail rate is 71.2 % (n=281, mean 50.7 insns), so "divergent ⇒ fails" carries
almost no information:

| stratum | n | fail | mean insns |
|---|---|---|---|
| all | 281 | 71.2 % | 50.7 |
| lab-DIVERGENT | 18 | 100 % | 138.7 |
| lab-IDENTICAL | 263 | 69.2 % | 44.7 |
| **size ≥ 60, DIVERGENT** | **18** | **100 %** | 111 |
| **size ≥ 60, IDENTICAL** | **63** | **96.8 %** | 114.5 |

Size-matched enrichment **1.03×** (w47's eaclib figure was 1.8× on n=7 and was already declined).
**The usable half is the NEGATIVE**, and it is strong: **263 syslib functions are provably not
SN-compiler-specific**, so allocsim / reqdelta / qtytrace / the instrumented traces apply to
them in full. 5 of the 14 libmath soft-float TUs are the densest divergence pocket — a1/a8
should expect lab traces there to be inadmissible.

---

## 6. WIRING RECOMMENDATIONS

### TIER 1 — MEETS THE w47 IDENTITY BAR (recommend wiring)
FAIL→PASS conversion + ZERO PASS regressions + reproduced 2× + **re-gated WIRED (hookless)**.

| TU | key to add | wired result | conversion |
|---|---|---|---|
| `recon/syslib/psx/libgpu/SYS.c` | `{"no_split_addresses": True}` (NEW key) | 13→**14** PASS, 1957→**1743** diffs | `MoveImage` 27→PASS (46/46) |
| `recon/syslib/psx/libpad/PADMAIN.c` | `{"no_split_addresses": True}` (NEW key) | 1→**2** PASS, 667→**614** | `_padSetVsyncParam` 16→PASS (11/11) |
| `recon/syslib/psx/libpad/PADENTRY.c` | ⚠️ **MERGE into the EXISTING entry** `{"jtbl_at_fusion": True}` at build.py line 281 — do NOT add a second key (the 04G duplicate-key hazard) | 5→**6** PASS, 72→**52** | `PadInfoAct` 20→PASS (53/53) |

**Wired verification performed** (patch → hookless `tools/verify_asm.py` → revert):
per-function results were **byte-identical to the probe** on all three TUs
(`scratch/w48_a9/wired_gate.txt`), **0 regressions**, and a duplicate-key counter-audit of the
whole `PER_TU_FLAGS` literal reported **30 keys, 0 duplicates**.
`_padSetVsyncParam`'s oracle is the textbook nosplit signature — one `la`-materialised base
(`lui/addiu %hi/%lo`) then four stores at ±displacements, where split-addresses emits a fresh
`lui %hi` per store.

### TIER 2 — net-positive, ZERO regressions, count-exactness NOT degraded (consolidator's call)
Same evidence class as the already-landed `recon/eaclib/psx/pad.c` precedent (which was wired
on "5/5 improve or hold", not on a conversion). Below the bar because no fn converts.
`libetc/INTR` (−51, dCNT +2) · `libmcrd/USERFUNC` (−45, +1) · `libgpu/FONT` (−34, 0) ·
`libmcrd/BIOS` (−28, 0) · `libpad/PADCMD` (−20, 0) · `libcd/iso9660` (−17, +1) ·
`libc/SPRINTF` (−15, 0) · `libapi/COUNTER` (−7, 0) · `libetc/INTR_VB` (−6, 0) ·
`libcd/toc` (−4, 0) · `libgte/COR_01` (−4, 0) · `libpad/PADPORTD` (−2, 0) · `libcd/event` (−1, 0).

### TIER 3 — DECLINED despite a diff cut (count-exactness REGRESSES)
`libmcrd/LIBMCRD` (−56 but dCNT **−3**: MemCardAccept/Exist 26/26→27/26, MemCardFormat 35→36) ·
`libpress/LIBPRESS` (−6, dCNT −2) · `libapi/FIRST` (−22, dCNT −1) · `libetc/VSYNC` (−1, dCNT −1).
A diff cut bought with extra instructions is a nudge, not an identity.

### NOT RECOMMENDED (measured worse)
`libcd/drv` **+62**, `libcd/cdread` +30, `libetc/INTR_DMA` +9, `libcd/cdread2` +6,
`libcd/cdcont` +5, `libgte/FGO_01` +4, `libcd/stcdint` +3, `libpad/MCXMAIN` +2,
`libgte/FGO_06` +2, `libcd/TYPE` +2, `libetc/VMODE` +1.

---

## 7. HANDOFFS

* **a1 (libmcrd)** — 🔴 `_card_start` **31 → 3 diffs** under `-mno-split-addresses`
  (120/119 insns; residual = the §H6 macro-split class, see below). And the briefing's
  `funcEvSp*` floor is **STALE: `funcEvSpIOE` is already PASS**. `_clr_card_event` → §3a
  (count-exact at 2 diffs under the existing splice; needs a use-fence, not a flag).
  BIOS is TIER-2 for the flag; LIBMCRD is TIER-3 (declined).
* **a3/a4 (libpad)** — PADMAIN + PADENTRY are TIER-1 landings (one PASS each). PADCMD/PADPORTD
  are TIER-2. **Do not spend the wave on `-fno-delayed-branch` whole-TU probes** — §3 closes it.
* **a2 (libgpu)** — SYS is TIER-1 (+1 PASS, −214). SYS's 20 `section(".bss")` attributes are a
  per-symbol `-G0` emulation; §4 explains why a whole-TU `-G0` makes it worse, so leave them.
* **a5/a6 (libcd)** — `-mno-split-addresses` is **WRONG** for drv/cdread/cdcont/stcdint
  (measured worse); iso9660/toc/event are TIER-2. cdcont's `CdControl{,B,F}` and drv's
  `CD_ready`/`CD_datasync` are in the SN-divergent set (§5b) — lab traces inadmissible there.
* **a8 (math/gte)** — the "libmath is one class" premise is **falsified**: no setting improves
  the class (`-fno-schedule-insns` helps 6 TUs, hurts 7; class total 2361→2330). Best single
  lead: **`__floatsisf` 38 → 11 diffs** under `-fno-schedule-insns` *or* `-O1` (43→44 vs
  oracle 45 — still 1 short, so below the bar; combinations with sched2/expensive/strength
  all measure 11, so it is a 1-insn source-shape problem). 5 libmath fns are SN-divergent.
* **🔬 a10 (real ASPSX)** — §H6: **60 oracle sites** where `lui $at,%hi(S)` and the matching
  `%lo(S)($at)` access are separated by a `jal`/`j`/`beqz`/`jr`, i.e. ONE assembler address
  macro whose two halves straddle a delay slot (`scratch/w48_a9/macrosplit.txt`; heaviest:
  stcdint 16, LIBMCRD 10, cdcont 5, SYS 4, PADMAIN 3). Structural argument that it is
  assembler-side: **cc1 never allocates `$at`**, so the `lui $at` cannot have come from the
  compiler. This is a MACRO-EXPANSION placement question and is **distinct from the 04C
  falsification** (which tested *backward-filling an existing instruction*). Concrete exhibit
  ready to assemble: `_card_start` @ `jal EnableEvent`, where our maspsx output is
  `lui $at; sw $v0,0($at); jal; nop` and retail is `lui $at; jal; sw $v0,%lo($at)`.
  **I polled `scratch/w48_a10_receipts.md` before writing this — not present at my finish
  time (a10's worktree held only w48_a10_{snasm,scan,diff}.py), so no assembler-side
  conclusion is claimed here.**

---

## 8. TOOLS (committed, `w48_a9_` prefixed, `git add -f`)

| tool | what |
|---|---|
| `w48_a9_axis.py` | (TU × config) → JSON ledger of per-fn `[diffs, ours, oracle]`; makes the IDENTITY BAR computable |
| `w48_a9_report.py` | ledger → per-TU deltas + IDENTITY-CANDIDATE / nudge / REGR verdicts + cluster totals |
| `w48_a9_gpcensus.py` | `%gp_rel` census over the ORACLE (`-G0` discriminator, w47-a7 method) |
| `w48_a9_atcensus.py` | `$at` census over the ORACLE (the `-mno-split-addresses` structural fingerprint) |
| `w48_a9_modea2.py` | Mode A′ — Mode A for TUs the lab cc1 rejects (section attributes stripped from BOTH inputs) |
| data | `w48_a9/{ladderALL,repro2}.{txt,json}`, `nosplit_table.txt`, `nodelay_map.txt`, `gpcensus.txt`, `atcensus.txt`, `macrosplit.txt`, `modea.txt`, `modea2.txt`, `wired_gate.txt`, `w48_a9_mods.txt` |

### Gotchas paid this wave (add to the standing list)
* The stock rebuilt cc1 (elf AND ecoff) **rejects `__attribute__((section(...)))`** on mips —
  11 syslib TUs are invisible to Mode A without the A′ strip.
* The stock rebuilt cc1 **segfaults** on SPRINTF / FONT / PADPORTD.
* `git diff` of `tools/build.py` against `HEAD:` shows the WHOLE FILE as changed even when the
  tree is clean — repo storage is LF, the worktree is CRLF. **Use `git status --porcelain`,
  not `diff <(git show HEAD:...)`, to prove a revert.**
* A per-TU `-G` census taken under `-mno-split-addresses` is structurally blind (§2b), and a
  `section(".bss")` attribute masks `-G` exactly like an unsized-array declaration (§4).
