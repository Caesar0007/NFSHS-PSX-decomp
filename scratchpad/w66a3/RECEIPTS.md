# W66-A3 — THE LAST-UNDEFINED BELT

Repo `C:\Temp\nfs4-decomp`, wave W66, 2026-08-15. Base at start `c7904577`; HEAD moved to
`5a0b174f` (w66a6) mid-run and several peers held uncommitted edits in the same tree
throughout. **Every number below was measured by me** (`tools/verify_asm.py`,
`tools/tugate.py`, `tools/relink.py`, `tools/probe_link.py`, `tools/tu_order_audit.py`,
`tools/ownmap.py`, `tools/calltarget_audit.py`, `scratchpad/w66a3/gen_ld.py --link`);
nothing is quoted from a briefing.

---

## 0. HEADLINE

| axis | measured baseline | after |
|---|---|---|
| **recon-lane REAL LINK, undefined names** | **15** (0 `.L`) | **0** |
| `relink.py` UNRESOLVED (reloc-referenced) | 20 | **5** — and all 5 are the ld-provided absolutes (`_gp`, `__last_org`, `D_80000004`, `D_1000001`, `ticksA`), i.e. **0 real** |
| `relink.py` REAL dup / HIDDEN PHANTOMS | 0 / 0 | **0 / 0** (GATE GREEN) |
| COMMON symbols, tree-wide | 1 (`debug_cause`) | **0** |
| `tu_order_audit` | 0 inversions / 508 objects | **0 / 508** |
| `probe_link` | 82.93 % (161/442) | **82.95 % (161/443)** — climbed |
| PASS→FAIL regressions | — | **0** (23 TUs gated 2×) |
| `calltarget_audit` | 2 | 2 (the known `Sim_MainGameLoop` pair; **+2 wrong targets fixed that this tool cannot see** — §4) |

**`python tools/relink.py` unresolved 20 → 5 (0 real) and the real-link undefined count is 0.**
The acceptance sheet is met; §5 documents the honest residue.

---

## 1. THE 15, CLASSIFIED (`scratchpad/w66a3/plan.py`)

The residual set was never one problem. Re-deriving each name's VA (symbol_addrs → SYM →
`@0xVA` breadcrumb), its referencing objects (`objdump -r`, batched) and whether an
`asm/data` blob already emits that VA split them into five mechanical classes:

| # | class | symbols | device |
|---|---|---|---|
| 1 | **name phantom** — defined under a different spelling | `CD_init` | call the spelling that exists (`CD_init_80108140`) |
| 2 | **blob already emits the VA** | `dma_cb`, `g_videomode`, `g_bootGP`, `_init_pad_flag`, `_fnt`, `_rsincos`, `FECredits_lastFadeTick` | asm-label alias on the C decl (or on the `__asm__` text where the symbol only appears there) |
| 3 | **blob emits the VA, C-side alias NOT byte-neutral / many consumers** | `_cdr`, `bigBuf`, `showRoomFlag` | **a second GLOBAL LABEL on the BLOB side** — zero C change, so byte-neutrality is structural |
| 4 | **interior label of a run this tree already owns** | `gSndState` (= `sndgs`+0), `iSNDplatformrate` (= `sndgs`+0xA0) | extra labels in the owning TU's file-scope asm `.bss` block |
| 5 | **C++ shape defects** | `__20tDialogMessageString`, `tScreen_ProcessInput__FP7tScreen…` | missing inline base-ctor definitions / flattened-method mangling |

Two of these were **latent defects, not link harnesses** (§3).

---

## 2. LEDGER — every landing, every gate

| symbol(s) | TU / file | device | gate before → after |
|---|---|---|---|
| `CD_init` | `libcd/event.c` | decl+call → `CD_init_80108140` (the spelling `drv.c` defines and `cdcont.c` already used; splat appended the VA for the `CD_init`/`CD_Init` NTFS case-collision) | 5/5 → **5/5** |
| `dma_cb` | `libetc/INTR_DMA.c` | `extern int dma_cb[8] __asm__("D_8013BD24")` (8-word run, r18) | 3/4 → **3/4** |
| `g_videomode` | `libetc/VMODE.c` | alias `D_80134838` (9-word run, r17) — scalar decl shape (the macro-form lever) untouched | 2/2 → **2/2** |
| `g_bootGP` | `eacpsxz/savegp.c` | alias `D_801234E8` **+ the `%hi/%lo` operand inside `initgp`'s template renamed** (an asm-label on a C decl cannot rename a symbol that only appears inside an `__asm__` string) | 3/3 → **3/3** |
| `_fnt` | `libgpu/FONT.c` | alias `Font` (`symbol_addrs Font = 0x80135E58`) | 1/2 → **1/2** |
| `_rsincos` | `libgte/FGO_01.c`, `FGO_06.c` | renamed to `rcossin_tbl` (19 sites) — referenced ONLY from hand-asm templates, and `rcossin_tbl` is both the blob label and the canonical PsyQ name | 1/1, 1/1 → **1/1, 1/1** |
| `_init_pad_flag` | `libapi/PAD.c` (+ `PAD_data.c` retired) | alias `D_8013C338` | 1/1 → **1/1** |
| `FECredits_lastFadeTick` | `frontend/fecredits.cpp` | asm-label view repointed to `D_80051AA4` | 7/7 → **7/7** |
| `gSndState`, `iSNDplatformrate` | `sndpsxz/ssysinit.c` (+ `spktplay.c` def deleted) | interior labels of the `sndgs` .bss run at **+0** and **+0xA0** (`nm`-verified) | 4/4, 13/13 → **4/4, 13/13** |
| `_cdr` | `asm/data/data_8010CCD4_r20.data.s` | **blob-side label** at 0x8013C290 | cdread.c 3/6 → **3/6** |
| `bigBuf` | `asm/data/rdata_80010000_r00.rodata.s` | blob-side label at 0x80010000 (`_front_obj`) | 5 consumer TUs untouched |
| `showRoomFlag` | `asm/data/front_data_r00.data.s` | blob-side label at 0x80051260 (`_front_data_org`) | 3 consumer TUs untouched |
| `__20tDialogMessageString` | `frontend/fedialog.cpp` | the two inline base ctors supplied in-TU (§4) | 33/33 → **33/33**, `__12tDialogYesNo` PASS 46/46 |
| `tScreen_ProcessInput__FP…` | `frontend/screenpost_externs.h` | asm-label onto the METHOD mangling (§4) | 12/13 → **12/13** |
| `debug_cause` (the parked COMMON) | `libcd/stcdint.c` | demoted to `extern` — the blob cut w65-a6 specified **has landed** (`dlabel debug_cause` @0x80136AE0), under that exact name, so no alias is needed | 1/3 → **1/3**, COMMON `C` → `U` |
| the multi-run `.bss` split | `libcd/stream.c`, `streamhelp.c` | per-run nobits sections (§6) | 3/3, 5/6 → **3/3, 5/6** |

Consumer spot-checks, all unchanged: `stagpat` 8/8 · `span` 1/1 · `sstsetpr` 1/1 · `svol` 2/2 ·
`cdcont` 19/19 · `drv` 11/13 · `cdread` 3/6.

---

## 3. TWO LATENT DEFECTS FOUND ON THE WAY (gate-invisible, both the `gRepeatCount` class)

1. **`recon/syslib/psx/libapi/PAD_data.c`'s `int _init_pad_flag;`** — described in-source as
   "the owning definition … so the link still resolves". It never resolved anything: at 4
   bytes the tentative definition routes to a **LOCAL** symbol (`nm` prints `b`, the w65-a6
   §6.1 falsification, re-measured here), so `PAD.c`'s reference stayed undefined *and* a
   private word sat at an address retail does not have. The TU is now empty, with the
   receipt in place so the definition is not re-added.
2. **`recon/eaclib/psx/sndpsxz/spktplay.c`'s `int iSNDplatformrate[1];`** — labelled
   "(extern-declared, never defined; link-harness)". Same mechanism, same two failures. The
   real storage is `sndgs + 0xA0` — the file's *own* header note says the oracle loads it
   from `D_80147900` — and it is now an interior label of the `sndgs` run.

**RULE (third and fourth instances now): a 4-byte "link-harness" tentative definition is
never a link harness on either lane. It is a local symbol at a wrong address.** Grep class:
any `int X[1];` / `int X;` whose comment claims to satisfy an extern.

---

## 4. THE TWO C++ SHAPE DEFECTS — and a NAMED GAP IN THE CALL-TARGET AUDIT

**(a) `__20tDialogMessageString` — the CTOR mirror of the w65-a3 dtor-chain law.**
`__12tDialogYesNo`'s oracle jal's `__7tScreen` and then carries every base ctor body inlined.
Retail has **no** `__11tDialogBase` / `__20tDialogMessageString` function at all (neither is
in `symbol_addrs`): in retail these ctors are **inline-only**. `feapp.cpp`, `fememcard.cpp`
and `front.cpp` all carry the inline definitions; `fedialog.cpp` did **not**, so gcc had to
emit an out-of-line call to a ctor nobody defines. Supplying the two inline definitions in
`fedialog.cpp` and deleting the hand-written duplicate stores made the member-init chain
inline them and reach `__7tScreen` — **PASS 46/46 on the first compile**, whole TU 33/33.

**(b) `tScreen_ProcessInput__FP7tScreen…`** — a flattened instance method (§3.23b): the
free-fn form mangles `__FP7tScreen…`, the oracle for
`ProcessInput__24tScreenPinkSlipStandings…` jal's the **method** form `__7tScreen…`. An
asm-label on the declaration fixes the emitted name only (ABI identical: `this` in `$a0` ==
the explicit first pointer arg), and keeps the `int` return that the body needs.

🔴 **THE GAP: neither defect was visible to ANY existing gate.** `verify_asm` is reloc-name
lenient; `calltarget_audit.py` only reports a site where **both** names are known at
different VAs, so a call to an **undefined** callee is invisible to it. Both were wrong
call targets in a gate-PASSing, board-100 function, and **the real link is the only
witness**. Suggested standing check: fold the relink/real-link undefined set into
`calltarget_audit`'s report as a third class ("callee undefined").

---

## 5. THE HONEST RESIDUE — 5 names, all linker-provided, none materializable

`relink.py` still lists these because it links the lane WITHOUT the scripts; under the real
link (`linkers/nfs4_recon.ld` + `undefined_syms_auto.txt`) all five resolve and the
undefined count is **0**:

* `_gp` — assigned by the script (`_gp = 0x8013C54C`).
* `ticksA` — `PROVIDE(ticksA = ticks)` in the script.
* `__last_org` — the SYM's `endofcode` @0x80148B04, the bss-end marker `2mbyte.c`'s heap
  init reads. A linker symbol, not storage.
* `D_80000004`, `D_1000001` — BIOS/kernel absolutes, not objects.

**Do not "materialize" any of these** — each would put real storage where the image has none.

---

## 6. THE MULTI-RUN `.bss` SPLIT (the w65-a6 §7.2 hand-off), LANDED

`stream.c`'s 21 symbols form **three disjoint retail runs** and `streamhelp.c`'s form
**two**; one object's `.bss` is contiguous, so a single section could never reproduce them.
Each run now lives in its **own nobits section** named for its retail base, so a linker
script can place each independently:

```
stream.c      .bss.st_80144874    8 B   StFunc1, StFunc2
              .bss.st_80146C7C   72 B   StEmu_Addr .. StStartFrame   (ends at Cdinfo @0x80146CC4)
              .bss.st_801489CC    4 B   StMode
streamhelp.c  .bss.ds_801489D0    8 B   _ds_word0, _ds_word1
              .bss.ds_801489E4    4 B   _ds_ready_cb  (== GlobalCallback+4)
```

`objdump -h` / `nm` verified: sizes 8 / 0x48 / 4 and 8 / 4, and every interior offset is the
exact retail delta (`StEmu_Addr`@0 … `StStartFrame`@0x44; `_ds_word0`@0, `_ds_word1`@4).

Two properties worth recording:
* **byte-neutral by construction** — a nobits section emits no data, the C views stay
  `extern`, and names/order/sizes are unchanged. Both TUs re-gate at their prior counts.
* **the split DELETED an 8-byte filler in `streamhelp.c`** that was not neutral: it claimed
  0x801489D8..0x801489E0, i.e. storage this object does not own, sitting exactly on
  `GlobalCallback` @0x801489E0. `_ds_ready_cb` is `GlobalCallback+4` — genuinely a slot of a
  block no TU in this tree owns yet (see the cursor).

An UNPLACED link is unchanged because the catch-all is widened to
`*(.bss); *(.bss.*); *(COMMON)`. **`linkers/nfs4.ld` needs no change** — it links the src
lane, which has no recon objects.

---

## 7. FALSIFICATIONS / CORRECTIONS TO THE STANDING RECORD

1. **w65-a6 §6.2's recommended next attempt for `_cdr` was "rename the BLOB label to
   `_cdr`". Renaming is unnecessary and strictly worse than ADDING a label:** nine files
   reference `D_8013C290` (the CdRead / `_read_data_int` oracles among them), so a rename
   costs a multi-file sweep, while a second `dlabel` is one line. The property that matters
   is the same either way — **no C declaration changes, so `cdread.c`'s object cannot move**.
   Byte-neutrality here is structural, not measured; `cdread.c` held 3/6 (`CdRead` 2,
   `_read_issue` 8, `_read_int` 15) against the alias attempt's 2/6.
2. **The same argument generalises**: for a symbol with several consumers, or one whose
   C-side alias is known to perturb codegen, the blob-side label is the cheaper AND safer
   device. `bigBuf` (5 TUs) and `showRoomFlag` (4 declarations across 4 headers) cost one
   line each this way instead of ten header edits and ten re-gates.
3. **`debug_cause`'s blob cut had already landed** — the w65-a6 §5 "parked COMMON" entry was
   stale by one wave. The follow-up needed was one line, and it needed **no** asm-label
   (the blob uses the exact name).
4. **`tools/stale_absolutes.py` CANNOT RUN as promoted** — `ROOT = parents[2]` resolves to
   `C:\Temp` instead of the repo (the 16F "check root resolution on every promotion" law,
   firing again), and it also hard-depends on `scratchpad/w65a6/census_recon.json`, a wave
   scratchpad file. I did the equivalent check by hand: **no** `linkers/undefined_syms_auto.txt`
   or `undefined_funcs_auto.txt` row shadows any symbol this belt resolved. Orchestrator fix:
   `parents[1]` + derive the defined set from `nm` (or from `relink.py --json`) instead of the
   stale census.

---

## 8. CATALOG-ROW CANDIDATES (the memory dir is read-only to me)

1. **BLOB-SIDE LABEL vs C-SIDE ALIAS — pick by consumer count and by codegen risk.** Both
   resolve an undefined data symbol whose VA a splat blob already emits. The C-side
   `__asm__("D_<VA>")` alias touches the declaration (measurably NOT free in at least one
   case: `_cdr` cost `CdReadSync` PASS→FAIL). A second `dlabel` on the blob touches no C at
   all, so byte-neutrality is **structural**. Use the blob label for multi-consumer names and
   for any TU built on a `volatile` state block; use the C alias when you want the name to
   stay local to one TU. Never `sym = base+N` (ASPSX 2.77 has no symbol-assignment form).
2. **A SYMBOL THAT ONLY APPEARS INSIDE AN `__asm__` STRING CANNOT BE ALIASED FROM C.**
   `extern T x __asm__("Y");` renames C references only; `%hi(x)` inside a hand-asm template
   is literal text. Rename the template operand (a pure reloc-name change; the gate is
   reloc-name lenient) — `g_bootGP`, `_rsincos`.
3. **THE 4-BYTE "LINK-HARNESS" TENTATIVE DEFINITION IS ALWAYS A DEFECT** (4th and 5th
   instances). It routes to a LOCAL symbol on both lanes, so it resolves nothing, and it
   places a private word at a VA retail does not have. Detection: `nm` prints `b`/`C`, and
   the reference is still `U` in a sibling object. Cure: interior label of the run that
   really contains it, or an alias to the blob label.
4. **THE CTOR-CHAIN LAW (the mirror of w65-a3's dtor law).** gcc-2.8 emits `jal` to the
   nearest ancestor that DECLARES a ctor. Retail's tDialog family has NO out-of-line base
   ctor — they are `inline`, expanded at every construction site. A TU that constructs but
   lacks the inline DEFINITION emits an out-of-line call to a symbol nobody defines: a real
   undefined symbol that the gate hides (right position, one jal, wrong name). Cure: supply
   the inline definitions in that TU and delete the hand-written duplicate stores.
5. **THE CALL-TARGET AUDIT'S BLIND SPOT: an UNDEFINED callee.** `calltarget_audit.py` needs
   both names to have VAs; `verify_asm` is reloc-name lenient. A call to a never-defined
   function is therefore invisible to every byte gate — **only the real link sees it**. Two
   such sites were fixed this belt, both in board-100 / gate-PASS functions.
6. **A nobits section per RETAIL RUN lets one object reproduce disjoint runs.** Name it for
   the run's base VA, keep the C view `extern`, widen the script catch-all to `*(.bss.*)`.
   Byte-neutral by construction, and it removes the temptation to pad across storage the
   object does not own.

---

## 9. GATES RUN (all by me, this tree, at the end of the belt)

```
tools/relink.py --lane recon        REAL dup 0 · HIDDEN PHANTOMS 0 · unresolved 5 (all ld-provided) · GATE GREEN
scratchpad/w66a3/gen_ld.py --link   undefined-names 0 (.L=0)   [strict AND multdef-ok]
tools/tu_order_audit.py             508 objects, 0 inversions
tools/probe_link.py                 82.95 % (161/443)   [baseline 82.93 %, 161/442 -- climbed]
tools/ownmap.py  (data + front)     runs clean; NO window verdict mentions any symbol this belt touched
tools/calltarget_audit.py           2 (the pre-existing Sim_MainGameLoop pair)
COMMON census (nm over build/recon) 0
tugate                              23 TUs, gated 2x, ZERO PASS->FAIL
```

`scan.py` was re-run immediately before every link (the 15E stale-objdata hazard).

---

## 10. NOT LANDED / FOR THE LINK LANE

1. **`linkers/nfs4_recon.ld` is generated** — I regenerated it for every measurement but did
   **not** commit it (the link lane owns `linkers/`, and `scratchpad/w66a5` shows a peer on
   that lane this wave). The one-line spec to fold into the generator:
   `.bss : SUBALIGN(4) { *(.bss); *(.bss.*); *(COMMON); }` (it is in
   `scratchpad/w66a3/gen_ld.py`, which is otherwise `scratchpad/w65a5/gen_ld.py` verbatim
   with `HERE` repointed).
2. **The five runs of §6 now have handles** — placing them at 0x80144874 / 0x80146C7C /
   0x801489CC / 0x801489D0 / 0x801489E4 is a script edit with no source consequence.
3. **`GlobalCallback` @0x801489E0 is owned by nobody.** `_ds_ready_cb` is its slot 1. When an
   owner is identified, `_ds_ready_cb` should become an interior label of that object's run
   and `.bss.ds_801489E4` disappears.
4. **`tools/stale_absolutes.py` root/censusfix** (§7.4).
5. **`calltarget_audit` third class** (§4).

---

## 11. HAZARDS ENCOUNTERED

* **Peers landing continuously**: HEAD moved `c7904577` → `5a0b174f` mid-run and ~20 files
  were dirty from other belts. Every commit stages **explicit files**; every baseline was
  re-measured rather than quoted. The blob-class duplicate count moved 796 → 797 during the
  run — **not mine**: none of my new names appears in ld's multiple-definition list
  (`scratchpad/w66a3/dup_after.txt`), and `REAL` stayed 0.
* **A `*/` receipt inside an open comment** (the 5th+ firing): my first `ssysinit.c` edit put
  new prose after the block's closing `*/`. Caught immediately by the compile; fixed by
  folding it inside the comment.
* **`relink.py --json` with a non-existent directory** raises after printing a perfectly good
  gate result — create the output directory first.
* All escape-bearing edits went through the Edit/Write tools or byte-mode Python with a
  size-grew assert and `os.replace` (no heredocs).

## 12. FILES

Touched (committed): `recon/syslib/psx/libcd/{event,stcdint,stream,streamhelp}.c` ·
`recon/syslib/psx/libetc/{INTR_DMA,VMODE}.c` · `recon/syslib/psx/libgpu/FONT.c` ·
`recon/syslib/psx/libgte/{FGO_01,FGO_06}.c` · `recon/syslib/psx/libapi/{PAD,PAD_data}.c` ·
`recon/eaclib/psx/eacpsxz/savegp.c` · `recon/eaclib/psx/sndpsxz/{ssysinit,spktplay}.c` ·
`recon/frontend/common/{fecredits.cpp,fedialog.cpp,screenpost_externs.h}` ·
`asm/data/{data_8010CCD4_r20.data.s,front_data_r00.data.s,rdata_80010000_r00.rodata.s}`.

Left behind in `scratchpad/w66a3/`: `plan.py` (the classifier — VA + referencing objects +
blob-label lookup for any undefined name), `gen_ld.py`/`scan.py` (the link harness with the
widened catch-all), `relink_{base,after,final}.json`, `probe_{base,after}.json`,
`recon_strict_undef.txt`, `dup_after.txt`, `ownmap_{data,front}.{txt,json}`,
`bak/fedialog.cpp`.
