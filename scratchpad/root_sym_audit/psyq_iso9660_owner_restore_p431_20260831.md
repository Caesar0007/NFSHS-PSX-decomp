# Canonical PsyQ `ISO9660.obj` owner restoration

Date: 2026-08-31

## Authorities joined

- canonical PsyQ 4.3 member:
  `C:\Temp\nfs4-clean\psyq43\extracted\LIBCD\obj\ISO9660.obj`;
- matched PsyQ 4.0 source:
  `C:\Temp\ps1-decomp-refs\psyz\decomp\src\libcd\iso9660.c`;
- independent SotN PsyQ copy and symbol configurations under
  `C:\Temp\ps1-decomp-refs\sotn-decomp`;
- NFS4 retail assembly, raw image, generated linker map, and detailed
  `tools\verify_asm.py` gates.

## Canonical member proof

The archive member has exactly one XDEF, `CdSearchFile`. Its sections are:

- `.text`: 2,416 bytes, comprising 601 function instructions plus 12 bytes of
  archive-member tail padding;
- `.rdata`: 496 bytes;
- `.data`: 16 bytes;
- `.bss`: 9,216 bytes.

After masking relocation fields, the member's 601 function instructions are
identical to the six contiguous NFS4 retail functions: `CdSearchFile`, `_cmp`,
`CD_newmedia`, `CD_searchdir`, `CD_cachefile`, and `cd_read`. There is zero
non-relocation drift; the remaining three words are zero alignment padding
after `cd_read`, not function code. The old `_cd_cmp_name` and `_cd_find_path`
spellings are retained only as local zero-code oracle aliases.

The sole-XDEF evidence proves that all five helpers and all five storage objects
are file-local. The source now expresses that scope directly. Its object symbol
table has one global text definition (`CdSearchFile`); the helpers, `file`,
`dire`, `load_buf`, `cached_dir_num_`, and `cached_nopen_` are local.

## Restored private data and types

The initialized words are restored to their matched-source declarations:

```c
static int cached_dir_num_ = 0;
static int cached_nopen_ = -1;
```

The compiler emits those words at offsets 0 and 4. The source-level alignment
marker reproduces the canonical archive member's 16-byte `.data` size and
alignment, yielding the exact bytes `00000000 ffffffff 00000000 00000000`.
The reconstruction linker places this owner at retail
`0x80136C68..0x80136C78`; the source lane retains the identical sliced blob
window. The following residual begins unchanged at `D_80136C78`.

The 9,216-byte private BSS is restored as the contiguous local run:

- `file[64]` at BSS offset `0x0000`, type `CdlFILE`;
- `dire[128]` at offset `0x0600`, type `CdlDIR`;
- `load_buf[0x800]` at offset `0x1C00`, type `unsigned char`.

All three are now ordinary `static` C arrays; the old synthetic file-scope BSS
assembly is gone. The compiler emits the exact 9,216-byte section and offsets.

`CdlDIR` now uses the canonical fields `num`, `parentNum`, `lba`, and `name`.
The exact local labels `file` and `load_buf` are independently preserved by
SotN symbol configurations; `dire` is supported by the matched source family
and the canonical member layout.

## Matching and regression proof

All six functions are detailed PASS:

- `CdSearchFile`: 182 instructions;
- `_cmp` / oracle alias `_cd_cmp_name`: 8;
- `CD_newmedia`: 177;
- `CD_searchdir` / oracle alias `_cd_find_path`: 41;
- `CD_cachefile`: 167;
- `cd_read`: 26 normalized instructions.

Repository gates after the owner carve:

- full reconstruction build compiles and links;
- both relink lanes GREEN with zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- recon/source call audits scan 15,781/15,779 call relocations with zero calls
  to undefined symbols;
- 521 objects have zero TU-order inversions;
- 466 units have zero proven wrong call targets;
- vtable indexing passes all 1,017 scanned files;
- source-only policy passes with no post-compiler text moves or branch
  retargets;
- exhaustive ownership audit compiles 518/518 TUs and exactly owns all 3,491
  oracle names, with zero hidden phantoms or ownership gaps.

Durable machine-readable evidence:
`iso9660_owner_relink_p431_20260831.json`,
`iso9660_owner_undef_recon_p431_20260831.json`,
`iso9660_owner_undef_src_p431_20260831.json`, and
`iso9660_owner_link_probe_p431_20260831.json`.
