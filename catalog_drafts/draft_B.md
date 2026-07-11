# Catalog harvest draft B (second half, alphabetically by file)

Scope: `catalog_gaps.txt` NOVEL-list entries 91-150 (60 entries) — from
`recon/game/common/bworld.cpp:689` (BWorld_InitContexts) through
`recon/stdarg.h:1`. Covers the tail of `game/common`, all of `game/psx`,
and all of `syslib/psx` + `stdarg.h`. (Entries 1-90, the commit-log rows
and `eaclib`/`frontend`/head-of-`game/common`, are the complementary
first-half scope — not processed here.)

Each gap entry was opened at its cited file:line, the MATCH/recon comment
and surrounding function body read, and classified against the existing
`reference_asm_pattern_catalog.md` (baseline read before this pass).

---

## NEW ROWS (candidates to fold into the catalog)

### §A. Register coloring / coalescing

| symptom | fix | example / §ref |
|---|---|---|
| a pointer/local needs to land in a specific register the natural source doesn't reach (permuter-plateaued); no ABI anchor, no call, no aliasing reason for a `move` | **NET-ZERO POINTER INC/DEC PAIR** — insert a semantically-void `p++; p--;` (or `p--; p++;`) on the pointer right after its use. It has zero runtime effect but adds a def/use edge that changes the allocator's live-range priority for `p`, pulling it onto the oracle's register. Comment it loudly (`/* net-zero pair forces p into oracle's aN */`) — it reads as dead code otherwise. Permuter-derived; keep verbatim once found, don't "clean up". | BworldSm_UpdateSimQuad (`recon/game/common/bworldSm.cpp:393-395`) |
| a global/field is read ONCE and its value feeds TWO independent tests/uses in the function; oracle caches the FIRST read into a register-web that spans use #1, but RE-READS the source fresh (a second `lw`) for use #2 instead of reusing the cached value — coloring diverges because ours reuses one cached local for both | **SELECTIVE / PARTIAL CACHING** — don't let one C local's live range span both use-sites. Cache the value in a local ONLY for the use-web the oracle keeps it live for (first guard/first consumer); write the SECOND, independent use as a fresh re-dereference of the source (`obj->field` / `slicePos->simSlice->field`) instead of the cached local, even though the value is provably the same. Matches the oracle's own CSE boundary instead of over-CSEing. | CopSpeak_Request `head`/queue-guard split (`recon/game/common/copspeak.cpp:738`); BworldSm_UpdateSimQuad `simIndex` re-read via `slicePos->simSlice` not the cached `pTVar2` (`recon/game/common/bworldSm.cpp:400`) |
| oracle copies a call's raw return value into a FRESH register (`addu v1,v0,zero`) before testing it, then stages the eventual 0/K return constant directly into `$v0`; ours tests the call expression in-place (reuses `$v0`) and stages the return constant via a different reg (`$a0`) with an extra epilogue move — repeats identically at every call site of the same shape | **CANDIDATE LEVER (unconfirmed as of this pass):** introduce a NAMED temp for the call result and test THAT temp, never `f(...)` in-place — `void *r = ReadPad(...); if (r != 0) { ... }` — so the call's `$v0` is explicitly copied out early, freeing `$v0` for the return-constant staging the oracle does. Worth a dedicated pass; the same residual repeats at 3 call sites in one function so one working lever should clear all of them at once. | Device_PSXPadMulti (`recon/game/psx/device.cpp:277-293`, 17/56 residual, all 3 `Device_ReadPad` sites) |
| a fixed-length copy/store block declares its scratch temps as ONE multi-declarator statement (`u_long l0,l1,l2,l3;`) matching the SYM's grouped naming, but colors WORSE than the same names as SEPARATE per-line declarations, even though the VALUES and USE ORDER are identical | grouping declarators in ONE statement vs SEPARATE statements is itself allocator-visible (not just decl ORDER, §3.12 #15 / catalog row 35) — **try both layouts** when a SYM-suggested multi-declarator group regresses; keep whichever the diff count prefers even if it means abandoning the SYM's literal grouping (the SYM's naming is authoritative, its STATEMENT GROUPING is not). | Sfx_AdditivePrim `l0..l3` grouped-decl regression, kept as separate `v0f..v3f` (`recon/game/psx/sfx.cpp:143-148`) |
| a load and the store that consumes it MAY-ALIAS a store that sits between them (a "packet bump" / pointer-advance write) — a coloring-only split-temp lever doesn't explain why the split point is FIXED | when a load/store pair straddles an intervening MAY-ALIAS store, the split isn't a free coloring choice — the LOAD must happen BEFORE the aliasing store and the RESULT-STORE must happen AFTER it (matches the oracle's own ordering constraint, not just its register pick); reproduce the exact same before/after placement, not an arbitrary split point | Flare_2DSpike `rgb` split around the packet-bump store (`recon/game/psx/flare.cpp:1103-1122`) |

### §B. Loops

| symptom | fix | example / §ref |
|---|---|---|
| oracle's zero-trip guard test (`if(n!=0)`) has the loop-counter INIT (`i=n-1`) INSIDE the guard's delay slot, but count var `n` must stay LIVE ACROSS the compare (it can't coalesce with the counter reg) — ours instead computes `i=n-1` unconditionally before/after the guard and `n`+`i` end up sharing a register the oracle keeps separate | **HOIST the counter init ABOVE the zero-guard, not after it**: `int i = n - 1; if (n != 0) { do {...} while (--i != -1); }` — keeping the ORIGINAL count variable `n` live through the `if(n!=0)` test (instead of letting it die right after the subtraction) blocks gcc from coalescing counter and count into one pseudo, giving a fresh `$v0` counter + separate sentinel, with the init landing in the guard branch's delay slot exactly like the oracle. (Inverse of the §B "split the load from the decrement" lever — here the split is BEFORE the guard, not deferred into it.) | `_memset` (`recon/syslib/psx/libgpu/SYS.cpp:104-113`) |

### §C. Arithmetic / value codegen

| symptom | fix | example / §ref |
|---|---|---|
| a boolean-select mask idiom (`uVar = -(u_int)(bool) & N`) that should emit `sltu;negu;andi` un-simplified (matching the oracle) instead gets CONSTANT-FOLDED by gcc-2.8.0 to a plain shift (`bool<<log2(N)`) once the compiler can PROVE the driving value is a strict 0/1 boolean at that point — survives named-bool, inline-recompute, pre-materialized-base-pointer, and `volatile` (which regresses further with a stack spill) | **UNCONFIRMED lever to try:** route the boolean through an OPAQUE/indirect load the optimizer can't range-prove at the mask site (e.g. read it back through a pointer, or via a non-inlined helper) instead of fighting the constant-fold at the source expression that IS provably 0/1. Documented here as a recognized symptom + open lever, not yet verified — don't re-try the already-exhausted list (named bool / inline recompute / pointer-materialize / volatile) before trying opacity. | Device_VerifyType (`recon/game/psx/device.cpp:48-68`, 11-diff residual) |
| a boolean test against 0 (`x <= 0`, or "is this an exact match" on a signed compare result) needs to emit `sltiu` (unsigned) but the natural signed relational (`x <= 0`, `x == 0` compared via `<=`) emits `slti`/`beqz` instead | write the test as an **UNSIGNED RANGE COMPARE**: `(unsigned)x < 1u` (for `x <= 0`) instead of the natural signed `x <= 0` — forces `sltiu` and matches the oracle's unsigned-compare choice for that particular boolean-return idiom. Same family as §3.12 #9 (type controls codegen) but applied at the COMPARISON EXPRESSION itself, not the operand's declared type. | `_cd_cmp_name` (`recon/syslib/psx/libcd/iso9660.cpp:74-77`) |

### §E. gp-REL / data / reloc

| symptom | fix | example / §ref |
|---|---|---|
| a small array is accessed by SOME call sites via a CONSTANT index (oracle reaches them with per-element `%gp_rel(D_xxx)`/`%gp_rel(D_xxx+4)`, no address materialization at all) but by OTHER call sites via a VARIABLE/runtime index (oracle genuinely computes `base+index*stride`, real array codegen) — the array is over the gp-rel size threshold as ONE object but each element alone qualifies | **DUAL-MODEL the storage**: tentative-define ONE scalar PER ELEMENT (§3.12 #6 gp-rel-owner lever, applied per-element) for the constant-index call sites, AND keep the real `T arr[N]` array (0-initialized, written in sync at every mutation site) for the variable-index call sites — both forms alias the same runtime state by construction (every write path updates both), so this is safe duality, not divergence, until the variable-index caller is itself cracked and the array form can be retired. | Weather_gLastProcessTime0/1 scalars + Weather_gLastProcessTime[2] array duality (`recon/game/psx/weather.cpp:16-32`, consumed by Weather_Restart) |

### §F. Scheduling / delay slots / epilogue / stack frame

| symptom | fix | example / §ref |
|---|---|---|
| the oracle's prologue reserves a LARGER stack frame (`addiu sp,sp,-N`) than every DECLARED local in the recon accounts for; SYM shows the function's one real `AUTO` local sitting at a stack offset with unexplained dead space BELOW it (e.g. local at `-8` in an `0x18`-byte frame, only 0x10 of which is "used") | **DEAD FILLER LOCAL** — add an unused local array sized to fill the SYM-implied gap (`int deadfrm[5];` never read/written) purely to reproduce the oracle's `addiu sp,sp,-N` frame size. This is the stack-frame counterpart of the "unused local is load-bearing" pseudo-numbering rule (§3.12 #15/catalog §A row 35) — here the padding controls FRAME SIZE, not register coloring. Confirm the size from the SYM's `AUTO` offset, not by guessing. | Paths_StartUp `deadfrm[5]` (`recon/game/common/paths.cpp:19-20`) |
| EVERY reasonable C control-flow shape for a 2-way select/early-exit (`if/else`, `if(cond) return X; return Y;`, an inverted wrap `if(!cond){...}return Y;`, a `continue`-based loop skip) compiles to the SAME instruction sequence and the SAME branch polarity/layout — but that layout is the OPPOSITE of the oracle's, and no combination reaches it | **JUMP-OPTIMIZATION CANONICALIZATION FLOOR — recognize and stop reshaping.** gcc-2.8.0's jump-opt pass canonicalizes small 2-way selects/early-outs to ONE preferred layout regardless of how the C source spells the condition or which block is written "first" — if you've already tried if/else, early-return, and the inverted wrap and all three produce byte-identical output, this is that canonicalization, not an unexplored structural shape. Accept as a genuine floor (permuter candidate at best); don't keep permuting source polarity variants that are provably isomorphic to gcc's jump-opt pass. | Object_FindDefWithThisID (`recon/game/common/object.cpp:673`, if/else vs continue vs no-else all tie); Device_Analog (`recon/game/psx/device.cpp:338-353`, early-return vs full-wrap tie); Weather_ChangeIntensityBasedOnTime (`recon/game/psx/weather.cpp:328-335`, goto-graph position-vs-polarity tie) |

### §H. Inlined SDK macros

| symptom | fix | example / §ref |
|---|---|---|
| a GTE store macro call (`gte_stsxy`/`gte_stsxy3`/similar `swc2`-based store through a struct field pointer) has the oracle materializing the field's address into a register EVERY call (`addiu vN,base,OFF; swc2 $14,0(vN)`), but ours folds the field offset straight into the `swc2` displacement (`swc2 $14,OFF(base)`) — a fixed per-call 1-insn gap, NOT reproducible via any call-site cast, local pointer, or raw-asm-with-generic-constraint (all fold identically); a hard-coded scratch-register raw-asm perturbs it but is the register-pin anti-pattern and regresses elsewhere | **ROOT CAUSE = the shared GTE macro's asm CONSTRAINT, not the call site.** Real PsyQ 4.3 `inline_c.h` GTE store macros use a `"r"` REGISTER constraint with the displacement hard-coded to `0` in the asm string (`"swc2 $14, 0(%0)" :: "r"(ptr)`) — this FORCES address materialization into a register on every call, no exceptions. This project's `recon/lib/psx_gte.h` instead uses an `"=m"` MEMORY OPERAND (`"swc2 $14, %0" : "=m"(*(int*)(p))`), which lets gcc pick ANY legal addressing mode including folding the offset into the displacement. **Fix at the MACRO level** (`recon/lib/psx_gte.h`, not per call site): change the constraint from `"=m"` to `"r"` with the fixed `0(%0)` displacement, matching the real SDK macro. This is a whole-macro-family fix (affects every `gte_st*` call site across the GTE-heavy render fns), out of scope for a single-file edit but the correct fix once undertaken. | Sfx_AdditivePrim (`recon/game/psx/sfx.cpp:122-141`, 53-diff near-miss root-caused to this; PsyQ reference `C:\Temp\psq43\PSX43\psx\include\inline_c.h:900-912`) |

---

## ALREADY-COVERED (matches an existing catalog row)

| gap entry | file:line | covered by |
|---|---|---|
| BWorld_InitContexts | `recon/game/common/bworld.cpp:689,693` | §A statement/decl-order family (catalog row 35, §3.12 #15d) — naming the `-1` constant as its own local, declared+assigned BEFORE the loop counter, reorders constant-materialization tie-break |
| BWorld_OpenContext | `recon/game/common/bworld.cpp:732,757` | §E "v0-vs-a2" register-materialization tie-break floor (catalog row 98) — a single dead-pointer coloring swap cascading through the whole body, ACCEPT |
| gmesetup.cpp (GameSetup_StartUp) | `recon/game/common/gmesetup.cpp:4` | §A rows 26/31 — index-form-vs-pointer-walk + in-place dead-pointer store; GameSetup_StartUp is literally the catalog's cited example already |
| Draw_DeInitViews | `recon/game/psx/draw.cpp:167` | §B row 56 (label-goto, no-rotation) — explicitly cites this fn as an example already |
| Draw_DeInitViewsInGame | `recon/game/psx/draw.cpp:202` | §B row 56's NUANCE caveat — the negative-result case (12 source shapes tried, no lever reaches the oracle's rotation direction while keeping addressing/stride); documents the caveat, not a new class |
| Draw_StartFrameRender | `recon/game/psx/draw.cpp:450` | §B row 56 family (rotation floor) + §3.25 3d (unscheduled-cc1/CSE-vs-rereads signature) — the tail's "re-read twice vs our CSE" residual matches the per-obj optimization-flag identity note |
| Draw_StopFrameRender | `recon/game/psx/draw.cpp:512` | §B row 56 — explicitly cites this fn as an example already |
| DrawW_AddSubdividPrimGT4 | `recon/game/psx/draww.cpp:88` | §B rows 53/54 (field-fusion + load-N/store-N grouped temps) — GT3 is the cited example, GT4 is the same idiom extended to 4 elements |
| DrawW_AddSubdividPrimGT3 | `recon/game/psx/draww.cpp:112` | §B rows 53/54 — cited example already |
| DrawW_kCtrlWorld_High | `recon/game/psx/draww.cpp:1239` | §B row 52 (lazy in-guard sentinel) — cited example already |
| DrawW_StripDraw_High | `recon/game/psx/draww.cpp:1281` | §B row 51 (exit-in-the-middle no-rotation) — cited example already |
| DrawW_GetAnimationTime | `recon/game/psx/draww.cpp:1589` | §A row 465 ("ours-1-shorter"/permuter-crackable family) — already flagged there as "also a permuter target, not a floor — re-try it" |
| DrawW_DoObjectAnimations | `recon/game/psx/draww.cpp:1695` | §F "load deferred to its single use" row (UpdateVideoWall) + lever #3 (statement order) |
| Hud_BTC_QuitOut | `recon/game/psx/hud.cpp:3789` | §A row 36 / §3.12 #15 (decl scope+pseudo-numbering is load-bearing) — an unused-but-undeclared `row_base` local avoids a low-numbered pseudo that would flip operand order |
| Night_SetPlayerHeadLightColor | `recon/game/psx/night.cpp:287` | §E "v0-vs-a2" register-materialization tie-break (catalog row 98) — explicitly self-cited in the recon comment |
| Night_SetWeatherColors | `recon/game/psx/night.cpp:356` | §E "v0-vs-a2" — explicitly self-cited in the recon comment |
| Sfx_BuildSmokeFacet | `recon/game/psx/sfx.cpp:39` | §F scheduling-floor family (bnez delay-slot fill choice, gcc-2.8.0 -O2 tie-break) — accept |
| Sfx_BuildSouffleFacet | `recon/game/psx/sfx.cpp:213-214` | §I top note — the `/* Handwritten function */`/per-instruction COP2 annotation is noise, not a whole-function marker (91/94 false positives already documented) |
| Weather_SetMatrix | `recon/game/psx/weather.cpp:67` | §A row 36 (SYM block scopes load-bearing, DrawW_WorldSetUpMatrix) — explicitly self-cited |
| Weather_InitSplats | `recon/game/psx/weather.cpp:186,196` | §B row 51 (exit-in-the-middle) + §3.2 (void-return mistype) + statement-order family — the "move splat_i=0 first to fix save order" is the prologue analog of the §F epilogue-restore-order row |
| Weather_Restart | `recon/game/psx/weather.cpp:397` | §3.12 #6 gp-rel tentative-def-per-element lever — this fn IS the mechanism already documented at the top of weather.cpp |
| Weather_TransformVertex | `recon/game/psx/weather.cpp:571` | §B exit-in-the-middle / deferred-compute family — moving `next=s+1` after the break test is the same "defer to single use" shape |
| _cdread2_ready (CdRead2) | `recon/syslib/psx/libcd/cdread2.cpp:22` | §3.2 void-return-mistype lever ("void→int can regress... check: does the fn already match as void?") |
| PATCHGTE.cpp (_patch_gte) | `recon/syslib/psx/libgte/PATCHGTE.cpp:13` | §G hand-asm transcription family (file-scope `__asm__`, double `.set noreorder`) — already the established methodology for genuine SYM-`.ASM`/BIOS-workaround code |
| _padCmdSetMap / _padCmdGetDescR0 | `recon/syslib/psx/libpad/PADCMD.cpp:75,87` | §A SHARED-CONSTANT-RETURN row (catalog row 29, methodology #17) — same `_padCmd*` family already cited (`_padCmd4B`/`_padCmdGetStatus`) |
| _padSetActAlign | `recon/syslib/psx/libpad/PADCMD.cpp:304` | §A SHARED-CONSTANT-RETURN row — same lever, oracle re-materializes via a fresh `li` rather than a `move`, still the "hoist `r=K` before both uses" fix |
| _padSetMainMode_snd | `recon/syslib/psx/libpad/PADCMD.cpp:386` | §B label-goto / §A flat-descending-guard-chain family (catalog rows 37/56) — multi-way dispatch via goto/case labels matching the oracle's beq-chain layout |

## NON-GENERALIZABLE

| gap entry | file:line | reason |
|---|---|---|
| func_va_data.cpp header comment | `recon/game/common/func_va_data.cpp:4` | data-materialization pass description (§3.8b/methodology data-mat practice), not a code/asm diff pattern |
| FIRST.cpp (`firstfile`) | `recon/syslib/psx/libapi/FIRST.cpp:14,20` | documented "WALL" — a multi-cause structural near-miss (single-pass-vs-two-pass CFG rewrite needed, the signed-char cause is already covered separately, and a magic-divide-constant difference for `/0x50` that isn't root-caused) deferred as out-of-scope; no single reusable lever to extract yet |
| SPRINTF.cpp (`sprintf`) | `recon/syslib/psx/libc/SPRINTF.cpp:12,13` | documented "WALL" with no concrete lever — a 558-insn parser deferred as future work; explicitly notes a sibling-toolchain reference (SOTN sprintf.c) was tried and is the WRONG shape here |
| INTR.cpp (`SetIntrMask`) | `recon/syslib/psx/libetc/INTR.cpp:123` | models the true pointer-indirection shape of a BIOS mask register (`g_imask_ptr`) — a semantic-fidelity/oracle-args-first correction, not a new byte-match lever |
| SYS.cpp (`_set_draw_mode`) | `recon/syslib/psx/libgpu/SYS.cpp:127` | documented, unresolved 5-diff floor ("coloring and or-operand order are coupled; this basin's 5 is the floor") — multiple source variants tried and reverted, no working fix to extract |
| stdarg.h | `recon/stdarg.h:1` | vendored PsyQ 4.3 SDK header, not a diff pattern |

---

## Counts

- Gap entries processed: **60** (catalog_gaps.txt NOVEL list entries 91-150: `BWorld_InitContexts` through `stdarg.h`)
- New symptom→fix rows drafted: **9** (spanning §A ×5, §B ×1, §C ×2, §E ×1, §F ×2, §H ×1 — table above; some rows absorb 2-4 gap entries that share one root cause, e.g. the 4 `Device_PSXPadMulti` lines → 1 row, the 4 `Sfx_AdditivePrim` lines → 2 rows)
- Already covered by an existing catalog row: **28** entries (27 distinct functions/files)
- Non-generalizable (no reusable pattern, or pure documentation/floor with no extractable fix): **8** entries (6 distinct files)
