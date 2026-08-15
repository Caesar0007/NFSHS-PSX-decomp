# W66-A2 — THE MASPSX + DTOR SWEEP · final census

Repo `C:\Temp\nfs4-decomp`, base `c7904577`. Every number below was measured by me,
twice where the discipline requires it. `tools/build.py` was **never edited** (the
maspsx flag is probed through an in-memory hook, `scratchpad/w66a2/pr.py`).

---

## 0. SCOREBOARD

| item | result |
|---|---|
| maspsx `--nop-before-label` (OPT-IN, default OFF), both copies | implemented, ast-validated, copies byte-identical |
| default-OFF byte-inertness | **1207/1207 objects byte-identical** (whole-tree A/B, 4 peer-churned TUs re-proved under fixed sources) |
| flag-ON probe (`FntPrint`) | brdist `(10,8,9)` → **0**; gate PASS held; **exactly 1 word changes** (the `j` target), insn count 439/439 |
| flag-ON on other TUs | **NOT globally safe**: closes FONT only, *breaks* fememcard + fescreen (0 → 1 row each) ⇒ per-TU wiring is mandatory |
| `_vtdtor_*` fabricated wrappers | **113 slots rewired, 113 wrappers deleted, 0 left tree-wide** |
| gates on the 10 edited TUs (2×) | 9 × `0/0`, `aihigh.cpp` **14/14 PASS** — zero PASS→FAIL |
| production lane (aihigh, the only code TU touched) | `AIHigh_StartUp` REAL=0 RELOP=0 (2×), `AIHigh_Execute` REAL=0 RELOP=0 |
| `relink --lane recon` | **GATE GREEN** — REAL dup 0, HIDDEN PHANTOMS 0, unresolved 5 |
| `tu_order_audit` | **508 objects, 0 inversions** |
| tree-wide `brdist` (459 TUs) | 41 TUs / 65 rows → **6 class-d** (gate-PASS but divergent) + 59 class-a (already-FAILing fns) |
| `calltarget_audit` (461 units) | **2** — the known `Sim_MainGameLoop` swapped pair, unchanged |
| `textmoves_audit` (alabel walker FIXED) | 84 sealed fns, **3** real divergences (all already-FAILing), **0 metric-blind** |

**No zero-divergence certificate is claimable today.** The honest residue is §5.

---

## 1. THE MASPSX OPT-IN FLAG

### 1.1 What it does

`maspsx/__init__.py::_handle_nop_before_next_instruction` hoists a following label
**above** the load-delay `nop` it inserts. That is the w65-a2 `FntPrint` blocker: our
`$L115` lands on the nop (idx 88) where retail's `.L800F7198` is the `addiu` after it
(idx 89), so the branch word differs while the instruction stream is already retail's.

The opt-in flag `--nop-before-label` (processor kwarg `nop_before_label`, default
`False`) emits the inserted nop **first** and the label after it:

```python
            if nop_required:
                label = self.get_next_instruction(skip=0, ignore_nop=True, ignore_set=True)
                nop = f"nop # DEBUG: Reuse of '{r_dest}'. {reason}"
                if is_label(label):
                    self.skip_instructions = 1
                    if self.nop_before_label:          # OPT-IN
                        res.append(nop); res.append(label); return res
                    res.append(label)
                res.append(nop)
```

Patched in BOTH copies (`C:/Temp/maspsx-master/…` — the one `build.py` runs by default
via `NFS4_MASPSX` — and the in-repo `tools/maspsx/…`): byte-mode edits, LF preserved,
every anchor count-asserted `==1`, `ast.parse` before write, atomic `os.replace`,
backups in `scratchpad/w66a2/bak/`. `diff` of the two copies: identical.
Applier: `scratchpad/w66a2/patch_maspsx.py`.

### 1.2 Default-OFF is BYTE-INERT (the mandatory sweep, done stronger)

`build.py --skip-asm --out …` full tree before and after the patch, then a SHA-1 of
every object (strictly stronger than a brdist sweep, which only sees branch words):

* pre: 1207 objects, 0 build failures, 2m36s · post: 1207 objects, 0 failures, 2m38s
* **1203 byte-identical**; the 4 differing objects
  (`screentrophyinfo.cpp`, `libcd/event.c`, `libetc/INTR_DMA.c`, `libetc/VMODE.c`)
  are exactly 4 of the 9 files PEERS edited during the runs (git status + a source-hash
  snapshot diff prove it). Re-compiled with **fixed sources**, patched-vs-pristine
  maspsx: **0/4 differ** (`scratchpad/w66a2/recheck4.py`).
* the tree-wide `brdist` sweep (§4) was run on the patched (default-off) toolchain and
  reproduces the known row set — no new row anywhere.

### 1.3 Flag-ON probe proof (no build.py edit)

`scratchpad/w66a2/pr.py {gate|tu|brd} <TU>` loads `build.py` in memory and wraps its
`subprocess.run` so the maspsx invocation gains `$W66_MASPSX_FLAGS`.

| measurement | control | `--nop-before-label` |
|---|---|---|
| `brdist recon/syslib/psx/libgpu/FONT.c` (2×) | `FntPrint (10,8,9)`; 1 divergent | **0 divergent** |
| `tugate FONT.c` | 1/2 (FntPrint PASS, FntFlush FAIL 2 — peer-live, pre-existing) | **1/2, identical** |
| object word diff (`objdump -d -z`) | — | **1 word**: `45c: j 0800011f → 08000120`; 439/439 insns |

⇒ the flag relocates a label and nothing else; `FntPrint`'s class-d row closes.

### 1.4 🔴 It is NOT safe tree-wide — measured

| TU | control | flag ON |
|---|---|---|
| `syslib/psx/libgpu/FONT.c` | 1 row (`FntPrint`) | **0** ✅ |
| `frontend/common/fememcard.cpp` | 0 | **1** (`LoadGame__FsbT1 (36,6,5)`) ❌ |
| `frontend/common/fescreen.cpp` | 0 | **1** (`Draw__7tScreenb (1,7,6)`) ❌ |
| `frontend/common/screencarselect.cpp` | 0 | 0 |
| `frontend/common/screenmain.cpp` | 1 | 1 (no effect) |
| `frontend/psx/memcard.c` | 1 | 1 (no effect) |
| `game/psx/hud.cpp` | 7 | 7 (no effect) |

### 1.5 WIRING SPEC (orchestrator — `tools/build.py`)

1. Header comment, beside the `jtbl_at_fusion` key:
   `#   "nop_before_label"   -> pass --nop-before-label to maspsx for this TU only`
   `#                           (maspsx emits an inserted load-delay nop BEFORE a`
   `#                           following label instead of hoisting the label above`
   `#                           it — retail/aspsx placement; w66-a2)`
2. In **both** `compile_c` and `compile_cpp`, directly after the `jtbl_at_fusion` line:
   ```python
       if tu_flags.get("nop_before_label"):
           maspsx_cmd.append("--nop-before-label")
   ```
3. Wire it **by MERGING into FONT.c's EXISTING entry** (build.py:359 — the dup-key
   hazard, w47/w60: a second `"recon/syslib/psx/libgpu/FONT.c"` key silently discards
   the first):
   ```python
   "recon/syslib/psx/libgpu/FONT.c":       {"jtbl_at_fusion": True, "nop_before_label": True},
   ```
4. Re-gate FONT.c wired (hookless) and re-run `brdist` on it; do **not** wire any other
   TU without its own brdist A/B (§1.4).

⚠️ Both maspsx copies must stay in sync; `C:/Temp/maspsx-master/` is OUTSIDE the repo
(not under git) — it is the copy `build.py` actually executes.

---

## 2. THE `_vtdtor_` REWIRING — 113 slots, oracle-driven

Retail's dtor slot holds **the destructor's own address**: `asm/data/rdata_*.rodata.s`
carries `.word ___<len><Class>` at the slot (verified per slot, see below). Our recon
routed every slot through a fabricated `static int _vtdtor_X(X *p){ p->~X(); return 0; }`
wrapper — an artifact of C++ forbidding `&Class::~Class`, and a function retail never had.
w65-a3 minted the real `___<len><Class>` symbols (the extern-`"C"` dtor device + the
`_._`→`___` rename build.py already does), so the slots can name them directly.

**Mission scope (`vtables_tdialog.cpp` + `vtables_tlist.cpp`): 20 slots.** Each retail
symbol was read out of the oracle data before the edit (`scratchpad/w66a2/dtor_check.py`)
and each was confirmed DEFINED in the recon lane (fedialog / fecars / femenu / fetourn /
fetracks). Example receipt: `_vt_11tDialogBase` @0x800105D4 = `.word ___11tDialogBase`.

**Extended tree-wide (the same transformation, same oracle rule): 93 more slots** in
`aihigh.cpp` (2), `vtables_{aidatarecord,aihigh,aistate,tmenu,tpausemenu,tscreen,tscreen2}.cpp`.
`scratchpad/w66a2/rewire_all.py` does NOT assume the class's own dtor: for each slot it
reads the retail word at **slot VA + 4** (the cfront entry is `{delta,index,fn}`; the fn
pointer is the second word) and uses that symbol — which for a class with no declared
dtor is an ANCESTOR's (w65-a3's DTOR-DEPTH LAW). One such case exists and is now correct:

```
vtables_aistate.cpp  AIState_Base @0x80055650 -> ___12AIState_Base_80072838   <== VA-suffixed symbol
```

`--check` output (all 93 slots, per-slot symbol) is `scratchpad/w66a2/rewire_all_check.txt`;
0 unresolved slots, 0 mismatched wrapper/slot sets.

### 2.1 What the objects now look like

`nm build/recon/game/common/vtables_tdialog.cpp.o` → the 10 wrappers are gone, 10 `U
___<len><Class>`; `objdump -r` shows the slots as `R_MIPS_32 ___<len><Class>` — exactly
retail's `.word`.

`aihigh.cpp` is the only CODE TU touched. Pre/post object comparison
(`b_pre` vs current): **16 → 14 functions, the 2 removed are exactly the wrappers, 0
functions added, 0 function bodies changed.** The apparent "body change" on
`AIHigh_Execute`/`AIHigh_StartUp` is only the intra-section absolute `j` encoding moving
with the 0x40-byte section shift the deleted wrappers freed (every `beq/bnez` WORD is
identical); gate 14/14 PASS and psyqproof REAL=0 both confirm.

### 2.2 Gates (baseline-first, 2×, zero PASS→FAIL)

vtables_{tdialog,tlist,aidatarecord,aihigh,aistate,object,tmenu,tpausemenu,tscreen,tscreen2}
`0/0` before and after · `aihigh.cpp` **14/14** before (w65-a3 baseline) and after ·
definer TUs re-gated for the record: fedialog 33/33, fecars 46/46, femenu 72/73,
fetourn 35/35, fetracks 15/15 (all at their HEAD values) · full `build.py --skip-asm`
green, 0 skipped TUs · `relink` GREEN with **HIDDEN PHANTOMS = 0** (the 113 new
external references all resolve) · `tu_order_audit` 0 inversions.

---

## 3. `textmoves_audit.py` — the alabel walker FIXED (w65-a4 §4.2 rec. 4)

`scratchpad/w66a2/textmoves_audit.py`. Three defects fixed:

1. **alabel truncation** (the flagged limitation): the walker stopped at the next
   `<label>:` objdump header, so an interior splat `alabel` (a GLOBAL symbol in the
   expected object) truncated the expected-side scan and manufactured bogus
   `PC-REL BRANCH COUNT` rows. It now takes the fn's `[st_value, st_value+st_size)`
   span from the SYMBOL TABLE (`objdump -t`) and keeps every instruction inside it —
   the same rule `verify_asm.ours()` implements from the oracle side.
2. **reloc-pending branches**: a branch carrying `R_MIPS_PC16` in the splat-assembled
   expected object has a PLACEHOLDER immediate (`…ffff`) and is not comparable in an
   unlinked object. Such PAIRS are skipped and reported as such; pairing is by
   **byte offset inside the fn**, so the two sides stay aligned when one relocates a
   branch the other resolves locally. (The 6 rows the old tool printed —
   `iFILE_ExecCommand`, `vramfxya`, `LoadGame`, `AudioCmn_SoundCar`, `sprintf`,
   `FntPrint` — were all this artifact.)
3. **object paths from `objdiff.json`**, not from a path convention (aiphysic's expected
   object is `expected/src/aiphysic.c.o`; the convention reported "missing object").
   It also prints objdiff's per-symbol `match_percent`, never `fuzzy_match_percent`.

Result: **84 TEXT_MOVES-sealed fns audited · 3 with a real PC-relative divergence · 0
unresolved · 0 scored 100 by objdiff**:

| fn | evidence | match_percent |
|---|---|---|
| `DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii` | branch POSITIONS differ (ours 760,772 / exp 756,768) | 97.12 |
| `PutDispEnv` | positions differ (ours 828 / exp 832) | 98.55 |
| `__divdf3` | positions differ (ours 620,640 / exp 628,648) | 94.80 |

All three are already-FAILing fns (class a) — the divergence is part of that residual,
not a hidden defect. **The audit is NOT a superset of `brdist`**: it cannot see a branch
the expected object leaves relocated (that is exactly `FntPrint`'s row). Run both.

---

## 4. TREE-WIDE `brdist` (459 TUs, 214 s)

`scratchpad/w66a2/brdist_sweep.py` → `brdist_final.json` / `.txt`;
classification by gate status (`classify_brdist.py`, one `tugate` per affected TU) →
`brdist_classified.{json,txt}`.

**41 TUs, 65 fn rows: 6 class-d (gate says PASS, branch word/count diverges) + 59
class-a (the fn already FAILs the gate).**

### 4.1 The 6 class-d rows — the complete hidden-divergence set

| unit | fn | row | route |
|---|---|---|---|
| syslib/psx/libgpu/FONT.c | `FntPrint` | (10,8,9) | **CLOSED by §1** — wire `nop_before_label` |
| syslib/psx/libpad/PADSEQD.c | `_dirSendAuto` | (1,32,33) | `PER_FN_BRANCH_RETARGET` (w65-a2 §4.2) |
| syslib/psx/libmcrd/LIBMCRD.c | `MemCardWriteData_cb` | (6,53,52) | `PER_FN_BRANCH_RETARGET` |
| frontend/common/screenmain.cpp | `DrawBackground__11tScreenMain` | (9,11,12) | `PER_FN_BRANCH_RETARGET` |
| game/psx/hud.cpp | `Hud_BuildString__FPciiiib` | (2,154,155) | `PER_FN_BRANCH_RETARGET` |
| frontend/psx/memcard.c | `MCRD_handlecardevents` | (13,148,94) | open (large delta — whole-block, not a ±1 label move) |

w65-a4's 9-row list minus `fememcard LoadGame`, `fescreen InitializeShapes`,
`screencarselect DrawBackground__25tScreenCarSelectTwoPlayer` — those three now read
clean/class-a at HEAD (peer landings since that census).

### 4.2 class-a (59 rows, 35 TUs) — informational

Every one belongs to a function the gate already FAILs, e.g. `femenu DrawSlider` (11),
`fetv DrawTV` (5), `libmcrd MemCardGetDirentry` (12), `libpad _padLoadActInfo_rcv` (9),
`libmath __divdf3` (6), `hud Hud_BuildMapMarkers` (11). They are the branch-word face of
those residuals, not separate defects. Full list: `brdist_classified.txt`.
⚠️ `hud.cpp` and several syslib TUs were being edited by peers during the sweep — their
rows are that in-flight state, re-measure before acting.

---

## 5. THE HONEST RESIDUE (what a "zero known divergence" claim would have to cover)

| class | count | state |
|---|---|---|
| brdist class-d (gate-blind branch words) | **6** | 1 closed by the new flag once wired; 4 need `PER_FN_BRANCH_RETARGET`; 1 open |
| brdist class-a | 59 | inside known FAILing fns |
| calltarget wrong-target sites | **2** | the `Sim_MainGameLoop` swapped pair (w65-a3 §2: jump.c "jump around unconditional jump" inversion; named mechanisms = block-relocating TEXT_MOVES or a jump-opt splice) |
| TEXT_MOVES branch-word divergences | 3 | all in already-FAILing fns |
| recon-lane unresolved symbols | 5 | `D_1000001`, `D_80000004`, `__last_org`, `_gp`, `ticksA` |
| REAL dups / hidden phantoms / TU inversions | 0 / 0 / 0 | GREEN |

---

## 6. FALSIFICATIONS / HAZARDS (this run)

* **The flag is not a tree-wide fix** (§1.4) — measured, not assumed.
* `ast.parse(data.decode("ascii","surrogateescape"))` raises on a file with non-ASCII
  bytes (`maspsx/__init__.py` has 2) — decode UTF-8. Caught before any write (the
  patcher validates before `os.replace`).
* A `/* … */` receipt header that literally contains the token being deleted trips a
  "no leftover" assertion — the rewire tool's own comment mentioned `_vtdtor_X`.
* `rewire_all.py` had to become line-ending-aware: `aihigh.cpp` is CRLF while all the
  `vtables_*.cpp` are LF (the standing mixed-endings hazard).
* Peers edited 9 recon files during the two full builds; the object A/B was therefore
  re-proved on the 4 affected TUs with fixed sources instead of being hand-waved.
* `build/**` churns under peers: every gate here was re-measured at the point of use.

## 6b. CONCURRENCY ADDENDUM (HEAD moved under this belt)

* **w66-a1 landed the `PER_FN_BRANCH_RETARGET` mechanism** (as a `git apply`-clean
  patch for the orchestrator, `scratchpad/w66a1/branch_retarget.patch`; `tools/build.py`
  itself still unwritten) and closes **all 6** of my §4.1 class-d rows plus the 2
  calltarget rows with it. My §4/§5 tables are therefore the state **before that patch
  is wired**; re-run `brdist`/`calltarget_audit` after the orchestrator applies it.
* **`FntPrint` now has TWO independent routes**: w66-a1's retarget row (no toolchain
  change) and this belt's `nop_before_label` (no per-fn row). w66-a1's note that maspsx
  "hoists exactly ONE label above its inserted nop, so a SECOND label lands after it"
  refutes only w65-a2's *"a maspsx option is REQUIRED"* framing — the option itself is
  implemented, measured, and byte-inert by default. **Orchestrator choice**: prefer the
  retarget row if you want one mechanism for the whole class; prefer the flag if you
  want the label where retail's assembler put it without a per-fn anchor to maintain.
  They must not both be applied to `FntPrint` (double-fix → a new divergence).
* **Attribution**: a peer's `git add`-a-directory commit (`de791715`) swept every file
  I had staged (the 10 recon TUs, both `tools/maspsx` files and the `scratchpad/w66a2`
  receipts) into *their* commit. Content is intact and verified in HEAD
  (`git show de791715:tools/maspsx/maspsx/__init__.py | grep -c nop_before_label` = 3);
  only the attribution moved. Standing hazard, receiving end (w65-a4 §7 saw the same).
* **Re-baselined after the peer landings** (HEAD `f3cab3d2`): `vtables_tdialog` 0/0,
  `vtables_tlist` 0/0, `aihigh.cpp` **14/14 PASS** — zero PASS→FAIL still holds.

## 7. FILES (all under `scratchpad/w66a2/`)

`patch_maspsx.py` (the maspsx applier) · `pr.py` (in-memory maspsx-flag probe harness:
`gate|tu|brd`) · `recheck4.py` (fixed-source patched-vs-pristine A/B) ·
`dtor_check.py` (retail slot symbol + definition census, the 20 in-scope slots) ·
`rewire_vtdtor.py` (the mission-scope rewiring) · `rewire_all.py` (the oracle-driven
tree-wide one, `--check` for a dry run) · `vtdtor_census.py` ·
`textmoves_audit.py` (FIXED — promote-worthy) · `brdist_sweep.py` + `classify_brdist.py` ·
`classd_probe.sh`/`.txt` (the flag's per-TU effect) ·
data: `pre_obj_hashes.json`, `post_obj_hashes.json`, `brdist_final.{json,txt}`,
`brdist_classified.{json,txt}`, `textmoves_audit_out.txt`, `calltarget_final.txt`,
`rewire_all_{check,apply}.txt`, `build_{pre,post,after}.log`, `bak/` (all backups).
