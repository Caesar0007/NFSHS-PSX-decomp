# frontend/common local declaration closure (P443, 2026-08-31)

The live strict audit exposed five residual declaration dispositions in three
already byte-exact functions.  All five had existing binary/compiler evidence;
this round made that evidence machine-checkable without changing executable
source:

- `GetPSXPadValue::acc2` is the second function-scope accumulator required to
  reproduce retail's two distinct cross-jump allocation trios.  Its existing
  combined `acc1/acc2` note was split into two validated
  `SYM-CODEGEN-CARRIER` markers.
- The three SYM `child` records in `tGlobalMenuDefs::tGlobalMenuDefs` are locals
  of the inlined `A1_SetChildMenu` helper.  A `SYM-INLINE-LOCAL` receipt now
  resolves the helper and verifies that ctags finds its real `child` parameter.
- Constructor locals `memoryMenu` and `userNameMenu` preserve the measured
  retail spill/pointer-reuse shape.  Their receipts were duplicated at a
  stable early body position because a historical CRCRLF tail made the audit's
  source-line slice miss the original comments.
- `tScreenCarSelectTwoPlayer::DrawBackground::loading` is the measured named
  read that blocks an otherwise incorrect GCC `jump.c` equivalence.  Its
  existing branch-distance receipt now has an explicit carrier marker.

## Verification

- Strict `frontend/common` audit: 781 SYM functions; 779 explicit source
  definitions mapped and declaration-clean; the other two are correctly
  recognized implicit `tAllScreens` constructor/destructor emissions; zero
  missing/extra locals, zero type/storage findings, zero mapping review, and
  missing/extra globals 0/0.
- Whole-TU authoritative gates: `front.cpp` 43/43, `femenudefs.cpp` 66/66,
  and `screencarselect.cpp` 59/59 PASS.
- Both relink lanes GREEN with zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols.
- Undefined-call audit: recon 15,781 and src 15,779 call relocations, zero
  undefined targets.
- Full phantom audit: 518/518 TUs compile; all 3,491 oracle symbols exact;
  zero hidden phantoms and zero ownership gaps.
