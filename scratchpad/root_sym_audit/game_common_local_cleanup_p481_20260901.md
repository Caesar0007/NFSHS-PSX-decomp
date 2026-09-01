# P481: `LocationBank::Distance` and `Speech::SubmitRequest` closure

This round reconciles two `speech.obj` functions with their complete SLD local
shape while retaining exact retail code.

## `LocationBank::Distance`

SYM records only the implicit `this` receiver and `slice`; the exact retail CFG
nevertheless requires four optimized compiler quantities to keep one shared
circular-distance minimum tail.  Their source spellings do not survive SYM and
therefore cannot be claimed as original names.  The reconstruction now marks
`start`, `end`, `forward`, and `backward` as explicit source-only codegen
carriers with measured receipts:

- no-local direct `MIN` returns: 36/37 instructions, 19 diffs;
- only `forward`/`backward`: 39/37 instructions, 26 diffs;
- retained four-quantity form: PASS 37/37.

This removes the function from the generic review queue without presenting
unrecoverable carrier spellings as SYM facts.

## `Speech::SubmitRequest`

The SLD nested scopes at the bank lookup and direct-request call contain:

- `Speech *this`, `long bank`;
- a second `Speech *this`.

Those records are now represented by recovered inline member operations
`BankOffset(long bank)` and `FileHandle()`.  The former replaces the explicit
`pThis`/`bankStart` block; the latter removes `pThis`, `requestFile`, and
`requestCar` from the request arm.  Because the helpers are fully inlined, SYM
and the retail image prove their receivers, parameter, operations, and codegen
but cannot prove their linkage spellings; the helper names remain explicit
source-shape inferences.

The existing guide-authorized zero-byte value fence remains after `BankOffset`
to preserve GCC 2.8.1's retail quantity lifetime.  The zero-byte cross-jump
fence remains at the duplicated return tail.  Neither is a post-compile rewrite.

Result: PASS 61/61, with exact branch distances.

## Audit movement

- declaration-clean functions: 726 -> 728;
- unexplained extra source locals: 1656 -> 1648;
- restored inline-local mappings: 12 -> 15;
- explicit source-only codegen carriers: 106 -> 110;
- missing SYM names: 0;
- function/type/storage findings: 0.

## Proof

- `tools/verify_asm.py`: `Distance` PASS 37/37; `SubmitRequest` PASS 61/61.
- `tools/tugate.py recon/game/common/speech.cpp`: 102/102 PASS.
- `tools/brdist.py recon/game/common/speech.cpp`: 102 functions checked, 0
  branch-offset/count divergences.
- strict game/common audit: 1193/1193 functions mapped, 547/547 globals,
  115/115 vtables, 0 missing names.
- The separately linked `front.bin` invariant remains
  `[0x80010000, 0x80054548)`, size `0x44548`; frontend TU ownership is not
  attributed to the resident `bigbuf.obj` reservation merely by VA overlap.
