# P903 upstream EACPSXZ final repaired-state verification

Independent final-stage rebuild of all74 actual C TUs after root repaired
the incoming source/header changes. Before/after inventories and failed
comparison remain frozen; final output uses its own namespace.

- **74/74 TUs compile.**
- **248/248 native functions PASS**, including the three fxform routines and
  stream's address-disambiguated file-static `locaterequest`.
- **1,139 branches**, no changed count/offset.
- **73 entire ELF objects literally identical** to the pre-integration objects.
- **74/74 complete object semantics identical.** The only permitted nonliteral
  case is callback.c's exact symbol-table permutation. Every duplicate symbol
  record is preserved; ordered semantic relocation records are identical.
- callback's128-byte NOBITS BSS is again aligned to4. No data, code, symbol
  binding, storage size or relocation destination differs from the old object.
- primate's entire object is literally restored, including all22 GP-relative
  addends affected by the initial header-order regression.
- vars/ticks/libticks and the timer consumers remain literal-object exact.
- Six data-only owners remain classified as storage checks, not function PASSes.

Root performed the production repairs. This reviewer changed only diagnostic
scripts/receipts, never production or normal build outputs. The restored
pre-integration semantics do not claim the whole project's unfinished native
link/data-layout backlog is solved.

## Exact handoff manifest

`final_source_include_hashes.json` records **152 actual source/include files**.
All hashes were rechecked after the complete final run; root can use them to
ensure the normal compilation/relink consumes exactly the tested state.
No outside-cluster quote/angle include consumer was found under the actual
`-Iinclude`, `-Irecon` and source-relative search paths.

`final_complete.json` records every final object, source/include/oracle hash,
whole function PASS set, complete symbols/relocations/section metadata and
branch result. `final_comparison.json` is the strict comparison against
`before_complete.json`; `compare_final.py` permits no nonliteral object other
than callback and asserts its128-byte/4-alignment contract explicitly.

```
python scratchpad/p903_upstream_eac/compare_final.py
```

No stage names or previous before/after artifacts were reused. No opcode,
object, linker output or compiler label was rewritten by the diagnostics.
