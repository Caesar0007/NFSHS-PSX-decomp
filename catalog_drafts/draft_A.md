# Catalog gap-harvest draft A (first half, gaps #1-71 of 141, sorted alphabetically by cited file)

Source: `python tools/catalog_gapfinder.py` run 2026-07-11 against
`reference_asm_pattern_catalog.md`. Covers the FIRST HALF of `catalog_gaps.txt`'s 141
NOVEL entries: the 21 commit-only entries (no file location) plus all file-cited gaps
from `recon/eaclib/psx/eacpsxz/asinfunc.cpp` through `recon/game/common/aispeeds.cpp:920`
(sorted alphabetically by cited path). Second half (audiocmn.cpp onward) is out of scope
for this draft.

---

## NEW ROWS

Formatted to drop straight into the existing per-section tables (`| symptom | fix | example / §ref |`).

### -> §A (REGISTER COLORING / COALESCING)

| symptom | fix | example / §ref |
|---|---|---|
| oracle re-materializes a LITERAL comparison constant FRESH into the compare reg (e.g. `li v0,K1`) at each of several sequential guard branches inside the SAME loop iteration, rather than treating it as loop-invariant and hoisting it once into a callee-saved reg | **reuse ONE named local for the sequential literal compares**: `cmp = K1; if (cmp < x) {...} cmp = K2; if (cmp < x) {...}` — re-assigning the SAME variable a fresh literal right before each compare defeats gcc's invariant-hoist/CSE (the var "looks written", not loop-invariant), forcing a fresh `li` at each compare site like the oracle. Distinct from the SHARED-CONSTANT-RETURN hoist (existing §A row, which hoists ONE constant for reuse) — this is the INVERSE: preventing a hoist. | AIPerson_LoadGlue `cmp=0x10000;...cmp=0xffff;` (recon/game/common/aiperson.cpp:198, commits 40cef4f/6411e45, 88%→100%) |
| an eagerly-cached global pointer (`ptVar1 = GlobalPtr;` at function top, dereferenced at N later sites) costs/saves a saved register vs the oracle; near-miss residual is a whole saved-reg-count / frame-size mismatch, not a single coloring swap | **drop the eager whole-pointer cache; use a literal `Global->field` dereference at EACH use site** instead of caching the base pointer once — matches the oracle's saved-register count when the oracle re-derefs the global at each access. ⚠️ a 3rd variant exists (address `%hi(Global)` cached in a saved reg, but the VALUE reloaded fresh at each access) that is a genuine §3.15 reload-tie-break FLOOR, not reachable by any source form — only try the drop-the-cache lever first; if the residual is exactly an address-vs-value-cache split, accept it as a floor. | GenericMenuSaveGame (recon/frontend/common/femenudefs.cpp:658, 69→58 diffs); MenuExtended_PurchaseUpgrade (femenudefs.cpp:1401, 94→73 diffs) |
| a 3-way (or N-way) in-place SWAP via a temp (`t=a;a=b;b=t;` repeated for several field pairs) has its temp-store/load order backwards vs the oracle | write each swap's temp assignment in the SAME direction (high-offset-first or low-offset-first) that the oracle's load/store OFFSET PAIRS use — `t=d[hi]; d[hi]=d[lo]; d[lo]=t;` mirrors an oracle that loads the high-offset field first | transpose in-place path (recon/eaclib/psx/eacpsxz/trnspos.cpp:20) |

### -> §B (LOOPS / CONTROL FLOW)

| symptom | fix | example / §ref |
|---|---|---|
| an if/else pair is logically symmetric but ours gets the WRONG branch polarity / block layout: the oracle's beqz/bnez skips the RARE/error/steep-region/failure case (which sits OUT-OF-LINE at the end) and falls straight through the common/success case; ours has it backwards (extra insns, wrong branch sense) even though both forms are behaviorally identical | **the C-level if/else ARM ORDER directly controls beqz/bnez polarity and which arm is pushed out-of-line**: write the block the oracle treats as the SKIP TARGET (rare/error/failure/steep-region) as the `else` (or the branch taken via `goto`/early-exit), and the common/fast/success path as the `if`-BODY so it becomes the fall-through. This recurs constantly across near-misses; check the oracle's branch SENSE (beqz vs bnez) and out-of-line block placement before touching anything else. | intarcsin coarse-vs-steep region (recon/eaclib/psx/eacpsxz/asinfunc.cpp:59); intatan swap-arm (atanfunc.cpp:53); iSPCH_GetPhraseBank byFind-before-byParam block order (recon/eaclib/psx/spchpsxz/spchpick.cpp:137); iSPCH_GetPhraseBank bySub success-fall-through (spchpick.cpp:155); FREE_find forward-walk-as-if-body (recon/eaclib/psx/eacpsxz/memstd.cpp:81); loadfileatadratomic success-as-bnez-target (recon/eaclib/psx/eacpsxz/nsync.cpp:146) |
| a `switch(x){case A: r=..; break; case B: r=..; break;}` dispatch on a small dense int is near-missing: oracle lays out TWO forward `beq`s to OUT-OF-LINE case blocks with a `j` to a shared return, but an `if(x==A){...} else if(x==B){...}` recon inlines the case bodies in place instead | **use a real `switch` statement for the dispatch**, not `if`/`else if` chains, when the oracle shows forward-branch-to-out-of-line-block layout for a small case set — gcc's switch lowering (even for 2-3 cases) produces the forward-beq/out-of-line-block/shared-tail shape; if/else-if inlines bodies at the branch site instead | sizeofbigfileheader / bigcount (recon/eaclib/psx/eacpsxz/locatbig.cpp:52,68) |
| a SINGLE statement (one increment/store) needs its OWN gcc storage/scheduling scope to color or schedule like the oracle, but it isn't naturally inside a block | **wrap the lone statement in `do { stmt; } while (0);`** — not a real loop, but forces gcc to treat it as its own block scope (fresh pseudo-numbering / independent store scheduling), distinct from a bare `{ }` block which doesn't always get the same treatment. Combine with `goto` for the real loop-back edges when the SYM shows nested `do{}while(0)` scopes wrapping goto-loop bodies. | AIScript_ProcessActionsAndReactions `lastReactionIndex` increment (recon/game/common/aiscript.cpp:112); AIPerson_LoadScriptData `loop_2` body wrapped in `do{...}while(0)` (recon/game/common/aiperson.cpp:154, commit 40cef4f) |
| oracle reaches ONE shared error-tail block (identical purge+close+return-0 byte sequence) from TWO+ call sites via what looks like a single label, but writing the shared tail as a real function-scope helper or literal duplication either doesn't merge or diverges | **goto ERROR-TAIL idiom**: write ONE labeled block reached by an explicit `goto` from the site(s) that should JUMP to it, and leave the OTHER identical-body site as **inline straight-line code** (not a goto) — gcc's cross-jump pass merges the inline copy back into the goto target automatically, reproducing the oracle's single shared tail block reached from multiple points. (Confirms the "accept-as-floor" cross-jump note in the catalog intro is beatable for THIS shape — a shared explicit label + one inline duplicate — even though a fully floor-accepted case still exists elsewhere, e.g. iSNDstreamgetstreamptr's un-mergeable dual `jr ra` tails.) | loadbigfileheaderatomic `closefail`/`purgefail` (recon/eaclib/psx/eacpsxz/nsync.cpp:200) |
| a plain top-tested `while(cond)` loop over a `bool`/`char`-typed field near-misses by a redundant PRE-LOOP guard copy (a duplicated entry test with its own `andi`/mask re-application) that a `for`/`do-while` rewrite doesn't reproduce | **keep the plain `while(cond)`** (don't convert to `for`/`do-while`/goto) — gcc-2.8's `jump.c` `duplicate_loop_exit_test` pass duplicates a `while`'s entry test AHEAD of the loop body as its own copy (re-masking a bool/char condition with `andi 0xFF`), which is exactly the oracle's redundant guard block; other loop C-forms don't trigger this specific duplication. | tListIterator::Decrement / tListIteratorIndexed / tListIteratorDoubleIndexed (recon/frontend/common/femenu.cpp:86,177,260) — all SYM `FCN VOID, no locals` |

### -> §C (ARITHMETIC / VALUE CODEGEN)

| symptom | fix | example / §ref |
|---|---|---|
| a round-to-nearest / 2-way constant SELECT written as `x = cond ? A : B;` compiles to a branchLESS strength-reduced bit-op sequence (e.g. `(x>>N&1)+(x>>N+1)`), but the oracle's disasm shows a genuinely BRANCHED if/else picking between the two constants | **write the select as an explicit `if(cond) x=A; else x=B;`**, not a ternary — gcc-2.x strength-reduces an arithmetically-foldable `?:` into branchless bit-ops even when the oracle kept (or the true source used) a branched form; only the literal if/else statement suppresses the fold | intatan round-select (recon/eaclib/psx/eacpsxz/atanfunc.cpp:67) |
| a boolean result near-misses by ONE instruction pair: oracle emits `slti;sltiu` (a "set-not-equal-to-zero"/seq idiom) where ours emits `slti;xori` (or vice versa), for what is logically the same comparison written two ways (`!(x<K)` vs `x>=K`) | **the exact comparison PHRASING selects the idiom**: `bool r = !(x < K);` (negate a strict-less-than) compiles to the `slti`+`sltiu` sequence; writing the DIRECT inverse comparison `bool r = (K <= x);`/`(x > K-1)` compiles to `slti`+`xori` instead. Match the oracle's specific instruction pair by picking the C-level phrasing, not just a logically-equivalent one. | freshenElapsed `!timeNow` (recon/game/common/aih_basiccop.cpp:87); cond5 `5 < timeLeft_` (recon/game/common/aih_btcperp.cpp:342) |

### -> §D (STRUCTURE / CALL SHAPE)

| symptom | fix | example / §ref |
|---|---|---|
| oracle expands a struct-sized region copy as an INLINE unrolled sequence of word/half loads+stores with NO call instruction, but a `memcpy(dst,src,N)` call in the recon adds a real `jal memcpy` (this codebase's `memcpy` is a genuine non-inlined extern, never intrinsic-expanded) | **write a plain C struct assignment `*(StructType*)dst = *(StructType*)src;`** (define a same-sized `struct { int w[N/4]; }` locally if there's no named type) instead of calling `memcpy()` — gcc expands a struct assignment as its OWN inline unrolled load/store sequence, matching the oracle; a real `memcpy()` call is a structural miss (extra `jal` + wrong reg pressure), landed 121→94 diffs when swapped in | iSNDstreamremoverequest packet-compaction copy (recon/eaclib/psx/sndpsxz/sst.cpp:112) |
| a decompiler (Ghidra/m2c) shows a "lost-dataflow" raw register read (`in_a0`/`in_a1`, no defining assignment it can trace) at function entry | it is simply the function's **REGPARM parameter itself** — the decompiler lost the definition because the arg never gets a stack home before its first use. Recognize it as the named SYM parameter directly; don't invent a phantom source for it. | FeDraw_SetABRMode `abr` (recon/frontend/psx/mmeffect.cpp:18, SYM: `abr` REGPARM int) |

### -> §A (RESULT-FUNNEL VARIABLE — return-value shape family)

| symptom | fix | example / §ref |
|---|---|---|
| oracle initializes ONE result variable to a default BEFORE a cascade of independent branch tests, sets it differently in each arm, and has exactly ONE `return` at the end (as opposed to an early `return` per arm, which emits a different tail/epilogue each time) | **result-FUNNEL shape**: `int r = default; if (condA) r = A; else if (condB) r = B; return r;` — matches when the oracle's disasm shows one shared epilogue/`jr ra` reached by every arm (vs N separate returns). This is the mirror image of the existing "direct return, don't extend a temp's live range" row — pick whichever shape the oracle's tail structure (one shared epilogue vs duplicated `jr ra`s) actually shows. | typeofbigfile (recon/eaclib/psx/eacpsxz/locatbig.cpp:37); locatebig (locatbig.cpp:139); FREE_find ring-head (recon/eaclib/psx/eacpsxz/memstd.cpp:81); PinkSlipsPreSave `ret` (recon/frontend/common/femenudefs.cpp:709) |

### -> §F (SCHEDULING / `volatile`-AS-MATCH-LEVER FAMILY)

| symptom | fix | example / §ref |
|---|---|---|
| a near-miss residual disappears ONLY when a plain (non-hardware, non-IRQ-register) memory access is marked `volatile`, in one of these 4 confirmed shapes: **(a)** a struct field genuinely touched by async/IRQ code is re-loaded TWICE / a store isn't sunk into a call's delay slot, where plain C would let gcc CSE/sink it; **(b)** a manual sign-extend shift-chain (`(u8<<24)>>24`) on a byte read collapses back to a bare `lb` unless blocked; **(c)** TWO adjacent, literally-identical stores get dead-store-eliminated (gcc drops the redundant 2nd store) unless blocked; **(d)** a `ptr - 1` pointer correction gets folded into the FOLLOWING load's displacement (1 insn) instead of surviving as the oracle's separate `addiu ptr,ptr,-4` + `lhu val,off(ptr)` (2 insns) | `volatile` is usable purely as a **CODEGEN DEVICE** (not just for real hardware/IRQ memory) to defeat a specific optimizer pass: **(a)** mark the field access `volatile` when it IS genuinely async-touched (semantically correct AND blocks the CSE/sink); **(b)** `*(volatile unsigned char *)&byte` blocks the shift-chain->`lb` idiom-collapse; **(c)** `*(volatile T*)&field = val;` on the redundant store keeps it byte-identical but present; **(d)** `((volatile T*)ptr)->field` on the corrected pointer's final deref blocks the `-1`-into-displacement fold. Same family as the existing `^ zero` runtime-zero idiom (§3.13) — a value-preserving compiler fence, not a hardware claim. | (a) SNDPKTPLAY_stop `+0xc` pitch field / `+0` state word (recon/eaclib/psx/sndpsxz/spktplay.cpp:305); (b) iSNDstreamparsenumchunks `parseIdx` (recon/eaclib/psx/sndpsxz/sst.cpp:231, also needs the scaled-index term listed FIRST in the `+` for `addu`-operand-order tie-break); (c) tDialogYesNo ctor `timeOutTicks` double-store (recon/frontend/common/fedialog.cpp:800); (d) AISpeeds_GetLegalSpeed `speedData-1` deref (recon/game/common/aispeeds.cpp:920, comment tag "H40") |

---

## ALREADY-COVERED

Gap → existing catalog row it duplicates (no new row written; some are additional confirming examples worth folding into the existing row's example list later, noted with "+ex").

- commit `dd1bd0e` (& 0x1f shift-mask Ghidra-ism sweep) → §C "an extra `andi rX,rX,31`... GHIDRA TRANSCRIPTION ARTIFACT — delete it" row.
- commit `7e4261e` ((signed char) sweep, lbu→lb) → §C "`char` IS UNSIGNED on this build... cast at the use site `(signed char)`" row.
- commit `8521faf` (SNDautovol `(signed char)sndgs[0xf]`) → same §C row as above (+ex: SNDautovol).
- commit `cfd31e8` (ProcessActions pin-free, drop register-asm constraints) → catalog header golden rule "No `register T x asm(\"$N\")` arg/value pins — ever."
- commit `189c616` (ProcessActions 73.57→85.92, match oracle SYM local structure) → §A "DECL SCOPE + ORDER ARE LOAD-BEARING" row.
- commit `7d4def8` (AIInit_DeInitAICar, permuter-assisted) → META-WORKFLOW step 5 (permuter) / general permuter-usage rows.
- commit `40cef4f` LoadScriptData half (do-while(0) scoping) → folded into NEW §B row "single-statement `do{}while(0)` scope wrapper" above (counted as new, not covered).
- eacpsxz/fsincos.cpp:12 (inline weight polynomial, plain 32-bit mult not 64-bit widen) → §C "a `mult;mfhi` high part... KEEP the arithmetic un-simplified" row.
- eacpsxz/locatbig.cpp:139,37 (result-funnel var) → counted under NEW §A "RESULT-FUNNEL VARIABLE" row above, not duplicate-covered.
- eacpsxz/nsync.cpp:146 (post-call access via separate local pointer `p`) → §A "take the address into a local pointer BEFORE the call" row (+ex: loadfileatadratomic); the branch-polarity half of the same comment is counted under the NEW §B arm-order row.
- sndpsxz/sdfx.cpp:98 (iSNDplatformfxinit scratch-reg reuse across branch) → §E "TWO global/field address loads... register-materialization FLOOR" row (same tie-break class).
- sndpsxz/sst.cpp:103 (iSNDstreamgetstreamptr, un-merged `jr ra` tails) → catalog intro changelog note "un-merged `jr ra` tails / gcc cross-jumping (sst, MEMMOVE — accept-as-floor)" (explicitly pre-acknowledged, not a table row but already banked).
- sndpsxz/sst.cpp:158 (lui hoist into lw delay slot) → §E "register-materialization FLOOR" row / §3.15 family.
- sndpsxz/sst.cpp:208 (lock-format lwl/lwr vs folded lw/sw) → §E "GENUINE base-anchor FLOOR — accept" row (unexplained toolchain quirk, same accept-and-move-on class).
- sndpsxz/sst.cpp:329 (avail<thresh + STREAM_state fused branch-sense) → §F genuine scheduler/CFG-fusion floor class (six equivalent source shapes tried, byte-identical — same as other §F "accept" rows).
- sndpsxz/sst.cpp:349 (S->$s1 + &sndss scratch coloring) → explicitly self-labeled "same reload/coloring tie-break class as iSNDstreamnumcreated/service" (i.e. sst.cpp:446/158) — same floor, not separately new.
- sndpsxz/sst.cpp:404 (lock-new-rate copy) → explicitly self-labeled "SAME pattern as iSNDstreamparseheader's rate-word copy" (sst.cpp:208) — duplicate of that floor.
- sndpsxz/sst.cpp:446 (iSNDstreamnumcreated &sndss lui/addiu scratch-hop) → explicitly tagged "§3.15 v0-vs-a2 family" — same §E floor row.
- sndpsxz/sst.cpp:547 (bgez delay-slot store-scheduling) → explicitly self-labeled "same class as the lui-scratch/lwl-lwr floors documented above."
- sndpsxz/svol.cpp:18 (iSNDunsafevol delay-slot value choice) → §F genuine gcc-scheduling-choice floor class (declaration-order variants all reproduce identical schedule).
- spchpsxz/spchpick.cpp:144 (array decl → separate-temp load lui/lw) → §A "DECL SCOPE + ORDER ARE LOAD-BEARING" row family (declaring a named local for a global read).
- spchpsxz/spchpick.cpp:198 (plain signed `/8` → bgez/+7/sra) → §C "signed `/256` = bgez;addiu 0xFF;sra 8; signed `/2` = ..." row (same family, different power-of-2 divisor).
- femenudefs.cpp:329 (AskTheUserToSaveTheGame, `^1` cheater idiom + answer-default coloring) → catalog intro's banked "`^1`/xori boolean-negate idiom" note + §F "delay-slot reg-reuse scheduling floor" row (residual explicitly "not source-reachable without a pin").
- femenudefs.cpp:1550 (GenericMenuLoadGame, address-cached/value-reloaded split) → §3.15 reload-tie-break floor (explicitly cited in-source).
- femenuoptions.cpp:1244 (tMenuItemSlidingActivated field-store order for jr-delay-slot fill) → general statement-order/delay-slot-fill family (§F "pointer-local-before-call" / funnel-var neighbors).
- fetools.cpp:11 (unsized-array gp-rel font pointers) → §E "unsized array `extern T g[]`" gp-rel row + §3.15.
- screencongrats.cpp:868 (pass buffer not sprintf's return) → explicitly cites existing §3.12#16 already in the methodology.
- statchk.cpp:450 (`la NewRecords` + separate `addiu 0x1C`, oracle unfused) → §E offset-fusion / bare-displacement family.
- memcard.cpp:436 (`la(+0x260)` anchor, name=+4, base=-0x260) → §A "in-place dead-ptr store" / §E "GENUINE base-anchor FLOOR" family.
- aih_btccop.cpp:1164 (shared literal `1` materialized once for two stores) → §A "SHARED-CONSTANT-RETURN hoist" row (same materialize-once-reuse family, applied to two stores instead of store+return).
- aih_btcperp.cpp:343 (`&&`-value funnel into a fresh var) → §A "fresh result var" row (writing the combined boolean into a NEW local, not reusing an operand).
- aiphysic.cpp:131 (AIPhysic_HitWallCheck, `&&` single-expression + inverted-tail branch polarity) → §A "`&&`/`||` ↔ nested if" row + branch-polarity family; a strong reinforcing example (survived 2 compilers + permuter, only the logic re-expression cracked it) worth folding into that row's example list.
- aiphysic.cpp:283 (AIPhysic_CalculateGear, `__builtin_abs`) → §C "absolute-value idiom... `__builtin_abs(x)`" row (+ex: confirmed portable across both gcc-2.7.2 and gcc-2.8.0).

---

## NON-GENERALIZABLE

One line each — vague/batch commits with no single isolable symptom, pure-tooling changes, or docs-only commits.

- commit `493fae2` "SYM-driven near-miss sweep -- 2 PASS + diff reductions" — multi-fn grab-bag commit message, no single symptom cited.
- commit `910045e` "revert(verify_asm): drop call-target check" — verify-tooling change, not a source recon pattern.
- commit `91c700f` "libcard PATCH nops + anim/bworld/copspeak/nfs3 near-miss fixes" — multi-file grab-bag, no isolable single trick.
- commit `969996d` "6 mid-diff game functions byte-matched (task #78)" — batch commit, no per-fn symptom in the message.
- commit `76e43b4` "~67 functions byte-matched across 6 regions (pattern-DB-triaged fan-out)" — explicitly says it applied EXISTING catalog patterns at scale; no new trick.
- commit `d051f1f` "frontend: byte-match +55 near-misses via 8-way matching fan-out" — batch commit, no single symptom.
- commit `8879e7f` "libcd cdread/stcdint settle + libmath _comp_mant 19->16" — batch of unrelated straggler fixes, no single symptom.
- commit `617df4b` "patch_permuter: make permuter score track objdiff" — permuter tooling change, not a source-level trick.
- commit `eb26097` "docs: add silent-hill-decomp cross-reference" — documentation-only commit.
- commit `4482a45` "AIInit_LoadConfigs 100% match + permuter -j parallelism" — the payload is a permuter tooling/parallelism change, not a new source pattern (the match itself isn't described).
- commit `e2f261a` "auto-match gp_rel/lui global set/return fns (+3, 0.278%)" — automated batch-matcher tooling run, no per-fn symptom.

---

## Counts

- Gaps processed (first half, sorted alphabetically by cited file): **71** of 141 total (21 commit-only entries with no file path + 50 file-cited entries through `recon/game/common/aispeeds.cpp:920`).
- New rows written: **14** (3 in §A coloring, 5 in §B loops/control-flow, 2 in §C arithmetic, 2 in §D structure, 1 result-funnel §A row, 1 consolidated 4-subcase `volatile`-as-match-lever §F row).
- Already-covered: **29** gaps mapped to existing rows (or explicitly pre-acknowledged changelog notes).
- Non-generalizable: **11** gaps (all commit-only, batch/tooling/docs commits with no isolable single symptom).

Draft file: `C:\Temp\nfs4-decomp\catalog_drafts\draft_A.md`
