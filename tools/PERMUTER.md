# Running decomp-permuter on this project

decomp-permuter grinds a near-matching function (objdiff fuzzy 90–99 %) toward a
byte-perfect match by randomly mutating its C and recompiling thousands of times.

EA's `nfs4-f` reconstruction is **cfront C++**, which fought the permuter on three
fronts; all are now handled by the `tools/` glue:

| Problem | Fix |
|---|---|
| permuter's vendored pycparser rejects cfront `(...)`-only prototypes (vtable dispatch casts, PsyQ lib decls) | `tools/patch_permuter.py` adds a `parameter_type_list : ELLIPSIS` grammar production and rebuilds the yacc tables (one-time, idempotent) |
| C++ class bodies / `bool` / `::` / `extern "C"` are unparseable, and sibling function bodies drag them in | `tools/permuter_sanitize.py` strips layout-neutral methods/ctors/dtors, unwraps `extern "C"`, rewrites `::`→`__`, and **reduces the TU to the single target function** + its real (layout-exact) type context |
| `compile.sh` can't be `CreateProcess`'d on Windows | `tools/run_permuter.py` shims `*.sh` invocations to `python tools/permute.py compile …` |

## One-time setup

```sh
python tools/patch_permuter.py        # patch + rebuild the permuter's parser
```

## Per-function workflow

```sh
# 1. create the job: recon module, mangled symbol, its nonmatching .s
python tools/permute.py setup game/common/aiinit.cpp \
    AIInit_DeInitAICar__FP8Car_tObj \
    asm/nonmatchings/main/AIInit_DeInitAICar__FP8Car_tObj.s

# 2. grind (use -j N for N parallel workers; -J is permuter@home, not local cores; lower score = closer, 0 = byte-perfect)
python tools/run_permuter.py permuter_work/AIInit_DeInitAICar__FP8Car_tObj -j 8
```

When it prints `found a match!` (score 0), copy the winning function body from the
printed source back into the recon module, then re-run the objdiff report. Good
targets are the 90–99 % functions in the report (e.g. `AIInit_CleanUp2` 93 %,
`AIInit_InitAICar` 95 %, `AIInit_RestartAICar` 93 %).

`permuter_work/` is gitignored scratch.

## C++ real-inheritance handling (`permute.py::_lower_method`)

`permuter_sanitize.py` flattens `struct D : public B { … }` into
`struct D { B _vbase_; … }` (layout-neutral). A method body's transparent
`this->baseField` (valid C++, since D IS-A B) then no longer resolves in the
lowered plain-C struct, so `_lower_method` walks D's base chain and rewrites
`this->baseField` → `this->_vbase_[._vbase_…].baseField` with **one `_vbase_`
hop per inheritance level** where the field is actually declared.

### Two bugs fixed 2026-07-07 (do NOT reintroduce)
Both surfaced on `tMenuItemSlidingActivated::TransitionOn` (a 2-level chain whose
base declares fields on multi-declarator lines):
- **(a) under-capture** — the field regex `(\w+)\s*(?:\[…\])?\s*;` grabbed only the
  LAST name before each `;`, so `short fW, fH, fOpenHeight, fSlideOffset;` yielded
  only `fSlideOffset`, leaving the other three as bare `this->field` → CC1PLPSX
  `no member named`. Fix: split each `;`-declarator on `,` before extracting names.
- **(b) over-capture / double-hop** — the synthetic `_vbase_` sentinel of a
  base-of-base matched the generic field pattern and got rewritten too, producing
  `this->_vbase_._vbase_.field` for a field only 1 level up. Fix: `discard("_vbase_")`
  from each level's field set, and accumulate the `_vbase_.` prefix per level.

### Verify after touching `_lower_method` (multi-level regression check)
`setup` must produce a base.c that **compiles** (not just parses). Spot-check one
class at each depth — 3-level is the key guard test (walks `_vbase_` 3 deep):
```sh
# 3-level (AIHigh_Base→BasicPerp→Player→Opponent) — MUST compile + show 3-deep hops
python tools/permute.py setup game/common/aih_opp.cpp \
    CheckForWipeOut__15AIHigh_Opponent asm/nonmatchings/main/CheckForWipeOut__15AIHigh_Opponent.s
grep -oE '(_vbase_\.)+' permuter_work/CheckForWipeOut__15AIHigh_Opponent/base.c | sort -u
# expect a `_vbase_._vbase_._vbase_.` line; base score should compute with 0 errors.
```
Verified 2026-07-07 across depths: HumanCop/Opponent (3-level, `_vbase_`×3, compile+run OK),
tMenuItemGoToMenuNFS4Button (4) and tBlankMenuItemNFS4LeftRightChoice (5) both compile clean.

### Known LIMITATION (separate from the field fix — not yet handled)
`_lower_method` rewrites `this->method(…)` → `Class__method(thiz, …)` using the
**derived** class name only. A method that calls a method **inherited from a base**
(e.g. `AIHigh_BTC_Wingman::CheckForActivation` calling `CheckForWingmanRequest()`,
defined on base `AIHigh_BTC_HumanCop`) still emits `Class::method` that the flattened
struct can't resolve → CC1PLPSX `no matching function for call to Base::method(…)`.
Setup succeeds but the compile fails, so **those functions can't be permuted yet**.
Fix would require walking the base chain to find which level declares each called
method and emitting that base's `Base__method` free-fn name. Left for a dedicated
pass. (Distinguish it from bug (a): `no matching function` = this method-call gap;
`no member named` = a field-rewrite regression.)
