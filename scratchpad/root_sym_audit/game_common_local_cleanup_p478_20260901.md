# P478: `speech.cpp` location-bank source closure

This round restores three adjacent location-bank routines to their exact SYM
locals and named class operations while preserving their byte-exact oracles.

## Restored functions

- `Speech::CheckCarBank`: replaced four pointer/result artifacts with the SYM
  `match` and `i` indexed loop.  GCC strength-reduces the ordinary array access
  to retail's two stride-12 pointer walks.  PASS 45/45.
- `Speech::CheckLocationBank`: restored `d`, `i`, and the nested inlined
  `LocationBank::Set` operation.  The helper's `bankid` and `name` parameters
  are bound to the two inner SLD records; argument evaluation naturally emits
  retail's three batched loads before the four stores.  PASS 65/65.
- `Speech::FindClosestLocationTo`: replaced five decompiler artifacts with the
  exact SYM locals `closestbank`, `closestdistance`, `i`, `locationbank`, and
  `distance`.  PASS 54/54.

## Measured source-shape evidence

- `LocationBank::Set` must accept its two slice values as `int`.  A `short`
  signature grows the function from 65 to 69 instructions and differs at
  eight rows because GCC inserts unsigned halfword loads plus explicit sign
  extension.  The `int` form emits retail's direct `lh` pair.
- `FindClosestLocationTo` retains an explicit top-tested `while` with a break.
  The equivalent `for` remains count-exact at 54 instructions but changes 24
  oracle rows by converting the known-nonempty path to a different loop test
  and allocation order.

As with the other fully inlined members, SYM proves the `Set` parameter names,
scope, types used after promotion, and emitted instruction shape but does not
retain a separate linkage symbol.  The helper spelling is therefore recorded
as an explicit source-shape inference.

## Proof

- `tugate.py recon/game/common/speech.cpp`: PASS, 102/102.
- strict game/common audit: 1193/1193 functions mapped, 0 missing names,
  547/547 globals mapped, 115/115 vtables mapped.
- declaration-clean functions: 721 -> 724.
- unexplained extra source locals: 1686 -> 1667.
- restored inline-local mappings: 7 -> 9 (`bankid`/`name` from `Set`).
- relink `recon`: GREEN, 757 objects, 0 real duplicates/unresolved.
- relink `src`: GREEN, 706 objects, 0 real duplicates/unresolved.
- data-only payload audit: PASS, 11/11 byte exact.
- `git diff --check`: no errors; line-ending notices only.
