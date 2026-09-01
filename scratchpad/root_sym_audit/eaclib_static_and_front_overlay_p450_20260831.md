# P450: front overlay boundary and EACLIB compact-static closure

## `front.bin` overlay boundary

The SYM opcode-1 linker records `00010b` through `000151` and `NFS4.MAP`
agree on the complete separately linked frontend overlay:

- `_front_obj = _front_org = 0x80010000`.
- `_front_objend = _front_orgend = 0x80054548`.
- `_front_size = 0x44548`.
- Therefore the load interval is `[0x80010000, 0x80054548)`.

`bigbuf.obj` reserves that interval and exports `bigBuf` at its load base.  It
does not own the frontend payload bytes.  The functions and data inside the
interval remain owned by their separately compiled frontend `.obj` members.

`address.obj` is outside the overlay and owns two four-byte words:

- `FrontStartAddress @ 0x80054D90` contains `0x80010000`.
- `FrontEndAddress @ 0x80054D94` contains `0x80054548`.

The corresponding assembly comments and the object-closure report now record
the exclusive end and the exact SYM record family.

## Compact public/static address records

The strict source audit previously admitted only compact opcode-2 public
symbols.  Opcode 6 is the equivalent name+VA record for file-static symbols.
The audit now admits both, still requiring a unique source definition carrying
an exact `@0xVA` receipt.  Repeated static names are therefore disambiguated by
address rather than guessed by spelling.

Twenty opcode-2 EACLIB definitions were receipted in their owning TUs.  All
five affected TUs remain exact:

- `fileroot.c`: 9/9 PASS.
- `inittmr.c`: 4/4 PASS.
- `joystkn.c`: 1/1 PASS.
- `primate.c`: 3/3 PASS.
- `threads.c`: 2/2 PASS.

Six opcode-6 definitions were then closed:

- `unbtree.c`: `SQVclue`, `SQVd`, `SQVleft`, `SQVright`, `SQVs`; 1/1 PASS.
- `stream.c`: its distinct `requestidcounter`; 32/32 PASS.

## `nasync.obj` source restoration

Retail SYM records two 8-byte statics, `freequeue @ 0x8013DEA0` and
`callqueue @ 0x8013DEA8`.  The previous reconstruction used four invented
pointer globals (`freequeuehead`, `freequeuetail`, `callqueuehead`,
`callqueuetail`) to compensate for a `-G4` small-data threshold.

The natural source was restored to two `AsyncQueue` objects and direct
`&freequeue` / `&callqueue` calls.  Whole-TU compiler-input probes on that
source gave:

- baseline `-G4`: 18/23 PASS, 50 diffs;
- `-G8`: 23/23 PASS, 0 diffs;
- `-G0`: 10/23 PASS, 193 diffs;
- no-split-addresses: 15/23 PASS, 46 diffs;
- `-G8` plus no-split-addresses: 15/23 PASS, 34 diffs.

Accordingly `nasync.c` now has a documented whole-TU `g_value=8` compiler
identity.  It re-gated 23/23 PASS twice after the shared-header rebuild.  All
nine compact opcode-6 statics from `readblocksize @ 0x8013DE90` through
`mutex @ 0x8013DEBC` now map by exact retail name and VA.

## Audit and regression result

- Exact compact-address definitions: 67 before this round, 82 after it.
- Unresolved EACLIB source definitions: 65 before the opcode-2 closure, then
  45, then 34 after `nasync`, and 28 after `unbtree`/`stream`.
- Relink: GREEN in both lanes; real duplicates 0, hidden phantoms 0,
  unresolved relocations 0.
- Undefined call audit: recon 15,781 calls / 0 undefined; src 15,779 / 0.
- `git diff --check`: no errors (line-ending warnings only).

The 28 remaining definitions are still a review queue.  In particular,
`unref.obj`'s four same-named tentative common definitions are intentionally
shared with `unbtree.obj` and must be classified with common-symbol/linker
evidence rather than deleted as apparent duplicates.
