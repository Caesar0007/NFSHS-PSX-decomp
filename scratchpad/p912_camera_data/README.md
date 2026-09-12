# P912 Camera data source proposal

Private proposal; not yet applied to production or placed in the normal link.

`Camera_gFlags[19]` had malformed flat initializers: the packed flags were
repeated into coordinates and one-bit members. Native SYM1e05ee..1e06b0 defines
`coorddef arm` plus six INT one-bit fields at bits 96..101. The braced proposal
recovers all 19 coordinate/flag records from raw ROM, independently equal to CPE.
This corrects 102 initializer bytes without changing a code word.

`Camera_gInfo[2]` was declared first but deferred by the compiler after the
initialized tables. Explicit aggregate zero initialization makes its existing
544-byte source storage lead the native run. The complete 1,404-byte .data then
matches ROM and full CPE coverage, with all ten SYM names/types/bindings/extents
at their native offsets. Existing source names and types are not replaced.
Original literal/macro/initializer spelling is not uniquely recoverable from
these binary records and is explicitly not claimed.

Both stages preserve **38 PASS functions and 382 branches**, all 38 local,
lexical and SLD instruction graphs, other section payloads and ordered relocation
contracts. Reordering changes only seven existing HI/LO relocation words. Every
one of 204 .data references retains its exact native cell and interior addend.
The private baseline equals the actual saved normal object except its precisely
checked FILE path. There are no asm, volatile, pins, helper names, invented
padding or postcompile/debug rewrites.

The copied clock-module header and mistaken BSS comments are corrected in the
candidate. Source code bodies and headers are unchanged. Native placement and
full link/public/local/overlap preservation remain required before landing.
The exact r06 raw donor remains untouched and must stay available to the oracle.

Receipts: `native_flags.json`, `flags_only_verification.json`,
`candidate_verification.json`, per-stage gate/debug records and `backups/`.
