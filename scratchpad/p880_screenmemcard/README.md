# P880 screenmemcard scalar-global/source cleanup

Removed four unrecorded locals while preserving every byte of the whole object:

- `tScreenMemcard::Initialize`: removed `menus` and `feApp`; direct scalar menuDefs/FEApp member accesses now reproduce the retail load web.
- `tScreenMemcard::Cleanup`: removed `menus` and `iconTable`; direct menu-field updates and `purgememadr(fMemIcon)` reproduce the retail early load and store scheduling. The generated function now has only native `this`, no extra local records.
- Removed the CPP-local `A_FEApp[]` asm-label declaration and `#define FEApp A_FEApp[0]`; the existing scalar pointer extern is used instead. No new asm/volatile/helper identifier or instruction rewrite was added.

## Authoritative evidence

Native Initialize record6f9e5a has this REGPARM16, only named local i INT/REG6 (6f9f5b), frame24/mask80010000. Native i scope is80047d50-80047da8. Final debug preserves that register/type and exact machine scope (+288..+376); msgId remains an explicitly unresolved source-only U_INT/REG7 carrier. Cleanup6f9f85 has this REGPARM16, no locals, frame24/mask80010000; final debug now matches that local list.

Native FEApp4b4f01 is one EXT PTR STRUCT tFEApplication at800514c0, target size896; `screenmemcard_externs.h:35` already supplies a scalar pointer extern. This round removes the contradictory CPP-local array view. It does **not** restore the complete foreign type: `screenmemcard_types.h` still maps tFEApplication to ScreenMemcard_FEApplicationCodegenView, and tGlobalMenuDefs to its private CodegenView. Those separate type backlogs are unchanged.

The M2C per-function bodies80047C30/80047DD8 confirm the queues/flags/calls and the two field offsets3054/3080; raw oracle is the arity/address authority (M2C prints stale call arguments). IDA's bodies have broken const-memory propagation in these particular functions, so they were not used to override native/raw evidence.

## Verification

- Baseline and final whole TU: **15/15 PASS**, **0 branch divergences**.
- Initialize: **106/106 PASS**, exact -g twin. Cleanup: **25/25 PASS**, exact -g twin.
- Whole actual object before/after is byte-identical: SHA256 `fa86b7250da7ac05498145ad09161ae01fb10664eb1c91838aec57401b666c25`.
- Old-source isolated -g and final -g both retain the exact whole6972-byte text section and identical text relocation records.
- All **131 linked analysis words** across both functions equal raw `rom/nfs4-f.exe`; all131 oracle-comment words independently equal the same raw bytes. All52 relocation sites were resolved, including the native FEApp/menuDefs/fMemIcon targets and the byte-checked `records` string. Only in-memory copies were linked for comparison; no emitted object was rewritten.
- Full native-versus-generated line maps are saved. Neither final function has a generated source group that merges distinct native lines. FEApp's pointer load and input-player access now belong to the same correct native803 expression. Full SLD is not claimed: native811 inline expansion grouping and empty lexical blocks remain incompletely represented.

## Failed probe and remaining work

The direct conditional field assignment replacing msgId still gives **31diff,107/106 instructions** under scalar menuDefs; it was restored. The previous43diff receipt was an older array-global basin, not a permanent limitation. Existing `tMenuItem::SetTextDescription` in fe_core_types.h (currently enabled only for screencarselect) suggests an inline argument-before-receiver evaluation route, but target SYM does not prove that helper name. No header activation or invented helper was added.

Other pre-existing CPP-local array views (ticks/CURRENTLYUSINGMEMCARD/layout ints), source carriers in unrelated functions, and foreign private CodegenViews remain. This round is not a claim that the whole file is SYM-exact or source-restored.

## Artifacts and ownership

`receipt.json` summarizes results; `raw_debug_receipt.json` contains every reference, generated local list, block offsets and before/after/native line map. Focused function snapshots and the failed ternary are included; `screenmemcard.cpp.before` is the untouched full-file backup. `verify_receipt.py` compiles only its old-source debug snapshot in scratch and reads the normal/final-debug objects. It uses the P879 ELF reader definition without executing P879 compiler code.

Only `recon/frontend/common/screenmemcard.cpp` was changed in production. P879 bank headers and other agents' edits were untouched. Source is frozen, no commits/pushes made; root consolidates. Do not stage generated compiler `.i/.s/.o` intermediates by default.
