# W86-D3 receipt — re-pricing the KEPT frontend + syslib devices with the W85 levers

Gate for every number below (whole-TU, authoritative):

```
python tools/tugate.py <file>
python tools/verify_asm.py <file> <fn>     # focused read
python tools/vdiff.py <file> <fn>          # full unified diff, context 2
```

Harness: `scratchpad/w86/D3_probe.py <relpath> <variantfile>` — applies an
edit-SET (list of old→new pairs) to one recon file, whole-TU gates, always
restores. Variant files `scratchpad/w86/v_*.py`.

## BASELINE (measured first, 2026-09-02, before any edit) — and FINAL STATE

| file | baseline gate | final gate |
|---|---|---|
| `recon/frontend/common/femenudefs.cpp` | 66/66 PASS | **66/66 PASS** |
| `recon/frontend/common/femenu.cpp` | 73/73 PASS | 73/73 PASS |
| `recon/frontend/common/femenuextended.cpp` | 57/57 PASS | **57/57 PASS** |
| `recon/frontend/common/femenuoptions.cpp` | 92/92 PASS | **92/92 PASS** |
| `recon/frontend/common/screencarselect.cpp` | 59/59 PASS | **59/59 PASS** |
| `recon/frontend/common/screencongrats.cpp` | 28/28 PASS | 28/28 PASS |
| `recon/frontend/common/screenmemcard.cpp` | 15/15 PASS | 15/15 PASS |
| `recon/frontend/common/fedialog.cpp` | 33/33 PASS | 33/33 PASS |
| `recon/frontend/common/feinput.cpp` | 4/4 PASS | 4/4 PASS |
| `recon/frontend/common/fetourn.cpp` | 35/35 PASS | 35/35 PASS |
| `recon/frontend/common/fetv.cpp` | 5/5 PASS | 5/5 PASS |
| `recon/frontend/common/feapp.cpp` | 15/15 PASS | 15/15 PASS |
| `recon/game/common/nfs3.cpp` | 11/11 PASS | 11/11 PASS |
| `recon/game/common/speech.cpp` | 102/102 PASS | 102/102 PASS |
| `recon/syslib/psx/libgpu/FONT.c` | FntPrint PASS 240/240, FntFlush FAIL 6 @199/199 | unchanged |
| `recon/syslib/psx/libcd/stcdint.c` | 2/3 PASS (`_st_dma` FAIL 1) | unchanged |

**ZERO PASS broken. 10 `__asm__` devices deleted.** LIBMCRD pins were OFF-LIMITS
and were not touched or measured.

---

## 🏆 THE WAVE'S NEW LEVER — the **ABSORPTION INFLATOR** (pure C, zero bytes)

W85-33A-1 found the idempotent-mask ref inflator (`v &= mask; v &= mask;`) but its
worked example lives inside a LOOP, where the mask register's value is unknown to
cse. **In straight-line code that form is INERT**, measured first here:
`int limM = -1; lim &= limM;` x1..x7 and the `|= limZ` twin x1..x6 all land on the
device-free number exactly (femenuoptions `UpdatefOpenHeight`, 14 diffs), because
cse const-propagates the mask and simplifies `x & -1` → `x` **before**
`flow_analysis` counts the reference (toplev.c runs cse/loop/cse2 ahead of
`flow_analysis`, which is what sets `REG_N_REFS`).

**The fix is the ABSORPTION LAW, which holds for EVERY value of the second
operand:**

```c
v = v & (v | q);       /* == v for any q */
v = v | (v & q);       /* == v for any q */
p = (T *)((int)p & ((int)p | (int)q));            /* pointer form */
b = (T *)((int)a & ((int)a | (int)q));            /* copy form: b == a, but cse cannot prove it */
```

Because `q` is a *runtime* quantity, cse cannot fold the expression away; the insns
survive to `flow_analysis` (which counts the extra reference of `v`), and combine
collapses the AND/OR pair again, so the object is **byte-identical** — count-exact
in every landing below. It is a no-op by ALGEBRA, not by value analysis, so it is
safe for any `q`, pointers included.

Properties measured this wave:

* the operand `q` must be runtime-unknown to cse — a `-1`/`0` constant local is
  folded away and the lever is inert;
* it must sit where the inflated variable is still **LIVE** — the same statements
  at a function tail (`SubtractiveBox`, where `x` and `packetCell` are both dead)
  are deleted before flow counts anything, and moving them to a live point costs
  real instructions (50/72/78 vs the device-free 40);
* the ref gain **SATURATES**: nesting 1/2/3/4 deep is identical
  (`GoToTournTrackInfo` 4 diffs at every depth), depth 6 blows up to 34 — it
  cannot emulate an arbitrarily wide `"r"(x)` xN fence;
* the **operand choice matters**: the same absorption on the same variable is a
  PASS against one runtime value and 22/46 against another (`yOffset` vs `i` =
  PASS, vs `carInfo.fUpgrades` 22, vs the sibling loop's counter 46);
* it is also a **cse EQUALITY KILL** in copy form — this retired
  `MenuExtended_BuyCar`'s and `tScreenCarSelect::DrawForeground`'s opacity
  launders, which W85's dead-reassignment form cannot reach (that one needs the
  variable to be DEAD afterwards);
* devices stay **jointly** priced (33A-3): `GoToDealer`'s three fences are 10/10/2
  singly and 10 together, but two absorption inflators with the third fence simply
  DELETED is a full PASS.

### 🔴 TRIAGE LAW confirmed independently (matches the W86-D1 relay)

A pure-C zero-insn device can only reach passes **at or before combine** (combine
is what makes it free). Reachable: cse value-numbering, loop.c classification,
flow `REG_N_REFS` (hence local/global-alloc, which READ it). Unreachable:
sched1, reload, `reload_cse_regs`, jump2, sched2, reorg. Every failure below fell
on the right side of that line, and every landing was an allocation/cse dial:

| device class | mechanism | this wave |
|---|---|---|
| allocno REF dial | flow REG_N_REFS (pre-combine) | **CLEARED** (lim, yOffset x2, menuDefinitions, cmdType) |
| cse equality / opacity | cse (pre-combine) | **CLEARED** (this_00, currentItemValue, textType) |
| sched2 issue order | post-combine | KEPT (femenu, screencongrats, femenuextended selFade/fade) |
| reorg delay-slot / `stop_search_p` | post-combine | KEPT (FONT @561, feinput, `"i"(0)` boundaries) |
| `reload_cse_regs` const/copy reuse | post-combine | KEPT (FONT @683, speech `$2`) |
| reload spill-register choice | post-combine | KEPT (nfs3 trap pins) |
| sched1 whole-block barrier | post-combine | KEPT (stcdint `_st_dma`) |

---

## LANDED — devices cleared (whole-TU re-gated PASS after every edit)

| TU | function | device removed | pure-C replacement |
|---|---|---|---|
| femenuoptions.cpp | `UpdatefOpenHeight` | `__asm__("" : : "r"(lim) x4)` | `lim &= (lim \| cur);` |
| femenuextended.cpp | `MenuNFS4_DrawTextBox` | `"=r"(textType) : "0"(textType)` | `textType &= (textType \| selected);` |
| femenudefs.cpp | `MenuExtended_GoToDealer` | **all three** fences | 2 absorption inflators; first fence deleted outright |
| femenudefs.cpp | `MenuExtended_GoToSeller` | **all three** (twin) | same recipe |
| femenudefs.cpp | `MenuExtended_BuyCar` | `"+r"(this_00)` | `popUp = (T *)((int)this_00 & ((int)this_00 \| (int)&carManager));` |
| screencarselect.cpp | `DrawForeground` | `"=r"(currentItemValue) : "0"(...)` | `currentItem = (tMenuItem *)((int)currentItemValue & ((int)currentItemValue \| (int)menuDefs));` |
| screencarselect.cpp | `DrawOverlay` | **both** `"r"(yOffset)` fences | `yOffset &= (yOffset \| i);` in each loop |

**10 `__asm__` statements deleted** (3 dealer + 3 seller + BuyCar + lim + textType
+ currentItemValue + 2 yOffset = 12 lines, 10 device sites), 0 PASS broken.
Per-file device census after (comments stripped, symbol-alias `asm("name")`
declarations excluded): femenudefs 12→5, femenuextended 3→2, femenuoptions 4→3,
screencarselect 6+4→3+4.

### Measurement tables (landings)

**femenuoptions `UpdatefOpenHeight`** (PASS 136/136): fence removed 14;
`int limM = -1; lim &= limM;` x1..x7 → 14; `int limZ = 0; lim |= limZ;` x1..x6 → 14;
**`lim &= (lim | cur)` / `lim |= (lim & cur)` / the same against `(int)selected`,
at x1, x2 and x4 → ALL PASS 92/92.** Landed x1 against `cur`.

**femenuextended `MenuNFS4_DrawTextBox`** — all three launders out 4;
`textType &= (textType | selected)` x1 and x2 → **PASS 57/57**. Siblings resist:
`selFade` absorbed against `selected`/`textpix`/`helpText` 20, `dist` 46,
`fSelFade` 4, OR-form 20; `fade` absorbed against any operand 4; all three at
once 26.

**femenudefs `GoToDealer` / `GoToSeller`** — singly: commandPtr/state fence 10,
menuDefinitions fence 10, cmdType fence 2, all three 10. Replacements:
`menuDefinitions` absorbed alone **PASS**; `cmdType` absorbed alone 2; **both
absorbed + first fence dropped PASS 66/66**; both absorbed + first fence kept
PASS; both absorbed + `state` absorbed PASS; both absorbed + `commandPtr`
absorbed 2. Landed the device-free spelling. The seller twin takes the identical
recipe (its all-three-dropped number is also 10).

**femenudefs `MenuExtended_BuyCar`** — fence dropped 12; `popUp` from the
absorption of `this_00` against `&carManager` **PASS**; against `&carInfo` 24;
OR spelling 24; absorbing `this_00` in place before a plain copy 24; a dead
`this_00 |= 0` after the copy 12.

**screencarselect `DrawForeground`** — launder dropped 2 (count-exact 557/557,
`bne s0` vs retail `bne s2`); the absorption copy against `menuDefs` **PASS**,
and so are the OR form, the `FEApp` operand, and absorbing in place before a
plain copy.

**screencarselect `DrawOverlay`** — either yOffset fence removed 74;
`yOffset &= (yOffset | i)` in the first loop **PASS**, in the second loop
**PASS**, and **both together PASS 59/59**; against `carInfo.fUpgrades` 22;
against the other loop's counter `j` 46 (and 46 for x2/OR spellings).

---

## KEEP-with-reason — every kept device re-priced with the NEW levers

**femenuoptions `SubtractiveBox`** (`"r"(packetCell)` + two `x` identity uses) —
the tail placement defeats the inflator: absorbing `x` against `packetCell`/`w`
at the tail x1..x4 → 40 (= plain removal); keeping the packetCell fence and
absorbing only `x` → 40; moving the inflator to a LIVE point (before the
coordinate comma-expression) is WORSE: x1 50, x2/x3 72, x4 78/80.
The `*(volatile short *)&fEnableVal` store stays (W85-S3 semantic store→reload).

**femenu `tMenuItemLeftRightSlider::ProcessInput`** (2 launders) — both out 6;
`volume &= (volume | sound)` x1/x2, `sound &= (sound | volume)`, both directions,
both OR forms → 6; against `(int)keyval` 18; a dead reassignment of both after
the call 6; dead reassignment with one fence kept 4. sched2 issue-order tie.

**femenudefs `GoToTournTrackInfo`** `"r"(manager)` x6 — the inflator takes it from
18 to **4, count-exact 90/90**; residual is purely WHERE the `frontEndState`
address completes (oracle `lui a0,0 … addiu s1,v0,0 … addiu a0,a0,0 … lbu
v0,288(a0) … sb zero,290(a0)`; ours completes `a0` and stores `tier` two slots
earlier). Falsified: nesting 2/3/4 → 4 (saturated), 6 → 34; two separate
statements 20; four/six 46; operands `frontEndBase` / `&command` / `frontEndState`
→ 4; absorbing `frontEndState` instead 32, both directions 20; swapping the two
carrier initialisations 4 (2 with the fence kept); moving the `tier` store after
`amount = tourn->fEntranceFee` → 2 with the inflator AND 2 with the fence.

**femenudefs `GoToSpecialEventTrackInfo`** `"r"(frontEndState),"r"(manager) x6` —
plain removal 18, one absorption of `manager` against `frontEndState` **10**,
absorbing `frontEndState` instead 32, both 24.

**femenudefs the two `"+r"(selectedTourney)` launders** — drop 6; absorbed against
`manager`/`amount` 19, OR-form 19, against `tourn` 6, against `frontEndState` 33.

**femenudefs `EnterUserName`** `*(volatile u_char *)&FEApp->fInputPlayer` — retail
issues TWO `lbu` of the same byte. Plain read 3; absorption spellings
`FEApp->fInputPlayer & (FEApp->fInputPlayer | q)` for q = `menuDefs[0]`, `FEApp`,
and the OR form → 3 (gcc still emits ONE load).

**femenudefs `GoToTwoPlayerSingleRace`** `"+r"(screenState)` — drop 4;
absorbed against `menuDefinitions` 4, against `carSelectScreen` 15.

**femenudefs `GenericMenuLoadGame`** `"m"(FEApp)` — a MEMORY-operand fence; the
absorption lever has no memory analogue. Drop 10.

**femenudefs `AwardPinkSlipsCar`** (2 devices, priced in combination): `"+r"(mgr)`
dropped 2, absorbed against `&frontEnd` 2 (59 when it is the only change);
the statement-expression `"+r"(playerNum) : "r"(fWinner)` absorbed against
`&carManager` 67, dropped 67; mgr dropped + playerNum absorbed 67; both absorbed 67.

**screencarselect** — `"r"(currentItem)` drop 18, absorbed against `menuDefs` 18;
`"+&r"(shapeFade)` drop 8, absorbed against `shapeTicks`/`fadeBase`/both 8;
the `"i"(0)` boundary and the four `ticks` volatile reads are the reorg / IRQ
classes (untouched, W85-S5 verdicts stand).

**screencongrats `CalculatePrizes`** — leading `"r"(carCXBits)` dropped 2, absorbed
against `this` x1/x2 → 2; trailing fence dropped 37, absorbed 37; the sibling
`tScreenTournamentTrophy::CalculatePrizes` launder dropped 6, absorbed 12.
sched2 ready-list class (the leading fence pins `lui a1,16512` at insn 0).

**screenmemcard** — LoadIcon's `"r"(i*0xc0)` x3 GIV dial: drop 12; a `char *row`
local without the inflator 28, with 1/2/3 absorptions 74, with the fence kept 64;
absorbing `i` itself 184. `pulled` launder: drop 3, absorbed against `i` 7,
against `filenum` 58, OR form 58. `DrawVerticalLine` fence: drop 17, absorbed 17,
absorbed on both `shifted` and `x` 16. `DrawHorizontalLine`: drop 17, absorbed
against `test`/`pos` 17.

**fedialog `Draw__11tDialogHelp`** — `"+r"(loadedTicks)` drop 5, absorbed against
`firstTick` 11, OR form 11, **against `this` 3**; `"r"(ticks)` drop 10, absorbed
against `firstTick` x1/x2 10, against `numLetters` 10; both absorbed 11.

**fetourn `UpdateTrackFinishPoints`** `"m"(this->fCompetitors[i])` — drop 20;
absorbing `i` against `stats` 146, against `k` (x1 and x3) 38; a `comp` local
carrying the absorption 32. The `"m"` operand's ADDRESS allocno has no C name.

**fetv `DrawTV`** — the first `"r"(rgbMask) x2` fence: drop 72; absorbed against
`texture` x1/x2/x3 and the OR form **58**; against `packetPtrSlot` 72.

**feapp `MainLoop`** — `"r"(needToSetChildMenu)` drop 6, absorbed (AND and OR
forms, against `i`) 6; `"r"(currentTicks)` drop 6, absorbed against `tick` x1/x2 6;
`"r"(&command[0])` drop 42 (no C name for the address allocno); the `"i"(0)`
boundary is the reorg class.

**nfs3 `NFS3_CheckForFileOperations`** (the two trap-operand `$N` pins) — W85-S3's
certificate says the residual needs `hard_reg_n_uses[$a0]==0`, i.e. the guard bound
left UNALLOCATED, which needs `REG_N_REFS == 2 && REG_BASIC_BLOCK < 0`. The
inflator moves REG_N_REFS the WRONG WAY (it only adds refs), so the ref-dial angle
is aimed away from the gate; what is needed is FEWER refs plus a cross-block
split. Measured with both pins removed: baseline 4; loop bound used directly
(`e` copy deleted, so the bound has 2 refs but both in one block) 7; the
iteration-count form `int n = g - p; do {…} while (--n)` 23; an absorption
inflator on `e` 7; the count form WITH the pins 20. W62-A12's `-dl/-dg` reading
(a RELOAD spill-register choice, `Spilling reg 5. Spilling reg 6.`) is
post-combine, so the triage law says asm-only. **Both pins KEPT.**

**speech `MobileSpeaker::Status`** — the two `"$2"` clobbers (W85-S2's
"highest-value removal target"). Both sites are 2 diffs when dropped
(`addu a1,s1,v0` ours vs `addiu a1,s1,8` retail), count-exact 358. The in-source
W61-A10 note attributes the substitution to **cse** (pre-combine, so in principle
C-reachable), and this wave attacked it on that assumption:
* absorption on the ADDRESS (`&fColour & (&fColour | q)` for q = branchVoice /
  pSVar10 / this, AND and OR forms) → 2 at every spelling;
* the W85 dead-reassignment CSE kill, given the constant a NAME
  (`int eight = 8; if (uVar8 != eight) { eight = 0; … }`, also `= (int)pSVar10`,
  `= (int)uVar8`) → 2 at every spelling — the dead store is eliminated before it
  can invalidate the constant's register;
* a compare spelling that never parks 8 in a register (`(uVar8 ^ 8) != 0`) → 4
  at site 1, 8 with both sites converted (it costs the `li` the ORACLE has).
**KEPT.** Named angle unchanged: the substitution survives every C spelling of
the address AND of the compare, so it is the post-reload constant-reuse family
after all (`reload_cse_regs`), not source-side cse — consistent with the triage
law and with W85-M1's FntPrint finding in the same class.

**FONT.c** (`FntPrint`'s two fences) — the inflator was untried before this wave;
now tried and falsified, exactly as the triage law predicts: the `peel` identity
launder dropped 2, absorbed against `len` (AND and OR) 2, against `bufPtr` 2 —
its whole job is to clear `reload_cse_regs`' `reg_values[$v0]` (post-combine, no
C vehicle); the void-tail `"i"(0)` dropped 1 — its whole job is reorg's
`stop_search_p` (post-combine, ASM-only by construction, W85-33A-4). **Both KEPT**,
FntFlush's certificate untouched.

**stcdint `_st_dma`** — the DICR read-back barrier: dropped 17; an absorption
inflator on `dummy` (x1 44, x2 51) makes it much worse. It is a sched1 whole-block
barrier (post-combine), and in gcc-2.7.2's sched.c only an asm gives one. **KEPT.**

**feinput / screencongrats / screencarselect `"i"(0)` boundaries** — reorg and
jump2 cross-jump classes (post-combine); not re-opened this wave beyond the
numbers above (W85-S5's falsification tables stand).

---

## RULES COMPLIANCE

* No git operations. No edits to `tools/*.py`, `regiondiff/**`, MANIFEST, boards,
  `.github/**`, or any memory file. No new devices of any kind: every landed
  change is plain C (an algebraic no-op expression), no `__asm__`, no `volatile`,
  no register pin, no post-compile move, no build-system intervention.
* LIBMCRD pins untouched (user ruling pending).
* Every removal was gated on the WHOLE TU; every probe restores the file; every
  non-removal is receipted above with the numbers that justify it. Final re-gate
  of all 16 assigned files run after the last edit — table at the top.
* Harnesses/variants: `scratchpad/w86/D3_probe.py`, `scratchpad/w86/v_*.py`.
