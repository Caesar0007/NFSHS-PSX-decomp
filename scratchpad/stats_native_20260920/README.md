# Stats_TrackEndGame — native C replacement, 2026-09-20

The production body in `recon/game/common/stats.cpp` now contains no register
pins, asm statements or volatile accesses. The inspected baseline contained
two pins (`$21`, `$22`) and **four asm statements: three empty-template fences
and one nonempty handwritten minimum sequence**, rather than four empty fences.
All four statements are removed. So are the unproved source locals `raceIndex`,
`raceCar`, `sliceCar` and `sliceTotal`.

## Why the ordinary C matches

Both minimum expressions must use the native slice field first:

```cpp
PlayerSlice = MIN(Cars_gHumanRaceCarList[i]->stats.sliceTotal, trackSlices);
DesiredSlice = MIN(Cars_gRaceCarList[j]->stats.sliceTotal, trackSlices);
```

The existing macro is `((a) > (b) ? (b) : (a))`. With this operand order, the
compiler generates the native load/copy/compare sequence itself and selects
the original registers without constraints. Reversing both operands gives
234 instructions/142 diff lines. Two explicit default/override forms give
223/95. The source also uses a signed `linearVel_ch.z >> 16` instead of a
casted high-halfword memory access. No build flag or declaration was changed.

The NFS2 PC twin confirms the end-game counting pattern but does not contain
NFS4's checkpoint-speed section. It is supporting evidence, not copied as a
substitute for the native NFS4 implementation. The native SYM and retail raw
instructions control this reconstruction; M2C's extra call arguments are
stale caller registers and are not introduced into the source.

## Actual-path checks

- `Stats_TrackEndGame`: **232/232 concrete retail instruction words**, including
  every one of its34 branch checks. All49 real relocations were resolved in
  memory from primary SYM addresses for comparison; no output was rewritten.
- Whole Stats TU: **7/7 PASS, 166 branch checks**.
- Before and after compilation of the actual production path produces a
  **literally identical entire ordinary object**, including data, symbols,
  ordered relocations and metadata. Normal build/cache outputs were not touched;
  generated verification outputs use separate scratch directories.
- All nine recorded source locals match their native types, owning scopes and
  register/stack homes. No extra named source locals remain in this function.
- All six neighbors preserve their full declaration/scope/SLD contracts.
- Every source byte outside the target region, including mixed line endings,
  is preserved. Headers, tools, unrelated edits and the user-owned scratch
  result are untouched. Nothing was committed or pushed.

MIPS HI16/LO16 pairing in the raw checker follows **relocation-record order**,
not instruction-address order. The Cars array HI in the branch delay slot at
800B8F68 pairs with the LO in the earlier out-of-line abs arm at800B8EB4.
The checker refuses missing pairs instead of masking those immediate fields.

## Remaining source/debug recovery — explicitly not complete

Byte matching does not certify the lost original source verbatim.

1. The emitted debug tree reproduces the six native scopes containing all
   named locals, but not one empty inner scope at800B8F08..800B8F80 (depth6).
   Ordinary for/do/condition-controlled while variants tested here rotate the
   loop and give234 instructions/60 diff lines; they were not landed. Adding
   plain inner braces preserves code but the compiler discards the empty scope.
2. Native SLD distinguishes the position call (502) from the comparison (503),
   while the current source attributes them together. The split initialization/
   explicit loop guard also differs from native line500's grouping. Current
   pairwise SLD result improves from **107 merges/141 splits to16/27**, not0/0.
   A compressed same-line loop diagnostic reached16/0 but was not used to hide
   the unresolved source form. No fabricated `#line` directives, helper names,
   dummy expressions, blocks or asm were added to manufacture debug agreement.

Thus the requested pin/asm removal and byte/branch preservation are completed;
full original SYM/SLD source recovery remains open. Keep the native loop/call
scope question in the restoration backlog rather than adding matching carriers.

## Receipts

`final_receipts.json`, `actual.json`, `actual_verification.json`, and
`actual_raw_proof.json` cover the landed source. `actual_before.json` is the
fresh baseline at the actual source path. `backups/` retains the original
source and headers; `inputs/` and per-stage objects retain rejected probes.
`gate.py`, `verify.py`, `raw_proof.py` and `finalize.py` describe the checks.

No shared build-tool modification, compiler-output rewrite or Git operation was
performed. The source edit is limited to this function and its obsolete receipt
comments; the full earlier history remains in the local backup.
