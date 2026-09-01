# P496: four-TU one-extra-pair closure

Eight one-extra-local findings across `anim.cpp`, `bworld.cpp`, `render.cpp`,
and `souffle.cpp` are now resolved without changing any retail instruction
stream.

## Exact source restorations

- `AnimScript::GetTimedAnimPosRot(coorddef *, matrixtdef *)`: return the
  overload call directly, removing `iVar1`.
- `AnimScript::GetTimedAnimPosRot(int, ...)`: reuse the SYM-recorded `tmp` for
  the tick delta before its later matrix-element swaps, removing `ticks`.
- `Render_RenderWorld`: use the SYM-recorded integer `savesp` for all three
  `SetSp` save/restore pairs, removing `pvVar1`.
- `Render_RenderPauseMenuView`: use the SYM-recorded `ogFlip`, removing
  `iVar1`.
- `GetGustWind`: mask each `random()` result directly into its destination,
  removing `uVar1`.

## Measured retained carriers

- `BWorld_InitContexts::noClient`: the existing receipt proves that the
  declaration-first named `-1` is needed to schedule `li a3,-1` before
  `li a2,1`; the direct literal gives the former two-diff ordering.
- `BWorld_Init::random`: moving `rand()` into the two `numLaps` arms duplicates
  the signed-division expansion, growing 187 instructions to 191 and producing
  24 word diffs.  The result must remain live across the branch.
- `Souffle_Add::limit`: a direct literal emits one fewer instruction and 17
  word diffs (`slti` instead of retail's named-constant `li` plus `slt`).

## Proof

- All eight selected functions individually pass `tools/verify_asm.py`.
- TU gates: `anim.cpp` 18/18, `bworld.cpp` 21/21, `render.cpp` 23/23,
  and `souffle.cpp` 10/10 PASS.
- `tools/brdist.py`: zero branch-distance/count divergences in every affected
  translation unit.
- Strict P495 -> P496: declaration-clean functions 847 -> 855; unexplained
  extras 1453 -> 1445; missing names remain 0.
- Explicit codegen carriers: 134 -> 137.
- Type/storage findings remain 0; globals remain 547/547 and vtables remain
  115/115.
- `tools/relink.py --lane both -v`: GREEN, with no real duplicates, hidden
  phantoms, or unresolved relocations.
- Data-only payload audit: PASS, all 11 members byte exact.
- `git diff --check`: no errors (repository line-ending warnings only).

No commit or push was performed.
