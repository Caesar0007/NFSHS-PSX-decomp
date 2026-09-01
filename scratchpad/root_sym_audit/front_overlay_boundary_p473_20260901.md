# P473: `front.bin` overlay-boundary closure

The five SYM opcode-1 linker records describe one separately compiled and
linked frontend overlay, not five ordinary data objects:

- `00010b`: `_front_obj = 0x80010000`
- `00011b`: `_front_objend = 0x80054548`
- `00012e`: `_front_org = 0x80010000`
- `00013e`: `_front_orgend = 0x80054548`
- `000151`: `_front_size = 0x00044548`
- load interval: `[0x80010000, 0x80054548)`

`bigbuf.obj` reserves this exact resident load window and exports the unsized
`bigBuf` load-base alias.  It does not own the initialized frontend bytes at
that address.  The frontend translation units are compiled and linked into
`front.bin` separately and retain their individual object ownership.

`address.obj` owns the two four-byte words outside the overlay:

- `FrontStartAddress @ 0x80054D90 = 0x80010000`
- `FrontEndAddress @ 0x80054D94 = 0x80054548`

## Function/object attribution rule

Functions and initialized data assigned by SYM to frontend translation units
are members of the separately built `front.bin` image.  Their runtime VAs fall
inside the reserved interval, but that overlap does **not** make them members
of `bigbuf.obj`: `bigbuf.obj` is only the resident reservation for the load
window.  Original SYM module ownership remains authoritative for each frontend
function and data definition.  Conversely, `recon/frontend/psx` is resident
support code and is not classified as part of the `frontend/common` overlay
merely because it serves the frontend.

The reconstruction now carries all five linker aliases explicitly in
`configs/symbol_addrs.txt`.  `FrontEndAddress` is expressed through
`_front_objend`, pairing it with the existing `_front_obj` relocation used by
`FrontStartAddress`; the prior coincident `_front_dtors_orgend` spelling had
the same value but obscured the overlay-boundary ownership.

## Proof

- Raw `rom/nfs4-f.exe` words at `0x80054D90..0x80054D98` are exactly
  `0x80010000, 0x80054548`.
- `NFS4.MAP` independently carries all five values above.
- `tools/relink.py --lane recon -v`: GREEN, 757 objects, 0 real duplicates,
  0 hidden phantoms, 0 unresolved relocations.
- `tools/relink.py --lane src -v`: GREEN, 706 objects, 0 real duplicates,
  0 hidden phantoms, 0 unresolved relocations.
- `audit_data_only_payloads.py`: PASS, 11/11 data-only members byte exact,
  including `vars.obj`.
- `audit_sym_object_members.py`: 519/519 completed object-member pairs,
  0 malformed/unpaired; `bigbuf.obj` remains the opaque reservation member and
  `address.obj` remains the SLD assembly/data member.
- `git diff --check`: no errors (only the repository's line-ending warnings).

No function body, frontend object assignment, overlay byte, address, or PASS
status changed in this closure.
