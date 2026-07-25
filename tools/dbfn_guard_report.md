# w25-a10 regression-guard report — dual-compile splice project (wave 25)

Role: read-only over recon/ source, edit rights limited to `tools/` (never
`build.py`'s splice mechanism itself, never `tools/dbfn_sites.txt`). Verifies
every claim in this report independently via `tools/guard_snapshot.py` +
`tools/guard_diff.py` (new helpers added this session) reusing `build.py`'s
own `compile_c`/`compile_cpp` and `verify_asm.py`'s normalization rules —
i.e. the SAME gate the fleet is scored against, not an approximation.

Tracked scope (kept constant all session, 613 functions, 0 compile
failures throughout): all 14 `recon/syslib/psx/*` subdirectories (393 fns)
+ a fixed 10-file eaclib/game sample (220 fns): `eacpsxz/unhuff.c`,
`sndpsxz/saelib.cpp`, `spchpsxz/spchpick.cpp`, `game/common/{aiphysic,
bworld,audiocmn}.cpp`, `game/psx/{draww,device,sfx,weather}.cpp`.

## 1. Gate bug found and fixed (out-of-band request from the coordinator)

`bulkverify.py`'s `norm()` (and this session's own `guard_snapshot.py`
copy) was missing a constant-literal paren-expr fold that `verify_asm.py`'s
`norm_ins()` — the project's authoritative single-function gate — already
had: the oracle `.s` sometimes prints an unevaluated li-macro hi/lo split
verbatim (`lui $t0, (0x0 >> 16)`, `ori $a0,$a0,(0xF4000001 & 0xFFFF)`)
instead of the folded decimal our compiled side always shows. Ported
verify_asm.py's exact fold into both tools. Verified on the reported
victims (libcard `InitCARD2`/`_patch_card`: NEAR(2)→PASS each, bonus
`_patch_card2` too). Affected-set scope: 4182 occurrences across 701 oracle
files (only the `>>16` / `&0xFFFF` forms exist — no `<<`/`|`/`+`/`-`
variants). Re-ran the full 613-fn baseline before/after: **133 changes, ALL
decreases** (programmatically verified: 0 cases of diffcount-increase or
status-rank-worsening), 0 appeared/disappeared. Commit: `w25-a10 guard:
gate norm() paren-expr fold`.

This shifted the "starting" baseline from PASS=264 (buggy gate) to
PASS=307 (fixed gate) — a survey-accuracy correction, not new project work.

## 2. Mechanism audit (w25-a1's PER_FN_NO_DELAYED_BRANCH dual-compile splice)

Read `tools/build.py`'s `_apply_fn_splice`/`_extract_fn_region`/
`_uniquify_local_labels` and traced the actual `.s`/`.nodb.s` build
artifacts for `libetc/INTR.cpp` by hand.

**Verified correct / non-issues:**
- **jtbl_at_fusion interaction (explicitly asked about)**: SAFE. maspsx
  runs exactly ONCE, over the final post-splice `.s`, regardless of which
  functions came from which compile — `_apply_fn_splice` completes and
  writes the merged text to `s_file` *before* the maspsx invocation, so a
  TU in both `PER_TU_FLAGS` (jtbl) and `PER_FN_NO_DELAYED_BRANCH` gets the
  flag applied uniformly. Confirmed live: `PADENTRY.c` carries both
  (`jtbl_at_fusion` since w23-a11, `PadStartCom`/`PadStopCom`/`PadGetState`
  since w25-a5) with zero interaction problems in the independent re-gate.
- **Fencepost/extraction integrity**: confirmed empirically on INTR.cpp's
  4 spliced functions — exact `.ent`/`.end` boundaries, no swallowed
  neighbor, `.frame`/`.mask`/`.fmask` correctly captured inside the region,
  `.text` file-scope boilerplate between functions correctly left alone.
- **File-scope payload duplication/loss (.rdata, `$LC` strings, `.globl`)**:
  never touched by the mechanism (only `.ent`..`.end` regions are read from
  the flag build; everything else always comes from the normal build) — no
  duplication path exists.
- **Debug-line bookkeeping**: non-issue. `-g1` only emits a single
  file-scope `.file` line, no per-instruction `.loc` records to desync.
- **+4 PASS on INTR.cpp (ResetCallback/InterruptCallback/DMACallback/
  VSyncCallbacks) and +4 on cdcont.cpp (CdSync/CdReady/CdFlush/
  CdDataSync)**: independently re-verified via `verify_asm.py`, digit-for-
  digit match to both commit messages' before/after tables.

**Real gaps found (not live bugs in the currently-merged scope, but
un-enforced hazards for future appliers — flagged for a1/wave lead):**
- **`.rdata` jump-table hazard (TIER-2, no automated guard)**: a spliced
  function's OWN internal `$L<N>` labels get renamed to a collision-proof
  `$L{tag}_{num}` namespace, but a jump table referencing those labels
  lives in `.rdata`, OUTSIDE `.ent`/`.end`, and is only ever taken from the
  normal build (never touched by the splice). If anyone ever splices a
  function containing a `switch`, the renamed in-region case labels would
  no longer match the untouched table's references — likely an assembler
  "undefined symbol" error (safe fail), but COULD silently collide with an
  unrelated same-numbered label elsewhere in the file (unsafe). Currently
  moot — the TIER-1 checklist explicitly excludes switch/interior-branch
  functions and no applier has hit this — but it is enforced only by
  human discipline, not code. Recommend an automated pre-flight assertion
  (reject any splice candidate whose flagged region references a `$L<N>`
  not defined in that same region) before this mechanism scales further.
- **Latent `PER_TU_FLAGS.no_delayed_branch` × `PER_FN_NO_DELAYED_BRANCH`
  overlap**: if a TU ever has BOTH a TU-level `no_delayed_branch: True`
  entry and function entries in the new map, the "normal" build would
  already carry the flag, making the second (flag) compile identical and
  the splice an inert no-op — harmless but silently pointless. No overlap
  exists today (no `PER_TU_FLAGS` entry currently sets `no_delayed_branch`),
  but worth a one-line assertion to keep it that way.
- **C++ dtor mangled-name timing**: `_apply_fn_splice` runs on the raw
  cc1plus output BEFORE the `_._`→`___` dtor-mangling rename step, so a
  future dtor splice candidate's map key must use the pre-rename `_._`
  form, not the final `___` name the SYM/oracle uses. Currently moot (all
  4 landed TUs are `extern "C"`, no mangling), but undocumented — worth a
  one-line note next to `PER_FN_NO_DELAYED_BRANCH`.

### 2b. Empty-map invariance

With the mechanism merged but `PER_FN_NO_DELAYED_BRANCH = {}`: rebuilt the
full 613-fn baseline. **Byte-identical, 0 changes.** (Verified via
`guard_diff.py`; map temporarily emptied/restored in a throwaway edit, not
committed.)

## 3. Continuous integration sweep

Every wave-25 branch (a1–a9) was merged into this worktree as it landed
real work (3 small dict-literal conflicts, all trivial independent
insertions near the same map location — resolved by keeping both sides;
verified `ast.parse` clean + re-gated after each). a5/a6 contributed
nothing beyond a1's merge (confirmed via `git diff` — pure supersets of
what was already integrated).

Every numeric claim in every applier commit message was independently
reproduced via `guard_snapshot.py`/`verify_asm.py` on the affected
directory, not just trusted from the commit text:

| TU | fn | claimed | verified |
|---|---|---|---|
| libetc/INTR.cpp | ResetCallback/InterruptCallback/DMACallback/VSyncCallbacks | FAIL4→PASS ×4 | ✅ exact |
| libcd/cdcont.cpp | CdSync/CdReady/CdFlush/CdDataSync | FAIL4→PASS ×4 | ✅ exact |
| libpress/LIBPRESS.c | DecDCTout | FAIL4→PASS | ✅ exact |
| libpress/LIBPRESS.c | MDEC_status | 8→2 diffs | ✅ exact |
| libcd/cdread2.cpp | _cdread2_ready | FAIL4→PASS | ✅ exact |
| libpad/PADENTRY.c | PadStartCom, PadStopCom | FAIL4→PASS ×2 | ✅ exact |
| libpad/PADENTRY.c | PadGetState (Tier-2) | 16→10 | ✅ exact |
| libpad/PADPORTD.c | _pad_get_port | FAIL3→PASS | ✅ exact |
| libpad/PADMAIN.cpp | _padStopCom, _padClrIntSio0 (Tier-2) | 10→6, 28→24 | ✅ exact |
| libpad/PADCMD.cpp | 3 fns (Tier-2) | 32→30, 24→22, 24→19 | ✅ exact |

**Every one of these was checked against a whole-directory re-gate of ALL
other functions in the same TU (not just the target), confirming the
"zero collateral" claim independently** — every applier's zero-collateral
claim held in every case.

**Negative results independently spot-checked, also accurate:** a3's
libcd Phase-2 (4 no-ops + 2 reverted regressions, comment-only landing),
a4's Phase-2 (13/14 reverted, comment-only), a7's SYS.cpp Tier-2 handoff
(5 reverted, comment-only), a9's libc/libsn/2mbyte survey (PCread/PCwrite
Tier-2 splice tried, regressed 39→45, correctly reverted, comment-only).

### Unexpected-changes list: **EMPTY.** 0 disappeared, 0 appeared, 0
regressions, 0 collateral, across every merge step of the whole session.

### Policy inconsistency flagged for the wave lead (not a code bug)

a1's own commit explicitly states the TIER-2 principle: *"an honest FAIL
beats a smaller-but-structurally-wrong FAIL"* — and a1's own later commits,
a4's Phase-2, and a9's Task 2 all held to a strict **PASS-or-revert** bar
(a4 explicitly reverted `StSetRing` 9→3 and `data_ready_callback` 21→18
*despite* clean net-positive improvement, citing that exact bar).

**a5's 5 commits landed 7 Tier-2 functions that do NOT reach PASS**
(`PadGetState`, `_padStopCom`, `_padClrIntSio0`, and 3 in `PADCMD.cpp`),
citing "the wave lead" as authorizing a looser "net-positive + zero
collateral is sufficient" bar. I independently re-verified `PadGetState`'s
residual diff by hand (`verify_asm.py`) and confirmed it still shows the
exact "naked nop + inverted branch polarity, oracle's shared-tail
`beq...j...li` shape absent" signature a1's commit describes as the
TIER-2 failure mode — i.e. it is smaller but still the
"structurally-wrong" shape a1 warned against, now landed on `main`'s
future merge target rather than reverted.

This is not a regression (nothing that used to PASS broke, no collateral
anywhere) and every individual number a5 reported is accurate — but it is
a real, live policy split between appliers on the identical scenario
(Tier-2, net-positive, non-PASS): a1/a4/a9 revert, a5 lands. Recommend the
coordinator get an explicit wave-lead ruling on which bar is standard
before more Tier-2 entries accumulate under whichever policy an agent
happens to pick.

## Final integrated numbers (613 tracked fns, 0 compile failures, every
step diffed against the step before)

| checkpoint | PASS | NEAR | FAR |
|---|---|---|---|
| session start (buggy gate) | 264 | ~150 | ~199 |
| after gate-bug fix (§1) | 307 | 116 | 190 |
| after full wave-25 integration (§3) | **320** | 104 | 189 |

+13 genuine new byte-PASS functions from the dual-compile splice mechanism
across 6 TUs, +7 more functions measurably improved (smaller diff, one
under the flagged policy split above), 0 regressions anywhere in the
tracked scope at any point in the session.

## GO / NO-GO

**GO** for the coordinator's final merge of the mechanism + all TIER-1
(PASS-reaching) entries — mechanism is sound, empty-map-invariant, and
every TIER-1 claim independently reproduced with zero collateral.

**Two items for the coordinator before calling it fully clean:**
1. Resolve the TIER-2 PASS-or-revert vs net-positive-is-fine policy split
   (§3) — currently a5's 7 non-PASS Tier-2 landings sit inconsistently
   against a1/a4/a9's stricter bar on the identical scenario class.
   Not a technical blocker; a wave-lead call either way is fine, just
   needs to be made explicit and applied uniformly going forward.
2. Consider the two mechanism hardening items from §2 (jtbl-reference
   pre-flight assertion, `PER_TU_FLAGS`-overlap assertion) before the
   fleet scales this mechanism into TUs with more structural variety
   (switches, deeper interior branching) than the epilogue-only shapes
   proven so far.
