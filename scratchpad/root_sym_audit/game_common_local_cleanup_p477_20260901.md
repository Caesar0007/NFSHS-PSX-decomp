# P477: `CarBank::Check` / `Speaker::SetCar` inline-source closure

This round uses the retail SLD block nesting, per-variable registers, and raw
oracle instructions to restore the inline source operations hidden by the
flat decompilation.  Both reconstructed functions remain byte exact.

## `CarBank::Check`

- restored the SYM parameter spelling `name`;
- removed the spurious shadow `name` plus `bVar1`, `lVar2`, and `iVar3`;
- restored the three inlined `CarBankName` predicates (`Full`, `Make`, and
  `Model`).  Their `this`/`name` inline scopes explain the three nested SLD
  blocks and preserve retail's materialized boolean result;
- direct short-circuit expressions were rejected: they compile to 62 rather
  than 66 instructions and differ at 18 oracle rows;
- the inline-member form is PASS, 66/66, with only the SYM outer local
  `match`.

## `Speaker::SetCar`

- restored `carcolour` as the shift result and removed `uVar3`;
- restored the inlined virtual `GetCarBank` operation and named `CarBank`
  fields, removing `piVar1`;
- restored the named virtual `KnownPerp` operation, removing `dispatchThis`
  and `iVar2`;
- restored `ClearCar()` for the zero-bank inline `this` scope;
- restored `SetColour(int Colour)` for the SLD inline `this`/`Colour` scope;
  the audit receipt binds the caller's retail `Colour` record to that actual
  helper parameter rather than retaining a fake caller local;
- result is PASS, 72/72, with only the SYM outer local `carcolour`.

The inline helper spellings are source-shape inferences: SYM proves their
receivers, arguments, scopes, and generated instructions, but—as expected for
fully inlined members—does not retain separate linkage names.  The selected
names follow the recovered field and method vocabulary and are recorded here
so the remaining lexical uncertainty is explicit.

## Proof

- `tugate.py recon/game/common/speech.cpp`: PASS, 102/102.
- strict game/common audit: 1193/1193 functions mapped, 0 missing names,
  547/547 globals mapped, 115/115 vtables mapped.
- declaration-clean functions: 719 -> 721.
- unexplained extra source locals: 1694 -> 1686.
- restored inline-local mappings: 6 -> 7 (`Colour` from `SetColour`).
- relink `recon`: GREEN, 757 objects, 0 real duplicates/unresolved.
- relink `src`: GREEN, 706 objects, 0 real duplicates/unresolved.
- data-only payload audit: PASS, 11/11 byte exact.
- `git diff --check`: no errors; line-ending notices only.
