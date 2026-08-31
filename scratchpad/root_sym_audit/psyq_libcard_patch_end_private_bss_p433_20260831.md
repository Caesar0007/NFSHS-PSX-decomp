# Canonical PsyQ LIBCARD `PATCH.obj` / `END.obj` private BSS restoration

Date: 2026-08-31

## Canonical member evidence

The PsyQ 4.3 archive members at
`C:\Temp\nfs4-clean\psyq43\extracted\LIBCARD\obj` prove the complete section
extent and linkage:

- `PATCH.obj`: `.text` 464 bytes, `.bss` 16 bytes; XDEFs are only
  `_patch_card`, `_patch_card2`, and `_copy_memcard_patch`;
- `END.obj`: `.text` 128 bytes, `.bss` 16 bytes; the only XDEF is
  `_ExitCard`;
- neither member retains a BSS local name;
- all PATCH/END text references to scratch storage relocate directly against
  the member's BSS section base.

This disproves the earlier reconstruction comment that each owner contained a
four-byte word followed by an unattributed 12-byte gap. Each complete 16-byte
interval is one private member section. The `D_80148AC4` and `D_80148AD4`
spellings are retail-address oracle labels, not recovered original source
names, and are now local rather than exported.

## Exact reconstructed layout

The current objects reproduce the canonical section sizes and local scope:

- `PATCH.c.o(.bss)`: `0x10` bytes at retail `0x80148AC4..0x80148AD4`;
- `END.c.o(.bss)`: `0x10` bytes at retail `0x80148AD4..0x80148AE4`.

The standing implied-base link probe places both sections at those exact
addresses. The distinct interval `0x80148AE4..0x80148B04` remains outside the
canonical END member evidence and is deliberately not claimed.

## Regression proof

Detailed instruction gates remain PASS:

- `func_8010CA40`: 9 instructions;
- `_patch_card`: 37 instructions;
- `_patch_card2`: 28 instructions;
- `_copy_memcard_patch`: 13 instructions;
- `_ExitCard`: 28 instructions.

Both relocatable-link lanes remain GREEN with zero real duplicates, hidden
phantoms, or relocation-referenced unresolved symbols. Durable receipts are
`psyq_libcard_patch_end_relink_p433_20260831.json` and
`psyq_libcard_patch_end_probe_p433_20260831.json`.
