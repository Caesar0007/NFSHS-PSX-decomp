# P880 source-restoration checkpoint (uncommitted)

Eleven unsupported local declarations removed across four frontend TUs, with
no replacement names: three Femenudefs dialog aliases, three FEApp aliases,
four ScreenMemcard aliases, and FECredits mainScreen. This removes ten audit
carrier mappings. Five additional false extern array views were removed;
existing scalar declarations now provide the original storage shape.

verify.py/receipts.json independently recompile all four real-path TUs:

| TU | Normal PASS | Whole-object identity |
| --- | ---: | --- |
| femenudefs.cpp | 66/66 | e5f8a1f116f2e9aeecfbf0d2d96c5e4e6a6164caea5ef588aec3690449580fd0 |
| feapp.cpp | 16/16 | aed59b1d17dd6befe6112862e1d2233441c9a484a071c86f50132db2e17ca65a |
| screenmemcard.cpp | 15/15 | fa86b7250da7ac05498145ad09161ae01fb10664eb1c91838aec57401b666c25 |
| fecredits.cpp | 7/7 | a84ea3901e372b00286db36de01e45637d0a72bed38763c0aa27cef55766db70 |

All 104 functions PASS, every branch check is clean, and all program/data/
relocation bytes remain unchanged. Standing relink lanes and source-policy/
vtable audits pass. No header or compiler/assembler setting changed, so this
round uses exact affected-object identity rather than claiming a fresh global
full-build sweep. P879's full-build/1,301-function results remain its own receipt.

Native debug/local and independent raw-reference evidence is in the dedicated
p880_fem_dialogs, p880_feapp, p880_screenmemcard and p880_fecredits directories.
Unresolved inline spellings, exact complete SLD grouping and foreign CodegenView
types remain explicitly qualified there; exact-g alone is not native-source proof.

## Honest audit state

Frontend carrier mappings: 462 -> 452. Game/common remains 478. The previously
exempted lasttick in SetupCurrCredit is still missing as a real local-static
declaration, despite the existing view reaching its data. Removing that
exemption makes the strict frontend count 780 declaration-clean and one missing
name, rather than hiding the gap as 781/zero. Matching has not regressed.
Restoring lasttick's declaration plus single correct backing storage is the
next concrete source/data ownership task.

EXTERN_ARRAY_VIEW_REVIEW.md inventories 100 remaining candidate sites in 37
files for one explicit-asm-label array syntax family. It is a review queue,
not a claim every site is wrong; genuine native arrays must remain arrays.

Clock experiments retained no source change. Stock pre-/post-delay-slot RTL
locates the residual precisely; see ../p880_clock/README.md. No finite failed
probe set is treated as a compiler floor or permission to add a fence.

No commit/push or unrelated edit was made. Existing P879 changes, user files
and compiler intermediates are preserved. The full restoration goal is active.
