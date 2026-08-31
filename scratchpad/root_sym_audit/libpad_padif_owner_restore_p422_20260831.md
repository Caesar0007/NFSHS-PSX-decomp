# Canonical `libpad/PADIF.obj` owner and data restoration

Date: 2026-08-31

## Authoritative organization evidence

Retail SYM names `..\syslib\psx\lib\libpad.lib(PADIF.obj)` twice and has no
`MCXMAIN.obj` FILE record. Canonical PsyQ 4.3 independently supplies the
decisive shape:

- `LIBPAD/PADIF.obj` contains five private code entries;
- the reference decomp records them at object offsets `0`, `0x48`, `0x120`,
  `0x1CC`, and `0x290`;
- retail NFS4's five reconstructed state functions start with the identical
  first three boundaries `0`, `0x48`, and `0x120` and occupy the same state
  sequence;
- PsyQ 4.3 `INDEX.tsv` assigns public data symbol `padIntFunc` to `PADIF.obj`.

The synthetic `MCXMAIN.c` TU is therefore restored as `PADIF.c`. Its three
private PAD state words and `padIntFunc` now form one `.data` block in the true
owner. The path-specific gcc 2.7.2 lane and the two existing per-function
2.8.0 `-mno-split-addresses` splices were renamed, not altered; the focused
pre-edit wiring receipt is `padif_build_path_backup_p421_20260831.md`.

## Code and data proof

All five functions remain detailed byte-exact:

- `_padIntInit`: PASS, 18 instructions;
- `_padIntQuery`: PASS, 54 instructions;
- `_padIntRecvId`: PASS, 48 instructions;
- `_padIntRecvHdr`: PASS, 35 instructions;
- `_padIntRecvData`: PASS, 223 instructions.

The emitted `PADIF.c.o(.data)` is exactly 32 bytes and the probe linker places
it at retail `0x8013C308`. Direct comparison with `rom/nfs4-f.exe` is 32/32
bytes exact: three private words (`0`, `0x1F801040`, `0`) followed by the five
retail function pointers through `0x8010C314`.

## Project-wide integrity

- Full p422 type/owner board: 464 TUs, 151 typed `OK`, 313 `SYM_UNTYPED`, and
  zero `OWNER_MAP`, `SOURCE_MERGE`, `SOURCE_SPLIT`, `DIFF`, or `COMPILE_FAIL`.
- Recon/source relink gate: GREEN; zero real duplicates and zero hidden
  phantoms.
- Fresh link probe: text 957,948/979,772 bytes identical (97.77%); data
  148,560/151,363 bytes identical (98.15%), 213/249 byte-compared sections
  exact. The standard three relocation-range warnings remain probe-only.

Durable evidence: `libpad_padif_owner_p421_20260831.tsv`,
`sym_type_graph_board_p422_20260831.tsv`,
`padif_owner_relink_p422_20260831.json`, and
`padif_owner_link_probe_p422_20260831.json`.
