# P474: `MobileSpeaker::Engage` chain-local restoration

`Engage__Q26Speech13MobileSpeakerP8Car_tObj` now uses the SYM-recovered
`Sub` name for the first inlined chain traversal and one honest `SubChain`
local for the second chain traversal.  The same `SubChain` remains live across
the later temporary dispatch detach/restore, matching the retail `$s3`
allocation without the previous type-punned voice-pointer carrier.

The explicit goto-shaped traversal is retained because it is the ordinary C++
source shape that reproduces the retail branch/delay-slot schedule.  Replacing
it with a compact `while` loop produced eight instruction-order differences.
No volatile object, executable assembly, register pin, or post-compile rewrite
was introduced.

## Proof

- `verify_asm.py Engage__Q26Speech13MobileSpeakerP8Car_tObj`: PASS, 467/467.
- `tugate.py recon/game/common/speech.cpp`: PASS, 102/102.
- strict game/common audit: 1193/1193 SYM functions mapped, 0 missing names,
  547/547 globals mapped, 115/115 vtable records mapped.
- game/common extra source locals: 1725 -> 1724.
- `audit_data_only_payloads.py`: PASS, 11/11 exact.
- relink `recon`: GREEN, 757 objects, 0 real duplicates, 0 unresolved.
- relink `src`: GREEN, 706 objects, 0 real duplicates, 0 unresolved.
- `git diff --check`: no errors; line-ending notices only.

The frontend overlay remains modeled as a separately compiled and linked
`front.bin` image occupying `[0x80010000, 0x80054548)`.  Its SYM linker records
are `_front_obj/_front_org = 0x80010000`,
`_front_objend/_front_orgend = 0x80054548`, and `_front_size = 0x44548`.
`bigbuf.obj` reserves that load window; `address.obj` publishes the boundary
words outside it.
