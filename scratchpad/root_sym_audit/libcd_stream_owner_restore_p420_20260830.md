# Canonical `libcd` streaming owner restoration

Date: 2026-08-30

Pre-change source/tool backup: Git commit `3346a726`.

## Authoritative organization evidence

Canonical PsyQ 4.3 `C:\Temp\nfs4-clean\psyq43\extracted\INDEX.tsv`
identifies the old reconstructed `stream.c` and `streamhelp.c` contents as
nine independent archive members:

- `C_002.obj`: `StClearRing`;
- `C_003.obj`: `StUnSetRing` and its two private initialized CD-register
  pointers;
- `C_004.obj`: `data_ready_callback` and the private words at retail
  `0x801489D0`/`0x801489D4`;
- `C_005.obj`: `StSetStream`, `StFunc1`, and `StFunc2`;
- `C_007.obj`: `StFreeRing`;
- `C_008.obj`: `init_ring_status`;
- `C_009.obj`: `StGetNext`;
- `C_010.obj`: `StSetMask`;
- `CDROM.obj`: `StSetRing` and the main streaming-state BSS run.

The isolated `StMode` word belongs to `BIOS.obj`, so its retail-addressed BSS
definition now lives in `drv.c`.  The callback word at `0x801489E4` belongs to
`libds/DSCB.obj`; the false `_ds_ready_cb` duplicate formerly carried by the
synthetic helper TU was removed.  Reconstruction files, oracle stubs,
`objdiff.json`, compiler-lane metadata, linker-generator documentation, and the
SYM type-board owner logic all use the canonical member names now.

## Matching proof

All nine moved functions pass detailed `verify_asm.py` in both normal and
explicit `NFS4_SOURCE_ONLY=1` modes:

- `StClearRing`: PASS, 24 instructions;
- `StUnSetRing`: PASS, 32 instructions;
- `data_ready_callback`: PASS, 35 instructions;
- `StSetStream`: PASS, 33 instructions;
- `StFreeRing`: PASS, 43 instructions;
- `init_ring_status`: PASS, 13 instructions;
- `StGetNext`: PASS, 46 instructions;
- `StSetMask`: PASS, 7 instructions;
- `StSetRing`: PASS, 11 instructions.

The strict objdiff branch-destination audit found and repaired one old hidden
semantic mismatch in `StGetNext`: the non-wrap path had reused the status load
from before the wrap test and branched past retail's second `lhu`.  A
zero-instruction DMA memory barrier now expresses the asynchronous producer
boundary.  `StGetNext` is 100% under objdiff as well as both verify lanes.
Seven other new units are exact 100% objdiff rows; `C_003` and `C_004` differ
only in relocation symbol spelling (`D_80136C48/D_80136C54` versus private
source names, and `D_801489D0/D_801489D4` versus `_ds_word0/_ds_word1`).
Detailed instruction streams are exact.

## SYM and repository integrity

- Full p420 type board: 464 TUs, 151 retained-type `OK`, 311
  `SYM_UNTYPED`, two pre-existing `OWNER_MAP`; zero `SOURCE_MERGE`,
  `SOURCE_SPLIT`, `DIFF`, or `COMPILE_FAIL`.
- Focused syslib board: 161 TUs, 160 `SYM_UNTYPED`, one pre-existing
  `OWNER_MAP`; the two libcd source-merge findings are gone.
- Recon/source relink gate: green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols.
- Undefined-call audit: zero across 15,782 call relocations.
- Focused libcd call-target audit: zero proven wrong-target sites.
- TU-order audit: 519 objects, zero inversions.
- Phantom audit: 519/519 TUs compile, 3,484/3,484 exact oracle names, zero
  hidden phantoms and zero ownership gaps.
- Phantom census: zero `__Fe` bases.
- Fresh link/data probe: text 963,433/987,556 bytes identical (97.56%);
  data 148,529/151,331 bytes identical (98.15%), 212/248 exact placed data
  sections.  Its three relocation-range warnings are the known synthetic
  probe-link limitation, not unresolved-symbol or ownership failures.

Durable boards and probe receipt:

- `sym_type_graph_board_p420_20260830.tsv`;
- `syslib_type_graph_libcd_split_p420_20260830.tsv`;
- `libcd_split_link_probe_p420_20260830.json`.
