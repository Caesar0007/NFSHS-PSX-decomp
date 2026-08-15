# W65-A3 — THE CALLTARGET BELT · per-site ledger

**`calltarget_audit.py` tree-wide: 143 → 2 sites (98.6 % cleared). ZERO PASS→FAIL.
tu_order_audit 0 inversions. Full recon build green after every shared-header edit.**

Baseline re-measured by me at HEAD `14c766e6` (143, matching W64-A21's number).
Final measured at `2aa75577`.

| commit | family | sites | after |
|---|---|---|---|
| `25214fa4` | CD_get_intr `puts` → `printf` | 1 | 142 |
| `421e3ba1` | tDialog hierarchy (dtors + 3 recursions) | 26 | 117 |
| `9f62ef5f` | base-scope qualification sweep | 47 | 70 |
| `230b39c0` | 29 dtors made implicit | 56 | 14 |
| `2aa75577` | camera order + AIHigh dtors + TextValue | 12 | **2** |

---

## 0. Why this belt exists (the blind spot, restated)

`verify_asm` is reloc-**name** lenient by design (AGENT_GUIDE §0c — and rightly so:
mangled-vs-demangled spellings and same-VA aliases legitimately differ), and the
board's `fuzzy_match_percent` ignores relocations entirely. **A `jal` to the wrong
function therefore scores 100 % on both lanes.** Every row below was invisible to
both, and ~50 of them are genuine runtime defects, not modelling debt.

---

## 1. FIXED — mechanism by mechanism

### 1a. `CD_get_intr` — `puts` where retail calls `printf` · 1 site · FIXED
`syslib/psx/libcd/drv.c`. The oracle's first `jal` in the `nReg == 5` arm is
`jal printf` with a **single** `%hi/%lo(D_800577A0)` argument — the string
`"DiskError: "`, exactly 12 bytes below the format string at `D_800577AC`.
**Verdict: transcription bug in a sealed function, not a header/macro binding
issue** — both `puts` and `printf` are declared in the TU, and gcc-2.8 does no
`printf`→`puts` folding (that is a gcc-4.x optimisation). One pointer argument
either way, so the instruction stream is unchanged and `CD_get_intr` held
**PASS 343/343**; the TU gated 11/13 before *and* after (`CD_init_80108140` 10,
`CD_cw` 18 — both pre-existing).

### 1b. THE DTOR-DEPTH LAW · 34 classes · 82 sites · FIXED
**The rule, read off the oracle** (all ~140 `asm/nonmatchings/**/___*.s`):

* a dtor body that stores **`_vt_<its own class>`** into the object
  (`lui/addiu %hi/%lo(_vt_X); sw $v0,OFF($a0)` in the jal's delay slot) belongs to
  the class that really **owns a declared dtor**;
* a **plain 8-insn `jal <ancestor>; nop`** is a dtor gcc **synthesised**, and it
  therefore chains to the nearest ancestor that owns one — **not to the direct base**.
* Refinement found on AIHigh: a body storing **a BASE's** `_vt_` (`___15AIHigh_BTC_Perp`
  stores `_vt_16AIHigh_BasicPerp`) is *also* synthesised — that is gcc inlining the
  base's own implicit reset before chaining on. **Read whose vtable it is, not the
  insn count.**

Our recon declared a dtor on *every* class, so each derived dtor `jal`'d its direct
base. That single modelling error produced the whole tScreen / tDialog / tMenuItem /
AIHigh debt.

**Probed on the real CC1PLPSX** (receipts `scratchpad/w65a3/dtor{1,2,3,4}.s`):

| shape | call sites | standalone symbol |
|---|---|---|
| explicit out-of-line dtor, implicit intermediates | `jal` the **first real** ancestor ✔ | emitted ✔ |
| explicit out-of-line dtor at every level (our old shape) | `jal` the **direct base** ✘ | emitted ✔ |
| inline in-class `~X(){}` | collapses ✔ | **NOT emitted** ✘ |
| synthesised (no declaration) | collapses ✔ | **NOT emitted** ✘ |
| inline in-class + `-fkeep-inline-functions` | collapses ✔ | emitted ✔ |

gcc emits **no** out-of-line copy for a synthesised dtor — falsified four ways
(a file-scope object with its static-dtor list, `delete p`, a `virtual` member, an
explicit `p->~C()` call site; `dtor3.s` emits none of them). `-fkeep-inline-functions`
*does*, but it is a whole-TU flag that would also export every other inline in
`nfs4_types.h` as a global — multiply-defined at link. **So the standalone symbol
must be supplied by hand.**

**FIX (34 classes):** drop `~Class();` from `nfs4_types.h` (non-virtual ⇒ **zero
layout change**, `sizeof` unchanged) and replace each trivial
`Class::~Class(){return;}` **in place** — preserving the object's symbol ORDER —
with `extern "C" void ___<len><Class>(void *thisp) { <ancestor>(thisp); }`.
Byte-identical to retail's 8-insn body: the argument passes through in `$a0` and
the ignored `__in_chrg` in `$a1` costs nothing. This is the
`___18tDialogInteractive` / `___31tDialogMessageStringWithTimeout` device already
in `fedialog.cpp` — generalised. Mechanised by `scratchpad/w65a3/implicit_dtor.py`,
which refuses any non-trivial body.

Ancestors are read **per class off the oracle, never off the class graph**:
`tScreenCarSelectDuel` → `___16tScreenCarSelect` (a real `_vt_` class) while its
siblings → `___7tScreen`; `tScreenPinkSlipCongrats::Cleanup` → `tScreen` while its
`Initialize` → `tScreenCongrats`.

Classes converted: `tDialog{Base,MessageString,YesNo,BackUpOnly,Help,
NoInputMessage,YesNoMem,YesNoTri,MessageStringWithTimeout}`,
`tScreen{Main,Audio,Display,Memcard,UserName,PinkSlips,TrackInfo,TrophyInfo,
TrackSelect,TrackRecords,Congrats,BeTheCopCongrats,PinkSlipCongrats,
TournamentTrophy,TournamentCongrats,TournamentStandings,TournamentStandings3item,
PinkSlipStandings,CarSelectDuel}`,
`tMenuItemOptions{LeftRightChoice,TwoItemChoice}`,
`tBlankMenuItem{GoToMenuNFS4Button,NFS4LeftRightChoice}`,
`AIHigh_{BasicCop,BTC_Cop,BTC_Perp}`.

### 1c. BASE-SCOPE QUALIFICATION · 50 sites · FIXED — **a runtime-bug class**
50 call sites spelled `this->Method(...)` inside `Class::Method` bound to the
derived override that shadows the base — **unconditional infinite recursion in 48
of them**. Retail calls the base's same-named method at every one. §3.23c's
SILENT-SHADOW row in its same-name-override form: well-formed C++ (no warning
possible), invisible to the gate and to the board. The affected set is the
front end's **entire screen lifecycle** — `Initialize`, `Cleanup`, `PreLoad`,
`Draw`, `DrawBackground`, `DrawForeground`, `ProcessInput`, `TransitionOn`,
`UpdateTransition`, `CalculatePrizes` — plus `tDialogMessageString::Draw` and both
`tDialogYesNo{Mem,Tri}::ProcessInput`.

**FIX:** explicit base scope (`this->tScreen::Initialize()`), **codegen-neutral** —
a qualified non-virtual call is the same `jal`, only the callee symbol changes;
confirmed by the gate holding to the instruction on all 20 TUs. Applied by
`scratchpad/w65a3/qualify.py`, which brace-matches the enclosing definition and
rewrites only inside its body (byte-level, so mixed-EOL TUs are never normalised);
it asserts exactly one definition per `Class::Method` — 50/50 resolved with exactly
one site each.

### 1d. `Camera_Update` case-body ORDER · 6 sites · FIXED — **a runtime bug**
The oracle's `jal` order through the 19-mode switch is Bumper, Tail×3, Heli×3,
Circle, Spline, TV, Blimp, Anim, **Simple**, CopCam1, CopCam2 — the
`case 8: case 9: case 0xf:` SimpleCam group is emitted **last** of that run, not
first (catalog §D: case BODIES emit in SOURCE order). Written first, six
consecutive `jal`s each landed one handler off: **every camera mode from 10 to
0xe would have run the wrong camera**. Moving the group after `case 0xe` is also
the natural 1998 shape — the group sits where its own last label (`0xf`) belongs.
`Camera_Update__Fv` **PASS 288/288** held.

### 1e. `screenpost` TextValue override · 1 site · FIXED
Reverts W64's `__asm__("TextValue__13tListIterator7tPlayer")` alias. The
"hierarchy binds BASE" law does **not** apply here: the oracle's single
(tail-merged) `jal` in `DrawBackground__26tScreenTournamentStandings` names
`TextValue__23tListIteratorTournament7tPlayer`, which is also the static type of
**both** ternary operands (`menuDefs->iteratorSpecialEvent` /
`->iteratorTournament`, both `tListIteratorTournament`).
**Lesson: the ORACLE is the authority, not the law.**

---

## 2. BLOCKED — with mechanism · 2 sites

### `Sim_MainGameLoop__Fv` — the two swapped `jal`s · **gcc LAYOUT-PASS residual**
Oracle block order:
`[PSS; j L716C]` `[InBetween=1; Camera_Update; j L7174]` `[L716C: PSS]` `[L7174:]`
— the **second** `Sim_ProcessSimSchedules` is laid out **after** the else arm and
the if arm jumps over it. Ours emits `[PSS][PSS][InBetween;Camera_Update]`, so the
two `jal`s land on each other's targets.

Falsified this wave (all measured with `verify_asm`; baseline **6 diffs**, ours
319 / oracle 321):

| form | diffs | note |
|---|---|---|
| baseline `if(speed==3){PSS();PSS();} else {…}` | **6** | correct branch polarity, second PSS inline |
| `if(speed==3){PSS();} else{…; goto after;} PSS(); after:;` | 8 | **branch polarity INVERTS** (`beq` ours vs `bne` oracle) |
| explicit goto chain in oracle block order | 8 | same inversion |
| + void-tail fence at the goto-target head | 8 | inversion survives |
| void-tail fence between the two PSS calls | 6 | inert |

**Mechanism:** every source form that ends the if arm with a jump lets `jump.c`'s
"jump around unconditional jump" inversion fire, swapping which arm is the
fall-through — the catalog's W50 row, here firing in the direction we do not want.
The in-source receipt already reads *"the unexplored axis is therefore the LAYOUT
pass, not the source"*, and this wave's five probes confirm it from the calltarget
side. **Left at its best form (6 diffs); reverted cleanly, `sim.cpp` untouched at
HEAD.** Named next angles: a `PER_FN_TEXT_MOVES` block relocation (the final text
is only two blocks apart), or a `-fno-thread-jumps` / jump-opt per-fn splice probe
(`PER_FN_NO_THREAD_JUMPS` precedent, catalog `AudioClc_SoundPlayersCar`).

**Nothing was classified `benign-by-construction`.** The audit already excludes the
two provably-uninformative reloc shapes (section-relative `.text`+addend forms and
any-addend sites), so every surviving row was a real wrong target.

---

## 3. Gates (all baseline-first, all 2×)

`scratchpad/w65a3/base1.txt` vs `after1.txt`/`after1b.txt` and `base2.txt` vs
`after2.txt` are **byte-identical**; `feapp`, `front`, `fedialog` and `camera` were
additionally re-baselined by restoring their backups, rebuilding and re-gating.

drv 11/13 · fedialog 33/33 · feapp 14/15 · front 42/43 · fememcard 18/18 ·
fecheats 10/10 · femenudefs 65/66 · femenuoptions 91/92 · femenuextended 57/57 ·
screen{main 13/13, audio 8/8, display 3/3, memcard 15/15, username 5/6,
pinkslips 8/8, trackinfo 5/5, trophyinfo 3/3, tracks 10/10, trackrecords 7/7,
congrats 28/28, post 12/13, carselect 59/59, controller 22/22, tournselect 9/9,
trophyroom 9/9} · vtables_tdialog 0/0 · pausemenu 59/60 · camera 37/38 ·
aihigh 14/14 · aih_basiccop 9/9 · aih_btccop 39/40 · aih_btcperp 26/26 ·
aistate 52/52. **ZERO PASS→FAIL.**
`psyqproof` REAL=0 RELOP=0 on `___12tDialogYesNo` (8 words) and
`Draw__20tDialogMessageString` (89).

---

## 4. Follow-ups for the orchestrator

1. **`recon/game/common/vtables_tdialog.cpp` (and `vtables_tlist.cpp`) still route
   every dtor slot through a fabricated `static int _vtdtor_X(X *p){ p->~X(); return 0; }`
   wrapper.** Now that each `___<len><Class>` is a real `extern "C"` function with the
   right signature, the slots can point at it **directly** and the 10+ wrappers can go —
   strictly more faithful (retail's slot holds the dtor's own address). Out of this
   belt's scope (data materialisation, no oracle functions in that unit: it gates 0/0),
   but it is now cheap.
2. **Promote `calltarget_audit.py` to a wave-close gate** (already in `tools/`); it costs
   ~13 min over 461 units and it is the only instrument that sees this class.
3. **Catalog row candidates** (memory dir is read-only for me):
   * *THE DTOR-DEPTH LAW* — the `_vt_`-store discriminator above, plus the
     "gcc emits no out-of-line synthesised dtor" falsification set and the
     `extern "C" ___<len><Class>` supply device.
   * *SAME-NAME-OVERRIDE SILENT SHADOW* — `this->Method()` inside `Class::Method`
     is infinite recursion the compiler, the gate and the board all miss; 50 live
     instances found in one sweep. Grep class: any `this->X(` inside `C::X`.
   * *CASE-BODY ORDER IS A CORRECTNESS SURFACE* — a mis-ordered multi-label group
     silently rebinds N consecutive `jal`s while the instruction stream stays exact.
   * *"the ORACLE is the authority, not the law"* — W64's TextValue base-binding law
     was right in general and wrong at this site.
4. **`sim.cpp`** — see §2; the only open calltarget row.

## 5. Files

`scratchpad/w65a3/`: `dtor{1,2,3,4}.{i,s}` (the CC1PLPSX probes) ·
`implicit_dtor.py` · `qualify.py` · `selfcalls.py` · `ed.py` (line-ending-safe exact
replace) · `spec{1,2,3}.tsv` · `base{1,2}.txt`, `after{1,1b,2}.txt` (gate receipts) ·
`base_calltarget.txt`, `ct{2,3,4}.txt`, `ct_final.txt` (audit trail 143→117→70→14→2) ·
per-file `.bak` backups.
