# Canonical `textset.obj` owner restoration

Date: 2026-08-31

## Authoritative organization evidence

Retail SYM contains two independent FILE records for
`..\eaclib\psx\eacpsxz.lib(textset.obj)` and no `setfont.obj` owner. The
reconstructed `setfont` function at `0x800F2E94` was therefore stored under a
synthetic filename. NFS2 PC beta independently places `_setfont` in
`textset.obj`, confirming that `textset` is the original EA translation-unit
name rather than a stem guess.

`recon/eaclib/psx/eacpsxz/setfont.c` and its oracle stub are now named
`textset.c`; objdiff and both linker paths use the same canonical owner.

## Matching and audit proof

- `setfont`: PASS, 100 instructions before and after the rename.
- Focused eacpsxz board: 68/68 owners resolve to their retained SYM FILE
  records; `textset.c` resolves to `eacpsxz.lib(textset.obj)`.
- Full p421 board: 464 TUs, 151 typed `OK`, 312 `SYM_UNTYPED`, and only the
  then-unresolved `MCXMAIN.c` owner-map row; zero source merges/splits, type
  diffs, or compile failures.

Durable boards: `eacpsxz_textset_owner_p421_20260831.tsv` and
`sym_type_graph_board_p421_20260831.tsv`.
