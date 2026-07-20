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

## 🔴 Known scorer/gate discrepancy -- ALWAYS re-check a "found match!" against verify_asm

The permuter's own internal score and `tools/verify_asm.py`'s real diff count
**can disagree** (reported independently by a2 and at least 4 other wave-22
agents this session -- a genuinely recurring issue, not a one-off). A
candidate that LOWERS the permuter's score can RAISE the real gate's diff
count, and vice versa. `patch_permuter.py` already applies two scorer
adjustments in this project's favor (reloc-name-leniency in `objdump.py` so
cosmetic name diffs from C++ method-lowering/mangling don't count, and a
15/100 insert-delete penalty rebalance to better track objdiff's per-
instruction model) -- but these bring the *general shape* of the score
closer to objdiff, they don't guarantee per-candidate agreement, because the
permuter's diff algorithm (`difflib`/`levenshtein` over the instruction text,
scored via `src/scorer.py`'s penalty weights) and objdiff/`verify_asm.py`'s
real byte/instruction comparison are still two different measurements of
"how close is this" -- not the same metric wearing two names. **Do not trust
a `[found a match!]`/score-0 or a "best score" print as final** -- always
paste the winning candidate back and re-run `verify_asm.py` (or the
project's real objdiff report) before treating a function as sealed. This is
a per-candidate risk, not a systemic bug with a known single fix; aligning
the scorer exactly to the gate was not attempted this session (would mean
either replacing the diff algorithm with a real disassemble-and-compare
against target.o per candidate -- expensive, changes iteration throughput --
or building a lookup table of known scorer/gate divergence patterns, which
needs a larger sample of disagreeing candidates than any one agent has
collected yet). If you hit a concrete disagreeing pair (candidate text +
both scores), record it here or in your session notes so a future pass has
real data to align against instead of guessing.

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

## C lane (eaclib/sndpsxz/spchpsxz plain-C modules) -- unblocked 2026-07-20

`tools/permute.py setup` now works on `.c` modules exactly like `.cpp` ones --
same two commands, no flag needed:

```sh
python tools/permute.py setup eaclib/psx/eacpsxz/matrix.c \
    reorthogonalize asm/nonmatchings/main/reorthogonalize.s
python tools/run_permuter.py permuter_work/reorthogonalize -j 8
```

**How the lane is selected.** `do_setup` looks at the module argument's
extension (`.c` -> CC1PSX / the "c" lane, anything else -> CC1PLPSX / the
"cpp" lane -- mirrors build.py's own dispatch: `compile_c()` runs on
`src/**/*.c` **and** `recon/**/*.c` -- e.g. `eacpsxz/unhuff.obj`'s C
fallback -- while `compile_cpp()` only runs on `recon/**/*.cpp`, the vendored
C++ reconstruction). The chosen lane is written to `permuter_work/<sym>/lang`
(plain text `c` or `cpp`) alongside `settings.toml`. `tools/run_permuter.py`
reads that file at launch and bakes `--lang <lang>` into `NFS4_COMPILE_DRIVER`
(inherited by `-j` worker subprocesses) and into the `compile.sh` shim, so
`tools/permute.py compile` always knows which compiler to invoke even though
the permuter only ever hands it a randomly-named tempdir `.c` file with no
clue of its own about where it came from. The C lane's `cpp`/`CC1PSX`/maspsx
invocation in `do_compile` mirrors build.py's real `compile_c()` flags
byte-for-byte (`-D__GNUC__=2 -D__OPTIMIZE__ -DPSX`, `-g1 -mgpOPT
-fgnu-linker`, `-I include -I .` for maspsx) rather than the C++ lane's
`-D__cplusplus=1`/`-I recon` set.

**Why the sanitizer needed no changes.** `permuter_sanitize.py`'s C++-only
transforms (struct-scope method/ctor/dtor stripping, `extern "C"` unwrapping,
`::`->`__`, bare-tag typedef aliasing) are all keyed on syntax that plain C
source never contains (no `::`, no in-struct function declarators, no bare
tag types without the `struct`/`union` keyword) -- they were already
no-ops on C input by construction. Likewise `permute.py::_lower_method` only
fires when a function body contains the `this` keyword; a real C function
never does, so it passes through untouched. The only actual C++-only
assumption in the whole toolchain was the **hardcoded compiler/flags** in
`do_compile`/`do_setup`'s preprocess step -- fixed above.

**Proof (2026-07-20, this worktree).** `eaclib/psx/eacpsxz/addtimer.c
addtimer` (small idempotent-registration loop, unowned by any wave-22 agent)
-- `setup` produced a clean `base.c`, `lang=c`, and `do_compile --lang c`
round-tripped it through CC1PSX + maspsx to a valid `.o` whose disassembly
instruction-for-instruction matches the oracle (this fn turned out to
already be a byte-exact reconstruction, just not yet promoted out of
`asm/nonmatchings/`). For a genuine near-miss C target,
`eaclib/psx/eacpsxz/matrix.c reorthogonalize` (base score 180, a documented
gcc-2.8.0 allocator-floor candidate) ran 65 real permuter iterations in ~75s
at `-j 4` with 0 crashes (scores fluctuating 180-1875 as expected of random
mutation on a floor case; some candidates report compiler errors, which the
permuter tracks and continues past -- normal operation, not a lane failure).
Both **C++ lane regressions** re-verified unchanged after the fix:
`game/common/aistate.cpp ApproachTargeting__13AIState_Chasei` base score
**135** and `game/common/camera.cpp Camera_UpdateSplineCam__Fi` base score
**2970** (both match their previously-documented values exactly).

## `sizeof(TYPE) op expr` misparse (fixed 2026-07-20 -- NOT a ctor-inclusion bug)

**Symptom seen:** `setup` on `game/common/aitriger.cpp
InsertTrigger__24AITrigger_TriggerManagerP9trigger_tb` produced a `base.c`
that failed to *compile* (not to reduce/parse) with `CC1PLPSX: no matching
function for call to 'trigger_pathPosition_t::trigger_pathPosition_t(int)'`
-- reported by a13, who reasonably read it as "the reducer is pulling in
constructor code it can't compile."

**Actual root cause (confirmed by testing the vendored parser directly,
outside this project entirely):** it is real ambiguity in decomp-permuter's
own `perm_pycparser` grammar, triggered by plain C -- `sizeof(int) + 4`
mis-parses the *identical* wrong way. `perm_pycparser` folds
`cast_expression` into `unary_expression`
(`p_cast_expression_2: unary_expression : LPAREN type_name RPAREN
unary_expression`), unlike the real ISO C grammar, which keeps
`cast_expression` reachable only *from* `unary_expression`, never the
reverse. Combined with `SIZEOF unary_expression`, this reopens the classic
sizeof/cast shift-reduce ambiguity, and PLY's default shift-preferred
resolution swallows what follows as a cast target:
`trigger->trafficPath.numPoints * sizeof(trigger_pathPosition_t) + 0x40`
was regenerated as `numPoints * (sizeof((trigger_pathPosition_t)(+0x40)))`
-- `+0x40` got folded in as a functional-style cast/construction of
`trigger_pathPosition_t` from `int`, which fails because that class has no
such constructor. For POD sizeof targets the same misparse is silently
harmless (the *value* is unaffected, since sizeof of any int-typed
expression == sizeof(int)), so it went unnoticed until a class type with no
matching ctor hit it. **The reducer/sanitizer never touched
`trigger_pathPosition_t`'s constructor at all** -- the corruption happens
entirely inside decomp-permuter's own parse-then-regenerate step, downstream
of everything in this project's tools.

**Fix (`permuter_sanitize.py::_wrap_sizeof_parens`, called from
`sanitize()`):** wrap every `sizeof(...)` span in a redundant outer paren
pair. Always a semantic no-op in C/C++ (parens around a complete expression
never change type/value/codegen), and it sidesteps the ambiguity because the
token right after the wrapped span becomes `)`, which can't start a cast
target -- nothing left to resolve either way. Verified directly against the
vendored parser: `sizeof(T) + 4 * 2` now correctly parses as
`sizeof(T) + (4 * 2)` (precedence restored, not just the crash fixed).
`InsertTrigger__24AITrigger_TriggerManagerP9trigger_tb` now sets up, compiles
(base score 335), and ran 22 real iterations at `-j 4` with 0 crashes.
Lane-agnostic (applies to both `.c` and `.cpp` modules); likely fixes other
not-yet-reported near-misses using `sizeof(SomeClass) + offset` too.

**Distinct from limit (A) placement-new** (see below): that one is a missing
grammar production (`new`/placement-`new` isn't tokenized/parsed at all --
a hard, immediate pycparser syntax error), not an ambiguous one that silently
resolves the wrong way. Root causes don't share a fix; sizeof was a
paren-wrap workaround, `new` needs either a real grammar addition or a
codegen-provably-neutral text rewrite -- not yet attempted (see below).

## Remaining known limitations

(A) **placement-new blocker -- PARSING/SETUP side FIXED 2026-07-20; full
COMPILE still blocked by (C) for constructors with custom arguments.**
`new`/`operator new(N)`/placement `new(ptr) Class(args)` had zero grammar
support in `perm_pycparser` (NEW isn't even a token) -- any function using
them couldn't reach `setup` at all. Fixed via `permuter_sanitize.py::
_wrap_new_expressions` (transform 5): `operator new/delete(...)` -> plain
`__nfs4_op_new(...)`/`__nfs4_op_delete(...)` calls; placement
`new(PLACEMENT) TYPE(ARGS)` -> `__nfs4_new_TYPE(PLACEMENT, ARGS)` (TYPE
folded into the macro's own NAME, not passed as an argument -- a bare type
name isn't a valid C expression, so pycparser correctly rejected the first,
argument-based design that was tried and discarded; verified against the
real vendored parser before settling on this shape). `do_setup` scans the
reduced base.c for every distinct `__nfs4_new_<TYPE>` and writes them to
`permuter_work/<sym>/new_types`; `run_permuter.py` reads that file (same
mechanism as `lang`) and bakes one inverse `-D` macro per type into
`NFS4_COMPILE_DRIVER`/the compile.sh shim, so `do_compile`'s cpp invocation
expands everything back to the LITERAL original text before CC1PLPSX ever
sees it -- byte-identical by construction, not by hand-substituting a
different construct (a6 was right to reject that approach; this one never
asks "does the substitute compile the same" because there is no semantic
substitute, only a reversible spelling change). Confirmed empirically (not
assumed) what CC1PLPSX actually does with placement-new before trusting any
of this: compiled a standalone placement-new test through the real
CC1PLPSX and disassembled it -- `new(ptr) Foo(v)` (Foo a 2-int-field ctor)
compiles to the constructor's body INLINED directly at `ptr` (this
codebase's placement operator, `lib/nfs4_new.h`, is `inline ... { return
p; }`, trivially optimized away -- no separate placement-operator-new call
exists in real output), and `operator new(N)` compiles to a call to
`__builtin_new` (CC1PLPSX's own GCC-2.x runtime hook name, independent of
the user's own `operator new` declaration).

Second real bug found + fixed in the same pass: `reduce_to_fn` drops every
function *definition* except the target (that's how it keeps `base.c`
pycparser-sized at all) -- but `nfs4_new.h`'s placement `operator new` is
`inline`, i.e. a definition, so it silently lost its own declaration too,
leaving only the single-arg heap `operator new(unsigned)` visible
(CC1PLPSX: `too many arguments to function 'operator new(unsigned int)'`,
found compiling `HighExecute__18AIHigh_BTC_Wingman`). Fixed with `-include
<repo>/recon/lib/nfs4_new.h` added to `do_compile`'s cpp invocation
whenever `new_types` is non-empty -- invisible to pycparser (base.c's own
text never changes), and safe against double-declaration because the
header's own `#ifndef _NFS4_NEW_H_` guard is fresh in that cpp invocation's
own macro namespace regardless of what `do_setup`'s separate preprocessing
pass already stripped.

**Verified:** `setup` on `HighExecute__18AIHigh_BTC_Wingman` (24
`new`-expressions, 4 distinct placement types) now succeeds and correctly
extracts `new_types = [AIState_Base, AIState_Chase, AIState_GotoSlice,
AIState_Normal]`; the "too many arguments to operator new" class of error
is gone entirely. `HighExecute` still does NOT fully compile, but the
REMAINING errors are unrelated to new-expression handling -- see (C) below,
which is the real reason, confirmed by inspecting the reduced `base.c`
directly rather than guessed at.

(B) non-`this` flattened-base field access -- **FIXED 2026-07-20, in two
passes.** `_lower_method`'s base-chain field-redirection walk was hardwired
to `this`/the method's own class. Extracted the walk into
`_redirect_base_fields(text, body, root_cls, accessor)` so it can run once
per (type, accessor) pair instead of just `(cls, "this")`:
  - Pass 1 (a6's repro, `SetupWingman__18AIHigh_BTC_WingmanP19AIHigh_
    BTC_HumanCop`): added one pair per POINTER PARAMETER (`Type *name`,
    any type other than the method's own class), off `name->`.
    `humanCop->carObj_` needed exactly the `_vbase_._vbase_._vbase_.carObj_`
    3-hop path a6 had found by hand. Second bug fixed in the same pass: the
    raw recon text commonly wraps a plain pointer VARIABLE in redundant
    parens before `->` (`(humanCop)->carObj_`, a Ghidra-recon artifact
    `this` never has) -- the first cut silently left such sites
    unredirected (no error, just unfixed); fixed by tolerating an optional
    `(...)` wrap via a captured group.
  - Pass 2 (a15's repro, `CheckForWipeOut__10AIHigh_Cop`): the same gap for
    a LOCAL VARIABLE declared inside the function body
    (`AIHigh_Player *pAVar3; ... pAVar3 = thiz->perpTarget_; ...
    (pAVar3)->carObj_`), not covered by the parameter-list scan. Added a
    regex scan over the whole function body for `Type *name;`-shaped
    declaration statements (comma-separated multi-declarators included) and
    added one (type, accessor) pair per match. `_redirect_base_fields` is a
    safe no-op when `type` doesn't head a flattened hierarchy, so being
    liberal about what counts as a "local pointer declaration" costs
    nothing on a false positive.

Verified both: `SetupWingman` sets up, compiles, and scores (base 20);
`CheckForWipeOut__10AIHigh_Cop` sets up, compiles, and scores (base 315);
the existing 3-level `this->`-chain regression
(`CheckForWipeOut__15AIHigh_Opponent`, `_vbase_` x3) still compiles and
produces the identical 3-deep hop pattern after both passes.

**Do (A), (B), (C) share a root cause?** Partially -- checked directly at
each step rather than assumed, and the answer changed as evidence came in:
- (A) vs (B): **different bugs.** (B) was a semantic/compile-time gap in an
  already-parsing text transform (pycparser had zero problem with
  `humanCop->carObj_`; only CC1PLPSX's flattened-struct member lookup
  rejected it). (A) was a syntax-level gap -- pycparser couldn't even build
  an AST for `new`. Confirmed by inspection: (B)'s fix does nothing for (A),
  since (A)'s failure is upstream of anywhere `_lower_method` runs.
- (A) vs (C): **yes, genuinely connected**, discovered while finishing (A):
  once `new`/`operator new` parse and the placement-operator declaration is
  restored (`-include` fix above), the REMAINING compile errors on
  `HighExecute` are `no matching function for call to
  AIState_Base::AIState_Base(Car_tObj *&)` (candidates: only the implicit
  copy-ctor and default-ctor) -- confirmed by grepping the reduced
  `struct AIState_Base { ... }` body in base.c: its real
  `AIState_Base(Car_tObj*)` constructor declaration is gone. Root cause:
  `permuter_sanitize.sanitize()`'s struct-body method/ctor stripping
  (`_is_method_line`/`_is_method_header`) removes EVERY class's method/ctor
  declarations unconditionally, not just the target method's own class --
  so any OTHER class placement-new (or a direct call) needs a
  non-default-non-copy constructor of, its declaration is gone too, and
  CC1PLPSX's overload resolution has nothing left to match against. This
  IS limit (C) ("call-only-struct member-function declarations") --
  confirmed with a concrete repro (`HighExecute`) rather than left
  abstract. Also affects `AIHigh_BasicCop::CheckSpikeBelt()` calls in the
  same function via the OLD known limitation in `_lower_method`'s
  method-call lowering documented below (derived-class name used instead
  of walking to find which base actually declares the method) -- so
  `HighExecute` is blocked by (A)+(C)+the-old-known-limitation
  simultaneously, and (A) alone was not going to be enough regardless.

(C) call-only-struct member-function declarations -- **root cause now
concretely identified** (see above), not yet fixed. Fixing it safely means
deciding WHICH struct-scope method/ctor declarations `sanitize()` should
keep (their signatures only, still stripping bodies -- keeping bodies would
reintroduce the exact C++ pycparser can't parse) without reintroducing
either (i) parse failures from method syntax pycparser still can't handle
in a bare declaration, or (ii) meaningfully bloating every job's base.c
(the whole "single-function TU" strategy is what keeps pycparser's job
tractable at all -- keeping bodies-stripped declarations for literally
every class is far cheaper than keeping bodies, but still needs to be
proven safe across a range of real TUs before landing). Left for a
dedicated session, not attempted under this wave's regression-critical time
pressure.
(D) packed-attribute-before-tag.
(F) overloaded-name `base.c` duplicate-symbol.
None of (A)/(C)-(F) are C-lane issues -- they affect C++ `.cpp` modules only.

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
