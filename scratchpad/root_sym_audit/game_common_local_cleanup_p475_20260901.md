# P475: `speech.cpp` source-shape and SYM-local restoration

This round replaces raw address arithmetic and decompiler temporaries with
the source-visible `Speech` object graph while preserving every retail
instruction in the translation unit.

## Restored source shapes

- `DispatchSpeaker::GetCarBank` and `MobileSpeaker::GetCarBank` now index the
  named `fCarBank.Dispatch` / `fCarBank.Mobile` arrays.
- both `FindClosestLocationTo` overrides use the named location-bank arrays.
- both `CallSign` overrides return the named call-sign members.
- `Speech::Mobile` tests the SYM-confirmed `fBankOffset` readiness member.
- `Speech::SetDelayedStatus` writes `fDispatch->fStatusSub/fStatusCount`.
- `Speech_Server` expresses the virtual `Status()` operation.
- `Speech::CountLocations` now uses its sole SYM local, `d`.
- `Speaker::CalcMph` is restored to the signed C division expression rather
  than the decompiled bias-and-shift sequence.
- `MobileSpeaker::ReActivate` retains the SYM `unit` virtual-result local and
  uses the recovered call-sign layout.
- `MobileSpeaker::Activate` removes two vtable/address decompiler carriers;
  its remaining `iVar3` is explicitly receipted as an allocation carrier.
- `Speaker::Promote` removes its raw dispatch-address carrier.
- all remaining raw `Speech_fgSpeech + 0x...` uses outside the constructor are
  now named `fBankOffset`, `fDispatch`, `fMultiplePerps`, or `fSpeakerCar`
  accesses.

## Measured carrier evidence

- `FindMobile::mobile`: direct repeated member accesses compile four
  instructions shorter and change 20 instructions.
- `FindLocation::advance/offset`: direct substitution adds two instructions
  and changes 92 instructions through GCC quantity/allocation changes.
- `Promote::cont`: direct condition spelling is four instructions shorter and
  changes 14 instructions.
- `Activate::iVar3`: direct call-sign member chaining is two instructions
  shorter and changes 22 instructions.

These are now explicit `SYM-CODEGEN-CARRIER` receipts rather than generic
review dispositions.

## Proof

- `tugate.py recon/game/common/speech.cpp`: PASS, 102/102.
- strict game/common audit: 1193/1193 functions mapped, 0 missing names,
  547/547 globals mapped, 115/115 vtables mapped.
- declaration-clean functions: 704 -> 715.
- unexplained extra source locals: 1724 -> 1706.
- relink `recon`: GREEN, 757 objects, 0 real duplicates/unresolved.
- relink `src`: GREEN, 706 objects, 0 real duplicates/unresolved.
- data-only payload audit: PASS, 11/11 byte exact.
- `git diff --check`: no errors; line-ending notices only.

No volatile object, executable assembly, register pin, or post-compile rewrite
was introduced.
