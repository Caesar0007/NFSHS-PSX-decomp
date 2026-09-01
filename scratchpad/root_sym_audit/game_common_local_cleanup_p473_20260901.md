# P473: `MobileSpeaker::Engage` virtual-source restoration

## Result

- `Engage__Q26Speech13MobileSpeakerP8Car_tObj`: PASS, 467/467 instructions.
- `speech.cpp`: 102/102 functions PASS.
- Strict game/common audit: 1193/1193 mapped, missing SYM locals 0,
  declaration-clean 704, extra source locals 1725.
- `Engage` review entry: 81 extra locals before this round, 37 after it
  (44 decompiler-only locals removed while retaining exact code).

## Restored source shape

The SYM contains repeated inlined `this` records around the indirect calls but
does not contain the reconstructed receiver/vtable temporaries.  This agrees
with ordinary source-level C++ virtual expressions.  `Speaker` therefore now
provides zero-local inline virtual ABI bridges for the recovered slots used by
this function (`Report`, `KnownPerp`, `IsSuper`, `StatusCount`, `CarObj`,
`Perp`, and `CallSign`).  These bridges retain the explicit recovered vtable
layout while allowing the caller to express the original semantic operation.

Landed byte-exact restorations include:

- direct `Speech::fSpeakerCar` and `Speech::fMultiplePerps` field access;
- `SetCar(VirtualPerp())`, `VirtualCarObj()->carFlags`, and virtual call-sign
  bank field access;
- semantic `Speech::Dispatch()->fSub` access where allocation was unchanged;
- the dispatch virtual `Report(perp)` call through a zero-local bridge;
- semantic super-cop tests and chain updates;
- semantic dispatch `KnownPerp` / `StatusCount` tests;
- semantic `FindLocation(VirtualPerp())` and `SetSpeed(VirtualPerp())` calls;
- same-perp `StatusCount`, `SetCar`, `CallSign`, and `FindLocation` paths;
- reuse of the SYM `carObj` name for the remaining late virtual-call result;
- removal of unused declarations and the decompiler-only vtable aliases in
  all converted regions.

No `volatile`, non-empty assembly, register pin, or post-compile rewrite was
introduced.

## Retained measured carriers / falsified reductions

- The masked `superFlag` temporary is required for retail's two-instruction
  `andi v0` / `sltiu s0` sequence.  A direct comparison produces either a
  three-instruction bit extraction or the wrong destination/signed compare.
- Collapsing the `bVar4` validation flow into one short-circuit condition
  removes two retail instructions and gives 6 diffs; the original boolean
  carrier/control shape remains.
- Directly embedding reply macro fields gives 12 scheduling diffs; the three
  argument-order carriers remain.
- Directly embedding the reacquired-perp macro fields gives 10 scheduling
  diffs; its pointer/value carriers remain.
- Collapsing the late dispatch virtual-call block into semantic wrappers gives
  37 diffs and one instruction short because argument/receiver evaluation and
  allocation change; its ordered raw carriers remain for a later SLD/QTY
  reconstruction.
- Replacing the second chain traversal carrier with a new `SubChain` local
  changes whole-function saved-register allocation (38-44 diffs); the exact
  carrier is retained pending an allocation-receipted rewrite.

## Global proof

- `tools/relink.py --lane recon -v`: GREEN; 757 objects, 0 real duplicates,
  0 hidden phantoms, 0 unresolved relocations.
- `tools/relink.py --lane src -v`: GREEN; 706 objects, 0 real duplicates,
  0 hidden phantoms, 0 unresolved relocations.
- Undefined-call audit: recon 15781 calls / 0 undefined; source 15779 / 0.
- Data-only payload audit remains 11/11 byte exact, including `vars.obj`.
- `git diff --check`: no errors (repository line-ending warnings only).

The separately linked `front.bin` overlay invariant closed in the same round
is documented independently in `front_overlay_boundary_p473_20260901.md`.
No commit or push was requested or performed.
