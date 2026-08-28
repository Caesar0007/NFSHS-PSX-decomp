# Front.obj exact owner-type-surface receipt

- Pre-change backup commit: `80143f87`.
- Source owner: `recon/frontend/common/front.cpp`.
- Retail owner: `Front.obj`.
- Canonical type graph: exact; 214/214 named keys, 2/2 anonymous records, zero missing, mismatched, or extra records, and zero parse issues.
- The reconstruction reuses Front's 189-record intersection with the exact `FEMenuDefs.obj` graph, suppresses the three FEMenuDefs-only owner records, and restores the 25 Front-specific records, including the complete 15,320-byte `tAllScreens` graph.
- Five pair-locked foreign code-generation records are accepted only when their structure, typedef, size, rows, and owner header all match: `tFEApplication` (896 bytes), `tGlobalMenuDefs` (15,128 bytes), `tCreditManager` (56 bytes), `Front_MissionManagerCodegenView` (8 bytes), and `Front_GameSetupCodegenView` (2,600 bytes).
- Function oracle result: all 43/43 `Front.obj` functions PASS. This includes the implicit 262-instruction `tAllScreens` constructor and 116-instruction destructor.
- The call-target gate exposed one byte-neutral but semantically wrong constructor relocation (`tScreen` instead of `tScreenMemcard`). Restoring the retained `tScreenMemcard` constructor declaration preserves PASS and produces the exact retail target. Final wrong-call-target count: zero.
- Whole `recon/frontend/common` canonical owner sweep: 41/41 `OK`; every owner has all retail named records exact, both anonymous records covered, and no extra named/anonymous records or typedefs.
- Strict frontend/common source audit: 779/779 explicit functions declaration-clean, two implicit aggregate special members accounted for, 190/190 object-owned globals mapped, and zero name, type, storage, ownership, or review findings.
- Repository integrity gates: both relink lanes GREEN; zero calls to undefined symbols in both lanes; zero proven wrong call targets; 513 objects with zero TU-order inversions; no unsafe vtable indexing in 980 files; no post-compiler text moves; phantom audit compiled 513/513 TUs and found 3484/3484 exact oracle symbols, zero hidden phantoms, and zero unmatched ownership gaps.
- No reconstructed function body was changed. Declaration-only assembler labels preserve established retail C++ linkage where an owner-local source spelling intentionally uses an integer or code-generation view instead of an absent foreign tag.

Evidence files:

- `front_type_graph_p291_20260828.md`
- `frontend_common_type_graph_p291_20260828.tsv`
- `frontend_common_strict_p291_20260828.md`
