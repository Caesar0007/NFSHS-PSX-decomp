# W86-S1 receipt — SYM/SLD exactness, recon/frontend/common (9 TUs)

Scope: feapp.cpp, fecars.cpp, fecheats.cpp, fecredits.cpp, fedialog.cpp,
feinput.cpp, fememcard.cpp, femenu.cpp, femenudefs.cpp.
SYM source: `C:\Temp\nfs4-psx\nfs4-psx-sym.txt` (the path in the brief,
`C:\Temp\nfs4-psx decompiles\...`, does not exist).
Gate: `python tools/tugate.py <cpp>` after EVERY edit (iron rule).

## Gate state — UNCHANGED, 272/272

| TU | before | after |
|---|---|---|
| feapp.cpp | 15/15 | **15/15** |
| fecars.cpp | 46/46 | **46/46** |
| fecheats.cpp | 10/10 | **10/10** |
| fecredits.cpp | 7/7 | **7/7** |
| fedialog.cpp | 33/33 | **33/33** |
| feinput.cpp | 4/4 | **4/4** |
| fememcard.cpp | 18/18 | **18/18** |
| femenu.cpp | 73/73 | **73/73** |
| femenudefs.cpp | 66/66 | **66/66** |
| **total** | **272/272** | **272/272** |

CRLF line endings preserved in every file (verified byte-wise; one accidental
LF conversion of feapp.cpp was caught and restored immediately).

## Audit method

Three throwaway checkers (session scratchpad, `s1_*.py` — the wave scratchpad
is shared between agents, so everything is namespaced `s1_`):

* `s1_cmp.py`  — SYM `8c` REGPARM/REG/AUTO/STAT names vs the C identifier set.
* `s1_order.py` — SYM **Def-record order** vs the C declaration order.
* `s1_sc3.py`  — SYM **scope depth measured by BLOCK VA RANGE**, not by the
  block record's `line =`.  🔑 The `line =` field is unreliable (gcc emits a
  block at the declarator line for some fns and at the body brace for others,
  and inline expansions emit `line = 1` blocks at the function-entry VA).
  Comparing a block's `[start,end]` VA span against the function's span is the
  robust discriminator: a block strictly narrower than the function is a real
  source scope; everything else is the fn/body scope or an inline artifact.

## Findings

**Names and types were already clean** (earlier waves' SLD work): 0 SYM local
names missing from the C across all 272 fns; every REGPARM name already
present; every SYM type already matched (the apparent `PTR STRUCT` vs `T&`
and `ARG INT` vs `short` hits are C++ references and 4-byte stack-arg slots —
false positives).  This matches the orchestrator relay: the frontend's residual
debt is the **ORDER/SCOPE axis**.

Residual debt found: **31 declaration-ORDER mismatches + 25 SCOPE mismatches**
(after discounting inline-expansion `this` records).

## Edits applied (each individually gated)

### Renames (codegen-free, but gated anyway) — 6 identities / 57 sites
| TU | fn | old → new |
|---|---|---|
| feapp | SetScreen | `this_00`→`currentScreen`, `iVar1`→`slotOffset` |
| fecars | GetStockCar | `uVar1`→`viewable` |
| fecheats | FECheat_ActivateCheat | `ptVar2`→`feApp`, `pcVar4`→`wordText` |
| fememcard | SavePinkSlipsCars | `pCVar7`→`cardInfo` (7 sites) |
| femenudefs | 6 fns | `ptVar1`/`ptVar2`/`ptVar3`→`menuDefsBase`, `this_00`→`dialogAnchor` |

After the femenudefs bulk rename I **restored the historical names inside
comment text** (37 lines) — those receipts describe decompiler identities that
were *removed* by earlier waves, so rewriting them would have falsified the
record; only live-variable references (the carrier headers and BuyCar's own
receipt) carry the new names.  Code now has zero decompiler-style identifiers
in all 9 TUs (remaining hits are comments only).

### Declaration ORDER → SYM 8c Def-record order (carriers moved AFTER the SYM set)
* fecars: `CalcUsedPrice`, `PurchaseCar`, `SellCar`, `PurchaseUpgrade`,
  `AddUpgradesToPinkSlipsList`, `LoadDescription`, `FindSimilarCar`,
  `SavePinkSlipsCars`, `tListIteratorCarColor::Increment`, `…::Decrement` (10)
* fecheats: `FECheat_ActivateCheat`, `FECheat_EncodeString`,
  `FECheat_ActivateBonusByCode` (3)
* fecredits: `DrawCurrCredit` — full 11-local reorder to
  drawFlags/fShowCred/width/x/y/ColTextTitle/ColTextSubTitle/ColText/r/p,p2/buffer,
  with the six measured carriers (frameTick/titleFadeBase/subTitleFadeBase/
  text/pixelWidth/tag) moved after them (1)
* fedialog: `tDialogHelp::CalculateDimensions`, `tDialogHelp::Draw` (carrier
  `bufferPtr` after the SYM set), `tDialogYesNo::Draw`,
  `tDialogYesNoMem::ProcessInput` (4)
* feapp: `Redraw` (carriers `pc`/`pal2` after `r`) (1)
* fememcard: `Init_Memcard`, `LoadGame`, `SavePinkSlipsCars` (3)
* femenudefs: `AskTheUserToSaveTheGame`, `GoToTournTrackInfo`,
  `GoToSpecialEventTrackInfo` (+ `menus` carrier after), `BuyCar` (+
  `dialogAnchor` carrier after), `PurchaseUpgrade`, `DidUserWinBeTheCop`,
  `AwardPinkSlipsCar` (full 5-local reorder + 5 carriers after),
  `ExitPinkSlipsEarly` (full reorder + 3 carriers after) (8)

**30 order fixes, 0 regressions.**

### SCOPE → SYM nested blocks written as real C blocks
| TU | fn | change |
|---|---|---|
| feapp | DrawHelpIcons | `string`,`string2` → the VertHelp block (0x800133a0); `i` → a further nested block |
| feapp | RunPostGame | `ret`,`dummyCars`,`i`,`nBestCarIndex` → the SLD line-5 raceType block |
| fecars | LoadPinkSlipsCars | `i` → the body block (two `Block start` records at fn entry) |
| fecars | SavePinkSlipsCars | `carInfo` stays fn-scope; `i` → the 0x80016c7c block |
| fecars | ValidCar | `trackInfo` → the innermost SLD line-73 `if` |
| fecredits | DrawCurrCredit | `hidden`,`jaguar`,`rollthedice` → the text-scan loop block (0x8003639c); `dist`,`height` → the tail StartedLines block next to the already-nested `width` |
| fedialog | Display, Hide | `i` → the `currentlyOn` guard block |
| fedialog | tDialogInteractive::Run | `keyVal`,`command` → the outer-loop block (0x80019848); `i` → the inner block (0x80019858) |
| fedialog | tDialogHelp::CalculateDimensions | `menu` → the autoGenerate block with showLeftRight/showCross |
| fememcard | SavePinkSlipsCars | `event` → function scope (SYM has it at fn scope, not block) |
| femenu | tMenuConstructor | `p` → the loop block (0x80025440) |
| femenu | tMenu::Draw | `item` → the 0x80025928 block after the title guard |
| femenudefs | PinkSlipsPreSave | `ret`,`answer` → the cheater-guard block |
| femenudefs | FinishedPlayer1GetName | `dummyCars`,`nBestCarIndex` → the `else` block |
| femenudefs | ExitPinkSlipsEarly | `string`,`player` → the `Run()` block |

**16 scope fixes, 0 net regressions.**

### Temps folded
None folded. Every non-SYM local in these 9 TUs already carries a
`SYM-CODEGEN-CARRIER` annotation with a *measured* diff cost from an earlier
wave (feapp 14, fecars 21, fecheats 5, fecredits 15, fedialog 3, feinput 1,
fememcard 17, femenu 14, femenudefs 59).  A cross-check of every "extra" C
declaration against the file's comment text found exactly **one** undocumented
carrier — `perPlayer` in `tFEApplication::MainLoop`, a deep block-local, not a
function-scope invention.  Re-pricing already-measured carriers is W86-D work,
not this lane's, so none were disturbed.

## Regressions hit and reverted (1)

* **femenudefs `PinkSlipsPreSave`** — SYM puts `ret`, `YesNoDialog`, `answer`
  all at the same depth.  Collapsing the extra block around `YesNoDialog` to
  reach that depth **regressed 66→65 (2 diffs)**; reverted.  The partial form
  (ret/answer moved into the guard block, `YesNoDialog` left one level deeper)
  is PASS and is what landed. **Cost of full SYM scope here: 2 diffs.**

## Inapplicable mismatches (with cost / reason)

| Mismatch | Why not applied |
|---|---|
| `__in_chrg` REGPARM on 12 destructors (feapp, fecars ×2, femenu ×8, femenudefs) | compiler-synthesized dtor parameter; not expressible in C++ source. Cost: 0 (no codegen effect). |
| femenudefs `PinkSlipsPreSave` `YesNoDialog` one level deeper than SYM | measured **FAIL 2** (above). |
| fememcard `SavePinkSlipsCarsWithErrorDialogs` `WarningDialog` one level deeper | the nested block is load-bearing: it makes the dialog ctor/dtor fire **fresh every retry iteration** (documented in-file). Flattening changes object lifetime, not just scope. |
| fememcard `SaveGame` `i` — SYM records it at fn scope *and last in the Def order* | mutually exclusive in C++: it is used long before the last declaration position. Left block-scoped (its current form). |
| fememcard `Confirm` `MyDialog` before `putbackon`/`ret` in SYM order | the declaration is deliberately placed after `BringThatBeatBack()` to pin the ctor `jal` position (documented in-file, measured). |
| femenudefs `popUp`/`yesNo` (sym 3 vs c 2), `amount` (sym 6 vs c 0), feapp `m`/`dialog`/`err`/`player`/`carInfo`/`ticks`, fedialog `player`, feinput `tick` | SYM depth inflated by **inline-expansion blocks** (each inlined member call opens its own scope carrying a `this` record). Not source scopes; nothing to apply. |
| fecars `ValidCar` `trackInfo` (sym 10 vs c 3) | the SYM chain runs through 10 nested SLD scopes that the recon expresses with labels/`goto` (required for the retail CFG). Placed in the innermost real `if` — the closest reachable scope. |
| fedialog `tDialogHelp::CalculateDimensions` showLeftRight/showCross/menu (sym 2 vs c 1) | SYM opens **two** blocks (0x80018c38 then 0x80018c60); only one maps to a C construct. Adding a bare extra `{}` was not attempted after the PinkSlipsPreSave result showed such collapses/expansions are codegen-relevant. |
| feapp `Redraw` `emptycommand`/`JustOneToPass` (sym 2 vs c 1) | same inline-expansion depth class. |

## Reusable finding for the wave

**Do not read SYM block nesting off the `line =` field.** gcc-2.8 emits the
function's outer block at the *declarator* line in some functions and at the
*body brace* in others, and every inlined member call opens a `line = 1` block
at the function-entry VA.  Depth computed that way produces systematic
off-by-one false positives and buries the real ones.  Use the block record's
**start/end VA span** relative to the function's span instead — a block that is
strictly narrower is a real source scope; a block spanning the whole function
is the fn/body scope; `line = 1` blocks at the entry VA that carry a `this`
record are inline expansions. (`scratchpad` helper `s1_sc3.py` implements this.)
