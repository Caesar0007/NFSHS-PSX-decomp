# FEMenuDefs.obj exact owner-type-surface receipt

- Pre-change backup commit: `7f5a66dd`.
- Source owner: `recon/frontend/common/femenudefs.cpp`.
- Retail owner: `FEMenuDefs.obj`.
- Canonical type graph: `OK`; 192/192 named records exact, 2/2 anonymous records covered, no missing, mismatched, or extra named/anonymous records.
- The owner surface is composed from the exact retained records rather than the project-wide umbrella. It restores the public `MCRDFILE`, `tArrowLocation[6]`, and `tTextLocation[5]` typedefs and the object-specific method/type surface.
- Four pair-locked code-generation views preserve fields needed by the linked source without claiming retail owner records absent from `FEMenuDefs.obj`: `FEMenuDefs_ScreenMainCodegenView` (1 byte), `FEMenuDefs_ScreenTrophyRoomCodegenView` (344 bytes), `FEMenuDefs_PadCodegenView` (68 bytes), and `FEMenuDefs_GameSetupCodegenView` (444 bytes). The audit accepts each only when both its structure and typedef exactly match the recorded size, rows, and owner header.
- One source expression was corrected to the retail short-width truth test: `(short)tournamentManager.IsTournamentFinished() != 0`.
- Function oracle result: 65/66 PASS, exactly preserving the independently measured pre-change baseline. The only residual is `__15tGlobalMenuDefs`, unchanged at 736 diffs with equal 3207/3207 instruction counts. The destructor and every other function PASS.
- Neighbor regression: `FeMenuOptions.obj` remains graph-exact (165/165 named) and 91/91 functions PASS.
- Frontend/common owner graph after this change: 40/41 owners exact. Only `Front.obj` remains; its 214/214 retail named records are present and exact, but its current umbrella source still emits 332 foreign extra named records plus extra anonymous/typedef records.
- Strict frontend/common source audit: 779/779 explicit functions declaration-clean, 2 implicit aggregate special members accounted for, 190/190 object-owned globals mapped, and zero name, type, storage, ownership, or review findings.
- Repository integrity gates: both relink lanes GREEN; zero calls to undefined symbols in both lanes; zero proven wrong call targets; 513 objects with zero TU-order inversions; no unsafe vtable indexing in 979 files; no post-compiler text moves; phantom audit compiled 513/513 TUs and found 3484/3484 exact oracle symbols, zero hidden phantoms, and zero unmatched ownership gaps.
- No assembly or volatile construct was added to a reconstructed function body. Declaration-only assembler labels bind owner-local debug/codegen views to the already established retail C++ symbols.

Evidence files:

- `femenudefs_type_graph_p290_20260828.tsv`
- `frontend_common_type_graph_p290_20260828.tsv`
- `frontend_common_strict_p290_20260828.md`
