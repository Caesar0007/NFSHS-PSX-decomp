# PsyQ private libcd storage and `StCdInterrupt` restoration

Date: 2026-08-31

## Authorities joined

- Public SDK interface: all 46 headers under
  `C:\Temp\nfs4-clean\psyq43\PSX43\psx\include`, especially
  `libcd.h`. This is authoritative for public source names, typedefs, and
  prototypes, but it does not expose private file-scope identifiers.
- Canonical member/layout evidence:
  `C:\Temp\nfs4-clean\psyq43\extracted` and the retail CPE/SYM/raw image.
- Independent symbol-bearing PsyQ copies:
  `C:\Temp\ps1-decomp-refs\sotn-decomp\src\main\psxsdk\libcd\c_004.c`,
  `c_011.c`, and SotN's symbol configs.
- Independent library-info label/byte evidence:
  `C:\Temp\ps1-decomp-refs\mgs_reversing\asm\safechk.s`.
- Byte authority: detailed `tools\verify_asm.py`, plus the whole-tree link,
  ownership, call-target, and source-policy gates.

## Restored source facts

### `LIBCD/BIOS.obj` library-info record

`__ps_libinfo__` is now represented as the eight byte-sized metadata fields
actually emitted at the start of the object rather than as two reconstructed
`unsigned int` words:

`'P', 's', 0x04, 0x26, 0xf4, 0x2d, 0x43, 0x10`.

The exact label is independently retained by the MGS PsyQ object transcription,
which also emits the record byte by byte. NFS4's `.data` bytes and placement are
unchanged. All thirteen reconstructed `drv.c` functions remain detailed PASS.

### `LIBCD/C_004.obj` callback storage

The synthetic exported `_ds_word0`/`_ds_word1` pair is replaced with
object-local storage. SotN preserves the exact private identifier `fp_2`, its
type `static CdlLOC`, and its role as the copied sector location. SotN's symbol
configs independently retain `fp_2` as a real label. The adjacent second word
stores `StHEADER.frameCount` and is proven file-local `int`, but no consulted
source retains its original spelling; it therefore uses explicit address
placeholder `D_801489D4` rather than an invented semantic name.

`data_ready_callback` remains PASS at 35 instructions, and the object symbol
table now marks both words local.

### `LIBCD/C_011.obj` cached stream slot

SotN's independent copy proves that C_011's cached ring slot has source category
`static volatile u16 *`. NFS4 now emits `_st_slot` as object-local BSS and uses
the proven pointer-to-volatile-halfword type. The spelling `_st_slot` remains a
reconstruction placeholder: neither the public PsyQ header nor an independent
symbol table preserves Sony's original private identifier.

Restoring the type moved `StCdInterrupt` from its measured 27-diff basin to 8
diffs. Two natural source refinements then closed it:

- the first slot-ID comparison uses a single ordinary halfword view, avoiding
  old cc1's redundant second zero-extension;
- `Stframe_no = _st_slot[4]` lets the volatile-pointee load retain retail's one
  `andi 0xffff` naturally.

The former empty-template asm allocation fence and explicit mask are removed.
`StCdInterrupt` is now PASS at 583/583 instructions; `_st_copy_words` remains
PASS at 11. The user-parked `_st_dma` body was not edited and remains at its
pre-existing one-instruction residual (107 ours / 106 oracle).

## Regression proof

- full reconstruction build compiles and links;
- both relink lanes are GREEN with zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- 15,781 call relocations contain zero undefined calls;
- 521 objects have zero translation-unit order inversions;
- 466 units contain zero proven wrong call targets;
- vtable indexing passes all 1,017 scanned files;
- source-only policy passes with no post-compiler text moves or branch
  retargets;
- exhaustive phantom audit compiles 518/518 TUs and exactly owns all 3,491
  oracle names, with zero hidden phantoms or ownership gaps.

Durable machine-readable link evidence:
`psyq_private_storage_relink_p430_20260831.json` and
`psyq_private_storage_undef_p430_20260831.json`.

## Explicit remaining provenance gaps

- original private spelling of C_004's frame-count word at `0x801489D4`;
- original private spelling of C_011's cached slot pointer at `0x80144864`;
- whether Sony wrote the library-info bytes as a source declaration or injected
  them through library tooling. The exact label, byte representation, ownership,
  and layout are proven; the emission mechanism is not.

These are underdetermined source-provenance items, not matching or linkage
failures, and they must not be closed through speculative renaming.
